{****** Pesadelo de Jaime o mocho. Programado em Turbo Pascal  1991&93 ******}
{****** Autor: PAULO ALEXANDRE F. MOREIRA     Telef.9898076  Rio Tinto ******}

program jaime_pesadelo (input,output);
uses
   graph,crt,dos{,bgidriv,bgifont};

type
  ficheiro = file;
  v = array [1..8] of integer;
  matriz1 = array [1..20] of string;
  matriz2 = array [1..20] of longint;

var
  {***** variaveis para o bicho1 *****}
  bx1,by1,extb1,extotalb1,contab1,incb1       : integer;
  primeirob1                                  : boolean;

  {***** variaveis para o bicho2 *****}
  bx2,by2,extb2,extotalb2,contab2,incb2       : integer;
  primeirob2                                  : boolean;

  {***** variaveis para o bicho3 *****}
  bx3,by3,extb3x,extotalb3x,contab3,incb3x    : integer;
  extb3y,extotalb3y,incb3y                    : integer;
  primeirob3                                  : boolean;

  {***** variaveis para o bicho4 *****}
  bx4,by4,extb4,extotalb4,contab4,incb4       : integer;
  primeirob4                                  : boolean;

  {***** variaveis para o bicho5 *****}
  bx5,by5,extb5,extotalb5,contab5,incb5       : integer;
  primeirob5                                  : boolean;

  obj1h,obj1v,obj2h,obj2v,obj3h,obj3v         : integer;
  obj4h,obj4v,obj5h,obj5v,obj6h,obj6v,obh,obv : integer;
  comeflag1,comeflag2,comeflag3,nivel         : integer;
  comeflag4,comeflag5,objs,vidas,vel          : integer;
  x,y,cntjaimed,cntjaimee,bonus,bonecox       : integer;
  elevadorh,elevadorv,elevmax,elevmin,bonecoy : integer;
  escbicho1,escbicho2,escbicho3               : integer;
  escbicho4,escbicho5,morreu                  : integer;
  pontos                                      : longint;
  vsalto                                      : v;
  sentido,sbonus,spontos,snivel,fim           : string;
  tecla                                       : char;
  fich                                        : ficheiro;
  boneco,jaime,jaime2,jaimed,jaimee           : pointer;
  recinto,bichos,apres,apresenta,oldint       : pointer;
  fichpont                                    : text;
  tabpont                                     : matriz1;
  tabnum                                      : matriz2;
  sai,tec_e,tec_d,tec_c,tec_b,tec_s           : boolean;


procedure aborta(msg : string);{ ******************************************* }
begin
  writeln(msg, ': ', grapherrormsg(graphresult));
  halt(1);
end;

procedure abrir_modo_grafico;{ ********************************************* }
var
  graphdriver,graphmode,error : integer;
begin
{  if registerBGIdriver(@CGAdriverproc) < 0 then
    aborta('CGA');
  if registerBGIfont(@smallfontproc) < 0 then
    aborta('Small');
  if registerBGIfont(@triplexfontproc) < 0 then
    aborta('Triplex');}
  graphdriver := cga;
  graphmode := 1;
  initgraph(graphdriver, graphmode, '');
  if graphresult <> grok then
  begin
    writeln('Erro inicial,graficos: ', grapherrormsg(graphdriver));
    halt(1);
  end;
end;

procedure carrega_jaime;{ ************************************************** }
var
  tamanho : integer;
begin
  tamanho := 2390;
  assign(fich,'graf1.spr');
  reset(fich,1);
  GetMem(jaime,tamanho);
  BlockRead(fich,jaime^,tamanho,tamanho);
  close(fich);
end;

procedure carrega_bichos;{ ************************************************* }
var
  tamanho : integer;
begin
  tamanho := 3150;
  assign(fich,'graf2.spr');
  reset(fich,1);
  GetMem(bichos,tamanho);
  BlockRead(fich,bichos^,tamanho,tamanho);
  close(fich);
end;

procedure carrega_recinto;{ ************************************************ }
var
  tamanho : integer;
begin
  tamanho := 5760;
  assign(fich,'graf3.spr');
  reset(fich,1);
  GetMem(recinto,tamanho);
  BlockRead(fich,recinto^,tamanho,tamanho);
  close(fich);
end;

procedure carrega_apresenta;{ ********************************************** }
var
  tamanho : integer;
begin
  tamanho := 9866;
  assign(fich,'graf4.spr');
  reset(fich,1);
  GetMem(apres,tamanho);
  BlockRead(fich,apres^,tamanho,tamanho);
  close(fich);
end;

procedure carrega_vsalto;{ ************************************************* }
begin
  vsalto[1] := 8; vsalto[2] := 6; vsalto[3] := 4; vsalto[4] := 4;
  vsalto[5] := 2; vsalto[6] := 0; vsalto[7] := 0; vsalto[8] := 0;
end;

procedure poe_pixel;{ ****************************************************** }
const
  seed   = 1962;
  numpts = 2000;
var
  x,y,i,color : word;
  xmax,ymax   : integer;
  viewinfo    : viewporttype;
begin
  getviewsettings(viewinfo);
  with viewinfo do
  begin
    xmax := (x2-x1-1);
    ymax := (y2-y1-1);
  end;
  while not keypressed do
  begin
    randseed := seed;
    i := 0;
    while (not keypressed) and (i < numpts) do
    begin
      inc(i);
      putpixel(random(xmax)+1, random(ymax)+1, 1);
    end;
    randseed := seed;
    i := 0;
    while (not keypressed) and (i < numpts) do
    begin
      inc(i);
      x := random(xmax)+1;
      y := random(ymax)+1;
      color := getpixel(x, y);
      if color = 1 then
        putpixel(x, y, 0);
    end;
  end;
end;

procedure caverna; { ******************************************************* }
var
  caverna : pointer;
  i       : integer;
begin
  caverna := ptr(seg(recinto^),ofs(recinto^));
  putimage(0,0,caverna^,xorput);
  setcolor(0);
  for i := 0 to 8 do
    line(65,i,260,i);
  setcolor(3); outtextxy(33,0,'PAMsoftware - SPOOLER 1991/93 v2');
  caverna := ptr(seg(recinto^),ofs(recinto^)+4646);
  putimage(0,58,caverna^,xorput);
  caverna := ptr(seg(recinto^),ofs(recinto^)+4920);
  putimage(312,58,caverna^,xorput);
  caverna := ptr(seg(recinto^),ofs(recinto^)+5194);
  putimage(0,192,caverna^,xorput);
end;

procedure coordenadas_1;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 290; elevadorv := 168; elevmax := 96; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 14; bx1 := 270; by1 := 132; contab1 := 0; incb1 := 1; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 58; bx2 := 290; by2 := 176; contab2 := 0; incb2 := -3; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 14; incb3y := 1; by3 := 60;
  extb3x := 0; extotalb3x := 36; incb3x := 2; bx3 := 164; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 22; bx4 := 18; by4 := 128; contab4 := 0; incb4 := 2; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 14; bx5 := 118; by5 := 84; contab5 := 0; incb5 := 1; primeirob5 := true;
end;

