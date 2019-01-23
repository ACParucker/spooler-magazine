
                          /* SHOCK Ver 1.0 */
           /* COMBYTE.C ú M‚todo 5 - CompressÆo meio byte */


#include <stdio.h>            /* printf()                                      */
#include <io.h>               /* filelength()                                  */
#include <string.h>           /* strupr()                                      */
#include <conio.h>

#include "proto.h"

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;
extern int SC;



                       /* -=>  compbyte ()  <=- */

unsigned compbyte(unsigned char *filename)
{
 unsigned char a,
               c[500];

 char mascara1=0xf0,
      mascara2=0xf;

 int j=0,
     i=0,
     k=0,
     h=0;


 printf("\r    Espremendo   %s",strupr(filename));

 out[j++]=SC;
 for(i=0;i < datasize;i++)
 {
  c[h]=0;
  if (k==255) { a=0;i--; }
  a=buffer[i];

  switch(a)
  {
   case '$':c[h]=1;break;
   case ',':c[h]=2;break;
   case '.':c[h]=3;break;
   case '*':c[h]=4;break;
  }

  if(a>='0' && a<='9')
  {
   c[h]=5;
  }

  if(c[h]==0)
  {
   if(k>5)
   {
    int x=0,
        y=0,
        z=0,
        l=0;


    out[j]=SC;
    out[j+1]=k;
    j+=2;h=0;

    for(l=(i-k);l < i;l+=2)
    {
     switch(c[h])
     {
      case 1:x=0xa0;           break;
      case 2:x=0xb0;           break;
      case 3:x=0xc0;           break;
      case 4:x=0xd0;           break;
      case 5:x=(buffer[l]<<4); break;
     }
     x= x & mascara1;

     switch(c[h+1])
     {
      case 1:y=0xa;          break;
      case 2:y=0xb;          break;
      case 3:y=0xc;          break;
      case 4:y=0xd;          break;
      case 5:y=buffer[l+1];  break;
     }
     y= y & mascara2;
     z= x | y;
     out[j++]=z;
     h+=2;
    }

    if(l==i+1)
    {
     out[j-1]=buffer[i-1];
    }

    h=0;k=0;i--;

    goto Jump;
   }

   if(k>0)
   {
    int l2;

    for(l2=i-k;l2<i;l2++)
    {
     out[j++]=buffer[l2];
    }

    h=0;k=0;i--;

    goto Jump;
   }

   out[j++]=a;
   k=0;
   h=0;
  }
  else
  { k++;h++; }
  Jump:;
 }

 if(k>0)
 {
  for(i=datasize-k;i < datasize;i++) out[j++]=buffer[i];
 }

 return j;
}
