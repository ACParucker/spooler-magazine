#include <stdlib.h>
#include <string.h>
#include <dos.h>
#include <alloc.h>
#include <stdio.h>
#include <io.h>


#define SECS 125
/*Codigos de resultados a enviar ao ambiente no fim da execu‡„o do programa*/
#define OK 0              /* OK */
#define EPASS 1           /* Password Errada */
#define ELEITURA 2        /* Erro ao ler */
#define EESCRITA 3        /* Erro ao escrever */
#define EMEM 4            /* Erro na aloca‡„o de mem¢ria */
#define EJA  5            /* A diskette j  estava encriptada */
#define EIMPOSSIVEL 6     /* N„o h  espa‡o para alojar a password */
#define ENUNCA 7          /* A diskette n„o est  encriptada */

/* Estruturas que permitir„o alterar os bits por byte */
struct bs
{
  b1 : 2;
  b2 : 2;
  b3 : 2;
  b4 : 2;
};

union swaper
{
  char c;
  struct bs b;
};

/* Fun‡„o que encripta e desemcripta cada os 64000 bytes da FAT */
void code(char *bu)
{
  unsigned register int a;
  struct bs indep;
  union swaper sw;

  for (a=0;a<64000;a++)
   {
     sw.c=bu[a];
     /* Trocar o grupo de bits 1 pelo 4 */
     indep.b1=sw.b.b1;
     sw.b.b1=sw.b.b4;
     sw.b.b4=indep.b1;

     /* Trocar o grupo de bits 2 pelo 3 */
     indep.b1=sw.b.b2;
     sw.b.b2=sw.b.b3;
     sw.b.b3=indep.b1;

     bu[a]=sw.c;
   }
}

/*DB LetIn <request>
   por      1  <DRIVE> <PASS>
   tirar    2  <DRIVE> <PASS>
   mudar    3  <DRIVE> <PASS> */

/* Fun‡„o Principal */
int main(int argc, char *argv[])
{
  unsigned int a, b, res;
  unsigned char drive, oper, str[6], flag1=0, flag2=0;
  void far *buf;
  char far *snoop;

  /* Impedir o acesso ao programa no caso da chamada n„o ser feita do ambiente*/
  if (argc<3 && strcmp(argv[1],"LetIn")!=0)
   {
     puts("Overlay do Disk Block.  Impossivel correr em separado !");
     return -1;
   }
  drive=atoi(argv[3]);
  oper=atoi(argv[2]);
  /* Aloca‡„o de mem¢ria */
  if((buf=farmalloc(64000))==NULL) {return EMEM;}
  snoop=buf;

  /* Leitura da FAT (e mais)*/
  if(absread(drive,SECS,2,buf)!=0) {return ELEITURA;}

  /*Descobrir a password utilizada (no caso de a diskette estar j  encriptada*/
  for(a=0; a<65000; a++)
   if(snoop[a]=='+')
    if(snoop[a+1]=='*' && snoop[a+2]=='ÿ' && snoop[a+3]=='*' && snoop[a+4]=='+')
     {
       flag1=1;
       break;
     }

  /* Colocar a password e encripta‡„o */
  if(oper==1)
   {
     if (flag1==1) {return EJA;}

     code(buf);

     for(a=0; a<63989; a++)
      if(snoop[a]==snoop[a+1])
       for(b=a; b<a+11; b++) if (snoop[b]==snoop[b+1]) {flag2=1;break;}

     if (flag2==0) {return EIMPOSSIVEL;}

     snoop[a++]='+'; snoop[a++]='*'; snoop[a++]='ÿ'; snoop[a++]='*'; snoop[a++]='+';

     strcpy(str, argv[4]);
     for(b=0;b<5;b++) if (str[b]==NULL) break;
     for(;b<5;b++) str[b]=NULL;
     for(b=a;b<a+5;b++) snoop[b]=(str[b-a])+5;
     if(abswrite(drive,SECS,2,buf)!=0) {return EESCRITA;}
   }

  /* Remover a password e encripta‡„o */
  if(oper==2)
   {
     char str[6];
     unsigned int pos;

     if (flag1==0) {return ENUNCA;}

     pos=a; str[5]=NULL;
     for (a=pos+5;a<pos+10;a++) str[a-pos-5]=snoop[a]-5;
     for (a=pos;a<pos+10;a++) snoop[a]=snoop[pos+10];

     if (strcmp(str,argv[4])) {return EPASS;}

     code(buf);
     if(abswrite(drive,SECS,2,buf)!=0) {return EESCRITA;}
   }

  /* Modificar a password */
  if(oper==3)
   {
     char str[6];
     unsigned int pos;

     if (flag1==0) {return ENUNCA;}

     pos=a; str[5]=NULL;
     for (a=pos+5;a<pos+10;a++) str[a-pos-5]=snoop[a]-5;

     if (strcmp(str,argv[4])) { return EPASS;}

     for (a=pos+5;a<pos+10;a++) snoop[a]=argv[5][a-pos-5]+5;
     if(abswrite(drive,SECS,2,buf)!=0) {return EESCRITA;}
   }

  free(buf);
  return 0;
}
