

                          /* SHOCK Ver 1.0 */
       /* COMFIL.C ú M‚todo 2 - CompressÆo Comprimento de Fileira */


#include <stdio.h>            /* printf()                                      */
#include <io.h>               /* filelength()                                  */
#include <string.h>           /* strupr()                                      */
#include <conio.h>

#include "proto.h"

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;
extern int SC;


                     /* -=>  compfil ()  <=- */

unsigned compfil(unsigned char *filename)
{
 int i=0,
     k=1,
     j=0;

 unsigned char a,
               b;

 printf("\r    Compactando  %s",strupr(filename));

 out[j++]=SC;
 for(i=0;i < datasize;i++)
 {
  a=buffer[i];

  if (a==buffer[i+1])
  {
   b=a;
   k++;
   if (k!=255) continue;
   else i++;
  }

  if (k>3)
  {
   out[j]=SC;
   out[j+1]=b;
   out[j+2]=k;
   j+=3;
   k=1;
  }
  else
  {
   out[j]=a;
   if (k>1) out[j+1]=a;
   if (k>2) out[j+2]=a;
   j+=k;
   k=1;
  }
 }
 return j;
}
