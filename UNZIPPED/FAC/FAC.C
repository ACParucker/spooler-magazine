#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <graphics.h>

/* Fonte de caracteres */
/* Renato Casquilho, 1993 */
void alte_fonte(void);

int fonte;
char *buffer = NULL;


/* Fun‡„o para imprimir a frase 'frase' a meio do ecr„, */
/* na linha 'y' e com a cor 'cor' */
/* Renato Casquilho, 1993 - MOTOR.C */
void escreve(char *frase, int y, int cor)
{
	int col;
	setcolor(cor);
	col = (640-textwidth(frase))/2;
	outtextxy(col, y, frase);
}




void espera_tecla(int cor, char *s)
{
    char t;

    settextstyle(GOTHIC_FONT, HORIZ_DIR, 4);
    escreve(s, 440, cor);
    settextstyle(fonte, HORIZ_DIR, 3);
    while(kbhit())
	 getch();
    t = getch();
    if(t==27){
	 closegraph();
	 exit(0);
    }
}

void tutorial(char *titulo, int linhas, char *texto[], int flag)
{
    int i, j;


    clearviewport();
    setcolor(WHITE);
    rectangle(0, 0, 639, 479);
    escreve(titulo, 0, 15);
    setcolor(LIGHTGRAY);
    settextstyle(fonte, HORIZ_DIR, 1);
    j=0;
    for(i=0; i!=linhas; i++, j++){
	 if(texto[i]=="!"){
	      j=-1;
	      espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
	      clearviewport();
	      rectangle(0, 0, 639, 479);
              setcolor(LIGHTGRAY);
	      settextstyle(fonte, HORIZ_DIR, 1);
	 }
	 else
	      outtextxy(10, 20*j, texto[i]);
    }
    if(flag && j)
	 espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}


void cn_con_int(void)
{
    char *text[]={
	 "",
	 "",
	 "Trata-se de uma t‚cnica de controle usada em grande",
	 "parte das m quinas ferramenta. Esta forma de controle",
	 "envolve a medida da posi‡„o de uma pe‡a na m quina, em",
	 "rela‡„o … m quina ferramenta, e a compara‡„o com um",
	 "valor pr‚-especificado pelo programa de controle. Daqui",
	 "resulta um sinal de erro que ‚ transformado em movimento",
	 "pelos dispositivos de accionamento.",
	 "",
	 "Os sistemas de controle podem ser: de posicionamento,",
	 "para-axial ou de contornamento.",
	 ""
    };

    tutorial("1.1- Conceitos Introdut¢rios", 12, text, 0);

    setcolor(WHITE);
    settextstyle(fonte, HORIZ_DIR, 1);

    rectangle(20, 280, 140, 330);
    outtextxy(30, 290, "Programa");

    line(140, (330+280)/2, 260, (330+280)/2);
    line(250, (330+280)/2-5, 260, (330+280)/2);
    line(250, (330+280)/2+5, 260, (330+280)/2);
    outtextxy(160, (330+280)/2-30, "Posi‡„o");
    outtextxy(160, (330+280)/2, "desejada");

    rectangle(260, 280, 390, 330);
    outtextxy(270, 280, "Unidade de");
    outtextxy(270, 300, "Controlo");

    line(390, (330+280)/2, 450, (330+280)/2);
    line(440, (330+280)/2-5, 450, (330+280)/2);
    line(440, (330+280)/2+5, 450, (330+280)/2);

    outtextxy(400, (330+280)/2-30, "Erro");

    rectangle(450, 250, 580, 330+25);
    outtextxy(460, 280-30, "Actuador");
    line(450, 250+27, 580, 250+27);
    outtextxy(460, 300-25, "M quina");
    line(450, 250+27*2, 580, 250+27*2);
    outtextxy(460, 320-20, "Transdutor");
    outtextxy(460, 340-20, "de posi‡„o");

    line((580+450)/2, 330+25, (580+450)/2, 330+80);
    line((390+260)/2, 330+80, (580+450)/2, 330+80);
    line((390+260)/2, 330+80, (390+260)/2, 330);
    line((390+260)/2, 330, (390+260)/2-5, 330+10);
    line((390+260)/2, 330, (390+260)/2+5, 330+10);
    outtextxy((390+260)/2+20, 330+80-30, "Posi‡„o actual");

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}


