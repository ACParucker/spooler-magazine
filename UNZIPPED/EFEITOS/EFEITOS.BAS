'************************************************************************
'*                   E F E I T O S    M C G A    1 . 1                  *
'*                                                                      *
'*          Programa de demonstraáÑo gr†fica para VGA produzido         *
'*         para a SPOOLER por Jorge Candeias - PortimÑo - Algarve       *
'*                                                                      *
'*          Sintaxe de utilizaáÑo:                                      *
'*                                                                      *
'*                   EFEITOS [minutos]    (minutos Ç o tempo que        *
'*                                         o programa demora em         *
'*                                         cada efeito)                 *
'*                                                                      *
'*          Linguagem:     QuickBasic 4.5                               *
'************************************************************************

'***** DECLARAÄéO DE SUBROTINAS E FUNÄôES *****
DECLARE SUB Efeito1 ()
DECLARE SUB Efeito2 ()
DECLARE SUB Efeito3 ()
DECLARE SUB Efeito4 ()
DECLARE SUB Efeito5 ()
DECLARE SUB Efeito6 ()
DECLARE SUB Efeito7 ()
DECLARE SUB Efeito8 ()
DECLARE SUB FimProg ()
DECLARE SUB Introducao ()
DECLARE SUB Pausa ()
DECLARE SUB PB ()
DECLARE FUNCTION Limita.Cores% (Cor%)
DECLARE FUNCTION Negro% ()

'***** INICIALIZAÄéO DO êCRAN E DO GERADOR DE NñMEROS ALEATüRIOS *****
ON ERROR GOTO Erros:
SCREEN 13
RANDOMIZE TIMER

'***** DECLARAÄéO DE VARIÜVEIS GLOBAIS *****
DIM SHARED Fim AS SINGLE, Pal(1 TO 255, 1 TO 3) AS INTEGER, Salto AS SINGLE
DIM SHARED Final AS INTEGER, Contador AS INTEGER

'***** LEITURA E TRATAMENTO DA LINHA DE COMANDO *****
Linha$ = COMMAND$
IF Linha$ = "" THEN
   Mins = .4
ELSE
   flag% = 1
   FOR i% = 1 TO LEN(Linha$)
      IF INSTR("0123456789.", MID$(Linha$, i%, 1)) = 0 THEN
         flag% = 0
         EXIT FOR
      END IF
   NEXT
   IF flag% = 1 THEN
      Mins = VAL(Linha$)
   ELSE
      Mins = .4
   END IF
END IF

'***** INICIALIZAÄéO DO PROGRAMA *****
Salto = .03
Final = 0
Introducao           'Subrotina que faz a apresentaáÑo do programa
CLS

'***** PROGRAMA PRINCIPAL *****
DO
a% = RND * 8 + 1
IF RND < .3 THEN CLS
Inic = TIMER
Fim = Inic + Mins * 60
Salto = RND / 5               'Vari†vel que determina a frequància com que
                              'as cores mudam o seu sentido de alteraáÑo.
SELECT CASE a%
   CASE 1
      Efeito1
   CASE 2
      Efeito2
   CASE 3
      Efeito3
   CASE 4
      Efeito4
   CASE 5
      Efeito5
   CASE 6
      Efeito6
   CASE 7
      Efeito7
   CASE 8
      Efeito8
END SELECT
LOOP WHILE Final = 0

'***** FIM DO PROGRAMA *****
FimProg
END

'***** ROTINA DE TRATAMENTO DE ERROS *****
Erros:
SCREEN 0
WIDTH 80
CLS
PRINT "OK. NÑo percebo isto!"
PRINT "Ou a placa gr†fica deste computador nÑo me compreende"
PRINT "ou nÑo sei o que se passa."
PRINT "Desculpem l†, mas assim vou-me embora!"
END

