**********************************************
* BIB.PRG
* Menu Principal
* 21/10/93
* Isildo Mendes 1993
**********************************************

#include "setcurs.ch"

Public mt[2]
public je, anu, anu2
mt[1]=savescreen(0,0,24,39)
mt[2]=savescreen(0,40,24,79)

je=0
anu=0
anu2=0

SET WRAP ON
SET MESSAGE TO 22
SET SCOREBOARD OFF
SET KEY 28 TO ajuda
SET CURSOR OFF

set color to n/bg
clear
set color to n/w
@20,48 to 22,76
sombra(20,48,22,76)
@21,49 say "Pressione qualquer tecla..."
fole()

set color to w+/b
clear
@1,15 to 5,65 double
sombra(1,15,5,65)
set color to gr+/b
@2,19 say "            Isildo Mendes 1994"
set color to w+/b
@3,15 say "Ç"
@3,16 to 3,64
@3,65 say "¶"
set color to bg+/b
@4,19 say "    BIBGEST - Gest„o de Biblioteca Pessoal"
set color to w+/r
@8,34 say " Vers„o 5.0 "


indseg()
select 1
use livros
select 2
use bibautor
select 3
use bibtema
select 4
use bibedito
select 5
use bibamigo
select 6
use bibempre
select 7
use bibmem
goto 1
if data="BRITISH"
  set date to british
else
  set date to ANSI
endif


   set color to w/b
   clear
   @0,0 TO 3,79
   set color to bg+/b
   @1,10 say "B I B G E S T  v5.0"
   @2,6 say "Gest„o de Biblioteca Pessoal"
   set color to gr+/b
   @1,46 SAY "N£mero de S‚rie: "
   @1,63 say "SPOOLER"
   @2,47 SAY "   Isildo Mendes 1994"
   set color to w/b
   @0,37 say "Â"
   @1,37 say "³"
   @2,37 say "³"
   @3,37 say "Á"
   @3,25 say "Â"
   for i=4 to 22
     @i,25 say "³"
   next
   set color to w+/b
   @4,26 clear to 22,79
   for i=4 to 22
     @i,26 say replicate(chr(177),55)
   next
   set color to w+/b
   @8, 34 say "                                        "
   @9, 34 say "    ÛßßÜ Û ÛßßÜ Ûßßß Ûßßß Ûßßß ßßÛßß    "                                           
   @10,34 say "    ÛÜÜß Û ÛÜÜß Û ÜÜ ÛÜÜ  ÛÜÜÜ   Û      "  
   @11,34 say "    Û  Û Û Û  Û Û  Û Û       Û   Û      "
   @12,34 say "    ßßß  ß ßßß  ßßßß ßßßß ßßßß   ß      "
   @13,34 say "                                        "
   @14,34 say "      Gest„o de Biblioteca Pessoal      "
   @15,34 say "                                        "
   set color to gr+/b
   @16,34 say "              Vers„o 5.00               "
   @17,34 say "                                        "
   sombra(8,34,17,73)
   set color to w/b
   @23,0 to 23,79 double
   @23,25 say "Ï"
   set color to w+/b
   @24,2 say "Seleccione com "+chr(27)+" "+chr(26)+" "+chr(24)+" "+chr(25) +;
             " e prima <ENTER>"
   @24,65 SAY "Esc = Termina"
   DO MENU

***************************************************
PROCEDURE MENU

store 1 to nivel,nivel1,nivel2,nivel3,nivel4

DO WHILE .T.
   set color to BG+/RB
   @4,3 to 6,20 double
   @5,4 say " MENU PRINCIPAL "
   sombra(4,3,6,20)
   set color to n/w
   @9,3 to 21,20
   sombra(9,3,21,20)
   risco = "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
   set color to n/w,bg+/b
   @10,4 PROMPT "   Livros       "
   @11,3 say risco
   @12,4 PROMPT "   Listagens    "
   @13,3 say risco
   @14,4 PROMPT "   Empr‚stimos  "
   @15,3 say risco
   @16,4 PROMPT "   Utilit rios  "
   @17,3 say risco
   set color to gr+/b
   @19,4 say    "   F1 = Ajuda   "
   set color to n/w,bg+/b
   MENU TO choic
   z := savescreen(0,0,24,79)

   do case
     case choic=0
       alerta()
     case choic=1
       menu1()
     case choic=2
       menu2()
     case choic=3
       menu3()
     case choic=4
       menu4()
   endcase
   restscreen(0,0,24,79,z)
ENDDO

*****************************

procedure menu1

public varia

SET COLOR TO n/w,bg+/b

