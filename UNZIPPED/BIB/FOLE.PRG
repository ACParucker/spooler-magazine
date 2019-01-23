********************
* Abertura
*******************

cor=setcolor()
s:= savescreen(8,2,17,41)
set color to gr+/r
zoomin()
set color to n/w
@8,2 to 16,40
sombra(8,2,16,40)
set color to gr+/r
@9, 3 say "            BIBGEST v5.0             "
@10,3 say "    Gest„o de Biblioteca Pessoal     "
set color to n/w
@11,2 say "Ã"
@11,3 to 11,39
@11,40 say "´"
set color to gr+/r
@12,3 say "           Vers„o FREEWARE           "
set color to n/w
@13,2 say "Ã"
@13,3 to 13,39
@13,40 say "´"
@14,3 say "            Isildo Mendes            "
@15,3 say "            Junho de 1994            "
@1,16 to 5,49
sombra(1,16,5,49)
set color to r/w
@2,17 say " Este programa ‚ de utilidade   "
@3,17 say " p£blica, podendo ser copiado e "
@4,17 say " distribu¡do livremente.        "  
inkey(0)
set color to n/bg
@20,48 clear to 23,77
@1,16 clear to 6,50
setcolor("&cor")
restscreen(8,2,17,41,s)
zoomout()
return
*****************

Function zoomin(tempo)

public n1,n2,n3,n4,n5,n6,n7,n8

if tempo=nil
  tempo=.01
endif

n1:=savescreen(0,76,3,79)
@0,76 clear to 2,79
@0,76 to 2,79
sombra(0,76,2,79)
inkey(tempo)
n2:= savescreen(1,71,5,78)
@1,71 clear to 4,77
@1,71 to 4,77
sombra(1,71,4,77)
inkey(tempo)
n3:= savescreen(3,65,8,74)
@3,65 clear to 7,73
@3,65 to 7,73
sombra(3,65,7,73)
inkey(tempo)
n4:= savescreen(6,58,11,69)
@6,58 clear to 10,68
@6,58 to 10,68
sombra(6,58,10,68)
inkey(tempo)
n5:= savescreen(9,48,15,61)
@9,48 clear to 14,60
@9,48 to 14,60
sombra(9,48,14,60)
inkey(tempo)
n6:= savescreen(12,38,19,53)
@12,38 clear to 18,52
@12,38 to 18,52
sombra(12,38,18,52)
inkey(tempo)
n7:=savescreen(16,20,23,46)
@16,20 clear to 22,45
@16,20 to 22,45
sombra(16,20,22,45)
inkey(tempo)
corantig=setcolor()
n8:=savescreen(14,5,20,35)
@14,5 clear to 19,34
@14,5 to 19,34
sombra(14,5,19,34)
corantig=setcolor()
setcolor("&corantig")
return nil

*********************************

Function zoomout(tempo)

if tempo=nil
  tempo=.01
endif

restscreen(14,5,20,35,n8)
inkey(tempo)
restscreen(16,20,23,46,n7)
inkey(tempo)
restscreen(12,38,19,53,n6)
inkey(tempo)
restscreen(9,48,15,61,n5)
inkey(tempo)
restscreen(6,58,11,69,n4)
inkey(tempo)
restscreen(3,65,8,74,n3)
inkey(tempo)
restscreen(1,71,5,78,n2)
inkey(tempo)
restscreen(0,76,3,79,n1)
return nil
************************

Function Recver2(nMov)

if nmov=nil
  nmov=1
endif
do case
  case nmov=1
    for i=0 to 39
      restscreen(0,0,24,i,mt[1])
      inkey(.01)
    next
    for i=79 to 40 step -1
      restscreen(0,i,24,79,mt[2])
      inkey(.01)
    next
  case nmov=2
    for i=0 to 24
      restscreen(0,0,i,39,mt[1])
      inkey(.01)
    next
    for i=24 to 0 step -1
      restscreen(i,40,24,79,mt[2])
      inkey(.01)
    next
endcase
return nil
***********************

