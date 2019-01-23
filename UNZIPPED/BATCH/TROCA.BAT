@echo off
if "%3"=="" goto corrente
rename %3\%1 m.$$$
rename %3\%2 %1
rename %3\m.$$$ %2
goto fim
:corrente
rename %1 m.$$$
rename %2 %1
rename m.$$$ %2
:fim
