@Echo Off
Bt2 Dice Sorteia
If ErrorLevel 6 GoTo Opt6
If ErrorLevel 5 GoTo Opt5
If ErrorLevel 4 GoTo Opt4
If ErrorLevel 3 GoTo Opt3
If ErrorLevel 2 GoTo Opt2
If ErrorLevel 1 GoTo Opt1

:Opt1
Echo 1
GoTo End

:Opt2
Echo 2
GoTo End

:Opt3
Echo 3
GoTo End

:Opt4
Echo 4
GoTo End

:Opt5
Echo 5
GoTo End

:Opt6
Echo 6
GoTo End

:End