void cn_dis_pos(void)
{
    int i, d, h;
    char *text[]={
	 "",
	 "",
	 "Os dispositivos de posicionamento - transdutores de posi‡„o",
	 "-, fornecem informa‡„o sobre a posi‡„o dos diferentes eixos",
	 "ao sistema de controle.",
	 "",
	 "Os transdutores podem ser classificados em absolutos e",
	 "incrementais. Podem ainda ser tamb‚m classificados em",
	 "transdutores de posi‡„o angular e de posi‡„o linear.",
	 "",
	 "Quanto ao sinal produzido … sa¡da, podem ser classificados",
	 "em anal¢gicos e digitais."
    };


    tutorial("1.2- Dispositivos de Posicionamento", 12, text, 0);

    setcolor(WHITE);

    /* mesa */
    line(250, 400-20, 550, 300-20);
    line(250, 400+8-20, 550, 300+8-20);
    line(250, 400+8*2-20, 250, 400-20);
    line(550, 300-20, 550, 300+8*2-20);
    line(250, 400-20, 130, 360-20);
    line(130, 360-20, 410, 300-20);
    line(410, 300-20, 550, 300-20);
    line(130, 360+8*2-20, 250, 400+8*2-20);
    line(130, 360-20, 130, 360+8*2-20);
    /* /\/\/\/\/\/\ */
    outtextxy(30, 260, "Transdutor Angular (fixo)");
    d = 0;
    h = 0;
    for(i=0; i!=20; i++){
	 line(250+d, 400+8*2-20-h, 260+d, 400+8*2-20-9-h);
	 line(260+d, 400+8*2-20-9-h, 260+5+d, 400+8*2-20-9+4-h);
	 d+= 15;
	 h+= 5;
    }

    /* debaixo da mesa … esquerda */
    line(160, 400-20+6, 160, 380-20+6);
    line(190, 400+20-20-3, 190, 380+20-20-3);
    line(190, 417-20, 218, 400-15); /* / */
    line(160, 406-20, 190, 417-20);
    line(120, 430-20, 172, 400-20);
    line(134, 430-20+1, 186, 400-20+1);

    /* transdutor */
    outtextxy(464, 354, "T");
    ellipse(500, 390-20, 0, 360, 10, 20);
    ellipse(450, 390-20, 90, 270, 10, 20);
    line(500, 390-20-20, 450, 390-20-20);
    line(500, 390+20-20, 450, 390+20-20);
    ellipse(350, 390-20, 0, 360, 5, 10);
    line(450-10, 390-20-2, 350, 390-20-2);
    line(450-10, 390-20+2, 350, 390-20+2);

    line(350, 390-20+10, 350-10-10, 390-20+10);
    line(350-10-10, 390-20+10, 350-10-10-5, 390-20+10-5);
    line(350-10-10-5, 390-20+10-6, 350-10+5, 390-20+10-6);
    line(350-10-10-5, 390-20+10-6*2, 350-10+5, 390-20+10-6*2);
    line(350-10-10, 390-20+10-6, 350-10-10-5, 390-20+10-6*2);

    /*seta*/
    line(340, 390, 340, 410);
    line(340, 390, 335, 395);
    line(340, 390, 345, 395);

    outtextxy(50, 410, "A mesa, ao deslizar, acciona o detector de movimento");

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}


void cn_dis_acc(void)
{
    char *text[]={
	 "",
	 "",
	 "Os sinais el‚ctricos de comando que controlam os",
	 "movimentos de uma m quina de Controle Num‚rico (e os",
	 "dos robots), s„o transformados em trabalho mecƒnico pelos",
	 "dispositivos de accionamento. Estes podem ser actuadores:",
	 "hidr ulicos, pneum ticos ou el‚ctricos.",
	 "",
	 "",
	 "Compara‡„o dos diversos tipos de mecanismos de",
	 "accionamento:",
	 "",
	 "- Consumo: os actuadores electromecƒnicos necessitam de",
	 "potˆncia apenas quando a m quina est  a trabalhar.",
	 "",
	 "- Potˆncia: os sistemas de alta press„o fornecem maior",
	 "potˆncia que os electromecƒnicos.",
	 "",
	 "- Resposta: os sistemas hidr ulicos respondem a mais",
	 "comandos por segundo do que os outros, embora os tempos",
	 "de respostas sejam aproximadamente os mesmos.",
	 "!",
	 "",
	 "- Dimens”es: os sistemas de alta press„o necessitam de",
	 "mais espa‡o.",
	 "",
	 "- Ambiente: os sistemas de alta press„o requerem filtragem",
	 "e arrefecimento para manterem as suas caracter¡sticas.",
	 "",
	 "- Aplica‡„o: os sistemas hidr ulicos s„o utilizados em",
	 "opera‡”es de contornamento por serem r pidos e suaves.",
	 "Os sistemas pneum ticos e electromecƒnicos s„o utilizados",
	 "para opera‡”es de posicionamento."
    };

    tutorial("1.3- Dispositivos de Accionamento", 33, text, 0);

    putimage(400, 260, buffer, 1);
    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}


