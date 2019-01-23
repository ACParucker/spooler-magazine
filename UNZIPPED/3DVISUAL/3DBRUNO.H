//Header do 3DVISUAL por Bruno Shirley Possolo.

#include <graphics.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <dos.h>
#include "rato.h"

#define PI 3.141592654
#define MAXv 100 //Aceita figuras at‚ 100 vertices
#define MAXa 50  //Aceita figuras at‚ 50 arestas

int VRT;
int ART;
int 	x[MAXv],y[MAXv],z[MAXv],
	i[MAXa],j[MAXa],
	u[MAXv],v[MAXv],w[MAXv],
	m1[MAXv],n1[MAXv],m2[MAXv],n2[MAXv];
int limpa=0;


//Rotinas Graficas
void iniciaGR(void);
void fimGR(void);
//Matematicas
int round(float n);
float radianos(float graus);
//Varios
int load(char *nome);
void tecla(int x1,int y1,int x2,int y2,int prime,char *str);
//3DROT
void rotacao(	float A, float B, float C,
		int Tx, int Ty,
		float zoom, int cor, int fundo);
void ver(int zoom,int cor,int fundo);



void iniciaGR(void)
{
	int grdrive,grmode,errorcode;

	grdrive=DETECT;
	initgraph(&grdrive,&grmode,"\\BORLANDC\\BGI");
	errorcode=graphresult();
	if (errorcode!=grOk)
	{
		printf("\nErro no modo de iniciar graficos");
		exit(1);
	}
}

void fimGR(void) { closegraph(); }

int round(float n) { return ((int) (n+0.5)); }

float radianos(float graus) { return graus*PI/180; }

int load(char *nome)
{
	FILE *in;
	int ct;

	if ((in = fopen(nome,"rb"))== NULL)
	{
		fprintf(stderr, "Erro a abrir %s \n",nome);
		return 1;
	}
	if (!feof(in))
	{
		VRT=getw(in);
		for(ct=0;ct<VRT;ct++)
		{
			x[ct]=getw(in);
			y[ct]=getw(in);
			z[ct]=getw(in);
		}
		ART=getw(in);
		for(ct=0;ct<ART;ct++)
		{
			i[ct]=getw(in);
			j[ct]=getw(in);
		}
	}
	fclose(in);
	return 0;
}

void tecla(int x1,int y1,int x2,int y2,int prime,char *str)
{
	int COR,cor1=7,cor2=8;

	if(prime!=0) cor1=8;
	setfillstyle(1,cor2);
	bar(x1,y1,x2,y2);
	setfillstyle(1,cor1);
	bar(x1+2,y1+2,x2-2,y2-2);
	outtextxy(x1+4,y1+abs(y1-y2)/2,str);
}

/****************************************************************************
FUN€ÇO ROTA€¶O ‚ baseada nos EIXOS x,y,z

 + X
  |
  |       / + Y
  |     /
  |   /
  | /
  |--------------- + Z
 O
****************************************************************************/
// Rota‡Æo Isom‚trica
void rotacao(	float A, float B, float C,
		int Tx, int Ty,
		float zoom, int cor, int fundo)
{
	int ct,xx,yy,zz;

	A=radianos(A);
	B=radianos(B);
	C=radianos(C);


	for(ct=0;ct<VRT;ct++)	//EIXO OZ
	{
		xx=x[ct]*zoom; yy=y[ct]*zoom; zz=z[ct]*zoom;
		u[ct]=round((xx*cos(A)-yy*sin(A))); //x'
		w[ct]=round((xx*sin(A)+yy*cos(A))); //y'
		v[ct]=round(zz);                    //z'
	}
	for(ct=0;ct<VRT;ct++)   //EIXO OX
	{
		v[ct]=round(w[ct]*cos(B)-v[ct]*sin(B)); //y'
		w[ct]=round(w[ct]*sin(B)+v[ct]*cos(B)); //z'
	}
	for(ct=0;ct<VRT;ct++)   //EIXO OY
	{
		xx=u[ct];
		u[ct]=Tx+round(u[ct]*cos(C)+v[ct]*sin(C)); //x'
		v[ct]=Ty+round(-xx*sin(C)+v[ct]*cos(C));   //z'
	}
	ver(zoom,cor,fundo);
}

void ver(int zoom,int cor,int fundo)
{
	int ct,dbm;

	if(zoom<=0)  cor=fundo;
	if (limpa==1)
	{
		ct=0;
		do {

			setcolor(fundo);
			line( 	m1[ct],n1[ct],
				m2[ct],n2[ct]);
		}while (++ct<ART);
	}
	setcolor(cor);
	ct=0;
	do {
		m1[ct]=u[i[ct]-1];
		n1[ct]=v[i[ct]-1];
		m2[ct]=u[j[ct]-1];
		n2[ct]=v[j[ct]-1];
		line( 	m1[ct],n1[ct],
			m2[ct],n2[ct]);
	}while (++ct<ART);
}

