'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
'³                     QUICK BASIC IV - FICHA TCNICA                        ³
'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
'³ Software................: BASE                                            ³
'³ M¢dulo,Execut vel.......: BASE.BAS, BASE.EXE                              ³
'³ Vers„o (Idioma),rev.....: 1.0 (P), 01/10/94                               ³
'³ Cliente.................: -                                               ³
'³ Autor...................: N‚lio Abreu                                     ³
'³ Copyright...............: 1994                                            ³
'³ Data de cria‡„o.........: 09/10/94                                        ³
'³ Interface de v¡deo......: Todos                                           ³
'³ Ambiente................: DOS                                             ³
'³ Interface de sistema....: Monoposto                                       ³
'³ Sistema operativo.......: MS/PC/DR-DOS vers„o 2 ou superior               ³
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

DECLARE SUB LIMPA ()
DECLARE SUB AJUDA (j)
DECLARE SUB ERRO ()

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
DECLARE FUNCTION GET.NUMBER$ ()

COLOR 7, 1, 1: CLS
COLOR 11, 1
LOCATE 1, 1: PRINT CHR$(201) + STRING$(78, CHR$(205)) + CHR$(187);
FOR l = 2 TO 24
  LOCATE l, 1: PRINT CHR$(186);
  LOCATE l, 80: PRINT CHR$(186);
NEXT
LOCATE 25, 1: PRINT CHR$(200) + STRING$(78, CHR$(205)) + CHR$(188);
DIM titulo$(1 TO 20)
titulo$(1) = "ÉÍÍÍÍ»   ÉÍÍÍÍÍÍÍ» ÉÍÍÍÍÍÍÍ» ÉÍÍÍÍÍÍÍ»"
titulo$(2) = "º ÛÛ º   º ÛÛÛÛÛ º º ÛÛÛÛÛ   º ÛÛÛÛÛ  "
titulo$(3) = "º ÛÛ º   º ÛÛÛÛÛ º º ÛÛÛÛÛ   º ÛÛ     "
titulo$(4) = "ÌÍÍÍÍÊÍ» ÌÍÍÍÍÍÍÍ¹ ÈÍÍÍÍÍÍÍ» ÌÍÍÍÍ¹   "
titulo$(5) = "º ÛÛÛÛ º º ÛÛÛÛÛ º   ÛÛÛÛÛ º º ÛÛ     "
titulo$(6) = "º ÛÛÛÛ º º ÛÛÛÛÛ º   ÛÛÛÛÛ º º ÛÛÛÛÛ  "
titulo$(7) = "º ÛÛÛÛ º º ÛÛÛÛÛ º   ÛÛÛÛÛ º º ÛÛÛÛÛ  "
titulo$(8) = "ÈÍÍÍÍÍÍ¼ Ê       Ê ÈÍÍÍÍÍÍÍ¼ ÈÍÍÍÍÍÍÍ¼"
titulo$(10) = " Uma vers„o Especial Spooler Magazine "
titulo$(12) = " Uma produ‡„o de N‚lio Abreu "
titulo$(14) = " Vers„o 1.0 - (c) 09/10/94 - 1994 - Rev 09/10/94 "
titulo$(16) = " Escrito em Quick BASIC 4.5 "
FOR l = 1 TO 16
  COLOR 14, 1
  LOCATE l + 4, 40 - LEN(titulo$(l)) \ 2: PRINT titulo$(l)
NEXT
m$ = " Pressione ENTER para come‡ar, ESC termina "
COLOR 28, 1
LOCATE 24, 40 - LEN(m$) \ 2: PRINT m$;
DO
  tecla$ = INKEY$
  IF tecla$ = CHR$(13) OR tecla$ = CHR$(27) THEN EXIT DO
