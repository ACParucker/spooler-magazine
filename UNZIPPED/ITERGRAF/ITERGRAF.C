/*
	ITERGRAF - Interac‡”es Gr ficas 1.0
	       Por Luciano OLiveira

	  Programado em Microsoft Quick C

*/

#include <graph.h>      /* Inserimos os headers */
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <time.h>

#define Random( min, max ) ((rand() % (int)(((max)+1) - (min))) + (min))

struct Linhas           /* Definimos uma struct Linhas */
{
 int LX1, LY1;
 int LX2, LY2;
 int LCor [4];
} Line[100];          /* Inicializamos um array Line da struct Linhas */

int MaxDelta = 16;
int Modo = 1;
int X1 = 320;
int Y1 = 240;
int X2 = 320;
int Y2 = 240;
int CurrentLine    = 0;
int ColorCount     = 0;
int IncrementCount = 0;
int Colors[4];
int DeltaX1, DeltaY1, DeltaX2, DeltaY2;

long int Tempo;
unsigned char Duracao = 0;
unsigned char Ch;

EraseCurrentLine()
{
 _setcolor(0);
 if(Modo == 1 || Modo == 3)
	{
	 _moveto(Line[CurrentLine].LX1, Line[CurrentLine].LY1);
	 _lineto(Line[CurrentLine].LX2, Line[CurrentLine].LY2);

	 _moveto(639 - Line[CurrentLine].LX1, Line[CurrentLine].LY1);
	 _lineto(639 - Line[CurrentLine].LX2, Line[CurrentLine].LY2);

	 _moveto(Line[CurrentLine].LX1, 479 - Line[CurrentLine].LY1);
	 _lineto(Line[CurrentLine].LX2, 479 - Line[CurrentLine].LY2);

	 _moveto(639 - Line[CurrentLine].LX1, 479 - Line[CurrentLine].LY1);
	 _lineto(639 - Line[CurrentLine].LX2, 479 - Line[CurrentLine].LY2);
	}

 if(Modo == 2)
	{
	 _rectangle(_GFILLINTERIOR,Line[CurrentLine].LX1,
				   Line[CurrentLine].LY1,
				   Line[CurrentLine].LX2,
				   Line[CurrentLine].LY2);

	 _rectangle(_GFILLINTERIOR,639 - Line[CurrentLine].LX1,
				   Line[CurrentLine].LY1,
				   639 - Line[CurrentLine].LX2,
				   Line[CurrentLine].LY2);

	 _rectangle(_GFILLINTERIOR,Line[CurrentLine].LX1,
				   479 - Line[CurrentLine].LY1,
				   Line[CurrentLine].LX2,
				   479 - Line[CurrentLine].LY2);

	 _rectangle(_GFILLINTERIOR,639 - Line[CurrentLine].LX1,
				   479 - Line[CurrentLine].LY1,
				   639 - Line[CurrentLine].LX2,
				   479 - Line[CurrentLine].LY2);
	}
}


SelectNewColors()
{
 Colors[0] = Random(0,15) + 1;
 Colors[1] = Random(0,15) + 1;
 Colors[2] = Random(0,15) + 1;
 Colors[3] = Random(0,15) + 1;
 ColorCount = 3*(1+Random(0,5));
};

SelectNewDeltaValues()
{
 DeltaX1 = Random(0,MaxDelta) - (MaxDelta / 2);
 DeltaY1 = Random(0,MaxDelta) - (MaxDelta / 2);
 DeltaX2 = Random(0,MaxDelta) - (MaxDelta / 2);
 DeltaY2 = Random(0,MaxDelta) - (MaxDelta / 2);
 IncrementCount = 2 * (1 + Random(0,4));
};

int AdjustX( int X, int DeltaX)
{
 int TestX;
 TestX = X + DeltaX;
 if ( TestX < 1 || TestX > 639 )
	{
	 TestX = X;
	 DeltaX = -DeltaX;
	}
 return(TestX);
};

int AdjustY( int Y, int DeltaY)
{
 int TestY;
 TestY = Y + DeltaY;
 if ( TestY < 1 || TestY > 479 )
	{
	 TestY = Y;
	 DeltaY = -DeltaY;
	}
 return(TestY);
};

DrawCurrentLine()
{
 int c1, c2, c3, c4;
 c1 = Colors[0];
 c2 = Colors[1];
 c3 = Colors[2];
 c4 = Colors[3];

 if(Modo == 1 || Modo == 3)
	{
	 _setcolor(c1);
	 _moveto(X1,Y1);
	 _lineto(X2,Y2);

	 _setcolor(c2);
	 _moveto(639 - X1, Y1);
	 _lineto(639 - X2, Y2);

	 _setcolor(c3);
	 _moveto(X1, 479 - Y1);
	 _lineto(X2, 479 - Y2);

	 _setcolor(c4);
	 _moveto(639 - X1, 479 - Y1);
	 _lineto(639 - X2, 479 - Y2);
	}

 if(Modo == 2)
	{
	 _setcolor(c1);
	 _rectangle(_GFILLINTERIOR,X1,Y1,X2,Y2);

	 _setcolor(c2);
	 _rectangle(_GFILLINTERIOR,639 - X1, Y1,639 - X2, Y2);

	 _setcolor(c3);
	 _rectangle(_GFILLINTERIOR,X1, 479 - Y1,X2, 479 - Y2);

	 _setcolor(c4);
	 _rectangle(_GFILLINTERIOR,639 - X1, 479 - Y1,639 - X2, 479 - Y2);
	}

 SaveCurrentLine(c1, c2, c3, c4);
}

