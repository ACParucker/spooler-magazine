'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                     QUICK BASIC IV - FICHA T륝NICA                        �
'쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'� Software................: Todos                                           �
'� M줰ulo,Execut쟶el.......: STANDARD.INC                                    �
'� Vers꼘 (Idioma),rev.....: 2.0 (P), 01/06/94                               �
'� Cliente.................: -                                               �
'� Autor...................: N굃io Abreu                                     �
'� Copyright...............: 1993                                            �
'� Data de cria뇙o.........: 18/09/93                                        �
'� Interface de v죆eo......: Todos                                           �
'� Ambiente................: DOS                                             �
'� Interface de sistema....: Monoposto                                       �
'� Sistema operativo.......: MS/PC/DR-DOS vers꼘 2 ou superior               �
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                         FINALIDADE DO SOFTWARE                            �
'쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�     Inicializa뇙o das constantes e vari쟶eis de utiliza뇙o diversa.       �
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
'쿙OTA: Sempre que quiser utilizar este ficheiro, coloque-o dentro do seus  �
'넌袴袴 programas sob a forma de um 췙EMark�:                               �
'�                                                                          �
'�                  REM $INCLUDE : 'STANDARD.INC'                           �
'�                                                                          �
'�      ou                                                                  �
'�                                                                          �
'�                  ' $INCLUDE : 'STANDARD.INC'                             �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�             \/ ZONA RESERVADA 멣 CONSTANTES DA PROGRAMA�랳 \/            �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
'쿔MPORTANTE! O bloco de source-code que se segue, � protegido por Copyright�
'넌袴袴袴袴袴 pela MicroSoft. A sua inclus꼘 deve-se ao facto de existirem  �
'�            rutinas internas na biblioteca que recorrem � sua utiliza뇙o  �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

' Define o tipo necess쟲io para o INTERRUPT
TYPE RegType
		 ax    AS INTEGER
		 bx    AS INTEGER
		 cx    AS INTEGER
		 dx    AS INTEGER
		 bp    AS INTEGER
		 si    AS INTEGER
		 di    AS INTEGER
		 flags AS INTEGER
END TYPE
' Define o tipo necess쟲io para o INTERUPTX
TYPE RegTypeX
		 ax    AS INTEGER
		 bx    AS INTEGER
		 cx    AS INTEGER
		 dx    AS INTEGER
		 bp    AS INTEGER
		 si    AS INTEGER
		 di    AS INTEGER
		 flags AS INTEGER
		 ds    AS INTEGER
		 es    AS INTEGER
END TYPE

'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
'쿔MPORTANTE! O bloco de source-code que precede , � protegido por Copyright�
'넌袴袴袴袴袴 pela MicroSoft. A sua inclus꼘 deve-se ao facto de existirem  �
'�            rutinas internas na biblioteca que recorrem � sua utiliza뇙o  �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�                \/ ZONA RESERVADA 멣 CONSTANTES BOLEANAS \/               �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST FALSE = 0, TRUE = NOT FALSE
CONST FALSO = 0, VERDADE = NOT FALSO
CONST NAO = 0, SIM = NOT NAO
CONST NO = 0, YES = NOT NO
CONST AUSENTE = 0, PRESENTE = NOT AUSENTE
CONST ABSENT = 0, PRESENT = NOT ABSENT
CONST DISABLE = 0, ENABLE = NOT DISABLE

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�                \/ ZONA RESERVADA AOS C욬IGOS DAS TECLAS \/               �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

ESC.key$ = CHR$(27)
ENTER.key$ = CHR$(13)
TAB.key$ = CHR$(9)
BACKSPACE.key$ = CHR$(8)

F1.key$ = CHR$(0) + CHR$(59):F2.key$ = CHR$(0) + CHR$(60)
F3.key$ = CHR$(0) + CHR$(61):F4.key$ = CHR$(0) + CHR$(62)
F5.key$ = CHR$(0) + CHR$(63):F6.key$ = CHR$(0) + CHR$(64)
F7.key$ = CHR$(0) + CHR$(65):F8.key$ = CHR$(0) + CHR$(66)
F9.key$ = CHR$(0) + CHR$(67):F10.key$ = CHR$(0) + CHR$(68)

