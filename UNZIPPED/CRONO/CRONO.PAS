(****  PARA A SPOOLER  ******************************************************)
(****************************************************************************)
(*                              RELOGIO                                     *)
(*             ANALOGICO           -           DIGITAL                      *)
(****************************************************************************)
program Crono;
(* QUANDO QUISERES SABER AS HORAS OU ACERTA-LAS
   NAO UTILIZES O PRE-HISTORICO TIME
   UTILIZA   - CRONO -
*)

(* ESTRUTURA -
CURSOR - CONTROLA O ESTADO DO CURSOR
ANALOGICO- CICLO COM A FUNCAO GETTIME
  MODOGRAFICO- INICIALIZA O MODO GRAFICO
  MOSTRADOR- DESENHA O MOSTRADOR DO RELOGIO
  DESENHA- DESENHA OS PONTEIROS
DIGITAL- CICLO COM A FUNCAO GETTIME
  NUMERO- ESCOLHE O NUMERO
    UM,DOIS,TRES,...- OS NUMEROS COMPOSTOS EM CARACTERES ASCII
  DECOMP- DECOMPOE OS NUMEROS EM DEZENAS E UNIDADES
  MENU- DESENHA UM MENU DO DIGITAL
  LE TECLAS- FUNCAO QUE LE NUMEROS ATRAVES DAS TECLAS PREMIDAS
  ACERTA HORA- PARA ACERTAR A HORA - SETTIME
  ACERTA DATA- PARA ACERTAR A DATA - SETDATE
RELOGIO- CICLO QUE PERMITE A PASSAGEM DE UM RELOGIO PARA OUTRO
PROGRAMA PRINCIPAL
*)



uses crt,graph,dos,   (* UNIDADES USADAS NO PROGRAMA *)
     linkfont,        (* LINKA AS FONTES *)
     linkdriv;        (* LINKA O DIVER *)

type  TIPOCURSOR=(ON,OFF,BIG);         (* O TIPO DE CURSOR DESEJADO *)
      TABSIN = array [0..59] of real;  (* TABELA DE SENOS   *)
      TABCOS = array [0..59] of real;  (* TABELA DE COSENOS *)


var TEC:char;                      (* PARA A LEITURA DE TECLAS  *)
    SAIR:boolean;                  (* CONTROLA O CICLO DE SAIDA *)
    BoldFonte,TscrFonte:word;      (* INSTALACAO DE DUAS FONTES *)
    HORAS,MINUTOS,SEGUNDOS,C:word; (* LOGICO ... *)



(* ESTA ROTINA PERMITE MUDAR O TIPO DE CURSOR
   ON  -CURSOR NORMAL
   OFF -CURSOR APAGADO
   BIG -CURSOR GRANDE
*)
procedure cursor(TIPO:TIPOCURSOR);
var REGS:registers;

begin
  with REGS do
  begin
    ax:=$100;
    case TIPO of
      OFF:cx:=$3030;
      ON :cx:=$607;
      BIG:cx:=$0f;
    end;
    intr($10,REGS);
  end;
end;

(* PROCEDIMENTO DO RELOGIO ANALOGICO
   EM MODO GRAFICO MAS Sà PARA VGA.. PE€O DESCULPA AOS OUTROS !!
*)
procedure Analogico;
var TCS:TABCOS;
    TSN:TABSIN;
    HOR,MIN,SEG:integer;
    GRAFICO:boolean;
    VEZ:integer;

(* INICIALIZA O MODO GRAFICO VGA-640*480
*)
procedure Modo_Grafico;
var GRDRIVER,GRMODE,ERRORCODE,N:integer;

    (* ABORTA SE HOUVER ERROS *)
    procedure Abortar(Msg : string);
    begin
      clrscr;
      Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
      readln;
      GRAFICO:=False;
    end;

