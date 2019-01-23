'***************************************************************************
'*                   F I L I G R A N A     1 . 1                           *
'*                                                                         *
'*       Programa de demonstra‡„o gr fica produzido para a SPOOLER         *
'*             por Jorge Candeias - Portim„o - Algarve                     *
'*                                                                         *
'*       Sintaxe de Utiliza‡„o:                                            *
'*                                                                         *
'*                FILIGRAN [segundos]                                      *
'*                                                                         *
'*       Linguagem:     QuickBASIC 4.5                                     *
'***************************************************************************

'***** DECLARA€ŽO DE SUBROTINAS *****
DECLARE SUB Pausa (Segs!)
DECLARE SUB Inicializar ()

COLOR 15

'***** LEITURA E TRATAMENTO DA LINHA DE COMANDO *****
Linha$ = COMMAND$
IF Linha$ = "" THEN
   Segs! = 3
ELSE
   Flag& = 1
   FOR i& = 1 TO LEN(Linha$)
      IF INSTR("0123456789.", MID$(Linha$, i&, 1)) = 0 THEN
         Flag& = 0
         EXIT FOR
      END IF
   NEXT
   IF Flag& = 1 THEN
      Segs! = VAL(Linha$)
   ELSE
      Segs! = 3
   END IF
END IF

'***** INICIALIZA€ŽO DE VARI†VEIS *****
Video& = 12
Linhas! = 480
Colunas! = 640
Cores& = 16
M& = 1               ' Interruptor da mensagem de ajuda
C& = 1               ' Interruptor de cor

'***** INICIALIZA€ŽO *****
Inicializar
ON ERROR GOTO Erros:
RANDOMIZE TIMER
CONST Pi! = 3.141592

'***** MŸDULO PRINCIPAL *****
DO
   CLS
   IF M& = 1 THEN                               'Impress„o da mensagem
      LOCATE 1, 1: PRINT "C alterna Cor/PB"     'de ajuda
      LOCATE 2, 1: PRINT "ESC para sair"
   END IF
   DO
      Salto& = 360 / (RND * Linhas! / 10 + 1)
   LOOP UNTIL 360 MOD Salto& = 0
   IF RND > .3 THEN Aspecto! = RND * 2.8 + .2 ELSE Aspecto! = 4 / 3 * Linhas! / Colunas!
   IF C& = 1 THEN cor& = INT(RND * (Cores& - 1)) + 1 ELSE cor& = Cores& - 1
   CIRCLE (Colunas! / 2, Linhas! / 2), Linhas! / 2 - 10, cor&, , , Aspecto!
  
   ' *** CICLO PRINCIPAL ***
   ' Desenha as linhas interiores do c¡rculo ou elipse
   ' e muda aleatoriamente as cores
   ' (se o interruptor de cor estiver ligado).
   FOR Alfa! = 0 TO 180 STEP Salto&
      FOR Beta! = 0 TO 360 STEP Salto&
         RaioX! = Linhas! / 2 - 10
         RaioY! = RaioX!
         IF Aspecto! < 1 THEN
            RaioY! = RaioY! * Aspecto!
         ELSE
            RaioX! = RaioX! / Aspecto!
         END IF
         X0 = Colunas! / 2 + RaioX! * COS(Beta! / 180 * Pi!)
         Y0 = Linhas! / 2 - RaioY! * SIN(Beta! / 180 * Pi!)
         Ang2! = Alfa! + Beta!
         IF Ang2! > 360 THEN Ang2! = Ang2! - 360
         X1 = Colunas! / 2 + RaioX! * COS(Ang2! / 180 * Pi!)
         Y1 = Linhas! / 2 - RaioY! * SIN(Ang2! / 180 * Pi!)
         LINE (X0, Y0)-(X1, Y1), cor&
      NEXT
      IF RND < .4 THEN
         IF C& = 1 THEN cor& = INT(RND * (Cores& - 1)) + 1
      END IF
   NEXT

   ' *** LEITURA E TRATAMENTO DE ®INPUTS¯ PROVENIENTES DO TECLADO ***
   a$ = UCASE$(INKEY$)
   IF a$ = "C" THEN
      C& = -C&
   ELSEIF a$ <> CHR$(27) AND a$ <> "" THEN
      M& = -M&
   END IF
  
   Pausa Segs!
LOOP UNTIL a$ = CHR$(27)

'***** FIM DO PROGRAMA *****
SCREEN 0
COLOR 14, 1
PRINT
PRINT " * * * * * * * * * * * *  F I L I G R A N A    1 . 1  * * * * * * * * * * * * "
PRINT
COLOR 11, 4
PRINT " Programa concebido e realizado por  JORGE CANDEIAS  para a  SPOOLER  -  1993 "
COLOR 7, 0
END

'***** TRATAMENTO DE ERROS PROVENIENTES DA SUBROTINA Inicializar *****
ErroVideo:
IF Video& = 12 THEN
   Video& = 9
   Linhas! = 350
   Colunas! = 640
   Cores& = 16
   RESUME NEXT
ELSEIF Video& = 9 THEN
   Video& = 1
   Linhas! = 200
   Colunas! = 320
   Cores& = 4
   RESUME NEXT
ELSE
   PRINT "Pe‡o imensa desculpa!..."
   PRINT "Sou um programa simples e pouco sofisticado"
   PRINT "e n„o conhe‡o a sua placa gr fica."
   PRINT "Vai ter de ficar para a pr¢xima."
   PRINT "Vou terminar..."
   END
END IF

'***** TRATAMENTO DE ERROS NŽO PREVISTOS *****
Erros:
SCREEN 0
CLS
PRINT "Pe‡o imensa desculpa!..."
PRINT "Sou um programa simples, pouco sofisticado"
PRINT "e tenho qualquer coisa a funcionar mal."
PRINT "N„o sei o que ‚, e por isso vou terminar..."
END

'***************************************************************************
'*                     SUBROTINA Inicializar                               *
'*                                                                         *
'*        Esta subrotina e a rotina de tratamento de erros do m¢dulo       *
'*       principal do programa servem para detectar automaticamente a      *
'*          placa gr fica em que o FILIGRANA est  a ser executado.         *
'***************************************************************************
SUB Inicializar

'** VARI†VEIS COMPARTILHADAS POR ESTA SUBROTINA E PELO MŸDULO PRINCIPAL **
SHARED Video&, Linhas!, Colunas!, Cores&

ON ERROR GOTO ErroVideo:
SCREEN Video&

END SUB

'***************************************************************************
'*                           SUBROTINA Pausa                               *
'*                                                                         *
'*          Esta subrotina serve para manter cada desenho no ‚cran         *
'*                durante um espa‡o de tempo pr‚-definido                  *
'***************************************************************************
SUB Pausa (Segs!)

Liga! = TIMER
DO UNTIL TIMER >= Liga! + Segs!
LOOP

END SUB