void cn_pro_cn(void)
{
    char *text[] = {
	 "",
         "",
	 "A programa‡„o destas m quinas envolve a especifica‡„o da",
	 "da sequˆncia dos passos de processamento a realizar pela",
	 "m quina. Envolve tamb‚m a prepara‡„o de um meio de",
	 "input - disqueta -, por interm‚dio do qual, as instru‡”es",
	 "s„o comunicadas … m quina.",
	 "",
	 "Existem dois modos de programa‡„o: manual e assistida por",
	 "computador (linguagem de programa‡„o). A programa‡„o",
	 "manual ‚ adequada para opera‡”es de posicionamento, n„o",
	 "sendo permitida a defini‡„o da geometria da pe‡a, o que",
	 "torna as opera‡”es de contornamento quase imposs¡veis.",
	 "Na programa‡„o assistida por computador, o programa ‚",
	 "escrito numa linguagem de alto n¡vel e s„o permitidas: a",
	 "defini‡„o da geometria da pe‡a e o envio de comandos",
	 "para a m quina.",
	 "",
	 "Quanto …s instru‡”es, estas s„o do tipo: baixar ferramenta",
	 "at‚ … posi‡„o x, deslocar pelo eixo dos xx, recolher",
	 "ferramenta, . . .",
	 "!",
	 "",
	 "A verifica‡„o dos programas ‚ conseguida … custa de duas",
	 "t‚cnicas: maquinagem com materiais substitutos (custos",
	 "menores e melhores caracter¡sticas de maquinagem), e",
	 "provas gr ficas (representa‡„o visual no ecr„ de percurso da",
	 "ferramenta)."
    };

    tutorial("1.4- Programa‡„o para Controle Num‚rico", 28, text, 0);

    setcolor(WHITE);
    settextstyle(fonte, HORIZ_DIR, 1);

    line(450, 130, 450, 410);			/* vert */
    line(320, (370+170)/2, 580, (370+170)/2);	/* hor */
    line(510, (370+170)/2-5, 510, (370+170)/2+5);
    outtextxy(510-3, (370+170)/2, "2");
    line(540, (370+170)/2-5, 540, (370+170)/2+5);
    outtextxy(540-3, (370+170)/2, "3");

    line(450-5, (370+170)/2-30*2, 450+5, (370+170)/2-30*2);
    outtextxy(450-16, (370+170)/2-30*2-14, "2");
    line(450-5, (370+170)/2-30*4, 450+5, (370+170)/2-30*4);
    outtextxy(450-16, (370+170)/2-30*4-14, "4");

    circle(510, (370+170)/2-30*4, 3);  /* P0 */
    outtextxy(510+10, (370+170)/2-30*4-20, "P0");
    circle(540, (370+170)/2-30*2, 3);  /* P1 */
    outtextxy(540+10, (370+170)/2-30*2-20, "P1");
    line(510, (370+170)/2-30*4, 540, (370+170)/2-30*2);
    outtextxy((540+510)/2+10, ((370+170)/2-30*2 + (370+170)/2-30*4)/2-20, "L1");



    outtextxy(50, 160, "MACHIN / EXEMPLO, 1");
    outtextxy(50, 180, "CLPRNT");
    outtextxy(50, 200, "P0 = POINT / 2, 4, 0");
    outtextxy(50, 220, "P1 = POINT / 3, 2, 0");
    outtextxy(50, 240, "L0 = LINE / P0, P1");
    outtextxy(50, 260, "INTOL / .010");
    outtextxy(50, 280, "OUTTOL / .010");
    outtextxy(50, 300, "CUTTER / .700");
    outtextxy(50, 320, "........");
    outtextxy(50, 340, "FINI");

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}




void ri_con_int(void)
{
    char *text[] = {
	 "",
	 "",
	 "A defini‡„o de Robot Industrial da RIA (Robotics Industries",
	 "Association) dos EEUU ‚: ®um Robot Industrial ‚ um",
	 "manipulador multifuncional reprogram vel, concebido para",
         "movimentar materiais, pe‡as, ferramentas ou outros",
	 "dispositivos especiais, atrav‚s de uma s‚rie vari vel de",
	 "movimentos programados, para realizar uma variedade de",
	 "tarefas¯.",
	 "",
	 "",
	 "S„o trˆs as gera‡”es de robots que podemos identificar:",
	 "",
         "- A primeira caracteriza-se essencialmente por robots",
	 "cegos, surdos e mudos, capazes de efectuar tarefas",
	 "repetitivas, embora n„o sejam dotados de capacidades",
	 "sensoriais e, constituem a maior parte dos robots instalados",
	 "actualmente. As suas traject¢rias podem ser alteradas em",
	 "resposta a sinais externos, embora isto n„o possa ser feito",
	 "feito on-line.",
	 "!",
	 "",
	 "- A segunda gera‡„o j  ‚ capaz de responder a sinais",
	 "externos, de tacto ou vis„o, de uma forma pr‚-programada",
	 "e, as suas traject¢rias podem ser alteradas on-line, em",
	 "resposta a sinais sensoriais.",
	 "",
	 "- A terceira gera‡„o, em fase de desenvolvimento, ‚ a dos",
	 "robots inteligentes, ou seja: capazes de reagir ao ambiente,",
	 "respondendo … linguagem natural e com capacidades de",
	 "auto-programa‡„o."
    };

    tutorial("2.1- Conceitos Introdut¢rios", 31, text, 0);
    putimage(400, 260, buffer, 1);
    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}



