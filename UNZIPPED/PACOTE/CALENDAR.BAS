DEFINT A-Z
TYPE MESTIPO
   NUMERO AS INTEGER
   MESNOME AS STRING * 9
END TYPE

DECLARE FUNCTION ANOBISSEXTO% (N%)
DECLARE FUNCTION ENTRADADADOS% (PROMPT$, LINHA%, ANOMENOR%, ANOMAIOR%)

DECLARE SUB PRINTCALENDARIO (ANO%, MES%)
DECLARE SUB CALCULOMES (ANO%, MES%, PRIMEIRODIA%, TOTALDIAS%)
DECLARE SUB IMPRESSORA ()

ON ERROR GOTO ERRO
DIM MESDATA(1 TO 12) AS MESTIPO

FOR I = 1 TO 12
   READ MESDATA(I).MESNOME, MESDATA(I).NUMERO
NEXT

LOOPER:
IMPR = 0
CLS


DO

   ANO = ENTRADADADOS("Ano pertendido (1 a 3000): ", 5, 1, 3000)
     PRINT " Pertende imprimir o calend rio (S/N)?";
     y$ = UCASE$(INPUT$(1))
     IF y$ = "S" THEN
      IMPR = 1
     ELSE
      IMPR = 0
     END IF
 
  FOR IM = 1 TO 12
    MES = IM
   IF IM = 1 THEN
   ELSE
    PRINTCALENDARIO ANO, MES
   END IF
   IF IM MOD 4 = 0 OR IM = 1 THEN
        IF IM <> 1 THEN
         IF IMPR <> 0 THEN IMPRESSORA
         LOCATE 24, 1: PRINT "Qualquer tecla p/ continuar ...";
         t$ = UCASE$(INPUT$(1))
         IF t$ = CHR$(27) THEN
          CLS
          END
         END IF
         LOCATE 24, 1: PRINT "                                  ";
        END IF
        LOCATE 1, 1
        PRINT "ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "บ                                                                           บ";
        PRINT "ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ";
        IF IM = 1 THEN
            PRINTCALENDARIO ANO, MES
        END IF

   END IF
NEXT IM
   LOCATE 12, 31
   PRINT "Novo ano (S/N)? ";
   LOCATE , , 1, 0, 13
                        
   Resp$ = INPUT$(1)
   CLS

LOOP WHILE UCASE$(Resp$) = "S"
CLS
END
ERRO:
 IF ERR = 25 THEN
  SCREEN 0, 0, 0, 0
  BEEP
  LOCATE 11, 30: PRINT "Erro no dispositivo."
  LOCATE 13, 30: PRINT "Impressora inactiva."
  SLEEP 6: D$ = INPUT$(1)
  RESUME LOOPER
 END IF


DATA Janeiro, 31, Fevereiro, 28, Maro, 31
DATA Abril, 30, Maio, 31, Junho, 30, Julho, 31, Agosto, 31
DATA Setembro, 30, Outubro, 31, Novembro, 30, Dezembro, 31

FUNCTION ANOBISSEXTO (N) STATIC
   ANOBISSEXTO = (N MOD 4 = 0 AND N MOD 100 <> 0) OR (N MOD 400 = 0)
END FUNCTION

SUB CALCULOMES (ANO, MES, PRIMEIRODIA, TOTALDIAS) STATIC
   SHARED MESDATA() AS MESTIPO
   CONST LEAP = 366 MOD 7
   CONST NORMAL = 365 MOD 7

   NUMDAYS = 0
   FOR I = 1899 TO ANO - 1
      IF ANOBISSEXTO(I) THEN
         NUMDAYS = NUMDAYS + LEAP
      ELSE
         NUMDAYS = NUMDAYS + NORMAL
      END IF
   NEXT

   FOR I = 1 TO MES - 1
      NUMDAYS = NUMDAYS + MESDATA(I).NUMERO
   NEXT

   TOTALDIAS = MESDATA(MES).NUMERO

   IF ANOBISSEXTO(ANO) THEN

      IF MES > 2 THEN
         NUMDAYS = NUMDAYS + 1

      ELSEIF MES = 2 THEN
         TOTALDIAS = TOTALDIAS + 1

      END IF
   END IF

   PRIMEIRODIA = NUMDAYS MOD 7
END SUB