DEFINT A-Z
'***** EFEITO NñMERO 1 *****
'***** QUADRADO COM LISTAS COLORIDAS HORIZONTAIS *****
SUB Efeito1

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
Passo = 100
DO
   FOR Cor = 1 TO 255
      Pal(Cor, 1) = En: Pal(Cor, 2) = Ve: Pal(Cor, 3) = Az
      En = En + ie: Ve = Ve + iv: Az = Az + ia
      IF RND < Salto THEN ie = -ie
      IF RND < Salto THEN iv = -iv
      IF RND < Salto THEN ia = -ia
      En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
      PALETTE Cor, Pal(Cor, 1) + 256 * Pal(Cor, 2) + 65536 * Pal(Cor, 3)
      FOR fil = 0 TO 200 STEP Passo
         LINE (33 + Cor, fil)-(33 + Cor, fil - 1 + Passo / 2), Cor
         LINE (289 - Cor, fil + Passo / 2)-(289 - Cor, fil - 1 + Passo), Cor
      NEXT
      IF Cor = 255 THEN
         IF RND < .2 THEN                    'AlteraáÑo do n£mero de riscas
            DO
               Passo = RND * 190 + 18
            LOOP UNTIL 200 MOD Passo = 0
         END IF
      END IF
   NEXT
   a$ = INKEY$
   IF UCASE$(a$) = "P" THEN            'Tratamento de ÆinputsØ
      Pausa                            'provenientes do teclado
   ELSEIF a$ = CHR$(27) THEN           '(repete-se em todas as
      Final = 1                        ' rotinas de efeitos)
      EXIT DO
   END IF
LOOP WHILE TIMER < Fim

END SUB

'***** EFEITO NñMERO 2 *****
'***** QUADRADO CENTRAL COM MOVIMENTO EM VAI-VêM *****
SUB Efeito2

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
alt = 1: i = 2
DO
   Pal(i, 1) = En: Pal(i, 2) = Ve: Pal(i, 3) = Az
   En = En + ie: Ve = Ve + iv: Az = Az + ia
   IF RND < Salto THEN ie = -ie
   IF RND < Salto THEN iv = -iv
   IF RND < Salto THEN ia = -ia
   En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
   PALETTE i, Pal(i, 1) + 256 * Pal(i, 2) + 65536 * Pal(i, 3)
   LINE (160, 100)-(224, 36 + i / 2), i
   LINE (160, 100)-(96, 164 - i / 2), i
   LINE (160, 100)-(96 + i / 2, 36), i
   LINE (160, 100)-(224 - i / 2, 164), i
   IF i = 255 OR i = 1 THEN
      alt = -alt
      a$ = INKEY$
      IF UCASE$(a$) = "P" THEN
         Pausa
      ELSEIF a$ = CHR$(27) THEN
         Final = 1
         EXIT DO
      END IF
   END IF
   i = i + alt
LOOP UNTIL TIMER > Fim AND (i = 255 OR i = 1)

END SUB

'***** EFEITO NñMERO 3 *****
'***** LOSANGO COM CORES IGUAIS EM CIMA E EM BAIXO *****
SUB Efeito3

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
alt = 1: i = 2
DO
   Pal(i, 1) = En: Pal(i, 2) = Ve: Pal(i, 3) = Az
   En = En + ie: Ve = Ve + iv: Az = Az + ia
   IF RND < Salto THEN ie = -ie
   IF RND < Salto THEN iv = -iv
   IF RND < Salto THEN ia = -ia
   En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
   PALETTE i, Pal(i, 1) + 256 * Pal(i, 2) + 65536 * Pal(i, 3)
   LINE (160, 200)-(31 + i, 101), i
   LINE (160, 0)-(31 + i, 100), i
   IF i = 255 OR i = 1 THEN
      alt = -alt
      a$ = INKEY$
      IF UCASE$(a$) = "P" THEN
         Pausa
      ELSEIF a$ = CHR$(27) THEN
         Final = 1
         EXIT DO
      END IF
   END IF
   i = i + alt
LOOP UNTIL TIMER > Fim AND (i = 255 OR i = 1)

END SUB