procedure nivel_1;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+560);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+678);

  putimage(290,168,elevador^,xorput); putimage(226,168,chao1^,xorput);
  putimage(226,96,chao1^,xorput); putimage(162,96,chao1^,xorput);
  putimage(98,120,chao1^,xorput);
  putimage(34,144,chao1^,xorput); putimage(18,144,chao2^,xorput);

  putimage(295,175,itemp^,xorput); putimage(20,127,itemp^,xorput);
  putimage(240,152,itemp^,xorput); putimage(180,79,itemp^,xorput);
  putimage(100,103,itemp^,xorput);

  obj1h := 295; obj1v := 175;
  obj2h := 240; obj2v := 152;
  obj3h := 180; obj3v := 79;
  obj4h := 100; obj4v := 103;
  obj5h := 020; obj5v := 127;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 9; escbicho2 := 42; escbicho3 := 0; escbicho4 := 30;  escbicho5 := 33;
  coordenadas_1;
end;

procedure coordenadas_2;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 100; elevadorv := 168; elevmax := 120; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 26; bx1 := 84; by1 := 151; contab1 := 0; incb1 :=-1; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 58; bx2 := 292; by2 := 152; contab2 := 0; incb2 := -2; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 16; incb3y := 1; by3 := 128;
  extb3x := 0; extotalb3x := 56; incb3x := 2; bx3 := 126; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 38; bx4 := 126; by4 := 104; contab4 := 0; incb4 := 3; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 10; bx5 := 57; by5 := 84; contab5 := 0; incb5 := 2; primeirob5 := true;
end;

procedure nivel_2;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+560);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+678);

  putimage(100,168,elevador^,xorput); putimage(121,168,chao1^,xorput);
  putimage(185,168,chao1^,xorput); putimage(249,168,chao1^,xorput);
  putimage(84,168,chao2^,xorput); putimage(121,120,chao1^,xorput);
  putimage(185,120,chao1^,xorput); putimage(249,120,chao1^,xorput);
  putimage(74,106,chao2^,xorput); putimage(40,106,chao2^,xorput);
  putimage(8,130,chao1^,xorput);

  putimage(300,152,itemp^,xorput); putimage(300,104,itemp^,xorput);
  putimage(160,152,itemp^,xorput); putimage(42,90,itemp^,xorput);
  putimage(42,114,itemp^,xorput);

  obj1h := 300; obj1v := 152;
  obj2h := 300; obj2v := 104;
  obj3h := 042; obj3v := 090;
  obj4h := 042; obj4v := 114;
  obj5h := 160; obj5v := 152;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 30; escbicho2 := 6; escbicho3 := 33; escbicho4 := 24;  escbicho5 := 9;
  coordenadas_2;
end;

procedure coordenadas_3;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 100; elevadorv := 168; elevmax := 120; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 16; bx1 := 256; by1 := 78; contab1 := 0; incb1 :=-1; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 50; bx2 := 57; by2 := 152; contab2 := 0; incb2 := 3; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 26; incb3y := 3; by3 := 62;
  extb3x := 0; extotalb3x := 54; incb3x := 0; bx3 := 40; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 36; bx4 := 121; by4 := 128; contab4 := 0; incb4 := 3; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 16; bx5 := 210; by5 := 58; contab5 := 0; incb5 := 2; primeirob5 := true;
end;

procedure nivel_3;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+712);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+830);

  putimage(57,168,chao1^,xorput); putimage(121,168,chao1^,xorput);
  putimage(185,168,chao1^,xorput); putimage(249,168,chao1^,xorput);
  putimage(121,144,chao1^,xorput); putimage(185,144,chao1^,xorput);
  putimage(249,144,chao1^,xorput); putimage(185,120,chao1^,xorput);
  putimage(249,120,chao1^,xorput); putimage(248,96,chao1^,xorput);
  putimage(296,72,chao2^,xorput);

  putimage(180,152,itemp^,xorput); putimage(270,80,itemp^,xorput);
  putimage(210,128,itemp^,xorput); putimage(300,56,itemp^,xorput);
  putimage(240,104,itemp^,xorput);

  obj1h := 180; obj1v := 152;
  obj2h := 270; obj2v := 080;
  obj3h := 210; obj3v := 128;
  obj4h := 300; obj4v := 056;
  obj5h := 240; obj5v := 104;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 0; escbicho2 := 12; escbicho3 := 21; escbicho4 := 39;  escbicho5 := 33;
  coordenadas_3;
end;

procedure coordenadas_4;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 147; elevadorv := 168; elevmax := 74; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 14; bx1 := 270; by1 := 86; contab1 := 0; incb1 := 1; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 58; bx2 := 212; by2 := 58; contab2 := 0; incb2 := -2; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 14; incb3y := 1; by3 := 156;
  extb3x := 0; extotalb3x := 78; incb3x := -2; bx3 := 290; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 58; bx4 := 40; by4 := 128; contab4 := 0; incb4 := 1; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 14; bx5 := 48; by5 := 84; contab5 := 0; incb5 := 1; primeirob5 := true;
end;

procedure nivel_4;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+712);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+830);

  putimage(147,168,elevador^,xorput);
  putimage(130,168,chao2^,xorput); putimage(169,168,chao2^,xorput);
  putimage(16,144,chao1^,xorput); putimage(80,144,chao1^,xorput);
  putimage(7,120,chao1^,xorput); putimage(71,120,chao2^,xorput);
  putimage(170,122,chao1^,xorput); putimage(234,122,chao1^,xorput); putimage(298,122,chao2^,xorput);
  putimage(170,74,chao1^,xorput); putimage(234,74,chao1^,xorput);

  putimage(295,178,itemp^,xorput); putimage(60,130,itemp^,xorput);
  putimage(272,108,itemp^,xorput); putimage(200,60,itemp^,xorput);
  putimage(20,106,itemp^,xorput);

  obj1h := 295; obj1v := 178;
  obj2h := 272; obj2v := 108;
  obj3h := 200; obj3v := 60;
  obj4h := 020; obj4v := 106;
  obj5h := 060; obj5v := 130;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 0; escbicho2 := 21; escbicho3 := 33; escbicho4 := 15;  escbicho5 := 9;
  coordenadas_4;
end;

procedure coordenadas_5;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 56; elevadorv := 168; elevmax := 78; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 14; bx1 := 268; by1 := 150; contab1 := 0; incb1 :=-1; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 48; bx2 := 292; by2 := 176; contab2 := 0; incb2 := -4; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 18; incb3y := 3; by3 := 56;
  extb3x := 0; extotalb3x := 54; incb3x := 0; bx3 := 178; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 44; bx4 := 12; by4 := 62; contab4 := 0; incb4 := 2; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 14; bx5 := 98; by5 := 96; contab5 := 0; incb5 := 1; primeirob5 := true;
end;

procedure nivel_5;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+712);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+830);

  putimage(248,168,chao1^,xorput); putimage(168,150,chao1^,xorput);
  putimage(88,132,chao1^,xorput); putimage(8,78,chao1^,xorput);
  putimage(56,78,chao2^,xorput); putimage(40,168,chao2^,xorput);
  putimage(56,168,elevador^,xorput); putimage(77,168,chao2^,xorput);

  putimage(280,152,itemp^,xorput); putimage(100,116,itemp^,xorput);
  putimage(180,134,itemp^,xorput); putimage(300,176,itemp^,xorput);
  putimage(12,63,itemp^,xorput);

  obj1h := 280; obj1v := 152;
  obj2h := 100; obj2v := 116;
  obj3h := 180; obj3v := 134;
  obj4h := 300; obj4v := 176;
  obj5h := 012; obj5v := 063;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 0; escbicho2 := 6; escbicho3 := 9; escbicho4 := 21;  escbicho5 := 30;
  coordenadas_5;
