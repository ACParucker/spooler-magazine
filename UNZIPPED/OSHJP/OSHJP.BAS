ON ERROR GOTO 100
A$ = COMMAND$
H1 = VAL(LEFT$(A$, 2))
M1 = VAL(MID$(A$, 3, 2))
H2 = VAL(MID$(A$, 6, 2))
M2 = VAL(MID$(A$, 8, 2))
O$ = MID$(A$, 11, LEN(A$) - 10)
H = VAL(LEFT$(TIME$, 2))
M = VAL(MID$(TIME$, 4, 2))
IF H1 > H2 THEN GOTO 100
IF H1 = H2 AND M1 > M2 THEN GOTO 100
IF H1 < 0 OR H1 > 23 THEN GOTO 100
IF H2 < 0 OR H2 > 23 THEN GOTO 100
IF M1 < 0 OR M1 > 59 THEN GOTO 100
IF M2 < 0 OR M2 > 59 THEN GOTO 100

IF H < H1 THEN END
IF H > H2 THEN END
IF H = H1 AND M < M1 THEN END
IF H = H2 AND M > M2 THEN END

IF UCASE$(O$) = "BLOCK" THEN PRINT "O OSHJP acaba de bloquear o sistema.": DO: LOOP
IF UCASE$(RIGHT$(O$, 4)) = "BEEP" THEN PRINT LEFT$(O$, LEN(O$) - 4): BEEP: END
PRINT O$: END

100 BEEP: PRINT "OSHJP ver. 1.0 por: JOÇO MOTA"
PRINT
PRINT "Sintaxe:"
PRINT "OSHJP [ hora de encerramento ] [ hora de abertura ] [ mensagem... ] "
PRINT
PRINT "Formato da hora: hhmm hhmm"
PRINT "Exemplo: 0000 0959"
PRINT
PRINT "Mensagem - mensagem a apresentar se a hora do sistema se encontra entre as"
PRINT "duas introduzidas."
PRINT "BLOCK - Bloqueia completamente o sistema."
PRINT "Mensagem + BEEP - apresenta mensagem e emite som."
PRINT
END

