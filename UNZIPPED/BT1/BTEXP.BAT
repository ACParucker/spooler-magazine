@Echo Off

Cls
Bt fade 2 1 9 200 BatchÿToolsÿv1.1ÿMenu fora
Bt menubar 2 3 9 15 btrun.mnu
If ErrorLevel 8 GoTo End
If ErrorLevel 7 GoTo Opt7
If ErrorLevel 6 GoTo Opt6
If ErrorLevel 5 GoTo Opt5
If ErrorLevel 4 GoTo Opt4
If ErrorLevel 3 GoTo Opt3
If ErrorLevel 2 GoTo Opt2
If ErrorLevel 1 GoTo Opt1
Goto End

:Opt1
Bt typeit 1 9 0 50 50 ÿop‡„o1 Û
Goto BackOff

:Opt2
Bt typeit 1 9 0 50 50 ÿop‡„o2 Û
Goto BackOff

:Opt3
Bt typeit 1 9 0 25 25 ÿop‡„o3 Û
Goto BackOff

:Opt4
Bt typeit 1 9 0 25 25 ÿop‡„o4 Û
Goto BackOff

:Opt5
Bt typeit 1 9 0 25 25 ÿop‡„o5 Û
Goto BackOff

:Opt6
Bt typeit 1 9 0 25 25 ÿop‡„o6 Û
Goto BackOff

:Opt7
Bt typeit 1 9 0 25 25 ÿop‡„o7 Û
Goto BackOff

:BackOff
btexp

:End
Cls
Bt fade 1 1 9 200 ExitÿfromÿBatchÿToolsÿMenu fora
Echo.
