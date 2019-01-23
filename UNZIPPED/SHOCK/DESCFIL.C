
                         /* UNSHOCK Ver 1.0 */
       /* DESCFIL.C ú M‚todo 2 - CompressÆo Comprimento de Fileira */


#include <stdio.h>
#include <string.h>

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;


unsigned descfil(unsigned char filename[])
{
 int i=1,
     l=0,
     k=0,
     j=0;

 unsigned char a,SC;

 SC=buffer[0];

 printf("\r    Descompactando  %s",strupr(filename));
 for(i=1;i < datasize;i++)
 {
  if (buffer[i]==SC)
  {
   a=buffer[i+1];
   k=buffer[i+2];
   for (l=0;l<k;l++) out[j++]=a;
   i+=2;
  }
  else
  {
   out[j++]=buffer[i];
  }
 }
 return j;
}
