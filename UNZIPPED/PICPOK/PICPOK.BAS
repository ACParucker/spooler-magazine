'****************** PROGRAMA :  PIC - POK     (QUICKBASIC  4.0) *************
'****************** (C)  PAM  SOFTWARE         DEZ 90 & SET 93  *************
SCREEN 1
DEFSEG = &HB800
BLOAD "PICPOK.PIC"
DIM GRAFICOS%(8100), OPCOES%(5400), RECOR$(10)
LOCATE 13, 31: PRINT "AGUARDE"
GOSUB LEGRAFICOS
GOSUB LERECORDES
GOSUB VELOCIDADE
LOCATE 13, 31: PRINT "       "
GET (0, 0)-(210, 199), OPCOES%
COL = 27: GOSUB QUEDA2

CICLOINICIAL:
t$ = INKEY$
IF t$ = CHR$(0) + CHR$(59) THEN CLS : GOTO INICIO
IF t$ = CHR$(0) + CHR$(60) THEN GOSUB RECORDES: CLS : PUT (0, 0), OPCOES%: COL = 27: CONT = 0: GOSUB QUEDA2
IF t$ = CHR$(27) THEN CLS : PRINT TIME$: PRINT "VOLTE SEMPRE !": FOR a = 1 TO 1500: NEXT a: END
GOTO CICLOINICIAL

INICIO:
DIM NAVE%(50), BOLA%(20), QUADRO%(3000)
RANDOMIZE TIMER
FLAGFIM = 0: FLAG = 1: BONUS = 6000: NAVES = 11: NIVEL = 0: PONTOS = 0
GOSUB ECRAN

'****************** CICLO PRINCIPAL DE CONTROLE DA BOLA E NAVE **************
CICLO1:
t$ = INKEY$
IF t$ = CHR$(0) + CHR$(75) OR t$ = CHR$(0) + CHR$(77) THEN GOSUB MOVENAVE
IF t$ = CHR$(27) THEN GOTO FINAL
GOSUB MOVEBOLA
GOTO CICLO1

'******************* MOVIMENTO DA NAVE **************************************
MOVENAVE:
IF t$ = CHR$(0) + CHR$(75) AND NH > 10 THEN NH = NH - 5
IF t$ = CHR$(0) + CHR$(77) AND NH < 155 THEN NH = NH + 5
PUT (NH, 184), NAVE%, PSET
RETURN

'******************* MOVIMENTO DA BOLA **************************************
MOVEBOLA:
IF INCH + BH > 188 OR INCH + BH < 8 THEN INCH = -INCH: SOUND 400, .5
IF INCV + BV > 174 OR INCV + BV < 8 THEN INCV = -INCV: SOUND 400, .5
BH = BH + INCH
BV = BV + INCV
PUT (BH, BV), BOLA%, PSET
IF BV = 173 THEN IF BH < NH - 3 OR BH > NH + 33 THEN NAVES = NAVES - 1: FLAG = 0: GOSUB ECRAN ELSE GOSUB TESTABOLA1
IF BV < 94 THEN GOSUB TESTABOLA2
IF BV > 60 THEN GOSUB TESTABOLA3
IF BONUS > 0 THEN BONUS = BONUS - 1: LOCATE 22, 31: PRINT BONUS ELSE FLAGFIM = 2: FLAG = 1: FOR a = 1 TO 200: LINE (230, 165)-(273, 178), 1, BF: LOCATE 22, 31: PRINT BONUS: SOUND 5000, .1: LINE (230, 165)-(273, 178), 2, BF: NEXT a: BONUS = 6000: _
     GOSUB ECRAN
FOR a = 1 TO pausa: NEXT
RETURN

'******************* TESTE DE BATIMENTO NA NAVE *****************************
TESTABOLA1:
RANDOMIZE TIMER: RAND = (RND * 10) / 10: SOUND 50, 1.5
IF BH > NH + 20 AND BH < NH + 33 THEN INCH = 1 + RAND: RETURN
IF BH > NH - 3 AND BH < NH + 10 THEN INCH = -1 - RAND: RETURN
RETURN

