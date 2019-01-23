{°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°
 °±²ÛÛ²±°                                                        °±²ÛÛ²±°
 °±²ÛÛ²±°   V  ÛÛÛÛÛÛ¿      ÛÛÛÛÛÛ¿      ÛÛ¿         ÛÛÛÛÛÛ¿  S  °±²ÛÛ²±°
 °±²ÛÛ²±°   L  ÛÛÚÄÄÄÙ      ÛÛ³ ÛÛ³      ÛÛ³         ÛÛÚÄÄÄÙ  O  °±²ÛÛ²±°
 °±²ÛÛ²±°   A  ÛÛ³          ÛÛÛÛÛÛ³      ÛÛ³         ÛÛ³      F  °±²ÛÛ²±°
 °±²ÛÛ²±°   D  ÛÛ³          ÛÛ³ ÛÛ³      ÛÛ³         ÛÛ³      T  °±²ÛÛ²±°
 °±²ÛÛ²±°      ÛÛÛÛÛÛ¿      ÛÛ³ ÛÛ³      ÛÛÛÛÛÛ¿     ÛÛÛÛÛÛ¿     °±²ÛÛ²±°
 °±²ÛÛ²±°      ÀÄÄÄÄÄÙ      ÀÄÙ ÀÄÙ      ÀÄÄÄÄÄÙ     ÀÄÄÄÄÄÙ     °±²ÛÛ²±°
 °±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°°±²ÛÛ²±°

 Legenda     :

             -------  Titulo  -------- : O Pr¢prio o indica;
             ° bl ,bl ,bl ,bl ,bl ... °: RESUMO do que faz o procedimento ou
                                          fun‡Æo;

 Programador : Vladimiro Cola‡o
               Rua de Algares, n§6
               7600 ALJUSTREL
               tlf: (084)-62213

 Linguagem
 Utilizada   : PASCAL 6.0
}

PROGRAM CalCulaDora;

USES CRT,GRAPH,MOUSEU,DOS;

CONST _ = FALSE;       {ú utilizada no REPEAT UNTIL _; para executar um ciclo
                          infinito }

{--------------------------- Vari…veis GLOBAIS ----------------------------}

