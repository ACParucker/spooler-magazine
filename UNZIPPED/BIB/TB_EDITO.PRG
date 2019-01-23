* TBrowse
* Cargo e modifica‡„o de objectos

#include "Inkey.ch"
#include "Setcurs.ch"

Public objBr, objCol, nTecla 

public dec2, edi_co, edi_dec, ro, ro2

men2 := savescreen(7,14,19,48)

set cursor off
set color to n/w,w+/r

objBr := TBrowseDB(8, 15, 17, 46)
@7,14 to 18,47 double
sombra(7,14,18,47)
objBr:colsep := CHR(032) + CHR(179) + CHR(032)
objBr:headsep := CHR(205) + CHR(209) + CHR(205)

objCol := TBcolumnNew(" Editores", {||bibedito->descric})
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
     dec2=descric
     edi_co=codedito
     exit
   ELSEIF (nTecla == K_INS)
     set cursor on
     inse_edi()
     set cursor off
     objCol := TBColumnNew(" Editores",{||bibedito->descric})
     objBr:addColumn(objCol)
     objBr:refreshall()
   ELSEIF (nTecla == K_F10)
     ro=recno()
     set cursor on
     edi_co=codedito
     edi_dec=descric
     mod_edi()
     set cursor off
     *objCol := TBColumnNew(" Autores",{||bibautor->descric})
     *objBr:addColumn(objCol)
     objBr:goTop()
     objBr:refreshAll()
   ELSEIF (nTecla == K_DEL)
     set cursor on
     ro2=recno()
     edi_co=codedito
     anu_edi()
     set cursor off
     objBr:goTop()
     objBr:refreshAll()
   ENDIF
END
set cursor on
restscreen(7,14,19,48,men2)
     
**********************

Procedure mod_edi

m := savescreen(10,18,16,63)

select 1
count to vobra1 for codedito=edi_co
set color to w+/b,n/w
@10,18 clear to 15,62
@10,18 to 15,62
sombra(10,18,15,62)
set color to n/g
@10,35 say " Editores "
set color to w+/b,n/g
select 4
set index to edi_desc
goto ro
set color to w+/b,n/w
@12,20 say "Nome: " get edi_dec
@14,20 say "Obras: "
set color to n/w
@14,27 say vobra1 pict "####"
read
replace descric with edi_dec
index on descric to edi_desc
set index to edi_desc
set color to n/w,w+/r
restscreen(10,18,16,63,m)

*****************************

procedure anu_edi

#define AL_CANCEL 1

set exact on
g := savescreen(20,23,23,51)
opcoes := {"Ok"}

do while .t.

  select 1
  locate for codedito=edi_co
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
    select 4
    set index to edi_desc
    set color to w+/r,w+/b
    @20,23 clear to 22,50
    @20,23 to 22,50
    sombra(20,23,22,50)
    @21,25 prompt "Eliminar"
    @21,40 prompt "Desistir"
    menu to es
    do case 
      case es=1
        goto ro2
        delete
        pack
        index on descric to edi_desc
        set index to edi_desc
        exit
      case es=2
        exit
    endcase
  endif
  exit
enddo
set exact off
select 4
set index to edi_desc
set color to n/w,w+/r
restscreen(20,23,23,51,g)

***********************

* Fim de Ficheiro.
