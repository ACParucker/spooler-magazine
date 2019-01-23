#include <dos.h>
#include <conio.h>
#include <stdio.h>

#define  TEXT                   (0x1)
#define  NOT_TEXT		(0x0)
#define  _XY_(x, y)		(Vid_Mem + (((y * 80) + x) << 1))


static char far *Vid_Mem = NULL;


void WriteChar(int x, int y, char ch, int attr)
{
    char far *v;

    v=_XY_(x, y);
    *v++ = ch;
    *v++=  attr;
}



void WriteStr(int x, int y, char *str, int attr)
{
    char far *v;

    v = _XY_(x, y);
    for(; *str; *v++ = *str++, *v++ = attr);
}



int GetVideoMode(void)
{
    _AX = 0x0F00;
    geninterrupt(0x10);
    return _AL;
}



int InitScreen(void)
{
    int mode;

    mode = GetVideoMode();
    if(mode != 2 && mode != 3 && mode != 7)
	 return NOT_TEXT;

    if(mode == 7)
	 Vid_Mem = (char far *)MK_FP(0xB000, 0x0);
    else
	 Vid_Mem = (char far *)MK_FP(0xB800, 0x0);

    return TEXT;
}



void BkColors(int colors)
{
    _AX = 0x1003;
    if(colors==16)
	 _BX = 0x0;
    else
	 _BX = 0x1;
    geninterrupt(0x10);
}



int main(void)
{
    int mode, i;
    int attr[] = {31, 241, 159, 127, 79, 207};
    char str[10];

    mode = InitScreen();
    if(mode != TEXT){
	 printf("Modo texto n„o est  presente...\n");
	 return -1;
    }

    BkColors(8);
    for(i=0; i!=6; i++){
	 WriteStr(0, i+1, "  . .  . Isto ‚ um teste . . .                     atributo                     ", attr[i]);
	 itoa(attr[i], str, 10);
	 WriteStr(60, i+1, str, attr[i]);
    }
    getch();

    BkColors(16);

    return 0;
}
