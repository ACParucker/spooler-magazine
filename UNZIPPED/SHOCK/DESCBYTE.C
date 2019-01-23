
                         /* UNSHOCK Ver 1.0 */
           /* DESCBYTE.C ú M‚todo 5 - CompressÆo meio byte */


#include <stdio.h>
#include <string.h>
#include <math.h>

#include "unproto.h"
#include "unconfig.h"

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;


                     /* -=> descbyte () <=- */

unsigned descbyte(unsigned char filename[])
{
 int j=0,
     k=0,
     m=0,
     l=0,
     x=0,
     y=0,
     i=0;

 unsigned char  a,z,SC;

 char mascara1=0xf0,
      mascara2=0xf;

 printf("\r    Espremendo      %s",strupr(filename));

 SC=buffer[0];

 for(i=1;i < datasize;i++)
 {
  a=buffer[i];

  if(a==SC)
  {
   k=buffer[i+1];
   i+=2;
   m=i+(k/2);
   l=i;

   for(;l < m;l++)
   {
    z=buffer[l];
    x=(z&mascara1)>>4;

    if(x<10)
    {
     out[j]=x+48;
    }
    else
    {
     switch(x)
     {
      case 10:out[j]='$';break;
      case 11:out[j]=',';break;
      case 12:out[j]='.';break;
      case 13:out[j]='*';break;
     }
    }
    y=z&mascara2;
    if(y<10)
    {
     out[j+1]=y+48;
    }
    else
    {
     switch(y)
     {
      case 10:out[j+1]='$';break;
      case 11:out[j+1]=',';break;
      case 12:out[j+1]='.';break;
      case 13:out[j+1]='*';break;
     }
    }
    j+=2;
   }
   i=m;
   i--;
  }
  else
  {
   out[j++]=a;
  }
 }
 return j;
}



