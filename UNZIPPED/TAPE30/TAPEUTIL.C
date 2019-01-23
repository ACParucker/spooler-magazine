/*

    Ficheiro: TAPEUTIL.C
	Descri‡„o: Rotinas de uso geral
    Programa‡„o por: Carlos Ladeira     23/03/1994

*/

#include <string.h>
#include <stdio.h>
#include <alloc.h>
#include <conio.h>
#include "tape.h"

extern Palt *pal;
extern byte MenuOpt;
extern Menu M[MAX_MENU_OPT];
extern int curec;
extern byte ec;
extern edit e[33];
extern char saved;
extern char *p, *pbox, *pend, *ends;
extern struct tape *info, *first, *last;
extern char FileName[80], PathName[80];
extern char fnd_str[40];

int saveSN(void)	/* pergunta ao utilizador se pretende gravar as etiquetas em mem¢ria */
{
  CursorSmall();
  while (!saved) {
    status(" Etiquetas alteradas por gravar, Gravar (S/N) ? [Sim]");
    GotoXY(49, 24);
    switch (GetKey()) {
      case CR:
      case 's':
      case 'S':	save(); break;
      case 'n':
      case 'N': saved=1; break;
      case ESC: return 0;
      }
    }
  return 1;
}

void drawtape(void)	/* desenha uma etiqueta no ecr„ */
{
  register char i;
  static char clear=1;

  if (!info) {
    BlockCls(1, 0, 56, 23, pal->TEXT1);
    clear=1;
    return;
    }

  if (clear) {			/* se for necess rio desenhar */
    Box(2, 0, 55, 23, pal->TEXT1);
    Box(2, 4, 55, 7, pal->TEXT1);
    XYCh(2, 4, pal->TEXT1, 195);
    XYCh(2, 7, pal->TEXT1, 195);
    XYCh(55, 4, pal->TEXT1, 180);
    XYCh(55, 7, pal->TEXT1, 180);
    XYStr(5, 3, pal->TITLE, "Fonte:");
    XYStr(4, 5, pal->TITLE, "A");
    XYStr(4, 6, pal->TITLE, "B");
    XYStr(4, 8, pal->TITLE, "A");
    XYStr(4,16, pal->TITLE, "B");
    clear--;
    }

  setedit();
  for (i=0; i<31; i++)
   WriteStr(e[i].x, e[i].y, e[i].x+e[i].elen-1, e[i].y, pal->TEXT2, e[i].s);
}

void setedit(void)	/* posiciona o editor para a etiqueta corrente */
{
  byte i;

  e[0].s=info->data.message;
  e[1].s=info->data.len;
  e[2].s=info->data.source;
  e[3].s=info->data.Aauthor;
  e[4].s=info->data.Bauthor;
  e[5].s=info->data.Aalbum;
  e[18].s=info->data.Balbum;
  e[31].s=FileName;
  e[32].s=fnd_str;

  for (i=0; i<12; i++) {
    e[6+i].s=info->data.Amusic[i];
    e[19+i].s=info->data.Bmusic[i];
    }

  start_edit();
}

void start_edit(void)		/* inicializa as variaveis do editor */
{
  ends=pbox=p=e[ec].s;
  pend=p+e[ec].len;
  while (*ends) ends++;
}

void findstring(const char *s)	/* procura uma string por todas as etiquetas */
{
  register int i, j=1;
  struct tape *p;
  char match=0;
  char s1[40], s2[40];

  if (!info || !*s) return;

  p=info;
  info=NULL;
  strcpy(s1, s);
  strupr(s1);
  drawtape();
  info=first;
  ResetKbd();
  CursorSmall();

  while (info) {
    setedit();
    sprintf(s2, "%3d", j);
    XYStr(62, 22, pal->TITLE, s2);
    for (i=0; i<31; i++) {
      message(" Procurando ...");
      strcpy(s2, e[i].s);
      strupr(s2);
      if (strstr(s2, s1)) {
	match++;
	p=info;
	ec=i;
	curec=j;
	drawtape();
	WriteStr(e[i].x, e[i].y, e[i].x+e[i].elen-1, e[i].y, pal->TEXT3, e[i].s);
	}
      if (kbhit() || match) {
	message(" Continuar a busca ([s]/n) ? ");
	if (!getSN()) {
	  if (!match) info=p;
	  drawtape();
	  return;
	  }
	match=0;
	}
      }
    info=info->next;
    j++;
    }

  message(" N„o consegui localizar ...");
  GetKey();
  info=p;
  drawtape();
}

void PrepFileName(char *name)		/* prepara a variavel FileName */
{
  strcpy(FileName, PathName);
  strcat(FileName, name);
  strupr(FileName);
}

int getSN(void)		/* lˆ resposta do utilizador */
{
  for (;;)
    switch (GetKey()) {
      case CR:
      case 's':
      case 'S': return 1;
      case ESC:
      case 'n':
      case 'N': return 0;
      }
}

void status(char *s)	/* escreve mensagem na ultima linha */
{
  WriteStr(0, 24, 79, 24, pal->STATUS, s);
}

void message(char *s)	/* igual a status, e posiciona o cursor no fim da mensagem */
{
  status(s);
  GotoXY( strlen(s), 24);
}

void DelCh(char *p)	/* apaga o caracter apontado por p */
{
  while (*p) {
    *p=*(p+1);
    p++;
    }
}

void InsertCh(char *p, char c)	/* insere o caracter c na posi‡„o apontada por p */
{
  char ch;

  while (*p) {
    ch=*p;
    *p=c;
    c=ch;
    p++;
    }
  *p++=c;
  *p='\0';
}
