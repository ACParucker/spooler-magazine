'⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
'≥                       QUICK BASIC IV - SUMÜRIO                            ≥
'√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
'≥ Software................: VOLUME MAKER                                    ≥
'≥ M¢dulo,Execut†vel.......: VOLUME.BAS,VOLUME.EXE                           ≥
'≥ VersÑo (Idioma).........: 1.2 (P) - VersÑo Especial Spooler               ≥
'≥ Cliente.................: -                                               ≥
'≥ Autor...................: NÇlio Abreu                                     ≥
'≥ Copyright...............: 1993                                            ≥
'≥ Data de criaáÑo,rev.....: 21/04/93,08/10/94                               ≥
'≥ Finalidade do m¢dulo....: Criar volumes em ZIP sub-divididos em blocos    ≥
'≥ Finalidade software.....: Criar volumes em ZIP sub-divididos em blocos    ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥ M¢dulos constituintes...: VOLUME.BAS                                      ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥ Ficheiros constituintes.: -                                               ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥ Ambiente................: Mono/Multi - HER, CGA, EGA, VGA, XGA, MCGA, Poli≥
'≥ Sistema.................: MS/PC/DR-DOS VersÑo 2 ou superior               ≥
'¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

'Inicializa funcîes para converÑo de tempo
DECLARE SUB AJUDA ()
DECLARE SUB BARRA (f&, t&, linha, coluna)
DECLARE SUB PERCENTO (feito&, total&, linha, coluna)
DECLARE FUNCTION TIME2SECONDS& (t$)
DECLARE FUNCTION SECONDS2TIME$ (s&)
DECLARE FUNCTION RET.NAM$ (f$)

versao$ = "1.2"
rev$ = "08/10/94"
copy$ = "1993,94"
t1$ = "(c) NÇlio Abreu - 21/04/93 - " + copy$ + " - VersÑo " + versao$ + " - Rev. " + rev$
t2$ = "VersÑo Especial Spooler - Desenvolvido em Quick BASIC 4.50"
t3$ = "VOLUME activo durante "

'Arranque
LOCATE , , 1, 11, 12
PRINT "VOLUME - "; t1$
PRINT t2$
PRINT
SHELL "IF EXIST *.ZIP ECHO WARNING!! >VOLUME.MSG"

OPEN "VOLUME.MSG" FOR BINARY AS #1
IF LOF(1) <> 0 THEN
  COLOR 28: PRINT "AVISO!!!"; : COLOR 12: PRINT " EXISTEM FICHEIROS DO TIPO ZIP NO DIRECTüRIO CORRENTE!"
  PRINT "         POR FAVOR COLOQUE-OS EM LUGAR SEGURO E  REMOVA-OS  DO"
  PRINT "         REFERIDO DIRECTüRIO AFIM DE EVITAR  RETARDAMENTOS  NA"
  PRINT "         CRIAÄéO DOS VOLUMES, POIS O PKZIP (TM)  NéO  CONSEGUE"
  PRINT "         COMPRIMIR ÆZIP'sØ, E POR TAL IRÜ ÆPERDERØ IMENSO TEM-"
  PRINT "         PO NA ANALISE DOS REFERIDOS."
  COLOR 7
  CLOSE
  PRINT "Deseja apag†-los (A), outra tecla termina ";
  DO
    tecla$ = UCASE$(INKEY$)
    IF tecla$ <> "" THEN EXIT DO
  LOOP
  PRINT
  IF tecla$ = "A" THEN KILL "*.ZIP": KILL "VOLUME.MSG": GOTO ok
  CLOSE
  KILL "VOLUME.MSG"
  END
ELSE
  CLOSE
  KILL "VOLUME.MSG"
END IF
ok:
volume$ = COMMAND$
IF volume$ = "" THEN
  PRINT "Sintaxe:"
  PRINT "         VOLUME nome ≥[/H]≥[/V]"
  PRINT
  PRINT "                nome - nome do volume com o m†ximo de 6 caracteres"
  PRINT "                  /H - Exibe a ajuda"
  PRINT "                  /V - Alteraáîes nesta versÑo"
  END
END IF
IF volume$ = "/H" THEN AJUDA: END
volume$ = MID$(volume$, 1, 6)
IF volume$ = "/V" THEN
  PRINT "Alteraáîes verificadas nesta Rev:"
  PRINT
  PRINT "            * CorrecáÑo de alguns Bugs"
  PRINT "            * ModificaáÑo do ÆvisualØ"
  PRINT "            * Indicador do tempo gasto na compressÑo dos arquivos"
  PRINT "            * Estimativa quanto ao nß de volumes a criar e ao tempo"
  PRINT "            * Possibilidade de criar auto-descompactaveis"
  PRINT "            * Indicador do tempo gasto na criaáÑo do VOLUME"
  PRINT
  END