LEFT.key$ = CHR$(0) + CHR$(75)
RIGHT.key$ = CHR$(0) + CHR$(77)
DOWN.key$ = CHR$(0) + CHR$(80)
UP.key$ = CHR$(0) + CHR$(72)

HOME.key$ = CHR$(0) + CHR$(71)
END.key$ = CHR$(0) + CHR$(79)

PAGE.UP.key$ = CHR$(0) + CHR$(73)
PAGE.DOWN.key$ = CHR$(0) + CHR$(81)

INS.key$ = CHR$(0) + CHR$(82)
DEL.key$ = CHR$(0) + CHR$(83)
nul.key$ = ""

ALT.A.key$ = CHR$(0) + CHR$(30):ALT.B.key$ = CHR$(0) + CHR$(48)
ALT.C.key$ = CHR$(0) + CHR$(46):ALT.D.key$ = CHR$(0) + CHR$(32)
ALT.E.key$ = CHR$(0) + CHR$(18):ALT.F.key$ = CHR$(0) + CHR$(33)
ALT.G.key$ = CHR$(0) + CHR$(34):ALT.H.key$ = CHR$(0) + CHR$(35)
ALT.I.key$ = CHR$(0) + CHR$(23):ALT.J.key$ = CHR$(0) + CHR$(36)
ALT.K.key$ = CHR$(0) + CHR$(37):ALT.L.key$ = CHR$(0) + CHR$(38)
ALT.M.key$ = CHR$(0) + CHR$(50):ALT.N.key$ = CHR$(0) + CHR$(49)
ALT.O.key$ = CHR$(0) + CHR$(24):ALT.P.key$ = CHR$(0) + CHR$(25)
ALT.Q.key$ = CHR$(0) + CHR$(16):ALT.R.key$ = CHR$(0) + CHR$(19)
ALT.S.key$ = CHR$(0) + CHR$(31):ALT.T.key$ = CHR$(0) + CHR$(20)
ALT.U.key$ = CHR$(0) + CHR$(22):ALT.V.key$ = CHR$(0) + CHR$(47)
ALT.W.key$ = CHR$(0) + CHR$(17):ALT.X.key$ = CHR$(0) + CHR$(45)
ALT.Y.key$ = CHR$(0) + CHR$(21):ALT.Z.key$ = CHR$(0) + CHR$(44)

ALT.F1.key$ = CHR$(0) + CHR$(104):ALT.F2.key$ = CHR$(0) + CHR$(105)
ALT.F3.key$ = CHR$(0) + CHR$(106):ALT.F4.key$ = CHR$(0) + CHR$(107)
ALT.F5.key$ = CHR$(0) + CHR$(108):ALT.F6.key$ = CHR$(0) + CHR$(109)
ALT.F7.key$ = CHR$(0) + CHR$(110):ALT.F8.key$ = CHR$(0) + CHR$(111)
ALT.F9.key$ = CHR$(0) + CHR$(112):ALT.F10.key$ = CHR$(0) + CHR$(113)

