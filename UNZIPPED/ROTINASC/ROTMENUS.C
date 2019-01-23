#include <conio.h>
#include <dos.h>
#include <stdio.h>
#include <string.h>
#include <bios.h>
#include <alloc.h>
#include <stdlib.h>
#include "menus.h"

void writexy(int x, int y, char *s,int a)
 {
  char far *p;
  p=(char far *) 0xB8000000;
  p+=160*(y-1)+(x-1)*2;
  for( ;*s; ) { *p++=*s++; *p++=a; }
 } /* writexy */

void repetchar(char x, char y, char c, char n, char a)
 {
  char far *p;
  int i;
  p=(char far *) 0xB8000000;
  p+=160*(y-1)+(x-1)*2;
  for(i=1;i<=n;i++) { *p++=c; *p++=a; }
 } /* repetchar */


void caixa(int x1, int y1, int x2, int y2, int a)
 {
  char far *p;
  int i,j;
  p=(char far *) 0xB8000000;
  p+=160*(y1-1)+(x1-1)*2;
  for (i=y1;i<y2+1;i++) {
     for (j=x1;j<=x2;j++)  {  *p++=' '; *p++=a; }
     p+=(160-(x2-x1+1)*2);
  }
 }   /*   caixa  */


  char *salvaecran(int x1, int y1, int x2, int y2)
   {
    char *ecr=NULL;
    ecr=(char *)malloc(1+(x2-x1+1)*(y2-y1+1)*2);
    gettext(x1,y1,x2,y2,ecr);
    ecr[2*(x2-x1+1)*(y2-y1+1)]='\0';
    return(ecr);
   }  /*   salvaecran   */

  void restauraecran(int x1, int y1, int x2, int y2, char *ecr)
   {
    puttext(x1,y1,x2,y2,ecr);
    if (ecr) free(ecr);
   }  /*   salvaecran  */

 void box(int x1, int y1, int x2, int y2, int estilo, int atr)
   {

   char boxchar[4][6] = { {218,191,217,192,196,179},
			  {214,183,189,211,196,179},
			  {213,184,190,212,205,186},
			  {201,187,188,200,205,186} };

  int i;
  char far *p;
  p=(char far *) 0xB8000000;
  p+=160*(y1-1)+(x1-1)*2; *p++=boxchar[estilo][0]; *p++=atr;
  for (i=x1;i<x2-1;i++) { *p++=boxchar[estilo][4]; *p++=atr;  }
  *p++=boxchar[estilo][1]; *p++=atr;
  p+=160-(x2-x1+1)*2;
  for (i=y1;i<y2-1;i++)  {
      *p++=boxchar[estilo][5]; *p++=atr;  p+=(x2-x1-1)*2;
      *p++=boxchar[estilo][5]; *p++=atr;  p+=160-(x2-x1+1)*2;
  }
  *p++=boxchar[estilo][3]; *p++=atr;
  for (i=x1;i<x2-1;i++) { *p++=boxchar[estilo][4]; *p++=atr;  }
  *p++=boxchar[estilo][2]; *p++=atr;
  }   /*   box  */


void limpa(int x1, int y1, int x2, int y2)
 {
  textbackground(BLACK);
  window(x1,y1,x2,y2);
  clrscr();
  window(1,1,80,25);
 }   /*   limpa   */


void mensagem(char *mem)
 {
  struct text_info texto;
  char *ecran;

  gettextinfo(&texto);
  ecran=salvaecran(1,23,80,25);
  caixa(1,23,80,25,100);
  box(1,23,79,25,SNGLSNGL,78);
  writexy(3,24," Aten‡ao  :   ",78);
  writexy(16,24,mem,79);
  writexy(4,25," Pressione Qualquer Tecla Para Continuar ",78);
  gotoxy(45,25);
  getkey();
  restauraecran(1,23,80,25,ecran);
  textattr(texto.attribute);
  gotoxy(texto.curx,texto.cury);
 }  /*   mensagem  */

int getkey(void)
{
 int key, lo, hi;

 key = bioskey(0);
 lo = key & 0X00FF;
 hi = (key & 0XFF00) >> 8;
 return( (lo==0) ? hi+256 : lo);
} /* getkey */

char *datasys(char *datas)
 {
  char datax[11],*datan;
  struct date dat;
  datan=datas;
  getdate(&dat);
  sprintf(datax,"%2d.%2d.%2d",dat.da_year,dat.da_mon,dat.da_day);
  strcpy(datas,datax+2);
  if (dat.da_mon < 10) datas[3]='0';
  if (dat.da_day < 10) datas[6]='0';
  return(datan);
 } /*  datasys  */

void menuop(MENU tabm[], char op, char cl, char ln, char *str, char *m, void (*pr)())
 {
   tabm[op].col=cl;
   tabm[op].lin=ln;
   tabm[op].st=str;
   tabm[op].mem=m;
   tabm[op].proc=pr;
  }  /*  menuop  */

void menubarra(BARRA barra[], char op, MENU *menu, char x, char y, char *s,
	       char *mem, char nit, char x1, char y1, char x2, char y2)
 {
   barra[op].x=x;
   barra[op].y=y;
   barra[op].st=s;
   barra[op].mem=mem;
   barra[op].coord[0]=x1;
   barra[op].coord[1]=y1;
   barra[op].coord[2]=x2;
   barra[op].coord[3]=y2;
   barra[op].nit=nit;
   barra[op].menu=menu;
  }  /*  menuop  */