END IF
PRINT "Volumes a serem criados : "; volume$ + "nn.ZIP"
LOCATE , , 1, 10, 11
PRINT "Lendo o direct¢rio....";
SHELL "DIR >VOLUME.LST"
PRINT
INPUT "Limite do volume (em Kbytes, 0/ENTER termina) ", limite
IF limite = 0 THEN PRINT "VOLUME terminado pelo utilizador": END
DIM ordena$(7)
ordena$(7) = "  NENHUMA"
ordena$(1) = " NOME-DSC"
ordena$(2) = " NOME-ASC"
ordena$(3) = " EXT.-DSC"
ordena$(4) = " EXT.-ASC"
ordena$(5) = "TAMN.-DSC"
ordena$(6) = "TAMN.-ASC"
PRINT "Tipo de ordenaáÑo:"
PRINT "                   1 = Nome - Sentido descendente"
PRINT "                   2 = Nome - Sentido ascendente"
PRINT "                   3 = ExtensÑo - Sentido descendente"
PRINT "                   4 = ExtensÑo - Sentido ascendente"
PRINT "                   5 = Tamanho - Sentido descendente"
PRINT "                   6 = Tamanho - Sentido ascendente"
PRINT "                   7 = Nenhuma"
PRINT "                  <Ÿ = Termina"
PRINT "1 a 7 => [ ]";
linha = CSRLIN
coluna = POS(x) - 2
LOCATE linha, coluna: INPUT "", ord$
ord = VAL(ord$)
IF ord = 0 THEN END
PRINT "Criar auto-descompactaveis (S/N) ? [N]";
linha = CSRLIN
coluna = POS(x) - 2
LOCATE linha, coluna: INPUT "", r$
r$ = MID$(UCASE$(r$), 1, 1)
IF r$ = "S" THEN auto = -1 ELSE auto = 0
PRINT "Pedir confirmaáÑo na criaáÑo dos auto-descompactaveis (S/N) ? [N]";
linha = CSRLIN
coluna = POS(x) - 2
LOCATE linha, coluna: INPUT "", r$
r$ = MID$(UCASE$(r$), 1, 1)
IF r$ = "S" THEN confir = -1 ELSE confir = 0
PRINT "Preparando ficheiros....";
OPEN "VOLUME.LST" FOR INPUT AS #1
item = 1
DO UNTIL EOF(1)
  LINE INPUT #1, t$
  IF t$ <> "" THEN IF ASC(LEFT$(t$, 1)) > 46 AND MID$(t$, 14, 5) <> "<DIR>" THEN item = item + 1
LOOP
item = item - 1
limite = limite * 1024
SEEK #1, 1
DIM nomes$(1 TO item), ext$(1 TO item), bytes(1 TO item), ficheiro$(1 TO item)
d = 1
DO UNTIL EOF(1)
  LINE INPUT #1, t$
  IF t$ <> "" THEN
    IF ASC(LEFT$(t$, 1)) > 46 AND MID$(t$, 14, 5) <> "<DIR>" THEN
      IF RTRIM$(MID$(t$, 1, 12)) <> "VOLUME   LST" THEN
        nomes$(d) = RTRIM$(MID$(t$, 1, INSTR(t$, " ")))
        ext$(d) = MID$(t$, 10, 3)
        bytes$ = MID$(t$, 20, 7)
        IF INSTR(bytes$, ".") <> 0 THEN
          bytes$ = MID$(bytes$, 1, INSTR(bytes$, ".") - 1) + MID$(bytes$, INSTR(bytes$, ".") + 1)
        END IF
        bytes(d) = VAL(bytes$)
        total.de.bytes& = total.de.bytes& + bytes(d)
        ficheiro$(d) = nomes$(d) + "." + ext$(d)
        d = d + 1
      END IF
    END IF
  END IF
LOOP
CLOSE
KILL "VOLUME.LST"
l = 1
d = d - 1
IF ord$ = "1" THEN
  PRINT
  PRINT "Aguarde....ordenando ficheiros por ordem alfabÇtica descendente....";
  linha = CSRLIN
  coluna = POS(x)
  feito = 0
  per% = 0
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR j = 1 TO d
    WRITE #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  DIM fich$(1 TO d), by(1 TO d)
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR k = 1 TO d
    FOR m = 1 TO d
      IF fich$(k) > fich$(m) THEN
        SWAP fich$(k), fich$(m)
        SWAP by(k), by(m)
      END IF
    NEXT
    feito = feito + 1
    d& = d
    feito& = feito
    PERCENTO feito&, d&, linha, coluna
  NEXT
  FOR j = 1 TO d
    WRITE #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
END IF
IF ord$ = "2" THEN
  PRINT
  PRINT "Aguarde....ordenando ficheiros por ordem alfabÇtica ascendente....";
  linha = CSRLIN
  coluna = POS(x)
  feito = 0
  per% = 0
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR j = 1 TO d
    WRITE #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  DIM fich$(1 TO d), by(1 TO d)
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR k = 1 TO d
    FOR m = 1 TO d
      IF fich$(k) < fich$(m) THEN
        SWAP fich$(k), fich$(m)
        SWAP by(k), by(m)
      END IF
    NEXT
    feito = feito + 1
    d& = d
    feito& = feito
    PERCENTO feito&, d&, linha, coluna
  NEXT
  FOR j = 1 TO d
    WRITE #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
END IF
IF ord$ = "5" THEN
  PRINT
  PRINT "Aguarde....ordenando ficheiros por ordem de tamanho descendente....";
  linha = CSRLIN
  coluna = POS(x)
  feito = 0
  per% = 0
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR j = 1 TO d
    WRITE #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  DIM fich$(1 TO d), by(1 TO d)
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR k = 1 TO d
    FOR m = 1 TO d
      IF by(k) > by(m) THEN
        SWAP fich$(k), fich$(m)
        SWAP by(k), by(m)
      END IF
    NEXT
    feito = feito + 1
    d& = d
    feito& = feito
    PERCENTO feito&, d&, linha, coluna
  NEXT
  FOR j = 1 TO d
    WRITE #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