begin
  GRAFICO:=True;
               (* REGISTA OS DRIVER GRAFICO DESEJADO *)
  if RegisterBGIdriver(@EGAVGADriver) < 0 then Abortar('EGA/VGA');
                 (* REGISTA AS FONTES GRAFICAS DESEJADAS *)
  if RegisterBGIfont(@BoldFont) < 0 then         Abortar('BOLD');
  if RegisterBGIfont(@TscrFont) < 0 then         Abortar('TSCR');

  (* INSTALAR DUAS FONTES *)
  BoldFonte:=installuserfont('BOLD');
  TscrFonte:=installuserfont('TSCR');

  GRDRIVER:=Detect;
  initgraph(GRDRIVER,GRMODE,'');
  ERRORCODE:=graphresult;
  if ERRORCODE <> grok then  Abortar ('ERRO:');

end;


(* DESENHA UM MOSTRADOR DO RELOGIO
 *)
procedure Mostrador;
var R,X,Y,XX,YY,N:integer;
    NUM,AJUSTEX,AJUSTEY:integer;
    SNUM,SA,SM,SD,DATA:string;
    A,M,D,DM:word;

begin
  (* CRIA-SE UMA TABELA DE SENOS E COSSENOS
     PARA CORRESPONDENCIA DOS ANGULOS
  *)
  for N:=0 to 59 do
  begin
    TCS[N]:=cos(pi/2+(N/30)*pi);
    TSN[N]:=sin(pi/2+(N/30)*pi);
  end;

  (* DESENHO DO MOSTRADOR *)
  setfillstyle(9,blue);bar(0,0,640,480);
  setcolor(white);circle(320,240,235);circle(320,240,210);
  setfillstyle(1,black);floodfill(320,240,white);
  setfillstyle(9,darkgray);floodfill(320,20,white);
  setlinestyle(0,0,3);setcolor(black);
  circle(320,17,2);circle(320,462,2);
  circle(98,240,2);circle(542,240,2);
  setcolor(white);setlinestyle(0,0,1);


  (* LINHAS E PONTOS *)
  for N:=0 to 59 do
  begin
    X:=320-round(160*TCS[N]);
    Y:=240-round(160*TSN[N]);
    XX:=320-round((160+30)*TCS[N]);
    YY:=240-round((160+30)*TSN[N]);
    circle(X,Y,1);
    if (N mod 15=0) then circle(X,Y,4)
    else if (N mod 5=0) then lineto(XX,YY);
  end;

  (* NUMEROS *)
  setcolor(lightblue);
  settextstyle(BoldFonte,0,4);
  outtextxy(125,200    ,'9');
  outtextxy(490,200    ,'3');
  outtextxy(310,385    ,'6');
  outtextxy(295,18     ,'12');

  (* CRONO *)
  settextstyle(TscrFonte,horizdir,4);
  outtextxy(270,140,'Crono');


  (* DATA *)
  getdate(A,M,D,DM);settextstyle(defaultfont,0,1);
  setcolor(blue);outtextxy(304,200,'-');outtextxy(328,200,'-');
  setcolor(red);str(D,SD);outtextxy(288,200,SD);
  setcolor(yellow);str(M,SM);outtextxy(312,200,SM);
  setcolor(green);str(A,SA);outtextxy(336,200,copy(SA,3,2));

   (* CIRCULO INTERIOR *)
  setlinestyle(0,0,3);setcolor(blue);
  circle(320,240,2);circle(320,240,4);


  setcolor(lightgreen);settextstyle(0,0,1);outtextxy(8,470,'Rui Gil 93');

  (* PRIMEIRA VEZ *)
  VEZ:=1;

  HOR:=24;MIN:=60;SEG:=60;

end;

(* DESENHO DOS PONTEIROS DA SEGUINTE MANEIRA
   QUANDO O NUMERO MUDA DESENHA-SE UMA LINHA
*)
procedure Desenha(HO,MI,SE:word);
var HOVER,MOVER,SOVER:integer; (* ANGULO DA LINHA A PRETO *)
    X,Y,X0,Y0,X1,Y1,R:integer;
    HAUX:integer;

