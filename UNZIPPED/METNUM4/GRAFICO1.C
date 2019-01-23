#include "parser.h"
#include <alloc.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <graphics.h>


#define MAX	639.0
#define MIN	479.0

FILE *fp = NULL;


void desenha(void)
{
    int i, pontos, ax=0, ay=0;
    char fx1[550], fx2[550];

    float mx, Mx, my, My, incr, _x, _y;

    setcolor(WHITE);
    rectangle(0, 0, MAX, MIN);

    fscanf(fp, "%s\n", fx1);		/* ler a f¢rmula */

    fscanf(fp, "%f\t%f\n", &_x, &_y);
    mx = Mx = _x;			/* procura do menor e do maior */
    my = My = _y;
    pontos = 1;
    while(fscanf(fp, "%f\t%f\n", &_x, &_y)==2){
	 if(_x > Mx)
	      Mx = _x;
	 if(_x < mx)
	      mx = _x;
	 if(_y > My)
	      My = _y;
	 if(_y < my)
	      my = _y;
	 pontos++;
    }

    if(pontos<2){
	 printf("\nERRO: existem poucos pontos definidos para continuar");
	 printf("\nQualquer tecla para sair. . .");
	 getch();
	 closegraph();
	 exit(-3);
    }

    fscanf(fp, "\n%s\n", fx2);		/* ler a f¢rmula */


/****************************************************************/
    /* obter my e My em [mx, Mx] */
    for(i=mx; i!=Mx+1; i++){
	 _y = parse(fx1, i);
	 if(_y > My)
	      My = _y;
	 if(_y < my)
	      my = _y;
    }
    for(i=mx; i!=Mx+1; i++){
	 _y = parse(fx2, i);
	 if(_y > My)
	      My = _y;
	 if(_y < my)
	      my = _y;
    }


/******************************************************************/
    /* desenhar pontos no ‚cran */

    fseek(fp, 0, 0);
    fscanf(fp, "%s\n", fx1);

    i=0;
    while(fscanf(fp, "%f\t%f\n", &_x, &_y)==2){/* escrever pontos de procura */
	 _x = (_x - mx) / (Mx - mx) * MAX;
	 _y = (_y - My) / (My - my) * -MIN;

	 if(i>0){
	      setcolor(LIGHTBLUE);
	      line(ax, ay, _x, _y);
	 }
	 setcolor(YELLOW);
	 circle(_x, _y, 10);
	 i++;
	 ax = _x;
	 ay = _y;

    }

    getch();


/****************************************************************/
    /* desenhar gr ficos */

    setcolor(LIGHTRED);
    incr = mx;
    /* desenhar grafico Lagrange */
    for(i=mx; i!=Mx+1; i++){
	 _y = parse(fx1, i);
	 _y = (_y - My) / (My - my) *  -MIN;
	 _x = (i - mx) / (Mx - mx) * MAX;
	 if(i>incr)
	      line(ax, ay, _x, _y);

	 ax = _x;
	 ay = _y;
    }

    getch();
    setcolor(LIGHTGREEN);
    incr = mx;
    /* desenhar grafico Newton */
    for(i=mx; i!=Mx+1; i++){
	 _y = parse(fx2, i);
	 _y = (_y - My) / (My - my) *  -MIN;
	 _x = (i - mx) / (Mx - mx) * MAX;
	 if(i>incr)
	      line(ax, ay, _x, _y);

	 ax = _x;
	 ay = _y;
    }
    getch();

}




void fim()
{
    closegraph();
    fclose(fp);
    printf("\nOcorreu um erro durante a procura");/* provavelmente overflow */
    exit(0);					/* ou divis„o por 0	*/
}




int main(void)
{
    int gd, gm;

    signal(SIGFPE, fim);

    fp = fopen("RESUL.DAT", "rt");
    if(fp==NULL){
	 printf("\nERRO: ficheiro RESUL.DAT n„o foi encontrado");
	 exit(-1);
    }

    if(registerbgifont(sansserif_font)<0)
	 exit(0);
    if(registerbgidriver(EGAVGA_driver)<0)
	 exit(0);

    gd = DETECT;
    initgraph(&gd, &gm, "");
    if(getmaxx()!=MAX || getmaxy()!=MIN){
	 printf("\nERRO: resolu‡„o pretendida n„o foi atingida");
	 printf("\nQualquer tecla para sair. . .");
	 getch();
	 closegraph();
	 exit(-2);
    }

    setfillstyle(SOLID_FILL, DARKGRAY);
    bar(0, 0, MAX, MIN);

    setcolor(7);
    settextstyle(0, HORIZ_DIR, 2);
    outtextxy(65, 15, "Aproxima‡„o Num‚rica de Fun‡”es");

    settextstyle(3, HORIZ_DIR, 3);
    setcolor(7);
    outtextxy(10, 350, "Legenda");
    setcolor(LIGHTBLUE);
    outtextxy(10, 380, "-> pontos definidos");
    setcolor(LIGHTGREEN);
    outtextxy(10, 410, "-> Newton");
    setcolor(LIGHTRED);
    outtextxy(10, 440, "-> Lagrange");


    desenha();

    closegraph();

    fclose(fp);

    return 0;
}