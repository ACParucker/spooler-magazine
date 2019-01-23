#define AL_CANCEL 1
#define AL_CONT   2

public cam

set console off

g := savescreen(0,0,24,79)
set color to w/n
cam3=" "

select 1
if reccount()=0
  naoha()
  return
endif
if va=2
  select 2
  set index to bibautor
  select 1
  set relation to codautor into bibautor
  index on titulo to li_titul
  set index to li_titul
  list titulo,bibautor->descric to file lista.txt off
  cam="T¡tulo"
  cam2="   T¡tulo                                             Autor"
elseif va=3
  select 2
  set index to aut_desc
  tb_aut()
  cam3=dec
  set color to w/n
  select 3
  set index to bibtema
  select 1
  index on titulo to li_titul
  set index to li_titul
  set relation to codtema into bibtema
  list titulo,bibtema->descric to file lista.txt for codautor=aut_co off
  cam="Autor"
  cam2="   T¡tulo                                             Tema"
elseif va=4
  select 3
  set index to tem_desc
  tb_tema()
  cam3=dec3
  set color to w/n
  select 2
  set index to bibautor
  select 1
  index on titulo to li_titul
  set index to li_titul
  set relation to codautor into bibautor
  list titulo,bibautor->descric to file lista.txt for codtema=tema_co off
  cam="Tema"
  cam2="   T¡tulo                                             Autor"
elseif va=5
  select 4
  set index to edi_desc
  tb_edito()
  cam3=dec2
  set color to w/n
  select 2
  set index to bibautor
  select 1
  index on titulo to li_titul
  set index to li_titul
  set relation to codedito into bibedito, codautor into bibautor
  list titulo,bibautor->descric to file lista.txt for codedito=edi_co off
  cam="Editor"
  cam2="   T¡tulo                                             Autor"
endif
set console on

fich="lista.txt"
fic=memoread(fich)

v1="  Isildo Mendes 1994"
v2="Listagem de Livros por " + cam + ": " + cam3
v3=stuff(v1,len(v1)+1,0,replicate(" ",80))
vv3=stuff(v3,len(v3)+1,0,replicate(" ",80))
v4=stuff(vv3,len(vv3)-10,0,v2)
v5=stuff(v4,len(v4)+1,0,replicate(" ",80))
v6=stuff(v5,len(v5)+1,0,replicate("Í",80))
v7=stuff(v6,len(v6)+1,0,replicate(" ",86))
v8=stuff(v7,len(v7)+1,0,cam2)
v9=stuff(v8,len(v8)+1,0,replicate(" ",80))
vv9=stuff(v9,len(v9)+1,0,replicate("Í",80))
v10=stuff(vv9,len(vv9)+1,0,fic)
v11=stuff(v10,len(v10)+1,0,replicate("Í",80))
v12=stuff(v11,len(v11)+1,0,replicate(" ",86))
fim="Impresso em " + dtoc(date())
v13=stuff(v12,len(v12)+1,0,fim)

do while .t.

  if imp2=0
    if .not. isprinter()
      opcoes := {"Sair","Repetir"}
      escolha := ALERT("Impressora n„o Preparada!",opcoes)
      do case
        case escolha == AL_CANCEL
          exit
        case escolha == AL_CONT
          loop
        otherwise
          exit
      endcase
    endif
    set device to print
    set print on
    @prow(),0 say "  Isildo Mendes 1994"
    @prow()+2,0 say "Listagem de Livros por " + cam + ": " + cam3
    @prow()+2,0 say replicate("Í",79)
    @prow()+2,0 say	cam2
    @prow()+2,0 say replicate("Í",79)
    no_lines := mlcount(fic,79)
    for i=1 to no_lines
      linha=memoline(fic,79,i)
      @prow()+1,0 say linha
    next
    @prow()+1,0 say replicate("Í",79)
    @prow()+1,0 say "Impresso em " + dtoc(date())
    eject
    set device to screen
    set print off
    exit
  else
    memoedit(v13,3,0,22,79,.f.," ",83)
    exit
  endif
enddo
set color to n/w,bg+/b
restscreen(0,0,24,79,g)

*************************************

procedure list_emp

fi := savescreen(0,0,24,79)


select 1
if reccount()=0
  naoha()
  return
endif
select 5
set index to nom_ami
tb_amigo()
select 1
set index to livros
select 6
set relation to codlivro into livros
set console off
list dtsaid," ",dtentrad,"  ",livros->titulo to file lista.txt for codamigo=ami_co off
ti="Listagem de Livros Emprestados a " + dec5
cab="Emprestado  Devolvido   T¡tulo"
soft="  Isildo Mendes 1994"
rod="Impresso em " + dtoc(date())
set console on
fix="lista.txt"
hand=memoread(fix)