END IF
IF ord$ = "6" THEN
  PRINT
  PRINT "Aguarde....ordenando ficheiros por ordem de tamanho ascendente....";
  linha = CSRLIN
  coluna = POS(x)
  feito = 0
  per% = 0
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR j = 1 TO d
    WRITE #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  DIM fich$(1 TO d), by(1 TO d)
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR k = 1 TO d
    FOR m = 1 TO d
      IF by(k) < by(m) THEN
        SWAP fich$(k), fich$(m)
        SWAP by(k), by(m)
      END IF
    NEXT
    feito = feito + 1
    d& = d
    feito& = feito
    PERCENTO feito&, d&, linha, coluna
  NEXT
  FOR j = 1 TO d
    WRITE #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
END IF
IF ord$ = "3" THEN
  PRINT
  PRINT "Aguarde....ordenando ficheiros por ordem extensÑo descendente....";
  linha = CSRLIN
  coluna = POS(x)
  feito = 0
  per% = 0
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR j = 1 TO d
    WRITE #1, ficheiro$(j), ext$(j), bytes(j)
  NEXT
  CLOSE
  DIM fich$(1 TO d), ex$(1 TO d), by(1 TO d)
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, fich$(j), ex$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR k = 1 TO d
    FOR m = 1 TO d
      IF ex$(k) > ex$(m) THEN
        SWAP fich$(k), fich$(m)
        SWAP by(k), by(m)
      END IF
    NEXT
    feito = feito + 1
    feito& = feito
    d& = d
    PERCENTO feito&, d&, linha, coluna
  NEXT
  FOR j = 1 TO d
    WRITE #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
END IF
IF ord$ = "4" THEN
  PRINT
  PRINT "Aguarde....ordenando ficheiros por ordem extensÑo ascendente....";
  linha = CSRLIN
  coluna = POS(x)
  feito = 0
  per% = 0
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR j = 1 TO d
    WRITE #1, ficheiro$(j), ext$(j), bytes(j)
  NEXT
  CLOSE
  DIM fich$(1 TO d), ex$(1 TO d), by(1 TO d)
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, fich$(j), ex$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
  FOR k = 1 TO d
    FOR m = 1 TO d
      IF ex$(k) < ex$(m) THEN
        SWAP fich$(k), fich$(m)
        SWAP by(k), by(m)
      END IF
    NEXT
    feito = feito + 1
    feito& = feito
    d& = d
    PERCENTO feito&, d&, linha, coluna
  NEXT
  FOR j = 1 TO d
    WRITE #1, fich$(j), by(j)
  NEXT
  CLOSE
  OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
  FOR j = 1 TO d
    INPUT #1, ficheiro$(j), bytes(j)
  NEXT
  CLOSE
  KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
END IF
PRINT
PRINT "Aguarde....Determinando o tempo estimativo .....";
linha = CSRLIN
coluna = POS(x)
OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
FOR j = 1 TO d
  WRITE #1, ficheiro$(j), bytes(j)
NEXT
CLOSE
DIM fichtmp$(1 TO d), bytmp(1 TO d)
OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
FOR j = 1 TO d
  INPUT #1, fichtmp$(j), bytmp(j)
NEXT
CLOSE
OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR OUTPUT AS #1
FOR k = 1 TO d
  FOR m = 1 TO d
    IF bytmp(k) > bytmp(m) THEN
      SWAP fichtmp$(k), fichtmp$(m)
      SWAP bytmp(k), bytmp(m)
    END IF
  NEXT
NEXT
FOR j = 1 TO d
  WRITE #1, fichtmp$(j), bytmp(j)
NEXT
CLOSE
OPEN ENVIRON$("TEMP") + "\$$$$$$$$.$$$" FOR INPUT AS #1
l = 0
INPUT #1, f$, b
CLOSE
KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
LOCATE linha, coluna
tempo.in.do.zip& = TIME2SECONDS&(TIME$)
SHELL "PKZIP -a -ex " + ENVIRON$("TEMP") + "\$$$$$$$$.$$$ " + f$ + ">NUL:"
tempo.ou.do.zip& = TIME2SECONDS&(TIME$)
tempo.zip& = tempo.ou.do.zip& - tempo.in.do.zip&
estima& = tempo.zip&
KILL ENVIRON$("TEMP") + "\$$$$$$$$.$$$"
vol = 1
feito = 0
l = CSRLIN
COLOR 7, 1, 1: CLS
COLOR 14, 3
FOR j = 1 TO 5: LOCATE j, 1: PRINT SPACE$(80): NEXT
LOCATE 1, 1: PRINT CHR$(201) + STRING$(78, CHR$(205)) + CHR$(187)
FOR j = 2 TO 4
  LOCATE j, 1: PRINT CHR$(186)
  LOCATE j, 80: PRINT CHR$(186)
NEXT
LOCATE 5, 1: PRINT CHR$(200) + STRING$(78, CHR$(205)) + CHR$(188)
COLOR 4, 3
FOR j = 9 TO 15: LOCATE j, 1: PRINT SPACE$(80); : NEXT
LOCATE 6, 1: PRINT CHR$(201) + STRING$(78, CHR$(205)) + CHR$(187);
FOR j = 7 TO 22
  LOCATE j, 1: PRINT CHR$(186);
  LOCATE j, 80: PRINT CHR$(186);
