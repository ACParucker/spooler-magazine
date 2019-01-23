#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <dos.h>

char buff[4096];

struct descritor{
    int linhas;
    char titulo[20];
    char *descricao[25];
}personalidades[] ={
    {
    14,
    "Nervoso",
"O  mais  se destaca no nervoso ‚ a intensidade e a sucess„o r pida das suas",
"emo‡”es.  Passa  rapidamente  da  euforia  …  depress„o,  do  entusiasmo ao",
"abatimento,  da  alegria  … tristeza.  As  suas opini”es variam entre p¢los",
"extremos   e  contradit¢rios.  Daqui  resulta  um  personagem  com  facetas",
"simultaneamente  desconcertantes e encantadoras, desafiadoras e agrad veis.",
"As  suas  rela‡”es  interpessoais  s„o  numerosas  e  agitadas, tem  muitos",
"camaradas  tempor rios, mas poucos amigos verdadeiros. O reconhecimento e a",
"fidelidade  s„o  nele  raros,  havendo  nas  suas liga‡”es uma vagabundagem",
"afectiva e, na sua carreira, uma vagabundagem profissional. Corre atr s das",
"emo‡”es,  da  mudan‡a,  da  novidade. Aprecia particularmente as impress”es",
"in‚ditas  e  excitantes:  filmes  de  terror,  romances  policiais,  amores",
"excˆntricos,  tabaco,  lcool, estupefacientes. Em tudo, o nervoso, gosta de",
"exagero:  vocabul rio metaf¢rico e excessivo, vestu rio esquisito, culto do",
"paradoxo, atitudes teatrais e um inconformismo mais ou menos agressivo.",
    },
    {
    21,
    "Sentimental",
"Com  a  interven‡„o  da  secundariedade,  as  emo‡”es  nos sentimentais s„o",
"interiorizadas.  O  aspecto dominante ‚ a intimidade. Ao momento que passa,",
"no  nervoso,  sucede-se  o  sentimental, o peso do passado e a projec‡„o de",
"um  futuro  cuja  incerteza  gera sempre a ang£stia. A rumina‡„o mental ‚ o",
"seu  estado  quase  permanente,  comprazendo-se  na  auto-acusa‡„o. As suas",
"aspira‡”es  s„o  elevadas e um sentimento forte de dignidade f -lo lamentar",
"amargamente  a sua falta de rendimento. Os fracassos s„o duramente vividos,",
"deixando um sentimento de impotˆncia e falta de coragem. A sua face exprime",
"ami£de  o sofrimento interior e a tristeza. S¢ deixa saber o que lhe vai no",
"¡ntimo a pessoas em que deposita enorme confian‡a. Sen„o, recorre ao di rio",
"ou,  se  ‚  escritor,  …  poesia e … prosa autobiogr ficas. Quando d  a sua",
"afei‡„o ou a sua amizade, f -lo de um modo total que excede mesmo a partida",
"ou  a  morte  do  outro.  indeciso antes de agir e, durante a ac‡„o, o seu",
"ritmo  ‚  lento  e  sem  entusiasmo.  Por vezes, a mania da perfei‡„o ainda",
"retarda  mais  o  cumprimento  das  tarefas. Em resumo, o sentimental ‚ uma",
"pessoa  complicada  na  rela‡„o  com os outros e consigo mesmo. Se tem, por",
"exemplo,  de  comprar roupa, entra numa loja, experimenta grande quantidade",
"de  pe‡as,  incapaz de se decidir e finalmente sai com um vestido ou um par",
"de cal‡as do qual dir : ®Nunca na vida hei-de p“r esta porcaria!¯. Na loja,",
"n„o  teve coragem para dizer que n„o gostava de nada; c  fora, est  furioso",
"com a sua falta de coragem.",
    },
    {
    22,
    "Col‚rico",
"O  termo col‚rico presta-se a confus„o por poder fazer crer que o indiv¡duo",
"com este car cter est  constantemente encolerizado. Se bem que os emotivos,",
"- activos -,  prim rios possam ter atitudes violentas, estas n„o constituem",
"tra‡o  permanente,  nem mesmo dominante no seu comportamento. H , por isso,",
"autores  que  preferem  a  denomina‡„o de dinƒmicos, porque a constƒncia de",
"ardor  no trabalho ‚ a sua caracter¡stica marcante. O col‚rico ‚ feito para",
"a  ac‡„o  improvisada, … qual se lan‡a com enorme entusiasmo, impelido pela",
"emotividade. Mal acaba uma tarefa vira-se imediatamente para outra direc‡„o",
"e  acontece  mesmo que se empenhe em v rias tarefas simultƒneas. Seja homem",
"ou  mulher,  o  col‚rico  revela-se nas situa‡”es dif¡ceis e graves porque,",
"embora  as  sinta  vivamente,  depressa  se  recomp”e. S„o precisas grandes",
"trag‚dias  para  o  abater.  O repouso e todas as formas de inac‡„o s„o-lhe",
"penosas.  Em  vez  de  cruzar os bra‡os, prefere inventar uma ocupa‡„o. Mas",
"isto  tamb‚m  tem  os  seus  inconvenientes:  a precipita‡„o, o esp¡rito de",
"aventura, a temeridade e a dispers„o prejudicam, muitas vezes, a efic cia e",
"a perfei‡„o das suas realiza‡”es. Os sentimentos tendem para o excesso, mas",
"a  constƒncia  ‚  problem tica.  Tanto elogia ideias e pessoas num momento,",
"como  depois  as  condena  sem  apelo.    inflex¡vel com os moleng”es e os",
"indecisos.  Precisa  de companheiros ardentes e inflex¡veis como ele. Gosta",
"de  rodear-se  de  muita  gente,  o  que confere …s trocas interpessoais um",
"car cter  t„o variado como fugaz. Gosta de entrar em pol‚micas e o papel de",
"l¡der conv‚m-lhe … maravilha.",
    },
    {
    19,
    "Apaixonado",
"N„o  deve  aqui  tomar-se  o  termo  no  sentido  que  lhe ‚ atribu¡do pela",
"linguagem corrente, que qualifica o apaixonado como aquele que se lan‡a sem",
"controlo  na  satisfa‡„o  dos  desejos  e  na  busca  do  prazer.    que o",
"apaixonado,  sendo  emotivo,  vive  intensamente  os est¡mulos exteriores e",
"interiores  mas,  sendo secund rio, modera e dirige os seus impulsos. Chega",
"mesmo  a  sublim -los, canalizando para a ac‡„o energias que poderia gastar",
"de  outro  modo.  O  apaixonado  prossegue com uma tenacidade sem falhas, a",
"realiza‡„o  de uma obra suscept¡vel de marcar a sua existˆncia. Se encontra",
"obst culos,  n„o  os  considera  factores  de insucesso, constituindo mesmo",
"raz„o suplementar para redobrar de vigor na luta pelos seus objectivos. Tem",
"uma  esp‚cie  de divisa do tudo ou nada; vai at‚ ao fim, sem jamais admitir",
"que  pode  falhar. O apaixonado prepara meticulosamente com antecedˆncia as",
"suas ac‡”es e mant‚m-se perseverante na prossecu‡„o das metas que se imp“s.",
"Pouco lhe importa ser compreendido ou odiado, desde que esteja pessoalmente",
"convencido  da grandeza do seu empreendimento.  exigente consigo pr¢prio e",
"‚-o,  do  mesmo  modo, com os outros. N„o admite que algu‚m o perturbe ou o",
"refreie na sua actividade. O apaixonado tanto pode originar grandes obras e",
"sucessos como, quando cai na megalomania, na obstina‡„o cega, na dureza, no",
"desprezo ou na tirania, ser respons vel por destrui‡”es e fracassos.",
    },
    {
    11,
    "Sangu¡neo",
"O  termo sangu¡neo ‚ usado na classifica‡„o de Hip¢crates para caracterizar",
"indiv¡duos  com  pele  avermelhada. Ora, esta caracter¡stica nada tem a ver",
"com o n„o-emotivo, activo prim rio, sendo, por isso, mais adequado design -",
"-lo  realista.  De facto, da ac‡„o quotidiana, o sangu¡neo revela a clareza",
"dos  seus  objectivos e a adequa‡„o dos meios que usa. As suas preocupa‡”es",
"centram-se  nos  resultados  tang¡veis  e  pr¢ximos.   h bil a utilizar as",
"circunstƒncias e as pessoas. O imprevisto n„o o desconcerta e possui a arte",
"de  encontrar  os  meios  para  que as situa‡”es se virem em seu favor. Tem",
"enorme habilidade diplom tica, a que se acrescenta um optimismo constante e",
"um  sentido  raro  de  oportunidade.  As liga‡”es afectivas s„o escassas e,",
"quando as tem, s„o geralmente pouco profundas e passageiras.",
    },
    {
    9,
    "Fleum tico",
"Fleum tico  ‚  o  nome  conveniente para este tipo de seres pouco afectados",
"pelas   emo‡”es,   eficazes  e  constantes.  A  disposi‡„o  fundamental  do",
"fleum tico ‚ o sentido de lei.  frio, perseverante, ponderoso e s¢brio. De",
"um  modo  geral,  ‚  uma  pessoa de vida simples, desinteressada, honrada e",
"digna  de confian‡a. De humor sempre igual, faz an lises com grande lucidez",
"e  que atinjam elevados graus de abstrac‡„o. O seu ritmo de vida ‚ uniforme",
"e  met¢dico,  subordinado a normas que s¢ acontecimentos excepcionais podem",
"alterar.  N„o  nos  surpreende,  portanto,  que n„o haja artistas e grandes",
"romancistas inclu¡dos neste tipo caracterol¢gico.",
    },
    {
    14,
    "Amorfo",
"O  amorfo ou hipot¢nico ‚ geralmente volumoso e, quando adulto, ‚ gordo. As",
"suas   energias   podem   eventualmente   ser  gastas  no  desporto  ou  em",
"divertimentos,  mas  raramente  em  actividades  intelectuais.    entre os",
"amorfos  que  se  encontram  os  verdadeiros  pregui‡osos,  cujas  reservas",
"energ‚ticas  se  reservam  para  actividades  bem  determinadas como comer,",
"beber,  repousar,  recrear-se.  Se  ‚ criticado e exortado a mudar de vida,",
"pode  mostrar  boa  vontade  em  emendar-se,  mas  depressa regressa … vida",
"anterior.   O   seu  grande  prazer  ‚  nada  fazer  e  escapar  sempre  …s",
"contrariedades  da vida. No entanto, o amorfo ‚ bom companheiro, agrad vel,",
"aproveitando  as  alegrias da existˆncia e sabendo dividir os outros. Gosta",
"de  pregar partidas e ‚ o primeiro a achar gra‡a se ‚ ele pr¢prio v¡tima de",
"uma  partida.  o menos pontual dos homens, indiferente …s regras sociais e",
"aos  sistemas religiosos. Fugindo a responsabilidades de qualquer tipo, nem",
"sempre tem consciˆncia dos perigos, o que lhe d  a aparˆncia de corajoso.",
    },
    {
    11,
    "Ap tico",
"Seria  mais  exacto falar de pl cidos ou indiferentes. O tra‡o dominante ‚,",
"de  facto, o desinteresse geral. Tranquilidade e solid„o s„o para o ap tico",
"as  maiores  aspira‡”es.  Assim,  sabe,  na ocasi„o certa, servir-se do seu",
"aspecto  sofredor  para  causar  piedade  nos  outros  e  obter deles o que",
"custaria  muito  se  o fizesse pelos pr¢prios meios. Poupa as suas for‡as e",
"vigia  atentamente  os  m¡nimos  sintomas de doen‡a orgƒnica para se tratar",
"cuidadosamente  e  p“r  os  outros  a  tratar  dele.  As  suas ambi‡”es s„o",
"limitadas  ou  mesmo  inexistentes.  No  plano profissional contenta-se com",
"pap‚is modestos e as tarefas mon¢tonas convˆm-lhe perfeitamente.  um homem",
"de  h bitos  porque  o h bito ‚ um meio econ¢mico de viver. N„o enfrenta as",
"situa‡”es para as resolver, demitindo-se para n„o ser afectado.",
    }
};



