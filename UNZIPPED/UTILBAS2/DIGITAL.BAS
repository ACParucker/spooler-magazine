'⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
'≥                       QUICK BASIC IV - SUMÜRIO                            ≥
'√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
'≥ Software................: DIGITAL                                         ≥
'≥ M¢dulo,Execut†vel.......: DIGITAL.BAS,DIGITAL.EXE                         ≥
'≥ VersÑo (Idioma),rev.....: 1.1(P),09/10/94                                 ≥
'≥ Cliente.................: -                                               ≥
'≥ Autor...................: NÇlio Abreu                                     ≥
'≥ Copyright...............: 1993                                            ≥
'≥ Data de criaáÑo.........: 05/06/1993                                      ≥
'≥ Finalidade do m¢dulo....: Display de um rel¢gio digital                   ≥
'≥ Finalidade software.....: Display de um rel¢gio digital                   ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥ M¢dulos constituintes...: -                                               ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥ Ficheiros constituintes.: -                                               ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥                                                                           ≥
'≥ Ambiente................: -                                               ≥
'≥ Sistema.................: PC/MS/DR-DOS VersÑo 2 ou superior               ≥
'¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ

DECLARE SUB SHOW.DATE ()

COLOR 7, 1, 1: CLS
DIM digitos$(1 TO 8, 0 TO 9)
DIM mes$(1 TO 12): DIM ms$(1 TO 12): DIM cms(1 TO 12)

mes$(1) = "Janeiro"
mes$(2) = "Fevereiro"
mes$(3) = "Maráo"
mes$(4) = "Abril"
mes$(5) = "Maio"
mes$(6) = "Junho"
mes$(7) = "Julho"
mes$(8) = "Agosto"
mes$(9) = "Setembro"
mes$(10) = "Outubro"
mes$(11) = "Novembro"
mes$(12) = "Dezembro"

ds$(1) = "Domingo"
ds$(2) = "Segunda"
ds$(3) = "Teráa"
ds$(4) = "Quarta"
ds$(5) = "Quinta"
ds$(6) = "Sexta"
ds$(0) = "S†bado"

ponto$(1) = "    "
ponto$(2) = " €€ "
ponto$(3) = "    "
ponto$(4) = " €€ "
ponto$(5) = "    "

digitos$(1, 0) = "€ﬂﬂﬂ€"
digitos$(2, 0) = "€   €"
digitos$(3, 0) = "€   €"
digitos$(4, 0) = "€   €"
digitos$(5, 0) = "€‹‹‹€"

digitos$(1, 1) = "    €"
digitos$(2, 1) = "    €"
digitos$(3, 1) = "    €"
digitos$(4, 1) = "    €"
digitos$(5, 1) = "    €"

digitos$(1, 2) = "€ﬂﬂﬂ€"
digitos$(2, 2) = "    €"
digitos$(3, 2) = "‹‹‹‹€"
digitos$(4, 2) = "€    "
digitos$(5, 2) = "€‹‹‹€"

digitos$(1, 3) = "€ﬂﬂﬂ€"
digitos$(2, 3) = "    €"
digitos$(3, 3) = " ‹‹‹€"
digitos$(4, 3) = "    €"
digitos$(5, 3) = "€‹‹‹€"

digitos$(1, 4) = "€   €"
digitos$(2, 4) = "€   €"
digitos$(3, 4) = "€‹‹‹€"
digitos$(4, 4) = "    €"
digitos$(5, 4) = "    €"

digitos$(1, 5) = "€ﬂﬂﬂ€"
digitos$(2, 5) = "€    "
digitos$(3, 5) = "€‹‹‹‹"
digitos$(4, 5) = "    €"
digitos$(5, 5) = "€‹‹‹€"

digitos$(1, 6) = "€ﬂﬂﬂ€"
digitos$(2, 6) = "€    "
digitos$(3, 6) = "€‹‹‹‹"
digitos$(4, 6) = "€   €"
digitos$(5, 6) = "€‹‹‹€"

digitos$(1, 7) = "€ﬂﬂﬂ€"
digitos$(2, 7) = "    €"
digitos$(3, 7) = "    €"
digitos$(4, 7) = "    €"
digitos$(5, 7) = "    €"

digitos$(1, 8) = "€ﬂﬂﬂ€"
digitos$(2, 8) = "€   €"
digitos$(3, 8) = "€‹‹‹€"
digitos$(4, 8) = "€   €"
digitos$(5, 8) = "€‹‹‹€"