NEXT
LOCATE 23, 1: PRINT CHR$(200) + STRING$(78, CHR$(205)) + CHR$(188);
LOCATE 7, 2: PRINT "Volume a ser processado .............................................."
LOCATE 8, 2: PRINT "Arquivo sendo compactado ........................................."
LOCATE 9, 2: PRINT "Tamanho do arquivo sendo compactado .............................."
LOCATE 10, 2: PRINT "Tamanho actual do ZIP ............................................"
LOCATE 11, 2: PRINT "Limite imposto pelo operador ....................................."
LOCATE 12, 2: PRINT "Volumes j† criados ........................................................"
LOCATE 13, 2: PRINT "Total de volumes previstos (Ò) ............................................"
LOCATE 14, 2: PRINT "Tempo estimativo para criaáÑo dos volumes (Ò)........................."
LOCATE 15, 2: PRINT "Tipo de ordenaáÑo ...................................................."
LOCATE 16, 2: PRINT "Tempo actual / Tempo activo.................................."
LOCATE 17, 2: PRINT "Tempo gasto na compactaáÑo do £ltimo arquivo.........................."
LOCATE 18, 2: PRINT "Percentagem em volumes (%) ................................................"
LOCATE 19, 2: PRINT "Percentagem em bytes (%) .................................................."
LOCATE 20, 2: PRINT "Percentagem em ficheiros (%) .............................................."
LOCATE 21, 2: PRINT "Totais de - Ficheiros/Bytes a compactar .........................."
LOCATE 22, 2: PRINT "Totais de - Ficheiros/Bytes j† compactados ......................."
COLOR 14, 4
LOCATE 24, 1: PRINT SPACE$(80);
msg$ = " Para abortar o VOLUME, pressione a tecla ÆESCØ "
LOCATE 24, 40 - LEN(msg$) \ 2: PRINT msg$;

