

                            /* SHOCK Ver 1.0 */
          /* SHOCK.C ú M¢dulo Principal do Programa Compressor */


#include <stdlib.h>             /* itoa();                                    */
#include <stdio.h>              /* printf();                                  */
#include <process.h>            /* exit();                                    */
#include <alloc.h>              /* malloc(), free();                          */
#include <io.h> /* open(),read(),_creat(),write(),filelenght(),eof(),close(); */
#include <errno.h>              /* errno, ENOPATH, ENOFILE, EINVDRV           */
#include <fcntl.h>              /* O_RDONLY, O_BINARY                         */
#include <string.h>             /* strupr(),strchr(),strcmp(),strlen();       */
#include <dir.h>                /* findfirst(),findnext(), ffblk              */
#include <dos.h>                /* unlink(), FA_ARCH, ctrlbrk()               */
#include <ctype.h>              /* tolower()                                  */
#include <math.h>               /* ceil()                                     */
#include <conio.h>              /* wherey(), gotoxy(), getch();               */
#include <time.h>               /* clock()                                    */

#include "proto.h"        /*    Pr¢totipos                                    */
#include "config.h"       /*    Constantes globais                            */


unsigned char *buffer,*out;   /*  Buffers de 25k                              */

 int in_stream,  /*  Handle para o(s) ficheiro(s) a ser(em) comprimido(s)     */
    out_stream, /*  Handle para o ficheiro de saida                           */
    datasize;      /*  Tamanho em bytes dos dados lidos para o buffer         */

long infile_size;   /*  Tamanho do ficheiro a comprimir                       */




                        /* -=> main () <=- */


void main(int argc,char *argv[])
{
 extern unsigned char
                 fileSHK[],      /*  Especifica‡„o do ficheiro comprimido      */
                 infiles[],      /*  Especifica‡„o dos ficheiros a comprimir   */
                 password[];     /*  Guarda a password                         */

 static struct ffblk FFBLK;

 extern int param_r,         /*  Partilhado com OPCOES.C                      */
            param_a;         /*  Partilhado com OPCOES.C                      */

 unsigned char mov[4]={ '|','/','-','\\' };

 int fprocessed=0,  /*  Guarda o n£mero de ficheiros a comprimir processados  */
     totalinf=0,      /*  Guarda o n£mero de ficheiros a comprimir            */
     existSHK=FALSE,    /*  TRUE se o ficheiro .SHK j  existir                */
     exist=NAOEXIST,
     first=TRUE,   /*  TRUE se for o 1§ ficheiro da especifica‡„o dada         */
     same=FALSE,   /*  TRUE se o ficheiro a comp. for o mesmo que o .SHK       */
     i,cont=0,cont2=0,cm=0;  /*  Variaveis contadoras                               */

 int min=0,sec=0;   /*  Minutos e segundos                                     */

 long tam_compdat=0;  /*  Tamanho dos dados comprimidos                        */

 long percents=0,     /*  Guarda todas as percentagens de compress„o           */
      percentagem=0;  /*  A percentagem corrente                               */

 unsigned char
          openf[NML]={""}, /*  Ficheiro(s) a ser aberto para ser comprimido    */
          *nofp,        /*  Nome do ficheiro presentemente a ser processado    */
          response='';  /*  Guarda a reposta do usu rio                        */

 unsigned double tempo=0;      /*  Tempo que passou...                         */
 long unsigned double proc=0;  /*  Numero de bytes processados                 */



                   /*   ---  úúú  ---  úúú  ---   */


 buffer = malloc(BUFSIZE);
 out = malloc(BUFSIZE);

 if((buffer==NULL) || (out==NULL)) erro("\n   SHOCK -=> Mem¢ria insuficiente !!!");

 ctrlbrk(cbreak);

 totalinf = ver_param(argc,argv);

 mostra_inf();

 if (param_r) out_stream=cria_SHK(fileSHK);
 else
 {
  existSHK=findfirst(fileSHK,&FFBLK,FA_ARCH);
  if (existSHK==0)
  {
   printf("\n\n   SHOCK -=> %s j  existe.\n\t\t   Deseja reescrever ? [SNTD] ",
                                                        strupr(fileSHK));
   som();

   do
   {
    response=getch();
    response=tolower(response);
    switch(response)
    {
     case 's': {printf("Sim");out_stream=cria_SHK(fileSHK);}break;
     case 't': {printf("Todos");out_stream=cria_SHK(fileSHK);} break;

     case 'n': {
                printf("N„o");
                printf("\n\n   SHOCK -=> Execu‡„o terminada...");
                halt();
               } break;

     case 'd': {
                printf("Desistir");
                printf("\n\n   SHOCK -=> Execu‡„o terminada...");
                halt();
               } break;

     default : printf("\n\t\t   Deseja reescrever ? (Sim,N„o,Todos,Desistir) ");
    }
   } while (response!='s' && response!='t' && response!='n'
                                                      && response!='d');
  }
  else out_stream=cria_SHK(fileSHK);
 }

 do
 {
  if (exist==NAOEXIST)
  {
   for (i=0;i < NML;i++) openf[i]='';
   cont2=0;
   first=TRUE;
   do
   {
    openf[cont2++]=infiles[cont++];
   } while(infiles[cont]!=';');
   cont++;
  }

  if (first)
  {
   errno=0;
   findfirst(openf,&FFBLK,FA_ARCH);
   if (errno!=0)
   {
    switch (errno)
    {
     case EINVDRV:erro("\n\n   SHOCK -=> Drive especificada inv lida !!!");break;
     case ENOPATH:
     case ENOFILE:{
                   printf("\n\n   SHOCK -=> Ficheiro(s) %s n„o encontrado(s) !!!\n",openf);
                   som();
                   halt();
                  } break;
     default:erro("\n\n   SHOCK -=> Ocorreu um erro n„o identificado !!!");
    }
   }
   totalinf++;
   if ((strchr(openf,'*')!=NULL) || (strchr(openf,'?')!=NULL))
    printf("    Procurando   %s ...\n",strupr(openf));
   exist=EXIST;
   first=FALSE;
   nofp=FFBLK.ff_name;
   if (strcmp(nofp,fileSHK)==0) same=TRUE;
  }

  else
  {
   errno=0;
   exist=findnext(&FFBLK);
   if (exist==EXIST) totalinf++;
   else
   {
    exist=NAOEXIST;
    totalinf--;
   }
   if (strcmp(nofp,fileSHK)==0)
   {
    same=TRUE;
    totalinf--;
   }
  }

  if (same==FALSE)
  {
   if (exist==EXIST)
   {
    errno=0;
    in_stream = open(nofp,O_RDONLY | O_BINARY);
    if (errno!=0)
    {
     printf("\n\n   SHOCK -=> Impossivel ler dados de %s !!!",strupr(nofp));
     som();
     halt();
    }

    infile_size=filelength(in_stream);

    while (!eof(in_stream))
    {
     datasize=read(in_stream,buffer,BUFSIZE);
     proc+=datasize;

     if (proc > BUFSIZE)
     {
      if (cm==4) cm=0;
      gotoxy(41,wherey());
      printf("%c ",mov[cm++]);
     }

     tam_compdat+=comprime(datasize,nofp,proc);

     if (cm==4) cm=0;
     gotoxy(41,wherey());
     printf("%c ",mov[cm++]);
    }
    percentagem=(int)(ceil((100-(100*(float)tam_compdat/infile_size))));
    gotoxy(5,wherey());
    printf("Incluido...");
    gotoxy(30,wherey());
    printf("  ¯ %d%    ",percentagem);
    gotoxy(38,wherey());
    printf("®");
    gotoxy(39,wherey());
    printf(" OK  \n");

    percents+=percentagem;

    fprocessed++;
    tam_compdat=0;
    proc=0;

    close(in_stream);
    if (param_a) unlink(nofp);
   }
  }
  same=FALSE;
 } while (fprocessed < totalinf);

 tempo=clock();
 sec=tempo/CLK_TCK;
 min=sec/60;           /*  Calcula os minutos                                   */
 sec=sec-(60*min)+1;                /* e os segundos ...                        */

 estatistica(fprocessed,percents,min,sec);       /* Estatistica final           */

 if (fprocessed==0) { close(out_stream);unlink(fileSHK); }
 halt();
}



                   /* -=>  cria_SHK ()  <=- */


