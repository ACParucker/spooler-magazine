@echo off
cls
del agenda.obj
del agenda.exe
cls
clipper agenda
rtlink file agenda, edit library clipper, minhalib
agenda
