' ÚÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄ¿
' ³  ³ BASED ‚ um editor de texto de dominio    ³  ³
' ³  ³ p£blico feito em Quick Basic Vers„o 4.5  ³  ³
' ³  ³                                          ³  ³
' ³  ³ Este programa destina-se a ser divulgado ³  ³
' ³  ³ junto do programa Jr Cad V 1.0 na        ³  ³
' ³  ³ revista de inform tica SPOOLER           ³  ³
' ³  ³                                          ³  ³
' ³  ³   Autor: Jos‚ Fortunato H. Tom s         ³  ³
' ÀÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÙ



ON ERROR GOTO ERROS
PAG$ = "ì "

DIM BS$(1 TO 19)

IN:                     
IF FM$ = "" THEN FM$ = "MEMORIA.DAT"
TOM = 3
                OPEN "I", #3, FM$
                IF TOM = 45 THEN
                   FOR A = 6 TO 19
                     BS$(A) = " "
                   NEXT A
                   GOTO GH2
                END IF
                IF LOF(3) < 1 THEN GOTO GH
                 FOR A = 6 TO 19
                  INPUT #3, AG$
                  IF LEN(AG$) <= 80 THEN
                   BS$(A) = AG$
                   IF BS$(A) = "" THEN BS$(A) = "ÿ"
                  ELSE
                   BS$(A) = MID$(AG$, 1, 80)
                  END IF
                  IF EOF(3) <> 0 AND A < 19 THEN
                   FOR FAF = A TO 19
                     BS$(FAF) = " "
                   NEXT FAF
                  END IF
                  IF EOF(3) <> 0 OR A = 19 THEN GOTO GH
                 NEXT A
GH:
CLOSE #1
GH2:
TOM = 0

INICIO:
IF TS = 0 THEN TS = 1
IF LS = 0 THEN LS = 7
LIMPA$ = STRING$(80, 255)

MUDANCA = 0
COLUNAS = 0
Y = 1
HOR = 1
X = 0

DIM A$(5000)

ERASE A$
IF FRO$ = "" THEN FRO$ = COMMAND$
IF FRO$ = "" THEN
 FRO$ = "SEMNOME.TXT"
 AF = 1
END IF

COLUNAS = 1
        COLOR 7, 0
        CLS
        LOCATE 13, 30: PRINT "Aguardar um momento !"
        LOCATE 14, 32: PRINT "Leitura de texto"

CLOSE
IF FRO$ = "SEMNOME.TXT" AND AF = 1 THEN
 AF = 0
 GOTO NOVO
END IF
1 OPEN FRO$ FOR INPUT AS #1
DO UNTIL EOF(1)
X = X + 1
COLUNAS = COLUNAS + 1
    LINE INPUT #1, A$(X)
    IF INSTR(A$(X), CHR$(9)) <> 0 THEN
        D = INSTR(A$(X), CHR$(9))
        PARTE1$ = MID$(A$(X), 1, D - 1)
        PARTE2$ = MID$(A$(X), D + 1, LEN(A$(X)))
        A$(X) = PARTE1$ + "        " + PARTE2$
    END IF
LOOP

NOVO:
CLS
W = 21
IF COLUNAS < 20 THEN W = COLUNAS
GOSUB CORES

PINI = 1
PRINCIPAL:
        DO

               C$ = INKEY$
                D = D + 1
                IF TOM = 4 THEN
                 TOM = 0
                 C$ = CHR$(0) + CHR$(79)
                END IF
                IF D MOD 5 = 0 AND CURSORX + HOR - 2 > LEN(A$(CURSORY + Y - 1)) THEN
                 C$ = CHR$(0) + CHR$(79)
                 D = 0
                END IF
                 IF TOM = 1 THEN
                  TOM = 0
                  C$ = CHR$(8)
                 END IF

'************************************* Pagina‡„o / Rotina de actua‡„o
                IF MBN2 <> CURSORY + Y - 1 THEN MBN = 0
                IF PAG$ = "80" AND MBN <> 43 AND LEN(A$(CURSORY + Y - 1)) > 80 THEN
                  FOR XT = 80 TO 1 STEP -1
                   AXT$ = MID$(A$(CURSORY + Y - 1), XT, 1)
                   IF INSTR(AXT$, " ") <> 0 THEN
                        MBN = 1
                        A1$ = MID$(A$(Y + CURSORY - 1), 1, XT - 1)
                        A2$ = MID$(A$(Y + CURSORY - 1), XT + 1, LEN(A$(Y + CURSORY - 1)) - XT)
                        A$(Y + CURSORY - 1) = A2$
                        GOSUB ENTER
                        A$(Y + CURSORY - 1) = A1$
                        GOSUB LISTA
                        CURSORY = CURSORY + 1
                        IF XT > CURSORX + HOR - 1 THEN
                         CURSORY = CURSORY - 1
                        ELSE
                          CURSORX = CURSORX + HOR - XT - 1
                          IF CURSORX > 80 THEN
                           HOR = CURSORX - 78
                           CURSORX = 80
                          END IF
                        END IF
                       EXIT FOR
                   END IF
                  NEXT XT
                  IF MBN = 0 THEN GOSUB PAGE2
                END IF

               SELECT CASE C$