end;

procedure coordenadas_6;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 147; elevadorv := 168; elevmax := 74; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 34; bx1 := 10; by1 := 118; contab1 := 0; incb1 := 1; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 90; bx2 := 296; by2 := 176; contab2 := 0; incb2 := -2; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 10; incb3y := 2; by3 := 99;
  extb3x := 0; extotalb3x := 58; incb3x := 2; bx3 := 74; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 54; bx4 := 26; by4 := 76; contab4 := 0; incb4 := 2; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 14; bx5 := 224; by5 := 75; contab5 := 0; incb5 := -1; primeirob5 := true;
end;

procedure nivel_6;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2,chao3 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+864);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+678);
  chao3 := ptr(seg(jaime^),ofs(jaime^)+560);

  putimage(10,92,chao1^,xorput); putimage(74,92,chao1^,xorput);
  putimage(138,92,chao1^,xorput); putimage(202,92,chao3^,xorput);
  putimage(292,100,chao2^,xorput); putimage(274,124,chao2^,xorput);
  putimage(200,142,chao3^,xorput); putimage(136,142,chao1^,xorput);
  putimage(71,142,chao3^,xorput); putimage(42,166,chao3^,xorput);
  putimage(10,184,chao2^,xorput); putimage(248,168,chao3^,xorput);

  putimage(275,152,itemp^,xorput); putimage(150,126,itemp^,xorput);
  putimage(296,176,itemp^,xorput); putimage(50,76,itemp^,xorput);
  putimage(296,84,itemp^,xorput);

  obj1h := 275; obj1v := 152;
  obj2h := 296; obj2v := 176;
  obj3h := 050; obj3v := 076;
  obj4h := 150; obj4v := 126;
  obj5h := 296; obj5v := 084;
  obj6h := 053; obj6v := 174;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 0; escbicho2 := 36; escbicho3 := 21; escbicho4 := 18;  escbicho5 := 33;
  coordenadas_6;
end;

procedure coordenadas_7;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 147; elevadorv := 168; elevmax := 74; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 82; bx1 := 10; by1 := 54; contab1 := 0; incb1 := 1; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 54; bx2 := 276; by2 := 90; contab2 := 0; incb2 := -3; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 10; incb3y := 1; by3 := 138;
  extb3x := 0; extotalb3x := 138; incb3x := 1; bx3 := 50; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 54; bx4 := 38; by4 := 90; contab4 := 0; incb4 := 3; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 14; bx5 := 153; by5 := 136; contab5 := 0; incb5 := -1; primeirob5 := true;
end;

procedure nivel_7;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2,chao3 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+864);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+830);
  chao3 := ptr(seg(jaime^),ofs(jaime^)+712);

  putimage(50,168,chao3^,xorput); putimage(210,168,chao1^,xorput);
  putimage(130,154,chao1^,xorput); putimage(226,144,chao3^,xorput);
  putimage(33,144,chao3^,xorput); putimage(10,130,chao2^,xorput);
  putimage(38,106,chao3^,xorput); putimage(103,106,chao1^,xorput);
  putimage(167,106,chao1^,xorput); putimage(231,106,chao1^,xorput);

  putimage(156,140,itemp^,xorput); putimage(32,130,itemp^,xorput);
  putimage(280,130,itemp^,xorput); putimage(105,92,itemp^,xorput);
  putimage(216,92,itemp^,xorput);

  obj1h := 156; obj1v := 140;
  obj2h := 280; obj2v := 130;
  obj3h := 032; obj3v := 130;
  obj4h := 105; obj4v := 092;
  obj5h := 216; obj5v := 092;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 0; escbicho2 := 3; escbicho3 := 21; escbicho4 := 27;  escbicho5 := 9;
  coordenadas_7;
end;

procedure coordenadas_8;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 147; elevadorv := 168; elevmax := 74; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 20; bx1 := 22; by1 := 118; contab1 := 0; incb1 := 2; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 48; bx2 := 292; by2 := 176; contab2 := 0; incb2 := -4; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 20; incb3y := 4; by3 := 60;
  extb3x := 0; extotalb3x := 188; incb3x := 1; bx3 := 8; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 52; bx4 := 70; by4 := 176; contab4 := 0; incb4 := 3; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 20; bx5 := 282; by5 := 176; contab5 := 0; incb5 := -2; primeirob5 := true;
end;

procedure nivel_8;{ ******************************************************** }
var
  itemp : pointer;
begin
  caverna;
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));

  putimage(8,178,itemp^,xorput); putimage(82,178,itemp^,xorput);
  putimage(156,178,itemp^,xorput); putimage(229,178,itemp^,xorput);
  putimage(302,178,itemp^,xorput);

  obj1h := 008; obj1v := 178;
  obj2h := 082; obj2v := 178;
  obj3h := 156; obj3v := 178;
  obj4h := 229; obj4v := 178;
  obj5h := 302; obj5v := 178;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 0; escbicho2 := 3; escbicho3 := 21; escbicho4 := 27;  escbicho5 := 33;
  coordenadas_8;
end;

procedure coordenadas_9;{ ************************************************** }
begin
  x := 53; y := 176; elevadorh := 147; elevadorv := 168; elevmax := 74; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 26; bx1 := 32; by1 := 50; contab1 := 0; incb1 := 2; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 34; bx2 := 134; by2 := 104; contab2 := 0; incb2 := 1; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 10; incb3y := 0; by3 := 176;
  extb3x := 0; extotalb3x := 48; incb3x := -4; bx3 := 292; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 96; bx4 := 292; by4 := 176; contab4 := 0; incb4 := -2; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 26; bx5 := 278; by5 := 50; contab5 := 0; incb5 := 2; primeirob5 := true;
end;

procedure nivel_9;{ ******************************************************** }
var
  elevador,itemp,chao1,chao2,chao3 : pointer;
begin
  caverna;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+560);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+678);
  chao3 := ptr(seg(jaime^),ofs(jaime^)+712);

  putimage(70,168,chao2^,xorput); putimage(249,168,chao2^,xorput);
  putimage(102,144,chao2^,xorput); putimage(219,144,chao2^,xorput);
  putimage(134,120,chao3^,xorput); putimage(55,96,chao1^,xorput);
  putimage(215,96,chao1^,xorput); putimage(10,144,chao1^,xorput);
  putimage(279,144,chao2^,xorput);

  putimage(240,82,itemp^,xorput); putimage(32,130,itemp^,xorput);
  putimage(288,130,itemp^,xorput); putimage(75,82,itemp^,xorput);
  putimage(216,130,itemp^,xorput);

  obj1h := 240; obj1v := 082;
  obj2h := 032; obj2v := 130;
  obj3h := 288; obj3v := 130;
  obj4h := 075; obj4v := 082;
  obj5h := 216; obj5v := 130;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 0; escbicho2 := 18; escbicho3 := 12; escbicho4 := 27;  escbicho5 := 9;
  coordenadas_9;
end;

procedure coordenadas_10;{ ************************************************* }
begin
  x := 53; y := 176; elevadorh := 147; elevadorv := 168; elevmax := 74; elevmin := 168;
{***** defini‡ao inicial do valor das variaveis do bicho1 *****}
  extb1 := 0; extotalb1 := 20; bx1 := 210; by1 := 118; contab1 := 0; incb1 := 2; primeirob1 := true;

