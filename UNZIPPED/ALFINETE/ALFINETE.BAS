'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�              旼� 旼컴컴캠 旼컴컴캠 旼컴컴캠    旼컴컴캠 旼컴컴캠          �
'�              � � � 靈커 � � 靈컴캭 � 靈커 �    읏 靈� � � 靈커 �          �
'�              � � � �  � � � � 旼캠 � �  � �     � � � � � �  � �          �
'�          旼� � � � �  � � � � 읏 � � �  � �     � � � � � �  � �          �
'�          � 聃� � � 聃켸 � � 聃켸 � � 聃켸 �    粕 聃� � � 聃켸 �          �
'�          읕컴컴� 읕컴컴캭 읕컴컴캭 읕컴컴캭    읕컴컴캭 읕컴컴캭          �
'�      旼컴컴캠 旼�    旼컴컴� 旼컴� 旼컴�  旼� 旼컴컴� 旼컴컴� 旼컴컴�     �
'�      � 靈커 � � �    � 靈컴� 읏 笭 �   獺 � � � 靈컴� 읕� 靈� � 靈컴�     �
'�      � 聃켸 � � �    � 聃�    � �  � 퓻 獺� � � 聃�     � �   � 聃�       �
'�      � 靈커 � � �    � 靈�    � �  � 봉� 鍛 � � 靈�     � �   � 靈�       �
'�      � �  � � � 聃캠 � �     粕 獺 � � 읏   � � 聃컴�   � �   � 聃컴�     �
'�      읕�  읕� 읕컴캭 읕�     읕컴� 읕�  읕컴� 읕컴컴�   읕�   읕컴컴�     �
'�                                                                           �
'�      Programa뇙o de Hugo Ferreira, 1992.                                  �
'�      Programado em Microsoft QuickBASIC 4.50                              �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

DECLARE SUB Instrucao ()
DECLARE SUB PedirNomes ()
DECLARE SUB Menu ()
DECLARE SUB PrintXY (X%, Y%, Posi%, Color1%, Color2%, Text$)
DECLARE SUB LimparEspacos (opcao%)
DECLARE SUB InputLinha ()
DECLARE SUB PrimeiroPalito ()
DECLARE SUB UltimoPalito ()
DECLARE SUB RotinaDeERRO ()
DECLARE SUB Verificacoes (opcao%)
DECLARE SUB Caixa (Linha1%, Coluna1%, Linha2%, Coluna2%, Color1%, Color2%)
DECLARE SUB EcraDoJogo ()
DECLARE SUB ImprimirAgulhas ()
DECLARE SUB Apresentacao ()
DECLARE FUNCTION PerguntarNome$ (X%, Y%)

'Todas as variaveis de tipo n꼘 declaradas no programa, s꼘 do tipo inteiro.
'DEFenir INTeiro A - Z (de A a Z): EXEMPLO; ERRO, TRUE, FALSE, L1, FimDoJogo
DEFINT A-Z

'Constantes Booleanas 0=Falso, 1=Veradeiro
 CONST TRUE = 1, FALSE = 0

'Declara뇙o de dim's, ARRAY's que v꼘 ter a situa뇙o dos alfinetes(apagados ou n꼘)
'ARRAY's com o nome dos jogadores
 DIM SHARED Fila1(1 TO 7) AS INTEGER, Fila2(1 TO 5) AS INTEGER, Fila3(1 TO 3) AS INTEGER
 DIM SHARED Player$(2)

'Chamar a rotina de apresenta뇙o
 CLS : CALL Apresentacao
'Chamar a rotina para dezenhar o ecr� do jogo
 CLS : EcraDoJogo

'Ciclo que vai durar at� o jogador premir 3(sair).
'Se premir dois � chamada a rotina que tem as instro뇯es, se premir um
'come놹 o jogo
Comeco:
DO

'Chamada da rotina que vai dezenhar as 3 op뇯es do menu
 CALL Menu

'Esperar que uma tecla seja premida
 a$ = INPUT$(1)

'Passar o valor da tecla que uma string(cadeia de caracteres), para inteiro
'atrav굎 da fun뇙o VAL(retorna o numero inteiro de uma cadeia).
 opcao = VAL(a$)