'**************************************************       MEMŸRIAS
                CASE IS = CHR$(0) + CHR$(32)        'D
                 C$ = MID$(DATE$, 4, 2) + "/" + MID$(DATE$, 1, 2) + "/" + MID$(DATE$, 7)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(35)        'H
                 C$ = MID$(TIME$, 1, 5)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(30)        'A
                 C$ = BS$(6)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(31)        'S
                 C$ = BS$(7)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(33)        'F
                 C$ = BS$(8)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(34)        'G
                 C$ = BS$(9)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(36)        'J
                 C$ = BS$(10)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(37)        'K
                 C$ = BS$(11)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(38)        'L
                 C$ = BS$(12)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(44)        'Z
                 C$ = BS$(13)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(45)        'X
                 C$ = BS$(14)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(46)        'C
                 C$ = BS$(15)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(47)        'V
                 C$ = BS$(16)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(48)        'B
                 C$ = BS$(17)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(49)        'N
                 C$ = BS$(18)
                 GOSUB MACROUTINE
                CASE IS = CHR$(0) + CHR$(50)        'M
                 C$ = BS$(19)
                 GOSUB MACROUTINE

'**************************************************       End MEMŸRIAS
                CASE IS = CHR$(0) + CHR$(66)        'F8
                    COLOR LS, FO
                      LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$
                    COLOR LS, TS
                    C$ = ""
                    E = 23
                    Q = 40
                    C2 = LS
                    C1 = TS
                    CARAC$ = ""
                    T$ = "Nova directoria (incluindo drive):"
                    LOCATE 23, 1: PRINT LIMPA$
                    CALL CHC(E, Q, T$, D, C2, C1, CARAC$)
                    LOCATE 1, 1
                    SHELL "CD " + CARAC$
                    COLOR LS, FO
                    CLS
                    GOSUB CORES
                CASE IS = CHR$(0) + CHR$(67)        'F9
                    COLOR LS, FO
                      LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$
                    COLOR LS, TS
                    E = 23
                    Q = 12
                    C2 = LS
                    C1 = TS
                    CARAC$ = "*.TXT"
                    T$ = "Tipo de ficheiros a visionar:"
                    LOCATE 23, 1: PRINT LIMPA$
                    CALL CHC(E, Q, T$, D, C2, C1, CARAC$)
                    COLOR LS, FO
                    CLS
                    TOM = 889
                    PRINT "Directoria ";
                    FILES CARAC$
                    PRINT
                    PRINT "Qualquer tecla p/ continuar."
                    SLEEP 240
                    C$ = INKEY$
                    C$ = ""
                    GOSUB CORES

'*************************************       Pagina‡„o / Rotina de activa‡„o
                CASE IS = CHR$(0) + CHR$(25)
                 IF PAG$ = "ì " THEN
                  PAG$ = "80"
                  MBN2 = -1
                 ELSE
                  IF PAG$ = "80" THEN
                   PAG$ = "ì "
                   MBN2 = -1
                  END IF
                 END IF
                 GOSUB CORES
'**************************************************

               CASE IS = CHR$(0) + CHR$(21)       ' Alt Y
                 A$(Y + CURSORY - 1) = ""
                 CURSORX = 1
                 HOR = 1
                 GOSUB UNIR
                 IF COLUNAS - (CURSORY + Y) < 20 AND Y > 1 THEN CURSORY = CURSORY + 1
                 GOSUB LISTA
                 C$ = ""
'***************************************************
               CASE IS = CHR$(0) + CHR$(83)
                 IF Y + CURSORY - 1 = 1 AND COLUNAS = 1 AND A$(1) = "" THEN C$ = ""
               CASE IS = CHR$(0) + CHR$(16)
                 A$(Y + CURSORY - 1) = MID$(A$(Y + CURSORY - 1), 1, HOR + CURSORX - 2)
                 TOM = 1
                 C$ = " "
'******************************************************* ABERTURA MEMŸRIAS
               CASE IS = CHR$(0) + CHR$(24)

                      COLOR LS, FO
                      LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$

                COLOR LS, TS
                E = 23
                Q = 25
                C2 = LS
                C1 = TS
                CARAC$ = ""
                T$ = "Digite o nome do ficheiro de mem¢rias a abrir:"
                LOCATE 23, 1: PRINT LIMPA$
                CALL CHC(E, Q, T$, D, C2, C1, CARAC$)
                FM$ = CARAC$
                TOM = 43
                GOSUB CORES
                C$ = CHR$(0) + CHR$(71)
                TOM = 2
                GOSUB CV
                IF FM$ = "" THEN FM$ = "MEMORIA.DAT"
                TOM = 3
3               OPEN "I", #3, FM$
                IF TOM = 45 THEN
                   FOR A = 6 TO 19
                     BS$(A) = " "
                   NEXT A
                  GOTO GH3
                END IF
                IF LOF(3) < 1 THEN GOTO GH1
                 FOR A = 6 TO 19
                  INPUT #3, AG$
                  IF LEN(AG$) <= 80 THEN
                   BS$(A) = AG$
                   IF BS$(A) = "" THEN BS$(A) = "ÿ"
                  ELSE
                   BS$(A) = MID$(AG$, 1, 80)
                  END IF
                  IF EOF(3) <> 0 AND A < 19 THEN
                   FOR FAF = A TO 19
                     BS$(FAF) = " "
                   NEXT FAF
                  END IF
                  IF EOF(3) <> 0 OR A = 19 THEN GOTO GH1
                 NEXT A
