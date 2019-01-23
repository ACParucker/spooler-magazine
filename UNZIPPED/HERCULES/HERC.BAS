'Jogo HERCULES
'Linguagem:     Quickbasic
'Programador:   Fernando Pinheiro
'Data:          Algures em 1993
'Conselho:      Divirtam-se


RANDOMIZE TIMER ' Os Numeros e posi‡”es criadas aleatoriamente ser„o mesmo
                ' imprevisiveis

DEFINT A-Z 'Definir todas as variaveis como inteiras

Modo = 1                                        'Parametros do DOS que reduz a
IF MID$(COMMAND$, 1, 1) = "-" THEN Modo = 2     'velocidade de jogo
IF MID$(COMMAND$, 1, 1) = "+" THEN Modo = 3     '

Nfant = 3 ' Numero de inimigos em jogo
          ' Pode-se alterar

PLAY "mbl16t100o3"     'Definir o Som, dura‡„o da nota, batimentos e oitava

QMusica = 1

Resp$ = "X"
WHILE UCASE$(Resp$) <> "S" AND UCASE$(Resp$) <> "N"
   CLS
   WIDTH 40: COLOR 10
   LOCATE 12, 12: PRINT "Quer Musica?(S/N)"
   Resp$ = INPUT$(1)
WEND

IF UCASE$(Resp$) = "N" THEN QMusica = 0

DIM Musica$(20) 'Dimensionar um Buffer para conter a musica
Musica$(1) = "f+p10c+f+p10c+f+c+"
Musica$(2) = "f+a+>c+p5<bp10g+bp10g+"            '
Musica$(3) = "bg+fg+c+p5f+p13f+p10"              '
Musica$(4) = "a+g+f+f+ffp10g+bfg+f+f+p10"        '
Musica$(5) = "a+g+f+f+ffp10g+bff+f+t175"         '
Musica$(6) = "gf+ff+a+p20a+p20ba+"               ' Definir
Musica$(7) = "aa+>c+p20c+p20d+c+<b"              '
Musica$(8) = "a+>c+t100p5c+p10c+d+p10c+"         '    a
Musica$(9) = "c+<bbp18ba+a"                      '
Musica$(10) = "p18a+g+g+p18f+fd+f"               ' musica
Musica$(11) = "t175f+ff+ff+ff+ff+ff+ff+"         '
Musica$(12) = "ff+ff+ff+ff+ff+ff+ff+ff+ff+ff+p5" '
Musica$(13) = "t100a+>c+<ba+g+bp13g+"            '
Musica$(14) = "fp8f+p6a+>c+<ba+g+bp13g+fc+d+f"   '
Musica$(15) = "t175f+ff+ff+ff+ff+ff+ff+"         '
Musica$(16) = "ff+ff+ff+ff+ff+ff+ff+ff+ff+fp4"   '

Musica = 2'Inicializar a parte da musica a ser tocada como sendo a primeira

SCREEN 1 ' Ecr„ CGA
'PALETTE 1, 0 '
'PALETTE 2, 0 ' => Palette Negra para que os graficos possam ser desenhados
'PALETTE 3, 0 '    sem vis„o do jogador (S¢ possivel em VGA)

COLOR 0, 2 ' Comando que vai tentar substituir as instru‡”es Palette em CGA


'(**********************************Gr ficos*********************************)
'Heroi (HERCULES)
PSET (10, 10)        '
PSET (9, 9)          '
PSET (10, 10)        '
PSET (7, 9)          '
PSET (5, 9)          '
PSET (2, 10)         '
PSET (3, 9)          '
LINE (3, 8)-(9, 8)   '      =>Defini‡„o Grafica #1 do Heroi
LINE (2, 7)-(10, 7)  '
LINE (3, 6)-(9, 6)   '
LINE (7, 7)-(5, 7), 0'
LINE (3, 5)-(9, 5)   '
LINE (4, 4)-(8, 4)   '
PSET (4, 5), 0       '
PSET (8, 5), 0       '
PSET (7, 10)         '
PSET (5, 10)         '
PSET (7, 10), 0      '
DIM Herc1%(100), Herc2%(100) 'Dimensionamento dos array's que v„o conter os Graficos do Heroi
GET (0, 2)-(12, 12), Herc1% 'Leitura do Grafico #1 do heroi para um array
PSET (7, 10)         '      =>Defini‡„o Grafica #2 do Heroi
PSET (5, 10), 0      '
GET (0, 2)-(12, 12), Herc2% 'Leitura do Grafico #2 do heroi para uma array