void ri_car(void)
{
    char *text[]={
	 "",
	 "",
	 "Algumas caracter¡sticas importantes na escolha de um",
	 "robot, para realizar uma determinada tarefa, s„o: o n£mero",
	 "de graus de liberdade, o volume de trabalho, precis„o,",
	 "repetibilidade, resolu‡„o espacial, capacidade de carga,",
	 "velocidade e acelera‡„o.",
	 "",
	 "O n£mero de graus de liberdade ‚ o n£mero de eixos que",
	 "podem ser controlados separadamente. Existem,",
	 "normalmente, trˆs eixos principais e trˆs secund rios. Os",
	 "primeiros permitem o posicionamento no espa‡o e os",
	 "segundos, a orienta‡„o no espa‡o. Graus adicionais s„o",
	 "considerados redundantes, embora possam ser utilizados",
	 "para facilitar o acesso a pontos dif¡ceis e facilitar a",
	 "programa‡„o.",
	 "",
	 "O volume de trabalho ‚ a zona espacial que o robot, ou",
	 "parte dele, pode alcan‡ar e ‚ ditado pela sua configura‡„o",
	 "mecƒnica.",
	 "!",
	 "",
	 "A precis„o de um robot traduz a capacidade de se posicionar",
	 "num determinado ponto do espa‡o.",
	 "",
	 "A repetibilidade diz respeito … capacidade de voltar ao",
	 "mesmo ponto repetidamente.",
	 "",
	 "A resolu‡„o espacial de um robot ‚ o menor deslocamento",
	 "que o robot consegue realizar.",
	 "",
	 "A capacidade de carga pode variar de um at‚ muitos",
	 "milhares de quilogramas e depende do tamanho,",
	 "configura‡„o, constru‡„o e tipo de accionamento. N„o entra",
	 "em linha de conta com o ¢rg„o terminal, normalmente",
	 "montado no pulso.",
	 "",
	 "A velocidade e acelera‡„o dependem da carga manipulada",
	 "e variam com a posi‡„o no volume de trabalho. Dependem",
	 "ainda da precis„o pretendida para o posicionamento do peso",
	 "do objecto manipulado e da distƒncia a percorrer. A",
	 "velocidade m xima de um robot espacial ‚ cerca de 2 m/s."
    };

    tutorial("2.2- Caracter¡sticas", 42, text, 1);

    clearviewport();

    rectangle(0, 0, 639, 479);

    circle(639/4, 479/4, 60);
    circle(639/4, 479/4, 8);

    circle(639/4*3, 479/4, 60);
    circle(639/4*3, 479/4, 8);

    circle(639/4, 479/4*3, 60);
    circle(639/4, 479/4*3, 8);

    circle(639/4*3, 479/4*3, 60);
    circle(639/4*3, 479/4*3, 8);

    setcolor(LIGHTGRAY);
    setfillstyle(SOLID_FILL, LIGHTGRAY);

    setcolor(WHITE);
    outtextxy(60, 0,  "M  precis„o");
    outtextxy(60, 20, "Boa repetibilidade");
    setcolor(LIGHTGRAY);
    pieslice(639/4+40, 479/4+10, 0, 360, 5);
    pieslice(639/4+40, 479/4-10, 0, 360, 5);
    pieslice(639/4+50, 479/4, 0, 360, 5);

    setcolor(WHITE);
    outtextxy(380, 0,  "Boa precis„o");
    outtextxy(380, 20, "M  repetibilidade");
    setcolor(LIGHTGRAY);
    pieslice(639/4*3+40, 479/4-20, 0, 360, 5);
    pieslice(639/4*3-40, 479/4+20, 0, 360, 5);
    pieslice(639/4*3+40, 479/4+20, 0, 360, 5);

    setcolor(WHITE);
    outtextxy(60, 479/2,  "M  precis„o");
    outtextxy(60, 479/2+20, "M  repetibilidade");
    setcolor(LIGHTGRAY);
    pieslice(639/4+40, 479/4*3-10, 0, 360, 5);
    pieslice(639/4-40, 479/4*3+30, 0, 360, 5);
    pieslice(639/4+10, 479/4*3, 0, 360, 5);

    setcolor(WHITE);
    outtextxy(380, 479/2,  "Boa precis„o");
    outtextxy(380, 479/2+20, "Boa repetibilidade");
    setcolor(LIGHTGRAY);
    pieslice(639/4*3+5, 479/4*3+8, 0, 360, 5);
    pieslice(639/4*3-10, 479/4*3-2, 0, 360, 5);
    pieslice(639/4*3+5, 479/4*3-10, 0, 360, 5);

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}


