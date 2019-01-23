@echo off
del frm.obj
del frm.exe
cls
clipper frm
rtlink file frm, procs
frm