LOOP
IF tecla$ = CHR$(27) THEN GOTO fim
LIMPA
COLOR 10, 3
LOCATE 2, 3: PRINT CHR$(201) + STRING$(74, CHR$(205)) + CHR$(187);
FOR l = 3 TO 4
  LOCATE l, 3: PRINT CHR$(186);
  LOCATE l, 4: PRINT SPACE$(74)
  LOCATE l, 78: PRINT CHR$(186);
NEXT
LOCATE 5, 3: PRINT CHR$(200) + STRING$(74, CHR$(205)) + CHR$(188);
COLOR 10, 3
LOCATE 20, 3: PRINT CHR$(201) + STRING$(74, CHR$(205)) + CHR$(187);
FOR l = 21 TO 23
  LOCATE l, 3: PRINT CHR$(186);
  LOCATE l, 4: PRINT SPACE$(74)
  LOCATE l, 78: PRINT CHR$(186);
NEXT
LOCATE 24, 3: PRINT CHR$(200) + STRING$(74, CHR$(205)) + CHR$(188);
n$ = " SPOOLER BASE - CONVERSOR NUMRICO "
LOCATE 3, 40 - LEN(n$) \ 2: PRINT n$
n$ = "(c) N‚lio Abreu - Vers„o 1.0 - Rev 09/10/94 - (c) 09/10/94 - 1994"
LOCATE 4, 40 - LEN(n$) \ 2: PRINT n$
LOCATE 21, 4: PRINT "Este programa, visa ajudar todos os programadores, que necessitem de con-"
LOCATE 22, 4: PRINT "verter valores num‚ricos de uma base para outra."
m$ = " FELIZES CONVERS™ES....."
LOCATE 23, 40 - LEN(m$) \ 2: PRINT m$
DIM opcao$(1 TO 12), linha(1 TO 12), base$(1 TO 12)
opcao$(1) = " Bin rio para Decimal     "
opcao$(2) = " Bin rio para HexaDecimal "
opcao$(3) = " Bin rio para Octal       "
opcao$(4) = " Decimal para HexaDecimal "
opcao$(5) = " Decimal para Octal       "
opcao$(6) = " Decimal para Bin rio     "
opcao$(7) = " HexaDecimal para Bin rio "
opcao$(8) = " HexaDecimal para Octal   "
opcao$(9) = " HexaDecimal para Decimal "
opcao$(10) = " Octal para Bin rio       "
opcao$(11) = " Octal para Decimal       "
opcao$(12) = " Octal para HexaDecimal   "
base$(1) = " Base 02 ÍÍ> Base 10 "
base$(2) = " Base 02 ÍÍ> Base 16 "
base$(3) = " Base 02 ÍÍ> Base 08 "
base$(4) = " Base 10 ÍÍ> Base 16 "
base$(5) = " Base 10 ÍÍ> Base 08 "
base$(6) = " Base 10 ÍÍ> Base 02 "
base$(7) = " Base 16 ÍÍ> Base 02 "
base$(8) = " Base 16 ÍÍ> Base 08 "
base$(9) = " Base 16 ÍÍ> Base 10 "
base$(10) = " Base 08 ÍÍ> Base 02 "
base$(11) = " Base 08 ÍÍ> Base 10 "
base$(12) = " Base 08 ÍÍ> Base 16 "
c = 4
FOR j = 1 TO 12
  linha(j) = j + 6
NEXT
FOR j = 1 TO 12
  COLOR 15, 7
  LOCATE linha(j), c: PRINT opcao$(j)
NEXT
COLOR 12, 7
LOCATE 6, c - 1: PRINT CHR$(201) + STRING$(LEN(opcao$(1)), CHR$(205)) + CHR$(187);
FOR l = 7 TO 18
  LOCATE l, c - 1: PRINT CHR$(186);
  LOCATE l, c + LEN(opcao$(1)): PRINT CHR$(186);
NEXT
LOCATE 19, c - 1: PRINT CHR$(200) + STRING$(LEN(opcao$(1)), CHR$(205)) + CHR$(188);
COLOR 15, 8

