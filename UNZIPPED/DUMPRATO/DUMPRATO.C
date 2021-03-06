#include <stdio.h>
#include <string.h>
#include <io.h>
#include <conio.h>
#include <stdlib.h>

void output(char *, int);

void main(int argc, char *argv[])
{
 FILE	*ficheiro;
 int	ciclo, byteh, bytel, tipo=1;
 char   convers[3];

 if(argc==1)                   //N�o h� par�metros, mostra a sintaxe
 {
  printf("\n\n");
  printf(" � DumpRato v1.0 � Feito por Tiago Ribeiro para a Spooler � Mar�o 94 �\n");
  printf(" Cria uma defini��o do cursor do rato a partir de um ficheiro criado \n");
  printf(" com o programa Cursor Editor (Spooler n�19).\n");
  printf("\n");
  printf("  � Uso : \n\n");
  printf("       DUMPRATO ficheiro_in [ > ficheiro_out ]\n\n\n");
  printf("  � Exemplos :\n\n");
  printf("       L� um ficheiro para o ecran \n");
  printf("        DUMPRATO cursor.ced\n");
  printf("       L� um ficheiro para outro\n");
  printf("        DUMPRATO in.ced > out.ced\n\n");
 }
 else
 {
  ficheiro=fopen(argv[1], "rb");
  if( !ficheiro )
  {
   printf("Ficheiro inv�lido \n");    //Obviamente, ficheiro inv�lido
   exit(1);
  }

  printf("// HotSpot ----> coluna 0x%2.2X  linha 0x%2.2X\n", fgetc(ficheiro), fgetc(ficheiro));

  printf("static unsigned cursor[32]={\n");

  for(ciclo=0;ciclo<32;ciclo++)
  {
   byteh=fgetc(ficheiro);
   bytel=fgetc(ficheiro);

   if(ciclo<31)
	printf("    0x%02.2X%02.2X,          //", bytel, byteh);
   else
	printf("    0x%02.2X%02.2X           //", bytel, byteh);

   sprintf(convers, "%02.2X", bytel);
   output(convers, tipo);
   sprintf(convers, "%02.2X", byteh);
   output(convers, tipo);
   printf("\n");

   if(ciclo<15)
	tipo=1;
   else
	tipo=0;

   if(ciclo==15)
	printf("\n");
  }
  printf("}\n");

  fclose(ficheiro);
  exit(0);
 }
}

void output(char *hex, int tipo)
{
 int ciclo;

 if(tipo==0)
  for(ciclo=0;ciclo<=1;ciclo++)
   switch(hex[ciclo])
   {
	case '0'  : printf("0000"); break;
	case '1'  : printf("000�"); break;
	case '2'  : printf("00�0"); break;
	case '3'  : printf("00��"); break;
	case '4'  : printf("0�00"); break;
	case '5'  : printf("0�0�"); break;
	case '6'  : printf("0��0"); break;
	case '7'  : printf("0���"); break;
	case '8'  : printf("�000"); break;
	case '9'  : printf("�00�"); break;
	case 'A'  : printf("�0�0"); break;
	case 'B'  : printf("�0��"); break;
	case 'C'  : printf("��00"); break;
	case 'D'  : printf("��0�"); break;
	case 'E'  : printf("���0"); break;
	case 'F'  : printf("����"); break;
   }
 else
  for(ciclo=0;ciclo<=1;ciclo++)
   switch(hex[ciclo])
   {
	case '0'  : printf("����"); break;
	case '1'  : printf("���1"); break;
	case '2'  : printf("��1�"); break;
	case '3'  : printf("��11"); break;
	case '4'  : printf("�1��"); break;
	case '5'  : printf("�1�1"); break;
	case '6'  : printf("�11�"); break;
	case '7'  : printf("�111"); break;
	case '8'  : printf("1���"); break;
	case '9'  : printf("1��1"); break;
	case 'A'  : printf("1�1�"); break;
	case 'B'  : printf("1�11"); break;
	case 'C'  : printf("11��"); break;
	case 'D'  : printf("11�1"); break;
	case 'E'  : printf("111�"); break;
	case 'F'  : printf("1111"); break;
   };
}