CLS

'Fantasmas
FOR z = 0 TO 5                       '
CIRCLE (6, 7), z, 1                  '
NEXT                                 '
LINE (4, 6)-(5, 7), 2, BF            ' => Defini‡„o Grafica dos Fantasmas
LINE (7, 6)-(8, 7), 2, BF            '
CIRCLE (6, 12), 3, 3, .9, 2.5, 1.1   '
LINE (5, 10)-(7, 10), 0              '
DIM Fant%(100)  ' Dimensionamento dum array para conter o grafico dos inimigos
GET (0, 2)-(12, 12), Fant% 'Leitura do grafico dos inimigos para um array

CLS

'Bonus
'cereja
CIRCLE (3, 7), 2, 2    '
PAINT (3, 7), 2        '
CIRCLE (9, 7), 2, 2    '
PAINT (9, 7), 2        '  =>Defini‡„o Grafica do Bonus #1 (cereja)
LINE (3, 5)-(5, 0), 3  '
LINE (9, 5)-(5, 0), 3  '
LINE (4, 0)-(7, 0), 3  '
DIM cereja%(100) 'Dimensionamento do array que contera o grafico do 1§ Bonus
GET (0, 0)-(12, 12), cereja% ' Leitura do Grafico do 1§ Bonus para um Array
CLS
'ma‡„
CIRCLE (6, 8), 3, 2        '
PAINT (6, 8), 2            '
PSET (6, 10), 0            '
LINE (6, 5)-(6, 3), 3      ' =>Defini‡„o Grafica do Bonus #2 (ma‡„)
PSET (5, 2), 3             '
CIRCLE (9, 3), 2, 1, , , .3'
PAINT (9, 3), 1            '
DIM maca%(100)  ' Dimensionamento do array que conter  o grafico do 2§ Bonus
GET (1, 1)-(13, 13), maca% ' Leitura do Grafico do 2§ Bonus para um array
CLS
'Cifr„o
LOCATE 1, 1:  PRINT "$"         ' => Defini‡„o Grafica do Bonus #3 (cifr„o)
DIM cifrao%(100) 'Dimensionamento do array que contera o grafico do 3§ Bonus
GET (0, 0)-(12, 12), cifrao% '1§ Leitura do Gr fico do 3§ Bonus para um array
CLS
PUT (2, 2), cifrao% 'Impressao no ecr„ do 3§ Bonus centrando-o no local desejado
GET (0, 0)-(12, 12), cifrao% 'Leitura final do Grafico do 3§ Bonus para um array

CLS

'(*********************************Apresenta‡„o******************************)

IF QMusica THEN

PLAY "X" + VARPTR$(Musica$(1))'Inicializar o Buffer de Musica

ON PLAY(1) GOSUB MaisMusica 'Definir o chamador de eventos para a musica de
                            'BackGround em que sempre que o Buffer s¢ tiver uma
                            'nota deve ir   rotina ,MaisMusica encher outra vez
                            'o buffer musical
PLAY ON 'Accionar o chmador de eventos da musica BackGround
END IF

DIM nome$(5) ' Dimensionamento das variaveis que conter„o o titulo do jogo
nome$(1) = "Û  Û ÛÛÛÛ ÛÛÛÛ ÛÛÛÛ Û  Û Û    ÛÛÛÛ ÛÛÛÛ" '
nome$(2) = "Û  Û Û    Û  Û Û    Û  Û Û    Û    Û   " '=> Defini‡„o do nome
nome$(3) = "ÛÛÛÛ ÛÛÛ  ÛÛÛÛ Û    Û  Û Û    ÛÛÛ  ÛÛÛÛ" '   do jogo e atribui‡„o
nome$(4) = "Û  Û Û    Û Û  Û    Û  Û Û    Û       Û" '   do mesmo a variaveis
nome$(5) = "Û  Û ÛÛÛÛ Û  Û ÛÛÛÛ ÛÛÛÛ ÛÛÛÛ ÛÛÛÛ ÛÛÛÛ" '   dum array

LOCATE 4                 '
PRINT SPC(1); nome$(1)   '
PRINT SPC(1); nome$(2)   ' => Impress„o do nome do jogo no ecr„
PRINT SPC(1); nome$(3)   '
PRINT SPC(1); nome$(4)   '
PRINT SPC(1); nome$(5)   '
                        

LOCATE 25: PRINT " Use a barra de espa‡os para prosseguir"; 'Impress„o no ecr„
                                                            'linha 25 de uma
                                                            'mensagem auxiliar