'******************* TESTE DE BATIMENTO NAS PEDRAS AZUIS ********************
TESTABOLA2:                                                                                         
IF INCV = -2 AND INCH > 0 THEN GOSUB BOLACIMADIR: IF PEDRAS = 0 THEN FLAG = 1: GOSUB ECRAN ELSE RETURN
IF INCV = -2 AND INCH < 0 THEN GOSUB BOLACIMAESQ: IF PEDRAS = 0 THEN FLAG = 1: GOSUB ECRAN ELSE RETURN
IF INCV = 2 AND INCH > 0 THEN GOSUB BOLABAIXODIR: IF PEDRAS = 0 THEN FLAG = 1: GOSUB ECRAN ELSE RETURN
IF INCV = 2 AND INCH < 0 THEN GOSUB BOLABAIXOESQ: IF PEDRAS = 0 THEN FLAG = 1: GOSUB ECRAN ELSE RETURN
RETURN

BOLACIMADIR:
IF POINT(BH + 12, BV + 5) = 1 THEN PAINT (BH + 12, BV + 5), 0: INCH = -INCH: SOUND 3000, .5: PEDRAS = PEDRAS - 1: RETURN
IF POINT(BH + 5, BV - 1) = 1 THEN PAINT (BH + 5, BV - 1), 0: INCV = -INCV: SOUND 3000, .5: PEDRAS = PEDRAS - 1
RETURN

BOLACIMAESQ:
IF POINT(BH - 3, BV + 5) = 1 THEN PAINT (BH - 3, BV + 5), 0: INCH = -INCH: SOUND 3000, .5: PEDRAS = PEDRAS - 1: RETURN
IF POINT(BH + 5, BV - 1) = 1 THEN PAINT (BH + 5, BV - 1), 0: INCV = -INCV: SOUND 3000, .5: PEDRAS = PEDRAS - 1
RETURN

BOLABAIXODIR:
IF POINT(BH + 12, BV + 5) = 1 THEN PAINT (BH + 12, BV + 5), 0: INCH = -INCH: SOUND 3000, .5: PEDRAS = PEDRAS - 1: RETURN
IF POINT(BH + 5, BV + 11) = 1 THEN PAINT (BH + 5, BV + 11), 0: INCV = -INCV: SOUND 3000, .5: PEDRAS = PEDRAS - 1
RETURN

BOLABAIXOESQ:
IF POINT(BH - 2, BV + 5) = 1 THEN PAINT (BH - 2, BV + 5), 0: INCH = -INCH: SOUND 3000, .5: PEDRAS = PEDRAS - 1: RETURN
IF POINT(BH + 5, BV + 11) = 1 THEN PAINT (BH + 5, BV + 11), 0: INCV = -INCV: SOUND 3000, .5: PEDRAS = PEDRAS - 1
RETURN

'******************* TESTE DE BATIMENTO NAS PEDRAS BRANCAS ******************
TESTABOLA3:
IF INCV = -2 AND INCH > 0 THEN GOSUB BOLACIMADIR3: RETURN
IF INCV = -2 AND INCH < 0 THEN GOSUB BOLACIMAESQ3: RETURN
IF INCV = 2 AND INCH > 0 THEN GOSUB BOLABAIXODIR3: RETURN
IF INCV = 2 AND INCH < 0 THEN GOSUB BOLABAIXOESQ3: RETURN
RETURN

BOLACIMADIR3:
IF POINT(BH + 12, BV + 5) = 3 THEN INCH = -INCH: SOUND 5000, .5: RETURN
IF POINT(BH + 5, BV - 1) = 3 THEN INCV = -INCV: SOUND 5000, .5
RETURN

BOLACIMAESQ3:
IF POINT(BH - 3, BV + 5) = 3 THEN INCH = -INCH: SOUND 5000, .5: RETURN
IF POINT(BH + 5, BV - 1) = 3 THEN INCV = -INCV: SOUND 5000, .5
RETURN

BOLABAIXODIR3:
IF POINT(BH + 12, BV + 5) = 3 THEN INCH = -INCH: SOUND 5000, .5: RETURN
IF POINT(BH + 5, BV + 11) = 3 THEN INCV = -INCV: SOUND 5000, .5
RETURN