titulo$ = " * * * VOLUME - EXTENSOR DE COMPACTAÄéO * * * "
COLOR 12, 3: LOCATE 2, 40 - LEN(titulo$) \ 2: PRINT titulo$
titulo$ = t1$
COLOR 11, 3: LOCATE 3, 40 - LEN(titulo$) \ 2: PRINT titulo$
titulo$ = " VersÑo Especial Spooler "
COLOR 10, 3: LOCATE 4, 40 - LEN(titulo$) \ 2: PRINT titulo$
name.size = LEN(volume$)
arranque& = TIME2SECONDS&(TIME$)
starting.time$ = TIME$
vol$ = STRING$((8 - name.size) - LEN(MID$(STR$(vol), 2)), "0") + MID$(STR$(vol), 2)
tot.by& = total.de.bytes& / 2
tot.vol = INT(tot.by& / limite) + 1
OPEN volume$ + vol$ + ".DAT" FOR OUTPUT AS #1
PRINT #1, USING "Volume ## - InformaáÑo comprimida em ZIP"; vol
PRINT #1, USING "Volume criado a \        \ Ös \      \"; DATE$; starting.time$
PRINT #1, USING "CompressÑo iniciada Ös \      \"; starting.time$
PRINT #1, ""
CLOSE
FOR j = 1 TO d
  est.tim$ = SECONDS2TIME$(estima& * d)
  vol$ = STRING$((8 - name.size) - LEN(MID$(STR$(vol), 2)), "0") + MID$(STR$(vol), 2)
  COLOR 4, 3: LOCATE 7, 68: PRINT USING "\          \"; volume$ + vol$ + ".ZIP"
  COLOR 4, 3: LOCATE 8, 68: PRINT USING "\          \"; RET.NAM$(RTRIM$(nomes$(j)) + "." + ext$(j))
  COLOR 4, 3: LOCATE 9, 70: PRINT USING "##,###,###"; bytes(j)
  COLOR 4, 3: LOCATE 9, 50: PRINT USING "(##,###K)"; bytes(j) / 1024
  COLOR 4, 3: LOCATE 10, 70: PRINT USING "##,###,###"; size
  COLOR 4, 3: LOCATE 10, 50: PRINT USING "(##,###K)"; size / 1024
  COLOR 4, 3: LOCATE 11, 70: PRINT USING "##,###,###"; limite
  COLOR 4, 3: LOCATE 11, 50: PRINT USING "(##,###K)"; limite / 1024
  COLOR 4, 3: LOCATE 12, 77: PRINT USING "###"; vol - 1
  COLOR 4, 3: LOCATE 13, 77: PRINT USING "###"; tot.vol
  COLOR 4, 3: LOCATE 14, 72: PRINT USING "\      \"; est.tim$
  COLOR 4, 3: LOCATE 15, 71: PRINT USING "\       \"; ordena$(ord)
  act& = TIME2SECONDS&(TIME$)
  activo& = act& - arranque&
  act$ = SECONDS2TIME$(activo&)
  COLOR 4, 3: LOCATE 16, 61: PRINT USING "\      \ / \      \"; TIME$; act$
  tv& = tot.vol
  v& = vol - 1
  COLOR 4, 3: PERCENTO v&, tv&, 18, 76
  COLOR 4, 3: PERCENTO bytes.in&, total.de.bytes&, 19, 76
  feito2& = feito
  d2& = d
  COLOR 4, 3: PERCENTO feito2&, d2&, 20, 76
  COLOR 4, 3: LOCATE 21, 64: PRINT USING "#,###/##,###,###"; d; total.de.bytes&
  COLOR 4, 3: LOCATE 21, 50: PRINT USING "(##,###K)"; total.de.bytes& / 1024
  COLOR 4, 3: LOCATE 22, 64: PRINT USING "#,###/##,###,###"; fd; bytes.in&
  COLOR 4, 3: LOCATE 22, 50: PRINT USING "(##,###K)"; bytes.in& / 1024
  BARRA bytes.in&, total.de.bytes&, 19, 40
  feit& = feito
  di& = d
  BARRA feit&, di&, 20, 40
  feit& = vol - 1
  di& = tot.vol
  BARRA feit&, di&, 18, 40
  hora.actual& = TIME2SECONDS&(TIME$)
  tempo.gasto& = hora.gasta& - hora.actual&
  IF hora.gasta& = 0 THEN tempo.gasto& = 0
  COLOR 4, 3: LOCATE 17, 72: PRINT SECONDS2TIME$(tempo.zip&)
  IF INKEY$ = CHR$(27) THEN
    DO
      COLOR 14, 4
      LOCATE 24, 1: PRINT SPACE$(80);
      LOCATE 24, 5: COLOR 30, 4: PRINT " IMPORTANTE! "; : COLOR 14, 4: PRINT " Cancelando agora ir† destruir o volume activo:" + volume$ + vol$ + ".ZIP ";
      COLOR 14, 4
      LOCATE 25, 1: PRINT SPACE$(80);
      pergunta$ = " Parar agora (S/N) ? "
      LOCATE 25, 40 - LEN(pergunta$) \ 2: PRINT pergunta$;
      LOCATE , , 1, 11, 12
      DO
        tecla$ = UCASE$(INKEY$)
        IF tecla$ <> "" THEN EXIT DO
      LOOP
      PRINT tecla$;
      IF tecla$ = "S" THEN
        COLOR 7, 0, 0: CLS
        OPEN volume$ + vol$ + ".ZIP" FOR OUTPUT AS #1: CLOSE
        OPEN volume$ + vol$ + ".DAT" FOR OUTPUT AS #1: CLOSE
        KILL volume$ + vol$ + ".ZIP"
        KILL volume$ + vol$ + ".DAT"
        COLOR 14, 1:
        LOCATE 1, 1: PRINT SPACE$(80);
        LOCATE 2, 1: PRINT SPACE$(80);
        LOCATE 3, 1: PRINT SPACE$(80);
        LOCATE 1, 1
        termino& = TIME2SECONDS&(TIME$)
        ter& = termino& - arranque&
        ter$ = SECONDS2TIME$(ter&)
        PRINT "VOLUME - "; t1$
        PRINT t2$
        PRINT t3$ + ter$
        COLOR 7, 0
        PRINT
        END
      END IF
      IF tecla$ = "N" THEN
        COLOR 14, 4
        LOCATE 24, 1, 0, 11, 11: PRINT SPACE$(80);
        msg$ = " Para abortar o VOLUME, pressione a tecla ÆESCØ "
        LOCATE 24, 40 - LEN(msg$) \ 2: PRINT msg$
        COLOR 7, 1
        LOCATE 25, 1: PRINT SPACE$(80);
        EXIT DO
      END IF
    LOOP
  END IF
  LOCATE 1, 1, 0, 11, 11
  tempo.in.do.zip& = TIME2SECONDS&(TIME$)
  SHELL "PKZIP -a -ex " + volume$ + vol$ + " " + RTRIM$(nomes$(j)) + "." + ext$(j) + " >NUL:"
  bytes.in& = bytes.in& + bytes(j)
  fd = fd + 1
  tempo.ou.do.zip& = TIME2SECONDS&(TIME$)
  tempo.zip& = tempo.ou.do.zip& - tempo.in.do.zip&
  OPEN volume$ + vol$ + ".ZIP" FOR BINARY AS #1: size = LOF(1): CLOSE
  perf% = (feito * 100) / d
  perb% = (bytes.in& * 100) / total.de.bytes&
  IF size > limite THEN
    ending.time$ = TIME$
    segundos.finais& = TIME2SECONDS&(ending.time$)
    segundos.iniciais& = TIME2SECONDS&(starting.time$)
    segundos.gastos& = segundos.finais& - segundos.iniciais&
    gasto$ = SECONDS2TIME$(segundos.gastos&)
    OPEN volume$ + vol$ + ".DAT" FOR APPEND AS #1
    PRINT #1, USING "#### ficheiros guardados totalizando ##,###,### bytes"; feito; total
    PRINT #1, USING "CompressÑo terminada Ös \      \"; ending.time$
    PRINT #1, USING "Tempo gasto no processo: \      \"; gasto$
    CLOSE
    OPEN volume$ + vol$ + ".ZIP" FOR BINARY AS #1: size = LOF(1): CLOSE
    vol = vol + 1
    starting.time$ = TIME$
    vol$ = STRING$((8 - name.size) - LEN(MID$(STR$(vol), 2)), "0") + MID$(STR$(vol), 2)
    OPEN volume$ + vol$ + ".DAT" FOR OUTPUT AS #1
    PRINT #1, USING "Volume ## - InformaáÑo comprimida em ZIP"; vol
    PRINT #1, USING "Volume criado a \        \ Ös \      \"; DATE$; starting.time$
    PRINT #1, USING "CompressÑo iniciada Ös \      \"; starting.time$
    PRINT #1, ""
    CLOSE
    hora.gasta& = TIME2SECONDS&(TIME$)
    total& = 0
  ELSE
    total& = total& + bytes(j)
    OPEN volume$ + vol$ + ".DAT" FOR APPEND AS #2
    PRINT #2, USING "Guardado \          \ com ###,### bytes (#### ficheiros de ####)"; nomes$(j) + "." + ext$(j); bytes(j); feito; d
    CLOSE
  END IF
  feito = feito + 1
