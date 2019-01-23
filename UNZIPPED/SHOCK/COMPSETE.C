
                          /* SHOCK Ver 1.0 */
          /* COMPSETE.C ú M‚todo 6 - CompressÆo SETE BITS */


#include <stdio.h>            /*  printf()                                     */
#include <io.h>               /*  filelength()                                 */
#include <string.h>           /*  strupr()                                     */
#include <conio.h>

#include "proto.h"

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;


                    /* -=> compsete () <=- */

unsigned compsete(unsigned char *filename)
{
 int i=0,
     k=0,
     opc=0;

 unsigned char a,b;

 printf("\r    Reduzindo    %s",strupr(filename));

 out[opc++]=(int)(datasize-((datasize/8)*8));

 for(i=0;i < datasize;i++)
 {
  if (i+8 <= datasize)
  {
   a = buffer[i++];
   a = a << 1;
   for (k=0;k<7;++k)
   {
    b = buffer[i++];
    b = b & 127;
    b = b | ((a << k) & 128);
    out[opc++] = b;
   }
   i--;
  }
  else for (;i < datasize;i++) out[opc++]=buffer[i];
 }
 return opc;
}