'PALETTE 1, 4 'Cor #1 : Vermelho       
'PALETTE 2, 3 'Cor #2 : Turquesa                   (S¢ possivel em VGA)
'PALETTE 3, 10 'Cor #3 : Verde Alta Intensidade


Tecla$ = "X"                                          '
x = 300                                               '
WHILE Tecla$ <> CHR$(32) AND x > -40                  '
Tecla$ = INKEY$                                       '
IF x > 0 AND x < 301 THEN PUT (x, 100), Herc1%        '
IF x > -20 AND x < 281 THEN PUT (x + 20, 100), Fant%  '
IF x > -40 AND x < 261 THEN PUT (x + 40, 100), Fant%  '
FOR z = 1 TO 300: NEXT                                '
IF x > 0 AND x < 301 THEN PUT (x, 100), Herc1%        '
IF x > -20 AND x < 281 THEN PUT (x + 20, 100), Fant%  '=>Ciclo que espera
IF x > -40 AND x < 261 THEN PUT (x + 40, 100), Fant%  '  pela press„o da
IF x > 0 AND x < 301 THEN PUT (x, 100), Herc2%        '  barra de espa‡os
IF x > -20 AND x < 281 THEN PUT (x + 20, 98), Fant%   '  enquanto passa no
IF x > -40 AND x < 261 THEN PUT (x + 40, 98), Fant%   '  ecr„ uma anima‡„o
FOR z = 1 TO 300: NEXT                                '  relativa ao jogo
IF x > 0 AND x < 301 THEN PUT (x, 100), Herc2%        '
IF x > -20 AND x < 281 THEN PUT (x + 20, 98), Fant%   '
IF x > -40 AND x < 261 THEN PUT (x + 40, 98), Fant%   '
x = x - 1                                             '
WEND                                                  '

'PALETTE 1, 0 '
'PALETTE 2, 0 ' => Palette Negra para que os ecr„ possa ser desenhado
'PALETTE 3, 0 '    sem vis„o do jogador (S¢ possivel em VGA)

CLS

'(******************************Leitura do ecr„ de Jogo**********************)
inicio: ' Rotina que ser  chamada sempre que um novo jogo comece

COLOR 0, 2 ' Comando que vai tentar substituir as instru‡”es Palette em CGA

DIM ecra$(19, 26)  ' Dimensionamento do array que contera o labirinto do jogo
OPEN "hercules.lbr" FOR INPUT AS #1 ' Abertura do ficheiro com a defini‡ao
                                    ' do ecr„ de jogo.
FOR z = 1 TO 19                  '
INPUT #1, linha$                 '
FOR x = 1 TO 26                  '  =>Leitura do Labirinto do jogo do ficheiro
ecra$(z, x) = MID$(linha$, x, 1) '
NEXT                             '
NEXT                             '
CLOSE
                                '
FOR z = 1 TO 19                 '
FOR x = 1 TO 26                 '  => Impress„o no ecr„ do labirinto de jogo
IF ecra$(z, x) = "Û" THEN       '
LINE (x * 12 - 12, z * 10 - 10)-(x * 12, z * 10), 1, BF
LINE (x * 12 - 10, z * 10 - 8)-(x * 12 - 2, z * 10 - 2), 2, BF
END IF                          '
NEXT                            '
NEXT                            '

'(**************************Inicializa‡”es de Jogo***************************)


'PALETTE 1, 4 'Cor #1 : Vermelho
'PALETTE 2, 3 'Cor #2 : Turquesa                 (S¢ possivel em VGA)
'PALETTE 3, 10 'Cor #3 : Verde Alta Intensidade

Vidas = 3: Pontos = 0             ' Variaveis de Jogo Novo
FantasmaActual = 1      'Qual o fantasma a ser actualizado

Novas:                             'Rotina a chamar sempre que se perde uma
                                   'vida

HercX = INT(RND * 19) + 1         '
HercY = INT(RND * 26) + 1         '
WHILE ecra$(HercX, HercY) = "Û"   '
HercY = INT(RND * 26) + 1         ' => Inicializa‡„o das variaveis que
WEND                              '    controlar„o o heroi
HercSX = 0                        '
HercSY = 0                        '
                                  '
DIM FantX(Nfant), FantY(Nfant), FantSX(Nfant), FantSY(Nfant)'=>Inicializa‡„o
FOR z = 1 TO Nfant                                          '  dos array's
FantX(z) = INT(RND * 17 + 2)                                '      que
FantY(z) = INT(RND * 24 + 2)                                '  controlar„o
WHILE ecra$(FantX(z), FantY(z)) = "Û"                       '  os fantasmas
FantY(z) = INT(RND * 25 + 2)                                '   durante o
WEND                                                        '     jogo
NEXT                                                        '


