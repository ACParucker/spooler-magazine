// WEIRD 1 - DEMO � por Tiago Ribeiro � Mar�o 94

#include <conio.h>
#include <stdlib.h>
#include <process.h>
#include <time.h>
#include "weird1.h"

int  demo_menu(void);
void boot_demo(void);
void set_demo(void);
void romcode_demo(void);
void shell_demo();
void graf_demo(void);
void imag(int);
void pausa(void);

void main(void)
{
 int op;

 while(1)
 {
  op=demo_menu();

  switch(op)
  {
   case 1: boot_demo();		break;
   case 2: set_demo(); 		break;
   case 3: romcode_demo();	break;
   case 4: shell_demo();	break;
   case 5: graf_demo();		break;
  }
 }
}

int demo_menu(void)
{
 clrscr();
 printf(" �                ��    ��                             �             ��\n");
 printf("  ��            ��    ��  ���    �  ��   ��           �            �� �\n");
 printf("    �          �     �������     �   ����  ��   ���� �               � \n");
 printf("     ��   �  ��     �       �     �  �        ��    ��              �  \n");
 printf("       ��� ��        �������    ��    �       �     ��             �   \n");
 printf("                                               �����  ��         ����� \n\n");
 printf("                  por Tiago Ribeiro � DEMONSTRA��O � Mar�o 94");
 printf("\n\n\n\n\n");
 printf("                 1. x_reboot    \n");
 printf("                 2. x_set       \n");
 printf("                 3. x_romcode   \n");
 printf("                 4. x_shell     \n");
 printf("                 5. x_pixel, x_setrgb, x_getrgb, \n");
 printf("                    x_getpal, x_fadeout,         \n");
 printf("                    x_fadein, x_voff, x_von      \n\n");
 printf("                 0. Sair        \n");

 while(1)
 {
  switch(getch())
  {
   case '1': return 1;
   case '2': return 2;
   case '3': return 3;
   case '4': return 4;
   case '5': return 5;
   case '0': clrscr();
			 printf("I'll be back ...\n\n");
			 exit(0);
  }
 }
}

void boot_demo(void)
{
 int tecla;

 clrscr();
 printf(" Esta n�o tem muito que se lhe diga ! Todos voc�s sabem o que t�m a\n");
 printf(" fazer para arrancar novamente com o computador: CTRL+ALT+DEL, carregar\n");
 printf(" no bot�o de Reset, desligar e ligar o computador, fechar e abrir o \n");
 printf(" interruptor geral da vossa instala��o el�ctrica, entornar um copo de\n");
 printf(" �gua para dentro do CPU (bem, assim talvez j� n�o volte a ligar), etc\n");
 printf(" Agora experimentem faz�-lo sem m�os ! N�o me compreendam mal, o que eu\n");
 printf(" quero dizer �, para tentarem for�ar o computador a arrancar de dentro\n");
 printf(" de um programa vosso ! � para aqueles que n�o conseguem que serve esta\n");
 printf(" fun��o - x_reboot. N�o se esque�am que � preciso tomar certas precau��es\n");
 printf(" (n�o, n�o estou a falar de contraceptivos !): fechem TODOS os ficheiros\n");
 printf(" que tenham aberto, tirem a disquete da drive de arranque (se n�o quiserem\n");
 printf(" fazer o boot strap a partir dela) e j� agora conv�m verificar se n�o existe\n");
 printf(" nenhum programa a funcionar em background - ver func��o x_shell (passe a \n");
 printf(" publicidade). Esta fun��o permite ainda dois tipos de bootup: a frio,\n");
 printf(" que � id�ntico a fazerem Reset, ou a quente, o mesmo que fazer CTRL+ALT+DEL.\n\n");
 printf(" Se quiserem experimentar, for�a que n�o pagam mais por isso:\n");
 printf("                Prime a tecla '1' para um COLD_BOOT\n");
 printf("                Prime a tecla '2' para um WARM_BOOT\n");
 printf("                Prime outra coisa qualquer para voltar ao menu\n");

 tecla=getch();
 if(tecla=='1')
  x_reboot(COLD_BOOT);
 if(tecla=='2')
  x_reboot(WARM_BOOT);
}