{***** defini‡ao inicial do valor das variaveis do bicho2 *****}
  extb2 := 0; extotalb2 := 70; bx2 := 292; by2 := 86; contab2 := 0; incb2 := -2; primeirob2 := true;

{***** defini‡ao inicial do valor das variaveis do bicho3 *****}
  extb3y := 0; extotalb3y := 10; incb3y := 0; by3 := 86;
  extb3x := 0; extotalb3x := 34; incb3x := 4; bx3 := 88; contab3 := 0; primeirob3 := true;

{***** defini‡ao inicial do valor das variaveis do bicho4 *****}
  extb4 := 0; extotalb4 := 70; bx4 := 88; by4 := 86; contab4 := 0; incb4 := 2; primeirob4 := true;

{***** defini‡ao inicial do valor das variaveis do bicho5 *****}
  extb5 := 0; extotalb5 := 14; bx5 := 100; by5 := 108; contab5 := 0; incb5 := 1; primeirob5 := true;
end;

procedure nivel_10;{ ******************************************************* }
var
  elevador,itemp,chao1,chao2,chao3 : pointer;
begin
  caverna;
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  chao1 := ptr(seg(jaime^),ofs(jaime^)+864);
  chao2 := ptr(seg(jaime^),ofs(jaime^)+830);
  chao3 := ptr(seg(jaime^),ofs(jaime^)+560);

  putimage(9,168,chao3^,xorput); putimage(72,144,chao1^,xorput);
  putimage(9,120,chao3^,xorput); putimage(88,102,chao3^,xorput);
  putimage(153,102,chao1^,xorput); putimage(217,102,chao1^,xorput);
  putimage(225,102,chao1^,xorput); putimage(249,102,chao1^,xorput);
  putimage(250,78,chao2^,xorput);

  putimage(160,88,itemp^,xorput); putimage(232,88,itemp^,xorput);
  putimage(300,88,itemp^,xorput); putimage(240,178,itemp^,xorput);
  putimage(120,130,itemp^,xorput);

  obj1h := 160; obj1v := 088;
  obj2h := 232; obj2v := 088;
  obj3h := 300; obj3v := 088;
  obj4h := 240; obj4v := 178;
  obj5h := 120; obj5v := 130;
  obj6h := 053; obj6v := 176;

  comeflag1 := 1; comeflag2 := 1; comeflag3 := 1;
  comeflag4 := 1; comeflag5 := 1; objs := 5;

  escbicho1 := 21; escbicho2 := 39; escbicho3 := 24; escbicho4 := 12;  escbicho5 := 9;
  coordenadas_10;
end;

procedure proximo_nivel;{ ************************************************** }
begin
  case nivel of
    1  : nivel_1;
    2  : nivel_2;
    3  : nivel_3;
    4  : nivel_4;
    5  : nivel_5;
    6  : nivel_6;
    7  : nivel_7;
    8  : nivel_8;
    9  : nivel_9;
    10 : nivel_10;
  end;
end;

procedure escrever_pontuacao(pontos:longint);{ ***************************** }
var
  c : integer;
begin
  str(pontos:5,spontos);
  for c := 1 to 5 do
    if spontos[c] = #32 then
      spontos[c] := #48;
  outtextxy(98,25,spontos);
end;

procedure escrever_bonus(bonus:integer);{ ********************************** }
var
  c : integer;
begin
  str(bonus:4,sbonus);
  for c := 1 to 4 do
    if sbonus[c] = #32 then
      sbonus[c] := #48;
  outtextxy(34,25,sbonus);
end;

procedure escrever_nivel(nivel:integer);{ ********************************** }
var
  c : integer;
begin
  str(nivel:2,snivel);
  for c := 1 to 2 do
    if snivel[c] = #32 then
      snivel[c] := #48;
  outtextxy(178,25,snivel);
end;

procedure inicio;{ ********************************************************* }
begin
  clearviewport;
  setcolor(2); outtextxy(30,15,'Bonus   Pontos   Nivel');
  setcolor(3); escrever_nivel(nivel);
  escrever_pontuacao(pontos);
  boneco := ptr(seg(jaime^),ofs(jaime^)+1126);
  bonecox := 225; bonecoy := 12;
  for x := 1 to vidas do
    begin
       putimage(bonecox,bonecoy,boneco^,xorput);
       bonecox := bonecox+10;
       if x = 7 then
         begin
           bonecoy := 23; bonecox := 225;
         end;
    end;
  proximo_nivel;
  sentido := 'dir';
  cntjaimed := 0;
  cntjaimee := 4;
  bonus := 2000; escrever_bonus(bonus); morreu := 0;
  jaimed := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimed);
  putimage(x,y,jaimed^,xorput);
  jaimee := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimee);
  delay(2000);
end;

procedure inicio2;{ ********************************************************* }
var
  elevador,cruz,bicho1,bicho2,bicho3,bicho4,bicho5 : pointer;
begin
  sentido := 'dir';
  cntjaimed := 0;
  cntjaimee := 4; morreu := 0;
  elevador := ptr(seg(jaime^),ofs(jaime^)+1016);
  putimage(elevadorh,elevadorv,elevador^,xorput);
  cruz := ptr(seg(jaime^),ofs(jaime^)+1064);
  putimage(x,y,cruz^,xorput);
  bicho1 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho1+contab1));
  putimage(bx1,by1,bicho1^,xorput);
  bicho2 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho2+contab2));
  putimage(bx2,by2,bicho2^,xorput);
  bicho3 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho3+contab3));
  putimage(bx3,by3,bicho3^,xorput);
  bicho4 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho4+contab4));
  putimage(bx4,by4,bicho4^,xorput);
  bicho5 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho5+contab5));
  putimage(bx5,by5,bicho5^,xorput);
  if nivel = 1 then coordenadas_1;
  if nivel = 2 then coordenadas_2;
  if nivel = 3 then coordenadas_3;
  if nivel = 4 then coordenadas_4;
  if nivel = 5 then coordenadas_5;
  if nivel = 6 then coordenadas_6;
  if nivel = 7 then coordenadas_7;
  if nivel = 8 then coordenadas_8;
  if nivel = 9 then coordenadas_9;
  if nivel = 10 then coordenadas_10;
  putimage(elevadorh,elevadorv,elevador^,xorput);
  jaimed := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimed);
  putimage(x,y,jaimed^,xorput);
  jaimee := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimee);
  delay(2000);
end;

procedure som1;{ *********************************************************** }
var s : integer;
begin
  for s := 30 to 32 do
    begin
      sound(s*20);sound(s*400);
      delay(1);
    end;
  for s := 32 downto 30 do
    begin
      sound(s*20);sound(s*400);
      delay(1);
    end;
  nosound;
end;

procedure som2;{ *********************************************************** }
var s : integer;
begin
  for s := 1 to 2 do
    begin
      sound(s*10000);
      delay(1);
    end;
  for s := 2 downto 1 do
    begin
      sound(s*10000);
      delay(1);
    end;
  nosound;
end;

procedure som3;{ *********************************************************** }
var s : integer;
begin
  for s := 1 to 20 do
    begin
      sound(s*100);
      delay(5);
    end;
  for s := 20 downto 1 do
    begin
      sound(s*100);
      delay(5);
    end;
  nosound;
end;

