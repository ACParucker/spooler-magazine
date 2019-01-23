{*   Auxiliar n§4 do Nutritus 1.0   *}

unit Nutri3;

interface
procedure FullPort;
procedure Avolta;
procedure Cima(Header : string);
procedure Baixo(Msg : string);
procedure Dita(X,Y : Integer; Texto : String);
procedure Som;
procedure Demo;
procedure Ajuda(Ecra : string);
procedure PMenu;
procedure Perc1(Grf : string);
procedure Confirma;
procedure Aju2;
procedure Esco1(Alim, Esco : string);
procedure Esco2(Alim, Esco : string);
procedure Esco3(Alim, Esco : string);
procedure Esco4(Alim, Esco : string);
procedure Esco5(Alim, Esco : string);
procedure Esco6(Alim, Esco : string);
implementation
uses Crt, Graph, Printer, Nutri33;

var
  MaxX, MaxY  : word;
  Feito : Boolean;
  Tecla : Boolean;
  Ch, Ch0, Ch1, Ch2, Ch3, Ch4, Ch5: Char;
  Qual : string;
  Erro : Integer;

{ Declara e define o tamanho da janela visual (ecr„) }
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

{ P”e o titulo do ecr„ no pr¡ncipio dele }
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

{ P”e a mensagem no fim do ecr„ }
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

{ Procedure de escrita em 3d }
procedure Dita(X,Y : Integer; Texto : String);
begin
  SetColor(8);
  OutTextXY(X+1,Y+1, Texto);
  SetColor(15);
  OutTextXY(X,Y, Texto);
end;

{ Emite 2 sons. Usada quando se erra uma tecla }
procedure Som;
begin
  sound(1750);
  delay(100);
  nosound;
  delay(50);
  sound(1750);
  delay(100);
  nosound;
end;

{ Proc. que cria e controla a demonstra‡„o }
procedure Demo;
const
  r  = 20;
var
  Saucer    : pointer;
  X, Y      : integer;
  ulx, uly  : word;
  lrx, lry  : word;
  Size      : word;
  I         : word;
begin
  ulx := 20;
  uly := 20;
  lrx := 95;
  lry := 96;
  Baixo('Desculpem, mas tenho que me ir embora ...');
  delay(1000);
  Size := ImageSize(ulx, uly, lrx, lry);
  GetMem(Saucer, Size);
  GetImage(ulx, uly, lrx, lry, Saucer^);
  PutImage(ulx, uly, Saucer^, XORput);
  X := 20;
  Y := 20;
for I := 1 to 36 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y + 10;
    X := X + 2;
  end;
for I := 1 to 36 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y - 5;
    X := X + 2;
  end;
for I := 1 to 36 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y + 5;
    X := X + 2;
  end;
for I := 1 to 36 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y - 3;
    X := X + 2;
  end;
for I := 1 to 36 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y + 3;
    X := X + 2;
  end;
for I := 1 to 36 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y - 1;
    X := X + 1;
  end;
for I := 1 to 36 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y + 1;
    X := X + 1;
  end;
Y := Y -3;
for I := 1 to 10 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y - 1;
    X := X + 1;
  end;
for I := 1 to 10 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y + 1;
    X := X + 1;
  end;
for I := 1 to 50 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    X := X + 3;
  end;
  Baixo('Mas, o programa ainda n„o acabou, ‚ melhor voltar ...');
  delay(2000);
  X := - 40;
  Y := - 40;
for I := 1 to 30 do
  begin
    PutImage(X, Y, Saucer^, XORput);
    PutImage(X, Y, Saucer^, XORput);
    Y := Y + 2;
    X := X + 2;
  end;
  PutImage(X, Y, Saucer^, XORput);
  FreeMem(Saucer, size);
  Baixo('Pressione Enter para a demonstra‡„o');
end;

{ Proc que controla as teclas e mostra o ecr„ de ajuda para o Nutritus }
procedure Ajuda(Ecra : string);
label 1,2,3,4,5,6,7,8,9,10,11,12,13,14;
const MPad : FillPatternType = (65,28,34,42,42,34,28,65);
var
  Pg, Texto : string;
  Q : word;
  O : Integer;
begin
12:
  setfillstyle(1,7);
  bar(5,15,635,465);
  Cima('Nutritus 1.0 - Ajuda');
  Baixo('Pressione F1 para Ajuda');
  setfillstyle(1,3);
  bar(20,90,620,440);
  setcolor(11);
  line(20,90,620,90);
  line(21,91,619,91);
  line(20,90,20,439);
  line(21,91,21,438);
  setcolor(1);
  line(620,91,620,440);
  line(619,92,619,439);
  line(20,440,620,440);
  line(21,439,619,439);
  setfillstyle(1,8);
  bar(621,100,630,440);
  bar(30,441,630,450);
  SetTextStyle(1,0,5);
  SetTextJustify(1,2);
  setcolor(8);
  outtextxy(322,2, 'Nutritus 1.0');
  setcolor(3);
  outtextxy(321,1, 'Nutritus 1.0');
  setcolor(11);
  outtextxy(320,0, 'Nutritus 1.0');
  SetTextStyle(0,0,2);
  SetTextJustify(0,0);
  setcolor(1);
  rectangle(10,58,629,61);
  setcolor(15);
  rectangle(11,59,630,62);
  if Ecra = '1' then goto 2;
  if Ecra = '2' then goto 3;
  if Ecra = '3' then goto 4;
  if Ecra = '4' then goto 5;
  if Ecra = '5' then goto 6;
1:Pg := '1';
  setfillstyle(1,3);
  bar(25,95,615,435);
  setfillstyle(1,7);
  bar(10,63,630,89);
  SetTextStyle(0,0,2);
  setcolor(8);
  outtextxy(20,85, 'P g. 1 de 7');
  setcolor(10);
  outtextxy(19,84, 'P g. 1 de 7');
  SetTextStyle(2,0,6);
  dita(40,110, 'Descri‡„o:   ()');
  dita(60,130, 'Apare‡e o nome do programa e dois circulos com um pe-');
  dita(60,150, 'queno resumo do programa.');
  dita(40,170, 'Teclas utilizadas nesse ecr„:');
  dita(60,190, 'Qualquer tecla - Vai para o menu principal');
  goto 9;
2:Pg := '2';
  setfillstyle(1,3);
  bar(25,95,615,435);
  setfillstyle(1,7);
  bar(10,63,630,89);
  SetTextStyle(0,0,2);
  setcolor(8);
  outtextxy(20,85, 'P g. 2 de 7');
  setcolor(10);
  outtextxy(19,84, 'P g. 2 de 7');
  SetTextStyle(2,0,6);
  dita(40,110, 'Descri‡„o:   (Menu Principal)');
  dita(60,130, 'S„o listadas  5  barras pressionaveis: Necessidades ali-');
  dita(60,150, 'mentares  di rias; Composi‡„o dos alimentos; Menu de Im-');
  dita(60,170, 'press„o; Ajuda para o Nutritus; Sair para o DOS.');
  dita(40,190, 'Teclas utilizadas nesse ecr„:');
  dita(60,210, '   CB - Pressiona a barra abaixo');
  dita(60,230, '   CC - Pressiona a barra acima');
  dita(60,250, '  Esc - Sai para o DOS');
  dita(60,270, '   F1 - Chama este ecr„');
  dita(60,290, 'Enter - Selecciona a barra pressionada');
  goto 9;
3:Pg := '3';
  setfillstyle(1,3);
  bar(25,95,615,435);
  setfillstyle(1,7);
  bar(10,63,630,89);
  SetTextStyle(0,0,2);
  setcolor(8);
  outtextxy(20,85, 'P g. 3 de 7');
  setcolor(10);
  outtextxy(19,84, 'P g. 3 de 7');
  SetTextStyle(2,0,6);
  dita(40,110, 'Descri‡„o:   (Necessidades alimentares di rias)');
  dita(60,130, '  mostrada   uma   tabela, a   qual   indica   quais');
  dita(60,150, 'as  necessidades   alimentares   que   um   individuo');
  dita(60,170, 'di riamente precisa.');
  dita(40,190, 'Teclas utilizadas nesse ecr„:');
  dita(60,210, '  Esc - Volta para o Menu principal');
  dita(60,230, '   F1 - Chama este ecr„');
  dita(60,250, ' Home - Vai para o princip¡o da tabela');
  dita(60,270, '  End - Vai para o fim da tabela');
  dita(60,290, '  <-- - Move a tabela uma coluna para a direita');
  dita(60,310, '  --> - move a tabela uma coluna para a esquerda');
  goto 9;
4:Pg := '4';
  setfillstyle(1,3);
  bar(25,95,615,435);
  setfillstyle(1,7);
  bar(10,63,630,89);
  SetTextStyle(0,0,2);
  setcolor(8);
  outtextxy(20,85, 'P g. 4 de 7');
  setcolor(10);
  outtextxy(19,84, 'P g. 4 de 7');
  SetTextStyle(2,0,6);
  dita(40,110, 'Descri‡„o:   (Composi‡„o dos alimentos)');
  dita(60,130, 'Tamb‚m  aqui, ‚ mostrada uma tabela com a  composi‡„o');
  dita(60,150, 'dos alimentos consoante os grupos a que pertencem.');
  dita(40,170, 'Teclas utilizadas nesse ecr„:');
  dita(60,190, '    1 - Vai para o 1§ Grupo da Tabela');
  dita(60,210, '    2 - Vai para o 2§ Grupo da Tabela');
  dita(60,230, '    3 - Vai para o 3§ Grupo da Tabela');
  dita(60,250, '    4 - Vai para o 4§ Grupo da Tabela');
  dita(60,270, '    5 - Vai para o 5§ Grupo da Tabela');
  dita(60,290, '  Esc - Volta para o Menu Principal');
  dita(60,310, '   F1 - Chama este ecr„');
  dita(60,330, ' Home - Vai para o canto superior esquerdo da tabela');
  dita(60,350, '  End - Vai para o canto superior direito da tabela');
  dita(60,370, '  <-- - Move a tabela « ecr„ para a direita');
  dita(60,390, '  --> - Move a tabela « ecr„ para a esquerda');
  dita(60,410, ' PgUp - Move a tabela 1 ecr„ para baixo');
  dita(60,430, ' PgDn - Move a tabela 1 ecr„ para cima');
  goto 9;
5:Pg := '5';
  setfillstyle(1,3);
  bar(25,95,615,435);
  setfillstyle(1,7);
  bar(10,63,630,89);
  SetTextStyle(0,0,2);
  setcolor(8);
  outtextxy(20,85, 'P g. 5 de 7');
  setcolor(10);
  outtextxy(19,84, 'P g. 5 de 7');
  SetTextStyle(2,0,6);
  dita(40,110, 'Descri‡„o:   (Menu de Impress„o)');
  dita(60,130, 'Aparecem  4  janelas: Status do Menu de Impress„o(mos-');
  dita(60,150, 'tra a impressora utilizada, a porta  utilizada  para o');
  dita(60,170, 'OUTPUT, qual a forma de alimenta‡„o, o n£mero de  pas-');
  dita(60,190, 'sagens, qual  o  modo  de OUTPUT(gr fico ou texto), as');
  dita(60,210, 'fontes disponiveis, e a percentagem imprimida).');
  dita(40,230, 'Teclas utilizadas nesse ecr„:');
  dita(60,250, '    1 - Manda imprimir Necessidades alimentares di rias');
  dita(60,270, '    2 - Manda imprimir Composi‡„o dos alimentos Grupo 1');
  dita(60,290, '    3 - Manda imprimir Composi‡„o dos alimentos Grupo 2');
  dita(60,310, '    4 - Manda imprimir Composi‡„o dos alimentos Grupo 3');
  dita(60,330, '    5 - Manda imprimir Composi‡„o dos alimentos Grupo 4');
  dita(60,350, '    6 - Manda imprimir Composi‡„o dos alimentos Grupo 5');
  dita(60,370, '    7 - Muda forma de alimenta‡„o(continuo/folha-folha)');
  dita(60,390, '    8 - Muda o n£mero de passagens(1 ou 2 passagens)');
  dita(60,410, '  Esc - Vai para o Menu Principal');
  dita(60,430, '   F1 - Chama este ecr„');
  goto 9;
6:Pg := '6';
  setfillstyle(1,3);
  bar(25,95,615,435);
  setfillstyle(1,7);
  bar(10,63,630,89);
  SetTextStyle(0,0,2);
  setcolor(8);
  outtextxy(20,85, 'P g. 6 de 7');
  setcolor(10);
  outtextxy(19,84, 'P g. 6 de 7');
  SetTextStyle(2,0,6);
  dita(40,110, 'Descri‡„o:   (Menu de Impress„o)');
  dita(60,130, '(surge pressionando os n£meros de 1 a 6)');
  dita(60,150, 'Igual ao anterior, s¢ que as mensagens ‚ que mudaram');
  dita(40,170, 'Teclas utilizadas nesse ecr„:');
  dita(60,190, '    1 - Imprime a folha escolhida');
  dita(60,210, '  Esc - Volta para o ecr„ principal de Menu de Impress„o');
  dita(60,230, '   F1 - Chama este ecr„');
  goto 9;
