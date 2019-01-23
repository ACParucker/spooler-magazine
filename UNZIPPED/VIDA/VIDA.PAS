(****************************************************************************)
(*                          O  JOGO  DA  VIDA                               *)
(* PARA A SPOOLER                                                           *)
(* REALIZADO POR:  RUI GIL                                                  *)
(* NOVEMBRO DE 1993                                                         *)
(****************************************************************************)

program Vida;

(* UNITS UTILIZADAS NO PROGRAMA *)
uses dos,
     crt,
     graph,
     linkdriv;


type
       (* CELULA - exisTE TEM DOIS ESTADOS, VIVA OU MORTA.
                   viziNHOS DA CELULA
       *)
       CELULA = record
                  EXIS:boolean;
                  VIZI:0..8;
                end;

       (* ESPACO DE CELULAS
       *)
       ESPACO = array [1..180,1..160] of CELULA;

       (* UTILIZADO PARA CONTER O PAR (X,Y) DE UMA COORDENADA
       *)
       COORDENADAS = record
                       X:integer;
                       Y:integer;
                     end;
       (* PONTEIRO QUE APONTA PARA UM RECORD NOME DO FICHEIRO
       *)
       PONTE = ^FILENAME;

       (* RECORD NOME DO FICHEIRO
          COM UM PONTEIRO PARA A FRENTE E OUTRO PARA TRAS
       *)
       FILENAME = record
                    NAME:string[8];
                    PROX:PONTE;
                    ANTE:PONTE;
                  end;


var
     E:ESPACO;             (* ESPACO DE CELULAS *)
     OPCAO:integer;        (* OPCAO ESCOLHIDA NOS MENUS*)
     SAIR:boolean;         (* SAIR DO PROGRAMA *)
     TEC,T:char;           (* PARA A LEITURA DE TECLAS *)
     TEMPO,VIDAS:integer;  (* CONTAR O TEMPO E O NUMERO DE VIDAS *)

     C1,C2:COORDENADAS;    (* COORDENADAS DA AREA DE CALCULO *)
     F1,F2:COORDENADAS;    (* COORDENADAS DA AREA DE FICHEIRO *)
     J1,J2:COORDENADAS;    (* COORDENADAS DA JANELA DE ZOOM *)

     X,Y:integer;          (* BASTANTE UTIL ... *)
     F:text;               (* FICHEIRO DE TEXTO *)




(* ESTE PROCEDIMENTO INICIALIZA O MODO GRAFICO
   REGISTA O DRIVER VGA 640x480 NO HEAP
*)
procedure IniciaGraficos;
var GRDRIVER,GRMODE,ERRORCODE,N:integer;

    (* ABORTA SE HOUVER ERROS *)
    procedure Abortar(Msg : string);
    begin
      clrscr;
      Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
      readln;
    end;

begin
               (* REGISTA O DRIVER GRAFICO DESEJADO *)
  if RegisterBGIdriver(@EGAVGADriver) < 0 then Abortar('EGA/VGA');

  GRDRIVER:=VGA;GRMODE:=VGAhi;
  initgraph(GRDRIVER,GRMODE,'');
  ERRORCODE:=graphresult;
  if ERRORCODE <> grok then  Abortar ('ERRO');
end;

(* ESTE PROCEDIMENTO FECHA O MODO GRAFICO
*)
procedure FechaGraficos;
begin
  closegraph;
end;

(* PERMITE DESENHAR UMA BARRA BIDIMENSIONAL COM UMA DETERNINADA COR
*)
procedure plot(X,Y,XX,YY:integer;COR:word);
begin
  setfillstyle(1,COR);bar(X,Y,XX,YY);
end;

(* INICIALIZA AS VARIAVEIS E O ECRAN
*)
procedure InicioVida;
begin
  SAIR:=false;
  J1.X:=73;J2.X:=108;
  J1.Y:=65;J2.Y:=96;
  plot(540,0,640,480,black);
  setcolor(lightgreen);
  outtextxy(558,15,'TIC-TAC'); outtextxy(570,55,'VIDAS');
  outtextxy(570,450,'<ESC>');
  setcolor(yellow);
  outtextxy(570,30,' 0');outtextxy(570,70,' 0');
  outtextxy(570,460,' SAI');
  setcolor(red);
  line(545,5,635,5);line(635,5,635,88);line(635,88,545,88);
  line(545,88,545,5);line(545,445,635,445);line(635,445,635,473);
  line(635,473,545,473);line(545,473,545,445);
