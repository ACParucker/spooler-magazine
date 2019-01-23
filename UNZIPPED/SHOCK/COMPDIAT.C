
                           /* SHOCK Ver 1.0 */
           /* COMPDIAT.C ú M‚todo 4 - CompressÆo Diat¢mica */

#include <stdio.h>            /* printf()                                      */
#include <io.h>               /* filelength()                                  */
#include <string.h>           /* strcpy(),strcmp(),strupr()                    */
#include <conio.h>

#include "proto.h"

unsigned char

         par[][3]={  "  ","a ","m ","r ","re",
                     "de","pr","ac","os","on",   /* pares provaveis de */
                     "en","an","in","ba","ca",    /*   ocurrencia    */
                     "as","ng","e ","o "," a",
                     " e","th","\r\n"," d","wh"
                  };


extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;


                     /* -=>  compdiat ()  <=- */

unsigned compdiat(unsigned char *filename)
{
 int i=0,
     k=0,
     l=0,
     lk=0,
     flag=0,
     x=0,
     z=0;

 unsigned char a[3];

 printf("\r    Esmagando    %s",strupr(filename));

 lk=sizeof(par)/sizeof(par[0]);

 for(i=0;i < datasize;i++)
 {
  for(x=i,z=0;z<2 && buffer[x];z++,x++)
  {
   a[z]=buffer[x];
  }
  a[z]=0;
  flag=0;

  for(k=0;k<lk;k++)
  {
   if(strcmp(a,par[k])==0)
   {
    out[l++]=k+225;
    i++;
    flag=1;
    break;
   }
  }
  if (!flag)
  {
   out[l++]=a[0];
  }
 }
 return l;
}