#define  gotoxy(x, y)		(pointer + (((y * 80) + x) * 2))


char far *pointer = NULL;
int attr;



void writexy(int x, int y, char *str)
{
    char far *v;

    v = gotoxy(x, y);
    for(; *str; *v++ = *str++, *v++ = attr);
}



void write_ch(int x, int y, char ch)
{
    char far *v;

    v = gotoxy(x,y);
    *v++ = ch;
    *v++ = attr;
}



int get_video_mode(void)
{
    _AX = 0xF00;
    geninterrupt(0x10);
    return _AL;
}



void init_screen(void)
{
    int mode;

    mode = get_video_mode();
    if(mode != 2 && mode != 3 && mode != 7)
	 exit(-1);

    if(mode == 7)
	 pointer = (char far *)MK_FP(0xB000, 0x0);
    else
	 pointer = (char far *)MK_FP(0xB800, 0x0);
}



void max_colors(void)
{
    _AX = 0x1003;
    _BX = 0x0;
    geninterrupt(0x10);
}



void liga_cursor(void)
{
    _AX = 0x100;
    _CX = 0x506;
    geninterrupt(0x10);
}



void desliga_cursor(void)
{
    _AX = 0x100;
    _CX = 0x2000;
    geninterrupt(0x10);
}



void my_window(int x1, int y1, int x2, int y2, char *titulo)
{
    int   x;
    char  c[]="Ú¿ÀÙ³Ä";

    for(x=y1+1;x<y2;x++){
	 write_ch(x1, x, c[4]);
	 write_ch(x2, x, c[4]);
    }
    for(x=x1+1;x<x2;x++){
	 write_ch(x, y1, c[5]);
	 write_ch(x, y2, c[5]);
    }

    for(x=0;titulo[x]!='\0';x++);
    if(x)
	 writexy(((x2 + x1 - x) >> 1), y1, titulo);
    write_ch(x1, y1, c[0]);
    write_ch(x2, y1, c[1]);
    write_ch(x1, y2, c[2]);
    write_ch(x2, y2, c[3]);
}