Bonus = INT(RND * 3 + 1)                 '
BonusX = INT(RND * 19 + 1)               '
BonusY = INT(RND * 26 + 1)               ' => Selec‡„o aleatoria da coordenada
WHILE ecra$(BonusX, BonusY) = "Û"        '    do Bonus e do tipo de Bonus
BonusY = INT(RND * 26 + 1)               '
WEND                                     '

SELECT CASE Bonus                                        '
CASE 1: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cereja%'=> Impress„o no ecr„
CASE 2: PUT (BonusY * 12 - 12, BonusX * 10 - 10), maca%  '   do tipo de bonus
CASE 3: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cifrao%'
END SELECT                                               '

PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%     ' =>Inicializa‡„o dos
FOR z = 1 TO Nfant                                 '   graficos do heroi
PUT (FantY(z) * 12 - 12, FantX(z) * 10 - 10), Fant%'   e Fantasmas no ecr„
NEXT                                               '


'(*******************************Ciclo De Jogo*******************************)
Jogo: 'Label Chamada durante o ciclo de Jogo

LOCATE 25, 5: PRINT "VIDAS:"; Vidas;       ' =>Imprimir no ecr„ os dados
LOCATE 25, 20: PRINT "PONTOS:"; Pontos;    '   de jogo (Vidas e Pontua‡„o)


IF Modo <> 2 THEN 'Se o modo 1 o heroi nao tem inercia
Tecla$ = INKEY$                     'As Proximas 73 Linhas de Programa
IF Tecla$ = CHR$(27) THEN GOTO Fim  'cuidam de receber os dados exteriores
IF LEN(Tecla$) = 2 THEN             'tais como Teclas Premidas, Verificam
'                                   'se as coordenadas do heroi coincidem
Tecla$ = RIGHT$(Tecla$, 1)          'com Bonus, Actualizam os graficos e
SELECT CASE Tecla$                  'posi‡”es relativos ao Heroi e Bonus.
CASE "H": HercSX = -1: HercSY = 0
CASE "P": HercSX = 1: HercSY = 0
CASE "K": HercSY = -1: HercSX = 0
CASE "M": HercSY = 1: HercSX = 0
END SELECT
'
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
IF HercX + HercSX < 20 AND HercX + HercSX > 0 AND HercY + HercSY > 0 AND HercY + HercSY < 27 THEN
IF ecra$(HercX + HercSX, HercY + HercSY) <> "Û" THEN
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
HercX = HercX + HercSX
HercY = HercY + HercSY
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
ELSE
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
END IF
ELSE
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
HercX = HercX + HercSX
HercY = HercY + HercSY
IF HercX < 1 THEN HercX = 19
IF HercX > 19 THEN HercX = 1
IF HercY < 1 THEN HercY = 26
IF HercY > 26 THEN HercY = 1
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
'PLAY "mbo2l16acebeca"
END IF
'
END IF
'
END IF

IF Modo = 2 THEN  'Se o modo 2 o heroi tem inercia
Tecla$ = INKEY$                     'As Proximas 73 Linhas de Programa
IF Tecla$ = CHR$(27) THEN GOTO Fim  'cuidam de receber os dados exteriores
IF LEN(Tecla$) = 2 THEN             'tais como Teclas Premidas, Verificam
'                                   'se as coordenadas do heroi coincidem
Tecla$ = RIGHT$(Tecla$, 1)          'com Bonus, Actualizam os graficos e
SELECT CASE Tecla$                  'posi‡”es relativos ao Heroi e Bonus.
CASE "H": HercSX = -1: HercSY = 0
CASE "P": HercSX = 1: HercSY = 0
CASE "K": HercSY = -1: HercSX = 0
CASE "M": HercSY = 1: HercSX = 0
END SELECT
'
END IF

PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
IF HercX + HercSX < 20 AND HercX + HercSX > 0 AND HercY + HercSY > 0 AND HercY + HercSY < 27 THEN
IF ecra$(HercX + HercSX, HercY + HercSY) <> "Û" THEN
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
HercX = HercX + HercSX
HercY = HercY + HercSY
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
ELSE
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
END IF
ELSE
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
HercX = HercX + HercSX
HercY = HercY + HercSY
IF HercX < 1 THEN HercX = 19
IF HercX > 19 THEN HercX = 1
IF HercY < 1 THEN HercY = 26
IF HercY > 26 THEN HercY = 1
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1%
'PLAY "mbo2l16acebeca"
END IF
'
END IF

PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1% 'Estas 2 Linhas Colocam o Heroi
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2% 'em duas Posi‡”es diferentes
                                               'dando a ideia de movimento.

IF HercX = BonusX AND HercY = BonusY THEN
'
'
Pontos = Pontos + 10
IF Pontos >= 2000 THEN GOTO AcabouOJogo
IF Pontos MOD 100 = 0 AND Vidas < 9 THEN
'PLAY "mbO2L12f+fgabo1l6bc"
Vidas = Vidas + 1
END IF
'
SELECT CASE Bonus
CASE 1: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cereja%
CASE 2: PUT (BonusY * 12 - 12, BonusX * 10 - 10), maca%
CASE 3: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cifrao%
END SELECT
'
Bonus = INT(RND * 3 + 1)                 '
BonusX = INT(RND * 19 + 1)               '
BonusY = INT(RND * 26 + 1)               ' => Selec‡„o aleatoria da coordenada
WHILE ecra$(BonusX, BonusY) = "Û"        '    do Bonus e do tipo de Bonus
BonusY = INT(RND * 26 + 1)               '
WEND                                     '
'
SELECT CASE Bonus
CASE 1: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cereja%
CASE 2: PUT (BonusY * 12 - 12, BonusX * 10 - 10), maca%
CASE 3: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cifrao%
END SELECT
'
END IF 'Aqui acabam as 73 linhas Relativas ao Processamento do Heroi e Bonus

DIM PilhaX(4), PilhaY(4)                          'Dimensionar Pilha para
                                                  'as jogadas dos fantasmas

IF Modo <> 1 THEN                                 'Estas Proximas Linhas
z = FantasmaActual                                'processam os movimentos
IF FantX(z) = 0 THEN FantX(z) = 9: FantY(z) = 14  'dos Fantasmas no jogo
IF FantX(z) = 19 THEN FantX(z) = 9: FantY(z) = 14 'verificando tambem se
IF FantY(z) = 0 THEN FantX(z) = 9: FantY(z) = 14  'coincidem com o Heroi
IF FantY(z) = 26 THEN FantX(z) = 9: FantY(z) = 14 'e se ele portanto morreu.
Nhip = 0
IF ecra$(FantX(z) + 1, FantY(z)) <> "Û" AND FantSX(z) <> -1 THEN
Nhip = 1
PilhaX(Nhip) = 1
PilhaY(Nhip) = 0
END IF
IF ecra$(FantX(z) - 1, FantY(z)) <> "Û" AND FantSX(z) <> 1 THEN
Nhip = Nhip + 1
PilhaX(Nhip) = -1
PilhaY(Nhip) = 0
END IF
IF ecra$(FantX(z), FantY(z) + 1) <> "Û" AND FantSX(z) <> 1 THEN
Nhip = Nhip + 1
PilhaX(Nhip) = 0
PilhaY(Nhip) = 1
END IF
IF ecra$(FantX(z), FantY(z) - 1) <> "Û" AND FantSX(z) <> 1 THEN
Nhip = Nhip + 1
PilhaX(Nhip) = 0
PilhaY(Nhip) = -1
END IF
IF Nhip >= 1 THEN
jog = INT(RND * Nhip) + 1
FantSX(z) = PilhaX(jog)
FantSY(z) = PilhaY(jog)
END IF
IF Nhip = 0 THEN
IF ecra$(FantX(z) + 1, FantY(z)) <> "Û" THEN FantSX(z) = 1: FantSY(z) = 0
IF ecra$(FantX(z) - 1, FantY(z)) <> "Û" THEN FantSX(z) = -1: FantSY(z) = 0
IF ecra$(FantX(z), FantY(z) + 1) <> "Û" THEN FantSX(z) = 0: FantSY(z) = 1
IF ecra$(FantX(z), FantY(z) - 1) <> "Û" THEN FantSX(z) = 0: FantSY(z) = -1
END IF
PUT (FantY(z) * 12 - 12, FantX(z) * 10 - 10), Fant%
FantX(z) = FantX(z) + FantSX(z)
FantY(z) = FantY(z) + FantSY(z)
IF FantX(z) = 0 THEN FantX(z) = 9: FantY(z) = 14
IF FantX(z) = 19 THEN FantX(z) = 9: FantY(z) = 14
IF FantY(z) = 0 THEN FantX(z) = 9: FantY(z) = 14
IF FantY(z) = 26 THEN FantX(z) = 9: FantY(z) = 14
PUT (FantY(z) * 12 - 12, FantX(z) * 10 - 10), Fant%
FOR x = 1 TO 50: NEXT'Diminuir a velocidade
IF FantX(z) = HercX AND FantY(z) = HercY THEN GOTO UmaVidaMenos
FantasmaActual = FantasmaActual + 1
IF FantasmaActual > Nfant THEN FantasmaActual = 1
END IF

