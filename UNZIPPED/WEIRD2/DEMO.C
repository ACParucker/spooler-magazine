// WEIRD 2 - DEMO ˛ por Tiago Ribeiro ˛ Junho 94

#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include "weird2.h"
#include "clock.h"

void PrintText(char *);
int  demo_menu(void);
void pausa(void);
void Demo1(void);
void Demo2(void);
void Demo3(void);
void Demo4(void);
void Demo5(void);
void Demo6(void);
void Demo7(void);
void GoingOut(void);

void main(void)
{
 int op;

 while(1)
 {
  op=demo_menu();
  clrscr();
  switch(op)
  {
   case 1 : Demo1();  break;
   case 2 : Demo2();  break;
   case 3 : Demo3();  break;
   case 4 : Demo4();  break;
   case 5 : Demo5();  break;
   case 6 : Demo6();  break;
   case 7 : Demo7();
  }
 }
}

int demo_menu(void)
{
 clrscr();

 printf("                                                             ‹€€€€€€€€€€€€€ﬂ \n");
 printf("‹€          ‹€  ‹€€€€€ﬂ ‹€€€€€€ﬂ  ‹€€€€€€‹     ‹€€€€            €€€   €€€    \n");
 printf(" €€        €€  €€         €€€    €€ﬂ    ‹€€   €€   €€          €€€   €€€     \n");
 printf("  €€   ‹  €€  €€€€ﬂ      €€€    €€€€€€€€€ﬂ   €€    €€         €€€   €€€      \n");
 printf("   €€‹€€‹€€  €€         €€€    €€€   €€‹    €€    €€         €€€   €€€       \n");
 printf("    €ﬂ  €ﬂ  ‹€€€€€€ﬂ ‹€€€€€€ﬂ ‹€€     ﬂ€€‹ ‹€€€€€€ﬂ         €€€   €€€        \n");
 printf("                                                         ‹€€€€€€€€€€€€ﬂ      \n\n");
 printf("                  por Tiago Ribeiro ˛ DEMONSTRAÄéO ˛ Junho 94");
 printf("\n\n\n\n");
 printf("                 1. x_PrintScr()    \n");
 printf("                 2. x_MotorOff()    \n");
 printf("                 3. x_KeyLights()   \n");
 printf("                 4. x_IsColor()     \n");
 printf("                 5. x_NumDrives     \n");
 printf("                 6. x_Coprocessor() \n");
 printf("                 7. x_StartClock(), x_StopClock(), \n");
 printf("                    x_HideClock(),  x_ShowClock(), \n");
 printf("                    x_ClockColor(), x_ClockPos()   \n\n");
 printf("                 0. Sair        \n");

 while(1)
 {
  switch(getch())
  {
   case '1': return 1;
   case '2': return 2;
   case '3': return 3;
   case '4': return 4;
   case '5': return 5;
   case '6': return 6;
   case '7': return 7;
   case '0': GoingOut();
  }
 }
}

void pausa(void)
{
 textcolor(LIGHTRED+BLINK);
 cprintf("Prime uma tecla para continuar ...\r");
 getch();
 delline();
 textcolor(LIGHTGRAY);
}

void GoingOut(void)
{
 exit(0);
}

void PrintText(char *Ficheiro)
{
 FILE *in;
 char InChar, linha[80];
 int countlinhas = 0;

 if ((in = fopen(Ficheiro, "rt")) == NULL )
 {
  printf("Erro na abertura do ficheiro %12s\n", Ficheiro);
  abort();
 }

 while(!feof(in))
 {
  InChar = fgetc(in);
  if (InChar == '\n')
   countlinhas++;

  printf("%c", InChar);

  if (countlinhas == 20)
  {
   pausa();
   countlinhas = 0;
  }
 }

 fclose(in);
}

void Demo1(void)
{
 byte valor;

 PrintText("#1A.BLA");
 printf("\n");
 pausa();
 valor = x_PrintScr();
 printf("\n");

 switch(valor)
 {
  case PRINT_COMPLETE : textcolor(GREEN);
						cprintf("OperaáÑo completada com sucesso."); break;
  case PRINT_PROGRESS : textcolor(GREEN);
						cprintf("OperaáÑo a decorrer.");             break;
  case PRINT_ERROR    : textcolor(RED);
						cprintf("ERRO : operaáÑo sem sucesso.");     break;
 }
 textcolor(LIGHTGRAY);
 printf("\n\n\n");
 pausa();
}

