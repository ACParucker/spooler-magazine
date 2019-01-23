'
'                    PAIN DEMO por S‚rgio Freire  1994
'                    ==================================
'
'   Este ‚ o resultado da jun‡ao de muitos programas feitos por mim num
'  386 SX a 16 MHz. Como o Basic ‚ graficamente lento, tive agora que optar
'  por outra linguagem acess¡vel e mais r pida: o Pascal. J  comecei …
'  algum tempo a programar em Turbo Pascal 6.0 e notei que a velocidade que
'  eu desejava s¢ a poderei obter com outro programa. Desenvolvi j  demos
'  gr ficas e programas com o Pascal. Utilisei, por exemplo a unit GoldPlay
'  versao 1.0 que permite ler m¢dulos de Amiga em PC com o Turbo Pascal e que
'  cont‚m algumas fun‡oes ( Eu necessitava de mais ! ). Pe‡o-vos programado-
'  res, para que me ajudem e dai dicas.
'   Poderemos trocar ideias, c¢digos de programas, exemplos,etc e tamb‚m
'  associarmo-nos para juntos produzirmos demos ou programas de boa qualidade.
'   Desculpem-me pela repeti‡ao cont¡nua das vari veis e constantes.
'   A Pain Demo foi exclusivamente produzida para a Spooler para ajudar pro-
'  gramadores, dar-lhes ideias e para saberem que eu estou por aqui.
'   Se vocˆs me puderem arranjar programas exemplo, programas que me permitam
'  trabalhar a 256 cores,programas que trabalhem com gr ficos (gif,etc), sons
'  (voc,wav,etc) com o Turbo Pascal 6.0 , ficarei-lhes muito grato. Eu tamb‚m
'  vos posso ajudar e/ou fornecer programas, e coisas desse g‚nero.
'   Obrigado … Spooler por ser mais que uma revista e ajudar-nos, a n¢s
'  programadores, a programar e fornecer dicas, programas e ideias.
'   Caso o executavel der erros ( "bugs" ) corram o ficheiro qb_pain.bat
'  que correr  o QBasic do vosso DOS e funcionar  muito melhor !
'
'         þþþþþþþþþþþþþþþþ LER LE_ME.TXT þþþþþþþþþþþþþþþþþþþþ
'
'  Contactem-me !!!

DECLARE SUB apresentar ()
DECLARE SUB pain ()
DECLARE SUB flash ()
DECLARE SUB tuboconcha ()
DECLARE SUB tresd ()
DECLARE SUB papagaio ()
DECLARE SUB passaro ()
DECLARE SUB nave ()
DECLARE SUB estrela ()
DECLARE SUB piramide ()
DECLARE SUB linhas ()
DECLARE SUB colar ()
DECLARE SUB chao ()

apresentar
pain
flash
tuboconcha
tresd
papagaio
passaro
nave
estrela
piramide
linhas
colar
chao
SLEEP 0

SUB apresentar

CLS
COLOR 10
SCREEN 9
FOR y = 140 TO 155 STEP 3
FOR x = 160 TO 490
LINE (320, 1)-(x, 140), y - (140 - 1)
 NEXT
NEXT

   'apagar
FOR x = 1 TO 140
LINE (160, x)-(490, x), 0
NEXT


COLOR 1
FRASE$ = "SPOOLER PRESENTS"

PS = 1

x = 55
WHILE x <= 70
   FOR i = 75 TO x STEP -1
        LOCATE 10, i: PRINT MID$(FRASE$, PS, 1)
        LOCATE 10, i + 1: PRINT " "
   NEXT
   x = x + 1
   PS = PS + 1
WEND

COLOR 1

FOR i = 10 TO 24
LOCATE i, 55: PRINT "S"
LOCATE i - 1, 55: PRINT " "
NEXT

COLOR 2

FOR i = 10 TO 24
LOCATE i, 56: PRINT "P"
LOCATE i - 1, 56: PRINT " "
NEXT

COLOR 3

FOR i = 9 TO 24
LOCATE i, 57: PRINT "O"
LOCATE i - 1, 57: PRINT " "
NEXT

