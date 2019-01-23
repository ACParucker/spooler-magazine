@echo off
if "%1"=="" goto aviso
echo Criando o direct¢rio %1\USERLIB1.....
md %1\userlib1 >nul:
echo Copiando o USERLIB1.EXE para %1\USERLIB1.....
copy userlib1.exe %1\userlib1 >nul:
%1
cd\userlib1
echo Descompactando o USERLIB1....
userlib1
cls
echo Informa‡„o compactada:
dir userlib1.exe
echo Informa‡„o geral:
dir /w
echo.
echo Com os comprimentos de N‚lio Abreu.....
echo.
goto fim
:aviso
echo Sintaxe de uso: SPOOLER letra_do_disco: 
:fim
