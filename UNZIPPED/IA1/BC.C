/*
C¢digo extraido do livro...®C¯ Avan‡ado, editado pela Graficria
Autor......................Ruben Romano Borges Barbosa
*/

















#include "screen.h"

#include <stdlib.h>
#include <alloc.h>
#include <conio.h>
#include <dos.h>
#include <stdio.h>
#include <ctype.h>
#include <time.h>
#include <string.h>


typedef struct{
    int    left      : 7;
    int    right;    : 7;
    int    top;      : 5;
    int    bottom;   : 5;
    char  *buffer;
}Screen;

#define  __XY__(x, y)          (Vid_Mem + y*160 + (x<<1))
#define  __DEF__(c1,c2)        (c2)
#define  __FP_OFF_(fp)         ((unsigned)(fp))
#define  __FP_SEG_(fp)         ((unsigned)((unsigned long)(fp) >> 16))
#define  __MK_FP__(seg)        ((void far *)(((unsigned long)(seg) << 16)))

static Screen   *_vm     = NULL;
static char far *Vid_Mem = NULL;

static int       _attr;
static char      _mode;
static char      _screen;
static int       _px, _py;
static int       _old_attr;
static char      _last_mode;
static char      _video_mem;
static char      _max_windows;
static char      _mode_was_changed;


static void    Shadow       (S_Box *b);
static void    EmptyLine    (int x1, int x2, int y);
static void    Col          (S_Box *b, int ind, int size);



static void Col(S_Box *b, int ind, int size)
{
    register int x;
    int per1, per2, oldattr;

    oldattr = _attr;
    per2 = b->bottom - b->top - 3;
    per1 = ind * per2 / (size - per2);
    _attr = __DEF__(112, 31);
    WriteChar(b->right, b->top + 1, 24);
    WriteChar(b->right, b->bottom - 1, 25);
    _attr = 7;
    for(x = 0; x != per2 ; x++)
	 WriteChar(b->right, b->top + x + 2, 'Û');
    _attr = 11;
    WriteChar(b->right, b->top + per1 + 2, 'Û');
    _attr = oldattr;
}



#define  UP     (0x48)
#define  DOWN   (0x50)
#define  PGUP   (0x49)
#define  PGDN   (0x51)
#define  HOME   (0x47)
#define  END    (0x4F)
#define  F1     (0x3B)
#define  FALSE  (0x00)
#define  TRUE   (0x01)

void ShowData(S_Box *b, int color, int size, char *s[], char *msg)
{
    int  x, yy, write, ind, q, ce, wr;
    char e[80], t, h[]="  Arrows   PgUP   PgDn   Home   End   Esc   [.......]";

    CursorOff();
    b->right = strlen(s[0]) + 3 + b->left;
    q = b->bottom - b->top;
    yy = b->top;
    _attr = color;
    Box(b, SINGLE, msg, SAVE_ON, SHADOW_ON, CLEAR_ON);
    SaveLastLine();
    _attr = __DEF__(112, 63);
    WriteStr(25, 24, h);
    _attr = color;
    for(x = 0; x != q - 1; x++)
	 WriteStr(b->left + 2, ++yy, s[x]);
    ind = 0;
    ce = 0;
    do{
	 write = FALSE;
	 Col(b, ind, size);
	 t = getch();
         if(!t){
	      t = getch();
	      wr = 0;
	      ce = 0;
              switch(t){
                   case  UP    :
                         if(ind){
			     write = TRUE;
                             ind--;
                         }
                         break;
                   case  DOWN  :
			 if(ind <= size - q){
                             ind++;
			     write = TRUE;
                         }
                         break;
                   case  PGUP  :
			 if(ind >= q - 1){
			     ind = ind - q + 1;
			     write = TRUE;
			     break;
                         }
                   case  HOME  :
			 if(ind){
			     ind = 0;
			     write = TRUE;
                         }
                         break;
	PGDOWN:	   case  PGDN  :
			 if(ind + 2 * q <= size + 1){
			     ind = ind + q - 1;
			     write = TRUE;
                             break;
                         }
                   case  END   :
			 if(ind <= size - q){
			     ind = size - q + 1;
			     write = TRUE;
                         }
              }
	 }
	 else{
	      if(t!=27){
		   e[ce++] = t;
		   e[ce] = '\0';
		   for(wr = 0; wr != size; wr++)
			if(!strnicmp(e, s[wr], ce)) break;
		   if(wr==size){
			WriteStr(70, 24, ".......");
			wr = 0;
			ce = 0;
		   }
		   else{
			ind = wr - q + 1;
			wr = 1;
			if(ce<8)
			     WriteChar(69 + ce, 24, t);
			goto PGDOWN;
		   }
	      }
	 }
	 if(write==TRUE)
	      for(x=0; x != q - 1; x++)
		   WriteStr(b->left + 2,b->top + x + 1, s[x+ind]);
    }while(t!=27);
    RestoreVideo();
    RestoreVideo();
    CursorOn();
}





