


                         /* =-> COMP HUFF <-= */

        /* \/ Demonstracao do metodo de compressao de Huffman \/ */


                  /** -=> ZONA DE DECLARACOES <=- **/


#include <stdio.h>


unsigned char
         bufsai[1024],            /* variavel para o buffer de saida */
         bufent[1024],            /* variavel para o buffer de entrada */
         *arqent,                 /* nome arquivo de entrada */
         *arqsai;                 /* nome arquivo de saida*/



FILE *input,                   /* Ficheiro de entrada */
     *output;                  /* Ficheiro de saida */


       /* Estructura da arvore para o codigo Huffman */

struct arv {
            int freq;    /* Frequencia */
            int parent;  /* " No-pai " */
            int left;    /* " No-filho " esquerdo */
            int right;   /* " No-filho " direita */
           } node;


int list[255];       /* Lista dos indices para a arvore */
struct arv tree[511];          /* Arvore */


float tfs=255,tfe=0;

void comprime();       /* Declaracao da funcao comprime */
void descomprime();    /* Declaracao da funcao descomprime */



                         /** -=> MAIN <=- **/


main(int argc,char *argv[])
{
 char *cord;           /* Comprime ou descomprime */

 cord=argv[1];
 arqent=argv[2];
 arqsai=argv[3];

 if (argc>4)                                             /* Verifica */
 {
  printf(" \nDemasiados parametros !\n ");            /* os parametros */
  exit(-1);
 }                                                 /* da linha de comando */
 if (argc==2)
 {
  printf(" \nFaltam parametros !\n ");
  exit(-2);
 }
 if (argc==3) arqsai=arqent;
 if (argc==1)
 {
  ajuda();
  exit(-3);
 }
                        /* Mensagens de Erro */

 if (strlen(cord)!=1 || cord[0]!=99 && cord[0]!=100 && cord[0]!=67 && cord[0]!=68)
 {
  printf(" \nDeve especificar (C)omprime ou (D)escomprime !\n");
  exit(-4);
 }

 if ((input = fopen(arqent,"r+b")) == NULL )  /* Verifica se arquivo a ser */
 {                                            /* a ser comprimido existe */

  printf(" \nImpossivel abrir arquivo \"%s\" !\n",arqent);
  exit(-5);
 }

 if ((output = fopen(arqsai,"w+b")) == NULL ) /* Tenta abrir o arquivo de saida */
 {
  printf(" \nImpossivel abrir arquivo \"%s\" !\n ",arqsai);   /* destino */
  exit(-6);
 }


 if (cord[0]==99 || cord[0]==67) comprime();
 else if (cord[0]==100 || cord[0]==68) descomprime();
}



                         /** -=> AJUDA <=- **/



ajuda()                  /* Ecran de ajuda */
{
 printf(" \nCompHuff - Demonstracao para a SPOOLER por Jose Iria.\n");
 printf("                 Metodo de Compressao de Huffman    \n\n");
 printf(" Syntax: \n");
 printf("        CompHuff comando [d:][path]<fich orig> [[d:][path]<fich dest>]\n\n");
 printf("        Onde comando especifica compressao (\"c\") ou descompressao (\"d\"),\n");
 printf("        <fich orig> especifica o ficheiro a ser comprimido\n");
 printf("        e <fich dest> o ficheiro resultante da compressao.\n");
 printf("        O drive e path sao opcionais.\n\n");
 printf(" Exemplo: \n");
 printf("               CompHuff c exemplo.txt exemplo.mch\n\n");
 printf("         Comprime o ficheiro EXEMPLO.TXT em EXEMPLO.MCH\n\n");
}


                       /** -=> SORT LIST <=- **/


void sortlist()           /* SHELL SORT modificado */
{               /* Ordena a lista dos indices para a arvore */
 int i,j,h,       /* por ordem decrescente de frequencia */
     Tmp;

 h=364;

 do
 {
  h=h/3;
  for(i=h+1;i<=255;i++)
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
 }
 while(h!=1);
}

                         /** -=> MAKE TREE <=- **/