void set_demo(void)
{
 clrscr();
 printf(" J� devem saber que o comando SET do DOS serve para criar vari�veis   \n");
 printf(" de ambiente (environment variables). Por exemplo 'SET PATH=C:\\',    \n");
 printf(" cria uma vari�vel 'PATH' no sistema operativo cujo conte�do � 'C:\\'.\n\n");
 printf(" At� aqui tudo bem, mas h�o-de experimentar fazer isto de dentro de  \n");
 printf(" um programa ! Quando se executa uma instru��o SYSTEM, EXEC ou SPAWN \n");
 printf(" em linguagem C (ou instru��es semelhantes noutras linguagens), por  \n");
 printf(" exemplo 'system(set teste=isto n�o vai dar nada)', a vari�vel       \n");
 printf(" 'teste' � criada, mas antes disso uma nova c�pia do DOS � iniciada. \n");
 printf(" Assim, e como ap�s a instru��o 'system' terminar esta nova c�pia �  \n");
 printf(" �apagada� da mem�ria, a vari�vel deixa de existir. \n\n");
 printf(" Se n�o acreditam, experimentem escrever o seguinte conjunto de \n");
 printf(" comandos quando estiverem no DOS: \n");
 printf("           SET                -> Para verem as vari�veis existentes       \n");
 printf("           COMMAND            -> Para arrancarem com uma nova c�pia do DOS\n");
 printf("           SET VARIAVEL=OK    -> Para criar uma vari�vel                  \n");
 printf("           SET                -> Para verificarem a cria��o da vari�vel   \n");
 printf("           EXIT               -> Para terminarem a nova c�pia do DOS      \n");
 printf("           SET                -> Para verem se a vari�vel ainda existe    \n\n");
 pausa();
 printf(" Pois �, o mal � que os autores dos sistemas operativos, gostam de   \n");
 printf(" manter os programadores amadores na escurid�o (traumas, coitados ...)\n");
 printf(" e n�o documentam (ou fazem-no indevidamente) muitas das fun��es do  \n");
 printf(" dito cujo. � o caso da fun��o 2Eh, que serve para alterar           \n");
 printf(" permanentemente uma vari�vel do sistema. \n\n");
 printf(" � para isso que serve a fun��o 'x_set'. Esta fun��o s� funciona no \n");
 printf(" modelo de mem�ria SMALL e est� codificada em ASSEMBLER.            \n");
 printf(" Para a usarem n�o se esque�am de compilar e linkar o ficheiro      \n");
 printf(" INT2E.ASM. S� recebe um par�metro que � a vari�vel, seguida de um  \n");
 printf(" sinal de igual e do seu conte�do. Por exemplo, 'A=B', 'PROMPT=$p$g',\n");
 printf(" 'PATH=C:\\SPOOLER', 'TEMP=C:\\TEMP'. \n\n");
 printf(" Para aqueles de voc�s que julgam que eu n�o devo estar s�brio, vai  \n");
 printf(" agora ser criada uma vari�vel 'SPOOLER', cujo conte�do � 'MAGAZINE  \n");
 printf(" DOS UTILIZADORES PC' \n\n\n");
 printf(" Se carregares verificar, sai do programa e escreve SET.\n\n");
 x_set("SPOOLER=MAGAZINE DOS UTILIZADORES PC");
 printf("\n");

 pausa();
}

