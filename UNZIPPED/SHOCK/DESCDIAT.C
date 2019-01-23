
                          /* UNSHOCK Ver 1.0 */
           /* DESCDIAT.C ú M‚todo 4 - CompressÆo Diat¢mica */

#include <stdio.h>
#include <io.h>
#include <string.h>
#include <conio.h>


extern unsigned char *buffer,*out;
extern int datasize;

unsigned char

         par[][3]={  "  ","a ","m ","r ","re",
                     "de","pr","ac","os","on",   /* pares provaveis de */
                     "en","an","in","ba","ca",    /*   ocurrencia    */
                     "as","ng","e ","o "," a",
                     " e","th","\r\n"," d","wh"
                  };



                     /* -=>  descdiat ()  <=- */

unsigned descdiat(unsigned char filename[])
{
 int i=0,
     l=0;

 printf("\r    Esmagando       %s",strupr(filename));

 for(i=0;i < datasize;i++)
 {
  if(buffer[i]>224)
  {
   out[l++]=par[buffer[i]-225][0];
   out[l++]=par[buffer[i]-225][1];
  }
  else
  {
   out[l++]=buffer[i];
  }
 }
 return l;
}