begin
  HAUX:=HO;
  if HAUX >=12 then HAUX:=HAUX-12; (* LIMITA-SE AS HORAS DE 0 A 12    *)
  HAUX:=HAUX*5+MI div 12;          (* E 1/5 DA VELOCIDADE DOS MINUTOS *)

  if SEG<>SE then
  begin
    R:=150;setlinestyle(0,0,1);
    if SE=0 then SOVER:=59 else SOVER:=SE-1;
    setcolor(green);

    if VEZ<>1 then
    begin
      X0:=320-round(R*TCS[SOVER]);
      Y0:=240-round(R*TSN[SOVER]);     (* ANGULO ANTERIOR *)
      X:=320-round(10*TCS[SOVER]);
      Y:=240-round(10*TSN[SOVER]);
      line(X,Y,X0,Y0);
    end;

    X1:=320-round(R*TCS[SE]);
    Y1:=240-round(R*TSN[SE]);        (* ANGULO PRESENTE *)
    X:=320-round(10*TCS[SE]);
    Y:=240-round(10*TSN[SE]);
    line(X,Y,X1,Y1);

    sound(10000);delay(1);nosound;
  end;

  if MIN<>MI then
  begin
    R:=130;setlinestyle(0,0,3);
    if MI=0 then MOVER:=59 else MOVER:=MI-1;
    setcolor(yellow);

    if VEZ<>1 then
    begin
      X0:=320-round(R*TCS[MOVER]);
      Y0:=240-round(R*TSN[MOVER]);
      X:=320-round(10*TCS[MOVER]);
      Y:=240-round(10*TSN[MOVER]);
      line(X,Y,X0,Y0);
    end;

    X1:=320-round(R*TCS[MI]);
    Y1:=240-round(R*TSN[MI]);
    X:=320-round(10*TCS[MI]);
    Y:=240-round(10*TSN[MI]);
    line(X,Y,X1,Y1);
  end;

  if HOR<>HO then
  begin
    R:=100;setlinestyle(0,0,3);
    if HAUX=0 then HOVER:=59 else HOVER:=HAUX-1;
    setcolor(red);

    if VEZ<>1 then
    begin
      X0:=320-round(R*TCS[HOVER]);
      Y0:=240-round(R*TSN[HOVER]);
      X:=320-round(10*TCS[HOVER]);
      Y:=240-round(10*TSN[HOVER]);
      line(X,Y,X0,Y0);
    end;

    X1:=320-round(R*TCS[HAUX]);
    Y1:=240-round(R*TSN[HAUX]);
    X:=320-round(10*TCS[HAUX]);
    Y:=240-round(10*TSN[HAUX]);
    line(X,Y,X1,Y1);
  end;

  HOR:=HO;MIN:=MI;SEG:=SE;
  VEZ:=2;
end;

(* PROGRAMA PRINCIPAL DO ANALOGICO *)
begin
  Modo_Grafico;
  if GRAFICO then
  begin
    Mostrador;
    setwritemode(XORput);
    repeat
      gettime(HORAS,MINUTOS,SEGUNDOS,C); (* LÒ AS HORAS DO D O S *)
      Desenha(HORAS,MINUTOS,SEGUNDOS);   (* E DESENHA-AS         *)
    until keypressed;
    if Keypressed then TEC:=readkey;
    cleardevice;
    closegraph;(* FECHA O MODO GRAFICO *)
  end;
end;



(* RELOGIO DIGITAL EM MODO TEXTO E COM AS SEGUINTES OPCOES
   ACERTO DA HORA
   ACERTO DA DATA
*)
procedure Digital;

(* PERMITE POR UM NUMERO NO ECRAN COMPOSTO COM
   CARACTERES ASCII
*)
procedure Numero(N,X,Y:integer);

(* NUMERO UM *)
Procedure Um(X1,Y1 :integer);
begin
  gotoxy(X1,Y1);  write('  ²  ');
  gotoxy(X1,Y1+1);write(' ²²  ');
  gotoxy(X1,Y1+2);write('² ²  ');
  gotoxy(X1,Y1+3);write('  ²  ');
  gotoxy(X1,Y1+4);write('  ²  ');
  gotoxy(X1,Y1+5);write('  ²  ');
  gotoxy(X1,Y1+6);write('²²²²²');
end;

