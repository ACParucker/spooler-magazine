
                         /* UNSHOCK Ver 1.0 */
             /* DESCMAP.C ú M‚todo 3 - Mapeamento de bit */


#include <stdio.h>
#include <string.h>

#include "unproto.h"

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;


                        /* -=> descmap () <=- */

unsigned descmap(unsigned char filename[])
{
 int i=0,
     l=0,
     k=0,
     j=0,
     m=0,
     c=0;

 unsigned char mascara[8]={ 1,2,4,8,16,32,64,128 };

 unsigned char a,
               b,
               mapa,
               id,SC;

 printf("\r    Maximizando     %s",strupr(filename));

 SC=buffer[0];

 for(i=1;i < datasize;i++)
 {
  a=buffer[i];
  if(a==SC)
  {
   b=buffer[i+1];
   k=buffer[i+2];
   i+=3;c=i+k;

   for(l=0;l<k;l++)
   {
    mapa=buffer[i++];
    for(m=0;m<8;m++)
    {
     id=0;
     id=mapa&mascara[m];
     if(id==mascara[m])
     {
      out[j++]=b;
     }
     else
     {
      if (c < datasize)
      {
       out[j++]=buffer[c++];
      }
     }
    }
   }
   i=c-1;
  }
  else
  {
   out[j++]=a;
  }
 }
 return j;
}


