* TBrowse
* Cargo e modifica‡„o de objectos

#include "Inkey.ch"
#include "Setcurs.ch"

Public objBr, objCol, nTecla 

public dec5, ami_nom, ami_co, ro8, ro9

men := savescreen(7,14,19,69)

locate for codlivro=co_liv

set cursor off
set color to n/w,w+/r

objBr := TBrowseDB(8, 15, 17, 67)
@7,14 to 18,68 double
sombra(7,14,18,68)
objBr:colsep := CHR(032) + CHR(179) + CHR(032)
objBr:headsep := CHR(205) + CHR(209) + CHR(205)

objBr:skipBlock := {|nRegs| Skipper(nRegs)}
objBr:goTopBlock := {| | goTopDb()}
objBr:goBottomBlock := {| | goBottomDb()}

objCol := TBcolumnNew("Destino", {||bibamigo->nome})
objBr:addcolumn(objCol)
objCol := TBColumnNew("Sa¡da", {||bibempre->dtsaid})
objBr:addcolumn(objCol)
objCol := TBColumnNew("Devolu‡„o", {||bibempre->dtentrad})
objBr:addColumn(objCol)

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
     exit
   ELSEIF (nTecla == K_ESC)
     exit
   ELSEIF (nTecla == K_INS)
     set cursor on
     nov_emp()
     set cursor off
     objBr:goTop()
     objBr:refreshAll()
     exit
   ELSEIF (nTecla == K_DEL)
     set cursor on
     ro9=recno()
	 anu=1
	 most_emp()
     set cursor off
     objBr:goTop()
     objBr:refreshAll()
     exit
   ENDIF
END
set cursor on
if anu2=1
  restscreen(7,14,19,69,men)
  return
else
  restscreen(7,14,19,69,men)
endif

**********************

Function goTopDb()

while (codlivro=co_liv) .and. (!bof())
  skip -1
  if !(codlivro=co_liv)
    skip
   	exit
  endif
end
return nil

********************

Function goBottomDb()

while (codlivro=co_liv) .and. (!eof())
  skip
end
skip -1
return nil

*********************

Function Skipper(nSolicitado)
Local nSaltados := 0

if (nSolicitado == 0)
  skip 0
elseif (nSolicitado > 0) .and. (!eof())
  while (nSaltados < nSolicitado)
    skip
    if !(codlivro=co_liv) .or. eof()
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
    if !(codlivro=co_liv)
      skip
      exit
    endif
    nSaltados--
  end
endif
return nSaltados

*****************************
  
procedure most_emp

#define AL_CANCEL 1
#define AL_CONT   2

a := savescreen(0,0,24,79)

select 1
set index to livros
select 6
set relation to codlivro into livros

do while .t.
  set color to w+/b,n/w
  @10,5 clear to 20,75
  @10,5 to 20,75
  sombra(10,5,20,75)
  @12,7 say "       T¡tulo: "
  set color to n/w	
  @12,22 say livros->titulo
  select 5
  set index to bibamigo
  select 6
  set relation to codamigo into bibamigo
  set color to w+/b
  @14,7 say "Nome do Amigo: "	
  set color to n/w
  @14,22 say bibamigo->nome
  set color to w+/b
  @16,7 say "Emprestado em: "	
  set color to n/w
  @16,22 say dtoc(dtsaid)
  set color to w+/b
  @18,7 say " Devolvido em: "
  set color to n/w	
  @18,22 say dtoc(dtentrad)
  set color to w+/r,w+/b
  @20,20 clear to 22,60
  @20,20 to 22,60
  sombra(20,20,22,60)
  if anu=1
    @21,24 prompt "Desistir"
    @21,42 prompt "Anular Registo"
    menu to qe
    do case
      case qe=1
        exit
      case qe=2
        anu2=1
        delete
        pack
        index on codlivro to bibempre
        index on codamigo to emp_ami
        set index to bibempre
        if reccount()=0
          opcoes := {"N„o","Sim"}
          escolha := ALERT("N„o existem empr‚stimos deste livro!;Deseja criar um?",opcoes)
          do case 
            case escolha == AL_CANCEL
              exit
            case escolha == AL_CONT
              nov_emp()
              exit
            otherwise
              exit
          endcase
        endif  
        exit
      otherwise
        exit
    endcase
  endif
  @21,23 prompt "Terminar Consulta"
  @21,49 prompt "Alterar"
  menu to vai
  do case
    case vai=1
      exit
    case vai=2
      emp_al()
    otherwise
      exit
  endcase 
  exit
enddo
anu=0
anu2=0
if anu2=1
  restscreen(0,0,24,79,a)
  return
else
  restscreen(0,0,24,79,a) 
endif

********************************

procedure emp_al

t := savescreen(0,0,24,79)

do while .t.

  set color to n/w
  select 5
  set index to nom_ami
  tb_amigo()
  @14,22 say dec5
  select 6
  set color to w+/b,n/w
  @16,22 get dtsaid
  @18,22 get dtentrad
  read
  set color to w+/r,w+/b
  @20,15 clear to 22,65
  @20,15 to 22,65
  sombra(20,25,22,65)
  @21,18 prompt "Gravar"
  @21,36 prompt "Corrigir"
  @21,55 prompt "Desistir"
  menu to qi
  do case
    case qi=1
      replace codamigo with ami_co
      replace dtsaid with dtsaid
      replace dtentrad with dtentrad
      exit
    case qi=2
      loop
    case qi=3
      exit
    otherwise
      exit
  endcase
enddo
restscreen(0,0,24,79,t)

****************************
 
* Fim de Ficheiro.