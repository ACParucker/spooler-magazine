' Make Directory - Change Directory num s¢ passo.
' Por Jos‚ F. Tom s

ON ERROR GOTO ERRO
IF INSTR(UCASE$(COMMAND$), "/HELP") <> 0 THEN ERROR 255
ty% = 0
MKDIR COMMAND$
ty% = 1
CHDIR COMMAND$

END
ERRO:
IF ERR = 75 THEN RESUME NEXT
IF ERR = 70 THEN PRINT "Disco protegido contra grava‡„o!"
PRINT
PRINT " MDCD para Ms Dos 3.30 e posteriores vers”es."
PRINT " Por Jos‚ F. Tom s"
PRINT ""
PRINT " MDCD ‚ uma  alternativa … instru‡„o MD do Dos, pois quase sempre"
PRINT " que abrimos uma directoria precisamos de entrar logo nela da¡ ser"
PRINT " necess rio recorrer … instru‡„o CD. O MDCD ‚ a jun‡„o destas"
PRINT " duas instru‡”es do Dos (MD e CD) que cria e muda p'ra directoria"
PRINT " desejada (ao mesmo tempo)."
PRINT
PRINT " MDCD <drive:><directoria>"
END

