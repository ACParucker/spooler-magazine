* TBrowse
* Cargo e modifica‡„o de objectos

#include "Inkey.ch"
#include "Setcurs.ch"

Public objBr, objCol, nTecla, vdtentra

men2 := savescreen(7,0,19,80)

vdtentra=ctod("  /  /  ")
locate for dtentrad=vdtentra

set cursor off
set color to n/w,w+/r

objBr := TBrowseDB(8, 1, 17, 78)
@7,0 to 18,79 double
sombra(7,0,18,80)
objBr:colsep := CHR(032) + CHR(179) + CHR(032)
objBr:headsep := CHR(205) + CHR(209) + CHR(205)

objBr:skipBlock := {|nRegs| Skippe(nRegs)}
objBr:goTopBlock := {| | goTopD()}
objBr:goBottomBlock := {| | goBottomD()}

objCol := TBcolumnNew("T¡tulo do Livro", {||livros->titulo})
objBr:addcolumn(objCol)
objCol := TBColumnNew("Destino", {||bibamigo->nome})
objBr:addcolumn(objCol)

WHILE .T.
 	
   WHILE (!objBr:stabilize())
      nTecla := INKEY()
      IF (nTecla != 0)
        EXIT
      ENDIF
   END

   IF (objBr:stable)
     IF (objBr:hitTop .OR. objBr:hitBottom)
       TONE(125,0)
     ENDIF
     nTecla := INKEY(0)
   ENDIF

   IF (nTecla == K_DOWN)
     objBr:down()
   ELSEIF (nTecla == K_UP)
     objBr:up()
   ELSEIF (nTecla == K_PGDN)
     objBr:pageDown()
   ELSEIF (nTecla == K_PGUP)
     objBr:pageUp()
   ELSEIF (nTecla == K_CTRL_PGUP)
     objBr:goTop()
   ELSEIF (nTecla == K_CTRL_PGDN)
     objBr:goBottom()
   ELSEIF (nTecla == K_RIGHT)
     objBr:right()
   ELSEIF (nTecla == K_LEFT)
     objBr:left()
   ELSEIF (nTecla == K_HOME)
     objBr:home()
   ELSEIF (nTecla == K_END)
     objBr:end()
   ELSEIF (nTecla == K_CTRL_LEFT)
     objBr:panLeft()
   ELSEIF (nTecla == K_CTRL_RIGHT)
     objBr:panRight()
   ELSEIF (nTecla == K_CTRL_HOME)
     objBr:panHome()
   ELSEIF (nTecla == K_CTRL_END)
     objBr:panEnd()
   ELSEIF (nTecla == K_RETURN)
     most_emp()
     objBr:goTop()
     objBr:refreshall()
     exit
   ELSEIF (nTecla == K_ESC)
     exit
   ENDIF
END
set cursor on
restscreen(7,0,19,80,men2)

**********************

Function goTopD()

while (dtentrad=vdtentra) .and. (!bof())
  skip -1
  if !(dtentrad=vdtentra)
    skip
   	exit
  endif
end
return nil

********************

Function goBottomD()

while (dtentrad=vdtentra) .and. (!eof())
  skip
end
skip -1
return nil

*********************

Function Skippe(nSolicitado)
Local nSaltados := 0

if (nSolicitado == 0)
  skip 0
elseif (nSolicitado > 0) .and. (!eof())
  while (nSaltados < nSolicitado)
    skip
    if !(dtentrad=vdtentra) .or. eof()
      skip -1
      exit
    endif
    nSaltados++
  end
elseif (nSolicitado < 0)
  while (nSaltados > nSolicitado)
    skip -1
    if bof()
      exit
    endif
    if !(dtentrad=vdtentra)
      skip
      exit
    endif
    nSaltados--
  end
endif
return nSaltados

*****************************
  
* Fim de Ficheiro.