'Conforme a op뇙o escolhe o que fazer: 1-Jogar, 2-Instro뇯es, 3-sair
 IF opcao = 1 THEN EXIT DO
 IF opcao = 2 THEN CALL Instrucao
 IF opcao = 3 THEN GOTO Sair

'Se atecla premida n꼘 corresponder a nenhuma das op뇯es continua o ciclo
LOOP


'Se o programa veio para aqui � porque a tecla 1 foi premida, 1-Jogar
'Chamada da rotina para limpar o sitio onde v꼘 ser impressos os alfinetes
 CALL LimparEspacos(5)

'Chamada a rotina que pede os nomes
 CALL PedirNomes

'Formula para escolher o primeiro jogador aleat줿iamente
'Esta formula encontra-se na ajuda do QB. Ordem RND, sec뇙o DETAILS
RANDOMIZE TIMER: Jogador = INT((2 - 1 + 1) * RND + 1)

'Defeni뇙o das seguintes variaveis a verdadeiro(1), Quando todas elas forem
'falsas(0), acaba o jogo
 L1 = TRUE: L2 = TRUE: L3 = TRUE

'Defeni뇙o de fim de jogo a falso, porque quando for verdadeiro acaba o jogo
 FimDeJogo = FALSE

'por todas os alfinetes a zero, Quando todos eles forem 1, acaba o jogo
 FOR k = 1 TO 7: Fila1(k) = 1: NEXT
 FOR k = 1 TO 5: Fila2(k) = 1: NEXT
 FOR k = 1 TO 3: Fila3(k) = 1: NEXT

'Come놹 o ciclo at� que um dos jogadores ganhe
DO

'chama rotina para imprimir a situa뇙o dos alfinetes
1 CALL ImprimirAgulhas
 
'P봢 a variavel ERRO a FALSE(0), pois ainda n꼘 aconteceu nenhum erro
  ERRO = FALSE
   
'Chama a rotina para perguntar em que linha jogar
  CALL InputLinha
 
'Se a variavel FimdeJogo for igual TRUE, igual a 1, ent꼘 quer dizer que todas
'as filas foram preenchidas e acabou o jogo.
   IF FimDeJogo = TRUE THEN GOTO Final
'Se erro for igual TRUE, ocorreu um erro, chama-se arotina de erro para avisar
'e volta-se ao principio
   IF ERRO = TRUE THEN CALL RotinaDeERRO: GOTO 1

'chama a rotina para perguntar qual o primeiro alfinete a apagar
  CALL PrimeiroPalito
'verifica se existe erro
   IF ERRO = TRUE THEN CALL RotinaDeERRO: GOTO 1
 
'chama a rotina para perguntar qual o ultimo palito a apagar
  CALL UltimoPalito
'verifica se existe erro
   IF ERRO = TRUE THEN CALL RotinaDeERRO: GOTO 1
 
'verifica se algum dos valores correspondentes a alfinetes j� havia sido
'apagado. F�-lo da seginte maneira: Se F%(Fila) for igual a 1, vai para
'VerJG7; se for igual a 2, vai para VerJG5; se for igual a 3, vai para
'VerJG3.
  ON F% GOSUB VERJG7, VERJG5, VERJG3
'verifica se existe erro, por causa talvez de se querer apagar uma agulha
'j� apagada
   IF ERRO = TRUE THEN CALL RotinaDeERRO: GOTO 1

'Um sistema de verifica뇙o parecido com o de cima, s� que este p봢 o(s)
'alfinete(s) escolido(s) por n쥀 com o valor 0, ou seja apaga-os
  ON F% GOSUB VER7, VER5, VER3
'verifica se n꼘 ocurreu nenhum erro
   IF ERRO = TRUE THEN CALL RotinaDeERRO: GOTO 1

'A jogada correu toda bem por isso passa-se a vez para o outro jogador
  IF Jogador = 1 THEN Jogador = 2 ELSE Jogador = 1
'Limpa-se o ecra do jogador que vai jogar
  IF Jogador = 1 THEN LimparEspacos (3) ELSE CALL LimparEspacos(4)
 