void Demo2(void)
{
 byte factor = -1;

 PrintText("#2A.BLA");
 printf("\n");

 printf("Factor de delay [0..9]: ");
 while (factor<0 || factor>9)
  factor = (getch() - '0');

 printf("%1d\"™n", factor);

 x_MotorOff((factor*10));

 pausa();
}

void Demo3(void)
{
 byte TabKey[3]={1,1,1}, OldVal, NewVal;

 PrintText("#3A.BLA");
 printf("\n");

 NewVal = 0;
 OldVal = x_KeyLights( NewVal );   // Armazena estado corrente

 randomize();

 do
 {
   switch(random(3))
   {
	 case 0    : TabKey[0]=!TabKey[0]; break;
	 case 1    : TabKey[1]=!TabKey[1]; break;
	 case 2    : TabKey[2]=!TabKey[2];
   }
   NewVal = TabKey[0]*KEY_SCROLLLOCK + TabKey[1]*KEY_NUMLOCK +
			TabKey[2]*KEY_CAPSLOCK;
   x_KeyLights ( NewVal );
   delay(300);
 } while (!kbhit());

 x_KeyLights( OldVal);    // Repîe estado inicial
}

void Demo4(void)
{
 PrintText("#4A.BLA");

 if (x_IsColor())
  printf("\n\nAlta tecnologia p† ! Tens cores por todo o lado !\n");
 else
  printf("\n\nEntÑo meu ? Ainda vives na idade-da-pedra ?\n");

 pausa();
}

void Demo5(void)
{
 int NDrives = 0;

 PrintText("#5A.BLA");

 NDrives = x_NumDrives();
 switch(NDrives)
 {
  case 0    : printf("\n\nO quà ? NÑo podes usar disquetes !"); break;
  case 1    : printf("\n\nCoitado ! S¢ podes meter disquetes num sitio !");
			  break;
  default   : printf("\n\nUAAUUU ! Tens ",
					 "%d sitios diferentes para pores disquetes", NDrives);
 }

 printf("\n\n");
 pausa();
}

void Demo6(void)
{
 PrintText("#6A.BLA");
 clrscr();
 PrintText("#6B.BLA");

 if (x_Coprocessor())
  printf("\n\nTens um coprocessador numÇrico ",
		 "(ou entÑo disfaráas muito bem !)\n\n");
 else
  printf("\n\n2 + 2 = 5 ! NÑ... Acho que nÑo tens coprocessador numÇrico\n\n");

 pausa();
}

void Demo7(void)
{
 byte OldLed, Tecla=0, Lin=0, Col=0, CorFore=YELLOW, CorBack=RED, move=0;
 char Buffer[4096];

 PrintText("#7A.BLA");
 pausa();
 clrscr();

 printf(" Teclas disponiveis:\n\n");
 printf("   8 , 2     ->     Cima / baixo\n");
 printf("   4 , 6     ->     Esquerda / direita\n\n");
 printf("   + , -     ->     Muda a cor das letras (ou numeros, como queiram !)\n");
 printf("   * , /     ->     Muda a cor de fundo (do rel¢gio, of course !)\n\n");
 printf("   ENTER     ->     THE PARTY IS OVER ...");

 OldLed = x_KeyLights( KEY_NUMLOCK );  // Liga o Num Lock
 gettext(1, 1, 80, 25, Buffer);
 x_StartClock(Lin, Col, CorFore, CorBack); // Inicializa e mostra o rel¢gio

 do
 {
  Tecla = getch();
  switch( Tecla )
  {
   case '8' : if ( Lin > 0 )  Lin--; move=1; break;
   case '2' : if ( Lin < 24 ) Lin++; move=1; break;
   case '4' : if ( Col > 0 )  Col--; move=1; break;
   case '6' : if ( Col < 72 ) Col++; move=1; break;
   case '+' : if ( CorFore != 15 )
			   CorFore++;
			  else
			   CorFore = 0;          break;
   case '-' : if ( CorFore != 0 )
			   CorFore--;
			  else
			   CorFore = 15;         break;
   case '*' : if ( CorBack!= 7 )
			   CorBack++;
			  else
			   CorBack = 0;          break;
   case '/' : if ( CorBack != 0 )
			   CorBack--;
			  else
			   CorBack = 7;
  };

  if (move)
  {
   puttext(1, 1, 80, 25, Buffer);
   x_ClockPos(Col, Lin);
   move=0;
  }
  x_ClockColor(CorFore, CorBack);
 } while ( Tecla != 13);

 x_StopClock();                        // Desliga o rel¢gio
 x_KeyLights( OldLed );                // Repîe o estado inicial dos LEDs
}
