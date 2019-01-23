// WEIRD 1 - DEMO ˛ por Tiago Ribeiro ˛ Maráo 94

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
 printf(" €                ‹ﬂ    ‹‹                             ‹             ‹€\n");
 printf("  ﬂ‹            ‹ﬂ    ‹ﬂ  ﬂﬂ‹    ﬂ  ﬂ‹   ‹‹           €            ‹ﬂ €\n");
 printf("    €          €     €‹‹‹‹‹ﬂ     €   €‹ﬂﬂ  ﬂ‹   ‹ﬂﬂ‹ €               € \n");
 printf("     ﬂ‹   ‹  ‹ﬂ     €       ‹     €  €        ‹ﬂ    ﬂ€              €  \n");
 printf("       ﬂ‹ﬂ €ﬂ        ﬂﬂ‹‹‹ﬂﬂ    ‹ﬂ    €       €     ‹€             €   \n");
 printf("                                               ﬂﬂ‹‹ﬂ  ﬂ‹         ﬂﬂﬂﬂﬂ \n\n");
 printf("                  por Tiago Ribeiro ˛ DEMONSTRAÄéO ˛ Maráo 94");
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
 printf(" Esta nÑo tem muito que se lhe diga ! Todos vocàs sabem o que tàm a\n");
 printf(" fazer para arrancar novamente com o computador: CTRL+ALT+DEL, carregar\n");
 printf(" no botÑo de Reset, desligar e ligar o computador, fechar e abrir o \n");
 printf(" interruptor geral da vossa instalaáÑo elÇctrica, entornar um copo de\n");
 printf(" †gua para dentro do CPU (bem, assim talvez j† nÑo volte a ligar), etc\n");
 printf(" Agora experimentem fazà-lo sem mÑos ! NÑo me compreendam mal, o que eu\n");
 printf(" quero dizer Ç, para tentarem foráar o computador a arrancar de dentro\n");
 printf(" de um programa vosso ! ê para aqueles que nÑo conseguem que serve esta\n");
 printf(" funáÑo - x_reboot. NÑo se esqueáam que Ç preciso tomar certas precauáîes\n");
 printf(" (nÑo, nÑo estou a falar de contraceptivos !): fechem TODOS os ficheiros\n");
 printf(" que tenham aberto, tirem a disquete da drive de arranque (se nÑo quiserem\n");
 printf(" fazer o boot strap a partir dela) e j† agora convÇm verificar se nÑo existe\n");
 printf(" nenhum programa a funcionar em background - ver funcáÑo x_shell (passe a \n");
 printf(" publicidade). Esta funáÑo permite ainda dois tipos de bootup: a frio,\n");
 printf(" que Ç idàntico a fazerem Reset, ou a quente, o mesmo que fazer CTRL+ALT+DEL.\n\n");
 printf(" Se quiserem experimentar, foráa que nÑo pagam mais por isso:\n");
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
 printf(" J† devem saber que o comando SET do DOS serve para criar vari†veis   \n");
 printf(" de ambiente (environment variables). Por exemplo 'SET PATH=C:\\',    \n");
 printf(" cria uma vari†vel 'PATH' no sistema operativo cujo conte£do Ç 'C:\\'.\n\n");
 printf(" AtÇ aqui tudo bem, mas hÑo-de experimentar fazer isto de dentro de  \n");
 printf(" um programa ! Quando se executa uma instruáÑo SYSTEM, EXEC ou SPAWN \n");
 printf(" em linguagem C (ou instruáîes semelhantes noutras linguagens), por  \n");
 printf(" exemplo 'system(set teste=isto nÑo vai dar nada)', a vari†vel       \n");
 printf(" 'teste' Ç criada, mas antes disso uma nova c¢pia do DOS Ç iniciada. \n");
 printf(" Assim, e como ap¢s a instruáÑo 'system' terminar esta nova c¢pia Ç  \n");
 printf(" ÆapagadaØ da mem¢ria, a vari†vel deixa de existir. \n\n");
 printf(" Se nÑo acreditam, experimentem escrever o seguinte conjunto de \n");
 printf(" comandos quando estiverem no DOS: \n");
 printf("           SET                -> Para verem as vari†veis existentes       \n");
 printf("           COMMAND            -> Para arrancarem com uma nova c¢pia do DOS\n");
 printf("           SET VARIAVEL=OK    -> Para criar uma vari†vel                  \n");
 printf("           SET                -> Para verificarem a criaáÑo da vari†vel   \n");
 printf("           EXIT               -> Para terminarem a nova c¢pia do DOS      \n");
 printf("           SET                -> Para verem se a vari†vel ainda existe    \n\n");
 pausa();
 printf(" Pois Ç, o mal Ç que os autores dos sistemas operativos, gostam de   \n");
 printf(" manter os programadores amadores na escuridÑo (traumas, coitados ...)\n");
 printf(" e nÑo documentam (ou fazem-no indevidamente) muitas das funáîes do  \n");
 printf(" dito cujo. ê o caso da funáÑo 2Eh, que serve para alterar           \n");
 printf(" permanentemente uma vari†vel do sistema. \n\n");
 printf(" ê para isso que serve a funáÑo 'x_set'. Esta funáÑo s¢ funciona no \n");
 printf(" modelo de mem¢ria SMALL e est† codificada em ASSEMBLER.            \n");
 printf(" Para a usarem nÑo se esqueáam de compilar e linkar o ficheiro      \n");
 printf(" INT2E.ASM. S¢ recebe um parÉmetro que Ç a vari†vel, seguida de um  \n");
 printf(" sinal de igual e do seu conte£do. Por exemplo, 'A=B', 'PROMPT=$p$g',\n");
 printf(" 'PATH=C:\\SPOOLER', 'TEMP=C:\\TEMP'. \n\n");
 printf(" Para aqueles de vocàs que julgam que eu nÑo devo estar s¢brio, vai  \n");
 printf(" agora ser criada uma vari†vel 'SPOOLER', cujo conte£do Ç 'MAGAZINE  \n");
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
 printf(" Antes de prosseguir digo-vos j† que esta funáÑo nÑo foi inventada \n");
 printf(" por mim. Foi um tipo chamado NEWMAN que a criou e portanto nÑo me \n");
 printf(" peáam para explicar pormenorizadamente como Ç que funciona.       \n");
 printf(" O autor, dizia que ela calculava um ROM CHECKSUM, o que quer dizer\n");
 printf(" em portuguàs, ROM CHECKSUM ...     Agora a sÇrio, a funáÑo varre\n");
 printf(" v†rias posiáîes da mem¢ria (da ROM, penso eu), e vai somando todos\n");
 printf(" os valores que esta contÇm, criando assim um c¢digo que, embora \n");
 printf(" seja igual em computadores da mesma marca e modelo, difere bastante\n");
 printf(" de computador para computador. Ora bem, temos um c¢digo que identifica \n");
 printf(" mais ou menos um certo CPU, o que Ç que poderemos fazer com isto ????\n");
 printf(" NÑo sei que ideias Ç que vos vieram Ö cabeáa, mas eu acho que a que \n");
 printf(" faz mais sentido Ç a de um sistema de protecáÑo. Como ? Simples. No \n");
 printf(" inicio do programa em que o usarem, calculem primeiro o c¢digo \n");
 printf(" verdadeiro (recorrendo Ö funáÑo 'x_romcode'), e em seguida comparem-no\n");
 printf(" com um que esteja armazenado num ficheiro. Se coincidirem, ok ! desta \n");
 printf(" vez passa, se nÑo, faáam qualquer coisa chata, sei l†, ponham o \n");
 printf(" computador a tocar m£sica cl†ssica, e garanto-vos que mais ninguÇm tenta\n");
 printf(" correr novamente o programa. \n\n\n");
 printf(" J† agora, e para acabarmos em beleza, o ROM CHECKSUM (ou seja, o ROM \n");
 printf(" CHECKSUM) deste computador Ç %lu.\n\n", code);

 pausa();
}