LOOP
'Imprime o nome do vencedor
Final:
 CALL LimparEspacos(5)
 
  IF Jogador = 1 THEN Nome$ = Player$(1)
  IF Jogador = 2 THEN Nome$ = Player$(2)
  
  Text$ = "Ganhou o jogador" + STR$(Jogador) + ": " + Nome$
  PrintXY 16, 41 - LEN(Text$) / 2, 0, 5, 7, Text$
 
  WHILE INKEY$ = "": WEND
 
  CALL LimparEspacos(5)
GOTO Comeco

'faz a chamada 꿺 rotinas para verificar e acertar os alfinetes
VER7: CALL Verificacoes(1): RETURN
VER5: CALL Verificacoes(2): RETURN
VER3: CALL Verificacoes(3): RETURN
VERJG7: CALL Verificacoes(4): RETURN
VERJG5: CALL Verificacoes(5): RETURN
VERJG3: CALL Verificacoes(6): RETURN

'faz o ecra subir imprimindo 25 vezes na linha 25, e imprime a mensagem
'de despedida.
Sair:
 COLOR 7, 0
 FOR n = 1 TO 25
  LOCATE 25, 1: PRINT STRING$(80, 0)
 NEXT n
 PrintXY 1, 1, 0, 9, 0, "V늤os-nos por a�..."
 PrintXY 2, 1, 0, 7, 0, "At� � proxima."

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                              Apresentacao                                 �
'�                                                                           �
'� Imprime o nome do jogo com progressivas passagens de cor                  �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB Apresentacao
a = 1: mov = TRUE
PrintXY 25, 32, 0, 11, 0, "Prima uma tecla!"
DO
 PrintXY 2, 20, 0, a + 5, 0, " 複複複複  複複複複   複複複複   複複複複 "
 PrintXY 3, 20, 0, a + 4, 0, "       複� 栢旼� 栢�  栢旼컴컴�  栢旼� 栢�"
 PrintXY 4, 20, 0, a + 3, 0, "       複� 複�   複�  複�        複�   複�"
 PrintXY 5, 20, 0, a + 2, 0, " 複    複� 複�   複�  複�   複   複�   複�"
 PrintXY 6, 20, 0, a + 1, 0, " 複複複複� 複複複複�  複複複複�  複複複複�"
 PrintXY 7, 20, 0, a, 0, " 읕컴컴컴� 읕컴컴컴�  읕컴컴컴�  읕컴컴컴�"
 PrintXY 10, 30, 0, a + 5, 0, " 複複複    複複複複"
 PrintXY 11, 30, 0, a + 4, 0, " 栢旼� 栢� 栢旼컴栢�"
 PrintXY 12, 30, 0, a + 3, 0, " 複�   複� 複�   複�"
 PrintXY 13, 30, 0, a + 2, 0, " 複�   複� 複�   複�"
 PrintXY 14, 30, 0, a + 1, 0, " 複複複 粕 複複複複�"
 PrintXY 15, 30, 0, a, 0, " 읕컴컴켸  읕컴컴컴�"
 PrintXY 18, 5, 0, a + 5, 0, " 複複複複  複        複複複複  複  複     複  複複複�  複複複複  複複複� "
 PrintXY 19, 5, 0, a + 4, 0, " 栢旼� 栢� 栢�       栢旼컴컴� 栢� 栢複   栢� 栢旼컴켸    栢旼켸 栢旼컴켸"
 PrintXY 20, 5, 0, a + 3, 0, " 複複複複� 複�       複複      複� 複� 複 複� 複複        複�    複複 "
 PrintXY 21, 5, 0, a + 2, 0, " 複旼� 複� 複�       複�       複� 複�  複複� 複旼�       複�    複旼� "
 PrintXY 22, 5, 0, a + 1, 0, " 複�   複� 複複複複  複�       複� 複�    複� 複複複�     複�    複複複�"
 PrintXY 23, 5, 0, a, 0, " 읕�   읕� 읕컴컴컴� 읕�       읕� 읕�    읕� 읕컴컴켸    읕�    읕컴컴켸"
 IF mov = TRUE THEN a = a + 1
 IF mov = FALSE THEN a = a - 1
 IF a = 10 THEN mov = FALSE
 IF a = 1 THEN mov = TRUE
 FOR n = 0 TO 10000: NEXT
