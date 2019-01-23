* CHOIC.PRG	*

PRIVATE ficheiro,vcome,vtermi,hand

ant := savescreen(10,1,23,78)

do while .t.

  if imp = 2
    set color to w+*/n
    @6,54 say "ESCAPE = Imprimir."
  endif

  if imp = 3
    anula()
    exit
  endif

  set color to w/n
  ficheiro = file
  vcome = comeco
  vterm = termino
  set color to w+/b
  @15,20 to 17,62
  @16,21 say " Localizando dados. Espere um momento... "
  hand = memoread(ficheiro)
  var = "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±± SPOOLER - Magazine ±±±±±±± "
  va  = replicate("±",78)
  var1 = stuff(var,len(var)+1,0,replicate(" ",78))
  inicio = len(var1)
  for i=vcome to vterm
    var2 = stuff(var1,inicio+1,0,memoline(hand,79,i))
    inicio = inicio + len(var2)
    var1 = var2
  next i
  var3 = stuff(var2,inicio+1,0,replicate(" ",78))
  var4 = stuff(var3,inicio+79,0,va)
  set color to w+/n
  memoedit(var4,10,1,23,78,.f.,"",78)
  if imp = 2
    choic2()
  endif
  exit
enddo
restscreen(10,1,23,78,ant)
set color to w/n
@6,54 say "ESCAPE - Sair.    "
return
 
***************************

procedure choic2
 
local ext
ext = space(1)
inicio = 1

do while .t.
   e := savescreen(0,0,24,79)
   tecla = lastkey()
   store " " to resp
   do case
    case tecla = 27
     set color to w+/b,n/w
     @24,18 say "Deseja imprimir o texto visualizado?(S/N)   "
     @24,60 get resp pict "!" 
     read
     if resp = "S"
       if .not. isprinter()
         @24,18 say "Impressora NŽO PREPARADA! Prima uma tecla..."
         inkey(0)
         restscreen(0,0,24,79,e)
         return
       endif
       @24,18 say "    Imprimindo... Aguarde um momento...    "
       set device to print
       set print on
       @prow(),0 say "SPOOLER - Magazine"
       @prow(),60 say "UTILSOFT - Software"
       @prow()+1,0 say "Dicion rio de Termos Inform ticos"
       @prow()+2,0 say " "
       for i=vcome to vterm
         extracto = memoline(hand,79,i)
         @prow()+1,0 say extracto
       next
       @prow()+1,0 say replicate("-",78)
       eject
       set device to screen
       set print off
       exit
     else
      exit
     endif
    otherwise
     exit
  endcase
enddo
restscreen(0,0,24,79,e)
return

*************************
* Fim de ficheiro.
