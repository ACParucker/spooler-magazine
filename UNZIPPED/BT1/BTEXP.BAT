@Echo Off

Cls
Bt fade 2 1 9 200 Batch�Tools�v1.1�Menu fora
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
Bt typeit 1 9 0 50 50 �op��o1 �
Goto BackOff

:Opt2
Bt typeit 1 9 0 50 50 �op��o2 �
Goto BackOff

:Opt3
Bt typeit 1 9 0 25 25 �op��o3 �
Goto BackOff

:Opt4
Bt typeit 1 9 0 25 25 �op��o4 �
Goto BackOff

:Opt5
Bt typeit 1 9 0 25 25 �op��o5 �
Goto BackOff

:Opt6
Bt typeit 1 9 0 25 25 �op��o6 �
Goto BackOff

:Opt7
Bt typeit 1 9 0 25 25 �op��o7 �
Goto BackOff

:BackOff
btexp

:End
Cls
Bt fade 1 1 9 200 Exit�from�Batch�Tools�Menu fora
Echo.