NEXT
CLOSE
j = d
COLOR 4, 3: LOCATE 7, 68: PRINT USING "\          \"; volume$ + vol$ + ".ZIP"
COLOR 4, 3: LOCATE 8, 68: PRINT USING "\          \"; RET.NAM$(RTRIM$(nomes$(j)) + "." + ext$(j))
COLOR 4, 3: LOCATE 9, 70: PRINT USING "##,###,###"; bytes(j)
COLOR 4, 3: LOCATE 9, 50: PRINT USING "(##,###K)"; bytes(j) / 1024
COLOR 4, 3: LOCATE 10, 70: PRINT USING "##,###,###"; size
COLOR 4, 3: LOCATE 10, 50: PRINT USING "(##,###K)"; size / 1024
COLOR 4, 3: LOCATE 11, 70: PRINT USING "##,###,###"; limite
COLOR 4, 3: LOCATE 11, 50: PRINT USING "(##,###K)"; limite / 1024
COLOR 4, 3: LOCATE 12, 77: PRINT USING "###"; vol - 1
COLOR 4, 3: LOCATE 13, 77: PRINT USING "###"; tot.vol
COLOR 4, 3: LOCATE 14, 72: PRINT USING "\      \"; est.tim$
COLOR 4, 3: LOCATE 15, 71: PRINT USING "\       \"; ordena$(ord)
act& = TIME2SECONDS&(TIME$)
activo& = act& - arranque&
act$ = SECONDS2TIME$(activo&)
COLOR 4, 3: LOCATE 16, 61: PRINT USING "\      \ - \      \"; TIME$; act$
COLOR 4, 3: PERCENTO total.de.bytes&, total.de.bytes&, 19, 76
COLOR 4, 3: PERCENTO d2&, d2&, 20, 76
COLOR 4, 3: LOCATE 21, 64: PRINT USING "#,###/##,###,###"; d; total.de.bytes&
COLOR 4, 3: LOCATE 21, 50: PRINT USING "(##,###K)"; total.de.bytes& / 1024
COLOR 4, 3: LOCATE 22, 64: PRINT USING "#,###/##,###,###"; fd; bytes.in&
COLOR 4, 3: LOCATE 22, 50: PRINT USING "(##,###K)"; bytes.in& / 1024
BARRA bytes.in&, total.de.bytes&, 19, 40
feit& = feito
di& = d
BARRA feit&, di&, 20, 40
feit& = vol - 1
di& = tot.vol
BARRA feit&, di&, 18, 40
ending.time$ = TIME$
segundos.finais& = TIME2SECONDS&(ending.time$)
segundos.iniciais& = TIME2SECONDS&(starting.time$)
segundos.gastos& = segundos.finais& - segundos.iniciais&
gasto$ = SECONDS2TIME$(segundos.gastos&)
OPEN volume$ + vol$ + ".DAT" FOR APPEND AS #1
PRINT #1, USING "#### ficheiros guardados totalizando ##,###,### bytes"; d; total&
PRINT #1, USING "CompressÑo terminada Ös \      \"; ending.time$
PRINT #1, USING "Tempo gasto no processo: \      \"; gasto$
CLOSE
SLEEP 2
COLOR 7, 1, 1
VIEW PRINT 6 TO 24
CLS 2
l = 6
c = 1
t.bytes& = 0
FOR v = 1 TO vol
  vol$ = STRING$((8 - name.size) - LEN(MID$(STR$(v), 2)), "0") + MID$(STR$(v), 2)
  OPEN volume$ + vol$ + ".ZIP" FOR BINARY AS #1
  size& = LOF(1)
  t.bytes& = t.bytes& + size&
  CLOSE
  LOCATE l, 1: PRINT USING "\          \ com ##,###,### (##,###k) - \          \ com ##,###,### (##,###k)"; volume$ + vol$ + ".ZIP"; size&; size& / 1024; volume$ + vol$ + ".EXE"; size2&; size2& / 1024
  IF auto THEN
    IF confir THEN
      l = l + 1
      LOCATE l, 1
      PRINT "Converter de ZIP a EXE "; volume$ + vol$ + ".ZIP"; : INPUT " (S/N) ? ", r$
      r$ = MID$(UCASE$(r$), 1, 1)
      IF r$ = "S" THEN
        LOCATE l, 1: PRINT SPACE$(80);
        LOCATE l, 1
        PRINT "Criando o EXE apartir do ZIP....";
        SHELL "ZIP2EXE " + volume$ + vol$ + " >NUL:"
        LOCATE l, 1: PRINT SPACE$(80);
        l = l - 1
        OPEN volume$ + vol$ + ".EXE" FOR BINARY AS #1: size2& = LOF(1): CLOSE
        LOCATE l, 1: PRINT USING "\          \ com ##,###,### (##,###k) - \          \ com ##,###,### (##,###k)"; volume$ + vol$ + ".ZIP"; size&; size& / 1024; volume$ + vol$ + ".EXE"; size2&; size2& / 1024
        t.bytes2& = t.bytes2& + size2&
        size2& = 0
      END IF
    ELSE
      l = l + 1
      LOCATE l, 1
      PRINT "Criando o EXE apartir do ZIP....";
      SHELL "ZIP2EXE " + volume$ + vol$ + " >NUL:"
      LOCATE l, 1: PRINT SPACE$(80);
      l = l - 1
      OPEN volume$ + vol$ + ".EXE" FOR BINARY AS #1: size2& = LOF(1): CLOSE
      LOCATE l, 1: PRINT USING "\          \ com ##,###,### (##,###k) - \          \ com ##,###,### (##,###k)"; volume$ + vol$ + ".ZIP"; size&; size& / 1024; volume$ + vol$ + ".EXE"; size2&; size2& / 1024
      t.bytes2& = t.bytes2& + size2&
      size2& = 0
    END IF
  END IF
  l = l + 1
  IF l = 24 THEN
    PRINT "Uma tecla continua....";
    DO
      tecla$ = INKEY$
      IF tecla$ <> "" THEN EXIT DO
    LOOP
    CLS 2
    l = 6
  END IF
