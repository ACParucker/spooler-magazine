DECLARE SUB SetDefaults ()
DECLARE SUB CheckPassword (Ficheiro$, Passw$)
DECLARE SUB Janela3 ()
DECLARE SUB DecifrarFicheiro (Ficheiro$, TamanhoDoFicheiro&, Array%())
DECLARE SUB JanelaDecifrar (L&)
DECLARE SUB JanelaCifrar (L&)
DECLARE SUB CifrarFicheiro (Ficheiro$, TamanhoDoFicheiro&, Passw$, Array%())
DECLARE SUB InputFicheiro ()
DECLARE SUB InputPassword ()
DECLARE SUB Processa (Cifra$, TamanhoDoFicheio&, P&, Array%())
DECLARE SUB SetScreens ()
DECLARE SUB CheckFile (Ficheiro$)
DECLARE SUB Janela1 ()
DECLARE SUB Janela2 ()
DECLARE SUB Janela ()
DECLARE SUB SpoolerScr ()
DECLARE SUB Screens ()
DECLARE SUB Gerandom (Passw$)

COMMON SHARED Passw$
COMMON SHARED Ficheiro$
COMMON SHARED TamanhoDoFicheiro&
COMMON SHARED Array%()
COMMON SHARED Spy$

Inicio:
 CLEAR
 LOCATE , , 0, 0, 7

 SetScreens

SCREEN 0, 1, 0, 0
 CLS

StartProgram:
 SetDefaults
 SpoolerScr
   PCOPY 3, 0

SCREEN 0, 1, 0, 0
ON ERROR GOTO Erro
   Screens

Menu:
SELECT CASE UCASE$(INPUT$(1))
      
       CASE "C"
            InputFicheiro
            CheckFile Ficheiro$
       CASE "S"
            GOTO Sair
      
       CASE ELSE
            GOTO Menu
END SELECT
BEEP
COLOR 16, 15
LOCATE 20, 30: PRINT " Opera‡„o terminada "

FOR a = 1 TO 5000
NEXT a

COLOR 15, 0
FOR a = 1 TO 7
SCREEN 0, 1, a, 7
CLS
NEXT a

SCREEN 0, 1, 0, 0
CLS
SYSTEM

Sair:
PCOPY 1, 0
COLOR 31, 4
LOCATE 20, 24: PRINT "  Confirma sair do programa  (S/N)  "

SimNao:
SELECT CASE UCASE$(INPUT$(1))
      
       CASE "S"
             COLOR 0, 0
             FOR a = 1 TO 7
             SCREEN 0, 1, a, 7
             CLS
             NEXT a
             SCREEN 0, 1, 0, 0
             CLS
             SYSTEM

       CASE "N"
             PCOPY 1, 0
             SetDefaults
             Screens
             GOTO Menu
      
       CASE ELSE

END SELECT
GOTO SimNao

Erro:
IF ERR = 53 THEN
    BEEP
    BEEP
     COLOR 0, 15
      ERROR1$ = " Ficheiro " + Ficheiro$ + " n„o encontrado. Carregue numa tecla...    "
       LOCATE 20, (80 - LEN(ERROR1$)) \ 2, 0, 1, 7: PRINT ERROR1$;
   
    DO WHILE INKEY$ = ""
    LOOP

END IF
CLOSE

COLOR 15, 0
FOR a = 1 TO 7
SCREEN 0, 1, a, 7
CLS
NEXT a

SCREEN 0, 1, 0, 0
CLS
SYSTEM

SUB CheckFile (Ficheiro$) STATIC
Spy$ = ""
OPEN Ficheiro$ FOR BINARY AS #1
L& = LOF(1)
Spy$ = SPACE$(15)
GET #1, L& - 14, Spy$
CLOSE #1

RightSpy$ = RIGHT$(Spy$, 5)
IF RightSpy$ = "[CDF]" THEN
    
    JanelaDecifrar L&
    InputPassword
    Gerandom Passw$
    CheckPassword Ficheiro$, Passw$
    DecifrarFicheiro Ficheiro$, TamanhoDoFicheiro&, Array%()

EXIT SUB
END IF

IF RightSpy$ <> "[CDF]" THEN

   JanelaCifrar L&
   InputPassword
   Gerandom Passw$
   CifrarFicheiro Ficheiro$, TamanhoDoFicheiro&, Passw$, Array%()

END IF

END SUB

SUB CheckPassword (Ficheiro$, Passw$)
Spy$ = ""

