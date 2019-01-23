IF COMMAND$ = "" THEN PRINT "Parametro solicitado inexistente.": END
ON ERROR GOTO 100
5 CHDIR COMMAND$: PRINT "Direct¢rio j  existente": END
10 MKDIR COMMAND$
20 CHDIR COMMAND$
END
100 IF ERL = 10 THEN PRINT "Nao ‚ poss¡vel criar dir‚ctorio.": END
IF ERL = 5 THEN RESUME 10