procedure som4;{ *********************************************************** }
var s : integer;
begin
  for s := 1 to 5 do
    begin
      sound(s*2000);
      delay(3);
    end;
  for s := 5 downto 1 do
    begin
      sound(s*200);
      delay(3);
    end;
  nosound;
end;

procedure move_bicho1;{ **************************************************** }
var
  bicho1 : pointer;
begin
  bicho1 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho1+contab1));
  if primeirob1 then
    putimage(bx1,by1,bicho1^,xorput);
  primeirob1 := false;
  putimage(bx1,by1,bicho1^,xorput);
  contab1 := contab1+1;
  if contab1 = 3 then
    begin
      contab1 := 0;
      by1 := by1+incb1;
      bicho1 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho1+contab1));
      putimage(bx1,by1,bicho1^,xorput);
    end
  else
    begin
      by1 := by1+incb1;
      extb1 := extb1+1;
      bicho1 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho1+contab1));
      putimage(bx1,by1,bicho1^,xorput);
    end;
  if extb1 = extotalb1 then
    begin
      incb1 := -incb1;
      extb1 := 0;
    end;
end;

procedure move_bicho2;{ **************************************************** }
var
  bicho2 : pointer;
begin
  bicho2 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho2+contab2));
  if primeirob2 then
    putimage(bx2,by2,bicho2^,xorput);
  primeirob2 := false;
  putimage(bx2,by2,bicho2^,xorput);
  contab2 := contab2+1;
  if contab2 = 3 then
    begin
      contab2 := 0;
      bx2 := bx2+incb2;
      bicho2 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho2+contab2));
      putimage(bx2,by2,bicho2^,xorput);
    end
  else
    begin
      bx2 := bx2+incb2;
      extb2 := extb2+1;
      bicho2 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho2+contab2));
      putimage(bx2,by2,bicho2^,xorput);
    end;
  if extb2 = extotalb2 then
    begin
      incb2 := -incb2;
      extb2 := 0;
    end;
end;

procedure move_bicho3;{ **************************************************** }
var
  bicho3 : pointer;
begin
  bicho3 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho3+contab3));
  if primeirob3 then
    putimage(bx3,by3,bicho3^,xorput);
  primeirob3 := false;
  putimage(bx3,by3,bicho3^,xorput);
  contab3 := contab3+1;
  if contab3 = 3 then
    begin
      contab3 := 0;
      bx3 := bx3+incb3x;
      by3 := by3+incb3y;
      bicho3 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho3+contab3));
      putimage(bx3,by3,bicho3^,xorput);
    end
  else
    begin
      bx3 := bx3+incb3x;
      by3 := by3+incb3y;
      extb3x := extb3x+1;
      extb3y := extb3y+1;
      bicho3 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho3+contab3));
      putimage(bx3,by3,bicho3^,xorput);
    end;
  if extb3x = extotalb3x then
    begin
      incb3x := -incb3x;
      extb3x := 0;
    end;
  if extb3y = extotalb3y then
    begin
      incb3y := -incb3y;
      extb3y := 0;
    end;
end;

procedure move_bicho4;{ **************************************************** }
var
  bicho4 : pointer;
begin
  bicho4 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho4+contab4));
  if primeirob4 then
    putimage(bx4,by4,bicho4^,xorput);
  primeirob4 := false;
  putimage(bx4,by4,bicho4^,xorput);
  contab4 := contab4+1;
  if contab4 = 3 then
    begin
      contab4 := 0;
      bx4 := bx4+incb4;
      bicho4 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho4+contab4));
      putimage(bx4,by4,bicho4^,xorput);
    end
  else
    begin
      bx4 := bx4+incb4;
      extb4 := extb4+1;
      bicho4 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho4+contab4));
      putimage(bx4,by4,bicho4^,xorput);
    end;
  if extb4 = extotalb4 then
    begin
      incb4 := -incb4;
      extb4 := 0;
    end;
end;

procedure move_bicho5;{ **************************************************** }
var
  bicho5 : pointer;
begin
  bicho5 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho5+contab5));
  if primeirob5 then
    putimage(bx5,by5,bicho5^,xorput);
  primeirob5 := false;
  putimage(bx5,by5,bicho5^,xorput);
  contab5 := contab5+1;
  if contab5 = 3 then
    begin
      contab5 := 0;
      by5 := by5+incb5;
      bicho5 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho5+contab5));
      putimage(bx5,by5,bicho5^,xorput);
    end
  else
    begin
      by5 := by5+incb5;
      extb5 := extb5+1;
      bicho5 := ptr(seg(bichos^),ofs(bichos^)+70*(escbicho5+contab5));
      putimage(bx5,by5,bicho5^,xorput);
    end;
  if extb5 = extotalb5 then
    begin
      incb5 := -incb5;
      extb5 := 0;
    end;
end;

procedure morre;{ ********************************************************** }
var
  t    : integer;
  cruz : pointer;
begin
  if sentido = 'dir' then
    begin
      putimage(x,y,jaimed^,xorput);
    end
  else
    begin
        putimage(x,y,jaimee^,xorput);
    end;
  cruz := ptr(seg(jaime^),ofs(jaime^)+1064);
  putimage(x,y,cruz^,xorput);
  som3;
  bonecox := 225; bonecoy := 12;
  for t := 1 to vidas do
     begin
       putimage(bonecox,bonecoy,boneco^,xorput);
       bonecox := bonecox+10;
       if t = 7 then
         begin
           bonecoy := 23; bonecox := 225;
         end;
     end;
  vidas := vidas-1;
  bonecox := 225; bonecoy := 12;
  for t := 1 to vidas do
     begin
       putimage(bonecox,bonecoy,boneco^,xorput);
       bonecox := bonecox+10;
       if t = 7 then
         begin
           bonecoy := 23; bonecox := 225;
         end;
     end;
  if vidas = 0 then
    begin
      settextstyle(smallfont,horizdir,4);
      setcolor(3); outtextxy(220,16,'Fim do Jogo');
      settextstyle(defaultfont,horizdir,1);
      fim := 'sim';
    end;
  delay(2000);
  morreu := 1;
end;

procedure comep;{ ********************************************************** }
var
  itemp : pointer;
begin
  som4;
  itemp := ptr(seg(jaime^),ofs(jaime^)+1150+54*(nivel-1));
  putimage(obh,obv,itemp^,xorput);
  setcolor(0); outtextxy(98,25,spontos);
  setcolor(3); pontos := pontos+100;
  escrever_pontuacao(pontos);
end;

procedure comeg;{ ********************************************************** }
var
  t,tot : integer;
  itemg : pointer;
begin
  som4;
  itemg := ptr(seg(jaime^),ofs(jaime^)+1690+70*(nivel-1));
  putimage(obj6h,obj6v,itemg^,xorput);
  setcolor(0); outtextxy(98,25,spontos);
  setcolor(3); pontos := pontos+500;
  escrever_pontuacao(pontos);
  tot := round(bonus div 6);
  for t := 1 to tot do
    begin
      sound(2000);delay(1);nosound;
      setcolor(0); outtextxy(98,25,spontos);
      setcolor(3); pontos := pontos+6;
      escrever_pontuacao(pontos);
      setcolor(0); outtextxy(34,25,sbonus);
      setcolor(3); bonus := bonus-6;
      escrever_bonus(bonus);
    end;
  setcolor(0); outtextxy(34,25,sbonus);
  setcolor(3); bonus := 0;
  escrever_bonus(bonus);
  if nivel = 10 then
    begin
      pontos := pontos+5000;
      setcolor(0); outtextxy(98,25,spontos);
      setcolor(3); pontos := pontos+500;
      escrever_pontuacao(pontos);
      nivel := 0;
    end;
  delay (2000);
  nivel := nivel+1;
  inicio;
