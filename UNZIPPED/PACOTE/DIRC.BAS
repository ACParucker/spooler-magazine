' Dir em duas colunas para Ms Dos 5.00, 6.00 e 6.20
' Por Jos‚ Fortunato H. Tom s

ON ERROR GOTO ERRO
IF INSTR(UCASE$(COMMAND$), "/HELP") <> 0 THEN ERROR 255
IF INSTR(UCASE$(COMMAND$), "/H") <> 0 OR INSTR(UCASE$(COMMAND$), "/?") <> 0 THEN
 SHELL "DIR /?"
 END
END IF

S$ = "DIR " + COMMAND$ + "/-P /-W >DIRC.DAT"
SHELL S$
OPEN "I", #1, "DIRC.DAT"
   PRINT
   PRINT
S% = -1: D% = -1



DO

 INPUT #1, A$
  
   IF EOF(1) <> 0 THEN
         
          IF POS(0) > 10 THEN
            LOCATE CSRLIN, 42
          ELSE
            LOCATE CSRLIN, 1
          END IF
    
     PRINT A$
     CLOSE #1
     EXIT DO
   END IF

 S% = S% + 1: D% = D% + 1

 IF INSTR(A$, "             ") <> 0 THEN
 ELSE
  IF LEN(A$) > 40 AND INSTR(A$, "-") <> 0 THEN
    IF INSTR(A$, "<DIR>") <> 0 THEN
     A$ = LEFT$(A$, 18) + MID$(A$, 22, LEN(A$) - 27) + RIGHT$(A$, 5)
    ELSE
     A$ = LEFT$(A$, 13) + MID$(A$, 17, LEN(A$) - 22) + RIGHT$(A$, 5)
    END IF
  END IF
 
  IF D% = 2 THEN
   LOCATE CSRLIN, 41
   S% = S% + 1: D% = D% + 1
  END IF

  IF INSTR(A$, "-") = 0 AND D% > 6 THEN
   IF POS(0) > 40 THEN
    PRINT
    S% = S% + 1: D% = D% + 1
   END IF
   A1$ = A$: INPUT #1, A$
   IF LEN(A$) > 40 AND POS(0) > 42 THEN S% = S% + 1: D% = D% + 1
   S% = S% + 1: D% = D% + 1
   LOCATE CSRLIN, 1
   PRINT A1$;
   LOCATE CSRLIN, 42
   PRINT A$
   IF EOF(1) <> 0 THEN
     CLOSE #1
     EXIT DO
   END IF
   GOTO GHJ
  END IF

  IF D% = 4 THEN
       PRINT A$; " "
       LOCATE CSRLIN, 1
  ELSE
       IF POS(0) < 40 THEN
        LOCATE CSRLIN, 1
       ELSE
         LOCATE CSRLIN, 42
       END IF
       PRINT A$; " ";
  END IF

GHJ:
 
  IF S% > 42 THEN
    S% = -1
    LOCATE 25, 1: PRINT TAB(1); "Pressione qualquer tecla para continuar . . .";
    P$ = UCASE$(INPUT$(1))
    LOCATE 25, 1: PRINT TAB(1); "                                               ";
    IF P$ = CHR$(27) THEN
      CLOSE #1
      EXIT DO
      PRINT "^C"
    END IF
    PRINT TAB(1);
  END IF
 END IF

 IF EOF(1) <> 0 THEN
  CLOSE #1
  EXIT DO
 END IF

LOOP

KILL "DIRC.DAT"

END

ERRO:
PRINT
PRINT " DIRC para Ms Dos vers”es 5.00, 6.00 e 6.20"
PRINT " Por Jos‚ Fortunato Tom s"
PRINT ""
PRINT " DIRC ‚ uma  alternativa … instru‡„o DIR do Dos para uma melhor"
PRINT " e mais compactada exibi‡„o da lista de ficheiros e direct¢rias."
PRINT " DIRC aceita todo o switch da instru‡„o DIR   excep‡„o de /P, /W"
PRINT " e /C[H]."
PRINT ""
PRINT " Para mais informa‡”es aconselha-se: <DIRC /?> ou <DIRC /H>"
RESET
IF ERR <> 255 THEN KILL "DIRC.DAT"
END