void InitBackGround(char *title, char *company)
{
    char str[80];
    int x;
    S_Box b={0, 3, 79, 23};

    _attr = __DEF__(112, 31);
    EmptyLine(0, 79, 0);
    WriteStr(((79 - strlen(title)) >> 1), 0, title);

    _attr = __DEF__(15, 240);
    EmptyLine(0, 79, 1);
    WriteStr(((79 - strlen(company)) >> 1), 1, company);

    _attr = __DEF__(112, 63);
    EmptyLine(0, 79, 2);
    strcpy(str, "Ruben Romano Borges Barbosa");
    WriteStr(((79 - strlen(str)) >> 1), 2, str);

    EmptyLine(0, 79, 24);
    WriteStr(1, 24, "Op‡”es dispon¡veis ¯¯");

    _attr = __DEF__(15, 159);
    Box(&b, SINGLE, "", SAVE_OFF, SHADOW_OFF, ((_attr==15) ? CLEAR_OFF : CLEAR_ON));

    if(_attr == 159) return;
    CharCopy(str, 78, '±');
    for(x=4; x!=23; x++)
	 WriteStr(1, x, str);
}



static void EmptyLine(int x1, int x2, int y)
{
    char e[81];

    CharCopy(e, x2 -x1 + 1, ' ');
    WriteStr(x1, y, e);
}


void Box(S_Box *b, int style, char *str, int save, int shadow, int clear)
{
    int   x;
    char  c[]="Ú¿ÀÙ³ÄÉ»È¼ºÍ", e[80];

    if(save==SAVE_ON){
	 b->right++;
	 b->bottom++;
	 SaveVideo(b);
	 b->right--;
	 b->bottom--;
    }
    if(shadow==SHADOW_ON)
	 Shadow(b);
    CharCopy(e, b->right - b->left - 1, c[5+style]);
    WriteStr(b->left + 1, b->top   , e);
    WriteStr(b->left + 1, b->bottom, e);
    for(x=b->top+1;x<b->bottom;x++){
	 WriteChar(b->left,  x, c[4+style]);
	 WriteChar(b->right, x, c[4+style]);
    }
    if(clear == CLEAR_ON)
	 Cls(b);
    for(x=0;str[x]!='\0';x++);
    if(x)
	 WriteStr(((b->right + b->left - x) >> 1), b->top, str);
    WriteChar(b->left,  b->top,    c[0+style]);
    WriteChar(b->right, b->top,    c[1+style]);
    WriteChar(b->left,  b->bottom, c[2+style]);
    WriteChar(b->right, b->bottom, c[3+style]);
}




int SaveLastLine(void)
{
    S_Box b={ 25, 23, 79, 24};

    return(SaveVideo(&b));
}


int SaveScreen(void)
{
    S_Box b = {0, 0, 79, 24};

    return(SaveVideo(&b));
}



int SaveVideo(S_Box *b)
{
    int  cont,cal;
    char far *v, far *tmp;
    register int x,y;

    _vm[_screen].left   = b->left;
    _vm[_screen].top    = b->top;
    _vm[_screen].right  = b->right;
    _vm[_screen].bottom = b->bottom;
    _vm[_screen].buffer = (char *)malloc(((b->bottom-b->top+1)*(b->right-b->left+1)<<1));
    if(_vm[_screen].buffer==NULL) return(OUT_OF_MEMORY);
    tmp=__XY__(b->left,b->top);
    for(cont=0,y=b->top; y<=b->bottom; y++){
	 v = tmp;
         tmp+=160;
	 cal = ((b->right-b->left+1)<<1);
	 for(x=0; x<cal; x++)
	      _vm[_screen].buffer[cont++] = *v++;
    }
    _screen++;
    return(OK);
}



void RestoreVideo(void)
{
    int cont,cal;
    char far *v,far *tmp;
    register int x,y;

    _screen--;
    tmp = v=__XY__((_vm[_screen].left),_vm[_screen].top);
    for(cont=0,y=_vm[_screen].top; y<=_vm[_screen].bottom; y++){
	 v = tmp;
	 tmp+= 160;
	 cal = ((_vm[_screen].right-_vm[_screen].left+1)<<1);
	 for(x=0; x<cal; x++)
	      *v++ = _vm[_screen].buffer[cont++];
    }
    free((char *)_vm[_screen].buffer);
}



void WriteChar(int x, int y, char ch)
{
    char far *v;

    v = __XY__(x,y);
    *v++ = ch;
    *v++ = _attr;
}



void WriteStr(int x, int y, char *str)
{
    char far *v;

    v = __XY__(x,y);
    for(; *str ;*v++ = *str++, *v++ = _attr);
}



void ReadStr(int x, int y, int size, char *str)
{
    char far *v;

    v = __XY__(x,y);
    for(; size-- ; *v++, *str++ = *v++);
    *str = '\0';
}



int ReadAttr(int x, int y)
{
    char far *v;

    v = __XY__(x,y);
    *v++;
    return(*v);
}



unsigned char ReadChar(int x, int y)
{
    char far *v;

    v = __XY__(x,y);
    return(*v);
}



void Cls(S_Box *b)
{
    int y;
    char e[80];

    CharCopy(e, b->right - b->left - 1, ' ');
    for(y = b->top + 1; y < b->bottom ; y++)
	 WriteStr(b->left + 1, y, e);
}