GH1:
                CLOSE #3
GH3:
                TOM = 0


                  LOCATE 1, 47: PRINT "Coluna:"; HOR + CURSORX - 1

               END SELECT


'****************************************** Esc
                IF C$ = CHR$(27) THEN
               
                COLOR LS, FO
                LOCATE CURSORY + 1, CURSORX
                IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                 ART$ = " "
                ELSE
                 ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                END IF
                PRINT ART$
                
                 IF MUDANCA <> 0 THEN
                       COLOR LS, TS
                       LOCATE 23, 1: PRINT LIMPA$
                       COLOR LS, TS
                       LOCATE 23, 1: PRINT " Deseja gravar o actual texto (S/N)?"
                       C$ = ""
                       C = 0
                       DO UNTIL C <> 0
                          C$ = UCASE$(INKEY$)
                          IF C$ = "S" THEN F = 1: GOSUB GRAVAR
                          IF C$ = "N" THEN C = 1
                          IF C$ = CHR$(27) THEN GOSUB CORES
                       LOOP
                 END IF
                 SCREEN 0, 0, 0: END
               END IF

'*********************************** Back Escape / JFHT Soft
               IF C$ = CHR$(8) AND HOR + CURSORX - 1 = 1 AND CURSORY + Y - 1 > 1 THEN
                IF LEN(A$(CURSORY + Y - 2)) = 0 THEN
                 C = CURSORY
                 BACKSPACE = 1
                 GOSUB APAGAR: C$ = ""
                 CURSORY = C - 1
                 MUDANCA = 1
                ELSE
                 A1$ = A$(CURSORY + Y - 2)
                 A2$ = A$(CURSORY + Y - 1)
                 A$(CURSORY + Y - 1) = A1$ + A2$
                 A$(CURSORY + Y - 2) = ""
                 BACKSPACE = 1
                 GOSUB APAGAR: C$ = ""
                 MUDANCA = 1
                 CURSORX = LEN(A1$) + 1
                 IF CURSORX > 80 THEN
                  HOR = CURSORX - 78
                  CURSORX = 79
                 END IF
                 CURSORY = CURSORY - 1
                END IF

               END IF

               IF C$ = CHR$(8) AND HOR + CURSORX - 1 = 1 THEN
                C$ = ""
               ELSE
                IF C$ = CHR$(8) THEN
                 PARTE1$ = MID$(A$(CURSORY + Y - 1), 1, CURSORX + HOR - 3)
                 PARTE2$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, LEN(A$(CURSORY + Y - 1)) - LEN(PARTE1$))
                 A$(CURSORY + Y - 1) = PARTE1$ + PARTE2$: GOSUB LISTA
                 CURSORX = CURSORX - 1: C$ = "": MUDANCA = 1
                END IF
               END IF

'***************  DELETE


               IF C$ = CHR$(0) + CHR$(83) AND CURSORX + HOR - 1 <= LEN(A$(CURSORY + Y - 1)) THEN
                 PARTE1$ = MID$(A$(CURSORY + Y - 1), 1, CURSORX + HOR - 2)
                 PARTE2$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR, LEN(A$(CURSORY + Y - 1)) - LEN(PARTE1$))
                 A$(CURSORY + Y - 1) = PARTE1$ + PARTE2$
                 GOSUB LISTA
                 C$ = ""
                 MUDANCA = 1
               END IF

                'Une e retrai linha caso a linha = ""
               IF C$ = CHR$(0) + CHR$(83) AND CURSORX + HOR - 2 = LEN(A$(Y + CURSORY - 1)) AND CURSORY + Y - 1 <> COLUNAS THEN
                GOSUB UNIR
                C$ = ""
               END IF
'***************
               IF C$ = CHR$(0) + CHR$(65) THEN GOSUB IMPRIMIR
'************* ENTER

               IF C$ = CHR$(13) AND CURSORX + HOR - 1 > 1 AND HOR + CURSORX - 1 <= LEN(A$(Y - 1 + CURSORY)) THEN
                GOSUB PARTIRM
                CURSORY = CURSORY + 1
                CURSORX = 1
                HOR = 1
               END IF
               IF C$ = CHR$(13) AND HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                 CURSORY = CURSORY + 1
                 CURSORX = 1
                 HOR = 1
                 GOSUB ENTER
                 C$ = ""
               END IF
               IF C$ = CHR$(13) THEN
                GOSUB ENTER
                C$ = ""
                CURSORY = CURSORY + 1
                CURSORX = 1
                HOR = 1
               END IF
'*************
               IF C$ = CHR$(0) + CHR$(59) THEN GOSUB HELP
               IF C$ = CHR$(0) + CHR$(60) THEN
                      COLOR LS, FO
                      LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$
                      C$ = ""
                GOSUB GRAVAR
               END IF
               IF C$ = CHR$(0) + CHR$(61) THEN
                      COLOR LS, FO
                      LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$
                 COLOR LS, FO
                 GOSUB CARREGAR
               END IF
               IF C$ = CHR$(0) + CHR$(62) THEN
                FO = FO + 1
                GOSUB CORES
               END IF
               IF C$ = CHR$(0) + CHR$(63) THEN
                 TS = TS + 1
                 GOSUB CORES
               END IF
               IF C$ = CHR$(0) + CHR$(64) THEN
                LS = LS + 1
                GOSUB CORES
               END IF
 '******************

               IF CURSORY < 1 THEN Y = Y - 1: CURSORY = 1

