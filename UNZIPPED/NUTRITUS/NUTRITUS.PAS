{    Programa em Turbo Pascal 7.0 por    }
{         Isaac MSC  Mem Martins         }
{                                        }
{ Programado em 19/7/1994 para a revista }
{                                        }
{            SPOOLER Magazine            }
{                                        }
{  Originalmente o Nutritus.Exe tem as   }
{  fontes com os caract‚res portugueses  }
{                                        }
{ ATEN€ŽO:  Se esta ‚ a primeira vez que }
{ usa o Nutritus, fa‡a:                  }
{     Alt-O+C+C+K_Full+Enter+Alt-C+B     }
{                                        }

Program Nutritus;

uses
  Crt, Dos, Graph, Printer, Nutri2, Nutri21, Nutri22, Nutri3, Nutri33, KeyTTT5, StrnTTT5, MiscTTT5, WinTTT5, bgidriv, bgifont;
var
  GraphDriver : integer;
  GraphMode   : integer;
  MaxX, MaxY  : word;
  ErrorCode   : integer;
  MaxColor    : word;
  OldSaida    : Pointer;
  Ch, Ch0, Ch1, Ch2, Ch3, Ch4, Ch5: Char;
  Err : Char;
  Caixa : Char;
  Feito : Boolean;
  Ness : Char;
  Comp : String;
  Escolha : Char;
  Erro : Integer;
  E1, E2, E3, E4, E5, E6 : Boolean;
  LowMode, HighMode: Integer;
const c = #255;

{ Oÿ$F+ faz com que pr‚ definidamente exista uma vari vel, Pointer    }
{ que est  pr‚ definida: faz qualquer coisa se alguma outra acontecer }
{ Sem que seja preciso fazer uma rotina que chame uma Procedure ...   }
{ Pois j  foi pr‚ definido . }
{$F+}

{ Antes de sair de qualquer parte do programa, chama esta proc. }
procedure SairProc;
label 1,2;
var
  Ver : Word;
begin
  ExitProc := OldSaida;
  CloseGraph;
  if Err= 'E' then goto 1;
  writeln('Obrigado por ter utilizado o Nutritus,   ass.');
  writeln('                                             Isaac MSC');
  if Erro = 1 then writeln('Erro: a impressora n„o estava pronta...');
  goto 2;
1:writeln('Obrigado por ter tentado utilizar o Nutritus,   ass.');
  writeln('                                                    Isaac MSC');
2:writeln('');
  Ver := DosVersion;
  WriteLn('DOS vers„o ',Lo(Ver),'.',Hi(Ver));
end;
{$F-}

{ Se acontecer algum erro com as fontes, chama esta proc }
procedure Abort(Msg : string);
begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

{ Proc de inicializa‡„o }
procedure Inicializa;
label 1,2;
var Fil : Integer;
begin
  Erro := 1;
  E1 := False; E2 := False; E3 := False; E4 := False; E5 := False; E6 := False;
  DirectVideo := False; OldSaida := ExitProc; ExitProc := @SairProc;
  if (MemAvail div 1024) < 100 then E1 := True;
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then Abort('VGA');
  if RegisterBGIfont(@GothicFontProc) < 0 then Abort('Gothic');
  if RegisterBGIfont(@SansSerifFontProc) < 0 then Abort('SansSerif');
  if RegisterBGIfont(@SmallFontProc) < 0 then Abort('Small');
  if RegisterBGIfont(@TriplexFontProc) < 0 then Abort('Triplex');
  GraphDriver := 9;
  InitGraph(GraphDriver, GraphMode, '');
  ErrorCode := GraphResult;
  GetModeRange(GraphDriver, LowMode, HighMode);
  SetGraphMode(HighMode);
  if ErrorCode <> grOK then begin E5 := True; goto 1; end;
  goto 2;
1:Reset_Startup_Mode;
  Beep;
  Err:= 'E';
  Erro := 0;
  If E1 then Begin WriteLn(' ->  Erro 1: RAM Insuficiente, Necess ria: 448Kb'); Halt; end;
  Halt(1);
2:Randomize;
  MaxColor := GetMaxColor;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  Err:= ' ';
end;

{ Define o ecr„ }
procedure FullPort;
begin
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  SetViewPort(0, 0, MaxX, MaxY, ClipOn);
end;

{ Faz o risquinho … volta do ecr„ }
procedure Avolta;
var
  ViewPort : ViewPortType;
begin
  setbkcolor(7);
  setcolor(14);
  SetLineStyle(SolidLn, 0, NormWidth);
  GetViewSettings(ViewPort);
  with ViewPort do
    Rectangle(0, 0, x2-x1, y2-y1);
end;

{ Escreve o titulo do ecr„ no pr¡ncipio dele }
procedure Cima(Header : string);
begin
  ClearDevice;
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, TopText);
  FullPort;
  setcolor(8);
  OutTextXY(MaxX div 2+1, 3, Header);
  setcolor(15);
  outtextXY(maxx div 2, 2, header);
  SetViewPort(0, TextHeight('M')+4, MaxX, MaxY-(TextHeight('M')+4), ClipOn);
  Avolta;
  SetViewPort(1, TextHeight('M')+5, MaxX-1, MaxY-(TextHeight('M')+5), ClipOn);
end;

{ Escreve uma mensagem no fim do ecr„ }
procedure Baixo(Msg : string);
begin
  FullPort;
  SetTextStyle(DefaultFont, HorizDir, 1);
  SetTextJustify(CenterText, TopText);
  SetLineStyle(SolidLn, 0, NormWidth);
  SetFillStyle(EmptyFill, 0);
  Bar(0, MaxY-(TextHeight('M')+4), MaxX, MaxY);
  setcolor(14);
  Rectangle(0, MaxY-(TextHeight('M')+4), MaxX, MaxY);
  setcolor(8);
  OutTextXY(MaxX div 2+1, MaxY-(TextHeight('M')+1), Msg);
  setcolor(15);
  OutTextXY(MaxX div 2, MaxY-(TextHeight('M')+2), Msg);
  SetViewPort(1, TextHeight('M')+5, MaxX-1, MaxY-(TextHeight('M')+5), ClipOn);
end;

{ Faz o ecr„ de introdu‡„o }
procedure Intro;
begin
   Avolta;
   setcolor(15);
   line(138, 50, 502, 50);
   line(138, 50, 138, 150);
   setcolor(8);
   line(139, 150, 502, 150);
   line(502, 51, 502, 150);
   SetTextStyle(1, 0,8);
   setcolor(8);
   OutTextXY(162, 50, 'Nutritus');
   OutTextXY(161, 49, 'Nutritus');
   OutTextXY(160, 48, 'Nutritus');
   OutTextXY(159, 47, 'Nutritus');
   OutTextXY(158, 46, 'Nutritus');
   setcolor(15);
   OutTextXY(157, 45, 'Nutritus');
   SetTextStyle(0, 0,1);
   setcolor(8);
   OutTextXY(182, 470, '          Nutritus 1.0 programado em Pascal por Isaac MSC');
   setcolor(15);
   OutTextXY(181, 469, '          Nutritus 1.0 programado em Pascal por Isaac MSC');
   setcolor(15);
   arc(150,320,50,220,130);
   setcolor(8);
   arc(150,320,230,40,130);
   setcolor(15);
   arc(490,320,50,220,130);
   setcolor(8);
   arc(490,320,230,40,130);
   settextjustify(1,1);
   settextstyle(0,0,0);
   setcolor(1);
   outtextxy(150,220, 'Leite');
   outtextxy(150,240, 'Carne Ovo');
   outtextxy(150,260, 'Azeite Oleo Manteiga');
   outtextxy(150,280, 'P„o Milho Centeio Soja');
   outtextxy(150,300, 'Banana Pera Ameixa Ma‡„ Mel„o');
   outtextxy(150,330, 'Batata Cebola Couve Fava Tomate');
   outtextxy(150,350, 'Feij„o Gr„o A‡ucar Arroz Aveia');
   outtextxy(150,370, 'Margarina Banha Toucinho');
   outtextxy(150,390, 'Peixe Ovo');
   outtextxy(150,410, 'Iogurte');
   outtextxy(490,230, 'Parte edivel');
   outtextxy(490,250, 'Calorias');
   outtextxy(490,270, 'Gl¡cidos');
   outtextxy(490,290, 'L¡pidos');
   outtextxy(490,310, 'Proteinas');
   outtextxy(490,330, 'Colesterol');
   outtextxy(490,350, 'Celulose');
   outtextxy(490,370, 'Acidos gordos polinsaturados');
   outtextxy(490,390, 'Vitaminas');
   outtextxy(490,410, 'Minerais');
   DelayKey(15000);
end;

{ Faz a caixa 1 ligada }
procedure l1;
begin
  setfillstyle(1,1);
  bar(50,50,590,100);
  setcolor(8);
  line(50,50,590,50);
  line(50,50,50,100);
  line(51,51,589,51);
  line(51,51,51,99);
  setcolor(15);
  line(51,100,590,100);
  line(590,100,590,51);
  line(52,99,589,99);
  line(589,99,589,52);
  setcolor(8);
  outtextxy(319,52, 'Necessidades alimentares di rias');
  setcolor(9);
  outtextxy(318,51, 'Necessidades alimentares di rias');
end;

{ Faz a caixa 1 desligada }
procedure d1;
begin
  setfillstyle(1,1);
  bar(50,50,590,100);
  setcolor(15);
  line(50,50,590,50);
  line(50,50,50,100);
  line(51,51,589,51);
  line(51,51,51,99);
  setcolor(8);
  line(51,100,590,100);
  line(590,100,590,51);
  line(52,99,589,99);
  line(589,99,589,52);
  setcolor(8);
  outtextxy(321,54, 'Necessidades alimentares di rias');
  setcolor(15);
  outtextxy(320,53, 'Necessidades alimentares di rias');
end;

{ Faz a caixa 2 ligada }
procedure l2;
begin
  setfillstyle(1,1);
  bar(50,125,590,175);
  setcolor(8);
  line(50,125,590,125);
  line(50,125,50,175);
  line(51,126,589,126);
  line(51,126,51,174);
  setcolor(15);
  line(51,175,590,175);
  line(590,175,590,126);
  line(52,174,589,174);
  line(589,174,589,127);
  setcolor(8);
  outtextxy(319,127, 'Composi‡„o dos alimentos');
  setcolor(9);
  outtextxy(318,126, 'Composi‡„o dos alimentos');
end;

{ Faz a caixa 2 desligada }
procedure d2;
begin
  setfillstyle(1,1);
  bar(50,125,590,175);
  setcolor(15);
  line(50,125,590,125);
  line(50,125,50,175);
  line(51,126,589,126);
  line(51,126,51,174);
  setcolor(8);
  line(51,175,590,175);
  line(590,175,590,126);
  line(52,174,589,174);
  line(589,174,589,127);
  setcolor(8);
  outtextxy(321,129, 'Composi‡„o dos alimentos');
  setcolor(15);
  outtextxy(320,128, 'Composi‡„o dos alimentos');