end;

(* CONTEM TODOS OS MENUS DO PROGRAMA
   DESENHA-OS E RETORNA A OPCAO ESCOLHIDA
*)
function Menus(M:integer):integer;
var ESCOLHA:integer;

(* DESENHA O MENU EM QUESTAO
*)
procedure Menu (T1,T2,
                O1,O2,O3,O4,O5,O6,O7,O8,
                H1,H2                    :string;
                MIN,MAX                  :shortint);

var MENU:array [1..8] of string [12];
    N,COO:integer;

begin
  MENU [1]:=O1;MENU [2]:=O2;
  MENU [3]:=O3;MENU [4]:=O4;
  MENU [5]:=O5;MENU [6]:=O6;
  MENU [7]:=O7;MENU [8]:=O8;
  if (MIN=0) and (MAX=0) then ESCOLHA:=0 else ESCOLHA:=MIN;
  setcolor(red);
  plot(545,140,635,328,black);
  line(545,140,635,140);line(635,140,635,328);
  line(635,328,545,328);line(545,328,545,140);
  line(635,168,545,168);line(635,300,545,300);
  outtextxy(540+round((100-8*length(T1))/2),145,T1);
  outtextxy(540+round((100-8*length(T2))/2),155,T2);
  setcolor(blue);
  outtextxy(540+round((100-8*length(H1))/2),305,H1);
  outtextxy(540+round((100-8*length(H2))/2),315,H2);
  repeat
    for N:=0 to 7 do
    begin
      plot(550,170+(N*16),630,181+(N*16),black);setcolor(yellow);
      outtextxy(540+round((100-8*length(MENU [N+1]))/2),173+(N*16),MENU [N+1]);
    end;

    if ESCOLHA<>0 then
    begin
      plot(550,170+((ESCOLHA-1)*16),
           630,181+((ESCOLHA-1)*16),
           lightgreen);

      setcolor(black);
      outtextxy(540+round((100-8*length(MENU [ESCOLHA]))/2),
                           173+((ESCOLHA-1)*16),
                                MENU [ESCOLHA]);
      T:=#0;
      repeat TEC:=readkey; until TEC in [#0,#13,#27];

      if TEC=#0  then T:=readkey;
      if T=#80 then ESCOLHA:=ESCOLHA+1;
      if T=#72 then ESCOLHA:=ESCOLHA-1;

      if ESCOLHA>MAX then ESCOLHA:=MIN;
      if ESCOLHA<MIN then ESCOLHA:=MAX;

      if TEC=#27 then ESCOLHA:=0;
    end;

  until (TEC in [#13,#27]) or (ESCOLHA=0);

  if ESCOLHA=0 then Menus:=0 else Menus:=ESCOLHA-MIN+1;

end;

(* TODOS OS MENUS DO PROGRAMA
   CHAMA-SE A FUNCAO COM O NUMERO DO MENU
   E ELA RETORNA A OPCAO
*)
begin
  case M of
    0:Menu ('MENU','PRINCIPAL',
            '',
            'Accao',
            'Criar',
            'Limpar',
            'Ficheiros','','','',
            #24#25,'ENTER',
            2,5);

    1:Menu ('BIOGRAPH','Vidas (T)',
            '','','','','','','','',
            '','',
            0,0);

    2:Menu ('CRIAR','FIGURA',
            '','PONTO',
            '',
            'X=    ','',
            'Y=    ','','',
            #24#25#26#27,'SPACE',
            0,0);

    3:Menu ('LIMPAR','O ESPACO',
            '','',
            'Nao',
            'Sim','','','','',
            #24#25,'ENTER',
            3,4);

    4:Menu ('MENU','FICHEIROS',
            '','',
            'Abrir...',
            'Salvar...',
            '','','','',
            #24#25,'ENTER',
            3,4);

    5:Menu ('CONFIRMAS','SAIR',
            '','',
            'Nao',
            'Sim','','','','',
            #24#25,'ENTER',
            3,4);

    41:Menu('ABRIR','FICHEIRO',
             '','',
             'Nome',
             'Procurar',
             '','','','',
             #24#25,'ENTER',
             3,4);

    42:Menu('SALVAR','FICHEIRO',
            '',
            'Escreve',
            'o nome',
            '','','','','',
            '0..9','A..Z',
            0,0);

    43:Menu('ABRIR','FICHEIRO',
            '',
            'Ficheiro',
            'Nao',
            'Encontrado',
            '','','','',
            'QUALQUER','TECLA',
            0,0);

    44:Menu('ABRIR','FICHEIRO',
            'Posiciona',
            'a Figura',
            '',
            'X=    ',
            '',
            'Y=    ',
            '','',
            #24#25#26#27,'SPACE',
            0,0);

    45:Menu('SALVAR','FICHEIRO',
            'Canto',
            'Superior',
            'Esquerdo',
            'X=    ',
            '',
            'Y=    ',
            '','',
            #24#25#26#27,'SPACE',
            0,0);

    46:Menu('SALVAR','FICHEIRO',
            'Canto',
            'Inferior',
            'Direito',
            'X=    ',
            '',
            'Y=    ',
            '','',
            #24#25#26#27,'SPACE',
            0,0);

    47:Menu('CONFIRMAS','',
            '','',
            'Nao',
            'Sim','','','','',
            #24#25,'ENTER',
            3,4);

    48:Menu('SALVAR','FICHEIRO',
            '','',
            'O Quadrado',
            'Nao e',
            'Valido',
            '',
            '',
            '',
            'QUALQUER','TECLA',
            0,0);

   411:Menu('ABRIR','FICHEIRO',
            '',
            'Escreve',
            'o nome',
            '','','','','',
            '0..9','A..Z',
            0,0);

   412:Menu('PROCURAR','FICHEIRO',
            '','','','','','','','',
            #24#25,'ENTER',
            0,0);

  end;
end;


(* PROCEDIMENTO GERAL DO JOGO VIDA
*)
procedure JogoVida;
var NORTE,SUL,ESTE,OESTE:integer;

(* VERIFICA OS LIMITES TORNANDO O ESPACO UMA ESFERA
*)
procedure Esfera(LONGITUDE,LATITUDE:integer);
begin
  if LONGITUDE = 180 then ESTE:=1    else ESTE:=LONGITUDE+1;
  if LONGITUDE = 1   then OESTE:=180 else OESTE:=LONGITUDE-1;
  if LATITUDE  = 160 then SUL:=1     else SUL:=LATITUDE+1;
  if LATITUDE  = 1   then NORTE:=160 else NORTE:=LATITUDE-1;
end;

(* FAZ A ALTERACAO NOS VIZINHOS
   A TOMA O VALOR +1 OU -1
*)
procedure Vizinhos(PX,PY,A:integer);
begin

  Esfera(PX,PY);

  E [ESTE ,PY   ].VIZI:=E [ESTE ,PY   ].VIZI+A;
  E [OESTE,PY   ].VIZI:=E [OESTE,PY   ].VIZI+A;
  E [PX   ,SUL  ].VIZI:=E [PX   ,SUL  ].VIZI+A;
  E [PX   ,NORTE].VIZI:=E [PX   ,NORTE].VIZI+A;
  E [ESTE ,SUL  ].VIZI:=E [ESTE ,SUL  ].VIZI+A;
  E [OESTE,SUL  ].VIZI:=E [OESTE,SUL  ].VIZI+A;
  E [ESTE ,NORTE].VIZI:=E [ESTE ,NORTE].VIZI+A;
  E [OESTE,NORTE].VIZI:=E [OESTE,NORTE].VIZI+A;
end;

(* FAZ NASCER UMA CELULA NA COORDENADA NX,NY
*)
procedure Nascimento(NX,NY:integer);
begin
  E [NX,NY].EXIS:=true;
  VIDAS:=VIDAS+1;

  Vizinhos(NX,NY,+1);

  (* OS LIMITES DO QUADRADO DE CALCULO *)
  if ESTE  > C2.X then C2.X:=ESTE  else if ESTE = 1   then C1.X:=ESTE;
  if OESTE < C1.X then C1.X:=OESTE else if OESTE= 180 then C2.X:=OESTE;
  if NORTE < C1.Y then C1.Y:=NORTE else if NORTE= 160 then C2.Y:=NORTE;
  if SUL   > C2.Y then C2.Y:=SUL   else if SUL  = 1   then C1.Y:=SUL;
end;

(* FAZ MORRER UMA CELULA NA COORDENADA MX,MY
*)
procedure Morte(MX,MY:integer);
begin
  E [MX,MY].EXIS:=false;
  VIDAS:=VIDAS-1;

  Vizinhos(MX,MY,-1);

end;

(* PERMITE PASSAR UMA VARIAVEL PARA STRING PARA SER IMPRIMIDA NO ECRAN
*)
procedure Var_Str(X,Y:integer;NUM:integer);
var MSG:string;
begin
  plot(X,Y,634,Y+8,black);
  str(NUM,MSG);setcolor(yellow);
  outtextxy(X,Y,MSG);
end;

(* PROCEDIMENTO QUE PROCESSA AS CONFIGURACOES
   O CORACAO DA MAQUINA , DIGAMOS ASSIM...
*)
procedure Accao;
var PIXELCOLOR:word;
    B:integer;
    ALT:integer;
    PLA:integer;
    PAUSA:integer;

(* APENAS ESCREVE OS LIMITES DE ALTURA DO GRAFICO
*)
procedure Graflim;
begin
  setcolor(green);
  outtextxy(550,305,'MAX =');
  outtextxy(550,315,'MIN =');
  Var_Str(600,305,390*ALT);
  Var_Str(600,315,390*(ALT-1));
end;

(* DESENHA UM GRAFICO DO NUMERO DE VIDAS AO LONGO DO TEMPO
*)
procedure Grafico(VALOR:integer);
begin
  VALOR:=round(VALOR/3);
  if TEMPO mod 5=0     then begin
                              PLA:=PLA+1;
                            end;

  if PLA=80            then begin
                              Menus(1);PLA:=0;
                              Graflim;
                            end;

  if VALOR>130*ALT     then begin
                              Menus(1);ALT:=ALT+1;
                              Graflim;
                            end;

  if VALOR<130*(ALT-1) then begin
                              Menus(1);ALT:=ALT-1;
                              Graflim;
                            end;
  VALOR:=VALOR-(130*(ALT-1));

  putpixel(550+PLA,299-VALOR,random(8)+8); (* CORES CLARAS *)
end;

(* ACCAO *)
begin
  Menus(1);PLA:=0;ALT:=1;
  Graflim;PAUSA:=0;
  for B:=40 downto 15 do setrgbpalette(1,0,0,B);
  repeat
    if keypressed then TEC:=readkey;

    (* AQUI ESTA A REGRA. APENAS E SO ISTO *)

    for X:=C1.X to C2.X do for Y:=C1.Y to C2.Y do
    begin
      (* SE EXISTE E TIVER MENOS DE 1 OU MAIS DE QUATRO VIZINHOS
         ENTAO DEIXA DE EXISTIR, POR OUTRAS PALAVRAS MORRE...
         POR ISOLAMENTO OU POR SUPER-POVOAMENTO
      *)
      if (E [X,Y].EXIS) and
         (E [X,Y].VIZI <= 1) or (E [X,Y].VIZI >= 4) then E [X,Y].EXIS:=false;
      (* SE FOR UMA CASA VAZIA ONDE ESTEJAM TRES E SO TRES VIZINHOS
         ENTAO NASCE...
      *)
      if (not E [X,Y].EXIS) and (E [X,Y].VIZI= 3)   then E [X,Y].EXIS:=true;
    end;

    (* COMO O ESPACO TEM DE SER LINEAR
       O PROCESSAMENTO DO ESPACO CONTEM DOIS CICLOS
       UM PARA DECIDIR QUEM NASCE E QUEM PASSA DESTA PARA MELHOR
       E UM SEGUNDO PARA FAZER AS ALTERACOES
       ESTE CICLO E O SEGUNDO...
    *)
    for X:=C1.X to C2.X do for Y:=C1.Y to C2.Y do
    begin
      PIXELCOLOR:=getpixel(X*3-1,Y*3-1);
      if (not E [X,Y].EXIS) and (PIXELCOLOR=yellow) then
      begin
        morte(X,Y);
        plot(X*3-2,Y*3-2,X*3-1,Y*3-1,blue);
      end;
      if (E [X,Y].EXIS) and (PIXELCOLOR=blue) then
      begin
        nascimento(X,Y);
        plot(X*3-2,Y*3-2,X*3-1,Y*3-1,yellow);
      end;
    end;

    (* UMA PAUSA PARA AS FIGURAS PEQUENAS *)
    PAUSA:=(100-((C2.X-C1.X)+(C2.Y-C1.Y)));
    if PAUSA > 1 then delay(PAUSA);

    TEMPO:=TEMPO+1;Grafico(VIDAS);
    Var_Str(578,30,TEMPO);Var_str(578,70,VIDAS);
  until TEC=#27;
  for B:=15 to 40 do setrgbpalette(1,0,0,B);
end;

(* INICIALIZA UM ZOOM DO ESPACO FORNECENDO UMA VISTA DE
   UM QUADRADO DE 36x32 CELULAS NO ESPACO TOTAL DE 180x160
*)
procedure InitZoom;
begin
  plot(0,0,539,480,blue);setcolor(black);
  for X:=0 to 35 do line(X*15,0,X*15,479);
  for Y:=0 to 31 do line(0,Y*15,539,Y*15);
  for X:=0 to 35 do for Y:=0 to 31 do
  if E [X+J1.X,Y+J1.Y].EXIS then plot(X*15+3,Y*15+3,X*15+12,Y*15+12,yellow);
  X:=J1.X+10;Y:=J1.Y+10;
end;

(* FAZ O CONTRARIO DO INITZOOM
   DESZOOMIFICA ?! PASSANDO PARA O ESPACO TOTAL.
*)
procedure Espaco;
begin
  plot(0,0,539,480,blue);
  for X:=1 to 180 do for Y:=1 to 160 do
  if E [X,Y].EXIS then plot(X*3-2,Y*3-2,X*3-1,Y*3-1,yellow);
end;

(* DESENHA UM CURSORZINHO LINDO NO MODO ZOOM
*)
procedure Cursor;
begin
  Var_Str(594,221,X);Var_Str(594,253,Y);
  plot((X-J1.X)*15+3,(Y-J1.Y)*15+3,(X-J1.X)*15+12,(Y-J1.Y)*15+12,lightgreen);
end;

(* PERMITE MOVER O CURSOR NO MODO ZOOM
   E TRANSLACIONAR A JANELA QUANDO O CURSOR ASSIM O INSISTE
   A TRANSLACAO PODE SER FEITA SEGUNDO O EIXO DO XX OU DOS YY
*)
procedure Mover;

(* TRANSLACAO NO EIXO DO XX
*)
procedure Trans_X;
var C,L:integer;

begin
  for C:=0 to 35 do for L:=0 to 31 do
  begin
    if E [C+J1.X,L+J1.Y].EXIS then
    plot(C*15+3,L*15+3,C*15+12,L*15+12,yellow)
    else
    plot(C*15+3,L*15+3,C*15+12,L*15+12,blue);
  end;
end;

(* TRANSLACAO NO EIXO DO YY
*)
procedure Trans_Y;
var C,L:integer;

begin
  for L:=0 to 31 do for C:=0 to 35 do
  begin
    if E [C+J1.X,L+J1.Y].EXIS then
    plot(C*15+3,L*15+3,C*15+12,L*15+12,yellow)
    else
    plot(C*15+3,L*15+3,C*15+12,L*15+12,blue);
  end;
end;

(* MOVER *)
begin
  T:=readkey;

  if E [X,Y].EXIS then
  plot((X-J1.X)*15+3,(Y-J1.Y)*15+3,(X-J1.X)*15+12,(Y-J1.Y)*15+12,yellow)
  else
  plot((X-J1.X)*15+3,(Y-J1.Y)*15+3,(X-J1.X)*15+12,(Y-J1.Y)*15+12,blue);

  if T=#75 then if X>1   then X:=X-1;
  if T=#77 then if X<180 then X:=X+1;
  if T=#80 then if Y<160 then Y:=Y+1;
  if T=#72 then if Y>1   then Y:=Y-1;

  if (X<J1.X) then begin
                     J1.X:=J1.X-8;
                     J2.X:=J2.X-8;
                     Trans_X;
                   end;
  if (X>J2.X) then begin
                     J1.X:=J1.X+8;     (* QUANDO OS LIMITES DA *)
                     J2.X:=J2.X+8;     (* DA JANELA SAO ULTRAPASSADOS *)
                     Trans_X;          (* HA UMA TRANSLACAO DE 8 QUADRADOS *)
                   end;
  if (Y<J1.Y) then begin
                     J1.Y:=J1.Y-8;
                     J2.Y:=J2.Y-8;
                     Trans_Y;
                   end;
  if (Y>J2.Y) then begin
                     J1.Y:=J1.Y+8;
                     J2.Y:=J2.Y+8;
                     Trans_Y;
                   end;
  Cursor;
end;

(* PERMITE SERMOS NOS A CRIAR AS CONFIGURACOES DE CELULAS
*)
procedure Criar;

begin
  Menus(2);
  InitZoom;
  Cursor;
  repeat
    repeat TEC:=readkey until TEC in [#0,#32,#27];
    if TEC=#32 then
    begin
      if E [X,Y].EXIS
      then begin
             E [X,Y].EXIS:=false;
             Morte(X,Y);
             Var_str(578,70,VIDAS);
           end
      else begin
             E [X,Y].EXIS:=true;
             Nascimento(X,Y);
             Var_str(578,70,VIDAS);
           end;
    end;
    if TEC=#0 then Mover;
  until TEC=#27;
  Espaco;
end;

(* FAZ UM RESET DO ESPACO
   TEMPO E VIDAS IGUAL A 0
   RESET DA JANELA DE CALCULO
   POSICIONA A JANELA DE ZOOM NO MEIO
*)
procedure Limpar(N:shortint);
var X,Y:integer;
begin
  if N<>0 then OPCAO:=Menus(3) else OPCAO:=2;
  if OPCAO=2 then
  begin
    for X:=1 to 180 do for Y:=1 to 160 do
    begin
      E [X,Y].EXIS:=false; E [X,Y].VIZI:=0;
    end;
    plot(0,0,540,480,blue);
    TEMPO:=0;VIDAS:=0;
    Var_Str(578,30,TEMPO);Var_str(578,70,VIDAS);

    C1.X:=180;C2.X:=1;
    C1.Y:=160;C2.Y:=1;

    J1.X:=73;J2.X:=108;
    J1.Y:=65;J2.Y:=96;
  end;
end;

(* PERMITE GRAVAR E CARREGUAR CONFIGURACOES
   SO NA DIRECTORIA EM QUESTAO
   OS FICHEIROS SAO EM MODO TEXTO
*)
procedure Ficheiros;
var FICHEIRO:string;

(* PEDE UMA CONFIRMACAO
*)
function Confirma:boolean;
begin
  OPCAO:=Menus(47);
  if OPCAO=2 then Confirma:=true else Confirma:=false;
end;

(* FUNCAO QUE LE UM NOME ATRAVES DAS TECLAS
   RETORNA UMA STRING
   SO ACEITA LETRAS E NUMEROS
*)
function Nome:string;
var NAME:string;

begin
  NAME:='';
  setcolor(yellow);
  repeat
    repeat TEC:=readkey;
    until TEC in [#97..#122,#65..#90,#48..#57,#13,#8,#27];
    if TEC=#8 then delete(NAME,length(NAME),1);
    if not (TEC in [#13,#8,#27]) then NAME:=NAME+TEC;
    plot(546,237,634,245,black);
    outtextxy(540+round((100-8*length(NAME))/2),237,NAME);
  until (TEC in [#13,#27]) or (length(NAME) >= 8);
  if (TEC=#13) and (NAME='') then NAME:=#255;
  Nome:=NAME;
end;

(* ESTA FUNCAO COMECA POR FAZER UM DIR DOS FICHEIROS
   COM A EXTENSAO *.VDA E CRIA UMA LISTA DE PONTEIROS DUPLAMENTE LIGADA
   E CIRCULAR COM OS NOMES DOS FICHEIROS
   DEPOIS ESCREVE OITO DELES NO ECRAN E PERMITE COM
   AS TECLAS CURSORAS FAZER A LISTA ANDAR PARA TRAS E PARA A FRENTE
   MUITO UTIL...
   RETORNA UMA STRING.
*)
function Procurar:string;
var
 DIRINFO: SearchRec;
 INI,FIM,FIL:PONTE;
 A:integer;

begin
  FindFirst('*.VDA', Archive, DIRINFO);(* PROCURA *.VDA *)
  INI:=nil;FIM:=nil;

  if DosError<>0 then Procurar:=#255
  else
  begin
    New(FIL);
    FIL^.NAME:=copy(DIRINFO.Name,1,length(DIRINFO.Name)-4);
    INI:=FIL;FIM:=FIL;
    FIL^.ANTE:=nil;FIL^.PROX:=nil;   (* O PRIMEIRO ELEMENTO *)

    while DosError = 0 do
    begin
      FindNext(DIRINFO);
      if DosError=0 then (* ENQUANTO HOUVER FICHEIROS CRIA A LISTA *)
      begin
        New(FIL);
        FIL^.NAME:=copy(DIRINFO.Name,1,length(DIRINFO.Name)-4);
        FIM^.PROX:=FIL;    (* LIGA AO DA FRENTE *)
        FIL^.ANTE:=FIM;    (* LIGA AO DE TRAS   *)
        FIL^.PROX:=nil;
        FIM:=FIL;
      end;
    end;
    FIM^.PROX:=INI;   (* AQUI A SERPENTE MORDE O RABO TORNANDO-A CIRCULAR *)
    INI^.ANTE:=FIM;

    Menus(412);
    repeat
      FIM:=INI;
      for A:=0 to 7 do
      begin
        if A=3 then setcolor (yellow) else setcolor(green);

        outtextxy(540+round((100-8*length(FIM^.NAME))/2),
                  173+(A*16),   FIM^.NAME); (* MOSTRA OITO NO ECRAN *)

        FIM:=FIM^.PROX;
      end;
      TEC:=readkey;
      if TEC=#0 then T:=readkey;

      if (TEC=#0) and (T=#80) then INI:=INI^.PROX; (* RODAR A LISTA *)
      if (TEC=#0) and (T=#72) then INI:=INI^.ANTE;
      if TEC=#0 then plot(550,170,632,298,black);

    until TEC in [#13,#27];
    for A:=1 to 3 do INI:=INI^.PROX;
    if TEC<>#27 then Procurar:=INI^.NAME else Procurar:=#255;
  end;
end;

(* DESENHA AS LINHAS PARA MOSTRAR A AREA DO FICHEIRO
   A GRAVAR OU A CARREGUAR.
*)
procedure Area (X1,Y1,X2,Y2:integer);
begin
  line((X1)*15+7,(Y1)*15+7,(X1)*15+7,(Y2)*15+7);
  line((X1)*15+7,(Y2)*15+7,(X2)*15+7,(Y2)*15+7);
  line((X2)*15+7,(Y2)*15+7,(X2)*15+7,(Y1)*15+7);
  line((X2)*15+7,(Y1)*15+7,(X1)*15+7,(Y1)*15+7);
end;

(* PERMITE CARREGUAR UM FICHEIRO DE CONFIGURACOES
*)
procedure LoadFig;
var C,L,N:integer;
       AC:COORDENADAS;

(* PERMITE REAJUSTAR AS VARIAVEIS ANTES DE DESENHAR A AREA
*)
procedure NovaArea;
begin
  F1.X:=(X-AC.X)-J1.X;
  F1.Y:=(Y-AC.Y)-J1.Y;
  F2.X:=X-J1.X;
  F2.Y:=Y-J1.Y;
  Area (F1.X,F1.Y,F2.X,F2.Y);
end;

(* LOADFIG *)
begin
  OPCAO:=Menus(41);
  case OPCAO of
    1:FICHEIRO:=Nome;
    2:FICHEIRO:=Procurar;
  end;
{$I-}
  assign(F,FICHEIRO+'.VDA');
  reset(F);
{$I+}
  if ioresult<>0 then (* ASSUME-SE QUE SE HOUVER ERRO *)
  begin               (* ENTAO NAO ENCONTROU O FICHEIRO *)
    Menus(43);
    TEC:=readkey;
  end
  else
  begin
    InitZoom;
    Menus(44);
    Cursor;
    setwritemode(XORput);
    readln(F);
    read(F,F1.X);read(F,F1.Y);read(F,F2.X);read(F,F2.Y);
    readln(F);
    AC.X:=F2.X;
    AC.Y:=F2.Y;
    NovaArea;
    repeat
      repeat TEC:=readkey; until TEC in [#0,#32,#27];

      NovaArea;

      if TEC=#0 then mover;

      NovaArea;

      if TEC=#32 then
      begin
        for L:=Y-(F2.Y-F1.Y) to Y do
        begin
          readln(F);
          for C:=X-(F2.X-F1.X) to X do
          begin
            read(F,N);

            if C<1 then X:=180+C else X:=C;(* PORQUE O MUNDO  ESFRICO *)
            if L<1 then Y:=160+L else Y:=L;

            if N=1 then
            begin
              if not E [X,Y].EXIS then
              begin
                E [X,Y].EXIS:=true;
                nascimento(X,Y);
              end;
            end
            else
            if N=0 then
            begin
              if E [X,Y].EXIS then
              begin
                E [X,Y].EXIS:=false;
                morte(X,Y);
              end;
            end;
          end;
        end;
      end;
    until TEC in [#32,#27];
    setwritemode(Normalput);
    close(F);
    Espaco;
  end;
end;

(* PERMITE SALVAR UMA CONFIGURACAO
*)
procedure SaveFig;
var VALIDO,ACABOU:boolean;

(* REAJUSTA AS VARIAVEIS ANTES DE DESENHAR A AREA
*)
procedure NovaArea;
begin
  F2.X:=X-J1.X;
  F2.Y:=Y-J1.Y;
  Area(F1.X-J1.X,F1.Y-J1.Y,F2.X,F2.Y);
end;

(* SAVEFIG *)
begin
  Menus(42);FICHEIRO:=Nome;
  ACABOU:=false;
  while (TEC<>#27) and not ACABOU do
  begin
    InitZoom;
    Menus(45);
    Cursor;
    repeat
      TEC:=readkey;
      if TEC=#0 then Mover;
      if TEC=#32 then
      begin
        F1.X:=X;F1.Y:=Y;
      end;
    until TEC in [#32,#27];
    Menus(46);
    Cursor;
    setwritemode(XORput);
    NovaArea;
    if TEC<> #27 then
    begin
      repeat
        TEC:=readkey;

        NovaArea;

        if TEC=#0 then Mover;

        Novaarea;

        if TEC=#32 then
        begin
          F2.X:=X;F2.Y:=Y;
        end;
      until TEC in [#32,#27];
    end;
    setwritemode(NormalPut);
    ACABOU:= Confirma;
  end;
  if (F2.X<F1.X) or (F2.Y<F1.Y) then VALIDO:=false else VALIDO:=true;
  if not VALIDO then
  begin
    Menus(48);
    TEC:=readkey;
  end;
  if VALIDO and (TEC<>#27) then
  begin
    assign(F,FICHEIRO+'.VDA');
    rewrite(F);
    writeln(F,'- CANTOS DA FIGURA -');
    write(F,1,' ');write(F,1,' ');
    write(F,F2.X-F1.X,' ');write(F,F2.Y-F1.Y,' ');
    writeln(F);write(F,'FIGURA : '+FICHEIRO);
    for Y:=F1.Y to F2.Y do
    begin
      writeln(F);
      for X:=F1.X to F2.X do
      if E [X,Y].EXIS then write(F,1,' ') else write(F,0,' ');
    end;
    writeln(F);write(F,'JOGO DA VIDA');close(F);
  end;
  Espaco;
end;

(* FICHEIROS *)
begin
  OPCAO:=Menus(4);
  case OPCAO of
    1:LoadFig;
    2:SaveFig;
  end;
end;

(* CONFIRMAS A SAIDA DO PROGRAMA ?...
*)
procedure Confirmacao;
begin
  OPCAO:=Menus(5);
  if OPCAO=2 then SAIR:=true else SAIR:=false;
end;

(* PROGRAMA PRINCIPAL
   DO PROCEDIMENTO JOGOVIDA
*)
begin
  Limpar(0);
  repeat

    OPCAO:=Menus(0);
    case OPCAO of
      1:Accao;
      2:Criar;
      3:limpar(1);
      4:Ficheiros;
      0:confirmacao;
    end;

  until SAIR;
end;

(* THE END *)
procedure FimVida;
begin
  clrscr;
  write('Tem um bom DOS...');
end;

(****************************************************************************)
(*                          PROGRAMA PRINCIPAL                              *)
(****************************************************************************)
begin
  IniciaGraficos;

  InicioVida;  JogoVida;  FimVida;

  FechaGraficos;
end.
(*** PARA COMENTARIOS, SUGESTOES ETC... *************************************)
(* A MINHA MORADA :                                                         *)
(*                    RUI MANUEL FERREIRA GIL                               *)
(*                    RUA DOS SAPATEIROS N§10-A                             *)
(*                    AMOR                                                  *)
(*                    2400 LEIRIA                                           *)
(****************************************************************************)