COLOR 4

FOR i = 8 TO 24
LOCATE i, 58: PRINT "O"
LOCATE i - 1, 58: PRINT " "
NEXT

COLOR 5

FOR i = 7 TO 24
LOCATE i, 59: PRINT "L"
LOCATE i - 1, 59: PRINT " "
NEXT

COLOR 6

FOR i = 6 TO 24
LOCATE i, 60: PRINT "E"
LOCATE i - 1, 60: PRINT " "
NEXT

COLOR 7
  FOR i = 5 TO 24
LOCATE i, 61: PRINT "R"
LOCATE i - 1, 61: PRINT " "
NEXT

COLOR 9

FOR i = 4 TO 24
LOCATE i, 63: PRINT "P"
LOCATE i - 1, 63: PRINT " "
NEXT

COLOR 10

FOR i = 3 TO 24
LOCATE i, 64: PRINT "R"
LOCATE i - 1, 64: PRINT " "
NEXT

COLOR 11

FOR i = 2 TO 24
LOCATE i, 65: PRINT "E"
LOCATE i - 1, 65: PRINT " "
NEXT

COLOR 12

FOR i = 2 TO 24
LOCATE i, 66: PRINT "S"
LOCATE i - 1, 66: PRINT " "
NEXT

COLOR 13

FOR i = 2 TO 24
LOCATE i, 67: PRINT "E"
LOCATE i - 1, 67: PRINT " "
NEXT

COLOR 14

FOR i = 2 TO 24
LOCATE i, 68: PRINT "N"
LOCATE i - 1, 68: PRINT " "
NEXT

COLOR 15

FOR i = 2 TO 24
LOCATE i, 69: PRINT "T"
LOCATE i - 1, 69: PRINT " "
NEXT

COLOR 1

FOR i = 2 TO 24
LOCATE i, 70: PRINT "S"
LOCATE i - 1, 70: PRINT " "
NEXT


FOR x = 400 TO 640
LINE (x, 0)-(x, 480), 0
NEXT

END SUB

SUB chao
               ' CHAO

SCREEN 7
SWidth = 320
SHeight = 200
SC = SWidth
cx = SWidth / 2
cy = SHeight / 2
YC = cy + 38
entr = 1
segy = 40
c1 = 4
c2 = 2
c3 = 1