end;

{ Faz a caixa 3 ligada }
procedure l3;
begin
  setfillstyle(1,1);
  bar(50,200,590,250);
  setcolor(8);
  line(50,200,590,200);
  line(50,200,50,250);
  line(51,201,589,201);
  line(51,201,51,249);
  setcolor(15);
  line(51,250,590,250);
  line(590,250,590,201);
  line(52,249,589,249);
  line(589,249,589,202);
  setcolor(8);
  outtextxy(319,202, 'Menu de Impress„o');
  setcolor(9);
  outtextxy(318,201, 'Menu de Impress„o');
end;

{ Faz a caixa 3 desligada }
procedure d3;
begin
  setfillstyle(1,1);
  bar(50,200,590,250);
  setcolor(15);
  line(50,200,590,200);
  line(50,200,50,250);
  line(51,201,589,201);
  line(51,201,51,249);
  setcolor(8);
  line(51,250,590,250);
  line(590,250,590,201);
  line(52,249,589,249);
  line(589,249,589,202);
  setcolor(8);
  outtextxy(321,204, 'Menu de Impress„o');
  setcolor(15);
  outtextxy(320,203, 'Menu de Impress„o');
end;

{ Faz a caixa 4 ligada }
procedure l4;
begin
  setfillstyle(1,1);
  bar(50,275,590,325);
  setcolor(8);
  line(50,275,590,275);
  line(50,275,50,325);
  line(51,276,589,276);
  line(51,276,51,324);
  setcolor(15);
  line(51,325,590,325);
  line(590,325,590,276);
  line(52,324,589,324);
  line(589,324,589,277);
  setcolor(8);
  outtextxy(319,277, 'Ajuda para o Nutritus');
  setcolor(9);
  outtextxy(318,276, 'Ajuda para o Nutritus');
end;

{ Faz a caixa 4 desligada }
procedure d4;
begin
  setfillstyle(1,1);
  bar(50,275,590,325);
  setcolor(15);
  line(50,275,590,275);
  line(50,275,50,325);
  line(51,276,589,276);
  line(51,276,51,324);
  setcolor(8);
  line(51,325,590,325);
  line(590,325,590,276);
  line(52,324,589,324);
  line(589,324,589,277);
  setcolor(8);
  outtextxy(321,279, 'Ajuda para o Nutritus');
  setcolor(15);
  outtextxy(320,278, 'Ajuda para o Nutritus');
end;

{ Faz a caixa 5 ligada }
procedure l5;
begin
  setfillstyle(1,1);
  bar(50,350,590,400);
  setcolor(8);
  line(50,350,590,350);
  line(50,350,50,400);
  line(51,351,589,351);
  line(51,351,51,399);
  setcolor(15);
  line(51,400,590,400);
  line(590,400,590,351);
  line(52,399,589,399);
  line(589,399,589,352);
  setcolor(8);
  outtextxy(319,352, 'Sair para o DOS');
  setcolor(9);
  outtextxy(318,351, 'Sair para o DOS');
end;

{ Faz a caixa 5 desligada }
procedure d5;
begin
  setfillstyle(1,1);
  bar(50,350,590,400);
  setcolor(15);
  line(50,350,590,350);
  line(50,350,50,400);
  line(51,351,589,351);
  line(51,351,51,399);
  setcolor(8);
  line(51,400,590,400);
  line(590,400,590,351);
  line(52,399,589,399);
  line(589,399,589,352);
  setcolor(8);
  outtextxy(321,354, 'Sair para o DOS');
  setcolor(15);
  outtextxy(320,353, 'Sair para o DOS');
end;

{ Limpa a zona das caixas e define qual a fonte a usar }
procedure Caixas;
begin
  setfillstyle(1,1);
  bar(50,50,590,100);
  bar(50,125,590,175);
  bar(50,200,590,250);
  bar(50,275,590,325);
  bar(50,350,590,400);
  settextstyle(1,0,0);
  settextjustify(1,2);
end;

{ Faz o exo-esqueleto do ecr„ Necessidades Alimentares Di rias }
procedure Exo;
begin
  settextstyle(2,0,5);
  settextjustify(0,1);
  Dita(20,84,  'Crian‡as e Adolescentes');
  Dita(30,100, ' 1 a 2  anos');
  Dita(30,116, ' 2 a 4  anos');
  Dita(30,132, ' 4 a 9  anos');
  Dita(30,148, '10 a 14 anos');
  Dita(30,164, '15 a 19 anos');
  Dita(20,180, 'Mulheres Adultas');
  Dita(30,196, 'Trabalho reduzido');
  Dita(30,212, 'Gravidez (6§ ao 9§ mˆs)');
  Dita(30,228, 'Aleita‡„o');
  Dita(20,244, 'Homens Adultos');
  Dita(30,260, 'Trabalho reduzido');
  Dita(30,276, 'Trabalho m‚dio');
  Dita(30,292, 'Trabalho pesado');
  Dita(20,308, 'Pessoas Idosas');
  settextjustify(1,1);
end;

{ Faz a p gina 1 do ecr„ Necessidades Alimentares Di rias }
procedure Ecra1;
begin
  setcolor(1);
  line(15,47,620,47);
  line(15,47,15,319);
  line(228,47,228,319);
  line(228,63,620,63);
  line(294,47,294,79);
  line(360,63,360,79);
  line(426,63,426,79);
  line(492,47,492,79);
  line(558,63,558,79);
  line(620,63,620,79);
  line(15,79,620,79);
  line(15,95,620,95);
  line(15,111,620,111);
  line(15,127,620,127);
  line(15,143,620,143);
  line(15,159,620,159);
  line(15,175,620,175);
  line(15,191,620,191);
  line(15,207,620,207);
  line(15,223,620,223);
  line(15,239,620,239);
  line(15,255,620,255);
  line(15,271,620,271);
  line(15,287,620,287);
  line(15,303,620,303);
  line(15,319,620,319);
  line(294,95,294,175);
  line(360,95,360,175);
  line(426,95,426,175);
  line(492,95,492,175);
  line(558,95,558,175);
  line(620,95,620,175);
  line(294,191,294,239);
  line(360,191,360,239);
  line(426,191,426,239);
  line(492,191,492,239);
  line(558,191,558,239);
  line(620,191,620,239);
  line(294,255,294,319);
  line(360,255,360,319);
  line(426,255,426,319);
  line(492,255,492,319);
  line(558,255,558,319);
  line(620,255,620,319);
  setcolor(15);
  line(16,48,621,48);
  line(16,48,16,320);
  line(229,48,229,320);
  line(229,64,621,64);
  line(295,48,295,80);
  line(361,64,361,80);
  line(427,64,427,80);
  line(493,48,493,80);
  line(559,64,559,80);
  line(621,64,621,80);
  line(16,80,621,80);
  line(16,96,621,96);
  line(16,112,621,112);
  line(16,128,621,128);
  line(16,144,621,144);
  line(16,160,621,160);
  line(16,176,621,176);
  line(16,192,621,192);
  line(16,208,621,208);
  line(16,224,621,224);
  line(16,240,621,240);
  line(16,256,621,256);
  line(16,272,621,272);
  line(16,288,621,288);
  line(16,304,621,304);
  line(16,320,621,320);
  line(295,96,295,176);
  line(361,96,361,176);
  line(427,96,427,176);
  line(493,96,493,176);
  line(559,96,559,176);
  line(621,96,621,176);
  line(295,192,295,240);
  line(361,192,361,240);
  line(427,192,427,240);
  line(493,192,493,240);
  line(559,192,559,240);
  line(621,192,621,240);
  line(295,256,295,320);
  line(361,256,361,320);
  line(427,256,427,320);
  line(493,256,493,320);
  line(559,256,559,320);
  line(621,256,621,320);
  settextstyle(2,0,5);
  settextjustify(1,1);
  Dita(395,52, 'Compostos organicos(em g)');
  settextjustify(0,1);
  Dita(497,52, 'Elementos minera');
  Dita(233,68, 'Calorias');
  Dita(299,68, 'Protidos');
  Dita(365,68, 'Lip¡dos');
  Dita(431,68, 'Gl¡cidos');
  Dita(497,68, 'F¢sforo');
  Dita(563,68, 'C lcio');
  settextjustify(2,2);
  dita(289,95, '880.0');
  dita(289,111, '1300.0');
  dita(289,127, '1900.0');
  dita(289,143, '2800.0');
  dita(289,159, '3000.0');
  dita(289,191, '2200.0');
  dita(289,207, '2500.0');
  dita(289,223, '2800.0');
  dita(289,255, '2400.0');
  dita(289,271, '2900.0');
  dita(289,287, '3400.0');
  dita(289,303, '1800.0');
  dita(355,95, '35.0');
  dita(355,111, '50.0');
  dita(355,127, '75.0');
  dita(355,143, '100.0');
  dita(355,159, '120.0');
  dita(355,191, '60.0');
  dita(355,207, '80.0');
  dita(355,223, '85.0');
  dita(355,255, '70.0');
  dita(355,271, '85.0');
  dita(355,287, '100.0');
  dita(355,303, '40.0');
  dita(421,95, '30.0');
  dita(421,111, '36.0');
  dita(421,127, '53.0');
  dita(421,143, '77.0');
  dita(421,159, '85.0');
  dita(421,191, '35.0');
  dita(421,207, '40.0');
  dita(421,223, '70.0');
  dita(421,255, '40.0');
  dita(421,271, '50.0');
  dita(421,287, '55.0');
  dita(421,303, '25.0');
  dita(487,95, '128.0');
  dita(487,111, '198.0');
  dita(487,127, '296.0');
  dita(487,143, '445.0');
  dita(487,159, '480.0');
  dita(487,191, '410.0');
  dita(487,207, '430.0');
  dita(487,223, '440.0');
  dita(487,255, '450.0');
  dita(487,271, '470.0');
  dita(487,287, '490.0');
  dita(487,303, '300.0');
  dita(553,95, '600.0');
  dita(553,111, '700.0');
  dita(553,127, '1000.0');
  dita(553,143, '1500.0');
  dita(553,159, '1700.0');
  dita(553,191, '1200.0');
  dita(553,207, '1400.0');
  dita(553,223, '1500.0');
  dita(553,255, '1300.0');
  dita(553,271, '1500.0');
  dita(553,287, '1700.0');
  dita(553,303, '1000.0');
  dita(615,95, '700.0');
  dita(615,111, '900.0');
  dita(615,127, '950.0');
  dita(615,143, '1300.0');
  dita(615,159, '1300.0');
  dita(615,191, '800.0');
  dita(615,207, '950.0');
  dita(615,223, '1100.0');
  dita(615,255, '900.0');
  dita(615,271, '950.0');
  dita(615,287, '1000.0');
  dita(615,303, '600.0');
end;