7:Pg := '7';
  setfillstyle(1,3);
  bar(25,95,615,435);
  setfillstyle(1,7);
  bar(10,63,630,89);
  SetTextStyle(0,0,2);
  setcolor(8);
  outtextxy(20,85, 'P g. 7 de 7');
  setcolor(10);
  outtextxy(19,84, 'P g. 7 de 7');
  SetTextStyle(2,0,6);
  dita(40,110, 'Teclas no  Ajuda para o Nutritus');
  dita(60,130, ' PgUp - Vai para o ecr„ anterior');
  dita(60,150, ' PgDn - Vai para o ecr„ seguinte');
  dita(60,170, '  Esc - Vai atr s');
  dita(60,190, '   F1 - Este ecr„');
  dita(60,210, '   F2 - Acerca do programa e demonstra‡„o');
  goto 9;
8:Pg := '8';
  setfillstyle(1,7);
  bar(5,10,635,465);
  Cima('Nutritus 1.0 - Ajuda');
  Baixo('Pressione Enter para a Demonstra‡„o');
  Logotipo(-80,-80);
  SetTextStyle(1,0,8);
  setcolor(8);
  outtextxy(380,-1, 'Nutritus 1.0');
  setcolor(3);
  outtextxy(376,-5, 'Nutritus 1.0');
  setcolor(11);
  outtextxy(375,-6, 'Nutritus 1.0');
  settextstyle(2,0,6);
  setcolor(8);
  outtextxy(380,78, 'Um Programa sobre Alimenta‡„o e Nutri‡„o ');
  setcolor(3);
  outtextxy(379,77, 'Um Programa sobre Alimenta‡„o e Nutri‡„o ');
  setcolor(11);
  outtextxy(378,76, 'Um Programa sobre Alimenta‡„o e Nutri‡„o ');
  settextstyle(2,0,7);
  settextjustify(0,0);
  setcolor(1);
  rectangle(20,120,460,430);
  setcolor(15);
  rectangle(21,121,461,431);
  setcolor(1);
  rectangle(480,120,620,430);
  setcolor(15);
  rectangle(481,121,621,431);
  dita(55,140, 'Programador:');
  dita(55,180, 'Isaac MSC');
  dita(55,210, 'Tel. (065) 38716');
  dita(55,240, 'Av. Luisa Todi, 339 1Dt');
  dita(55,270, '2900 Set£bal');
  dita(55,300, 'Portugal');
  dita(55,340, 'A todos os que colaboraram para');
  dita(55,370, 'a concretiza‡„o deste programa,');
  dita(55,400, 'Obrigado .');
  setfillpattern(MPad,9);
  bar(490,130,610,160);
  setcolor(1);
  rectangle(490,130,610,160);
  setfillpattern(MPad,10);
  bar(490,170,610,200);
  setcolor(2);
  rectangle(490,170,610,200);
  setfillpattern(MPad,11);
  bar(490,210,610,240);
  setcolor(3);
  rectangle(490,210,610,240);
  setfillpattern(MPad,12);
  bar(490,250,610,280);
  setcolor(4);
  rectangle(490,250,610,280);
  setfillpattern(MPad,13);
  bar(490,290,610,320);
  setcolor(5);
  rectangle(490,290,610,320);
  setfillpattern(MPad,14);
  bar(490,330,610,360);
  setcolor(6);
  rectangle(490,330,610,360);
  setfillpattern(MPad,15);
  bar(490,370,610,400);
  setcolor(8);
  rectangle(490,370,610,400);
  settextstyle(0,0,0);
  dita(495,420,'ass. Isaac MSC');
  o := 8;
  for q := 1 to 2 do
      begin
        setcolor(1+o);
        MoveTo(219+q,379+q);
        LineRel(-25,+15);
        MoveRel(+15,-9);
        LineRel(-2,+25);
        MoveRel(-15,+9);
        LineRel(+25,-15);
        LineRel(+3,-2);
        LineRel(+2,-1);
        LineRel(+1,-1);
        LineRel(+2,-2);
        LineRel(+1,-2);
        LineRel(+1,-2);
        LineRel(0,-1);
        LineRel(-1,-1);
        LineRel(+3,+1);
        LineRel(+2,+1);
        LineRel(+2,+2);
        LineRel(+1,+2);
        LineRel(0,+2);
        LineRel(-2,+1);
        LineRel(-2,+1);
        LineRel(+6,-2);
        LineRel(+3,-1);
        MoveRel(+3,0);
        LineRel(+4,-1);
        MoveRel(+7,-3);
        LineRel(0,-3);
        LineRel(-2,-2);
        LineRel(-2,-1);
        LineRel(-2,0);
        LineRel(-2,+1);
        LineRel(-2,+2);
        LineRel(-2,+2);
        LineRel(-1,+2);
        LineRel(0,+2);
        LineRel(+1,+1);
        MoveRel(+6,-1);
        LineRel(+5,-1);
        LineRel(+1,-2);
        LineRel(+1,-4);
        LineRel(0,+5);
        LineRel(+1,-1);
        LineRel(+3,-1);
        LineRel(+1,+1);
        LineRel(+2,+1);
        LineRel(+2,0);
        LineRel(+1,+1);
        LineRel(+3,0);
        LineRel(+2,-1);
        LineRel(+1,-1);
        LineRel(+1,-2);
        LineRel(0,-2);
        LineRel(-1,-2);
        LineRel(-2,-1);
        LineRel(-2,0);
        LineRel(-3,+1);
        LineRel(-3,+2);
        LineRel(-2,+2);
        MoveRel(+14,-1);
        LineRel(0,-3);
        LineRel(0,+3);
        LineRel(+2,+2);
        LineRel(+2,+1);
        LineRel(+2,0);
        LineRel(+1,-2);
        LineRel(0,-2);
        LineRel(-1,-2);
        LineRel(+1,-1);
        LineRel(+3,+1);
        LineRel(+3,0);
        LineRel(+2,-1);
        LineRel(+1,+1);
        LineRel(-2,+1);
        LineRel(-3,+2);
        LineRel(-2,+1);
        LineRel(-1,+1);
        LineRel(-1,+2);
        LineRel(0,+1);
        LineRel(+2,+1);
        LineRel(+1,+1);
        LineRel(+3,0);
        LineRel(+3,-1);
        LineRel(+2,-1);
        LineRel(+3,-1);
        LineRel(+1,0);
        MoveRel(+26,-18);
        LineRel(+1,+1);
        LineRel(+2,+18);
        LineRel(+1,-8);
        LineRel(+1,-8);
        LineRel(+1,-1);
        LineRel(+2,+12);
        LineRel(+5,-11);
        LineRel(+3,+15);
        LineRel(+1,+1);
        LineRel(+1,0);
        LineRel(+3,-1);
        MoveRel(+20,-15);
        LineRel(-2,-1);
        LineRel(-4,0);
        LineRel(-3,+1);
        LineRel(-2,+2);
        LineRel(-1,+2);
        LineRel(0,+2);
        LineRel(+1,+2);
        LineRel(+2,+1);
        LineRel(+4,0);
        LineRel(+3,+1);
        LineRel(+1,+1);
        LineRel(0,+2);
        LineRel(-1,+2);
        LineRel(-2,+1);
        LineRel(-4,0);
        LineRel(-1,-1);
        LineRel(-2,-1);
        LineRel(-2,0);
        MoveRel(+32,-15);
        LineRel(-2,0);
        LineRel(-3,+1);
        LineRel(-5,+5);
        LineRel(-2,+3);
        LineRel(-1,+1);
        LineRel(0,+3);
        LineRel(+1,+2);
        LineRel(+3,+1);
        LineRel(+3,0);
        LineRel(+10,-3);
        LineRel(+4,-1);
        LineRel(+3,0);
        LineRel(+1,+1);
        MoveRel(+8,+1);
        LineRel(+1,0);
        o := 0;
      end;
13:
  ch:=readkey;
  if ch = chr(0) then ch1:= readkey;
  if ch = chr(13) then
     begin
       Demo;
       goto 13;
     end;
  goto 12;
9:ch:=readkey;
  if ch <> chr(0) then goto 10;
  ch1:=readkey;
  if ch1 = chr(59) then goto 7;
  if ch1 = chr(60) then goto 8;
  if ch1 = chr(73) then
     begin
       if Pg = '1' then goto 7;
       if Pg = '2' then goto 1;
       if Pg = '3' then goto 2;
       if Pg = '4' then goto 3;
       if Pg = '5' then goto 4;
       if Pg = '6' then goto 5;
       if Pg = '7' then goto 6;
     end;
  if ch1 = chr(81) then
     begin
       if Pg = '1' then goto 2;
       if Pg = '2' then goto 3;
       if Pg = '3' then goto 4;
       if Pg = '4' then goto 5;
       if Pg = '5' then goto 6;
       if Pg = '6' then goto 7;
       if Pg = '7' then goto 1;
     end;
  Som;
  goto 9;
10:
  if ch = chr(27) then goto 11;
  Som;
  goto 9;
11:
end;

{ Controla e gere o ecr„ "Print Menu" }
procedure PMenu;
begin
  Baixo('Pressione uma tecla');
  settextstyle(0,0,0);
  settextjustify(0,0);
  Dita(20,355, 'Teclas usadas:');
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
  line(270,390,300,390);
  line(271,391,301,391);
  line(272,392,302,392);
  line(273,393,303,393);
  line(300,390,300,360);
  line(301,391,301,359);
  line(302,392,302,358);
  line(303,393,303,357);
  line(320,390,350,390);
  line(321,391,351,391);
  line(322,392,352,392);
  line(323,393,353,393);
  line(350,390,350,360);
  line(351,391,351,359);
  line(352,392,352,358);
  line(353,393,353,357);
  line(370,390,400,390);
  line(371,391,401,391);
  line(372,392,402,392);
  line(373,393,403,393);
  line(400,390,400,360);
  line(401,391,401,359);
  line(402,392,402,358);
  line(403,393,403,357);
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
  settextjustify(0,2);
  Dita(30,375, '1');
  Dita(80,375, '2');
  Dita(130,375, '3');
  Dita(180,375, '4');
  Dita(230,375, '5');
  Dita(280,375, '6');
  Dita(330,375, '7');
  Dita(380,375, '8');
  Dita(23,425, 'Esc');
  Dita(75,425, 'F1');
  settextstyle(1,0,0);
  settextjustify(1,1);
  setcolor(8);
  outtextxy(321,16, 'Menu de Impress„o');
  setcolor(15);
  outtextxy(319,14, 'Menu de Impress„o');
  setcolor(7);
  outtextxy(320,15, 'Menu de Impress„o');
  settextstyle(2,0,5);
  settextjustify(0,0);
  bar(25,129,250,144);
  bar(25,113,250,128);
  bar(235,188,280,202);
  bar(325,67,615,188);
  bar(325,227,615,345);
  bar(25,247,295,276);
  setcolor(1);
  rectangle(20,50,300,210);
  line(20,65,300,65);
  setcolor(15);
  rectangle(21,51,301,211);
  line(21,66,301,66);
  dita(50, 61, 'Status do Menu de Impress„o');
  dita(30, 80, 'Impressora:  Epson 9 agulhas');
  dita(30, 95, '             (ou compativel)');
  dita(30,110, 'Porta para o output: LPT1');
  dita(30,125, 'Alimenta‡„o: Papel continuo');
  dita(30,140, 'N£mero de passagens: 1');
  dita(30,155, 'Modo de output: Texto');
  dita(30,170, 'Fontes disponiveis na impressora:');
  dita(30,185, '          Pica, Elite e Condensed');
  dita(30,200, 'Percentagem imprimida:');
  settextjustify(2,0);
  dita(270,200, '  0%');
  settextjustify(0,0);
  setcolor(1);
  rectangle(320,50,620,190);
  line(320,65,620,65);
  setcolor(15);
  rectangle(321,51,621,191);
  line(321,66,621,66);
  dita(405,61, 'Menu de escolha');
  dita(330,80, '1- Necessidades alimentares di rias');
  dita(330,95, '2- Composi‡„o dos alimentos Grupo I');
  dita(330,110, '3- Composi‡„o dos alimentos Grupo II');
  dita(330,125, '4- Composi‡„o dos alimentos Grupo III');
  dita(330,140, '5- Composi‡„o dos alimentos Grupo IV');
  dita(330,155, '6- Composi‡„o dos alimentos Grupo V');
  dita(330,170, '7- Mudar a forma de alimenta‡„o');
  dita(330,185, '8- Mudar as passagens na impressora');
  setcolor(1);
  rectangle(320,210,620,350);
  line(320,225,620,225);
  setcolor(15);
  rectangle(321,211,621,351);
  line(321,226,621,226);
  dita(390,221, 'Janela de mensagens');
  dita(330,240, 'Escolha pressionando o n£mero corres');
  dita(326,241, '                                   _');
  dita(330,255, 'pondente, qual a ac‡„o a tomar.');
  setcolor(1);
  rectangle(20,230,300,280);
  line(20,245,300,245);
  setcolor(15);
  rectangle(21,231,301,281);
  line(21,246,301,246);
  dita(100,241, 'Janela de ac‡„o');
  dita(30,260, 'Esperando resposta atrav‚s do');
  dita(30,275, 'teclado');
