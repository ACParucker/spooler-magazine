


                          /* UNSHOCK Ver 1.0 */
        /* UNSHOCK.C ú M¢dulo Principal do Programa Descompressor */


#include <stdio.h>
#include <process.h>
#include <alloc.h>
#include <io.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <dos.h>
#include <dir.h>
#include <ctype.h>
#include <conio.h>
#include <time.h>

#include "unproto.h"
#include "unconfig.h"


unsigned char *buffer,*out;   /*  Buffers de 25k                              */
unsigned char nofp[NML]={""};


int in_stream,  /*  Handle para o(s) ficheiro(s) a ser(em) comprimido(s)      */
    out_stream, /*  Handle para o ficheiro de saida                           */
    datasize,   /*  Tamanho em bytes dos dados lidos para o buffer            */
    fprocessed;  /*  Guarda o n£mero de ficheiros a comprimir processados     */



                        /* -=> main () <=- */


void main(int argc,char *argv[])
{
 extern unsigned char fileSHK[], /*  Especifica‡„o do ficheiro comprimido     */
                 password[];     /*  Guarda a password                        */

 extern int param_a;
 extern int param_d;

 int metodo=0,
     cm=0;

 unsigned char mov[4]={ '|','/','-','\\' };



                   /*   ---  úúú  ---  úúú  ---   */


 buffer = malloc(BUFSIZE);
 out = malloc(BUFSIZE);

 if((buffer==NULL) || (out==NULL)) erro("\n   UNSHOCK -=> Mem¢ria insuficiente !!!");

 ctrlbrk(cbreak);

 ver_param(argc,argv);

 mostra_inf(fileSHK);

 errno=0;
 in_stream = open(fileSHK,O_RDONLY | O_BINARY);
 if (errno!=0)
 {
  printf("   UNSHOCK -=> Impossivel ler dados de %s .\n",strupr(fileSHK));
  som();
  halt();
 }

 le_header(in_stream);

 while (!eof(in_stream))
 {
  metodo=le_ID(in_stream);

  if (strcmp(nofp,"")!=0)
  {
   if (fprocessed==0) fprocessed++;
   else
   {
    fprocessed++;
    printf("\r    Recomposto...   ");
    gotoxy(35,wherey());
    printf("OK  \n");
    close(out_stream);
   }
   out_stream=cria_outfile(nofp);
  }

  read(in_stream,buffer,datasize);

  if (cm==4) cm=0;
  gotoxy(36,wherey());
  printf("%c ",mov[cm++]);

  descomprime(out_stream,metodo,nofp);
  if (param_d) coloca_data_hora(out_stream,nofp);

  if (cm==4) cm=0;
  gotoxy(36,wherey());
  printf("%c ",mov[cm++]);
 }
 printf("\r    Recomposto...   ");
 gotoxy(35,wherey());
 printf("OK  ");

 if (param_a) unlink(fileSHK);

 estatistica(fprocessed);
 halt();
}



                   /* -=>  cria_outfile ()  <=- */


