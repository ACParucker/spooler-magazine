


                           /* UNSHOCK Ver 1.0 */
           /* DESCHUFF.C ú M‚todo 1 - Codifica‡Æo de Huffman */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "unproto.h"

struct arv {
            int freq;    /* Frequencia */
            int parent;  /* " No-pai " */
            int left;    /* " No-filho " esquerdo */
            int right;   /* " No-filho " direita */
           } node;


int list[255];       /* Lista dos indices para a arvore */
struct arv tree[511];          /* Arvore */


extern unsigned char *buffer,*out;
extern int datasize;


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


                   /* -=> maketree () <=- */


void maketree()     /* Cria a arvore Huffman */
{
 int i=0,            /* Vars Contadoras */
     ListCnt=0,      /* Contador da Lista */
     TreeCnt=0,      /* Contador da Arvore */
     NewFreq=0;


 /* Inicializa a arvore e a lista */
 for(i=0;i<=255;i++)
 {
  tree[i].freq=buffer[i];
  tree[i].parent=-1;
  list[i]=i;
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


                     /* -=> decode () <=- */


unsigned decode()
{
 int nodenumb,              /* Num. do no */
     charnumb,              /* Num. do carac. no buffer de entrada */
     bitnumb,
     finalbyte,
     outpoint;              /* Ponteiro para a posicao no buffer de saida */


 bitnumb=7;
 outpoint=0;          /* Inicializa Vars */
 charnumb=256;
 finalbyte=buffer[datasize-1];
 if (finalbyte==8) finalbyte=0;

 /* Descodifica todos os carac. no buffer bit a bit */
 while (charnumb < datasize-1)
 {
  nodenumb=list[0];        /* Posiciona na raiz */
  while (nodenumb > 255)
  {
   if ((buffer[charnumb] & ( 1 << bitnumb ))==0)  /* Compara cada bit */
      nodenumb=tree[nodenumb].right;
   else                                       /* e escolhe o " No-filho " */
      nodenumb=tree[nodenumb].left;

   if (charnumb==datasize-2)
   {
    if (bitnumb > finalbyte) bitnumb--;
    else charnumb++;
   }
   else
   {
    if (bitnumb > 0 ) bitnumb--;              /* ate chegar ao no-terminal */
    else
    {
     charnumb++;
     bitnumb=7;
    }
   }
  }

  if (nodenumb >=0)
  {
   out[outpoint++]=nodenumb; /* Escreve carac. decodificado no buffer */
                                           /* de saida */
  }
 }
 return outpoint;
}


                    /* -=> descomprime () <=- */

unsigned deschuff(unsigned char filename[])
{
 int tam_huff=0;

 printf("\r    Descondensando  %s",strupr(filename));

 maketree();                             /* Cria arvore */
 tam_huff=decode();            /* Descodifica ficheiro de entrada */

 return tam_huff;
}