IF Modo = 1 THEN                                  'Estas Proximas Linhas
FOR z = 1 TO Nfant                                'processam os movimentos
IF FantX(z) = 0 THEN FantX(z) = 9: FantY(z) = 14  'dos Fantasmas no jogo
IF FantX(z) = 19 THEN FantX(z) = 9: FantY(z) = 14 'verificando tambem se
IF FantY(z) = 0 THEN FantX(z) = 9: FantY(z) = 14  'coincidem com o Heroi
IF FantY(z) = 26 THEN FantX(z) = 9: FantY(z) = 14 'e se ele portanto morreu.
Nhip = 0
IF ecra$(FantX(z) + 1, FantY(z)) <> "Û" AND FantSX(z) <> -1 THEN
Nhip = 1
PilhaX(Nhip) = 1
PilhaY(Nhip) = 0
END IF
IF ecra$(FantX(z) - 1, FantY(z)) <> "Û" AND FantSX(z) <> 1 THEN
Nhip = Nhip + 1
PilhaX(Nhip) = -1
PilhaY(Nhip) = 0
END IF
IF ecra$(FantX(z), FantY(z) + 1) <> "Û" AND FantSX(z) <> 1 THEN
Nhip = Nhip + 1
PilhaX(Nhip) = 0
PilhaY(Nhip) = 1
END IF
IF ecra$(FantX(z), FantY(z) - 1) <> "Û" AND FantSX(z) <> 1 THEN
Nhip = Nhip + 1
PilhaX(Nhip) = 0
PilhaY(Nhip) = -1
END IF
IF Nhip >= 1 THEN
jog = INT(RND * Nhip) + 1
FantSX(z) = PilhaX(jog)
FantSY(z) = PilhaY(jog)
END IF
IF Nhip = 0 THEN
IF ecra$(FantX(z) + 1, FantY(z)) <> "Û" THEN FantSX(z) = 1: FantSY(z) = 0
IF ecra$(FantX(z) - 1, FantY(z)) <> "Û" THEN FantSX(z) = -1: FantSY(z) = 0
IF ecra$(FantX(z), FantY(z) + 1) <> "Û" THEN FantSX(z) = 0: FantSY(z) = 1
IF ecra$(FantX(z), FantY(z) - 1) <> "Û" THEN FantSX(z) = 0: FantSY(z) = -1
END IF
PUT (FantY(z) * 12 - 12, FantX(z) * 10 - 10), Fant%
FantX(z) = FantX(z) + FantSX(z)
FantY(z) = FantY(z) + FantSY(z)
IF FantX(z) = 0 THEN FantX(z) = 9: FantY(z) = 14
IF FantX(z) = 19 THEN FantX(z) = 9: FantY(z) = 14
IF FantY(z) = 0 THEN FantX(z) = 9: FantY(z) = 14
IF FantY(z) = 26 THEN FantX(z) = 9: FantY(z) = 14
PUT (FantY(z) * 12 - 12, FantX(z) * 10 - 10), Fant%
FOR x = 1 TO 50: NEXT'Diminuir a velocidade
IF FantX(z) = HercX AND FantY(z) = HercY THEN GOTO UmaVidaMenos
NEXT
END IF

ERASE PilhaX, PilhaY 'Aqui Acaba o modulo de processamento dos Fantasmas

PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2% 'Estas 2 Linhas Colocam o Heroi
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc1% 'em duas Posi‡”es diferentes
                                               'dando a ideia de movimento.

FOR z = 1 TO 50: NEXT      'Diminuir a velocidade

IF Vidas < 0 THEN GOTO Fim

GOTO Jogo                  'Chamada De Label do ciclo de jogo

'(************************Rotinas especiais de jogo**************************)

Fim: 'Rotina De Final De Jogo
ON ERROR GOTO Erro
ErroResolvido = 0

CLS

ERASE ecra$
ERASE FantX, FantY, FantSX, FantSY

