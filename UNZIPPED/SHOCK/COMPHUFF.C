
                          /* SHOCK Ver 1.0 */
           /* COMPHUFF.C ú M‚todo 1 - Codifica‡Æo de Huffman */


#include <stdio.h>               /* printf()                                    */
#include <stdlib.h>              /* div()                                       */
#include <io.h>                  /* filelength(),lseek()                        */
#include <math.h>                /* ceil()                                      */
#include <string.h>              /* strupr()                                    */
#include <conio.h>               /* wherex(),wherey(),gotoxy()                  */

#include "proto.h"
#include "config.h"

extern unsigned char *buffer;
extern unsigned char *out;
extern int datasize;
extern long infile_size;
extern int param_m;

           /* Estructura da arvore para o codigo Huffman */

struct arv {
            int freq;    /* Frequencia */
            int parent;  /* " No-pai " */
            int left;    /* " No-filho " esquerdo */
            int right;   /* " No-filho " direita */
           } node;


int list[255];       /* Lista dos indices para a arvore */
struct arv tree[511];          /* Arvore */

int csete,SC;


                       /* -=> sortlist () <=- */


void sortlist()           /* SHELL SORT modificado */
{               /* Ordena a lista dos indices para a arvore */
 int i,j,h,       /* por ordem decrescente de frequencia */
     Tmp;

 h=364;

 do
 {
  h=h/3;
  for(i=h+1;i<=256;i++)
  {
   Tmp=list[i-1];
   j=i;
   /* Compara as entradas da arvore */
   while((tree[list[j-h-1]].freq < tree[Tmp].freq) && (j>h))
   {
    /* Troca valores */
    list[j-1]=list[j-h-1];
    j=j-h;
   }
   list[j-1]=Tmp;
  }
 } while(h!=1);
}

                       /* -=> maketree () <=- **/


void maketree()      /* Cria a arvore Huffman */
{
 int i=0,j=0,         /* Vars Contadoras */
     ListCnt=0,       /* Contador da Lista */
     TreeCnt=0,       /* Contador da Arvore */
     NewFreq=0;


 /* Inicializa a arvore e a lista */
 for(i=0;i<=255;i++)
 {
  tree[i].freq=0;
  tree[i].parent=-1;
  list[i]=i;
 }

 for(i=0;i < datasize;i++) tree[buffer[i]].freq++;

 for (j=0;j <= 255;j++)
 {
  tree[j].freq=(int)ceil((float)tree[j].freq/101);
 }

 i=1;
 csete=TRUE;
 SC=1000;

 if (param_m)
 {
  do
  {
   if (SC==1000)
    if (tree[i].freq==0) SC=i;

   if (i > 126)
   {
    if (tree[i].freq!=0) csete=FALSE;
    if (SC!=1000 && csete==FALSE) break;
   }
   i++;
  } while (i <= 255);
 }
 else
 {
  for (i=127;i <= 255;i++)
   if (tree[i].freq!=0) csete=FALSE;
 }

 sortlist();             /* Ordena a lista */

 ListCnt=255;

 /* Posiciona ListCnt na primeira frequencia na arvore maior que zero */
 while((ListCnt>0) && (tree[list[ListCnt]].freq==0)) ListCnt--;

 TreeCnt=255;

 /* Cria a Arvore */
 while (ListCnt>0)
 {
  TreeCnt++;
  /* Combina duas frequencias */
  NewFreq=tree[list[ListCnt]].freq + tree[list[ListCnt-1]].freq;
  tree[TreeCnt].freq=NewFreq;
  tree[TreeCnt].parent=-1;
  /* Determina os " Nos-filhos " */
  tree[TreeCnt].left=list[ListCnt];
  tree[TreeCnt].right=list[ListCnt-1];
  /* Determina o " No-pai " */
  tree[list[ListCnt-1]].parent=-TreeCnt;
  tree[list[ListCnt]].parent=TreeCnt;
  ListCnt--;
  i=ListCnt;

  while( (i>0) && (NewFreq > tree[list[i-1]].freq) )
  {
   list[i]=list[i-1];
   i--;
  }
  list[i]=TreeCnt;
 }
}

                        /* -=> encode () <=- */


unsigned encode()         /* Codifica o ficheiro */
{
 int i=0,             /* Var Contadora */
     nodenumb,        /* Num. do no */
     code;            /* Carac. codificado */

 unsigned ocount;     /* Contador buffer saida */

 int  bitnumb,    /* Num. do bit */
      codebit;    /* Mascara */


 ocount=256;
 bitnumb=7;           /* Inicializa vars */
 out[256]=0;

 /* Codifica cada caracter do fich. entrada */
 for(i=0;i < datasize;i++)
 {
  nodenumb=buffer[i];          /* N£mero do n¢-terminal */
  codebit=0;
  code=0;
  /* Codifica at‚ … raiz */
  while (nodenumb!=list[0])
  {
   if (tree[nodenumb].parent>0)
   {
    code=code | (1 << codebit);
   }
   codebit++;
   /* Posiciona no " N¢-pai " */
   nodenumb=abs(tree[nodenumb].parent);
  }
  /* Escreve bits de "code" para o buffer de saida */
  while (codebit>0)
  {
   codebit--;
   if ((code & (1 << codebit)) !=0 )
   {
    out[ocount]=out[ocount] | (1 << bitnumb);
   }
   if (bitnumb > 0) bitnumb--;
   else
   {
    ocount++;
    bitnumb=7;
    out[ocount]=0;
   }
  }
 }

 if ( bitnumb != 7 ) ocount++;
 out[ocount++]=bitnumb+1;

 return ocount;
}


                        /* -=> comphuff () <=- */

                  /* FuncÆo principal do compressor */

unsigned int comphuff()
{
 int i;
 unsigned tam_huff=0;

 maketree();                              /* Cria  rvore */

 for(i=0;i<=255;i++)
 {
  out[i]=tree[i].freq;
 }

 tam_huff=encode();                  /* Codifica */

 if (tam_huff==257) tam_huff=0;
 return tam_huff;
}
