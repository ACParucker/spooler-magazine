/*

    Ficheiro: TAPELIST.C
	Descri‡„o: Rotinas de manipula‡„o da lista em mem¢ria
    Programa‡„o por: Carlos Ladeira     23/03/1994

*/

#include <string.h>
#include <alloc.h>
#include "tape.h"

extern struct tape *info, *first, *last;
extern int curec, lastrec;
extern char saved;

void clearinfo(void)	/* limpa todo o texto da etiqueta corrente */
{
  byte i;

  if (!info) return;

  strcpy(info->data.message, "");
  strcpy(info->data.source, "");
  strcpy(info->data.len, "");
  strcpy(info->data.Aauthor, "");
  strcpy(info->data.Bauthor, "");
  strcpy(info->data.Aalbum, "");
  strcpy(info->data.Balbum, "");

  for (i=0; i<12; i++) {
    strcpy(info->data.Amusic[i], "");
    strcpy(info->data.Bmusic[i], "");
    }
  saved=0;
}

void fillmodel(void)    /* preenche a etiqueta corrente com o modelo */
{
  byte i;

  strcpy(info->data.message, "Data: (__/__/__)");
  strcpy(info->data.source, "_________");
  strcpy(info->data.len, "___");
  strcpy(info->data.Aauthor, "_____________________");
  strcpy(info->data.Bauthor, "_____________________");
  strcpy(info->data.Aalbum, "__________________________________");
  strcpy(info->data.Balbum, "__________________________________");

  for (i=0; i<12; i++) {
    strcpy(info->data.Amusic[i], "_________________________________");
    strcpy(info->data.Bmusic[i], "_________________________________");
    }
  saved=0;
}

void initlist(void)	/* inicializa a lista */
{
  curec=lastrec=0;
  info=first=last=NULL;
}

void clearlist(void)	/* liberta a mem¢ria em uso e inicializa a lista */
{
  struct tape *p;

  p=first;
  while (info=p, info) {
    p=p->next;
    free(info);
    }
  initlist();
}

int insert(void)	/* insere uma nova etiqueta */
{
  struct tape *_new;

/* tem de deixar pelo menos 1000 bytes livres, para uso por outras fun‡”es */
  if (coreleft()<(unsigned long)(sizeof(struct tape)+1000)) return 0;
  _new=(struct tape *)calloc(1, sizeof(struct tape));

  lastrec++;

  if (!info) {			/* se for a primeira etiqueta da lista */
    info=first=last=_new;
    info->next=NULL;
    info->prior=NULL;
    curec++;
    }
  else {
    _new->next=info;
    _new->prior=info->prior;
    if (info!=first) info->prior->next=_new;
    else first=_new;
    info->prior=_new;
    info=_new;
    }
  clearinfo();

  saved=0;
  return 1;
}

int _delete(void)	/* apaga a etiqueta corrente */
{
  struct tape *p;

  if (!info) return 0;

  lastrec--;
  p=info;
  if (p==first) {	/* se a corrente for a primeira */
    info=first=p->next;
    if (p==last) initlist();
    else first->prior=NULL;
    }
  else {
    p->prior->next=p->next;
    if (p==last) {		/* se for a ultima */
      info=last=p->prior;
      curec--;
      }
    else {
      p->next->prior=p->prior;
      info=p->next;
      }
    }
  free(p);	/* liberta a mem¢ria usada pela etiqueta */

  saved=0;
  return 1;
}

void get_prev(void)	/* etiqueta corrente = etiqueta anterior */
{
  if (info!=first) {
    curec--;
    info=info->prior;
    }
  else {
    curec=lastrec;
    info=last;
    }
  drawtape();
}

void get_next(void)	/* etiqueta corrente = etiqueta posterior */
{
  if (info!=last) {
    curec++;
    info=info->next;
    }
  else {
    curec=1;
    info=first;
    }
  drawtape();
}
