PRINT "SEGURO v1.1"
PRINT "Por RUI PACHECO"
PRINT "Janeiro 1994"
X$ = COMMAND$
IF UCASE$(X$) = "/I" THEN
      C = 1
      ON ERROR GOTO ERRO
      OPEN "C:\DOS\DIR.DAT" FOR INPUT AS #1
      INPUT #1, DIR$
      CLOSE
      INST = 1
CONT:
    IF INST = 1 THEN
       PRINT
       PRINT TAB(5); "PROGRAMA J† INSTALADO"
       END
    END IF
   
    IF INST = 0 THEN
       PRINT
       DO WHILE DIR$ = ""
       INPUT "   Unidade e Direct¢rio de destino: ", DIR$
       LOOP
       COM1$ = "MD " + DIR$ + " >NUL"
       COM2$ = "COPY INSTALA.EXE " + DIR$ + " >NUL"
       COM3$ = "COPY MARCA.EXE " + DIR$ + " >NUL"
       COM4$ = "COPY SEGURO.EXE " + DIR$ + " >NUL"
       SHELL COM1$
       SHELL COM2$
       SHELL COM3$
       SHELL COM4$
       OPEN "C:\DOS\DIR.DAT" FOR OUTPUT AS #1
       PRINT #1, DIR$
       CLOSE
       OPEN "C:\XXXXXXXX.XXX" FOR OUTPUT AS #1
       MARCA$ = "@ " + UCASE$(DIR$) + "\MARCA.EXE"
       PRINT #1, MARCA$
       CLOSE
       SHELL "ATTRIB -H C:\AUTOEXEC.BAT >NUL"
       SHELL "COPY C:\XXXXXXXX.XXX+C:\AUTOEXEC.BAT C:\A.BBB >NUL": KILL "C:\XXXXXXXX.XXX"
       SHELL "COPY C:\AUTOEXEC.BAT " + DIR$ + "\A.BBB >NUL"
       SHELL "COPY C:\A.BBB C:\AUTOEXEC.BAT >NUL"
       SHELL "DEL C:\A.BBB"
       PRINT
       PRINT TAB(5); "PROGRAMA INSTALADO"
       END IF
END IF


IF UCASE$(X$) = "/D" THEN
      C = 2
      ON ERROR GOTO ERRO
      OPEN "C:\DOS\DIR.DAT" FOR INPUT AS #1
      INPUT #1, DIR$
      CLOSE
      INST = 1
CONT1:
    IF INST = 0 THEN
       PRINT
       PRINT TAB(5); "PROGRAMA NŽO INSTALADO"
       END
    END IF
    IF INST = 1 THEN
        COM1$ = "DEL " + DIR$ + "\SEGURO.EXE >NUL"
        COM2$ = "DEL " + DIR$ + "\INSTALA.EXE >NUL"
        COM3$ = "DEL " + DIR$ + "\MARCA.EXE >NUL"
        COM4$ = "DEL " + DIR$ + "\REGISTO.DAT >NUL"
        COM5$ = "DEL " + DIR$ + "\NUMERO.NUM >NUL"
        COM6$ = "COPY " + DIR$ + "\A.BBB C:\AUTOEXEC.BAT >NUL"
        COM7$ = "DEL " + DIR$ + "\A.BBB >NUL"
        COM8$ = "CD " + LEFT$(DIR$, 2) + "\"
        COM9$ = "RD " + DIR$ + " >NUL"
        COM10$ = "DEL C:\DOS\DIR.DAT >NUL"
        SHELL COM1$
        SHELL COM2$
        SHELL COM3$
        SHELL COM4$
        SHELL COM5$
        SHELL COM6$
        SHELL COM7$
        SHELL COM8$
        SHELL COM9$
        SHELL COM10$
        PRINT
        PRINT TAB(5); "PROGRAMA DESINSTALADO"
        END
    END IF
END IF

IF X$ = "" OR UCASE$(X$) <> "/I" AND UCASE$(X$) <> "/D" THEN
PRINT
PRINT TAB(3); "SINTAXE:   INSTALA  [/I] [/D]"
PRINT
PRINT TAB(6); "/I        Instala‡„o do programa SEGURO"
PRINT TAB(6); "/D        Desinstala‡„o do programa SEGURO"
END IF
END
ERRO:
INST = 0
IF C = 1 THEN GOTO CONT
IF C = 2 THEN GOTO CONT1
END

