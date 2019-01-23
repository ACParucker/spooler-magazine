DECLARE SUB Disco (drive$, livre&, total&, erro%)
DECLARE FUNCTION Trunca% (nome$, tamanho&)
DECLARE SUB ProxFich (nomefich$, erro%)
DECLARE SUB PrimFich (dirlist$, nomefich$, erro%)


TYPE regtype
        AX AS INTEGER
        BX AS INTEGER
        CX AS INTEGER
        DX AS INTEGER
        BP AS INTEGER
        SI AS INTEGER
        DI AS INTEGER
        FLAGS AS INTEGER
END TYPE



TYPE regtypex
        AX AS INTEGER
        BX AS INTEGER
        CX AS INTEGER
        DX AS INTEGER
        BP AS INTEGER
        SI AS INTEGER
        DI AS INTEGER
        FLAGS AS INTEGER
        DS AS INTEGER
        ES AS INTEGER
END TYPE

DIM SHARED regs AS regtype
DIM SHARED regx AS regtypex
DIM SHARED dirstr AS STRING
DIM SHARED vecseg AS INTEGER
DIM SHARED vecofs AS INTEGER

SUB Disco (drive$, livre&, total&, erro%)
'Permite saber o espa‡o livre e total em disco/disquete
'drive$=nome da drive (a:, b:, c:, ...)
'devolve os seguintes parƒmetros:
'livre&=n£mero de bytes livres
'total&=capacidade total do disco
'erro%=se houver erro, esta vari vel devolve o valor 1, e 0 em caso contr rio.

    erro% = 0
    regs.AX = &H3600                'fun‡„o 36h
    a$ = UCASE$(LEFT$(drive$, 1))   'lˆ letra da drive
    IF a$ = "" THEN regs.DX = 0     'se n„o existir, lˆ drive actual
    IF ASC(a$) >= 65 AND ASC(a$) <= 90 THEN regs.DX = ASC(a$) - 64
    CALL interrupt(&H21, regs, regs)
    
    IF regs.AX = &HFFFF THEN erro% = 1
    tmpax& = regs.AX
    tmpbx& = regs.BX
    tmpcx& = regs.CX
    tmpdx& = regs.DX
    IF erro% = 0 THEN
        livre& = tmpax& * tmpbx& * tmpcx&
        total& = tmpax& * tmpcx& * tmpdx&
    END IF

END SUB

SUB PrimFich (dirlist$, nomefich$, erro%)
'Procura o primeiro ficheiro especificado por dirlist$.
'nomefich$ ‚ uma vari vel de retorno que d  o nome do ficheiro encontrado
'Erro% indica se a opera‡„o foi bem sucedida (igual a 0) ou ent„o:
'2 - erro de sistema , 3 - direct¢rio n„o encontrado, 18 - n„o existem mais
'ficheiros com a especifica‡„o designada.


    erro% = 0
    dirstr = STRING$(45, 0)            'inicializa string

    regx.AX = &H2F00
    CALL interruptx(&H21, regx, regx)  'chama fun‡„o 2Fh, que d  o
    vecseg = regx.ES                   'segmento e
    vecofs = regx.BX                   'offset do DTA

    regx.AX = &H1A00                   'novo valor do DTA
    regx.DS = VARSEG(dirstr)           'usando uma vari vel do Basic
    regx.DX = SADD(dirstr)
    CALL interruptx(&H21, regx, regx)

    especif$ = dirlist$ + CHR$(0)      'vari vel contendo a especifica‡„o
    regx.AX = &H4E00                   'dos ficheiros a procurar
    regx.CX = 0                        'attrib=0 - s¢ procura ficheiros
    regx.DS = VARSEG(especif$)         'segmento da vari vel
    regx.DX = SADD(especif$)           'offset da vari vel
    CALL interruptx(&H21, regx, regx)

    IF regx.FLAGS AND 1 THEN erro% = regx.AX   'se CF=1, ent„o h  erro
                                               'o c¢digo de erro est  em AX

    regx.AX = &H1A00
    regx.DS = vecseg
    regx.DX = vecofs
    CALL interruptx(&H21, regx, regx)  'rep”e endere‡o do DTA

    lim% = INSTR(32, dirstr, CHR$(0)) - 31  'localiza primeiro caracter
                                            'de c¢digo 0, depois do nome
    nomefich$ = MID$(dirstr, 31, lim%)      'escreve o nome do ficheiro at‚
                                            'ao caracter chr$(0)



