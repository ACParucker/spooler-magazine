**********************************
* NOVOS.PRG
* Manuten‡„o da Tabela de livros
* 7 de Fevereiro de 1994
**********************************

#define AL_CANCEL  1
#define AL_CONT    2 

Public fi, c

select 1
set index to livros
go bottom
vcod=codlivro + 1
vtit=space(50)
vedc=0
vloc_ed=space(20)
vano_ed=year(date())
vedi=0
vpags=0
vdtcompra=date()
vpreco=0
vobs1=space(70)
vobs2=space(70)
vobs3=space(70)

d := savescreen(0,0,24,79)
set color to w+/b,n/w
@2,2 clear to 22,77
@2,2 to 22,77
@24,1 say space(77)
@24,1 say "Insira os dados e pressione <ENTER> no fim."
sombra(2,2,22,77)
set color to n/g
@2,33 say " Novos Livros "
desiste=0

do while .t.
  set cursor on
  set color to gr+/b,n/w
  @4,4 say "C¢digo do Livro: "
  @4,21 say vcod
  @6,4 say "T¡tulo: " get vtit
  read
  if desiste=0
    @8,15 say "Pressione <ENTER> para Desistir."
    if vtit=space(50)
      set cursor off
      set color to n/w,bg+/b
      savescreen(0,0,24,79,d)
      return
    endif
  endif
  @8,15 clear to 16,65
  locate for titulo=vtit
  if found()
    opcoes := {"Repetir","Continuar"}
    escolha := ALERT("T¡tulo j  Existente!",opcoes)
    do case
      case escolha == AL_CANCEL
        loop
      case escolha == AL_CONT
        *exit
        segue()
      otherwise
        exit
    endcase
  endif
  @8,4 say "Autor: "
  select 2
  if reccount()=0
    fi=1
    vazio()
  endif
  set color to w+/r
  @24,1 say space(78)
  @24,2 say "Ins=Insere"
  @24,20 say "Del=Apaga"
  @24,37 say "F10=Altera"
  @24,59 say "Enter=Escolhe Op‡„o"
  set index to aut_desc
  tb_aut()
  set color to n/w
  @8,11 say dec
  set color to gr+/b
  @10,4 say "Editor: "
  select 4
  if reccount() = 0
    fi=2
    vazio()
  endif
  set index to edi_desc
  tb_edito()
  set color to n/w
  @10,12 say dec2
  select 3
  set color to gr+/b
  @12,4 say "Tema: "
  if reccount() = 0
    fi=3
    vazio()
  endif
  set index to tem_desc
  tb_tema()
  set color to n/w
  @12,10 say dec3
  set color to w+/b
  @24,1 say space(78)
  @24,2 say "Insira os dados e pressione <ENTER> no fim."
  set color to gr+/b,n/w
  @14,4 say "Edi‡„o: " get vedi pict "##"
  @14,20 say "Local: " get vloc_ed
  @14,53 say "Ano da Edi‡„o: " get vano_ed pict "####"
  @16,4 say "Data da Compra: " get vdtcompra
  @16,32 say "Pre‡o: " get vpreco pict "###,###.##"
  @16,53 say "N§ de P ginas: " get vpags pict "####"
  @18,4 say "Observa‡”es:"
  @19,4 get vobs1
  @20,4 get vobs2
  @21,4 get vobs3
  read
  set color to w+/r,w+/b
  di := savescreen(20,15,23,66)
  @20,15 clear to 22,65
  @20,15 to 22,65
  sombra(20,15,22,65)
  @21,18 prompt "Gravar"
  @21,36 prompt "Corrigir"
  @21,55 prompt "Desistir"
  menu to ri
  do case
    case ri=1
      select 1
      append blank
      replace codlivro with vcod
      replace titulo with vtit
      replace codautor with aut_co
      replace codedito with edi_co
      replace codtema with tema_co
      replace local_ed with vloc_ed
      replace ano_ed with vano_ed
      replace edicao with vedi
      replace dtcompra with vdtcompra
      replace preco with vpreco
      replace pags with vpags
      replace obs1 with vobs1
      replace obs2 with vobs2
      replace obs3 with vobs3
      index on codlivro to livros
      index on titulo to li_titul
      exit
    case ri=2
      select 1
      restscreen(20,15,23,66,di)
      desiste=1
      loop
    case ri=3
      exit
  endcase
  exit
enddo
set color to n/w,bg+/b
set cursor off
restscreen(0,0,24,79,d)

*****************************

procedure vazio

public nome_fi, co

f := savescreen(0,0,24,79)