VAR

  visor                {ú String do que aparece no visor da calculadora }
        :string;
  limpar,              {ú TRUE se deseja limpar o visor                 }
  FApagaStrVis,        {ú TRUE se deseja apagar a string do Visor       }
  FBotaoNums,          {ú TRUE se um numero (0.1234567890) foi pressionado }
  Fpot,                {ú TRUE se o botao Potˆncia (Xn) foi press.      }
  FFix,                {ú TRUE se o botÆo FIX foi Pressionado           }
  FixONOFF,            {ú TRUE se a fun‡Æo de fixar os valores foi
                          escolhida no menu Op‡äes }
  FResolvente,         {ú TRUE se o botÆo FR foi Pressionado            }
  R2                   {ú TRUE se existe mais que uma raiz na F.Resolvente }
       :Boolean;
  erro                 {ú Usado na valida‡Æo de vari veis               }
       :integer;
  ANS,                 {ú Mem¢ria de resposta, do £ltimo valor apresentado
                          pelo visor (do inglˆs (ANS)wer)               }
  XPot,                {. Guarda o Valor da Base de (X^n)               }
  Afr,                 {. Valor de (A) na F.Resolvente                  }
  Bfr,                 {. Valor de (B) na F.Resolvente                  }
  Cfr,                 {. Valor de (C) na F.Resolvente                  }
  raiz1,               {. Valor da 1¦raiz na F.Resolvente               }
  raiz2,               {. Valor da 2¦raiz na F.Resolvente               }
  delta,               {. Valor do Delta=(bý-4a*c) na F.Resolvente      }
  MEM                  {ú Mem¢ria da calculadora (M+,M-)                }
        :Real;
  OPER                 {ú Indica o operador a ser utilizado ('*','/','-','+')}
        :char;
  FIX,                 {ú Valor do n§ de casas decimais a arredondar    }
  ContOPER,            {ú Conta as vezes que um operador qualquer (/*+-)
                         foi utilizado                                  }
  ContFR               {ú guarda o valor de (1,2 ou 3) que indica ao
                          computador, se valores de A,B ou C j  foram ou nÆo
                          todos introduzidos (se j  ContFR=3) na formula Resolvente }
          :Byte;
  P                    {ú Vari vel do tipo apontador utilizada para guardar
                          imagens gr ficas }
          :pointer;



{----------------------------- VµRIOS -------------------------------}

{° ú Converte Graus para Radianos°}

FUNCTION Graus_Rads(x:REAL):REAL;
BEGIN
        {  necess rio para a funcÆo SIN(x) e COS(x) que utilizam radianos .
          O PI e uma constante Pr‚-defenida pelo Pascal , que ‚ o tal,
          ô = 3,141592654 mais conhecido pelo 3,14 }
  Graus_Rads:=(x*PI)/180;
END;

{° ú Retorna o valor l¢gico 'TRUE' se o RATO se posicionar numa dada area °}

FUNCTION PosRato( X,Y,C,L:integer):Boolean;
                { Posicao(X) + (C)omprimento, Posi‡Æo(Y) + (L)argura.     }

BEGIN
  if (MouseX>x) and (MouseX<(x+C)) and (MouseY>y) and (MouseY<(y+L)) then
  PosRato:=TRUE Else PosRato:=FALSE;
END;

{° ú Retira os zeros de um 'string', que nÆo sÆo necess rios, … esquerda
   ú Caso Pergunte (entÆo e … direita), uma simples valida‡Æo da
     'string' usada no visor resolve o problema. °}

PROCEDURE RetiraZeros(VAR s:string);
VAR CONT:INTEGER;
    Flag:boolean;
BEGIN
  Flag:=FALSE;
  cont:=length(s);
  While not Flag do
  begin
    if s[cont]='0' then delete(s,cont,1);
    if s[cont-1]<>'0' then Flag:=TRUE;
    dec(cont);
  end;
END;

{------------------ LINKAGENS de FONTES e PLACA GRµFICA ------------------}

{° Estes 4 "mini-procedimentos" sÆo utilizados para "linkar" os
   ficheiros '*.OBJ', para juntar as Fontes(*.CHR) e o driver
   (EGAVGA.BGI) ao execut vel(CALC.EXE). Para mais informa‡äes dˆ
   uma olhada no 'BGILINK.PAS' no direct¢rio '\BGI' do seu Pascal °}

PROCEDURE SansSherif; external;
  {$L SANS.OBJ }

PROCEDURE littleFont; external;
  {$L LITT.OBJ }

PROCEDURE triplex; external;
  {$L TRIP.OBJ }

PROCEDURE Driver; external;
  {$L EGAVGA.OBJ }

{° ú Aborta o programa, se algum erro for detectado na inicializa‡Æo
    da Placa Gr fica °}

PROCEDURE Abort(Msg : string);
begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;


{------------------------------ SONS --------------------------------------}

{° ú Produzem sons de Aviso °}

PROCEDURE som;
VAR n:integer;
BEGIN
  sound(2000);
  delay(3);
  nosound;
END;

PROCEDURE som2;
VAR n:integer;
BEGIN
  sound(200);
  delay(3);
  nosound;
END;

{--------------------  PROCEDIMENTOS GRAFICOS -----------------------------}

{° ú Procura os objectos(*.OBJ) linkados e regista-os
   ú Detecta a Placa Gr fica, e inicializa os gr ficos °}

PROCEDURE IniciaGraficos;
VAR
  grm,grd:integer;
BEGIN
     { As vari veis seguidas da arroba (salvo seja o nome para o simbolo '@'),
       sÆo designam o nome do 'Public Name' do seu objecto (*.OBJ) linkado.
       Para mais informa‡äes sobre a "linkagem" das fontes e drivers ver o
       programa exemplo 'BGILINK.PAS' da directoria '\BGI' do Pascal }
  if RegisterBGIdriver(@driver)   < 0 then   ABORT('DRIVER');
  if RegisterBGIfont(@SansSherif) < 0 then   Abort('SansSerif');
  if RegisterBGIfont(@LittleFont) < 0 then   Abort('LittleFont');
  if RegisterBGIfont(@triplex)    < 0 then   Abort('Triplex');
  grm:=detect;
  initgraph(grm,grd,'');
END;

{°  ú Limpa o visor da calculadora °}

PROCEDURE LimpaVisor;
BEGIN
  EscondeRato;
  Setfillstyle(1,darkgray);
  bar(360,65,427,107);{limpa o visor}
  MostraRato;
END;

{° ú Desenha uma Janela, com os limites em relevo °}

PROCEDURE Faz_Janela (x1,y1,            x2,y2,           cor:INTEGER);
                     {Canto Sup. Esq.,  Canto Inf. Dir,  Cor de Fundo}
BEGIN
  setfillstyle(1,cor);
  Bar(x1,y1,x2,y2);
  setcolor(DarkGray);
  rectangle(x1,y1,x2,y2);
  rectangle(x1+2,y1+2,x2-2,y2-2);
  rectangle(x1+3,y1+3,x2-2,y2-2);
  setcolor(white);
  rectangle(x1+1,y1+1,x2-1,y2-1);
END;

{° ú Captura uma imagem ,
                          utilizando uma vari vel 'P' do tipo 'Pointer'
                          passada por Referˆncia (pelo adere‡o de mem¢ria). °}

PROCEDURE CapturaImagem(x1,y1,            x2,y2:integer   ;VAR P:pointer);
                        {Canto Sup. esq., Canto Inf. dir,  Apontador}
BEGIN
  Getmem(P,imagesize(x1,y1,x2,y2));
  Getimage(x1,y1,x2,y2,P^);
END;

{°  ú Desenha um botÆo cinzento com relevo °}

PROCEDURE Desenha_Botao (x1,y1,C,L:INTEGER;s:STRING;B:Boolean);
                { Posicao(X) + (C)omprimento, Posi‡Æo(Y) + (L)argura.     }

VAR
CentroX,CentroY,x2,y2:integer;
BEGIN
  x2:=x1+C;
  y2:=y1+L;
  CentroY:= round(y1+((y2-y1)/2));
  CentroX:= round(x1+(x2-x1)/2)+1;
  setfillstyle(1,lightgray);
  bar(x1-1,y1-1,x2+1,y2+1);
  if not B then
  Begin
    {Topo}
    setcolor(white);
    line(x1+1,y1+1,x2-1,y1+1);
    { Esquerda}
    line(x1+1,y1+1,x1+1,y2-1);
    {Direita}
    setcolor(darkgray);
    line(x2-1,y1+1,x2-1,y2-1);
    line(x2-2,y1+2,x2-2,y2-2);
    {Base}
    line(x2-1,y2-1,x1+1,y2-1);
    line(x2-2,y2-2,x1+2,y2-2);
    setcolor(lightgray);
    line(x2-3,y2-3,x2-1,y2-1);
  End;
  If B Then
  Begin
    bar(x1-1,y1-1,x2+1,y2+1);
    setcolor(white);
    rectangle(x1+2,y1+2,x2-2,y2-2);
    setcolor(DarkGray);
    line(x1+2,y1+2,x2-2,y1+2);
    line(x1+2,y1+2,x1+2,y2-2);
  End;
  setcolor(DarkGray);
  SetTextJustify(CenterText,CenterText);
  settextstyle(SmallFont,HorizDir,6);
  if not(b) then outtextXY(CentroX,CentroY-3,s) else
  outtextXY(CentroX+1,CentroY-2,s)
END;

{° ú Faz o efeito de pressionar os Botäes °}

PROCEDURE PiscaBotao(x1,y1,C,L:integer;s:STRING);
VAR x,y:integer;
BEGIN
  escondeRato;
  Desenha_botao(x1,y1,C,L,s,TRUE);
  x:=mouseX;y:=MouseY;
  while EsqRato do;
  ColocaRatoXY(X,Y);
  Desenha_botao(x1,y1,C,L,s,FALSE);
  MostraRAto;
END;

{° ú Dezenha o simbolo da Raiz Quadrada °}

PROCEDURE Desenha_Raiz(x,y:INTEGER);
BEGIN
  MoveTo(X,Y);
  lineTo(x+2,y);
  lineTo(x+7,y+8);
  lineto(x+10,y-8);
  lineTo(x+18,y-8);
END;

{° ú Faz o efeito de pressionar o BotÆo da Raiz Quadrada °}

PROCEDURE PiscaBotaoRaiz;
VAR x,y:integer;
BEGIN
  escondeRato;
  Desenha_botao(345,220,40,30,'x',TRUE);
  Desenha_Raiz(350+1,235+1);
  x:=mouseX;y:=MouseY;
  while EsqRato do;
  ColocaRatoXY(X,Y);
  Desenha_botao(345,220,40,30,'x',FALSE);
  Desenha_Raiz(350,235);
  MostraRAto;
  Som;
END;

{° ú Desenha o fundo do ecrƒn
   ú Desenha o corpo da Calculadora, o visor, e os botäes
   ú Desenha o MENU
   ú Coloca o Cursor do Rato em Forma de MÆo°}

PROCEDURE TELAINICIAL;
BEGIN
  EscondeRato;
  SetFillStyle(5,blue);
  FloodFill(1,1,blue);
                                {Calculadora}
  settextStyle(TriplexFont,HorizDir,3);
  SetTextJustify(CenterText,Toptext);
  Faz_Janela(170+15,5+15,470+15,40+15,black);
  Faz_Janela(170,5,470,40,blue);
  setcolor(cyan);
  OutTextXY(322,7,'CALCULADORA');
  Faz_Janela(490+15,410+15,590+15,440+15,black);
  Faz_Janela(490,410,590,440,blue);
  setcolor(lightblue);
  SetTextJustify(LeftText,Toptext);
  settextStyle(TriplexFont,HorizDir,2);
  outtextXY(500,410,'VladSoft');
  {Corpo Da Calculadora}
  Faz_Janela(180+15,45+15,460+15,440+15,black);
  Faz_Janela(180,45,460,440,lightgray);
                                {1¦ Fila}
  Desenha_botao(210,395,40,30,'0',FALSE);
  Desenha_botao(255,395,40,30,'.',FALSE);
  Desenha_botao(300,395,40,30,'EXP',FALSE);
  Desenha_botao(345,395,85,30,'EXECUTA',FALSE);
                                {2¦ Fila}
  Desenha_botao(210,360,40,30,'1',FALSE);
  Desenha_botao(255,360,40,30,'2',FALSE);
  Desenha_botao(300,360,40,30,'3',FALSE);
  Desenha_botao(345,360,40,30,'+',FALSE);
  Desenha_botao(390,360,40,30,'-',FALSE);
                               {3¦ Fila}
  Desenha_botao(210,325,40,30,'4',FALSE);
  Desenha_botao(255,325,40,30,'5',FALSE);
  Desenha_botao(300,325,40,30,'6',FALSE);
  Desenha_botao(345,325,40,30,'*',FALSE);
  Desenha_botao(390,325,40,30,'/',FALSE);
                               {4¦ Fila}
  Desenha_botao(210,290,40,30,'7',FALSE);
  Desenha_botao(255,290,40,30,'8',FALSE);
  Desenha_botao(300,290,40,30,'9',FALSE);
  Desenha_botao(345,290,40,30,'DEL',FALSE);
  Desenha_botao(390,290,40,30,'AC',FALSE);
                               {5¦ Fila}
  Desenha_botao(210,255,40,30,'(-)',FALSE);
  Desenha_botao(255,255,40,30,'Sen',FALSE);
  Desenha_botao(300,255,40,30,'Cos',FALSE);
  Desenha_botao(345,255,40,30,'Tg',FALSE);
  Desenha_botao(390,255,40,30,'FR',FALSE);
                               {6¦ Fila}
  Desenha_botao(210,220,40,30,'X^2',FALSE);{X elevado a 2}
  Desenha_botao(255,220,40,30,'X^n',FALSE);{X elevado a (n)}
  Desenha_botao(300,220,40,30,'1/X',FALSE);{inverso de X}
  Desenha_botao(345,220,40,30,'x',FALSE);{ Raiz Quadrada }
  Desenha_botao(390,220,40,30,'FIX',FALSE);
                               {7§ Fila}
  Desenha_botao(210,185,40,30,'M+',FALSE);
  Desenha_botao(255,185,40,30,'M-',FALSE);
                                 {Caracteres Min£sculos e simbolo da Raiz}
  setcolor(darkgray);
  SetTextStyle(smallFont,HorizDir,4);
  Desenha_Raiz(350,235);{Desenha o simbolo da Raiz Quadr tica}
                                 {Visor}
  Faz_Janela(210,60,430,110,darkgray);
  SetGraphicsCursor(PointingHandCurs); { Muda o aspecto do Rato }
  ColocaRatoXY(210,435);
  MostraRato;
END;

{° ú Coloca uma imagem, em forma de 'V',
     utilizada no menu OPCOES para as escolhas das mesma °}

PROCEDURE MenuFix;
TYPE imagem=array[1..8,1..8] of byte;
CONST Matriz:imagem = ((15,15,15,15,15,15,15,15),  { Os numeros dentro da   }
                      ( 15,15,15,15,15,15,15,1 ),  { matriz, indicam a cor  }
                      ( 15,15,15,15,15,15,1 ,1 ),  { de cada pixel. Nota-se }
                      ( 15,15,15,15,15,1 ,1 ,15),  { perfeitamente a forma  }
                      ( 1 ,15,15,15,1 ,1 ,15,15),  { pretendida .}
                      ( 1 ,1 ,15,1 ,1 ,15,15,15),
                      ( 15,1 ,1 ,1 ,15,15,15,15),
                      ( 15,15,1 ,15,15,15,15,15));

VAR
     n,m:byte;
BEGIN
  EscondeRato;
  outtextxy(190,60,'Fix ON  ');
  outtextxy(190,80,'Fix OFF ');
  setfillstyle(1,white);
  if FixONOFF then
  begin
    bar(240,80,249,89);   {limpa o certo do fix off}
              { com a ajuda da matriz, coloca o simbolo pixel a pixel }
    For n:=1 to 8 do For m:=1 to 8 do PutPixel(240+m,60+n,matriz[n,m]);
  end
  else
  begin
    bar(240,60,249,69);     {limpa o certo do fix on}
    For n:=1 to 8 do For m:=1 to 8 do PutPixel(240+m,80+n,matriz[n,m]);
  end;
  MostraRato;
END;

{--------------------- MENUS (OPCOES, SAIR) ----------------------------}

{° ú  Controla os aspectos gr ficos relacionados com o menu,
      e as suas fun‡äes °}

PROCEDURE Menu;

VAR
  x,y       :integer;
  INDicador :byte;     { Esta vari vel tem os valores (0,1,2), em que se }
  P         :pointer;  { indicador=0 o rato nÆo est  posicionado em nenhum }
                       { Menu . Caso esteja, o valor varia entre 1 ou 2 .}

BEGIN
  EscondeRato;
  SetfillStyle(1,blue);
  bar(172,7,468,38);
  SetTextjustify(Lefttext,toptext);
  Settextstyle(triplexfont,horizdir,1);
  setcolor(yellow);
  outtextXY(190,10,'Opcoes');
  outtextXY(290,10,'Sair');
  MostraRato;
  indicador:=0;
  while MouseY<38 do
  begin
    GetButtonStatus;
    While PosRato(180,10,80,25) do
    begin
      if indicador<>1 then
      begin
        setfillstyle(1,magenta);
        EscondeRAto;
        Bar(180,10,260,35);
        outtextXY(190,10,'Opcoes');
        if not indicador=0 then
        begin
          setfillstyle(1,blue);
          Bar(280,10,357,35);
          outtextXY(290,10,'Sair');
        end;
        MostraRAto;
        indicador:=1;
      end;
      if EsqRato then
      begin
        EscondeRato;
        CapturaImagem(180,40,260,110,P);
        SetFillstyle(1,white);
        Faz_Janela(180,40,260,110,white);
        MostraRato;
        settextstyle(smallfont,horizdir,4);
        setcolor(black);
        MenuFix;
        { Enquanto dentro da Janela (OPCOES) }
        While PosRato(180,10,80,100) do
        begin
          if EsqRato then
          begin
            if PosRato(190,60,60,10) then {fix on}
            begin
              FixONOFF:=TRUE;
              MenuFix;  { Coloca o (V) conforme o valor de FixOnOff }
            end;
            if PosRato(190,80,60,10) then {fix off}
            begin
              FixONOFF:=FALSE;
              MenuFix;
            end;
          end;
        end;
        EscondeRato;
        x:=MouseX;y:=MouseY;
        colocaRatoXY(x,y);
        PutImage(180,40,P^,NormalPut);
        MostraRato;
        Freemem(P,imageSize(180,40,260,110));
        Settextstyle(triplexfont,horizdir,1);
        setcolor(yellow);
      end; {if EsqRato}
    end; {fim de while}
    While PosRato(280,10,80,25) do
    begin
      if indicador<>2 then
      begin
        EscondeRAto;
        setfillstyle(1,magenta);
        Bar(280,10,357,35);
        outtextXY(290,10,'Sair');
        if not indicador=0 then
        begin
          setfillstyle(1,blue);
          Bar(180,10,260,35);
          outtextXY(190,10,'Opcoes');
        end;
        MostraRAto;
        indicador:=2;
      end;
      if EsqRato then
      begin
        Closegraph;
        halt;
      end;
    end; {fim de while do}
    if indicador>0 then
    begin
      EscondeRato;
      if indicador=1 then
      begin
        setfillstyle(1,blue);
        Bar(180,10,260,35);
        outtextXY(190,10,'Opcoes');
      end
      Else {=2}
      begin
        setfillstyle(1,blue);
        Bar(280,10,357,35);
        outtextXY(290,10,'Sair');
      end;
      MostraRato;
      indicador:=0
    end;{fim de if}
  end;{fim de While MouseX}
  EscondeRato;
  bar(172,7,468,38);
  settextStyle(TriplexFont,HorizDir,3);
  SetTextJustify(CenterText,TopText);
  setfillstyle(1,blue);
  setcolor(Cyan);
  OutTextXY(322,7,'CALCULADORA');
  MostraRato;
END;

{°  Este Procedimento ‚ muito importante nesse programa, sendo tamb‚m
    por isso dif¡cil de explicar, como pode reparar.
    Execute ‚ chamado quando o botÆo 'EXECUTA' ‚ pressionado, quando
    se quer executar uma opera‡Æo qualquer (a+b,a/b,...), ou entrar
    um valor (por ex: na F.Resolvente). Note-se que Este Procedimento tem
    muitas estructuras IF, e que as suas condi‡oes sÆo (exepto uma) Vari veis
    booleanas. O procedimento parece confuso por causa disso mesmo, mas tudo
    ‚ Controlado e nÆo se d  ao caso de mais que uma Vari vel Booleana ser
    verdadeira. Cada vez que o botao 'EXECUTA' ‚ pressi. s¢ a opera‡Æo que
    est  a decorrer ‚ que ‚ executada. Depois da mesma executada a vari vel
    booleana a ela ligada (ex: FResolvente,Fpot) ‚ colocada a FALSE .
    Este procedimento trabalha com vari veis Globais, ou seja que
    podem ser utilizadas em qualquer procedimento ou fun‡Æo porque foram
    definidas nas declara‡äes de Vari veis do programa principal. Sendo
    por isso possivel durante o 'correr' do programa, 'saltar' para fora
    do proced. sem que os valores das vari veis se percam, para esperar
    um novo valor para a opera‡Æo ou qualquer outra ac‡Æo do utilizador.
    Exemplo:
        BotÆo Pressionado           Opera‡ao

        5   .  .  .  .  .  .  .  .  þ ú visor:='5'( Mostra o 5 );
                                      ú FBotaoNums:=TRUE;
        +   .  .  .  .  .  .  .  .  þ ú Guarda 1§ o valor 5 em ANS
                                        ( Val(visor,ANS,erro) );
                                      ú ContOper:=1;
                                      ú Oper:='+';
                                      ú FBotaoNums:=FALSE;
        6   .  .  .  .  .  .  .  .  þ ú visor:='6'( Mostra o 6 );
                                      ú FBotaoNums:=TRUE;
        EXECUTA   .  .  .  .  .  .  þ ú Verifica se ContOper=1;
                                      ú Verifica FBotaoNums:=TRUE (se foi
                                        anterior. carregado um n£mero);
                                      ú Verifica qual a opera‡Æo pretendida
                                        com o 1§ e 2§ numero (n.c. oper:='+');
                                      ú Verifica se o resultado est  dentro
                                        do limites (-1E19 < res < 1E19);
                                      ú Efectua a opera‡ao (ANS+R), em que
                                        neste Caso R=6 e ANS=5; .°}

PROCEDURE EXECUTA;

VAR
  R,valor  :real;
  erro,i,n :integer;
  feito    :boolean;
  s        :string;
BEGIN
  Val(Visor,R,erro);
  if R2 then  { Se houver a 2¦ raiz depois de ter sido apresentada a }
  begin       { 1¦ Raiz da Formula Resolvente                             }
    limpaVisor;
    str(raiz2:0:FIX,visor);
    retiraZeros(visor);
    visor:='X= '+visor;
    ANS:=0;
    R2:=FALSE;
    exit
  end;
  if FResolvente then { Se a Formula Resolvente estiver a decorrer }
  begin
    inc(contFR);      { Ver 'Vari veis Globais' }
    CASE contFR of
      1:
      begin
        Afr:=R;
        visor:='b?';
        exit  { sai deste procedimento, para, no programa principal }
      end;    { esperar que o utilizador introduza o valor de B     }
      2:
      begin
        Bfr:=R;
        visor:='c?';
        exit
      end;
      3:
      begin
        Fresolvente:=FALSE;
        Cfr:=R;
        delta:=sqr(bfr)-4*afr*cfr;
        if (Afr=0) and (Bfr=0) and (Cfr=0) then
        begin
          som2;
          limpaVisor;
          visor:='Equa‡ao verdadeira';
          ANS:=0;
          exit;
        end;
        if (Afr=0) and (Bfr=0) then
        begin
          som2;
          limpaVisor;
          visor:='Equa‡ao impossivel';
          ANS:=0;
          exit;
        end;
        if Afr=0 then
        begin
          raiz1:=-Cfr/Bfr;
          str(raiz1:0:FIX,visor);
          retiraZeros(visor);
          visor:='X= '+visor;
          ANS:=0;
          exit
        end;
        if delta>0 then
        begin  { Apresenta as Raizes }
          raiz1:=(-bfr+sqrt(delta))/(2*afr);
          raiz2:=(-bfr-sqrt(delta))/(2*afr);
          limpaVisor;
          str(raiz1:0:FIX,visor);
          retiraZeros(visor);
          visor:='X= '+visor+' ou';
          setColor(lightgray);
          SetTextJustify(rightText,centerText);
          SetTextStyle(smallFont,HorizDir,4);
          outtextXY(420,80,'EXE');
          R2:=TRUE; { Colocou R2 a TRUE .Depois sai do procedimento e espera}
          ANS:=0;   { que volte a carregar em 'EXECUTA'. Da¡ como R2 ‚ verdadeiro }
          exit      { vai apresentar a 2¦ raiz .}
        end;
        if delta<0 then
        begin
          som2;
          LimpaVisor;
          visor:='Raizes imaginarias';
          ANS:=0;
          exit
        end;
        if delta=0 then
        begin
          raiz1:=-bfr/(2*afr);
          raiz2:=raiz1;
          limpaVisor;
          str(raiz1:0:FIX,visor);
          retiraZeros(visor);
          visor:='X= '+visor;
          ANS:=0;
          exit
        end;
      end;
    end;
  end;
  If FPot then
  Begin
    val(Visor,i,erro);
    Fpot:=FALSE;
    limpaVisor;
    valor:=1;
    feito:=TRUE;
    n:=0;
    repeat
      inc(n);
      if (Valor*xPot>-1e19) and (valor*xpot<1e19) then Valor:=Valor*XPot
      else feito:=FALSE;
    until not(feito) or (n=Abs(i)) or (i=0); {ú Multiplica o Xpot por si mesmo o }
    if i=0 then                              {  n§ de vezes igual ao seu expoente }
    begin
      Valor:=1;
      Feito:=TRUE
    end;
    if feito then
    begin
      if i<0 Then Valor:=1/Valor;
      if FixONOFF then str(Valor:0:FIX,visor) else str(Valor:0,visor);
    end
    else
    begin
      visor:='Al‚m do Limite';
      ANS:=0;
      exit
    end;
    RetiraZeros(visor);
    exit
  End;
  If FFix then
  begin
    FFix:=FALSE;
    val(Visor,i,erro);
    limpaVisor;
    visor:='';
    if (i>=0) and (i<=12) then FIX:=i else
    begin
      ANS:=0;
      FFix:=FALSE;
      visor:='Fix de 1 a 12';
    end;
    exit { Sai para esperar pela entrada do valor de FIX }
  end;
 { Caso nao se tenha press. um operador, a resposta ‚ a mesma do visor }
  if (ContOper=0) then ANS:=R;
  { se se efectuou uma opera‡ao correcta (N§ | operador | N§) ir  proceder
    ao seu c lculo }
  if (ContOper=1) and (FBotaoNums) then
  BEGIN
    Case Oper of { Oper ter  o resultado da ultima opera‡Æo }
      '+':
      begin
        if (ANS+R>-1e19) and (ANS+R<1e19) then ANS:=ANS+R else
        begin
          visor:='Al‚m do Limite';
          ANS:=0;
          exit
        end;
      end;
      '-':
      begin
        if (ANS-R>-1e19) and (ANS-R<1e19) then ANS:=ANS-R  else
        begin
          visor:='Al‚m do Limite';
          ANS:=0;
          exit
        end;
      end;
      '/':
      begin
        if (R=0) then
        begin
          if ANS<>0 then visor:='Divisao por zero';
          exit
        end;
        if (ANS/R>-1e19) and (ANS/R<1e19) then ANS:=ANS/R
        else
        begin
          visor:='Al‚m do Limite';
          ANS:=0;
          exit
        end;
      end;
      '*':
      begin
        if (ANS*R>-1e19) and (ANS*R<1e19) then ANS:=ANS*R
        else
        begin
          visor:='Al‚m do Limite';
          ANS:=0;
          exit
        end;
      end;
    end;
  END;
  { Faz os devidos arredondamentos caso requeridos (FixONOFF=TRUE) }
  if FixONOFF then str(ANS:0:FIX,visor) Else str(ANS:0,visor);
  { Retira todos os zeros da 'string' que nÆo fazem falta … esquerda
    porque os da direita sao formatados pelo comando str em cima}
  RetiraZeros(visor);
END;

{--------------------- CORPO PRINCIPAL DO PROGRAMA ----------------------}

BEGIN
  if NOT(MousePresent) then
  begin
    closegraph;
    clrscr;
    textbackground(lightblue);
    textcolor(7);
    writeln('O Programa "CALC.EXE" termina:');
    writeln('O Rato nÆo foi previamente instalado !');
    textbackground(black);
    halt;
  end;
  INiciaGraficos;
  TELAINICIAL;
  { Inicializa‡Æo de vari veis }
  Visor:='';
  MEM:=0;
  ContOper:=0;
  FBotaoNums:=FALSE;
  FPot:=FALSE;
  Limpar:=FALSE;
  FApagaStrVis:=FALSE;
  FixONOFF:=TRUE;
  FResolvente:=FALSE;
  FFix:=FALSE;
  FIX:=8;
  R2:=FALSE;
  setTextStyle(TriplexFont,4,HorizDir);
  SetTextJustify(LeftText,leftText);
  repeat
    { Parte que executa as fun‡äes dos botäes }
    IF EsqRato THEN
    BEGIN
      if PosRato(210,395,40,30) then  {þ 0 þ}
      begin
        PiscaBotao(210,395,40,30,'0');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'0';
      End;
      if PosRato(255,395,40,30) then  {þ . þ}
      begin
        PiscaBotao(255,395,40,30,'.');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'.';
      End;
      if PosRato(300,395,40,30) then   {þ EXP þ}
      begin
        PiscaBotao(300,395,40,30,'EXP');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'E';
      End;
      if PosRato(345,395,85,30) then  {þ EXECUTA þ}
      begin
        PiscaBotao(345,395,85,30,'EXECUTA');
        som;
        { Esta estrutura condicional (IF) ir  emitir um erro de execu‡Æo
          se (ContOper=1) um operador (/*-+) tenha sido anteriormente
          pressionado e nÆo tenha sido escolhido um n§ (Not(FBotaoNums))
          para terminar a opera‡Æo, ou se (FPot) a fun‡Æo potˆncia foi
          accionada, caso isso estaria … espera de um numero para terminar
          a opera‡Æo. Se esse numero nÆo for sido press. d  erro .

        þ (not(FBotaoNums) AND (ContOper=1)) OR (not(FBotaoNums) AND (FPot)) }
          { Pela Propriedade distribuitiva do AND em rela‡Æo ao OR }
        if ((ContOper=1) or (FPot)) AND not(FBotaoNums) then
        begin
          som2;
          limpaVisor;
          visor:='erro de execu‡ao';
          FApagaStrvis:=TRUE;
          FPot:=FALSE;
        end
        else EXECUTA;
        FBotaoNums:=FALSE;
        FApagaStrVis:=TRUE;
        contOper:=0;
      End;
      if PosRato(210,360,40,30) then  {þ 1 þ}
      begin
        PiscaBotao(210,360,40,30,'1');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'1';
      End;
      if PosRato(255,360,40,30) then  {þ 2 þ}
      begin
        PiscaBotao(255,360,40,30,'2');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'2';
      End;
      if PosRato(300,360,40,30) then  {þ 3 þ}
      begin
        PiscaBotao(300,360,40,30,'3');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'3';
      End;
      if PosRato(210,325,40,30) then   {þ 4 þ}
      begin
        PiscaBotao(210,325,40,30,'4');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'4';
      End;
      if PosRato(255,325,40,30) then  {þ 5 þ}
      begin
        PiscaBotao(255,325,40,30,'5');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'5';
      End;
      if PosRato(300,325,40,30) then   {þ 6 þ}
      begin
        PiscaBotao(300,325,40,30,'6');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'6';
      End;
      if PosRato(210,290,40,30) then    {þ 7 þ}
      begin
        PiscaBotao(210,290,40,30,'7');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'7';
      End;
      if PosRato(255,290,40,30) then     {þ 8 þ}
      begin
        PiscaBotao(255,290,40,30,'8');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'8';
      End;
      if PosRato(300,290,40,30) then     {þ 9 þ}
      begin
        PiscaBotao(300,290,40,30,'9');
        som;
        if FApagaStrVis then visor:='';
        FApagaStrVis:=FALSE;
        FBotaoNums:=TRUE;
        visor:=visor+'9';
      End;
      if PosRato(345,360,40,30) then      {þ + þ}
      begin
        PiscaBotao(345,360,40,30,'+');
        som;
        if contOper<2 then inc(contOper);
        case ContOper of
          1:
          begin
            Oper:='+';
            Val(Visor,ANS,erro);
            if FixONOFF then str(ANS:0:FIX,visor) Else str(ANS:0,visor);
            RetiraZeros(visor);
          end;
          2: { Caso 2, ‚ porque o ultimo botÆo a ser press. foi um operador,
               logo emiti um erro }
          begin
            som2;
            visor:='erro de execu‡ao';
            FApagaStrvis:=TRUE;
            ContOper:=0;
          end;
        end;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
      End;
      if PosRato(390,360,40,30) then     {þ - þ}
      begin
        PiscaBotao(390,360,40,30,'-');
        som;
        if contOper<2 then inc(contOper);
        case ContOper of
          1:
          begin
            Oper:='-';
            Val(Visor,ANS,erro);
            if FixONOFF then str(ANS:0:FIX,visor) Else str(ANS:0,visor);
            RetiraZeros(visor);
          end;
          2: { Caso 2, ‚ porque o ultimo botÆo a ser press. foi um operador,
               logo emiti um erro }
          begin
            som2;
            visor:='erro de execu‡ao';
            FApagaStrvis:=TRUE;
            ContOper:=0;
          end;
        end;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
      End;
      if PosRato(345,325,40,30) then      {þ * þ}
      begin
        PiscaBotao(345,325,40,30,'*');
        som;
        if contOper<2 then inc(contOper);
        case ContOper of
          1:
          begin
            Oper:='*';
            Val(Visor,ANS,erro);
            if FixONOFF then str(ANS:0:FIX,visor) Else str(ANS:0,visor);
            RetiraZeros(visor);
          end;
          2:    { Caso 2, ‚ porque o ultimo botÆo a ser press. foi um operador,
                  logo emiti um erro }
          begin
            som2;
            visor:='erro de execu‡ao';
            ContOper:=0;
          end;
        end;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
      End;
      if PosRato(390,325,40,30) then    {þ / þ}
      begin
        PiscaBotao(390,325,40,30,'/');
        som;
        if contOper<2 then inc(contOper);
        case ContOper of
          1:
          begin
            Oper:='/';
            Val(Visor,ANS,erro);
            if FixONOFF then str(ANS:0:FIX,visor) Else str(ANS:0,visor);
            RetiraZeros(visor);
          end;
          2:  { Caso 2, ‚ porque o ultimo botÆo a ser press. foi um operador,
               logo emiti um erro }
          begin
            som2;
            visor:='erro de execu‡ao';
            ContOper:=0;
          end;
        end;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
      End;
      if PosRato(345,290,40,30) then    {þ DEL þ}
      begin
        PiscaBotao(345,290,40,30,'DEL');
        som;
        delete(visor,length(visor),1);
        if length(visor)=0 then FBotaoNums:=FALSE;
      End;
       if PosRato(390,290,40,30) then    {þ AC þ}
      begin
        PiscaBotao(390,290,40,30,'AC');
        som;
        LimpaVisor;
        ANS:=0;
        Fpot:=FALSE;
        FFix:=FALSE;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
        ContOper:=0;
        Fresolvente:=FALSE;
        R2:=FALSE;
        visor:='0.';
      End;
      if PosRato(210,255,40,30) then    {þ (-) þ}
      begin
        PiscaBotao(210,255,40,30,'(-)');
        som;
        If FApagaStrVis Then visor:='';
        FApagaStrVis:=FALSE;
        Visor:=Visor+'-';{ Coloca o sinal negativo }
      end;
      if PosRato(255,255,40,30) then    {þ SEN þ}
      begin
        PiscaBotao(255,255,40,30,'Sen');
        som;
        val(visor,ANS,erro);
        ANS:=Graus_Rads(ANS);
        str(sin(ANS):0:FIX,visor);
        retiraZeros(visor);
        FApagaStrVis:=TRUE;
      end;
      if PosRato(300,255,40,30) then     {þ COS þ}
      begin
        PiscaBotao(300,255,40,30,'Cos');
        som;
        val(visor,ANS,erro);
        ANS:=Graus_Rads(ANS);
        str(Cos(ANS):0:FIX,visor);
        retiraZeros(visor);
        FApagaStrVis:=TRUE;
      end;
      if PosRato(345,255,40,30) then    {þ TG þ}
      begin
        PiscaBotao(345,255,40,30,'Tg');
        som;
        val(visor,ANS,erro);
        ANS:=Graus_Rads(ANS);
        if (cos(ANS)<>0) then str((sin(ANS)/cos(ANS)):0:FIX,visor)
        else
        begin
          som2;
          visor:='Tangente Indefenida';
        end;
        retiraZeros(visor);
        FApagaStrVis:=TRUE;
      end;
      if PosRato(390,255,40,30) then     {þ FR þ}
      begin
        PiscaBotao(390,255,40,30,'FR');
        som;
        LimpaVisor;
        if NOT((FPot) OR (FFix)) then
        begin
          setColor(lightgray);
          SetTextJustify(rightText,centerText);
          SetTextStyle(smallFont,HorizDir,4);
          outtextXY(420,80,'aXý+bX+c=0');
          FResolvente:=TRUE;
          FApagaStrvis:=TRUE;
          ContFR:=0;
          Afr:=0;Bfr:=0;Cfr:=0;
          R2:=FALSE;
          visor:='a?';
        end;
        if (FPot) or (FFix) then
        begin
          som2;
          visor:='erro de execu‡ao';
          FApagaStrvis:=TRUE;
          Fpot:=FALSE;
          FFIX:=FALSE;
        end;
      end;
      if PosRato(210,220,40,30) then     {þ Xý þ}
      begin
        PiscaBotao(210,220,40,30,'X^2');
        som;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
        val(visor,ANS,erro);
        if (ANS*ANS>1e-19) and (ANS*ANS<1e19) or (ANS=0) then
        begin
          if FixONOFF then str(ANS*ANS:0:FIX,visor) else str(ANS*ANS:0,visor);
        end
        else
        begin
          visor:='Al‚m do Limite';
          ANS:=0;
        end;
        RetiraZeros(visor);
      end;
      if PosRato(255,220,40,30) then {þ X^n þ}
      begin
        if not(FFix) and not(Fresolvente) then
        begin
          PiscaBotao(255,220,40,30,'X^n');
          Som;
          FApagaStrVis:=TRUE;
          FBotaoNums:=FALSE;
          FPot:=TRUE;
          Val(visor,XPot,erro);{/* Guarda Valor a ser posteriormente */}
          setColor(lightgray); {/* Utilizado para a Exponencia‡Æo.   */}
          SetTextJustify(rightText,centerText);
          SetTextStyle(smallFont,HorizDir,4);
          outtextXY(420,80,'X');
          SetTextStyle(smallFont,HorizDir,3);
          outtextXY(425,70,'n');
        end;
        if (FFix) or (Fresolvente) then
        begin
          som2;
          ffix:=FALSE;
          FResolvente:=FALSE;
          FApagaStrVis:=TRUE;
          FBotaoNums:=FALSE;
          limpaVisor;
          visor:='Erro de execu‡ao';
        end;
      end;
      if PosRato(300,220,40,30) then    {þ 1/X þ}
      begin
        PiscaBotao(300,220,40,30,'1/X');
        Som;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
        val(visor,ANS,erro);
        if ANS<>0 then
        begin
          if FixONOFF then str((1/ANS):0:FIX,visor) else str((1/ANS):0,visor);
          RetiraZeros(visor);
        end
        ELSE visor:='Divisao por zero';
      end;
      if PosRato(345,220,40,30) then     {þ RAIZ ý þ}
      begin
        PiscaBotaoRaiz;
        FApagaStrVis:=TRUE;
        FBotaoNums:=FALSE;
        val(visor,ANS,erro);
        if ANS>=0 then
        begin
          if FixONOFF then str(SQRT(ANS):0:FIX,visor) else
                                                      str(SQRT(ANS):0,visor);
        end
        Else visor:='Raiz Negativa';
        RetiraZeros(visor);
      end;
      if PosRato(390,220,40,30) then {FIX}
      begin
        PiscaBotao(390,220,40,30,'FIX');
        som;
        if not((Fpot) or (FResolvente)) then
        begin
          FApagaStrVis:=TRUE;
          FFix:=TRUE;
          setColor(lightgray);
          SetTextJustify(RightText,centerText);
          SetTextStyle(smallFont,HorizDir,4);
          outtextXY(420,80,'FIX');
          str(FIX,visor);
        end;
        if (Fpot) or (FResolvente) then
        begin
          som2;
          fpot:=FALSE;
          Fresolvente:=FALSE;
          FApagaStrVis:=TRUE;
          FBotaoNums:=FALSE;
          limpaVisor;
          visor:='Erro de execu‡ao';
        end;
      end;
      if PosRato(210,185,40,30) then     {þ M+ þ}
      begin
        PiscaBotao(210,185,40,30,'M+');
        som;
        val(visor,MEM,erro);
        FApagaStrVis:=TRUE;
      end;
      if PosRato(255,185,40,30) then    {þ M- þ}
      begin
        PiscaBotao(255,185,40,30,'M-');
        som;
        if FixONOFF then str(MEM:0:FIX,visor) else str(MEM,visor);
        retiraZeros(visor);
        FBotaoNums:=TRUE;
        FApagaStrVis:=TRUE;
      end;
      if PosRato(490,410,100,30) then {þ VladSoft þ}
      begin
        EscondeRato;
        CapturaImagem(490,320,590+15,440,P);
        Faz_Janela(490+15,320+15,590+15,440+15,black);
        Faz_Janela(490,320,590,440,blue);
        SetTextJustify(leftText,TopText);
        SetTextStyle(smallFont,HorizDir,4);
        setcolor(lightred);
        outtextXY(495,325,'Programador:');
        setcolor(Yellow);
        outtextXY(495,340,'Vladimiro Cola‡o');
        outtextXY(495,355,'Rua de Algares,');
        outtextXY(495,370,'n§6');
        outtextXY(495,385,'7600 Aljustrel');
        outtextXY(495,400,'Tlf: 084-62213');
        SetTextJustify(LeftText,Toptext);
        settextStyle(TriplexFont,HorizDir,2);
        setcolor(lightblue);
        outtextXY(500,410,'VladSoft');
        MostraRato;
        repeat
        until (EsqRato) and PosRato(490,320,100,120);
        EscondeRato;
        PutImage(490,320,P^,NormalPut);
        MostraRAto;
        Freemem(P,imageSize(490,320,590+15,440));
      end;
      limpar:=TRUE;
    END;{if EsqRato}
    if Mousey<38 then MENU;
    if limpar Then
    Begin
      setfillStyle(1,darkgray);
      EscondeRato;
      bar(214,90,427,107); { preenche o visor da calculadora a cinzento }
      if length(visor)>20 then delete(visor,21,20);
      SetTextJustify(RightText,CenterText);
      settextstyle(SmallFont,HorizDir,6);
      setcolor(lightGray);
      outtextXY(420,95,visor);
      MostraRato;
      limpar:=FALSE;
    End;
  until _; { a Vari…vel '_' ‚ uma Constante Booleana = FALSE. O resultado d 
             um Ciclo INFINITO }

END.
{²²²²°°°°²²²²°°°°²²²²°°°°²²²²°°°°²²²²°°°°²²²²°°°°²²²²°°°°²²²²°°°°²²²²°°°°²²²²}