void shell_demo(void)
{
 int valor;

 valor=x_shell();
 clrscr();
 printf(" Muitos sÑo os programas que permitem o acesso ao DOS... Mas existem \n");
 printf(" outros que o fazem de um modo completamente diferente: reparem no  \n");
 printf(" Microsoft Windows que quando em multitarefa permite correr o DOS \n");
 printf(" numa janela ou, o DosShell do MS-DOS que pode ser usado como comutador\n");
 printf(" de tarefas ! Tudo ok atÇ aqui, mas existem programas que tendem a embirrar\n");
 printf(" e nÑo funcionam nestas circunstÉncias. Destes, alguns avisam que nÑo podem \n");
 printf(" correr, visto estar um programa qualquer a 'trabalhar' l† por tr†s, mas \n");
 printf(" outros, que devem ter sido concebidos para espalhar o pÉnico pelas \n");
 printf(" populaáîes, embora arranquem muito bem, nÑo passam da° deixando o \n");
 printf(" computador pendurado logo de seguida. \n");
 printf(" 'Como evitar isto ?', dizem vocàs, 'O ideal era saber se o Windows ou\n");
 printf(" o DosShell estÑo activos !'. 'EntÑo nÑo desespere, a soluáÑo que \n");
 printf(" procurava finalmente chegou - x_shell. Encomende j† e receba Ægr†tisØ\n");
 printf(" uma cassete de video com as instruáîes e o livro 'Como transformar o seu\n");
 printf(" 8088 num Pentium em 10 segundos'. Para encomendar ligue, de Lisboa ou \n");
 printf(" do Porto, 506-12...'. Ooops, meio de comunicaáÑo errado ! \n");
 printf(" Ok, agora a sÇrio, esta funáÑo detecta o Windows versÑo 3.x em modo \n");
 printf(" Standard ou Enhanced (multitarefa), Windows versÑo 2.x, o Task Switcher\n");
 printf(" do DOS e ainda quando nenhum destes est† em 'background'.\n\n");
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
 printf(" Ao contr†rio do que alguns de vocàs j† estÑo neste momento a pensar, este\n");
 printf(" nÑo Ç mais um conjunto de funáîes que permite usar o modo de video MCGA.\n");
 printf(" Existem in£meras bibliotecas desse tipo por a°, e tentar competir com elas\n");
 printf(" seria, alÇm de uma grande asneira, uma perca de tempo, visto nÑo ter sido essa\n");
 printf(" a minha intenáÑo ao constru°r estas funáîes. \n");
 printf(" Algumas nÑo sÑo mais que uma adaptaáÑo das que foram apresentadas\n");
 printf(" no n£mero 14 da Spooler,  contidas num artigo que lanáava algumas luzes\n");
 printf(" sobre o, atÇ entÑo, misterioso modo 13h, o MCGA. As outras foram aqui postas\n");
 printf(" a titulo de exemplo e curiosidade. H† para a° funáîes que ligam e desligam \n");
 printf(" o Çcran, que alteram a intensidade de vermelho, verde e azul presente em cada\n");
 printf(" cìr, e um processo para efectuar um fade-in e um fade-out.\n");
 printf(" A seguir vÑo ver uma sequància de FADE-INs/FADE-OUTs, com velocidades \n");
 printf(" diferentes, e atÇ FADE-IN para uma cìr que atÇ parecem um FADE-OUT para branco.\n");
 printf(" Se nÑo perceberam patavina do que est† escrito aqui em cima, o melhor Ç verem\n");
 printf(" a demonstraáÑo propriamente dita, pois Ç para isso que estÑo aqui !\n\n");

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
