'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�                     QUICK BASIC IV - FICHA T륝NICA                        �
'쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'� Software................: QUICK BASIC USER LIBRARY I                      �
'� M줰ulo,Execut쟶el.......: USERLIB1.BAS, USERLIB1.LIB, USERLIB1.QLB        �
'� Vers꼘 (Idioma),rev.....: 1.1 (P), 30/10/93                               �
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
'�     Procedimentos, fun뇯es e blocos de programa a serem usados em todos os�
'쿾rogramas a serem criados pelo Quick BASIC. Inclui gest꼘 de ficheiros e de�
'퀂istema.                                                                   �
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'�    Ideia levado a cabo por N굃io Remigio Correia de Abreu, com o apoio das�
'쿶nstru뇯es do Clipper. Todos os direitos reservados. Para ser usado em am- �
'쿫iente DOS no Quick BASIC 4.5 (compilador).                                �
'컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
'쿎omo criar a biblioteca de sistema USERLIB1.LIB e a de ambiente USERLIB1. �
'�.QLB ?                                                                    �
'�                                                                          �
'�     1� - Inicializar o Quick Basic sob a forma de QB /L QB - Isto avisa- �
'�          r� ao QB que pretende criar uma biblioteca e que ele dever� co- �
'�          locar o c줰igo de controlo na biblioteca a ser criada. Isto evi-�
'�          tar� possiveis erros na gera뇙o da biblioteca. Poder� criar a   �
'�          biblioteca sem usar a biblioteca QB mas n꼘 ha gar긪tias de que �
'�          a biblioteca criada esteja em prefeitas condi뇯es.              �
'�                                                                          �
'�     2� - Logo que apare놹 o men� do topo, escolha a op뇙o File, e dentro �
'�          desta escolha Open. Carregue esta biblioteca como se fosse um   �
'�          programa (caso tenha sido gravada com a extensao BAS (default)  �
'�                                                                          �
'�     3� - Logo que o c줰igo fonte deste ficheiro apare놹 dentro da janela �
'�          escolha a op뇙o Run, e dentro desta a op뇙o Make Library...     �
'�                                                                          �
'�     4� - Confirme o nome que pretende dar � biblioteca e pressione ENTER �
'�                                                                          �
'�     5� - Ao pressionar ENTER o QB ir� verificar o m줰ulo para ver se n꼘 �
'�          existem erros. Caso existam o QB ir� parar no local exacto.     �
'�                                                                          �
'�     6� - Caso n꼘 existam erros o QB ir� criar as duas bibliotecas: a LIB�
'�          e a QLB. Destas utilize a QLB dentro do QB carregando-a como    �
'�          carregou a QB.QLB no inicio. A LIB ser� uusada pelo QB quando   �
'�          for criado o EXEcut쟶el                                         �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
'旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
'쿙OTA: Sempre que quiser utilizar esta biblioteca no seu EXEcut쟶el e caso �
'넌袴袴 seja dentro do QB n꼘 esque놹 nunca de inicializar o QB sob a forma �
'�      de QB /L nome_da_biblioteca_QLB. Fora do QB, crie e inclua um fich- �
'�      eiro com as declara뇯es das bibliotecas. Este tamb굆 dever� de ser  �
'�      incluido (sob a forma de '$INCLUDE: 'nome_do_ficheiro') no inicio   �
'�      do programa. Este ficheiro dever� de ser id늧tico a este, n꼘 pos-  �
'�      suindo o resto do c줰igo. Fora do QB, na cria뇙o do EXEcut쟶el de-  �
'�      ver� de incluir a biblioteca LIB no LINK.                           �
'읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�               \/ ZONA RESERVADA AS FUNCOES DA PROGRAMACAO \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

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