void ri_conf_mec(void)
{
    char *text[]={
	 "",
	 "",
	 "Quanto … configura‡„o mecƒnica ou anatomia, os robots",
	 "podem ser:",
	 "- Cartesianos: com trˆs eixos principais de movimento",
	 "linear ao longo de um sistema de eixos xyz e o seu volume",
	 "de trabalho ‚ um paralelep¡pedo.",
	 "- Coordenadas Cil¡ndricas: com dois eixos lineares, um",
	 "horizontal e outro vertical e, um eixo rotacional no plano",
	 "horizontal. O seu volume de trabalho ‚ um cilindro.",
	 "- Esf‚ricos: com um eixo linear e dois rotacionais. O seu",
	 "volume de trabalho ‚ uma esfera.",
	 "- Antropom¢rficos ou de Bra‡o Articulado: assim chamado",
	 "por analogia com o bra‡o humano, possuindo juntas",
	 "rotacionais. O primeiro grau de liberdade ‚ uma rota‡„o",
	 "sobre uma base e, o segundo e terceiro s„o chamados ombro",
	 "e cotovelo. O pulso possui tamb‚m at‚ trˆs graus de",
	 "liberdade rotacionais.",
	 "- SCARA (Selectiv Compilance Assembly Robot Arm): com",
	 "trˆs graus de liberdade rotacionais ao longo de um plano",
	 "horizontal e, um eixo linear vertical. N„o possui pulso.",
	 "!"
    };

    tutorial("2.3- Configura‡„o Mecƒnica", 22, text, 0);

    setcolor(WHITE);
    clearviewport();
    rectangle(0, 0, 639, 479);
    settextstyle(fonte, HORIZ_DIR, 3);
    escreve("Distribui‡„o de Robots por Pa¡ses (1988)", 30, WHITE);
    settextstyle(fonte, HORIZ_DIR, 1);

    settextjustify(2, 0);
    outtextxy(150, 110+30*0, "Jap„o");
    outtextxy(150, 110+30*1, "EUA");
    outtextxy(150, 110+30*2, "Alemanha");
    outtextxy(150, 110+30*3, "Fran‡a");
    outtextxy(150, 110+30*4, "It lia");
    outtextxy(150, 110+30*5, "Reino Unido");
    outtextxy(150, 110+30*6, "Su‚cia");
    outtextxy(150, 110+30*7, "B‚lgica");
    outtextxy(150, 110+30*8, "Espanha");
    settextjustify(0, 2);

    rectangle(170, 110-30, 570,110+30*9);
    line(170, 110-30, 170, 110+30*9+10);
    outtextxy(170, 110+30*9+10, "0");
    line(170+100, 110-30, 170+100, 110+30*9+10);
    outtextxy(170+100, 110+30*9+10, "50");
    line(170+200, 110-30, 170+200, 110+30*9+10);
    outtextxy(170+200, 110+30*9+10, "100");
    line(170+300, 110-30, 170+300, 110+30*9+10);
    outtextxy(170+300, 110+30*9+10, "150");
    line(170+400, 110-30, 170+400, 110+30*9+10);
    outtextxy(170+400, 110+30*9+10, "200");

    bar(172, 110-15,      172+350, 110-20+25);
    bar(172, 110-15+30*1, 172+66, 110-20+25+30*1);
    bar(172, 110-15+30*2, 172+33, 110-20+25+30*2);
    bar(172, 110-15+30*3, 172+20, 110-20+25+30*3);
    bar(172, 110-15+30*4, 172+15, 110-20+25+30*4);
    bar(172, 110-15+30*5, 172+9, 110-20+25+30*5);
    bar(172, 110-15+30*6, 172+5, 110-20+25+30*6);
    bar(172, 110-15+30*7, 172+3, 110-20+25+30*7);
    bar(172, 110-15+30*8, 172+1, 110-20+25+30*8);

    outtextxy(170-100, 110+30*9+10, "Milhares");

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}