END SUB

SUB ProxFich (nomefich$, erro%)
'procura o pr¢ximo ficheiro (depois de ter sido usado a rotina PrimFich).
'nomefich$ devolve o nome do ficheiro encontrado.
'Quando n„o houver mais ficheiros que satisfa‡am a especifica‡„o dada,
'o parƒmetro erro% devolve 1.
'Portanto, esta rotina pode ser executada v rias vezes para procurar todos
'os ficheiros com determinada especifica‡„o (dada inicialmente … rotina
'primfich). Podem ser utilizados wildcards ou caracteres globais (* e ?).


    erro% = 0
    regx.AX = &H2F00
    CALL interruptx(&H21, regx, regx)  'guarda o ender‡o actual do DTA
    vecseg = regx.ES
    vecofs = regx.BX

    regx.AX = &H1A00
    regx.DS = VARSEG(dirstr)           'Usa uma vari vel do Basic
    regx.DX = SADD(dirstr)             ' como novo DTA
    CALL interruptx(&H21, regx, regx)

    regx.AX = &H4F00
    CALL interruptx(&H21, regx, regx)  'procura pr¢ximo ficheiro

    IF regx.FLAGS AND 1 THEN erro% = 1



    regx.AX = &H1A00
    regx.DS = vecseg
    regx.DX = vecofs
    CALL interruptx(&H21, regx, regx)   'restaura o endere‡o do DTA

    lim% = INSTR(32, dirstr, CHR$(0)) - 31   'Localiza o primeiro caracter 0
                                             'depois do nome do ficheiro
    nomefich$ = MID$(dirstr, 31, lim%)       'Devolve o nome do ficheiro


END SUB

FUNCTION Trunca% (nome$, tamanho&)
'Trunca um ficheiro no s¡tio determinado por tamanho&
'nome$=nome do ficheiro
'tamanho%=quantidade de bytes a guardarno ficheiro
'A fun‡„o devolve um valor inteiro, que ‚ um c¢digo de erro:
'0 = N„o houve qualquer erro
'1 = O ficheiro n„o foi encontrado
'2 = Erro de sistema (provavelmente n„o foi concedido acesso ao ficheiro)
'3 = N£mero inv lido de bytes passados … fun‡„o

  erro% = 0
  nome$ = nome$ + CHR$(0)  'terminador de string
  regx.AX = &H3D82         'fun‡„o 32h, c¢digo de acesso 82h
  regx.DS = VARSEG(nome$)  'segmento da vari vel
  regx.DX = SADD(nome$)    'offset da vari vel
  CALL interrupt(&H21, regx, regx)   'abre ficheiro
  handle = reg.ax                    'handle do ficheiro
  IF (regx.FLAGS AND 1) = 1 THEN     'verifica c¢digo de erro
    IF regx.AX = 2 OR regx.AX = 3 THEN
      erro% = 1
     ELSE erro% = 2
    END IF
  END IF
 

  IF erro% = 0 THEN

    regs.AX = &H4200
    regs.BX = handle
    regs.CX = tamanho& \ &H10000   '16 bits mais significativos
    regs.DX = tamanho& AND &HFFFF  '16 bits menos significativos
    CALL interrupt(&H21, regs, regs)  'desloca o ponteiro para o s¡tio a truncar

    regx.AX = &H4000
    regx.BX = handle
    regx.CX = 0
    regx.DX = 0
    regx.DS = 0
    CALL interruptx(&H21, regx, regx) 'trunca o ficheiro
    IF (regx.FLAGS AND 1) = 1 THEN erro% = 3  'verifica c¢digo de erro

    regs.AX = &H3E00
    regs.BX = handle
    CALL interrupt(&H21, regs, regs)  'fecha ficheiro

  END IF
  Trunca% = erro%

END FUNCTION

