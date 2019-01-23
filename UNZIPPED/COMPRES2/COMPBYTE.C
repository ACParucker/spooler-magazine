
                        /* *** Comp Byte *** */

#include <stdio.h>


unsigned char

         c[500],                  /* variavel auxiliar */
         bufsai[500],             /* variavel para o buffer de saida */
         bufent[500],            /* variavel para o buffer de entrada */
         *arqent,                     /* nome arquivo de entrada */
         *arqsai;                     /* nome arquivo de saida */


FILE *input,                  /* Ficheiros de entrada e saida */
     *output;


char mascara1=0xf0,
     mascara2=0xf;


main(int argc,char *argv[])
{
 char *cord;

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

 if (strlen(cord)!=1 || cord[0]!=99 && cord[0]!=100 && cord[0]!=67 && cord[0]!=68)
 {
  printf(" \nDeve especificar (C)omprime ou (D)escomprime !\n");
  exit(-6);
 }

 if ((input = fopen(arqent,"rb")) == NULL ) /* Verifica se arquivo a ser */
 {                                            /* a ser comprimido existe */

  printf(" \nImpossivel abrir arquivo \"%s\" !\n",arqent);
  exit(-4);
 }

 if ((output = fopen(arqsai,"wb")) == NULL )     /* Tenta abrir o arquivo */
 {
  printf(" \nImpossivel abrir arquivo \"%s\" !\n ",arqsai);   /* destino */
  exit(-5);
 }

 if (cord[0]==99 || cord[0]==67) comprime();
 else if (cord[0]==100 || cord[0]==68) descomprime();

}


ajuda()                  /* Ecran de ajuda */
{
 printf(" \nCompByte - Demonstracao para a SPOOLER por Jose Iria.\n");
 printf("                  Metodo de Compressao Meio Byte    \n\n");
 printf(" Syntax: \n");
 printf("        CompByte comando [d:][path]<fich orig> [[d:][path]<fich dest>]\n\n");
 printf("        Onde comando especifica compressao (\"c\") ou descompressao (\"d\"),\n");
 printf("        <fich orig> especifica o ficheiro a ser comprimido\n");
 printf("        e <fich dest> o ficheiro resultante da compressao.\n");
 printf("        O drive e path sao opcionais.\n\n");
 printf(" Exemplo: \n");
 printf("               CompByte c exemplo.txt exemplo.mcb\n\n");
 printf("         Comprime o ficheiro EXEMPLO.TXT em EXEMPLO.MCB\n\n");
}


comprime()
{
 unsigned char a;

 float tfs=0,         /* Tamanho Ficheiro Saida */
       tfe=0;         /*    "       "     Entrada */


 int j=0,
     i=0,
     n=0,
     k=0;



 printf("\n Comprimindo:\n              %s ---> %s",strupr(arqent),strupr(arqsai));
 while(fgets(bufent,500,input) != NULL)
 {                                           /* Le o arquivo origem */
  n=strlen(bufent);
  tfe+=n;
  k=0;j=0;

  for(i=0;i<n;i++)
  {
   c[i]=0;
   a=bufent[i];

   switch(a)
   {
    case '$':c[i]=1;break;
    case ',':c[i]=2;break;
    case '.':c[i]=3;break;
    case '*':c[i]=4;break;
   }
   if(a>='0' && a<='9')
   {
    c[i]=5;
   }

   if(c[i]==0)
   {
    if(k>5)
    {

     int x=0,
         y=0,
         z=0,
         l=0;


     bufsai[j]=127;
     bufsai[j+1]=14+k;
     j+=2;

     for(l=(i-k);l<=k;l+=2)
     {
      switch(c[l])
      {
       case 1:x=0xa0;           break;
       case 2:x=0xb0;           break;
       case 3:x=0xc0;           break;
       case 4:x=0xd0;           break;
       case 5:x=(bufent[l]<<4); break;
      }
      x= x & mascara1;

      switch(c[l+1])
      {
       case 1:y=0xa;          break;
       case 2:y=0xb;          break;
       case 3:y=0xc;          break;
       case 4:y=0xd;          break;
       case 5:y=bufent[l+1];  break;
      }
      y= y & mascara2;
      z= x | y;
      bufsai[j++]=z+14;
     }
     if(l==k+1)
     {
      bufsai[j++]=bufent[k-1];
     }
     k=0;
     i--;
     goto Jump;
    }

    if(k>0)
    {
     int l2;

     for(l2=i-k;l2<i;l2++)
     {
      bufsai[j++]=bufent[l2];
     }
     k=0;
     i--;
     goto Jump;
    }

    bufsai[j++]=a;
    k=0;
   }
   else k++;
   Jump:;
  }
  if(k>0)
  {
   for(i=n-k;i<n;i++)
   bufsai[j++]=bufent[i];
  }
  for(i=0;i<j;i++)
  {
   fputc(bufsai[i],output);
  }
 tfs+=j;
 }
 fclose(input);
 fclose(output);
 printf(" (%d%)\n\n",100-((int)(tfs/tfe*100)));
}





descomprime()
{
 int j=0,
     k=0,
     m=0,
     l=0,
     x=0,
     y=0,
     i=0,
     n=0;

 unsigned char  a,
                z;


 printf("\n Descomprimindo:\n                 %s ---> %s",strupr(arqent),strupr(arqsai));
 while(fgets(bufent,500,input) != NULL)
 {                                           /* Le o arquivo origem */
  j=0;
  n=strlen(bufent);

  for(i=0;i<n;i++)
  {
   a=bufent[i];

   if(a==127)
   {
    k=bufent[i+1]-14;
    i+=2;
    m=i+(k/2);
    l=i;

    for(;l<m;l++)
    {
     z=bufent[l]-14;
     x=(z&mascara1)>>4;

     if(x<10)
     {
      bufsai[j]=x+48;
     }
     else
     {
      switch(x)
      {
       case 10:bufsai[j]='$';break;
       case 11:bufsai[j]=',';break;
       case 12:bufsai[j]='.';break;
       case 13:bufsai[j]='*';break;
      }
     }
     y=z&mascara2;
     if(y<10)
     {
      bufsai[j+1]=y+48;
     }
     else
     {
      switch(y)
      {
       case 10:bufsai[j+1]='$';break;
       case 11:bufsai[j+1]=',';break;
       case 12:bufsai[j+1]='.';break;
       case 13:bufsai[j+1]='*';break;
      }
     }
     j+=2;
    }
    i=m;
   }
   else
   {
    bufsai[j]=a;
    j++;
   }
  }
  for(i=0;i<j;i++)
  {
   fputc(bufsai[i],output);
  }
 }
 fclose(input);
 fclose(output);
 printf(" (ok)\n\n");
}