DIM NomeJogador$(16), ScoreJogador(20)

RetornoDoErro:

IF ErroResolvido = 1 THEN
OPEN "Hercules.Pnt" FOR OUTPUT AS #1
WRITE #1, "Fernando Pinheiro   ", 160
WRITE #1, "Daniel Barbosa      ", 150
WRITE #1, "Jos‚ Augusto        ", 140
WRITE #1, "Manuel Soares       ", 130
WRITE #1, "Pedro Miguel        ", 120
WRITE #1, "Mario Rui           ", 110
WRITE #1, "Pedro Manuel        ", 100
WRITE #1, "Cristina Azevedo    ", 90
WRITE #1, "Daniela Filomena    ", 80
WRITE #1, "Vera Alegria        ", 70
WRITE #1, "Rui Costa           ", 60
WRITE #1, "Antonio Augusto     ", 50
WRITE #1, "Antonio Sergio      ", 40
WRITE #1, "Margarida           ", 30
WRITE #1, "Paulo Correia       ", 20
WRITE #1, "Paulo Renato        ", 10
CLOSE
END IF

OPEN "Hercules.Pnt" FOR INPUT AS #1


LOCATE 1, 10
COLOR , 1
PRINT "Tabela De Pontua‡”es"

x = 0
FOR z = 1 TO 16

INPUT #1, NomeJogador$(z), ScoreJogador(z)

IF Pontos > ScoreJogador(z) AND x = 0 THEN

LOCATE 25, 1: PRINT "Introduza o seu nome...";         '
                                                       '
NomeJogador$(z) = SPACE$(20)                           '
PosicaoNome = 1                                        '
                                                       '  Entrar o nome
WHILE (PosicaoNome < 20)                               '  do jogador
                                                       '
Entrada$ = "°"                                         '
                                                       '
WHILE LEN(Entrada$) = 0 OR Entrada$ = "°"              '
LOCATE z + 2, 1 + PosicaoNome: PRINT "Û"               '
Entrada$ = INKEY$                                      '
LOCATE z + 2, 2: PRINT NomeJogador$(z);                '
WEND                                                   '
                                                       '
BackSpace = 0                                          '
IF Entrada$ = CHR$(8) AND PosicaoNome > 1 THEN         '    (BackSpace)
PosicaoNome = PosicaoNome - 1                          '
BackSpace = 1                                          '
Entrada$ = MID$(NomeJogador$(z), PosicaoNome, 1)       '
END IF                                                 '
                                                       '
IF Entrada$ = CHR$(13) THEN                            '    (Return)
PosicaoNome = 20                                       '
Entrada$ = MID$(NomeJogador$(z), PosicaoNome, 1)       '
END IF                                                 '
                                                       '
MID$(NomeJogador$(z), PosicaoNome, 1) = Entrada$       '
LOCATE z + 2, 1 + PosicaoNome: PRINT Entrada$          '
                                                       '
IF BackSpace = 0 THEN PosicaoNome = PosicaoNome + 1    '                                     
                                                       '
WEND                                                   '

ScoreJogador(z) = Pontos
x = 1
LOCATE 25, 1: PRINT "                       ";

END IF

LOCATE z + 2, 2
PRINT NomeJogador$(z)
LOCATE z + 2, 30: PRINT ScoreJogador(z)
NEXT

CLOSE



OPEN "Hercules.Pnt" FOR OUTPUT AS #1
FOR z = 1 TO 16
WRITE #1, NomeJogador$(z), ScoreJogador(z)
NEXT
CLOSE

Tecla$ = "X"
WHILE Tecla$ <> CHR$(32)
Tecla$ = INKEY$
WEND

CLS

LOCATE 10
PRINT "Deseja Jogar Outra Vez? ( S \ <outra> )"
Tecla$ = "°"
WHILE LEN(Tecla$) = 0 OR Tecla$ = "°"
Tecla$ = INKEY$
WEND
'Tecla$ = INPUT$(1)
CLS
PLAY OFF
IF Tecla$ = "S" OR Tecla$ = "s" THEN
IF QMusica THEN PLAY ON
GOTO inicio
END IF
SCREEN 0
WIDTH 80
PRINT "Obrigado por ter jogado HERCULES..."
PRINT "Um Jogo de Fernando Pinheiro para a Revista SPOOLER."
END

Erro:

CLOSE

