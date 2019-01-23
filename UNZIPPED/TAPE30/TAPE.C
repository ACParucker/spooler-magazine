/*

	Ficheiro: TAPE.C
	Descri‡„o: Bloco principal do programa
    Programa‡„o por: Carlos Ladeira     23/03/1994

*/

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <alloc.h>
#include <conio.h>
#include "tape.h"

extern Palt *pal;
extern byte MenuOpt;
extern Menu M[MAX_MENU_OPT];

/* variaveis utilizadas no editor de etiquetas */
byte ec=31, oldec=0;
edit e[33]={
  { 4,  1, 0, 19, 20},  {50,  1, 0,  3,  4},  {12,  3, 0,  9, 10},
  { 7,  5, 0, 21, 22},  { 7,  6, 0, 21, 22},  { 7,  8, 0, 34, 35},
  { 6,  9, 0, 33, 20},  { 6, 10, 0, 33, 20},  { 6, 11, 0, 33, 20},
  { 6, 12, 0, 33, 20},  { 6, 13, 0, 33, 20},  { 6, 14, 0, 33, 20},
  {32,  9, 0, 33, 20},  {32, 10, 0, 33, 20},  {32, 11, 0, 33, 20},
  {32, 12, 0, 33, 20},  {32, 13, 0, 33, 20},  {32, 14, 0, 33, 20},
  { 7, 16, 0, 34, 35},  { 6, 17, 0, 33, 20},  { 6, 18, 0, 33, 20},
  { 6, 19, 0, 33, 20},  { 6, 20, 0, 33, 20},  { 6, 21, 0, 33, 20},
  { 6, 22, 0, 33, 20},  {32, 17, 0, 33, 20},  {32, 18, 0, 33, 20},
  {32, 19, 0, 33, 20},  {32, 20, 0, 33, 20},  {32, 21, 0, 33, 20},
  {32, 22, 0, 33, 20},  {14, 24, 0, 65, 66},  { 8, 24, 0, 33, 34}
  };

char saved=1;		/* indica se as ultimas modifica‡”es foram gravadas */
int curec=0, lastrec=0; 	/* etiqueta corrente e ultima etiqueta */
char *p, *pbox, *pend, *ends;   	/* pointers utilizados pelo editor */
enum {SAVE, LOAD, EDIT, MENU, FIND} func=LOAD;	/* indica o que o editor est  a editar */
struct tape *info=NULL, *first=NULL, *last=NULL;/* pointers para: corrente, primeira e ultima etiquetas */
char FileName[80], PathName[80];	/* localiza‡„o do ficheiro de dados */
char fnd_str[40]="";		/* usada na fun‡„o FIND do editor */
char buffer[5000];		/* buffer usado na leitura de dados */
char quit=0;			/* indica a saida do programa */

void main(int NArgs, char **Args)
{
  char *p;

  InitVideo();		/* inicializa o video */
  show_face();		/* mostra o ecr„ do programa */

  p=Args[0];            /* vai buscar a path do programa */
  while (*p) p++;
  while (*(p-1)!=92) p--;
  *p=0;
  strcpy(PathName, Args[0]);	/* e coloca em PathName */

  setedit();		/* inicializa o editor */
  if (NArgs>1) {	/* se existir um parƒmetro */
    PrepFileName(Args[1]);	/* lˆ o ficheiro especificado pelo parƒmetro */
    ec=0;
    func=(info) ? EDIT : MENU;
    load();
    }
  else {		/* caso contrario assume TAPE.DBF por defeito */
    PrepFileName("TAPE.DBF");
    status(" Lˆ ficheiro:");
    }

  start();	/* prossegue com a execu‡„o do programa */

  BlockCls(0, 0, 79, 24, 0x07);	/* depois de terminado o programa, limpar o ecr„ */
  GotoXY(0, 0);			/* colocar o cursor no canto superior esquerdo */
  CursorSmall();		/* e torna-lo visivel */
}

void show_face(void)	/* mostra o ecr„ do programa */
{
  char i;

  BlockCls(0, 0, 79, 24, pal->TEXT1);

  for (i=0; i<MAX_MENU_OPT; i++) XYStr(M[i].x, M[i].y, pal->TEXT1, M[i].s);
  Box(58, 5, 77, 18, pal->TEXT2);
  XYStr(62, 5, pal->TEXT1, " Menu (   ) ");
  XYStr(69, 5, pal->TITLE, "F10");
  XYStr(61, 11, pal->TEXT2, "--------------");

  XYStr(61, 1, pal->TITLE, "Tape Edit 3.0");
  XYStr(58, 2, pal->TEXT1, "por: Carlos Ladeira");
  XYStr(63, 3, pal->TEXT1, "28/03/1994");

  Box(58, 19, 77, 23, pal->TEXT2);
  XYStr(63, 19, pal->TEXT1, " Etiqueta ");
  XYStr(69, 20, pal->TEXT1, "- Pr¢x.");
  XYStr(69, 21, pal->TEXT1, "- Ante.");
  XYStr(60, 22, pal->TEXT1, "N§     Total:");
  XYStr(60, 20, pal->TITLE, "CTRL");
  XYStr(60, 21, pal->TITLE, "CTRL");
  XYCh(67, 20, pal->TITLE, 0x1A);
  XYCh(67, 21, pal->TITLE, 0x1B);
  XYCh(65, 20, pal->TEXT2, '+');
  XYCh(65, 21, pal->TEXT2, '+');
}