do while .t.

   @ 10,19,14,40 BOX "ÖÄ¿³¾ÍÈº"
   sombra(10,19,14,40)
   @ 11,20 CLEAR TO 13,39									  
   @ 11,20 PROMPT " Novos Registos     "
   @ 12,20 PROMPT " Anular Registos    "  
   @ 13,20 PROMPT " Consultar Registos "
   MENU TO nivel1
   k := savescreen(0,0,24,79)

   do case
      case nivel1=1
         novos()
      case nivel1=2
         varia=0
         anula()
      case nivel1=3
         varia=1
         anula()
	  case nivel1=0
 		 exit
   endcase
   restscreen(0,0,24,79,k)
enddo

***********************************************

procedure menu2

set color to n/w,bg+/b
public va

do while .t.

   @ 12,19,17,32 BOX "ÖÄ¿³¾ÍÈº"
   sombra(12,19,17,32)
   @ 13,20 CLEAR TO 16,31
   @ 13,20 PROMPT " Por T¡tulo " 
   @ 14,20 PROMPT " Por Autor  " 
   @ 15,20 PROMPT " Por Tema   " 
   @ 16,20 PROMPT " Por Editor "
   MENU TO nivel2
   s := savescreen(0,0,24,79)

   do case

      case nivel2=1
         va=2
	     imp()
      case nivel2=2
         va=3
	     imp()
      case nivel2=3
         va=4
	     imp()
      case nivel2=4
         va=5
         imp()
      case nivel2=0
         exit
	  otherwise
         exit
   endcase
   restscreen(0,0,24,79,s)
enddo

*****************************************

procedure imp

public imp2

do while .t.

  @13,31,16,51 box "ÖÄ¿³¾ÍÈº"
  sombra(13,31,16,51)
  @14,32 clear to 15,50
  @14,32 prompt " Para o Ecr„       "
  @15,32 prompt " Para a Impressora "
  menu to imp1
  q := savescreen(0,0,24,79)

  do case 
    case imp1=1
      imp2=1
      lista()
    case imp1=2
      imp2=0
      lista()
    otherwise
      exit
  endcase
  restscreen(0,0,24,79,q)
enddo

*********************************
  
procedure menu3

public je

set color to n/w,bg+/b

do while .t.

   @ 14,19,18,45 BOX "ÖÄ¿³¾ÍÈº"
   sombra(14,19,18,45)
   @ 15,20 CLEAR TO 17,44
   @ 15,20 PROMPT " Registos de Empr‚stimos " 
   @ 16,20 PROMPT " Livros n„o Devolvidos   "
   @ 17,20 PROMPT " Listagem de Empr‚stimos "
   MENU TO nivel3
   si := savescreen(0,0,24,79)

   do case
	 case nivel3 = 1
        je=1
        select 1
        if reccount()=0
          naoha()
          exit
        endif
        set index to li_titul
        tb_livro()
        anu2=0
     case nivel3 = 2
        nao_dev()
     case nivel3 = 3
        liemp()
 	 case nivel3 = 0
        exit
  endcase
  restscreen(0,0,24,79,si)  
enddo
je=0
return

***************************************

procedure menu4

s := savescreen(0,0,24,79)
set color to n/w,bg+/b

do while .t.

   @ 16,19,22,37 BOX "ÖÄ¿³¾ÍÈº"
   sombra(16,19,22,37)
   @ 17,20 CLEAR TO 21,36
   @ 17,20 PROMPT " Seguran‡as      " 
   @ 18,20 PROMPT " Reindexa‡„o     " 
   @ 19,20 PROMPT " Formato da Data "
   @ 20,20 PROMPT " Informa‡”es     " 
   @ 21,20 PROMPT " Copyright       " 
   menu TO nivel4

   do case
      case nivel4=1
           copias()
      case nivel4=2
           indseg()
      case nivel4=3
           fo_data()
      case nivel4=4
           livre()
      case nivel4=5
           copyr()
      case nivel4=0
           exit
   endcase

enddo
restscreen(0,0,24,79,s)
return

***************************************

procedure liemp

public pr

do while .t.

  pr=0
  @18,42,21,71 box "ÖÄ¿³¾ÍÈº"
  sombra(18,42,21,71)
  @19,43 clear to 20,70
  @19,43 prompt " Para um Destino            "
  @20,43 prompt " N„o Devolvidos por Destino "
  menu to ia
  tu := savescreen(0,0,24,79)
  do case
    case ia=1
	  imp2()
    case ia=2
      pr=1
      imp2()
    otherwise
      exit
  endcase
  restscreen(0,0,24,79,tu)
enddo
    
**************************************************

procedure imp2

public imp

do while .t.

  imp=0
  @19,55,22,75 box "ÖÄ¿³¾ÍÈº"
  sombra(19,55,22,75)
  @20,56 clear to 21,74
  @20,56 prompt " Para o Ecr„       "
  @21,56 prompt " Para a Impressora "
  menu to lixo
  di := savescreen(0,0,24,79)
  do case
    case lixo=1
      if pr=0 
        list_emp()
      else
        pr=1
        li_emp()
      endif
    case lixo=2
	  imp=1
      if pr=0
        list_emp()
      else
        pr=1
        li_emp()
      endif
    otherwise
      exit
  endcase
  restscreen(0,0,24,79,di)