void ClrScr(void)
{
    int x;
    char e[80];

    CharCopy(e,79,' ');
    for(x = 0; x != 24; x++)
	 WriteStr(0, x, e);
}



int GetVideoMem(void)
{
    _AH = 0x0012;
    _BL = 0x0010;
    geninterrupt(0x0010);
    return _BL;             /* 03  256 K */
}



int GetVideoMode(void)
{
    _AX = 0x0F00;
    geninterrupt(0x0010);
    return _AL;
}



void SetVideoMode(int mode)
{
    _AH = 0x0000;
    _AL = mode;
    geninterrupt(0x0010);
}



void CursorOn(void)
{
    _AX = 0x0100;
    _CX = 0x0506;
    geninterrupt(0x0010);
}



void CursorOff(void)
{
    _AX = 0x0100;
    _CX = 0x2000;
    geninterrupt(0x0010);
}



void BigCursor(void)
{
    _AX = 0x0100;
    _CX = 0x050E;
    geninterrupt(0x0010);
}



void RestoreCursor(void)
{
    _AH = 0x0001;
    _CX = 0x0D0E;
    geninterrupt(0x0010);
}



void SpeedUp(void)
{
    _AX = 0x0305;
    _BX = 0x0000;
    geninterrupt(0x0016);
}



void SpeedDw(void)
{
    _AX = 0x0305;
    _BX = 0x0212;
    geninterrupt(0x0016);
}



int GetDosVersionH(void)
{
    _AX = 0x3000;
    geninterrupt (0x0021);
    return _AH;
}



int GetDosVersionL(void)
{
    _AX = 0x3000;
    geninterrupt(0x0021);
    return _AL;
}




void BkColors(int colors)
{
    _AX = 0x1003;
    if(colors==16)
	 _BX = 0x0000;
    else
	 _BX = 0x0001;
    geninterrupt(0x0010);
}



int  GetColor(void)
{
    return(_attr);
}



void SetColor(int color)
{
    _old_attr = _attr;
    _attr = color;
}



void RestoreColor(void)
{
    int temp;

    temp = _attr;
    _attr = _old_attr;
    _old_attr = temp;
}



int InitScreen(int windows)
{
    int _modes[] = {3, 2, 7}, e;

    _px = wherex();
    _py = wherey();
    _last_mode = GetVideoMode();
    _mode_was_changed = FALSE;
    if(_last_mode!=3){
	 for(_mode = 0; _mode != 3; _mode++){
	      SetVideoMode(_modes[_mode]);
	      e = GetVideoMode();
	      if(e == _modes[_mode]){
		   _mode = e;
		   break;
	      }
	 }
	 _mode_was_changed = TRUE;
	 if(_mode == 3){
	      printf("\nCan not set video mode...");
	      exit(-1);
	 }
    }
    else
	 _mode = 3;
    if(_mode==7)
	 Vid_Mem = (char far *)__MK_FP__(0xB000);
    else
	 Vid_Mem = (char far *)__MK_FP__(0xB800);
    _max_windows = windows;
    _vm = (Screen *)malloc(sizeof(Screen) * windows);
    if(_vm ==  NULL){
	 printf("\nCan not allocate memory...");
	 exit(-2);
    }
    if(SaveScreen()==OUT_OF_MEMORY){
         printf("\nCan not allocate memory...");
	 exit(-3);
    }
    _video_mem = GetVideoMem();
    BkColors(0x10);
    SpeedUp();
    CursorOff();
    return(_mode);
}




void CloseScreen(void)
{
    if(_mode_was_changed)
	 SetVideoMode(_last_mode);
    RestoreVideo();
    free((Screen *)_vm);
    BkColors(0x08);
    CursorOn();
    gotoxy((int)_px , (int)_py);
}



static void Shadow(S_Box *b)
{
    int oldattr, x;

    oldattr = _attr;
    for(x = b->left + 1; x <= b->right + 1; x++){
	 _attr = (ReadAttr(x, b->bottom + 1) & 0x77);
	 WriteChar(x, b->bottom + 1, ReadChar(x, b->bottom + 1));
    }
    for(x = b->top + 1; x<= b->bottom; x++){
	 _attr = ((ReadAttr(b->right + 1, x) & 0x77));
	 WriteChar(b->right + 1, x, ReadChar(b->right + 1, x));
    }
    _attr = oldattr;
}



void CharCopy(char *s, int q, int ch)
{
    int x;

    for(x = 0; q-- ;s[x++] = ch);
    s[x] = '\0';
}





/*
Rotinass tiradas do meu livro C Avan‡ado
*/

#include "bc.h"

void main(void)
{
    S_Box b;

    InitScreen(10);
    InitBackGround("Bio-computa‡„o", "S‚rie de Inteligˆncia Artificial  -  Parte I    -    v1.0 / 1995");

    b.left = 2;
    b.right = 0;
    b.top = 5;
    b.bottom = 21;
    ShowData(&b, 31, 156, s, "[ Introdu‡„o … bio-computa‡„o ]");

    CloseScreen();
}