@Echo Off
:Begin
Cls
Bt3 Typeit3 1 2 7 10 Escolha�Op��o
Bt3 MenuMouse 1 4 9 25 bt3shell.mnu
If ErrorLevel 3 GoTo Exit
If ErrorLevel 2 GoTo DosShell
If ErrorLevel 1 GoTo SysBox
If ErrorLevel 0 GoTo Exit

:SysBox
Bt3 SysBox 20 2 7 9 1 normal
Goto Begin

:DosShell
Bt3 Typeit3 2 9 7 10 DosShell�?
Bt3 YesNoBox 1 10 7 9 25 normal por
If ErrorLevel 1 bt3shell.exe
If ErrorLevel 0 Goto Begin

:Exit
Bt3 Typeit3 2 9 7 10 Abandonar�Menu�?
Bt3 YesNoBox 1 10 7 9 25 normal por
If ErrorLevel 1 GoTo End
If ErrorLevel 0 GoTo Begin

:End