FUNCTION ENTRADADADOS (PROMPT$, LINHA, ANOMENOR, ANOMAIOR) STATIC


   PRINT "ษออออออออออออออออออออออออออออออออออออออออป"
   PRINT "บ Planificador de calend rios desde 1    บ"
   PRINT "บ at 3000, em Qbasic por Jos F. Tom s. บ"
   PRINT "ศออออออออออออออออออออออออออออออออออออออออผ"

   LOCATE LINHA, 2, 1, 0, 13
   PRINT PROMPT$;

   COLUNA = POS(0)

   DO
      LOCATE LINHA, COLUNA
      PRINT SPACE$(10)
      LOCATE LINHA, COLUNA
      INPUT "", VALOR
   LOOP WHILE (VALOR < ANOMENOR OR VALOR > ANOMAIOR)

   ENTRADADADOS = VALOR

END FUNCTION

DEFSNG A-Z
SUB IMPRESSORA
   LPRINT CHR$(27) + CHR$(10);
   LPRINT CHR$(27) + CHR$(71);
   LPRINT CHR$(27) + CHR$(77);
   LPRINT CHR$(15)
   
    DIM ar(2)
    DEF SEG = VARSEG(ar(0))
    FOR ir = 0 TO 2
       IF ir = 0 THEN df = 205
       IF ir = 1 THEN df = 5
       IF ir = 2 THEN df = 203
       POKE VARPTR(ar(0)) + ir, df
    NEXT ir
    CALL ABSOLUTE(VARPTR(ar(0)))
    DEF SEG
 
  LPRINT CHR$(18)

END SUB

DEFINT A-Z
SUB PRINTCALENDARIO (ANO, MES) STATIC
SHARED MESDATA() AS MESTIPO

   CALCULOMES ANO, MES, PRIMEIRODIA, TOTALDIAS

    LOCATE 2, 36: PRINT STR$(ANO)
    ETIQUETAMES$ = RTRIM$(MESDATA(MES).MESNOME)

   MARGEMESQUERDA = (35 - LEN(ETIQUETAMES$)) \ 2
   IF MES = 1 OR MES = 5 OR MES = 9 THEN
    LIN = 3
    TB = 2
   END IF
   IF MES = 2 OR MES = 6 OR MES = 10 THEN
    LIN = 3
    TB = 42

   END IF
   IF MES = 3 OR MES = 7 OR MES = 11 THEN
    LIN = 14
    TB = 2

   END IF
   IF MES = 4 OR MES = 8 OR MES = 12 THEN
    LIN = 14
    TB = 42

   END IF


   LOCATE LIN, TB: PRINT "            "; ETIQUETAMES$; "         "
   LOCATE LIN + 1, TB: PRINT
   LOCATE LIN + 2, TB: PRINT " Dom  Seg  Ter  Qua  Qui  Sex  Sab"

   MARGEMESQUERDA = 5 * PRIMEIRODIA + TB + 1
   LOCATE , MARGEMESQUERDA

   FOR I = 1 TO TOTALDIAS
      I$ = RIGHT$(STR$(I), 2)

'FERIADOS SEGUNDO OS CALENDRIOS EM VIGOR NAS DCADAS DE 80 E 90 EM PORTUGAL
      IF MES = 1 AND I = 1 THEN I$ = " F"
      IF MES = 4 AND I = 25 THEN I$ = " F"
      IF MES = 5 AND I = 1 THEN I$ = " F"
      IF MES = 6 AND I = 10 THEN I$ = " F"
      IF MES = 8 AND I = 15 THEN I$ = " F"
      IF MES = 10 AND I = 5 THEN I$ = " F"
      IF MES = 11 AND I = 1 THEN I$ = " F"
      IF MES = 12 AND I = 1 THEN I$ = " F"
      IF MES = 12 AND I = 25 THEN I$ = " F"
'***************************************************************************
     
      IF POS(0) > 72 THEN
       LOCATE CSRLIN, POS(0): PRINT USING "& "; I$;
      ELSE
       LOCATE CSRLIN, POS(0): PRINT USING "&   "; I$;
      END IF

      IF TB = 2 THEN
       IF POS(0) > 36 THEN
        PRINT
        LOCATE , TB + 1, 0
       END IF
      ELSE
       IF POS(0) > 74 THEN
        PRINT
        LOCATE , TB + 1, 0
       END IF
      END IF
   NEXT

END SUB