'***** EFEITO NñMERO 4 *****
'***** LOSANGO COM CORES INVERSAS EM CIMA E EM BAIXO *****
SUB Efeito4

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
alt = 1: i = 2
DO
   Pal(i, 1) = En: Pal(i, 2) = Ve: Pal(i, 3) = Az
   En = En + ie: Ve = Ve + iv: Az = Az + ia
   IF RND < Salto THEN ie = -ie
   IF RND < Salto THEN iv = -iv
   IF RND < Salto THEN ia = -ia
   En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
   PALETTE i, Pal(i, 1) + 256 * Pal(i, 2) + 65536 * Pal(i, 3)
   LINE (160, 200)-(31 + i, 101), i
   LINE (160, 0)-(288 - i, 100), i
   IF i = 255 OR i = 1 THEN
      alt = -alt
      a$ = INKEY$
      IF UCASE$(a$) = "P" THEN
         Pausa
      ELSEIF a$ = CHR$(27) THEN
         Final = 1
         EXIT DO
      END IF
   END IF
   i = i + alt
LOOP UNTIL TIMER > Fim AND (i = 255 OR i = 1)

END SUB

'***** EFEITO NñMERO 5 *****
'***** QUADRADO CENTRAL COM MOVIMENTO ROTATIVO *****
SUB Efeito5

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
DO
   FOR Cor = 1 TO 255
      Pal(Cor, 1) = En: Pal(Cor, 2) = Ve: Pal(Cor, 3) = Az
      En = En + ie: Ve = Ve + iv: Az = Az + ia
      IF RND < Salto THEN ie = -ie
      IF RND < Salto THEN iv = -iv
      IF RND < Salto THEN ia = -ia
      En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
      PALETTE Cor, Pal(Cor, 1) + 256 * Pal(Cor, 2) + 65536 * Pal(Cor, 3)
      LINE (160, 100)-(224, 36 + Cor / 2), Cor
      LINE (160, 100)-(96, 164 - Cor / 2), Cor
      LINE (160, 100)-(96 + Cor / 2, 36), Cor
      LINE (160, 100)-(224 - Cor / 2, 164), Cor
   NEXT
   a$ = INKEY$
   IF UCASE$(a$) = "P" THEN
      Pausa
   ELSEIF a$ = CHR$(27) THEN
      Final = 1
      EXIT DO
   END IF
LOOP WHILE TIMER < Fim

END SUB

'***** EFEITO NñMERO 6 *****
'***** 15 QUADRADOS COM MOVIMENTO ROTATIVO *****
SUB Efeito6

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
DO
   FOR Cor = 1 TO 255
      Pal(Cor, 1) = En: Pal(Cor, 2) = Ve: Pal(Cor, 3) = Az
      En = En + ie: Ve = Ve + iv: Az = Az + ia
      IF RND < Salto THEN ie = -ie
      IF RND < Salto THEN iv = -iv
      IF RND < Salto THEN ia = -ia
      En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
      PALETTE Cor, Pal(Cor, 1) + 256 * Pal(Cor, 2) + 65536 * Pal(Cor, 3)
      FOR x = 0 TO 319 STEP 65
         FOR y = 200 TO 0 STEP -65
            IF Cor <= 64 THEN
               xi = Cor - 32
               yi = -32
            ELSEIF Cor <= 128 THEN
               xi = 32
               yi = Cor - 96
            ELSEIF Cor <= 192 THEN
               xi = 160 - Cor
               yi = 32
            ELSE
               xi = -32
               yi = 224 - Cor
            END IF
            LINE (x + 32, y + 32)-(x + 32 + xi, y + 32 + yi), Cor
            IF Cor = 255 THEN
               LINE (x + 32, y + 32)-(x, y), Cor
               LINE (x + 32, y + 32)-(x + 1, y), Cor
            END IF
         NEXT
      NEXT
   NEXT
   a$ = INKEY$
   IF UCASE$(a$) = "P" THEN
      Pausa
   ELSEIF a$ = CHR$(27) THEN
      Final = 1
      EXIT DO
   END IF
LOOP WHILE TIMER < Fim

END SUB