{ Faz a p gina 3 do ecr„ Necessidades Alimentares Di rias }
procedure Ecra3;
begin
  setcolor(1);
  line(15,47,620,47);
  line(15,47,15,319);
  line(228,47,228,319);
  line(228,63,620,63);
  line(294,63,294,79);
  line(360,63,360,79);
  line(426,47,426,79);
  line(492,63,492,79);
  line(558,63,558,79);
  line(620,47,620,79);
  line(15,79,620,79);
  line(15,95,620,95);
  line(15,111,620,111);
  line(15,127,620,127);
  line(15,143,620,143);
  line(15,159,620,159);
  line(15,175,620,175);
  line(15,191,620,191);
  line(15,207,620,207);
  line(15,223,620,223);
  line(15,239,620,239);
  line(15,255,620,255);
  line(15,271,620,271);
  line(15,287,620,287);
  line(15,303,620,303);
  line(15,319,620,319);
  line(294,95,294,175);
  line(360,95,360,175);
  line(426,95,426,175);
  line(492,95,492,175);
  line(558,95,558,175);
  line(620,95,620,175);
  line(294,191,294,239);
  line(360,191,360,239);
  line(426,191,426,239);
  line(492,191,492,239);
  line(558,191,558,239);
  line(620,191,620,239);
  line(294,255,294,319);
  line(360,255,360,319);
  line(426,255,426,319);
  line(492,255,492,319);
  line(558,255,558,319);
  line(620,255,620,319);
  setcolor(15);
  line(16,48,621,48);
  line(16,48,16,320);
  line(229,48,229,320);
  line(229,64,621,64);
  line(295,64,295,80);
  line(361,64,361,80);
  line(427,48,427,80);
  line(493,64,493,80);
  line(559,64,559,80);
  line(621,48,621,80);
  line(16,80,621,80);
  line(16,96,621,96);
  line(16,112,621,112);
  line(16,128,621,128);
  line(16,144,621,144);
  line(16,160,621,160);
  line(16,176,621,176);
  line(16,192,621,192);
  line(16,208,621,208);
  line(16,224,621,224);
  line(16,240,621,240);
  line(16,256,621,256);
  line(16,272,621,272);
  line(16,288,621,288);
  line(16,304,621,304);
  line(16,320,621,320);
  line(295,96,295,176);
  line(361,96,361,176);
  line(427,96,427,176);
  line(493,96,493,176);
  line(559,96,559,176);
  line(621,96,621,176);
  line(295,192,295,240);
  line(361,192,361,240);
  line(427,192,427,240);
  line(493,192,493,240);
  line(559,192,559,240);
  line(621,192,621,240);
  line(295,256,295,320);
  line(361,256,361,320);
  line(427,256,427,320);
  line(493,256,493,320);
  line(559,256,559,320);
  line(621,256,621,320);
  settextstyle(2,0,5);
  settextjustify(0,1);
  Dita(233,52, 'Compostos organicos(em g)');
  Dita(431,52, 'Elementos minerais(em mg)');
  Dita(233,68, 'Protidos');
  Dita(299,68, 'Lip¡dos');
  Dita(365,68, 'Gl¡cidos');
  Dita(431,68, 'F¢sforo');
  Dita(497,68, 'C lcio');
  Dita(563,68, 'Ferro');
  settextjustify(2,2);
  dita(289,95, '35.0');
  dita(289,111, '50.0');
  dita(289,127, '75.0');
  dita(289,143, '100.0');
  dita(289,159, '120.0');
  dita(289,191, '60.0');
  dita(289,207, '80.0');
  dita(289,223, '85.0');
  dita(289,255, '70.0');
  dita(289,271, '85.0');
  dita(289,287, '100.0');
  dita(289,303, '40.0');
  dita(355,95, '30.0');
  dita(355,111, '36.0');
  dita(355,127, '53.0');
  dita(355,143, '77.0');
  dita(355,159, '85.0');
  dita(355,191, '35.0');
  dita(355,207, '40.0');
  dita(355,223, '70.0');
  dita(355,255, '40.0');
  dita(355,271, '50.0');
  dita(355,287, '55.0');
  dita(355,303, '25.0');
  dita(421,95, '128.0');
  dita(421,111, '198.0');
  dita(421,127, '296.0');
  dita(421,143, '445.0');
  dita(421,159, '480.0');
  dita(421,191, '410.0');
  dita(421,207, '430.0');
  dita(421,223, '440.0');
  dita(421,255, '450.0');
  dita(421,271, '470.0');
  dita(421,287, '490.0');
  dita(421,303, '300.0');
  dita(487,95, '600.0');
  dita(487,111, '700.0');
  dita(487,127, '1000.0');
  dita(487,143, '1500.0');
  dita(487,159, '1700.0');
  dita(487,191, '1200.0');
  dita(487,207, '1400.0');
  dita(487,223, '1500.0');
  dita(487,255, '1300.0');
  dita(487,271, '1500.0');
  dita(487,287, '1700.0');
  dita(487,303, '1000.0');
  dita(553,95, '700.0');
  dita(553,111, '900.0');
  dita(553,127, '950.0');
  dita(553,143, '1300.0');
  dita(553,159, '1300.0');
  dita(553,191, '800.0');
  dita(553,207, '950.0');
  dita(553,223, '1100.0');
  dita(553,255, '900.0');
  dita(553,271, '950.0');
  dita(553,287, '1000.0');
  dita(553,303, '600.0');
  dita(615,95, '6.0');
  dita(615,111, '8.0');
  dita(615,127, '13.0');
  dita(615,143, '18.0');
  dita(615,159, '18.0');
  dita(615,191, '15.0');
  dita(615,207, '20.0');
  dita(615,223, '18.0');
  dita(615,255, '15.0');
  dita(615,271, '18.0');
  dita(615,287, '20.0');
  dita(615,303, '10.0');
end;

{ Faz a p gina 4 do ecr„ Necessidades Alimentares Di rias }
procedure Ecra4;
begin
  setcolor(1);
  line(15,47,620,47);
  line(15,47,15,319);
  line(228,47,228,319);
  line(228,63,620,63);
  line(294,63,294,79);
  line(360,47,360,79);
  line(426,63,426,79);
  line(492,63,492,79);
  line(558,47,558,79);
  line(620,63,620,79);
  line(15,79,620,79);
  line(15,95,620,95);
  line(15,111,620,111);
  line(15,127,620,127);
  line(15,143,620,143);
  line(15,159,620,159);
  line(15,175,620,175);
  line(15,191,620,191);
  line(15,207,620,207);
  line(15,223,620,223);
  line(15,239,620,239);
  line(15,255,620,255);
  line(15,271,620,271);
  line(15,287,620,287);
  line(15,303,620,303);
  line(15,319,620,319);
  line(294,95,294,175);
  line(360,95,360,175);
  line(426,95,426,175);
  line(492,95,492,175);
  line(558,95,558,175);
  line(620,95,620,175);
  line(294,191,294,239);
  line(360,191,360,239);
  line(426,191,426,239);
  line(492,191,492,239);
  line(558,191,558,239);
  line(620,191,620,239);
  line(294,255,294,319);
  line(360,255,360,319);
  line(426,255,426,319);
  line(492,255,492,319);
  line(558,255,558,319);
  line(620,255,620,319);
  setcolor(15);
  line(16,48,621,48);
  line(16,48,16,320);
  line(229,48,229,320);
  line(229,64,621,64);
  line(295,64,295,80);
  line(361,48,361,80);
  line(427,64,427,80);
  line(493,64,493,80);
  line(559,48,559,80);
  line(621,64,621,80);
  line(16,80,621,80);
  line(16,96,621,96);
  line(16,112,621,112);
  line(16,128,621,128);
  line(16,144,621,144);
  line(16,160,621,160);
  line(16,176,621,176);
  line(16,192,621,192);
  line(16,208,621,208);
  line(16,224,621,224);
  line(16,240,621,240);
  line(16,256,621,256);
  line(16,272,621,272);
  line(16,288,621,288);
  line(16,304,621,304);
  line(16,320,621,320);
  line(295,96,295,176);
  line(361,96,361,176);
  line(427,96,427,176);
  line(493,96,493,176);
  line(559,96,559,176);
  line(621,96,621,176);
  line(295,192,295,240);
  line(361,192,361,240);
  line(427,192,427,240);
  line(493,192,493,240);
  line(559,192,559,240);
  line(621,192,621,240);
  line(295,256,295,320);
  line(361,256,361,320);
  line(427,256,427,320);
  line(493,256,493,320);
  line(559,256,559,320);
  line(621,256,621,320);
  settextstyle(2,0,5);
  settextjustify(0,1);
  Dita(233,52, ' organicos(em g)');
  Dita(365,52, 'Elementos minerais(em mg)');
  Dita(233,68, 'Lip¡dos');
  Dita(299,68, 'Gl¡cidos');
  Dita(365,68, 'F¢sforo');
  Dita(431,68, 'C lcio');
  Dita(497,68, 'Ferro');
  Dita(563,68, ' C');
  settextjustify(2,2);
  dita(289,95, '30.0');
  dita(289,111, '36.0');
  dita(289,127, '53.0');
  dita(289,143, '77.0');
  dita(289,159, '85.0');
  dita(289,191, '35.0');
  dita(289,207, '40.0');
  dita(289,223, '70.0');
  dita(289,255, '40.0');
  dita(289,271, '50.0');
  dita(289,287, '55.0');
  dita(289,303, '25.0');
  dita(355,95, '128.0');
  dita(355,111, '198.0');
  dita(355,127, '296.0');
  dita(355,143, '445.0');
  dita(355,159, '480.0');
  dita(355,191, '410.0');
  dita(355,207, '430.0');
  dita(355,223, '440.0');
  dita(355,255, '450.0');
  dita(355,271, '470.0');
  dita(355,287, '490.0');
  dita(355,303, '300.0');
  dita(421,95, '600.0');
  dita(421,111, '700.0');
  dita(421,127, '1000.0');
  dita(421,143, '1500.0');
  dita(421,159, '1700.0');
  dita(421,191, '1200.0');
  dita(421,207, '1400.0');
  dita(421,223, '1500.0');
  dita(421,255, '1300.0');
  dita(421,271, '1500.0');
  dita(421,287, '1700.0');
  dita(421,303, '1000.0');
  dita(487,95, '700.0');
  dita(487,111, '900.0');
  dita(487,127, '950.0');
  dita(487,143, '1300.0');
  dita(487,159, '1300.0');
  dita(487,191, '800.0');
  dita(487,207, '950.0');
  dita(487,223, '1100.0');
  dita(487,255, '900.0');
  dita(487,271, '950.0');
  dita(487,287, '1000.0');
  dita(487,303, '600.0');
  dita(553,95, '6.0');
  dita(553,111, '8.0');
  dita(553,127, '13.0');
  dita(553,143, '18.0');
  dita(553,159, '18.0');
  dita(553,191, '15.0');
  dita(553,207, '20.0');
  dita(553,223, '18.0');
  dita(553,255, '15.0');
  dita(553,271, '18.0');
  dita(553,287, '20.0');
  dita(553,303, '10.0');
  dita(615,95, '30.0');
  dita(615,111, '40.0');
  dita(615,127, '60.0');
  dita(615,143, '90.0');
  dita(615,159, '100.0');
  dita(615,191, '60.0');
  dita(615,207, '90.0');
  dita(615,223, '110.0');
  dita(615,255, '70.0');
  dita(615,271, '80.0');
  dita(615,287, '100.0');
  dita(615,303, '60.0');