int cria_SHK(unsigned char filename[])
{
 int stream;             /*  Handle para o ficheiro comprimido                 */

 printf("\n\n    Criando %s ...\n",strupr(filename));

 stream=_creat(filename,FA_ARCH);
 if (stream==-1)
 {
  printf("\n   SHOCK -=> Impossivel criar/reescrever"
                   " o ficheiro %s !!!\n             Execu‡„o terminada...\n"
                                                              ,filename);
  som();
  halt();
 }

 esc_header(stream,filename);
 return stream;
}



                       /* -=> esc_header () <=- */


void esc_header(int out_stream,unsigned char filename[])
{
 extern int param_p;
 extern unsigned char password[];

 int stat=0;

 stat=write(out_stream,&ASSINATURA,5);
 if (stat==ERR_ESC)
 {
  printf("\n   SHOCK -=> Impossivel aceder ao ficheiro %s !!!"
                         "Execu‡„o terminada...",filename);
  exit(-2);
 }
 write(out_stream,&SEPARADOR,1);
 if (param_p) esc_pass(out_stream,password);
 printf("\n");
}


                         /* -=> esc_pass () <=- */

void esc_pass(int out_stream,unsigned char password[])
{
 int i=0;
 unsigned char ch;

 printf("    Encriptando palavra-chave ...\n");
 do
 {
  ch=password[i];
  ch=ch^78;
  password[i++]=ch;
 } while (password[i]!=0);

 write(out_stream,password,i);
}


                    /* -=>  estatistica ()  <=- */

void estatistica(int fprocessed,long percents,int min,int sec)
{
 printf("\n   N£mero total de ficheiros comprimidos : %d ficheiro(s) .",fprocessed);
 printf("\n   Tempo total de compress„o : %d min, %d sec .",min,sec);
 printf("\n   Percentagem total de compress„o : >>> %d% <<< .\n\n",
                               (int)(ceil(((float)percents/fprocessed))));
}


                     /* -=>  cbreak () <=- */

int cbreak()
{
 extern unsigned char fileSHK[];

 close(in_stream);
 close(out_stream);
 unlink(fileSHK);
 printf("\n   SHOCK -=>  CONTROL + BREAK  pressionado...");
 return 0;
}


                    /* -=>  halt ()  <=- */

void halt()
{
 free(buffer);
 free(out);
 exit(0);
}