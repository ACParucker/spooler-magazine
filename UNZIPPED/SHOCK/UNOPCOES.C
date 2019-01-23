
                          /* UNSHOCK Ver 1.0 */
            /* UNOPCOES.C ú M¢dulo de an lise de parametros */
                     /* e outras func”es diversas */


#include <stdio.h>                 /*   printf()                               */
#include <string.h>                /*   strlen(),strcat(),strchr()             */
#include <bios.h>                  /*   biosmemory()                           */
#include <ctype.h>                 /*   tolower()                              */
#include <dos.h>                   /*   sound()                                */
#include <process.h>               /*   exit()                                 */

#include "unproto.h"
#include "unconfig.h"

int param_p=FALSE,       /*  Verifica se existe o parametro -P(assword)        */
    param_s=TRUE,        /*  Verifica se existe o parametro -S(om)             */
    param_r=FALSE,       /*  Verifica se existe o parametro -R(eescreve)       */
    param_d=TRUE,        /*  Verifica se existe o parametro -D(ata/Hora)       */
    param_a=FALSE;       /*  Verifica se existe o parametro -A(paga)           */


unsigned char fileSHK[NML]={""},
              password[NML]={""};


                     /* -=>  ver_param ()  <=- */


void ver_param(int param_cont,char *param[])
{

 int cont=0,i=0;              /*  Vari veis contadoras                         */

 unsigned char *param_aux;        /*  Vari vel auxiliar                        */

 if (param_cont > 5) ajuda("Demasiados parametros !!!");
 if (param_cont < 2) ajuda("Faltam parametros !!!");
 for (cont=1;cont < param_cont;cont++)
 {
  param_aux = param[cont];

  if (param_aux[0]=='-')
  {
   tolower(param_aux[1]);
   switch (param_aux[1])
   {
          case 'p': {
                     for (i=2;i<=strlen(param_aux);i++)
                         password[i-2]=param_aux[i];
                     param_p = TRUE; break;
                    }

          case 's': param_s = FALSE; break;

          case 'r': param_r = TRUE; break;

          case 'a': param_a = TRUE; break;
   }
  }
  else strcpy(fileSHK,param_aux);
  if (strchr(fileSHK,'.')==NULL) strcat(fileSHK,".SHK");
 }
}


                        /* -=>  ajuda ()  <=- */

                  /* Ecran de ajuda ao utilizador */

void ajuda(char *msg)
{
 printf("\n  UNSHOCK  Ver 1.0                                    1994 ú J.R. Iria");

 printf("\n\n    Syntax :  UNSHOCK [-<op> [-<op>...]] [<SHK_file>] .");

 printf("\n\n    Op‡äes :");
 printf("\n            -p: Password especificada na prompt, a seguir a '-p'.");
 printf("\n            -r: Desactiva a quest„o de permiss„o para reescrever .");
 printf("\n            -a: Activa a elimina‡„o do ficheiro .SHK .");
 printf("\n            -s: Desactiva o som de aviso .");

 printf("\n\n    Exemplos :");
 printf("\n              unshock -r spooler.shk                      ");
 printf("\n              unshock -pspooler -a fontes                 ");

 printf("\n\n    %s\n",msg);
 som();
 halt();
}


                          /* -=> erro () <=-*/


void erro(char *msg)
{
 printf("%s\n",msg);
 som();
 halt();
}


                       /* -=> mostra_inf () <=- */

void mostra_inf(unsigned char compfiles[])
{
 printf("\n\n   UNSHOCK  Ver 1.0                                  1994 ú J.R. Iria");
 printf("\n\n    Ficheiro a descomprimir : %s .",strlwr(compfiles));
 if (param_r)
 printf("\n    Reescrevendo sem questionar .");
 if (param_a)
 printf("\n    Apagando o ficheiro .SHK .");
 if (param_s)
 printf("\n    Som activado .");
 else printf("\n    Som desactivado .");
 printf("\n\n");
}


                       /* -=> som () <=- */

void som()
{
 int i;

 if (param_s==TRUE)
 {
  for (i=0;i<3;i++)
  {
   sound(509);sound(410);delay(5);
   sound(630);delay(20);sound(470);delay(25);
   sound(570);delay(25);sound(675);delay(15);
   nosound();
  }
 }
}
