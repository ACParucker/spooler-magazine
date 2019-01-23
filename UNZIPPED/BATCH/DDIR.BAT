@ECHO OFF
CLS
if "%1" == "a:" goto a
if "%1" == "b:" goto b
if "%1" == "c:" goto c
VOL
goto cont
:a
vol a:
goto cont
:b
vol b:
goto cont
:c
vol c:
:cont
if "%1" == "" goto corr
goto param
:corr
@echo  Subdirect¢rios do direct¢rio corrente.
goto fim
:param
@echo  Subdirect¢rios de %1.
:fim
DIR %1 | FIND "<DIR>">c:\ddir.$$$
type c:\ddir.$$$ | more
del c:\ddir.$$$
@echo.