IF ERR <> 53 THEN
PLAY OFF
SCREEN 0
WIDTH 80
PRINT "Obrigado por ter jogado HERCULES..."
PRINT "Um Jogo de Fernando Pinheiro para a Revista SPOOLER."
PRINT "ERRO: err = "; ERR; " ; erl = "; ERL
PRINT "Sugest„o :     Provavelmente o programa est  a tentar escrever"
PRINT "           a tabela de pontua‡”es numa disqueta protegida."
PRINT "               Verifique se esse ‚ o caso e desproteja a disqueta"
PRINT "           contra escrita."
END
END IF
ErroResolvido = 1
'OPEN "Hercules.Pnt" FOR OUTPUT AS #1
'WRITE #1, "Fernando Pinheiro   ", 160
'WRITE #1, "Daniel Barbosa      ", 150
'WRITE #1, "Jos‚ Augusto        ", 140
'WRITE #1, "Manuel Soares       ", 130
'WRITE #1, "Pedro Miguel        ", 120
'WRITE #1, "Mario Rui           ", 110
'WRITE #1, "Pedro Manuel        ", 100
'WRITE #1, "Cristina Azevedo    ", 90
'WRITE #1, "Daniela Filomena    ", 80
'WRITE #1, "Vera Alegria        ", 70
'WRITE #1, "Rui Costa           ", 60
'WRITE #1, "Antonio Augusto     ", 50
'WRITE #1, "Antonio Sergio      ", 40
'WRITE #1, "Margarida           ", 30
'WRITE #1, "Paulo Correia       ", 20
'WRITE #1, "Paulo Renato        ", 10
'CLOSE
RESUME RetornoDoErro

UmaVidaMenos:            'Rotina em que se perdeu uma vida
ERASE PilhaX, PilhaY
z = Nfant + 1
Vidas = Vidas - 1
'Play "mbo3t200l3a+p4ap6a+p6a-a"
SELECT CASE Bonus                                        '
CASE 1: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cereja%'=> Impress„o no ecr„
CASE 2: PUT (BonusY * 12 - 12, BonusX * 10 - 10), maca%  '   do tipo de bonus
CASE 3: PUT (BonusY * 12 - 12, BonusX * 10 - 10), cifrao%'
END SELECT                                               '
PUT (HercY * 12 - 12, HercX * 10 - 10), Herc2%
FOR x = 1 TO Nfant
PUT (FantY(x) * 12 - 12, FantX(x) * 10 - 10), Fant%
NEXT
LOCATE 25, 1: PRINT "                                    ";
LOCATE 25, 1: PRINT "Prima Uma Tecla Para Continuar...";

WHILE LEN(INKEY$) <> 0                           'Esvaziar o Buffer do teclado
WEND

Tecla$ = "°"
WHILE LEN(Tecla$) = 0 OR Tecla$ = "°"
Tecla$ = INKEY$
WEND

LOCATE 25, 1: PRINT "                                    ";
ERASE FantX, FantY, FantSX, FantSY
GOTO Novas


MaisMusica: 'Rotina chamada para encher o Buffer de musica sempre
            'que este se esvazia

PLAY "X" + VARPTR$(Musica$(Musica)) 'Encher o Buffer com mais notas
Musica = Musica + 1 'Incrementar o valor da variavel que indica qual
                    'a parte da musica a tocar

IF Musica > 16 THEN PLAY "mbl16t100o3" 'Se a musica tiver chegado ao fim
                                       'inicializar outra vez os atributos
                                       'musicais
IF Musica > 16 THEN PLAY "X" + VARPTR$(Musica$(1))'Se a musica acabou n„o deixar o buffer esvaziar
IF Musica > 16 THEN Musica = 2 'Se o contador da parte da musica a tocar for
                               'maior que o numero de partes a tocar ent„o
                               'voltar ao principio
RETURN


AcabouOJogo: 'Rotina que ‚ chamada quando o Jogador bate o recorde de pontua‡„o
             'estabelecido por mim ( 2.000 )
CLS
'LOCATE 5
'PRINT "              PARABENS"
'PRINT
'PRINT "         VOCE ACABOU HERCULES"
'PRINT
'PRINT "        O SEU NOME NUNCA SERA"
'PRINT
'PRINT "  ULTRAPASSADO NA TABELA DE PONTUA€OES"

BLOAD "GENIO.PIC"

Tecla$ = "°"
WHILE LEN(Tecla$) > 0 'Esvaziar o Buffer do teclado
Tecla$ = INKEY$
WEND
WHILE LEN(Tecla$) = 0 OR Tecla$ = "°" 'Esperar que seja premida uma tecla
Tecla$ = INKEY$
WEND

GOTO Fim

END

