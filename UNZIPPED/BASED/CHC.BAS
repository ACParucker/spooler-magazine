DECLARE SUB CHC (LINHA, TAMANHO, TEXT$, t, CTEXTO, CTELA, CARAC$)
 CLS
 CHC 12, 15, "pROMPT : ", 0, 7, 0, "MER"

SUB CHC (LINHA, TAMANHO, TEXT$, t, CTEXTO, CTELA, CARAC$)

' Prepara‡„o e afecta‡„o de variaveis

 C3 = C2 + 16
 IF TEXT$ = "" THEN
  COLUNAINICIAL = t
 ELSE
  LOCATE LINHA, 3
  PRINT TEXT$
  COLUNAINICIAL = 4 + LEN(TEXT$)
 END IF
 COLUNA = COLUNAINICIAL
 COLUNAFINAL = COLUNA + TAMANHO
 INSERT = 95

 LOCATE LINHA, COLUNAINICIAL: COLOR CTEXTO, CTELA: PRINT STRING$(TAMANHO + 1, 255)



DO
  C$ = INKEY$
  ' ********************************* INSERT
  IF C$ = CHR$(0) + CHR$(82) THEN
   IF INSERT = 95 THEN
    INSERT = 219
   ELSE
    INSERT = 95
   END IF
   C$ = ""
  END IF
  '************************************************* TAB NŽO PERMITIDO
  IF C$ = CHR$(9) THEN C$ = ""
  '************************************************* ENTER
  IF C$ = CHR$(13) THEN EXIT DO
  '************************************************* DELETE
  IF C$ = CHR$(0) + CHR$(83) AND COLUNA - LEN(CARAC$) < COLUNAINICIAL THEN
    CARAC$ = MID$(CARAC$, 1, COLUNA - COLUNAINICIAL) + MID$(CARAC$, COLUNA - COLUNAINICIAL + 2)
    C$ = ""
    LOCATE LINHA, COLUNAINICIAL: COLOR CTEXTO, CTELA: PRINT STRING$(TAMANHO, 255)
    ANTCUR = 2
  END IF
  '************************************************* BACKESCAPE
  IF C$ = CHR$(8) THEN
    C$ = ""
    IF COLUNA > COLUNAINICIAL THEN
     LOCATE LINHA, COLUNAINICIAL: COLOR CTEXTO, CTELA: PRINT STRING$(COLUNAFINAL - COLUNAINICIAL + 1, 255)
     COLUNA = COLUNA - 1
     CARAC$ = MID$(CARAC$, 1, COLUNA - COLUNAINICIAL) + MID$(CARAC$, COLUNA - COLUNAINICIAL + 2)
     ANTCUR = -1
    END IF
  END IF
  '************************************************** HOME
  IF C$ = CHR$(0) + CHR$(71) THEN
   INI = COLUNA - COLUNAINICIAL + 1
   IF INI < 1 THEN INI = 1
   IF INI > LEN(CARAC$) THEN A$ = " " ELSE A$ = MID$(CARAC$, INI, 1)
   LOCATE LINHA, COLUNA: PRINT A$
   COLUNA = COLUNAINICIAL
   C$ = ""
  END IF
  '************************************************** END
  IF C$ = CHR$(0) + CHR$(79) THEN
   INI = COLUNA - COLUNAINICIAL
   IF INI < 1 THEN INI = 1
   LOCATE LINHA, COLUNA: PRINT MID$(CARAC$, INI, 1)
   COLUNA = LEN(CARAC$) + COLUNAINICIAL
   C$ = ""
  END IF
  '************************************************** CURSOR ESQUERDA
  IF C$ = CHR$(0) + CHR$(75) AND COLUNA > COLUNAINICIAL THEN
   COLUNA = COLUNA - 1
   ANTCUR = -1
  END IF
  '************************************************** CURSOR DIREITA
  IF C$ = CHR$(0) + CHR$(77) AND COLUNA < LEN(CARAC$) + COLUNAINICIAL THEN
   COLUNA = COLUNA + 1
   ANTCUR = 1
  END IF
  IF C$ <> "" THEN
   IF ASC(C$) < 32 OR ASC(C$) > 255 THEN C$ = ""
  END IF
 
 
  IF LEN(CARAC$) = TAMANHO + 1 AND INSERT = 219 AND C$ <> "" AND COLUNA = COLUNAFINAL THEN
    BEEP
    C$ = ""
  END IF
 
  IF LEN(C$ + CARAC$) = TAMANHO + 1 AND INSERT = 95 AND C$ <> "" THEN
    BEEP
    C$ = ""
  ELSE
   IF INSERT = 219 AND C$ <> "" AND COLUNA - COLUNAFINAL = 0 THEN
     BEEP
     C$ = ""
   END IF
  END IF
  IF ANTCUR = -1 THEN
   LOCATE LINHA, COLUNA + 1: COLOR CTEXTO, CTELA: PRINT CHR$(255)
   ANTCUR = 0
  ELSE
   IF ANTCUR = 1 THEN
    LOCATE LINHA, COLUNA: COLOR CTEXTO, CTELA: PRINT CHR$(255)
    ANTCUR = 0
   END IF
  END IF
  IF C$ <> "" THEN COLUNA = COLUNA + 1
'****************************************** Insere
  IF INSERT = 219 AND C$ <> "" THEN
    CARAC$ = MID$(CARAC$, 1, COLUNA - COLUNAINICIAL - 1) + C$ + MID$(CARAC$, COLUNA - COLUNAINICIAL + 1)
  END IF
  IF INSERT = 95 AND C$ <> "" THEN
   CARAC$ = MID$(CARAC$, 1, COLUNA - COLUNAINICIAL - 1) + C$ + MID$(CARAC$, COLUNA - COLUNAINICIAL)
  END IF

 
  LOCATE LINHA, COLUNA: COLOR CTEXTO + 16, CTELA: PRINT CHR$(INSERT)
  IF ANTCUR = 2 THEN
   ANTCUR = 0
   M = 0
  ELSE
   M = 5
  END IF
  S# = TIMER
  T2# = M / 500 'SPEEDCONST
  DO
  LOOP UNTIL TIMER - S# > T2#
  LOCATE LINHA, COLUNAINICIAL: COLOR CTEXTO, CTELA: PRINT CARAC$
  S# = TIMER
  T2# = 2 / 500 'SPEEDCONST
  DO
  LOOP UNTIL TIMER - S# > T2#
  COLOR CTEXTO, CTELA
LOOP
END SUB

