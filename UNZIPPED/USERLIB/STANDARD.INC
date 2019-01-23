'ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
'ณ                     QUICK BASIC IV - FICHA TCNICA                        ณ
'รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
'ณ Software................: Todos                                           ณ
'ณ Mขdulo,Execut vel.......: STANDARD.INC                                    ณ
'ณ Verso (Idioma),rev.....: 2.0 (P), 01/06/94                               ณ
'ณ Cliente.................: -                                               ณ
'ณ Autor...................: Nlio Abreu                                     ณ
'ณ Copyright...............: 1993                                            ณ
'ณ Data de criao.........: 18/09/93                                        ณ
'ณ Interface de vกdeo......: Todos                                           ณ
'ณ Ambiente................: DOS                                             ณ
'ณ Interface de sistema....: Monoposto                                       ณ
'ณ Sistema operativo.......: MS/PC/DR-DOS verso 2 ou superior               ณ
'ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
'ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
'ณ                         FINALIDADE DO SOFTWARE                            ณ
'รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
'ณ     Inicializao das constantes e vari veis de utilizao diversa.       ณ
'ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ
'ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
'ณNOTA: Sempre que quiser utilizar este ficheiro, coloque-o dentro do seus  ณ
'ณอออออ programas sob a forma de um ฎREMarkฏ:                               ณ
'ณ                                                                          ณ
'ณ                  REM $INCLUDE : 'STANDARD.INC'                           ณ
'ณ                                                                          ณ
'ณ      ou                                                                  ณ
'ณ                                                                          ณ
'ณ                  ' $INCLUDE : 'STANDARD.INC'                             ณ
'ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ             \/ ZONA RESERVADA ‘S CONSTANTES DA PROGRAMA€O \/            ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

'ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
'ณIMPORTANTE! O bloco de source-code que se segue,  protegido por Copyrightณ
'ณอออออออออออ pela MicroSoft. A sua incluso deve-se ao facto de existirem  ณ
'ณ            rutinas internas na biblioteca que recorrem … sua utilizao  ณ
'ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

' Define o tipo necess rio para o INTERRUPT
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
' Define o tipo necess rio para o INTERUPTX
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

'ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
'ณIMPORTANTE! O bloco de source-code que precede ,  protegido por Copyrightณ
'ณอออออออออออ pela MicroSoft. A sua incluso deve-se ao facto de existirem  ณ
'ณ            rutinas internas na biblioteca que recorrem … sua utilizao  ณ
'ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ                \/ ZONA RESERVADA ‘S CONSTANTES BOLEANAS \/               ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST FALSE = 0, TRUE = NOT FALSE
CONST FALSO = 0, VERDADE = NOT FALSO
CONST NAO = 0, SIM = NOT NAO
CONST NO = 0, YES = NOT NO
CONST AUSENTE = 0, PRESENTE = NOT AUSENTE
CONST ABSENT = 0, PRESENT = NOT ABSENT
CONST DISABLE = 0, ENABLE = NOT DISABLE

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ                \/ ZONA RESERVADA AOS CDIGOS DAS TECLAS \/               ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

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

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ              \/ ZONA RESERVADA ‘S CONSTANTES INFORMTICAS \/             ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST Kbyte% = 1024, Mbyte& = 1048576, Gbyte& = 1073741824

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ              \/ ZONA RESERVADA ‘S CONSTANTES DOS PORTS IO \/             ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST lpt1$ = "LPT1:", com1$ = "COM1:", lpt2$ = "LPT2:"
CONST lpt3$ = "LPT3:", com2$ = "COM2:", com3$ = "COM3:"
CONST com4$ = "COM4:"

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ              \/ ZONA RESERVADA AOS FICHEIROS TEMPORRIOS  \/             ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST nul.file$ = " >NUL:"

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ                 \/ ZONA RESERVADA ‘S VARIVEIS NULAS  \/                 ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST nul.string$ = "", nul.integer% = 0, nul.long& = 0, nul.single! = 0, nul.double# = 0

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ             \/ ZONA RESERVADA AOS SEGMENTOS DE MEMRIA  \/               ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST MDA.SEG = &HB000, CGA.SEG = &HB800, VGA.SEG = &HA400, EGA.SEG = &HA400

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ                \/ ZONA RESERVADA ‘S CONSTANTES DO DOS  \/                ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST disk160K& = 160256, disk180K& = 179712, disk320K& = 322560
CONST disk360K& = 362496, disk720K& = 730112, disk1200K& = 1213952
CONST disk1440K& = 1457664

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ            \/ ZONA RESERVADA ‘S CONSTANTES DE IMPRESSORA  \/             ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

printer.status = FALSE
printer.line = 1

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ               \/ ZONA RESERVADA ‘S CONSTANTES DE REDE  \/                ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

NetWork.status = DISABLE
NetWork.error = NO

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ           \/ ZONA RESERVADA ‘S CONSTANTES DE AMBIENTE  \/                ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST BLACK = 0, BLUE = 1, GREEN = 2, CYAN = 3, RED = 4, MANGENTA = 5
CONST BROWN = 6, WHITE = 7, GREY = 8, LIGHT.BLUE = 9, LIGHT.GREEN = 10
CONST LIGHT.CYAN = 11, LIGHT.RED = 12, LIGHT.MANGENTA = 13, YELOW = 14
CONST LIGHT.WHITE = 15
CONST FLASH = 16

'Variaveis de controlo do procedimento GETCOLOR()
foreground = 0
background = 0

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ           \/ ZONA RESERVADA ‘S CONSTANTES DE FICHEIROS \/                ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST dat$ = ".DAT", scr$ = ".SCR", grf$ = ".GRF", var$ = ".VAR"
CONST mem$ = ".MEM", sys$ = ".SYS", cfg$ = ".CFG", txt$ = ".TXT"
CONST cor$ = ".COR", hlp$ = ".HLP", tmp$ = ".~~~", bak$ = ".BAK"
CONST ini$ = ".INI", bin$ = ".BIN", reg$ = ".REG", dbf$ = ".DBF"
CONST idx$ = ".IDX", tbl$ = ".TBL", drv$ = ".DRV", cpi$ = ".CPI"
CONST bkp$ = ".B~K", bol$ = ".BOL", prn$ = ".PRN", psw$ = ".PSW"
CONST old$ = ".OLD", dev$ = ".DEV", doc$ = ".DOC", his$ = ".HIS"

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ         \/ ZONA RESERVADA ‘ LEITURA DA LINHA DE COMANDO \/               ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

comand.line$ = UCASE$(COMMAND$)

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ         \/ ZONA RESERVADA ‘ LEITURA DA ‘REA DE VARIAVEIS \/              ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

temp.dir.1$ = ENVIRON$("TEMP")
temp.dir.2$ = ENVIRON$("TMP")
dos.path$ = ENVIRON$("PATH")
dos.comspec$ = ENVIRON$("COMSPEC")
dos.prompt$ = ENVIRON$("PROMPT")

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ         \/ ZONA RESERVADA ‘ RESERVA DE BUFFER DE IMAGEM \/               ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

CONST first.row% = 1,last.row% = 25,first.column% = 1,last.column% = 80

'ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
'ณ           \/ ZONA RESERVADA AO CONTROLO DE ERRO INTERNO   \/             ณ
'ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ

ON ERROR GOTO error.handler

'***** END OF STANDARD.INC FILE *****