DO

   FOR n = 1 TO SWidth / 2 STEP 2
      IF cx + n > 319 THEN STOP
      LINE (n, cy * 2)-(cx, YC), 1
      LINE (-160 + n, cy * 2)-(cx - 3, YC), 1
      LINE (-320 + n, cy * 2)-(cx - 3, YC), 1
      LINE (-480 + n, cy * 2)-(cx - 3, YC), 1
      LINE (-640 + n, cy * 2)-(cx - 3, YC), 1
      LINE (cx + n, cy * 2)-(cx, YC), 1
      LINE (cx * 2 + n, cy * 2)-(cx, YC), 1
      LINE (480 + n, cy * 2)-(cx - 3, YC), 1
      LINE (640 + n, cy * 2)-(cx - 3, YC), 1
      'LINHAS HORIZONTAIS
      LINE (0, YC + 62)-(SWidth, YC + 62), 1
      LINE (0, YC + 30)-(SWidth, YC + 30), 1
      LINE (0, YC + 15)-(SWidth, YC + 15), 1
      LINE (0, YC + 5)-(SWidth, YC + 5), 1
      LINE (0, YC)-(SWidth, YC), 1
       IF cy < 100 THEN GOSUB LINES
      ' apagar '''''''''''''''''''''''
      CLS 1
      IF n >= 70 AND entr = 1 THEN
      LET YC = YC - 2
      cy = cy - 1
      END IF
      IF cy < 70 THEN LET entr = 0
    NEXT n
LOOP UNTIL INKEY$ <> ""

LINES:
   
     IF corentr = 1 THEN LET corentr = 2
     IF corentr = 3 THEN LET corentr = 4
   
      IF cx + n = 319 AND corentr = 0 THEN GOSUB mudacores
      IF cx + n = 319 AND corentr = 2 THEN GOSUB mudacores2
      IF cx + n = 319 AND corentr = 4 THEN GOSUB mudacores3
   
      LINE (n, cy * 2)-(n, cy * 2 + segy), 4
      LINE (cx + n, cy * 2)-(cx + n, cy * 2 + segy), 10
      LINE (-160 + n, cy * 2)-(n, cy * 2 + segy), c1, BF        ' primeiro
      LINE (n, cy * 2)-(cx + n, cy * 2 + segy), c2, BF          ' segundo
      LINE (cx * 2 + n, cy * 2)-(cx + n, cy * 2 + segy), c3, BF ' terceiro
      LINE (0, cy * 2 + segy)-(320, cy * 2 + segy), 1
IF INKEY$ <> "" THEN GOTO fim
RETURN

mudacores:
   c1 = 1        '4,2,1
   c2 = 4
   c3 = 2
 corentr = 1
RETURN

mudacores2:
   c1 = 2
   c2 = 1
   c3 = 4
 corentr = 3
RETURN

mudacores3:
  c1 = 4
  c2 = 2
  c3 = 1
 corentr = 0
RETURN

fim:
SCREEN 0
CLS                    'fim
PRINT " Paindemo por S‚rgio Freire. "
PRINT "     Sergio Freire                  "
PRINT "     Rua Dr. Jose Antonio Almeida,15"
PRINT "     Soza "
PRINT "     3840 Vagos"


    FOR i = 540 TO 37 STEP -5
    SOUND i, .2
    NEXT i



END SUB

SUB colar
                  ' COLAR

pi = 3.141592654#
cx = 320
cy = 180
RX = 100
RY = 100
c = 1
acry = 30
DO
        XTOP = rndx
        Ytop = 1
        FOR q = 0 TO 4 * pi STEP .09
                x = cx + COS(q) * RX * 1.3 * q / 9
                y = cy + SIN(q) * RY * q / 9

                pos1 = cx + COS(q + .5) * RX * 1.3 * q / 7
                pos2 = cx + COS(q + 1) * RX * 1.3 * q / 7
                pos3 = cx + COS(q + 1.5) * RX * 1.3 * q / 7
                pos4 = cx + COS(q + 2) * RX * 1.3 * q / 7
                pos5 = cx + COS(q + 2.5) * RX * 1.3 * q / 7
                pos6 = cx + COS(q + 3) * RX * 1.3 * q / 7
                pos7 = cx + COS(q + 3.5) * RX * 1.3 * q / 7
                pos8 = cx + COS(q + 4) * RX * 1.3 * q / 7

                LINE (pos1, y)-(pos2, y - acry)
                LINE (pos2, y)-(pos3, y - acry)
                LINE (pos3, y)-(pos4, y - acry)
                LINE (pos4, y)-(pos5, y - acry)
                LINE (pos5, y)-(pos6, y - acry)
                LINE (pos6, y)-(pos7, y - acry)
                LINE (pos7, y)-(pos8, y - acry)
                'LINE (pos8, y)-(pos1, y-acry)


                LINE (pos1, y)-(pos1, y - acry)
                LINE (pos2, y)-(pos2, y - acry)
                LINE (pos3, y)-(pos3, y - acry)
                LINE (pos4, y)-(pos4, y - acry)
                LINE (pos5, y)-(pos5, y - acry)
                LINE (pos6, y)-(pos6, y - acry)
                LINE (pos7, y)-(pos7, y - acry)
                LINE (pos8, y)-(pos8, y - acry)

                LINE (pos1, y)-(pos2, y - acry), 0
                LINE (pos2, y)-(pos3, y - acry), 0
                LINE (pos3, y)-(pos4, y - acry), 0
                LINE (pos4, y)-(pos5, y - acry), 0
                LINE (pos5, y)-(pos6, y - acry), 0
                LINE (pos6, y)-(pos7, y - acry), 0
                LINE (pos7, y)-(pos8, y - acry), 0
                'LINE (pos8, y)-(pos1, y-acry), 0

                LINE (pos1, y)-(pos1, y - acry), 0
                LINE (pos2, y)-(pos2, y - acry), 0
                LINE (pos3, y)-(pos3, y - acry), 0
                LINE (pos4, y)-(pos4, y - acry), 0
                LINE (pos5, y)-(pos5, y - acry), 0
                LINE (pos6, y)-(pos6, y - acry), 0
                LINE (pos7, y)-(pos7, y - acry), 0
                LINE (pos8, y)-(pos8, y - acry), 0


        NEXT q

     rndx = RND * 640
     c = RND * 15
LOOP UNTIL INKEY$ <> ""

END SUB

SUB estrela
             ' ESTRELA

pi = 3.141592654#
cx = 260
cy = 180
RX = 100
RY = 80
c = 1
DO
        XTOP = rndx
        Ytop = 1
        FOR q = 0 TO 2 * pi STEP .09
                x = cx + COS(q) * RX * q / 5
                d = x
                y = cy + SIN(q) * RY * q / 5
                e = y
                x = cx + COS(q + 2) * RX * 1.3 * q / 5
                y = cy + SIN(q + 2) * RY * q / 5
                a = x
                b = y
                k = cx + COS(q + 4) * RX * 1.3 * q / 5
                l = cy + SIN(q + 4) * RY * q / 5
                IF cx - x >= 5 OR cy - y = 5 THEN
                LET dado = 1
                END IF


                q = q + .9
                x = cx + COS(q) * RX * q / 5
                z = x
                y = cy + SIN(q) * RY * q / 5
                w = y
                x = cx + COS(q + 2) * RX * 1.3 * q / 5
                y = cy + SIN(q + 2) * RY * q / 5
                r = x
                t = y
                x = cx + COS(q + 4) * RX * 1.3 * q / 5
                y = cy + SIN(q + 4) * RY * q / 5
                LINE (z, w)-(r, t), 4
                LINE (r, t)-(x, y), 4
                LINE (x, y)-(z, w), 4
                LINE (a, b)-(d, e), 4
                LINE (d, e)-(k, l), 4
                LINE (k, l)-(a, b), 4


                LINE (z, w)-(r, t), 0
                LINE (r, t)-(x, y), 0
                LINE (x, y)-(z, w), 0
                LINE (a, b)-(d, e), 0
                LINE (d, e)-(k, l), 0
                LINE (k, l)-(a, b), 0


                q = q - .9

              NEXT q
        FOR q = 2 * pi TO 0 STEP -.09
                x = cx + COS(q) * RX * q / 5
                d = x
                y = cy + SIN(q) * RY * q / 5
                e = y
                x = cx + COS(q + 2) * RX * 1.3 * q / 5
                y = cy + SIN(q + 2) * RY * q / 5
                a = x
                b = y
                k = cx + COS(q + 4) * RX * 1.3 * q / 5
                l = cy + SIN(q + 4) * RY * q / 5
                IF cx - x >= 5 OR cy - y = 5 THEN
                LET dado = 1
                END IF


                q = q + .9
                x = cx + COS(q) * RX * q / 5
                z = x
                y = cy + SIN(q) * RY * q / 5
                w = y
                x = cx + COS(q + 2) * RX * 1.3 * q / 5
                y = cy + SIN(q + 2) * RY * q / 5
                r = x
                t = y
                x = cx + COS(q + 4) * RX * 1.3 * q / 5
                y = cy + SIN(q + 4) * RY * q / 5
                LINE (z, w)-(r, t), 4
                LINE (r, t)-(x, y), 4
                LINE (x, y)-(z, w), 4
                LINE (a, b)-(d, e), 4
                LINE (d, e)-(k, l), 4
                LINE (k, l)-(a, b), 4


                LINE (z, w)-(r, t), 0
                LINE (r, t)-(x, y), 0
                LINE (x, y)-(z, w), 0
                LINE (a, b)-(d, e), 0
                LINE (d, e)-(k, l), 0
                LINE (k, l)-(a, b), 0

     
                q = q - .9

      NEXT q

c = RND * 15
LOOP UNTIL INKEY$ <> ""

END SUB

SUB flash
                                 'flash
    DO
    SCREEN 1
    VIEW (1, 1)-(318, 198), 15, 0
    CLS
    FOR a = 1 TO 50: NEXT a
    LOOP UNTIL INKEY$ <> ""

END SUB

SUB linhas
                ' LINHAS

pi = 3.141592654#
cx = 320
cy = 180
RX = 100
RY = 100
c = 1
DO
        XTOP = rndx
        Ytop = 1
        FOR q = 0 TO 2 * pi STEP .09
                x = cx + ATN(q) * RX
                y = cy + COS(q) * RY
                LINE (y * g, x)-(x, y), c
     
        NEXT q
     
        FOR q = 0 TO 2 * pi STEP .09
                x = cx + ATN(q) * RX
                y = cy + COS(q) * RY
                LINE (y * g, x)-(x, y), 0
        NEXT q
       rndx = RND * 640
     g = RND * 8
     c = (RND * 14) + 1
LOOP UNTIL INKEY$ <> ""

pi = 3.14159265#
cx = 160
cy = 180
RX = 100
RY = 100
c = 1
DO
        XTOP = rndx
        Ytop = 1
        FOR q = 0 TO 2 * pi STEP .09
                x = cx + COS(q) * RX * 1.3
                y = cy + SIN(q) * RY
                f = cx + COS(q + pi + 2) * RX * 1.3
                g = cy + SIN(q + pi + 7) * RY
                'PSET (x, y)
                'PSET (f, g), 10
                LINE (x, y)-(f, g), c
                ' LINE (x, y)-(f, g), 0
        NEXT q
        FOR q = 0 TO 2 * pi STEP .09
                x = cx + COS(q) * RX * 1.3
                y = cy + SIN(q) * RY
                f = cx + COS(q + pi + 2) * RX * 1.3
                g = cy + SIN(q + pi + 7) * RY
                'PSET (x, y)
                'PSET (f, g), 10
                LINE (x, y)-(f, g), 0
                ' LINE (x, y)-(f, g), 0
        NEXT q

        'FOR q = 0 TO 2 * pi STEP .09
        '        X = cx + COS(q) * rx * 1.3
        '        Y = cy + SIN(q) * RY
        '        LINE (XTOP, Ytop)-(X, Y), 0
        'NEXT q
  
  
     rndx = RND * 640
     c = RND * 15

LOOP UNTIL INKEY$ <> ""

END SUB

SUB nave

                       'nave

pi = 3.141592654#
cx = 160
cy = 180
RX = 100
RY = 100
c = 1

   c = 1
   d = 4
   SCREEN 9
    CLS


      WINDOW (1, 1)-(640, 480)
    DO
    FOR x = 0 TO 400 STEP 24
    y = 1
    LET y = 20 * COS(x - 80) + 270
        LINE (200, 300)-(100, y), 5  'AZUL
        LINE (200, 300)-(300, y), 5   'VERDE
        LINE (300, y)-(220, y), 13     'BRANCO
        LINE (200, 300)-(220, y), 4  'VERMELHO
        LINE (100, y)-(180, y), 13  ' AMARELO
        LINE (180, y)-(200, 300), 4    'VIOLETA
        LINE (200, 300)-(100, y), 0
        LINE (200, 300)-(300, y), 0
        LINE (300, y)-(200, y), 0
        LINE (200, 300)-(220, y), 0
        LINE (100, y)-(180, y), 0
        LINE (180, y)-(200, 300), 0

        FOR q = 0 TO 2 * pi STEP .8
                e = cx + COS(q) * RX * 1.3
                r = cy + SIN(q) * RY
                XTOP = RND * (e * 3.5)
                Ytop = RND * (r * 4)
                LINE (XTOP, Ytop)-(320, 200), c
                LINE (XTOP, Ytop)-(320, 200), 0
        NEXT q




    NEXT x

  LOOP UNTIL INKEY$ <> ""

END SUB

SUB pain
                       'Pain Demo
SCREEN 9

    LINE (0, 0)-(12, 12), 4, BF
    LOCATE (11)
    COLOR 11
    PRINT "              Pain Demo"
    DIM letra(1 TO 10000)
    GET (290, 130)-(100, 160), letra
    DIM BOX%(1 TO 10000)
    x1% = 12: x2% = 1: Y1% = 1: Y2% = 12
    GET (x1%, Y1%)-(x2%, Y2%), BOX%

    CLS

    FOR c = 1 TO 100 STEP 2
    PUT (400, c), letra, PSET
    NEXT c

pi = 3.141592654#
cx = 160
cy = 180
RX = 50
RY = 50

DO
        XTOP = rndx
        Ytop = 1
        FOR q = 0 TO 2 * pi STEP .09
                x = cx + COS(q) * RX * 1.3
                y = cy + SIN(q) * RY
                PUT (x, y), letra, PSET
  
        NEXT q

    LOOP WHILE INKEY$ = ""

    FOR k = 10 TO 400
x1 = 200
        Y1% = 188
        PUT (k + 10, Y1%), BOX%, XOR
        PUT (220 + k, 110), BOX%, XOR
NEXT

CLS
pi = 3.141592654#
cx = 160
cy = 180
RX = 50
RY = 50
c = 1
DO
        XTOP = rndx
        Ytop = 1
        FOR q = 0 TO 2 * pi STEP .07
                x = cx + COS(q) * RX * 1.3
                y = cy + SIN(q) * RY
                PUT (x, y), BOX%, XOR
   
        NEXT q
   
LOOP WHILE INKEY$ = ""

END SUB

SUB papagaio
                        'papagaio
   c = 4
   d = 4
   SCREEN 9
    CLS
    DO
 
      WINDOW (1, 1)-(640, 480)
    FOR x = 0 TO 400 STEP 12
    y = 1
    LET y = 20 * COS(x - 80) + 270
        LINE (y, 390)-(x, y), c
        LINE (y, 0)-(x, y), c
        LINE (y, 240)-(x, y), c
        LINE (y, 390)-((400 - x), y), d
        LINE (y, 240)-((400 - x), y), d
        LINE ((400 - x), y)-(y, 0), d
        REM FOR delay% = 1 TO 100: NEXT delay%
        REM PRESET (x, Y)
        LINE (y, 390)-(x, y), 0
        LINE (y, 0)-(x, y), 0
        LINE (y, 240)-(x, y), 0
        LINE (y, 390)-((400 - x), y), 0
        LINE (y, 240)-((400 - x), y), 0
        LINE ((400 - x), y)-(y, 0), 0
    NEXT x
    LOOP UNTIL INKEY$ <> ""

END SUB

SUB passaro

                  'passaro
 
   c = 4
   d = 4
   SCREEN 9
    CLS
    DO

      WINDOW (1, 1)-(640, 480)
      REM LINE (0, 1)-(640, 1), 4
      REM LINE (1, 1)-(1, 480), 4
    FOR x = 0 TO 400 STEP 6
    y = 1
    LET y = 20 * COS(x - 80) + 270
        LINE (200, 300)-(100, y), 1  'AZUL
        LINE (200, 300)-(300, y), 2   'VERDE
        LINE (300, y)-(220, y), 7     'BRANCO
        LINE (200, 300)-(220, y), 4   'VERMELHO
        LINE (100, y)-(180, y), 14  ' AMARELO
        LINE (180, y)-(200, 300), 13   'VIOLETA
        LINE (200, 300)-(100, y), 0
        LINE (200, 300)-(300, y), 0
        LINE (300, y)-(200, y), 0
        LINE (200, 300)-(220, y), 0
        LINE (100, y)-(180, y), 0
        LINE (180, y)-(200, 300), 0
    NEXT x
    LOOP UNTIL INKEY$ <> ""

END SUB

SUB piramide
                ' PIRAMIDE

pi = 3.141592654#
cx = 260
cy = 180
RX = 100
RY = 80
c = 1
DO
        XTOP = rndx
        Ytop = 1
        FOR q = 0 TO 2 * pi STEP .09
                x = cx + COS(q) * RX * 1.3
                d = x
                y = cy + SIN(q) * RY
                e = y
                PSET (x, y), 4
                x = cx + COS(q + 2.1) * RX * 1.3
                y = cy + SIN(q + 12.1) * RY
                a = x
                b = y
                x = cx + COS(q + 4) * RX * 1.3
                y = cy + SIN(q + 4) * RY
                PSET (x, y)
                LINE (250, 100)-(x, y), 1
                LINE (250, 100)-(a, b), 1
                LINE (250, 100)-(d, e), 1
                LINE (a, b)-(d, e), 4
                LINE (d, e)-(x, y), 4
                LINE (x, y)-(a, b), 4

                LINE (250, 100)-(x, y), 0
                LINE (250, 100)-(a, b), 0
                LINE (250, 100)-(d, e), 0
                LINE (XTOP, Ytop)-(x, y), 0
                LINE (a, b)-(d, e), 0
                LINE (d, e)-(x, y), 0
                LINE (x, y)-(a, b), 0
        NEXT q

     rndx = RND * 640
     c = RND * 15
LOOP UNTIL INKEY$ <> ""

END SUB

SUB tresd
                 ' 3D
    CLS
    FOR x = 110 TO 490 STEP 3
    y = 1
    LET y = .009 * ((x - 320) * (x - 320)) + 40
    LET a = (x)
        PRINT ""
        REM LINE (320, 480)-(x, y), 4
        LINE (320, 240)-(x, y), 1
        REM LINE (a, 40)-(x, y), 3
        REM LINE (320, 480)-(x, y), 0
        REM LINE (320, 0)-(x, y), 0
        REM LINE (a, 40)-(x, y), 0
        REM LINE (a, 10)-(x, y), 5, B
        REM LINE (a, 10)-(x, y), 0, B
    NEXT x
    CLS
    WINDOW
    FOR x = 110 TO 700 STEP 3
    y = 1
    LET y = .009 * ((x - 320) * (x - 320)) + 40
    LET a = x / 3
        PRINT ""
        REM LINE (320, 480)-(x, y), 4
        LINE (320, 240)-(x, y), 2
        REM LINE (a, 40)-(x, y), 3
        REM LINE (320, 480)-(x, y), 0
        REM LINE (320, 240)-(x, y), 0
        REM LINE (a, 40)-(x, y), 0
        REM LINE (a, 10)-(x, y), 5, B
        REM LINE (a, 10)-(x, y), 0, b
      NEXT x
      
                   
END SUB

SUB tuboconcha
                              'tubo
    SCREEN 9
    WINDOW (1, 1)-(640, 480)
    FOR x = 266 TO 410 STEP .75
    y = 1
    LET y = .1 * ((x - 320) * (x - 320)) + 180
        COLOR 1, 0
        CIRCLE (x, y), 20, 1
        x = x - 9
    LET y = a
    LET y = .1 * ((x - 320) * (x - 320)) + 180
        CIRCLE (x, y), 20, 8
        x = x + 9
        x = x - 13.5
        LET y = .1 * ((x - 320) * (x - 320)) + 180
        CIRCLE (x, y), 20, 0
        REM CIRCLE (X, y), 20, 2
        REM CIRCLE (X, y), 20, 0
        x = x + 13.5
    NEXT x
                      
          'concha
  

   c = 3
   d = 5
   SCREEN 9
    FOR b = 1 TO 10 STEP 3
      WINDOW (1, 1)-(640, 480)
      REM LINE (0, 1)-(640, 1), 4
      REM LINE (1, 1)-(1, 480), 4
    FOR x = 1 TO 640 STEP 6
    y = 1
    LET y = 20 * COS(x - 80) + 270
        LINE (320, 480)-(x, y), c
        LINE (320, 0)-(x, y), d
        REM FOR delay% = 1 TO 100: NEXT delay%
        REM PRESET (x, Y)
    NEXT x
    c = c + 1
    d = d + 1
    NEXT b

END SUB

