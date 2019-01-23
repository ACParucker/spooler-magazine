#include <stdio.h>
#include <dir.h>
#include <dos.h>
#include <io.h>

FILE *old;
FILE *new;

char files[1024][13], path[256], dest[256];

main(argc,argv)
int argc;
char *argv[];
{
char copiar[256], delete[256],c='';
int i=0, j=0;

struct ffblk dira;
struct ffblk dira2;

 erro();

 if(argc!=3){
  printf("Erro #1: N£mero de parƒmetros errado!\n\nSintaxe: MOVER Ficheiros_a_Mover Destino\n\n");
  exit(1);
 }


 j=strlen(argv[1]);
 if(strchr(argv[1],'\\')!=NULL){
  while(c!='\\'){c=argv[1][j];if(c!='\\')j--;}
  j++;
  while(i<j){path[i]=argv[1][i];i++;}
 }

 j=strlen(argv[2]);
 strcpy(dest,argv[2]);
 if(argv[2][j-1]!='\\')strcat(dest,"\\");

 if (strcmp(argv[2],"\\")==0) goto SEGUE;
 if (strchr(argv[2],':')!=NULL && strlen(argv[2])<=3) goto SEGUE;

 if (findfirst(argv[2],&dira2,FA_DIREC)==-1){
  printf("Directoria Destino n„o existe! Quer cri -la? (S/n)");
  c=getch();
  if(c=='S' | c=='s' | c=='\r') mkdir(argv[2]);
   else {
    printf("\n\nErro #3: Directoria n„o existe!\n");
    exit(3);
   }
  printf("\n\n");
 }

 SEGUE:
 if(findfirst(argv[1], &dira, FA_ARCH)==-1) {
  printf("Erro #2: N„o foram encontrado nenhum ficheiro com essa designa‡„o!\n");
  exit(2);
 }

 /* lˆ os ficheiros existentes e guarda-os na mem¢ria */

 i=0;
 strcpy(files[i],dira.ff_name);
 while(findnext(&dira)!=-1){
  i++;
  strcpy(files[i],dira.ff_name);
  if(i>=1024)break;
 }

 copy_cmb(i);

 printf("Ok!\n");
 exit(0);

}


/* Disclaimer */

erro()
{
 printf("MoVeR(C) v1.0 por Carlos Batista para Spooler Magazine, %s\n\n", __DATE__);
}




/* Rotina de c¢pia */

copy_cmb(int times)
{
struct ftime data_file;

char filepath[256], filedest[256],c,buffer[32767];
int u=0,attrib=0;
unsigned long pos=0, aler=32767, filel=0;;

 while(u<=times){

  /* Verifica se o user pressionou uma tecla */

  if(kbhit()!=0){
   printf("\nProcesso abortado pelo utilizador!");
   fcloseall();
   goto FIM;
  }

  /* constroi os paths */

  strcpy(filepath,path);strcat(filepath,files[u]);
  old=fopen(filepath,"rb");
  strcpy(filedest,dest);strcat(filedest,files[u]);
  strupr(filepath);strupr(filedest);

  /* Verifica se o file j  existe */

  if ( (new=fopen(filedest,"rb"))!=NULL) {
   fclose(new);
   printf("\nFicheiro %s j  existe. Apago ficheiro j  existente? (S/n)",filedest);
   c=getch();
   if(c=='s' || c=='S' || c=='\r') ;
    else {
     fclose(old);fclose(new);
     goto OVER;
    }
  }
  new=fopen(filedest,"wb");

  filel=filelength(fileno(old));
  printf("\nMovendo ficheiro %s para %s   ", filepath, filedest);

  getftime(fileno(old), &data_file);
  attrib=_chmod(filepath,0);

  /* centro da rotina de c¢pia */

  while(!feof(old)){
   pos=ftell(old);

   if(pos>=filel)break;
   if(filel-pos<32767)aler=filel-pos;
    else aler=32767;

   fread(buffer,aler,1,old);
   fwrite(buffer,aler,1,new);

   printf(".");
  }

  /* rep”e data original fecha ficheiros e mete o atributo */

  setftime(fileno(new), &data_file);
  fclose(old);fclose(new);
  switch(attrib){
   case 1:
   case 33: _chmod(filedest, 1, FA_RDONLY);break;
   case 2:
   case 34: _chmod(filedest, 1, FA_HIDDEN);break;
   case 4:
   case 36: _chmod(filedest, 1, FA_SYSTEM);break;
   case 32:
   default: _chmod(filedest, 1, FA_ARCH);break;
  }

  /* apaga file origem */

  _chmod(filepath,1,FA_ARCH);
  remove(filepath);

  OVER:
  u++;
 }

 FIM:
 printf("\n\n");

 return(0);
}
