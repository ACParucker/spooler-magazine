(****************************************************************************)
(***********             @RUI GIL    8/93       *****************************)
(****************************************************************************)
(*  PARA A SPOOLER MAGAZINE.                                                *)
(****************************************************************************)

program Logic;
(* CODIFICACAO DE UM JOGO DE LOGICA BASTANTE CONHECIDO
   CHAMADO MASTER MIND.
   CONSISTE EM ENCONTRAR O CODIGO FORMULADO PELO ADVERSARIO
   (NESTE CASO O COMPUTADOR), ATRAVES DAS PISTAS QUE NOS SAO DADAS
   DURANTE A EXECUCAO.
*)

(* ESTRUTURA:-
MODO GRAFICO - INICIALIZA O MODO GRAFICO
JANELA       - PERMITE DESENHAR JANELAS EM DOIS ESTADOS ON/OFF
APRESENTACAO - CAPA DO PROGRAMA
MOUSE        - UTILIZACAO DO RATO
SHOWMOUSE    - MOSTRA O RATO
HIDEMOUSE    - ESCONDE O RATO
OPCOES       - CONTEM AS CONDICOES NECESSARIAS PARA AS OPCOES (RATO\TECLAS)
MASTERMIND   - O JOGO
     BACKSPCE  - PERMITE CORIGIR UMA COR QUE SE ESCOLHEU
     ENTER     - CONFIRMA A CHAVE ESCOLHIDA E FAZ A LEITURA DELA
     NOVO      - PERMITE RECOMECAR UM NOVO JOGO
     PALETTE   - COLOCA A COR ESCOLHIDA NO SITIO CERTO
     CONFIRMA  - NO CASO DE QUERER SAIR PEDE CONFIRMACAO
     HELP      - UM HELPEZINHO PARA NAO NOS PERDERMOS
PROGRAMA MASTERMIND
FIM_PROGRAMA   - ROTINA DE SAIDA, FECHA O MODO GRAFICO
PROGRAMA PRINCIPAL.
*)


uses linkfont,  (* UNIDADE DE LINKAGEM DAS FONTES  *)
     linkdriv,  (* UNIDADE DE LINKAGEM DOS DRIVERS *)
     crt,      (* ROTINAS DE VIDEO                *)
     graph,    (* UNIDADE DE ROTINAS GRAFICAS     *)
     dos;


type ESTADO = ( ON , OFF );             (* ESTADO DAS JANELAS *)
     CHAVE  = array [1..4] of integer;  (* CODIGO DE 4 CORES  *)



var cursorx, cursory, keys : integer; (* VARIAVEIS DO RATO        *)
    Boldfont,OPCAO:word;              (* FONTE E OPCAO ESCOLHIDA  *)
    TEC:char;                         (* PARA A LEITURA DE TECLAS *)


(* INICIALIZA O MODO GRAFICO AUTO-DETECTADO *)
procedure modographico;
var GRAFDRIVER,
    GRAFMODE   :integer;

    (* ABORTA SE HOUVER ERROS *)
    procedure Abortar(Msg : string);
    begin
      Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
      readln;Halt(1);
    end;

begin
               (* REGISTA OS DRIVERS GRAFICOS DESEJADOS *)
  if RegisterBGIdriver(@EGAVGADriver) < 0 then Abortar('EGA/VGA');
                 (* REGISTA AS FONTES GRAFICAS DESEJADAS *)
  if RegisterBGIfont(@Gothic) < 0 then         Abortar('Gothic');
  if RegisterBGIfont(@Triplex) < 0 then        Abortar('Triplex');
  if RegisterBGIfont(@Bold) < 0 then           Abortar('Bold');
                 (* INICIALIZACAO DO MODO GRAFICO *)
  boldfont:=installuserfont('BOLD');  (* INSTALA UMA FONTE *)
  GRAFDRIVER := Detect;
  InitGraph(GRAFDRIVER,GRAFMODE,'');
  if Graphresult <> grOk then abortar ('ERRO NA INICIALIZAÄAO GRAFICA');
end;


(* DESENHA UMA JANELA. DOIS ESTADOS POSSIVEIS ON\OFF *)
procedure janela(X1,Y1,X2,Y2:integer;TIPO:ESTADO);
var SDIR,IESQ:word;
    N:integer;

