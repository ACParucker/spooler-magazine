'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'³                     QUICK BASIC IV - FICHA TCNICA                        ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³ Software................: QUICK BASIC USER LIBRARY I                      ³
'³ M¢dulo,Execut vel.......: USERLIB.BAS, USERLIB.LIB, USERLIB.QLB           ³
'³ Vers„o (Idioma),rev.....: 2.0 (P), 01/06/94                               ³
'³ Cliente.................: -                                               ³
'³ Autor...................: N‚lio Abreu                                     ³
'³ Copyright...............: 1993                                            ³
'³ Data de cria‡„o.........: 18/09/93                                        ³
'³ Interface de v¡deo......: Todos                                           ³
'³ Ambiente................: DOS                                             ³
'³ Interface de sistema....: Monoposto                                       ³
'³ Sistema operativo.......: MS/PC/DR-DOS vers„o 2 ou superior               ³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'³                         FINALIDADE DO SOFTWARE                            ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³     Procedimentos, fun‡”es e blocos de programa a serem usados em todos os³
'³programas a serem criados pelo Quick BASIC. Inclui gest„o de ficheiros e de³
'³sistema.                                                                   ³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'³    Ideia levado a cabo por N‚lio Remigio Correia de Abreu, com o apoio das³
'³instru‡”es do Clipper. Todos os direitos reservados. Para ser usado em am- ³
'³biente DOS no Quick BASIC 4.5 (compilador).                                ³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³Como criar a biblioteca de sistema USERLIB.LIB e a de ambiente USERLIB.QLB³
'³                                                                          ³
'³     1§ - Inicializar o Quick Basic sob a forma de QB /L QB - Isto avisa- ³
'³          r  ao QB que pretende criar uma biblioteca e que ele dever  co- ³
'³          locar o c¢digo de controlo na biblioteca a ser criada. Isto evi-³
'³          tar  possiveis erros na gera‡„o da biblioteca. Poder  criar a   ³
'³          biblioteca sem usar a biblioteca QB mas n„o ha garƒntias de que ³
'³          a biblioteca criada esteja em prefeitas condi‡”es.              ³
'³                                                                          ³
'³     2§ - Logo que apare‡a o men£ do topo, escolha a op‡„o File, e dentro ³
'³          desta escolha Open. Carregue esta biblioteca como se fosse um   ³
'³          programa (caso tenha sido gravada com a extensao BAS (default)  ³
'³                                                                          ³
'³     3§ - Logo que o c¢digo fonte deste ficheiro apare‡a dentro da janela ³
'³          escolha a op‡„o Run, e dentro desta a op‡„o Make Library...     ³
'³                                                                          ³
'³     4§ - Confirme o nome que pretende dar … biblioteca e pressione ENTER ³
'³                                                                          ³
'³     5§ - Ao pressionar ENTER o QB ir  verificar o m¢dulo para ver se n„o ³
'³          existem erros. Caso existam o QB ir  parar no local exacto.     ³
'³                                                                          ³
'³     6§ - Caso n„o existam erros o QB ir  criar as duas bibliotecas: a LIB³
'³          e a QLB. Destas utilize a QLB dentro do QB carregando-a como    ³
'³          carregou a QB.QLB no inicio. A LIB ser  uusada pelo QB quando   ³
'³          for criado o EXEcut vel                                         ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³NOTA: Sempre que quiser utilizar esta biblioteca no seu EXEcut vel e caso ³
'³ÍÍÍÍÍ seja dentro do QB n„o esque‡a nunca de inicializar o QB sob a forma ³
'³      de QB /L nome_da_biblioteca_QLB. Fora do QB, crie e inclua um fich- ³
'³      eiro com as declara‡”es das bibliotecas. Este tamb‚m dever  de ser  ³
'³      incluido (sob a forma de '$INCLUDE: 'nome_do_ficheiro') no inicio   ³
'³      do programa. Este ficheiro dever  de ser idˆntico a este, n„o pos-  ³
'³      suindo o resto do c¢digo. Fora do QB, na cria‡„o do EXEcut vel de-  ³
'³      ver  de incluir a biblioteca LIB no LINK.                           ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
'ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
'³               \/ ZONA RESERVADA AS FUNCOES DA PROGRAMACAO \/             ³
'ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾

' Define o tipo necess rio para o INTERRUPT
TYPE RegType
     ax    AS INTEGER
     bx    AS INTEGER
     cx    AS INTEGER
     dx    AS INTEGER
     bp    AS INTEGER
     si    AS INTEGER
     di    AS INTEGER
     flags AS INTEGER
END TYPE
' Define o tipo necess rio para o INTERUPTX
TYPE RegTypeX
     ax    AS INTEGER
     bx    AS INTEGER
     cx    AS INTEGER
     dx    AS INTEGER
     bp    AS INTEGER
     si    AS INTEGER
     di    AS INTEGER
     flags AS INTEGER
     ds    AS INTEGER
     es    AS INTEGER
END TYPE

