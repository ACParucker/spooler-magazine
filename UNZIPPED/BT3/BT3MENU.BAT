@Echo Off
:Begin
rem { Uso do Rato:                 
rem   But„o esquerdo - confirmar
rem   But„o direito  - cancelar
rem
rem   Equivalentes do Teclado:
rem   Enter - confirmar
rem   Esc   - cancelar
rem   Tab   - mudar op‡„o
rem   setas - mudar op‡„o }
Cls
Bt3 Typeit3 1 2 7 10 EscolhaÿOp‡„o
rem { Apresenta um menu com os itens contidos no
rem   ficheiro bt3menu.mnu, e inicializa o rato }
Bt3 menumouse 1 4 9 25 bt3menu.mnu
rem { Se escolheu 1, 2 ou 3 ent„o... }
If ErrorLevel 3 GoTo Exit
If ErrorLevel 2 GoTo Opt2
If ErrorLevel 1 GoTo Opt1
rem { Se teclou Esc ou o but„o direito do rato
rem   ent„o ErrorLevel = 0 e vai para... }
If ErrorLevel 0 GoTo Exit

:Opt1
Echo ÿOp‡„o1
Pause > nul
Rem { Loop }
Goto Begin

:Opt2
Echo ÿOp‡„o2
Pause > nul
Rem { Loop }
Goto Begin

:Exit
Bt3 Typeit3 2 9 7 10 AbandonarÿMenuÿ?
rem { Apresenta uma caixa de dialogo com
rem   op‡”es l¢gicas sim e n„o na l¡ngua
rem   nativa (Por,Eng,Fra,Ger) }
Bt3 YesNoBox 1 10 7 9 25 normal por
rem { Se escolheu 'sim', o valor de
rem   ErrorLevel ‚ 1 e ... }
If ErrorLevel 1 GoTo End
rem { Se teclou Esc ou o but„o direito do
rem   rato, ou escolheu 'n„o', o valor de
rem   ErrorLevel ‚ 0 e ... }
If ErrorLevel 0 GoTo Begin

:End