LOCATE 6, LEN(opcao$(1)) + 5: PRINT CHR$(201) + STRING$(72 - LEN(opcao$(1)), CHR$(205)) + CHR$(187);
FOR l = 7 TO 12
  LOCATE l, LEN(opcao$(1)) + 5: PRINT CHR$(186);
  LOCATE l, 78: PRINT CHR$(186);
  LOCATE l, LEN(opcao$(1)) + 6: PRINT SPACE$(72 - LEN(opcao$(1)))
NEXT
LOCATE 13, LEN(opcao$(1)) + 5: PRINT CHR$(200) + STRING$(72 - LEN(opcao$(1)), CHR$(205)) + CHR$(188);
COLOR 15, 8: LOCATE 7, LEN(opcao$(1)) + 6: PRINT "N£mero a converter....."; : COLOR 15, 7: PRINT STRING$(23, " ")
COLOR 15, 8: LOCATE 9, LEN(opcao$(1)) + 6: PRINT "Base a usar............"; : COLOR 15, 7: PRINT STRING$(23, " ")
COLOR 15, 8: LOCATE 11, LEN(opcao$(1)) + 6: PRINT "N£mero convertido......"; : COLOR 15, 7: PRINT STRING$(23, " ")
COLOR 11, 7
LOCATE 14, LEN(opcao$(1)) + 5: PRINT CHR$(201) + STRING$(72 - LEN(opcao$(1)), CHR$(205)) + CHR$(187);
FOR l = 15 TO 18
  LOCATE l, LEN(opcao$(1)) + 5: PRINT CHR$(186);
  LOCATE l, LEN(opcao$(1)) + 6: PRINT SPACE$(72 - LEN(opcao$(1)))
  LOCATE l, 78: PRINT CHR$(186);
NEXT
LOCATE 19, LEN(opcao$(1)) + 5: PRINT CHR$(200) + STRING$(72 - LEN(opcao$(1)), CHR$(205)) + CHR$(188);
AJUDA 1
t$ = " CONVERTER N–MEROS DE: "
LOCATE 6, 6: PRINT t$
posicao = 1
GOSUB poe.barra
DO
  tecla$ = UCASE$(INKEY$)
  IF tecla$ <> "" THEN
    IF tecla$ = CHR$(27) THEN
      EXIT DO
    END IF
    IF MID$(tecla$, 2) = "H" THEN
      posicao = posicao - 1
      IF posicao < 1 THEN posicao = 12
      GOSUB poe.barra
    END IF
    IF MID$(tecla$, 2) = "P" THEN
      posicao = posicao + 1
      IF posicao > 12 THEN posicao = 1
      GOSUB poe.barra
    END IF
    IF tecla$ = CHR$(13) THEN
      AJUDA 2
      DO
        COLOR 14, 7: LOCATE 9, LEN(opcao$(1)) + 30: PRINT base$(posicao)
        COLOR 7, 1
        numero$ = GET.NUMBER$
        IF numero$ <> "" THEN
          SELECT CASE posicao
            CASE 1
              valor$ = LTRIM$(STR$(BIN2DEC&(numero$)))
            CASE 2
              valor$ = LTRIM$(BIN2HEX$(numero$))
            CASE 3
              valor$ = LTRIM$(BIN2OCT$(numero$))
            CASE 4
              valor$ = LTRIM$(DEC2HEX$(VAL(numero$)))
            CASE 5
              valor$ = LTRIM$(DEC2OCT$(VAL(numero$)))
            CASE 6
              valor$ = LTRIM$(DEC2BIN$(VAL(numero$)))
            CASE 7
              valor$ = LTRIM$(HEX2BIN$(numero$))
            CASE 8
              valor$ = LTRIM$(HEX2OCT$(numero$))
            CASE 9
              valor$ = LTRIM$(STR$(HEX2DEC&(numero$)))
            CASE 10
              valor$ = LTRIM$(OCT2BIN$(numero$))
            CASE 11
              valor$ = LTRIM$(STR$(OCT2DEC&(numero$)))
            CASE 12
              valor$ = LTRIM$(OCT2HEX$(numero$))
          END SELECT
          COLOR 14, 7: LOCATE 11, (LEN(opcao$(1)) + 52) - LEN(valor$): PRINT valor$
        ELSE
          EXIT DO
        END IF
      LOOP
      AJUDA 1
      COLOR 15, 8: LOCATE 9, LEN(opcao$(1)) + 6: PRINT "Base a usar............"; : COLOR 15, 7: PRINT STRING$(23, " ")
    END IF
  END IF
