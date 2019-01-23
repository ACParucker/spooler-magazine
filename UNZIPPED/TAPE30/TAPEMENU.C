/*

    Ficheiro: TAPEMENU.C
	Descri‡„o: Fun‡„o menu
    Programa‡„o por: Carlos Ladeira     23/03/1994

*/

#include <string.h>
#include "tape.h"

extern struct tape *info, *first, *last;
extern byte ec, oldec;
extern edit e[33];
extern char saved;
extern int curec, lastrec;
extern Palt *pal;
extern enum {SAVE, LOAD, EDIT, MENU, FIND} func;
extern char quit;

byte MenuOpt=0;			/* posi‡„o corrente do menu */
Menu M[MAX_MENU_OPT]={		/* op‡”es do menu */
  {" Editar           ", " Edita a etiqueta corrente", 59, 6},
  {" Imprimir         ", " Imprime a etiqueta corrente", 59, 7},
  {" Ler dados        ", " Lˆ novo ficheiro de etiquetas", 59, 8},
  {" Gravar dados     ", " Grava todas as etiquetas para um ficheiro", 59, 9},
  {" Sair para o DOS  ", " Termina a execu‡„o do programa", 59, 10},
  {" Localizar texto  ", " Procura uma \"string\" por todas as etiquetas", 59, 12},
  {" Inserir etiqueta ", " Cria uma etiqueta nova", 59, 13},
  {" Inserir modelo   ", " Cria uma etiqueta e preenche-a com um modelo", 59, 14},
  {" Excluir etiqueta ", " Elimina a etiqueta corrente", 59, 15},
  {" Copiar etiqueta  ", " Cria uma nova etiqueta igual … corrente", 59, 16},
  {" Limpar etiqueta  ", " Limpa todo o texto da etiqueta corrente", 59, 17}
  };

void menu(int k)
{
  /* apaga op‡„o corrente do menu */
  XYStr(M[MenuOpt].x, M[MenuOpt].y, pal->TEXT1, M[MenuOpt].s);
  switch (k) {
    case PGUP:
    case HOME: MenuOpt=0; break;
    case PGDN:
    case END:  MenuOpt=MAX_MENU_OPT-1; break;
    case LEFT:
    case UP: MenuOpt=(MenuOpt) ? MenuOpt-1 : MAX_MENU_OPT-1; break;
    case RIGHT:
    case DOWN: MenuOpt=(MenuOpt<(MAX_MENU_OPT-1)) ? MenuOpt+1 : 0; break;
    case ESC: if (info) func=EDIT; break;
    case CTRL_LEFT:  get_prev(); break;
    case CTRL_RIGHT: get_next(); break;
    case CR:
      switch (MenuOpt) {
	case 0: if (info) func=EDIT; break;
	case 1: if (info) PrintTape(); break;
	case 2:
	  if (!saveSN()) break;
	  func=LOAD;
	  oldec=ec;
	  ec=31;
	  start_edit();
	  status("      Ler de:");
	  break;
	case 3:
	  func=SAVE;
	  oldec=ec;
	  ec=31;
	  start_edit();
	  status(" Gravar para:");
	  break;
	case 4:
	  if (!saveSN()) break;
	  quit=1;
	  break;
	case 5:
	  if (!info) break;
	  func=FIND;
	  oldec=ec;
	  ec=32;
	  start_edit();
	  status(" Texto:");
	  break;
	case 6: insert(); drawtape(); break;
	case 7: insert(); fillmodel(); drawtape(); break;
	case 8: _delete(); drawtape(); break;
	case 9:
	  if (info) {
	    insert();
	    info->data=info->next->data;
	    drawtape();
	    saved=0;
	    }
	  break;
	case 10: clearinfo(); drawtape();
	}
    }
}