'***********************

               IF CURSORY - 1 >= COLUNAS THEN CURSORY = COLUNAS
               IF CURSORY > 21 THEN CURSORY = 21: Y = Y + 1

'****************** PAGE UP

               IF C$ = CHR$(0) + CHR$(73) AND Y > 1 THEN
                      C$ = ""
                      COLOR LS, FO
                      LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$

                Y = Y - 20
                CURSORX = 1

               ELSE

                IF C$ = CHR$(0) + CHR$(73) THEN
                    C$ = ""
                         COLOR LS, FO
                         LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$

                  CURSORY = 1
                  CURSORX = 1

                END IF
               END IF

'****************** PAGE DOWN

               IF C$ = CHR$(0) + CHR$(81) AND Y < COLUNAS - 20 THEN
                C$ = ""
                COLOR LS, FO
                LOCATE CURSORY + 1, CURSORX
                IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                 ART$ = " "
                ELSE
                 ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                END IF
                PRINT ART$

                CURSORX = 1
                Y = Y + 20
                DO WHILE LEN(A$(CURSORY + Y - 1)) = 0
                 Y = Y - 1
                LOOP
               ELSE
                IF C$ = CHR$(0) + CHR$(81) THEN
                 C$ = ""
                 COLOR LS, FO
                 LOCATE CURSORY + 1, CURSORX
                 IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                  ART$ = " "
                 ELSE
                  ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                 END IF
                 PRINT ART$

                 CURSORY = 20
                 CURSORX = 1
                 IF COLUNAS < CURSORY THEN CURSORY = COLUNAS
                END IF
               END IF


'******************  END

               IF C$ = CHR$(0) + CHR$(79) THEN
                COLOR LS, FO
                LOCATE CURSORY + 1, CURSORX
                PRINT MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                CURSORX = LEN(A$(CURSORY + Y - 1)) + 1
                 IF LEN(A$(CURSORY + Y - 1)) > 78 THEN
                  HOR = LEN(A$(Y + CURSORY - 1)) - 77
                  CURSORX = 79
                 ELSE
                  HOR = 1
                 END IF
               END IF

'*********************************************** HOME
               IF C$ = CHR$(0) + CHR$(71) THEN
                COLOR LS, FO
                LOCATE CURSORY + 1, CURSORX
                IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                 ART$ = " "
                ELSE
                 ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                END IF
                PRINT ART$
                HOR = 1: CURSORX = 1
               END IF

 '***************** SETA PARA CIMA

        IF C$ = CHR$(0) + CHR$(72) AND CURSORY + Y > 1 THEN

                IF CURSORY = 1 AND Y > 1 THEN
                 CURSORY = 2
                 Y = Y - 1
                END IF

                COLOR LS, FO
                LOCATE CURSORY + 1, CURSORX
                IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                 ART$ = " "
                ELSE
                 ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                END IF
                PRINT ART$
                IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 2)) THEN
                         CURSORX = LEN(A$(CURSORY + Y - 2)) + 1
                         IF CURSORX > 80 THEN
                          HOR = CURSORX - 78
                          CURSORX = 80
                         ELSE
                          HOR = 1
                         END IF

                END IF
                IF A$(CURSORY + Y - 2) = "" AND CURSORY + Y - 2 >= 1 THEN
                 CURSORX = 1
                 HOR = 0
                 CURSORY = CURSORY - 1
                ELSE
                 IF CURSORY + Y - 2 >= 1 THEN
                  CURSORY = CURSORY - 1
                 END IF
                END IF
                C$ = ""
        END IF

 '******************* SETA PARA BAIXO

        IF C$ = CHR$(0) + CHR$(80) AND CURSORY + Y - 1 < COLUNAS THEN
                C$ = ""
                COLOR LS, FO
                LOCATE CURSORY + 1, CURSORX
                IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                 ART$ = " "
                ELSE
                 ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                END IF
                PRINT ART$

                IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y)) THEN
                         CURSORX = LEN(A$(CURSORY + Y)) + 1
                         IF CURSORX > 80 THEN
                          HOR = CURSORX - 78
                          CURSORX = 80
                         ELSE
                          HOR = 1
                         END IF
                END IF

                IF A$(CURSORY + Y) = "" AND CURSORY + Y <= COLUNAS THEN
                 CURSORX = 1
                 HOR = 1

                  IF CURSORY = 21 THEN
                   CURSORY = 21
                   Y = Y + 1
                  ELSE
                   CURSORY = CURSORY + 1
                   CV = 1
                  END IF
                ELSE
                 IF CURSORY + Y <= COLUNAS AND CV <> 1 THEN
                    IF CURSORY = 21 THEN
                     CURSORY = 21
                     Y = Y + 1
                    ELSE
                     CURSORY = CURSORY + 1
                    END IF
                 END IF
                END IF
                CV = 0

        END IF

'*********************** SETA PARA A DIREITA

               IF C$ = CHR$(0) + CHR$(77) THEN
                C$ = ""
                COLOR LS, FO
                IF LEN(A$(Y + CURSORY - 1)) = 0 THEN
                 GOTO DIREITANULA
                END IF
                IF LEN(A$(Y + CURSORY - 1)) + 1 = CURSORX - 1 + HOR THEN
                 CURSORX = CURSORX - 1
                END IF
                LOCATE CURSORY + 1, CURSORX: PRINT MID$(A$(Y + CURSORY - 1), CURSORX + HOR - 1, 1)
                CURSORX = CURSORX + 1