NEXT
LOCATE , 1
PRINT "Uma tecla termina...";
DO
  tecla$ = INKEY$
  IF tecla$ <> "" THEN EXIT DO
LOOP
termino& = TIME2SECONDS&(TIME$)
ter& = termino& - arranque&
ter$ = SECONDS2TIME$(ter&)
VIEW PRINT
COLOR 7, 0, 0: CLS
COLOR 14, 1:
LOCATE 1, 1: PRINT SPACE$(80);
LOCATE 2, 1: PRINT SPACE$(80);
LOCATE 3, 1: PRINT SPACE$(80);
LOCATE 1, 1
PRINT "VOLUME - "; t1$
PRINT t2$
PRINT t3$ + ter$
COLOR 7, 0
media& = t.bytes& \ vol
PRINT
PRINT "Sum†rio final:"
PRINT
PRINT "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
PRINT "∫                  SUMÜRIO FINAL                     ∫"
PRINT "ÃÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ"
PRINT "∫Total de bytes comprimidos................"; USING "##,###,###∫"; total.de.bytes&
PRINT "∫Total de arquivos processados............."; USING "      ####∫"; d
PRINT "∫Total de VOLUMEs criados.................."; USING "      ####∫"; vol
PRINT "∫MÇdia dos VOLUMEs........................."; USING "##,###,###∫"; media&
PRINT "∫Total de bytes em VOLUMEs................."; USING "##,###,###∫"; t.bytes&
PRINT "∫Total de bytes em autodescompactaveis....."; USING "##,###,###∫"; t.bytes2&
PRINT "∫Tempo total activo........................"; USING "  \      \∫"; act$
PRINT "∫Tempo estimativo para criaáÑo dos VOLUMEs."; USING "  \      \∫"; est.tim$
PRINT "∫Arranque do VOLUME Ös....................."; USING "  \      \∫"; SECONDS2TIME$(arranque&)
PRINT "∫Termino do VOLUME Ös......................"; USING "  \      \∫"; SECONDS2TIME$(termino&)
PRINT "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"
PRINT
END

'⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
'≥                             FIM DO MüDULO                                 ≥
'¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

