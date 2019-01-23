* INFOR.PRG

#include "SETCURS.CH"
#include "FILEIO.CH"

PUBLIC imp

SET HEADING OFF			  && Defini‡„o do ambiente.
SET SCOREBOARD OFF
SET BELL OFF
SET CURSOR OFF
SET KEY 28 TO HELP

USE INFOIND
INDEX ON NOME TO TERMOS

set color to r/n
clear
@0,0 to 1,44
@0,45 to 1,79
set color to b/w
@0,2 say " Copyright (c), UTILSOFT - Software  1993 "
@0,47 SAY "         Isildo Mendes         "
set color to r/n
@2,0 to 8,33
@2,34 to 8,79
set color to b/w
@2,9 say " Zona de Menus "
@2,48 say " Zona Secund ria "
set color to w/n
@3,36 say "Teclas"
@4,36 say "Operacionais:"
@4,54 say "RETURN - Aceita Op‡„o."
@5,54 say "CURSOR - Escolhe Op‡„o."
@6,54 say "ESCAPE - Desistir."
set color to w+/n
@7,54 say "F1     - Mapa de Ajuda."
set color to g/n
@9,0 to 24,79
set color to w+/b	
for i = 10 to 23
 @i,1 say replicate(chr(177),78)
next
set color to w+/b

@11,10 say "                                                            "
@12,10 say "                                                            "
@13,10 say "           ÜÜÜÜÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÜÜÜÜ            "                 
@14,10 say "           Û   ßßÛßß ÛÛ  Û Ûßßß ÛßßßÛ ÛßßßÛ    Û            "
@15,10 say "           ³     Û   Û ßÜÛ Ûßß  Û   Û ÛÜÜÜÛ    ³            "
@16,10 say "           ³   ÜÜÛÜÜ Û   Û Û    ÛÜÜÜÛ Û  ßÜ    ³            "
@17,10 say "           ³                                   ³            "                            
@18,10 say "           Û         SPOOLER Magazine          Û            "
@19,10 say "           ÛÜÜÜ_____________________________ÜÜÜÛ            "
@20,10 say "                                                            "
@21,10 say "             Dicion rio de Termos Inform ticos              "
@22,10 say "                                                            "

do while .t.
  
  set color to w+/n,bg+/b
  @3,1 prompt padr(" Consulta ao Dic. de Term. Inf. ",32)
  @4,1 prompt padr(" Consulta e Impress„o de Texto. ",32)
  @5,1 prompt padr(" Manuten‡„o do Dicion rio. ",32)
  @6,1 prompt padr(" Outras Informa‡”es. ",32)
  @7,1 prompt padr(" Sair do Programa para o DOS. ",32)  
 
  menu to escolha

  do case
    case escolha = 1
	  imp = 1
      consulta()
    case escolha = 2
      imp = 2
      consulta()
    case escolha = 3
      manut()
    case escolha = 4
      info()
    case escolha = 5
      exit
  endcase
enddo
set color to w/n
clear
return

**********************

procedure consulta

local menu
menu := savescreen(9,1,23,78)

set color to g/n
@10,1 clear to 23,78

set index to termos
public dat_blk := {| | nome}
rec_find(9,0,24,79,dat_blk)

restscreen(9,1,23,78,menu)
return

**********************

procedure imprime

local mi

mi := savescreen(10,1,23,78)
set color to g/n
@10,1 clear to 23,78
choic2()
restscreen(10,1,23,78,mi)
return

***************************   

procedure manut

local l
l := savescreen(0,0,24,79)

do while .t.

  @3,1 prompt padr(" Inserir Novos Termos. ",32)
  @4,1 prompt padr(" Anular Termos. ",32)
  @5,1 prompt padr(" Indexa‡„o de Ficheiros. ",32)
  @6,1 prompt padr(" C¢pias de Seguran‡a. ",32)
  @7,1 prompt padr(" Voltar ao Menu anterior. ",32)

  menu to opcao
 
  do case 
    case opcao = 1
      insere()
    case opcao = 2
      imp = 3
      consulta()
    case opcao = 3
      indexa()
    case opcao = 4
      copias()
    case opcao = 5
      exit
  endcase

