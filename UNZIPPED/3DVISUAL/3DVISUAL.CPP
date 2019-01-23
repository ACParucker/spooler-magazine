//3DVISUAL v1.0 por BRUNO SHIRLEY POSSOLO

#include <math.h>
#include <conio.h>
#include <dir.h>
#include "3dbruno.h"

int maxx, maxy, mx, my, ratx, raty;

void control(void);
void HELP(void);
void MAINload(void);

int main(void)
{
	int ch,rx=20,ry=80,rz=0,ler,cc;
	int cor=2,fundo=0;
	int zpp=20,ee=100;
	char *str,buf[50],st[12];

	clrscr();

	str="cubo.vis";
	ler=load(str);
	if (ler==1) exit(1);

	iniciaGR();
	directvideo=1;

	inicializa_rato();
	maxx=getmaxx();
	maxy=getmaxy();
	mx=maxx/2;
	my=maxy/2;
	ratx=mx;
	raty=my;
	esconde_rato();
	setcolor(2);
	control();
	do {
		setviewport(0,0,maxx,400,1);
		rotacao(rx,ry,rz,mx,my,zpp,cor,fundo);
		setviewport(0,400,maxx,maxy,1);
		setcolor(4);
		sprintf(buf," EixoX=%3d EixoY=%3d ",rx,ry);
		outtextxy(430,10,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");
		setcolor(3);
		outtextxy(430,10,buf);
		setcolor(4);
		sprintf(buf," EixoZ=%3d Zoom=%3dx",rz,zpp);
		outtextxy(430,20,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");
		setcolor(3);
		outtextxy(430,20,buf);
		setcolor(4);
		mostra_rato();
		while(rato.butao!=1)
		{
			rato=getmouse();
			ch=0;
			//SAIR
			if(rato.x>=5&&rato.x<=45
			   &&rato.y>=405&&rato.y<=425)  ch=0x1b;
			//LOAD
			if(rato.x>=50&&rato.x<=90
			   &&rato.y>=405&&rato.y<=425) ch='L';
			//ROTA€âES
			if(rato.x>=140&&rato.x<=165
			   &&rato.y>=405&&rato.y<=425)  ch='C';
			if(rato.x>=140&&rato.x<=165
			   &&rato.y>=435&&rato.y<=455) 	ch='B';
			if(rato.x>=170&&rato.x<=195
			   &&rato.y>=415&&rato.y<=435) 	ch='D';
			if(rato.x>=110&&rato.x<=135
			   &&rato.y>=415&&rato.y<=435) 	ch='E';
			if(rato.x>=170&&rato.x<=195
			   &&rato.y>=450&&rato.y<=470) 	ch='2';
			if(rato.x>=110&&rato.x<=135
			   &&rato.y>=450&&rato.y<=470) 	ch='1';
			//TRANSLA€âES
			if(rato.x>=240&&rato.x<=265
			   &&rato.y>=405&&rato.y<=425) 	ch='b';
			if(rato.x>=240&&rato.x<=265
			   &&rato.y>=435&&rato.y<=455) 	ch='c';
			if(rato.x>=270&&rato.x<=295
			   &&rato.y>=415&&rato.y<=435) 	ch='d';
			if(rato.x>=210&&rato.x<=235
			   &&rato.y>=415&&rato.y<=435) 	ch='e';
			//ZOOM
			if(rato.x>=310&&rato.x<=360
			   &&rato.y>=405&&rato.y<=425) 	ch='z';
			if(rato.x>=370&&rato.x<=420
			   &&rato.y>=405&&rato.y<=425) 	ch='x';
			//Default
			if(rato.x>=310&&rato.x<=370
			   &&rato.y>=435&&rato.y<=455) 	ch='f';
			//HELP
			if(rato.x>=5&&rato.x<=45
			   &&rato.y>=435&&rato.y<=455) 	ch='H';

		}
		rato.butao=0;
		esconde_rato();
		switch(ch) {
			case 'C':{ ry=ry+4;
				if(ry>359) ry=ry-360;
				sprintf(buf,"Y%c",0x18); //CIMA
				tecla(140,5,165,25,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(140,5,165,25,0,buf);
				mostra_rato(); }
				break;
			case 'B':{ ry=ry-4;
				if(ry<0) ry=ry+360;
				sprintf(buf,"Y%c",0x19); //BAIXO
				tecla(140,35,165,55,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(140,35,165,55,0,buf);
				mostra_rato(); }
				break;
			case 'E':{ rx=rx+4;
				if(rx>359) rx=rx-360;
				sprintf(buf,"%cX",0x1b); //ESQUERDA
				tecla(110,15,135,35,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(110,15,135,35,0,buf);
				mostra_rato();}
				break;
			case 'D':{ rx=rx-4;
				if(rx<0) rx=rx+360;
				sprintf(buf,"X%c",0x1a); //DIREITA
				tecla(170,15,195,35,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(170,15,195,35,0,buf);
				mostra_rato();}
				break;
			case '1' :{ rz=rz+4;
				if(rz>359) rz=rz-360;
				sprintf(buf,"<Z");   	//ESQUERDA OZ
				tecla(110,50,135,70,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(110,50,135,70,0,buf);
				mostra_rato();}
				break;
			case '2' :{ rz=rz-4;
				if(rz<0) rz=rz+360;
				sprintf(buf,"Z>");	//DIREITA OZ
				tecla(170,50,195,70,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(170,50,195,70,0,buf);
				mostra_rato();}
				break;
			case 'f' :{ 	rx=20;ry=80;rz=0;zpp=20;
					mx=maxx/2;my=maxy/2;
					sprintf(buf,"Default");
					tecla(310,35,370,55,1,buf);
					mostra_rato();
					delay(ee);
					esconde_rato();
					tecla(310,35,370,55,0,buf);
					mostra_rato();
				}
				break;
			case 'Z' :
			case 'z' :{ zpp+=1;
				sprintf(buf,"Zoom+");
				tecla(310,5,360,25,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(310,5,360,25,0,buf);
				mostra_rato();}
				break;
			case 'X' :
			case 'x' :{ if(zpp>0) zpp-=1;
				sprintf(buf,"Zoom-");
				tecla(370,5,420,25,1,buf);
				mostra_rato();
				delay(ee);
				esconde_rato();
				tecla(370,5,420,25,0,buf);
				mostra_rato();}
				break;
			case 'b' :{ 	my=my-4;
					sprintf(buf,"T%c",0x18);
					tecla(240,5,265,25,1,buf);
					mostra_rato();
					delay(ee);
					esconde_rato();
					tecla(240,5,265,25,0,buf);
					mostra_rato();}
					break;
			case 'c' :{ 	my=my+4;
					sprintf(buf,"T%c",0x19);
					tecla(240,35,265,55,1,buf);
					mostra_rato();
					delay(ee);
					esconde_rato();
					tecla(240,35,265,55,0,buf);
					mostra_rato();}
					break;
			case 'e' :{  mx=mx-4;
					sprintf(buf,"%cT",0x1b);
					tecla(210,15,235,35,1,buf);
					mostra_rato();
					delay(ee);
					esconde_rato();
					tecla(210,15,235,35,0,buf);
					mostra_rato();}
					break;
			case 'd' :{	mx=mx+4;
					sprintf(buf,"T%c",0x1a);
					tecla(270,15,295,35,1,buf);
					mostra_rato();
					delay(ee);
					esconde_rato();
					tecla(270,15,295,35,0,buf);
					mostra_rato();}
					break;
			case 'H' :{
					sprintf(buf,"HELP");
					tecla(5,35,45,55,1,buf);
					mostra_rato();
					delay(ee);
					esconde_rato();
					tecla(5,35,45,55,0,buf);
					HELP();
					mostra_rato();}
					break;
			case 'L' : {
					tecla(50,5,90,25,1,"LOAD");
					mostra_rato();
					delay(ee);
					esconde_rato();
					tecla(50,5,90,25,0,"LOAD");
					MAINload();
					rato.butao=0;
					mostra_rato();}
					break;
		}
		limpa=1;
	} while(ch!=0x1b);
	cleardevice();
	mouseOff();
	fimGR();
	printf(" Programado por BRUNO SHIRLEY POSSOLO \n");
	return 0;
}

void control(void)
{
	char strg[25];

	setcolor(4);
	setviewport(0,400,maxx,maxy,1);
	rectangle(0,1,maxx,maxy-400);

	tecla(5,5,45,25,0,"SAIR");
	tecla(50,5,90,25,0,"LOAD");
	// Controlos da rota‡Æo
	sprintf(strg,"Y%c",0x18); //CIMA
	tecla(140,5,165,25,0,strg);
	sprintf(strg,"Y%c",0x19); //BAIXO
	tecla(140,35,165,55,0,strg);
	sprintf(strg,"X%c",0x1a); //DIREITA
	tecla(170,15,195,35,0,strg);
	sprintf(strg,"%cX",0x1b); //ESQUERDA
	tecla(110,15,135,35,0,strg);
	sprintf(strg,"Z>");       //DIR OZ
	tecla(170,50,195,70,0,strg);
	sprintf(strg,"<Z");	  //ESQ OZ
	tecla(110,50,135,70,0,strg);
	// Controlos da transla‡Æo
	sprintf(strg,"T%c",0x18); //CIMA
	tecla(240,5,265,25,0,strg);
	sprintf(strg,"T%c",0x19); //BAIXO
	tecla(240,35,265,55,0,strg);
	sprintf(strg,"T%c",0x1a); //DIREITA
	tecla(270,15,295,35,0,strg);
	sprintf(strg,"%cT",0x1b); //ESQUERDA
	tecla(210,15,235,35,0,strg);
	// Controlo do Zoom
	sprintf(strg,"Zoom+");
	tecla(310,5,360,25,0,strg);
	sprintf(strg,"Zoom-");
	tecla(370,5,420,25,0,strg);
	// Default
	sprintf(strg,"Default");
	tecla(310,35,370,55,0,strg);
	// HELP
	sprintf(strg,"HELP");
	tecla(5,35,45,55,0,strg);
	//CREDITOS
	setcolor(1);
	sprintf(strg," 3D VISUAL v1.0 1994 ");
	outtextxy(430,60,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");
	setcolor(14);
	outtextxy(430,60,strg);
	setcolor(1);
	sprintf(strg,"  por Bruno Possolo ");
	outtextxy(430,70,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");
	setcolor(14);
	outtextxy(430,70,strg);
}

void HELP(void)
{
	int k=185,kk=k;

	setviewport(50,100,400,200,0);
	setcolor(1);
	while(k!=370)
	{
		rectangle(kk,0,k,100);
		k++;kk--;
	}
	setcolor(3);
	rectangle(0,0,370,100);
	outtextxy(5,5," 3DVISUAL ver1.0 1994");
	outtextxy(5,15," por Bruno Shirley Possolo");
	outtextxy(5,35,"Este programa  serve para visualizar imagens");
	outtextxy(5,45,"em 3D WIREFRAME. Todos os controlos de visor");
	outtextxy(5,55,"sao controlados por mouse no painel  situado");
	outtextxy(5,65,"em baixo. Para informa‡oes  mais  detalhadas");
	outtextxy(5,75,"consultar a revista Spooler.");
	outtextxy(5,90," Botao direito do rato para sair da janela");
	do
	{
		rato=getmousepos();
	}while(rato.butao!=2);
	k=0;kk=100;
	setcolor(0);
	while(k!=51)
	{
		rectangle(0,k,370,kk);
		k++;kk--;
	}
}

void MAINload(void)
{
	struct ffblk ffblk;
	struct ffblk ffblk1;
	int done,ct=0,ch,ct1,OK,k=105,kk=k,sair=0;
	char str[12];

	setviewport(50,100,400,200,0);
	setcolor(1);
	while(k!=210)
	{
		rectangle(kk,0,k,100);
		k++;kk--;
	}
	setcolor(3);
	rectangle(0,0,210,100);
	setcolor(4);
	outtextxy(5,5," LOAD FIGURA :");
	tecla(5,60,70,80,0,"CANCELA");
	tecla(75,60,95,80,0,"<<");
	tecla(100,60,120,80,0,">>");
	tecla(125,60,205,80,0,"SELECIONA");
	mostra_rato();
	setcolor(3);
	done = findfirst("*.VIS",&ffblk,0);
	while (sair!=1)
	{
		setcolor(0);
		outtextxy(40,20,"ÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");
		setcolor(3);
		sprintf(str," %s ",ffblk.ff_name);
		outtextxy(40,20,str);
		setcolor(4);
		delay(50);
		while(rato.butao!=1)
		{
			rato=getmouse();
			ch=' ';
			if(rato.x>=55&&rato.x<=120&&
				rato.y>=160&&rato.y<=180) ch='e';
			if(rato.x>=125&&rato.x<=145&&
				rato.y>=160&&rato.y<=180) ch='q';
			if(rato.x>=150&&rato.x<=170&&
				rato.y>=160&&rato.y<=180) ch='w';
			if(rato.x>=175&&rato.x<=255&&
				rato.y>=160&&rato.y<=180) ch='r';
			if(rato.x>=95&&rato.x<=200&&
				rato.y>=120&&rato.y<=130) ch='d';
		}
		rato.butao=0;
		switch(ch)
		{
		case 'q': {     if(done!=-1) ct-=2; else ct-=3;
				done = findfirst("*.VIS",&ffblk1,0);
				ct1=1;
				while(ct1<=ct)
				{
					ct1++;
					done = findnext(&ffblk1);

				}
				ffblk=ffblk1;
				ct=ct1;
				esconde_rato();
				tecla(75,60,95,80,1,"<<");
				delay(100);
				tecla(75,60,95,80,0,"<<");
				mostra_rato();
				}
		break;
		case 'w': {     if(done!=-1)
				{
					ct++;
					done = findnext(&ffblk);
				}
				esconde_rato();
				tecla(100,60,120,80,1,">>");
				delay(100);
				tecla(100,60,120,80,0,">>");
				mostra_rato();
				}
		break;
		case 'r': {	sair=1;
				esconde_rato();
				tecla(125,60,205,80,1,"SELECIONA");
				tecla(125,60,205,80,0,"SELECIONA");
				sprintf(str,"%s",ffblk.ff_name);
				OK=load(str);
				cleardevice();
				if(OK==1) exit(1);
				}
		break;
		case 'e' :{ 	sair=1;
				esconde_rato();
				tecla(5,60,70,80,1,"CANCELA");
				tecla(5,60,70,80,0,"CANCELA");
				}
		break;
		case 'd' :{     sair=1;
				sprintf(str,"%s",ffblk.ff_name);
				OK=load(str);
				cleardevice();
				if(OK==1) exit(1);
				}
		}
	}
	esconde_rato();
	k=0;kk=100;
	setcolor(0);
	while(k!=51)
	{
		rectangle(0,k,370,kk);
		k++;kk--;
	}
	control();
}