void romcode_demo(void)
{
 unsigned long code;

 code=x_romcode();
 clrscr();
 printf(" Antes de prosseguir digo-vos j� que esta fun��o n�o foi inventada \n");
 printf(" por mim. Foi um tipo chamado NEWMAN que a criou e portanto n�o me \n");
 printf(" pe�am para explicar pormenorizadamente como � que funciona.       \n");
 printf(" O autor, dizia que ela calculava um ROM CHECKSUM, o que quer dizer\n");
 printf(" em portugu�s, ROM CHECKSUM ...     Agora a s�rio, a fun��o varre\n");
 printf(" v�rias posi��es da mem�ria (da ROM, penso eu), e vai somando todos\n");
 printf(" os valores que esta cont�m, criando assim um c�digo que, embora \n");
 printf(" seja igual em computadores da mesma marca e modelo, difere bastante\n");
 printf(" de computador para computador. Ora bem, temos um c�digo que identifica \n");
 printf(" mais ou menos um certo CPU, o que � que poderemos fazer com isto ????\n");
 printf(" N�o sei que ideias � que vos vieram � cabe�a, mas eu acho que a que \n");
 printf(" faz mais sentido � a de um sistema de protec��o. Como ? Simples. No \n");
 printf(" inicio do programa em que o usarem, calculem primeiro o c�digo \n");
 printf(" verdadeiro (recorrendo � fun��o 'x_romcode'), e em seguida comparem-no\n");
 printf(" com um que esteja armazenado num ficheiro. Se coincidirem, ok ! desta \n");
 printf(" vez passa, se n�o, fa�am qualquer coisa chata, sei l�, ponham o \n");
 printf(" computador a tocar m�sica cl�ssica, e garanto-vos que mais ningu�m tenta\n");
 printf(" correr novamente o programa. \n\n\n");
 printf(" J� agora, e para acabarmos em beleza, o ROM CHECKSUM (ou seja, o ROM \n");
 printf(" CHECKSUM) deste computador � %lu.\n\n", code);

 pausa();
}

void shell_demo(void)
{
 int valor;

 valor=x_shell();
 clrscr();
 printf(" Muitos s�o os programas que permitem o acesso ao DOS... Mas existem \n");
 printf(" outros que o fazem de um modo completamente diferente: reparem no  \n");
 printf(" Microsoft Windows que quando em multitarefa permite correr o DOS \n");
 printf(" numa janela ou, o DosShell do MS-DOS que pode ser usado como comutador\n");
 printf(" de tarefas ! Tudo ok at� aqui, mas existem programas que tendem a embirrar\n");
 printf(" e n�o funcionam nestas circunst�ncias. Destes, alguns avisam que n�o podem \n");
 printf(" correr, visto estar um programa qualquer a 'trabalhar' l� por tr�s, mas \n");
 printf(" outros, que devem ter sido concebidos para espalhar o p�nico pelas \n");
 printf(" popula��es, embora arranquem muito bem, n�o passam da� deixando o \n");
 printf(" computador pendurado logo de seguida. \n");
 printf(" 'Como evitar isto ?', dizem voc�s, 'O ideal era saber se o Windows ou\n");
 printf(" o DosShell est�o activos !'. 'Ent�o n�o desespere, a solu��o que \n");
 printf(" procurava finalmente chegou - x_shell. Encomende j� e receba �gr�tis�\n");
 printf(" uma cassete de video com as instru��es e o livro 'Como transformar o seu\n");
 printf(" 8088 num Pentium em 10 segundos'. Para encomendar ligue, de Lisboa ou \n");
 printf(" do Porto, 506-12...'. Ooops, meio de comunica��o errado ! \n");
 printf(" Ok, agora a s�rio, esta fun��o detecta o Windows vers�o 3.x em modo \n");
 printf(" Standard ou Enhanced (multitarefa), Windows vers�o 2.x, o Task Switcher\n");
 printf(" do DOS e ainda quando nenhum destes est� em 'background'.\n\n");
 printf(" Neste momento estamos a correr ");

 switch(valor)
 {
  case MODE_DOS			: printf("o DOS, pura e simplesmente."); break;
  case MODE_DOS_TS		: printf("o Task Switcher do DOS."); break;
  case MODE_WIN3X_STD	: printf("o Windows ver3.x no modo Standard."); break;
  case MODE_WIN3X_2X	: printf("o Windows ver2.x."); break;
  case MODE_WINX_386E	: printf("o Windows ver3.x no modo Enhanced."); break;
 }
 printf("\n\n");
 pausa();
}

