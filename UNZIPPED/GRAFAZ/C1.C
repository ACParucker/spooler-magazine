#include <stdio.h>
#include <conio.h>
#include <dos.h>
#include <fcntl.h>
#include <io.h>


#define EGB1nome "blast.EGB"
#define EGB2nome "logo.EGB"
#define PALnome "omissao.pal"


char EGB[3024];    /* 3025 bytes d  para um EGB com no m x 55x55 pontos   */
                   /* Para um uso mais "dispendioso" em termos de mem¢ria */
                   /* conv‚m alocar mem¢ria no heap para guardar os EGBS  */
char pal[768];     /* Array para os dados da palete			  */
unsigned char AlturaEGB, LarguraEGB;




void Ini (void)
{
    clrscr();
}

void Fini (void)
{
    textmode(LASTMODE);
    printf("Programa de demonstra‡„o da utiliza‡„o de EGBS em linguagem C\n");
    printf("NSJ  1994\n\n");
    printf("Informa‡”es, cr¡ticas ou um simples ol ,\n");
    printf("      (01) 4956868 ou\n");
    printf("      R. Jos‚ Mergulh„o, n§4 6§L Reboleira Sul 2700 Amadora\n\n");
    printf("Bons gr ficos!\n");
}


void ModoGraf0x13 (void)
{
    union   REGS regis;

    regis.x.ax = 0x0013;
    int86(0x10, &regis, &regis);   /* Modo gr fico 13h MCGA */
    delay(200);                    /* Esperar que o monitor se recomponha */
}


void Borda (char cor) /* Define uma cor para a borda */
{
    union   REGS regis;

    regis.x.ax = 0x1001;
    regis.h.bh = cor;
    int86(0x10, &regis, &regis);   /* Dar uma cor … borda */
}


int LoadPalete (char *nome)
/* Carrega de disco para a var pal a palete 'nome' */
{
    int     pal_file;

/* Carregar o ficheiro que cont‚m a palete para a var pal */
  /* Abrir o ficheiro para leitura */
    pal_file = open(nome, O_RDONLY | O_BINARY);

  /* Se o ficheiro n„o foi carregado devolve 0, caso contr rio 1 */
    if (pal_file == -1)  return 0;  
     else
      {
         read(pal_file, pal, 768);
         close(pal_file);
         return 1;
      }
}


void LigaPalete (void)
/* Activa a palete */
{
    union   REGS regis;
    struct  SREGS segregis;

    regis.x.ax = 0x1012;
    regis.x.bx = 0;
    regis.x.cx = 256;
    segregis.es = FP_SEG(pal);
    regis.x.dx = FP_OFF(pal);
  /* Activar a palete */
    int86x(0x10, &regis, &regis, &segregis);
}


int LoadEGB (char *nome)
/* Carrega de disco para a var EGB o EGB 'nome' */
{
    int     EGBfile;
    char    larg, alt;

/* Carregar o ficheiro que cont‚m o EGB para a var EGB */
    EGBfile = open(nome, O_RDONLY | O_BINARY);

  /* Se o ficheiro n„o foi carregado devolve 0, caso contr rio 1 */
    if (EGBfile == -1)  return 0;
     else
      { /* Ler a assinatura e a pos na matriz, ignorando-as */
           read(EGBfile, EGB, 11);

        /* Ler as dimens”es do EGB para as vars LarguraEGB e AlturaEGB */
           read(EGBfile, &LarguraEGB, 1);
           read(EGBfile, &AlturaEGB, 1);

        /* Ler o bloco de dados do EGB */
           read(EGBfile, EGB, (LarguraEGB + 1) * (AlturaEGB + 1));
           close(EGBfile);

          return 1;
      }
}



void poeEGB(unsigned int x, unsigned int y)
/* Coloca o EGB guardado na var EGB na pos (x,y) do ecran
 Esta rotina n„o performa o clip, isto ‚, se as coordenadas dadas fizerem
com que o EGB fique em parte fora do ecran, os resultados ser„o imprevisiveis,
mas £nicamente no efeito visual (o computador n„o "crasha" nem nada do g‚nero)
*/
{
    unsigned char far   *i;    /* i ‚ um ponteiro para o buffer de video */
    unsigned int cy, cx, index, aux;

  /* y * 320 + x ‚ o offset do ponto (x,y); 0xA0000000 ‚ o offset 0 do */
    i = (0xA0000000 + (y * 320 + x));  /* buffer de video (seg = A000h) */

  /* aux ‚ a distƒncia que vai do final de uma linha do EGB ao inicio da */
    aux = (319 - LarguraEGB);      /* linha seguinte, no buffer de video */
    index = 0;

    for (cy = 0; cy <= AlturaEGB; cy++)
     {
        for (cx = 0; cx <= LarguraEGB; cx++)
           {
	       *i = EGB[index];/* Marcar um ponto "no ecran" */
               i++;            /* Incrementa o ponteiro p/ o ponto seguinte */
               index++;        /* Pr¢ximo ponto do EGB */
           }
        i+= aux;   /* Pr¢xima linha do ecran, adicionando ao ponteiro */
     }             /* 319 - LarguraEGB (no modo 13h de video, o buffer */
                   /* ‚ endere‡ado linearmente) */
}


