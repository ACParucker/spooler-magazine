

                          /* SHOCK Ver 1.0 */
         /* ESC_SHK.C ú M¢dulo que escreve o ficheiro .SHK */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <io.h>
#include <string.h>
#include <dos.h>
#include <conio.h>

#include "proto.h"
#include "config.h"


extern unsigned char *buffer;


                      /* -=> comprime () <=- */


long comprime(int datasize, unsigned char *nofp, long unsigned double proc)
{
 int metodo=COMPHUFF,metsec=NONE;
 unsigned tam_compdat=0;

 extern int out_stream;
 extern long int compress[6];
 extern long infile_size;
 extern int param_m,csete;

 tam_compdat=comphuff();

 if (param_m) metsec=analdata(datasize);

 if (csete)
   compress[COMPSETE]=(int)(datasize-(datasize*((float)12.5/100))+1);
 else compress[COMPSETE]=0;

 if (param_m==FALSE) metsec=COMPSETE;
 else
 {
  if (csete && compress[COMPSETE] < compress[metsec]) metsec=COMPSETE;
 }

 if (metsec>0 && metsec<6)
 {
  if ((tam_compdat>compress[metsec]) && (compress[metsec]>0))
  {
   if (metsec==COMPDIAT) tam_compdat=compdiat(nofp);
   else if (metsec==COMPFIL) tam_compdat=compfil(nofp);
   else if (metsec==COMPMAP) tam_compdat=compmap(nofp);
   else if (metsec==COMPBYTE) tam_compdat=compbyte(nofp);
   else if (metsec==COMPSETE) tam_compdat=compsete(nofp);

   metodo=metsec;
  }
  else printf("\r    Condensando  %s",strupr(nofp));
 }
 else printf("\r    Condensando  %s",strupr(nofp));

 if ((tam_compdat >= datasize) || (tam_compdat==0))
 {
  metodo=NONE;
  tam_compdat=datasize;
 }

 esc_infodat(out_stream,nofp,metodo,tam_compdat);
 if (metodo!=NONE) esc_compdat(out_stream,tam_compdat);
 else armazena(out_stream,nofp);

 gotoxy(31,wherey());
 printf("  (%d%)  ",(int)(100*((float)proc/infile_size)));

 return tam_compdat;
}



                    /* -=> esc_infodat () <=- */

void esc_infodat(int out_stream,unsigned char *nofp,int metodo,int tamdat)
{
 static unsigned char nom_fich[NML];
 extern int param_d;

 unsigned char tam[5]={""};

 write(out_stream,&INFODAT,2);

 if (strcmp(nom_fich,nofp)!=0)
 {
  strcpy(nom_fich,nofp);
  write(out_stream,nom_fich,strlen(nom_fich));
  write(out_stream,&SEPARADOR,1);
  if (param_d) esc_data_hora(out_stream);
 }
 else write(out_stream,&SEPARADOR,1);

 write(out_stream,&metodo,1);
 write(out_stream,&SEPARADOR,1);

 itoa(tamdat,tam,10);
 write(out_stream,&tam,strlen(tam));
 write(out_stream,&SEPARADOR,1);
}



                   /* -=> esc_data_hora () <=- */

void esc_data_hora(int out_stream)
{
 static struct ftime the_time;
 unsigned char datim[5];
 extern int in_stream;

 getftime(in_stream,&the_time);

 write(out_stream,(itoa(the_time.ft_year,datim,10)),2);
 write(out_stream,(itoa(the_time.ft_month,datim,10)),2);
 write(out_stream,(itoa(the_time.ft_day,datim,10)),2);
 write(out_stream,&SEPARADOR,1);
 write(out_stream,(itoa(the_time.ft_hour,datim,10)),2);
 write(out_stream,(itoa(the_time.ft_min,datim,10)),2);
 write(out_stream,&SEPARADOR,1);
}



                     /* -=> esc_compdat () <=- */

void esc_compdat(int out_stream, int tam_compdat)
{
 extern unsigned char *out;

 if (write(out_stream,out,tam_compdat) == -1)
 erro("\n   SHOCK -=> Impossivel escrever os dados comprimidos !!!");
}


                     /* -=>  armazena ()  <=- */

void armazena(int out_stream,unsigned char *filename)
{
 extern int datasize;

 printf("\r    Armazenando  %s",filename);

 write(out_stream,buffer,datasize);
}




