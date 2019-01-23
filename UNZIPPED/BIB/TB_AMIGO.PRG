* TBrowse
* Cargo e modifica‡„o de objectos

#include "Inkey.ch"
#include "Setcurs.ch"

Public objBr, objCol, nTecla 

public dec5, ami_nom, ami_co, ro8, ro9

man := savescreen(7,14,19,44)

set cursor off
set color to n/w,w+/r

objBr := TBrowseDB(8, 15, 17, 42)
@7,14 to 18,43 double
sombra(7,14,18,43)
objBr:colsep := CHR(032) + CHR(179) + CHR(032)
objBr:headsep := CHR(205) + CHR(209) + CHR(205)

objCol := TBcolumnNew(" Nome do Amigo", {||bibamigo->nome})
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
     dec5=nome
     ami_co=codamigo
     exit
   ELSEIF (nTecla == K_INS)
     set cursor on
     nov_ami()
     set cursor off
     objBr:goTop()
     objBr:refreshall()
   ELSEIF (nTecla == K_F10)
     ro8=recno()
     set cursor on
     ami_co=codamigo
     dec5=nome
     mod_amig()
     set cursor off
     objBr:goTop()
     objBr:refreshAll()
   ELSEIF (nTecla == K_DEL)
     set cursor on
     ro9=recno()
     ami_co=codamigo
     anu_ami()
     set cursor off
     objBr:goTop()
     objBr:refreshAll()
   ENDIF
END
set cursor on
restscreen(7,14,19,44,man)
     
**********************

Procedure mod_amig

m := savescreen(10,18,21,63)

set color to w+/b,n/w
@10,18 clear to 20,62
@10,18 to 20,62
sombra(10,18,20,62)
set color to n/g
@10,36 say " Amigos "
set color to w+/b,n/g
goto ro8
set color to w+/b,n/w
@12,20 say "     Nome: " get nome
@14,20 say "   Morada: " get morada
@16,20 say "C. Postal: " get codpost
@18,20 say " Telefone: " get telef
read
replace nome with nome
replace morada with morada
replace codpost with codpost
replace telef with telef
index on nome to mom_ami
set index to nom_ami
set color to n/w,w+/r
restscreen(10,18,21,63,m)

*****************************

procedure anu_ami

#define AL_CANCEL 1

set exact on
g := savescreen(20,23,23,51)
opcoes := {"Ok"}

do while .t.

  select 6
  locate for codamigo=ami_co
  if found()
    escolha := ALERT("Este registo est  a ser utilizado como referˆncia para;outros ficheiros e n„o pode ser eliminado",;
                      opcoes)
    do case
      case escolha == AL_CANCEL
        exit
      otherwise
        exit
    endcase
  else
    select 5
    set index to nom_ami
    set color to w+/r,w+/b
    @20,23 clear to 22,50
    @20,23 to 22,50
    sombra(20,23,22,50)
    @21,25 prompt "Eliminar"
    @21,40 prompt "Desistir"
    menu to es
    do case 
      case es=1
        goto ro9
        delete
        pack
        index on nome to nom_ami
        set index to nom_ami
        exit
      case es=2
        exit
    endcase
  endif
  exit
enddo
set exact off
select 5
set index to nom_ami
set color to n/w,w+/r
restscreen(20,23,23,51,g)

***********************

* Fim de Ficheiro.