end;

{ Faz a p gina 5 do ecr„ Necessidades Alimentares Di rias }
procedure Ecra5;
begin
  setcolor(1);
  line(15,47,620,47);
  line(15,47,15,319);
  line(228,47,228,319);
  line(228,63,620,63);
  line(294,47,294,79);
  line(360,63,360,79);
  line(426,63,426,79);
  line(492,47,492,79);
  line(558,63,558,79);
  line(620,63,620,79);
  line(15,79,620,79);
  line(15,95,620,95);
  line(15,111,620,111);
  line(15,127,620,127);
  line(15,143,620,143);
  line(15,159,620,159);
  line(15,175,620,175);
  line(15,191,620,191);
  line(15,207,620,207);
  line(15,223,620,223);
  line(15,239,620,239);
  line(15,255,620,255);
  line(15,271,620,271);
  line(15,287,620,287);
  line(15,303,620,303);
  line(15,319,620,319);
  line(294,95,294,175);
  line(360,95,360,175);
  line(426,95,426,175);
  line(492,95,492,175);
  line(558,95,558,175);
  line(620,95,620,175);
  line(294,191,294,239);
  line(360,191,360,239);
  line(426,191,426,239);
  line(492,191,492,239);
  line(558,191,558,239);
  line(620,191,620,239);
  line(294,255,294,319);
  line(360,255,360,319);
  line(426,255,426,319);
  line(492,255,492,319);
  line(558,255,558,319);
  line(620,255,620,319);
  setcolor(15);
  line(16,48,621,48);
  line(16,48,16,320);
  line(229,48,229,320);
  line(229,64,621,64);
  line(295,48,295,80);
  line(361,64,361,80);
  line(427,64,427,80);
  line(493,48,493,80);
  line(559,64,559,80);
  line(621,64,621,80);
  line(16,80,621,80);
  line(16,96,621,96);
  line(16,112,621,112);
  line(16,128,621,128);
  line(16,144,621,144);
  line(16,160,621,160);
  line(16,176,621,176);
  line(16,192,621,192);
  line(16,208,621,208);
  line(16,224,621,224);
  line(16,240,621,240);
  line(16,256,621,256);
  line(16,272,621,272);
  line(16,288,621,288);
  line(16,304,621,304);
  line(16,320,621,320);
  line(295,96,295,176);
  line(361,96,361,176);
  line(427,96,427,176);
  line(493,96,493,176);
  line(559,96,559,176);
  line(621,96,621,176);
  line(295,192,295,240);
  line(361,192,361,240);
  line(427,192,427,240);
  line(493,192,493,240);
  line(559,192,559,240);
  line(621,192,621,240);
  line(295,256,295,320);
  line(361,256,361,320);
  line(427,256,427,320);
  line(493,256,493,320);
  line(559,256,559,320);
  line(621,256,621,320);
  settextstyle(2,0,5);
  settextjustify(0,1);
  Dita(233,52, 's(em mg)');
  Dita(299,52, 'Elementos minerais(em mg)');
  Dita(563,52, 'Vitamina');
  Dita(233,68, 'Glicidos');
  Dita(299,68, 'F¢sforo');
  Dita(365,68, 'C lcio');
  Dita(431,68, 'Ferro');
  Dita(497,68, ' C');
  Dita(563,68, 'B1 e B2');
  settextjustify(2,2);
  dita(289,95, '128.0');
  dita(289,111, '198.0');
  dita(289,127, '296.0');
  dita(289,143, '445.0');
  dita(289,159, '480.0');
  dita(289,191, '410.0');
  dita(289,207, '430.0');
  dita(289,223, '440.0');
  dita(289,255, '450.0');
  dita(289,271, '470.0');
  dita(289,287, '490.0');
  dita(289,303, '300.0');
  dita(355,95, '600.0');
  dita(355,111, '700.0');
  dita(355,127, '1000.0');
  dita(355,143, '1500.0');
  dita(355,159, '1700.0');
  dita(355,191, '1200.0');
  dita(355,207, '1400.0');
  dita(355,223, '1500.0');
  dita(355,255, '1300.0');
  dita(355,271, '1500.0');
  dita(355,287, '1700.0');
  dita(355,303, '1000.0');
  dita(421,95, '700.0');
  dita(421,111, '900.0');
  dita(421,127, '950.0');
  dita(421,143, '1300.0');
  dita(421,159, '1300.0');
  dita(421,191, '800.0');
  dita(421,207, '950.0');
  dita(421,223, '1100.0');
  dita(421,255, '900.0');
  dita(421,271, '950.0');
  dita(421,287, '1000.0');
  dita(421,303, '600.0');
  dita(487,95, '6.0');
  dita(487,111, '8.0');
  dita(487,127, '13.0');
  dita(487,143, '18.0');
  dita(487,159, '18.0');
  dita(487,191, '15.0');
  dita(487,207, '20.0');
  dita(487,223, '18.0');
  dita(487,255, '15.0');
  dita(487,271, '18.0');
  dita(487,287, '20.0');
  dita(487,303, '10.0');
  dita(553,95, '30.0');
  dita(553,111, '40.0');
  dita(553,127, '60.0');
  dita(553,143, '90.0');
  dita(553,159, '100.0');
  dita(553,191, '60.0');
  dita(553,207, '90.0');
  dita(553,223, '110.0');
  dita(553,255, '70.0');
  dita(553,271, '80.0');
  dita(553,287, '100.0');
  dita(553,303, '60.0');
  dita(615,95, '1.2');
  dita(615,111, '2.0');
  dita(615,127, '2.5');
  dita(615,143, '3.6');
  dita(615,159, '4.0');
  dita(615,191, '2.0');
  dita(615,207, '3.5');
  dita(615,223, '3.5');
  dita(615,255, '2.4');
  dita(615,271, '2.8');
  dita(615,287, '3.2');
  dita(615,303, '2.0');
end;

{ Faz a p gina 6 do ecr„ Necessidades Alimentares Di rias }
procedure Ecra6;
begin
  setcolor(1);
  line(15,47,620,47);
  line(15,47,15,319);
  line(228,47,228,319);
  line(228,63,620,63);
  line(294,63,294,79);
  line(360,63,360,79);
  line(426,47,426,79);
  line(492,63,492,79);
  line(558,63,558,79);
  line(620,63,620,79);
  line(15,79,620,79);
  line(15,95,620,95);
  line(15,111,620,111);
  line(15,127,620,127);
  line(15,143,620,143);
  line(15,159,620,159);
  line(15,175,620,175);
  line(15,191,620,191);
  line(15,207,620,207);
  line(15,223,620,223);
  line(15,239,620,239);
  line(15,255,620,255);
  line(15,271,620,271);
  line(15,287,620,287);
  line(15,303,620,303);
  line(15,319,620,319);
  line(294,95,294,175);
  line(360,95,360,175);
  line(426,95,426,175);
  line(492,95,492,175);
  line(558,95,558,175);
  line(620,95,620,175);
  line(294,191,294,239);
  line(360,191,360,239);
  line(426,191,426,239);
  line(492,191,492,239);
  line(558,191,558,239);
  line(620,191,620,239);
  line(294,255,294,319);
  line(360,255,360,319);
  line(426,255,426,319);
  line(492,255,492,319);
  line(558,255,558,319);
  line(620,255,620,319);
  setcolor(15);
  line(16,48,621,48);
  line(16,48,16,320);
  line(229,48,229,320);
  line(229,64,621,64);
  line(295,64,295,80);
  line(361,64,361,80);
  line(427,48,427,80);
  line(493,64,493,80);
  line(559,64,559,80);
  line(621,64,621,80);
  line(16,80,621,80);
  line(16,96,621,96);
  line(16,112,621,112);
  line(16,128,621,128);
  line(16,144,621,144);
  line(16,160,621,160);
  line(16,176,621,176);
  line(16,192,621,192);
  line(16,208,621,208);
  line(16,224,621,224);
  line(16,240,621,240);
  line(16,256,621,256);
  line(16,272,621,272);
  line(16,288,621,288);
  line(16,304,621,304);
  line(16,320,621,320);
  line(295,96,295,176);
  line(361,96,361,176);
  line(427,96,427,176);
  line(493,96,493,176);
  line(559,96,559,176);
  line(621,96,621,176);
  line(295,192,295,240);
  line(361,192,361,240);
  line(427,192,427,240);
  line(493,192,493,240);
  line(559,192,559,240);
  line(621,192,621,240);
  line(295,256,295,320);
  line(361,256,361,320);
  line(427,256,427,320);
  line(493,256,493,320);
  line(559,256,559,320);
  line(621,256,621,320);
  settextstyle(2,0,5);
  settextjustify(0,1);
  Dita(233,52, 'Elementos minerais(em mg)');
  Dita(497,52, 'Vitaminas(em mg)');
  Dita(233,68, 'F¢sforo');
  Dita(299,68, 'C lcio');
  Dita(365,68, 'Ferro');
  Dita(431,68, ' C');
  Dita(497,68, 'B1 e B2');
  Dita(563,68, 'A+Pro.A');
  settextjustify(2,2);
  dita(289,95, '600.0');
  dita(289,111, '700.0');
  dita(289,127, '1000.0');
  dita(289,143, '1500.0');
  dita(289,159, '1700.0');
  dita(289,191, '1200.0');
  dita(289,207, '1400.0');
  dita(289,223, '1500.0');
  dita(289,255, '1300.0');
  dita(289,271, '1500.0');
  dita(289,287, '1700.0');
  dita(289,303, '1000.0');
  dita(355,95, '700.0');
  dita(355,111, '900.0');
  dita(355,127, '950.0');
  dita(355,143, '1300.0');
  dita(355,159, '1300.0');
  dita(355,191, '800.0');
  dita(355,207, '950.0');
  dita(355,223, '1100.0');
  dita(355,255, '900.0');
  dita(355,271, '950.0');
  dita(355,287, '1000.0');
  dita(355,303, '600.0');
  dita(421,95, '6.0');
  dita(421,111, '8.0');
  dita(421,127, '13.0');
  dita(421,143, '18.0');
  dita(421,159, '18.0');
  dita(421,191, '15.0');
  dita(421,207, '20.0');
  dita(421,223, '18.0');
  dita(421,255, '15.0');
  dita(421,271, '18.0');
  dita(421,287, '20.0');
  dita(421,303, '10.0');
  dita(487,95, '30.0');
  dita(487,111, '40.0');
  dita(487,127, '60.0');
  dita(487,143, '90.0');
  dita(487,159, '100.0');
  dita(487,191, '60.0');
  dita(487,207, '90.0');
  dita(487,223, '110.0');
  dita(487,255, '70.0');
  dita(487,271, '80.0');
  dita(487,287, '100.0');
  dita(487,303, '60.0');
  dita(553,95, '1.2');
  dita(553,111, '2.0');
  dita(553,127, '2.5');
  dita(553,143, '3.6');
  dita(553,159, '4.0');
  dita(553,191, '2.0');
  dita(553,207, '3.5');
  dita(553,223, '3.5');
  dita(553,255, '2.4');
  dita(553,271, '2.8');
  dita(553,287, '3.2');
  dita(553,303, '2.0');
  dita(615,95, '1.5');
  dita(615,111, '1.8');
  dita(615,127, '2.0');
  dita(615,143, '2.5');
  dita(615,159, '5.0');
  dita(615,191, '2.0');
  dita(615,207, '2.6');
  dita(615,223, '4.0');
  dita(615,255, '2.0');
  dita(615,271, '2.5');
  dita(615,287, '3.0');
  dita(615,303, '1.5');
