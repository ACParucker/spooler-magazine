@Echo Off
Bt2 Dice 7 200 Sorteia
If ErrorLevel 6 GoTo Opt6
If ErrorLevel 5 GoTo Opt5
If ErrorLevel 4 GoTo Opt4
If ErrorLevel 3 GoTo Opt3
If ErrorLevel 2 GoTo Opt2
If ErrorLevel 1 GoTo Opt1

:Opt1
Echo.
Echo Opt1
GoTo End

:Opt2
Echo.
Echo Opt2
GoTo End

:Opt3
Echo.
Echo Opt3
GoTo End

:Opt4
Echo.
Echo Opt4
GoTo End

:Opt5
Echo.
Echo Opt5
GoTo End

:Opt6
Echo.
Echo Opt6
GoTo End

:End