void pausa(void)
{
 textcolor(WHITE+BLINK);
 printf("Prime uma tecla para continuar ...\r");
 textcolor(LIGHTGRAY);
 getch();
 delline();
}

void graf_demo(void)
{
 int demo=0, ciclo;
 char *PalBuffer;
 char old_mode;

 clrscr();
 printf(" Ao contr�rio do que alguns de voc�s j� est�o neste momento a pensar, este\n");
 printf(" n�o � mais um conjunto de fun��es que permite usar o modo de video MCGA.\n");
 printf(" Existem in�meras bibliotecas desse tipo por a�, e tentar competir com elas\n");
 printf(" seria, al�m de uma grande asneira, uma perca de tempo, visto n�o ter sido essa\n");
 printf(" a minha inten��o ao constru�r estas fun��es. \n");
 printf(" Algumas n�o s�o mais que uma adapta��o das que foram apresentadas\n");
 printf(" no n�mero 14 da Spooler,  contidas num artigo que lan�ava algumas luzes\n");
 printf(" sobre o, at� ent�o, misterioso modo 13h, o MCGA. As outras foram aqui postas\n");
 printf(" a titulo de exemplo e curiosidade. H� para a� fun��es que ligam e desligam \n");
 printf(" o �cran, que alteram a intensidade de vermelho, verde e azul presente em cada\n");
 printf(" c�r, e um processo para efectuar um fade-in e um fade-out.\n");
 printf(" A seguir v�o ver uma sequ�ncia de FADE-INs/FADE-OUTs, com velocidades \n");
 printf(" diferentes, e at� FADE-IN para uma c�r que at� parecem um FADE-OUT para branco.\n");
 printf(" Se n�o perceberam patavina do que est� escrito aqui em cima, o melhor � verem\n");
 printf(" a demonstra��o propriamente dita, pois � para isso que est�o aqui !\n\n");

 pausa();
 clrscr();

 old_mode=x_mcga();    // MCGA e guarda o modo antigo

 while(demo!=2)
 {
  x_mcga();      			       // Inicializa o modo 0x13 (MCGA 320x200x256)
  imag(demo);
  PalBuffer = malloc(MCGAPALSIZE);
  x_getpal(PalBuffer);

  if(kbhit())
  {
   x_modo_video(old_mode);
   free(PalBuffer);
   return;
  }

  x_fadeout(1);

  if(kbhit())
  {
   x_modo_video(old_mode);
   free(PalBuffer);
   return;
  }

  x_fadein(1, PalBuffer);

  if(kbhit())
  {
   x_modo_video(old_mode);
   free(PalBuffer);
   return;
  }

  x_fadeout(6);

  if(kbhit())
  {
   x_modo_video(old_mode);
   free(PalBuffer);
   return;
  }

  x_fadein(6, PalBuffer);

  if(kbhit())
  {
   x_modo_video(old_mode);
   free(PalBuffer);
   return;
  }

  for(ciclo=0;ciclo<MCGAPALSIZE;ciclo++)   // Preenche a palete a branco
   PalBuffer[ciclo]=63;

  x_fadeout(12);

  if(kbhit())
  {
   x_modo_video(old_mode);
   free(PalBuffer);
   return;
  }

  x_fadein(12, PalBuffer);

  if(kbhit())
  {
   x_modo_video(old_mode);
   free(PalBuffer);
   return;
  }

  x_fadeout(1);

  demo++;
 }
 x_modo_video(old_mode);
}

void imag(int demo)
{
 int x, y, cor=0, ciclo;

 if(demo==0)
 {
  x_voff();
  for(y=0;y<200;y++)
  {
   cor=0;
   for(x=0;x<320;x++)
   {
	x_pixel(x, y, cor);
	if(cor<256)
	 cor++;
   }
  }
  x_von();
 }

 if(demo==1)
 {
  randomize();
  for(ciclo=0;ciclo<10000;ciclo++)
  {
   x=random(320);
   y=random(200);
   cor=random(256);
   x_pixel(x, y, cor);
  }
 }
}