(* NUMERO DOIS *)
Procedure Dois(X2,Y2:integer);
begin
  gotoxy(X2,Y2);  write(' ²²² ');
  gotoxy(X2,Y2+1);write('²   ²');
  gotoxy(X2,Y2+2);write('    ²');
  gotoxy(X2,Y2+3);write('   ² ');
  gotoxy(X2,Y2+4);write('  ²  ');
  gotoxy(X2,Y2+5);write(' ²   ');
  gotoxy(X2,Y2+6);write('²²²²²');
end;

(* NUMERO TRES *)
Procedure Tres(X3,Y3:integer);
begin
  gotoxy(X3,Y3);  write(' ²²² ');
  gotoxy(X3,Y3+1);write('²   ²');
  gotoxy(X3,Y3+2);write('    ²');
  gotoxy(X3,Y3+3);write('  ²² ');
  gotoxy(X3,Y3+4);write('    ²');
  gotoxy(X3,Y3+5);write('²   ²');
  gotoxy(X3,Y3+6);write(' ²²² ');
end;

(* NUMERO QUATRO *)
Procedure Quatro(X4,Y4:integer);
begin
  gotoxy(X4,Y4);  write('   ² ');
  gotoxy(X4,Y4+1);write('  ²  ');
  gotoxy(X4,Y4+2);write(' ²   ');
  gotoxy(X4,Y4+3);write('²  ² ');
  gotoxy(X4,Y4+4);write('²²²²²');
  gotoxy(X4,Y4+5);write('   ² ');
  gotoxy(X4,Y4+6);write('   ² ');
end;

(* NUMERO CINCO *)
Procedure Cinco(X5,Y5:integer);
begin
  gotoxy(X5,Y5);  write('²²²² ');
  gotoxy(X5,Y5+1);write('²    ');
  gotoxy(X5,Y5+2);write('²    ');
  gotoxy(X5,Y5+3);write('²²²² ');
  gotoxy(X5,Y5+4);write('    ²');
  gotoxy(X5,Y5+5);write('²   ²');
  gotoxy(X5,Y5+6);write(' ²²² ');
end;

(* NUMERO SEIS *)
Procedure Seis(X6,Y6:integer);
begin
  gotoxy(X6,Y6);  write(' ²²² ');
  gotoxy(X6,Y6+1);write('²   ²');
  gotoxy(X6,Y6+2);write('²    ');
  gotoxy(X6,Y6+3);write('²²²² ');
  gotoxy(X6,Y6+4);write('²   ²');
  gotoxy(X6,Y6+5);write('²   ²');
  gotoxy(X6,Y6+6);write(' ²²² ');
end;

(* NUMERO SETE *)
Procedure Sete(X7,Y7:integer);
begin
  gotoxy(X7,Y7);  write('²²²²²');
  gotoxy(X7,Y7+1);write('    ²');
  gotoxy(X7,Y7+2);write('   ² ');
  gotoxy(X7,Y7+3);write('  ²  ');
  gotoxy(X7,Y7+4);write(' ²   ');
  gotoxy(X7,Y7+5);write('²    ');
  gotoxy(X7,Y7+6);write('²    ');
end;

(* NUMERO OITO *)
Procedure Oito(X8,Y8:integer);
begin
  gotoxy(X8,Y8);  write(' ²²² ');
  gotoxy(X8,Y8+1);write('²   ²');
  gotoxy(X8,Y8+2);write('²   ²');
  gotoxy(X8,Y8+3);write(' ²²² ');
  gotoxy(X8,Y8+4);write('²   ²');
  gotoxy(X8,Y8+5);write('²   ²');
  gotoxy(X8,Y8+6);write(' ²²² ');
end;

(* NUMERO NOVE *)
Procedure Nove(X9,Y9:integer);
begin
  gotoxy(X9,Y9);  write(' ²²² ');
  gotoxy(X9,Y9+1);write('²   ²');
  gotoxy(X9,Y9+2);write('²   ²');
  gotoxy(X9,Y9+3);write(' ²²²²');
  gotoxy(X9,Y9+4);write('    ²');
  gotoxy(X9,Y9+5);write('²   ²');
  gotoxy(X9,Y9+6);write(' ²²² ');
end;