OPEN Ficheiro$ FOR BINARY AS #1
L& = LOF(1)
Spy$ = SPACE$(15)
GET #1, L& - 14, Spy$
CLOSE #1

IF Passw$ = Spy$ THEN EXIT SUB
    Janela3
COLOR 0, 0
   
FOR a = 1 TO 7
SCREEN 0, 1, a, 0
CLS
NEXT a

SCREEN 0, 1, 0, 0
CLS

SYSTEM
END SUB

SUB CifrarFicheiro (Ficheiro$, TamanhoDoFicheiro&, Passw$, Array%()) STATIC

OPEN Ficheiro$ FOR BINARY AS #1
P& = 0
Cifra$ = SPACE$(100)
Contador& = TamanhoDoFicheiro& \ 100

FOR Inicio& = 0 TO Contador&
Control& = Inicio& * 100 + 1
IF Inicio& = Contador& THEN
Cifra$ = SPACE$(TamanhoDoFicheiro& - 100 * Contador&)
END IF

GET #1, Control&, Cifra$
Processa Cifra$, TamanhoDoFicheiro&, P&, Array%()
PUT #1, Control&, Cifra$
NEXT Inicio&

PUT #1, TamanhoDoFicheiro& + 1, Passw$
CLOSE #1

END SUB

SUB ClearScreens

END SUB

SUB DecifrarFicheiro (Ficheiro$, TamanhoDoFicheiro&, Array%()) STATIC

COLOR 1, 15
OPEN Ficheiro$ FOR BINARY AS #1
OPEN "TEMPFILE.CDF" FOR BINARY AS #2

P& = 0
Cifra$ = SPACE$(100)

TamanhoDoFicheiro& = LOF(1) - 15
Contador& = TamanhoDoFicheiro& \ 100

FOR Inicio& = 0 TO Contador&
Control& = Inicio& * 100 + 1
IF Inicio& = Contador& THEN
Cifra$ = SPACE$(TamanhoDoFicheiro& - 100 * Contador&)
END IF

GET #1, Control&, Cifra$
Processa Cifra$, TamanhoDoFicheiro&, P&, Array%()
PUT #2, Control&, Cifra$
NEXT Inicio&
CLOSE #2
CLOSE #1


KILL Ficheiro$
NAME "TEMPFILE.CDF" AS Ficheiro$

END SUB

SUB Gerandom (Passw$) STATIC

REDIM Array%(100)
REDIM k&(10)
x = 0: Y = 0

FOR a = 1 TO 9
x = ASC(MID$(Passw$, a, 1))
Y = ASC(MID$(Passw$, a + 1, 1))
k&(a) = x * Y
NEXT a

J& = 0

FOR a = 1 TO 9
J& = INT(J& + (k&(a) * k&(a + 1)))
NEXT a

RANDOMIZE J&

FOR Index% = 1 TO 100
Array%(Index%) = INT(RND * 255)
NEXT Index%

FOR a = 1 TO 10
x% = ASC(MID$(Passw$, a, 1)) XOR Array%(a)
MID$(Passw$, a, 1) = CHR$(x%)
NEXT a
END SUB

SUB InputFicheiro STATIC
PCOPY 2, 0

COLOR 15, 4
LOCATE 16, 35: PRINT " ESC=MENU "
LOCATE 18, 13: PRINT "                   Nome do ficheiro -                 "
LOCATE 20, 35: PRINT " ENTER=OK "

LOCATE , , 1, 1, 7

Linha = 18: Coluna = 50: Start = 50: Fim = 61
InFicheiro:
      IF Start < Coluna THEN Start = Coluna
      IF Start > Fim THEN Start = Fim

LOCATE Linha, Start, 1, 1, 7

IN$ = INKEY$
    IF IN$ = "" THEN GOTO InFicheiro
    IF LEN(IN$) > 1 THEN GOTO InFicheiro
    IF IN$ = CHR$(8) THEN PRINT CHR$(32); : Start = Start - 1
    IF IN$ = CHR$(13) THEN GOTO SetCodeFile
    IF IN$ = CHR$(27) THEN LOCATE , , 0, 1, 7: PCOPY 2, 0: EXIT SUB
    IF IN$ < CHR$(32) OR IN$ > CHR$(122) THEN GOTO InFicheiro
PRINT UCASE$(IN$);
Start = Start + 1
GOTO InFicheiro