DIREITANULA:
               END IF
 '****************** SETA PARA A ESQUERDA

               IF C$ = CHR$(0) + CHR$(75) THEN
                C$ = ""
                COLOR LS, FO
                IF LEN(A$(Y + CURSORY - 1)) = CURSORX - 2 + HOR THEN
                 LOCATE CURSORY + 1, CURSORX: PRINT " "
                END IF
                LOCATE CURSORY + 1, CURSORX: PRINT MID$(A$(Y + CURSORY - 1), CURSORX + HOR - 1, 1)
                CURSORX = CURSORX - 1
               END IF

 '***********************

               IF CURSORX > 79 AND LEN(C$) <= 1 THEN
                CURSORX = 79: HOR = HOR + 1
               END IF

  ' Rotina dirigida …s mem¢rias para p gina virtual

               IF CURSORX > 79 AND LEN(C$) > 1 THEN
                A$(CURSORY + Y - 1) = A$(CURSORY + Y - 1) + C$
                CURSORX = 79: HOR = HOR + LEN(C$)
                C$ = ""
               END IF


 '******************
               IF CURSORX < 1 THEN CURSORX = 1: HOR = HOR - 1
               IF C$ = CHR$(0) + CHR$(82) AND INSERT = 0 THEN INSERT = 1 ELSE IF C$ = CHR$(0) + CHR$(82) THEN INSERT = 0
               IF Y > COLUNAS - 20 THEN Y = COLUNAS - 20
               IF Y < 2 THEN Y = 1
               IF COLUNAS < 20 THEN Y = 1
               IF HOR < 1 THEN HOR = 1
               IF H <> HOR THEN GOSUB LISTA
               IF Y1 <> Y THEN GOSUB LISTA
               IF C$ = CHR$(9) THEN
                C$ = "     "
                GOSUB MACROUTINE
               END IF
               IF CURSORX + HOR - 1 > LEN(A$(CURSORY + Y - 1)) AND C$ <> "" AND INSERT = 0 THEN INSERT = 1
               IF C$ <> "" THEN
                IF ASC(C$) < 256 AND ASC(C$) > 0 AND CURSORX + HOR - 1 > LEN(A$(CURSORY + Y - 1)) AND INSERT = 0 THEN
                 INSERT = 1
                END IF
               END IF
                IF C$ <> "" THEN
                 IF ASC(C$) < 256 AND ASC(C$) > 0 AND INSERT = 0 THEN
                  MID$(A$(Y + CURSORY - 1), CURSORX + HOR - 1) = C$
                  MUDANCA = 1
                  MAIS1 = 1
                 END IF
                END IF
               IF C$ <> "" THEN
                IF ASC(C$) < 256 AND ASC(C$) > 0 AND INSERT = 1 THEN
                 PARTE1$ = MID$(A$(CURSORY + Y - 1), 1, CURSORX + HOR - 2)
                 PARTE2$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, LEN(A$(CURSORY + Y - 1)) - LEN(PARTE1$))
                 A$(CURSORY + Y - 1) = PARTE1$ + C$ + PARTE2$
                 GOSUB LISTA
                 MAIS1 = 1
                 MUDANCA = 1
                END IF
               END IF
HJK:
                 IF CURSORY = 0 THEN CURSORY = 1

                 COLOR 7, FO
                 LOCATE CURSORY + 1, CURSORX: PRINT " "
                 COLOR LS, FO
                 LOCATE CURSORY + 1, CURSORX: PRINT MID$(A$(Y + CURSORY - 1), CURSORX + HOR - 1, 1)
                 COLOR LS, TS
                 LOCATE 1, 54: PRINT HOR + CURSORX - 1; "  "
                 LOCATE 1, 20: PRINT "Linha"; Y + CURSORY - 1; "de"; COLUNAS; "linha(s)"
                 IF MAIS1 = 1 THEN CURSORX = CURSORX + 1: MAIS1 = 0
                 COLOR LS + 16, FO
                 LOCATE CURSORY + 1, CURSORX
                 IF INSERT = 0 THEN PRINT "Û" ELSE PRINT "_"
                 COLOR LS, TS
        LOOP






'********************************************************************
'* END PRINCIPAL                                                    *
'*                                                                  *
'********************************************************************
'

LISTA:
        C$ = ""
        COLOR LS, FO

         IF COLUNAS > W AND COLUNAS < 22 THEN W = COLUNAS
         FOR X = 1 TO W
            LOCATE X + 1, 1: PRINT LIMPA$
          IF LEN(A$(X + Y - 1)) <> 0 THEN
            LOCATE X + 1, 1: PRINT MID$(A$(X + Y - 1), HOR, 80)
          END IF
         NEXT

        COLOR LS, TS
        LOCATE 1, 47: PRINT "Coluna:"; HOR + CURSORX - 1


        KEY(11) ON: KEY(14) ON
        Y1 = Y
        H = HOR
'*********************************
        IF COLUNAS = 0 THEN COLUNAS = 1
'*********************************
RETURN

UP:
   C$ = "8"
   RETURN PRINCIPAL

