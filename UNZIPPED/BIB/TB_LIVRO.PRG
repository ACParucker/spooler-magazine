* TBrowse
* Cargo e modifica‡„o de objectos

#include "Inkey.ch"
#include "Setcurs.ch"

Public objBr, objCol, nTecla, i, n_liv, co_liv

public dec4
v := savescreen(3,9,22,63)

set cursor off
set color to n/w,w+/r

objBr := TBrowseDB(4, 10, 20, 61)
@3,9 to 21,62 double
sombra(3,9,21,62)
objBr:colsep := CHR(032) + CHR(179) + CHR(032)
objBr:headsep := CHR(205) + CHR(209) + CHR(205)

objCol := TBcolumnNew(" Livros", {||Livros->titulo})
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
     if je=1
       n_liv=titulo
       co_liv=codlivro
       empresti()
       exit
     endif
     mostra()
     objCol := TBColumnNew(" Livros",{||livros->titulo})
     objBr:addColumn(objCol)
     objBr:refreshall()
     if varia=0
       loop
     else
       exit
     endif
   ELSEIF (nTecla == K_ESC)
     exit
   ENDIF
END
restscreen(3,9,22,63,v)
     
**********************

* Fim de Ficheiro.