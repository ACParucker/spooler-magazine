@echo off
if exist resul.dat ren resul.dat resul.

ren resul1.dat resul.dat
echo 1§ exemplo
echo Grau=1, Pontos=6, Decimais=8
pause
grafico2
ren resul.dat resul1.dat

ren resul2.dat resul.dat
echo 1§ exemplo
echo Grau=2, Pontos=6, Decimais=8
pause
grafico2
ren resul.dat resul2.dat

ren resul3.dat resul.dat
echo 1§ exemplo
echo Grau=3, Pontos=6, Decimais=8
pause
grafico2
ren resul.dat resul3.dat


ren resul4.dat resul.dat
echo 2§ exemplo
echo Grau=1, Pontos=6, Decimais=2
pause
grafico2
ren resul.dat resul4.dat

ren resul5.dat resul.dat
echo 2§ exemplo
echo Grau=2, Pontos=6, Decimais=2
pause
grafico2
ren resul.dat resul5.dat

ren resul6.dat resul.dat
echo 2§ exemplo
echo Grau=3, Pontos=6, Decimais=2
pause
grafico2
ren resul.dat resul6.dat



ren resul7.dat resul.dat
echo 3§ exemplo
pause
grafico2
ren resul.dat resul7.dat

if exist resul. rename resul. resul.dat