enddo

***************************************

procedure alerta

#define AL_SAVE    1
#define AL_CANCEL  2
#define AL_CONT    3

opcoes := {"Continuar", "Sair"}

escolha := ALERT("Deseja Sair para o DOS ?", opcoes)

do case
  case escolha == AL_CANCEL
     set color to w/n
     close databases
	 clear
     quit
  case escolha == AL_CONT
     return
  otherwise
     return
endcase

************************************************

procedure copyr

e := savescreen(8,10,19,71)

set color to n/bg
@8,10 clear to 18,70
@8,10 to 18,70
sombra(8,10,18,70)

@10,21 say "BIBGEST - Gest„o de Biblioteca Pessoal"
set color to r/bg
@11,20 say "           Isildo Mendes 1994"
set color to n/bg
@13,20 say "Este programa foi desenvolvido para todos"
@14,20 say "os utilizadores de PC's em Portugal."
set color to gr/bg
@16,12 say "Este programa pode ser copiado e distribu¡do livremente." 
inkey(0)
set color to n/w,bg+/b
restscreen(8,10,19,71,e)

****************************************************************

procedure livre

q := savescreen(8,10,19,71)

esp = diskspace()

set color to n/w
@8,10 clear to 18,70
@8,10 to 18,70
sombra(8,10,18,70)

@10,15 say "Espa‡o Livre no Disco R¡gido: "
set color to r/w
@10,45 say esp pict "###,###,###"
set color to n/w
@10,58 say "bytes"
@12,15 say " Vers„o do Sistema Operativo: "
ms = os()
set color to r/w
@12,45 say ms
set color to n/w
dat = date()
@14,15 say "             Data do Sistema: "
set color to r/w
@14,45 say dat
set color to n/w
hor = time()
@16,15 say "             Hora do Sistema: " 
set color to r/w
@16,45 say hor pict "##:##,##"
inkey(0)
set color to n/w,bg+/b
restscreen(8,10,19,71,q)

*********************************************

procedure ajuda

n := savescreen(3,6,24,76)

set color to n/g
@3,6 clear to 23,75
@3,6 to 23,75
sombra(3,6,23,75)

@4, 8 say "Mapa de Ajuda ao Utilizador                            P g. 1 de 1"
@6, 8 say " Este programa foi elaborado tendo em aten‡„o o f cil manuseamento"
@7, 8 say "por parte  de qualquer  utilizador. Deste modo, o programa ‚ muito"
@8, 8 say "f cil de usar, n„o  existindo qualque dificuldade de maior. Assim,"
@9, 8 say "as teclas que ser„o mais  usadas s„o as setas do cursor, <ENTER> e"
@10,8 say "<ESC>. As setas do cursor servem para o utilizador se deslocar nos"
@11,8 say "menus, <ENTER> para  escolher uma op‡„o, e <ESC> para voltar atr s"
@12,8 say "e para sair do programa. Existem outras teclas tamb‚m muito usadas"
@13,8 say "mas que o programa chama a aten‡„o sempre que forem necess rias:  "
@14,8 say "Ins - Insere registos (Autores, Editores, Temas)                  "
@15,8 say "Del - Elinima registos (Autores, Editores, Temas)                 "
@16,8 say "F10 - Modifica registos (Autores, Editore, Temas)                 "
@18,8 say "Quando fizer altera‡”es nos ficheiros de dados, n„o se esque‡a  de"
@19,8 say "escolher a op‡„o ®Reindexa‡„o¯ para nova indexa‡„o."
@20,8 say "Ao inserir os dados verifique se estes est„o correctos."
@22,8 say "Pressione qualquer tecla para sair..."
inkey(0)
restscreen(3,6,24,76,n)
set color to n/w,bg+/b

*************************************************************

procedure fo_data

a := savescreen(0,0,24,79)

set color to n/w,bg+/b

do while .t.
 
  select 7
  goto 1
  @19,35,22,65 BOX "ÖÄ¿³¾ÍÈº"
  sombra(19,35,22,65)
  @20,36 clear to 21,64
  @20,36 prompt " Formato Nacional (dd/mm/aa) "
  @21,36 prompt " Formato ANSI     (yy.mm.dd) "
  menu to dt
  do case
    case dt=1
      replace data with "BRITISH"
      set date to british
      exit
    case dt=2
      replace data with "ANSI   "
      set date to ansi
      exit
    otherwise
      exit
  endcase
enddo
restscreen(0,0,24,79,a)

*****************************
* Fim de ficheiro.