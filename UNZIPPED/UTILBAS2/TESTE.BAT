@echo off
REM Aten��o....Altere os direct�rios onde este arquivo e seus componentes
REM ir�o ficar e inclua-o na PATH do DOS
cls
REM � importante que o MNU.EXE funcione dentro de um ciclo fechado
REM e que o mesmo seja finalizado com o arquivo.CTL criado pelo MNU.EXE
:loop
REM MNUOPC controla o arquivo que vai memorizar a op��o escolhida
SET MNUOPC=TESTE.OPC
REM MNUCTL controla a finaliza��o do MNU.EXE e t�rmino do BAT MENU
SET MNUCTL=TESTE.FIM
REM MNUBAT controla o GO?.BAT que ir� executar a op��o escolhida
SET MNUBAT=GOTST.BAT
REM Carrega a fonte Gr�fica
mnufnt1
REM Carrega o men�
mnu teste.mnu
REM Se existe o CTL definido inicialmente ent�o termina
if exist %MNUCTL% goto fim
REM Se existe o BAT definido inicialmente ent�o executa o que esiver dentro
REM dele
if exist %MNUBAT% call %MNUBAT%
REM Se ele foi executado ent�o apaga para n�o haver conflitos
if exist %MNUBAT% del %MNUBAT%
REM repete o men� at� que seja criado o arquivo.CTL
goto loop
REM Quando o arquivo.CTL for criado vem para aqui
:fim
mnufnt0
REM Como o men� j� terminou e para n�o consumir mais espa�o em disco
REM �rua� com estes arquivos
if exist %MNUCTL% del %MNUCTL%
if exist %MNUOPC% del %MNUOPC%
REM Limpa as variaveis do DOS
SET MNUOPC=
SET MNUBAT=
SET MNUCTL=
REM Apaga os GO que possam existir
del go*.bat
REM Limpa a tela
cls
REM e Rua.....
cd\
REM Anula os efeitos da Fonte Gr�fica
MODE CO80
