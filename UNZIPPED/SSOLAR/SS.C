/*
Programa Sistema Solar - Bugs
Rua Carlos Malheiro Dias, 119 - 2§
4200 Porto
*/

#include <graphics.h>
#include <time.h>
#include <conio.h>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include <dos.h>

#define	MAX_PLANETAS	9
#define	VEZES		0.1


/*
Cores atribu¡das aos planetas.
*/
int cores[] = {
    LIGHTRED,
    RED,
    CYAN,
    BROWN,
    LIGHTGRAY,
    LIGHTMAGENTA,
    GREEN,
    BLUE,
    LIGHTGRAY
};

/*
Distƒncias m‚dias dos planetas ao sol em mil Km.
*/
unsigned double dm_s[MAX_PLANETAS] = {
    70000.0,	/* merc£rio	*/
   108140.0,	/* v‚nus	*/
   150000.0,	/* terra	*/
   227800.0,	/* marte	*/
   777700.0,	/* j£piter	*/
  1430000.0,	/* saturno	*/
  2870000.0,	/* £rano	*/
  4494000.0,	/* neptuno	*/
  5900000.0	/* plut„o	*/
};

/*
Raios dos planetas em km.
*/
double raio[1+MAX_PLANETAS] = {
    700000.0,
      2400.0,
      6100.0,
      6378.0,
      3390.0,
     71350.0,
     60000.0,
     23550.0,
     25000.0,
      3000.0
};


/*
Dias que demoram a dar uma volta completa ao sol.
*/
unsigned long periodo_sideral[MAX_PLANETAS] = {
     88L,
    225L,
    365L,
    687L,
   4329L,
  10753L,
  30664L,
  60148L,
  90677L
};

int X, Y, X0=0;
int ampl = 0;

void info(char *titulo);
void ambiente(char *titulo);

int main(void)
{
    char t;
    int gd, gm;
    unsigned int  i, j, col, del=20;
    char *titulo = "Sistema Solar";
    double ang, h, x, y, ant_x[MAX_PLANETAS], ant_y[MAX_PLANETAS];


    if(registerbgifont(gothic_font)<0)
	 exit(0);
    if(registerbgidriver(EGAVGA_driver)<0)
	 exit(0);

    randomize();
    gd = DETECT;
    initgraph(&gd, &gm, "");

    X = getmaxx();		/* somar 5000 para ampliar */
    Y = getmaxy();

    setcolor(LIGHTGRAY);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, 3);
    col = (X - textwidth(titulo)) / 2;
    outtextxy(col, 10, titulo);

    setcolor(YELLOW);
    circle(X0, Y/2, raio[0]/2400.0);		/* sol */
    putpixel(X0, Y/2, YELLOW);

    for(i=0; i!=MAX_PLANETAS; i++)
    {
	 setcolor(cores[i]);
	 circle(X0+dm_s[i]*X/5900000.0, Y/2, raio[i+1]/2400.0);	/* planetas */
	 setcolor(DARKGRAY);
								/* ¢rbitas */
	 ellipse(X0, Y/2, 0, 360, dm_s[i] * X/5900000.0, dm_s[i] * X/5900000.0);

	 ant_x[i] = dm_s[i] * X/5900000.0;
	 ant_y[i] = Y/2;

	 for(j=0; j!=20; j++)				/* estrelas */
	      putpixel(random(X), random(Y), LIGHTGRAY);

    }


    /* cintura principal de aster¢ides */
    setcolor(LIGHTGRAY);
    for(i=0; i!=8; i+=2)
	 circle(X0, Y/2, 17+dm_s[3] * X/5900000.0+i);



    /* anima‡„o dos planetas */

    i=0;
    while(1)
    {
	 for(; ; i++)
	 {
	      for(j=0; j!=MAX_PLANETAS; j++)
	      {
		   h = (double)i * VEZES / periodo_sideral[j]; /* resultado em dias */
		   ang = (double)h * 360.0 /*/ periodo_sideral[j]*/; /* resultado em graus */


                   x = dm_s[j] * X/5900000.0 * cos(ang);
		   y = sin(ang) * dm_s[j]*X/5900000.0+Y/2;

		   if((int)ant_x[j] !=(int)x || (int)ant_y[j]!=(int)y)
		   {
			setcolor(BLACK);
			if(j==5 || j==6 || j==7 || j==4)
			     circle(X0+ant_x[j], ant_y[j], raio[j+1]/2400.0); /* apagar */
			else{
			     setfillstyle(SOLID_FILL, 0);
			     pieslice(X0+ant_x[j], ant_y[j], 0, 360, raio[j+1]/2400.0);
			}

			setcolor(DARKGRAY);
			/* ¢rbitas */
			ellipse(X0, Y/2, 0, 360, dm_s[j] * X/5900000.0, dm_s[j] * X/5900000.0);

			setcolor(cores[j]);

			if(j==5 || j==6 || j==7 || j==4)
			     circle(X0+x, y, raio[j+1]/2400.0); /* nova posi‡„o do planeta*/
			else{
			     setfillstyle(SOLID_FILL, cores[j]);
			     pieslice(X0+x, y, 0, 360, raio[j+1]/2400.0);
			}

			ant_x[j] = x;
			ant_y[j] = y;
                   }
		   if(kbhit())
		   {
			t = getch();
			if(!t)
			{
			     t = getch();
			     switch(t)
			     {
				  case 72:
				       if(del>=4)
					    del-=4;
				       else
					    printf("\a");
				       break;
				  case 80:
				       del+=4;
				       break;
				  case 77:
				       clearviewport();
				       X +=1000;
				       X0+=(int)dm_s[0] * X/5900000.0;
				       ampl++;
				       ambiente(titulo);
				       break;
				  case 75:
				       if(ampl>=1)
				       {
					    ampl--;
					    clearviewport();
					    X -=1000;
					    X0-=(int)dm_s[0] * X/5900000.0;
                                            ambiente(titulo);
				       }
                             }
			}
			else{
			     switch(t)
			     {
				  case 27:
				       closegraph();
				       exit(0);
				  case 'i':
				  case 'I':
				       info(titulo);
			     }
			}
		   }
		   delay(del);
	      }
	 }
    }
    closegraph();

    return 0;
}



