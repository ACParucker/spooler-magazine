
                           /* SHOCK Ver 1.0 */
             /*OPCOES.C ú M¢dulo de an lise de parametros */
                     /* e outras func”es diversas */


#include <stdio.h>                 /*   printf()                               */
#include <string.h>                /*   strlen(),strcat(),strchr()             */
#include <bios.h>                  /*   biosmemory()                           */
#include <ctype.h>                 /*   tolower()                              */
#include <dos.h>                   /*   sound()                                */
#include <process.h>               /*   exit()                                 */

#include "proto.h"
#include "config.h"

int param_p=FALSE,       /*  Verifica se existe o parametro -P(assword)        */
    param_s=TRUE,        /*  Verifica se existe o parametro -S(om)             */
    param_m=FALSE,       /*  Verifica se existe o parametro -M(etodo)          */
    param_r=FALSE,       /*  Verifica se existe o parametro -R(eescreve)       */
    param_d=TRUE,        /*  Verifica se existe o parametro -D(ata\hora)       */
    param_a=FALSE;       /*  Verifica se existe o parametro -A(paga)           */


unsigned char fileSHK[NML]={""},
              infiles[NML]={""},
              password[NML]={""};



                     /* -=>  ver_param ()  <=- */


int ver_param(int param_cont,char *param[])
{
 int cont=0,i=0,              /*  Vari veis contadoras                         */
     non_option=0;

 unsigned char *aux;          /*  Vari vel auxiliar                            */


 if (param_cont > 13) ajuda("Demasiados parametros !!!");

 else if (param_cont < 2 ) ajuda("Faltam parametros !!!");

 for (cont=1;cont < param_cont;cont++)
 {
  aux=param[cont];

  if (aux[0]=='-')
  {
   tolower(aux[1]);
   switch (aux[1])
   {
          case 'p': {
                     if ((strlen(aux)-2) > 40)
                        erro("Password demasiado extensa!");
                        for (i=2;i<=strlen(aux);i++)
                        password[i-2]=aux[i];
                     param_p = TRUE; break;
                    }

          case 's': param_s = FALSE; break;

          case 'm': param_m = TRUE; break;

          case 'r': param_r = TRUE; break;

          case 'd': param_d = FALSE; break;

          case 'a': param_a = TRUE; break;
   }
  }

  else
  {
   non_option++;
   if (non_option==1)
   {
    strcpy(fileSHK,aux);
    if (strchr(fileSHK,'.')==NULL) strcat(fileSHK,".SHK");
   }
   else
   {
    strcat(infiles,aux);
    strcat(infiles,";");
   }
  }
 }

 if (non_option<1) ajuda(" necess rio especificar o ficheiro de destino !!!");
 else if (non_option==1) strcpy(infiles,"*.*;");
 else if (non_option>1) non_option--;

 return non_option;
}


                        /* -=>  ajuda ()  <=- */

                   /* Ecran de ajuda ao utilizador */

void ajuda(char *msg)
{
 printf("\n  SHOCK  Ver 1.0                                         1994 ú J.R. Iria");

 printf("\n\n    Syntax :  SHOCK [-<op> [-<op>...]] <SHK_file> [<in_files>...] .");

 printf("\n\n    Op‡äes :");
 printf("\n            -m: Activa utiliza‡„o dos m‚todos secund rios (+compress„o).");
 printf("\n            -d: Desactiva a perserva‡„o da data/hora dos ficheiros orig.");
 printf("\n            -p: Protege com password, especificada a seguir a '-p'.");
 printf("\n            -r: Desactiva a quest„o de permiss„o para reescrever.");
 printf("\n            -a: Activa a elimina‡„o dos ficheiros originais.");
 printf("\n            -s: Desactiva o som de aviso.");

 printf("\n\n    Exemplos :");
 printf("\n              shock -m -r spooler.shk *.spo                                    ");
 printf("\n              shock -pspooler fontes *.c *.pas                                ");
 printf("\n              shock -d -s -a cartas carta1.wri carta2.doc                       ");

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

void mostra_inf(void)
{
 printf("\n\n   SHOCK  Ver 1.0                                      1994 ú J.R. Iria");
 printf("\n\n    Ficheiro(s) a comprimir : %s .",infiles);
 if (param_d)
 printf("\n    Preservando a data/hora dos ficheiros originais .");
 if (param_a)
 printf("\n    Apagando os ficheiros originais .");
 if (param_r)
 printf("\n    Reescrevendo sem questionar .");
 if (param_s)
 printf("\n    Som activado .");
 else printf("\n    Som desactivado .");
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