@echo off
if "%1" == "" goto vazio
if not "%1" == "" goto cheio
:vazio
del *.bak
goto fim
:cheio
del %1\*.bak
goto fim
:fim