void back(void)
{
    int i;
    char *s="                                                                              ";

    attr = 240;
    writexy(1, 1, s);
    writexy(23, 1, "Heymans  -  Wiersma  -  Le Senne");

    attr = 159;
    for(i=2; i!=25; i++)
	 writexy(1, i, s);

    attr = 159;
    my_window(0, 0, 79, 24, "[ Teste de Personalidade ]");


    attr = 31;
    my_window(2, 2, 77, 13, "[ Elementos fundamentais do car cter ]");
    s[strlen(s)-4] = '\0';
    attr = 31;
    for(i=3; i!=13; i++)
	 writexy(3, i, s);

    attr = 63;
    my_window(5, 14, 74, 23, "[ Seleccione os seus elementos ]");
    s[strlen(s)-6] = '\0';
    i+=2;
    for(; i!=23; i++)
	 writexy(6, i, s);
}



void personalidade(int p)
{
    int i, j, v;
    char aux[100];

    gettext(1,1,80, 25, &buff);
    sprintf(aux, "[ Personalidade: %s ]", personalidades[p].titulo);
    attr = 159;
    my_window(0, 0, 79, 24, aux);

    for(i=2; i!=24; i++)
	 for(j=1; j!=79; j++)
	      write_ch(j, i, ' ');

    v = (22 - personalidades[p].linhas) / 2 + 2;
    for(i=0; i!=personalidades[p].linhas; i++)
	 writexy(2, i+v, personalidades[p].descricao[i]);

    getch();
    puttext(1,1,80, 25, buff);
}



