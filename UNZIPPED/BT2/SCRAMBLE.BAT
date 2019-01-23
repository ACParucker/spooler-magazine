@Echo Off
Echo.
Echo Demonstra‡„o da fun‡„o
Echo Scramble em Batch Tools 2 v1.0
Echo.
Echo O texto a baralhar ‚ 'Ol '
Bt2 Scramble 9 Ol  3
If ErrorLevel 1 Goto Acertou
If ErrorLevel 0 Goto Falhou

:Acertou
Echo.
Echo Acertou na resposta.
GoTo End
                     
:Falhou
Echo.
Echo Falhou nas 3 tentativas.
Echo A resposta era 'Ol '.

:End