'***** EFEITO NñMERO 7 *****
'***** CãRCULO *****
SUB Efeito7

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
alt = 1
i = 2
DO
   Pal(i, 1) = En: Pal(i, 2) = Ve: Pal(i, 3) = Az
   En = En + ie: Ve = Ve + iv: Az = Az + ia
   IF RND < Salto THEN ie = -ie
   IF RND < Salto THEN iv = -iv
   IF RND < Salto THEN ia = -ia
   En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
   PALETTE i, Pal(i, 1) + 256 * Pal(i, 2) + 65536 * Pal(i, 3)
   x = 80 * SIN(i / 255 * 3.1418)               'Duas instruáîes que
   y = 100 * COS(i / 255 * 3.1418)              'definem o c°rculo
   LINE (160 - x, 100 - y / 1.5)-(160 + x, 100 - y / 1.5), i
   IF i = 127 THEN
      LINE (160 - x, 101 - y / 1.5)-(160 + x, 101 - y / 1.5), i
   END IF
   IF i = 255 OR i = 1 THEN
      alt = -alt
      a$ = INKEY$
      IF UCASE$(a$) = "P" THEN
         Pausa
      ELSEIF a$ = CHR$(27) THEN
         Final = 1
         EXIT DO
      END IF
   END IF
   i = i + alt
LOOP UNTIL TIMER > Fim AND (i = 1 OR i = 255)

END SUB

'***** EFEITO NñMERO 8 *****
'***** EFEITO DE TñNEL *****
SUB Efeito8

Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
DO
   FOR Cor = 1 TO 160
      Pal(Cor, 1) = En: Pal(Cor, 2) = Ve: Pal(Cor, 3) = Az
      En = En + ie: Ve = Ve + iv: Az = Az + ia
      IF RND < Salto THEN ie = -ie
      IF RND < Salto THEN iv = -iv
      IF RND < Salto THEN ia = -ia
      En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
      PALETTE Cor, Pal(Cor, 1) + 256 * Pal(Cor, 2) + 65536 * Pal(Cor, 3)
      LINE (Cor - 1, Cor - 61)-(320 - Cor - 1, 320 - Cor - 61), Cor, B
   NEXT
   a$ = INKEY$
   IF UCASE$(a$) = "P" THEN
      Pausa
   ELSEIF a$ = CHR$(27) THEN
      Final = 1
      EXIT DO
   END IF
LOOP WHILE TIMER < Fim

END SUB

'***** FIM DO PROGRAMA *****
SUB FimProg

'***** CICLO QUE PRODUZ UM EFEITO DE ÆSHADINGØ *****
FOR a = 1 TO 255
   Contador = 0
   DO
      i = INT(RND * 255) + 1
      Contador = Contador + 1
      IF Contador = 10 THEN
         Contador = 0
         IF Negro = 1 THEN EXIT FOR
      END IF
   LOOP WHILE Pal(i, 1) + Pal(i, 2) + Pal(i, 3) = 0
   Pal(i, 1) = 0: Pal(i, 2) = 0: Pal(i, 3) = 0
   PALETTE i, Pal(i, 1) + 256 * Pal(i, 2) + 65536 * Pal(i, 3)
NEXT

'***** MENSAGEM FINAL *****
SCREEN 0
WIDTH 80
COLOR 14, 1
PRINT
PRINT " * * * * * * * * * * * * * * *  EFEITOS MCGA 1.1  * * * * * * * * * * * * * * * "
PRINT
COLOR 11, 4
PRINT "  Programa concebido e realizado por  JORGE CANDEIAS  para a  SPOOLER  -  1994  "
COLOR 7, 0

END SUB

'***** ROTINA QUE PRODUZ O êCRAN INICIAL *****
SUB Introducao

'***** INICIALIZAÄéO DAS CORES *****
'Esta inicializaáÑo Ç semelhante Ö existente em cada um dos efeitos
Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
Az1 = RND * 63: Ve1 = RND * 63: En1 = RND * 63
ie1 = 1: iv1 = 1: ia1 = 1
Az2 = RND * 63: Ve2 = RND * 63: En2 = RND * 63
ie2 = 1: iv2 = 1: ia2 = 1