LOOP UNTIL INKEY$ <> ""

'imprime na linha 25, ou autores enquanto d� a musica
PrintXY 25, 30, 0, 12, 0, "   Hugo Ferreira   "
C$ = INKEY$: IF C$ <> "" GOTO FIM
PLAY "t120o1l16b9n0ba"
C$ = INKEY$: IF C$ <> "" GOTO FIM
PLAY "an0bn0bn0baaan0b9n0baan0b"
C$ = INKEY$: IF C$ <> "" GOTO FIM
PLAY "o2l16e-9n0e-d-d-n0e-"
C$ = INKEY$: IF C$ <> "" GOTO FIM
PLAY "n0e-n0e-d-d-d-n0e-9n0e-d-d-n0e-"
C$ = INKEY$: IF C$ <> "" GOTO FIM
PLAY "o2l16g-9n0g-een0g-n0g-n0g-eeen0g-9n0g-een0g-"
C$ = INKEY$: IF C$ <> "" GOTO FIM
PrintXY 25, 30, 0, 11, 0, "     APRESENTA     "
PLAY "o2l16b9n0baan0g-n0g-n0g-eeen0o1b9n0baan0b"
PrintXY 25, 29, 0, 15, 0, "  O JOGO DO ALFINETE   "
WHILE C$ = "": C$ = INKEY$: WEND
FIM:
END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                                 Caixa                                     �
'�                                                                           �
'� Dezenha as caixas no ecra                                                 �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB Caixa (Linha1, Coluna1, Linha2, Coluna2, Color1, Color2) STATIC

    COLOR Color1, Color2

    TamanhoDaCaixa = Coluna2 - Coluna1 + 1

    LOCATE Linha1, Coluna1
    PRINT "�"; STRING$(TamanhoDaCaixa - 2, "�"); "�";

    FOR a = Linha1 + 1 TO Linha2 - 1
        LOCATE a, Coluna1
        PRINT "�"; SPACE$(TamanhoDaCaixa - 2); "�";
    NEXT a

    LOCATE Linha2, Coluna1
    PRINT "�"; STRING$(TamanhoDaCaixa - 2, "�"); "�";

END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                               EcraDoJogo                                  �
'�                                                                           �
'� Dezenha o ecra de jogo, utilizando varias SUBs como Caixa, PrintXY        �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB EcraDoJogo
 
    Caixa 1, 2, 10, 39, 8, 7: Caixa 1, 41, 10, 79, 8, 7: Caixa 11, 2, 25, 79, 8, 7
    PrintXY 10, 3, 0, 15, 7, STRING$(36, 196) + CHR$(217)
    PrintXY 10, 42, 0, 15, 7, STRING$(37, 196) + CHR$(217)
    PrintXY 25, 3, 0, 15, 7, STRING$(76, 196) + CHR$(217)
    FOR n = 2 TO 9
     PrintXY n, 39, 0, 15, 7, CHR$(179)
     PrintXY n, 79, 0, 15, 7, CHR$(179)
    NEXT n
    FOR n = 1 TO 10
     PrintXY n, 1, 0, 7, 7, CHR$(219)
     PrintXY n, 40, 0, 7, 7, CHR$(219)
     PrintXY n, 80, 0, 7, 7, CHR$(219)
    NEXT n
    FOR n = 12 TO 24: PrintXY n, 79, 0, 15, 7, CHR$(179): NEXT n
    FOR n = 10 TO 25
     PrintXY n, 1, 0, 7, 7, CHR$(219)
     PrintXY n, 80, 0, 7, 7, CHR$(219)
    NEXT n

    PrintXY 2, 4, 0, 9, 7, "Jogador 1:": PrintXY 2, 43, 0, 9, 7, "Jogador 2:"
    PrintXY 5, 4, 0, 14, 7, "Linha a Jogar:": PrintXY 5, 43, 0, 14, 7, "Linha a Jogar:"
    PrintXY 7, 4, 0, 14, 7, "Primeiro Alfinete:": PrintXY 7, 43, 0, 14, 7, "Primeiro Alfinete:"
    PrintXY 9, 4, 0, 14, 7, "Ultimo Alfinete:": PrintXY 9, 43, 0, 14, 7, "Ultimo Alfinete:"