'Fun‡”es para convers„o num‚rica
DECLARE FUNCTION BIN2DEC& (valor$)
DECLARE FUNCTION BIN2HEX$ (valor$)
DECLARE FUNCTION BIN2OCT$ (valor$)
DECLARE FUNCTION DEC2BIN$ (valor#)
DECLARE FUNCTION DEC2HEX$ (valor#)
DECLARE FUNCTION DEC2OCT$ (valor#)
DECLARE FUNCTION HEX2BIN$ (valor$)
DECLARE FUNCTION HEX2DEC& (valor$)
DECLARE FUNCTION HEX2OCT$ (valor$)
DECLARE FUNCTION OCT2DEC& (valor$)
DECLARE FUNCTION OCT2HEX$ (valor$)
DECLARE FUNCTION OCT2BIN$ (valor$)

'Fun‡”es de c lculo num‚rico avan‡ado
DECLARE FUNCTION INVERS# (valor)
DECLARE FUNCTION SQUARE& (valor)
DECLARE FUNCTION CUBE& (valor)
DECLARE FUNCTION PI# ()

'Fun‡”es de tratamento de string
DECLARE FUNCTION ALOCATE$ (entry$, addstr$, position$, size)

'Fun‡”es matem ticas
DECLARE FUNCTION ADD.BIN$ (valor1$, valor2$)
DECLARE FUNCTION ADD.HEX$ (valor1$, valor2$)
DECLARE FUNCTION ADD.OCT$ (valor1$, valor2$)
DECLARE FUNCTION SUB.HEX$ (valor1$, valor2$)
DECLARE FUNCTION SUB.OCT$ (valor1$, valor2$)
DECLARE FUNCTION SUB.BIN$ (valor1$, valor2$)
DECLARE FUNCTION MUL.HEX$ (valor1$, valor2$)
DECLARE FUNCTION MUL.OCT$ (valor1$, valor2$)
DECLARE FUNCTION MUL.BIN$ (valor1$, valor2$)
DECLARE FUNCTION DIV.HEX$ (valor1$, valor2$)
DECLARE FUNCTION DIV.OCT$ (valor1$, valor2$)
DECLARE FUNCTION DIV.BIN$ (valor1$, valor2$)
DECLARE FUNCTION FACTORIAL& (valor1)
DECLARE FUNCTION PERCENT! (valor!)
DECLARE FUNCTION TEN# (expoente%)
DECLARE FUNCTION VIRG$ (valor#, casas)

'Fun‡”es boleanas
DECLARE FUNCTION ZERO (n)
DECLARE FUNCTION NEGATIVE (n)
DECLARE FUNCTION POSITIVE (n)
DECLARE FUNCTION ALLTRIM$ (n$)
DECLARE FUNCTION EMPTY (n$)
DECLARE FUNCTION IIF$ (condicao, valor1$, valor2$)

'Fun‡”es de tempo
DECLARE FUNCTION TIME2SECONDS (t$)
DECLARE FUNCTION SECONDS2TIME$ (s)
DECLARE FUNCTION EVALUATE$ (tin$, tfi$)

'Fun‡”es de arquivo
DECLARE FUNCTION TEMPFILE$ ()
DECLARE FUNCTION OPEN.FILES ()
DECLARE FUNCTION DOS.FAT (pathname$)
DECLARE FUNCTION DISK.FREE& (drive$)
DECLARE FUNCTION DOS.VER$ ()
DECLARE FUNCTION DOS.VOL$ (drive$)

'Fun‡”es de sistema
DECLARE FUNCTION BASE.MEMORY ()
DECLARE FUNCTION FLOPPY ()
DECLARE FUNCTION RS232 ()
DECLARE FUNCTION GAME ()
DECLARE FUNCTION LPT ()
DECLARE FUNCTION FPU ()
DECLARE FUNCTION KEY.STATUS$ ()
DECLARE FUNCTION INTERNAL.MEMORY ()
DECLARE FUNCTION STRING.MEMORY ()
DECLARE FUNCTION STACK ()
DECLARE FUNCTION NUMBER.MEMORY ()
DECLARE FUNCTION GET.KEY$ (keys$())
DECLARE FUNCTION CURDIR$ (drive$)
DECLARE FUNCTION HP850$ (t$)
DECLARE FUNCTION CP860$ (t$)
DECLARE FUNCTION PRN.NUMBER% ()
DECLARE FUNCTION PRN.STATUS% ()
DECLARE FUNCTION NET.STATUS% ()
DECLARE FUNCTION NET.ERROR% ()

'ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
'³            \/ ZONA RESERVADA AS PROCEDURES DA PROGRAMACAO \/             ³
'ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾

'Procedimentos de ambiente
DECLARE SUB CLW (l1, c1, l2, c2)
DECLARE SUB BOX (l1, c1, l2, c2, frame$)
DECLARE SUB CURSOR (status, l.start, l.end)
DECLARE SUB SAVE.SCREEN (m$)
DECLARE SUB RESTORE.SCREEN (m$)
DECLARE SUB HMENU (l, opcoes$(), colunas(), f1, b1, f2, b2, f3, b3, frame$, msg$(), lm, cm, f4, b4, items)
DECLARE SUB VMENU (c, opcoes$(), linhas(), f1, b1, f2, b2, f3, b3, frame$, msg$(), lm, cm, f4, b4, items)
DECLARE SUB TEXT.BOX (l, c, texto$(), f1, b1, f2, b2, items, centro)
DECLARE SUB DIVISION (l1, c1, l2, c2, frame$)
DECLARE SUB FILL (l1, c1, l2, c2, frame$)
DECLARE SUB CENTER (l, texto$)
DECLARE SUB SHOW (filename$, f1, b1, bd, f2, b2, f3, b3, frame$)
DECLARE SUB SAVESCR (l1, c1, l2, c2, a$())
DECLARE SUB RESTORESCR (l1, c1, l2, c2, a$())
DECLARE SUB GETCOLOR (l, c)

'Procedimentos de impressora ESC/P ou IBM
DECLARE SUB PAGE.SET (lines)
DECLARE SUB PRINTER (port$, st)
DECLARE SUB CONDENSED (st)
DECLARE SUB EXPANDED (st)
DECLARE SUB FORMFEED ()
DECLARE SUB PAGE.JUMP (l)

'Procedimentos para impressora HP DeskJet
DECLARE SUB HPRESET ()
DECLARE SUB HPEJECT ()
DECLARE SUB HPPITCH (pitch)
DECLARE SUB HPORIENTATION (o$)
DECLARE SUB HPCODEPAGE (code.page$)
DECLARE SUB HPSTYLE (s$)
DECLARE SUB HPNLQ ()
DECLARE SUB HPDRAFT ()
DECLARE SUB HPFONT (f$)
DECLARE SUB HPINTENSITY (i$)
DECLARE SUB HPFIXED ()
DECLARE SUB HPPROP ()
DECLARE SUB HPMARGIN (margin$, value)
DECLARE SUB HPFONTHIGHT (a)
DECLARE SUB HPUNDERLN (t$)
DECLARE SUB HPPAPER (t$)
DECLARE SUB HPSIZE (l)

'Procedimentos de sistema
DECLARE SUB INTERRUPT (intnum AS INTEGER, inreg AS RegType, outreg AS RegType)
DECLARE SUB INTERRUPTX (intnum AS INTEGER, inreg AS RegTypeX, outreg AS RegTypeX)
' NOTE: If the routine called takes parameters, then they will have to
'       be added to this declare statement before the parameter given.
DECLARE SUB ABSOLUTE (address AS INTEGER)
DECLARE SUB INT86OLD (intnum AS INTEGER, inarray() AS INTEGER, outarray() AS INTEGER)
DECLARE SUB INT86XOLD (intnum AS INTEGER, inarray() AS INTEGER, outarray() AS INTEGER)
DECLARE SUB COPY (source$, target$)
DECLARE SUB BAK (source$, target$)
DECLARE SUB ADD (filename$, vstring$)
DECLARE SUB REMOVE (filename$, vstring$)
DECLARE SUB INSERE (filename$, vstring$, position)
DECLARE SUB UPDATE.PATH (autoexec.file$, directory$)
DECLARE SUB MOVE (source$, target$)
DECLARE SUB ADIR (pathname$, vfiles, file.name$(), file.ext$(), file.size(), file.date$(), file.time$(), file.type$())
DECLARE SUB CTRL.BREAK (status)
DECLARE SUB CTRL.C (status)
DECLARE SUB ALT.CTRL.DEL (status)

'ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
'³             \/ ZONA RESERVADA AOS TESTES DESTA BIBLIOTECA  \/            ³
'ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾











'ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
'³               \/ INICIO DO PSEUDOCODIGO DESTA BIBLIOTECA  \/             ³
'ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾

END
key.press:
'Este bloco tem como finalidade controlar a leitura do teclado de alguns
'procedimentos e fun‡”es
RETURN

'ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
'³                /\ FIM DO SOURCE - CODE  DESTA BIBLIOTECA  /\             ³
'ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾

SUB ADD (filename$, vstring$)
  f1% = FREEFILE
  OPEN filename$ FOR APPEND AS #f1%
  PRINT #f1%, vstring$
  CLOSE #f1%
END SUB

FUNCTION ADD.BIN$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = BIN2DEC&(a1$)
  valor2! = BIN2DEC&(a2$)
  soma# = valor1! + valor2!
  adicao$ = DEC2BIN$(soma#)
  ADD.BIN$ = adicao$
END FUNCTION

FUNCTION ADD.HEX$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = HEX2DEC&(a1$)
  valor2! = HEX2DEC&(a2$)
  soma# = valor1! + valor2!
  adicao$ = DEC2HEX$(soma#)
  ADD.HEX$ = adicao$
END FUNCTION

FUNCTION ADD.OCT$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  va1! = OCT2DEC&(a1$)
  va2! = OCT2DEC&(a2$)
  soma# = va1! + va2!
  adicao$ = DEC2OCT$(soma#)
  ADD.OCT$ = adicao$
END FUNCTION

SUB ADIR (pathname$, vfiles, file.name$(), file.ext$(), file.size(), file.date$(), file.time$(), file.type$())
  old.l = CSRLIN
  old.c = POS(x)
  LOCATE 1, 1, 0, 10, 10
  t$ = TEMPFILE$
  SHELL "DIR " + pathname$ + ">" + t$
  livre = FREEFILE
  OPEN t$ FOR INPUT AS #livre
  m = 1
  DO UNTIL EOF(livre)
    LINE INPUT #livre, temp$
    IF temp$ <> "" THEN
      IF ASC(LEFT$(temp$, 1)) > 32 THEN
        IF LEFT$(temp$, 1) = "." THEN
           file.name$(m) = MID$(temp$, 1, 8)
           file.ext$(m) = ""
           file.size(m) = 0
           file.date$(m) = MID$(temp$, 23, 8)
           file.time$(m) = MID$(temp$, 32, 5)
           file.type$(m) = "D"
        ELSE
           file.name$(m) = MID$(temp$, 1, 8)
           file.ext$(m) = MID$(temp$, 10, 3)
           file.size(m) = VAL(MID$(temp$, 14, 8))
           file.date$(m) = MID$(temp$, 23, 8)
           file.time$(m) = MID$(temp$, 32, 5)
           IF MID$(temp$, 14, 4) = "<DIR>" THEN
             file.type$(m) = "D"
           ELSE
             file.type$(m) = "F"
           END IF
        END IF
        m = m + 1
      END IF
    END IF
  LOOP
  CLOSE #livre
  KILL t$
  LOCATE old.l, old.c
END SUB

FUNCTION ALLTRIM$ (n$)
  ALLTRIM$ = RTRIM$(LTRIM$(n$))
END FUNCTION

FUNCTION ALOCATE$ (entry$, addstr$, position$, size)
  SELECT CASE LEFT$(UCASE$(position$), 1)
    CASE "L"
      ALOCATE$ = STRING$(size - LEN(entry$), addstr$) + entry$
    CASE "R"
      ALOCATE$ = entry$ + STRING$(size - LEN(entry$), addstr$)
    CASE ELSE
      ALOCATE$ = ""
  END SELECT
END FUNCTION

SUB ALT.CTRL.DEL (status)
  SHARED break.key.flag, ctrl.c.key.flag, reset.key.flag
  KEY 16, CHR$(&H4 + &H8) + CHR$(&H53)    'ALT-CTRL-DEL
  ON KEY(16) GOSUB key.press
  IF NOT status THEN KEY(16) ON ELSE KEY(16) OFF
  IF status THEN reset.key.flag = -1 ELSE reset.key.flag = 0
  UEVENT ON
END SUB

SUB BAK (source$, target$)
  SHARED bak.status
  CONST FALSE = 0, TRUE = NOT FALSE
  bak.status = FALSE
  filenumber1% = FREEFILE
  OPEN target$ FOR OUTPUT AS #filenumber1%: CLOSE : KILL target$
  OPEN source$ FOR BINARY AS #filenumber1%
  IF LOF(filenumber1%) = 0 THEN CLOSE #filenumber1%: ERROR 53
  IF LOF(filenumber1%) > 32000 THEN buffer = 32000 ELSE buffer = LOF(filenumber1%)
  filenumber2% = FREEFILE
  OPEN target$ FOR BINARY AS #filenumber2%
  written = LOF(filenumber1%)
  DO UNTIL EOF(filenumber1%)
    IF buffer = 0 THEN EXIT DO
    buffer$ = SPACE$(buffer)
    GET #filenumber1%, , buffer$
    PUT #filenumber2%, , buffer$
    written = written - buffer
    buffer$ = ""
    IF written > 32000 THEN
      buffer = 32000
    ELSE
      buffer = written
    END IF
  LOOP
  bak.status = TRUE
  CLOSE #filenumber1%, filenumber2%
END SUB

FUNCTION BASE.MEMORY
  DEF SEG = &H40
  BASE.MEMORY = PEEK(&H13) + (PEEK(&H14) * 256)
  DEF SEG
END FUNCTION

FUNCTION BIN2DEC& (valor$)
  a$ = LTRIM$(UCASE$(valor$))
  total = 0
  IF a$ = "" THEN
    ERROR 5
    EXIT FUNCTION
  END IF
  sinal = 1
  IF LEFT$(a$, 1) = "-" THEN
    sinal = -1
    a$ = MID$(a$, 2, LEN(a$) - 1)
  END IF
  IF LEFT$(a$, 1) = "+" THEN
    sinal = 1
    a$ = MID$(a$, 2, LEN(a$) - 1)
  END IF
  IF LEN(a$) < 40 THEN a$ = STRING$(40 - LEN(a$), "0") + a$
  IF LEN(a$) > 40 THEN
    ERROR 6
    EXIT FUNCTION
  END IF
  FOR j = 1 TO LEN(a$)
    codigo.ASCII = ASC(MID$(a$, j, 1))
    IF codigo.ASCII < 48 OR codigo.ASCII > 49 THEN ERROR 13
  NEXT
  expoente = 39
  FOR digito = 1 TO LEN(a$)
    valo$ = MID$(a$, digito, 1)
    valorB = VAL(valo$)
    total = total + (valorB * (2 ^ expoente))
    expoente = expoente - 1
  NEXT
  BIN2DEC& = sinal * total
END FUNCTION

FUNCTION BIN2HEX$ (valor$)
  a$ = UCASE$(valor$)
  d# = BIN2DEC(a$)
  h$ = DEC2HEX$(d#)
  BIN2HEX$ = h$
END FUNCTION

FUNCTION BIN2OCT$ (valor$)
  a$ = UCASE$(valor$)
  d# = BIN2DEC&(a$)
  o$ = DEC2OCT$(d#)
  BIN2OCT$ = o$
END FUNCTION

SUB BOX (l1, c1, l2, c2, frame$)
  SELECT CASE UCASE$(frame$)
    CASE "DOUBLE", "D", "DO", "DOU", "DOUB", "DOUBL"
      canto.superior.esquerdo$ = CHR$(201)
      canto.superior.direito$ = CHR$(187)
      canto.inferior.esquerdo$ = CHR$(200)
      canto.inferior.direito$ = CHR$(188)
      linha.vertical$ = CHR$(186)
      linha.horizontal$ = CHR$(205)
    CASE "SINGLE", "S", "SI", "SIN", "SING", "SINGL"
      canto.superior.esquerdo$ = CHR$(218)
      canto.superior.direito$ = CHR$(191)
      canto.inferior.esquerdo$ = CHR$(192)
      canto.inferior.direito$ = CHR$(217)
      linha.vertical$ = CHR$(179)
      linha.horizontal$ = CHR$(196)
    CASE ELSE
      ERROR 5
  END SELECT
  lx1 = l1
  lx2 = l2
  cy1 = c1
  cy2 = c2
  IF lx1 = 0 OR lx2 = 0 OR cy1 = 0 OR cy2 = 0 THEN ERROR 5
  IF lx1 > lx2 THEN SWAP lx1, lx2
  IF cy1 > cy2 THEN SWAP cy1, cy2
  linha.superior$ = STRING$((cy2 - cy1) - y, linha.horizontal$)
  linha.inferior$ = STRING$((cy2 - cy1) - y, linha.horizontal$)
  linha.lateral.esquerda$ = linha.vertical$
  linha.lateral.direita$ = linha.vertical$
  LOCATE lx1, cy1 + 1: PRINT linha.superior$;
  LOCATE lx2, cy1 + 1: PRINT linha.inferior$;
  LOCATE lx1, cy1: PRINT canto.superior.esquerdo$;
  LOCATE lx1, cy2 - x: PRINT canto.superior.direito$;
  LOCATE lx2, cy1: PRINT canto.inferior.esquerdo$;
  LOCATE lx2, cy2 - x: PRINT canto.inferior.direito$;
  FOR linha = lx1 + 1 TO lx2 - 1
    LOCATE linha, cy1: PRINT linha.lateral.esquerda$;
    LOCATE linha, cy2: PRINT linha.lateral.direita$;
  NEXT
END SUB

SUB CENTER (l, texto$)
  LOCATE l, 40 - LEN(texto$) \ 2: PRINT texto$;
END SUB

SUB CLW (l1, c1, l2, c2)
  lx1 = l1
  cy1 = c1
  lx2 = l2
  cy2 = c2
  IF lx1 = 0 OR lx2 = 0 OR cy1 = 0 OR cy2 = 0 THEN ERROR 5
  IF lx1 > lx2 THEN SWAP lx1, lx2
  IF cy1 > cy2 THEN SWAP cy1, cy2
  tamanho = cy2 - cy1 + 1
  FOR linha = lx1 TO lx2
    LOCATE linha, cy1: PRINT SPACE$(tamanho);
  NEXT
END SUB

SUB CONDENSED (st)
  SHARED printer.status, condensed.status, fprint%
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    IF st THEN
      PRINT #fprint%, CHR$(&HF);
      condensed.status = TRUE
    ELSE
      PRINT #fprint%, CHR$(&H12);
      condensed.status = FALSE
    END IF
  ELSE
    ERROR 57
  END IF
END SUB

SUB COPY (source$, target$)
  SHARED copy.status
  CONST FALSE = 0, TRUE = NOT FALSE
  copy.status = FALSE
  filenumber1% = FREEFILE
  OPEN target$ FOR OUTPUT AS #filenumber1%: CLOSE : KILL target$
  OPEN source$ FOR BINARY AS #filenumber1%
  IF LOF(filenumber1%) = 0 THEN CLOSE #filenumber1%: ERROR 53
  IF LOF(filenumber1%) > 32000 THEN buffer = 32000 ELSE buffer = LOF(filenumber1%)
  filenumber2% = FREEFILE
  OPEN target$ FOR BINARY AS #filenumber2%
  written = LOF(filenumber1%)
  DO UNTIL EOF(filenumber1%)
    IF buffer = 0 THEN EXIT DO
    buffer$ = SPACE$(buffer)
    GET #filenumber1%, , buffer$
    PUT #filenumber2%, , buffer$
    written = written - buffer
    buffer$ = ""
    IF written > 32000 THEN
      buffer = 32000
    ELSE
      buffer = written
    END IF
  LOOP
  copy.status = TRUE
  CLOSE #filenumber1%, filenumber2%
END SUB

FUNCTION CP860$ (t$)
  FOR j = 1 TO LEN(t$)
    caractere$ = MID$(t$, j, 1)
    SELECT CASE caractere$
      CASE "µ"
        MID$(t$, j, 1) = "†"
      CASE "¶"
        MID$(t$, j, 1) = ""
      CASE "·"
        MID$(t$, j, 1) = "‘"
      CASE "Æ"
        MID$(t$, j, 1) = "„"
      CASE "Ç"
        MID$(t$, j, 1) = "Ž"
      CASE "Ò"
        MID$(t$, j, 1) = "‰"
      CASE "Ô"
        MID$(t$, j, 1) = "’"
      CASE "Ö"
        MID$(t$, j, 1) = "‹"
      CASE "à"
        MID$(t$, j, 1) = "Ÿ"
      CASE "â"
        MID$(t$, j, 1) = "Œ"
      CASE "ã"
        MID$(t$, j, 1) = "©"
      CASE "ä"
        MID$(t$, j, 1) = "”"
      CASE "å"
        MID$(t$, j, 1) = "™"
      CASE "é"
        MID$(t$, j, 1) = "–"
      CASE "ë"
        MID$(t$, j, 1) = ""
      CASE "Þ"
        MID$(t$, j, 1) = "˜"
    END SELECT
  NEXT
  CP860$ = t$
END FUNCTION

SUB CTRL.BREAK (status)
  SHARED break.key.flag, ctrl.c.key.flag, reset.key.flag
  KEY 15, CHR$(&H4) + CHR$(&H46)          'CTRL-BREAK
  ON KEY(15) GOSUB key.press
  IF NOT status THEN KEY(15) ON ELSE KEY(15) OFF
  IF status THEN break.key.flag = -1 ELSE break.key.flag = 0
  UEVENT ON
END SUB

SUB CTRL.C (status)
  SHARED break.key.flag, ctrl.c.key.flag, reset.key.flag
  KEY 17, CHR$(&H4) + CHR$(&H2E)          'CTRL-C
  ON KEY(17) GOSUB key.press
  IF NOT status THEN KEY(17) ON ELSE KEY(17) OFF
  IF status THEN ctrl.c.key.flag = -1 ELSE ctrl.c.key.flag = 0
  UEVENT ON
END SUB

FUNCTION CUBE& (valor)
  a = valor
  CUBE& = a ^ 3
END FUNCTION

FUNCTION CURDIR$ (drive$)
  IF drive$ = "" THEN ERROR 5
  old.l = CSRLIN
  old.c = POS(x)
  LOCATE 1, 1, 0, 10, 10
  t$ = TEMPFILE$
  SHELL "CD " + drive$ + " >" + t$
  livre = FREEFILE
  OPEN t$ FOR INPUT AS #livre
  DO UNTIL EOF(livre)
    LINE INPUT #livre, m$
    IF m$ <> "" THEN CURDIR$ = m$: EXIT DO
  LOOP
  CLOSE #livre
  KILL t$
  LOCATE old.l, old.c
END FUNCTION

SUB CURSOR (status, l.start, l.end)
  SHARED cursor.status
  IF status THEN
    LOCATE , , 1, l.start, l.end
  ELSE
    LOCATE , , 0, l.start, l.end
  END IF
  cursor.status = status
END SUB

FUNCTION DEC2BIN$ (valor#)
  CONST nao = 0, sim = NOT nao
  a# = valor#
  DIM sinal$(2)
  sinal$(0) = " "
  sinal$(1) = "-"
  digito$ = ""
  verifica = sim
  negativo = nao
  IF a# < 0 THEN negativo = sim: a# = ABS(a#)
  DO WHILE verifica
    v# = a# \ 2
    IF v# = 0 THEN
      digito$ = MID$(STR$(a#), 2) + digito$
      EXIT DO
    END IF
    r# = a# MOD 2
    digito$ = MID$(STR$(r#), 2) + digito$
    a# = v#
  LOOP
  IF LEN(digito$) < 40 THEN digito$ = STRING$(40 - LEN(digito$), "0") + digito$
  IF LEN(digito$) > 40 THEN ERROR 6
  DEC2BIN$ = sinal$(ABS(negativo)) + digito$ + "{B}"
END FUNCTION

FUNCTION DEC2HEX$ (valor#)
  CONST nao = 0, sim = NOT nao
  a# = valor#
  DIM sinal$(2)
  sinal$(0) = " "
  sinal$(1) = "-"
  digito$ = ""
  verifica = nao
  negativo = nao
  IF a# < 0 THEN negativo = sim: a# = ABS(a#)
  IF a# < 16 THEN
    SELECT CASE a#
      CASE 10
        digito$ = "A" + digito$
      CASE 11
        digito$ = "B" + digito$
      CASE 12
        digito$ = "C" + digito$
      CASE 13
        digito$ = "D" + digito$
      CASE 14
        digito$ = "E" + digito$
      CASE 15
        digito$ = "F" + digito$
      CASE ELSE
        digito$ = MID$(STR$(a#), 2) + digito$
    END SELECT
  ELSE
    verifica = -1
  END IF
  DO WHILE verifica
    v# = a# \ 16
    IF v# = 0 THEN
      SELECT CASE a#
        CASE 10
          digito$ = "A" + digito$
        CASE 11
          digito$ = "B" + digito$
        CASE 12
          digito$ = "C" + digito$
        CASE 13
          digito$ = "D" + digito$
        CASE 14
          digito$ = "E" + digito$
        CASE 15
          digito$ = "F" + digito$
        CASE ELSE
          digito$ = MID$(STR$(a#), 2) + digito$
      END SELECT
      EXIT DO
    END IF
    r# = a# MOD 16
    SELECT CASE r#
      CASE 10
        digito$ = "A" + digito$
      CASE 11
        digito$ = "B" + digito$
      CASE 12
        digito$ = "C" + digito$
      CASE 13
        digito$ = "D" + digito$
      CASE 14
        digito$ = "E" + digito$
      CASE 15
        digito$ = "F" + digito$
      CASE ELSE
        digito$ = MID$(STR$(r#), 2) + digito$
    END SELECT
    a# = v#
  LOOP
  IF LEN(digito$) < 10 THEN digito$ = STRING$(10 - LEN(digito$), "0") + digito$
  IF LEN(digito$) > 10 THEN ERROR 6
  DEC2HEX$ = sinal$(ABS(negativo)) + digito$ + "{H}"
END FUNCTION

FUNCTION DEC2OCT$ (valor#)
  CONST nao = 0, sim = NOT nao
  a# = valor#
  DIM sinal$(2)
  sinal$(0) = " "
  sinal$(1) = "-"
  digito$ = ""
  negativo = nao
  IF a# < 0 THEN negativo = sim: a# = ABS(a#)
  verifica = -1
  IF a# < 8 THEN
    digito$ = MID$(STR$(a#), 2)
    verifica = nao
  END IF
  DO WHILE verifica
    v# = a# \ 8
    IF v# = 0 THEN
      digito$ = MID$(STR$(a#), 2) + digito$
      EXIT DO
    END IF
    r# = a# MOD 8
    digito$ = MID$(STR$(r#), 2) + digito$
    a# = v#
  LOOP
  IF LEN(digito$) < 20 THEN digito$ = STRING$(20 - LEN(digito$), "0") + digito$
  IF LEN(digito$) > 20 THEN ERROR 6
  DEC2OCT$ = sinal$(ABS(negativo)) + digito$ + "{O}"
END FUNCTION

FUNCTION DISK.FREE& (drive$)
  IF drive$ = "" THEN ERROR 5
  t$ = TEMPFILE$
  old.l = CSRLIN
  old.c = POS(x)
  LOCATE 1, 1, 0, 10, 10
  SHELL "DIR " + drive$ + ">" + t$
  livre = FREEFILE
  OPEN t$ FOR INPUT AS #livre
  t = 1
  DO UNTIL EOF(livre)
    LINE INPUT #livre, tu$
    t = t + 1
  LOOP
  t = t - 1
  SEEK #livre, 1
  FOR j = 1 TO t - 1
    LINE INPUT #livre, tu$
  NEXT
  LINE INPUT #livre, tu$
  size = LOF(livre)
  CLOSE #livre
  KILL t$
  LOCATE old.l, old.c
  DISK.FREE& = VAL(RIGHT$(tu$, 20)) - size
END FUNCTION

FUNCTION DIV.BIN$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = BIN2DEC&(a1$)
  valor2! = BIN2DEC&(a2$)
  IF valor2! = 0 THEN ERROR 5
  soma# = valor1! / valor2!
  so$ = MID$(STR$(soma#), 2)
  IF INSTR(so$, ".") <> 0 THEN soma# = VAL(MID$(so$, 1, INSTR(so$, ".") - 1))
  adicao$ = DEC2BIN$(soma#)
  DIV.BIN$ = adicao$
END FUNCTION

FUNCTION DIV.HEX$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  va1! = HEX2DEC&(a1$)
  va2! = HEX2DEC&(a2$)
  PRINT va1!, va2!
  IF va2! = 0 THEN ERROR 5
  soma# = va1! / va2!
  so$ = MID$(STR$(soma#), 2)
  IF INSTR(so$, ".") <> 0 THEN soma# = VAL(MID$(so$, 1, INSTR(so$, ".") - 1))
  PRINT soma#
  adicao$ = DEC2HEX$(soma#)
  DIV.HEX$ = adicao$
END FUNCTION

FUNCTION DIV.OCT$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = OCT2DEC&(a1$)
  valor2! = OCT2DEC&(a2$)
  IF valor2! = 0 THEN ERROR 5
  soma# = valor1! / valor2!
  so$ = MID$(STR$(soma#), 2)
  IF INSTR(so$, ".") <> 0 THEN soma# = VAL(MID$(so$, 1, INSTR(so$, ".") - 1))
  PRINT soma#
  adicao$ = DEC2OCT$(soma#)
  DIV.OCT$ = adicao$
END FUNCTION

SUB DIVISION (l1, c1, l2, c2, frame$)
  IF UCASE$(frame$) = "D" THEN
    IF l1 = l2 THEN
      left.division$ = CHR$(204)
      right.division$ = CHR$(185)
      line.division$ = STRING$(c2 - c1 - 1, CHR$(205))
    END IF
    IF c1 = c2 THEN
      up.division$ = CHR$(203)
      low.division$ = CHR$(202)
      line.division$ = CHR$(186)
    END IF
  END IF
  IF UCASE$(frame$) = "S" OR frame$ = "" THEN
    IF l1 = l2 THEN
      left.division$ = CHR$(195)
      right.division$ = CHR$(180)
      line.division$ = STRING$(c2 - c1 - 1, CHR$(196))
    END IF
    IF c1 = c2 THEN
      up.division$ = CHR$(194)
      low.division$ = CHR$(193)
      line.division$ = CHR$(179)
    END IF
  END IF
  IF l1 = l2 THEN
    LOCATE l1, c1: PRINT left.division$
    LOCATE l1, c2: PRINT right.division$
    LOCATE l1, c1 + 1: PRINT line.division$
  END IF
  IF c1 = c2 THEN
    LOCATE l1, c1: PRINT up.division$
    LOCATE l2, c1: PRINT low.division$
    FOR lina = l1 + 1 TO l2 - 1
      LOCATE lina, c1: PRINT line.division$
    NEXT
  END IF
END SUB

FUNCTION DOS.FAT (pathname$)
  old.l = CSRLIN
  old.c = POS(x)
  LOCATE 1, 1, 0, 10, 10
  t$ = TEMPFILE$
  SHELL "DIR " + pathname$ + ">" + t$
  livre = FREEFILE
  OPEN t$ FOR INPUT AS #livre
  DO UNTIL EOF(livre)
    LINE INPUT #livre, temp$
    IF temp$ <> "" THEN
      IF ASC(LEFT$(temp$, 1)) > 32 THEN vfiles = vfiles + 1
    END IF
  LOOP
  CLOSE #livre
  KILL t$
  LOCATE old.l, old.c
  DOS.FAT = vfiles
END FUNCTION

FUNCTION DOS.VER$
  t$ = TEMPFILE$
  old.l = CSRLIN
  old.c = POS(x)
  LOCATE 1, 1, 0, 10, 10
  SHELL "VER >" + t$
  livre = FREEFILE
  OPEN t$ FOR INPUT AS #livre
  t = 1
  DO UNTIL EOF(livre)
    LINE INPUT #livre, tu$
    IF tu$ <> "" THEN DOS.VER$ = tu$: EXIT DO
  LOOP
  CLOSE #livre
  KILL t$
  LOCATE old.l, old.c
END FUNCTION

FUNCTION DOS.VOL$ (drive$)
  IF drive$ = "" THEN ERROR 5
  t$ = TEMPFILE$
  old.l = CSRLIN
  old.c = POS(x)
  LOCATE 1, 1, 0, 10, 10
  SHELL "VOL " + drive$ + ">" + t$
  livre = FREEFILE
  OPEN t$ FOR INPUT AS #livre
  t = 1
  DO UNTIL EOF(livre)
    LINE INPUT #livre, tu$
    IF tu$ <> "" THEN
      FOR j = LEN(tu$) TO 1 STEP -1
        IF MID$(tu$, j, 1) = " " THEN v$ = ALLTRIM$(MID$(tu$, j, 11)): EXIT FOR
      NEXT
      EXIT DO
    END IF
  LOOP
  CLOSE #livre
  FOR j = 1 TO LEN(v$)
    IF ASC(MID$(v$, j, 1)) > 90 OR ASC(MID$(v$, j, 1)) < 65 THEN
      DOS.VOL$ = "NO LABEL   "
    ELSE
      DOS.VOL$ = v$
    END IF
  NEXT
  KILL t$
  LOCATE old.l, old.c
END FUNCTION

FUNCTION EMPTY (n$)
  CONST FALSE = 0, TRUE = NOT FALSE
  IF n$ = "" THEN EMPTY = TRUE
  IF n$ <> "" THEN EMPTY = FALSE
END FUNCTION

FUNCTION EVALUATE$ (tin$, tfi$)
  segundos.inicial = TIME2SECONDS(tin$)
  segundos.final = TIME2SECONDS(tfi$)
  segundos.gastos = segundos.final - segundos.inicial
  EVALUATE$ = SECONDS2TIME$(segundos.gastos)
END FUNCTION

SUB EXPANDED (st)
  SHARED printer.status, expanded.status, fprint%
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    IF st THEN
      PRINT #fprint%, CHR$(&HE);
      expanded.status = TRUE
    ELSE
      PRINT #fprint%, CHR$(&H14);
      expanded.status = FALSE
    END IF
  ELSE
    ERROR 57
  END IF
END SUB

FUNCTION FACTORIAL& (valor1)
  v = valor1
  IF v = 0 THEN ERROR 5
  resulta& = v
  FOR k = v - 1 TO 1 STEP -1
    resulta& = resulta& * k
  NEXT
  FACTORIAL& = resulta&
END FUNCTION

SUB FILL (l1, c1, l2, c2, frame$)
  FOR l = l1 TO l2
    LOCATE l, c1: PRINT STRING$(c2 - c1, frame$)
  NEXT
END SUB

FUNCTION FLOPPY
  DEF SEG = &H40
  byte1 = PEEK(&H10)
  byte2 = PEEK(&H11)
  byte = (byte2 * 256) + byte1
  byte$ = ""
  DO
    byte = byte \ 2
    resto = byte MOD 2
    byte$ = LTRIM$(STR$(resto)) + byte$
    IF LEN(byte$) = 14 THEN EXIT DO
  LOOP
  byte$ = LTRIM$(STR$(byte \ 2)) + byte$
  fdd$ = MID$(byte$, 9, 2)
  SELECT CASE fdd$
    CASE "00"
      FLOPPY = 1
    CASE "01"
      FLOPPY = 2
    CASE "10"
      FLOPPY = 3
    CASE "11"
      FLOPPY = 4
  END SELECT
  DEF SEG
END FUNCTION

SUB FORMFEED
  SHARED printer.status, formfeed.status, fprint%
  CONST FALSE = 0, TRUE = NOT FALSE
  formfeed.status = FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(&HC)
    formfeed.status = TRUE
  ELSE
    ERROR 57
  END IF
END SUB

FUNCTION FPU
  DEF SEG = &H40
  byte1 = PEEK(&H10)
  byte2 = PEEK(&H11)
  byte = (byte2 * 256) + byte1
  byte$ = ""
  DO
    byte = byte \ 2
    resto = byte MOD 2
    byte$ = LTRIM$(STR$(resto)) + byte$
    IF LEN(byte$) = 14 THEN EXIT DO
  LOOP
  byte$ = LTRIM$(STR$(byte \ 2)) + byte$
  mpu$ = MID$(byte$, 15, 1)
  SELECT CASE mpu$
    CASE "0"
      FPU = 0
    CASE "1"
      FPU = 1
  END SELECT
  DEF SEG
END FUNCTION

FUNCTION GAME
  DEF SEG = &H40
  byte1 = PEEK(&H10)
  byte2 = PEEK(&H11)
  byte = (byte2 * 256) + byte1
  byte$ = ""
  DO
    byte = byte \ 2
    resto = byte MOD 2
    byte$ = LTRIM$(STR$(resto)) + byte$
    IF LEN(byte$) = 14 THEN EXIT DO
  LOOP
  byte$ = LTRIM$(STR$(byte \ 2)) + byte$
  joystick$ = MID$(byte$, 4, 1)
  SELECT CASE joystick$
    CASE "0"
      GAME = 0
    CASE "1"
      GAME = 1
  END SELECT
  DEF SEG
END FUNCTION

FUNCTION GET.KEY$ (keys$())
  CONST FALSE = 0, TRUE = NOT FALSE
  keystatus = FALSE
  DO
    DO
      keystroke$ = UCASE$(INKEY$)
      IF keystroke$ <> "" THEN EXIT DO
    LOOP
    FOR ky = 1 TO UBOUND(keys$)
      IF keystroke$ = keys$(ky) THEN
        GET.KEY$ = keystroke$
        keystatus = TRUE
        EXIT FOR
      END IF
    NEXT
    IF keystatus THEN EXIT DO
  LOOP
END FUNCTION

SUB GETCOLOR (l, c)
  SHARED foreground, background
  actual.attribut% = SCREEN(l, c, 1)
  color.code$ = HEX$(actual.attribut%)
  IF LEN(color.code$) < 2 THEN color.code$ = "0" + color.code$
  foreground$ = RIGHT$(color.code$, 1)
  background$ = LEFT$(color.code$, 1)
  SELECT CASE foreground$
    CASE "A"
      foreground = 10
    CASE "B"
      foreground = 11
    CASE "C"
      foreground = 12
    CASE "D"
      foreground = 13
    CASE "E"
      foreground = 14
    CASE "F"
      foreground = 15
    CASE ELSE
      foreground = VAL(foreground$)
  END SELECT
  SELECT CASE background$
    CASE "A"
      background = 10
    CASE "B"
      background = 11
    CASE "C"
      background = 12
    CASE "D"
      background = 13
    CASE "E"
      background = 14
    CASE "F"
      background = 15
    CASE ELSE
      background = VAL(background$)
  END SELECT
END SUB

FUNCTION HEX2BIN$ (valor$)
  a$ = UCASE$(valor$)
  d# = HEX2DEC&(a$)
  b$ = DEC2BIN$(d#)
  HEX2BIN$ = b$
END FUNCTION

FUNCTION HEX2DEC& (valor$)
  a$ = UCASE$(valor$)
  total = 0
  IF a$ = "" THEN
    ERROR 5
    EXIT FUNCTION
  END IF
  sinal = 1
  IF LEFT$(a$, 1) = "-" THEN
    sinal = -1
    a$ = MID$(a$, 2, LEN(a$) - 1)
  END IF
  IF LEFT$(a$, 1) = "+" THEN
    sinal = 1
    a$ = MID$(a$, 2, LEN(a$) - 1)
  END IF
  IF LEN(a$) < 10 THEN a$ = STRING$(10 - LEN(a$), "0") + a$
  IF LEN(a$) > 10 THEN
    ERROR 6
    EXIT FUNCTION
  END IF
  FOR j = 1 TO LEN(a$)
    codigo.ASCII = ASC(MID$(a$, j, 1))
    IF (codigo.ASCII < 48 OR codigo.ASCII > 57) AND (codigo.ASCII < 65 OR codigo.ASCII > 70) THEN
      ERROR 13
      EXIT FUNCTION
    END IF
  NEXT
  expoente = 9
  FOR digito = 1 TO LEN(a$)
    valo$ = MID$(a$, digito, 1)
    SELECT CASE valo$
      CASE "A"
        valorB = 10
      CASE "B"
        valorB = 11
      CASE "C"
        valorB = 12
      CASE "D"
        valorB = 13
      CASE "E"
        valorB = 14
      CASE "F"
        valorB = 15
      CASE ELSE
        valorB = VAL(valo$)
    END SELECT
    total = total + (valorB * (16 ^ expoente))
    expoente = expoente - 1
  NEXT
  HEX2DEC& = sinal * total
END FUNCTION

FUNCTION HEX2OCT$ (valor$)
  a$ = UCASE$(valor$)
  d# = HEX2DEC&(a$)
  o$ = DEC2OCT$(d#)
  HEX2OCT$ = o$
END FUNCTION

SUB HMENU (l, opcoes$(), colunas(), f1, b1, f2, b2, f3, b3, frame$, msg$(), lm, cm, f4, b4, items)
  SHARED key.option
  IF msg$ <> "" THEN
    IF lm < 1 OR lm > 25 OR cm < 1 OR cm > 80 THEN ERROR 5
  END IF
  c1 = colunas(1) - 1
  c2 = colunas(UBOUND(colunas)) + LEN(opcoes$(UBOUND(opcoes$)))
  COLOR f3, b3: BOX l - 1, c1, l + 1, c2, frame$
  FOR j = 1 TO items
    COLOR f1, b1
    LOCATE l, colunas(j): PRINT opcoes$(j)
  NEXT
  posicao = 1
  GOSUB poe.barra
h.key:
  h.key.stroke$ = UCASE$(INKEY$)
  IF h.key.stroke$ = "" THEN GOTO h.key
  IF h.key.stroke$ = CHR$(27) THEN key.option = 0: COLOR 7, 0: EXIT SUB
  IF h.key.stroke$ = CHR$(13) THEN
    key.option = posicao
    COLOR 7, 0
    EXIT SUB
  END IF
  h.key.stroke$ = MID$(h.key.stroke$, 2)
  IF h.key.stroke$ = "K" THEN
    posicao = posicao - 1
    IF posicao < 1 THEN posicao = 1
    GOSUB poe.barra
    GOTO h.key
  END IF
  IF h.key.stroke$ = "M" THEN
    posicao = posicao + 1
    IF posicao > items THEN posicao = items
    GOSUB poe.barra
    GOTO h.key
  END IF
  BEEP
  GOTO h.key

poe.barra:
  prev = posicao - 1
  afte = posicao + 1
  IF prev < 1 THEN prev = 1
  IF afte > items THEN afte = items
  COLOR f1, b1
  LOCATE l, colunas(prev): PRINT opcoes$(prev)
  LOCATE l, colunas(afte): PRINT opcoes$(afte)
  COLOR f2, b2
  LOCATE l, colunas(posicao): PRINT opcoes$(posicao)
  IF msg$(posicao) <> "" THEN
    COLOR f4, b4
    LOCATE lm, cm: PRINT msg$(posicao)
  END IF
  COLOR f1, b1
  RETURN
END SUB

FUNCTION HP850$ (t$)
  FOR j = 1 TO LEN(t$)
    caractere$ = MID$(t$, j, 1)
    SELECT CASE caractere$
      CASE "†"
        MID$(t$, j, 1) = "µ"
      CASE ""
        MID$(t$, j, 1) = "¶"
      CASE "‘"
        MID$(t$, j, 1) = "·"
      CASE "„"
        MID$(t$, j, 1) = "Æ"
      CASE "Ž"
        MID$(t$, j, 1) = "Ç"
      CASE "‰"
        MID$(t$, j, 1) = "Ò"
      CASE "’"
        MID$(t$, j, 1) = "Ô"
      CASE "‹"
        MID$(t$, j, 1) = "Ö"
      CASE "Ÿ"
        MID$(t$, j, 1) = "à"
      CASE "Œ"
        MID$(t$, j, 1) = "â"
      CASE "©"
        MID$(t$, j, 1) = "ã"
      CASE "”"
        MID$(t$, j, 1) = "ä"
      CASE "™"
        MID$(t$, j, 1) = "å"
      CASE "–"
        MID$(t$, j, 1) = "é"
      CASE ""
        MID$(t$, j, 1) = "ë"
      CASE "˜"
        MID$(t$, j, 1) = "Þ"
    END SELECT
  NEXT
  HP850$ = t$
END FUNCTION

SUB HPCODEPAGE (cp$)
  SHARED printer.status, fprint%, prn.reset, cur.cp$, prn.cp
  CONST FALSE = 0, TRUE = NOT FALSE
  SELECT CASE UCASE$(cp$)
    CASE "PC-8"
      prn.code$ = "(10U"
    CASE "HP ROMAN8"
      prn.code$ = "(8U"
    CASE "PC-8 D/N"
      prn.code$ = "(11U"
    CASE "PC-850"
      prn.code$ = "(12U"
    CASE "ECMA-94"
      prn.code$ = "(0N"
    CASE "ISO 21"
      prn.code$ = "(1G"
    CASE "ISO 69"
      prn.code$ = "(1F"
    CASE "ISO 15"
      prn.code$ = "(0I"
    CASE "ISO 17"
      prn.code$ = "(2S"
    CASE "ISO 11"
      prn.code$ = "(0S"
    CASE "ISO 10"
      prn.code$ = "(3S"
    CASE "ISO 60"
      prn.code$ = "(0D"
    CASE "ISO 61"
      prn.code$ = "(1D"
    CASE "ISO 16"
      prn.code$ = "(4S"
    CASE "ISO 4"
      prn.code$ = "(1E"
    CASE "ISO 6"
      prn.code$ = "(0U"
    CASE "JIS ASCII"
      prn.code$ = "(0K"
    CASE "HP OFFICE"
      prn.code$ = "(1U"
    CASE "ISO IRV"
      prn.code$ = "(2U"
    CASE ELSE
      prn.cp = FALSE
      cur.cp$ = ""
      ERROR 13
  END SELECT
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + prn.code$
    prn.cp = TRUE
    cur.cp$ = cp$
  ELSE
    prn.cp = FALSE
    cur.cp$ = ""
    ERROR 57
  END IF
END SUB

SUB HPDRAFT
  SHARED printer.status, fprint%, prn.draft
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "(s1Q";
    prn.draft = TRUE
  ELSE
    prn.draft = FALSE
    ERROR 57
  END IF
END SUB

SUB HPEJECT
  SHARED printer.status, fprint%, prn.eject
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "&l0H";
    prn.eject = TRUE
  ELSE
    prn.eject = FALSE
    ERROR 57
  END IF
END SUB

SUB HPFIXED
  SHARED printer.status, fprint%, prn.fixed
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "(s0P";
    prn.fixed = TRUE
  ELSE
    prn.fixed = FALSE
    ERROR 57
  END IF
END SUB

SUB HPFONT (f$)
  SHARED printer.status, fprint%, cur.fnt$, prn.fnt
  CONST FALSE = 0, TRUE = NOT FALSE
  SELECT CASE UCASE$(cp$)
    CASE "COURIER"
      prn.code$ = "(s3T"
    CASE "CG TIMES"
      prn.code$ = "(s4101T"
    CASE "LETTER GOTHIC"
      prn.code$ = "(s6T"
    CASE "UNIVERS"
      prn.code$ = "(s52T"
    CASE ELSE
      prn.fnt = FALSE
      cur.fnt$ = ""
      ERROR 13
  END SELECT
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + prn.code$
    prn.fnt = TRUE
    cur.fnt$ = f$
  ELSE
    prn.fnt = FALSE
    cur.fnt$ = ""
    ERROR 57
  END IF
END SUB

SUB HPINTENSITY (o$)
  SHARED printer.status, fprint%, prn.inty, cur.it$
  CONST FALSE = 0, TRUE = NOT FALSE
  SELECT CASE UCASE$(o$)
    CASE "N"
      prn.code$ = "(s0B"
    CASE "E"
      prn.code$ = "(s7B"
    CASE "B"
      prn.code$ = "(s3B"
    CASE ELSE
      prn.inty = FALSE
      cur.it$ = "ENTRY->[B]old, [E]xtra Bold, [N]ormal"
      ERROR 13
  END SELECT
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + prn.code$
    prn.inty = TRUE
    cur.it$ = cp$
  ELSE
    prn.inty = FALSE
    cur.it$ = ""
    ERROR 57
  END IF
END SUB

SUB HPMARGIN (margin$, value)
  SHARED printer.status, fprint%, prn.marg, cur.mg$, cur.va
  CONST FALSE = 0, TRUE = NOT FALSE
  SELECT CASE LEFT$(UCASE$(margin$), 1)
    CASE "L"
      prn.code$ = "&a" + MID$(STR$(value), 2) + "L"
    CASE "R"
      prn.code$ = "&a" + MID$(STR$(value), 2) + "M"
    CASE "T"
      prn.code$ = "&l" + MID$(STR$(value), 2) + "F"
    CASE ELSE
      prn.marg = FALSE
      cur.mg$ = ""
      cur.va = 0
      ERROR 13
  END SELECT
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + prn.code$
    prn.marg = TRUE
    cur.mg$ = cp$
    cur.va = value
  ELSE
    prn.marg = FALSE
    cur.mg$ = ""
    cur.va = 0
    ERROR 57
  END IF
END SUB

SUB HPNLQ
  SHARED printer.status, fprint%, prn.nlq
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "(s2Q";
    prn.nlq = TRUE
  ELSE
    prn.nlq = FALSE
    ERROR 57
  END IF
END SUB

SUB HPORIENTATION (o$)
  SHARED printer.status, fprint%, prn.land, prn.port
  CONST FALSE = 0, TRUE = NOT FALSE
  SELECT CASE LEFT$(UCASE$(o$), 1)
    CASE "L"
      IF printer.status THEN
        PRINT #fprint%, CHR$(27) + "&l1O";
        prn.land = TRUE
        prn.port = FALSE
      ELSE
        prn.land = FALSE
        prn.port = FALSE
        ERROR 57
      END IF
    CASE "P"
      IF printer.status THEN
        PRINT #fprint%, CHR$(27) + "&l0O";
        prn.land = FALSE
        prn.port = TRUE
      ELSE
        prn.land = FALSE
        prn.port = FALSE
        ERROR 57
      END IF
    CASE ELSE
      ERROR 13
  END SELECT
END SUB

SUB HPPAPER (p$)
  SHARED printer.status, fprint%, prn.paper, cur.pp$
  CONST FALSE = 0, TRUE = NOT FALSE
  SELECT CASE UCASE$(p$)
    CASE "STANDARD"
      prn.code$ = "&l0A"
    CASE "USA LETTER"
      prn.code$ = "&l2A"
    CASE "USA OFFICE"
      prn.code$ = "&l3A"
    CASE "USA EXECUTIVE"
      prn.code$ = "&l1A"
    CASE "A4"
      prn.code$ = "&l26A"
    CASE "ENVELOPE 10"
      prn.code$ = "&l81A"
    CASE "ENVELOPE DL"
      prn.code$ = "&l-90A"
    CASE ELSE
      prn.paper = FALSE
      cur.pa$ = ""
      ERROR 13
  END SELECT
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + prn.code$
    prn.paper = TRUE
    cur.pa$ = cp$
  ELSE
    prn.paper = FALSE
    cur.pa$ = ""
    ERROR 57
  END IF
END SUB

SUB HPPITCH (pitch)
  SHARED printer.status, fprint%, cur.pitch, prn.pitch
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "(s" + MID$(STR$(pitch), 2) + "H";
    prn.pitch = TRUE
    cur.pitch = pitch
  ELSE
    prn.pitch = FALSE
    ERROR 57
  END IF
END SUB

SUB HPPROP
  SHARED printer.status, fprint%, prn.prop
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "(s1P";
    prn.prop = TRUE
  ELSE
    prn.prop = FALSE
    ERROR 57
  END IF
END SUB

SUB HPRESET
  SHARED printer.status, fprint%, prn.reset
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "E";
    prn.reset = TRUE
  ELSE
    prn.reset = FALSE
    ERROR 57
  END IF
END SUB

SUB HPSIZE (l)
  SHARED printer.status, fprint%, prn.size, cur.size
  CONST FALSE = 0, TRUE = NOT FALSE
  IF printer.status THEN
    PRINT #fprint%, CHR$(27) + "&l" + MID$(STR$(l), 2) + "P";
    prn.size = TRUE
    cu.size = l
  ELSE
    prn.size = FALSE
    cu.size = 0
    ERROR 57
  END IF
END SUB

SUB HPSTYLE (s$)
  SHARED printer.status, fprint%, prn.ital, prn.norm
  CONST FALSE = 0, TRUE = NOT FALSE
  SELECT CASE LEFT$(UCASE$(s$), 1)
    CASE "I"
      IF printer.status THEN
        PRINT #fprint%, CHR$(27) + "(s1S";
        prn.ital = TRUE
        prn.norm = FALSE
      ELSE
        prn.ital = FALSE
        prn.norm = FALSE
        ERROR 57
      END IF
    CASE "N"
      IF printer.status THEN
        PRINT #fprint%, CHR$(27) + "(s0S";
        prn.ital = FALSE
        prn.norm = TRUE
      ELSE
        prn.ital = FALSE
        prn.norm = FALSE
        ERROR 57
      END IF
    CASE ELSE
      ERROR 13
  END SELECT
END SUB

FUNCTION IIF$ (condicao, valor1$, valor2$)
  IF condicao THEN
    IIF$ = valor1$
  ELSE
    IIF$ = valor2$
  END IF
END FUNCTION

SUB INSERE (filename$, vstring$, position)
  f1% = FREEFILE
  OPEN filename$ FOR INPUT AS #f1%
  f2% = FREEFILE
  t$ = TEMPFILE$
  OPEN t$ FOR OUTPUT AS #f2%
  DO UNTIL EOF(f1%)
    LINE INPUT #f1%, texto$
    PRINT #f2%, texto$
  LOOP
  CLOSE #f1%, #f2%
  f1% = FREEFILE
  OPEN t$ FOR INPUT AS #f1%
  f2% = FREEFILE
  OPEN filename$ FOR OUTPUT AS #f2%
  current.position% = 1
  DO UNTIL EOF(f1%)
    LINE INPUT #f1%, texto$
    PRINT #f2%, texto$
    current.position% = current.position% + 1
    IF current.position% = position THEN
      PRINT #f2%, vstring$
    END IF
  LOOP
  CLOSE #f1%, #f2%
  KILL t$
END SUB

FUNCTION INTERNAL.MEMORY
  INTERNAL.MEMORY = FRE(-1) + FRE(-2) + FRE(3)
END FUNCTION

FUNCTION INVERS# (valor)
  x = valor
  IF x = 0 THEN ERROR 5
  INVERS# = 1 / x
END FUNCTION

FUNCTION KEY.STATUS$
  SHARED break.key.flag, ctrl.c.key.flag, reset.key.flag
  bkf = ABS(break.key.flag)
  cckf = ABS(ctrl.c.key.flag)
  rkf = ABS(reset.key.flag)
  KEY.STATUS$ = LTRIM$(STR$(bkf)) + LTRIM$(STR$(cckf)) + LTRIM$(STR$(rkf))
END FUNCTION

FUNCTION LPT
  DEF SEG = &H40
  byte1 = PEEK(&H10)
  byte2 = PEEK(&H11)
  byte = (byte2 * 256) + byte1
  byte$ = ""
  DO
    byte = byte \ 2
    resto = byte MOD 2
    byte$ = LTRIM$(STR$(resto)) + byte$
    IF LEN(byte$) = 14 THEN EXIT DO
  LOOP
  byte$ = LTRIM$(STR$(byte \ 2)) + byte$
  impressora$ = MID$(byte$, 1, 2)
  SELECT CASE impressora$
    CASE "00"
      LPT = 0
    CASE "01"
      LPT = 1
    CASE "10"
      LPT = 2
    CASE "11"
      LPT = 3
  END SELECT
  DEF SEG
END FUNCTION

SUB MOVE (source$, target$)
  COPY source$, target$
  KILL source$
END SUB

FUNCTION MUL.BIN$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = BIN2DEC&(a1$)
  valor2! = BIN2DEC&(a2$)
  soma# = valor1! * valor2!
  adicao$ = DEC2BIN$(soma#)
  MUL.BIN$ = adicao$
END FUNCTION

FUNCTION MUL.HEX$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = HEX2DEC&(a1$)
  valor2! = HEX2DEC&(a2$)
  soma# = valor1! * valor2!
  adicao$ = DEC2HEX$(soma#)
  MUL.HEX$ = adicao$
END FUNCTION

FUNCTION MUL.OCT$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  va1! = OCT2DEC&(a1$)
  va2! = OCT2DEC&(a2$)
  soma# = va1! * va2!
  adicao$ = DEC2OCT$(soma#)
  MUL.OCT$ = adicao$
END FUNCTION

FUNCTION NEGATIVE (n)
  CONST FALSE = 0, TRUE = NOT FALSE
  IF n < 0 THEN NEGATIVE = TRUE
  IF n >= 0 THEN NEGATIVE = FALSE
END FUNCTION

FUNCTION NET.ERROR%
  SHARED NetWork.error%
  NET.ERROR% = NetWork.error%
END FUNCTION

FUNCTION NET.STATUS%
  SHARED NetWork.status%
  NET.STATUS% = NetWork.status%
END FUNCTION

FUNCTION NUMBER.MEMORY
  NUMBER.MEMORY = FRE(-1)
END FUNCTION

FUNCTION OCT2BIN$ (valor$)
  a$ = UCASE$(valor$)
  d# = OCT2DEC&(a$)
  b$ = DEC2BIN$(d#)
  OCT2BIN$ = b$
END FUNCTION

FUNCTION OCT2DEC& (valor$)
  total = 0
  a$ = UCASE$(valor$)
  IF a$ = "" THEN
    ERROR 5
    EXIT FUNCTION
  END IF
  sinal = 1
  IF LEFT$(a$, 1) = "-" THEN
    sinal = -1
    a$ = MID$(a$, 2, LEN(a$) - 1)
  END IF
  IF LEFT$(a$, 1) = "+" THEN
    sinal = 1
    a$ = MID$(a$, 2, LEN(a$) - 1)
  END IF
  IF LEN(a$) < 20 THEN a$ = STRING$(20 - LEN(a$), "0") + a$
  IF LEN(a$) > 20 THEN
    ERROR 6
    EXIT FUNCTION
  END IF
  FOR j = 1 TO LEN(a$)
    codigo.ASCII = ASC(MID$(a$, j, 1))
    IF codigo.ASCII < 48 OR codigo.ASCII > 55 THEN
      ERROR 13
      EXIT FUNCTION
    END IF
  NEXT
  expoente = 19
  FOR digito = 1 TO LEN(a$)
    valo$ = MID$(a$, digito, 1)
    valorB = VAL(valo$)
    total = total + (valorB * (8 ^ expoente))
    expoente = expoente - 1
  NEXT
  OCT2DEC& = sinal * total
END FUNCTION

FUNCTION OCT2HEX$ (valor$)
  a$ = UCASE$(valor$)
  d# = OCT2DEC&(a$)
  h$ = DEC2HEX$(d#)
  OCT2HEX$ = h$
END FUNCTION

FUNCTION OPEN.FILES
  ficheiro = FREEFILE
  OPEN.FILES = ficheiro - 1
END FUNCTION

SUB PAGE.JUMP (l)
  SHARED printer.status, fprint%
  IF printer.status THEN
    FOR position% = l TO 72
      PRINT #fprint%, ""
    NEXT
  ELSE
    ERROR 57
  END IF
END SUB

SUB PAGE.SET (lines)
  SHARED printer.status, size.set, fprint%
  IF ZERO(lines) THEN lines = 62
  IF NEGATIVE(lines) THEN ERROR 5
  IF printer.status THEN
    PRINT #fprint%, CHR$(27); CHR$(67); CHR$(lines);
    size.set = lines
  ELSE
    ERROR 57
  END IF
END SUB

FUNCTION PERCENT! (valor!)
  v! = valor!
  IF v! = 0 THEN ERROR 5
  PERCENT! = v! / 100
END FUNCTION

FUNCTION PI#
  PI# = 4 * ATN(1)
END FUNCTION

FUNCTION POSITIVE (n)
  CONST FALSE = 0, TRUE = NOT FALSE
  IF n > 0 THEN POSITIVE = TRUE
  IF n <= 0 THEN POSITIVE = FALSE
END FUNCTION

SUB PRINTER (port$, st)
  SHARED printer.status, fprint%
  CONST FALSE = 0, TRUE = NOT FALSE
  IF EMPTY(port$) THEN port$ = "LPT1:"
  port$ = UCASE$(port$)
  IF port$ <> "LPT1:" AND port$ <> "LPT2:" AND port$ <> "LPT3:" AND port$ <> "COM1:" AND port$ <> "COM2:" AND port$ <> "COM3:" AND port$ <> "COM4:" THEN ERROR 5
  fprint% = FREEFILE
  IF st THEN
    OPEN port$ FOR OUTPUT AS #fprint%
    printer.status = TRUE
  ELSE
    CLOSE #fprint%
    printer.status = FALSE
  END IF
END SUB

FUNCTION PRN.NUMBER%
  SHARED fprint%
  PRN.NUMBER% = fprint%
END FUNCTION

FUNCTION PRN.STATUS%
  SHARED printer.status
  PRN.STATUS% = printer.status
END FUNCTION

SUB REMOVE (filename$, vstring$)
  f1% = FREEFILE
  OPEN filename$ FOR INPUT AS #f1%
  f2% = FREEFILE
  t$ = TEMPFILE$
  OPEN t$ FOR OUTPUT AS #f2%
  DO UNTIL EOF(f1%)
    LINE INPUT #f1%, texto$
    PRINT #f2%, texto$
  LOOP
  CLOSE #f1%, #f2%
  f1% = FREEFILE
  OPEN t$ FOR INPUT AS #f1%
  f2% = FREEFILE
  OPEN filename$ FOR OUTPUT AS #f2%
  current.position% = 1
  DO UNTIL EOF(f1%)
    LINE INPUT #f1%, texto$
    IF ALLTRIM$(texto$) <> ALLTRIM$(vstring$) THEN
      PRINT #f2%, texto$
    END IF
  LOOP
  CLOSE #f1%, #f2%
  KILL t$
END SUB

SUB RESTORE.SCREEN (m$)
  SHARED temp.dir.1$, temp.dir.2$
  IF NOT EMPTY(temp.dir.1$) THEN temp.dir$ = temp.dir.1$ + "\"
  IF NOT EMPTY(temp.dir.2$) THEN temp.dir$ = temp.dir.2$ + "\"
  IF EMPTY(temp.dir.1$) AND EMPTY(temp.dir.2$) THEN temp.dir$ = "\"
  DEF SEG = &HB800
  BLOAD temp.dir$ + m$
  DEF SEG
  KILL temp.dir$ + m$
END SUB

SUB RESTORESCR (l1, c1, l2, c2, a$())
  FOR linha = l1 TO l2
    LOCATE linha, c1: PRINT a$(linha);
  NEXT
END SUB

FUNCTION RS232
  DEF SEG = &H40
  byte1 = PEEK(&H10)
  byte2 = PEEK(&H11)
  byte = (byte2 * 256) + byte1
  byte$ = ""
  DO
    byte = byte \ 2
    resto = byte MOD 2
    byte$ = LTRIM$(STR$(resto)) + byte$
    IF LEN(byte$) = 14 THEN EXIT DO
  LOOP
  byte$ = LTRIM$(STR$(byte \ 2)) + byte$
  serial$ = MID$(byte$, 5, 3)
  SELECT CASE serial$
    CASE "000"
      RS232 = 0
    CASE "001"
      RS232 = 1
    CASE "010"
      RS232 = 2
    CASE "011"
      RS232 = 3
    CASE "100"
      RS232 = 4
    CASE "101"
      RS232 = 5
    CASE "110"
      RS232 = 6
    CASE "111"
      RS232 = 7
  END SELECT
  DEF SEG
END FUNCTION

SUB SAVE.SCREEN (m$)
        DEF SEG = &HB800
        BSAVE m$, 0, 16384
  DEF SEG
END SUB

SUB SAVESCR (l1, c1, l2, c2, a$())
  FOR linha = l1 TO l2
    FOR coluna = c1 TO c2
      a$(linha) = a$(linha) + CHR$(SCREEN(linha, coluna))
    NEXT
  NEXT
END SUB

FUNCTION SECONDS2TIME$ (s)
  hora = s \ 3600
  IF hora > 24 THEN hora = 0
  minuto = (s MOD 3600) \ 60
  segundo = (s MOD 60)
  hora$ = STRING$(2 - LEN(MID$(STR$(hora), 2)), "0") + MID$(STR$(hora), 2)
  minuto$ = STRING$(2 - LEN(MID$(STR$(minuto), 2)), "0") + MID$(STR$(minuto), 2)
  segundo$ = STRING$(2 - LEN(MID$(STR$(segundo), 2)), "0") + MID$(STR$(segundo), 2)
  SECONDS2TIME$ = hora$ + ":" + minuto$ + ":" + segundo$
END FUNCTION

SUB SHOW (filename$, f1, b1, bd, f2, b2, f3, b3, frame$)
  COLOR f1, b1, bd: CLS
  OPEN filename$ FOR INPUT AS #1
  IF LOF(1) > 45000 THEN ERROR 5
  ln = 0
  DO UNTIL EOF(1)
    LINE INPUT #1, t$
    ln = ln + 1
  LOOP
  paginas = INT(ln / 22) + 1
  SEEK #1, 1
  DIM texto$(1 TO ln): DIM inicio(1 TO paginas): DIM fim(1 TO paginas)
  controlo = 1
  contador = 1
  FOR j = 1 TO ln
    LINE INPUT #1, texto$(j)
    IF j = 1 THEN inicio(controlo) = j
    contador = contador + 1
    IF contador = 23 THEN
      fim(controlo) = j
      contador = 1
      controlo = controlo + 1
      inicio(controlo) = j + 1
    END IF
  NEXT
  inicio(controlo) = ln - 22
  fim(controlo) = ln
  CLOSE
  LOCATE , , 0
  COLOR f3, b3
  BOX 1, 1, 25, 80, frame$
  p = 1
texto:
  l = 2
  COLOR f2, b2
  FOR linha = inicio(p) TO fim(p)
    LOCATE l, 2: PRINT MID$(texto$(linha), 1, 77);
    l = l + 1
  NEXT
tec:
  a$ = UCASE$(INKEY$)
  IF a$ = "" THEN GOTO tec
  IF a$ = CHR$(27) THEN EXIT SUB
  IF MID$(a$, 2) = "I" THEN
    p = p - 1
    IF p < 1 THEN
      p = 1
      IF whbp THEN BEEP
    END IF
    COLOR f1, b1
    CLW 2, 2, 24, 79
    GOTO texto
  END IF
  IF MID$(a$, 2) = "Q" THEN
    p = p + 1
    IF p > paginas THEN
      p = paginas
      IF whbp THEN BEEP
    END IF
    COLOR f1, b1
    CLW 2, 2, 24, 79
    GOTO texto
  END IF
  IF MID$(a$, 2) = "G" THEN
    p = 1
    COLOR f1, b1
    CLW 2, 2, 24, 79
    GOTO texto
  END IF
  IF MID$(a$, 2) = "O" THEN
    p = paginas
    COLOR f1, b1
    CLW 2, 2, 24, 79
    GOTO texto
  END IF
  GOTO tec
END SUB

FUNCTION SQUARE& (valor)
  a = valor
  SQUARE& = a ^ 2
END FUNCTION

FUNCTION STACK
  STACK = FRE(-2)
END FUNCTION

FUNCTION STRING.MEMORY
  STRING.MEMORY = FRE(3)
END FUNCTION

FUNCTION SUB.BIN$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = BIN2DEC&(a1$)
  valor2! = BIN2DEC&(a2$)
  soma# = valor1! - valor2!
  adicao$ = DEC2BIN$(soma#)
  SUB.BIN$ = adicao$
END FUNCTION

FUNCTION SUB.HEX$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  valor1! = HEX2DEC&(a1$)
  valor2! = HEX2DEC&(a2$)
  soma# = valor1! - valor2!
  adicao$ = DEC2HEX$(soma#)
  SUB.HEX$ = adicao$
END FUNCTION

FUNCTION SUB.OCT$ (valor1$, valor2$)
  a1$ = valor1$
  a2$ = valor2$
  va1! = OCT2DEC&(a1$)
  va2! = OCT2DEC&(a2$)
  soma# = va1! - va2!
  adicao$ = DEC2OCT$(soma#)
  SUB.OCT$ = adicao$
END FUNCTION

FUNCTION TEMPFILE$
  d1 = RND * 10
  d2 = RND * 20
  d3 = RND * 30
  d4 = RND * 40
  d1$ = HEX$(d1)
  d2$ = HEX$(d2)
  d3$ = HEX$(d3)
  d4$ = HEX$(d4)
  d1$ = ALOCATE$(d1$, "0", "L", 2)
  d2$ = ALOCATE$(d2$, "0", "L", 2)
  d3$ = ALOCATE$(d3$, "0", "L", 2)
  d4$ = ALOCATE$(d4$, "0", "L", 2)
  TEMPFILE$ = d1$ + d2$ + d3$ + d4$ + "."
END FUNCTION

FUNCTION TEN# (expoente%)
  EX = expoente%
  TEN# = 10 ^ EX
END FUNCTION

SUB TEXT.BOX (l, c, texto$(), f1, b1, f2, b2, items, centro)
  FOR j = 1 TO items
    IF LEN(texto$(j)) MOD 2 <> 0 THEN
      texto$(j) = texto$(j) + " "
    END IF
  NEXT
  FOR j = 1 TO items
    FOR k = items TO 2 STEP -1
      IF LEN(texto$(k)) > LEN(texto$(j)) THEN
        size = LEN(texto$(k))
        mk = k
      END IF
    NEXT
  NEXT
  FOR j = 1 TO items
    v = LEN(texto$(j))
    IF j <> mk THEN
      texto$(j) = STRING$((size - v) \ 2, " ") + texto$(j) + STRING$((size - v) \ 2, " ")
    END IF
  NEXT
  IF centro THEN
    c = 40 - LEN(texto$(1)) \ 2
  END IF
  COLOR f1, b1: BOX l, c - 1, l + items + 1, c + LEN(texto$(1)), "D"
  FOR j = 1 TO items
    COLOR f2, b2: LOCATE l + j, c: PRINT texto$(j)
  NEXT
END SUB

FUNCTION TIME2SECONDS (t$)
  hora = VAL(MID$(t$, 1, 2))
  minuto = VAL(MID$(t$, 4, 2))
  segundo = VAL(MID$(t$, 7, 2))
  TIME2SECONDS = (hora * 3600) + (minuto * 60) + segundo
END FUNCTION

SUB UPDATE.PATH (autoexec.file$, directory$)
  vpth$ = ENVIRON$("PATH")
  IF RIGHT$(vpth$, 1) = ";" THEN vpth$ = MID$(vpth$, 1, LEN(vpth$) - 1)
  vpth$ = vpth$ + ";" + directory$
  f1% = FREEFILE
  t$ = TEMPFILE$
  OPEN autoexec.file$ FOR INPUT AS #f1%
  f2% = FREEFILE
  OPEN t$ FOR OUTPUT AS #f2%
  DO UNTIL EOF(f1%)
    LINE INPUT #f1%, texto$
    PRINT #f2%, texto$
  LOOP
  CLOSE #f1%, #f2%
  f1% = FREEFILE
  OPEN t$ FOR INPUT AS #f1%
  f2% = FREEFILE
  OPEN autoexec.file$ FOR OUTPUT AS #f2%
  DO UNTIL EOF(f1%)
    LINE INPUT #f1%, texto$
    IF UCASE$(LEFT$(texto$, 4)) = "PATH" THEN
      PRINT #f2%, vpth$
    ELSE
      PRINT #f2%, texto$
    END IF
  LOOP
  CLOSE #f1%, #f2%
  KILL t$
END SUB

FUNCTION VIRG$ (valor#, casas)
  v$ = MID$(STR$(valor#), 2)
  IF INSTR(v$, ".") <> 0 THEN
    deci$ = MID$(v$, INSTR(v$, "."), LEN(v$))
    v$ = MID$(v$, 1, INSTR(v$, ".") - 1)
    ponto = -1
  END IF
  FOR j = LEN(v$) TO 1 STEP -1
    m$ = MID$(v$, j, 1) + m$
    v = v + 1
    IF v = casas THEN m$ = "," + m$: v = 0
  NEXT
  IF LEFT$(m$, 1) = "," THEN m$ = MID$(m$, 2, LEN(m$))
  IF ponto THEN m$ = m$ + deci$
  VIRG$ = m$
END FUNCTION

SUB VMENU (c, opcoes$(), linhas(), f1, b1, f2, b2, f3, b3, frame$, msg$(), lm, cm, f4, b4, items)
  SHARED key.option
  IF msg$ <> "" THEN
    IF lm < 1 OR lm > 25 OR cm < 1 OR cm > 80 THEN ERROR 5
  END IF
  l1 = linhas(1) - 1
  l2 = linhas(UBOUND(linhas)) + 1
  c2 = c + LEN(opcoes$(UBOUND(opcoes$)))
  COLOR f3, b3: BOX l1, c - 1, l2, c2, frame$
  FOR j = 1 TO items
    COLOR f1, b1
    LOCATE linhas(j), c: PRINT opcoes$(j)
  NEXT
  posicao = 1
  GOSUB poe.barrav
v.key:
  v.key.stroke$ = UCASE$(INKEY$)
  IF v.key.stroke$ = "" THEN GOTO v.key
  IF v.key.stroke$ = CHR$(27) THEN key.option = 0: COLOR 7, 0: EXIT SUB
  IF v.key.stroke$ = CHR$(13) THEN
    key.option = posicao
    COLOR 7, 0
    EXIT SUB
  END IF
  v.key.stroke$ = MID$(v.key.stroke$, 2)
  IF v.key.stroke$ = "H" THEN
    posicao = posicao - 1
    IF posicao < 1 THEN posicao = 1
    GOSUB poe.barrav
    GOTO v.key
  END IF
  IF v.key.stroke$ = "P" THEN
    posicao = posicao + 1
    IF posicao > items THEN posicao = items
    GOSUB poe.barrav
    GOTO v.key
  END IF
  BEEP
  GOTO v.key

poe.barrav:
  prev = posicao - 1
  afte = posicao + 1
  IF prev < 1 THEN prev = 1
  IF afte > items THEN afte = items
  COLOR f1, b1
  LOCATE linhas(prev), c: PRINT opcoes$(prev)
  LOCATE linhas(afte), c: PRINT opcoes$(afte)
  COLOR f2, b2
  LOCATE linhas(posicao), c: PRINT opcoes$(posicao)
  IF msg$(posicao) <> "" THEN
    COLOR f4, b4
    LOCATE lm, cm: PRINT msg$(posicao)
  END IF
  COLOR f1, b1
  RETURN
END SUB

FUNCTION ZERO (n)
  CONST FALSE = 0, TRUE = NOT FALSE
  IF n = 0 THEN ZERO = TRUE
  IF n <> 0 THEN ZERO = FALSE
END FUNCTION

