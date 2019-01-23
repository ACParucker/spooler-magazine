@ECHO OFF
CLS
IF "%1"=="A:" GOTO A
IF "%1"=="a:" GOTO A
IF "%1"=="B:" GOTO B
IF "%1"=="b:" GOTO B
IF "%1"=="C:" GOTO C
IF "%1"=="c:" GOTO C
GOTO AJUDA
:A
SHIFT
IF "%1"=="" GOTO GLOBAL
:CICLO
FOR %%A IN (COPY DEL) DO %%A A:%1
SHIFT
IF NOT "%1"=="" GOTO CICLO
GOTO FIM
:GLOBAL
FOR %%A IN (COPY DEL) DO %%A A:*.*
GOTO FIM
:B
SHIFT
IF "%1"=="" GOTO GLOBALB
:CICLOB
FOR %%A IN (COPY DEL) DO %%A B:%1
SHIFT
IF NOT "%1"=="" GOTO CICLOB
GOTO FIM
:GLOBALB
FOR %%A IN (COPY DEL) DO %%A B:*.*
GOTO FIM
:C
SHIFT
IF "%1"=="" GOTO GLOBALC
:CICLOC
FOR %%A IN (COPY DEL) DO %%A C:%1
SHIFT
IF NOT "%1"=="" GOTO CICLOC
GOTO FIM
:GLOBALC
FOR %%A IN (COPY DEL) DO %%A C:*.*
GOTO FIM
:AJUDA
ECHO **********************************************************************
ECHO *                 A J U D A   P A R A   M O V E R                    *
ECHO *                                                                    *
ECHO *         O ficheiro batch MOVER move ficheiros entre disquetes ou   *
ECHO * entre uma disquete e o disco r¡gido. Para us -lo dever  colocar-se *
ECHO * no direct¢rio de origem de uma disquete e no direct¢rio de destino *
ECHO * da outra e introduzir o comando que deseja executar. Por exemplo,  *
ECHO * para mover os ficheiros batch e o COMMAND.COM do direct¢rio XICO   *
ECHO * da drive A: para o direct¢rio BATCH do disco C:, fa‡a:             *
ECHO *         "C:\> CD BATCH                       "                     *
ECHO *         "C:\BATCH> A:                        "                     *
ECHO *         "A:\> CD XICO                        "                     *
ECHO *         "A:\XICO> C:                         "                     *
ECHO *         "C:\BATCH> MOVER A: *.BAT COMMAND.COM"                     *
ECHO * Se s¢ entrar a drive como parƒmetro, o batch assume a totalidade   *
ECHO * dos ficheiros.                                                     *
ECHO **********************************************************************
:FIM
