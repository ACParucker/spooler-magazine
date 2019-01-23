@echo off
rem O ficheiro Repeat.Bat
rem ‚ executado 3 vezes.
bt2 repeat 3 repeat.dat
if not exist repeat.dat goto end
echo *
repeat.bat
:End
