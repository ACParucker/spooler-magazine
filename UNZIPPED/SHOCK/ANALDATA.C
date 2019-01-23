

                           /* SHOCK Ver 1.0 */
             /* ANALDATA.C ú Rotinas de an lise de dados */


#include <string.h>                 /*   strcat(),strcmp()                      */
#include <math.h>                   /*   ceil()                                 */

#include "proto.h"
#include "config.h"

int cdiat=FALSE;

long int compress[6];      /*  Guarda o n£mero de bytes resultantes          */
                                     /*    da analise dos v rios m‚todos     */


                    /* -=>  analdata ()  <=- */


int analdata(int datasize)
{
 extern int SC;
 extern unsigned char *buffer;

 int compFIL=0,compDIAT=0,compMAP=0,compBYTE=0;
 int repFIL=0,repMAP=0,repBYTE=0;
 int i,i2=0,l,fn=0,c,val=50;
 int met=0,met2=0,metsec=0;
 int cdiat=TRUE;

 unsigned char aux,aux2,aux3;
 unsigned char
         par[][3]={  "  ","a ","m ","r ","re",
                     "de","pr","ac","os","on",   /* pares provaveis de */
                     "en","an","in","ba","ca",    /*   ocurrencia    */
                     "as","ng","e ","o "," a",
                     " e","th","\r\n"," d","wh"
                  };

 int lk=sizeof(par)/sizeof(par[0]);

 for (i=0;i < 6;i++) compress[i]=0;

 for(i=0;i < datasize;i++)
 {
  aux=buffer[i];

  if (cdiat)
   if (aux >= 225) cdiat=FALSE;

  if (SC!=1000)
  {
   /* Analisa COMPFIL */
   if (aux==buffer[i+1]) repFIL++;
   else
   {
    if(repFIL > 2) compFIL+=repFIL-2;
    repFIL=0;
   }
   if (repFIL == 255) { compFIL+=252;repFIL=0; }

   /* Analisa COMPBYTE */
   if((aux=='$' || aux==',' || aux=='.' || aux=='*') ||
                                          (aux>='0' && aux<='9')) repBYTE++;
   else
   {
    if(repBYTE>5) compBYTE+=repBYTE-((int)(ceil((float)repBYTE/2))+2);
    repBYTE=0;
   }

   /* Analisa COMPMAP */
   if (i==val-50)
   {
    i2=i;
    if (datasize < val) val=datasize;

    do
    {
     l=i2;fn=0;repMAP=0;
     aux2=buffer[i2];
     do
     {
      aux3=buffer[l];
      if(aux2==aux3)
      {
       repMAP++;c=l;
      }
      l++;
     }
     while(l < val);

     fn=(int)(ceil((float)(c-i2)/8))+3;

     if (repMAP>fn)
     {
      val+=50;c=0;
      compMAP+=repMAP-fn;
     }
     i2++;
    } while (i2 < val && repMAP <= fn);
   }
  }

  /* Analisa COMPDIAT */
  if (cdiat)
  {
   aux2=buffer[i+1];
   for(i2=0;i2<lk;i2++)
   {
    if ((aux==par[i2][0]) && (aux2==par[i2][1])) { compDIAT++;break; }
   }
  }

  if (!cdiat && SC==1000) break;
 }

 if (cdiat) compress[COMPDIAT]=datasize-((compDIAT/3)*2);
 else compress[COMPDIAT]=0;

 if (SC!=1000)
 {
  compress[COMPBYTE]=datasize-compBYTE+1;
  compress[COMPFIL]=datasize-compFIL+1;
  compress[COMPMAP]=datasize-compMAP+1;

  if (cdiat && compress[COMPDIAT]<compress[COMPFIL]) met=COMPDIAT;
  else met=COMPFIL;
  if (compress[COMPBYTE]<compress[COMPMAP]) met2=COMPBYTE;
  else met2=NONE;
  if (compress[met]<compress[met2]) metsec=met;
  else metsec=met2;
 }
 else
 {
  if (cdiat) metsec=2;
  else metsec=0;
 }

 return metsec;
}