enddo
restscreen(0,0,24,79)
return

***********************

procedure help

local mi

mi := savescreen(1,4,22,76)
set color to n/w
@1,4 clear to 22,76
@1,4 to 22,76
@2,6 say  " Mapa de ajuda ao utilizador ."
@4,6 say  " Este programa acede ao Dicion rio de Termos Inform ticos. "
@5,6 say  " Para tal ‚ necess rio escolher a primeira op‡„o do menu principal."
@6,6 say  " Projecta um ‚cran com as teclas que funcionam na escolha dos items"
@7,6 say  " existentes na lista que de seguida ‚ fornecida, e tamb‚m na visua-"
@8,6 say  " liza‡„o do texto correspondente."
@10,6 say " Basta premir RETURN na linha pretendida. De seguida ‚ mostrado o"
@11,6 say " texto correspondente. Para sair prime-se a tecla ESCAPE. Para a"
@12,6 say " navega‡„o prime-se a setas do cursor. Quando terminar de ler o"
@13,6 say " o texto volatar  a posicionar-se no termo que consultou."
@16,6 say " Se quiser alcan‡ar mais r pido o fim do ficheiro basta premir a"
@17,6 say " tecla [END] para se posicionar no £ltimo registo. Para voltar ao"
@18,6 say " primeiro registo prima a tecla [HOME]." 
@19,6 say " Para visualizar estes ecr„s de ajuda prima a tecla F1."
@21,6 say " ESCAPE - Sair        Outra tecla - P gina seguinte         P g. 1"
inkey(0)
if lastkey() = 27
  restscreen(1,4,22,76,mi)
  set color to w+/n,bg+/b
  return
endif 
@2,5 clear to 21,75
@2,7 say "Mapa de ajuda ao utilizador."
@4,7 say "A segunda op‡„o do menu funciona de maneira idˆntica   primeira,"
@5,7 say "com a diferen‡a de que quando se est  a visualizar o texto e se"
@6,7 say "prime ESCAPE o programa pergunta se deseja imprimir o texto."
@9,7 say "A navega‡„o no texto do tema correspondente faz-se usando as teclas"
@10,7 say "de cursor (tecla NUMLOCK desligada), que movem o texto para cima e"
@11,7 say "para  baixo.  Podem-se tamb‚m usar as  teclas de p gina  para cima"
@12,7 say "[PgUp] e de p gina para baixo [PgDn]."
@14,7 say "A tecla que em todas as ocasi”es provoca a sa¡da ‚ a tecla ESCAPE."
@16,7 say "O texto ‚ apresentado com uma linha demarcadora de in¡cio."
@17,7 say "Identicamente, o final do texto ‚ demarcado com  a mesma linha que"
@18,7 say "se apresenta no in¡cio."
@21,7 say " ESCAPE - Sair       Outra tecla - P gina seguinte          P g. 2"
inkey(0)
if lastkey() = 27
  restscreen(1,4,22,76,mi)
  set color to w+/n,bg+/b
  return
endif
@2,5 clear to 21,75
@2,7 say "Mapa de ajuda ao utilizador."
@4,7 say "A terceira  op‡„o do  menu faz a  manuten‡„o  do ficheiro de dados,"
@5,7 say "ou  seja, o  utilizador  pode  inserir ou apagar termos, efectuar "
@6,7 say "c¢pias de seguran‡a ou indexar o ficheiro de dados. Devido  "
@7,7 say "estrutura do programa, n„o ‚ poss¡vel modificar os significados de"
@8,7 say "cada termo, pois isso iria provocar erros futuros, e mesmo na anula‡„o"
@9,7 say "de termos, o significado dos termos anulados continuar  a existir nos"
@10,7 say "ficheiros de texto (facto que n„o provoca incoveniente algum)."
@11,7 say "Se o utilizador n„o estiver de acordo com qualquer significado ter "
@12,7 say "de primeiro anular o termo e depois voltar a inseri-lo com novo"
@13,7 say "significado (tamb‚m n„o d  assim tanto trabalho!)."
@14,7 say "Para tal basta escolher a op‡„o pretendida no submenu que surge no"
@15,7 say "ecr„."
@16,7 say "Quando o programa lhe pede o nome do ficheiro de texto, e este n„o"
@17,7 say "existir, ‚ criado um novo ficheiro de texto com o nome que inseriu."
@18,7 say "IMPORTANTE: depois de inserir ou anular termos, n„o se esque‡a de"
@19,7 say "ordenar o ficheiro com a op‡„o ®Indexa‡„o do Ficheiro¯."
@21,7 say "Prima qualquer tecla para continuar...                      P g. 3"
inkey(0)
restscreen(1,4,22,76,mi)
set color to w+/n,bg+/b
return

