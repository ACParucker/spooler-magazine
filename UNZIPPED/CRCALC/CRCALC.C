/* CRCalc(C) v2.01 por Carlos Batista para Spooler Magazine

   Library files(.H) s„o as fornecidas com o TURBO C 2.0(C) da Borland Intl.
   e s„o copyright da mesma Borland Intl.

   Programa deve ser compilado usando o TURBO C 2.0

   Data: 1/12/1993

*/


# include <stdio.h>
# include <io.h>
# include <conio.h>
# include <dos.h>
# include <dir.h>

FILE *file;

long codigo, codigo2;

main(argc,argv)
int argc;
char *argv[];
{

int i=0,year,c;
long filel,periods[11],x=0;
char mes[10];

struct ftime data;
struct ffblk fila;

 if(argc!=2){
  erro();
  printf("Erro #1: Numero Errado de Parametros\n\nSyntax: CRCalc NomeFicheiro\n");
  exit(1);
 }

 if( (file=fopen(argv[1],"rb"))==NULL){
  erro();
  printf("Erro #2: Ficheiro n„o encontrado!\n");
  exit(2);
 }

 textmode(3);
 textbackground(WHITE);clrscr();
 pintar();
 for(i=2;i<25;i++){gotoxy(1,i);cprintf(" ");gotoxy(80,i);cprintf(" ");}
 textcolor(YELLOW);textbackground(1);
 gotoxy(10,2);cprintf(" CRCalc  v2.01(C) por Carlos Batista para Spooler Magazine, 1993 ");

 quadros();
 filel=filelength(fileno(file));
 periods[0]=filel/10;
 for(i=1;i<10;i++)periods[i]=periods[0]*(i+1);

 getftime(fileno(file), &data);
 year=1980+data.ft_year;

 findfirst(argv[1],&fila,FA_ARCH);

 textcolor(1);gotoxy(12,8);cprintf("Nome   : ");textcolor(4);cprintf("%s", strupr(fila.ff_name));
 textcolor(1);gotoxy(12,9);cprintf("Tamanho: ");textcolor(4);cprintf("%ld bytes", filel);
 textcolor(1);gotoxy(12,10);cprintf("Data   : ");textcolor(4);cprintf("%1.2u-", data.ft_day);
 switch(data.ft_month){
  case 1: strcpy(mes,"Janeiro");break;
  case 2: strcpy(mes,"Fevereiro");break;
  case 3: strcpy(mes,"Mar‡o");break;
  case 4: strcpy(mes,"Abril");break;
  case 5: strcpy(mes,"Maio");break;
  case 6: strcpy(mes,"Junho");break;
  case 7: strcpy(mes,"Julho");break;
  case 8: strcpy(mes,"Agosto");break;
  case 9: strcpy(mes,"Setembro");break;
  case 10: strcpy(mes,"Outubro");break;
  case 11: strcpy(mes,"Novembro");break;
  case 12: strcpy(mes,"Dezembro");break;
 }
 cprintf("%s", mes);
 cprintf("-%1.2u", year);
 textcolor(1);gotoxy(12,11);cprintf("Hora   : ");textcolor(4);cprintf("%1.2u:%1.2u:%1.2u",data.ft_hour, data.ft_min, data.ft_tsec);

 textcolor(0);gotoxy(55,9);cprintf("Valores CRC");
 textcolor(1);gotoxy(47,10);cprintf("  1§ Valor :");
 gotoxy(47,11);cprintf("  2¦ Valor :");

 textcolor(4);gotoxy(25,22);cprintf("A Calcular CRC do ficheiro. Espere...");


 textcolor(1);
 i=0;

 while(!feof(file)){

  c=getc(file);
  codigo+=((codigo<<1)+c)&0xffff;
  codigo2+=c&0xeeee;
  x++;

  if(x==periods[i]) {gotoxy(31+(i*2),17);cprintf("²²");i++;}

 }

 if(codigo<0)codigo=-codigo;


 textcolor(4);gotoxy(60,10);cprintf("%1.10ld", codigo);
 textcolor(4);gotoxy(60,11);cprintf("%1.10ld", codigo2);
 textcolor(4);gotoxy(16,22);cprintf("Acabado! Prima qualquer tecla para sair para o DOS!");


 putchar(7);
 getch();
 textmode(-1);
 clrscr();
 fclose(file);
 exit(0);


}

erro() /* mesg. */
{
 printf("CRCalc(C) v2.01 por Carlos Batista para Spooler Magazine, %s\n",__DATE__);
 printf("CRCalc Copyright de Carlos Batista, 1993 - Amadora, Portugal\n\n");

}

pintar()  /* para "encher" o fundo */
{

 union REGS z;

 gotoxy(1,2);
 z.h.ah=9;
 z.h.bh=0;
 z.h.bl=0x01;
 z.h.cx=1840;
 z.h.al=178;
 int86(0x10,&z,&z);

}

quadros()
{
int i;

 textcolor(7);textbackground(7);
 for(i=7;i<13;i++) {gotoxy(10,i);cprintf("ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");}
 textcolor(1);textbackground(0);
 for(i=8;i<13;i++) {gotoxy(38,i);cprintf("°");}
 gotoxy(11,13);cprintf("°°°°°°°°°°°°°°°°°°°°°°°°°°°°");

 textcolor(7);textbackground(7);
 for(i=9;i<12;i++) {gotoxy(46,i);cprintf("ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");}
 textcolor(1);textbackground(0);
 for(i=10;i<12;i++) {gotoxy(72,i);cprintf("°");}
 gotoxy(47,12);cprintf("°°°°°°°°°°°°°°°°°°°°°°°°°°");

 textcolor(7);textbackground(7);
 for(i=16;i<19;i++) {gotoxy(26,i);cprintf("ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");}
 textcolor(1);textbackground(0);
 for(i=17;i<19;i++) {gotoxy(56,i);cprintf("°");}
 gotoxy(27,19);cprintf("°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°");
 textcolor(4);textbackground(7);
 gotoxy(36,16);cprintf("% Completada");
 textcolor(5);
 gotoxy(31,18);cprintf("0        50      100");

 textcolor(7);textbackground(7);
 gotoxy(15,22);cprintf("ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ");
 textcolor(1);textbackground(0);
 gotoxy(16,23);cprintf("°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°");
 textbackground(7);


}