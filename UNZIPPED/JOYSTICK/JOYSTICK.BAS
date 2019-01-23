1  '
2  '  JOYSTICK.BAS
3  '
4  '  Exemplo de como utilizar o Joystick em BASIC
5  '
6  '  Este c¢digo ou partes do mesmo pode ser distribuido ou
7  '  integrado livremente em programas para qualquer tipo de uso,
8  '  desde que na sua distribui‡„o os coment rios sejam divulgados
9  '  intactos.
10 '
11 '  Para quaisquer coment rios ou d£vidas contactar o autor:
12 '
13 '	Pedro Sinogas
14 '	Rua A - Lote 6A
15 '	Madorna
16 '	2775 Parede
17 '
18 '  Novembro 93
19 '
20 CLS
30 LOCATE 1,1: PRINT "Joystick 1"
40 LOCATE 4,1: PRINT "Joystick 2"
50 WHILE INKEY$ = "": LOCATE 2, 1: PRINT STICK(0), STICK(1), STRIG(1), STRIG(5): LOCATE 5, 1: PRINT STICK(2), STICK(3), STRIG(3), STRIG(7): WEND

