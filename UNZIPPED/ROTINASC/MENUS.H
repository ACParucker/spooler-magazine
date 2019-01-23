#define CR 13
#define ESC 27
#define HOMEKEY 327
#define ENDKEY 335
#define UPKEY 328
#define DOWNKEY 336
#define PGUPKEY 329
#define PGDNKEY 337
#define LEFTKEY 331
#define RIGHTKEY 333
#define DBLDBL   3 /* º Í */ /* estilos para a fun‡„o Box  */
#define DBLSNGL  2 /* º Ä */
#define SNGLDBL  1 /* ³ Í */
#define SNGLSNGL 0 /* ³ Ä */

typedef struct {
   char col,lin;  /* coluna, linha */
   char *st;     /* Op‡„o de menu */
   char *mem;  /* mensagem que aparece em rodap‚, e que descreve a op‡„o de menu */
   void (*proc)(void); /* Procedimento a executar no caso da op‡„o ser selectionada */
 }   MENU;

typedef struct {
  char x, y; /* coluna, linha de cada Titulo de menu*/
  char *st;  /* Titulo do menu */
  char *mem;  /* mensagem que descreve o menu */
  char nit;  /* n§ de op‡”es do menu */
  int coord[4];   /* coordenada para construir no ecran a area do menu*/
  MENU *menu;  /* tabela que contem a defin‡„o do Menu */
} BARRA;

void writexy(int x, int y, char *s,int a);
   /* escreve a string s no ecran, na posi‡„o x,y com o atributo a. */

void repetchar(char x, char y, char c, char n, char a);
  /* escreve o caracter c, na posi‡„o x,y do ecran n vezes com o atributo a.*/

void caixa(int x1, int y1, int x2, int y2, int a);
	  /* Preenche uma area delimitada pelas coordenadas x1, y1, x2, y2
	    com o atributo a - (0 a 255).
	   coluna inicial, linha inicial, coluna final, linha final*/

char *salvaecran(int x1, int y1, int x2, int y2);
	 /* salva o ecran delimitado pelas coordenadas x1, y1, x2, y2.
    coluna inicial, linha inicial, coluna final, linha final*/

void restauraecran(int x1, int y1, int x2, int y2, char *ecr);
	/* restaura o ecran delimitado pelas coordenadas x1, y1, x2, y2.
	   coluna inicial, linha inicial, coluna final, linha final*/

void box(int x1, int y1, int x2, int y2, int estilo, int atr);
      /* desenha uma box no estilo 'estilo' delimitada pelas coordenadas x1, y1, x2, y2
	com o atributo atr (0 a 255).
    coluna inicial, linha inicial, coluna final, linha final*/

void limpa(int x1, int y1, int x2, int y2);
    /* limpa uma area delimitada pelas coordenadas x1, y1, x2, y2.
    coluna inicial, linha inicial, coluna final, linha final*/

void mensagem(char *mem);

int getkey(void);

char *datasys(char *datas); /* retorna a data de sistema na string datas */

void menuop(MENU tabm[], char op, char cl, char ln, char *str, char *m, void (*pr)());
      /*  tabm - menu, op - N§ da op‡„o no menu;
	  cl, ln - coluna e linha da op‡„o no ecran;
	  str - string que cont‚m a op‡„o;
	  m - string que cont‚m uma mensagem que aparece em rodap‚;
	  pr - fun‡„o a executar caso esta op‡„o seja seleccionada. */

void menubarra(BARRA barra[], char op, MENU menu[], char x, char y, char *s,
	       char *mem, char nit, char x1, char y1, char x2, char y2);
      /*  barra - barra de menus, op - N§ da op‡„o na barra de menus;
	  x, y - coluna e linha da op‡„o no ecran;
	  s   - string que cont‚m a op‡„o;
	  mem - string que cont‚m uma mensagem que aparece em rodap‚;
	  nit - n§ de op‡”es de menu que este menu cont‚m;
	  x1, y1, x2, y2 - coordenadas de ecran onde este menu ir  aparecer. */

void sair(void);  /* procedimento de sa¡da */

int fmenu(MENU tabel[], int crd[4], char nop, char opc0, char *me, char nit);

void menuprincipal(BARRA barra[], char nit);
	     /*  barra - barra de menus;
		 nit - N§ de menus que a barra cont‚m. */

/*     -------------- Fim Ficheiro -- Filipe.H  ------------------  */


 /* fim ficheiro  Menus.h  */