t1=stuff(soft,len(soft)+1,0,replicate(" ",77))
t2=stuff(t1,len(t1)+1,0,replicate(" ",77))
t3=stuff(t2,len(t2)-5,0,ti)
t4=stuff(t3,len(t3)+1,0,replicate(" ",77))
t5=stuff(t4,len(t4)+1,0,replicate("Í",78))
t6=stuff(t5,len(t5)+1,0,replicate(" ",77))
t7=stuff(t6,len(t6)+1,0,cab)
t8=stuff(t7,len(t7)+1,0,replicate(" ",77))
t9=stuff(t8,len(t8)+1,0,replicate("Í",78))
t10=stuff(t9,len(t9)+1,0,hand)
t11=stuff(t10,len(t10)+1,0,replicate("Í",78))
t12=stuff(t11,len(t11)+1,0,replicate(" ",77))
t13=stuff(t12,len(t12)+1,0,rod)

do while .t.

  if imp=0
    set color to w/n
    @3,0 to 23,79
    memoedit(t13,4,1,22,78,.f.," ",78)
    exit
  else
    if .not. isprinter()
      opcoes:={"Sair","Repetir"}
      escolha:=ALERT("Impressora n„o Preparada!",opcoes)
      do case
        case escolha == AL_CANCEL
          exit
        case escolha ==	AL_CONT
          loop
        otherwise
          exit
      endcase
	endif
	set device to print
    set print on
    @prow(),0 say "  Isildo Mendes 1994"
	@prow()+2,0 say "Listagem de Livros Emprestados a " + dec5
    @prow()+2,0 say replicate("Í",79)
    @prow()+2,0 say cab
    @prow()+2,0 say replicate("Í",79)
    linhas=mlcount(hand,79)
    for i=1 to linhas
      li=memoline(linhas,hand,79,i)
      @prow()+1,0 say li
    next
    @prow()+1,0 say replicate("Í",79)
    @prow()+2,0 say "Impresso em " + dtoc(date())
    eject
    set device to screen
    set print off
    exit
  endif
enddo
set color to n/w,bg+/b
restscreen(0,0,24,79,fi)
return

*********************************

procedure li_emp

ti := savescreen(0,0,24,79)
select 1
if reccount()=0
  naoha()
  return
endif
vd=ctod("  /  /  ")
select 1
set index to livros
select 5
set index to bibamigo
select 6
set relation to codlivro into livros,codamigo into bibamigo
set console off
list all livros->titulo,bibamigo->nome to file lista.txt for dtentrad=vd off
set consol on
fl="lista.txt"
fil=memoread(fl)
alto="  Isildo Mendes 1994"
titu="      Listagem de Livros Emprestados"
item="T¡tulo                                             Emprestado a"
the="Impresso em " + dtoc(date())

c1=stuff(alto,len(alto)+1,0,replicate(" ",80))
c2=stuff(c1,len(c1)+1,0,replicate(" ",80))
c3=stuff(c2,len(c2)+1,0,titu)
c4=stuff(c3,len(c3)+1,0,replicate(" ",80))
c5=stuff(c4,len(c4)+1,0,replicate("Í",80))
c6=stuff(c5,len(c5)+1,0,replicate(" ",86))
c7=stuff(c6,len(c6)+1,0,item)
c8=stuff(c7,len(c7)+1,0,replicate(" ",80))
c9=stuff(c8,len(c8)+1,0,replicate("Í",80))
c10=stuff(c9,len(c9)+1,0,fil)
c11=stuff(c10,len(c10)+1,0,replicate("Í",80))
c12=stuff(c11,len(c11)+1,0,replicate(" ",86))
c13=stuff(c12,len(c12)+1,0,the)

do while .t.

  if imp=0
    set color to w/n
    memoedit(c13,3,0,22,79,.f.," ",83)
   	exit
  else
    if .not. isprinter()
      opcoes:={"Sair","Repetir"}
      escolha:=ALERT("Impressora n„o Preparada!",opcoes)
      do case
        case escolha == AL_CANCEL
          exit
        case escolha == AL_CONT
          loop
        otherwise
          exit
      endcase
    endif 
	set device to print
    set print on
    @prow(),0 say "   Isildo Mendes 1994"
    @prow()+2,0 say "Listagem de Livros Emprestados"
    @prow()+2,0 say replicate("Í",79)
    @prow()+2,0 say item
    @prow()+2,0 say replicate("Í",79)
    ln=mlcount(fil,79)
    for i=1 to ln
      l=memoline(fil,79,i)
      @prow()+1,0 say l
    next
    @prow()+1,0 say replicate("Í",79)
    @prow()+1,0 say the
    eject
    set device to screen
    set print off
    exit
  endif
enddo
set color to n/w,bg+/b
restscreen(0,0,24,79,ti)
return

****************************

procedure naoha

jo := savescreen(0,0,24,79)

set color to w+/r
@10,22 clear to 14,59
@10,22 to 14,59
@11,24 say "O Ficheiros de Livros est  Vazio!"
set color to w+/b
@13,39 say "Ok"
inkey(0)
set color to n/w,bg+/b
restscreen(0,0,24,79)

************************