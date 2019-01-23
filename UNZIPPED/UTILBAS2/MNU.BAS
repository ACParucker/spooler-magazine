DECLARE SUB TEXTO (t$)
DECLARE SUB MENU ()
DECLARE SUB ERRO (t$)
DECLARE SUB TITULO (title$)

arquivo$ = COMMAND$
IF arquivo$ = "" OR arquivo$ = "/?" OR arquivo$ = "/H" THEN
	PRINT "Forma de uso: MNU arquivo.MNU"
	PRINT
	PRINT "Extrutura do arquivo MNU:"
	PRINT
	PRINT "       1¦ Linha = Titulo do men£"
	PRINT "       2¦ Linha = Total de op‡”es,op‡„o maior"
	PRINT "       3¦ linha at‚ ao fim = Op‡„o,Tecla de acesso,posicao,comando"
	PRINT
	PRINT "posicao - valor num‚rico entre 1 e 80 - corrspondendo … coluna"
	PRINT "opcao - Descritivo dentro de aspas (" + CHR$(34) + CHR$(34) + ")"
	PRINT "tecla de acesso - Letra correspondendo … tecla de acesso r pido dentro de as-"
	PRINT "                  pas (" + CHR$(34) + CHR$(34) + ")"
	PRINT "comando - Nome de um comando, arquivo BAT, etc, a ser evocado dentro de as-"
	PRINT "          pas (" + CHR$(34) + CHR$(34) + ")"
	PRINT
	END
END IF
go$ = ENVIRON$("MNUBAT")
opc$ = ENVIRON$("MNUOPC")
fim$ = ENVIRON$("MNUCTL")
ON ERROR GOTO corrige
OPEN opc$ FOR BINARY AS #1: size = LOF(1): CLOSE
IF size <> 0 THEN
	OPEN opc$ FOR INPUT AS #1
	INPUT #1, posicao
	CLOSE
	KILL opc$
ELSE
	posicao = 1
        KILL opc$
END IF
COLOR 7, 1, 1: CLS
OPEN arquivo$ FOR BINARY AS #1: size = LOF(1): CLOSE
IF size = 0 THEN KILL arquivo$: ERROR 53
OPEN arquivo$ FOR INPUT AS #1
INPUT #1, title$
INPUT #1, opcoes, maior
DIM opcao$(1 TO opcoes), linha(1 TO opcoes), teclas$(1 TO opcoes), comando$(1 TO opcoes), tposicao(1 TO opcoes)
FOR opcao = 1 TO opcoes
	INPUT #1, opcao$(opcao), teclas$(opcao), tposicao(opcao), comando$(opcao)
	linha(opcao) = opcao + 5
	coluna(opcao) = 40 - LEN(opcao$(opcao)) \ 2
NEXT
CLOSE
UP.key$ = CHR$(0) + "H"
DOWN.key$ = CHR$(0) + "P"
ESC.key$ = CHR$(27)
ENTER.key$ = CHR$(13)
HOME.key$ = CHR$(0) + "G"
END.key$ = CHR$(0) + "O"
TITULO title$
mnu:
MENU
GOSUB poe.barra
DO
	tecla$ = UCASE$(INKEY$)
	IF tecla$ = UP.key$ THEN
		posicao = posicao - 1
		IF posicao < 1 THEN posicao = opcoes
		GOSUB poe.barra
	END IF
	IF tecla$ = DOWN.key$ THEN
		posicao = posicao + 1
		IF posicao > opcoes THEN posicao = 1
		GOSUB poe.barra
	END IF
	IF tecla$ = HOME.key$ THEN
		posicao = 1
		FOR j = 1 TO opcoes
			LOCATE linha(j), coluna(j): COLOR 3, 1: PRINT opcao$(j)
		NEXT
		FOR j = 1 TO opcoes
			LOCATE linha(j), coluna(j) + tposicao(j)
			COLOR 14, 4
			PRINT teclas$(j)
		NEXT
		GOSUB poe.barra
	END IF
	IF tecla$ = END.key$ THEN
		posicao = opcoes
		FOR j = 1 TO opcoes
			LOCATE linha(j), coluna(j)
			COLOR 3, 1
			PRINT opcao$(j)
		NEXT
		FOR j = 1 TO opcoes
			LOCATE linha(j), coluna(j) + tposicao(j)
			COLOR 14, 4
			PRINT teclas$(j)
		NEXT
		GOSUB poe.barra
	END IF
	IF tecla$ = ENTER.key$ THEN
		OPEN opc$ FOR OUTPUT AS #1
		PRINT #1, posicao
		CLOSE
		OPEN go$ FOR OUTPUT AS #1
		PRINT #1, "@ECHO OFF"
                PRINT #1, "CLS"
                PRINT #1, "CALL " + comando$(posicao)
		CLOSE
		END
	END IF
	IF tecla$ = ESC.key$ THEN
		EXIT DO
	END IF
	IF tecla$ <> "" THEN
		FOR j = 1 TO opcoes
			IF tecla$ = teclas$(j) THEN ok = -1: posicao = j: EXIT FOR
		NEXT
		IF ok THEN
			FOR j = 1 TO opcoes
				LOCATE linha(j), coluna(j)
				COLOR 3, 1
				PRINT opcao$(j)
			NEXT
			FOR j = 1 TO opcoes
				LOCATE linha(j), coluna(j) + tposicao(j)
				COLOR 14, 4
				PRINT teclas$(j)
			NEXT
			GOSUB poe.barra
			OPEN opc$ FOR OUTPUT AS #1
			PRINT #1, posicao
			CLOSE
			OPEN go$ FOR OUTPUT AS #1
			PRINT #1, "@ECHO OFF"
                        PRINT #1, "CLS"
                        PRINT #1, "CALL " + comando$(posicao)
			CLOSE
			END
		END IF
	END IF