void ambiente(char *titulo)
{
    int i, col;

    setcolor(YELLOW);
    circle(X0, Y/2, raio[0]/2400.0);		/* sol */
    putpixel(X0, Y/2, YELLOW);
    setcolor(11);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, 3);
    col = (X - textwidth(titulo)) / 2;
    outtextxy(col, 10, titulo);

    /* cintura principal de aster¢ides */
    setcolor(LIGHTGRAY);
    for(i=0; i!=8; i+=2)
	 circle(X0, Y/2, 17+dm_s[3] * X/5900000.0+i);

    for(i=0; i!=20*9; i++)
	 putpixel(random(X), random(Y), LIGHTGRAY);
}

void info(char *titulo)
{
    int i;
    char str[80];
    char *planeta[] = {
	 "merc£rio",
	 "v‚nus",
	 "terra",
	 "marte",
	 "j£piter",
	 "saturno",
	 "£rano",
	 "neptuno",
	 "plut„o"
    };

    char *periodo_rotacao_sideral[] = {
	 " 58.5 d",
	 "243   d",
	 "23h 56m",
	 "24h 37m",
	 " 9h 51m",
	 "10h 14m",
	 "10h 48m",
	 "14h 00m",
	 " 9h +6d"
    };

    char *velocidade_orbital[] = {
	 "48.0",
	 "35.0",
	 "30.0",
	 "24.0",
	 "13.0",
	 "10.0",
	 " 6.8",
	 " 5.4",
	 " 4.8"
    };

    char *velocidade_de_escape[] = {
	 " 4.2",
	 "10.2",
	 "11.2",
	 " 5.0",
	 "60.0",
	 "35.0",
	 "22.5",
	 "25.0",
	 "Desc"
    };

    char *temperatura_maxima_a_superficie[] = {
	 " 410 ?",
	 " 530 ?",
	 "  60  ",
	 "  30  ",
	 "-130  ",
	 "-150  ",
	 "-190  ",
	 "-220  ",
	 "Desc  "
    };
    int m;

    m = getgraphmode();
    restorecrtmode();
    gotoxy(1, 1);
    printf("\nÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿\n");
    printf("³Planeta    Raio  D. M‚dia ao   P. Sid.  P. Rota‡„o  V.Orb.  V.Esc.  Temp.M x.³\n");
    printf("³           (Km)  Sol (1000Km)  (dias)   Sid.(horas) (Km/s)  (Km/s)  Sup.(C)  ³\n");
    printf("ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´\n");
    for(i=0; i!=9; i++)
    {
	 sprintf(str, "%-10s%5.0f%11.0f%10ld%12s%9s%8s%10s",
	       planeta[i], raio[i+1], dm_s[i], periodo_sideral[i],
	       periodo_rotacao_sideral[i], velocidade_orbital[i],
	       velocidade_de_escape[i], temperatura_maxima_a_superficie[i]);
	 printf("³%s  ³\n", str);
    }
    printf("ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ\n");
    printf("Raio..............diƒmetro do planeta / 2;\n");
    printf("D. M‚dia ao Sol...distƒncia m‚dia ao Sol;\n");
    printf("P. Sid............per¡odo  sideral. Tempo gasto a concluir uma rota‡„o em torno\n");
    printf("                  do Sol;\n");
    printf("P. Rota‡„o Sid....per¡odo de rota‡„o sideral;\n");
    printf("V. Orb............velocidade orbital m‚dia;\n");
    printf("V. Esc............velocidade de escape. Velocidade m¡nima requerida para que um\n");
    printf("                  objecto,  sem  recorrer  a impulsos al‚m do inicial, se possa\n");
    printf("                  libertar   da  ac‡„o  grav¡tica  de  um  planeta,  supondo  a\n");
    printf("                  resistˆncia da atmosfera inexistente;\n");
    printf("Temp.M x.Sup......temperatura m xima … superf¡cie;");


    getch();

    setgraphmode(m);

    ambiente(titulo);
}