digitos$(1, 9) = "€ﬂﬂﬂ€"
digitos$(2, 9) = "€   €"
digitos$(3, 9) = "€‹‹‹€"
digitos$(4, 9) = "    €"
digitos$(5, 9) = "€‹‹‹€"

ds2$(1) = CHR$(17) + "DOM" + CHR$(16)
ds2$(2) = CHR$(17) + "SEG" + CHR$(16)
ds2$(3) = CHR$(17) + "TER" + CHR$(16)
ds2$(4) = CHR$(17) + "QUA" + CHR$(16)
ds2$(5) = CHR$(17) + "QUI" + CHR$(16)
ds2$(6) = CHR$(17) + "SEX" + CHR$(16)
ds2$(0) = CHR$(17) + "SAB" + CHR$(16)

ms$(1) = CHR$(17) + "JN" + CHR$(16)
ms$(2) = CHR$(17) + "FV" + CHR$(16)
ms$(3) = CHR$(17) + "MR" + CHR$(16)
ms$(4) = CHR$(17) + "AB" + CHR$(16)
ms$(5) = CHR$(17) + "MA" + CHR$(16)
ms$(6) = CHR$(17) + "JN" + CHR$(16)
ms$(7) = CHR$(17) + "JL" + CHR$(16)
ms$(8) = CHR$(17) + "AG" + CHR$(16)
ms$(9) = CHR$(17) + "ST" + CHR$(16)
ms$(10) = CHR$(17) + "OC" + CHR$(16)
ms$(11) = CHR$(17) + "NV" + CHR$(16)
ms$(12) = CHR$(17) + "DZ" + CHR$(16)

cdsm(1) = 0
cdsm(2) = 6
cdsm(3) = 12
cdsm(4) = 18
cdsm(5) = 24
cdsm(6) = 30
cdsm(0) = 36

cms(1) = 17
cms(2) = 21
cms(3) = 25
cms(4) = 29
cms(5) = 33
cms(6) = 37
cms(7) = 41
cms(8) = 45
cms(9) = 49
cms(10) = 53
cms(11) = 57
cms(12) = 61

ON TIMER(1) GOSUB digital
TIMER ON
COLOR 9, 1
LOCATE 8, 16: PRINT CHR$(201) + STRING$(48, CHR$(205)) + CHR$(187)
FOR j = 9 TO 15
  LOCATE j, 16: PRINT CHR$(186)
  LOCATE j, 65: PRINT CHR$(186)
NEXT
LOCATE 16, 16: PRINT CHR$(200) + STRING$(48, CHR$(205)) + CHR$(188)
COLOR 9, 1
LOCATE 18, 20: PRINT CHR$(201) + STRING$(38, CHR$(205)) + CHR$(187)
FOR j = 19 TO 21
  LOCATE j, 20: PRINT CHR$(186)
  LOCATE j, 59: PRINT CHR$(186)
NEXT
LOCATE 22, 20: PRINT CHR$(200) + STRING$(38, CHR$(205)) + CHR$(188)

n$ = " (c) NÇlio Abreu - 1993,94 - 05/06/93 - VersÑo 1.1 - Rev 08/11/94 "
COLOR 13, 1: LOCATE 4, 40 - LEN(n$) \ 2: PRINT n$
m$ = " * * * * * S P O O L E R    D I G I T A L    C L O C K * * * * * "
COLOR 11, 1: LOCATE 2, 40 - LEN(m$) \ 2: PRINT m$
m$ = " Uma versÑo Especial Spooler Magazine "
COLOR 15, 1: LOCATE 6, 40 - LEN(m$) \ 2: PRINT m$

m$ = " ESC para Terminar "
COLOR 14, 1: LOCATE 25, 80 - LEN(m$): PRINT m$;
SHOW.DATE
DO
  a$ = INKEY$
  IF TIME$ = "00:00:00" THEN SHOW.DATE
  IF a$ = CHR$(27) THEN EXIT DO
LOOP
COLOR 7, 0, 0: CLS :
PRINT "Terminando DIGITAL!"
END