begin
  setfillstyle(1,lightgray);bar(X1,Y1,X2,Y2);
  SetLineStyle(SolidLn, 0, normWidth);

       (* OS DOIS ESTADOS POSSIVEIS *)
  if TIPO=ON then begin  SDIR:=white;IESQ:=black; end;
  if TIPO=OFF then begin SDIR:=black;IESQ:=white; end;

  setcolor(SDIR);
  for N:=1 to 6 do    (* 6 LINHAS - CANTO SUPERIOR DIREITO *)
  begin
    line(X1-N,Y2+N,X1-N,Y1-N);line(X1-N,Y1-N,X2+N,Y1-N);
  end;
  setcolor(IESQ);
  for N:=1 to 6 do    (* 6 LINHAS - CANTO INFERIOR ESQUERDO *)
  begin
    line(X2+N,Y1-N,X2+N,Y2+N);line(X2+N,Y2+N,X1-N,Y2+N);
  end;
end;



(* CAPA DO PROGRAMA *)
procedure Apresentacao;
var N,M,X,Y:integer;
    COLOR:word;
    TAMANHO:word;
    FRASE:pointer;

begin

    (* CAPTURA DA FRASE A MOVER *)
    setcolor(yellow);
    outtextxy(200,350,'< SPACE >');
    outtextxy(200,340,'  TECLA  ');
    TAMANHO := ImageSize(200,340,300,360);
    GetMem(FRASE,TAMANHO);
    GetImage(200,340,300,360, FRASE^);
    PutImage(200,340,FRASE^,1);

    (* PADRAO *)
    setfillstyle(11,blue);bar(0,0,640,480);

    (* MOLDURA *)
    setlinestyle(solidln,0,thickwidth);
    setcolor(lightblue);
    line(2,2,638,2);line(638,2,638,478);
    line(638,478,2,478);line(2,478,2,2);
    setcolor(blue);
    line(6,6,634,6);line(634,6,634,474);
    line(634,474,6,474);line(6,474,6,6);

    (* DESENHO DO TITULO *)
    for N:=1 to 10 do
    begin
      setcolor(red);
      settextstyle(gothicfont,horizdir,1);
      setusercharsize(10,1,10,1);
      outtextxy(60+N,N,'L');
      setcolor(blue);
      settextstyle(triplexfont,horizdir,10);
      outtextxy(250+N,150+N,'OGIK');
    end;
    setcolor(yellow);
    settextstyle(gothicfont,horizdir,1);
    setusercharsize(10,1,10,1);
    outtextxy(70,10,'L');
    settextstyle(triplexfont,horizdir,10);
    outtextxy(260,160,'OGIK');
    settextstyle(0,0,1);setcolor(green);
    outtextxy(10,464,'(C) Rui Gil-93');


    (* MOVIMENTO DA FRASE *)
    N:=200;M:=340;
    X:=N;Y:=M;
    repeat
      repeat
        if N=X then X:=random(560);
        if M=Y then Y:=320+random(140);
        putimage(N,M,FRASE^,1);
        delay(50);
        putimage(N,M,FRASE^,1);
        if N<X then N:=N+1 else N:=N-1;
        if M<Y then M:=M+1 else M:=M-1;
      until keypressed;
      TEC:=readkey;
    until TEC=#32;
    freemem(FRASE,TAMANHO); (* LIBERTA A MEMORIA DA FRASE *)

    (* COLOCACAO DO PANO DE FUNDO *)
    setfillstyle(9,blue);
    for N:=0 to 80 do
    begin
      bar (N*4,0,N*4,480);
      bar (640-N*4,0,640-N*4,480);
    end;
    for N:=0 to 80 do
    begin
      bar (320-N*4-1,0,320-N*4,480);
      bar (320+N*4-1,0,320+N*4,480);
    end;
    for N:=0 to 80 do
    begin
      bar (N*4-2,0,N*4,480);
      bar (640-N*4-2,0,640-N*4,480);
    end;
    for N:=0 to 80 do
    begin
      bar (320-N*4-3,0,320-N*4,480);
      bar (320+N*4-3,0,320+N*4,480);
    end;

    (* DESENHO DO QUADRO DAS CORES *)
    janela(320,20,580,160,ON);
    COLOR:=8;
    for N:=0 to 3 do for M:=0 to 1 do
    begin
      X:=340+(60*N);Y:=40+(60*M);
      setfillstyle(1,black);
      bar(X-2,Y-2,X+42,Y+42);
      setfillstyle(1,COLOR);
      bar(X,Y,X+40,Y+40);
      inc(COLOR);
    end;

    (* DESENHO DO QUADRO DAS OPCOES *)
    janela(320,180,580,280,ON);
    janela(340,190,430,220,ON);
    janela(470,190,560,220,ON);
    janela(340,240,430,270,ON);
    janela(470,240,560,270,ON);
    settextstyle(Boldfont,horizdir,1);
    outtextxy(360,180,'<<<');
    outtextxy(500,180,'[=]');
    outtextxy(490,230,'EXIT');