(* NUMERO ZERO *)
Procedure Zero(X0,Y0:integer);
begin
  gotoxy(X0,Y0);  write(' ²²² ');
  gotoxy(X0,Y0+1);write('²   ²');
  gotoxy(X0,Y0+2);write('²   ²');
  gotoxy(X0,Y0+3);write('²   ²');
  gotoxy(X0,Y0+4);write('²   ²');
  gotoxy(X0,Y0+5);write('²   ²');
  gotoxy(X0,Y0+6);write(' ²²² ');
end;

(* PROGRAMA PRINCIPAL DO NUMERO *)
begin
  case N of
    1:Um    (X,Y);
    2:Dois  (X,Y);
    3:Tres  (X,Y);
    4:Quatro(X,Y);
    5:Cinco (X,Y);
    6:Seis  (X,Y);
    7:Sete  (X,Y);
    8:Oito  (X,Y);
    9:Nove  (X,Y);
    0:Zero  (X,Y);
  end;
end;

(* DECOMPåE OS NUMEROS EM DEZENAS E UNIDADES PARA
   UTILIZAR O PROCEDIMENTO NUMERO
   COM UMA DETERMINADA POSI€ÇO E COR
*)
procedure Decomp(NUM:word;XD,XU:integer;COR:word);
var DEZENAS,UNIDADES:integer;

begin
   textcolor(COR);
   DEZENAS:=NUM div 10;
   UNIDADES:=NUM mod 10;
   Numero(DEZENAS,XD,9);
   Numero(UNIDADES,XU,9);
end;

(* MENU PARTICULAR DO RELOGIO DIGITAL
   TRANFORMA O MES E O DIA DA SEMANA NUMA STRING
   E ESCREVE A DATA
*)
procedure Menu;
var DIA,MES,ANO,DIASEMANA:word;
    DS,MS:string;
    COLUNA,LINHA:integer;

