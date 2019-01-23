.AUTODEPEND

#		*Translator Definitions*
CC = bcc +SPCALC.CFG
TASM = TASM
TLIB = tlib
TLINK = tlink
LIBPATH = F:\BORLANDC\LIB
INCLUDEPATH = F:\BORLANDC\INCLUDE


#		*Implicit Rules*
.c.obj:
  $(CC) -c {$< }

.cpp.obj:
  $(CC) -c {$< }

#		*List Macros*


EXE_dependencies =  \
 spcalc.obj \
 spcinit.obj \
 about.obj \
 pref.obj \
 spcalc.res \
 scalc.def

#		*Explicit Rules*
spcalc.exe: spcalc.cfg $(EXE_dependencies)
  $(TLINK) /x/c/P-/Twe/L$(LIBPATH) @&&|
c0ws.obj+
spcalc.obj+
spcinit.obj+
about.obj+
pref.obj
spcalc
		# no map file
mathws.lib+
import.lib+
cws.lib
scalc.def
|
  RC  spcalc.res spcalc.exe


#		*Individual File Dependencies*
spcalc.obj: spcalc.cfg spcalc.cpp 

spcinit.obj: spcalc.cfg spcinit.cpp 

about.obj: spcalc.cfg about.cpp 

pref.obj: spcalc.cfg pref.cpp 

spcalc.res: spcalc.cfg spcalc.rc 
	RC -R -I$(INCLUDEPATH) -FO spcalc.res SPCALC.RC

#		*Compiler Configuration File*
spcalc.cfg: spcalc.mak
  copy &&|
-2
-w+
-G
-O
-Og
-Oe
-Om
-Ov
-Ol
-Op
-Oi
-Z
-k-
-WS
-vi-
-I$(INCLUDEPATH)
-L$(LIBPATH)
| spcalc.cfg


