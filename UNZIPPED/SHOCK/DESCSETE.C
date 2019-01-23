

                         /* UNSHOCK Ver 1.0 */
          /* DESCSETE.C ú M‚todo 6 - CompressÆo SETE BITS */

#include <stdio.h>
#include <string.h>

#include "unproto.h"
#include "unconfig.h"

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;


                    /* -=> descsete () <=- */

unsigned descsete(unsigned char filename[])
{
 int i=0,k=0,opc=0,numbyte;
 unsigned char a,b;
 char s[7];

 printf("\r    Aumentando      %s",strupr(filename));

 numbyte=buffer[0];
 for (i=1;i < datasize-numbyte;i++)
 {
  a=0;
  for (k=0;k < 7;++k)
  {
   b = buffer[i++];
   s[k]=b & 127;
   b = b & 128;
   b = b >> k;
   a = a | b;
  }
  i--;
  a = a >> 1;
  out[opc++]=a;
  for (k=0;k < 7;++k) out[opc++]=s[k];
 }
 for (;i < datasize;i++) out[opc++]=buffer[i];

 return opc;
}