if fi=1
  nome_fi="Autores"
endif
if fi=2
  nome_fi="Editores"
endif
if fi=3
  nome_fi="Temas"
endif

set color to w+/r
@10,19 clear to 16,61
@10,19 to 16,61
sombra(10,19,16,61)
@12,23 say "O ficheiro de "+ nome_fi + " est  vazio!"
@13,21 say "Prima uma tecla para inserir os dados..."
set color to w+/b
@15,38 say "Ok"
inkey(0)
@10,19 clear to 17,62
if fi=1
  inse_aut()
endif
if fi=2
  inse_edi()
endif
if fi=3
  inse_tem()
endif
set color to n/w,w+/r
restscreen(0,0,24,79,f)

********************************************

procedure inse_aut

select 2
set index to
g := savescreen(0,0,24,79)

go bottom
vcodigo=codautor+1
vnom=space(30)
set color to w+/b,n/w
@10,18 clear to 14,62
@10,18 to 14,62
sombra(10,18,14,62)
set color to n/g
@10,35 say " Autores "
set color to w+/b,n/w
@12,20 say "Nome: " get vnom
read
append blank
replace codautor with vcodigo
replace descric with vnom
index on codautor to bibautor
index on descric to aut_desc
set index to aut_desc
set color to n/w,w+/r
restscreen(0,0,24,79,g)


***************************

procedure inse_edi

h := savescreen(0,0,24,79)
select 4
set index to

go bottom
vc=codedito+1
vnom=space(30)
set color to w+/b,n/w
@10,18 clear to 14,62
@10,18 to 14,62
sombra(10,18,14,62)
set color to n/g
@10,35 say " Editores "
set color to w+/b,n/w
@12,20 say "Nome: " get vnom
read
append blank
replace codedito with vc
replace descric with vnom
index on codedito to bibedito
index on descric to edi_desc
set index to edi_desc
set color to n/w,w+/r
restscreen(0,0,24,79,h)

********************************

procedure inse_tem

j := savescreen(0,0,24,79)
select 3
set index to

go bottom
vcodi=codtema+1
vnom=space(30)
set color to w+/b,n/w
@10,18 clear to 14,62
@10,18 to 14,62
sombra(10,18,14,62)
set color to n/g
@10,35 say " Temas "
set color to w+/b,n/w
@12,20 say "Tema: " get vnom
read
append blank
replace codtema with vcodi
replace descric with vnom
index on codtema to bibtema
index on descric to tem_desc
set index to tem_desc
set color to n/w,w+/r
restscreen(0,0,24,79,j)

**************************

procedure anula

c := savescreen(0,0,24,79)
select 2
set index to bibautor
select 3
set index to bibtema
select 4
set index to bibedito

select 1
set index to li_titul

do while .t.
  if reccount()=0
    set color to w+/r
    @10,19 clear to 14,61
    @10,19 to 14,61
    sombra(10,19,14,61)
    @11,25 say "O Ficheiro de Livros est  Vazio!"
    set color to w+/b
    @13,39 say "Ok"
    inkey(0)
    @10,19 clear to 17,62
    exit
  else
    tb_livro()
    exit
  endif
enddo
set color to n/w,bg+/b
restscreen(0,0,24,79,c)

*****************************

procedure mostra()

local es
Public cec

cec := savescreen(0,0,24,79)

set color to w+/b,n/w
@2,2 clear to 22,77
@2,2 to 23,77 
sombra(2,2,23,77)
set color to n/g
if varia=0
  @2,33 say " Anular Livros "
else
  @2,30 say " Consultar Livros "
endif