end;

(* RATO. CURSORX,CURSORY:COORDENADAS. KEYS:TECLAS *)
Procedure Mouse;
var  r : registers;

begin
   with r do
   begin
     ax := 3;
     intr($33,r);
     cursory := dx;
     cursorx := cx;
     keys    := bx;
   end;
end;

(* MOSTRA O RATO *)
Procedure ShowMouse;
var r : registers;

begin
  r.ax := 1;
  intr($33,r);
end;

(* ESCONDE O RATO *)
Procedure HideMouse;
var r : registers;
begin
  r.ax := 2;
  intr($33,r);
end;



(* AS OPCOES DO PROGRAMA [CONDICOES] *)
procedure opcoes;
begin
  Mouse;
  if keypressed then TEC:=readkey;

  (* PALETTE *)

  (* PRETO *)
  if (keys=1) and
  (cursorX>340) and (cursorY>40) and
  (cursorX<380) and (cursorY<80) or
  (TEC in ['1']) then OPCAO:=8;

  (* GREEN *)
  if (keys=1) and
  (cursorX>400) and (cursorY>40) and
  (cursorX<440) and (cursorY<80) or
  (TEC in ['2']) then OPCAO:=10;

  (* RED *)
  if (keys=1) and
  (cursorX>460) and (cursorY>40) and
  (cursorX<500) and (cursorY<80) or
  (TEC in ['3']) then OPCAO:=12;

  (* YELLOW *)
  if (keys=1) and
  (cursorX>520) and (cursorY>40) and
  (cursorX<560) and (cursorY<80) or
  (TEC in ['4']) then OPCAO:=14;

  (* BLUE *)
  if (keys=1) and
  (cursorX>340) and (cursorY>100) and
  (cursorX<380) and (cursorY<140) or
  (TEC in ['5']) then OPCAO:=9;

  (* CYAN *)
  if (keys=1) and
  (cursorX>400) and (cursorY>100) and
  (cursorX<440) and (cursorY<140) or
  (TEC in ['6']) then OPCAO:=11;

  (* MAGENTA *)
  if (keys=1) and
  (cursorX>460) and (cursorY>100) and
  (cursorX<500) and (cursorY<140) or
  (TEC in ['7']) then OPCAO:=13;

  (* WHITE *)
  if (keys=1) and
  (cursorX>520) and (cursorY>100) and
  (cursorX<560) and (cursorY<140) or
  (TEC in ['8']) then OPCAO:=15;

  (* MENU*)

  (* <<< *)
  if (keys=1) and
  (cursorX>340) and (cursorY>190) and
  (cursorX<430) and (cursorY<220) or
  (TEC in [#8]) then OPCAO:=1;

  (* [=] *)
  if (keys=1) and
  (cursorX>470) and (cursorY>190) and
  (cursorX<560) and (cursorY<220) or
  (TEC in [#13]) then OPCAO:=2;

  (* NOVO *)
  if (keys=1) and
  (cursorX>340) and (cursorY>240) and
  (cursorX<430) and (cursorY<270) or
  (TEC in ['n','N']) then OPCAO:=3;

  (* EXIT *)
  if (keys=1) and
  (cursorX>470) and (cursorY>240) and
  (cursorX<560) and (cursorY<270) or
  (TEC in ['e','E']) then OPCAO:=4;

  (* HELP *)
  if (keys=2) or
  (TEC in [#32]) then OPCAO:=5;

end;



(* O JOGO EM SI *)
procedure Master_Mind;
var LINHA,COL:integer;
    CODIGO,PLAY,TEMP:CHAVE;
    SAIR:boolean;

(* PERMITE ALTERAR E CORIGIR *)
procedure Backspce;
begin
  if COL>1 then
  begin
    hidemouse;
    settextstyle(Boldfont,horizdir,1);
    janela(340,190,430,220,OFF);
    setcolor(lightgreen);
    outtextxy(360,180,'<<<');
    delay(300);
    janela(340,190,430,220,ON);
    setcolor(black);
    outtextxy(360,180,'<<<');
    janela(100+(40*(COL-2)),80+(38*(LINHA-1)),
           120+(40*(COL-2)),100+(38*(LINHA-1)),ON);
    showmouse;
    COL:=COL-1;
  end;
end;

(* AO CONFIRMAR A CHAVE, COMPARA-A AO CODIGO E DESENHA O RESULTADO *)
procedure Enter;
var PRETAS,BRANCAS,N,M,X,Y,R:integer;
    FINISH:boolean;

begin
  if (COL>4) and (LINHA<=10) then
  begin
    hidemouse;
    settextstyle(boldfont,horizdir,1);
    janela(470,190,560,220,OFF);
    setcolor(lightgreen);
    outtextxy(500,180,'[=]');
    delay(500);
    janela(470,190,560,220,ON);
    setcolor(black);
    outtextxy(500,180,'[=]');
    showmouse;

    (* CONTAGEM DAS CORES CERTAS *)
    PRETAS:=0;BRANCAS:=0;FINISH:=false;
    for N:=1 to 4 do TEMP [N]:=CODIGO [N];
    for N:=1 to 4 do if PLAY [N] = TEMP [N] then
    begin
      PRETAS:=PRETAS+1;
      TEMP [N]:=0;PLAY [N]:=1;
    end;
    for N:=1 to 4 do for M:=1 to 4 do
    begin
      if PLAY [N] = TEMP [M] then
      begin
        BRANCAS:=BRANCAS+1;
        TEMP [M]:=0;PLAY [N]:=1;
      end;
    end;

    (* LIMITES DO JOGO, FAZ O DISPLAY DO CODIGO*)
    if (LINHA=10) or (PRETAS=4) then
    begin
      setfillstyle(1,lightgray);
      bar(94,34,246,66);
      for N:=1 to 4 do
      begin
        janela(100+40*(N-1),40,120+40*(N-1),60,ON);
        setfillstyle(1,CODIGO [N]);
        bar(100+40*(N-1),40,120+40*(N-1),60)
      end;
      if PRETAS=4 then FINISH:=true;
    end;

    (* DESENHO DAS BOLAS PRETAS E BRANCAS *)
    for N:=1 to 4 do
    begin
      if N=1 then begin X:=52;Y:=84+(38*(LINHA-1));end;
      if N=2 then begin X:=52;Y:=94+(38*(LINHA-1));end;
      if N=3 then begin X:=68;Y:=84+(38*(LINHA-1));end;
      if N=4 then begin X:=68;Y:=94+(38*(LINHA-1));end;
      if (PRETAS = 0) and
         (BRANCAS<>0) then begin
                             setcolor (white);
                             for R:=1 to 4 do circle(X,Y,R);
                             BRANCAS:=BRANCAS-1;
                           end;
       if PRETAS <> 0 then  begin
                             setcolor (black);
                             for R:=1 to 4 do circle(X,Y,R);
                             PRETAS:=PRETAS-1;
                           end;
   end;

    (* SE VENCEU... *)
    if FINISH then
    begin
      hidemouse;
      setfillstyle(11,blue);
      bar(300,310,620,470);
      setfillstyle(1,lightgray);
      bar(290,300,610,460);
      settextstyle(boldfont,horizdir,1);
      outtextxy(310,320,' * CONSEGUISTE * ');
      outtextxy(310,360,'     êS UM ...   ');
      outtextxy(310,400,' ! MASTER LOGIK !');

      repeat mouse; until keypressed or (keys=1);

      setfillstyle(9,blue);
      bar(290,300,620,470);
      LINHA:=10;
      showmouse;
    end;

    (* SE PERDEU... *)
    if (LINHA=10) and not FINISH then
    begin
      hidemouse;
      setfillstyle(11,blue);
      bar(300,310,620,470);
      setfillstyle(1,lightgray);
      bar(290,300,610,460);
      setcolor(black);
      settextstyle(boldfont,horizdir,1);
      outtextxy(310,320,'    AZAR !');
      outtextxy(310,380,'TENTA OUTRA VEZ .');

      repeat mouse; until keypressed or (keys=1);

      setfillstyle(9,blue);
      bar(290,300,620,470);
      showmouse;
    end;
    LINHA:=LINHA+1;COL:=1;
  end;
end;


(* INICIALIZA O JOGO COM UM NOVO CODIGO DE CORES *)
procedure Novo;
var N,M,X,Y:integer;

begin
  hidemouse;
  janela(340,240,430,270,OFF);
  settextstyle(boldfont,horizdir,1);
  setcolor(lightgreen);
  outtextxy(350,230,'NOVO');
  delay(500);
  janela(340,240,430,270,ON);
  setcolor(black);
  outtextxy(350,230,'NOVO');

  (* CRIA UM NOVO CODIGO *)
  randomize;for N:=1 to 4 do CODIGO [N]:=8+random(8);

  (* DESENHO DO TABULEIRO DE JOGO *)
  janela(20,20,260,460,ON);janela(100,40,240,60,ON);
  for N:=0 to 9 do for M:=0 to 3 do
  begin
    X:=100+(40*M);Y:=80+(38*N);
    janela(X,Y,X+20,Y+20,ON);
  end;
  for N:=0 to 9 do
  begin
    Y:=74+(38*N);X:=40;
    line(0+X,0+Y,40+X,0+Y);line(40+X,0+Y,40+X,32+Y);
    line(40+X,32+Y,0+X,32+Y);line(0+X,32+Y,0+X,0+Y);
  end;
  settextstyle(gothicfont,horizdir,6);
  setcolor(blue);
  for N:=1 to 5 do outtextxy(40+N,10+N,'L');
  setcolor(yellow);outtextxy(45,15,'L');
  settextstyle(triplexfont,horizdir,1);
  setcolor(red);outtextxy(120,40,'C O D I G O');

  LINHA:=1;COL:=1;
  showmouse;
end;

(* DESENHA A COR ESCOLHIDA NO LUGAR CORRESPONDENTE *)
procedure Palette(COR:integer);
begin
  if (COL<=4) and (LINHA <=10) then
  begin
    hidemouse;
    janela(100+(40*(COL-1)),80+(38*(LINHA-1)),
           120+(40*(COL-1)),100+(38*(LINHA-1)),OFF);
    setfillstyle(1,COR);
    bar(100+(40*(COL-1)),80+(38*(LINHA-1)),
        120+(40*(COL-1)),100+(38*(LINHA-1)));
    PLAY [COL]:=COR;(* JOGADA FEITA *)
    showmouse;
    COL:=COL+1;
    delay(200);
  end;
end;


(* CONFIRMACAO DE SAIDA *)
procedure Confirma;
begin
  hidemouse;
  janela(470,240,560,270,OFF);
  settextstyle(boldfont,horizdir,1);
  setcolor(lightgreen);
  outtextxy(490,230,'EXIT');
  delay(500);bar(464,234,566,276);
  janela(530,240,560,270,ON);
  janela(470,240,500,270,ON);
  setcolor(black);
  outtextxy(535,230,'N');
  outtextxy(475,230,'S');
  setfillstyle(11,blue);
  bar(340,360,620,420);
  setfillstyle(1,lightgray);
  bar(320,340,600,400);
  settextstyle(boldfont,horizdir,1);
  outtextxy(360,350,'CONFIRMAS ?');
  showmouse;
  repeat
    mouse;
    if keypressed then TEC:=readkey;

    (* CONFIRMOU *)
    if (keys=1) and
    (cursorX>470) and (cursorY>240) and
    (cursorX<500) and (cursorY<270) or
    (TEC in ['s','S']) then OPCAO:=1;

    (* NAO CONFIRMOU *)
    if (keys=1) and
    (cursorX>530) and (cursorY>240) and
    (cursorX<560) and (cursorY<270) or
    (TEC in ['n','N']) then OPCAO:=0;

  until (OPCAO=1) or (OPCAO=0);

  (* SE CONFIRMOU ENTAO... *)
  if OPCAO=1 then
  begin
    hidemouse;
    janela(470,240,500,270,OFF);
    setcolor(lightgreen);
    outtextxy(475,230,'S');
    delay(500);
    janela(470,240,500,270,ON);
    setcolor(black);
    outtextxy(475,230,'S');
    showmouse;
    SAIR:=true;
  end;

  (* SE NAO CONFIRMOU ENTAO... *)
  if OPCAO=0 then
  begin
    hidemouse;
    janela(530,240,560,270,OFF);
    setcolor(lightgreen);
    outtextxy(535,230,'N');
    delay(500);
    janela(470,240,560,270,ON);
    setcolor(black);
    outtextxy(490,230,'EXIT');
    setfillstyle(9,blue);
    bar(320,340,620,420);
    showmouse;
  end;
end;

(* HELP *)
procedure help;
begin
  hidemouse;
  setfillstyle(11,blue);
  bar(300,310,620,470);
  setfillstyle(1,lightgray);
  bar(290,300,610,460);
  settextstyle(defaultfont,horizdir,1);
  setcolor(white);
  outtextxy(320,370,'€');
  setcolor(black);
  outtextxy(300,370,'€ ');
  outtextxy(300,310,'OBJECTIVO DO JOGO :');
  outtextxy(300,320,'   - Encontrar o codigo de 4 cores');
  outtextxy(300,330,'LEGENDA :');
  setcolor(white);circle(310,352,1);circle(310,352,2);circle(310,352,3);
  setcolor(black);circle(310,342,1);circle(310,342,2);circle(310,342,3);
  outtextxy(300,340,'   - Cor certa no lugar Certo');
  outtextxy(300,350,'   - Cor certa no lugar Errado');
  outtextxy(300,360,'MENU :');
  outtextxy(340,370,'-   Æ cores Ø   Numeros de 1 a 8 ');
  outtextxy(300,380,'<<<  - Æ Backspace Ø  Permite corigir');
  outtextxy(300,390,'[=]  -   Æ Enter Ø   Confirma a chave');
  outtextxy(300,400,'NOVO -     Æ N Ø    recomecar um jogo');
  outtextxy(300,410,'EXIT -     Æ E Ø       permite sair');
  outtextxy(300,440,'SPACE - Este help.');
  outtextxy(300,450,' ESC  - sair do help.');
  settextstyle(triplexfont,horizdir,2);
  line(470,430,590,430);line(590,430,590,455);
  line(590,455,470,455);line(470,455,470,430);
  setcolor(lightgreen);
  outtextxy(480,430,'  R Gil-93');
  circle(484,443,8);outtextxy(480,428,'c');
  showmouse;

  repeat mouse;if keypressed then TEC:=readkey; until (TEC=#27) or (keys=1);

  hidemouse;
  setfillstyle(9,blue);
  bar(290,300,620,470);
  showmouse;
end;


(* MASTER_MIND PROGRAMA *)
begin
  SAIR:=false;
  showmouse;
  novo;(* PARA COMECAR *)

  repeat
    opcoes;
    case OPCAO of
      1:Backspce;
      2:Enter;
      3:Novo;
      4:Confirma;
      5:help;
      8,9,10,11,12,13,14,15:Palette(OPCAO);
    end;
  OPCAO:=0;TEC:=#0;(* ANULA A OPCAO PARA O CICLO NAO A REPETIR *)
  until SAIR;

end;

(* APAGA O ECRAN E FECHA O MODO GRAFICO *)
procedure Final_Programa;
var N:integer;

begin
  hidemouse;
  setfillstyle(1,black);
  for N:=0 to 80 do
  begin
    bar (N*4,0,N*4,480);
    bar (640-N*4,0,640-N*4,480);
  end;
  for N:=0 to 80 do
  begin
    bar (320-N*4-1,0,320-N*4,480);
    bar (320+N*4-1,0,320+N*4,480);
  end;
  for N:=0 to 80 do
  begin
    bar (N*4-2,0,N*4,480);
    bar (640-N*4-2,0,640-N*4,480);
  end;
  for N:=0 to 80 do
  begin
    bar (320-N*4-3,0,320-N*4,480);
    bar (320+N*4-3,0,320+N*4,480);
  end;
  closegraph;
  clrscr;writeln('Um Bom dia para ti ...');
end;

(****************************************************************************)
(* * * * * * * * * * * * * PROGRAMA PRINCIPAL * * * * * * * * * * * * * * * *)
(****************************************************************************)

begin
  ModoGraphico;
  Apresentacao;
  Master_Mind;
  Final_Programa;
end.

(*******  PARA COMENTARIOS, SUGESTOES, ETC...  ******************************)
(* MEU ENDERECO:                                                            *)
(*                 RUI MANUEL FERREIRA GIL                                  *)
(*                 RUA DOS SAPATEIROS Nß 10-A                               *)
(*                 AMOR                                                     *)
(*                 2400 LEIRIA                                              *)
(*                                                                          *)
(****************************************************************************)
