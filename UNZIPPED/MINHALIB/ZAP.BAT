@echo off
cls
del zapdbf.obj
del zapdbf.exe
cls
clipper zapdbf
rtlink file zapdbf library clipper, minhalib
zapdbf