'Fun뇯es para convers꼘 num굍ica
DECLARE FUNCTION BIN2DEC& (valor$)
DECLARE FUNCTION BIN2HEX$ (valor$)
DECLARE FUNCTION BIN2OCT$ (valor$)
DECLARE FUNCTION DEC2BIN$ (valor#)
DECLARE FUNCTION DEC2HEX$ (valor#)
DECLARE FUNCTION DEC2OCT$ (valor#)
DECLARE FUNCTION HEX2BIN$ (valor$)
DECLARE FUNCTION HEX2DEC& (valor$)
DECLARE FUNCTION HEX2OCT$ (valor$)
DECLARE FUNCTION OCT2DEC& (valor$)
DECLARE FUNCTION OCT2HEX$ (valor$)
DECLARE FUNCTION OCT2BIN$ (valor$)

'Fun뇯es de c쟫culo num굍ico avan놹do
DECLARE FUNCTION INVERS# (valor)
DECLARE FUNCTION SQUARE& (valor)
DECLARE FUNCTION CUBE& (valor)
DECLARE FUNCTION PI# ()

'Fun뇯es matem쟴icas
DECLARE FUNCTION ADD.BIN$ (valor1$, valor2$)
DECLARE FUNCTION ADD.HEX$ (valor1$, valor2$)
DECLARE FUNCTION ADD.OCT$ (valor1$, valor2$)
DECLARE FUNCTION SUB.HEX$ (valor1$, valor2$)
DECLARE FUNCTION SUB.OCT$ (valor1$, valor2$)
DECLARE FUNCTION SUB.BIN$ (valor1$, valor2$)
DECLARE FUNCTION MUL.HEX$ (valor1$, valor2$)
DECLARE FUNCTION MUL.OCT$ (valor1$, valor2$)
DECLARE FUNCTION MUL.BIN$ (valor1$, valor2$)
DECLARE FUNCTION DIV.HEX$ (valor1$, valor2$)
DECLARE FUNCTION DIV.OCT$ (valor1$, valor2$)
DECLARE FUNCTION DIV.BIN$ (valor1$, valor2$)
DECLARE FUNCTION FACTORIAL& (valor1)
DECLARE FUNCTION PERCENT! (valor!)
DECLARE FUNCTION TEN# (expoente%)
DECLARE FUNCTION VIRG$ (valor#, casas)

'Fun뇯es boleanas
DECLARE FUNCTION ZERO (n)
DECLARE FUNCTION NEGATIVE (n)
DECLARE FUNCTION POSITIVE (n)
DECLARE FUNCTION ALLTRIM$ (n$)
DECLARE FUNCTION EMPTY (n$)
DECLARE FUNCTION IIF$ (condicao, valor1$, valor2$)

'Fun뇯es de tempo
DECLARE FUNCTION TEMPFILE$ (t$)
DECLARE FUNCTION TIME2SECONDS (t$)
DECLARE FUNCTION SECONDS2TIME$ (s)
DECLARE FUNCTION EVALUATE$ (tin$, tfi$)

'Fun뇯es de arquivo
DECLARE FUNCTION OPEN.FILES ()
DECLARE FUNCTION PATH$ (drive$)
DECLARE FUNCTION DOS.FAT (pathname$)
DECLARE FUNCTION DISK.FREE& (drive$)
DECLARE FUNCTION DOS.VER$ ()
DECLARE FUNCTION DOS.VOL$ (drive$)

'Fun뇯es de sistema
DECLARE FUNCTION BASE.MEMORY ()
DECLARE FUNCTION FLOPPY ()
DECLARE FUNCTION RS232 ()
DECLARE FUNCTION GAME ()
DECLARE FUNCTION LPT ()
DECLARE FUNCTION FPU ()
DECLARE FUNCTION SPEED ()
DECLARE FUNCTION VERSION$ ()
DECLARE FUNCTION KEY.STATUS$ ()
DECLARE FUNCTION INTERNAL.MEMORY ()
DECLARE FUNCTION STRING.MEMORY ()
DECLARE FUNCTION STACK ()
DECLARE FUNCTION NUMBER.MEMORY ()


'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�            \/ ZONA RESERVADA AS PROCEDURES DA PROGRAMACAO \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

DECLARE SUB CLW (l1, c1, l2, c2)
DECLARE SUB BOX (l1, c1, l2, c2, frame$)
DECLARE SUB PAGE.SET (lines)
DECLARE SUB PRINTER (port$, st)
DECLARE SUB CONDENSED (st)
DECLARE SUB EXPANDED (st)
DECLARE SUB FORMFEED ()
DECLARE SUB PAGE.JUMP (l)
DECLARE SUB CURSOR (st)
DECLARE SUB INTERRUPT (intnum AS INTEGER, inreg AS RegType, outreg AS RegType)
DECLARE SUB INTERRUPTX (intnum AS INTEGER, inreg AS RegTypeX, outreg AS RegTypeX)
' NOTE: If the routine called takes parameters, then they will have to
'       be added to this declare statement before the parameter given.
DECLARE SUB ABSOLUTE (address AS INTEGER)
DECLARE SUB INT86OLD (intnum AS INTEGER, inarray() AS INTEGER, outarray() AS INTEGER)
DECLARE SUB INT86XOLD (intnum AS INTEGER, inarray() AS INTEGER, outarray() AS INTEGER)
DECLARE SUB SAVE.SCREEN (m$)
DECLARE SUB RESTORE.SCREEN (m$)
DECLARE SUB HMENU (l, opcoes$(), colunas(), f1, b1, f2, b2, f3, b3, frame$, msg$(), lm, cm, f4, b4, items)
DECLARE SUB VMENU (c, opcoes$(), linhas(), f1, b1, f2, b2, f3, b3, frame$, msg$(), lm, cm, f4, b4, items)
DECLARE SUB COPY (source$, target$)
DECLARE SUB BACKUP (source$, target$)
DECLARE SUB ADD (filename$, vstring$)
DECLARE SUB REMOVE (filename$, vstring$)
DECLARE SUB INSERE (filename$, vstring$, position)
DECLARE SUB UPDATE.PATH (autoexec.file$, directory$)
DECLARE SUB TEXT.BOX (l, c, texto$(), f1, b1, f2, b2, items, centro)
DECLARE SUB MOVE (source$, target$)
DECLARE SUB DIVISION (l1, c1, l2, c2, frame$)
DECLARE SUB FILL (l1, c1, l2, c2, frame$)
DECLARE SUB CENTER (l, texto$)
DECLARE SUB ADIR (pathname$, vfiles, file.name$(), file.ext$(), file.size(), file.date$(), file.time$(), file.type$())
DECLARE SUB CTRL.BREAK (status)
DECLARE SUB CTRL.C (status)
DECLARE SUB ALT.CTRL.DEL (status)
DECLARE SUB SHOW (filename$, f1, b1, bd, f2, b2, f3, b3, frame$)

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�             \/ ZONA RESERVADA 멣 CONSTANTES DA PROGRAMA�랳 \/            �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

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

F1.key$ = CHR$(0) + CHR$(59)
F2.key$ = CHR$(0) + CHR$(60)
F3.key$ = CHR$(0) + CHR$(61)
F4.key$ = CHR$(0) + CHR$(62)
F5.key$ = CHR$(0) + CHR$(63)
F6.key$ = CHR$(0) + CHR$(64)
F7.key$ = CHR$(0) + CHR$(65)
F8.key$ = CHR$(0) + CHR$(66)
F9.key$ = CHR$(0) + CHR$(67)
F10.key$ = CHR$(0) + CHR$(68)

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

ALT.A.key$ = CHR$(0) + CHR$(30)
ALT.B.key$ = CHR$(0) + CHR$(48)
ALT.C.key$ = CHR$(0) + CHR$(46)
ALT.D.key$ = CHR$(0) + CHR$(32)
ALT.E.key$ = CHR$(0) + CHR$(18)
ALT.F.key$ = CHR$(0) + CHR$(33)
ALT.G.key$ = CHR$(0) + CHR$(34)
ALT.H.key$ = CHR$(0) + CHR$(35)
ALT.I.key$ = CHR$(0) + CHR$(23)
ALT.J.key$ = CHR$(0) + CHR$(36)
ALT.K.key$ = CHR$(0) + CHR$(37)
ALT.L.key$ = CHR$(0) + CHR$(38)
ALT.M.key$ = CHR$(0) + CHR$(50)
ALT.N.key$ = CHR$(0) + CHR$(49)
ALT.O.key$ = CHR$(0) + CHR$(24)
ALT.P.key$ = CHR$(0) + CHR$(25)
ALT.Q.key$ = CHR$(0) + CHR$(16)
ALT.R.key$ = CHR$(0) + CHR$(19)
ALT.S.key$ = CHR$(0) + CHR$(31)
ALT.T.key$ = CHR$(0) + CHR$(20)
ALT.U.key$ = CHR$(0) + CHR$(22)
ALT.V.key$ = CHR$(0) + CHR$(47)
ALT.W.key$ = CHR$(0) + CHR$(17)
ALT.X.key$ = CHR$(0) + CHR$(45)
ALT.Y.key$ = CHR$(0) + CHR$(21)
ALT.Z.key$ = CHR$(0) + CHR$(44)
ALT.F1.key$ = CHR$(0) + CHR$(104)
ALT.F2.key$ = CHR$(0) + CHR$(105)
ALT.F3.key$ = CHR$(0) + CHR$(106)
ALT.F4.key$ = CHR$(0) + CHR$(107)
ALT.F5.key$ = CHR$(0) + CHR$(108)
ALT.F6.key$ = CHR$(0) + CHR$(109)
ALT.F7.key$ = CHR$(0) + CHR$(110)
ALT.F8.key$ = CHR$(0) + CHR$(111)
ALT.F9.key$ = CHR$(0) + CHR$(112)
ALT.F10.key$ = CHR$(0) + CHR$(113)
ALT.1.key$ = CHR$(0) + CHR$(120)
ALT.2.key$ = CHR$(0) + CHR$(121)
ALT.3.key$ = CHR$(0) + CHR$(122)
ALT.4.key$ = CHR$(0) + CHR$(123)
ALT.5.key$ = CHR$(0) + CHR$(124)
ALT.6.key$ = CHR$(0) + CHR$(125)
ALT.7.key$ = CHR$(0) + CHR$(126)
ALT.8.key$ = CHR$(0) + CHR$(127)
ALT.9.key$ = CHR$(0) + CHR$(128)
ALT.0.key$ = CHR$(0) + CHR$(129)

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�              \/ ZONA RESERVADA 멣 CONSTANTES INFORM냊ICAS \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST Kbyte% = 1024, Mbyte& = 1048576

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�              \/ ZONA RESERVADA 멣 CONSTANTES DOS PORTS IO \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST lpt1$ = "LPT1:", com1$ = "COM1:", lpt2$ = "LPT2:"
CONST lpt3$ = "LPT3:", com2$ = "COM2:", com3$ = "COM3:"
CONST com4$ = "COM4:"

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�              \/ ZONA RESERVADA AOS FICHEIROS TEMPOR냃IOS  \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

CONST nul.file$ = " >NUL:", temp.file$ = "TEMPFILE.TMP"

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

CONST PRETO = 0, AZUL = 1, VERDE = 2, CIAN = 3, VERMELHO = 4, VIOLETA = 5
CONST CASTANHO = 6, BRACO = 7, CINZA = 8, AZUL.BRILHANTE = 9, VERDE.BRILHANTE = 10
CONST CIAN.BRILHANTE = 11, VERMELHO.BRILHANTE = 12, VIOLETA.BRILHANTE = 13
CONST AMARELO = 14, BRANCO.BRILHANTE = 15
CONST CINTILHANTE = 16

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

parameter$ = UCASE$(COMMAND$)

'郞袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴拷
'�           \/ ZONA RESERVADA AO CONTROLO DE ERRO INTERNO   \/             �
'突袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴槁

ON ERROR GOTO error.handler

'***** END OF STANDARD.INC FILE *****

