                           /* Comp Map */

#include <stdio.h>

unsigned char
         bufsai[500],             /* variavel para o buffer de saida */
         bufent[500],             /* variavel para o buffer de entrada */
         *arqent,                 /* nome arquivo de entrada */
         *arqsai;                 /* nome arquivo de saida*/


unsigned char mascara[8]={ 1,2,4,8,16,32,64,128 };


FILE *input,                /* Ficheiros de entrada e saida */
     *output;


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
  exit(-4);
 }

 if ((input = fopen(arqent,"rb")) == NULL ) /* Verifica se arquivo a ser */
 {                                            /* a ser comprimido existe */

  printf(" \nImpossivel abrir arquivo \"%s\" !\n",arqent);
  exit(-5);
 }

 if ((output = fopen(arqsai,"wb")) == NULL )     /* Tenta abrir o arquivo */
 {
  printf(" \nImpossivel abrir arquivo \"%s\" !\n ",arqsai);   /* destino */
  exit(-6);
 }

 if (cord[0]==99 || cord[0]==67) comprime();
 else if (cord[0]==100 || cord[0]==68) descomprime();
}


ajuda()                  /* Ecran de ajuda */
{
 printf(" \nCompMap - Demonstracao para a SPOOLER por Jose Iria.\n");
 printf("                  Metodo de Mapeamento de bit    \n\n");
 printf(" Syntax: \n");
 printf("        CompMap comando [d:][path]<fich orig> [[d:][path]<fich dest>]\n\n");
 printf("        Onde comando especifica compressao (\"c\") ou descompressao (\"d\"),\n");
 printf("        <fich orig> especifica o ficheiro a ser comprimido\n");
 printf("        e <fich dest> o ficheiro resultante da compressao.\n");
 printf("        O drive e path sao opcionais.\n\n");
 printf(" Exemplo: \n");
 printf("               CompMap c exemplo.txt exemplo.mcm\n\n");
 printf("         Comprime o ficheiro EXEMPLO.TXT em EXEMPLO.MCM\n\n");
}



comprime()
{
 int j=0,
     k=0,
     i=0,
     n=0,
     l=0,
     m=0,
     c=0,
     fn=0;


 float tfs=0,
       tfe=0;


 unsigned char a,
               b,
               mapa;




 printf("\n Comprimindo:\n              %s ---> %s",strupr(arqent),strupr(arqsai));
 while(fgets(bufent,500,input) != NULL)
 {                                           /* Le o arquivo origem */
  j=0;m=0;
  n=strlen(bufent);
  tfe+=n;

  for(i=0;i<n;i++)
  {
   l=i;fn=0;k=0;

   a=bufent[i];
   do
   {
    b=bufent[l];
    if(a==b)
    {
     k++;c=l;
    }
    l++;
   }
   while(l<n);

   fn=((c-i)/8)+4;

   if (k>fn)
   {
    bufsai[j]=127;
    bufsai[j+1]=a;
    bufsai[j+2]=14+fn-3;
    j+=3;
    l=i;
    mapa=0;

    do
    {
     b=bufent[l];
     if (a==b)
     {
      mapa=mapa|mascara[m++];
     }
     else
     {
      m++;
     }
     if(m==8)
     {
      m=0;
      bufsai[j++]=mapa+14;
      mapa=0;
     }
     l++;
    }
    while (l<=c);

    if (m>0)
    {
     bufsai[j++]=mapa+14;
     mapa=0;
    }

    for(c=i;c<n;c++)
    {
     b=bufent[c];
     if (b!=a)
     {
      bufsai[j++]=b;
     }
    }
    goto jump;
   }
   else
   {
    bufsai[j++]=a;
   }
  }
  jump:;
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




descomprime()            /* Efectua a descompressao */
{
 int i=0,
     l=0,
     k=0,
     n=0,
     j=0,
     m=0,
     c=0;


 unsigned char a,
               b,
               mapa,
               id;


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
    b=bufent[i+1];
    k=bufent[i+2]-14;
    i+=3;
    c=i+k;

    for(l=0;l<k;l++)
    {
     mapa=bufent[i++]-14;
     for(m=0;m<8;m++)
     {
      id=0;
      id=mapa&mascara[m];
      if(id==mascara[m])
      {
       bufsai[j++]=b;
      }
      else
      {
       if(c<n)
       {
        bufsai[j++]=bufent[c++];
       }
      }
     }
    }
    i=c-1;
   }
   else
   {
    bufsai[j++]=a;
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