end;

{ Mostra a percentagem imprimida }
procedure Perc1;
begin
  settextstyle(2,0,5);
  settextjustify(2,0);
  bar(235,188,280,202);
  dita(270,200, Grf);
  settextjustify(0,0);
end;

{ Uma proc ajuda ao "Print Menu" }
procedure Aju2;
begin
  bar(15,356,70,395);
  bar(15,395,105,450);
  bar(325,67,615,188);
  bar(325,227,615,345);
  bar(25,247,295,276);
  dita(330,240, 'Aguarde enquanto imprime:');
end;

{ Confirma se a impress„o foi conclu¡da (n„o confirma coisa nenhuma) }
procedure Confirma;
begin
  setcolor(8);
  delay(2000);
  Perc1('100%');
  bar(325,67,615,188);
  bar(325,227,615,345);
  bar(25,247,295,276);
  dita(330,240, 'Impress„o concluida');
  dita(30,260, 'Esperando impressora confirmar');
  delay(2000);
  Erro := 0;
end;

{ Se o utilizador pressionar em 1 then do this procedure and imprime }
procedure Esco1;
Label 1,2,3,4,5,6,7,8,9;
begin
  settextstyle(2,0,5);
  settextjustify(0,0);
  goto 3;
4:Cima('Nutritus 1.0 - Menu de Impress„o');
  Baixo('Pressione uma tecla');
  PMenu;
3:bar(70,356,505,395);
  bar(325,67,615,188);
  bar(325,227,615,345);
  dita(330,80, '1- Imprime a folha escolhida');
  if Alim = '1' then goto 5;
  dita(330,240, 'Ligue, insira o papel continuo, e');
  goto 6;
5:dita(330,240, 'Ligue, insira a folha, e');
6:dita(330,255, 'ponha a impressora em ON LINE');
  dita(330,270, 'Pressione 1 para imprimir:');
  dita(330,285, 'Necessidades Alimentares Di rias');
2:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('5');
                 goto 4;
               end;
        else
          Som;
        end;
      end;
      #27: Goto 1;
      #49: Feito:= True;
    else
      Som;
    end;
  until Feito;
  Aju2;
  dita(330,255, 'Necessidades Alimentares Di rias');
  dita(30,260, 'Impress„o em curso ...');
  Baixo('Aguarde ...');
  Erro := 1;
  if Esco = '1' then goto 7;
  WriteLn(Lst, #27, 'G', #14, '    Necessidades Alimentares Di rias', #27,'P');
  goto 8;
7:WriteLn(Lst, #14, '    Necessidades Alimentares Di rias', #27,'P');
8:WriteLn(Lst, #15,#13);
  Perc1('  4%');
  WriteLn(Lst, '     ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ',
  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  Perc1('  8%');
  WriteLn(Lst, '     ³                          ³        ³Compostos orgƒnicos(em g) ³Elementos minerais(em mg) ³',
  '         Vitaminas (em mg)         ³');
  Perc1(' 12%');
  WriteLn(Lst, '     ³                          ³        ÃÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ´');
  Perc1(' 16%');
  WriteLn(Lst, '     ³                          ³Calorias³Protidos³Lip¡dos ³Gl¡cidos³F¢sforo ³ C lcio ³ Ferro  ³',
  '   C    ³B1 e B2 ³A+Prov.A³   D    ³');
  Perc1(' 20%');
  WriteLn(Lst, '     ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ´');
  Perc1(' 24%');
  WriteLn(Lst, '     ³ Crian‡as e Adolescentes  ³        ³        ³        ³        ³        ³        ³        ³',
  '        ³        ³        ³        ³');
  Perc1(' 28%');
  WriteLn(Lst, '     ³   1 a 2  anos            ³  880.0 ³   35.0 ³   30.0 ³  128.0 ³  600.0 ³  700.0 ³    6.0 ³',
  '   30.0 ³    1.2 ³    1.5 ³   0.02 ³');
  Perc1(' 32%');
  WriteLn(Lst, '     ³   2 a 4  anos            ³ 1300.0 ³   50.0 ³   36.0 ³  198.0 ³  700.0 ³  900.0 ³    8.0 ³',
  '   40.0 ³    2.0 ³    1.8 ³   0.02 ³');
  Perc1(' 36%');
  WriteLn(Lst, '     ³   4 a 9  anos            ³ 1900.0 ³   75.0 ³   53.0 ³  296.0 ³ 1000.0 ³  950.0 ³   13.0 ³',
  '   60.0 ³    2.5 ³    2.0 ³   0.02 ³');
  Perc1(' 40%');
  WriteLn(Lst, '     ³  10 a 14 anos            ³ 2800.0 ³  100.0 ³   77.0 ³  445.0 ³ 1500.0 ³ 1300.0 ³   18.0 ³',
  '   90.0 ³    3.6 ³    2.5 ³   0.02 ³');
  Perc1(' 44%');
  WriteLn(Lst, '     ³  15 a 19 anos            ³ 3000.0 ³  120.0 ³   85.0 ³  480.0 ³ 1700.0 ³ 1300.0 ³   18.0 ³',
  '  100.0 ³    4.0 ³    5.0 ³   0.01 ³');
  Perc1(' 48%');
  WriteLn(Lst, '     ³ Mulheres Adultas         ³        ³        ³        ³        ³        ³        ³        ³',
  '        ³        ³        ³        ³');
  Perc1(' 52%');
  WriteLn(Lst, '     ³  Trabalho reduzido       ³ 2200.0 ³   60.0 ³   35.0 ³  410.0 ³ 1200.0 ³  800.0 ³   15.0 ³',
  '   60.0 ³    2.0 ³    2.0 ³   0.01 ³');
  Perc1(' 56%');
  WriteLn(Lst, '     ³  Gravidez (6§ ao 9§ mˆs) ³ 2500.0 ³   80.0 ³   40.0 ³  430.0 ³ 1400.0 ³  950.0 ³   20.0 ³',
  '   90.0 ³    3.5 ³    2.6 ³   0.02 ³');
  Perc1(' 60%');
  WriteLn(Lst, '     ³  Aleita‡„o               ³ 2800.0 ³   85.0 ³   70.0 ³  440.0 ³ 1500.0 ³ 1100.0 ³   18.0 ³',
  '  110.0 ³    3.5 ³    4.0 ³   0.02 ³');
  Perc1(' 64%');
  WriteLn(Lst, '     ³ Homens Adultos           ³        ³        ³        ³        ³        ³        ³        ³',
  '        ³        ³        ³        ³');
  Perc1(' 68%');
  WriteLn(Lst, '     ³  Trabalho reduzido       ³ 2400.0 ³   70.0 ³   40.0 ³  450.0 ³ 1300.0 ³  900.0 ³   15.0 ³',
  '   70.0 ³    2.4 ³    2.0 ³   0.01 ³');
  Perc1(' 72%');
  WriteLn(Lst, '     ³  Trabalho m‚dio          ³ 2900.0 ³   85.0 ³   50.0 ³  470.0 ³ 1500.0 ³  950.0 ³   18.0 ³',
  '   80.0 ³    2.8 ³    2.5 ³   0.01 ³');
  Perc1(' 76%');
  WriteLn(Lst, '     ³  Trabalho pesado         ³ 3400.0 ³  100.0 ³   55.0 ³  490.0 ³ 1700.0 ³ 1000.0 ³   20.0 ³',
  '  100.0 ³    3.2 ³    3.0 ³   0.01 ³');
  Perc1(' 80%');
  WriteLn(Lst, '     ³ Pessoas idosas           ³ 1800.0 ³   40.0 ³   25.0 ³  300.0 ³ 1000.0 ³  600.0 ³   10.0 ³',
  '   60.0 ³    2.0 ³    1.5 ³   0.05 ³');
  Perc1(' 84%');
  WriteLn(Lst, '     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁ',
  'ÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÙ');
  Perc1(' 88%');
  WriteLn(Lst, #18, '                                 Nutritus 1.0 programado em Pascal por Isaac MSC');
  Perc1(' 92%');
  WriteLn(Lst, #27, 'H', #12);
  Perc1(' 96%');
  Confirma;
1:
end;

{ Se o utilizador pressionar em 2 then do this procedure and imprime }
procedure Esco2;
Label 1,2,3,4,5,6,7,8,9;
begin
  settextstyle(2,0,5);
  settextjustify(0,0);
  goto 3;
4:Cima('Nutritus 1.0 - Menu de Impress„o');
  Baixo('Pressione uma tecla');
  PMenu;
3:bar(70,356,505,395);
  bar(325,67,615,188);
  bar(325,227,615,345);
  dita(330,80, '1- Imprime a folha escolhida');
  if Alim = '1' then goto 5;
  dita(330,240, 'Ligue, insira o papel continuo, e');
  goto 6;
5:dita(330,240, 'Ligue, insira a folha, e');
6:dita(330,255, 'ponha a impressora em ON LINE');
  dita(330,270, 'Pressione 1 para imprimir:');
  dita(330,285, 'Composi‡„o dos alimentos Grupo I');
2:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('5');
                 goto 4;
               end;
        else
          Som;
        end;
      end;
      #27: Goto 1;
      #49: Feito:= True;
    else
      Som;
    end;
  until Feito;
  Aju2;
  dita(330,255, 'Composi‡„o dos alimentos Grupo I');
  dita(30,260, 'Impress„o em curso ...');
  Baixo('Aguarde ...');
  Erro := 1;
  if Esco = '1' then goto 7;
  WriteLn(Lst, #27, 'G', #14, '        Composi‡„o dos alimentos');
  goto 8;
7:WriteLn(Lst, #14, '        Composi‡„o dos alimentos');
8:WriteLn(Lst, #27, 'P', #15, #13);
  Perc1('  3%');
  WriteLn(Lst, 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ',
  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  Perc1('  7%');
  WriteLn(Lst, '³  Composi‡„o de 100g   ³      ³      ³      ³      ³      ³      ³            Vitaminas             ³',
  '             Minerais             ³');
  Perc1(' 10%');
  WriteLn(Lst, '³                       ³Parte ³Calo- ³ Gl¡- ³L¡pi- ³ Pro- ³Coles-ÃÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄ´');
  Perc1(' 14%');
  WriteLn(Lst, '³                       ³edivel³ rias ³cidos ³ dos  ³te¡nas³terol ³  A   ³  B1  ³  B2  ³  PP  ³  C   ³',
  'C lcio³Ferro ³Cobre ³Zinco ³ Iodo ³');
  Perc1(' 17%');
  WriteLn(Lst, '³       Grupo I         ³  %   ³      ³  g   ³  g   ³  g   ³  mg  ³  UI  ³  æg  ³  æg  ³  mg  ³  mg  ³',
  '  mg  ³  mg  ³  mg  ³  æg  ³  æg  ³');
  Perc1(' 21%');
  WriteLn(Lst, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄ´');
  Perc1(' 24%');
  WriteLn(Lst, '³Leite, mulher          ³  100 ³   66 ³  7.5 ³  3.4 ³  1.4 ³   20 ³  450 ³   78 ³   34 ³  0.2 ³    4 ³',
  '   32 ³  0.1 ³  0.1 ³   90 ³   12 ³');
  Perc1(' 28%');
  WriteLn(Lst, '³  vaca, estabulo       ³  100 ³   64 ³  4.9 ³  3.5 ³  3.3 ³   13 ³  700 ³   87 ³  158 ³  0.1 ³    3 ³',
  '  126 ³  0.1 ³ 0.07 ³  280 ³  701 ³');
  Perc1(' 31%');
  WriteLn(Lst, '³    mercado            ³  100 ³   57 ³  4.6 ³  3.0 ³  3.0 ³   12 ³  230 ³   54 ³  138 ³  0.2 ³    1 ³',
  '  126 ³  0.1 ³ 0.07 ³      ³      ³');
  Perc1(' 35%');
  WriteLn(Lst, '³  Condensado, a‡ucarado³  100 ³  339 ³ 56.9 ³  9.0 ³  7.6 ³   33 ³  700 ³  100 ³  400 ³  0.6 ³    4 ³',
  '  330 ³  0.6 ³  0.3 ³      ³      ³');
  Perc1(' 38%');
  WriteLn(Lst, '³    n„o a‡ucarado      ³  100 ³  150 ³ 10.2 ³  8.9 ³  7.3 ³      ³  450 ³  100 ³  300 ³  0.6 ³    1 ³',
  '  250 ³  0.3 ³  0.1 ³      ³      ³');
  Perc1(' 42%');
  WriteLn(Lst, '³  em p¢, completo      ³  100 ³  503 ³ 38.0 ³ 27.5 ³ 26.0 ³   69 ³ 1280 ³  350 ³ 1200 ³  1.5 ³   18 ³',
  '  980 ³  0.8 ³  0.2 ³ 2100 ³   28 ³');
  Perc1(' 45%');
  WriteLn(Lst, '³    meio gordo         ³  100 ³  432 ³ 45.0 ³ 14.0 ³ 31.5 ³   41 ³  688 ³  340 ³ 1300 ³  1.5 ³   25 ³',
  ' 1100 ³  0.8 ³  0.2 ³ 2960 ³   49 ³');
  Perc1(' 49%');
  WriteLn(Lst, '³    magro              ³  100 ³  357 ³ 52.5 ³  0.8 ³ 35.0 ³   23 ³vesti.³  350 ³ 1800 ³  1.5 ³   16 ³',
  ' 1260 ³  0.8 ³  0.2 ³ 3000 ³   59 ³');
  Perc1(' 52%');
  WriteLn(Lst, '³Iogurte                ³  100 ³   59 ³  4.3 ³  3.2 ³  3.2 ³   13 ³  200 ³   60 ³  128 ³  0.1 ³vesti.³',
  '  125 ³  0.2 ³  0.1 ³  280 ³  7.0 ³');
  Perc1(' 56%');
  WriteLn(Lst, '³Nata, 45% gordura      ³  100 ³  421 ³  2.4 ³ 45.0 ³  1.7 ³   86 ³ 2000 ³   40 ³  120 ³  0.1 ³vesti.³',
  '   67 ³  0.5 ³vesti.³vesti.³  5.5 ³');
  Perc1(' 59%');
  WriteLn(Lst, '³Queijo, fresco         ³  100 ³  279 ³  0.2 ³ 24.0 ³ 15.7 ³   46 ³  860 ³  305 ³  400 ³  0.6 ³ n.a. ³',
  '  590 ³  0.9 ³  0.2 ³      ³      ³');
  Perc1(' 63%');
  WriteLn(Lst, '³  flamengo, 20% gordura³   85 ³  185 ³  0.2 ³  7.5 ³ 29.5 ³   30 ³  795 ³  248 ³  330 ³  0.3 ³ n.a. ³',
  '  864 ³  0.8 ³  0.1 ³      ³      ³');
  Perc1(' 67%');
  WriteLn(Lst, '³    40% gordura        ³   85 ³  315 ³  0.2 ³ 23.4 ³ 26.0 ³   69 ³  895 ³  320 ³  400 ³  0.4 ³ n.a. ³',
  '  800 ³  0.8 ³  0.2 ³ 5300 ³   20 ³');
  Perc1(' 70%');
  WriteLn(Lst, '³  fundido, 40% gordura ³  100 ³  321 ³  0.2 ³ 25.7 ³ 22.5 ³   50 ³  805 ³  215 ³  320 ³  0.6 ³ n.a. ³',
  '  750 ³  0.8 ³  0.3 ³ 2660 ³   18 ³');
  Perc1(' 74%');
  WriteLn(Lst, '³  serra, amanteigado   ³   81 ³  327 ³  0.2 ³ 27.0 ³ 21.0 ³   88 ³  800 ³  450 ³  600 ³  0.7 ³ n.a. ³',
  '  700 ³  0.7 ³  0.2 ³      ³      ³');
  Perc1(' 77%');
  WriteLn(Lst, '³    curado             ³   85 ³  385 ³  0.2 ³ 31.5 ³ 25.5 ³   81 ³  950 ³  500 ³  650 ³  0.8 ³ n.a. ³',
  '  815 ³  0.8 ³  0.2 ³ 2950 ³   36 ³');
  Perc1(' 81%');
  WriteLn(Lst, '³Requeij„o              ³  100 ³  308 ³  3.3 ³ 28.6 ³  9.5 ³   80 ³  190 ³  270 ³  460 ³vesti.³ n.a. ³',
  '  250 ³  1.2 ³  0.2 ³      ³      ³');
  Perc1(' 84%');
  WriteLn(Lst, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁ',
  'ÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÙ');
  Perc1(' 88%');
  WriteLn(Lst, #18, '                                 Nutritus 1.0 programado em Pascal por Isaac MSC');
  Perc1(' 92%');
  WriteLn(Lst, #27, 'H', #12);
  Perc1(' 96%');
  Confirma;
1:
end;

{ Se o utilizador pressionar em 3 then do this procedure and imprime }
procedure Esco3;
Label 1,2,3,4,5,6,7,8,9;
begin
  settextstyle(2,0,5);
  settextjustify(0,0);
  goto 3;
4:Cima('Nutritus 1.0 - Menu de Impress„o');
  Baixo('Pressione uma tecla');
  PMenu;
3:bar(70,356,505,395);
  bar(325,67,615,188);
  bar(325,227,615,345);
  dita(330,80, '1- Imprime a folha escolhida');
  if Alim = '1' then goto 5;
  dita(330,240, 'Ligue, insira o papel continuo, e');
  goto 6;
5:dita(330,240, 'Ligue, insira a folha, e');
6:dita(330,255, 'ponha a impressora em ON LINE');
  dita(330,270, 'Pressione 1 para imprimir:');
  dita(330,285, 'Composi‡„o dos alimentos Grupo II');
2:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('5');
                 goto 4;
               end;
        else
          Som;
        end;
      end;
      #27: Goto 1;
      #49: Feito:= True;
    else
      Som;
    end;
  until Feito;
  Aju2;
  dita(330,255, 'Composi‡„o dos alimentos Grupo II');
  dita(30,260, 'Impress„o em curso ...');
  Baixo('Aguarde ...');
  Erro := 1;
  if Esco = '1' then goto 7;
  WriteLn(Lst, #27, 'G', #14, '        Composi‡„o dos alimentos');
  goto 8;
7:WriteLn(Lst, #14, '        Composi‡„o dos alimentos');
8:WriteLn(Lst, #27, 'P', #15, #13);
  Perc1('  2%');
  WriteLn(Lst, 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ',
  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  Perc1('  4%');
  WriteLn(Lst, '³  Composi‡„o de 100g   ³      ³      ³      ³      ³      ³      ³            Vitaminas             ³',
  '             Minerais             ³');
  Perc1('  6%');
  WriteLn(Lst, '³                       ³Parte ³Calo- ³ Gl¡- ³L¡pi- ³ Pro- ³Coles-ÃÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄ´');
  Perc1('  8%');
  WriteLn(Lst, '³                       ³edivel³ rias ³cidos ³ dos  ³te¡nas³terol ³  A   ³  B1  ³  B2  ³  PP  ³  C   ³',
  'C lcio³Ferro ³Cobre ³Zinco ³ Iodo ³');
  Perc1(' 10%');
  WriteLn(Lst, '³       Grupo II        ³  %   ³      ³  g   ³  g   ³  g   ³  mg  ³  UI  ³  æg  ³  æg  ³  mg  ³  mg  ³',
  '  mg  ³  mg  ³  mg  ³  æg  ³  æg  ³');
  Perc1(' 11%');
  WriteLn(Lst, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄ´');
  Perc1(' 13%');
  WriteLn(Lst, '³Carne, Borrego         ³   50 ³  133 ³  0.3 ³  5.2 ³ 20.3 ³      ³ n.a. ³  345 ³  180 ³  5.5 ³ n.a. ³',
  '   17 ³  1.8 ³  0.3 ³      ³      ³');
  Perc1(' 15%');
  WriteLn(Lst, '³  Cabrito              ³   75 ³  117 ³  0.2 ³  3.8 ³ 20.5 ³   94 ³ n.a. ³  300 ³  320 ³  6.1 ³ n.a. ³',
  '   11 ³  0.5 ³  0.3 ³      ³      ³');
  Perc1(' 17%');
  WriteLn(Lst, '³  Carneiro             ³   70 ³  131 ³  0.2 ³  5.6 ³ 19.8 ³   86 ³ n.a. ³  325 ³  207 ³  5.0 ³ n.a. ³',
  '   18 ³  1.5 ³  0.3 ³ 2950 ³   36 ³');
  Perc1(' 19%');
  WriteLn(Lst, '³  Coelho               ³   34 ³  119 ³  0.4 ³  4.0 ³ 20.3 ³   48 ³vesti.³  200 ³  180 ³  4.0 ³ n.a. ³',
  '   17 ³  2.1 ³  0.2 ³ 1500 ³   19 ³');
  Perc1(' 20%');
  WriteLn(Lst, '³  Frango               ³   40 ³  140 ³  0.2 ³  6.8 ³ 19.6 ³  113 ³vesti.³  180 ³  110 ³  4.5 ³ n.a. ³',
  '   20 ³  2.0 ³  0.2 ³ 1000 ³   18 ³');
  Perc1(' 22%');
  WriteLn(Lst, '³  Galinha              ³   42 ³  186 ³  0.2 ³ 11.0 ³ 21.5 ³  101 ³vesti.³  260 ³  120 ³  3.5 ³ n.a. ³',
  '   16 ³  1.5 ³  0.1 ³ 1000 ³   32 ³');
  Perc1(' 24%');
  WriteLn(Lst, '³  Pato                 ³   50 ³  210 ³  0.3 ³ 13.0 ³ 23.0 ³   85 ³vesti.³  240 ³  184 ³ 10.0 ³ n.a. ³',
  '   15 ³  3.0 ³  0.3 ³      ³      ³');
  Perc1(' 26%');
  WriteLn(Lst, '³  Peru                 ³   55 ³  138 ³  0.2 ³  6.1 ³ 20.5 ³      ³vesti.³  200 ³  140 ³  8.0 ³ n.a. ³',
  '   18 ³  2.0 ³  0.2 ³      ³      ³');
  Perc1(' 28%');
  WriteLn(Lst, '³  Porco                ³   90 ³  167 ³  0.4 ³  9.1 ³ 20.0 ³   74 ³ n.a. ³ 1500 ³  140 ³  4.5 ³ n.a. ³',
  '   16 ³  1.4 ³  0.2 ³ 2130 ³   30 ³');
  Perc1(' 30%');
  WriteLn(Lst, '³    figado             ³  100 ³  135 ³  1.8 ³  5.0 ³ 20.9 ³  237 ³30000 ³  595 ³ 1300 ³ 15.5 ³   28 ³',
  '   14 ³  7.8 ³  1.0 ³ 3300 ³   21 ³');
  Perc1(' 31%');
  WriteLn(Lst, '³  Vaca                 ³  100 ³  176 ³  0.3 ³  9.8 ³ 21.7 ³  196 ³ n.a. ³  240 ³  175 ³  4.2 ³ n.a. ³',
  '   12 ³  1.3 ³  0.3 ³ 3600 ³   21 ³');
  Perc1(' 33%');
  WriteLn(Lst, '³    figado             ³  100 ³  132 ³  2.1 ³  4.4 ³ 20.9 ³  283 ³32000 ³  450 ³ 1550 ³ 10.0 ³   27 ³',
  '   12 ³  5.7 ³  1.6 ³ 2650 ³   18 ³');
  Perc1(' 35%');
  WriteLn(Lst, '³  Vitela               ³   71 ³  149 ³  0.2 ³  7.6 ³ 19.9 ³   91 ³ n.a. ³  220 ³  210 ³  3.6 ³ n.a. ³',
  '   14 ³  0.9 ³  0.4 ³ 3000 ³   25 ³');
  Perc1(' 37%');
  WriteLn(Lst, '³    figado             ³  100 ³  148 ³  1.5 ³  6.7 ³ 20.3 ³  286 ³39600 ³  560 ³ 1561 ³ 11.0 ³   30 ³',
  '   12 ³  6.5 ³  4.7 ³ 5000 ³   25 ³');
  Perc1(' 39%');
  WriteLn(Lst, '³  Chouri‡o de carne    ³   94 ³  390 ³  0.2 ³ 32.5 ³ 24.5 ³   85 ³    - ³  690 ³  200 ³  5.0 ³ n.a. ³',
  '   30 ³  2.7 ³  0.2 ³      ³      ³');
  Perc1(' 40%');
  WriteLn(Lst, '³    de sangue          ³   87 ³  605 ³vesti.³ 62.5 ³ 11.5 ³   63 ³    - ³  140 ³  100 ³  1.0 ³ n.a. ³',
  '   21 ³ 13.0 ³  0.4 ³      ³      ³');
  Perc1(' 42%');
  WriteLn(Lst, '³  Farinheira           ³   94 ³  595 ³ 26.7 ³ 52.0 ³  4.8 ³   58 ³    - ³  160 ³  110 ³  2.0 ³ n.a. ³',
  '   25 ³  1.6 ³  0.2 ³      ³      ³');
  Perc1(' 44%');
  WriteLn(Lst, '³  Fiambre              ³  100 ³  304 ³  0.5 ³ 25.5 ³ 18.0 ³   64 ³    - ³  650 ³  150 ³  4.0 ³ n.a. ³',
  '   18 ³  0.9 ³  0.3 ³ 2950 ³   22 ³');
  Perc1(' 46%');
  WriteLn(Lst, '³  Mortadela            ³   99 ³  386 ³  2.7 ³ 33.2 ³ 18.3 ³   56 ³    - ³  350 ³  165 ³  5.6 ³ n.a. ³',
  '   21 ³  2.2 ³  0.5 ³      ³      ³');
  Perc1(' 48%');
  WriteLn(Lst, '³  Paio                 ³   94 ³  364 ³  0.2 ³ 30.0 ³ 22.8 ³   77 ³    - ³  650 ³  200 ³  6.0 ³ n.a. ³',
  '   24 ³  1.5 ³  0.3 ³      ³      ³');
  Perc1(' 50%');
  WriteLn(Lst, '³  Presunto             ³   95 ³  252 ³  0.1 ³ 17.0 ³ 25.0 ³   92 ³    - ³  750 ³  280 ³  6.0 ³ n.a. ³',
  '   23 ³  2.0 ³  0.5 ³ 3900 ³   22 ³');
  Perc1(' 51%');
  WriteLn(Lst, '³  Salpic„o             ³   97 ³  285 ³  0.2 ³ 19.0 ³ 28.0 ³   84 ³    - ³  650 ³  200 ³  5.0 ³ n.a. ³',
  '   25 ³  1.1 ³  0.1 ³ 3000 ³   30 ³');
  Perc1(' 53%');
  WriteLn(Lst, '³Peixe, carapau         ³   53 ³   99 ³  0.1 ³  2.3 ³ 19.5 ³      ³ n.a. ³  180 ³  130 ³  2.5 ³vesti.³',
  '   30 ³  0.7 ³  0.2 ³  460 ³   46 ³');
  Perc1(' 55%');
  WriteLn(Lst, '³  cherne               ³   70 ³   86 ³  0.2 ³  0.7 ³ 19.7 ³   36 ³ n.a. ³  187 ³   39 ³  3.1 ³vesti.³',
  '   15 ³  0.3 ³  0.1 ³  290 ³   59 ³');
  Perc1(' 57%');
  WriteLn(Lst, '³  corvina              ³   71 ³   88 ³  0.2 ³  1.2 ³ 19.1 ³      ³ n.a. ³  150 ³   39 ³  2.4 ³vesti.³',
  '   14 ³  0.6 ³  0.1 ³      ³      ³');
  Perc1(' 59%');
  WriteLn(Lst, '³  anguia               ³   90 ³  128 ³  0.1 ³  6.3 ³ 17.8 ³  117 ³ n.a. ³  150 ³  160 ³  1.5 ³vesti.³',
  '  200 ³  1.3 ³  0.2 ³      ³      ³');
  Perc1(' 60%');
  WriteLn(Lst, '³  faneca               ³   74 ³   82 ³  0.1 ³  0.6 ³ 19.0 ³   60 ³ n.a. ³  175 ³   52 ³  1.8 ³vesti.³',
  '   25 ³  0.6 ³  0.2 ³  170 ³   56 ³');
  Perc1(' 62%');
  WriteLn(Lst, '³  garoupa              ³   75 ³   95 ³  0.1 ³  1.4 ³ 20.5 ³      ³ n.a. ³  200 ³   47 ³  1.1 ³vesti.³',
  '   18 ³  0.6 ³  0.1 ³      ³      ³');
  Perc1(' 64%');
  WriteLn(Lst, '³  linguado             ³   65 ³   84 ³  0.1 ³  0.5 ³ 19.7 ³      ³ n.a. ³  197 ³   57 ³  1.9 ³vesti.³',
  '   30 ³  0.5 ³  0.1 ³      ³      ³');
  Perc1(' 66%');
  WriteLn(Lst, '³  peixe-espada         ³   72 ³   84 ³  0.1 ³  0.8 ³ 19.2 ³      ³ n.a. ³  100 ³   36 ³  1.2 ³vesti.³',
  '   25 ³  0.5 ³  0.1 ³      ³      ³');
  Perc1(' 68%');
  WriteLn(Lst, '³  pescada              ³   63 ³   74 ³  0.1 ³  0.4 ³ 17.4 ³   40 ³ n.a. ³  119 ³   50 ³  1.3 ³vesti.³',
  '   32 ³  0.6 ³  0.1 ³  200 ³   31 ³');
  Perc1(' 70%');
  WriteLn(Lst, '³  sardinha             ³   60 ³  230 ³  0.1 ³ 17.2 ³ 18.8 ³   52 ³vesti.³  160 ³  138 ³  4.5 ³vesti.³',
  '   48 ³  0.6 ³  0.2 ³  260 ³   30 ³');
  Perc1(' 71%');
  WriteLn(Lst, '³  Conserva, atum       ³  100 ³  232 ³vesti.³ 13.2 ³ 28.4 ³   41 ³vesti.³  270 ³   95 ³  4.7 ³ n.a. ³',
  '   21 ³  1.0 ³  0.3 ³      ³   24 ³');
  Perc1(' 73%');
  WriteLn(Lst, '³    pescada            ³   86 ³  245 ³  0.1 ³ 15.8 ³ 25.5 ³   50 ³vesti.³  160 ³  215 ³  4.6 ³ n.a. ³',
  '   66 ³  1.1 ³  0.2 ³      ³   33 ³');
  Perc1(' 75%');
  WriteLn(Lst, '³  Marisco, ameijoa     ³   27 ³   71 ³  1.6 ³  1.3 ³ 13.2 ³  112 ³vesti.³   36 ³  150 ³  1.7 ³vesti.³',
  '   63 ³ 10.5 ³  0.2 ³ 1600 ³  150 ³');
  Perc1(' 77%');
  WriteLn(Lst, '³    berbig„o           ³   21 ³   59 ³  2.7 ³  0.7 ³ 10.5 ³   97 ³vesti.³   50 ³  110 ³  1.7 ³vesti.³',
  '   58 ³  9.0 ³  0.3 ³ 1100 ³   80 ³');
  Perc1(' 79%');
  WriteLn(Lst, '³    camar„o            ³   34 ³   92 ³  0.3 ³  1.1 ³ 20.2 ³  154 ³vesti.³   80 ³  100 ³  2.2 ³vesti.³',
  '   86 ³  0.6 ³  0.6 ³ 1350 ³   36 ³');
  Perc1(' 80%');
  WriteLn(Lst, '³  Choco                ³   73 ³   76 ³  0.4 ³  1.0 ³ 16.5 ³      ³vesti.³  124 ³   47 ³  1.0 ³vesti.³',
  '   29 ³  0.7 ³  0.3 ³      ³      ³');
  Perc1(' 82%');
  WriteLn(Lst, '³  Lagosta              ³   48 ³   90 ³  0.2 ³  0.8 ³ 20.6 ³   93 ³vesti.³   96 ³   57 ³  2.0 ³vesti.³',
  '   60 ³  0.9 ³  0.7 ³      ³      ³');
  Perc1(' 84%');
  WriteLn(Lst, '³  Lula                 ³   88 ³   84 ³  0.3 ³  1.2 ³ 18.0 ³  222 ³vesti.³  126 ³   48 ³  1.2 ³vesti.³',
  '   28 ³  0.5 ³  0.3 ³      ³      ³');
  Perc1(' 86%');
  WriteLn(Lst, '³  Polvo, fresco        ³   78 ³   66 ³  0.2 ³  0.4 ³ 15.3 ³  140 ³vesti.³   80 ³   35 ³  0.9 ³ n.a. ³',
  '   33 ³  0.3 ³vesti.³  630 ³   44 ³');
  Perc1(' 88%');
  WriteLn(Lst, '³    curado             ³  100 ³  199 ³  0.7 ³  1.2 ³ 46.4 ³      ³vesti.³  194 ³   25 ³  2.5 ³ n.a. ³',
  '   46 ³  1.5 ³  0.2 ³      ³      ³');
  Perc1(' 90%');
  WriteLn(Lst, '³Ovo, completo          ³   88 ³  155 ³  0.6 ³ 11.6 ³ 12.0 ³  619 ³ 1100 ³  110 ³  280 ³  0.1 ³ n.a. ³',
  '   45 ³  2.6 ³  0.2 ³  520 ³   22 ³');
  Perc1(' 91%');
  WriteLn(Lst, '³  clara                ³  100 ³   49 ³  0.7 ³  0.3 ³ 10.8 ³ n.a. ³ n.a. ³ n.a. ³  250 ³vesti.³ n.a. ³',
  '    8 ³  0.1 ³  0.1 ³vesti.³   17 ³');
  Perc1(' 93%');
  WriteLn(Lst, '³  gema                 ³  100 ³  353 ³  0.3 ³ 32.4 ³ 15.1 ³ 1820 ³ 2050 ³  270 ³  350 ³  0.1 ³ n.a. ³',
  '  141 ³  4.8 ³  0.2 ³ 1500 ³   31 ³');
  Perc1(' 95%');
  WriteLn(Lst, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁ',
  'ÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÙ');
  Perc1(' 97%');
  WriteLn(Lst, #18, '                                 Nutritus 1.0 programado em Pascal por Isaac MSC');
  Perc1(' 98%');
  WriteLn(Lst, #27, 'H', #12);
  Perc1(' 99%');
  Confirma;
1:
end;

{ Se o utilizador pressionar em 4 then do this procedure and imprime }
procedure Esco4;
Label 1,2,3,4,5,6,7,8,9;
begin
  settextstyle(2,0,5);
  settextjustify(0,0);
  goto 3;
4:Cima('Nutritus 1.0 - Menu de Impress„o');
  Baixo('Pressione uma tecla');
  PMenu;
3:bar(70,356,505,395);
  bar(325,67,615,188);
  bar(325,227,615,345);
  dita(330,80, '1- Imprime a folha escolhida');
  if Alim = '1' then goto 5;
  dita(330,240, 'Ligue, insira o papel continuo, e');
  goto 6;
5:dita(330,240, 'Ligue, insira a folha, e');
6:dita(330,255, 'ponha a impressora em ON LINE');
  dita(330,270, 'Pressione 1 para imprimir:');
  dita(330,285, 'Composi‡„o dos alimentos Grupo III');
2:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('5');
                 goto 4;
               end;
        else
          Som;
        end;
      end;
      #27: Goto 1;
      #49: Feito:= True;
    else
      Som;
    end;
  until Feito;
  Aju2;
  dita(330,255, 'Composi‡„o dos alimentos Grupo III');
  dita(30,260, 'Impress„o em curso ...');
  Baixo('Aguarde ...');
  Erro := 1;
  if Esco = '1' then goto 7;
  WriteLn(Lst, #27, 'G', #14, '        Composi‡„o dos alimentos');
  goto 8;
7:WriteLn(Lst, #14, '        Composi‡„o dos alimentos');
8:WriteLn(Lst, #27, 'P', #15, #13);
  Perc1('  4%');
  WriteLn(Lst, 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂ',
  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  Perc1('  8%');
  WriteLn(Lst, '³  Composi‡„o de 100g   ³      ³      ³      ³      ³      ³                    ³      ³  Vitaminas  ³',
  '             Minerais             ³');
  Perc1(' 12%');
  WriteLn(Lst, '³                       ³Parte ³Calo- ³ Gl¡- ³L¡pi- ³ Pro- ³   Acidos gordos    ³Coles-ÃÄÄÄÄÄÄÂÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄ´');
  Perc1(' 18%');
  WriteLn(Lst, '³                       ³edivel³ rias ³cidos ³ dos  ³te¡nas³   Polinsaturados   ³terol ³  A   ³  E   ³',
  'C lcio³Ferro ³Cobre ³Zinco ³ Iodo ³');
  Perc1(' 22%');
  WriteLn(Lst, '³      Grupo III        ³  %   ³      ³  g   ³  g   ³  g   ³         g          ³  mg  ³  UI  ³  mg  ³',
  '  mg  ³  mg  ³  mg  ³  æg  ³  æg  ³');
  Perc1(' 26%');
  WriteLn(Lst, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄ´');
  Perc1(' 30%');
  WriteLn(Lst, '³Azeite                 ³  100 ³  900 ³      ³  100 ³      ³                7.2 ³   97 ³vesti.³ 15.0 ³',
  '      ³      ³      ³vesti.³  0.9 ³');
  Perc1(' 36%');
  WriteLn(Lst, '³Oleo, amendoim         ³  100 ³  900 ³      ³  100 ³      ³               19.4 ³  103 ³vesti.³ 19.5 ³',
  '      ³      ³vesti.³  1.1 ³      ³');
  Perc1(' 40%');
  WriteLn(Lst, '³  cartamo              ³      ³      ³      ³      ³      ³               77.1 ³      ³      ³      ³',
  '      ³      ³      ³      ³      ³');
  Perc1(' 44%');
  WriteLn(Lst, '³  girassol             ³      ³      ³      ³      ³      ³               58.2 ³      ³      ³   25 ³',
  '      ³      ³      ³      ³      ³');
  Perc1(' 48%');
  WriteLn(Lst, '³  milho                ³      ³      ³      ³      ³      ³                 46 ³      ³      ³   20 ³',
  '      ³      ³      ³      ³      ³');
  Perc1(' 54%');
  WriteLn(Lst, '³  soja                 ³      ³      ³      ³      ³      ³               61.5 ³      ³      ³ 17.5 ³',
  '      ³      ³      ³      ³      ³');
  Perc1(' 58%');
  WriteLn(Lst, '³  figado de bacalhau   ³  100 ³  900 ³      ³  100 ³      ³               21.4 ³  172 ³80000 ³      ³',
  '      ³      ³      ³      ³  700 ³');
  Perc1(' 62%');
  WriteLn(Lst, '³Manteiga               ³  100 ³  764 ³  0.5 ³ 84.7 ³  0.3 ³                2.8 ³  122 ³ 1316 ³  1.0 ³',
  '   13 ³  0.2 ³vesti.³vesti.³  4.1 ³');
  Perc1(' 66%');
  WriteLn(Lst, '³Margarina              ³  100 ³  764 ³  0.2 ³ 84.5 ³  0.3 ³                6.8 ³  105 ³vesti.³ 13.2 ³',
  '   11 ³  0.3 ³vesti.³vesti.³  2.8 ³');
  Perc1(' 72%');
  WriteLn(Lst, '³Banha                  ³  100 ³  895 ³ n.a. ³ 99.5 ³ n.a. ³                7.8 ³   82 ³ n.a. ³  0.5 ³',
  '      ³      ³      ³      ³      ³');
  Perc1(' 76%');
  WriteLn(Lst, '³Toucinho               ³   80 ³  860 ³ n.a. ³ 95.0 ³  1.3 ³                    ³      ³ n.a. ³  0.6 ³',
  '    9 ³  0.3 ³  0.1 ³      ³      ³');
  Perc1(' 80%');
  WriteLn(Lst, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁ',
  'ÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÙ');
  Perc1(' 84%');
  WriteLn(Lst, #18, '                                 Nutritus 1.0 programado em Pascal por Isaac MSC');
  Perc1(' 90%');
  WriteLn(Lst, #27, 'H', #12);
  Perc1(' 95%');
  Confirma;
1:
end;

{ Se o utilizador pressionar em 5 then do this procedure and imprime }
procedure Esco5;
Label 1,2,3,4,5,6,7,8,9;
begin
  settextstyle(2,0,5);
  settextjustify(0,0);
  goto 3;
4:Cima('Nutritus 1.0 - Menu de Impress„o');
  Baixo('Pressione uma tecla');
  PMenu;
3:bar(70,356,505,395);
  bar(325,67,615,188);
  bar(325,227,615,345);
  dita(330,80, '1- Imprime a folha escolhida');
  if Alim = '1' then goto 5;
  dita(330,240, 'Ligue, insira o papel continuo, e');
  goto 6;
5:dita(330,240, 'Ligue, insira a folha, e');
6:dita(330,255, 'ponha a impressora em ON LINE');
  dita(330,270, 'Pressione 1 para imprimir:');
  dita(330,285, 'Composi‡„o dos alimentos Grupo IV');
2:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('5');
                 goto 4;
               end;
        else
          Som;
        end;
      end;
      #27: Goto 1;
      #49: Feito:= True;
    else
      Som;
    end;
  until Feito;
  Aju2;
  dita(330,255, 'Composi‡„o dos alimentos Grupo IV');
  dita(30,260, 'Impress„o em curso ...');
  Baixo('Aguarde ...');
  Erro := 1;
  if Esco = '1' then goto 7;
  WriteLn(Lst, #27, 'G', #14, '        Composi‡„o dos alimentos');
  goto 8;
7:WriteLn(Lst, #14, '        Composi‡„o dos alimentos');
8:WriteLn(Lst, #27, 'P', #15, #13);
  Perc1('  2%');
  WriteLn(Lst, 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ',
  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  Perc1('  4%');
  WriteLn(Lst, '³  Composi‡„o de 100g   ³      ³      ³      ³      ³      ³      ³            Vitaminas             ³',
  '             Minerais             ³');
  Perc1('  6%');
  WriteLn(Lst, '³                       ³Parte ³Calo- ³ Gl¡- ³L¡pi- ³ Pro- ³Celu- ÃÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄ´');
  Perc1('  8%');
  WriteLn(Lst, '³                       ³edivel³ rias ³cidos ³ dos  ³te¡nas³ lose ³Caron.³  B1  ³  B2  ³  PP  ³  C   ³',
  'C lcio³Ferro ³Cobre ³Zinco ³ Iodo ³');
  Perc1(' 10%');
  WriteLn(Lst, '³       Grupo IV        ³  %   ³      ³  g   ³  g   ³  g   ³  g   ³  æg  ³  æg  ³  æg  ³  mg  ³  mg  ³',
  '  mg  ³  mg  ³  mg  ³  æg  ³  æg  ³');
  Perc1(' 12%');
  WriteLn(Lst, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄ´');
  Perc1(' 14%');
  WriteLn(Lst, '³Arroz, corrente        ³  100 ³  343 ³ 78.1 ³  0.4 ³  6.7 ³  0.4 ³ n.a. ³  212 ³   34 ³  2.0 ³ n.a. ³',
  '   13 ³  1.2 ³  0.3 ³      ³      ³');
  Perc1(' 16%');
  WriteLn(Lst, '³  mercantil            ³  100 ³  342 ³ 77.6 ³  0.4 ³  7.1 ³  0.4 ³ n.a. ³  194 ³   27 ³  2.1 ³ n.a. ³',
  '   11 ³  1.5 ³  0.7 ³      ³      ³');
  Perc1(' 18%');
  WriteLn(Lst, '³  gigante              ³  100 ³  351 ³ 79.3 ³  0.5 ³  7.2 ³  0.3 ³ n.a. ³  186 ³   31 ³  0.9 ³ n.a. ³',
  '   11 ³  0.7 ³  0.3 ³ 1310 ³  3.6 ³');
  Perc1(' 20%');
  WriteLn(Lst, '³  carolino             ³  100 ³  344 ³ 78.5 ³  0.3 ³  4.9 ³  0.3 ³ n.a. ³  142 ³   25 ³  1.8 ³ n.a. ³',
  '   11 ³  0.7 ³  0.6 ³      ³      ³');
  Perc1(' 22%');
  WriteLn(Lst, '³Aveia                  ³  100 ³  308 ³ 55.5 ³  6.5 ³  4.9 ³ 16.6 ³ n.a. ³  571 ³  206 ³  0.4 ³ n.a. ³',
  '   61 ³  3.7 ³  0.8 ³      ³      ³');
  Perc1(' 24%');
  WriteLn(Lst, '³Centeio, gr„o          ³  100 ³  349 ³ 74.0 ³  1.8 ³  9.3 ³  1.6 ³ n.a. ³  589 ³  188 ³  0.5 ³ n.a. ³',
  '   43 ³  3.4 ³  0.7 ³ 3400 ³  7.3 ³');
  Perc1(' 26%');
  WriteLn(Lst, '³  farinha de 1¦        ³  100 ³  350 ³ 78.5 ³  1.1 ³  6.6 ³  0.6 ³ n.a. ³  312 ³  107 ³  0.3 ³ n.a. ³',
  '   23 ³  1.6 ³  0.3 ³      ³      ³');
  Perc1(' 28%');
  WriteLn(Lst, '³Cevada                 ³  100 ³  326 ³ 69.8 ³  1.9 ³  7.5 ³  7.7 ³ n.a. ³  701 ³  155 ³  4.1 ³ n.a. ³',
  '   41 ³  2.5 ³  0.5 ³      ³      ³');
  Perc1(' 30%');
  WriteLn(Lst, '³Milho, gr„o            ³  100 ³  363 ³ 70.3 ³  4.9 ³  9.3 ³  2.0 ³ n.a. ³  628 ³  182 ³  1.6 ³ n.a. ³',
  '   14 ³  2.5 ³  0.8 ³ 2450 ³  3.4 ³');
  Perc1(' 32%');
  WriteLn(Lst, '³  farinha 75%          ³  100 ³  354 ³ 75.3 ³  2.2 ³  8.3 ³  0.7 ³ n.a. ³  360 ³  100 ³  1.0 ³ n.a. ³',
  '    8 ³  0.8 ³  0.1 ³      ³      ³');
  Perc1(' 34%');
  WriteLn(Lst, '³Trigo, gr„o            ³  100 ³  342 ³ 70.7 ³  2.0 ³ 10.2 ³  2.0 ³ n.a. ³  577 ³  191 ³  4.4 ³ n.a. ³',
  '   42 ³  3.4 ³  0.5 ³ 3000 ³  1.8 ³');
  Perc1(' 36%');
  WriteLn(Lst, '³  farinha corrente     ³  100 ³  359 ³ 76.7 ³  1.8 ³  9.1 ³  0.7 ³ n.a. ³  400 ³  110 ³  1.6 ³ n.a. ³',
  '   29 ³  1.1 ³  0.3 ³      ³      ³');
  Perc1(' 38%');
  WriteLn(Lst, '³  farinha especial     ³  100 ³  354 ³ 79.8 ³  0.9 ³  6.9 ³  0.5 ³ n.a. ³  210 ³   98 ³  1.0 ³ n.a. ³',
  '   23 ³  0.9 ³  0.2 ³      ³      ³');
  Perc1(' 40%');
  WriteLn(Lst, '³Massas, aletria        ³  100 ³  346 ³ 76.1 ³  0.6 ³  9.1 ³  0.2 ³ n.a. ³  171 ³   45 ³  0.5 ³ n.a. ³',
  '   21 ³  0.4 ³  0.3 ³      ³      ³');
  Perc1(' 42%');
  WriteLn(Lst, '³  esparguete           ³  100 ³  358 ³ 79.6 ³  0.5 ³  8.7 ³  0.4 ³ n.a. ³  163 ³   41 ³  0.7 ³ n.a. ³',
  '   23 ³  0.8 ³  0.3 ³  440 ³  4.4 ³');
  Perc1(' 44%');
  WriteLn(Lst, '³  letras               ³  100 ³  353 ³ 78.8 ³  0.4 ³  8.6 ³  0.3 ³ n.a. ³  169 ³   49 ³  0.7 ³ n.a. ³',
  '   23 ³  0.8 ³  0.7 ³  480 ³  2.7 ³');
  Perc1(' 46%');
  WriteLn(Lst, '³  cortada              ³  100 ³  357 ³ 79.5 ³  0.6 ³  8.4 ³  0.5 ³ n.a. ³  185 ³   45 ³  0.6 ³ n.a. ³',
  '   20 ³  0.8 ³  0.3 ³      ³      ³');
  Perc1(' 48%');
  WriteLn(Lst, '³P„o, centeio           ³  100 ³  274 ³ 61.5 ³  0.7 ³  5.3 ³  0.6 ³ n.a. ³  170 ³   56 ³  1.1 ³ n.a. ³',
  '   20 ³  1.1 ³  0.2 ³      ³      ³');
  Perc1(' 50%');
  WriteLn(Lst, '³  milho                ³  100 ³  291 ³ 89.8 ³  1.2 ³  5.3 ³  1.2 ³ n.a. ³  200 ³   80 ³  0.7 ³ n.a. ³',
  '   14 ³  1.3 ³  0.2 ³  460 ³  5.9 ³');
  Perc1(' 52%');
  WriteLn(Lst, '³  trigo de 1¦          ³  100 ³  269 ³ 59.9 ³  0.4 ³  6.4 ³  0.5 ³ n.a. ³  187 ³   98 ³  0.9 ³ n.a. ³',
  '   24 ³  1.2 ³  0.2 ³  700 ³  3.3 ³');
  Perc1(' 54%');
  WriteLn(Lst, '³  trigo de 2¦          ³  100 ³  246 ³ 54.4 ³  0.4 ³  6.3 ³  0.5 ³ n.a. ³  280 ³  110 ³  1.0 ³ n.a. ³',
  '   23 ³  1.5 ³  0.2 ³  480 ³  2.7 ³');
  Perc1(' 56%');
  WriteLn(Lst, '³Legumin. secas, ervilha³  100 ³  289 ³ 41.6 ³  1.2 ³ 20.8 ³  5.5 ³ n.a. ³  882 ³  180 ³  1.0 ³ n.a. ³',
  '  105 ³  6.6 ³  1.5 ³      ³      ³');
  Perc1(' 58%');
  WriteLn(Lst, '³  fava                 ³  100 ³  267 ³ 38.4 ³  1.3 ³ 25.4 ³  6.5 ³ n.a. ³  477 ³  108 ³  0.9 ³ n.a. ³',
  '  105 ³  4.8 ³  1.8 ³      ³      ³');
  Perc1(' 60%');
  WriteLn(Lst, '³  feijanico            ³  100 ³  302 ³ 50.0 ³  1.3 ³ 22.6 ³  3.5 ³ n.a. ³  545 ³   60 ³  1.3 ³ n.a. ³',
  '  163 ³  5.2 ³  1.8 ³ 3500 ³  9.0 ³');
  Perc1(' 62%');
  WriteLn(Lst, '³Feij„o, branco         ³  100 ³  297 ³ 50.0 ³  1.4 ³ 21.0 ³  3.9 ³ n.a. ³  347 ³   54 ³  1.2 ³ n.a. ³',
  '  177 ³  6.1 ³  1.8 ³      ³      ³');
  Perc1(' 64%');
  WriteLn(Lst, '³  catarino             ³  100 ³  286 ³ 50.0 ³  1.0 ³ 19.2 ³  4.0 ³ n.a. ³  342 ³   90 ³  1.2 ³ n.a. ³',
  '  149 ³  5.9 ³  2.2 ³ 1900 ³  7.1 ³');
  Perc1(' 66%');
  WriteLn(Lst, '³  manteiga             ³  100 ³  308 ³ 52.0 ³  1.4 ³ 21.8 ³  4.0 ³ n.a. ³  610 ³   72 ³  1.4 ³ n.a. ³',
  '  165 ³  7.8 ³  1.7 ³      ³      ³');
  Perc1(' 68%');
  WriteLn(Lst, '³Gr„o-de-bico           ³  100 ³  338 ³ 54.3 ³  5.0 ³ 19.0 ³  2.7 ³ n.a. ³  412 ³   70 ³  1.6 ³ n.a. ³',
  '  136 ³  6.3 ³  1.5 ³ 2650 ³  7.0 ³');
  Perc1(' 70%');
  WriteLn(Lst, '³Soja, gr„o             ³  100 ³  410 ³ 26.3 ³ 19.3 ³ 32.8 ³  6.3 ³  103 ³ 1165 ³  490 ³  1.8 ³ n.a. ³',
  '  246 ³  8.0 ³  1.3 ³ 3750 ³  4.7 ³');
  Perc1(' 72%');
  WriteLn(Lst, '³  farinha              ³  100 ³  331 ³ 32.9 ³  2.6 ³ 44.0 ³  2.4 ³   35 ³ 1164 ³ 1070 ³  0.8 ³ n.a. ³',
  '  255 ³  2.0 ³  1.1 ³      ³      ³');
  Perc1(' 74%');
  WriteLn(Lst, '³A‡ucar, amarelo        ³  100 ³  390 ³ 97.5 ³ n.a. ³vesti.³vesti.³ n.a. ³vesti.³vesti.³ n.a. ³ n.a. ³',
  '   40 ³  3.9 ³  0.4 ³   90 ³  8.0 ³');
  Perc1(' 76%');
  WriteLn(Lst, '³  branco               ³  100 ³  397 ³ 99.3 ³ n.a. ³vesti.³ n.a. ³ n.a. ³ n.a. ³ n.a. ³ n.a. ³ n.a. ³',
  '   15 ³  1.1 ³  0.3 ³vesti.³  8.0 ³');
  Perc1(' 78%');
  WriteLn(Lst, '³P.Pastelaria,bolo arroz³  100 ³  359 ³ 62.7 ³ 10.1 ³  4.4 ³  0.3 ³ n.a. ³  101 ³   25 ³  0.2 ³ n.a. ³',
  '   24 ³  0.2 ³  0.4 ³  170 ³  3.4 ³');
  Perc1(' 80%');
  WriteLn(Lst, '³  croissant            ³  100 ³  349 ³ 70.0 ³  7.4 ³  6.6 ³  0.3 ³ n.a. ³  125 ³   24 ³  0.3 ³ n.a. ³',
  '   29 ³  1.2 ³  0.2 ³      ³      ³');
  Perc1(' 82%');
  WriteLn(Lst, '³  p„o-de-l¢            ³  100 ³  365 ³ 63.4 ³  8.1 ³  9.6 ³  0.1 ³ n.a. ³  140 ³  200 ³  0.4 ³ n.a. ³',
  '   57 ³  1.6 ³  0.2 ³  540 ³  5.2 ³');
  Perc1(' 84%');
  WriteLn(Lst, '³Pasteis, bola-de-berlim³  100 ³  325 ³ 52.5 ³ 10.9 ³  4.3 ³  0.1 ³ n.a. ³   71 ³   53 ³  0.7 ³ n.a. ³',
  '   22 ³  1.1 ³  0.3 ³  390 ³  4.0 ³');
  Perc1(' 86%');
  WriteLn(Lst, '³  coco                 ³  100 ³  450 ³ 39.7 ³ 30.5 ³  4.2 ³  1.8 ³ n.a. ³   40 ³   41 ³vesti.³ n.a. ³',
  '   21 ³  1.7 ³  0.3 ³      ³      ³');
  Perc1(' 88%');
  WriteLn(Lst, '³  mil-folhas           ³  100 ³  415 ³ 52.0 ³ 19.7 ³  7.4 ³  0.1 ³ n.a. ³   80 ³   37 ³  0.3 ³ n.a. ³',
  '   32 ³  1.1 ³  0.2 ³      ³      ³');
  Perc1(' 90%');
  WriteLn(Lst, '³  nata                 ³  100 ³  297 ³ 48.5 ³ 10.2 ³  2.9 ³  0.2 ³ n.a. ³   98 ³   67 ³  0.5 ³ n.a. ³',
  '   26 ³  1.0 ³  0.3 ³  210 ³  4.0 ³');
  Perc1(' 92%');
  WriteLn(Lst, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁ',
  'ÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÙ');
  Perc1(' 94%');
  WriteLn(Lst, #18, '                                 Nutritus 1.0 programado em Pascal por Isaac MSC');
  Perc1(' 96%');
  WriteLn(Lst, #27, 'H', #12);
  Perc1(' 98%');
  Confirma;
1:
end;

{ Se o utilizador pressionar em 6 then do this procedure and imprime }
procedure Esco6;
Label 1,2,3,4,5,6,7,8,9;
begin
  settextstyle(2,0,5);
  settextjustify(0,0);
  goto 3;
4:Cima('Nutritus 1.0 - Menu de Impress„o');
  Baixo('Pressione uma tecla');
  PMenu;
3:bar(70,356,505,395);
  bar(325,67,615,188);
  bar(325,227,615,345);
  dita(330,80, '1- Imprime a folha escolhida');
  if Alim = '1' then goto 5;
  dita(330,240, 'Ligue, insira o papel continuo, e');
  goto 6;
5:dita(330,240, 'Ligue, insira a folha, e');
6:dita(330,255, 'ponha a impressora em ON LINE');
  dita(330,270, 'Pressione 1 para imprimir:');
  dita(330,285, 'Composi‡„o dos alimentos Grupo V');
2:Feito:=False;
  repeat
    Ch0:=ReadKey;
    case Ch0 of #0:
      begin
        Ch2:=ReadKey;
        case Ch2 of
          #59: begin
                 Ajuda('5');
                 goto 4;
               end;
        else
          Som;
        end;
      end;
      #27: Goto 1;
      #49: Feito:= True;
    else
      Som;
    end;
  until Feito;
  Aju2;
  dita(330,255, 'Composi‡„o dos alimentos Grupo V');
  dita(30,260, 'Impress„o em curso ...');
  Baixo('Aguarde ...');
  Erro := 1;
  if Esco = '1' then goto 7;
  WriteLn(Lst, #27, 'G', #14, '        Composi‡„o dos alimentos');
  goto 8;
7:WriteLn(Lst, #14, '        Composi‡„o dos alimentos');
8:WriteLn(Lst, #27, 'P', #15, #13);
  Perc1('  1%');
  WriteLn(Lst, 'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂ',
  'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  Perc1('  3%');
  WriteLn(Lst, '³  Composi‡„o de 100g   ³      ³      ³      ³      ³      ³      ³            Vitaminas             ³',
  '             Minerais             ³');
  Perc1('  4%');
  WriteLn(Lst, '³                       ³Parte ³Calo- ³ Gl¡- ³L¡pi- ³ Pro- ³Celu- ÃÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄ´');
  Perc1('  6%');
  WriteLn(Lst, '³                       ³edivel³ rias ³cidos ³ dos  ³te¡nas³ lose ³Carot.³  B1  ³  B2  ³  PP  ³  C   ³',
  'C lcio³Ferro ³Cobre ³Zinco ³ Iodo ³');
  Perc1('  8%');
  WriteLn(Lst, '³        Grupo V        ³  %   ³      ³  g   ³  g   ³  g   ³  g   ³  æg  ³  æg  ³  æg  ³  mg  ³  mg  ³',
  '  mg  ³  mg  ³  mg  ³  æg  ³  æg  ³');
  Perc1('  9%');
  WriteLn(Lst, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅ',
  'ÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄ´');
  Perc1(' 11%');
  WriteLn(Lst, '³Ab¢bora                ³   67 ³   10 ³  1.7 ³  0.2 ³  0.3 ³  0.7 ³ n.a. ³   10 ³    7 ³  0.5 ³  0.5 ³',
  '   12 ³   25 ³  0.1 ³      ³      ³');
  Perc1(' 12%');
  WriteLn(Lst, '³Agri„o                 ³   36 ³   29 ³  1.9 ³  0.9 ³  3.4 ³  0.6 ³ 1948 ³   89 ³   70 ³  1.5 ³   87 ³',
  '  198 ³  1.7 ³  0.6 ³      ³      ³');
  Perc1(' 14%');
  WriteLn(Lst, '³Alface                 ³   47 ³   12 ³  0.8 ³  0.2 ³  1.8 ³  0.6 ³  688 ³   57 ³   15 ³  1.1 ³    4 ³',
  '   70 ³  1.5 ³  0.6 ³  380 ³  2.5 ³');
  Perc1(' 16%');
  WriteLn(Lst, '³Alho                   ³   75 ³   80 ³ 13.8 ³  1.1 ³  3.8 ³  0.5 ³ n.a. ³  210 ³   21 ³  2.2 ³   17 ³',
  '   17 ³  0.8 ³  0.3 ³      ³      ³');
  Perc1(' 17%');
  WriteLn(Lst, '³Beterraba vermelha     ³   47 ³   25 ³  5.3 ³vesti.³  1.0 ³  0.8 ³ n.a. ³   36 ³   17 ³  1.3 ³   15 ³',
  '   17 ³  0.8 ³  0.3 ³      ³      ³');
  Perc1(' 19%');
  WriteLn(Lst, '³Br¢culo                ³   46 ³   27 ³  1.5 ³  0.8 ³  3.4 ³  1.2 ³ 1066 ³  102 ³   97 ³  1.8 ³   41 ³',
  '  119 ³  1.3 ³  0.4 ³      ³      ³');
  Perc1(' 20%');
  WriteLn(Lst, '³Cebola                 ³   89 ³   21 ³  3.8 ³  0.2 ³  0.9 ³  0.6 ³ n.a. ³   23 ³   10 ³  0.6 ³    8 ³',
  '   31 ³  0.5 ³  0.3 ³  270 ³  4.8 ³');
  Perc1(' 22%');
  WriteLn(Lst, '³Cenoura                ³   82 ³   28 ³  6.4 ³vesti.³  0.6 ³  0.6 ³ 3640 ³   56 ³    4 ³  0.9 ³    3 ³',
  '   41 ³  1.0 ³  0.1 ³  120 ³  5.1 ³');
  Perc1(' 24%');
  WriteLn(Lst, '³Couve-flor             ³   39 ³   37 ³  5.2 ³  0.2 ³  3.7 ³  1.0 ³vesti.³  166 ³   70 ³  2.0 ³  111 ³',
  '   21 ³  0.5 ³  0.4 ³  700 ³  5.4 ³');
  Perc1(' 25%');
  WriteLn(Lst, '³Couve galega           ³   55 ³   37 ³  2.3 ³  0.8 ³  5.1 ³  1.5 ³ 2875 ³  207 ³  183 ³  1.8 ³  148 ³',
  '  676 ³  2.4 ³  0.7 ³  400 ³  3.5 ³');
  Perc1(' 27%');
  WriteLn(Lst, '³Couve lombarda         ³   79 ³   20 ³  3.0 ³vesti.³  2.0 ³  1.0 ³vesti.³   29 ³   27 ³  2.2 ³   49 ³',
  '   18 ³  0.4 ³  0.3 ³      ³      ³');
  Perc1(' 28%');
  WriteLn(Lst, '³Couve merceana         ³   64 ³   26 ³  3.9 ³  0.3 ³  1.8 ³  0.8 ³vesti.³   55 ³   28 ³  1.4 ³   31 ³',
  '   30 ³  0.3 ³  0.3 ³      ³      ³');
  Perc1(' 30%');
  WriteLn(Lst, '³Couve portuguesa       ³   75 ³   29 ³  3.3 ³  0.5 ³  2.9 ³  1.2 ³  991 ³   64 ³   56 ³  1.4 ³  644 ³',
  '  234 ³  1.8 ³  0.6 ³      ³      ³');
  Perc1(' 32%');
  WriteLn(Lst, '³Ervilha, vagem         ³   92 ³   35 ³  3.9 ³  0.8 ³  3.1 ³  1.0 ³vesti.³   70 ³    7 ³  0.5 ³   30 ³',
  '  112 ³  0.7 ³  0.3 ³      ³      ³');
  Perc1(' 33%');
  WriteLn(Lst, '³Espinafre              ³   60 ³   24 ³  1.3 ³  0.9 ³  2.6 ³  0.6 ³ 2275 ³   71 ³  175 ³  0.4 ³   35 ³',
  '  104 ³  3.6 ³  0.5 ³      ³      ³');
  Perc1(' 35%');
  WriteLn(Lst, '³Fava, gr„o             ³   40 ³   78 ³ 11.0 ³  0.6 ³  7.4 ³  3.6 ³   64 ³  200 ³  107 ³  1.2 ³   23 ³',
  '   25 ³  1.2 ³  0.5 ³  900 ³  2.3 ³');
  Perc1(' 36%');
  WriteLn(Lst, '³Feij„o verde           ³   95 ³   33 ³  5.6 ³  0.3 ³  1.9 ³  1.2 ³   26 ³  103 ³   49 ³  0.7 ³   17 ³',
  '   40 ³  0.7 ³  0.2 ³  160 ³  4.5 ³');
  Perc1(' 38%');
  WriteLn(Lst, '³Grelos de couve        ³   40 ³   31 ³  2.9 ³  0.6 ³  3.6 ³  1.2 ³ 1078 ³   69 ³   90 ³  1.7 ³   79 ³',
  '  147 ³  1.5 ³  0.6 ³      ³      ³');
  Perc1(' 40%');
  WriteLn(Lst, '³Grelos de nabo         ³   48 ³   31 ³  2.3 ³  0.8 ³  3.6 ³  1.1 ³ 1226 ³   96 ³   71 ³  1.4 ³   84 ³',
  '   64 ³  1.1 ³  0.6 ³  530 ³  5.4 ³');
  Perc1(' 41%');
  WriteLn(Lst, '³Nabi‡a                 ³   42 ³   21 ³  1.4 ³  0.7 ³  2.3 ³  1.0 ³ 2518 ³   83 ³   72 ³  1.7 ³  103 ³',
  '  262 ³  2.0 ³  0.5 ³      ³      ³');
  Perc1(' 43%');
  WriteLn(Lst, '³Nabo                   ³   51 ³   18 ³  3.3 ³  0.4 ³  0.7 ³  0.7 ³ n.a. ³   59 ³   19 ³  0.9 ³   18 ³',
  '   12 ³  0.2 ³  0.3 ³  120 ³  9.5 ³');
  Perc1(' 44%');
  WriteLn(Lst, '³Pimento                ³   71 ³   23 ³  2.7 ³  0.6 ³  1.6 ³  0.8 ³   90 ³   98 ³   22 ³  0.5 ³   60 ³',
  '    9 ³  0.6 ³  0.2 ³      ³      ³');
  Perc1(' 46%');
  WriteLn(Lst, '³Rabanete               ³   41 ³   15 ³  2.2 ³  0.2 ³  1.0 ³  0.6 ³ n.a. ³   30 ³   14 ³  0.4 ³   16 ³',
  '   22 ³  0.4 ³  0.2 ³      ³      ³');
  Perc1(' 48%');
  WriteLn(Lst, '³Salsa                  ³   75 ³   22 ³  2.5 ³vesti.³  3.1 ³  1.0 ³   33 ³  180 ³   56 ³  0.6 ³  220 ³',
  '  200 ³  3.2 ³  0.2 ³      ³      ³');
  Perc1(' 49%');
  WriteLn(Lst, '³Tomate                 ³   85 ³   23 ³  4.3 ³  0.3 ³  0.8 ³  0.5 ³  510 ³   46 ³   30 ³  0.6 ³   20 ³',
  '   11 ³  0.7 ³  0.2 ³  110 ³  2.8 ³');
  Perc1(' 51%');
  WriteLn(Lst, '³Batata                 ³   87 ³   90 ³ 20.0 ³vesti.³  2.5 ³  0.8 ³ n.a. ³  100 ³   45 ³  1.4 ³   14 ³',
  '    9 ³  0.2 ³  0.4 ³  250 ³  5.0 ³');
  Perc1(' 52%');
  WriteLn(Lst, '³Batata-doce            ³   77 ³  125 ³ 30.3 ³vesti.³  1.0 ³  0.7 ³ n.a. ³   32 ³  811 ³  1.0 ³    5 ³',
  '    9 ³  0.4 ³  0.3 ³      ³      ³');
  Perc1(' 54%');
  WriteLn(Lst, '³Cogumelo               ³  100 ³   36 ³  3.4 ³  0.2 ³  5.2 ³  1.8 ³ n.a. ³   42 ³  380 ³  2.3 ³vesti.³',
  '   20 ³  1.4 ³  0.5 ³      ³      ³');
  Perc1(' 56%');
  WriteLn(Lst, '³Ameixa                 ³   95 ³   44 ³  6.5 ³  1.7 ³  0.6 ³  0.5 ³ 1104 ³   14 ³   45 ³  0.6 ³    3 ³',
  '    3 ³  1.0 ³    - ³      ³      ³');
  Perc1(' 57%');
  WriteLn(Lst, '³Anan s                 ³   68 ³   49 ³  9.5 ³  0.5 ³  0.5 ³  0.5 ³vesti.³   38 ³   27 ³  0.6 ³   16 ³',
  '   18 ³  0.6 ³  0.3 ³      ³      ³');
  Perc1(' 59%');
  WriteLn(Lst, '³Banana                 ³   59 ³   90 ³ 20.5 ³  0.3 ³  1.7 ³  0.3 ³ n.a. ³   60 ³   60 ³  0.7 ³    4 ³',
  '    9 ³  0.4 ³  0.1 ³  170 ³  7.2 ³');
  Perc1(' 60%');
  WriteLn(Lst, '³Cereja                 ³   76 ³   63 ³ 13.7 ³  0.4 ³  0.9 ³  0.3 ³  208 ³   32 ³   42 ³  0.4 ³    1 ³',
  '   16 ³  0.6 ³  0.3 ³      ³      ³');
  Perc1(' 62%');
  WriteLn(Lst, '³Damasco                ³   94 ³   53 ³  8.5 ³  0.9 ³  0.8 ³  0.6 ³ 1100 ³   38 ³   95 ³  0.5 ³    3 ³',
  '    9 ³  1.0 ³    - ³      ³      ³');
  Perc1(' 64%');
  WriteLn(Lst, '³Di¢spiro               ³   84 ³   65 ³ 15.0 ³  0.2 ³  0.6 ³  0.6 ³ 1060 ³    - ³    - ³  0.3 ³    3 ³',
  '   10 ³  0.2 ³vesti.³  100 ³  4.5 ³');
  Perc1(' 65%');
  WriteLn(Lst, '³Figo fresco            ³   72 ³   67 ³ 15.0 ³  0.3 ³  0.9 ³  1.2 ³vesti.³   27 ³   25 ³  0.3 ³    1 ³',
  '   36 ³  0.6 ³  0.1 ³   80 ³  3.5 ³');
  Perc1(' 67%');
  WriteLn(Lst, '³Figo seco              ³   99 ³  246 ³ 57.4 ³  0.7 ³  2.5 ³  7.1 ³vesti.³   79 ³   69 ³  0.5 ³  1.5 ³',
  '  219 ³  1.5 ³  0.3 ³      ³      ³');
  Perc1(' 68%');
  WriteLn(Lst, '³Ginja                  ³   84 ³   60 ³ 11.5 ³  1.0 ³  0.9 ³  0.3 ³  123 ³   38 ³   50 ³  0.8 ³    1 ³',
  '   15 ³  0.4 ³  0.3 ³      ³      ³');
  Perc1(' 70%');
  WriteLn(Lst, '³Laranja                ³   68 ³   51 ³ 10.2 ³  0.4 ³  0.9 ³  0.5 ³ 1220 ³  102 ³   53 ³  0.5 ³   58 ³',
  '   34 ³  0.3 ³  0.1 ³  140 ³  3.5 ³');
  Perc1(' 72%');
  WriteLn(Lst, '³Lim„o                  ³   61 ³   37 ³  1.9 ³  1.0 ³  0.5 ³  0.4 ³vesti.³   37 ³   22 ³  0.4 ³   55 ³',
  '   26 ³  0.5 ³  0.2 ³      ³      ³');
  Perc1(' 73%');
  WriteLn(Lst, '³Ma‡„                   ³   82 ³   62 ³ 13.8 ³  0.5 ³  0.3 ³  0.7 ³vesti.³   26 ³   28 ³  0.6 ³    2 ³',
  '    6 ³  0.3 ³  0.2 ³vesti.³  3.9 ³');
  Perc1(' 75%');
  WriteLn(Lst, '³Marmelo                ³   79 ³   48 ³  9.3 ³  1.0 ³  0.3 ³  2.2 ³ n.a. ³    - ³    6 ³  0.7 ³   14 ³',
  '    4 ³  0.1 ³  0.1 ³      ³      ³');
  Perc1(' 76%');
  WriteLn(Lst, '³Melancia               ³   52 ³   25 ³  5.5 ³  0.2 ³  0.4 ³  0.1 ³  300 ³   20 ³    9 ³  0.1 ³    4 ³',
  '   10 ³  0.3 ³  0.1 ³      ³      ³');
  Perc1(' 78%');
  WriteLn(Lst, '³Mel„o                  ³   65 ³   31 ³  6.5 ³  0.3 ³  0.5 ³  0.4 ³ n.a. ³   40 ³   20 ³  0.6 ³    2 ³',
  '    9 ³  0.3 ³  0.2 ³vesti.³  2.6 ³');
  Perc1(' 80%');
  WriteLn(Lst, '³Morango                ³   96 ³   34 ³  5.3 ³  0.7 ³  0.9 ³  1.2 ³ n.a. ³   33 ³   48 ³  0.6 ³   47 ³',
  '   25 ³  0.8 ³  0.3 ³      ³      ³');
  Perc1(' 81%');
  WriteLn(Lst, '³Nˆspera                ³   61 ³   54 ³ 10.5 ³  1.0 ³  0.4 ³  0.3 ³  160 ³   56 ³   61 ³  0.4 ³    1 ³',
  '   16 ³  0.3 ³    - ³      ³      ³');
  Perc1(' 83%');
  WriteLn(Lst, '³Pˆra                   ³   78 ³   43 ³  9.4 ³  0.5 ³  0.2 ³  0.9 ³ n.a. ³   30 ³   24 ³  0.7 ³    2 ³',
  '    9 ³  0.3 ³  0.2 ³  220 ³  3.4 ³');
  Perc1(' 84%');
  WriteLn(Lst, '³Pˆssego                ³   77 ³   45 ³  9.2 ³  0.5 ³  0.6 ³  0.3 ³  400 ³   22 ³   25 ³  1.3 ³    3 ³',
  '    7 ³  0.2 ³  0.1 ³      ³      ³');
  Perc1(' 86%');
  WriteLn(Lst, '³Tƒngera                ³   69 ³   41 ³  7.8 ³  0.4 ³  0.7 ³  0.4 ³  358 ³   43 ³   29 ³  8.4 ³   42 ³',
  '   57 ³  0.5 ³    - ³      ³      ³');
  Perc1(' 88%');
  WriteLn(Lst, '³Tƒngerina              ³   72 ³   46 ³  9.0 ³  0.4 ³  0.7 ³  0.4 ³  783 ³   82 ³   42 ³  0.4 ³   32 ³',
  '   30 ³  0.3 ³  0.1 ³vesti.³  3.2 ³');
  Perc1(' 89%');
  WriteLn(Lst, '³Uva fresca             ³   85 ³   75 ³ 17.2 ³  0.4 ³  0.3 ³vesti.³ n.a. ³   22 ³   15 ³  0.4 ³  0.6 ³',
  '    8 ³  1.0 ³  0.3 ³vesti.³  3.5 ³');
  Perc1(' 91%');
  WriteLn(Lst, '³Uva passa              ³   99 ³  267 ³ 62.4 ³  0.8 ³  1.6 ³  1.0 ³ n.a. ³   23 ³   15 ³  0.5 ³vesti.³',
  '   24 ³  1.0 ³  0.3 ³      ³      ³');
  Perc1(' 92%');
  WriteLn(Lst, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁ',
  'ÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÙ');
  Perc1(' 94%');
  WriteLn(Lst, #18, '                                 Nutritus 1.0 programado em Pascal por Isaac MSC');
  Perc1(' 96%');
  WriteLn(Lst, #27, 'H', #12);
  Perc1(' 98%');
  Confirma;
1:
end;

end.