void ri_pro_rob(void)
{
    char *text[]={
	 "",
	 "",
	 "A forma como um robot pode ser programado depende da",
	 "sofistica‡„o do seu sistema de controle. Vejamos ent„o como",
	 "podem ser programados:",
	 "",
	 "- Sequˆncia Limitada: os robots deste tipo possuem,",
	 "normalmente, actuadores pneum ticos ou hidr ulicos e",
	 "trabalham entre fins de curso mecƒnicos, que costumam ter",
	 "amortecedores para fornecer um desacelera‡„o controlada,",
	 "e, interruptores que assinalam o fim de alcance. A",
         "velocidade ‚ controlada por um v lvula e o controle ‚",
	 "efectuado por interm‚dio de um PLC (Controlador L¢gico",
	 "Program vel).",
	 "",
	 "- Controle Ponto a Ponto: a posi‡„o de cada eixo ‚ medida",
	 "por um 'encoder' ou 'resolver' que fornece um sinal de",
	 "'feedback'. O robot ‚ programado armazenando pontos",
	 "discretos na sua mem¢ria e as traject¢rias entre pontos",
	 "consecutivos n„o ‚ definida. A programa‡„o ‚ levada a cabo",
	 "a partir de uma caixa de comando.",
	 "!",
         "",
	 "- Controle Cont¡nuo de Traject¢ria: requer um modelo",
         "cinem tico do robot de modo que as posi‡”es interm‚dias ao",
	 "longo de uma traject¢ria, possam ser calculadas e, que se",
	 "possa coordenar o controle de todos os eixos. Este tipo de",
	 "robots ‚, normalmente, programado com o auxilio da caixa",
	 "de comando para as posi‡”es e, de uma linguagem de",
	 "programa‡„o para os movimentos entre as posi‡”es.",
	 "",
	 "- Inteligente: o robot tem capacidade de alterar o seu",
	 "programa em resposta a condi‡”es do ambiente de trabalho",
	 "circundante. A programa‡„o ‚ feita por meio de uma",
	 "linguagem de alto n¡vel."
    };

    tutorial("2.4- Programa‡„o de Robots", 35, text, 0);

    setcolor(WHITE);
    outtextxy(10, 290, "Linguagem VAL II - (Pegar numa pe‡a)");
    outtextxy(10, 330+20*0, "APPRO P1, 70");
    outtextxy(10, 330+20*1, "MOVES P1");
    outtextxy(10, 330+20*2, "CLOSEI");
    outtextxy(10, 330+20*3, "DEPART 50");

    outtextxy(160, 330+20*0, "; colocar o robot a 70 mm acima do ponto P1");
    outtextxy(160, 330+20*1, "; o robot desloca-se em linha recta at‚ P1");
    outtextxy(160, 330+20*2, "; fechar a garra");
    outtextxy(160, 330+20*3, "; afastar 50mm ao longo do eixo dos zz");

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}



void ri_org_ter(void)
{
    char *text[]={
	 "",
	 "",
	 "Os ¢rg„os terminais podem ser agrupados em garras e",
	 "ferramentas. Os primeiros destinam-se a opera‡”es de",
	 "manuseamento e os segundo a aplica‡”es de processamento.",
	 "",
         "Os principais tipos de garras s„o: pin‡as (el‚ctricas,",
	 "pneum ticas, hidr ulicas) em cerca de 60%, suc‡„o (ventosas),",
	 "cerca de 20%, insufl veis, magn‚ticas e ganchos em cerca de",
	 "2%, adesivas e agulhas.",
	 "",
	 "Para maximizar a capacidade de carga £til, os ¢rg„os",
         "terminais devem ser leves. Devem tamb‚m possuir uma",
	 "constru‡„o r¡gida para possibilitar o posicionamento preciso",
	 "e, que sejam pequenos para permitir a opera‡„o em espa‡os",
	 "restritos."
    };

    tutorial("2.5- ¢rg„os Terminais", 16, text, 1);

    clearviewport();
    setcolor(WHITE);
    rectangle(0, 0, 639, 479);
    line(639/2, 0, 639/2, 479-35);
    settextstyle(fonte, HORIZ_DIR, 4);
    settextjustify(1, 2);
    outtextxy(639/4, 20, "Garra");
    outtextxy(639/4*3, 20, "Ferramenta");
    setcolor(LIGHTGRAY);
    settextstyle(fonte, HORIZ_DIR, 2);
    outtextxy(639/4*3, 70, "- Soldadura no ponto");
    outtextxy(639/4, 70, "- Boa press„o");
    setcolor(WHITE);
    settextjustify(0, 2);
    settextstyle(fonte, HORIZ_DIR, 1);

    /* garra */
    line(70, 300, 250, 300);
    line(90, 280, 230, 280);
    line(250, 300, 250, 160);
    line(230, 280, 230, 160);
    line(230, 160, 250, 160);
    line(70, 160, 70, 300);
    line(90, 280, 90, 160);
    line(70, 160, 90, 160);
    line(150, 420, 150, 300);
    line(170, 420, 170, 300);
    /* efeito 3D */
    line(142, 410, 142, 300);
    line(230, 280, 230-8, 270);
    line(90, 270, 230-8, 270);
    line(230-8, 270, 230-8, 150);
    line(230-8, 150, 230, 160);
    line(230-8, 150, 250-8, 150);
    line(250, 160, 250-8, 150);
    line(70, 300, 70-8, 300-10);
    line(70-8, 300-10, 70-8, 150);
    line(70-8, 150, 70, 160);
    line(70-8, 150, 90-8, 150);
    line(90, 160, 90-8, 150);



    /* ferramenta */
    line(550-30, 290, 450, 290);
    line(550-30, 320, 450, 320);
    circle(450-30, 305, 32);
    line(450-30-10, 150, 450-30-10, 305-30);
    line(450-30+10, 150, 450-30+10, 305-30);

    ellipse(550, 350, 180, 360, 30, 10);
    ellipse(550, 250, 0, 360, 30, 10);
    line(550-30, 350, 550-30, 250);
    line(550+30, 350, 550+30, 250);
    line(550, 420, 550-20, 350+8);

    line(550, 420, 550+20, 350+8);

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}


