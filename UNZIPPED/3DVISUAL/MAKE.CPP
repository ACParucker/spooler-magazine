#include <stdio.h>
#include <stdlib.h>
#include <iostream.h>

int main(void)
{
   FILE *fp;
   int word,ct;
   int dado;
   char FNAME[12];
   printf("\n MAKE por Bruno Shirley Possolo");
   printf("\n NOTA: Os vertices sao defenidos por (X,Y,Z)");
   printf("\n       e as arestas sao defenidas pelas liga‡oes (I,J),");
   printf("\n       sendo I o vertice INICIAL e J o vertice FINAL.");
   printf("\n\nNome da ficha a criar=");
   gets(FNAME);
   fp = fopen(FNAME, "wb");
   if (fp == NULL)
   {
      printf("\nErro a criar ficha %s\n", FNAME);
      exit(1);
   }
   printf("\n N§ de vertices? "); cin>>word;
   putw(word,fp);

   for(ct=1;ct<=word;ct++)
   {
	printf("x[%d]=",ct);cin>>dado;putw(dado,fp);
	printf("y[%d]=",ct);cin>>dado;putw(dado,fp);
	printf("z[%d]=",ct);cin>>dado;putw(dado,fp);
   }

   printf("\n N§ de arestas? "); cin>>word;
   putw(word,fp);

   for(ct=1;ct<=word;ct++)
   {
	printf("i[%d]=",ct);cin>>dado;putw(dado,fp);
	printf("j[%d]=",ct);cin>>dado;putw(dado,fp);
   }
   fclose(fp);
   return 0;
}