END SUB

DEFSNG A-Z
'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                              ImprimirAgulhas                              �
'�                                                                           �
'� Atrav굎 de varios For..Next, imprime todos os alfinetes no ecra           �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB ImprimirAgulhas
'se o valor do alfinete for 1, est꼘 por apagar; se for 0, est꼘 apagados
 FOR n = 1 TO 7
   IF Fila1(n) = 1 THEN
      PrintXY 13, 28 + (n + (n + n)), 0, 9, 0, CHR$(219)
      PrintXY 14, 28 + (n + (n + n)), 0, 9, 0, CHR$(219)
      PrintXY 15, 28 + (n + (n + n)), 0, 9, 0, CHR$(219)
   END IF
   IF Fila1(n) = 0 THEN
      PrintXY 13, 28 + (n + (n + n)), 0, 12, 0, CHR$(177)
      PrintXY 14, 28 + (n + (n + n)), 0, 12, 0, CHR$(177)
      PrintXY 15, 28 + (n + (n + n)), 0, 12, 0, CHR$(177)
   END IF
 NEXT n

 FOR n = 1 TO 5
   IF Fila2(n) = 1 THEN
      PrintXY 17, 31 + (n + (n + n)), 0, 9, 0, CHR$(219)
      PrintXY 18, 31 + (n + (n + n)), 0, 9, 0, CHR$(219)
      PrintXY 19, 31 + (n + (n + n)), 0, 9, 0, CHR$(219)
   END IF
   IF Fila2(n) = 0 THEN
      PrintXY 17, 31 + (n + (n + n)), 0, 12, 0, CHR$(177)
      PrintXY 18, 31 + (n + (n + n)), 0, 12, 0, CHR$(177)
      PrintXY 19, 31 + (n + (n + n)), 0, 12, 0, CHR$(177)
   END IF
  NEXT n

 FOR n = 1 TO 3
  IF Fila3(n) = 1 THEN
      PrintXY 21, 34 + (n + (n + n)), 0, 9, 0, CHR$(219)
      PrintXY 22, 34 + (n + (n + n)), 0, 9, 0, CHR$(219)
      PrintXY 23, 34 + (n + (n + n)), 0, 9, 0, CHR$(219)
  END IF
  IF Fila3(n) = 0 THEN
      PrintXY 21, 34 + (n + (n + n)), 0, 12, 0, CHR$(177)
      PrintXY 22, 34 + (n + (n + n)), 0, 12, 0, CHR$(177)
      PrintXY 23, 34 + (n + (n + n)), 0, 12, 0, CHR$(177)
  END IF
 NEXT n
END SUB

DEFINT A-Z
'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                               InputLinha                                  �
'�                                                                           �
'� SUB que pergunta ao jogador em que linha deseja jogar                     �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB InputLinha
'A ordem SHARED declara as variaveis comuns ao resto do programa
SHARED ERRO, NP%, F%, Jogador, L1, L2, L3, FimDeJogo
Principio:
 ERRO = FALSE

 NP% = 7: Contador = 0: GOSUB Verify1: IF Contador = NP% AND L1 = TRUE THEN L1 = FALSE
 NP% = 5: Contador = 0: GOSUB Verify2: IF Contador = NP% AND L2 = TRUE THEN L2 = FALSE
 NP% = 3: Contador = 0: GOSUB Verify3: IF Contador = NP% AND L3 = TRUE THEN L3 = FALSE

 IF L1 = FALSE AND L2 = FALSE AND L3 = FALSE THEN FimDeJogo = TRUE: EXIT SUB
 IF Jogador = 1 THEN PrintXY 5, 4, 0, 13, 7, "Linha a Jogar:"
 IF Jogador = 2 THEN PrintXY 5, 43, 0, 13, 7, "Linha a Jogar:"

 DO
   a$ = INPUT$(1): F% = VAL(a$)
 LOOP WHILE F% < 1 OR F% > 3

 IF Jogador = 1 THEN PrintXY 5, 18, 0, 5, 7, STR$(F%)
 IF Jogador = 2 THEN PrintXY 5, 57, 0, 4, 7, STR$(F%)

 IF F% = 1 THEN NP% = 7
 IF F% = 2 THEN NP% = 5
 IF F% = 3 THEN NP% = 3
 Contador = 0
 
 ON F% GOSUB Verify1, Verify2, Verify3
 IF NP% = Contador THEN
  CALL RotinaDeERRO
  CALL ImprimirAgulhas
  GOTO Principio
 END IF

 IF Jogador = 1 THEN PrintXY 5, 4, 0, 14, 7, "Linha a Jogar:"
 IF Jogador = 2 THEN PrintXY 5, 43, 0, 14, 7, "Linha a Jogar:"

 EXIT SUB