end;

procedure apanha_obj;{ ***************************************************** }
var
  itemg : pointer;
begin
  if objs <> 0 then
    begin
      if (x > obj1h-10) and (x < obj1h+10) and (y > obj1v-5) and (y < obj1v+5) and (comeflag1 = 1) then
        begin
          objs := objs-1; obh := obj1h; obv := obj1v; comeflag1 := 0; comep;
        end;
      if (x > obj2h-10) and (x < obj2h+10) and (y > obj2v-5) and (y < obj2v+5) and (comeflag2 = 1) then
        begin
          objs := objs-1; obh := obj2h; obv := obj2v; comeflag2 := 0; comep;
        end;
      if (x > obj3h-10) and (x < obj3h+10) and (y > obj3v-5) and (y < obj3v+5) and (comeflag3 = 1) then
        begin
          objs := objs-1; obh := obj3h; obv := obj3v; comeflag3 := 0; comep;
        end;
      if (x > obj4h-10) and (x < obj4h+10) and (y > obj4v-5) and (y < obj4v+5) and (comeflag4 = 1) then
        begin
          objs := objs-1; obh := obj4h; obv := obj4v; comeflag4 := 0; comep;
        end;
      if (x > obj5h-10) and (x < obj5h+10) and (y > obj5v-5) and (y < obj5v+5) and (comeflag5 = 1) then
        begin
          objs := objs-1; obh := obj5h; obv := obj5v; comeflag5 := 0; comep;
        end;
      if objs = 0 then
        begin
          itemg := ptr(seg(jaime^),ofs(jaime^)+1690+70*(nivel-1));
          putimage(obj6h,obj6v,itemg^,xorput);
        end;
    end
  else
    begin
      if (x > obj6h-10) and (x < obj6h+10) and (y > obj6v-5) and (y < obj6v+5) then
        comeg;
    end;
end;

procedure colisao;{ ******************************************************** }
begin
  if (x+14 > bx1+4) and (x+14 < bx1+28) and (y+16 > by1) and (y+16 < by1+32) then
    morre;
  if (x+14 > bx2) and (x+14 < bx2+28) and (round(y/16) = round(by2/16)) then
    morre;
  if (x+14 > bx3) and (x+14 < bx3+28) and (y+16 > by3) and (y+16 < by3+32) then
    morre;
  if (x+14 > bx4) and (x+14 < bx4+28) and (round(y/16) = round(by4/16)) then
    morre;
  if (x+14 > bx5+4) and (x+14 < bx5+28) and (y+16 > by5) and (y+16 < by5+32) then
    morre;
end;

procedure move_bichos(vel:integer);{ *************************************** }
begin
  move_bicho1;
  move_bicho2;
  move_bicho3;
  move_bicho4;
  move_bicho5;
  colisao;
  if bonus = 0 then
    begin
      morre;
      bonus := 2000;
    end;
  delay(vel);
end;

procedure detecta_chao(i:integer);{ **************************************** }
var
  a,c,z : integer;
begin
  if (getpixel(x+5,y+16) = 0) and (getpixel(x+9,y+16) = 0) then
    begin
      if sentido = 'esq' then
        begin
          putimage(x,y,jaimee^,xorput);
          x := x-i;
          putimage(x,y,jaimee^,xorput);
          c := 188-y;
          z := 50;
          for a:= 1 to c do
            begin
              putimage(x,y,jaimee^,xorput);
              y := y+2;
              putimage(x,y,jaimee^,xorput);
              setcolor(0); outtextxy(34,25,sbonus);
              setcolor(3); bonus := bonus-1;
              escrever_bonus(bonus);
              move_bichos(vel);
              if morreu = 1 then
              inicio2;
              z := z-2;
              if z = 0 then
                begin
                  a := c;
                  morre;
                end;
              sound(z*30);
              if (getpixel(x+5,y+16) <> 0) or (getpixel(x+9,y+16) <> 0) then
                a := c;
            end;
          nosound;
        end
      else
        begin
          putimage(x,y,jaimed^,xorput);
          x := x+i;
          putimage(x,y,jaimed^,xorput);
          c := 188-y;
          z := 50;
          for a:= 1 to c do
            begin
              putimage(x,y,jaimed^,xorput);
              y := y+2;
              putimage(x,y,jaimed^,xorput);
              setcolor(0); outtextxy(34,25,sbonus);
              setcolor(3); bonus := bonus-1;
              escrever_bonus(bonus);
              move_bichos(vel);
              if morreu = 1 then
              inicio2;
              z := z-2;
              if z = 0 then
                begin
                  a := c;
                  morre;
                end;
              sound(z*30);
              if (getpixel(x+5,y+16) <> 0) or (getpixel(x+9,y+16) <> 0) then
                a := c;
            end;
          nosound;
        end;
    end;
end;

procedure controla_salto;{ ************************************************* }
var
  a,t,soma : integer;
begin
  soma := 0;
  for a := 0 to 13 do
    soma := soma + getpixel(x+a,y-1);
  if soma <> 0 then detecta_chao(0);
  if sentido = 'dir' then
    begin
      soma := 0;
      for t := 0 to 15 do
        soma := soma + getpixel(x+16,y+t);
      if soma <> 0 then detecta_chao(-2);
    end;
  if sentido = 'esq' then
    begin
      soma := 0;
      for t := 0 to 15 do
        soma := soma + getpixel(x-2,y+t);
      if soma <> 0 then detecta_chao(-2);
    end;
end;

procedure jaime_direita;{ ************************************************** }
var
  a,soma : integer;
begin
  if sentido = 'esq' then
    begin
      putimage(x,y,jaimee^,xorput);
      x := x-4;
      putimage(x,y,jaimed^,xorput);
      sentido := 'dir';
    end;
  soma := 0;
  if x > 290 then
    begin
      for a := 0 to 15 do
        soma := soma + getpixel(x+18,y+a);
    end;
  if soma = 0 then
    begin
      sound(8000);delay(1);nosound;
      putimage(x,y,jaimed^,xorput);
      cntjaimed := cntjaimed+1;
      if cntjaimed = 4 then
        begin
          cntjaimed := 0;
          x := x+4;
          jaimed := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimed);
          putimage(x,y,jaimed^,xorput);
        end
      else
        begin
          x := x+4;
          jaimed := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimed);
          putimage(x,y,jaimed^,xorput);
        end;
    end;
  apanha_obj;
  detecta_chao(6);
end;

procedure jaime_esquerda;{ ************************************************* }
begin
  if sentido = 'dir' then
    begin
      putimage(x,y,jaimed^,xorput);
      x := x+4;
      putimage(x,y,jaimee^,xorput);
      sentido := 'esq';
    end;
  if x-4 > 8 then
    begin
      sound(8000);delay(1);nosound;
      putimage(x,y,jaimee^,xorput);
      cntjaimee := cntjaimee+1;
      if cntjaimee = 8 then
        begin
          cntjaimee := 4;
          x := x-4;
          jaimee := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimee);
          putimage(x,y,jaimee^,xorput);
        end
      else
        begin
          x := x-4;
          jaimee := ptr(seg(jaime^),ofs(jaime^)+70*cntjaimee);
          putimage(x,y,jaimee^,xorput);
        end;
    end;
  apanha_obj;
  detecta_chao(4);
