'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³              ÚÄ· ÚÄÄÄÄÄÄ· ÚÄÄÄÄÄÄ· ÚÄÄÄÄÄÄ·    ÚÄÄÄÄÄÄ· ÚÄÄÄÄÄÄ·          ³
'³              ³ º ³ ÖÄÄ¿ º ³ ÖÄÄÄÄ½ ³ ÖÄÄ¿ º    À¿ ÖÄ¿ º ³ ÖÄÄ¿ º          ³
'³              ³ º ³ º  ³ º ³ º ÚÄÄ· ³ º  ³ º     ³ º ³ º ³ º  ³ º          ³
'³          ÚÄ· ³ º ³ º  ³ º ³ º À¿ º ³ º  ³ º     ³ º ³ º ³ º  ³ º          ³
'³          ³ ÓÄÙ º ³ ÓÄÄÙ º ³ ÓÄÄÙ º ³ ÓÄÄÙ º    ÚÙ ÓÄÙ º ³ ÓÄÄÙ º          ³
'³          ÀÄÄÄÄÄ½ ÀÄÄÄÄÄÄ½ ÀÄÄÄÄÄÄ½ ÀÄÄÄÄÄÄ½    ÀÄÄÄÄÄÄ½ ÀÄÄÄÄÄÄ½          ³
'³      ÚÄÄÄÄÄÄ· ÚÄ·    ÚÄÄÄÄÄ· ÚÄÄÄ· ÚÄÄÄ·  ÚÄ· ÚÄÄÄÄÄ· ÚÄÄÄÄÄ· ÚÄÄÄÄÄ·     ³
'³      ³ ÖÄÄ¿ º ³ º    ³ ÖÄÄÄ½ À¿ Ö½ ³   Ó· ³ º ³ ÖÄÄÄ½ ÀÄ¿ ÖÄ½ ³ ÖÄÄÄ½     ³
'³      ³ ÓÄÄÙ º ³ º    ³ ÓÄ·    ³ º  ³ Ç¿ Ó·³ º ³ ÓÄ·     ³ º   ³ ÓÄ·       ³
'³      ³ ÖÄÄ¿ º ³ º    ³ ÖÄ½    ³ º  ³ ºÀ¿ Ó´ º ³ ÖÄ½     ³ º   ³ ÖÄ½       ³
'³      ³ º  ³ º ³ ÓÄÄ· ³ º     ÚÙ Ó· ³ º À¿   º ³ ÓÄÄÄ·   ³ º   ³ ÓÄÄÄ·     ³
'³      ÀÄ½  ÀÄ½ ÀÄÄÄÄ½ ÀÄ½     ÀÄÄÄ½ ÀÄ½  ÀÄÄÄ½ ÀÄÄÄÄÄ½   ÀÄ½   ÀÄÄÄÄÄ½     ³
'³                                                                           ³
'³      Programa‡„o de Hugo Ferreira, 1992.                                  ³
'³      Programado em Microsoft QuickBASIC 4.50                              ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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

'Todas as variaveis de tipo n„o declaradas no programa, s„o do tipo inteiro.
'DEFenir INTeiro A - Z (de A a Z): EXEMPLO; ERRO, TRUE, FALSE, L1, FimDoJogo
DEFINT A-Z

'Constantes Booleanas 0=Falso, 1=Veradeiro
 CONST TRUE = 1, FALSE = 0

'Declara‡„o de dim's, ARRAY's que v„o ter a situa‡„o dos alfinetes(apagados ou n„o)
'ARRAY's com o nome dos jogadores
 DIM SHARED Fila1(1 TO 7) AS INTEGER, Fila2(1 TO 5) AS INTEGER, Fila3(1 TO 3) AS INTEGER
 DIM SHARED Player$(2)

'Chamar a rotina de apresenta‡„o
 CLS : CALL Apresentacao
'Chamar a rotina para dezenhar o ecr„ do jogo
 CLS : EcraDoJogo

'Ciclo que vai durar at‚ o jogador premir 3(sair).
'Se premir dois ‚ chamada a rotina que tem as instro‡”es, se premir um
'come‡a o jogo
Comeco:
DO

'Chamada da rotina que vai dezenhar as 3 op‡”es do menu
 CALL Menu

'Esperar que uma tecla seja premida
 a$ = INPUT$(1)

'Passar o valor da tecla que uma string(cadeia de caracteres), para inteiro
'atrav‚s da fun‡„o VAL(retorna o numero inteiro de uma cadeia).
 opcao = VAL(a$)

'Conforme a op‡„o escolhe o que fazer: 1-Jogar, 2-Instro‡”es, 3-sair
 IF opcao = 1 THEN EXIT DO
 IF opcao = 2 THEN CALL Instrucao
 IF opcao = 3 THEN GOTO Sair

