@Echo Off
Bt2 PauseKey 9 Tecle�A,�B�ou�C�para�prosseguir... abc
If ErrorLevel 3 GoTo C
If ErrorLevel 2 GoTo B
If ErrorLevel 1 GoTo A

:A
Echo A
GoTo End

:B
Echo B
GoTo End

:C
Echo C
GoTo End

:End