void start(void)	/* centro de todo o programa */
{
  char a[7];
  int k;
  byte i;
  byte ins=1;

  drawtape();		/* desenha a etiqueta corrente */

  do {
    sprintf(a, "%3d", curec);
    XYStr(62, 22, pal->TITLE, a);
    sprintf(a, "%3d", lastrec);
    XYStr(73, 22, pal->TITLE, a);

    switch (func) {
      case MENU:
	XYStr(M[MenuOpt].x, M[MenuOpt].y, pal->STATUS, M[MenuOpt].s);
	status(M[MenuOpt].hlp);
	CursorOff();
	break;
      case EDIT:
	status(" Use os cursores (\x18 \x19 \x1A \x1B) para movimentar a c‚lula e o cursor");
	XYStr(68, 24, pal->TEXT3, ins ? "INSERT" : "OVERWRITE");
      default:
	WriteStr(e[ec].x, e[ec].y, e[ec].x+e[ec].elen-1, e[ec].y, pal->TEXT3, pbox);
	GotoXY(p-pbox+e[ec].x, e[ec].y);
	CursorSmall();
      }

    ResetKbd();		/* limpa o buffer do teclado */
    k=GetKey();		/* lˆ uma tecla */

    switch (func) {
      case MENU: menu(k); continue;
      case EDIT:
	switch (k) {
	  case ESC:
	  case F10:
	    func=MENU;
	    WriteStr(e[ec].x, e[ec].y, e[ec].x+e[ec].elen-1, e[ec].y, pal->TEXT2, e[ec].s);
	    break;
	  case CTRL_LEFT:  get_prev(); break;
	  case CTRL_RIGHT: get_next(); break;
	  case CR:
	  case TAB:
	  case DOWN:
	  case UP:
	    WriteStr(e[ec].x, e[ec].y, e[ec].x+e[ec].elen-1, e[ec].y, pal->TEXT2, e[ec].s);
	    ec=(k==UP) ? ((!ec) ? ec=30 : ec-1) : ((++ec==31) ? ec=0 : ec);
	    start_edit();
	  }
	break;
      case LOAD:
	switch (k) {
	  case CR: load(); drawtape();
	  case ESC:
	    strupr(FileName);
	    ec=oldec;
	    start_edit();
	    func=MENU;
	  }
	break;
      case SAVE:
	switch (k) {
	  case CR: save();
	  case ESC:
	    strupr(FileName);
	    ec=oldec;
	    start_edit();
	    func=MENU;
	  }
	break;
      case FIND:
	switch (k) {
	  case CR: findstring(fnd_str);
	  case ESC:
	    ec=oldec;
	    start_edit();
	    func=MENU;
	  }
      }

    switch (k) {
      case INSERT: ins=!ins; break;
      case HOME: p=pbox=e[ec].s; break;
      case END:
	pbox=p=ends;
	for (i=0; i<e[ec].elen && pbox>e[ec].s; i++) pbox--;
	break;
      case BKSP:
	if (p>e[ec].s) {
	  DelCh(--p);
	  ends--;
	  saved=(func==EDIT) ? 0 : saved;
	  }
	break;
      case DEL:
	if (*p) {
	  DelCh(p);
	  ends--;
	  saved=(func==EDIT) ? 0 : saved;
	  }
	break;
      case LEFT: if (p>e[ec].s) p--; break;
      case RIGHT: if (*p) p++; break;
      default:
	if (k>255 || k<32) break;
	if ((ends<pend) && (ins || (!ins && !*p))) {
	    InsertCh(p, k);
	    p++;
	    ends++;
	    saved=(func==EDIT) ? 0 : saved;
	    }
	else
	  if (!ins && (p<ends)) {
	    *p++=k;
	    saved=(func==EDIT) ? 0 : saved;
	    }
      }

    if (p<pbox) pbox--;
    if (p-e[ec].elen==pbox) pbox++;
    } while (!quit);
  clearlist();
}

int load(void)		/* lˆ etiquetas de um determinado ficheiro */
{
  FILE *fp;
  int j;

  message(" Lendo dados, aguarde um momento ...");
  clearlist();

  if ((fp=fopen(FileName, "rb"))==NULL) return 0;
  setvbuf(fp, buffer, _IOFBF, 5000);	/* buffer de leitura de 5k */

  for (j=0; !feof(fp); j++) {
    if (!insert()) {
      message(" N„o existe mem¢ria suficiente para ler o ficheiro todo ...");
      GetKey();
      break;
      }
	if (fread(&info->data, sizeof(struct tapedata), 1, fp) != 1 ) _delete();
	}

  fclose(fp);
  saved=1;
  return 1;
}

int save(void)		/* grava etiquetas para um determinado ficheiro */
{
  FILE *fp;
  struct tape *p;

  message(" Gravando dados, aguarde um momento ...");

  if ((fp=fopen(FileName, "wb"))==NULL) return 0;

  p=last;
  while (p) {
    fwrite(&p->data, sizeof(struct tapedata), 1, fp);
    p=p->prior;
    }

  saved=1;
  fclose(fp);
  return 1;
}