int cria_outfile(unsigned char filename[])
{
 int stream,             /*  Handle para o ficheiro comprimido                 */
     existfile,          /*  TRUE se o ficheiro a descomprimir j  existir      */
     ready;

 extern int param_r;     /*  Partilhado com UNOPCOES.C                         */

 unsigned char
          resposta='';   /*  Guarda a reposta do usu rio                        */

 static struct ffblk FFBLK;

 do
 {
  ready=TRUE;
  if (param_r) stream=_creat(filename,FA_ARCH);
  else
  {
   existfile=findfirst(filename,&FFBLK,FA_ARCH);
   if (existfile==0)
   {
    printf("    %s ",strupr(filename));
    gotoxy(18,wherey());
    printf("existe. Reescrever ? [SNTD] ");
    som();

    do
    {
     resposta=getch();
     resposta=tolower(resposta);
     switch(resposta)
     {
      case 's': {printf("Sim");stream=_creat(filename,FA_ARCH);}break;
      case 't': {printf("Todos");stream=_creat(filename,FA_ARCH);param_r=TRUE;} break;

      case 'n': {
                 printf("N„o\n");
                 do
                 {
                  ready=FALSE;
                  read(in_stream,buffer,datasize);
                  if (eof(in_stream))
                  {
                   if ((fprocessed-1)==0) erro("\n   SHOCK -=>  Nenhum ficheiro descomprimido !!!");
                   else
                   {
                    estatistica(fprocessed-1);
                    halt();
                   }
                  }
                  le_ID(in_stream);
                 } while (strcmp(nofp,"")==0);
                } break;

      case 'd': {
                 printf("Desistir");
                 printf("\n\n   SHOCK -=> Execu‡„o terminada...");
                 halt();
                } break;

      default : printf("\n\t\t    Reescrever ? (Sim,N„o,Todos,Desistir) ");
     }
    } while (resposta!='s' && resposta!='t' && resposta!='n' && resposta!='d');
   }
   else stream=_creat(filename,FA_ARCH);
  }
 } while (ready==FALSE);

 if (stream==-1)
 {
  printf("\n   SHOCK -=> Impossivel criar/reescrever"
                   " o ficheiro %s !!!\n             Execu‡„o terminada...\n"
                                                              ,filename);
  som();
  halt();
 }

 printf("\r");clreol();
 return stream;
}



                       /* -=> le_header () <=- */

void le_header(int in_stream)
{
 extern unsigned char fileSHK[];

 unsigned char aux[50]={""},pass[40]={""},
          *ass=ASSINATURA,
          sep=*SEPARADOR,
          *ID=INFODAT;

 int i,i2=0;

 printf("    Analisando %s ...\n\n",strupr(fileSHK));

 read(in_stream,aux,50);
 for (i=0;i < 5;i++)
 {
  if (ass[i]!=aux[i])
  {
   printf("   UNSHOCK -=>  O ficheiro %s n„o foi comprimido pelo SHOCK Ver 1.0 !!!",fileSHK);
   som();halt();
  }
 }

 if (aux[i++]!=sep) erro_fileSHK();
 do
 {
  pass[i2++]=aux[i++];
 } while((aux[i-1]!=ID[0]) && (aux[i]!=ID[1]));
 pass[i2-1]='';
 if (strcmp(pass,"")!=0) ver_password(pass);

 lseek(in_stream,5+i2,SEEK_SET);
}



                    /* -=> ver_password () <=- */


void ver_password(char pass[])
{
 extern unsigned char password[];
 int i;
 unsigned char ch;

 for (i=0;i < strlen(pass);i++)
 {
  ch=pass[i];
  ch=ch^78;
  pass[i]=ch;
 }
 if (strcmp(pass,password)!=0)
  erro("\n   UNSHOCK -=> Password inv lida ! Descompress„o n„o permitida !!!");
}



                    /* -=>  estatistica ()  <=- */

void estatistica(int fprocessed)
{
 int min=0,sec=0;
 unsigned double tempo=0;

 tempo=clock();
 sec=tempo/CLK_TCK;
 min=sec/60;           /*  Calcula os minutos                                   */
 sec=sec-(60*min)+1;                /* e os segundos ...                        */

 printf("\n\n   N£mero total de ficheiros descomprimidos : %d ficheiro(s) .",fprocessed);
 printf("\n   Tempo total de descompress„o : %d min, %d sec .\n\n",min,sec);
}



                  /* -=>  coloca_data_hora ()  <=- */

void coloca_data_hora(int stream,unsigned char filename[])
{
 extern struct ftime the_time;
 int stat;

 stat=setftime(stream,&the_time);
 if (stat==ERR_ESC)
 {
  printf("\n\n   UNSHOCK -=>  Impossivel escrever data/hora no ficheiro %s !!!"
                                                                 ,filename);
  som();
  halt();
 }
}



                     /* -=>  cbreak () <=- */

int cbreak()
{
 extern unsigned char fileSHK[];

 close(in_stream);
 unlink(fileSHK);
 printf("\n   UNSHOCK -=>  CONTROL + BREAK  pressionado...");
 return 0;
}


                      /* -=>  halt () <=- */

void halt()
{
 free(buffer);
 free(out);
 exit(1);
}