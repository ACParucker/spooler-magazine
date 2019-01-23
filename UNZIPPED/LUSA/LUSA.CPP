//
//  |          __  __
//  |   |  |  |_  |__|     Vrs. 1.13 á  (c)  Fev. 1993
//  |__ |__|  __| |  |     ---------------------------
//  ------------------
//
//  AMBIENTE
//           Linguagem         : C++
//	     Sistema Operativo : MS-DOS 5.0
//	     Sistema           : PC compat¡vel 386
//
//  DESCRI€ŽO
//	     Este programa consiste num interpretador de uma nova
//	     linguagem de programa‡„o, a LUSA.
//
//  FICHEIROS RELACIONADOS
//           LusaDef.cpp                Erros.cpp
//           Ident.cpp                  Endereco.cpp
//           Parser.cpp		        Parser2.cpp
//
//  AUTORES
//           Rui Miguel Dias Anast cio
//           Nelson Paulo Mendes Pires
//
//  DATA     7/08/93
//

#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <conio.h>
#include <dos.h>
#include <iostream.h>


// VARIAVEIS GLOBAIS
// -----------------

int  numlin=1;   // indica o n§ da linha que est  a ser executada
char *memfich;   // ponteiro para a  rea de mem. que contem o prog.
char *chp,nomevar[80]; // auxiliares
int c,t;         // auxiliares
double resultado; // var. que recebe os valores das expressoes


#include "lusadef.cpp"
#include "erros.cpp"
#include "ident.cpp"

Ident id; // Objecto gestor dos identificadores

#include "parser.cpp"
#include "endereco.cpp"
#include "parser2.cpp"

// FUNCOES
//----------------------------------------------------------------------

long filesize(FILE *stream)
{
   long curpos, length;

   curpos = ftell(stream);
   fseek(stream, 0L, SEEK_END);
   length = ftell(stream);
   fseek(stream, curpos, SEEK_SET);
   return length;
}

//------------------------------
// LEFICH - Leitura do ficheiro
//          para memoria
//------------------------------

void le_fich(char *nome)
{
 FILE *fp;
 char tmp2,*tmp;
 enum asp {abertas=1,fechadas=0};
 enum asp aspas;

if ( !(fp=fopen(nome,"rb")) )
   { cout << "Ficheiro n„o encontrado!"; exit(2); }

if ( !( memfich =( char *) malloc (filesize(fp)) ))  fatal(err_mem);
tmp=memfich;

cout << "Lendo " << nome << " ...\n";

aspas=fechadas;
while (! feof(fp))
   {
   tmp2 = getc(fp);
   if (tmp2=='"') aspas=(enum asp)!aspas;
   if (tmp2=='{') {
      do {
	tmp2=getc(fp);
	if (tmp2==13) *tmp++=13;
	} while (tmp2!='}' && !feof(fp));
       continue;
       }
    if (feof(fp)) break;
    if (tmp2==10) continue;
    if (tmp2==13) *tmp++=13;
    else if (aspas==abertas) *tmp++=tmp2; else *tmp++=toupper(tmp2);
    }
    *tmp=0;
    fclose(fp);
    clrscr();
    tmp=memfich;
}

//----------------------------
// Verifica se existe um ponto
//----------------------------

void verpontovirg()
{
 get_token();
 if (*token!=';') fatal(err_pvesp);
}

//----------------------
// Mostra exp. caractere
//----------------------

void mostra()
{
  while (*prog!='\"') {
    if (*prog==13) { cprintf("\n"); prog++; continue; }
    if (*prog=='\\') {
       prog++;
       switch(*prog) {
	 case '\\':putch('\\');  break;
	 case 'n':putchar(13);putchar(10);break;
	 case 't':cprintf("\t");  break;
	 case 'b':putchar(7);  break;
	 case 'r':putchar(13); break;
	 case 'l':putchar(10); break;
	 case 'c':int tmp;
		  prog++;
		  get_token();
		  if (tok_type!=NUMBER) fatal(err_coresp);

		  tmp=atoi(token);
		  textattr(tmp);

		  id.proc_tipo("COR");
		  *(char*)id.lista->pt=tmp;

		  verpontovirg();
		  prog--;
		  break;
	 }
       }
       else putch(*prog);
       prog++;
   }
   prog++;
}


//----------------------------------------
//  EXPRESSAO - para condicoes de ciclos
//----------------------------------------

void expressao()
{
  char tmp;

  pt=prog;
  while ((*prog!=',') && (*prog!=';') && (*prog!=0) ) prog++;
  tmp=*prog;
  *prog=0;
  eval_exp1(&resultado);
  *prog=tmp;
}

//------------------------------------
//  AMBIENTE - variaveis pre-definidas
//------------------------------------