LOOP
fim:
COLOR 7, 0, 0: CLS
OPEN fim$ FOR OUTPUT AS #1
PRINT #1, CHR$(251)
CLOSE
END

poe.barra:
	antes = posicao - 1
	depois = posicao + 1
	IF antes < 1 THEN antes = opcoes
	IF depois > opcoes THEN depois = 1
	COLOR 15, 3
	LOCATE linha(antes), coluna(antes): PRINT opcao$(antes)
	LOCATE linha(depois), coluna(depois): PRINT opcao$(depois)
	COLOR 14, 3
	LOCATE linha(antes), coluna(antes) + tposicao(antes): PRINT teclas$(antes)
	LOCATE linha(depois), coluna(depois) + tposicao(depois): PRINT teclas$(depois)
	COLOR 11, 4
	LOCATE linha(posicao), coluna(posicao): PRINT opcao$(posicao)
	COLOR 3, 1
RETURN

corrige:
	ERRO "Erro " + RTRIM$(STR$(ERR)) + " no programa!"
END

SUB ERRO (t$)
	COLOR 14, 4
	LOCATE 20, 79 - LEN(t$) - 1: PRINT CHR$(201) + STRING$(LEN(t$), CHR$(205)) + CHR$(187);
	LOCATE 22, 79 - LEN(t$) - 1: PRINT CHR$(200) + STRING$(LEN(t$), CHR$(205)) + CHR$(188);
	LOCATE 21, 79 - LEN(t$) - 1: PRINT CHR$(186); t$; CHR$(186);
	COLOR 7, 3
END SUB

SUB MENU
	SHARED maior, opcoes, opcao$(), linha(), coluna(), teclas$(), tposicao()
	COLOR 1, 3
	LOCATE linha(1) - 1, coluna(maior) - 1: PRINT CHR$(32); STRING$(LEN(opcao$(maior)), CHR$(32)); CHR$(32)
	FOR l = linha(1) TO linha(1) + opcoes
		LOCATE l, coluna(maior) - 1: PRINT CHR$(32); STRING$(LEN(opcao$(maior)), CHR$(32)); CHR$(32)
	NEXT
	LOCATE linha(1) + opcoes, coluna(maior) - 1: PRINT CHR$(32); STRING$(LEN(opcao$(maior)), CHR$(32)); CHR$(32)
	COLOR 0, 1
	LOCATE linha(1) - 1, 41 + (LEN(opcao$(maior)) \ 2): PRINT "Ü"
	FOR lin = linha(1) TO linha(1) + opcoes
		COLOR 0, 0: LOCATE lin, 41 + (LEN(opcao$(maior)) \ 2): PRINT " "
	NEXT
	COLOR 0, 1
	LOCATE linha(1) + opcoes + 1, coluna(maior): PRINT STRING$(LEN(opcao$(maior)) + 2, "ß")
	FOR j = 1 TO opcoes
		LOCATE linha(j), coluna(j)
		COLOR 15, 3
		PRINT opcao$(j)
	NEXT
	FOR j = 1 TO opcoes
		LOCATE linha(j), coluna(j) + tposicao(j)
		COLOR 14, 3
		PRINT teclas$(j)
	NEXT
	box.size = LEN(opcao$(maior)) + 4
	center.box = box.size \ 2
	t$ = " " + CHR$(25) + ", " + CHR$(24) + " = Mover, " + CHR$(255) + " = Escolher, ESC = Sair "
	COLOR 14, 3
	LOCATE 25, 1: PRINT SPACE$(80);
	LOCATE 25, 40 - LEN(t$) \ 2, 0: PRINT t$;
	COLOR 7, 1
END SUB

SUB TEXTO (t$)
	COLOR 11, 3
	LOCATE 20, 79 - LEN(t$) - 1: PRINT CHR$(201) + STRING$(LEN(t$), CHR$(205)) + CHR$(187);
	LOCATE 22, 79 - LEN(t$) - 1: PRINT CHR$(200) + STRING$(LEN(t$), CHR$(205)) + CHR$(188);
	LOCATE 21, 79 - LEN(t$) - 1: PRINT CHR$(186); t$; CHR$(186);
	COLOR 7, 3
END SUB

SUB TITULO (title$)
	COLOR 15, 3
	LOCATE 1, 1: PRINT SPACE$(80);
	LOCATE 1, 40 - LEN(title$) \ 2: PRINT title$
	COLOR 7, 1
END SUB