begin
  Cursor(OFF);
  textbackground(black);
  textcolor(blue);
  for COLUNA:=1 to 80 do for LINHA:=1 to 24 do
  begin
    gotoxy(COLUNA,LINHA);write('²');
  end;
  textcolor(black);

  for COLUNA:=15 to 65 do for LINHA:=5 to 20 do
  begin
    gotoxy(COLUNA,LINHA);write('Û');
  end;
  textcolor(darkgray);textbackground(black);
  for COLUNA:=15 to 65 do
  begin
    gotoxy(COLUNA,5);write('²');
    gotoxy(COLUNA,20);write('²');
  end;
  for LINHA:=5 to 20 do
  begin
    gotoxy(14,LINHA);write('²²');
    gotoxy(65,LINHA);write('²²');
  end;
  getdate(ANO,MES,DIA,DIASEMANA);
  case MES of
    1: MS:='JANEIRO';
    2: MS:='FEVEREIRO';
    3: MS:='MAR€O';
    4: MS:='ABRIL';
    5: MS:='MAIO';
    6: MS:='JUNHO';
    7: MS:='JULHO';
    8: MS:='AGOSTO';
    9: MS:='SETEMBRO';
   10: MS:='OUTUBRO';
   11: MS:='NOVEMBRO';
   12: MS:='DEZEMBRO';
  end;
  case DIASEMANA of
    0: DS:='DOMINGO';
    1: DS:='SEGUNDA';
    2: DS:='TER€A';
    3: DS:='QUARTA';
    4: DS:='QUINTA';
    5: DS:='SEXTA';
    6: DS:='SABADO';
  end;
  textcolor(lightgreen);
  gotoxy(33,18);write('H     D');
  gotoxy(50,18);write('A');
  gotoxy(22,18);write ('S');
  gotoxy(21,17); write('OPCAO : ');
  gotoxy(1,25);write(#184+' Rui Gil 1993 ');

  textcolor (yellow);
  gotoxy(23,18);write ('air');
  gotoxy(34,18);write('oras');
  gotoxy(40,18);write('ata    ');
  gotoxy(51,18);write('nalogico');

  textcolor(red);
  gotoxy(34,17);write('-ACERTO-');
  gotoxy(50,17);write('-RELOGIO-');

  textcolor(lightblue);
  gotoxy(26,7);write(DS,' , ',DIA,' DE ',MS,' DE ',ANO,'    ');
  gotoxy(32,11);write('²');
  gotoxy(48,11);write('²');
  gotoxy(32,14);write('²');
  gotoxy(48,14);write('²');
end;


(* FUNCAO QUE LE UM VALOR . ACEITA UMA MENSAGEM E UM NUMERO
   A MENSAGEM E AQUILO QUE SE PEDE
   O NUMERO E O TAMANHO MAXIMO DAQUILO QUE SE PEDE
   RETORNA UM INTEIRO
*)
function Le_Teclas(MSG:string;L:integer):integer;
var SNUM:string;
    NUM:integer;
    ERRO:integer;

begin
  SNUM:='';
  gotoxy(33,18);write('            ');
  repeat
    gotoxy(33,18);write(MSG+SNUM); (* ESCREVE A STRING *)
    repeat TEC:=readkey;   (* LER AS TECLAS DOS NUMEROS *)
    until TEC in ['1','2','3','4','5','6','7','8','9','0',#13];
    if TEC<>#13 then SNUM:=SNUM+TEC; (* CONTRUCAO DA STRING DO NUMERO *)
  until (length (SNUM)>=L) or (TEC=#13); (* ATE SER IGUAL AO COMPRIMENTO LIMITE OU A TECLA ENTER *)
  val(SNUM,NUM,ERRO); (* TRANSFORMA UMA STRING EM UM NUMERO SE FOR POSSIVEL SENAO DA ERRO *)
  gotoxy(33,18);write(MSG+SNUM);
  delay(250);
  Le_Teclas:=NUM; (* RESULTADO *)
end;


(* ACERTA AS HORAS E OS MINUTOS UTILIZANDO A FUNCAO QUE  LE AS TECLAS
   OS SEGUNDOS E OS CENTESIMOS SAO REPOSTOS A ZERO
*)
procedure Acerta_Horas;
var HOR,MIN,SEG,CEN:word;

begin
  Cursor(BIG);

  HOR:=Le_Teclas('HORAS ? ',2);
  MIN:=Le_Teclas('MINUTOS ? ',2);
  SEG:=Le_Teclas('SEGUNDOS ? ',2);

  CEN:=0;
  settime(HOR,MIN,SEG,CEN);
  Cursor(OFF);
end;

(* ACERTA A DATA  DIA-MES-ANO UTILIZANDO A FUNCAO QUE LE AS TECLAS
*)
procedure Acerta_Data;
var DIA,MES,ANO:integer;

begin
  Cursor(BIG);

  DIA:=Le_Teclas('DIA ? ',2);
  MES:=Le_Teclas('MˆS ? ',2);
  ANO:=Le_Teclas('ANO ? ',4);

  setdate(ANO,MES,DIA);
  Cursor(OFF);
end;

(* PROGRAMA PRINCIPAL DO RELOGIO DIGITAL
*)
begin
  Cursor(OFF);
  repeat
    Menu;
    repeat
      gettime(HORAS,MINUTOS,SEGUNDOS,C);
      Decomp(HORAS,19,25,red);
      Decomp(MINUTOS,35,41,yellow);
      Decomp(SEGUNDOS,51,57,green);
      if keypressed then
      begin
        TEC:=readkey;
        TEC:=upcase(TEC);
      end;
    until TEC in ['S','H','D','A'];
    case TEC of
      'H':Acerta_Horas;
      'D':Acerta_Data;
    end;
  until (TEC='S') or (TEC='A');
end;

(* FINAL DO PROGRAMA
*)
procedure fim;
begin
  Cursor(ON);
  lowvideo;
  textcolor(white);
  textbackground(black);
  clrscr;
  SAIR:=true;
end;


(* INICIA O RELOGIO ESCOLHIDO
   PERMITE SAIR
*)
procedure relogio;
begin
  digital;
  if TEC='A' then Analogico;
  if TEC='S' then fim;
end;

(****************************************************************************)
(*                        PROGRAMA  PRINCIPAL                               *)
(****************************************************************************)
begin
  repeat Relogio until Sair;
end.
(****************************************************************************)