SetCodeFile:
Ficheiro$ = ""
FOR a = Coluna TO Fim
   R$ = CHR$(SCREEN(Linha, a))
   Ficheiro$ = Ficheiro$ + R$
NEXT a

OPEN Ficheiro$ FOR INPUT AS #1
CLOSE #1

OPEN Ficheiro$ FOR BINARY AS #1
TamanhoDoFicheiro& = LOF(1)
CLOSE #1

LOCATE , , 0, 0, 7
END SUB

SUB InputPassword STATIC
Passw$ = ""
COLOR 15, 4
LOCATE 20, 25: PRINT " Input Password -             ";
LOCATE , , 1, 1, 7

Linha = 20: Coluna = 42: Start = 42: Fim = 51

EnterPassword:
    IF Start < Coluna THEN Start = Coluna
    IF Start > Fim THEN Start = Fim

LOCATE Linha, Start, 1, 1, 7

IN$ = INKEY$
    IF IN$ = "" THEN GOTO EnterPassword
    IF LEN(IN$) > 1 THEN GOTO EnterPassword
    IF IN$ = CHR$(8) THEN PRINT CHR$(32); : Start = Start - 1
    IF IN$ = CHR$(13) THEN GOTO ReadPassword
    IF IN$ < CHR$(48) OR IN$ > CHR$(122) THEN GOTO EnterPassword
PRINT UCASE$(IN$);
Start = Start + 1
    IF Start > Fim THEN Start = Fim
GOTO EnterPassword

ReadPassword:
FOR a = Coluna TO Fim
   R$ = CHR$(SCREEN(Linha, a))
   Passw$ = Passw$ + R$
NEXT a

Passw$ = Passw$ + "[CDF]"

COLOR 7, 7
LOCATE 20, 22: PRINT STRING$(40, 32);
LOCATE , , 0, 0, 7

END SUB

SUB Janela
PCOPY 1, 0

COLOR 0, 15
LOCATE 15, 12: PRINT CHR$(201) + STRING$(57, 205) + CHR$(187)
FOR a = 16 TO 20
LOCATE a, 12: PRINT CHR$(186) + STRING$(57, 32) + CHR$(186)
NEXT a
LOCATE 21, 12: PRINT CHR$(200) + STRING$(57, 205) + CHR$(188)

END SUB

SUB Janela3
BEEP
BEEP
COLOR 20, 7
LOCATE 20, 17: PRINT "Password Incorreto...Carregue em qualquer tecla."
DO WHILE INKEY$ = ""
LOOP
END SUB

SUB JanelaCifrar (L&) STATIC
PCOPY 1, 0
COLOR 0, 15
LOCATE 15, 12: PRINT CHR$(201) + STRING$(57, 205) + CHR$(187)
FOR a = 16 TO 20
LOCATE a, 12: PRINT CHR$(186) + STRING$(57, 32) + CHR$(186)
NEXT a
LOCATE 21, 12: PRINT CHR$(200) + STRING$(57, 205) + CHR$(188)

COLOR 4, 7
LOCATE 16, 22: PRINT "Ficheiro-"
LOCATE 18, 22: PRINT "  Status-            Opera‡„o-      "

COLOR 0, 7
LOCATE 16, 31: PRINT Ficheiro$; L&; " Bytes"
LOCATE 18, 31: PRINT "NORMAL";
LOCATE 18, 52: PRINT "CIFRAR";
COLOR 20, 7
LOCATE 20, 38: PRINT "(S/N)"

DO
SELECT CASE INPUT$(1)
CASE "s", "S"
EXIT SUB
CASE "n", "N"
COLOR 0, 0
FOR a = 1 TO 7
SCREEN 0, 1, a, 0
CLS
NEXT a
SCREEN 0, 1, 0, 0
CLS
SYSTEM
CASE ELSE
END SELECT
LOOP
END SUB

SUB JanelaDecifrar (L&) STATIC
PCOPY 1, 0

COLOR 0, 15
LOCATE 15, 12: PRINT CHR$(201) + STRING$(57, 205) + CHR$(187)
FOR a = 16 TO 20
LOCATE a, 12: PRINT CHR$(186) + STRING$(57, 32) + CHR$(186)
NEXT a
LOCATE 21, 12: PRINT CHR$(200) + STRING$(57, 205) + CHR$(188)

COLOR 4, 7
LOCATE 16, 22: PRINT "Ficheiro-"
LOCATE 18, 22: PRINT "  Status-            Opera‡„o-      "