DOWN:
    C$ = "2"
    RETURN PRINCIPAL

ERROS:
     IF ERR = 53 AND TOM = 889 THEN
      TOM = 0
      RESUME NEXT
     END IF
    
    
     BEEP

     IF ERR = 53 AND TOM = 3 THEN
        COLOR 7, 0
        CLS
        LOCATE 12, 16
        PRINT "Ficheiro de mem¢rias inexistente, mem¢rias n„o carregadas."
        SLEEP 5
        JLK$ = INKEY$
        TOM = 43
        GOSUB CORES
        TOM = 45
        RESUME NEXT
     END IF
     IF ERR = 64 OR ERR = 55 THEN
        CLS
        LOCATE 12, 16
        IF ERL = 1 OR ERL = 3 THEN PRINT "O nome do ficheiro a carregar n„o pode ser aceite.": COLUNAS = 1:
        IF ERL = 2 THEN PRINT "O nome do ficheiro a gravar n„o pode ser aceite."
        SLEEP 4: F$ = INKEY$
        RESET
        FRO$ = "SEMNOME.TXT"
        GOSUB CORES
        RESUME PRINCIPAL
     END IF
     SELECT CASE ERR
     CASE IS = 53
      COLUNAS = 1: RESUME NOVO
     CASE IS = 76
      COLOR 7, 0
      CLS
      LOCATE 12, 27
      PRINT "Directoria n„o encontrada."
      SLEEP 4: F$ = INKEY$
      GOSUB CORES
      RESUME PRINCIPAL
     CASE IS = 75
      CLS
      IF TOM = 3 THEN FROT$ = FM$
      LOCATE 12, 20: PRINT "O caminho p/ o ficheiro "; FROT$; " foi negado."
      SLEEP 4: F$ = INKEY$

     CASE IS = 7 OR ERR = 14
      PRINT "  ": PRINT " Mem¢ria insuficiente ou texto muito grande.": PRINT "  "
      SLEEP 4: F$ = INKEY$

     CASE IS = 23
      COLOR 15, 0, 0: CLS
      PRINT "  Linha muito comprida, impossivel continuar.": FRO$ = ""
      SLEEP 4: F$ = INKEY$

     CASE IS = 27
      LOCATE 23, 1: PRINT LIMPA$: LOCATE 23, 1
      PRINT " Impressora sem papel. Tente de novo..."
      SLEEP 4: F$ = INKEY$
      GOSUB CORES
      C$ = "": ON ERROR GOTO ERROS
      RESUME PRINCIPAL

     CASE IS = 25
      LOCATE 23, 1: PRINT LIMPA$: LOCATE 23, 1
      PRINT " Impressora inexistente ou desligada. Tente de novo..."
      SLEEP 4: F$ = INKEY$
      GOSUB CORES: C$ = ""
      RESUME PRINCIPAL
     CASE IS = 23
     END SELECT
     SCREEN 0, 0, 0: CLS
     END

CORES:
        IF LS = 16 THEN LS = 0
        IF TS = 16 THEN TS = 0
        IF FO = 16 THEN FO = 0
        COLOR 0, 0, 0: CLS
                      COLOR LS, FO
                     FOR X = 1 TO 21
                        LOCATE X + 1, 1: PRINT LIMPA$
                      IF LEN(A$(X + Y - 1)) <> 0 THEN
                        LOCATE X + 1, 1: PRINT MID$(A$(X + Y - 1), HOR, 80)
                      END IF
                     NEXT
        COLOR , TS
        LOCATE 23, 1: PRINT LIMPA$
        LOCATE 1, 1: PRINT LIMPA$
        COLOR LS, TS

        '****************VISUAL

        LOCATE 1, 1: PRINT "                 "
        LOCATE 1, 1: PRINT USING "<&>"; RIGHT$(FRO$, 14)
        LOCATE 1, 47: PRINT "Coluna:"; HOR + CURSORX - 1
        LOCATE 1, 59: PRINT "  Pg Up/Down Home End"
        LOCATE 23, 1: PRINT " F1 - Menu   F2 - Salvaguardar Texto   F3 - Entrada de Texto   F4 - Cor Fundo   ";
        LOCATE 24, 1: PRINT " F5 - Cor Barras     F6 - Cor Letras     F7 - Imprimir Texto   "; CHR$(27); CHR$(24); CHR$(25); CHR$(26); "  ESC - Sair ";
        LOCATE 25, 1: PRINT " F8 - Mudar de Directoria     F9 - Visionar Ficheiros          Pagina‡„o: "; PAG$; "    ";
        GOSUB LISTA
        IF TOM = 43 THEN
         TOM = 0
         RETURN
        END IF

RETURN PRINCIPAL