SaveCurrentLine( int C1, int C2, int C3, int C4)
{
 Line[CurrentLine].LX1     = X1;
 Line[CurrentLine].LY1     = Y1;
 Line[CurrentLine].LX2     = X2;
 Line[CurrentLine].LY2     = Y2;
 Line[CurrentLine].LCor[0] = C1;
 Line[CurrentLine].LCor[1] = C2;
 Line[CurrentLine].LCor[2] = C3;
 Line[CurrentLine].LCor[3] = C4;
};

Updateline()
{
 CurrentLine++;
 if( CurrentLine > 99)
	CurrentLine = 1;
 ColorCount--;
 IncrementCount--;
}


void DoIter()
{
 int i;
 srand( (unsigned)time( NULL ) );
 SelectNewColors();
 while(Ch != 27)
	{
	 if(Modo == 3)
		 srand( (unsigned)time( NULL ) );

	 EraseCurrentLine();

	 if( !IncrementCount )
		SelectNewDeltaValues();

	 if( !ColorCount )
		SelectNewColors();

	 X1 = AdjustX(X1, DeltaX1);
	 X2 = AdjustX(X2, DeltaX2);
	 Y1 = AdjustY(Y1, DeltaY1);
	 Y2 = AdjustY(Y2, DeltaY2);

	 i = Random(0,5);
	 if( i = 3 )
		{
		 X1 = (X1+X2) / 2;
		 Y2 = (Y1+Y2) / 2;
		}
	 DrawCurrentLine();
	 Updateline();

	 if(Duracao)
		_asm
		{
		      sub     ah, ah
		      int     1Ah
		      add     dx, Duracao
		      adc     cx, 0
		      mov     WORD PTR Tempo[0], dx
		      mov     WORD PTR Tempo[2], cx
	      loop1:  int     1AH
		      cmp     dx, WORD PTR Tempo[0]
		      jb      loop1
		      cmp     cx, WORD PTR Tempo[2]
		      jb      loop1
		};

	 if(kbhit())
	 {
	  Ch = getch();
	  if(Ch == 32) /* SPACE */
		{
		 switch(Modo)
		 {
		  case 1:
			_clearscreen(_GCLEARSCREEN);
			Modo = 2;
			Ch = 0;
			break;
		  case 2:
			_clearscreen(_GCLEARSCREEN);
			Modo = 3;
			Ch = 0;
			break;
		  case 3:
			_clearscreen(_GCLEARSCREEN);
			Modo = 1;
			Ch = 0;
			break;
		 }
		}
	  if(Ch == 13) /* ENTER */
		{
		 srand( (unsigned)time( NULL ) );
		 SelectNewColors();
		 SelectNewDeltaValues();
		}
	  if(Ch == 82 || Ch == 114) /* R ou r */
		{
		 Duracao--;
		 if(Duracao ==  255)
			Duracao = 0;
		}
	  if(Ch == 76 || Ch == 108) /* L ou l */
		{
		 Duracao++;
		 if(Duracao ==  0)
			Duracao = 255;
		}
	  if(Ch == 43) /* caracter '+' */
		{
		 MaxDelta++;
		 if(MaxDelta > 100)
			MaxDelta = 100;
		}

	  if(Ch == 45) /* caracter '-' */
		{
		 MaxDelta--;
		 if(MaxDelta < 1)
			MaxDelta = 1;
		}

	  if(Ch == 42) /* caracter '*' */
		MaxDelta = 16;

	  if(Ch == 27)
		return;
	 }
	}
};

main()
{
 int i;

 if( !_setvideomode( _VRES16COLOR ) )
	{
	 printf(" necess ria uma placa VGA.\n");
	 exit(1);
	}
 for( i=0; i < 100; i++)
	{
	 Line[i].LX1 = 320;
	 Line[i].LY1 = 240;
	 Line[i].LX2 = 320;
	 Line[i].LY2 = 240;
	}

 DoIter();

 _setvideomode( _DEFAULTMODE );
 printf("Iterac‡”es Gr ficas 1.0\n");
 printf("1993 - Luciano Oliveira\n\n");
 printf("Comandos:\n");
 printf("         Esc   - Termina o programa.\n");
 printf("         Space - Altera o tipo de iterac‡„o.\n");
 printf("         Enter - Altera os valores de cor e de c lculo.\n");
 printf("         R     - Acelera o algoritmo de desenho.\n");
 printf("         L     - Retarda o algoritmo de desenho.\n");
 printf("         +     - Aumenta as linhas de desenho.\n");
 printf("         -     - Diminui as linhas de desenho.\n");
 printf("         *     - Restabelece o valor inicial das linhas.\n");
}