void ambiente()
{
  id.soma("DECIMAIS",'I');
  *(int*)id.lista->pt=2;
  id.soma("COR",'C');
  textattr(7);
  *(char*)id.lista->pt=7;
  id.soma("PI",'R');
  *(double*)id.lista->pt=3.1415;
  id.soma("VERSAO_SO",'I');
  *(int*)id.lista->pt=_version;
}

//-----------
// DEF_PROG
//-----------

void def_prog()
 {
   get_token();
   if (tok_type!=COMMAND) fatal(err_cmdesp);
   if (comandoid==cmd_PROGRAMA) {
      while (*prog!=13) prog++;
      prog++; numlin++;
      }
   else put_back();
 }

//-----------
// DEF_VAR
//-----------

void def_var()
{
  get_token();
 V0:
  if (tok_type!=COMMAND) fatal(err_cmdesp);
  switch (comandoid) {
    case cmd_INTEIRO:tipo='I'; break;
    case cmd_REAL   :tipo='R'; break;
    case cmd_CARACTER:tipo='C'; break;
    default         :return;
    }
 V1:
  get_token();
  if (tok_type!=VARIABLE) fatal(err_varesp);
  switch (id.soma(token,tipo)) {
     case 1: fatal(err_iddef);
     case 2: fatal(err_mem);
    }
  get_token();
  if (tok_type!=DELIMITER) fatal(err_pvvesp);
  if (*token==',') goto V1;
  if (*token==';') {
   get_token();
   if (tok_type==COMMAND)
     switch  (comandoid) {
      case cmd_INTEIRO:
      case cmd_REAL   :
      case cmd_CARACTER: goto V0;
      }
    else fatal(err_cmdesp);
  }
}

//-----------
// DEF_ROTVAR
//-----------

void def_rot()
{
   get_token();
   if (tok_type!=VARIABLE) fatal(err_identesp);
   switch (id.soma(token,'+')) {
     case 1: fatal(err_iddef);
     case 2: fatal(err_mem);
    }
   verpontovirg();
   id.lista->pt=(void*)prog; // poe na lista o endereco
   do get_token(); while (comandoid!=cmd_FIMROTINA && tok_type!=FIM);
   get_token();
}


//--------------------------------------
// Procedimentos que tratam cada comando
//--------------------------------------

void proc_fimrot()
//----------------
{
 if (endereco.tipo()!='+') fatal(err_fimrot);
 prog=endereco.end();
 endereco.tira();
}

void  proc_executa()
//------------------
{
 get_token();
 if (tok_type!=VARIABLE) fatal(err_varesp);
 strcpy(nomevar,token);
 verpontovirg();
 if (endereco.poe(prog,'+')) fatal(err_over);
 if (id.proc_tipo(nomevar)=='+')
   prog=(char *)id.lista->pt;
 else
   fatal(err_rotndef);
}

void proc_ate()
//-------------
{
 if (endereco.tipo()!='R') fatal(err_fimciclo);
 expressao();
 if ((int)resultado) endereco.tira();
 else prog=endereco.end();
}

void proc_se()
//------------
{
 pt=prog;
 get_token();
 while (tok_type!=COMMAND) get_token();
 if (comandoid!=cmd_ENTAO) fatal(err_entao);
 *(prog-5)=0;
 eval_exp1(&resultado);
 *(prog-5)='E';
 if (endereco.poe(prog,'S')) fatal(err_over);

 if (!(int)resultado) {
   int n=0;
   do {
      get_token();
      if (tok_type==COMMAND && comandoid==cmd_SE){
      if (endereco.poe(prog,'S')) fatal(err_over);
      n++;
      }
     if (tok_type==COMMAND && comandoid==cmd_FIMSE) {
       if (endereco.tipo()!='S') fatal(err_fimciclo);
       else { endereco.tira(); n--; }
      }
    } while ((!(tok_type==COMMAND && comandoid==cmd_FIMSE && n==-1)
	      && (tok_type!=FIM)));
  }
}

void proc_enquanto()
//------------------
{
  char *tmp=prog-8;
  int n=0;

  pt=prog;
  get_token();
  while (tok_type!=COMMAND) get_token();
  if (comandoid!=cmd_FAZ) fatal(err_cmdesp);

  *(prog-3)=0;
  eval_exp1(&resultado);
  *(prog-3)='F';
  if (endereco.poe(tmp,'E')) fatal(err_over);

  if ((int)resultado) return;

  do {
    get_token();
    if (tok_type==COMMAND && comandoid==cmd_ENQUANTO){
       if (endereco.poe(prog,'E')) fatal(err_over);
       n++;
      }
    if (tok_type==COMMAND && comandoid==cmd_FIMENQUANTO) {
       if (endereco.tipo()!='E') fatal(err_fimciclo);
       else { endereco.tira(); n--; }
      }
    }  while ((!(tok_type==COMMAND && comandoid==cmd_ENQUANTO && n==-1)
	       && (tok_type!=FIM)));
}