IMPRIMIR:
                      COLOR LS, FO
                      LOCATE CURSORY + 1, CURSORX
                      IF HOR + CURSORX - 1 > LEN(A$(CURSORY + Y - 1)) THEN
                         ART$ = " "
                      ELSE
                         ART$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1, 1)
                      END IF
                      PRINT ART$
                
         COLOR LS, TS
         LOCATE 23, 1: PRINT LIMPA$
         LOCATE 23, 1: PRINT " Deseja imprimir (T)odo o texto ou apenas uma (P)arte?      ESC-Desistir"
         C$ = ""
         DO UNTIL C$ = "T" OR C$ = "P"
                C$ = UCASE$(INPUT$(1))
                IF C$ = CHR$(27) THEN C$ = "": GOSUB CORES: RETURN
         LOOP
         IF C$ = "T" THEN GOTO TOTAL
        LOCATE 23, 1: PRINT LIMPA$
        Q = 5
        T$ = "Imprimir da linha:"
        E = 23
        C2 = LS
        C1 = TS
        CARAC$ = ""
        CALL CHC(E, Q, T$, D, C2, C1, CARAC$)
        TOPO = VAL(CARAC$)

        LOCATE 23, 1: PRINT LIMPA$

        Q = 5
        T$ = "At‚ … linha:"
        E = 23
        C2 = LS
        C1 = TS
        CARAC$ = ""
        CALL CHC(E, Q, T$, D, C2, C1, CARAC$)
        FIM = VAL(CARAC$)
        IF TOPO > COLUNAS OR TOPO < 1 THEN LOCATE 23, 1: PRINT "Parƒmetros inv lidos                                                          ": SLEEP 4: GOSUB CORES: RETURN
        IF FIM > COLUNAS OR FIM < TOPO THEN LOCATE 23, 1: PRINT "Parƒmetros inv lidos                                                          ": SLEEP 4: GOSUB CORES: RETURN
        LOCATE 23, 1: PRINT LIMPA$
        COLOR 31
        LOCATE 23, 1: PRINT " A IMPRIMIR ..."
        FOR X = TOPO TO FIM
            LPRINT A$(X)
        NEXT
        GOSUB CORES
RETURN

TOTAL:
         LOCATE 23, 1: PRINT LIMPA$
         COLOR 31
         LOCATE 23, 1: PRINT " A IMPRIMIR ..."
         FOR X = 1 TO COLUNAS
             IF LEN(A$(X)) = 80 THEN
               LPRINT A$(X);
             ELSE
               LPRINT A$(X)
             END IF
         NEXT
         GOSUB CORES
RETURN

HELP:
     COLOR LS, FO
     CLS
     PRINT "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
     PRINT "º Tabela De Comandos Do BASED V 1.0 :                                          º"
     PRINT "º  F1 - Exibe esta tabela de comandos       F2 - Salvaguardar texto (Grava‡„o) º"
     PRINT "º  F3 - Entrada de texto  (Leitura)         F4 - Altera‡„o da cor de fundo     º"
     PRINT "º  F5 - Altera‡„o da cor das barras de dados                                   º"
     PRINT "º  F6 - Altera‡„o da cor das letras         F7 - Impress„o do texto            º"
     PRINT "º  F8 - Mudan‡a de directoria                                                  º"
     PRINT "º  F9 - Visionar ficheiros na directoria actual                                º"
     PRINT "º                                                                              º"
     PRINT "º  Alt + [A; S; F; G; J; K; L; - Permite armazenar e uzar 19 mem¢rias lidas    º"
     PRINT "º         Z; X; C; V; B; N; M]   de ficheiros em formato ASCII                 º"
     PRINT "º  Alt + P - Activa rotina de                                                  º"
     PRINT "º            pagina‡„o … 80¦ coluna         Alt + Y - Elimina linha            º"
     PRINT "º  Alt + D - Permite usar a data do         Alt + Q - Apaga do cursor at‚      º"
     PRINT "º            sistema como uma memoria                 ao fim da linha          º"
     PRINT "º  Alt + H - Permite usar a hora do         Alt + O - Lˆ mem¢rias de ficheiro  º"
     PRINT "º            sistema como uma mem¢ria                 em formato ASCII         º"
     PRINT "º                                                                              º"
     PRINT "º  ["; CHR$(27); "] - Move cursor p/ a esquerda   Pg Up - Move cursor p/ cima ñ20 linhas    º"
     PRINT "º  ["; CHR$(26); "] - Move cursor p/ a direita    Pg Dn - Move cursor p/ baixo ñ20 linhas   º"
     PRINT "º  ["; CHR$(24); "] - Move cursor p/ cima         Home  - Move cursor p/ o in¡cio da linha  º"
     PRINT "º  ["; CHR$(25); "] - Move cursor p/ baixo        End   - Move cursor p/ o fim da linha     º"
     PRINT "º                                                                              º"
     PRINT "º Qualquer tecla p/ continuar.                  BASED V. 1.0 por Jos‚ F. Tom s º";
     LOCATE 25, 1: PRINT "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼";
     C$ = ""
     DO WHILE C$ = ""
        C$ = INKEY$
     LOOP
     GOSUB CORES
     RETURN

ENTER:
      FOR X = COLUNAS TO CURSORY + Y - 1 STEP -1
          A$(X + 1) = A$(X)
      NEXT
      A$(CURSORY + Y - 1) = ""
      COLUNAS = COLUNAS + 1
      GOSUB LISTA
      MUDANCA = 1
      RETURN


APAGAR:
       FOR X = CURSORY + Y - 1 - BACKSPACE TO COLUNAS
           A$(X) = A$(X + 1)
       NEXT
       A$(COLUNAS) = ""
       COLUNAS = COLUNAS - 1
       GOSUB LISTA
       BACKSPACE = 0
       MUDANCA = 1
       RETURN