'***** CICLO QUE PRODUZ O FUNDO *****
COLOR 4
LINE (0, 0)-(318, 199)
FOR Cor = 4 TO 255
   Pal(Cor, 1) = En: Pal(Cor, 2) = Ve: Pal(Cor, 3) = Az
   En = En + ie: Ve = Ve + iv: Az = Az + ia
   IF RND < Salto THEN ie = -ie
   IF RND < Salto THEN iv = -iv
   IF RND < Salto THEN ia = -ia
   En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
   PALETTE Cor, Pal(Cor, 1) + 256 * Pal(Cor, 2) + 65536 * Pal(Cor, 3)
   COLOR Cor
   Ponto! = (Cor - 4) / 251
   LINE (0, Ponto! * 200)-(320, 200 - Ponto! * 200)
   LINE (Ponto! * 320, 0)-(320 - Ponto! * 320, 200)
   LINE (Ponto! * 320 + 1, 0)-(320 - Ponto! * 320 - 1, 200)
NEXT
LINE (1, 199)-(320, 0)

'***** CICLO QUE PROFUZ AS LETRAS E AS MOVIMENTA *****
FOR P = 230 TO 301
   Pal(1, 1) = En1: Pal(1, 2) = Ve1: Pal(1, 3) = Az1
   Pal(2, 1) = En2: Pal(2, 2) = Ve2: Pal(2, 3) = Az2
   En1 = En1 + ie1: Ve1 = Ve1 + iv1: Az1 = Az1 + ia1
   En2 = En2 + ie2: Ve2 = Ve2 + iv2: Az2 = Az2 + ia2
   IF RND < Salto THEN ie1 = -ie1
   IF RND < Salto THEN iv1 = -iv1
   IF RND < Salto THEN ia1 = -ia1
   IF RND < Salto THEN ie2 = -ie2
   IF RND < Salto THEN iv2 = -iv2
   IF RND < Salto THEN ia2 = -ia2
   En1 = Limita.Cores(En1): Ve1 = Limita.Cores(Ve1): Az1 = Limita.Cores(Az1)
   En2 = Limita.Cores(En2): Ve2 = Limita.Cores(Ve2): Az2 = Limita.Cores(Az2)
   PALETTE 1, Pal(1, 1) + 256 * Pal(1, 2) + 65536 * Pal(1, 3)
   PALETTE 2, Pal(2, 1) + 256 * Pal(2, 2) + 65536 * Pal(2, 3)
   PSET (320 - P, 80), 1
   DRAW "C1U40R43D5L38D10R33D5L33D15R38D5L43"
   PSET (364 - P, 80), 0
   DRAW "C0U6BL38U13BR33U7BL33U8BR38U6"
   PSET (368 - P, 80), 1
   DRAW "C1U40R43D5L38D10R33D5L33D20L5"
   PSET (374 - P, 80), 0
   DRAW "C0U19BR33U7BL33U8BR38U6"
   PSET (416 - P, 80), 1
   DRAW "C1U40R43D5L38D10R33D5L33D15R38D5L43"
   PSET (460 - P, 80), 0
   DRAW "C0U6BL38U13BR33U7BL33U8BR38U6"
   PSET (464 - P, 80), 1
   DRAW "C1U40R5D40L5"
   PSET (469 - P, 80), 0
   DRAW "C0U40"
   PSET (474 - P, 40), 1
   DRAW "C1R37D5L16D35L5U35L16U5"
   PSET (512 - P, 40), 0
   DRAW "C0D6L16D34"
   PSET (516 - P, 70), 1
   DRAW "C1U20E10R23F10D20G10L23H10BR5BU2U16E7R19F7D16G7L19H7"
   PSET (530 - P, 74), 0
   DRAW "C0H6U16E6BU6BR21F10D20G10"
   PSET (564 - P, 80), 1
   DRAW "C1R35E8U9H8L26H4U2E4R34U5L35G8D4F8R26F4D7G4L34D5"
   PSET (600 - P, 80), 0
   DRAW "C0E8U9H9L26H3U2E3R34U6"
   PSET (P - 280, 150), 2
   DRAW "C2U40R10F22E22R10D40L10U25G22H22D25L10"
   PSET (P - 281, 150), 0
   DRAW "C0U40BR33BD21E21BD40U23BD20BL21H21"
   PSET (P - 207, 140), 2
   DRAW "C2U20E10R52D10L49G3D14F3R49D10L52H10"
   PSET (P - 198, 150), 0
   DRAW "C0H10U20E10"
   PSET (P - 132, 140), 2
   DRAW "C2U20E10R52D10L49G3D14F3R39U5L25U10R35D25L52H10"
   PSET (P - 123, 150), 0
   DRAW "C0H10U20E10BD15BR17D11R25D3"
   PSET (P - 59, 150), 2
   DRAW "C2U30E10R42F10D30L10U10L42D10L10BM+10,-20U7E3R36F3D7L42"
   PSET (P - 60, 150), 0
   DRAW "C0U30E10BR41BD40U9BU12U6H2"