end;

procedure jaime_salta(vel:integer);{ *************************************** }
var
  soma,a,cont : integer;
begin
  cont := 0;
  soma := 0;
  if sentido = 'dir' then
    begin
      for a := 0 to 13 do
        soma := soma + getpixel(x+a,y-2);
      if soma = 0 then
        begin
          som1;
          for a := 1 to 16 do
            begin
              putimage(x,y,jaimed^,xorput);
              if a <9 then
                begin
                  cont := cont+1;
                  y := y-vsalto[cont];
                end
              else
                begin
                  y:= y+vsalto[cont];
                  cont := cont-1;
                end;
              x := x+2;
              putimage(x,y,jaimed^,xorput);
              controla_salto;
              setcolor(0); outtextxy(34,25,sbonus);
              setcolor(3); bonus := bonus-1;
              escrever_bonus(bonus);
              move_bichos(vel);
              if morreu = 1 then
              inicio2;
              if (getpixel(x+5,y+16) <> 0) and (getpixel(x+11,y+16) <> 0) then
                a := 16;
            end;
        end;
    end
  else
    begin
      for a := 0 to 13 do
        soma := soma + getpixel(x+a,y-2);
      if soma = 0 then
        begin
          som1;
          for a:= 1 to 16 do
            begin
              putimage(x,y,jaimee^,xorput);
              if a <9 then
                begin
                  cont := cont+1;
                  y := y-vsalto[cont];
                end
              else
                begin
                  y:= y+vsalto[cont];
                  cont := cont-1;
                end;
              x := x-2;
              putimage(x,y,jaimee^,xorput);
              controla_salto;
              setcolor(0); outtextxy(34,25,sbonus);
              setcolor(3); bonus := bonus-1;
              escrever_bonus(bonus);
              move_bichos(vel);
              if morreu = 1 then
              inicio2;
              if (getpixel(x+5,y+16) <> 0) and (getpixel(x+11,y+16) <> 0) then
                a := 16;
            end;
        end;
    end;
  apanha_obj;
  detecta_chao(0);
end;

procedure jaime_cima(vel:integer);{ **************************************** }
var
  elevjaime : pointer;
  tamelev   : word;
  sobe,dist : integer;
begin
  if (x > elevadorh) and (x < elevadorh+4) and (y < elevadorv) and (elevadorv <> elevmax) then
    begin
      dist := (elevmin-elevmax) div 2;
      for sobe := 1 to dist do
        begin
          som2;
          tamelev := imagesize(elevadorh,y,elevadorh+20,elevadorv+7);
          getmem(elevjaime,tamelev);
          getimage(elevadorh,y,elevadorh+20,elevadorv+7,elevjaime^);
          putimage(elevadorh,y,elevjaime^,xorput);
          elevadorv := elevadorv-2;
          y := y-2;
          putimage(elevadorh,y,elevjaime^,xorput);
          setcolor(0); outtextxy(34,25,sbonus);
          setcolor(3); bonus := bonus-1;
          escrever_bonus(bonus);
          move_bichos(vel-10);
          if morreu = 1 then
            begin
              sobe := dist;
              inicio2;
            end;
        end;
      freemem(elevjaime,tamelev);
    end;
end;

procedure jaime_baixo(vel:integer);{ *************************************** }
var
  elevjaime : pointer;
  tamelev   : word;
  desce,dist: integer;
begin
  if (x > elevadorh) and (x < elevadorh+4) and (y < elevadorv) and (elevadorv <> elevmin) then
    begin
      dist := (elevmin-elevmax) div 2;
      for desce := 1 to dist do
        begin
          som2;
          tamelev := imagesize(elevadorh,y,elevadorh+20,elevadorv+7);
          getmem(elevjaime,tamelev);
          getimage(elevadorh,y,elevadorh+20,elevadorv+7,elevjaime^);
          putimage(elevadorh,y,elevjaime^,xorput);
          elevadorv := elevadorv+2;
          y := y+2;
          putimage(elevadorh,y,elevjaime^,xorput);
          setcolor(0); outtextxy(34,25,sbonus);
          setcolor(3); bonus := bonus-1;
          escrever_bonus(bonus);
          move_bichos(vel-10);
          if morreu = 1 then
            begin
              desce := dist;
              inicio2;
            end;
        end;
      freemem(elevjaime,tamelev);
    end;
end;

procedure mostrar_pontuacoes;{ ********************************************* }
var
  c : integer;
begin
  clearviewport;
  setcolor(2);
  settextstyle(triplexfont,horizdir,5);
  outtextxy(55,5,'TOP JAIME');
  settextstyle(defaultfont,horizdir,1);
  setcolor(3);
  for c := 1 to 10 do
    outtextxy(17,c*12+50,tabpont[c]);
  poe_pixel;
end;

procedure ler_nome( posx,posy : integer; var txt : string; pic : string);{ * }
var c,cmax : integer;
    parar  : boolean;
    tecla3 : char;

procedure por_caracter;
begin
  setcolor(3);
  outtextxy(posx,posy,tecla3);
  txt := txt + tecla3;
  posx := posx + 8;
  inc(c);
  if c <= cmax then
    repeat
      if pos(pic[c],'9#ALNX!$*') = 0 then
        begin
          outtextxy(posx,posy,pic[c]);
          txt := txt + pic[c];
          posx := posx + 8;
          inc(c);
        end;
    until pos(pic[c],'9#ALNX!$*') > 0;
end;

procedure apagar_caracter;
begin
  setcolor(0);
  posx := posx - 8;
  outtextxy(posx,posy,txt[length(txt)]);
  dec(c);
  delete(txt,length(txt),1);
  repeat
    if pos(pic[c],'9#ALNX!$*') = 0 then
      begin
        delete(txt,length(txt),1);
        posx := posx - 8;
        dec(c);
      end;
  until pos(pic[c],'9#ALNX!$*') > 0
end;

begin
  parar := false;
  txt := '';
  cmax := length(pic);
  for c := 1 to cmax do
    if pos(pic[c],'9#ALNX!$*') = 0 then
      begin
        outtextxy(c*8+posx,posy,pic[c]);
      end;
  c := 1;
  repeat
    repeat until keypressed;
    tecla3 := readkey;
    if ord(tecla3) > 31 then
      if c <= cmax then
        begin
          if pic[c] = '9' then
            begin
              if pos(tecla3,'0123456789') > 0 then
                por_caracter
            end
          else
            if pic[c] = 'X' then
              por_caracter;
    end;
    if ( ord(tecla3) = 8 ) and ( c > 1 ) then
      apagar_caracter;
    if ord(tecla3) = 13 then
      parar := true;
  until parar;
end;

procedure verifica_pontuacao;{ ********************************************* }
var
  ang,rot       : real;
  c,posi,px,py  : integer;
  nome,ll,tn,tp : string;

procedure abre_espaco;
var
  d : integer;
begin
  posi := 10;
  while (( pontos > tabnum[posi-1]) and ( posi > 2 )) do
    dec(posi);
  if pontos > tabnum[1] then
    dec(posi);
  for d := 10 downto posi+1 do
    begin
      tabpont[d] := tabpont[d-1];
      tabnum[d] := tabnum[d-1];
    end;