Verify1:
 FOR n% = 1 TO NP%
  IF Fila1(n%) = 0 THEN Contador = Contador + 1
 NEXT n%
RETURN

Verify2:
 FOR n% = 1 TO NP%
  IF Fila2(n%) = 0 THEN Contador = Contador + 1
 NEXT n%
RETURN

Verify3:
 FOR n% = 1 TO NP%
  IF Fila3(n%) = 0 THEN Contador = Contador + 1
 NEXT n%
RETURN
END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                                Instrucao                                  �
'�                                                                           �
'� Imprime as instrucoes do jogo                                             �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB Instrucao
 CALL LimparEspacos(5)
 PrintXY 12, 4, 0, 13, 7, "Instru뇯es:"
 PrintXY 14, 5, 0, 1, 7, "O jogo do Alfinete consiste, em apagar todos os alfinetes das tr늮 filas."
 PrintXY 15, 5, 0, 1, 7, "A cada jogador � perguntada a FILA em que deseja jogar, o PRIMEIRO "
 PrintXY 16, 5, 0, 1, 7, "alfinete a apagar e o ULTIMO alfinete a apagar, dessa mesma fila. "
 PrintXY 18, 5, 0, 4, 7, "SE UM JOGADOR INSERIR O VALOR DO PRIMEIRO ALFINETE A APAGAR, MAIOR QUE O"
 PrintXY 19, 5, 0, 4, 7, "DO SEGUNDO ALFINETE A APAGAR, PERDE A VEZ, PASSANDO O JOGO PARA O SEU"
 PrintXY 20, 5, 0, 4, 7, "ADVERS냃IO. O COMPUTADOR DECIDE ALEAT웂IAMENTE QUEM � O PRIMEIRO JOGADOR"
 PrintXY 21, 5, 0, 4, 7, "A JOGAR."
 PrintXY 23, 5, 0, 1, 7, "O jogo � ganho pelo jogador, que conseguir que o seu advers쟲io apague o"
 PrintXY 24, 5, 0, 1, 7, "ultimo alfinete."
 
 WHILE INKEY$ = "": WEND
 CALL LimparEspacos(5)
END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                               LimparEspacos                               �
'�                                                                           �
'� Imprime varias cadeias para limpar espa뇇s conforme a op놹o               �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB LimparEspacos (opcao)
  SELECT CASE opcao
         CASE 1: PrintXY 2, 15, 0, 7, 7, STRING$(21, 219)
         CASE 2: PrintXY 2, 54, 0, 7, 7, STRING$(21, 219)
         CASE 3:
                 PrintXY 5, 19, 0, 7, 7, STRING$(2, 219)
                 PrintXY 7, 23, 0, 7, 7, STRING$(2, 219)
                 PrintXY 9, 21, 0, 7, 7, STRING$(2, 219)
         CASE 4:
                 PrintXY 5, 58, 0, 7, 7, STRING$(2, 219)
                 PrintXY 7, 62, 0, 7, 7, STRING$(2, 219)
                 PrintXY 9, 60, 0, 7, 7, STRING$(2, 219)
         CASE 5:
                 FOR n = 12 TO 24
                 PrintXY n, 3, 0, 7, 7, STRING$(76, 219)
                 NEXT n
         CASE ELSE
  END SELECT