LOOP
GOTO fim

poe.barra:
  antes = posicao - 1
  apos = posicao + 1
  IF antes < 1 THEN antes = 12
  IF apos > 12 THEN apos = 1
  COLOR 15, 7
  LOCATE linha(antes), c: PRINT opcao$(antes)
  LOCATE linha(apos), c: PRINT opcao$(apos)
  COLOR 14, 4
  LOCATE linha(posicao), c: PRINT opcao$(posicao)
  COLOR 7, 1
RETURN

fim:
COLOR 7, 0, 0
CLS
END

SUB AJUDA (j)
  SHARED opcao$()
  COLOR 11, 7
  SELECT CASE j
    CASE 1
      LOCATE 15, LEN(opcao$(1)) + 6: PRINT CHR$(24) + "   - Sobe a barra um item de cada vez"
      LOCATE 16, LEN(opcao$(1)) + 6: PRINT CHR$(25) + "   - Desce a barra um item de cada vez"
      LOCATE 17, LEN(opcao$(1)) + 6: PRINT CHR$(17) + CHR$(217) + "  - Activa op‡„o onde est  a barra"
      LOCATE 18, LEN(opcao$(1)) + 6: PRINT "ESC - Abandona o programa voltando ao DOS"
    CASE 2
      LOCATE 15, LEN(opcao$(1)) + 6: PRINT CHR$(17) + CHR$(217) + "  - Confirma valor inserido         "
      LOCATE 16, LEN(opcao$(1)) + 6: PRINT "ESC  - Volta ao Men£ principal                "
      LOCATE 17, LEN(opcao$(1)) + 6: PRINT "BkSp - Apaga valores                          "
      LOCATE 18, LEN(opcao$(1)) + 6: PRINT SPACE$(45)
  END SELECT
