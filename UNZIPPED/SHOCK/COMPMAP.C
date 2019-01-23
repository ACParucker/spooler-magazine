
                          /* SHOCK Ver 1.0 */
             /* COMPMAP.C ú M‚todo 3 - Mapeamento de bit */


#include <stdio.h>            /* printf()                                      */
#include <io.h>               /* filelength()                                  */
#include <string.h>           /* strupr()                                      */
#include <math.h>             /* ceil()                                        */

#include "proto.h"

unsigned char mascara[8]={ 1,2,4,8,16,32,64,128 };

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;
extern int SC;



                     /* -=>  compmap ()  <=- */

unsigned compmap(unsigned char *filename)
{
 int j=0,k=0,i=0,
     l=0,m=0,p=0,c=0,
     h=0,fn=0,val=50;


 unsigned char a,
               b,
               mapa;

 printf("\r    Minimizando  %s",strupr(filename));

 out[j++]=SC;
 for(i=0;i < datasize;i++)
 {
  l=i;fn=0;k=1;

  if (datasize < val) val=datasize;

  a=buffer[i];
  do
  {
   b=buffer[l];
   if(a==b)
   {
    k++;c=l;
   }
   l++;
  }
  while(l < val);

  fn=(int)(ceil((float)(c-i)/8))+3;

  if (k > fn)
  {
   out[j]=SC;
   out[j+1]=a;
   out[j+2]=fn-3;

   p=j+2;j+=3;l=i;
   mapa=0;

   do
   {
    b=buffer[l];
    if (a==b)
    {
     mapa=mapa|mascara[m++];
    }
    else
    {
     m++;
    }

    if(m==8)
    {
     m=0;
     out[j++]=mapa;
     mapa=0;
    }
    l++;
   }
   while (l<=c);

   if (m!=0)
   {
    h=m;out[p]--;
    mapa=0;
   }

   for(c=i;c < val-h;c++)
   {
    b=buffer[c];
    if (b!=a)
    {
     out[j++]=b;
    }
   }
   for (;c < val;c++) out[j++]=buffer[c];

   i=val-1;
   val+=50;
   c=0;m=0;
  }
  else
  {
   out[j++]=a;
  }
 }

 return j;
}