NEXT

'***** MENSAGEM DE AUTOR *****
DO
   Az3 = RND * 63: Ve3 = RND * 63: En3 = RND * 63
LOOP WHILE Az3 + Ve3 + En3 < 70        'Ciclo que evita cores escuras
COLOR 3
PALETTE 3, Az3 + 256 * Ve3 + 65536 * En3
LOCATE 13, 11: PRINT "JORGE CANDEIAS  (1994)"

'***** CICLO QUE ALTERA AS CORES DO FUNDO *****
Az = RND * 63: Ve = RND * 63: En = RND * 63
ie = 1: iv = 1: ia = 1
Cont = 0
DO
   Cont = Cont + 1
   FOR i = 4 TO 255
      Pal(i, 1) = En: Pal(i, 2) = Ve: Pal(i, 3) = Az
      En = En + ie: Ve = Ve + iv: Az = Az + ia
      IF RND < Salto THEN ie = -ie
      IF RND < Salto THEN iv = -iv
      IF RND < Salto THEN ia = -ia
      En = Limita.Cores(En): Ve = Limita.Cores(Ve): Az = Limita.Cores(Az)
      PALETTE i, Pal(i, 1) + 256 * Pal(i, 2) + 65536 * Pal(i, 3)
   NEXT
LOOP WHILE INKEY$ = "" AND Cont < 6

END SUB

'***** FUNÄéO QUE LIMITA A ALTERAÄéO DOS COMPONENTES DA COR *****
'*****                  AO INTERVALO 0 - 63                 *****
FUNCTION Limita.Cores (Cor)

IF Cor >= 63 THEN
   Im = 63
ELSEIF Cor <= 0 THEN
   Im = 0
ELSE
   Im = Cor
END IF
Limita.Cores = Im

END FUNCTION

'***** ROTINA QUE VERIFICA SE O êCRAN ESTÜ NEGRO *****
'Serve para evitar o bloqueio da m†quina no caso de haver muitos atributos
'em negro quando o utilizador pretende sair do programa
FUNCTION Negro

FOR i = 1 TO 255
   IF Pal(i, 1) + Pal(i, 2) + Pal(i, 3) <> 0 THEN Negro = 0: EXIT FUNCTION
NEXT
Negro = 1

END FUNCTION

'***** ROTINA DE PAUSA *****
'Espera que o utilizador prima uma tecla para continuar
SUB Pausa

DO
   a$ = INKEY$
   IF UCASE$(a$) = "C" THEN PB: a$ = ""
LOOP WHILE a$ = ""

END SUB

DEFSNG A-Z
'***** ROTINA PARA TRANSFORMAR AS CORES EM TONS DE CINZENTO *****
'***** USA-SE PARA IMPRIMIR EM IMPRESSORAS A PRETO E BRANCO *****
SUB PB

DIM Paleta(1 TO 255, 1 TO 3)

FOR i = 1 TO 255
   Cinzento% = (Pal(i, 1) + Pal(i, 2) + Pal(i, 3)) / 3
   Paleta(i, 1) = Cinzento%
   Paleta(i, 2) = Cinzento%
   Paleta(i, 3) = Cinzento%
   PALETTE i, Paleta(i, 1) + 256 * Paleta(i, 2) + 65536 * Paleta(i, 3)
NEXT

END SUB