END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                                  Menu                                     �
'�                                                                           �
'� Imprime o menu do jogo                                                    �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB Menu
   PrintXY 13, 7, 0, 1, 7, " 蔔      賽賽� 輻賽� 輻賽  輻賽� 幡賽�"
   PrintXY 14, 7, 0, 1, 7, "  �  複  �   � �   � �   � 白複� 白複�"
   PrintXY 15, 7, 0, 1, 7, "  �      霜複� 霜複� 霜複� �   � �  霜 "

   PrintXY 17, 6, 0, 9, 7, "輻賽�     賽幡� 白  � 輻賽� 賽幡� 幡賽� �   � 輻賽� 輻賽� 輻賽� 輻賽�"
   PrintXY 18, 6, 0, 9, 7, "  輻  複    �   � � �  霜�    �   白複� �   � �     �   � 幡�    霜�"
   PrintXY 19, 6, 0, 9, 7, "蔔複�     複白� �  賞 霜複�   �   �  霜 霜複� 霜複� 霜複� 霜複� 霜複�"

  PrintXY 21, 6, 0, 11, 7, "輻賽�     輻賽� 輻賽� 賽幡� 幡賽�"
  PrintXY 22, 6, 0, 11, 7, "   賞 複   霜�  白複�   �   白複�"
  PrintXY 23, 6, 0, 11, 7, "霜複�     霜複� �   � 複白� �  霜 "

END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                               PedirNomes                                  �
'�                                                                           �
'� Pergunta os nomes do jogador 1 e 2, respectivamente.                      �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB PedirNomes
SHARED Player$()
 
  CALL LimparEspacos(1)
  PrintXY 16, 27, 0, 11, 7, "Insira o seu nome JOGADOR 1."
  Nome$ = PerguntarNome$(2, 15): Player$(1) = Nome$
 
  CALL LimparEspacos(2)
  PrintXY 16, 27, 0, 4, 7, "Insira o seu nome JOGADOR 2."
  Nome$ = PerguntarNome$(2, 55): Player$(2) = Nome$

  CALL LimparEspacos(5)

END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                              PerguntarNome                                �
'�                                                                           �
'� Edita a cadeia que contem o nome do jogador                               �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
FUNCTION PerguntarNome$ (X, Y)
SHARED Jogador

 Nome$ = ""
 DO
  DO
   DO
    Tecla$ = INKEY$
   LOOP WHILE Tecla$ = ""
   IF ASC(Tecla$) = 13 THEN EXIT DO
   IF ASC(Tecla$) = 8 THEN EXIT DO
  LOOP UNTIL ASC(Tecla$) > 32 OR ASC(Tecla$) < 255
 
  IF ASC(Tecla$) = 8 THEN
   IF LEN(Nome$) = 0 THEN
     Nome$ = Nome$
    ELSE
     Nome$ = LEFT$(Nome$, LEN(Nome$) - 1)
     PrintXY X, Y, 1, 8, 7, Nome$ + CHR$(32)
    END IF
   ELSE
    Nome$ = Nome$ + Tecla$
    PrintXY X, Y, 1, 8, 7, Nome$
  END IF
 
  PrintXY X, Y, 1, 8, 7, Nome$
  Comprimento = LEN(Nome$)
  LOOP UNTIL Tecla$ = CHR$(13) OR Comprimento = 20
  PerguntarNome$ = Nome$
END FUNCTION

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                              PrimeiroPalito                               �
'�                                                                           �
'� Pergunta ao jogador qual o primeiro alfinete ou palito a jogar            �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB PrimeiroPalito
SHARED ERRO, NP%, A1%, Jogador
 ERRO = FALSE

 IF Jogador = 1 THEN PrintXY 7, 4, 0, 13, 7, "Primeiro Alfinete:"
 IF Jogador = 2 THEN PrintXY 7, 43, 0, 13, 7, "Primeiro Alfinete:"

 DO
   a$ = INPUT$(1): A1% = VAL(a$)
 LOOP WHILE A1% = 0 OR A1% > NP%

 IF Jogador = 1 THEN PrintXY 7, 22, 0, 5, 7, STR$(A1%)
 IF Jogador = 2 THEN PrintXY 7, 61, 0, 4, 7, STR$(A1%)

 IF NP% = 7 THEN IF Fila1(A1%) = 0 THEN ERRO = TRUE
 IF NP% = 5 THEN IF Fila2(A1%) = 0 THEN ERRO = TRUE
 IF NP% = 3 THEN IF Fila3(A1%) = 0 THEN ERRO = TRUE

 IF Jogador = 1 THEN PrintXY 7, 4, 0, 14, 7, "Primeiro Alfinete:"
 IF Jogador = 2 THEN PrintXY 7, 43, 0, 14, 7, "Primeiro Alfinete:"