void maketree(int c_d,FILE *f)   /* Cria a arvore Huffman */
{
 int i=0,j=0,          /* Vars Contadoras */
     ListCnt=0,      /* Contador da Lista */
     TreeCnt=0,      /* Contador da Arvore */
     NewFreq=0;


 /* Inicializa a arvore e a lista */
 for(i=0;i<=255;i++)
 {
  tree[i].freq=0;
  /* Se MakeTree for chamado por descomprime() */
  if (c_d==1) tree[i].freq=fgetc(f);
  tree[i].parent=-1;
  list[i]=i;
 }

 /* Se MakeTree for chamado por comprime() */
 if (c_d==0)
 {
  /* Le ficheiro de entrada para determinar frequencias */
  while(fgets(bufent,1024,f) != NULL)
  {
   for(i=0;i<strlen(bufent);i++)
   {
    tree[bufent[i]].freq++;
    /* Se a frequencia for maior que 255 escala todos os valores */
    if (tree[bufent[i]].freq==255)
    {
     for(j=0;j<strlen(bufent);j++)
     {
      tree[bufent[i]].freq=(tree[bufent[i]].freq+1)/2;
     }
    }
   }
  }
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

                          /** -=> ENCODE <=- **/


void encode(FILE *sfile, FILE *dfile)    /* Codifica o ficheiro */
{
 int i=0,j=0,         /* Var Contadora */
     nodenumb,        /* Num. do no */
     ocount,          /* Contador buffer saida */
     code;            /* Carac. codificado */

 unsigned
 char     bitnumb,    /* Num. do bit */
          codebit;    /* Mascara */


 ocount=0;
 bitnumb=7;           /* Inicializa vars */
 bufsai[0]=0;

 /* Le o ficheiro de entrada para o buffer de entrada */
 while(fgets(bufent,1024,sfile) !=NULL )
 {
  tfe+=strlen(bufent);
  /* Codifica cada caracter do fich. entrada */
  for(i=0;i<strlen(bufent);i++)
  {
   nodenumb=bufent[i];      /* Numero do no-terminal */
   codebit=0;
   code=0;
   /* Codifica ate a raiz */
   while (nodenumb!=list[0])
   {
    if (tree[nodenumb].parent>0)
    {
     code=code | (1 << codebit);
    }
    codebit++;
    /* Posiciona no " No-pai " */
    nodenumb=abs(tree[nodenumb].parent);
   }
   /* Escreve bits de "code" para o buffer de saida */
   while (codebit>0)
   {
    codebit--;
    if ((code & (1 << codebit)) !=0 )
    {
     bufsai[ocount]=bufsai[ocount] | (1 << bitnumb);
    }
    if (bitnumb > 0) bitnumb--;
    else
    {
     /* Se o buffer estiver cheio... */
     if (ocount==1024)
     {
      for (j=0;j<ocount;j++)
      {
       fputc(bufsai[j],dfile);
      }
      ocount=0;
      tfs+=1024;
     }
     else ocount++;

     bitnumb=7;
     bufsai[ocount]=0;
    }
   }
  }
 }
 if ( bitnumb != 7 ) ocount++;

 /* Escreve do buffer de saida para o ficheiro de saida... */
 if ( ocount > 0 )
 {
  for(i=0;i<ocount;i++)
  {
   fputc(bufsai[i],dfile);
  }
  tfs+=ocount;
 }
}


                         /** -=> COMPRIME <=- **/


void comprime()    /* Funcao principal do compressor */
{
 int i;                /* Var Contadora */

 printf("\n Comprimindo:\n              %s ---> %s",strupr(arqent),strupr(arqsai));
 maketree(0,input);         /* Cria arvore */
 rewind(input);             /* Posiciona ponteiro no inicio do ficheiro */
 for(i=0;i<=255;i++)
 {
  fputc(tree[i].freq,output);   /* Escreve frequencias no fich. saida */
 }
 encode(input,output);      /* Codifica */

 printf(" (%d%)\n\n",100-((int)(tfs/tfe*100)));   /* Razao de compressao */

 fclose(input);             /* Fecha fich. de entrada */
 fclose(output);            /* Fecha fich. de saida */
}




                         /** -=> DECODE <=- **/


void decode(FILE *sfile, FILE *dfile)  /* Descodifica fich. entrada */
                                                     /* para fich. saida */
{
 int nodenumb,              /* Num. do no */
     charnumb,              /* Num. do carac. no buffer de entrada*/
     outpoint,              /* Ponteiro para a posicao no buffer de saida */
     ocount,i,j;              /* Vars Contadoras */


 unsigned
 char       bitnumb;          /* Num. do bit (mascara) */


 bitnumb=7;
 outpoint=0;          /* Inicializa Vars */
 /*for (i=0;i<255;i++) */
 /*{              */
 /* count[i]=0; */
/* }  */
 /* Le do ficheiro de entrada para buffer de entrada */
 while(fgets(bufent,1024,sfile) != NULL)
 {
  charnumb=0;
  /* Descodifica todos os carac. no buffer bit a bit */
  while (charnumb < strlen(bufent))
  {
   nodenumb=list[0];        /* Posiciona na raiz */
   while (nodenumb > 255)
   {
    if ((bufent[charnumb] & ( 1 << bitnumb ))==0)  /* Compara cada bit */
      nodenumb=tree[nodenumb].right;
    else                                       /* e escolhe o " No-filho " */
      nodenumb=tree[nodenumb].left;

    if (bitnumb > 0 ) bitnumb--;              /* ate chegar ao no-terminal */
    else
    {
     charnumb++;
     if (charnumb >= strlen(bufent))
     {
      if (fgets(bufent,1024,sfile)==NULL) nodenumb=-1;
      else
      {
       charnumb=0;
      }
     }
     bitnumb=7;
    }
   }
   if (nodenumb >=0)
   {
    /*if ( count[nodenumb] < tree[nodenumb].freq )*/
    /*{*/
     bufsai[outpoint]=nodenumb; /* Escreve carac. decodificado no buffer */
     outpoint++;                              /* de saida */
     /*count[nodenumb]++; */
    /*}*/

    /* Se o buffer estiver cheio... */
    if (outpoint==1024)
    {
     for (j=0;j<outpoint;j++)
     {
      fputc(bufsai[j],dfile);
     }
     outpoint=0;
    }
   }
  }
 }
 /* Escreve buffer de saida para ficheiro de saida... */
 if (outpoint>0)
 {
  for (i=0;i<outpoint;i++)
  {
   fputc(bufsai[i],dfile);
  }
 }
}


                         /** -=> DESCOMPRIME <=- **/

void descomprime()
{
 printf("\n Descomprimindo:\n                 %s ---> %s",strupr(arqent),strupr(arqsai));
 maketree(1,input);             /* Cria arvore */
 decode(input,output);          /* Descodifica ficheiro de entrada */
 fclose(input);               /* Fecha ficheiro de entrada */
 fclose(output);              /* Fecha ficheiro de saida */
 printf(" (ok)\n\n");
}



 /** -=> CRITICAS, SUGESTOES OU DUVIDAS PODEM SER ENDERECADAS A: <=- **/

         /*   \     Jose Iria                          /    */
         /*   /     R. Com. Ramiro Correia, Lote 42    \    */
         /*   \     Santo Ant¢nio                      /    */
         /*   /     2830 Barreiro                      \    */


 /* Para melhor entender o funcionamento do programa, veja a estructura */
 /* tree[] com EVALUATE depois de executado a funcao MakeTree(). A raiz */
  /* da arvore encontra-se em list[0]. A partir da raiz siga ate ao no */
   /* terminal pretendido - siga passo a passo a funcao descomprime() */
             /* antes de analisar a funcao comprime() */


   /* NOTA: O ficheiro comprimido pode ser maior que o ficheiro */
      /* original, porque tem que conter as frequencias */
                 /* que ocupam 255 bytes */