void linha_vermelha(int y_antigo, int novo_y)
{
    int i;
    char far *v;

    v = gotoxy(6, y_antigo);
    for(i=0; i!=68; i++){
	 *v++;
	 *v++ = 63;
    }
    v = gotoxy(6, novo_y);
    for(i=0; i!=68; i++){
	 *v++;
	 *v++ = 207;
    }
}



void opcao(void)
{
    int y;
    char t;

    y=0;
    linha_vermelha(y+1+15, y+15);
    do{
	 t=getch();
	 if(!t){
	      t = getch();
	      switch(t){
		   case 72:
			if(y>0){
			     y--;
			     linha_vermelha(y+1+15, y+15);
			}
			else{
			     y=7;
			     linha_vermelha(y-7+15, y+15);
			}
			break;
		   case 80:
			if(y<7){
			     y++;
			     linha_vermelha(y-1+15, y+15);
			}
			else{
			     y=0;
			     linha_vermelha(y+7+15, y+15);
			}
			break;
	      }
	 }
	 else{
	      switch(t){
		   case 27:
			break;
		   case 13:
			personalidade(y);
			break;
	      }
	 }
    }while(t!=27);
}



int main(void)
{
    int x, y;

    init_screen();
    desliga_cursor();
    max_colors();
    back();

    x = 3;
    y = 3;
    attr = 31;

    writexy(x, y++, "(E)  Emotivo.....Um est¡mulo que n„o tem consequˆncias nos outros ‚ capaz");
    writexy(x, y++, "                 de lhe causar grandes reac‡”es.");
    writexy(x, y++, "(nE) n„o Emotivo. necess rio um est¡mulo muito forte para originar uma");
    writexy(x, y++, "                 reac‡„o e n„o muito pronunciada.");

    writexy(x, y++, "(A)  Activo......N„o necessita de estimulos exteriores para passar ao");
    writexy(x, y++, "                 acto. Age com rapidez e resiste … fadiga.");
    writexy(x, y++, "(nA) n„o Activo..Age sob press„o e quando lhe surge um obst culo, perde o");
    writexy(x, y++, "                 empenho e desiste. Trabalha lentamente.");

    writexy(x, y++, "(P)  Prim rio....Indiv¡duo com reac‡”es r pidas, imediatas, mas ef‚meras.");
    writexy(x, y++, "(S)  Secund rio..Indiv¡duo com reac‡”es lentas ou diferidas, mas dur veis.");

    x = 9;
    y+= 2;
    attr = 63;

    writexy(x, y++, "Emotivo - n„o Activo Prim rio         ¯  EnAP   >   Nervoso");
    writexy(x, y++, "Emotivo - n„o Activo Secund rio       ¯  EnAS   >   Sentimental");
    writexy(x, y++, "Emotivo - Activo Prim rio             ¯  EAP    >   Col‚rico");
    writexy(x, y++, "Emotivo - Activo Secund rio           ¯  EAS    >   Apaixonado");
    writexy(x, y++, "n„o Emotivo - Activo Prim rio         ¯  nEAP   >   Sangu¡neo");
    writexy(x, y++, "n„o Emotivo - Activo Secund rio       ¯  nEAS   >   Fleum tico");
    writexy(x, y++, "n„o Emotivo - n„o Activo Prim rio     ¯  nEnAP  >   Amorfo");
    writexy(x, y++, "n„o Emotivo - n„o Activo Secund rio   ¯  nEnAS  >   Ap tico");

    opcao();

    clrscr();
    liga_cursor();

    return 0;
}