end;

{ Faz a p gina 7 do ecr„ Necessidades Alimentares Di rias }
procedure Ecra7;
begin
  setcolor(1);
  line(15,47,620,47);
  line(15,47,15,319);
  line(620,47,620,319);
  line(228,47,228,319);
  line(228,63,620,63);
  line(294,63,294,79);
  line(360,47,360,79);
  line(426,63,426,79);
  line(492,63,492,79);
  line(558,63,558,79);
  line(620,47,620,79);
  line(15,79,620,79);
  line(15,95,620,95);
  line(15,111,620,111);
  line(15,127,620,127);
  line(15,143,620,143);
  line(15,159,620,159);
  line(15,175,620,175);
  line(15,191,620,191);
  line(15,207,620,207);
  line(15,223,620,223);
  line(15,239,620,239);
  line(15,255,620,255);
  line(15,271,620,271);
  line(15,287,620,287);
  line(15,303,620,303);
  line(15,319,620,319);
  line(294,95,294,175);
  line(360,95,360,175);
  line(426,95,426,175);
  line(492,95,492,175);
  line(558,95,558,175);
  line(620,95,620,175);
  line(294,191,294,239);
  line(360,191,360,239);
  line(426,191,426,239);
  line(492,191,492,239);
  line(558,191,558,239);
  line(620,191,620,239);
  line(294,255,294,319);
  line(360,255,360,319);
  line(426,255,426,319);
  line(492,255,492,319);
  line(558,255,558,319);
  line(620,255,620,319);
  setcolor(15);
  line(16,48,621,48);
  line(16,48,16,320);
  line(621,48,621,320);
  line(229,48,229,320);
  line(229,64,621,64);
  line(295,64,295,80);
  line(361,48,361,80);
  line(427,64,427,80);
  line(493,64,493,80);
  line(559,64,559,80);
  line(621,48,621,80);
  line(16,80,621,80);
  line(16,96,621,96);
  line(16,112,621,112);
  line(16,128,621,128);
  line(16,144,621,144);
  line(16,160,621,160);
  line(16,176,621,176);
  line(16,192,621,192);
  line(16,208,621,208);
  line(16,224,621,224);
  line(16,240,621,240);
  line(16,256,621,256);
  line(16,272,621,272);
  line(16,288,621,288);
  line(16,304,621,304);
  line(16,320,621,320);
  line(295,96,295,176);
  line(361,96,361,176);
  line(427,96,427,176);
  line(493,96,493,176);
  line(559,96,559,176);
  line(621,96,621,176);
  line(295,192,295,240);
  line(361,192,361,240);
  line(427,192,427,240);
  line(493,192,493,240);
  line(559,192,559,240);
  line(621,192,621,240);
  line(295,256,295,320);
  line(361,256,361,320);
  line(427,256,427,320);
  line(493,256,493,320);
  line(559,256,559,320);
  line(621,256,621,320);
  settextstyle(2,0,5);
  settextjustify(0,1);
  Dita(233,52, ' minerais(em mg)');
  Dita(431,52, 'Vitaminas(em mg)');
  Dita(233,68, 'C lcio');
  Dita(299,68, 'Ferro');
  Dita(365,68, ' C');
  Dita(431,68, 'B1 e B2');
  Dita(497,68, 'A+Pro.A');
  Dita(563,68, ' D');
  settextjustify(2,2);
  dita(289,95, '700.0');
  dita(289,111, '900.0');
  dita(289,127, '950.0');
  dita(289,143, '1300.0');
  dita(289,159, '1300.0');
  dita(289,191, '800.0');
  dita(289,207, '950.0');
  dita(289,223, '1100.0');
  dita(289,255, '900.0');
  dita(289,271, '950.0');
  dita(289,289, '1000.0');
  dita(289,303, '600.0');
  dita(355,95, '6.0');
  dita(355,111, '8.0');
  dita(355,127, '13.0');
  dita(355,143, '18.0');
  dita(355,159, '18.0');
  dita(355,191, '15.0');
  dita(355,207, '20.0');
  dita(355,223, '18.0');
  dita(355,255, '15.0');
  dita(355,271, '18.0');
  dita(355,287, '20.0');
  dita(355,303, '10.0');
  dita(421,95, '30.0');
  dita(421,111, '40.0');
  dita(421,127, '60.0');
  dita(421,143, '90.0');
  dita(421,159, '100.0');
  dita(421,191, '60.0');
  dita(421,207, '90.0');
  dita(421,223, '110.0');
  dita(421,255, '70.0');
  dita(421,271, '80.0');
  dita(421,287, '100.0');
  dita(421,303, '60.0');
  dita(487,95, '1.2');
  dita(487,111, '2.0');
  dita(487,127, '2.5');
  dita(487,143, '3.6');
  dita(487,159, '4.0');
  dita(487,191, '2.0');
  dita(487,207, '3.5');
  dita(487,223, '3.5');
  dita(487,255, '2.4');
  dita(487,271, '2.8');
  dita(487,287, '3.2');
  dita(487,303, '2.0');
  dita(553,95, '1.5');
  dita(553,111, '1.8');
  dita(553,127, '2.0');
  dita(553,143, '2.5');
  dita(553,159, '5.0');
  dita(553,191, '2.0');
  dita(553,207, '2.6');
  dita(553,223, '4.0');
  dita(553,255, '2.0');
  dita(553,271, '2.5');
  dita(553,287, '3.0');
  dita(553,303, '1.5');
  dita(615,95, '0.02');
  dita(615,111, '0.02');
  dita(615,127, '0.02');
  dita(615,143, '0.02');
  dita(615,159, '0.01');
  dita(615,191, '0.01');
  dita(615,207, '0.02');
  dita(615,223, '0.02');
  dita(615,255, '0.01');
  dita(615,271, '0.02');
  dita(615,287, '0.02');
  dita(615,303, '0.05');
end;

{ Mostra qual ‚ a area vista no ecr„ Composi‡„o dos Alimentos }
procedure Status1(Stat : string);
begin
 setfillstyle(1,15);
 bar(568,360,600,445);
 setcolor(8);
 line(602,359,602,447);
 line(603,358,603,448);
 line(602,447,566,447);
 line(603,448,565,448);
 setcolor(15);
 line(566,358,566,447);
 line(565,357,565,448);
 line(566,358,602,358);
 line(565,357,603,357);
 setfillstyle(8,15);
 if Stat = '1' then
    bar(568,360,584,367);
 if Stat = '2' then
    bar(576,360,592,367);
 if Stat = '3' then
    bar(584,360,600,367);
 if Stat = '4' then
    bar(568,367,584,369);
 if Stat = '5' then
    bar(576,367,592,369);
 if Stat = '6' then
    bar(584,367,600,369);
 if Stat = '7' then
    bar(568,370,584,377);
 if Stat = '8' then
    bar(576,370,592,377);
 if Stat = '9' then
    bar(584,370,600,377);
 if Stat = '10' then
    bar(568,377,584,384);
 if Stat = '11' then
    bar(576,377,592,384);
 if Stat = '12' then
    bar(584,377,600,384);
 if Stat = '13' then
    bar(568,384,584,391);
 if Stat = '14' then
    bar(576,384,592,391);
 if Stat = '15' then
    bar(584,384,600,391);
 if Stat = '16' then
    bar(568,391,584,393);
 if Stat = '17' then
    bar(576,391,592,393);
 if Stat = '18' then
    bar(584,391,600,393);
 if Stat = '19' then
    bar(568,394,584,399);
 if Stat = '20' then
    bar(576,394,592,399);
 if Stat = '21' then
    bar(584,394,600,399);
 if Stat = '22' then
    bar(568,400,584,407);
 if Stat = '23' then
    bar(576,400,592,407);
 if Stat = '24' then
    bar(584,400,600,407);
 if Stat = '25' then
    bar(568,407,584,414);
 if Stat = '26' then
    bar(576,407,592,414);
 if Stat = '27' then
    bar(584,407,600,414);
 if Stat = '28' then
    bar(568,414,584,419);
 if Stat = '29' then
    bar(576,414,592,419);
 if Stat = '30' then
    bar(584,414,600,419);
 if Stat = '31' then
    bar(568,420,584,427);
 if Stat = '32' then
    bar(576,420,592,427);
 if Stat = '33' then
    bar(584,420,600,427);
 if Stat = '34' then
    bar(568,427,584,434);
 if Stat = '35' then
    bar(576,427,592,434);
 if Stat = '36' then
    bar(584,427,600,434);
 if Stat = '37' then
    bar(568,434,584,441);
 if Stat = '38' then
    bar(576,434,592,441);
 if Stat = '39' then
    bar(584,434,600,441);
 if Stat = '40' then
    bar(568,441,584,445);
 if Stat = '41' then
    bar(576,441,592,445);
 if Stat = '42' then
    bar(584,441,600,445);
 setcolor(15);
 rectangle(568,360,600,445);
end;

{ Mostra qual ‚ a area vista no ecr„ Necessidades Alimentares Di rias }
procedure Status(Stat : string);
begin
 setfillstyle(1,15);
 bar(400,370,620,440);
 setcolor(8);
 line(622,370,622,442);
 line(623,369,623,443);
 line(622,442,398,442);
 line(623,443,397,443);
 setcolor(15);
 line(398,368,398,442);
 line(397,367,397,443);
 line(398,368,622,368);
 line(397,367,623,367);
 setfillstyle(8,15);
 if Stat = '1' then
    bar(400,370,520,440);
 if Stat = '2' then
    bar(420,370,540,440);
 if Stat = '3' then
    bar(440,370,560,440);
 if Stat = '4' then
    bar(460,370,580,440);
 if Stat = '5' then
    bar(480,370,600,440);
 if Stat = '6' then
    bar(500,370,620,440);
 setcolor(15);
 rectangle(400,370,620,440);
end;

