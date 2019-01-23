#include<dos.h>
#include<stdio.h>
#include<conio.h>
#include<string.h>


FILE *fp=NULL;
char p[30];		/* vari vel auxiliar para ler a p.a. */
char pass[21];		/* palavra de acesso por defeito */

/*
Escrever msg na linha y, com som e devagar.
*/
void escreve_com_som_e_devagar(int y, char *msg)
{
    int i, len;

    len = 40 - strlen(msg) / 2;

    for(i=0; msg[i]!='\0'; i++)
    {
	 gotoxy(len + i, y);
	 if(msg[i]!=32)
	      sound(45);
	 else
	      delay(150);
	 cprintf("%c", msg[i]);
	 delay(80);
	 nosound();
	 delay(100);
    }
    delay(900);
}



/*
Devolve a linha actual
*/
int baixa_linhas(void)
{
    cprintf("\n\r\n\r");
    return wherey();
}



/*
Espera indefinida.
*/
void encrava(void)
{
    int y;

    y = baixa_linhas();
    escreve_com_som_e_devagar(y, "TENTATIVA FRUSTRADA . . .    ACESSO NEGADO");
    y = baixa_linhas();
    escreve_com_som_e_devagar(y, "POR FAVOR, DESLIGUE O COMPUTADOR");
    for(;;);
}



main(int argc, char *argv[])
{
    int i, y, tentativas;
    char t, s[80];

    if(argc == 2)
    {
	 fp=fopen("c:\\PASSWD.DAT", "r+b");
	 if(fp!=NULL)
	 {
	      fread(&pass, 20, 1, fp);
	      printf("\nIntroduza a palavra de acesso: ");
	      gets(s);
	      if(!strcmp(s, pass))
	      {
		   printf("\nNova palavra de acesso: %s", argv[1]);
		   fseek(fp, 0, 0);
		   fwrite(argv[1], 20, 1, fp);
		   fclose(fp);
		   return -1;
	      }
	      else
	      {
		   printf("\nM  tentativa...");
		   return -2;
	      }
	 }
	 else
	 {
	      printf("\nNova palavra de acesso: %s", argv[1]);
	      fp = fopen("c:\\PASSWD.DAT", "wb");
	      fwrite(argv[1], 20, 1, fp);
	      fclose(fp);
	      return -3;
         }
    }

    fp = fopen("c:\\PASSWD.DAT", "r+b");
    if(fp==NULL)
	 strcpy(pass, "visita");
    else
	 fread(&pass, 20, 1, fp);
    fclose(fp);

    y = baixa_linhas();
    escreve_com_som_e_devagar(y, "ACESSO AO COMPUTADOR RESTRITO APENAS A UTILIZADORES AUTORIZADOS");
    y = baixa_linhas();
    escreve_com_som_e_devagar(y, "INTRODUZA A PALAVRA DE ACESSO AO SISTEMA");
    y = baixa_linhas();

    tentativas = 0;
    do{
	 gotoxy(40, y);
	 cprintf("                           ");
         gotoxy(40, y);
	 i=0;
	 while((t=getch())!='\r' && i<20)
	 {
	      cprintf("*");
	      p[i++] = t;
	 }
	 tentativas++;
	 p[i] = '\0';
	 if(tentativas==10)
	      encrava();
    }while(strcmp(pass, p));

    y = baixa_linhas();
    escreve_com_som_e_devagar(y, "TESTE TERMINADO COM SUCESSO");
    y = baixa_linhas();
    escreve_com_som_e_devagar(y, "BEM VINDO AO COMPUTADOR");
    baixa_linhas();

    return 0;
}