GRAVAR:
       LOCATE 23, 1: COLOR LS, TS: PRINT LIMPA$
       IF FRO$ <> "" THEN
        LOCATE 23, 1: PRINT " Deseja gravar o texto no ficheiro "; FRO$; " ? (S/N) "
        Y$ = UCASE$(INPUT$(1))
        IF Y$ = "N" THEN
          LOCATE 23, 1: COLOR LS, TS: PRINT LIMPA$
          E = 23
          Q = 25
          C2 = LS
          C1 = TS
          T$ = "Ficheiro  de destino:"
          CARAC$ = ""
          CALL CHC(E, Q, T$, D, C2, C1, CARAC$)

          IF CARAC$ = "" THEN
           GOSUB CORES
           RETURN
          END IF

          FRO$ = CARAC$
        ELSE
         IF Y$ <> "S" THEN
          GOTO GRAVAR
         END IF
        END IF
       ELSE
          E = 23
          Q = 25
          C2 = LS
          C1 = TS
          T$ = "Ficheiro  de destino:"
          CARAC$ = ""
          CALL CHC(E, Q, T$, D, C2, C1, CARAC$)
          FRO$ = CARAC$
       END IF
       IF FRO$ = "" THEN FRO$ = "SEMNOME.TXT"
CV:
       CLOSE #1
2 OPEN FRO$ FOR OUTPUT AS #1
         FOR X = 1 TO COLUNAS
           PRINT #1, A$(X)
         NEXT
       CLOSE #1
       MUDANCA = 0
       IF TOM = 2 THEN
        TOM = 0
        RETURN
       END IF
       IF F = 1 THEN SCREEN 0, 0, 0: END
       IF F = 2 THEN GOTO CARREGAR: F = 0
       GOSUB CORES
       RETURN

CARREGAR:
         COLOR LS, TS
         LOCATE 23, 1: PRINT LIMPA$
         IF MUDANCA <> 0 THEN
            LOCATE 23, 1: PRINT " O ficheiro actual n„o foi gravado. Gravar (S/N)?"
            C$ = ""
            DO UNTIL C = 1
               C$ = UCASE$(INKEY$)
               IF C$ = "S" THEN F = 2: GOSUB GRAVAR
               IF C$ = "N" THEN C = 1
            LOOP
         END IF
         LOCATE 23, 1: PRINT LIMPA$
         E = 23
         Q = 25
         C2 = LS
         C1 = TS
         T$ = "Qual o nome do ficheiro a carregar:"
         CARAC$ = ""
         CALL CHC(E, Q, T$, D, C2, C1, CARAC$)
         IF CARAC$ = "" THEN
          GOSUB CORES
          RETURN
         END IF

         FRO$ = CARAC$

         GOTO INICIO

PARTIRM:
                A1$ = MID$(A$(Y + CURSORY - 1), 1, HOR + CURSORX - 2)
                A2$ = MID$(A$(Y + CURSORY - 1), HOR + CURSORX - 1, LEN(A$(Y + CURSORY - 1)) - HOR + CURSORX - 1 + 1)
                A$(Y + CURSORY - 1) = A2$
                GOSUB ENTER
                A$(Y + CURSORY - 1) = A1$
                CURSORX = 1
                HOR = 1
                GOSUB LISTA
                RETURN

UNIR:
 A1$ = A$(Y + CURSORY - 1) + A$(Y + CURSORY)
 A$(Y + CURSORY) = A1$
 GOSUB APAGAR
 TOM = T
 RETURN

MACROUTINE:
 A1$ = MID$(A$(CURSORY + Y - 1), 1, CURSORX + HOR - 2)
 A2$ = MID$(A$(CURSORY + Y - 1), CURSORX + HOR - 1)
 A$(CURSORY + Y - 1) = A1$ + C$ + A2$
 CURSORX = CURSORX + LEN(C$)
 C$ = ""
 IF CURSORX > 80 THEN
  HOR = HOR + CURSORX - 79
  CURSORX = 79
 END IF
 GOSUB LISTA
 IF MUDANCA = 0 THEN MUDANCA = 1
 RETURN


PAGE2:
                MBN2 = CURSORY + Y - 1
                MBN = 43
                IF PAG$ = "80" AND LEN(A$(CURSORY + Y - 1)) > 80 THEN
                  FOR XT2 = 80 TO LEN(A$(CURSORY + Y - 1)) STEP 1
                   AXT2$ = MID$(A$(CURSORY + Y - 1), XT2, 1)
                   IF INSTR(AXT2$, " ") <> 0 THEN
                        MBN = 1
                        A1$ = MID$(A$(Y + CURSORY - 1), 1, XT2 - 1)
                        A2$ = MID$(A$(Y + CURSORY - 1), XT2 + 1, LEN(A$(Y + CURSORY - 1)) - XT2)
                        A$(Y + CURSORY - 1) = A2$
                        GOSUB ENTER
                        A$(Y + CURSORY - 1) = A1$
                        GOSUB LISTA
                        CURSORY = CURSORY + 1
                        IF XT > CURSORX + HOR - 1 THEN
                          CURSORY = CURSORY - 1
                        ELSE
                           CURSORX = CURSORX + HOR - XT - 1
                           IF CURSORX > 80 THEN
                             HOR = CURSORX - 78
                             CURSORX = 80
                           END IF
                        END IF
                        EXIT FOR
                   END IF
                  NEXT XT2
                END IF
                RETURN


DEFINT A-Z