/* A respeito da fun‡„o teste, ler o coment rio da fun‡„o seguinte, Anima() */
void teste(void)
{
    LoadEGB(EGB1nome);
    poeEGB(70, 30);     /* Criar um fundo n„o preto */
    poeEGB(75, 32);
    poeEGB(80, 34);
    poeEGB(75, 30);
    LoadEGB(EGB2nome);
    poeEGB(80, 32);
    getch();         /* Ao carregar-se numa tecla o "MEGA" move-se sem      */
    poeEGB(81, 32);  /* deixar rasto, pois a borda preta de 1 ponto apagou  */
    getch();/* o possivel rasto. Se em vez de movˆ-lo para (81,32) o movesse*/
}       /* para, p.ex. (82,32) j  deixaria rasto, pois a borda cobre apenas */
        /* 1 ponto */


/* NOTA: Na anima‡„o gerada pela rotina seguinte, o EGB n„o deixa rasto porque
ele possu¡ em toda a sua volta uma linha "em branco". Para perceberem melhor
corram a fun‡„o que est  em coment rio na 4¦ linha da fun‡„o seguinte (teste). */
void Anima (void)
{
    unsigned int   x, y;
    char ix, iy, bord;

/*    teste();*/
    x = 0;     /* Posi‡„o actual do EGB */
    y = 30;
    ix = 1;    /* ix î {-1,1} */
    iy = 1;    /* iy î {-1,1} */
    bord = 0;  /* bord funciona como uma vari vel booleana */

    while(!kbhit())  /* Animar at‚ que seja premida uma tecla */
      {
        x+=ix;     /* Incrementar ou decrementar x, dependendo de ix */
        y+=iy;     /* Incrementar ou decrementar y, dependendo de iy */

        if (bord)
	  {
	      Borda(0); /* Borda … cor normal */
              nosound(); /* Parar qualquer som que esteja activo */
              bord = 0;
          }

      /* Se indo na dire‡„o em que vai, em x, o EGB tender a sair do ecran,
         inverter o sentido do movimento em x (se vai para a direita, passa
	 a ir para a esquerda) e faz um "clic" */
        if ((x > (319 - LarguraEGB)) || (x < 1))
          {
              sound(200);
              Borda(9);
	      if (ix < 0) ix = 1; else ix = -1;
              bord = 1;  /* Sinalizar que ‚ necess rio para o som e borda 0 */
          }

      /* Se indo na dire‡„o em que vai, em y, o EGB tender a sair do ecran,
         inverter o sentido do movimento em y (se vai para cima, passa a ir
	 para baixo) e faz um "clic" */
        if ((y > (199 - AlturaEGB)) || (y < 1))
          {
              sound(400);
              Borda(10);
	      if (iy < 0) iy = 1; else iy = -1;
              bord = 1;  /* Sinalizar que ‚ necess rio para o som e borda 0 */
	  }

        poeEGB(x, y);    /* Colocar o EGB no ecran */
        delay(3);        /* Atraso para a anima‡„o */
      }
    nosound();   /* Parar qualquer som que esteja activo */
    Borda(0);
}




void main (void)
{
    Ini;        /* Inicializa‡„o */
  /* Carregar o EGB */
    if ((LoadEGB(EGB1nome)) == 0)
       {
          printf("Ficheiro *.EGB n„o encontrado");
       }
    else
    /* Carregar a palete */
      if ((LoadPalete(PALnome)) == 0)
         {
            printf("Ficheiro *.PAL n„o encontrado\n");
         }
      else
           {
              ModoGraf0x13();   /* Colocar em modo gr fico        */
              LigaPalete();     /* Activar a palete		  */
              poeEGB(0, 0);     /* Colocar o EGB1 em (0,0)        */
              LoadEGB(EGB2nome);/* Carregar o 2§ EGB		  */
              Anima();          /* Pequena anima‡„o               */
              getch();          /* Esperar a press„o de uma tecla */
              Fini();           /* Finaliza‡„o			  */
           }
}



