do while .t.
  set color to gr+/b,n/w
  @4,4 say "C¢digo do Livro: " + str(codlivro)
  @6,4 say "T¡tulo: " 
  set color to n/w
  @6,12 say titulo
  select 1
  *set index to li_autor
  set relation to codautor into bibautor
  set color to gr+/b
  @8,4 say "Autor: "
  set color to n/w 
  @8,11 say bibautor->descric
  select 1
  *set index to li_edito
  set relation to codedito into bibedito
  set color to gr+/b
  @10,4 say "Editor: " 
  set color to n/w
  @10,12 say bibedito->descric
  select 1
  *set index to li_tema
  set relation to codtema into bibtema
  set color to gr+/b
  @12,4 say "Tema:" 
  set color to n/w
  @12,10 say bibtema->descric
  set color to gr+/b
  @14,4 say "Edi‡„o: "
  set color to n/w
  @14,12 say edicao
  set color to gr+/b
  @14,20 say "Local: " 
  set color to n/w
  @14,27 say local_ed
  set color to gr+/b
  @14,53 say "Ano da Edi‡„o: " 
  set color to n/w
  @14,68 say ano_ed
  set color to gr+/b
  @16,4 say "Data da Compra: " 
  set color to n/w
  @16,20 say dtcompra
  set color to gr+/b
  @16,32 say "Pre‡o: " 
  set color to n/w
  @16,39 say preco 
  set color to gr+/b
  @16,53 say "N§ de P ginas: " 
  set color to n/w
  @16,68 say pags
  set color to gr+/b
  @18,4 say "Oberva‡”es:"
  set color to n/w
  @19,4 say obs1
  @20,4 say obs2
  @21,4 say obs3
  if varia=0
    set color to w+/r,w+/b
    @19,20 clear to 23,58
    @19,20 to 23,58
    sombra(19,20,23,58)
    @20,24 say "Confirma a Anula‡„o deste Livro?"
    @22,29 prompt "Confirma"			 
    @22,43 prompt "Desiste"
    menu to es
    do case 
      case es = 1
        delete
        pack
        index on codlivro to livros
        index on titulo to li_titul
        set index to li_titul
        if reccount()=0
          set color to w+/r
          @10,19 clear to 16,61
          @10,19 to 16,61
          @12,23 say "O Ficheiro de Livros est  Vazio!"
          set color to w+/b
          @14,38 say "Ok"
          inkey(0)
          exit
        endif
      case es = 2
        exit
      otherwise
        exit
    endcase
  else
    h := savescreen(20,20,23,61)
    set color to w+/r,w+/b
    @20,20 clear to 22,60
    @20,20 to 22,60
    sombra(20,20,22,60)
    @21,25 prompt "Terminar Consulta"
    @21,49 prompt "Alterar"
    menu to moi
    do case 
      case moi=1
        exit
      case moi=2
        restscreen(20,20,23,61,h)
        modi()
        exit
      otherwise
        exit
    endcase
  endif
  exit
enddo
select 1
set index to li_titul
*if varia=1
  restscreen(0,0,24,79,cec)
*  return
*else
*  restscreen(0,0,24,79,cec)
*endif

****************************

procedure modi

set cursor on

*p := savescreen(0,0,24,79)

set color to gr+/b,n/w

do while .t.

  @6,12 get titulo
  read
  select 2
  set index to aut_desc
  set color to w+/r
  @24,1 say space(78)
  @24,2 say "Ins=Insere"
  @24,20 say "Del=Apaga"
  @24,37 say "F10=Altera"
  @24,59 say "Enter=Escolhe Op‡„o"
  tb_aut()
  set color to n/w
  @8,11 say dec
  select 4
  set index to edi_desc
  tb_edito()
  set color to n/w
  @10,12 say dec2
  select 3
  set index to tem_desc
  tb_tema()
  set color to n/w
  @12,10 say dec3
  set color to w+/b
  @24,1 say space(78)
  @24,2 say "Altere os dados que deseja e pressione <ENTER> no fim de cada."
  set color to gr+/b,n/w
  select 1
  @14,12 get edicao
  read
  @14,27 get local_ed
  read
  @14,68 get ano_ed
  read
  @16,20 get dtcompra
  read
  @16,39 get preco pict "##,###.##"
  read
  @16,68 get pags
  read
  @19,4 get obs1
  read
  @20,4 get obs2
  read
  @21,4 get obs3
  read
  t := savescreen(20,15,23,66)
  set color to w+/r,w+/b
  @20,15 clear to 22,65
  @20,15 to 22,65
  sombra(20,15,22,65)
  @21,18 prompt "Desistir"
  @21,37 prompt "Gravar"
  @21,53 prompt "Corrigir"
  menu to y
  do case
    case y=1
      exit
    case y=2
      replace titulo with titulo
      replace codautor with aut_co
      replace codedito with edi_co
      replace codtema with tema_co
      replace local_ed with local_ed
      replace ano_ed with ano_ed
      replace edicao with edicao
      replace dtcompra with dtcompra
      replace preco with preco
      replace pags with pags
      replace obs1 with obs1
      replace obs2 with obs2
      replace obs3 with obs3
      index on codlivro to livros
      index on titulo to li_titul
	  exit
    case y=3
      restscreen(20,15,23,66,t)
      loop
    otherwise
      exit
  endcase
enddo
select 1
set index to li_titul
set cursor off
restscreen(0,0,24,79,cec)
*return

*****************************

procedure segue

return

**************************

* Fim de Ficheiro.