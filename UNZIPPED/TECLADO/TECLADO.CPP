#include<dos.h>
#include<conio.h>
#include<stdio.h>

void teclado_drw(void);
void mostra(int *x,int *z,unsigned bit,char *s);
void putf(int *y,int *x,char *s);
void mostra_b(int *y,int *x,char *s,unsigned bit);


typedef struct keyboard {
  unsigned shiftRight  : 1;     /*  flags do teclado*/
  unsigned shiftLeft   : 1;
  unsigned ctrl        : 1;
  unsigned alt         : 1;
  unsigned scrollLock  : 1;
  unsigned numLock     : 1;
  unsigned capsLock    : 1;
  unsigned insert      : 1;
} Keyboard;


main()
{

keyboard far *tecla;
keyboard old;
int done=0;
int y,x,z;
tecla=(keyboard far *)MK_FP(0x0040,0x0017);/*linha explicada no artigo*/

textbackground(BLACK);
clrscr();
teclado_drw();
while(!done)
	{

	x=75;z=6;
	mostra(&x,&z,tecla->numLock,"Num");
	z=10;x=2;
	mostra(&x,&z,tecla->capsLock,"CapsLock");
	z=3;x=65;
	mostra(&x,&z,tecla->scrollLock,"ScL");
	z=6;x=61;
	mostra(&x,&z,tecla->insert,"Ins");

	x=7;z=14;
	mostra(&x,&z,tecla->alt,"Alt ");
	x=2;z=12;
	mostra(&x,&z,tecla->shiftLeft,"Shift");
	x=50;z=12;
	mostra(&x,&z,tecla->shiftRight,"  Shift  ");
	x=2;z=14;
	mostra(&x,&z,tecla->ctrl,"Ctrl");
	textbackground(BLACK);

	y=16;x=1;
	putf(&y,&x,"Estados Permanentes");
	y++;
	mostra_b(&y,&x,"NumLock    =",tecla->numLock);
	mostra_b(&y,&x,"CapsLock  = ",tecla->capsLock);
	mostra_b(&y,&x,"ScrollLock =",tecla->scrollLock);
	mostra_b(&y,&x,"Insert    = ",tecla->insert);

	y=16;x=40;
	putf(&y,&x,"Estados Tempor═rios");
	y++;
	mostra_b(&y,&x,"Alt       =",tecla->alt);
	mostra_b(&y,&x,"ShiftLeft =",tecla->shiftLeft);
	mostra_b(&y,&x,"ShiftRight =",tecla->shiftRight);
	mostra_b(&y,&x,"Ctrl       =",tecla->ctrl);
	y++;
	x=19;
	putf(&y,&x,"Ctrl Alt termina");




	done=(tecla->ctrl& tecla->alt);/*se tecla=ctrl e alt sai*/

	}
clrscr();
printf("Bruno Aleixo 1994");
 return 0;
}

void mostra(int *x,int *z,unsigned bit,char *s)/*x e z sao as coordenadas,v retorna 1 se tecla premida 0 se nao,s escreve para o ecran*/
{
 gotoxy(*x,*z);	if(bit==1) textbackground(YELLOW); else if (bit==0) textbackground(BLACK);
	    cputs(s);
}

void teclado_drw(void)

{
clrscr();
printf("\nзддд© здддбдддбддбддд© здддбдддбдддбддд© здддбдддбдддбддд© здддбдддбддд©       ");
printf("\nЁ   Ё Ё   Ё   Ё  Ё   Ё Ё   Ё   Ё   Ё   Ё Ё   Ё   Ё   Ё   Ё Ё   ЁScLЁ   Ё       ");
printf("\nюддды юдддадддаддаддды юдддадддадддаддды юдддадддадддаддды юдддадддаддды       ");
printf("\nзддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©здддбдддбддд© здддб ");
printf("\nЁ                                                         ЁЁInsЁ   Ё   Ё ЁNumЁ ");
printf("\nцддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢цдддедддеддд╢ цддде ");
printf("\nЁ                                                         ЁЁ   Ё   Ё   Ё Ё   Ё ");
printf("\nцддддддддбдддддддддддддддддддддддддддддддддддддддддддддддд╢юдддадддаддды цддде ");
printf("\nЁCapsLockЁ                                                Ё              Ё   Ё ");
printf("\nцдддддбддаддддддддддддддддддддддддддддддддддддддбддддддддд╢              цддде ");
printf("\nЁShiftЁ                                         Ё  Shift  Ё              Ё   Ё ");
printf("\nцддддбадддбдддддддддддддддддддддддддддддддддддбдаддддбдддд╢              цддда ");
printf("\nЁCtrlЁAlt Ё                                   Ё      Ё    Ё              Ё     ");
printf("\nюддддаддддадддддддддддддддддддддддддддддддддддаддддддадддды              юдддд ");
}

void putf(int *y,int *x, char *s)
{
gotoxy(*x,*y);
cputs(s);
(*y)++;

}
void mostra_b(int *y,int *x,char *s,unsigned bit)
{
	putf(y,x,s);
	cprintf("%u",bit);/*mostra 1 se tecla premida,0 se nao*/
}
