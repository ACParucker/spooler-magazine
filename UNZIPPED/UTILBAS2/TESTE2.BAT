@echo off
REM AtenáÑo....Altere os direct¢rios onde este arquivo e seus componentes
REM irÑo ficar e inclua-o na PATH do DOS
cls
REM ê importante que o MNU.EXE funcione dentro de um ciclo fechado
REM e que o mesmo seja finalizado com o arquivo.CTL criado pelo MNU.EXE
:loop
REM MNUOPC controla o arquivo que vai memorizar a opáÑo escolhida
SET MNUOPC=TESTE2.OPC
REM MNUCTL controla a finalizaáÑo do MNU.EXE e tÇrmino do BAT MENU
SET MNUCTL=TESTE2.FIM
REM MNUBAT controla o GO?.BAT que ir† executar a opáÑo escolhida
SET MNUBAT=GOTST2.BAT
REM Carrega a fonte Gr†fica
mnufnt1
REM Carrega o men£
mnu teste2.mnu
REM Se existe o CTL definido inicialmente entÑo termina
if exist %MNUCTL% goto fim
REM Se existe o BAT definido inicialmente entÑo executa o que esiver dentro
REM dele
if exist %MNUBAT% call %MNUBAT%
REM Se ele foi executado entÑo apaga para nÑo haver conflitos
if exist %MNUBAT% del %MNUBAT%
REM repete o men£ atÇ que seja criado o arquivo.CTL
goto loop
REM Quando o arquivo.CTL for criado vem para aqui
:fim
mnufnt0
REM Como o men£ j† terminou e para nÑo consumir mais espaáo em disco
REM ÆruaØ com estes arquivos
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
REM Anula os efeitos da Fonte Gr†fica
MODE CO80