void ri_equ_per(void)
{
    char *text[]={
	 "",
	 "",
	 "O robot n„o ‚ uma m quina que funcione isolada, ‚,",
	 "normalmente, o centro de uma c‚lula que pode integrar,",
         "entre outras pe‡as de equipamento, garras, ferramentas,",
	 "sensores, controladores l¢gicos program veis, sistemas de",
	 "identifica‡„o e de armazenamento e transporte e m quinas",
	 "de controle num‚rico.",
	 "",
	 "Uma das componentes principais de uma c‚lula robotizada",
	 "s„o os mecanismos de alimenta‡„o de pe‡as, isto ‚: o",
	 "conjunto de dispositivos que levam as pe‡as at‚ ao robot.",
	 "",
         "O fornecimento de pe‡as pode ser feito atrav‚s de um",
	 "tapete rolante e alimentadores autom ticos controlados por",
	 "computador ou n„o, e ainda, sistemas de AGV (Automatically",
	 "Guided Vehicle). Estes podem ser vistos como um tipo",
	 "especial de robot m¢vel, podendo ser guiados por carris, fios",
	 "embebidos no ch„o do local, linhas pintadas e sistemas de",
	 "vis„o, ou por ondas de r dio."
    };

    tutorial("2.6- Equipamento Perif‚rico", 20, text, 0);

    espera_tecla(WHITE, "Qualquer tecla para continuar. . .");
}



void ri_vis_rob(void)
{
    char *text[]={
	 "",
         "",
	 "A vis„o por computador, ou vis„o para robots, pode ser",
	 "definida como um processo de extrac‡„o, caracteriza‡„o e",
	 "interpreta‡„o de imagens do mundo (3D).",
         "",
	 "Um sistema de vis„o engloba trˆs componentes",
	 "fundamentais: um subsistema de aquisi‡„o de imagem, um",
	 "de processamento e an lise e, um de interpreta‡„o que",
	 "permite a tomada de decis”es e ac‡”es.",
	 "",
	 "O sistema de aquisi‡„o de imagem ‚, normalmente,",
	 "constitu¡do por uma cƒmara ligada a um computador, por",
	 "interm‚dio de uma placa digitalizadora de v¡deo com",
	 "mem¢ria, sendo por vezes ainda necess rio um sistema de",
	 "ilumina‡„o especial. Dado que este processo pode ser ruidoso,",
	 "uma t‚cnica comum de pr‚-processamento consiste nas",
	 "opera‡”es de smoothing. Estas envolvem o uso de filtros",
	 "especiais (por exemplo: m‚dias e/ou medianas) ou no",
	 "dom¡nio das frequˆncias. Como as imagens s„o constitu¡das",
	 "por pontos (pixel), para armazenar uma matriz de 512x512",
	 "!",
         "",
	 "era necess rio uma mem¢ria de 0.5 Mbytes (se cada pixel",
	 "for quantificado numa escala de 256 n¡veis de cinzento).",
	 "",
	 "Para reduzir a mem¢ria necess ria, utilizam-se muitas",
	 "t‚cnicas de binariza‡„o (thresholding), como por exemplo:",
	 "a detec‡„o de contornos."
    };

    tutorial("2.7- Vis„o para Robots", 29, text, 0);

    putimage(400, 260, buffer, 1);
    espera_tecla(WHITE, "Qualquer tecla para TERMINAR");
}