BOLABAIXOESQ3:
IF POINT(BH - 2, BV + 5) = 3 THEN INCH = -INCH: SOUND 5000, .5: RETURN
IF POINT(BH + 5, BV + 11) = 3 THEN INCV = -INCV: SOUND 5000, .5
RETURN

'******************* CENARIO DO JOGO ****************************************
ECRAN:
IF NAVES = 0 THEN FLAGFIM = 1: GOSUB PONTOS: GOTO FINAL
IF FLAG = 0 THEN GET (10, 10)-(195, 106), QUADRO%
CLS : PUT (0, 0), GRAFICOS%
GET (90, 191)-(131, 184), NAVE%
GET (105, 182)-(116, 172), BOLA%
INCH = -1.5 + (RND * 3): INCV = 2: NH = 90: BH = 105: BV = 173
PUT (240, 60), NAVE%
LOCATE 10, 31: PRINT NAVES - 1
IF FLAG = 1 THEN GOSUB PONTOS: BONUS = 6000: GOSUB ESCOLHENIVEL ELSE PUT (10, 10), QUADRO%: LOCATE 18, 31: PRINT PONTOS
IF NIVEL < 21 THEN LOCATE 14, 31: PRINT NIVEL
IF NIVEL < 21 THEN LOCATE 20, 12: PRINT "NIVEL"; NIVEL ELSE NIVEL = NIVEL - 1: LOCATE 14, 31: PRINT NIVEL: LOCATE 18, 10: PRINT "PARABENS!": LOCATE 19, 3: PRINT "CONCLUIU OS 20 NIVEIS": FLAGFIM = 1: GOSUB PONTOS: GOTO FINAL
LOCATE 22, 31: PRINT BONUS
SOUND 50, 3
TECLA:
Z$ = INKEY$: IF Z$ <> CHR$(13) THEN GOTO TECLA
LOCATE 20, 12: PRINT "         "
RETURN

PONTOS:                                   
IF FLAGFIM = 1 THEN PONTOS = PONTOS + (6000 - BONUS): FLAGFIM = 0
IF FLAGFIM = 0 THEN PONTOS = PONTOS + ((PEDRAS2 - PEDRAS) * NIVEL * 100) + 6000 - BONUS
IF FLAGFIM = 2 THEN LOCATE 18, 31: PRINT PONTOS: FLAGFIM = 0: RETURN
LOCATE 18, 31: PRINT PONTOS
NIVEL = NIVEL + 1
RETURN

FINAL:
FOR Z = 1 TO 3000: NEXT Z
GOTO RECORDES2

'******************* RECORDES ***********************************************
RECORDES:
CLS
LINE (0, 1)-(320, 37), 2, BF
LINE (4, 7)-(315, 31), 0, BF
LOCATE 3, 9: PRINT "RECORDISTAS DO PIC - POK"
LOCATE 9, 9: PRINT "Nome       Pontos       Nivel"
FOR a = 11 TO 20: LOCATE a, 6: PRINT RECOR$(a - 10): NEXT a
FOR a = 11 TO 19: LOCATE a, 3: PRINT a - 10: NEXT a: LOCATE 20, 3: PRINT "10"
CICLOINSTR4:
Z$ = INKEY$: IF Z$ = "" THEN GOTO CICLOINSTR4
RETURN

