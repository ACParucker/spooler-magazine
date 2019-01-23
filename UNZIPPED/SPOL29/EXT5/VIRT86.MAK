.AUTODEPEND

#		*Translator Definitions*
CC = bcc +VIRT86.CFG
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
 startup.obj \
 vmonitor.obj \
 preprot.obj

#		*Explicit Rules*
virt86.exe: virt86.cfg $(EXE_dependencies)
  $(TLINK) /x/3/c/P-/L$(LIBPATH) @&&|
c0c.obj+
startup.obj+
vmonitor.obj+
preprot.obj
virt86
		# no map file
cc.lib
|


#		*Individual File Dependencies*
startup.obj: virt86.cfg startup.c 

vmonitor.obj: virt86.cfg vmonitor.asm 
	$(TASM) /MX /M5 /O VMONITOR.ASM,VMONITOR.OBJ

preprot.obj: virt86.cfg preprot.asm 
	$(TASM) /MX /M5 /O PREPROT.ASM,PREPROT.OBJ

#		*Compiler Configuration File*
virt86.cfg: virt86.mak
  copy &&|
-R
-mc
-a
-f-
-ff-
-N
-vi-
-I$(INCLUDEPATH)
-L$(LIBPATH)
| virt86.cfg