*********************

procedure info

local me

me := savescreen(5,6,19,73)

set color to gr+/b
@5,6 clear to 19,73
@5,6 to 19,73
@6,8 say "Este programa foi desenvolvido por:"
@8,8 say "           Isildo Mendes, UTILSOFT - Software 1993 (c)"
@10,8 say "Para a Revista de Inform tica:"
@12,8 say "               SPOOLER MAGAZINE"
@13,8 say "               Rua Duarte Pacheco Pereira, 69-A"
@14,8 say "               Damaia"
@15,8 say "               2700 Amadora"
@17,8 say "    Este programa pode ser distr¡buido e copiado livremente."
inkey(0)
restscreen(5,6,19,73,me)
return

****************

procedure insere

local t, vnome, vfile, vcomeco, vtermi, cria

t := savescreen(9,1,23,78)
set cursor on
set color to w+/b
@9,25 say "´Inser‡„o de Novos RegistosÃ"
set color to w+/n,bg+/b
do while .t.

  vnome = space(78)
  vfile = space(12)
  vcomeco = 0
  vtermino = 0
  @10,1 clear to 23,78
  @11,5 say "Nome do Termo:            (ENTER para Sair.)"
  @12,1 get vnome picture "@!"
  read
  if vnome = space(78)
    exit
  endif
  seek vnome
  if found()
    @14,5 say "Termo j  existente!"
    @15,5 say "Prima uma tecla..."
    inkey(0)
    @14,5 clear to 15,78
    loop
  endif
  @14,5 say "Nome do ficheiro de texto:   (Ex: TERMOS01.INF, TERMOS02.INF, etc.)"
  @15,5 get vfile pict "@!"
  read
  if vfile = space(12)
    loop
  endif
  t2 = savescreen(10,1,23,78)
  locate for file=vfile
  if .not. found()
    store " " to cria
    @16,5 say "Ficheiro de texto n„o encontrado!"
    @17,5 say "Criar novo ficheiro? (S/N): " get cria pict "!"
	read
	if cria = "N"
      exit
    endif
    FCREATE(vfile)
    FCLOSE(vfile)
    if FERROR() <> 0
      @16,5 clear to 17,78
      @16,5 say "Erro criando ficheiro! ERRO " + str(FERROR(),2)
      @17,5 say "Prima qualquer tecla..."
      inkey(0)
      exit
    endif
  	@16,5 clear to 17,78
    @16,5 say "Ficheiro criado com sucesso!"
    @17,5 say "Prima uma tecla..."
    inkey(0)
  endif
  @13,1 clear to 23,78
  @13,5 say "De seguida vai inserir o texto correspondente ao significado"
  @14,5 say "do termo. Prima a tecla <INS> para justificar o texto   direita"
  @15,5 say "tal como pode observar pelos significados que vieram com o"
  @16,5 say "programa."
  @18,5 say "Insira o texto SEMPRE no fim de cada ficheiro."
  @19,5 say "Anote ou memorize a linha de princ¡pio e a linha de fim de cada"
  @20,5 say "significado, pois ir  precisar desses dados depois de terminar"
  @21,5 say "de inserir o texto."
  @23,5 say "                   Prima uma tecla..."
  inkey(0)
  @13,5 clear to 23,78
  fi = memoread(vfile)
  fi = memoedit(fi,10,1,22,78,.t.,"udf",78)
  memowrit(vfile,fi)
  restscreen(10,1,23,78,t2)
  @19,5 say "N§ da linha do in¡cio: " get vcomeco pict "###"
  @19,40 say "ENTER para Sair."
  read
  if vcomeco = 0
    exit
  endif
  @21,5 say "N§ da linha de fim   : " get vtermino pict "###"
  read
  append blank
  replace nome with vnome
  replace file with vfile
  replace comeco with vcomeco
  replace termino with vtermino
  @10,1 clear to 23,78
  @14,5 say "Termo Inserido!"
  @16,5 say "Escolha a op‡„o ®Indexa‡„o do Ficheiro¯ para ordenar o ficheiro."
  @18,5 say "Prima uma tecla..."
  inkey(0)
  exit