END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                                PrintXY                                    �
'�                                                                           �
'� Um print formatado.                                                       �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB PrintXY (X, Y, Posi, Color1, Color2, Text$)
  LOCATE X, Y, Posi
  COLOR Color1, Color2
  PRINT Text$;
END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                               RotinaDeERRO                                �
'�                                                                           �
'� Lida com os erros que possam suceder                                      �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB RotinaDeERRO
SHARED Jogador
   IF Jogador = 1 THEN
    PrintXY 13, 5, 0, 12, 7, "JOGADA INVALIDA"
    SLEEP 5
    CALL LimparEspacos(3)
    PrintXY 13, 5, 0, 7, 7, "               "
   END IF
   IF Jogador = 2 THEN
    PrintXY 13, 60, 0, 12, 7, "JOGADA INVALIDA"
    SLEEP 5
    CALL LimparEspacos(4)
    PrintXY 13, 60, 0, 7, 7, "               "
   END IF
  
   ERRO = FALSE
END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                               UltimoPalito                                �
'�                                                                           �
'� Pergunta qual o ultimo palito ou alfinete a jogar                         �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB UltimoPalito
SHARED ERRO, NP%, A2%, Jogador
 ERRO = FALSE

 IF Jogador = 1 THEN PrintXY 9, 4, 0, 13, 7, "Ultimo Alfinete:"
 IF Jogador = 2 THEN PrintXY 9, 43, 0, 13, 7, "Ultimo Alfinete:"

 DO
   a$ = INPUT$(1): A2% = VAL(a$)
 LOOP WHILE A2% = 0 OR A2% > NP%

 IF Jogador = 1 THEN PrintXY 9, 20, 0, 5, 7, STR$(A2%)
 IF Jogador = 2 THEN PrintXY 9, 59, 0, 4, 7, STR$(A2%)
 
 IF NP% = 7 THEN IF Fila1(A2%) = 0 THEN ERRO = TRUE
 IF NP% = 5 THEN IF Fila2(A2%) = 0 THEN ERRO = TRUE
 IF NP% = 3 THEN IF Fila3(A2%) = 0 THEN ERRO = TRUE

 IF Jogador = 1 THEN PrintXY 9, 4, 0, 14, 7, "Ultimo Alfinete:"
 IF Jogador = 2 THEN PrintXY 9, 43, 0, 14, 7, "Ultimo Alfinete:"

END SUB

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                               Verificacoes                                �
'�                                                                           �
'� Faz as verificacoes para ver se um determinado palito ja foi jogado       �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SUB Verificacoes (opcao%)
SHARED ERRO, A1%, A2%
  ERRO = FALSE
  SELECT CASE opcao
          CASE 1: FOR X% = A1% TO A2%: Fila1(X%) = 0: NEXT
          CASE 2: FOR X% = A1% TO A2%: Fila2(X%) = 0: NEXT
          CASE 3: FOR X% = A1% TO A2%: Fila3(X%) = 0: NEXT
          CASE 4
           FOR X% = A1% TO A2%
           IF Fila1(X%) = 0 THEN ERRO = TRUE
           EXIT FOR
           NEXT
          CASE 5
           FOR X% = A1% TO A2%
           IF Fila2(X%) = 0 THEN ERRO = TRUE
           EXIT FOR
           NEXT
          CASE 6
           FOR X% = A1% TO A2%
           IF Fila3(X%) = 0 THEN ERRO = TRUE
           EXIT FOR
           NEXT
  END SELECT
END SUB