SUB AJUDA
  COLOR 7, 1, 1: CLS
  COLOR 12, 1
  LOCATE 1, 1: PRINT CHR$(201) + STRING$(78, CHR$(205)) + CHR$(187)
  FOR j = 2 TO 24
    LOCATE j, 1: PRINT CHR$(186);
    LOCATE j, 80: PRINT CHR$(186);
  NEXT
  LOCATE 25, 1: PRINT CHR$(200) + STRING$(78, CHR$(205)) + CHR$(188);
  COLOR 3, 1
  LOCATE 2, 2: PRINT "     Este programa permite criar volumes de ZIP's de direct¢rios. ê muito £til"
  LOCATE 3, 2: PRINT "para armazenar direct¢rios em ZIP's e estes em disquetes. Se possui um direc- "
  LOCATE 4, 2: PRINT "t¢rio demasiadamente grande, e pretende armazen†-lo em disquetes, a £nica for-"
  LOCATE 5, 2: PRINT "ma Ç usar o VOLUME para fazà-lo. Tudo o que tem a fazer Ç evocar o VOLUME sob "
  LOCATE 6, 2: PRINT "a forma de VOLUME nome, onde ÆnomeØ Ç o nome do ZIP que pretende criar. O nome"
  LOCATE 7, 2: PRINT "s¢ poder† ter no m†ximo 6 caracteres, visto os restantes 2 serem usados para a"
  LOCATE 8, 2: PRINT "sifra numÇrica que o VOLUME ir† atribuir, por outras palavras, o VOLUME ir†   "
  LOCATE 9, 2: PRINT "criar os ZIP's ÆnomeØ sob a forma de Ænome0000Ø, Ænome0001Ø, etc.             "
  LOCATE 10, 2: PRINT "     Visto o VOLUME necessitar de interrumper a compressÑo afim de verificar o"
  LOCATE 11, 2: PRINT "o tamanho do ZIP para que nÑo seja ultrapassado o limite imposto pelo utiliza-"
  LOCATE 12, 2: PRINT "dor, o funcionamento do programa Ç lento. O processamento poder† ser interrum-"
  LOCATE 13, 2: PRINT "pido pressionando para o efeito a tecla ESC. Em tal situaáÑo, o volume que es-"
  LOCATE 14, 2: PRINT "t† sendo criado no momento do pressionar a tecla ESC, ser† apagado. Visto o"
  LOCATE 15, 2: PRINT "programa usar o formato ZIP, o PKZIP dever† de estar presente na ÆpathØ de"
  LOCATE 16, 2: PRINT "pesquisa do DOS. Durante o funcionamento, o VOLUME ir† criar arquivos com o "
  LOCATE 17, 2: PRINT "mesmo nome dos ZIP's mas com a terminaáÑo DAT, os quais possuem o relat¢rio de"
  LOCATE 18, 2: PRINT "compressÑo e tempo gasto no processo. Ao evocar o programa dever† de indicar"
  LOCATE 19, 2: PRINT "com que tamanho Ç que os ZIP's irÑo ficar (sugiro-lhe que indique o tamanho em"
  LOCATE 20, 2: PRINT "menos 20K que o tamanho pretendido afim de evitar ter de repetir o processo de"
  LOCATE 21, 2: PRINT "isto porque poderÑo existir arquivos que nÑo possuam compressÑo), podendo in-"
  LOCATE 22, 2: PRINT "dicar em seguida qual o tipo de ordenaáÑo que ser† usada nos mesmos. Uma vez "
  LOCATE 23, 2: PRINT "em funcionamento, o programa ir† exibir qual o volume est† criando, arquivo ";
  LOCATE 24, 2: PRINT "que est† comprimindo, seu tamanho, percentagens feitas, tempos gastos, etc.";
  msg$ = " Uma tecla termina "
  COLOR 14, 1: LOCATE 25, 40 - LEN(msg$) \ 2: PRINT msg$;
  COLOR 7, 1
  DO
    tecla$ = INKEY$
    IF tecla$ <> "" THEN EXIT DO
  LOOP
  COLOR 7, 0, 0: CLS
END SUB

SUB BARRA (f&, t&, linha, coluna)
  IF f& = 0 THEN
    COLOR 6, 3: LOCATE linha, coluna: PRINT "0% [∞∞∞∞∞∞∞∞∞∞] 100%"
  ELSE
    pr% = (f& * 100) / t&
    bar$ = STRING$(pr% \ 10, CHR$(219))
    COLOR 14, 3: LOCATE linha, coluna + 4: PRINT bar$
  END IF
  COLOR 7, 1
END SUB

SUB PERCENTO (feito&, total&, linha, coluna)
  per% = (feito& * 100) / total&
  LOCATE linha, coluna: PRINT USING "###%"; per%;
END SUB

FUNCTION RET.NAM$ (f$)
  m$ = LTRIM$(RTRIM$(f$))
  tm = LEN(m$)
  IF tm < 12 THEN
    RET.NAM$ = SPACE$(12 - tm) + m$
  ELSE
    RET.NAM$ = m$
  END IF
END FUNCTION

FUNCTION SECONDS2TIME$ (t&)
  segundos.totais& = t&
  horas = segundos.totais& \ 3600       'cada hora sao 3600 segundos
  resto.horas = segundos.totais& MOD 3600
  segundos.totais& = resto.horas
  minutos = segundos.totais& \ 60        'cada minuto sao 60 segundos
  resto.minutos = segundos.totais& MOD 60
  segundos = resto.minutos              'o resto que ficar sao os segundos
  'Converter para o formato standarizado
  horas$ = MID$(STR$(horas), 2)         'isto evita espaáos em branco que
                                        'possa originar erros
  minutos$ = MID$(STR$(minutos), 2)
  segundos$ = MID$(STR$(segundos), 2)
  'Verificar os tamanhos de cada dado e acertar acrescentando um 0 Ö esquerda
  IF LEN(horas$) <> 2 THEN horas$ = "0" + horas$    'ex. 02 horas
  IF LEN(minutos$) <> 2 THEN minutos$ = "0" + minutos$    'ex. 02 minutos
  IF LEN(segundos$) <> 2 THEN segundos$ = "0" + segundos$ 'ex. 02 segundos
  'formar a hora em hh:mm:ss e sair
  SECONDS2TIME$ = horas$ + ":" + minutos$ + ":" + segundos$
END FUNCTION

FUNCTION TIME2SECONDS& (t$)
  horas = VAL(MID$(t$, 1, 2))
  minutos = VAL(MID$(t$, 4, 2))
  segundos = VAL(MID$(t$, 7, 2))
  '1 hora = 3600 segundos, 1 minuto = 60 segundos
  'entÑo as horas (3600 segundos * hora) + minutos (60 segundos * minutos) +
  'segundos = segundos
  'em resumo xx horas yy minutos e zz segundos sao equivalentes a
  'mm segundos, pois xx horas sao 3600 * xx, yy minutos sao 60 * yy
  tempo.total& = (horas * 3600) + (minutos * 60) + segundos
  TIME2SECONDS& = tempo.total&
END FUNCTION