{ Controlador do teclado no ecr„ N.A.D. }
procedure Neces;
label 1,2;
begin
2:Avolta;
  Cima('Nutritus 1.0 - Necessidades alimentares di rias');
  Baixo('Pressione uma tecla');
  settextstyle(1,0,0);
  settextjustify(1,1);
  setcolor(8);
  outtextxy(321,16, 'Necessidades alimentares di rias');
  setcolor(15);
  outtextxy(319,14, 'Necessidades alimentares di rias');
  setcolor(7);
  outtextxy(320,15, 'Necessidades alimentares di rias');
  setcolor(1);
  rectangle(9,41,629,343);
  setcolor(15);
  rectangle(8,40,628,342);
  settextstyle(0,0,0);
  settextjustify(0,0);
  Dita(20,355, 'Teclas usadas:');
  Dita(500,355, 'Area visionada:');
  setcolor(8);
  line(20,440,50,440);
  line(21,441,51,441);
  line(22,442,52,442);
  line(23,443,53,443);
  line(50,440,50,410);
  line(51,441,51,409);
  line(52,442,52,408);
  line(53,443,53,407);
  line(70,440,100,440);
  line(71,441,101,441);
  line(72,442,102,442);
  line(73,443,103,443);
  line(100,440,100,410);
  line(101,441,101,409);
  line(102,442,102,408);
  line(103,443,103,407);
  line(120,440,150,440);
  line(121,441,151,441);
  line(122,442,152,442);
  line(123,443,153,443);
  line(150,440,150,410);
  line(151,441,151,409);
  line(152,442,152,408);
  line(153,443,153,407);
  line(170,440,200,440);
  line(171,441,201,441);
  line(172,442,202,442);
  line(173,443,203,443);
  line(200,440,200,410);
  line(201,441,201,409);
  line(202,442,202,408);
  line(203,443,203,407);
  line(220,440,250,440);
  line(221,441,251,441);
  line(222,442,252,442);
  line(223,443,253,443);
  line(250,440,250,410);
  line(251,441,251,409);
  line(252,442,252,408);
  line(253,443,253,407);
  line(270,440,300,440);
  line(271,441,301,441);
  line(272,442,302,442);
  line(273,443,303,443);
  line(300,440,300,410);
  line(301,441,301,409);
  line(302,442,302,408);
  line(303,443,303,407);
  settextjustify(0,2);
  Dita(23,425, 'Esc');
  Dita(75,425, 'F1');
  Dita(117,425, 'Home');
  Dita(173,425, 'End');
  Dita(227,425, #27+'-');
  Dita(277,425, '-'+#26);
  Ness := '1';
  Status('1');
  Exo;
  Ecra1;
1:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('2');
                 goto 2;
               end;
          #71:begin
               if Ness <> '1' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra1;
                   Ness := '1';
                   Status('1');
                  end;
              end;
          #75:begin
               if Ness = '3' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra1;
                   Ness := '1';
                   Status('1');
                   goto 1;
                  end;
               if Ness = '4' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra3;
                   Ness := '3';
                   Status('2');
                   goto 1;
                  end;
               if Ness = '5' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra4;
                   Ness := '4';
                   Status('3');
                   goto 1;
                  end;
               if Ness = '6' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra5;
                   Ness := '5';
                   Status('4');
                   goto 1;
                  end;
               if Ness = '7' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra6;
                   Ness := '6';
                   Status('5');
                   goto 1;
                  end;
              end;
          #77:begin
               if Ness = '1' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra3;
                   Ness := '3';
                   Status('2');
                   goto 1;
                  end;
               if Ness = '3' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra4;
                   Ness := '4';
                   Status('3');
                   goto 1;
                  end;
               if Ness = '4' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra5;
                   Ness := '5';
                   Status('4');
                   goto 1;
                  end;
               if Ness = '5' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra6;
                   Ness := '6';
                   Status('5');
                   goto 1;
                  end;
               if Ness = '6' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra7;
                   Ness := '7';
                   Status('6');
                   goto 1;
                  end;
              end;
          #79:begin
               if Ness <> '7' then
                  begin
                   setfillstyle(1,7);
                   bar(230,47,621,320);
                   Ecra7;
                   Ness := '7';
                   Status('6');
                  end;
              end;
        else
          Som;
        end;
      end;
      #27: Feito:=True;
    else
      Som;
    end;
  until Feito;
end;

{ Controla o teclado no ecr„ C. dos A. }
procedure Compo;
label 1,2,3,4,5;
begin
  Comp := '1';
2:Avolta;
  Cima('Nutritus 1.0 - Composi‡„o dos alimentos');
  Baixo('Pressione uma tecla');
  settextstyle(1,0,0);
  settextjustify(1,1);
  setcolor(8);
  outtextxy(321,16, 'Composi‡„o dos alimentos');
  setcolor(15);
  outtextxy(319,14, 'Composi‡„o dos alimentos');
  setcolor(7);
  outtextxy(320,15, 'Composi‡„o dos alimentos');
  setcolor(1);
  rectangle(9,41,629,343);
  setcolor(15);
  rectangle(8,40,628,342);
  settextstyle(0,0,0);
  settextjustify(0,0);
  Dita(20,355, 'Teclas usadas:');
  Dita(500,355, 'Area visionada:');
  setcolor(8);
  line(20,390,50,390);
  line(21,391,51,391);
  line(22,392,52,392);
  line(23,393,53,393);
  line(50,390,50,360);
  line(51,391,51,359);
  line(52,392,52,358);
  line(53,393,53,357);
  line(70,390,100,390);
  line(71,391,101,391);
  line(72,392,102,392);
  line(73,393,103,393);
  line(100,390,100,360);
  line(101,391,101,359);
  line(102,392,102,358);
  line(103,393,103,357);
  line(120,390,150,390);
  line(121,391,151,391);
  line(122,392,152,392);
  line(123,393,153,393);
  line(150,390,150,360);
  line(151,391,151,359);
  line(152,392,152,358);
  line(153,393,153,357);
  line(170,390,200,390);
  line(171,391,201,391);
  line(172,392,202,392);
  line(173,393,203,393);
  line(200,390,200,360);
  line(201,391,201,359);
  line(202,392,202,358);
  line(203,393,203,357);
  line(220,390,250,390);
  line(221,391,251,391);
  line(222,392,252,392);
  line(223,393,253,393);
  line(250,390,250,360);
  line(251,391,251,359);
  line(252,392,252,358);
  line(253,393,253,357);
  line(20,440,50,440);
  line(21,441,51,441);
  line(22,442,52,442);
  line(23,443,53,443);
  line(50,440,50,410);
  line(51,441,51,409);
  line(52,442,52,408);
  line(53,443,53,407);
  line(70,440,100,440);
  line(71,441,101,441);
  line(72,442,102,442);
  line(73,443,103,443);
  line(100,440,100,410);
  line(101,441,101,409);
  line(102,442,102,408);
  line(103,443,103,407);
  line(120,440,150,440);
  line(121,441,151,441);
  line(122,442,152,442);
  line(123,443,153,443);
  line(150,440,150,410);
  line(151,441,151,409);
  line(152,442,152,408);
  line(153,443,153,407);
  line(170,440,200,440);
  line(171,441,201,441);
  line(172,442,202,442);
  line(173,443,203,443);
  line(200,440,200,410);
  line(201,441,201,409);
  line(202,442,202,408);
  line(203,443,203,407);
  line(220,440,250,440);
  line(221,441,251,441);
  line(222,442,252,442);
  line(223,443,253,443);
  line(250,440,250,410);
  line(251,441,251,409);
  line(252,442,252,408);
  line(253,443,253,407);
  line(270,440,300,440);
  line(271,441,301,441);
  line(272,442,302,442);
  line(273,443,303,443);
  line(300,440,300,410);
  line(301,441,301,409);
  line(302,442,302,408);
  line(303,443,303,407);
  line(320,440,350,440);
  line(321,441,351,441);
  line(322,442,352,442);
  line(323,443,353,443);
  line(350,440,350,410);
  line(351,441,351,409);
  line(352,442,352,408);
  line(353,443,353,407);
  line(370,440,400,440);
  line(371,441,401,441);
  line(372,442,402,442);
  line(373,443,403,443);
  line(400,440,400,410);
  line(401,441,401,409);
  line(402,442,402,408);
  line(403,443,403,407);
  settextjustify(0,2);
  Dita(30,375, '1');
  Dita(80,375, '2');
  Dita(130,375, '3');
  Dita(180,375, '4');
  Dita(230,375, '5');
  Dita(23,425, 'Esc');
  Dita(75,425, 'F1');
  Dita(117,425, 'Home');
  Dita(173,425, 'End');
  Dita(227,425, #27+'-');
  Dita(277,425, '-'+#26);
  Dita(317,425, 'PgUp');
  Dita(367,425, 'PgDn');
  if Comp = '1' then begin  CEcra1;  Status1('1');  end;
  if Comp = '2' then begin  CEcra2;  Status1('2');  end;
  if Comp = '3' then begin  CEcra3;  Status1('3');  end;
  if Comp = '4' then begin  CEcra4;  Status1('4');  end;
  if Comp = '5' then begin  CEcra5;  Status1('5');  end;
  if Comp = '6' then begin  CEcra6;  Status1('6');  end;
  if Comp = '7' then begin  CEcra7;  Status1('7');  end;
  if Comp = '8' then begin  CEcra8;  Status1('8');  end;
  if Comp = '9' then begin  CEcra9;  Status1('9');  end;
  if Comp = '10' then begin  CEcra10;  Status1('10');  end;
  if Comp = '11' then begin  CEcra11;  Status1('11');  end;
  if Comp = '12' then begin  CEcra12;  Status1('12');  end;
  if Comp = '13' then begin  CEcra13;  Status1('13');  end;
  if Comp = '14' then begin  CEcra14;  Status1('14');  end;
  if Comp = '15' then begin  CEcra15;  Status1('15');  end;
  if Comp = '16' then begin  CEcra16;  Status1('16');  end;
  if Comp = '17' then begin  CEcra17;  Status1('17');  end;
  if Comp = '18' then begin  CEcra18;  Status1('18');  end;
  if Comp = '19' then begin  CEcra19;  Status1('19');  end;
  if Comp = '20' then begin  CEcra20;  Status1('20');  end;
  if Comp = '21' then begin  CEcra21;  Status1('21');  end;
  if Comp = '22' then begin  CEcra22;  Status1('22');  end;
  if Comp = '23' then begin  CEcra23;  Status1('23');  end;
  if Comp = '24' then begin  CEcra24;  Status1('24');  end;
  if Comp = '25' then begin  CEcra25;  Status1('25');  end;
  if Comp = '26' then begin  CEcra26;  Status1('26');  end;
  if Comp = '27' then begin  CEcra27;  Status1('27');  end;
  if Comp = '28' then begin  CEcra28;  Status1('28');  end;
  if Comp = '29' then begin  CEcra29;  Status1('29');  end;
  if Comp = '30' then begin  CEcra30;  Status1('30');  end;
  if Comp = '31' then begin  CEcra31;  Status1('31');  end;
  if Comp = '32' then begin  CEcra32;  Status1('32');  end;
  if Comp = '33' then begin  CEcra33;  Status1('33');  end;
  if Comp = '34' then begin  CEcra34;  Status1('34');  end;
  if Comp = '35' then begin  CEcra35;  Status1('35');  end;
  if Comp = '36' then begin  CEcra36;  Status1('36');  end;
  if Comp = '37' then begin  CEcra37;  Status1('37');  end;
  if Comp = '38' then begin  CEcra38;  Status1('38');  end;
  if Comp = '39' then begin  CEcra39;  Status1('39');  end;
  if Comp = '40' then begin  CEcra40;  Status1('40');  end;
  if Comp = '41' then begin  CEcra41;  Status1('41');  end;
  if Comp = '42' then begin  CEcra42;  Status1('42');  end;
1:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('3');
                 goto 2;
               end;
          #71: begin
               if Comp <> '1' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra1;
                   Comp := '1';
                   Status1('1');
                  end;
              end;
          #73: begin
               if Comp = '4' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra1;
                   Comp := '1';
                   Status1('1');
                   goto 1;
                  end;
               if Comp = '5' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra2;
                   Comp := '2';
                   Status1('2');
                   goto 1;
                  end;
               if Comp = '6' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra3;
                   Comp := '3';
                   Status1('3');
                   goto 1;
                  end;
               if Comp = '7' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra4;
                   Comp := '4';
                   Status1('4');
                   goto 1;
                  end;
               if Comp = '8' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra5;
                   Comp := '5';
                   Status1('5');
                   goto 1;
                  end;
               if Comp = '9' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra6;
                   Comp := '6';
                   Status1('6');
                   goto 1;
                  end;
               if Comp = '10' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra7;
                   Comp := '7';
                   Status1('7');
                   goto 1;
                  end;
               if Comp = '11' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra8;
                   Comp := '8';
                   Status1('8');
                   goto 1;
                  end;
               if Comp = '12' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra9;
                   Comp := '9';
                   Status1('9');
                   goto 1;
                  end;
               if Comp = '13' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra10;
                   Comp := '10';
                   Status1('10');
                   goto 1;
                  end;
               if Comp = '14' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra11;
                   Comp := '11';
                   Status1('11');
                   goto 1;
                  end;
               if Comp = '15' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra12;
                   Comp := '12';
                   Status1('12');
                   goto 1;
                  end;
               if Comp = '16' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra13;
                   Comp := '13';
                   Status1('13');
                   goto 1;
                  end;
               if Comp = '17' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra14;
                   Comp := '14';
                   Status1('14');
                   goto 1;
                  end;
               if Comp = '18' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra15;
                   Comp := '15';
                   Status1('15');
                   goto 1;
                  end;
               if Comp = '19' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra16;
                   Comp := '16';
                   Status1('16');
                   goto 1;
                  end;
               if Comp = '20' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra17;
                   Comp := '17';
                   Status1('17');
                   goto 1;
                  end;
               if Comp = '21' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra18;
                   Comp := '18';
                   Status1('18');
                   goto 1;
                  end;
               if Comp = '22' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra19;
                   Comp := '19';
                   Status1('19');
                   goto 1;
                  end;
               if Comp = '23' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra20;
                   Comp := '20';
                   Status1('20');
                   goto 1;
                  end;
               if Comp = '24' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra21;
                   Comp := '21';
                   Status1('21');
                   goto 1;
                  end;
               if Comp = '25' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra22;
                   Comp := '22';
                   Status1('22');
                   goto 1;
                  end;
               if Comp = '26' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra23;
                   Comp := '23';
                   Status1('23');
                   goto 1;
                  end;
               if Comp = '27' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra24;
                   Comp := '24';
                   Status1('24');
                   goto 1;
                  end;
               if Comp = '28' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra25;
                   Comp := '25';
                   Status1('25');
                   goto 1;
                  end;
               if Comp = '29' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra26;
                   Comp := '26';
                   Status1('26');
                   goto 1;
                  end;
               if Comp = '30' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra27;
                   Comp := '27';
                   Status1('27');
                   goto 1;
                  end;
               if Comp = '31' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra28;
                   Comp := '28';
                   Status1('28');
                   goto 1;
                  end;
               if Comp = '32' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra29;
                   Comp := '29';
                   Status1('29');
                   goto 1;
                  end;
               if Comp = '33' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra30;
                   Comp := '30';
                   Status1('30');
                   goto 1;
                  end;
               if Comp = '34' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra31;
                   Comp := '31';
                   Status1('31');
                   goto 1;
                  end;
               if Comp = '35' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra32;
                   Comp := '32';
                   Status1('32');
                   goto 1;
                  end;
               if Comp = '36' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra33;
                   Comp := '33';
                   Status1('33');
                   goto 1;
                  end;
               if Comp = '37' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra34;
                   Comp := '34';
                   Status1('34');
                   goto 1;
                  end;
               if Comp = '38' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra35;
                   Comp := '35';
                   Status1('35');
                   goto 1;
                  end;
               if Comp = '39' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra36;
                   Comp := '36';
                   Status1('36');
                   goto 1;
                  end;
               if Comp = '40' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra37;
                   Comp := '37';
                   Status1('37');
                   goto 1;
                  end;
               if Comp = '41' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra38;
                   Comp := '38';
                   Status1('38');
                   goto 1;
                  end;
               if Comp = '42' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra39;
                   Comp := '39';
                   Status1('39');
                   goto 1;
                  end;
              end;
          #75: begin
               if Comp = '2' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra1;
                   Comp := '1';
                   Status1('1');
                   goto 1;
                  end;
               if Comp = '3' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra2;
                   Comp := '2';
                   Status1('2');
                   Goto 1;
                  end;
               if Comp = '5' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra4;
                   Comp := '4';
                   Status1('4');
                   goto 1;
                  end;
               if Comp = '6' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra5;
                   Comp := '5';
                   Status1('5');
                   goto 1;
                  end;
               if Comp = '8' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra7;
                   Comp := '7';
                   Status1('7');
                   goto 1;
                  end;
               if Comp = '9' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra8;
                   Comp := '8';
                   Status1('8');
                   goto 1;
                  end;
               if Comp = '11' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra10;
                   Comp := '10';
                   Status1('10');
                   goto 1;
                  end;
               if Comp = '12' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra11;
                   Comp := '11';
                   Status1('11');
                   goto 1;
                  end;
               if Comp = '14' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra13;
                   Comp := '13';
                   Status1('13');
                   goto 1;
                  end;
               if Comp = '15' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra14;
                   Comp := '14';
                   Status1('14');
                   goto 1;
                  end;
               if Comp = '17' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra16;
                   Comp := '16';
                   Status1('16');
                   goto 1;
                  end;
               if Comp = '18' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra17;
                   Comp := '17';
                   Status1('17');
                   goto 1;
                  end;
               if Comp = '20' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra19;
                   Comp := '19';
                   Status1('19');
                   goto 1;
                  end;
               if Comp = '21' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra20;
                   Comp := '20';
                   Status1('20');
                   goto 1;
                  end;
               if Comp = '23' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra22;
                   Comp := '22';
                   Status1('22');
                   goto 1;
                  end;
               if Comp = '24' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra23;
                   Comp := '23';
                   Status1('23');
                   goto 1;
                  end;
               if Comp = '26' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra25;
                   Comp := '25';
                   Status1('25');
                   goto 1;
                  end;
               if Comp = '27' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra26;
                   Comp := '26';
                   Status1('26');
                   goto 1;
                  end;
               if Comp = '29' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra28;
                   Comp := '28';
                   Status1('28');
                   goto 1;
                  end;
               if Comp = '30' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra29;
                   Comp := '29';
                   Status1('29');
                   goto 1;
                  end;
               if Comp = '32' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra31;
                   Comp := '31';
                   Status1('31');
                   goto 1;
                  end;
               if Comp = '33' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra32;
                   Comp := '32';
                   Status1('32');
                   goto 1;
                  end;
               if Comp = '35' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra34;
                   Comp := '34';
                   Status1('34');
                   goto 1;
                  end;
               if Comp = '36' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra35;
                   Comp := '35';
                   Status1('35');
                   goto 1;
                  end;
               if Comp = '38' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra37;
                   Comp := '37';
                   Status1('37');
                   goto 1;
                  end;
               if Comp = '39' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra38;
                   Comp := '38';
                   Status1('38');
                   goto 1;
                  end;
               if Comp = '41' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra40;
                   Comp := '40';
                   Status1('40');
                   goto 1;
                  end;
               if Comp = '42' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra41;
                   Comp := '41';
                   Status1('41');
                   goto 1;
                  end;
              end;
          #77: begin
               if Comp = '1' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra2;
                   Comp := '2';
                   Status1('2');
                   goto 1;
                  end;
               if Comp = '2' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra3;
                   Comp := '3';
                   Status1('3');
                   Goto 1;
                  end;
               if Comp = '4' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra5;
                   Comp := '5';
                   Status1('5');
                   goto 1;
                  end;
               if Comp = '5' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra6;
                   Comp := '6';
                   Status1('6');
                   goto 1;
                  end;
               if Comp = '7' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra8;
                   Comp := '8';
                   Status1('8');
                   goto 1;
                  end;
               if Comp = '8' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra9;
                   Comp := '9';
                   Status1('9');
                   goto 1;
                  end;
               if Comp = '10' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra11;
                   Comp := '11';
                   Status1('11');
                   goto 1;
                  end;
               if Comp = '11' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra12;
                   Comp := '12';
                   Status1('12');
                   goto 1;
                  end;
               if Comp = '13' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra14;
                   Comp := '14';
                   Status1('14');
                   goto 1;
                  end;
               if Comp = '14' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra15;
                   Comp := '15';
                   Status1('15');
                   goto 1;
                  end;
               if Comp = '16' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra17;
                   Comp := '17';
                   Status1('17');
                   goto 1;
                  end;
               if Comp = '17' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra18;
                   Comp := '18';
                   Status1('18');
                   goto 1;
                  end;
               if Comp = '19' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra20;
                   Comp := '20';
                   Status1('20');
                   goto 1;
                  end;
               if Comp = '20' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra21;
                   Comp := '21';
                   Status1('21');
                   goto 1;
                  end;
               if Comp = '22' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra23;
                   Comp := '23';
                   Status1('23');
                   goto 1;
                  end;
               if Comp = '23' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra24;
                   Comp := '24';
                   Status1('24');
                   goto 1;
                  end;
               if Comp = '25' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra26;
                   Comp := '26';
                   Status1('26');
                   goto 1;
                  end;
               if Comp = '26' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra27;
                   Comp := '27';
                   Status1('27');
                   goto 1;
                  end;
               if Comp = '28' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra29;
                   Comp := '29';
                   Status1('29');
                   goto 1;
                  end;
               if Comp = '29' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra30;
                   Comp := '30';
                   Status1('30');
                   goto 1;
                  end;
               if Comp = '31' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra32;
                   Comp := '32';
                   Status1('32');
                   goto 1;
                  end;
               if Comp = '32' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra33;
                   Comp := '33';
                   Status1('33');
                   goto 1;
                  end;
               if Comp = '34' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra35;
                   Comp := '35';
                   Status1('35');
                   goto 1;
                  end;
               if Comp = '35' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra36;
                   Comp := '36';
                   Status1('36');
                   goto 1;
                  end;
               if Comp = '37' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra38;
                   Comp := '38';
                   Status1('38');
                   goto 1;
                  end;
               if Comp = '38' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra39;
                   Comp := '39';
                   Status1('39');
                   goto 1;
                  end;
               if Comp = '40' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra41;
                   Comp := '41';
                   Status1('41');
                   goto 1;
                  end;
               if Comp = '41' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra42;
                   Comp := '42';
                   Status1('42');
                   goto 1;
                  end;
              end;
          #79: if Comp <> '42' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra42;
                   Comp := '42';
                   Status1('42');
                   goto 1;
                  end;
          #81: begin
               if Comp = '1' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra4;
                   Comp := '4';
                   Status1('4');
                   goto 1;
                  end;
               if Comp = '2' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra5;
                   Comp := '5';
                   Status1('5');
                   goto 1;
                  end;
               if Comp = '3' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra6;
                   Comp := '6';
                   Status1('6');
                   goto 1;
                  end;
               if Comp = '4' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra7;
                   Comp := '7';
                   Status1('7');
                   goto 1;
                  end;
               if Comp = '5' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra8;
                   Comp := '8';
                   Status1('8');
                   goto 1;
                  end;
               if Comp = '6' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra9;
                   Comp := '9';
                   Status1('9');
                   goto 1;
                  end;
               if Comp = '7' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra10;
                   Comp := '10';
                   Status1('10');
                   goto 1;
                  end;
               if Comp = '8' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra11;
                   Comp := '11';
                   Status1('11');
                   goto 1;
                  end;
               if Comp = '9' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra12;
                   Comp := '12';
                   Status1('12');
                   goto 1;
                  end;
               if Comp = '10' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra13;
                   Comp := '13';
                   Status1('13');
                   goto 1;
                  end;
               if Comp = '11' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra14;
                   Comp := '14';
                   Status1('14');
                   goto 1;
                  end;
               if Comp = '12' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra15;
                   Comp := '15';
                   Status1('15');
                   goto 1;
                  end;
               if Comp = '13' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra16;
                   Comp := '16';
                   Status1('16');
                   goto 1;
                  end;
               if Comp = '14' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra17;
                   Comp := '17';
                   Status1('17');
                   goto 1;
                  end;
               if Comp = '15' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra18;
                   Comp := '18';
                   Status1('18');
                   goto 1;
                  end;
               if Comp = '16' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra19;
                   Comp := '19';
                   Status1('19');
                   goto 1;
                  end;
               if Comp = '17' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra20;
                   Comp := '20';
                   Status1('20');
                   goto 1;
                  end;
               if Comp = '18' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra21;
                   Comp := '21';
                   Status1('21');
                   goto 1;
                  end;
               if Comp = '19' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra22;
                   Comp := '22';
                   Status1('22');
                   goto 1;
                  end;
               if Comp = '20' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra23;
                   Comp := '23';
                   Status1('23');
                   goto 1;
                  end;
               if Comp = '21' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra24;
                   Comp := '24';
                   Status1('24');
                   goto 1;
                  end;
               if Comp = '22' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra25;
                   Comp := '25';
                   Status1('25');
                   goto 1;
                  end;
               if Comp = '23' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra26;
                   Comp := '26';
                   Status1('26');
                   goto 1;
                  end;
               if Comp = '24' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra27;
                   Comp := '27';
                   Status1('27');
                   goto 1;
                  end;
               if Comp = '25' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra28;
                   Comp := '28';
                   Status1('28');
                   goto 1;
                  end;
               if Comp = '26' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra29;
                   Comp := '29';
                   Status1('29');
                   goto 1;
                  end;
               if Comp = '27' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra30;
                   Comp := '30';
                   Status1('30');
                   goto 1;
                  end;
               if Comp = '28' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra31;
                   Comp := '31';
                   Status1('31');
                   goto 1;
                  end;
               if Comp = '29' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra32;
                   Comp := '32';
                   Status1('32');
                   goto 1;
                  end;
               if Comp = '30' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra33;
                   Comp := '33';
                   Status1('33');
                   goto 1;
                  end;
               if Comp = '31' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra34;
                   Comp := '34';
                   Status1('34');
                   goto 1;
                  end;
               if Comp = '32' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra35;
                   Comp := '35';
                   Status1('35');
                   goto 1;
                  end;
               if Comp = '33' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra36;
                   Comp := '36';
                   Status1('36');
                   goto 1;
                  end;
               if Comp = '34' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra37;
                   Comp := '37';
                   Status1('37');
                   goto 1;
                  end;
               if Comp = '35' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra38;
                   Comp := '38';
                   Status1('38');
                   goto 1;
                  end;
               if Comp = '36' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra39;
                   Comp := '39';
                   Status1('39');
                   goto 1;
                  end;
               if Comp = '37' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra40;
                   Comp := '40';
                   Status1('40');
                   goto 1;
                  end;
               if Comp = '38' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra41;
                   Comp := '41';
                   Status1('41');
                   goto 1;
                  end;
               if Comp = '39' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra42;
                   Comp := '42';
                   Status1('42');
                   goto 1;
                  end;
               end;
        else
          Som;
        end;
      end;
      #27: Feito:=True;
      #49: if Comp <> '1' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra1;
                   Comp := '1';
                   Status1('1');
                   goto 1;
                  end;
      #50: if Comp <> '7' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra7;
                   Comp := '7';
                   Status1('7');
                   goto 1;
                  end;
      #51: if Comp <> '19' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra19;
                   Comp := '19';
                   Status1('19');
                   goto 1;
                  end;
      #52: if Comp <> '22' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra22;
                   Comp := '22';
                   Status1('22');
                   goto 1;
                  end;
      #53: if Comp <> '31' then
                  begin
                   setfillstyle(1,7);
                   bar(15,47,621,336);
                   CEcra31;
                   Comp := '31';
                   Status1('31');
                   goto 1;
                  end;
    else
      Som;
    end;
  until Feito;
end;

{ Controlador do teclado no ecr„ M. de I. }
procedure Tabel;
label 1,2,3;
var
   Ali : Char;
begin
1:Avolta;
  Cima('Nutritus 1.0 - Menu de Impress„o');
  PMenu;
3:Ali := '0';
  Escolha := '1';
2:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('4');
                 goto 1;
               end;
        else
          Som;
        end;
      end;
      #27: Feito:=True;
      #49:begin
           Esco1(Ali,Escolha);
           PMenu;
           goto 3;
          end;
      #50:begin
           Esco2(Ali,Escolha);
           PMenu;
           goto 3;
          end;
      #51:begin
           Esco3(Ali,Escolha);
           PMenu;
           goto 3;
          end;
      #52:begin
           Esco4(Ali,Escolha);
           PMenu;
           goto 3;
          end;
      #53:begin
           Esco5(Ali,Escolha);
           PMenu;
           goto 3;
          end;
      #54:begin
           Esco6(Ali,Escolha);
           PMenu;
           goto 3;
          end;
      #55:begin
           if Ali = '0' then
              begin
                bar(25,113,250,128);
                dita(30,125, 'Alimenta‡„o: Folha … folha');
                Ali := '1';
                goto 2;
              end;
           if Ali = '1' then
              begin
                bar(25,113,250,128);
                dita(30,125, 'Alimenta‡„o: Papel continuo');
                Ali := '0';
                goto 2;
              end;
          end;
      #56:begin
           if Escolha = '1' then
              begin
                bar(25,129,250,144);
                dita(30,140, 'N£mero de passagens: 2');
                Escolha := '2';
                goto 2;
              end;
           if Escolha = '2' then
              begin
                bar(25,129,250,144);
                dita(30,140, 'N£mero de passagens: 1');
                Escolha := '1';
                goto 2;
              end;
          end;
    else
      Som;
    end;
  until Feito;
end;

{ Controlador do teclado no ecr„ menu principal }
procedure Menu;
label 1,2,3,4;
begin
  Intro;
4:Avolta;
  Cima('Nutritus 1.0 - Menu principal');
  Baixo('Selecione utilizando as teclas de direc‡„o');
  Caixas;
  l1;d2;d3;d4;d5;
  Caixa := '1';
1:ch:= readkey;
  if ch <> chr(0) then goto 2;
  ch1:=readkey;
  If Caixa = '1' then
     begin
      if ch1 = chr(72) then
         begin
          d1;
          l5;
          Caixa := '5';
          goto 1;
         end;
      if ch1 = chr(80) then
         begin
          d1;
          l2;
          Caixa := '2';
          goto 1;
         end;
     end;
  If Caixa = '2' then
     begin
      if ch1 = chr(72) then
         begin
          d2;
          l1;
          Caixa := '1';
          goto 1;
         end;
      if ch1 = chr(80) then
         begin
          d2;
          l3;
          Caixa := '3';
          goto 1;
         end;
     end;
  If Caixa = '3' then
     begin
      if ch1 = chr(72) then
         begin
          d3;
          l2;
          Caixa := '2';
          goto 1;
         end;
      if ch1 = chr(80) then
         begin
          d3;
          l4;
          Caixa := '4';
          goto 1;
         end;
     end;
  If Caixa = '4' then
     begin
      if ch1 = chr(72) then
         begin
          d4;
          l3;
          Caixa := '3';
          goto 1;
         end;
      if ch1 = chr(80) then
         begin
          d4;
          l5;
          Caixa := '5';
          goto 1;
         end;
     end;
  If Caixa = '5' then
     begin
      if ch1 = chr(72) then
         begin
          d5;
          l4;
          Caixa := '4';
          goto 1;
         end;
      if ch1 = chr(80) then
         begin
          d5;
          l1;
          Caixa := '1';
          goto 1;
         end;
     end;
  if ch1 = chr(59) then
     begin
       Ajuda('1');
       goto 4;
     end;
  Som;
  goto 1;
2:if ch = chr(27) then
     begin
       if Caixa = '1' then
          begin
           d1;
           l5;
          end;
       if Caixa = '2' then
          begin
           d2;
           l5;
          end;
       if Caixa = '3' then
          begin
           d3;
           l5;
          end;
       if Caixa = '4' then
          begin
           d4;
           l5;
          end;
       Delay(500);
       Erro := 0;
       Halt(1);
     end;
  if ch = chr(13) then
     begin
       if Caixa = '1' then Neces;
       if Caixa = '2' then Compo;
       if Caixa = '3' then Tabel;
       if Caixa = '4' then Ajuda('1');
       if Caixa = '5' then
          begin
            Erro := 0;
            Halt(1);
          end;
       goto 4;
     end;
  Som;
  goto 1;
3:goto 4;
end;


begin
  Inicializa; { o modo gr fico }
  Menu; { que controla totalmente o Nutritus }
end.
{ EOF - Para mais informa‡”es contacte o programador  ass.  Isaac MSC }