void proc_emxy()
//--------------
{ int x;
  expressao();
  x=(int)resultado;
  get_token();
  if (*token!=',') fatal(err_vesp);
  expressao();
  verpontovirg();
  gotoxy(x,(int) resultado);
}

void proc_som()
//------------
{ unsigned freq;
  expressao();
  freq=(unsigned)resultado;
  verpontovirg();
  sound(freq);
}

void  proc_escreve()
//------------------
{
 id.proc_tipo("COR");
 textattr(*(char*)id.lista->pt);
 do {
   get_token();
   switch (*token) {
     case '\"': mostra(); break;
     case '\'': expressao();
		cprintf("%c",(char)resultado);
		break;
     default:   put_back();
		expressao();
		id.proc_tipo("DECIMAIS");
		cprintf("%.*f",*(int*)id.lista->pt,resultado);
     }
    get_token();
    } while (*token==',');
  if (*token!=';') fatal(err_pvesp);
}

void proc_le()
//------------
{
  do {
     get_token();
     if (*token=='\"')  mostra();
     else if (tok_type!=VARIABLE) fatal(err_varesp);
     else {
	switch(id.proc_tipo(token)) {
	  case 'I' : scanf("%d",(int *)  id.lista->pt); break;
	  case 'R' : scanf("%lG",(double *)id.lista->pt); break;
	  case 'C' : scanf("%c",(char *) id.lista->pt); break;
	  default  : fatal(err_vesp);
	 }
	}
	get_token();
      } while (*token==',');
  if (*token!=';') fatal(err_pvesp);
}

void atribuicao()
//---------------
{
  char tmp;
  struct lista_reg *aux;

  tmp=id.proc_tipo(token);
  aux=id.lista;

  get_token();
  if (*token!='=') fatal(err_atrib);
  switch(tmp) {
    case 'I':int i;
	     expressao();
	     i=(int) resultado;
	     id.lista=aux;
	     memcpy( id.lista->pt ,&i,sizeof(int));
	     break;
    case 'R':double d;
	     expressao();
	     d=resultado;
	     id.lista=aux;
	     memcpy( id.lista->pt,&d,sizeof(double));
	     break;
    case 'C':char c;
	     expressao();
	     c=(int) resultado;
	     id.lista=aux;
	     memcpy( id.lista->pt ,&c,sizeof(char));
	     break;
    }
   verpontovirg();
}


// -----------------------------
//       BLOCO PRINCIPAL
// -----------------------------

void main(int nparam,char *param[])
{
 int tipo;

 clrscr();
 cout << "\nInterpretador de LUSA  Vrs. 1.13 á  -  Fev. 1993\n";
 for (c=0; c<80; c++,putch('-') );

 if (nparam<2) {
   cout << "Ficheiro ? ";
   scanf("%30s",&nomevar);
   }
 else strncpy(nomevar,param[1],30);

 if (strchr(nomevar,'.')==NULL) strcat(nomevar,".LUS");
 le_fich(nomevar);

 if (endereco.define(40)) fatal(err_mem);
 prog=chp=memfich;

 ambiente();

 def_prog();
 get_token();
 while (tok_type==COMMAND && comandoid!=cmd_INICIO) {
   switch (comandoid) {
      case cmd_VARIAVEL: def_var(); break;
      case cmd_ROTINA  : def_rot(); break;
      default: fatal(err_iniesp);
    }
  }

 if (comandoid!=cmd_INICIO) fatal(err_iniesp);

 do {
   get_token();
   if (tok_type==COMMAND)
     switch(comandoid) {
       case  cmd_FIM:        exit(0);
       case  cmd_FIMROTINA:  proc_fimrot(); break;
       case  cmd_EXECUTA:    proc_executa(); break;
       case  cmd_REPETE:     if (endereco.poe(prog,'R')) fatal(err_over);break;
       case  cmd_ATE:        proc_ate(); break;
       case  cmd_SE:         proc_se(); break;
       case  cmd_ENTAO:      fatal(err_entaonesp); break;
       case  cmd_FIMSE:      if (endereco.tipo()!='S') fatal(err_fimciclonesp);
			     else endereco.tira();
			     break;
       case  cmd_ENQUANTO:   proc_enquanto(); break;
       case  cmd_FIMENQUANTO:if (endereco.tipo()!='E') fatal(err_fimciclonesp);
			     else { prog=endereco.end(); endereco.tira(); }
			     break;
       case  cmd_FAZ:        fatal(err_cmdnesp);
       case  cmd_EMXY:       proc_emxy(); break;
       case  cmd_LIMPA_ECR:  clrscr(); verpontovirg();  break;
       case  cmd_ESCREVE:    proc_escreve(); break;
       case  cmd_LE:         proc_le(); break;
       case  cmd_SOM:        proc_som(); break;
       case  cmd_DSOM:       nosound(); verpontovirg(); break;
       } // switch

    else if (tok_type==VARIABLE) atribuicao();
   }  while (tok_type!=FIM);
}