RECORDES2:
IF NIVEL - 1 < VAL(RIGHT$(RECOR$(10), 2)) THEN CLS : PUT (0, 0), OPCOES%: COL = 27: CONT = 0: GOSUB QUEDA2: GOTO CICLOINICIAL
IF NIVEL - 1 >= 10 THEN RECORD1$ = STR$(PONTOS) + "       " + STR$(NIVEL - 1)
IF NIVEL - 1 < 10 THEN RECORD1$ = STR$(PONTOS) + "        " + STR$(NIVEL - 1)
CLS
LINE (0, 1)-(320, 37), 2, BF
LINE (4, 7)-(315, 31), 0, BF
RECORD$ = RECORD1$
COMP = 30 - LEN(RECORD$)
FOR a = 1 TO COMP: RECORD$ = " " + RECORD$: NEXT a
RECOR$(10) = RECORD$
FOR a = 1 TO 10: FOR B = 1 TO 9
IF RIGHT$(RECOR$(B), 16) < RIGHT$(RECOR$(B + 1), 16) THEN TEMP$ = RECOR$(B + 1): RECOR$(B + 1) = RECOR$(B): RECOR$(B) = TEMP$
NEXT B, a
LOCATE 3, 9: PRINT "RECORDISTAS DO PIC - POK"
LOCATE 9, 9: PRINT "Nome       Pontos       Nivel"
FOR a = 11 TO 20: LOCATE a, 6: PRINT RECOR$(a - 10): NEXT a
FOR a = 11 TO 19: LOCATE a, 3: PRINT a - 10: NEXT a: LOCATE 20, 3: PRINT "10"
FOR X = 1 TO 10
IF RECOR$(X) = RECORD$ THEN LIN = X + 10: NOME$ = "": LOCATE LIN, 5: PRINT "[          ]": GOTO NOME
NEXT X
NOME:
Z$ = INKEY$: IF Z$ = "" THEN GOTO NOME
IF Z$ = CHR$(13) THEN GOTO CONTINUA
IF Z$ = CHR$(8) AND LEN(NOME$) > 0 THEN NOME$ = LEFT$(NOME$, LEN(NOME$) - 1): LOCATE LIN, 5: PRINT "["; NOME$ + "  "
IF Z$ <> CHR$(8) THEN NOME$ = NOME$ + Z$: LOCATE LIN, 5: PRINT "["; NOME$
IF LEN(NOME$) = 10 THEN FOR a = 1 TO 2000: NEXT a: GOTO CONTINUA
GOTO NOME
CONTINUA:
LOCATE LIN, 5: PRINT " ": LOCATE LIN, 16: PRINT " "
RECORD$ = "": ESP$ = ""
COMP = 30 - LEN(NOME$ + RECORD1$)
FOR a = 1 TO COMP: ESP$ = ESP$ + " ": NEXT a
RECORD$ = NOME$ + ESP$ + RECORD1$
RECOR$(X) = RECORD$
GOSUB ESCRITA
CICLOINSTR5:
Z$ = INKEY$: IF Z$ = "" THEN GOTO CICLOINSTR5
CLS : PUT (0, 0), OPCOES%: COL = 27: CONT = 0: GOSUB QUEDA2
GOTO CICLOINICIAL

'***************** ESCRITA DE RECORDES **************************************
ESCRITA:
CLOSE
OPEN "PICPOK.REC" FOR RANDOM AS #2 LEN = 30
FIELD #2, 30 AS DADO$
FOR a = 1 TO 10
LSET DADO$ = RECOR$(a)
PUT #2, a
NEXT a
RETURN

'******************* LEITURA DE RECORDES ************************************
LERECORDES:
OPEN "PICPOK.REC" FOR RANDOM AS #2 LEN = 30
FIELD #2, 30 AS DADO$
FOR a = 1 TO 10
GET #2, a
RECOR$(a) = DADO$
NEXT a
RETURN

'******************* ESCOLHA DE NIVEIS **************************************
ESCOLHENIVEL:
IF NIVEL = 1 THEN GOSUB NIVEL1: RETURN
IF NIVEL = 2 THEN GOSUB NIVEL2: RETURN
IF NIVEL = 3 THEN GOSUB NIVEL3: RETURN
IF NIVEL = 4 THEN GOSUB NIVEL4: RETURN
IF NIVEL = 5 THEN GOSUB NIVEL5: RETURN
IF NIVEL = 6 THEN GOSUB NIVEL6: RETURN
IF NIVEL = 7 THEN GOSUB NIVEL7: RETURN
IF NIVEL = 8 THEN GOSUB NIVEL8: RETURN
IF NIVEL = 9 THEN GOSUB NIVEL9: RETURN
IF NIVEL = 10 THEN GOSUB NIVEL10: RETURN
IF NIVEL = 11 THEN GOSUB NIVEL11: RETURN
IF NIVEL = 12 THEN GOSUB NIVEL12: RETURN
IF NIVEL = 13 THEN GOSUB NIVEL13: RETURN
IF NIVEL = 14 THEN GOSUB NIVEL14: RETURN
IF NIVEL = 15 THEN GOSUB NIVEL15: RETURN
IF NIVEL = 16 THEN GOSUB NIVEL16: RETURN
IF NIVEL = 17 THEN GOSUB NIVEL17: RETURN
IF NIVEL = 18 THEN GOSUB NIVEL18: RETURN
IF NIVEL = 19 THEN GOSUB NIVEL19: RETURN
IF NIVEL = 20 THEN GOSUB NIVEL20: RETURN
RETURN