COLOR 0, 7
LOCATE 16, 31: PRINT Ficheiro$; L&; " Bytes"
LOCATE 18, 31: PRINT "CIFRADO";
LOCATE 18, 52: PRINT "DECIFRAR";
COLOR 20, 7
LOCATE 20, 38: PRINT "(S/N)"

DO
SELECT CASE INPUT$(1)
CASE "s", "S"
EXIT SUB
CASE "n", "N"
COLOR 0, 0
FOR a = 1 TO 7
SCREEN 0, 1, a, 0
CLS
NEXT a
SCREEN 0, 1, 0, 0
CLS
SYSTEM
CASE ELSE
END SELECT
LOOP
END SUB

SUB Processa (Cifra$, TamanhoDoFicheiro&, P&, Array%()) STATIC

COLOR 1, 7

FOR Inicio& = 1 TO LEN(Cifra$)
    Cifra% = ASC(MID$(Cifra$, Inicio&, 1)) XOR Array%(Inicio&)
    P& = (TamanhoDoFicheiro& + P& - TamanhoDoFicheiro&) + 1
    Perc& = P& * 100 \ TamanhoDoFicheiro&
    MID$(Cifra$, Inicio&, 1) = CHR$(Cifra%)
NEXT Inicio&

LOCATE 20, 39: PRINT USING "###%"; Perc&;

END SUB

SUB Screens
SCREEN 0, 1, 1, 0
CLS
DIM TITULO$(11)

TITULO$(1) = "    Cifrador/Decifrador de ficheiros  Vers„o(Demo)."
TITULO$(2) = " Autor "
TITULO$(3) = " Miguel Angelo Aveiro de Gouveia  "
TITULO$(4) = " T¦ do Pilar Lote 8 1§ Dt§        "
TITULO$(5) = " S§ Antonio  9000 Funchal-Madeira "
TITULO$(6) = "   Elaborado para SPOOLER                       "
TITULO$(7) = "   Linguagem: Microsoft QuickBasic Vers„o 4.00  "
TITULO$(8) = " Carregue em qualquer tecla...  "
TITULO$(9) = " MENU "
TITULO$(10) = " C - Cifrar/Decifrar  ficheiro  "
TITULO$(11) = "    S - Sair do Programa    "

COLOR 0, 15
PCOPY 3, 1

LOCATE 13, 16: PRINT TITULO$(1)
LOCATE 5, 37: PRINT TITULO$(2)
LOCATE 7, 24: PRINT TITULO$(3)
LOCATE 8, 24: PRINT TITULO$(4)
LOCATE 9, 24: PRINT TITULO$(5)
LOCATE 15, 18: PRINT TITULO$(6)
LOCATE 16, 18: PRINT TITULO$(7)

COLOR 16, 7
LOCATE 20, 26: PRINT TITULO$(8)



SCREEN 0, 1, 2, 0

PCOPY 3, 2
COLOR 0, 15
LOCATE 8, 38: PRINT TITULO$(9)
LOCATE 10, 26: PRINT TITULO$(10)
LOCATE 12, 28: PRINT TITULO$(11)

PCOPY 1, 0
SCREEN 0, 1, 0, 0
DO WHILE INKEY$ = ""
LOOP
PCOPY 2, 0
END SUB

SUB SetDefaults

REDIM Array%(100)

Passw$ = ""
Spy$ = ""
Ficheiro$ = ""

TamanhoDoFicheiro& = 0
P& = 0
L& = 0

FOR a = 1 TO 100
Array%(a) = 0
NEXT a
END SUB

SUB SetScreens
FOR Scr = 0 TO 7
SCREEN 0, 1, Scr, 0
CLS
NEXT Scr
END SUB

SUB SpoolerScr
SCREEN 0, 1, 3, 0
CLS

COLOR 15, 0
LOCATE 2, 2: PRINT CHR$(218) + STRING$(77, 196) + CHR$(191);
FOR a = 3 TO 23
LOCATE a, 2: PRINT CHR$(179) + STRING$(77, 32) + CHR$(179)
NEXT a
LOCATE 24, 2: PRINT CHR$(192) + STRING$(77, 196) + CHR$(217);

FUNDO$ = "SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER SPOOLER"

FOR a = 3 TO 23
IF a > 15 THEN COLOR a - 14, 0 ELSE COLOR a, 0
LOCATE a, 3: PRINT MID$(FUNDO$, a - 2, 77)
NEXT a

END SUB