'Se atecla premida n„o corresponder a nenhuma das op‡”es continua o ciclo
LOOP


'Se o programa veio para aqui ‚ porque a tecla 1 foi premida, 1-Jogar
'Chamada da rotina para limpar o sitio onde v„o ser impressos os alfinetes
 CALL LimparEspacos(5)

'Chamada a rotina que pede os nomes
 CALL PedirNomes

'Formula para escolher o primeiro jogador aleat¢riamente
'Esta formula encontra-se na ajuda do QB. Ordem RND, sec‡„o DETAILS
RANDOMIZE TIMER: Jogador = INT((2 - 1 + 1) * RND + 1)

'Defeni‡„o das seguintes variaveis a verdadeiro(1), Quando todas elas forem
'falsas(0), acaba o jogo
 L1 = TRUE: L2 = TRUE: L3 = TRUE

'Defeni‡„o de fim de jogo a falso, porque quando for verdadeiro acaba o jogo
 FimDeJogo = FALSE

'por todas os alfinetes a zero, Quando todos eles forem 1, acaba o jogo
 FOR k = 1 TO 7: Fila1(k) = 1: NEXT
 FOR k = 1 TO 5: Fila2(k) = 1: NEXT
 FOR k = 1 TO 3: Fila3(k) = 1: NEXT

'Come‡a o ciclo at‚ que um dos jogadores ganhe
DO

'chama rotina para imprimir a situa‡„o dos alfinetes
1 CALL ImprimirAgulhas
 
'P”e a variavel ERRO a FALSE(0), pois ainda n„o aconteceu nenhum erro
  ERRO = FALSE
   
'Chama a rotina para perguntar em que linha jogar
  CALL InputLinha
 
'Se a variavel FimdeJogo for igual TRUE, igual a 1, ent„o quer dizer que todas
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
 
'verifica se algum dos valores correspondentes a alfinetes j  havia sido
'apagado. F -lo da seginte maneira: Se F%(Fila) for igual a 1, vai para
'VerJG7; se for igual a 2, vai para VerJG5; se for igual a 3, vai para
'VerJG3.
  ON F% GOSUB VERJG7, VERJG5, VERJG3
'verifica se existe erro, por causa talvez de se querer apagar uma agulha
'j  apagada
   IF ERRO = TRUE THEN CALL RotinaDeERRO: GOTO 1

'Um sistema de verifica‡„o parecido com o de cima, s¢ que este p”e o(s)
'alfinete(s) escolido(s) por n¢s com o valor 0, ou seja apaga-os
  ON F% GOSUB VER7, VER5, VER3
'verifica se n„o ocurreu nenhum erro
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