end;

begin
  if pontos > tabnum[10] then
    begin
      clearviewport;
      ang := 6.283/50;
      rot := 0;
      for c := 1 to 50 do
      begin
        px := round(cos(rot)*130+160);
        py := round(sin(rot)*60+79);
        putimage(px-8,py-8,jaimed^,orput);
        rot := rot + ang;
        sound(round(cos(rot)*200)+1000);
        delay(10);
      end;
      nosound;
      setcolor(3);
      outtextxy(65,55,'PARABENS! BOA PONTUACAO!');
      setcolor(2);
      outtextxy(80,75,'INTRODUZA O SEU NOME');
      ler_nome(80,95,nome,'XXXXXXXXXXXXXXXXXXXX');
      for c := length(nome) to 19 do
        nome := nome + ' ';
      abre_espaco;
      str(nivel:5,tn);
      str(pontos:6,tp);
      ll := nome + '..' + tn + '   ' + tp;
      tabpont[posi] := ll;
      tabnum[posi] := pontos;
      mostrar_pontuacoes;
    end;
end;

procedure apres_menu_2;{ *************************************************** }
begin
  clearviewport;
  for x := 0 to 4 do
    begin
      apresenta := ptr(seg(apres^),ofs(apres^)+x*846);
      putimage(85,10,apresenta^,xorput);
      delay(400);
      putimage(85,10,apresenta^,xorput);
    end;
  putimage(85,10,apresenta^,xorput);
  apresenta := ptr(seg(apres^),ofs(apres^)+6980);
  putimage(90,100,apresenta^,xorput);
  settextstyle(triplexfont,horizdir,2);
  setcolor(1); outtextxy(105,45,'F1 - Jogar'); outtextxy(90,65,'F2 - Recordes');
  settextstyle(smallfont,horizdir,4);
  setcolor(3); outtextxy(70,190,'AUTOR : Paulo Alexandre Moreira');
  settextstyle(defaultfont,horizdir,1);
end;

{$F+} 
procedure keyboardH; interrupt;{ ******************************************* }
var tecla:byte;
begin
  asm
    in  al,60h      
    mov tecla,al    
    in  al,61h      
    or  al,80h      
    out 61h,al
    and al,7fh      
    out 61h,al
    mov al,20h      
    out 20h,al
  end;
  case tecla of
    $1      : sai := true;
    $4b     : tec_e := true;
    $4b+$80 : tec_e := false;
    $4d     : tec_d := true;
    $4d+$80 : tec_d := false;
    $48     : tec_c := true;
    $48+$80 : tec_c := false;
    $50     : tec_b := true;
    $50+$80 : tec_b := false;
    $39     : tec_s := true;
    $39+$80 : tec_s := false;
    else;
  end;
end;
{$F-}

procedure jogar(vel:integer);{ ***************************************************** }
begin
  inicio;
  tec_e := false; tec_d := false; tec_c := false ;
  tec_b := false; tec_s := false; sai := false;
  getintvec($09,oldint);
  setintvec($09,addr(keyboardH));
  repeat
    setcolor(0); outtextxy(34,25,sbonus);
    setcolor(3); bonus := bonus-1;
    escrever_bonus(bonus);
    if tec_e then jaime_esquerda;
    if tec_d then jaime_direita;
    if tec_c then jaime_cima(vel);
    if tec_b then jaime_baixo(vel);
    if tec_s then jaime_salta(vel);
    move_bichos(vel);
    if morreu = 1 then
      inicio2;
    if fim = 'sim' then
      sai := true;
  until sai;
  setintvec($09,oldint);
  verifica_pontuacao;
  apres_menu_2;
  tecla := #0; nivel := 1; vidas := 14; pontos := 0; fim := 'nao';
end;

procedure ler_pontuacoes;{ ************************************************* }
var linha : string;
    c     : integer;
    pont  : longint;

procedure calcula_pontuacao;
var d,erro : integer;
    t      : string;
begin
  t := '';
  for d := 31 to 36 do
    t := t + linha[d];
  val(t,pont,erro);
end;

begin
  assign(fichpont,'topjaime.rec');
  reset(fichpont);
  for c := 1 to 10 do
    begin
      readln(fichpont,linha);
      tabpont[c] := linha;
      calcula_pontuacao;
      tabnum[c] := pont;
    end;
  close(fichpont);
end;

procedure gravar_pontuacoes;{ ********************************************** }
var c : integer;
begin
  assign(fichpont,'topjaime.rec');
  rewrite(fichpont);
  for c := 1 to 10 do
    writeln(fichpont,tabpont[c]);
  close(fichpont);
end;

procedure recordes;{ ******************************************************* }
begin
  mostrar_pontuacoes;
  apres_menu_2;
end;

procedure apres_menu;{ ***************************************************** }
begin
  for x := 0 to 4 do
    begin
      apresenta := ptr(seg(apres^),ofs(apres^)+x*846);
      putimage(85,10,apresenta^,xorput);
      delay(400);
      putimage(85,10,apresenta^,xorput);
    end;
  putimage(85,10,apresenta^,xorput);
  for x := 0 to 4 do
    begin
      apresenta := ptr(seg(apres^),ofs(apres^)+4230+x*550);
      putimage(95,50,apresenta^,xorput);
      delay(400);
      putimage(95,50,apresenta^,xorput);
    end;
  putimage(95,50,apresenta^,xorput);
  apresenta := ptr(seg(apres^),ofs(apres^)+6980);
  putimage(90,100,apresenta^,xorput);
  delay(2000);
  apresenta := ptr(seg(apres^),ofs(apres^)+6430);
  putimage(95,50,apresenta^,xorput);
  for x := 4 downto 0 do
    begin
      apresenta := ptr(seg(apres^),ofs(apres^)+4230+x*550);
      putimage(95,50,apresenta^,xorput);
      delay(400);
      putimage(95,50,apresenta^,xorput);
    end;
  settextstyle(triplexfont,horizdir,2);
  setcolor(1); outtextxy(105,45,'F1 - Jogar'); outtextxy(90,65,'F2 - Recordes');
  settextstyle(smallfont,horizdir,4);
  setcolor(3); outtextxy(70,190,'AUTOR : Paulo Alexandre Moreira');
  settextstyle(defaultfont,horizdir,1);
end;

procedure velocidade;{ ***************************************************** }
var c     : integer;
    ss,x  : word;
begin
  c := 0;
  repeat
    gettime(x,x,x,ss);
  until ss < 5;
  repeat
    inc(c);
    gettime(x,x,x,ss);
  until ss > 40;
  if c < 1700  then
    vel := 12
  else
  if (c > 1700) and (c < 2700) then
    vel := 30
  else
    vel := 90;
end;


begin { ************************ modulo principal ************************** }
  abrir_modo_grafico;
  carrega_jaime;
  carrega_bichos;
  carrega_recinto;
  carrega_apresenta;
  ler_pontuacoes;
  velocidade;
  carrega_vsalto;
  apres_menu;
  tecla := #0; nivel := 1; vidas := 14; pontos := 0; fim := 'nao';
  repeat
    if keypressed then
      begin
        tecla := readkey;
        case tecla of
          #59 : jogar(vel);
          #60 : recordes;
        end;
      end;
  until tecla = #27;
  gravar_pontuacoes;
  closegraph;
end.