enddo
restscreen(9,1,23,78,t)
set cursor off
return  

function udf

parameter mode, line, col

ret_val := 0

do case
  case mode = 3
    readinsert(.f.)
  case mode = 0
    set color to g/n
    @23,2 say "F10 - Grava     ESC - Sai sem gravar"
    @23,55 say "Linha: "  + trim(str(line,3,0)) + " "
    @23,67 say "Coluna: " + trim(str(col,2,0))
  case lastkey() = -9
    ret_val = 23
  case lastkey() = 27
    ret_val = 27
endcase
set color to w+/n
return ret_val                

****************************************************************

procedure anula

local b, co
b := savescreen(0,0,24,79)

set color to w+/b
@9,23 say "´      Elimina‡„o de Registos     Ã"
set cursor on

do while .t.
  store " " to co
  set color to w+/b,bg+/b
  @14,22 clear to 16,63
  @14,22 to 16,63
  @15,23 say " Confirma a anula‡„o do Termo? (S/N): " get co pict "!"
  read
  if co = "N"
    exit
  endif
  @14,5 clear to 20,75
  @14,5 to 20,75
  @16,29 say "Aguarde um momento..."
  @17,29 say "Indexando o Ficheiro..."
  delete
  pack
  index on nome to termos
  set index to termos
  @16,29 clear to 17,74
  @16,29 say "Opera‡„o Terminada."
  @19,30 say "Prima uma tecla..."
  inkey(0)
  exit
enddo
set cursor off
restscreen(0,0,24,79,b)
return

*********************

procedure indexa

r := savescreen(0,0,24,79)

set color to w+/b
@10,1 clear to 23,78 

@9,30 say "´Indexa‡„o do FicheiroÃ"

@15,30 say "Indexando o Ficheiro..."
set color to w+*/b
@17,30 say " Aguarde um momento..."

INDEX ON NOME TO TERMOS

set color to w+/b
@10,1 clear to 23,78
@15,33 say "Opera‡„o completa..."
@17,33 say " Prima uma tecla..."
inkey(0)
restscreen(0,0,24,79,r)

********************

procedure copias

local e
e := savescreen(0,0,24,79)
set color to w+/b
@9,30 say "´C¢pias de Seguran‡aÃ"
set color to w+/n,bg+/b
set cursor on

do while .t.

  @10,1 clear to 23,78
  drv = space(1)
  @13,5 say "Indique a drive para onde deseja copiar os ficheiros: " get drv pict "!"
  read
  drv = drv + ":"
  @15,5 say "Coloque uma disquete vazia na drive " + drv
  @16,5 say "Prima uma tecla quando estiver pronto..."
  inkey(0)  
  @18,5 say "Aguarde um momento..."
  set console off
  !copy infoind.dbf &drv >nul
  !copy termos??.inf &drv >nul
  !copy termos.ntx &drv >nul
  set console on
  @21,5 say "Ficheiros copiados!"
  @22,5 say "Prima uma tecla..."
  inkey(0)
  exit
enddo
set cursor off
restscreen(0,0,24,79,e)
return

******************
* Fim de Ficheiro.