'******************* DEFINI�AO DOS NIVEIS ***********************************
NIVEL1:
FOR V = 36 TO 84 STEP 24
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
PEDRAS = 30
PEDRAS2 = 30
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL2:
FOR V = 60 TO 84 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL3:
FOR V = 12 TO 84 STEP 24
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
PEDRAS = 40
PEDRAS2 = 40
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL4:
FOR V = 36 TO 84 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
PEDRAS = 50
PEDRAS2 = 50
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL5:
FOR V = 24 TO 84 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
PEDRAS = 60
PEDRAS2 = 60
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL6:
FOR V = 36 TO 84 STEP 24
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 36
LINE (H, 72)-(H + 16, 80), 3, BF
NEXT
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL7:
FOR V = 36 TO 84 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 36
LINE (H, 84)-(H + 16, 92), 3, BF
NEXT
PEDRAS = 45
PEDRAS2 = 45
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL8:
FOR V = 36 TO 72 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 32 TO 190 STEP 36
LINE (H, 72)-(H + 16, 80), 3, BF
NEXT
FOR H = 32 TO 190 STEP 18
LINE (H, 96)-(H + 16, 104), 3, BF
NEXT
PEDRAS = 35
PEDRAS2 = 35
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL9:
LINE (14, 72)-(30, 80), 3, BF
FOR V = 72 TO 84 STEP 12
FOR H = 32 TO 190 STEP 36
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H, V
FOR H = 32 TO 80 STEP 18
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H
FOR H = 140 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H
FOR H = 14 TO 190 STEP 18
LINE (H, 36)-(H + 16, 44), 1, BF
NEXT H
LINE (50, 72)-(66, 80), 1, BF
LINE (158, 72)-(174, 80), 1, BF
LINE (50, 84)-(66, 92), 1, BF
LINE (158, 84)-(174, 92), 1, BF
PEDRAS = 14
PEDRAS2 = 14
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL10:
FOR V = 12 TO 48 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 36
LINE (H, 72)-(H + 16, 80), 3, BF
NEXT
FOR H = 32 TO 164 STEP 36
LINE (H, 96)-(H + 16, 104), 3, BF
NEXT
PEDRAS = 40
PEDRAS2 = 40
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL11:
FOR V = 48 TO 84 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR V = 72 TO 96 STEP 12
FOR H = 32 TO 190 STEP 36
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H, V
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL12:
FOR V = 36 TO 84 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR V = 72 TO 84 STEP 12
FOR H = 14 TO 190 STEP 36
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H, V
PEDRAS = 40
PEDRAS2 = 40
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL13:
FOR V = 24 TO 48 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR V = 72 TO 84 STEP 12
FOR H = 32 TO 190 STEP 36
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H, V
FOR H = 32 TO 80 STEP 18
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H
FOR H = 140 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL14:
FOR V = 24 TO 84 STEP 12
FOR H = 32 TO 190 STEP 36
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 36
LINE (H, 72)-(H + 16, 80), 3, BF
NEXT
FOR H = 32 TO 190 STEP 36
LINE (H, 96)-(H + 16, 104), 3, BF
NEXT
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL15:
FOR V = 24 TO 48 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
LINE (14, 72)-(30, 80), 3, BF
FOR V = 72 TO 84 STEP 12
FOR H = 32 TO 190 STEP 36
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H, V
FOR H = 32 TO 80 STEP 18
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H
FOR H = 140 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H
LINE (50, 72)-(66, 80), 1, BF
LINE (158, 72)-(174, 80), 1, BF
LINE (50, 84)-(66, 92), 1, BF
LINE (158, 84)-(174, 92), 1, BF
PEDRAS = 34
PEDRAS2 = 34
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL16:
FOR V = 24 TO 48 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR V = 72 TO 96 STEP 24
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 3, BF
NEXT H, V
LINE (86, 72)-(120, 80), 0, BF
LINE (86, 96)-(120, 104), 0, BF
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL17:
FOR V = 36 TO 60 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 18
LINE (H, 72)-(H + 16, 80), 3, BF
NEXT
LINE (86, 72)-(120, 80), 0, BF
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL18:
FOR V = 24 TO 60 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 18
LINE (H, 96)-(H + 16, 104), 3, BF
NEXT
LINE (86, 96)-(120, 104), 0, BF
PEDRAS = 40
PEDRAS2 = 40
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL19:
FOR V = 36 TO 60 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 18
LINE (H, 72)-(H + 16, 80), 3, BF
NEXT
LINE (86, 72)-(102, 80), 0, BF
PEDRAS = 30
PEDRAS2 = 30
NAVES = NAVES + 2
LOCATE 10, 31: PRINT NAVES - 1
RETURN