void robot(void)
{
    unsigned size;

    /* tronco */
    setfillstyle(SOLID_FILL, 11);
    bar(90, 100, 190, 160);
    setfillstyle(SOLID_FILL, 8);
    bar(100, 140, 180, 150);
    setcolor(7);
    pieslice(140, 130, 0, 180, 20);

    /* cabe‡a*/
    setfillstyle(SOLID_FILL, 7);
    bar(110, 60, 170, 100);
    setfillstyle(SOLID_FILL, 8);
    pieslice(125, 75, 0, 360, 8);
    pieslice(155, 75, 0, 360, 8);
    bar(120, 90, 160, 95);

    /*pernas*/
    setcolor(0);
    setfillstyle(SOLID_FILL, 9);
    bar(110, 160, 130, 180);
    setfillstyle(SOLID_FILL, 11);
    bar(105, 180, 135, 200);
    setfillstyle(SOLID_FILL, 9);
    bar(110, 200, 130, 220);
    pieslice(120, 220, 0, 360, 10);

    setfillstyle(SOLID_FILL, 9);
    bar(150, 160, 170, 180);
    setfillstyle(SOLID_FILL, 11);
    bar(145, 180, 175, 200);
    setfillstyle(SOLID_FILL, 9);
    bar(150, 200, 170, 220);
    pieslice(160, 220, 0, 360, 10);

    /* bra‡os */
    setfillstyle(SOLID_FILL, 7);
    bar(190, 110, 200, 120);
    bar(205, 100, 215, 180);
    setfillstyle(SOLID_FILL, 9);
    bar(200, 100, 215, 170);

    setfillstyle(SOLID_FILL, 7);
    bar(80, 110, 90, 120);
    bar(65, 100, 75, 180);
    setfillstyle(SOLID_FILL, 9);
    bar(65, 100, 80, 170);

    size = imagesize(60, 60, 240, 240);
    buffer = malloc(size);
    getimage(60, 60, 240, 240, buffer);
    if(buffer == NULL)
	 exit(0);
    clearviewport();
}

main(void)
{
    int gd, gm;


    fonte = installuserfont("ALTE.CHR");

    if(registerbgidriver(EGAVGA_driver) < 0){
	 printf("\nERRO [1]");
	 return -1;
    }
    if(registerbgifont(alte_fonte) < 0){
	 printf("\nERRO [2]");
	 return -2;
    }
    if(registerbgifont(gothic_font) < 0){
	 printf("\nERRO [3]");
	 return -3;
    }

    gd = VGA;
    gm = VGAHI;
    initgraph(&gd, &gm, "");


    /* background*/
    setcolor(WHITE);
    rectangle(0, 0, 639, 479);
    robot();
    settextstyle(GOTHIC_FONT, HORIZ_DIR, 7);
    escreve("Fabrico Assistido", 90, WHITE);
    escreve("por Computador", 180, WHITE);
    settextstyle(fonte, HORIZ_DIR, 3);
    escreve("Raquel Ferreira", 360, LIGHTGRAY);
    espera_tecla(DARKGRAY, "Qualquer tecla para continuar. . .");


    settextstyle(fonte, HORIZ_DIR, 6);
    clearviewport();
    escreve("Controle Num‚rico", 60, WHITE);
    settextstyle(fonte, HORIZ_DIR, 4);
    setcolor(LIGHTGRAY);
    outtextxy(80, 160, "Sum rio:");
    settextstyle(fonte, HORIZ_DIR, 2);
    setcolor(WHITE);
    outtextxy(80, 180+25*1, "1.1- Conceitos Introdut¢rios");
    outtextxy(80, 180+25*2, "1.2- Dispositivos de Posicionamento");
    outtextxy(80, 180+25*3, "1.3- Dispositivos de Accionamento");
    outtextxy(80, 180+25*4, "1.4- Programa‡„o para Controle Num‚rico");
    espera_tecla(LIGHTGRAY, "Qualquer tecla para continuar. . .");

    cn_con_int();
    cn_dis_pos();
    cn_dis_acc();
    cn_pro_cn();


    settextstyle(fonte, HORIZ_DIR, 6);
    clearviewport();
    escreve("Rob¢tica Industrial", 60, WHITE);
    settextstyle(fonte, HORIZ_DIR, 4);
    setcolor(LIGHTGRAY);
    outtextxy(80, 160, "Sum rio:");
    settextstyle(fonte, HORIZ_DIR, 2);
    setcolor(WHITE);
    outtextxy(80, 180+25*1, "2.1- Conceitos Introdut¢rios");
    outtextxy(80, 180+25*2, "2.2- Caracter¡sticas");
    outtextxy(80, 180+25*3, "2.3- Configura‡„o Mecƒnica");
    outtextxy(80, 180+25*4, "2.4- Programa‡„o de Robots");
    outtextxy(80, 180+25*5, "2.5- ¢rg„os Terminais");
    outtextxy(80, 180+25*6, "2.6- Equipamento Perif‚rico");
    outtextxy(80, 180+25*7, "2.7- Vis„o para Robots");
    espera_tecla(LIGHTGRAY, "Qualquer tecla para continuar. . .");

    ri_con_int();
    ri_car();
    ri_conf_mec();
    ri_pro_rob();
    ri_org_ter();
    ri_equ_per();
    ri_vis_rob();

    /* fim */

    closegraph();

    return 0;
}
