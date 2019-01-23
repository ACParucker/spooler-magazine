

                         /* UNSHOCK Ver 1.0 */
     /*  LE_SHK.C ú Modulo que lˆ o ficheiro comprimido e procede  */
                     /*    … descompress„o    */

#include <stdio.h>
#include <io.h>
#include <string.h>
#include <stdlib.h>

#include "unproto.h"
#include "unconfig.h"


struct ftime the_time;
int metodo;

extern int param_d;
extern unsigned char nofp[];
extern int datasize;



                      /* -=> le_ID () <=- */

int le_ID(int stream)
{
 extern int param_d;
 unsigned char aux[70]={""};
 unsigned char *ID=INFODAT;
 unsigned char sep=*SEPARADOR,readsep;
 unsigned char datim[NML]={""};
 int i=0,j=0,l=0;
 long start=0;

 for (i=0;i <= 13;i++) { nofp[i]=''; }
 i=0;
 start=tell(stream);
 read(stream,aux,70);

 if ((aux[i]!=ID[0]) && (aux[i+1]!=ID[1])) erro_fileSHK();
 i+=2;
 for (;i <= i+13;i++,j++)
 {
  if (aux[i]!=sep) nofp[j]=aux[i];
  else break;
 }

 readsep=aux[i++];
 if (readsep!=sep) erro_fileSHK();

 if (param_d)
 {
  if (strcmp(nofp,"")!=0)
  {
   le_data_hora(aux,i);
   if (param_d) i+=12;
  }
 }
 metodo=(int)aux[i++];
 readsep=aux[i++];
 if (readsep!=sep) erro_fileSHK();

 j=i;
 do readsep=aux[i++]; while (readsep!=sep);
 for (;j < i;j++,l++) datim[l]=aux[j];
 datasize=atoi(datim);

 lseek(stream,start+i,SEEK_SET);
 return metodo;
}


                   /* -=> le_data_hora () <=- */

void le_data_hora(char aux[],int pos)
{
 unsigned char datim[1]={""};
 unsigned char sep=*SEPARADOR,readsep;

 datim[0]=aux[pos++];datim[1]=aux[pos++];
 if (datim[1]==sep) param_d=FALSE;
 else
 {
  the_time.ft_year=atoi(datim);
  datim[0]=aux[pos++];datim[1]=aux[pos++];
  the_time.ft_month=atoi(datim);
  datim[0]=aux[pos++];datim[1]=aux[pos++];
  the_time.ft_day=atoi(datim);
  readsep=aux[pos++];
  if (readsep!=sep) erro_fileSHK();
  datim[0]=aux[pos++];datim[1]=aux[pos++];
  the_time.ft_hour=atoi(datim);
  datim[0]=aux[pos++];datim[1]=aux[pos++];
  the_time.ft_min=atoi(datim);
  readsep=aux[pos++];
  if (readsep!=sep) erro_fileSHK();
 }
}


                   /* -=> descomprime () <=- */

void descomprime(int stream,int metodo,unsigned char nofp[])
{
 unsigned tam_descdat=0;
 int stat;
 extern unsigned char *out;
 extern int datasize;

 switch (metodo)
 {
  case NONE     : repoe(stream,nofp,datasize);break;
  case COMPFIL  : tam_descdat=descfil(nofp);break;
  case COMPDIAT : tam_descdat=descdiat(nofp);break;
  case COMPBYTE : tam_descdat=descbyte(nofp);break;
  case COMPMAP  : tam_descdat=descmap(nofp);break;
  case COMPSETE : tam_descdat=descsete(nofp);break;
  case COMPHUFF : tam_descdat=deschuff(nofp);break;
  default: erro_fileSHK();
 }
 if (tam_descdat!=0)
 stat=write(stream,out,tam_descdat);
 if (stat==ERR_ESC) erro("   SHOCK -=>  Erro na escrita do ficheiro %s !!!");
}


                     /* -=> repoe () <=- */


void repoe(int stream,unsigned char filename[],int tamdat)
{
 extern unsigned char *buffer;

 printf("\r    Repondo         %s",strupr(filename));
 write(stream,buffer,tamdat);
}


                  /* -=> erro_fileSHK () <=- */

void erro_fileSHK()
{
 erro("\n   SHOCK -=> Erro na leitura do ficheiro comprimido !!!");
}