'faz a chamada …s rotinas para verificar e acertar os alfinetes
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
 PrintXY 1, 1, 0, 9, 0, "Vˆmos-nos por a¡..."
 PrintXY 2, 1, 0, 7, 0, "At‚ … proxima."

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                              Apresentacao                                 ³
'³                                                                           ³
'³ Imprime o nome do jogo com progressivas passagens de cor                  ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SUB Apresentacao
a = 1: mov = TRUE
PrintXY 25, 32, 0, 11, 0, "Prima uma tecla!"
DO
 PrintXY 2, 20, 0, a + 5, 0, " ÜÜÜÜÜÜÜÜ  ÜÜÜÜÜÜÜÜ   ÜÜÜÜÜÜÜÜ   ÜÜÜÜÜÜÜÜ "
 PrintXY 3, 20, 0, a + 4, 0, "       ÜÜ¿ ÛÛÚÄÄ ÛÛ¿  ÛÛÚÄÄÄÄÄÙ  ÛÛÚÄÄ ÛÛ¿"
 PrintXY 4, 20, 0, a + 3, 0, "       ÜÜ³ ÜÜ³   ÜÜ³  ÜÜ³        ÜÜ³   ÜÜ³"
 PrintXY 5, 20, 0, a + 2, 0, " ÜÜ    ÜÜ³ ÜÜ³   ÜÜ³  ÜÜ³   ÜÜ   ÜÜ³   ÜÜ³"
 PrintXY 6, 20, 0, a + 1, 0, " ÜÜÜÜÜÜÜÜ³ ÜÜÜÜÜÜÜÜ³  ÜÜÜÜÜÜÜÜ¿  ÜÜÜÜÜÜÜÜ³"
 PrintXY 7, 20, 0, a, 0, " ÀÄÄÄÄÄÄÄÙ ÀÄÄÄÄÄÄÄÙ  ÀÄÄÄÄÄÄÄÙ  ÀÄÄÄÄÄÄÄÙ"
 PrintXY 10, 30, 0, a + 5, 0, " ÜÜÜÜÜÜ    ÜÜÜÜÜÜÜÜ"
 PrintXY 11, 30, 0, a + 4, 0, " ÛÛÚÄÄ ÛÛ¿ ÛÛÚÄÄÄÛÛ¿"
 PrintXY 12, 30, 0, a + 3, 0, " ÜÜ³   ÜÜ³ ÜÜ³   ÜÜ³"
 PrintXY 13, 30, 0, a + 2, 0, " ÜÜ³   ÜÜ³ ÜÜ³   ÜÜ³"
 PrintXY 14, 30, 0, a + 1, 0, " ÜÜÜÜÜÜ ÚÙ ÜÜÜÜÜÜÜÜ³"
 PrintXY 15, 30, 0, a, 0, " ÀÄÄÄÄÄÄÙ  ÀÄÄÄÄÄÄÄÙ"
 PrintXY 18, 5, 0, a + 5, 0, " ÜÜÜÜÜÜÜÜ  ÜÜ        ÜÜÜÜÜÜÜÜ  ÜÜ  ÜÜ     ÜÜ  ÜÜÜÜÜÜÜ  ÜÜÜÜÜÜÜÜ  ÜÜÜÜÜÜÜ "
 PrintXY 19, 5, 0, a + 4, 0, " ÛÛÚÄÄ ÛÛ¿ ÛÛ¿       ÛÛÚÄÄÄÄÄÙ ÛÛ¿ ÛÛÜÜ   ÛÛ¿ ÛÛÚÄÄÄÄÙ    ÛÛÚÄÄÙ ÛÛÚÄÄÄÄÙ"
 PrintXY 20, 5, 0, a + 3, 0, " ÜÜÜÜÜÜÜÜ³ ÜÜ³       ÜÜÜÜ      ÜÜ³ ÜÜÚ ÜÜ ÜÜ³ ÜÜÜÜ        ÜÜ³    ÜÜÜÜ "
 PrintXY 21, 5, 0, a + 2, 0, " ÜÜÚÄÄ ÜÜ³ ÜÜ³       ÜÜÚ       ÜÜ³ ÜÜ³  ÜÜÜÜ³ ÜÜÚÄÙ       ÜÜ³    ÜÜÚÄÙ "
 PrintXY 22, 5, 0, a + 1, 0, " ÜÜ³   ÜÜ³ ÜÜÜÜÜÜÜÜ  ÜÜ³       ÜÜ³ ÜÜ³    ÜÜ³ ÜÜÜÜÜÜÜ     ÜÜ³    ÜÜÜÜÜÜÜ"
 PrintXY 23, 5, 0, a, 0, " ÀÄÙ   ÀÄÙ ÀÄÄÄÄÄÄÄÙ ÀÄÙ       ÀÄÙ ÀÄÙ    ÀÄÙ ÀÄÄÄÄÄÄÙ    ÀÄÙ    ÀÄÄÄÄÄÄÙ"
 IF mov = TRUE THEN a = a + 1
 IF mov = FALSE THEN a = a - 1
 IF a = 10 THEN mov = FALSE
 IF a = 1 THEN mov = TRUE
 FOR n = 0 TO 10000: NEXT
LOOP UNTIL INKEY$ <> ""

'imprime na linha 25, ou autores enquanto d  a musica
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                                 Caixa                                     ³
'³                                                                           ³
'³ Dezenha as caixas no ecra                                                 ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SUB Caixa (Linha1, Coluna1, Linha2, Coluna2, Color1, Color2) STATIC

    COLOR Color1, Color2

    TamanhoDaCaixa = Coluna2 - Coluna1 + 1

    LOCATE Linha1, Coluna1
    PRINT "Ú"; STRING$(TamanhoDaCaixa - 2, "Ä"); "¿";

    FOR a = Linha1 + 1 TO Linha2 - 1
        LOCATE a, Coluna1
        PRINT "³"; SPACE$(TamanhoDaCaixa - 2); "³";
    NEXT a

    LOCATE Linha2, Coluna1
    PRINT "À"; STRING$(TamanhoDaCaixa - 2, "Ä"); "Ù";