digital:
  hora1 = VAL(LEFT$(TIME$, 1))
  hora2 = VAL(MID$(TIME$, 2, 1))

  minu1 = VAL(MID$(TIME$, 4, 1))
  minu2 = VAL(MID$(TIME$, 5, 1))

  segu1 = VAL(MID$(TIME$, 7, 1))
  segu2 = VAL(MID$(TIME$, 8, 1))

  segu1$ = digitos$(1, segu1) + " " + digitos$(1, segu2)
  segu2$ = digitos$(2, segu1) + " " + digitos$(2, segu2)
  segu3$ = digitos$(3, segu1) + " " + digitos$(3, segu2)
  segu4$ = digitos$(4, segu1) + " " + digitos$(4, segu2)
  segu5$ = digitos$(5, segu1) + " " + digitos$(5, segu2)

  minu1$ = digitos$(1, minu1) + " " + digitos$(1, minu2)
  minu2$ = digitos$(2, minu1) + " " + digitos$(2, minu2)
  minu3$ = digitos$(3, minu1) + " " + digitos$(3, minu2)
  minu4$ = digitos$(4, minu1) + " " + digitos$(4, minu2)
  minu5$ = digitos$(5, minu1) + " " + digitos$(5, minu2)

  hora1$ = digitos$(1, hora1) + " " + digitos$(1, hora2)
  hora2$ = digitos$(2, hora1) + " " + digitos$(2, hora2)
  hora3$ = digitos$(3, hora1) + " " + digitos$(3, hora2)
  hora4$ = digitos$(4, hora1) + " " + digitos$(4, hora2)
  hora5$ = digitos$(5, hora1) + " " + digitos$(5, hora2)

  disp1$ = hora1$ + " " + ponto$(1) + " " + minu1$ + " " + ponto$(1) + " " + segu1$
  disp2$ = hora2$ + " " + ponto$(2) + " " + minu2$ + " " + ponto$(2) + " " + segu2$
  disp3$ = hora3$ + " " + ponto$(3) + " " + minu3$ + " " + ponto$(3) + " " + segu3$
  disp4$ = hora4$ + " " + ponto$(4) + " " + minu4$ + " " + ponto$(4) + " " + segu4$
  disp5$ = hora5$ + " " + ponto$(5) + " " + minu5$ + " " + ponto$(5) + " " + segu5$

  COLOR 10, 1
  LOCATE 10, 18: PRINT disp1$
  LOCATE 11, 18: PRINT disp2$
  LOCATE 12, 18: PRINT disp3$
  LOCATE 13, 18: PRINT disp4$
  LOCATE 14, 18: PRINT disp5$

  COLOR 7, 1
  IF segu1 = 0 AND segu2 = 0 THEN SOUND 1000, .1

RETURN

SUB SHOW.DATE
  SHARED ds$(), mes$(), ds2$(), cdsm(), ms$(), cms()
  COLOR 7, 1
  LOCATE 9, 20: PRINT " DOM "
  LOCATE 9, 26: PRINT " SEG "
  LOCATE 9, 32: PRINT " TER "
  LOCATE 9, 38: PRINT " QUA "
  LOCATE 9, 44: PRINT " QUI "
  LOCATE 9, 50: PRINT " SEX "
  LOCATE 9, 56: PRINT " SAB "

  LOCATE 15, 17: PRINT " JN "
  LOCATE 15, 21: PRINT " FV "
  LOCATE 15, 25: PRINT " MR "
  LOCATE 15, 29: PRINT " AB "
  LOCATE 15, 33: PRINT " MA "
  LOCATE 15, 37: PRINT " JN "
  LOCATE 15, 41: PRINT " JL "
  LOCATE 15, 45: PRINT " AG "
  LOCATE 15, 49: PRINT " ST "
  LOCATE 15, 53: PRINT " OC "
  LOCATE 15, 57: PRINT " NV "
  LOCATE 15, 61: PRINT " DZ "
  mes.actualb = VAL(LEFT$(DATE$, 2))
  ano.actualb = VAL(RIGHT$(DATE$, 4))
  dia.actualb = VAL(MID$(DATE$, 4, 2))

  IF mes.actualb <= 2 THEN mes.actualb = mes.actualb + 4: ano.actualb = ano.actualb - 1
  dsm = (dia.actualb + 2 * mes.actualb + 3 * (mes.actualb + 1) \ 5 + ano.actualb + ano.actualb \ 4 - ano.actualb \ 100 + ano.actualb \ 400 + 2) MOD 7
  COLOR 7, 1
  LOCATE 20, 21: PRINT SPACE$(37)
  COLOR 12, 1
  dt$ = ds$(dsm) + ", " + MID$(STR$(dia.actualb), 2) + " de " + mes$(mes.actualb) + " de " + MID$(STR$(ano.actualb), 2)
  LOCATE 20, 40 - LEN(dt$) \ 2: PRINT dt$
  COLOR 10, 1
  LOCATE 9, 20 + cdsm(dsm): PRINT ds2$(dsm)
  LOCATE 15, cms(mes.actualb): PRINT ms$(mes.actualb)
  COLOR 7, 1
END SUB

