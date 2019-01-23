#define AL_CANCEL 1
#define AL_CONT	  2

public sai
sai=0

x := savescreen(0,0,24,79)

do while .t.

  select 5
  set index to bibamigo
  select 6
  locate for codlivro=co_liv
  if .not. found()
    opcoes := {"N„o","Sim"}
    escolha := ALERT("N„o existem empr‚stimos deste livro!;Deseja criar um novo?",opcoes)
    do case 
      case escolha == AL_CANCEL
        exit
      case escolha == AL_CONT
        nov_emp()
      otherwise
        exit
     endcase
  endif
  if sai=1
    exit
  endif
  select 5
  set index to bibamigo
  select 6
  set relation to codamigo into bibamigo 
  index on codlivro to bibempre
  set index to bibempre
  set color to w+/r
  @24,1 say space(78)
  @24,2 say "Ins=Novo"
  @24,27 say "Del=Apaga"
  @24,49 say "Enter=Escolhe Op‡„o/Altera"
  tb_empre()
  exit
enddo
set color to n/w,bg+/b
restscreen(0,0,24,79,x)

*******************************

procedure nov_emp

t := savescreen(0,0,24,79)

set cursor on
set color to w+/b,n/w
@10,5 clear to 20,75
@10,5 to 20,75
sombra(10,5,20,75)
dt=date()
dt2=ctod("")

do while .t.
  set color to w+/b
  @12,7 say "       T¡tulo: " 
  set color to n/w
  @12,22 say n_liv 
  set color to w+/b,n/w
  @14,7 say "Nome do Amigo: "
  select 5
  set index to nom_ami
  if reccount()=0
    opcoes := {"N„o","Sim"}
    escolha := ALERT("N„o existem registos de Amigos!;Deseja criar um novo?",opcoes)
    do case
      case escolha == AL_CANCEL
       	exit
      case escolha == AL_CONT
        nov_ami()
      otherwise
        exit
    endcase
  endif
  set cursor off
  set color to w+/r
  @24,1 say space(78)
  @24,2 say "Ins=Novo"
  @24,20 say "Del=Apaga"
  @24,40 say "F10=Altera"
  @24,60 say "Enter=Escolhe Op‡„o"
  set color to n/w,w+/r
  tb_amigo()
  set cursor on
  select 6
  set color to n/w
  @14,22 say dec5
  set color to w+/b,n/w
  dt=date()
  @16,7 say "Emprestado em: "
  @16,22 get dt
  @18,7 say " Devolvido em: "
  @18,22 get dt2 pict "  /  /  "
  read
  set color to w+/r,w+/b
  @20,20 clear to 22,60
  @20,20 to 22,60
  sombra(20,20,22,60)
  @21,24 prompt "Gravar"
  @21,35 prompt "Corrigir"
  @21,49 prompt "Desistir"
  menu to quer
  do case
    case quer=1
      append blank
      replace codlivro with co_liv
      replace codamigo with ami_co
      replace dtsaid with dt
      replace dtentrad with dt2
      index on codlivro to bibempre
      index on codamigo to emp_ami
      set index to bibempre
      exit
  	case quer=2
      loop
    case quer=3
      sai=1
      exit
    otherwise
      sai=1
      exit
  endcase
 exit
enddo
set cursor off
restscreen(0,0,24,79,t)
return

******************************  

procedure nov_ami

f := savescreen(0,0,24,79)

vami=space(25)
vmor=space(25)
vcod_pos=space(25)
vtele=space(10)
set index to
go bottom
vcodami=codamigo+1

do while .t.
  set color to w+/b,n/w
  @10,10 clear to 20,70
  @10,10 to 20,70
  sombra(10,10,20,70)
  set color to n/g
  @10,35 say " Amigos "
  set color to w+/b,n/w
  @12,12 say "Nome do Amigo: " get vami
  @14,12 say "       Morada: " get vmor
  @16,12 say "C¢digo Postal: " get vcod_pos
  @18,12 say "     Telefone: " get vtele
  read
  set color to w+/r,w+/b
  @20,20 clear to 22,60
  @20,20 to 22,60
  sombra(20,20,22,60)
  @21,23 prompt "Gravar"
  @21,35 prompt "Corrigir"
  @21,49 prompt "Desistir"
  menu to tao
  do case
    case tao=1
      append blank
      replace codamigo with vcodami
      replace nome with vami
      replace morada with vmor
      replace codpost with vcod_pos
      replace telef with vtele
      index on codamigo to bibamigo
      index on nome to nom_ami
      set index to nom_ami
      exit
    case tao=2
      loop
    case tao=3
      exit
    otherwise
      exit
  endcase
enddo
restscreen(0,0,24,79,f)
return

*****************************  

procedure nao_dev

po := savescreen(0,0,24,79)

select 1
if reccount()=0
  naoha()
  return
endif
set index to livros
select 5
set index to bibamigo
select 6
index on dtentrad to emp_dat
set index to emp_dat
set relation to codlivro into livros,codamigo into bibamigo
tb_ndev()
set color to n/w,bg+/b
restscreen(0,0,24,79,po)

*****************************