END SUB

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                               EcraDoJogo                                  ³
'³                                                                           ³
'³ Dezenha o ecra de jogo, utilizando varias SUBs como Caixa, PrintXY        ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                              ImprimirAgulhas                              ³
'³                                                                           ³
'³ Atrav‚s de varios For..Next, imprime todos os alfinetes no ecra           ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SUB ImprimirAgulhas
'se o valor do alfinete for 1, est„o por apagar; se for 0, est„o apagados
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
'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                               InputLinha                                  ³
'³                                                                           ³
'³ SUB que pergunta ao jogador em que linha deseja jogar                     ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                                Instrucao                                  ³
'³                                                                           ³
'³ Imprime as instrucoes do jogo                                             ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SUB Instrucao
 CALL LimparEspacos(5)
 PrintXY 12, 4, 0, 13, 7, "Instru‡”es:"
 PrintXY 14, 5, 0, 1, 7, "O jogo do Alfinete consiste, em apagar todos os alfinetes das trˆs filas."
 PrintXY 15, 5, 0, 1, 7, "A cada jogador ‚ perguntada a FILA em que deseja jogar, o PRIMEIRO "
 PrintXY 16, 5, 0, 1, 7, "alfinete a apagar e o ULTIMO alfinete a apagar, dessa mesma fila. "
 PrintXY 18, 5, 0, 4, 7, "SE UM JOGADOR INSERIR O VALOR DO PRIMEIRO ALFINETE A APAGAR, MAIOR QUE O"
 PrintXY 19, 5, 0, 4, 7, "DO SEGUNDO ALFINETE A APAGAR, PERDE A VEZ, PASSANDO O JOGO PARA O SEU"
 PrintXY 20, 5, 0, 4, 7, "ADVERS†RIO. O COMPUTADOR DECIDE ALEATŸRIAMENTE QUEM  O PRIMEIRO JOGADOR"
 PrintXY 21, 5, 0, 4, 7, "A JOGAR."
 PrintXY 23, 5, 0, 1, 7, "O jogo ‚ ganho pelo jogador, que conseguir que o seu advers rio apague o"
 PrintXY 24, 5, 0, 1, 7, "ultimo alfinete."
 
 WHILE INKEY$ = "": WEND
 CALL LimparEspacos(5)
END SUB

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                               LimparEspacos                               ³
'³                                                                           ³
'³ Imprime varias cadeias para limpar espa‡os conforme a op‡ao               ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                                  Menu                                     ³
'³                                                                           ³
'³ Imprime o menu do jogo                                                    ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SUB Menu
   PrintXY 13, 7, 0, 1, 7, " ÜÛ      ßßßßÛ ÜßßßÜ Üßßß  ÜßßßÜ ÛßßßÜ"
   PrintXY 14, 7, 0, 1, 7, "  Û  ÜÜ  Ü   Û Û   Û Û   Ü ÛÜÜÜÛ ÛÜÜÜß"
   PrintXY 15, 7, 0, 1, 7, "  Û      ßÜÜÜß ßÜÜÜß ßÜÜÜß Û   Û Û  ßÜ "

   PrintXY 17, 6, 0, 9, 7, "ÜßßßÜ     ßßÛßß ÛÜ  Û ÜßßßÜ ßßÛßß ÛßßßÜ Û   Û ÜßßßÜ ÜßßßÜ Üßßßß ÜßßßÜ"
   PrintXY 18, 6, 0, 9, 7, "  Üß  ÜÜ    Û   Û Û Û  ßÜÜ    Û   ÛÜÜÜß Û   Û Û     Û   Û Ûßß    ßÜÜ"
   PrintXY 19, 6, 0, 9, 7, "ÜÛÜÜÜ     ÜÜÛÜÜ Û  ßÛ ßÜÜÜß   Û   Û  ßÜ ßÜÜÜß ßÜÜÜß ßÜÜÜß ßÜÜÜÜ ßÜÜÜß"

  PrintXY 21, 6, 0, 11, 7, "ÜßßßÜ     ÜßßßÜ ÜßßßÜ ßßÛßß ÛßßßÜ"
  PrintXY 22, 6, 0, 11, 7, "   ßÛ ÜÜ   ßÜÜ  ÛÜÜÜÛ   Û   ÛÜÜÜß"
  PrintXY 23, 6, 0, 11, 7, "ßÜÜÜß     ßÜÜÜß Û   Û ÜÜÛÜÜ Û  ßÜ "

END SUB

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                               PedirNomes                                  ³
'³                                                                           ³
'³ Pergunta os nomes do jogador 1 e 2, respectivamente.                      ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                              PerguntarNome                                ³
'³                                                                           ³
'³ Edita a cadeia que contem o nome do jogador                               ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                              PrimeiroPalito                               ³
'³                                                                           ³
'³ Pergunta ao jogador qual o primeiro alfinete ou palito a jogar            ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                                PrintXY                                    ³
'³                                                                           ³
'³ Um print formatado.                                                       ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SUB PrintXY (X, Y, Posi, Color1, Color2, Text$)
  LOCATE X, Y, Posi
  COLOR Color1, Color2
  PRINT Text$;
END SUB

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                               RotinaDeERRO                                ³
'³                                                                           ³
'³ Lida com os erros que possam suceder                                      ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                               UltimoPalito                                ³
'³                                                                           ³
'³ Pergunta qual o ultimo palito ou alfinete a jogar                         ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
'³                               Verificacoes                                ³
'³                                                                           ³
'³ Faz as verificacoes para ver se um determinado palito ja foi jogado       ³
'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