ALT.1.key$ = CHR$(0) + CHR$(120):ALT.2.key$ = CHR$(0) + CHR$(121)
ALT.3.key$ = CHR$(0) + CHR$(122):ALT.4.key$ = CHR$(0) + CHR$(123)
ALT.5.key$ = CHR$(0) + CHR$(124):ALT.6.key$ = CHR$(0) + CHR$(125)
ALT.7.key$ = CHR$(0) + CHR$(126):ALT.8.key$ = CHR$(0) + CHR$(127)
ALT.9.key$ = CHR$(0) + CHR$(128):ALT.0.key$ = CHR$(0) + CHR$(129)

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�              \/ ZONA RESERVADA 멣 CONSTANTES INFORM냊ICAS \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST Kbyte% = 1024, Mbyte& = 1048576, Gbyte& = 1073741824

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�              \/ ZONA RESERVADA 멣 CONSTANTES DOS PORTS IO \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST lpt1$ = "LPT1:", com1$ = "COM1:", lpt2$ = "LPT2:"
CONST lpt3$ = "LPT3:", com2$ = "COM2:", com3$ = "COM3:"
CONST com4$ = "COM4:"

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�              \/ ZONA RESERVADA AOS FICHEIROS TEMPOR냃IOS  \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST nul.file$ = " >NUL:"

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�                 \/ ZONA RESERVADA 멣 VARI냌EIS NULAS  \/                 �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST nul.string$ = "", nul.integer% = 0, nul.long& = 0, nul.single! = 0, nul.double# = 0

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�             \/ ZONA RESERVADA AOS SEGMENTOS DE MEM웂IA  \/               �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST MDA.SEG = &HB000, CGA.SEG = &HB800, VGA.SEG = &HA400, EGA.SEG = &HA400

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�                \/ ZONA RESERVADA 멣 CONSTANTES DO DOS  \/                �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST disk160K& = 160256, disk180K& = 179712, disk320K& = 322560
CONST disk360K& = 362496, disk720K& = 730112, disk1200K& = 1213952
CONST disk1440K& = 1457664

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�            \/ ZONA RESERVADA 멣 CONSTANTES DE IMPRESSORA  \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

printer.status = FALSE
printer.line = 1

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�               \/ ZONA RESERVADA 멣 CONSTANTES DE REDE  \/                �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

NetWork.status = DISABLE
NetWork.error = NO

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�           \/ ZONA RESERVADA 멣 CONSTANTES DE AMBIENTE  \/                �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST BLACK = 0, BLUE = 1, GREEN = 2, CYAN = 3, RED = 4, MANGENTA = 5
CONST BROWN = 6, WHITE = 7, GREY = 8, LIGHT.BLUE = 9, LIGHT.GREEN = 10
CONST LIGHT.CYAN = 11, LIGHT.RED = 12, LIGHT.MANGENTA = 13, YELOW = 14
CONST LIGHT.WHITE = 15
CONST FLASH = 16

'Variaveis de controlo do procedimento GETCOLOR()
foreground = 0
background = 0

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�           \/ ZONA RESERVADA 멣 CONSTANTES DE FICHEIROS \/                �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST dat$ = ".DAT", scr$ = ".SCR", grf$ = ".GRF", var$ = ".VAR"
CONST mem$ = ".MEM", sys$ = ".SYS", cfg$ = ".CFG", txt$ = ".TXT"
CONST cor$ = ".COR", hlp$ = ".HLP", tmp$ = ".~~~", bak$ = ".BAK"
CONST ini$ = ".INI", bin$ = ".BIN", reg$ = ".REG", dbf$ = ".DBF"
CONST idx$ = ".IDX", tbl$ = ".TBL", drv$ = ".DRV", cpi$ = ".CPI"
CONST bkp$ = ".B~K", bol$ = ".BOL", prn$ = ".PRN", psw$ = ".PSW"
CONST old$ = ".OLD", dev$ = ".DEV", doc$ = ".DOC", his$ = ".HIS"

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�         \/ ZONA RESERVADA � LEITURA DA LINHA DE COMANDO \/               �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

comand.line$ = UCASE$(COMMAND$)

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�         \/ ZONA RESERVADA � LEITURA DA 멢EA DE VARIAVEIS \/              �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

temp.dir.1$ = ENVIRON$("TEMP")
temp.dir.2$ = ENVIRON$("TMP")
dos.path$ = ENVIRON$("PATH")
dos.comspec$ = ENVIRON$("COMSPEC")
dos.prompt$ = ENVIRON$("PROMPT")

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�         \/ ZONA RESERVADA � RESERVA DE BUFFER DE IMAGEM \/               �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST first.row% = 1,last.row% = 25,first.column% = 1,last.column% = 80

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�           \/ ZONA RESERVADA AO CONTROLO DE ERRO INTERNO   \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

ON ERROR GOTO error.handler

'***** END OF STANDARD.INC FILE *****