int fmenu(MENU tabel[], int crd[4], char nop, char opc0, char *me, char nopb)
  {
     int op=0,i,fim_aux=0,opc=0,pos;  /* opc - opcao actual */
     char *ecr;

     ecr=salvaecran(crd[0],crd[1],crd[2],crd[3]);
     caixa(crd[0],crd[1],crd[2],crd[3],112);
     caixa(2,24,79,24,112);
     box(crd[0],crd[1],crd[2],crd[3],SNGLSNGL,113);
     repetchar(1,24,32,80,112);
     writexy(tabel[0].col,tabel[0].lin,tabel[0].st,7);
     pos=40-(int) (strlen(tabel[0].mem) / 2);
     writexy(pos,24,tabel[0].mem,112);
     for (i=1;i<nop;i++)
        writexy(tabel[i].col,tabel[i].lin,tabel[i].st,112);
     while (!fim_aux)	{
       op=0;
       while ((op!=ESC) && (op!=DOWNKEY) && (op!=UPKEY) && (op!=CR) &&
		   (op!=LEFTKEY) && (op!=RIGHTKEY))
         op=getkey();
       switch(op)  {
	  case ESC:
	    *me = 0;
	    fim_aux = 1;
	    restauraecran(crd[0],crd[1],crd[2],crd[3],ecr);
            return(opc0);
	  case CR:
	    tabel[opc].proc();
            break;
          case RIGHTKEY:
            restauraecran(crd[0],crd[1],crd[2],crd[3],ecr);
	    return(opc0 == nopb-1 ? 0: opc0+1);
          case LEFTKEY:
            restauraecran(crd[0],crd[1],crd[2],crd[3],ecr);
	    return(opc0 == 0 ? nopb-1: opc0-1);
          case UPKEY:
            caixa(2,24,79,24,112);
            writexy(tabel[opc].col,tabel[opc].lin,tabel[opc].st,112);
            if (opc == 0)  opc = nop-1; else  opc--;
            writexy(tabel[opc].col,tabel[opc].lin,tabel[opc].st,7);
            repetchar(7,24,' ',70,112);
	    pos=40-(int) (strlen(tabel[opc].mem) / 2);
	    writexy(pos,24,tabel[opc].mem,112);
            break;
          case DOWNKEY:
            caixa(2,24,79,24,112);
	    writexy(tabel[opc].col,tabel[opc].lin,tabel[opc].st,112);
	    if (opc == nop-1)  opc = 0; else  opc++;
	    writexy(tabel[opc].col,tabel[opc].lin,tabel[opc].st,7);
	    repetchar(7,24,' ',70,112);
	    pos=40-(int) (strlen(tabel[opc].mem) / 2);
            writexy(pos,24,tabel[opc].mem,112);
            break;
       }
     }
  caixa(2,23,79,24,112);
  return(opc0);
} /* menu */

void menuprincipal(BARRA barra[], char nit)
 {
  char fim_aux = 0,mostra_ecran=0, opcao=0, opaux, i, dt[9];
  int pos, op=0;

  textattr(7);
  clrscr();
  caixa(1,1,80,1,20);
  caixa(1,2,80,2,112);
  repetchar(1,1,219,1,23);
  caixa(1,24,80,24,112);
  caixa(1,25,80,25,20);
  writexy(barra[0].x,barra[0].y,barra[0].st,7);
  pos=40-(int) (strlen(barra[0].mem) / 2);
  writexy(pos,24,barra[0].mem,112);
  for (i=1;i<=nit-1;i++)
     writexy(barra[i].x,barra[i].y,barra[i].st,112);
  datasys(dt);
  writexy(73,1,datasys(dt),18);
  while (!fim_aux)  {
    op=0;
    while ((op!=ESC) && (op!=DOWNKEY) && (op!=LEFTKEY) && (op!=CR) &&
	     (op!=RIGHTKEY) && (op!=UPKEY))
      op=getkey();
    switch(op) {
       case ESC:  if (mostra_ecran == 1) mostra_ecran=0; else sair(); break;
       case RIGHTKEY:
	  writexy(barra[opcao].x,barra[opcao].y,barra[opcao].st,112);
          repetchar(7,24,' ',70,112);
	  if (opcao == nit-1)  opcao = 0; else  opcao++;
	  writexy(barra[opcao].x,barra[opcao].y,barra[opcao].st,7);
          repetchar(7,24,' ',70,112);
	  pos=40-(int) (strlen(barra[opcao].mem) / 2);
	  writexy(pos,24,barra[opcao].mem,112);
          break;
       case LEFTKEY:
	  writexy(barra[opcao].x,barra[opcao].y,barra[opcao].st,112);
          repetchar(7,24,' ',70,112);
	  if (opcao == 0)  opcao = nit-1; else  opcao--;
	  writexy(barra[opcao].x,barra[opcao].y,barra[opcao].st,7);
          repetchar(7,24,' ',70,112);
	  pos=40-(int) (strlen(barra[opcao].mem) / 2);
	  writexy(pos,24,barra[opcao].mem,112);
          break;
       case  CR:
       case DOWNKEY:
          mostra_ecran=1;
          while (mostra_ecran)	{
	     opaux=opcao;
	     opcao=fmenu(barra[opcao].menu,barra[opcao].coord,barra[opcao].nit,opcao,&mostra_ecran,nit);
             if (opaux!=opcao)	 {
	       writexy(barra[opaux].x,barra[opaux].y,barra[opaux].st,112);
	       writexy(barra[opcao].x,barra[opcao].y,barra[opcao].st,7);
             }
            else {
              repetchar(7,24,' ',70,112);
	      pos=40-(int) (strlen(barra[opcao].mem) / 2);
	      writexy(pos,24,barra[opcao].mem,112);
            }
	  }  break;
    }
  }
 }  /* menuprincipal */


 /* fim ficheiro  RotMenus  */
