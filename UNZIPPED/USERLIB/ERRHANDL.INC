'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                     QUICK BASIC IV - FICHA T륝NICA                        �
'쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'� Software................: -                                               �
'� M줰ulo,Execut쟶el.......: ERRHANDL.INC                                    �
'� Vers꼘 (Idioma),rev.....: 2.0 (P), 01/06/94                               �
'� Cliente.................: -                                               �
'� Autor...................: N굃io Abreu                                     �
'� Copyright...............: 1993                                            �
'� Data de cria뇙o.........: 18/09/93                                        �
'� Interface de v죆eo......: Texto                                           �
'� Ambiente................: DOS                                             �
'� Interface de sistema....: Monoposto                                       �
'� Sistema operativo.......: MS/PC/DR-DOS vers꼘 2 ou superior               �
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                         FINALIDADE DO SOFTWARE                            �
'쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�    Rutinas de controlo de erro.                                           �
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

error.handler:
  'De forma a evitar a cria뇙o de uma array STATIC (permanente), definir limites
  'em variaveis, o que origina a cria뇙o de uma array DYNAMIC (tempor쟲io), sendo
  'possivel a sua remo뇙o da mem줿ia
  starting.line% = 21
  ending.line% = 24
  DIM error.screen$(starting.line% TO ending.line%)
  'Memoriza as posi뇯es actuais do cursor e a cor
  actual.line% = CSRLIN
  actual.column% = POS(x)
  actual.attribut% = SCREEN(actual.line%,actual.column%,1)
  color.code$ = HEX$(actual.attribut%)
  IF LEN(color.code$) < 2 THEN color.code$ = "0" + color.code$
  foreground$ = RIGHT$(color.code$,1)
  background$ = LEFT$(color.code$,1)
  SELECT CASE foreground$
    CASE "A"
      foreground = 10
    CASE "B"
      foreground = 11
    CASE "C"
      foreground = 12
    CASE "D"
      foreground = 13
    CASE "E"
      foreground = 14
    CASE "F"
      foreground = 15
    CASE ELSE
      foreground = VAL(foreground$)
  END SELECT
  SELECT CASE background$
    CASE "A"
      background = 10
    CASE "B"
      background = 11
    CASE "C"
      background = 12
    CASE "D"
      background = 13
    CASE "E"
      background = 14
    CASE "F"
      background = 15
    CASE ELSE
      background = VAL(background$)
  END SELECT
  error.code = ERR
  error.line = ERL
  cod$ = MID$(STR$(error.code), 2) + "/" + MID$(STR$(error.line),2)
  SELECT CASE error.code
    CASE 5
      BEEP
      warning$ = "Chamada ilegal de fun뇙o - Erro/Linha #" + cod$
    CASE 6
      BEEP
      warning$ = "Overflow - Erro/Linha  #" + cod$
    CASE 7
      BEEP: SLEEP 1: BEEP
      warning$ = "Sem mem줿ia - Erro/Linha  #" + cod$
    CASE 11
      BEEP
      warning$ = "Divis꼜o por zero - Erro/Linha  #" + cod$
    CASE 13
      BEEP
      warning$ = "Erro de equipara뇙o - Erro/Linha  #" + cod$
    CASE 14
      BEEP: SLEEP 1: BEEP
      warning$ = "Sem espa뇇 na 쟲ea de string - Erro/Linha  #" + cod$
    CASE 24
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Impressora OFF-LINE - Erro/Linha  #" + cod$
    CASE 25
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Erro de comunica뇙o com a impressora - Erro/Linha  #" + cod$
    CASE 27
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Impressora sem papel - Erro/Linha  #" + cod$
    CASE 51
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$(2) = "Erro interno - Erro/Linha  #" + cod$
    CASE 53
      BEEP
      warning$ = "Ficheiro n꼘 encontrado - Erro/Linha  #" + cod$
    CASE 57
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Erro de I/O (Leitura/Escrita) - Erro/Linha  #" + cod$
    CASE 61
      BEEP
      warning$ = "Disco cheio - Erro/Linha  #" + cod$
    CASE 62
      BEEP
      warning$ = "^Z (<EOF>) n꼘 encontrado - Erro/Linha  #" + cod$
    CASE 67
      BEEP
      warning$ = "Muitos ficheiros no direct줿io corrente - Erro/Linha  #" + cod$
    CASE 68
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Dispositivo n꼘 existente - Erro/Linha  #" + cod$
    CASE 70
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Disco protegido contra escrita - Erro/Linha  #" + cod$
    CASE 71
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Drive sem disco - Erro/Linha  #" + cod$
    CASE 72
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Disco n꼘 formatado - Erro/Linha  #" + cod$
    CASE 75
      BEEP
      warning$ = "Acesso recusado - Erro/Linha  #" + cod$
    CASE 76
      BEEP
      warning$ = "Direct줿io desconhecido - Erro/Linha  #" + cod$
    CASE ELSE
      BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP: SLEEP 1: BEEP
      warning$ = "Erro desconhecido - Erro/Linha  #" + cod$
      beps = 5
  END SELECT
  'A sec뇙o seguinte salva uma por뇙o do ecran, afim de ser exibida a mensagem
  'de erro, sendo a mesma reposta em seguida. Apesar de existir os procedimentos
  'de memoriza뇙o da imagem, afim de expandir a rutina de erros em quest꼘
  'sem recurso � LIB, o c줰igo dos referidos procedimentos foi desdobrado nesta
  'rutina.
  'Obtem o tamanho da mensagem adicionando 2 unidades para a box
  tamanho.da.mensagem% = LEN(warning$) + 2
  'Impress꼘 na linha 21,22,23,24 desde a coluna 75 (para o inicio)
  'Percorre da linha 21 � 24 desde a coluna 75-tamanho.da.mensagem% at� 75
  'L� os caracteres l� existentes (SCREEN(linha%,coluna%))
  FOR linha% = 21 TO 24
    FOR coluna% = 75 - tamanho.da.mensagem% TO 75
      error.screen$(linha%) = error.screen$(linha%) + CHR$(SCREEN(linha%,coluna%))
    NEXT
  NEXT
  'Forma a mensagem dentro da box
  top.msg$ = CHR$(201) + STRING$(tamanho.da.mensagem% - 2, CHR$(205)) + CHR$(187)
  midle.msg.1$ = CHR$(186) + warning$ + CHR$(186)
  midle.msg.2$ = CHR$(186) + "[R]epetir, [A]nular, [C]ontinuar " + SPACE$((tamanho.da.mensagem% - 2)-33) + CHR$(186)
  bottom.msg$ = CHR$(200) + STRING$(tamanho.da.mensagem% - 2, CHR$(205)) + CHR$(188)
  'Exibe a mensagem em amarelo sobre vermelho
  COLOR 14,4
  LOCATE 21,75-tamanho.da.mensagem%:PRINT top.msg$;
  LOCATE 22,75-tamanho.da.mensagem%:PRINT midle.msg.1$;
  LOCATE 23,75-tamanho.da.mensagem%:PRINT midle.msg.2$;
  LOCATE 24,75-tamanho.da.mensagem%:PRINT bottom.msg$;
  'Repo a cor anterior
  COLOR foreground,background
  DO
    DO
      tecla$ = UCASE$(INKEY$)
      IF tecla$<>"" THEN EXIT DO
    LOOP
    IF tecla$ = "A" OR tecla$ = "R" OR tecla$ ="C" THEN EXIT DO
    BEEP
  LOOP
  IF tecla$ = "A" THEN COLOR 7,0 : END
  IF tecla$ = "R" THEN
    'Repoe o ecran
    FOR linha%=21 TO 24
      LOCATE linha%,75 - tamanho.da.mensagem%:PRINT error.screen$(linha%);
    NEXT
    ERASE error.screen$
    'Repoe as coordenadas anteriores
    LOCATE actual.line%,actual.column%
    RESUME
  ENDIF
  IF tecla$ = "C" THEN
    'Repoe o ecran
    FOR linha%=21 TO 24
      LOCATE linha%,75 - tamanho.da.mensagem%:PRINT error.screen$(linha%);
    NEXT
    ERASE error.screen$
    'Repoe as coordenadas anteriores
    LOCATE actual.line%,actual.column%
    RESUME NEXT
  ENDIF
END

