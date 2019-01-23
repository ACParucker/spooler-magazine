/*
    TAPE.H

    macros e prot¢tipos do projecto TAPE.PRJ

    por Carlos Ladeira      23/03/1994
*/

#if !defined(__COMPACT__)
#error O programa tem ser compilado no modelo de momoria COMPACT
#endif

#define byte unsigned char
#define word unsigned int

/* macros para os valores retomados pela fun‡„o GetKey() */
#define UP 		328
#define DOWN 		336
#define LEFT 		331
#define RIGHT 		333
#define CTRL_LEFT 	371
#define CTRL_RIGHT 	372
#define HOME 		327
#define PGUP 		329
#define PGDN 		337
#define END 		335
#define F1 		315
#define F2 		316
#define F3 		317
#define F4 		318
#define F5 		319
#define F6 		320
#define F7 		321
#define F8 		322
#define F9 		323
#define F10 		324
#define TAB 		9
#define CR 		13
#define SPACE 		32
#define BKSP 		8
#define ESC 		27
#define DEL 		339
#define INSERT 		338

/* Identifica a porta … qual a impressora est  ligada */
#define LPT1    0x00
#define LPT2    0x01

/* estado actual da impressora retomado por biosprint */
/* para determinar qualquer um destes estados, deve-se */
/* fazer um AND (&) entre o estado pretendido e o estado */
/* da impressora */
#define	TIME_OUT	0x01
#define	IO_ERROR	0x08	/* sempre que existir erro */
#define	SELECTED	0x10
#define	OUT_PAPER	0x20
#define	ACKNOWLEDGE 0x40
#define	NOT_BUSY	0x80

/* numero de op‡”es do menu */
#define MAX_MENU_OPT 11

/* macros para o m¢dulo VIDEO.C */
#define	vid_addr(x, y)	(VidAddr+(y*160)+(x<<1))
#define bad_box(X1, Y1, X2, Y2) \
  ((x2-x1<0) || (x1<0) || (x2>79) || (y1-y1<0) || (y1<0) || (y2>24)) ? 1 : 0
#define bad_xy(x, y) ((x<0) || (x>79) || (y<0) || (y>24)) ? 1 : 0

typedef struct {                /* estrutura usada para editar a etiqueta */
  byte x, y;
  char *s;
  byte len, elen;
  }edit;

typedef struct {		/* estrutura usada para guardar as op‡”es */
  char *s, *hlp;		/* do menu */
  byte x, y;
  }Menu;

struct tapedata{		/* estrutura usada para guardar os dados de */
  char message[20];		/* cada etiqueta */
  char source[10];
  char len[4];
  char Aauthor[22];
  char Bauthor[22];
  char Aalbum[35];
  char Balbum[35];
  char Amusic[12][34];
  char Bmusic[12][34];
  };

struct tape {			/* estrutura usada para criar lista de etiquetas */
  struct tapedata data;
  struct tape *next, *prior;
  };

typedef struct {		/* estrutura que guarda as cores em uso */
  char
    TEXT1,
    TEXT2,
    TEXT3,
    STATUS,
    TITLE;
  } Palt;


/* prototipos do ficheiro TAPEPRN.C */
void 	PrintTape	(void);
void	IBM_print	(void);
void	EPSON_print	(void);
void    HP_print        (void);
void 	printstr	(char *s, unsigned char x);
int     print   (int ch);
void    prints  (char *s);


/* prototipos do ficheiro TAPEKBD.C */
int 	GetKey		(void);
void 	ResetKbd	(void);

/* prototipos do ficheiro TAPELIST.C */
void 	clearinfo	(void);
void 	fillmodel	(void);
void	initlist	(void);
void 	clearlist	(void);
int 	insert		(void);
int 	_delete		(void);
void 	get_prev	(void);
void 	get_next	(void);

/* prototipos do ficheiro TAPEMENU.C */
void 	menu		(int k);

/* prototipos do ficheiro TAPE.C */
void	main		(int NArgs, char *Args[]);
void	show_face	(void);
void 	start		(void);
int 	load		(void);
int 	save		(void);

/* prototipos do ficheiro TAPEUTIL.C */
int 	saveSN		(void);
void 	drawtape	(void);
void 	setedit		(void);
void 	findstring	(const char *s);
void 	start_edit	(void);
void 	PrepFileName	(char *name);
int 	getSN		(void);
void 	status		(char *s);
void 	message		(char *s);
void 	DelCh		(char *p);
void 	InsertCh	(char *p, char c);

/* prototipos do ficheiro TAPEVID.C */
void 	InitVideo	(void);
void 	SetVideoMode	(char mode);
void 	SetCursorSize	(byte start, byte end);
void 	GotoXY		(byte x, byte y);
void 	BlockCls	(byte x1, byte y1, byte x2, byte y2, byte attr);
void 	CursorSmall	(void);
void 	CursorOff	(void);
void 	XYStr		(byte x, byte y, byte attr, char *str);
void 	XYCh		(byte x, byte y, byte attr, byte chr);
void 	WriteStr	(byte x1, byte y1, byte x2, byte y2, byte attr, char *str);
void 	Box		(byte x1, byte y1, byte x2, byte y2, byte attr);

