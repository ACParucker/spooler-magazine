@ECHO OFF
CLS
IF "%1"=="" GOTO VAZIO
IF "%1"=="\" GOTO RAIZ
DIR %1\*.BAT/P
GOTO FIM
:VAZIO
DIR *.BAT/P
GOTO FIM
:RAIZ
DIR \*.BAT/P
:FIM