NIVEL20:
FOR V = 12 TO 60 STEP 12
FOR H = 14 TO 190 STEP 18
LINE (H, V)-(H + 16, V + 8), 1, BF
NEXT H, V
FOR H = 14 TO 190 STEP 18
LINE (H, 96)-(H + 16, 104), 3, BF
NEXT
LINE (86, 96)-(102, 104), 0, BF
PEDRAS = 50
PEDRAS2 = 50
LOCATE 10, 31: PRINT NAVES - 1
RETURN

'******************* EFEITO ESPECIAL INICIAL ********************************
QUEDA2:
a$ = "(C) PAMSOFT"
CONT = CONT + 1: IF CONT > 11 THEN GOTO CICLODOIS
IF CONT = 4 THEN COL = COL + 1: GOTO QUEDA2
COL = COL + 1
FOR a = 2 TO 23
EXT$ = MID$(a$, CONT, 1)
LOCATE a, COL: PRINT EXT$: LOCATE a - 1, COL: PRINT " "
NEXT a
FOR A1 = 23 TO 19 STEP -1
SOUND 37, .03
FOR F = 1 TO 10: NEXT F
LOCATE A1, COL: PRINT EXT$: LOCATE A1 + 1, COL: PRINT " ";
NEXT A1
FOR A2 = 19 TO 23
FOR F = 1 TO 10: NEXT F
LOCATE A2, COL: PRINT EXT$: LOCATE A2 - 1, COL: PRINT " "
NEXT A2
FOR A3 = 23 TO 21 STEP -1
FOR F = 1 TO 10: NEXT F
LOCATE A3, COL: PRINT EXT$: LOCATE A3 + 1, COL: PRINT " ";
NEXT A3
FOR A4 = 21 TO 23
FOR F = 1 TO 10: NEXT F
LOCATE A4, COL: PRINT EXT$: LOCATE A4 - 1, COL: PRINT " "
NEXT A4
GOTO QUEDA2
CICLODOIS:
RETURN

'******************* LEITURA DE GRAFICOS ************************************
LEGRAFICOS:
OPEN "GRAFICOS.DAT" FOR RANDOM AS #1 LEN = 6
FIELD #1, 6 AS DADO$
FOR a = 0 TO 8100
GET #1, a + 1
GRAFICOS%(a) = VAL(DADO$)
NEXT a
RETURN

'******************* DETECTA VELOCIDADE DO PROCESSADOR **********************
VELOCIDADE:
t = TIMER
FOR a = 1 TO 1000
NEXT
vel = TIMER - t
IF vel > 1.1 THEN pausa = 0 ELSE IF vel > .07 AND vel < 1.1 THEN pausa = 100 ELSE pausa = 3000
RETURN

