/*

    Ficheiro: TAPEVIDEO.C
	Descri‡„o: Rotinas de manipula‡„o do video.
    Programa‡„o por: Carlos Ladeira     23/03/1994

*/

#include <dos.h>
#include "tape.h"

word far *CRT_addr=(word far *) 0x00000463;
enum {MONO, COLOR} video;
char far *VidAddr;
Palt mono ={0x70, 0x70, 0x07, 0x0F, 0x70},
     color={0x71, 0x74, 0x17, 0x1F, 0x7E},
     *pal;


void InitVideo(void)
{
  if (*CRT_addr==0x3B4) {
    VidAddr=(char far *) 0xB0000000L;
    SetVideoMode(7);
    pal=&mono;
    video=MONO;
    }
  else {
    VidAddr=(char far *) 0xB8000000L;
    SetVideoMode(3);
    pal=&color;
    video=COLOR;
    }
}

void SetVideoMode(char mode)
{
  union REGS r;

  r.h.ah=0x00;
  r.h.al=mode;
  int86(0x10, &r, &r);
}

void SetCursorSize(byte start, byte end)
{
  union REGS r;

  r.h.ah=1;
  r.h.ch=start;
  r.h.cl=end;
  int86(0x10, &r, &r);
}

void GotoXY(byte x, byte y)
{
  union REGS r;

  r.h.ah=2;
  r.h.bh=0;
  r.h.dh=y;
  r.h.dl=x;
  int86(0x10, &r, &r);
}

void BlockCls(byte x1, byte y1, byte x2, byte y2, byte attr)
{
  union REGS r;

  r.h.ah=6;
  r.h.al=0;
  r.h.ch=y1;
  r.h.cl=x1;
  r.h.dh=y2;
  r.h.dl=x2;
  r.h.bh=attr;
  int86(0x10, &r, &r);
}

void CursorSmall(void)
{
  if (video==MONO) SetCursorSize(12, 13);
  else SetCursorSize(6, 7);
}

void CursorOff(void)
{
  SetCursorSize(0x20, 0x20);
}

void XYStr(byte x, byte y, byte attr, char *str)
{
  char far *v;

  v=vid_addr(x, y);
  while (*str) {
    *v++=*str++;
    *v++=attr;
    }
}

void XYCh(byte x, byte y, byte attr, byte chr)
{
  char far *v;

  v=vid_addr(x, y);
  *v++=chr;
  *v=attr;
}

void WriteStr(byte x1, byte y1, byte x2, byte y2, byte attr, char *str)
{
  char far *v, far *w;
  register int i, j;

  w=v=vid_addr(x1, y1);
  for (i=y1; i<=y2; i++) {
    for (j=x1; j<=x2; j++) {
      if ((*str!='\n') && (*str)) *v++=*str++;
      else *v++=32;
      *v++=attr;
      }
    if (*str=='\n') str++;
    w+=160;
    v=w;
    }
}

void Box(byte x1, byte y1, byte x2, byte y2, byte attr)
{
  char far *v;
  register int i;

  v=vid_addr(x1, y1);
  *v++=218;
  *v++=attr;
  for (i=x1+1; i<x2; i++) {
    *v++=196;
    *v++=attr;
    }
  *v++=191;
  *v++=attr;

  v=vid_addr(x1, y2);
  *v++=192;
  *v++=attr;
  for (i=x1+1; i<x2; i++) {
    *v++=196;
    *v++=attr;
    }
  *v++=217;
  *v++=attr;

  v=vid_addr(x1, (y1+1));
  for (i=y1+1; i<y2; i++) {
    *v++=179;
    *v++=attr;
    v+=158;
    }

  v=vid_addr(x2, (y1+1));
  for (i=y1+1; i<y2; i++) {
    *v++=179;
    *v++=attr;
    v+=158;
    }
}