END SUB

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
  IF LEN(a$) < 20 THEN a$ = STRING$(20 - LEN(a$), "0") + a$
  IF LEN(a$) > 20 THEN
    ERROR 6
    EXIT FUNCTION
  END IF
  FOR j = 1 TO LEN(a$)
    codigo.ASCII = ASC(MID$(a$, j, 1))
    IF codigo.ASCII < 48 OR codigo.ASCII > 49 THEN ERROR 13
  NEXT
  expoente = 19
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
  D# = BIN2DEC(a$)
  h$ = DEC2HEX$(D#)
  BIN2HEX$ = h$
END FUNCTION

FUNCTION BIN2OCT$ (valor$)
  a$ = UCASE$(valor$)
  D# = BIN2DEC&(a$)
  o$ = DEC2OCT$(D#)
  BIN2OCT$ = o$
END FUNCTION

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
  IF LEN(digito$) < 20 THEN digito$ = STRING$(20 - LEN(digito$), "0") + digito$
  IF LEN(digito$) > 20 THEN ERROR 6
  DEC2BIN$ = sinal$(ABS(negativo)) + digito$
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
  IF LEN(digito$) < 20 THEN digito$ = STRING$(20 - LEN(digito$), "0") + digito$
  IF LEN(digito$) > 20 THEN ERROR 6
  DEC2HEX$ = sinal$(ABS(negativo)) + digito$
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
  DEC2OCT$ = sinal$(ABS(negativo)) + digito$
END FUNCTION

SUB ERRO
  SHARED opcao$()
  LOCATE , , 0
  COLOR 28, 7: LOCATE 7, LEN(opcao$(1)) + 30: PRINT "®® TECLA INCORRECTA ¯¯": COLOR 7, 1
  SLEEP 2
  COLOR 14, 7: LOCATE 7, LEN(opcao$(1)) + 30: PRINT SPACE$(22)
END SUB

FUNCTION GET.NUMBER$
  SHARED opcao$(), posicao
  CONST FALSE = 0, TRUE = NOT FALSE
  COLOR 15, 8: LOCATE 7, LEN(opcao$(1)) + 30
  COLOR 14, 7
  LOCATE , , 1, 11, 12
  coluna = LEN(opcao$(1)) + 50
  LOCATE 7, coluna
  old.posicao = posicao
  DO
    COLOR 14, 7
    ok = FALSE
    tecla$ = UCASE$(INKEY$)
    IF tecla$ <> "" THEN
      IF tecla$ = CHR$(13) THEN EXIT DO
      IF tecla$ = CHR$(27) THEN numero$ = "": EXIT DO
      IF tecla$ = CHR$(8) THEN
        posicao = 0
        p = p - 1
        IF p < 0 THEN p = 1
        numero$ = MID$(numero$, 1, p)
        LOCATE 7, coluna - 20: PRINT SPACE$(22)
        LOCATE 7, coluna - LEN(numero$): PRINT numero$;
        COLOR 14, 7: LOCATE 11, (LEN(opcao$(1)) + 30): PRINT SPACE$(22)
      END IF
      SELECT CASE posicao
        CASE 1, 2, 3
          IF ASC(tecla$) >= 48 AND ASC(tecla$) <= 49 THEN
            ok = TRUE
            numero$ = numero$ + tecla$
            p = p + 1
          ELSE
            BEEP
            ERRO
          END IF
        CASE 4, 5, 6
          IF ASC(tecla$) >= 48 AND ASC(tecla$) <= 57 THEN
            numero$ = numero$ + tecla$
            p = p + 1
            ok = TRUE
          ELSE
            BEEP
            ERRO
          END IF
        CASE 7, 8, 9
          IF (ASC(tecla$) >= 48 AND ASC(tecla$) <= 57) OR (ASC(tecla$) >= 65 AND ASC(tecla$) <= 70) THEN
            numero$ = numero$ + tecla$
            p = p + 1
            ok = TRUE
          ELSE
            BEEP
            ERRO
          END IF
        CASE 10, 11, 12
          IF ASC(tecla$) >= 48 AND ASC(tecla$) <= 55 THEN
            numero$ = numero$ + tecla$
            p = p + 1
            ok = TRUE
          ELSE
            BEEP
            ERRO
          END IF
      END SELECT
      LOCATE 7, coluna - LEN(numero$): PRINT numero$;
      posicao = old.posicao
    END IF
  LOOP
  LOCATE , , 0
  GET.NUMBER$ = numero$
END FUNCTION

FUNCTION HEX2BIN$ (valor$)
  a$ = UCASE$(valor$)
  D# = HEX2DEC&(a$)
  b$ = DEC2BIN$(D#)
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
  IF LEN(a$) < 20 THEN a$ = STRING$(20 - LEN(a$), "0") + a$
  IF LEN(a$) > 20 THEN
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
  expoente = 19
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
  D# = HEX2DEC&(a$)
  o$ = DEC2OCT$(D#)
  HEX2OCT$ = o$
END FUNCTION

SUB LIMPA
  FOR j = 2 TO 24
    COLOR 7, 1
    LOCATE j, 2: PRINT SPACE$(77);
  NEXT
END SUB

FUNCTION OCT2BIN$ (valor$)
  a$ = UCASE$(valor$)
  D# = OCT2DEC&(a$)
  b$ = DEC2BIN$(D#)
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
  D# = OCT2DEC&(a$)
  h$ = DEC2HEX$(D#)
  OCT2HEX$ = h$
END FUNCTION

