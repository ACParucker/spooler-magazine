{    Programa em Turbo Pascal 7.0 por    }
{         Isaac MSC  Mem Martins         }
{                                        }
{ Programado em 19/7/1994 para a revista }
{                                        }
{            SPOOLER Magazine            }
{                                        }
{   Originalmente o Nucleus.Exe tem as   }
{  fontes com os caractÇres portugueses  }
{                                        }
{ ATENÄéO:  Se esta Ç a primeira vez que }
{ usa o Nucleus, faáa:                   }
{     Alt-O+C+C+K_Full+Enter+Alt-C+B     }
{                                        }
Program Nucleus;

uses
  Crt, Dos, KeyTTT5, StrnTTT5, MiscTTT5, WinTTT5, Graph, Printer, Ajuda1, bgidriv, bgifont;

var
  GraphDriver : integer;
  GraphMode   : integer;
  MaxX, MaxY  : word;
  ErrorCode   : integer;
  MaxColor    : word;
  OldSaida    : Pointer;
  Saucer    : pointer;
  X, Y      : integer;
  ulx, uly  : word;
  lrx, lry  : word;
  Size      : word;
  Ch, Ch0, Ch1, Ch2, Ch3, Ch4, Ch5, Ch7: Char;
  Err : char;
  E1, E2, E3, E4, E5, E6 : Boolean;
  LowMode, HighMode: Integer;

const
  Pattern : FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);
  Triangle : array[1..7] of PointType = ((x:  37; y: 58),(x: 37; y: 83),(x: 43; y: 83),
  (x: 46; y: 90),(x: 50; y: 88),(x: 47; y: 82),(x: 51; y: 78));
  c = #255;

{ Oˇ$F+ faz com que prÇ definidamente exista uma vari†vel, Pointer    }
{ que est† prÇ definida: faz qualquer coisa se alguma outra acontecer }
{ Sem que seja preciso fazer uma rotina que chame uma Procedure ...   }
{ Pois j† foi prÇ definido . }
{$F+}

{ Antes de sair de qualquer parte do programa, o computador chama esta proc. }
procedure SairProc;
label 1,2;
var
  Ver : Word;
begin
  ExitProc := OldSaida;
  CloseGraph;
  if Err= 'E' then goto 1;
  Writeln;
  writeln('Obrigado por ter utilizado o Nucleus,   ass.');
  writeln('                                             Isaac MSC');
  goto 2;
1:Writeln;
  writeln('Obrigado por ter tentado utilizar o Nucleus,   ass.');
  writeln('                                                    Isaac MSC');
2:writeln('');
  Ver := DosVersion;
  WriteLn('DOS versÑo ',Lo(Ver),'.',Hi(Ver));
end;

{ Và se determinadas teclas foram pressionadas e executa uma tarefa }
Procedure Check_Pressed_Keys(var Ch : char);
{ Usa o TechnoJock's Turbo Toolkit }
{ #128 = mouseup          }
{ #129 = mousedown        }
{ #130 = mouseleft        }
{ #131 = mouseright       }
{ #132 = mouseLeftButton  }
{ #133 = mouseRightButton }
begin
    If (Ch = #27) or (ch = #19) or (ch = #132) then Halt(1);
    if (ch = #128) or (ch = #200) then
       begin
         PutImage(X, Y, Saucer^, XORput);
         X := X;
         Y := Y - 42;
         if y < 30 then  y := y + 42;
         PutImage(X, Y, Saucer^, XORput);
       end;
    if (ch = #129) or (ch = #208) then
       begin
         PutImage(X, Y, Saucer^, XORput);
         X := X;
         Y := Y + 42;
         if y > 420 then y := y - 42;
         PutImage(X, Y, Saucer^, XORput);
       end;
    if (ch = #130) or (ch = #203) then
       begin
         PutImage(X, Y, Saucer^, XORput);
         X := X - 34;
         Y := Y;
         if x < 0 then x := x + 34;
         PutImage(X, Y, Saucer^, XORput);
       end;
    if (ch = #131) or (ch = #205) then
       begin
         PutImage(X, Y, Saucer^, XORput);
         X := X + 34;
         Y := Y;
         if x > 610 then x := x - 34;
         PutImage(X, Y, Saucer^, XORput);
       end;
end;

{ Và se determinadas teclas foram pressionadas e executa uma tarefa }
procedure Check_2(var Ch : char);
begin
  If Ch = #19 then Halt(1);
    if (ch = #128) or (ch = #200) then
       begin
         PutImage(X, Y, Saucer^, XORput);
         Y := Y - 20;
         if Y < 360 then  Y := Y + 20;
         PutImage(X, Y, Saucer^, XORput);
       end;
    if (ch = #129) or (ch = #208) then
       begin
         PutImage(X, Y, Saucer^, XORput);
         Y := Y + 20;
         if Y > 430 then Y := Y - 20;
         PutImage(X, Y, Saucer^, XORput);
       end;
end;

{ Esta procedure serve para... nÑo fazer nada }
procedure NC;
begin
end;

{ Se o Ctrl-S for pressionado em qualquer parte do programa entÑo Halt; }
procedure Keyp;
begin
  if ch5 = #19 then halt(1);
end;

{ Executa linhas de v†rias cores do 0,0 para qualquer ponto do ecrÑ }
procedure Demonx;
begin
 moveto(0,0);
 SetColor(Random(GetMaxColor)+1);
 LineTo(Random(GetMaxX), Random(GetMaxY));
end;
{$F-}

procedure Abort;
begin
end;

{ Procedure de inicializaáÑo }
procedure Inicializa;
label 1,2;
var Fil : Integer;
    f: array[1..4] of integer;
begin
  E1 := False; E2 := False; E3 := False; E4 := False; E5 := False; E6 := False;
  DirectVideo := False; OldSaida := ExitProc; ExitProc := @SairProc;
  if (MemAvail div 1024) < 263 then E1 := True;
  f[1]:= InstallUserFont('TRIP');
  f[2]:= InstallUserFont('LITT');
  f[3]:= InstallUserFont('SANS');
  f[4]:= InstallUserFont('GOTH');
  { Regista os OBJ para se tornarem conhecidos e assimil†veis pelo programa }
  { Para fazer os OBJs utiliza-se o BINOBJ.EXE que Ç suposto estar na       }
  { C:\TP\BIN.   Exemplo:                                                   }
  { C:\TP\BGI> \TP\BIN\BINOBJ EGAVGA.CHR EGAVGA EGAVGADriverProc  (Enter)   }
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then Abort;
  if RegisterBGIfont(@GothicFontProc) < 0 then Abort;
  if RegisterBGIfont(@SansSerifFontProc) < 0 then Abort;
  if RegisterBGIfont(@SmallFontProc) < 0 then Abort;
  if RegisterBGIfont(@TriplexFontProc) < 0 then Abort;
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
  If E1 then Begin WriteLn(' ->  Erro: Falta de mem¢ria'); Halt; end;
  Halt(1);
2:Randomize;
  MaxColor := GetMaxColor;
  MaxX := GetMaxX;
  MaxY := GetMaxY;
  Err:= ' ';
end;

{ Faz o ecrÑ do Menu de ImpressÑo e manda imprimir o elemento escolhido }
procedure Pmenu(Pa : string);
label 1;
begin
 cleardevice;
 Avolta;
 Cima('Nucleus 1.0 - Menu de ImpressÑo');
 Baixo('Pressione botÑo esquerdo para imprimir ou direito para voltar ao menu principal');
 SetTextStyle(1, 0, 5);
 SetTextJustify(0,2);
 setcolor(8);
 outtextxy(17,2, 'Elemento para imprimir:');
 setcolor(3);
 outtextxy(16,1, 'Elemento para imprimir:');
 setcolor(11);
 outtextxy(15,0, 'Elemento para imprimir:');
 SetTextJustify(2,2);
 setcolor(8);
 outtextxy(632,2, Pa);
 setcolor(3);
 outtextxy(631,1, Pa);
 setcolor(11);
 outtextxy(630,0, Pa);
 setcolor(1);
 rectangle(10,58,629,61);
 setcolor(15);
 rectangle(11,59,630,62);
 setcolor(1);
 rectangle(29,379,509,429);
 setcolor(15);
 rectangle(30,380,510,430);
 SetTextStyle(3, 0, 0);
 SetTextJustify(0,2);
 setcolor(8);
 outtextxy(41,381, 'Percentagem imprimida:');
 setcolor(15);
 outtextxy(40,380, 'Percentagem imprimida:');
 Perc('0%');
 setcolor(15);
 line(200,200,440,200);
 line(201,201,439,201);
 line(202,202,438,202);
 line(200,201,200,280);
 line(201,202,201,279);
 line(202,203,202,278);
 setcolor(8);
 line(201,280,440,280);
 line(202,279,439,279);
 line(203,278,438,278);
 line(440,201,440,280);
 line(439,202,439,279);
 line(438,203,438,278);
 SetTextStyle(2, 0, 6);
 SetTextJustify(1,2);
 setcolor(8);
 outtextxy(321,211, 'Prepare a Impressora em');
 setcolor(15);
 outtextxy(320,210, 'Prepare a Impressora em');
 SetTextStyle(3, 0, 4);
 SetTextJustify(1,2);
 setcolor(8);
 outtextxy(321,241, 'LPT1');
 setcolor(15);
 outtextxy(320,240, 'LPT1');
 Pressed_Hook := @Keyp;
 repeat
 ch5:= getkey;
 Until ((ch5 = #13) or (Ch5 = #133)) xor ((ch5 = #27) or (ch5 = #132));
 Pressed_Hook := @NC;
 if (ch5 = #132) or (ch5 = #27) then goto 1;
 setcolor(7);
 setfillstyle(1,7);
 bar(200,200,440,280);
 setcolor(8);
 line(200,200,440,200);
 line(201,201,439,201);
 line(202,202,438,202);
 line(200,201,200,280);
 line(201,202,201,279);
 line(202,203,202,278);
 setcolor(15);
 line(201,280,440,280);
 line(202,279,439,279);
 line(203,278,438,278);
 line(440,201,440,280);
 line(439,202,439,279);
 line(438,203,438,278);
 SetTextStyle(2, 0, 6);
 SetTextJustify(1,2);
 setcolor(8);
 outtextxy(321,226, 'Imprimindo ...');
 setcolor(15);
 outtextxy(320,225, 'Imprimindo ...');
 if Pa= '1' then
    begin
     PElemento('1', 'H', 'HidrogÇnio', '1.0079', 'Gasoso', '2', '1', '99.9%', '20.268', '14.025', '0.0899', '1',
     'Hexagonal', '0.32', '0.79', '14.4', '13.598','14.304', '0.4494', '0,05868', '-', '0.001815', '2.20', 'Neutro',
     '1');
    end;
 if Pa= '2' then
    Begin
     PElemento('2', 'He', 'HÇlio', '4.00260', 'Gasoso', '2', '4', '100%', '4.215', '0.95', '0.1787', '',
     'Hexagonal', '0.93', '0.49', '-', '24.587', '5.193', '0.0845', '-', '-', '0.00152', '-', '-',
     '2');
    end;
 if Pa= '3' then
    Begin
     PElemento('3', 'Li', 'L°tio', '6.941', 'S¢lido', '2', '7', '92.6%', '1615', '453.7', '0.53', '1',
     'C£bico, corpo centrado', '1.23', '2.05', '13.1', '5.392', '3.6', '145.920', '3.0', '0.108', '0.847', '0.98',
     'B†sico', '2   1');
    end;
 if Pa= '4' then
    Begin
     PElemento('4', 'Be', 'Ber°lio', '9.01218', 'S¢lido', '1', '9', '100%', '2745', '1560', '1.85', '2',
     'Hexagonal', '0.90', '1.40', '5.0', '9.322', '1.82', '292.4', '12.2', '0.313', '2.0', '1.57',
     'Neutro', '2   2');
    end;
 if Pa= '5' then
    Begin
     PElemento('5', 'B', 'Boro', '10.81', 'S¢lido', '2', '11', '80.4%', '4275', '2300', '2.34', '3',
     'Romboedrico', '0.82', '1.17', '4.6', '8.298', '102', '489.70', '50.2', '10^12', '0.27', '2.04',
     'B†sico', '2   3');
    end;
 if Pa= '6' then
    Begin
     PElemento('6', 'C', 'Carbono', '12.011', 'S¢lido', '2', '12', '98,9%', '4470', '4100', '2.62', 'Ò4 2',
     'Hexagonal', '0.77', '0.91', '4.58', '11.26', '0.71', '355.8', '-', '0.00061', '1.29', '2.55',
     'B†sico', '2   4');
    end;
  if Pa= '7' then
    Begin
     PElemento('7', 'N', 'Azoto', '14.0067', 'Gasoso', '2', '14', '99.6%', '77.35', '63.14', '1.251', 'Ò3 5 4 2',
     'Hexagonal', '0.75', '0.75', '17.3', '14.534', '1.04', '2.7928', '0.3604', '-', '0.0002598', '3.04',
     'B†sico', '2   5');
    end;
 if Pa= '8' then
    Begin
     PElemento('8', 'O', 'OxigÇnio', '15.9994', 'Gasoso', '3', '16', '99.76%', '90.18', '50.35', '1.429', '-2',
     'C£bico', '0.73', '0.65', '14.0', '13618', '0.92', '3.4099', '0.22259', '-', '0.0002674', '3.44',
     '', '2   6');
    end;
 if Pa= '9' then
    Begin
     PElemento('9', 'F', 'Fl£or', '18.998403', 'Gasoso', '1', '19', '100%', '84.95', '53.48', '1.696', '-1',
     'C£bico', '0.72', '0.57', '17.1', '17.422', '0.82', '3.2698', '0.2552', '-', '0.000279', '3.98',
     '', '2   7');
    end;
 if Pa= '10' then
    Begin
     PElemento('10', 'Ne', 'NÇon', '20.179', 'Gasoso', '3', '20', '90.9%', '27.096', '24.553', '0.901', '',
     'C£bico, face centrada', '0.71', '0.51', '16.7', '21.564', '0.904', '1.7326', '0.3317', '-', '0.000493', '-',
     '', '2   8');
    end;
 if Pa= '11' then
    Begin
     PElemento('11', 'Na', 'S¢dio', '22.98977', 'S¢lido', '1', '23', '100%', '1156', '371.0', '0.97', '1',
     'C£bico, corpo centrado', '1.54', '2.23', '23.7', '5.139', '1.23', '96.960', '2.598', '0.21', '1.41', '0.93',
     'B†sico', '2   8   1');
    end;
 if Pa= '12' then
    Begin
     PElemento('12', 'Mg', 'MagnÇsio', '24.305', 'S¢lido', '3', '24', '78.8%', '1363', '922', '1.74', '2',
     'Hexagonal', '1.36', '1.72', '13.97', '7.646', '1.02', '127.40', '8.954', '0.226', '1.56', '1.31',
     'B†sico', '2   8   2');
    end;
 if Pa= '13' then
    Begin
     PElemento('13', 'Al', 'Alum°nio', '26.98154', 'S¢lido', '1', '27', '100%', '2793', '933.25', '2.70', '3',
     'C£bico, face centrada', '1.18', '1.82', '10.0', '5.986', '0.90', '293.4', '10.79', '0.377', '2.37', '1.61',
     'Neutro', '2   8   3');
    end;
 if Pa= '14' then
    Begin
     PElemento('14', 'Si', 'Sil°cio', '28.0855', 'S¢lido', '3', '28', '92.2%', '3540', '1685', '2.33', '4',
     'C£bico, face centrada', '1.11', '1.46', '12.1', '8.151', '0.71', '384.22', '50.55', '2.52x10^12', '1.48', '1.90',
     'Neutro', '2   8   4');
    end;
 if Pa= '15' then
    Begin
     PElemento('15', 'P', 'F¢sforo', '30.97376', 'S¢lido', '1', '31', '100%', '550', '317,30', '1.82', 'Ò3 5 4',
     'Monoclinico', '1.06', '1.23', '17.0', '10.486', '0.77', '12.129', '0.657', '10^-17', '0.00235', '2.19',
     'Acido', '2   8   5');
    end;
 if Pa= '16' then
    Begin
     PElemento('16', 'S', 'Enxofre', '32.06', 'S¢lido', '4', '32', '95%', '717.75', '388.36', '2.07', 'Ò2 4 6',
     'Ortorombico', '1.02', '1.09', '15.5', '10.36', '0.71', '-', '1.7175', '0.5x10^23', '0.00269', '2.58',
     'Acido', '2   8   6');
    end;
 if Pa= '17' then
    Begin
     PElemento('17', 'Cl', 'Cloro', '35.453', 'Gasoso', '2', '35', '75.5%', '239.1', '172.16', '3.17', 'Ò1 3 5 7',
     'Ortorombico', '0.99', '0.97', '22.7', '12.967', '0.48', '10.2', '3.203', '-', '0.000089', '3.16',
     'Acido', '2   8   7');
    end;
 if Pa= '18' then
    Begin
     PElemento('18', 'Ar', 'Argon', '39.948', 'Gasoso', '3', '40', '99.2%', '87.3', '83.81', '1.784', '',
     'C£bico, face centrada', '0.98', '0.88', '28.5', '15.759', '0.52', '6.447', '1.188', '-', '0.0001772', '-',
     '', '2   8   8');
    end;
 if Pa= '19' then
    Begin
     PElemento('19', 'K', 'Pot†ssio', '39.0983', 'S¢lido', '2', '39', '93.1%', '1032', '336,35', '0.86', '1',
     'C£bico, corpo centrado', '2.03', '2.77', '45.46', '4.341', '0.75', '79.87', '2.334', '0.139', '1.024', '0.82',
     'B†sico', '2   8   8   1');
    end;
 if Pa= '20' then
    Begin
     PElemento('20', 'Ca', 'C†lcio', '40.08', 'S¢lido', '6', '40', '97%', '1757', '1112', '1.55', '2',
     'C£bico, face centrada', '1.74', '2.23', '29.9', '6.113', '0.63', '153.60', '8.54', '0.298', '2.0', '1.0',
     'B†sico', '2   8   8   2');
    end;
 if Pa= '21' then
    Begin
     PElemento('21', 'Sc', 'EscÉndio', '44.9559', 'S¢lido', '1', '45', '100%', '3104', '1812', '3.0', '3',
     'Hexagonal', '1.44', '2.09', '15.0', '6.54', '0.6', '314.2', '14.1', '0.0177', '0.158', '1.36',
     'B†sico', '2   8   8   3');
    end;
 if Pa= '22' then
    Begin
     PElemento('22', 'Ti', 'TitÉnio', '47.9', 'S¢lido', '5', '48', '74.0%', '3562', '1943', '4.5', '4 3',
     'Hexagonal', '1.32', '2.0', '10.64', '6.82', '0.52', '421.0', '15.45', '0.0234', '0.219', '1.54',
     'Neutro', '2   8   8   4');
    end;
 if Pa= '23' then
    Begin
     PElemento('23', 'V', 'Van†dio', '50.9415', 'S¢lido', '1', '51', '99.7%', '3682', '2175', '5.8', '5 4 3 2',
     'C£bico, corpo centrado', '1.22', '1.92', '8.78', '6.74', '0.49', '0.452', '20.9', '0.0489', '0.307', '1.63',
     'Neutro', '2   8   8   5');
    end;
 if Pa= '24' then
    Begin
     PElemento('24', 'Cr', 'Cr¢mio', '51.996', 'S¢lido', '4', '52', '83.8%', '2945', '2130', '7.19', '6 3 2',
     'C£bico, corpo centrado', '1.18', '1.85', '7.23', '6.766', '0.45', '344.3', '16.9', '0.0774', '0.937', '1.66',
     'Acido', '2   8   8   6');
    end;
 if Pa= '25' then
    Begin
     PElemento('25', 'Mn', 'ManganÇsio', '54.938', 'S¢lido', '1', '55', '100%', '2335', '1517', '7.43', '7 6 4 2 3',
     'C£bico, corpo centrado', '1.17', '1.79', '1.39', '7.435', '0.48', '226.0', '12.05', '0.00695', '0.0782', '1.55',
     'Acido', '2   8   8   7');
    end;
 if Pa= '26' then
    Begin
     PElemento('26', 'Fe', 'Ferro', '55.847', 'S¢lido', '4', '56', '91.7%', '3135', '1809', '7.86', '2 3',
     'C£bico, corpo centrado', '1.17', '1.72', '7.1', '7.87', '0.44', '349.6', '13.8', '0.0993', '0.802', '1.83',
     'Neutro', '2   8   8   8');
    end;
 if Pa= '27' then
    Begin
     PElemento('27', 'Co', 'Cobalto', '58.9332', 'S¢lido', '1', '59', '100%', '3201', '1768', '8.9', '2 3',
     'Hexagonal', '1.16', '1.67', '6.7', '7.86', '0.42', '376.5', '16.19', '0.172', '1.0', '1.88',
     'Neutro', '2   8   9   8');
    end;
 if Pa= '28' then
    Begin
     PElemento('28', 'Ni', 'N°quel', '58.70', 'S¢lido', '5', '58', '67.8%', '3187', '1726', '8.9', '2 3',
     'C£bico, face centrada', '1.15', '1.62', '6.59', '7.635', '0.44', '370.4', '17.47', '0.143', '0.907', '1.91',
     'B†sico', '2   8  10   8');
    end;
 if Pa= '29' then
    Begin
     PElemento('29', 'Cu', 'Cobre', '63.546', 'S¢lido', '2', '63', '69.1%', '2836', '1357.6', '8.96', '2 1',
     'C£bico, face centrada', '1.17', '1.57', '7.1', '7.726', '0.38', '300.3', '13.05', '0.596', '4.01', '1.9',
     'B†sico', '2   8  18   1');
    end;
 if Pa= '30' then
    Begin
     PElemento('30', 'Zn', 'Zinco', '65.38', 'S¢lido', '5', '64', '48.9%', '1180', '692.73', '7.14', '2',
     'Hexagonal', '1.25', '1.53', '9.2', '9.394', '0.39', '115.3', '7.322', '0.166', '1.16', '1.65',
     'Neutro', '2   8  18   2');
    end;
 if Pa= '31' then
    Begin
     PElemento('31', 'Ga', 'G†lio', '69.72', 'L°quido', '2', '69', '60.5%', '2478', '302.9', '5.91', '3',
     'Ortorombico', '1.26', '1.81', '11.8', '5.999', '0.37', '258.7', '5.59', '0.0678', '0.406', '1.81',
     'Neutro', '2   8  18   3');
    end;
 if Pa= '32' then
    Begin
     PElemento('32', 'Ge', 'GermÉnio', '72.59', 'S¢lido', '5', '74', '36.7%', '3107', '1210.4', '5.32', '4',
     'C£bico, face centrada', '1.22', '1.52', '13.6', '7.899', '0.32', '330.9', '36.94', '1.45x10^8', '0.599', '2.01',
     'Neutro', '2   8  18   4');
    end;
 if Pa= '33' then
    Begin
     PElemento('33', 'As', 'ArsÇnio', '74.9216', 'S¢lido', '1', '75', '100%', '876', '1081(28atm)', '5.72', 'Ò3 5',
     'Romboedrico', '1.2', '1.33', '13.1', '9.81', '0.33', '34.74', '-', '0.0345', '0.5', '2.18',
     'Acido', '2   8  18   5');
    end;
 if Pa= '34' then
    Begin
     PElemento('34', 'Se', 'SelÇnio', '78.96', 'S¢lido', '6', '80', '49.8%', '958', '494', '4.8', '-2 4 6',
     'Hexagonal', '1.16', '1.22', '16.45', '9.752', '0.32', '37.7', '6.694', '10^12', '0.0204', '2.55',
     'Acido', '2   8  18   6');
    end;
 if Pa= '35' then
    Begin
     PElemento('35', 'Br', 'Bromo', '79.904', 'L°quido', '2', '79', '50.6%', '332.25', '265.9', '3.12', 'Ò1 5',
     'Ortorombico', '1.14', '1.12', '23.5', '11.814', '0.473', '15.438', '5.286', '-', '0.00122', '3.16',
     'Acido', '2   8  18   7');
    end;
 if Pa= '36' then
    Begin
     PElemento('36', 'Kr', 'Cr°pton', '83.8', 'Gasoso', '6', '84', '56.9%', '119.8', '115.78', '3.74', '',
     'C£bico, face centrada', '1.12', '1.03', '38.9', '13.999', '0.248', '9.029', '1.638', '-', '0.0000949', '-',
     '', '2   8  18   8');
    end;
 if Pa= '37' then
    Begin
     PElemento('37', 'Rb', 'Rub°dio', '85.4678', 'S¢lido', '1', '85', '72.1%', '961', '312.64', '1.53', '1',
     'C£bico, corpo centrado', '2.16', '2.98', '55.9', '4.177', '0.363', '72.216', '2.192', '0.0779', '0.582', '0.82',
     'B†sico', '2   8  18   8   1');
    end;
 if Pa= '38' then
    Begin
     PElemento('38', 'Sr', 'Estrìncio', '87.62', 'S¢lido', '4', '88', '82.5%', '1650', '1041', '2.6', '2',
     'C£bico, face centrada', '1.91', '2.45', '33.7', '5.695', '0.3', '144.0', '8.3', '0.0762', '0.353', '0.95',
     'B†sico', '2   8  18   8   2');
    end;
 if Pa= '39' then
    Begin
     PElemento('39', 'Y', 'Itrio', '88.9059', 'S¢lido', '1', '89', '100%', '3611', '1799', '4.5', '3',
     'Hexagonal', '1.62', '2.27', '19.8', '6.38', '0.3', '363.0', '11.4', '0.0166', '0.172', '1.22',
     'B†sico', '2   8  18   8   3');
    end;
 if Pa= '40' then
    Begin
     PElemento('40', 'Zr', 'Zirc¢nio', '91.22', 'S¢lido', '5', '90', '51.5%', '4682', '2125', '6.49', '4',
     'Hexagonal', '1.45', '2.16', '14.1', '6.84', '0.27', '58.2', '16.9', '0.0236', '0.227', '1.33',
     'Neutro', '2   8  18   8   4');
    end;
 if Pa= '41' then
    Begin
     PElemento('41', 'Nb', 'Ni¢bio', '92.9064', 'S¢lido', '1', '93', '100%', '5017', '2740', '8.55', '5 3',
     'C£bico, corpo centrado', '1.34', '2.08', '10.87', '6.88', '0.26', '682.0', '26.4', '0.0693', '0.537', '1.6',
     'Acido', '2   8  18   8   5');
    end;
 if Pa= '42' then
    Begin
     PElemento('42', 'Mo', 'MolibdÇnio', '95.94', 'S¢lido', '7', '98', '23.8%', '4912', '2890', '10.2', '6 5 4 3 2',
     'C£bico, corpo centrado', '1.3', '2.01', '9.4', '7.099', '0.25', '598.0', '32.0', '0.187', '1.38', '2.16',
     'Acido', '2   8  18   8   6');
    end;
 if Pa= '43' then
    Begin
     PElemento('43', 'Tc', 'TecnÇcio', '98', 'P. SintÇticamente', '-', '-', '-', '4538', '2473', '11.5', '7',
     'Hexagonal', '1.27', '1.95', '8.5', '7.28', '0.21', '660.0', '24.0', '0.067', '0.506', '1.9',
     'Acido', '2   8  18   8   7');
    end;
 if Pa= '44' then
    Begin
     PElemento('44', 'Ru', 'RutÇnio', '101.07', 'S¢lido', '7', '102', '31.6%', '4423', '2523', '12.2', '2 3 4 6 8',
     'Hexagonal', '1.25', '1.89', '8.3', '7.37', '0.238', '595.0', '24.0', '0.137', '1.17', '2.2',
     'Acido', '2   8  18   8   8');
    end;
 if Pa= '45' then
    Begin
     PElemento('45', 'Rh', 'R¢dio', '102.9055', 'S¢lido', '1', '103', '100%', '3970', '2236', '12.4', '2 3 4',
     'C£bico, face centrada', '1.25', '1.83', '8.3', '7.46', '0.242', '493', '21.5', '0.211', '1.5', '2.28',
     'Neutro', '2   8  18   9   8');
    end;
 if Pa= '46' then
    Begin
     PElemento('46', 'Pd', 'Pal†dio', '106.4', 'S¢lido', '6', '106', '27.3%', '3237', '1825', '12.0', '2 4',
     'C£bico, face centrada', '1.28', '1.79', '8.9',' 8.34', '0.24', '357.0', '17.6', '0.095', '0.718', '2.2',
     'B†sico', '2   8  18  10   8');
    end;
 if Pa= '47' then
    Begin
     PElemento('47', 'Ag', 'Prata', '107.868', 'S¢lido', '2', '107', '51.4%', '2436', '1234', '10.5', '1',
     'C£bico, face centrada', '1.34', '1.75', '10.3', '7.576', '0.235', '250.58', '11.3', '0.63', '4.29', '1.93',
     'Neutro', '2   8  18  18   1');
    end;
 if Pa= '48' then
    Begin
     PElemento('48', 'Cd', 'C†dmio', '112.41', 'S¢lido', '8', '114', '28.8%', '1040', '594.18', '8.65', '2',
     'Hexagonal', '1.48', '1.71', '13.1', '8.993', '0.23', '99.57', '6.192', '0.138', '0.968', '1.69',
     'B†sico', '2   8  18  18   2');
    end;
 if Pa= '49' then
    Begin
     PElemento('49', 'In', 'Indio', '114.82', 'S¢lido', '1', '113', '4.3%', '2346', '429.76', '7.31', '3',
     'Tetragonal', '1.44', '2.0', '15.7', '5.786', '0.23', '231.5', '3.263', '0.116', '0.816', '1.78',
     'Neutro', '2   8  18  18   3');
    end;
 if Pa= '50' then
    Begin
     PElemento('50', 'Sn', 'Estanho', '118.69', 'S¢lido', '10', '120', '33%', '2876', '505.06', '7.3', '4 2',
     'Tetragonal', '1.41', '1.72', '16.3', '7.344', '0.227', '295.8', '7.029', '0.0917', '0.666', '1.96',
     'Neutro', '2   8  18  18   3');
    end;
 if Pa= '51' then
    Begin
     PElemento('51', 'Sb', 'Antim¢nio', '121.75', 'S¢lido', '2', '121', '57.3%', '1860', '904', '6.68', 'Ò3 5',
     'Romboedrico', '1.4', '1.53', '18.23', '8.641', '0.21', '77.14', '19.87', '0.0288', '0.243', '2.05',
     'Acido', '2   8  18  18   4');
    end;
 if Pa= '52' then
    Begin
     PElemento('52', 'Te', 'Tel£rio', '127.6', 'S¢lido', '8', '130', '34.5%', '1261', '722.65', '6.24', '-2 4 6',
     'Hexagonal', '1.36', '1.42', '20.5', '9.009', '0.2', '52.55', '17.49', '2x10^-6', '0.0235', '2.1',
     'Acido', '2   8  18  18   5');
    end;
 if Pa= '53' then
    Begin
     PElemento('53', 'I', 'Iodo', '126.9045', 'S¢lido', '1', '127', '100%', '458.4', '386.7', '4.92', 'Ò1 5 7',
     'Ortorombico', '1.33', '1.32', '25.74', '10.451', '0.214', '20.752', '7.824', '8x10^16', '0.00449', '2.66',
     'Acido', '2   8  18  18   6');
    end;
 if Pa= '54' then
    Begin
     PElemento('54', 'Xe', 'XÇnon', '131.3', 'Gasoso', '9', '132', '26.9%', '165.03', '161.36', '5.89', '',
     'C£bico, face centrada', '1.31', '1.24', '37.3', '12.13', '0.158', '12.636', '2.297', '-', '0.0000569', '-',
     '', '2   8  18  18   7');
    end;
 if Pa= '55' then
    Begin
     PElemento('55', 'Cs', 'CÇsio', '132.9054', 'L°quido', '1', '133', '100%', '944', '301.55', '1.87', '1',
     'C£bico, corpo centrado', '2.35', '3.34', '71.07', '3.894', '0.24', '67.74', '2.092', '0.0489', '0.359', '0.79',
     'B†sico', '2   8  18  18   8   1');
    end;
 if Pa= '56' then
    Begin
     PElemento('56', 'Ba', 'B†rio', '137.33', 'S¢lido', '7', '138', '70.4%', '2171', '1002', '3.5', '2',
     'C£bico, corpo centrado', '1.98', '2.78', '39.24', '5.212', '0.204', '142.0', '7.75', '0.03', '0.184', '0.89',
     'B†sico', '2   8  18  18   8   2');
    end;
 if Pa= '57' then
    Begin
     PElemento('56', 'Ba', 'B†rio', '137.33', 'S¢lido', '7', '138', '70.4%', '2171', '1002', '3.5', '2',
     'C£bico, corpo centrado', '1.98', '2.78', '39.24', '5.212', '0.204', '142.0', '7.75', '0.03', '0.184', '0.89',
     'B†sico', '2   8  18  18   8   2');
    end;
 if Pa= '58' then
    Begin
     PElemento('58', 'Ce', 'CÇrio', '140.12', 'S¢lido', '3', '140', '88.5%', '3699', '1071', '6.78', '3 4',
     'C£bico, face centrada', '1.65', '2.7', '20.67', '5.54', '0.19', '414.0', '5.46', '0.0115', '0.114', '1.12',
     'B†sico', '2   8  18  18   8   4');
    end;
 if Pa = '59' then
    begin
     PElemento('59', 'Pr', 'Praseod°mio', '140.9077', '1', 'S¢lido', '141', '100%', '3785', '1204', '6.77', '3 4',
     'Hexagonal', '1.65', '2.67', '20.8', '5.46', '0.19', '296.8', '6.89', '0.0148', '0.125', '1.13',
     'B†sico', '2   8  18  18   8   5');
    end;
 if Pa = '60' then
    begin
     PElemento('60', 'Nd', 'Neod°mio', '144.24', 'S¢lido', '6', '142', '27.3%', '3341', '1289', '7.0', '3',
     'Hexagonal', '1.64', '2.64', '20.6', '5.53', '0.19', '273.0', '7.14', '0.0157', '0.165', '1.14',
     'B†sico', '2   8  18  18   8   6');
    end;
 if Pa = '61' then
    begin
     PElemento('61', 'Pm', 'PromÇcio', '145', 'P. SintÇticamente', '-', '-', '-', '3785', '1204', '6.475', '3',
     'Hexagonal', '1.63', '2.62', '22.39', '5.554', '-', '-', '-', '-', '0.179', '1.13',
     'B†sico', '2   8  18  18   8   7');
    end;
 if Pa = '62' then
    begin
     PElemento('62', 'Sm', 'Sam†rio', '150.4', 'S¢lido', '6', '152', '26.6%', '2064', '1345', '7.54', '3 2',
     'RomboÇdrico', '1.62', '2.59', '19.95', '5.64', '0.2', '166.4', '8.63', '0.00956', '0.133', '1.17',
     'B†sico', '2   8  18  18   8   8');
    end;
 if Pa = '63' then
    begin
     PElemento('63', 'Eu', 'Eur¢bio', '151.96', 'S¢lido', '2', '153', '52.2%', '1870', '1090', '5.26', '3 2',
     'C£bico, corpo centrado', '1.85', '2.56', '28.9', '5.67', '0.18', '143.5', '9.21', '0.0112', '0.139', '1.2',
     'B†sico', '2   8  18  18   9   8');
    end;
 if Pa = '64' then
    begin
     PElemento('64', 'Gd', 'Gadol°nio', '157.25', 'S¢lido', '7', '158', '24.5%', '3539', '1585', '7.89', '3',
     'Hexagonal', '1.61', '2.54', '19.9', '6.15', '0.23', '359.4', '10.05', '0.00736', '0.106', '1.2',
     'B†sico', '2   8  18  18  10   8');
    end;
 if Pa = '65' then
    begin
     PElemento('65', 'Tb', 'TÇrbio', '158.9254', 'S¢lido', '1', '159', '100%', '3496', '1630', '8.27', '3 4',
     'Hexagonal', '1.59', '2.51', '19.2', '5.86', '0.18', '330.9', '10.8', '0.00889', '0.111', '1.2',
     'B†sico', '2   8  18  18  18   1');
    end;
 if Pa = '66' then
    begin
     PElemento('66', 'Dy', 'Dispr¢sio', '162.5', 'S¢lido', '7', '164', '28.1%', '2835', '1682', '8.54', '3',
     'Hexagonal', '1.59', '2.49', '19.0', '5.94', '0.17', '230.0', '11.06', '0.0108', '0.107', '1.22',
     'B†sico', '2   8  18  18  18   2');
    end;
 if Pa = '67' then
    begin
     PElemento('67', 'Ho', 'H¢lmio', '164.9304', 'S¢lido', '1', '165', '100%', '2968', '1743', '8.8', '3',
     'Hexagonal', '1.58', '2.47', '18.7', '6.018', '0.16', '241', '22.2', '0.0124', '0.162', '1.23',
     'B†sico', '2   8  18  18  18   3');
    end;
 if Pa = '68' then
    begin
     PElemento('68', 'Er', 'êrbio', '167.26', 'S¢lido', '6', '166', '33.4%', '3136', '1795', '9.05', '3',
     'Hexagonal', '1.57', '2.45', '18.4', '6.101', '0.17', '261.0', '19.9', '0.0117', '0.143', '1.24',
     'B†sico', '2   8  18  18  18   4');
    end;
 if Pa = '69' then
    begin
     PElemento('69', 'Tm', 'T£lio', '168.9342', 'S¢lido', '1', '169', '100%', '2220', '1818', '9.33', '3 2',
     'Hexagonal', '1.56', '2.42', '18.1', '6.184', '0.16', '191.0', '16.84', '0.015', '0.168', '1.25',
     'B†sico', '2   8  18  18  18   5');
    end;
 if Pa = '70' then
    begin
     PElemento('70', 'Yb', 'ItÇrbio', '173.04', 'S¢lido', '7', '174', '31.7%', '1467', '1097', '6.98', '3 2',
     'C£bico, face centrada', '1.74', '2.4', '24.79', '6.254', '0.15', '128.9', '7.66', '0.0351', '0.349', '1.1',
     'B†sico', '2   8  18  18  18   6');
    end;
 if Pa = '71' then
    begin
     PElemento('71', 'Lu', 'LutÇcio', '174.967', 'S¢lido', '1', '175', '97.4%', '3668', '1936', '9.84', '3',
     'Hexagonal', '1.56', '2.25', '17.78', '5.43', '0.15', '355.9', '18.6', '0.0185', '0.164', '1.27',
     'B†sico', '2   8  18  18  18   7');
    end;
 if Pa = '72' then
    begin
     PElemento('72', 'Hf', 'H†fnio', '178.49', 'S¢lido', '6', '180', '35.2%', '4876', '2500', '13.1', '4',
     'Hexagonal', '1.44', '2.16', '13.6', '6.65', '0.14', '575.0', '24.06', '0.0312', '0.23', '1.3',
     'Neutro', '2   8  18  32   8   4');
    end;
 if Pa = '73' then
    begin
     PElemento('73', 'Ta', 'TÉntalo', '180.9479', 'S¢lido', '2', '181', '99.99%', '5731', '3287', '16.6', '5',
     'C£bico, corpo centrado', '1.34', '2.09', '10.9', '7.89', '0.13', '824', '35.4', '0.0761', '0.575', '1.5',
     'Acido', '2   8  18  32   8   5');
    end;
 if Pa = '74' then
    begin
     PElemento('74', 'W', 'VolfrÉmio', '183.85', 'S¢lido', '5', '184', '30.6%', '5828', '3680', '19.3', '6 5 4 3 2',
     'C£bico, corpo centrado', '1.3', '2.02', '9.53', '7.98', '0.13', '824.0', '35.4', '0.189', '1.74', '2.36',
     'Acido', '2   8  18  32   8   6');
    end;
 if Pa = '75' then
    begin
     PElemento('75', 'Re', 'RÇnio', '186.207', 'S¢lido', '2', '187', '62.9%', '5869', '3453', '21.0', '7 6 4 2 -1',
     'Hexagonal', '1.28', '1.97', '8.85', '7.88', '0.13', '715.0', '33.2', '0.0542', '0.479', '1.9',
     'Acido', '2   8  18  32   8   7');
    end;
 if Pa = '76' then
    begin
     PElemento('76', 'Os', 'Osmio', '190.2', 'S¢lido', '7', '192', '41%', '5285', '3300', '22.4', '2 3 4 6 8',
     'Hexagonal', '1.26', '1.92', '8.49', '8.7', '0.13', '746', '31.8', '0.109', '0.876', '2.2',
     'Acido', '2   8  18  32   8   8');
    end;
 if Pa = '77' then
    begin
     PElemento('77', 'Ir', 'Ir°dio', '192.22', 'S¢lido', '2', '193', '61.5%', '4701', '2716', '22.5', '2 3 4 6',
     'C£bico, face centrada', '1.27', '1.87', '8.54', '9.1', '0.13', '604', '26.1', '0.197', '1.47', '2.2',
     'B†sico', '2   8  18  32   9   8');
    end;
 if Pa = '78' then
    begin
     PElemento('78', 'Pt', 'Platina', '195.09', 'S¢lido', '4', '195', '33.8%', '4100', '2045', '21.4', '2 4',
     'C£bico, face centrada', '1.3', '1.83', '9.1', '9.0', '0.13', '510.0', '19.6', '0.0966', '0.716', '2.28',
     'B†sico', '2   8  18  32  10   8');
    end;
 if Pa = '79' then
    begin
     PElemento('79', 'Au', 'Ouro', '196.9665', 'S¢lido', '1', '197', '100%', '3130', '1337.58', '19.3', '3 1',
     'C£bico, face centrada', '1.34', '1.79', '10.2', '9.225', '0.128', '334.4', '12.55', '0.452', '3.17', '2.54',
     'Neutro', '2   8  18  32  18   1');
    end;
 if Pa = '80' then
    begin
     PElemento('80', 'Hg', 'Merc£rio', '200.59', 'L°quido', '7', '202', '29.8%', '630', '234.28', '13.53', '2 1',
     'Romboedrico', '1.49', '1.76', '14.82', '10.437', '0.139', '59.229', '2.295', '0.0104', '0.0834', '2.0',
     'B†sico', '2   8  18  32  18   2');
    end;
 if Pa = '81' then
    begin
     PElemento('81', 'Ti', 'TitÉnio', '204.37', 'S¢lido', '5', '48', '74.0%', '1746', '577', '11.85', '3 1',
     'Hexagonal', '1.48', '2.08', '17.2', '6.108', '0.13', '164.1', '4.142', '0.0617', '0.461', '2.04',
     'B†sico', '2   8  18  32  18   3');
    end;
 if Pa = '82' then
    begin
     PElemento('82', 'Pb', 'Chumbo', '207.2', 'S¢lido', '8', '208', '51.7%', '2023', '600.6', '11.4', '4 2',
     'C£bico, face centrada', '1.47', '1.81', '18.17', '7.416', '0.13', '177.7', '4.799', '0.0481', '0.353', '2.33',
     'Neutro', '2   8  18  32  18   4');
    end;
 if Pa = '83' then
    begin
     PElemento('83', 'Bi', 'Bismuto', '208.9804', 'S¢lido', '1', '209', '100%', '1837', '544.52', '9.8', '3 5',
     'Romboedrico', '1.46', '1.63', '21.3', '7.289', '0.12', '104.8', '11.3', '0.00867', '0.0787', '2.02',
     'Acido', '2   8  18  32  18   5');
    end;
 if Pa = '84' then
    begin
     PElemento('84', 'Po', 'Pol¢nio', '209', 'S¢lido', '-', '-', '-', '1235', '527', '9.4', '4 2',
     'Monocl°nico', '1.46', '1.53', '22.23', '8.42', '-', '-', '-', '0.0219', '0.2', '2.0',
     'Neutro', '2   8  18  32  18   6');
    end;
 if Pa = '85' then
    begin
     PElemento('85', 'At', 'Astato', '210', 'S¢lido', '-', '-', '-', '610', '575', '-', 'Ò1 3 5 7',
     '', '1.45', '1.43', '-', '-', '-', '-', '-', '-', '0.017', '2.2',
     '', '2   8  18  32  18   7');
    end;
 if Pa = '86' then
    begin
     PElemento('86', 'Rn', 'R†don', '222', 'Gasoso', '-', '-', '-', '211', '202', '9.91', '',
     'C£bico, face centrada', '-', '1.34', '50.5', '10.748', '0.09', '16.4', '2.89', '-', '0.0000364', '-',
     '', '2   8  18  32  18   8');
    end;
 if Pa = '87' then
    begin
     PElemento('87', 'Fr', 'FrÉncio', '223', 'L°quido', '-', '-', '-', '950', '300', '-', '1',
     'C£bico, corpo centrado', '-', '-', '-', '-', '-', '-', '-', '0.03', '0.15', '0.7',
     'B†sico', '2   8  18  32  18   8   1');
    end;
 if Pa = '88' then
    begin
     PElemento('88', 'Ra', 'R†dio', '226.0254', 'S¢lido', '-', '-', '-', '1809', '973', '5', '2',
     'C£bico, corpo centrado', '-', '-', '45.2', '5.279', '-' ,'-', '-', '-', '0.186', '0.9',
     'B†sico', '2   8  18  32  18   8   2');
    end;
 if Pa = '89' then
    begin
     PElemento('89', 'Ac', 'Actic°nio', '227.0278', 'S¢lido', '-', '-', '-' , '3473', '1323', '10.07', '3',
     'C£bico, face centrada', '-', '-', '22.54', '5.17', '-', '-', '-', '-', '0.12', '1.1',
     '', '2   8  18  32  18   8   3');
    end;
 if Pa = '90' then
    begin
     PElemento('90', 'Th', 'T¢rio', '232.0381', 'S¢lido', '-', '-', '-', '5061', '2028', '11.7', '4',
     'C£bico, face centrada', '1.65', '-', '19.9', '6.08', '0.12', '514.4', '16.1', '0.0653', '0.540', '1.3',
     'B†sico', '2   8  18  32  18   8   4');
    end;
 if Pa = '91' then
    begin
     PElemento('91', 'Pa', 'Proctat°nio', '231.0359', 'S¢lido', '-', '-', '-', '-', '-', '15.4', '5 4',
     'Ortorombico', '-', '-', '15.0', '5.89', '-', '-', '12.3', '0.0529', '0.47', '1.5',
     'B†sico', '2   8  18  32  18   8   5');
    end;
 if Pa = '92' then
    begin
     PElemento('92', 'U', 'UrÉnio', '238.029', 'S¢lido', '-', '-', '-', '4407', '1405', '18.9', '6 5 4 3',
     'Ortorombico', '1.42', '-', '12.59', '6.05', '0.12', '477.0', '8.52', '0.038', '0.276', '1.38',
     'Neutro', '2   8  18  32  18   8   6');
    end;
 if Pa = '93' then
    begin
     PElemento('93', 'Np', 'Nept£nio', '237.0482', 'P. SintÇticamente', '-', '-', '-', '-', '910', '20.4', '6 5 4 3',
     'Ortorombico', '-', '-', '11.62', '6.19', '0.12', '-' ,'5.19', '0.00822', '0.063', '1.36',
     'Neutro', '2   8  18  32  18   8   7');
    end;
 if Pa = '94' then
    begin
     PElemento('94', 'Pu', 'Plut¢nio', '239.1', 'P. SintÇticamente', '-', '-', '-', '3503', '913', '19.8', '6 5 4 3',
     'Monocl°nico', '-', '-', '12.32', '6.06', '0.13', '344.0', '2.84', '0.00666', '0.674', '1.28',
     'Neutro', '2   8  18  32  18   8   8');
    end;
 if Pa = '95' then
    begin
     PElemento('95', 'Am', 'Amer°cio', '243.1', 'P. SintÇticamente', '-', '-', '-', '2880', '1268', '13.6', '6 5 4 3',
     'Hexagonal', '-', '-', '17.86', '5.993', '0.11', '-', '14.4', '0.022', '0.1', '1.3',
     'Neutro', '2   8  18  32  18   9   8');
    end;
 if Pa = '96' then
    begin
     PElemento('96', 'Cm', 'C£rio', '247.1', 'P. SintÇticamente', '-', '-', '-', '-', '1340', '13.511', '3',
     '', '-' ,'-', '18.28', '6.02', '-', '-', '15.0', '-', '0.1', '1.3',
     'Neutro', '2   8  18  32  18  10   8');
    end;
 if Pa = '97' then
    begin
     PElemento('97', 'Bk', 'BerquÇlio', '247.11', 'P. SintÇticamente', '-' ,'-', '-' ,'-', '-', '-', '4 3',
     '', '-' ,'-', '-', '6.23', '-', '-', '-', '-', '0.1', '1.3',
     '', '2   8  18  32  18  18   1');
    end;
 if Pa = '98' then
    begin
     PElemento('98', 'Cf', 'Calif¢rnio', '252.1', 'P. SintÇticamente', '-' ,'-' ,'-' ,'-', '900', '-' ,'3',
     '', '-', '-', '-', '6.23', '-', '-', '-', '-', '0.1', '1.3',
     '', '2   8  18  32  18  18   2');
    end;
 if Pa = '99' then
    begin
     PElemento('99', 'Es', 'Einsteinio', '252.1', 'P. SintÇticamente', '-', '-', '-', '-', '-', '-', '-',
     '', '-', '-', '-', '6.42', '-', '-', '-', '-', '0.1', '1.3',
     '', '2   8  18  32  18  18  3');
    end;
 if Pa = '100' then
    begin
     PElemento('100', 'Fm', 'F¢rmio', '257.1', 'P. SintÇticamente', '-', '-', '-', '-', '-', '-', '-',
     '', '-', '-', '-', '6.42', '-', '-' ,'-', '-', '0.1', '1.3',
     '', '2   8  18  32  18  18   4');
    end;
 if Pa = '101' then
    begin
     PElemento('101', 'Md', 'MendelÇvio', '256.1', 'P. SintÇticamente', '-', '-', '-', '-' ,'-' ,'-', '-',
     '', '-', '-', '-' ,'6.58', '-' ,'-', '-', '-', '0.1', '1.3',
     '', '2   8  18  32  18  18   5');
    end;
 if Pa = '102' then
    begin
     PElemento('102', 'No', 'NobÇlio', '259.1', 'P. SintÇticamente', '-', '-', '-', '-' ,'-' ,'-' ,'-',
     '', '-', '-', '-', '6.65', '-', '-', '-', '-', '0.1', '1.3',
     '', '2   8  18  32  18  18   6');
    end;
 if Pa = '103' then
    begin
     PElemento('103', 'Lr', 'Lauràncio', '260.1', 'P. SintÇticamente', '-', '-' ,'-', '-', '-' ,'-', '-' ,
     '', '-' ,'-', '-', '-', '-' ,'-' ,'-' ,'-', '0.1', '-',
     '', '2   8  18  32  18  18   7');
    end;
 if Pa = '104' then
    begin
     PElemento('104', 'Unq', 'Unilqu†dio', '261', 'P. SintÇticamente', '-' ,'-', '-' ,'-', '-', '-', '-' ,
     '', '-', '-', '-' ,'-' ,'-' ,'-', '-', '-', '0.23', '-',
     '', '2   8  18  32  32  18   4');
    end;
 if Pa = '105' then
    begin
     PElemento('105', 'Unp', 'Unilpàntio', '262', 'P. SintÇticamente', '-', '-' ,'-', '-', '-' ,'-' ,'-',
     '', '-', '-', '-', '-' ,'-' ,'-', '-' ,'-', '0.58', '-',
     '', '2   8  18  32  32  18   4');
    end;
 if Pa = '106' then
    begin
     PElemento('106', 'Unh', 'UnilhÇxio', '263', 'P. SintÇticamente', '-', '-', '-', '-', '-', '-', '-',
     '', '-', '-', '-', '-', '-', '-' ,'-', '-', '-', '-',
     '', '2   8  18  32  32  18   5');
    end;
1:setcolor(7);
 setfillstyle(1,7);
 bar(200,200,440,280);
 Perc('100%');
 Baixo('Pressione um botÑo para ir para o menu principal');
 ch5:= getkey;
 if ch5 = #19 then halt(1);
end;

{ Espera saber qual a pr¢xima acáÑo a tomar depois da Tabela dos Elementos }
procedure Espe;
begin
  X := 187;
  Y := 420;
  Pressed_Hook := @Check_2;
  PutImage(X, Y, Saucer^, XORput);
  Repeat
    Ch := GetKey;
  Until (ch = #132) or (ch = #133) or (ch = #13) or (ch = #27);
  Pressed_Hook := @NC;
  if Y = 360 then ch3 := 'I';
  if Y = 380 then ch3 := 'D';
  if Y = 400 then ch3 := 'A';
  if Y = 420 then ch3 := ' ';
  if (ch = #27) or (ch = #132) then ch3 := ' ';
end;

{ Faz a caixa Acerca do Nucleus }
procedure Acerca;
  begin
    ch3 := ' ';
    Baixo('Presione um botÑo para ir para o menu principal');
    setfillpattern(Pattern,8);
    bar(90,90,545,387);
    setfillstyle(1,7);
    setcolor(7);
    bar(80, 80, 540, 383);
    setcolor(15);
    line(81, 81, 81, 382);
    line(82, 82, 82, 381);
    line(81, 81, 539, 81);
    line(82, 82, 538, 82);
    setcolor(8);
    line(82, 382, 539, 382);
    line(83, 381, 538, 381);
    line(538, 382, 539, 82);
    line(539, 381, 538, 83);
    Logotipo;
    setcolor(1);
    rectangle(192,100,519,175);
    setcolor(15);
    rectangle(193,101,520,176);
    SetTextStyle(1, 0, 5);
    SetTextJustify(1,2);
    setcolor(8);
    outtextxy(362,101, 'Nucleus 1.0');
    setcolor(15);
    outtextxy(361,100, 'Nucleus 1.0');
    SetTextStyle(0, 0, 0);
    setcolor(8);
    outtextxy(362,161, 'Um Programa de Qu°mica ');
    setcolor(15);
    outtextxy(361,160, 'Um Programa de Qu°mica ');
    setcolor(1);
    rectangle(99,193,519,269);
    setcolor(15);
    rectangle(100,194,520,270);
    SetTextJustify(0,0);
    setcolor(7);
    bar(119,193,237,194);
    setcolor(1);
    outtextxy(121,198, 'Agradecimentos:');
    setcolor(15);
    outtextxy(120,197, 'Agradecimentos:');
    setcolor(8);
    outtextxy(121,218, 'Dra. Maria Paula Soares Outeiro');
    setcolor(15);
    outtextxy(120,217, 'Dra. Maria Paula Soares Outeiro');
    setcolor(8);
    outtextxy(121,238, 'Prof. Manuel Filipe Ara£jo Carràlo');
    setcolor(15);
    outtextxy(120,237, 'Prof. Manuel Filipe Ara£jo Carràlo');
    setcolor(8);
    outtextxy(121,258, 'Sandra Cristina Gonáalves Vaz');
    setcolor(15);
    outtextxy(120,257, 'Sandra Cristina Gonáalves Vaz');
    setcolor(1);
    rectangle(99,287,519,363);
    setcolor(15);
    rectangle(100,288,520,364);
    setcolor(7);
    bar(119,287,213,288);
    setcolor(1);
    outtextxy(121,292, 'Programador:');
    setcolor(15);
    outtextxy(120,291, 'Programador:');
    setcolor(8);
    outtextxy(121,312, 'Isaac MSC');
    setcolor(15);
    outtextxy(120,311, 'Isaac MSC');
    setcolor(8);
    outtextxy(121,332, 'Av. Luisa Todi, 339 1Dtß');
    setcolor(15);
    outtextxy(120,331, 'Av. Luisa Todi, 339 1Dtß');
    setcolor(8);
    outtextxy(121,352, '2900 Set£bal  Portugal          Tel. (065) 38716');
    setcolor(15);
    outtextxy(120,351, '2900 Set£bal  Portugal          Tel. (065) 38716');
    ch4:= getkey;
    if ch4 = #19 then Halt(1);
  end;

{ DemonstraáÑo do Nucleus }
procedure Demons;
  begin
    ch3 := ' ';
    Baixo('Presione um botÑo para ir para o menu principal');
    randomize;
    { Chama a Procedure Far Demonx atÇ que seja desactivado }
    Idle_Hook := @Demonx;
    ch4:= getkey;
    { DesactivaáÑo do Far Demonx }
    Idle_Hook := @NC;
    if ch4 = #19 then Halt(1);
  end;

{ Ajuda para que o programa nÑo encrave por excesso de linhas por Procedure }
procedure LanAct(Nm : string);
label 1,2,3;
begin
 if Nm = '9' then goto 2;
      if ch2 = 'D' then
         begin
          Esque;
          Elemento('58', 'Ce', 'CÇrio', '140.12', 'S¢lido', '3', '140', '88.5%', '3699', '1071', '6.78', '3 4',
          'C£bico, face centrada', '1.65', '2.7', '20.67', '5.54', '0.19', '414.0', '5.46', '0.0115', '0.114', '1.12',
          'B†sico', '2   8  18  18   8   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('58');
          goto 1;
         end;
      if ch2 = 'E' then
         begin
          Esque;
          Elemento('59', 'Pr', 'Praseod°mio', '140.9077', '1', 'S¢lido', '141', '100%', '3785', '1204', '6.77', '3 4',
          'Hexagonal', '1.65', '2.67', '20.8', '5.46', '0.19', '296.8', '6.89', '0.0148', '0.125', '1.13',
          'B†sico', '2   8  18  18   8   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('59');
          goto 1;
         end;
      if ch2 = 'F' then
         begin
          Esque;
          Elemento('60', 'Nd', 'Neod°mio', '144.24', 'S¢lido', '6', '142', '27.3%', '3341', '1289', '7.0', '3',
          'Hexagonal', '1.64', '2.64', '20.6', '5.53', '0.19', '273.0', '7.14', '0.0157', '0.165', '1.14',
          'B†sico', '2   8  18  18   8   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('60');
          goto 1;
         end;
      if ch2 = 'G' then
         begin
          Esque;
          Elemento('61', 'Pm', 'PromÇcio', '145', 'P. SintÇticamente', '-', '-', '-', '3785', '1204', '6.475', '3',
          'Hexagonal', '1.63', '2.62', '22.39', '5.554', '-', '-', '-', '-', '0.179', '1.13',
          'B†sico', '2   8  18  18   8   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('61');
          goto 1;
         end;
      if ch2 = 'H' then
         begin
          Esque;
          Elemento('62', 'Sm', 'Sam†rio', '150.4', 'S¢lido', '6', '152', '26.6%', '2064', '1345', '7.54', '3 2',
          'RomboÇdrico', '1.62', '2.59', '19.95', '5.64', '0.2', '166.4', '8.63', '0.00956', '0.133', '1.17',
          'B†sico', '2   8  18  18   8   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('62');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('63', 'Eu', 'Eur¢bio', '151.96', 'S¢lido', '2', '153', '52.2%', '1870', '1090', '5.26', '3 2',
          'C£bico, corpo centrado', '1.85', '2.56', '28.9', '5.67', '0.18', '143.5', '9.21', '0.0112', '0.139', '1.2',
          'B†sico', '2   8  18  18   9   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('63');
          goto 1;
         end;
      if ch2 = 'J' then
         begin
          Esque;
          Elemento('64', 'Gd', 'Gadol°nio', '157.25', 'S¢lido', '7', '158', '24.5%', '3539', '1585', '7.89', '3',
          'Hexagonal', '1.61', '2.54', '19.9', '6.15', '0.23', '359.4', '10.05', '0.00736', '0.106', '1.2',
          'B†sico', '2   8  18  18  10   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('64');
          goto 1;
         end;
      if ch2 = 'K' then
         begin
          Esque;
          Elemento('65', 'Tb', 'TÇrbio', '158.9254', 'S¢lido', '1', '159', '100%', '3496', '1630', '8.27', '3 4',
          'Hexagonal', '1.59', '2.51', '19.2', '5.86', '0.18', '330.9', '10.8', '0.00889', '0.111', '1.2',
          'B†sico', '2   8  18  18  18   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('65');
          goto 1;
         end;
      if ch2 = 'L' then
         begin
          Esque;
          Elemento('66', 'Dy', 'Dispr¢sio', '162.5', 'S¢lido', '7', '164', '28.1%', '2835', '1682', '8.54', '3',
          'Hexagonal', '1.59', '2.49', '19.0', '5.94', '0.17', '230.0', '11.06', '0.0108', '0.107', '1.22',
          'B†sico', '2   8  18  18  18   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('66');
          goto 1;
         end;
      if ch2 = 'M' then
         begin
          Esque;
          Elemento('67', 'Ho', 'H¢lmio', '164.9304', 'S¢lido', '1', '165', '100%', '2968', '1743', '8.8', '3',
          'Hexagonal', '1.58', '2.47', '18.7', '6.018', '0.16', '241', '22.2', '0.0124', '0.162', '1.23',
          'B†sico', '2   8  18  18  18   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('67');
          goto 1;
         end;
      if ch2 = 'N' then
         begin
          Esque;
          Elemento('68', 'Er', 'êrbio', '167.26', 'S¢lido', '6', '166', '33.4%', '3136', '1795', '9.05', '3',
          'Hexagonal', '1.57', '2.45', '18.4', '6.101', '0.17', '261.0', '19.9', '0.0117', '0.143', '1.24',
          'B†sico', '2   8  18  18  18   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('68');
          goto 1;
         end;
      if ch2 = 'O' then
         begin
          Esque;
          Elemento('69', 'Tm', 'T£lio', '168.9342', 'S¢lido', '1', '169', '100%', '2220', '1818', '9.33', '3 2',
          'Hexagonal', '1.56', '2.42', '18.1', '6.184', '0.16', '191.0', '16.84', '0.015', '0.168', '1.25',
          'B†sico', '2   8  18  18  18   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('69');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('70', 'Yb', 'ItÇrbio', '173.04', 'S¢lido', '7', '174', '31.7%', '1467', '1097', '6.98', '3 2',
          'C£bico, face centrada', '1.74', '2.4', '24.79', '6.254', '0.15', '128.9', '7.66', '0.0351', '0.349', '1.1',
          'B†sico', '2   8  18  18  18   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('70');
          goto 1;
         end;
      if ch2 = 'Q' then
         begin
          Esque;
          Elemento('71', 'Lu', 'LutÇcio', '174.967', 'S¢lido', '1', '175', '97.4%', '3668', '1936', '9.84', '3',
          'Hexagonal', '1.56', '2.25', '17.78', '5.43', '0.15', '355.9', '18.6', '0.0185', '0.164', '1.27',
          'B†sico', '2   8  18  18  18   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('71');
          goto 1;
         end;
         goto 3;
2:    if ch2 = 'D' then
         begin
          Esque;
          Elemento('90', 'Th', 'T¢rio', '232.0381', 'S¢lido', '-', '-', '-', '5061', '2028', '11.7', '4',
          'C£bico, face centrada', '1.65', '-', '19.9', '6.08', '0.12', '514.4', '16.1', '0.0653', '0.540', '1.3',
          'B†sico', '2   8  18  32  18   8   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('90');
          goto 1;
         end;
      if ch2 = 'E' then
         begin
          Esque;
          Elemento('91', 'Pa', 'Proctat°nio', '231.0359', 'S¢lido', '-', '-', '-', '-', '-', '15.4', '5 4',
          'Ortorombico', '-', '-', '15.0', '5.89', '-', '-', '12.3', '0.0529', '0.47', '1.5',
          'B†sico', '2   8  18  32  18   8   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('91');
          goto 1;
         end;
      if ch2 = 'F' then
         begin
          Esque;
          Elemento('92', 'U', 'UrÉnio', '238.029', 'S¢lido', '-', '-', '-', '4407', '1405', '18.9', '6 5 4 3',
          'Ortorombico', '1.42', '-', '12.59', '6.05', '0.12', '477.0', '8.52', '0.038', '0.276', '1.38',
          'Neutro', '2   8  18  32  18   8   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('92');
          goto 1;
         end;
      if ch2 = 'G' then
         begin
          Esque;
          Elemento('93', 'Np', 'Nept£nio', '237.0482', 'P. SintÇticamente', '-', '-', '-', '-', '910', '20.4', '6 5 4 3',
          'Ortorombico', '-', '-', '11.62', '6.19', '0.12', '-' ,'5.19', '0.00822', '0.063', '1.36',
          'Neutro', '2   8  18  32  18   8   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('93');
          goto 1;
         end;
      if ch2 = 'H' then
         begin
          Esque;
          Elemento('94', 'Pu', 'Plut¢nio', '239.1', 'P. SintÇticamente', '-', '-', '-', '3503', '913', '19.8', '6 5 4 3',
          'Monocl°nico', '-', '-', '12.32', '6.06', '0.13', '344.0', '2.84', '0.00666', '0.674', '1.28',
          'Neutro', '2   8  18  32  18   8   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('94');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('95', 'Am', 'Amer°cio', '243.1', 'P. SintÇticamente', '-', '-', '-', '2880', '1268', '13.6', '6 5 4 3',
          'Hexagonal', '-', '-', '17.86', '5.993', '0.11', '-', '14.4', '0.022', '0.1', '1.3',
          'Neutro', '2   8  18  32  18   9   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('95');
          goto 1;
         end;
      if ch2 = 'J' then
         begin
          Esque;
          Elemento('96', 'Cm', 'C£rio', '247.1', 'P. SintÇticamente', '-', '-', '-', '-', '1340', '13.511', '3',
          '', '-' ,'-', '18.28', '6.02', '-', '-', '15.0', '-', '0.1', '1.3',
          'Neutro', '2   8  18  32  18  10   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('96');
          goto 1;
         end;
      if ch2 = 'K' then
         begin
          Esque;
          Elemento('97', 'Bk', 'BerquÇlio', '247.11', 'P. SintÇticamente', '-' ,'-', '-' ,'-', '-', '-', '4 3',
          '', '-' ,'-', '-', '6.23', '-', '-', '-', '-', '0.1', '1.3',
          '', '2   8  18  32  18  18   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('97');
          goto 1;
         end;
      if ch2 = 'L' then
         begin
          Esque;
          Elemento('98', 'Cf', 'Calif¢rnio', '252.1', 'P. SintÇticamente', '-' ,'-' ,'-' ,'-', '900', '-' ,'3',
          '', '-', '-', '-', '6.23', '-', '-', '-', '-', '0.1', '1.3',
          '', '2   8  18  32  18  18   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('98');
          goto 1;
         end;
      if ch2 = 'M' then
         begin
          Esque;
          Elemento('99', 'Es', 'Einsteinio', '252.1', 'P. SintÇticamente', '-', '-', '-', '-', '-', '-', '-',
          '', '-', '-', '-', '6.42', '-', '-', '-', '-', '0.1', '1.3',
          '', '2   8  18  32  18  18   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('99');
          goto 1;
         end;
      if ch2 = 'N' then
         begin
          Esque;
          Elemento('100', 'Fm', 'F¢rmio', '257.1', 'P. SintÇticamente', '-', '-', '-', '-', '-', '-', '-',
          '', '-', '-', '-', '6.42', '-', '-' ,'-', '-', '0.1', '1.3',
          '', '2   8  18  32  18  18   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('100');
          goto 1;
         end;
      if ch2 = 'O' then
         begin
          Esque;
          Elemento('101', 'Md', 'MendelÇvio', '256.1', 'P. SintÇticamente', '-', '-', '-', '-' ,'-' ,'-', '-',
          '', '-', '-', '-' ,'6.58', '-' ,'-', '-', '-', '0.1', '1.3',
          '', '2   8  18  32  18  18   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('101');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('102', 'No', 'NobÇlio', '259.1', 'P. SintÇticamente', '-', '-', '-', '-' ,'-' ,'-' ,'-',
          '', '-', '-', '-', '6.65', '-', '-', '-', '-', '0.1', '1.3',
          '', '2   8  18  32  18  18   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('102');
          goto 1;
         end;
      if ch2 = 'Q' then
         begin
          Esque;
          Elemento('103', 'Lr', 'Lauràncio', '260.1', 'P. SintÇticamente', '-', '-' ,'-', '-', '-' ,'-', '-' ,
          '', '-' ,'-', '-', '-', '-' ,'-' ,'-' ,'-', '0.1', '-',
          '', '2   8  18  32  18  18   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('103');
          goto 1;
         end;
         goto 3;
3:ch0:= 'E';
1:
end;

{ O Menu principal: Tabela Peri¢dica: teclas pressionadas, mouse }
procedure Principal;
label 1,2,3,4,5,6;
begin
1:if ch3 = 'D' then Demons;
2:if ch3 = 'A' then Acerca;
3:Cima('Nucleus 1.0 - Tabela Peri¢dica');
  Baixo('Escolha do elemento: BotÑo Esquerdo  Sair: BotÑo Direito');
  SetFillStyle(1, 15);
  FillPoly(SizeOf(Triangle) div SizeOf(PointType), Triangle);
  ulx := 36;
  uly := 57;
  lrx := 52;
  lry := 91;
  Size := ImageSize(ulx, uly, lrx, lry);
  GetMem(Saucer, Size);
  GetImage(ulx, uly, lrx, lry, Saucer^);
  PutImage(ulx, uly, Saucer^, XORput);
  X := 29;
  Y := 34;
  PutImage(X, Y, Saucer^, XORput);
4:Tabela;
  Pressed_Hook := @Check_Pressed_keys;
  Repeat
    Ch := GetKey;
  Until (ch = #133) or (ch = #13) or (ch = #187);
  CH2 := ';';
  if ch = #187 then goto 5;
  CASE Y OF
       034 : BEGIN
              CH1 := '1';
              IF X = 029 THEN CH2 := 'A';
              IF X = 607 THEN CH2 := 'R';
             END;
       076 : BEGIN
              CH1 := '2';
              IF X = 029 THEN CH2 := 'A';
              IF X = 063 THEN CH2 := 'B';
              IF X = 437 THEN CH2 := 'M';
              IF X = 471 THEN CH2 := 'N';
              IF X = 505 THEN CH2 := 'O';
              IF X = 539 THEN CH2 := 'P';
              IF X = 573 THEN CH2 := 'Q';
              IF X = 607 THEN CH2 := 'R';
             END;
       118 : BEGIN
              CH1 := '3';
              IF X = 029 THEN CH2 := 'A';
              IF X = 063 THEN CH2 := 'B';
              IF X = 437 THEN CH2 := 'M';
              IF X = 471 THEN CH2 := 'N';
              IF X = 505 THEN CH2 := 'O';
              IF X = 539 THEN CH2 := 'P';
              IF X = 573 THEN CH2 := 'Q';
              IF X = 607 THEN CH2 := 'R';
             END;
       160 : BEGIN
              CH1 := '4';
              IF X = 029 THEN CH2 := 'A';
              IF X = 063 THEN CH2 := 'B';
              IF X = 097 THEN CH2 := 'C';
              IF X = 131 THEN CH2 := 'D';
              IF X = 165 THEN CH2 := 'E';
              IF X = 199 THEN CH2 := 'F';
              IF X = 233 THEN CH2 := 'G';
              IF X = 267 THEN CH2 := 'H';
              IF X = 301 THEN CH2 := 'I';
              IF X = 335 THEN CH2 := 'J';
              IF X = 369 THEN CH2 := 'K';
              IF X = 403 THEN CH2 := 'L';
              IF X = 437 THEN CH2 := 'M';
              IF X = 471 THEN CH2 := 'N';
              IF X = 505 THEN CH2 := 'O';
              IF X = 539 THEN CH2 := 'P';
              IF X = 573 THEN CH2 := 'Q';
              IF X = 607 THEN CH2 := 'R';
             END;
       202 : BEGIN
              CH1 := '5';
              IF X = 029 THEN CH2 := 'A';
              IF X = 063 THEN CH2 := 'B';
              IF X = 097 THEN CH2 := 'C';
              IF X = 131 THEN CH2 := 'D';
              IF X = 165 THEN CH2 := 'E';
              IF X = 199 THEN CH2 := 'F';
              IF X = 233 THEN CH2 := 'G';
              IF X = 267 THEN CH2 := 'H';
              IF X = 301 THEN CH2 := 'I';
              IF X = 335 THEN CH2 := 'J';
              IF X = 369 THEN CH2 := 'K';
              IF X = 403 THEN CH2 := 'L';
              IF X = 437 THEN CH2 := 'M';
              IF X = 471 THEN CH2 := 'N';
              IF X = 505 THEN CH2 := 'O';
              IF X = 539 THEN CH2 := 'P';
              IF X = 573 THEN CH2 := 'Q';
              IF X = 607 THEN CH2 := 'R';
             END;
       244 : BEGIN
              CH1 := '6';
              IF X = 029 THEN CH2 := 'A';
              IF X = 063 THEN CH2 := 'B';
              IF X = 097 THEN CH2 := 'C';
              IF X = 131 THEN CH2 := 'D';
              IF X = 165 THEN CH2 := 'E';
              IF X = 199 THEN CH2 := 'F';
              IF X = 233 THEN CH2 := 'G';
              IF X = 267 THEN CH2 := 'H';
              IF X = 301 THEN CH2 := 'I';
              IF X = 335 THEN CH2 := 'J';
              IF X = 369 THEN CH2 := 'K';
              IF X = 403 THEN CH2 := 'L';
              IF X = 437 THEN CH2 := 'M';
              IF X = 471 THEN CH2 := 'N';
              IF X = 505 THEN CH2 := 'O';
              IF X = 539 THEN CH2 := 'P';
              IF X = 573 THEN CH2 := 'Q';
              IF X = 607 THEN CH2 := 'R';
             END;
       286 : BEGIN
              CH1 := '7';
              IF X = 029 THEN CH2 := 'A';
              IF X = 063 THEN CH2 := 'B';
              IF X = 097 THEN CH2 := 'C';
              IF X = 131 THEN CH2 := 'D';
              IF X = 165 THEN CH2 := 'E';
              IF X = 199 THEN CH2 := 'F';
             END;
       370 : BEGIN
              CH1 := '8';
              IF X = 131 THEN CH2 := 'D';
              IF X = 165 THEN CH2 := 'E';
              IF X = 199 THEN CH2 := 'F';
              IF X = 233 THEN CH2 := 'G';
              IF X = 267 THEN CH2 := 'H';
              IF X = 301 THEN CH2 := 'I';
              IF X = 335 THEN CH2 := 'J';
              IF X = 369 THEN CH2 := 'K';
              IF X = 403 THEN CH2 := 'L';
              IF X = 437 THEN CH2 := 'M';
              IF X = 471 THEN CH2 := 'N';
              IF X = 505 THEN CH2 := 'O';
              IF X = 539 THEN CH2 := 'P';
              IF X = 573 THEN CH2 := 'Q';
              IF X = 607 THEN CH2 := 'R';
             END;
       412 : BEGIN
              CH1 := '9';
              IF X = 131 THEN CH2 := 'D';
              IF X = 165 THEN CH2 := 'E';
              IF X = 199 THEN CH2 := 'F';
              IF X = 233 THEN CH2 := 'G';
              IF X = 267 THEN CH2 := 'H';
              IF X = 301 THEN CH2 := 'I';
              IF X = 335 THEN CH2 := 'J';
              IF X = 369 THEN CH2 := 'K';
              IF X = 403 THEN CH2 := 'L';
              IF X = 437 THEN CH2 := 'M';
              IF X = 471 THEN CH2 := 'N';
              IF X = 505 THEN CH2 := 'O';
              IF X = 539 THEN CH2 := 'P';
              IF X = 573 THEN CH2 := 'Q';
              IF X = 607 THEN CH2 := 'R';
             END;
  END;
5:if ch2= ';' then
     begin
      Pressed_Hook := @NC;
      Ajuda;
      Pressed_Hook := @Check_Pressed_keys;
      goto 3;
     end;
  if ch1 = '1' then
     begin
      if ch2 = 'A' then
         begin
          Esque;
          Elemento('1', 'H', 'HidrogÇnio', '1.0079', 'Gasoso', '2', '1', '99.9%', '20.268', '14.025', '0.0899', '1',
          'Hexagonal', '0.32', '0.79', '14.4', '13.598','14.304', '0.4494', '0,05868', '-', '0.001815', '2.20', 'Neutro', '1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then Pmenu('1');
          goto 1;
         end;
      if ch2 = 'R' then
         begin
          Esque;
          Elemento('2', 'He', 'HÇlio', '4.00260', 'Gasoso', '2', '4', '100%', '4.215', '0.95', '0.1787', '',
          'Hexagonal', '0.93', '0.49', '-', '24.587', '5.193', '0.0845', '-', '-', '0.00152', '-', '-', '2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then Pmenu('2');
          goto 1;
         end;
     end;
  if ch1 = '2' then
     begin
      if ch2 = 'A' then
         begin
          Esque;
          Elemento('3', 'Li', 'L°tio', '6.941', 'S¢lido', '2', '7', '92.6%', '1615', '453.7', '0.53', '1',
          'C£bico, corpo centrado', '1.23', '2.05', '13.1', '5.392', '3.6', '145.920', '3.0', '0.108', '0.847', '0.98',
          'B†sico', '2   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('3');
          goto 1;
         end;
      if ch2 = 'B' then
         begin
          Esque;
          Elemento('4', 'Be', 'Ber°lio', '9.01218', 'S¢lido', '1', '9', '100%', '2745', '1560', '1.85', '2',
          'Hexagonal', '0.90', '1.40', '5.0', '9.322', '1.82', '292.4', '12.2', '0.313', '2.0', '1.57',
          'Neutro', '2   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('4');
          goto 1;
         end;
      if ch2 = 'M' then
         begin
          Esque;
          Elemento('5', 'B', 'Boro', '10.81', 'S¢lido', '2', '11', '80.4%', '4275', '2300', '2.34', '3',
          'Romboedrico', '0.82', '1.17', '4.6', '8.298', '102', '489.70', '50.2', '10^12', '0.27', '2.04',
          'B†sico', '2   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('5');
          goto 1;
         end;
      if ch2 = 'N' then
         begin
          Esque;
          Elemento('6', 'C', 'Carbono', '12.011', 'S¢lido', '2', '12', '98,9%', '4470', '4100', '2.62', 'Ò4 2',
          'Hexagonal', '0.77', '0.91', '4.58', '11.26', '0.71', '355.8', '-', '0.00061', '1.29', '2.55',
          'B†sico', '2   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('6');
          goto 1;
         end;
      if ch2 = 'O' then
         begin
          Esque;
          Elemento('7', 'N', 'Azoto', '14.0067', 'Gasoso', '2', '14', '99.6%', '77.35', '63.14', '1.251', 'Ò3 5 4 2',
          'Hexagonal', '0.75', '0.75', '17.3', '14.534', '1.04', '2.7928', '0.3604', '-', '0.0002598', '3.04',
          'B†sico', '2   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('7');
          goto 1;
         end;
      if ch2 = 'P' then
         begin
          Esque;
          Elemento('8', 'O', 'OxigÇnio', '15.9994', 'Gasoso', '3', '16', '99.76%', '90.18', '50.35', '1.429', '-2',
          'C£bico', '0.73', '0.65', '14.0', '13618', '0.92', '3.4099', '0.22259', '-', '0.0002674', '3.44',
          '', '2   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('8');
          goto 1;
         end;
      if ch2 = 'Q' then
         begin
          Esque;
          Elemento('9', 'F', 'Fl£or', '18.998403', 'Gasoso', '1', '19', '100%', '84.95', '53.48', '1.696', '-1',
          'C£bico', '0.72', '0.57', '17.1', '17.422', '0.82', '3.2698', '0.2552', '-', '0.000279', '3.98',
          '', '2   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('9');
          goto 1;
         end;
      if ch2 = 'R' then
         begin
          Esque;
          Elemento('10', 'Ne', 'NÇon', '20.179', 'Gasoso', '3', '20', '90.9%', '27.096', '24.553', '0.901', '',
          'C£bico, face centrada', '0.71', '0.51', '16.7', '21.564', '0.904', '1.7326', '0.3317', '-', '0.000493', '-',
          '', '2   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('10');
          goto 1;
         end;
     end;
  if ch1 = '3' then
     begin
      if ch2 = 'A' then
         begin
          Esque;
          Elemento('11', 'Na', 'S¢dio', '22.98977', 'S¢lido', '1', '23', '100%', '1156', '371.0', '0.97', '1',
          'C£bico, corpo centrado', '1.54', '2.23', '23.7', '5.139', '1.23', '96.960', '2.598', '0.21', '1.41', '0.93',
          'B†sico', '2   8   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('11');
          goto 1;
         end;
      if ch2 = 'B' then
         begin
          Esque;
          Elemento('12', 'Mg', 'MagnÇsio', '24.305', 'S¢lido', '3', '24', '78.8%', '1363', '922', '1.74', '2',
          'Hexagonal', '1.36', '1.72', '13.97', '7.646', '1.02', '127.40', '8.954', '0.226', '1.56', '1.31',
          'B†sico', '2   8   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('12');
          goto 1;
         end;
      if ch2 = 'M' then
         begin
          Esque;
          Elemento('13', 'Al', 'Alum°nio', '26.98154', 'S¢lido', '1', '27', '100%', '2793', '933.25', '2.70', '3',
          'C£bico, face centrada', '1.18', '1.82', '10.0', '5.986', '0.90', '293.4', '10.79', '0.377', '2.37', '1.61',
          'Neutro', '2   8   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('13');
          goto 1;
         end;
      if ch2 = 'N' then
         begin
          Esque;
          Elemento('14', 'Si', 'Sil°cio', '28.0855', 'S¢lido', '3', '28', '92.2%', '3540', '1685', '2.33', '4',
          'C£bico, face centrada', '1.11', '1.46', '12.1', '8.151', '0.71', '384.22', '50.55', '2.52x10^12', '1.48', '1.90',
          'Neutro', '2   8   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('14');
          goto 1;
         end;
      if ch2 = 'O' then
         begin
          Esque;
          Elemento('15', 'P', 'F¢sforo', '30.97376', 'S¢lido', '1', '31', '100%', '550', '317,30', '1.82', 'Ò3 5 4',
          'Monoclinico', '1.06', '1.23', '17.0', '10.486', '0.77', '12.129', '0.657', '10^-17', '0.00235', '2.19',
          'Acido', '2   8   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('15');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('16', 'S', 'Enxofre', '32.06', 'S¢lido', '4', '32', '95%', '717.75', '388.36', '2.07', 'Ò2 4 6',
          'Ortorombico', '1.02', '1.09', '15.5', '10.36', '0.71', '-', '1.7175', '0.5x10^23', '0.00269', '2.58',
          'Acido', '2   8   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('16');
          goto 1;
         end;
      if ch2 = 'Q' then
         begin
          Esque;
          Elemento('17', 'Cl', 'Cloro', '35.453', 'Gasoso', '2', '35', '75.5%', '239.1', '172.16', '3.17', 'Ò1 3 5 7',
          'Ortorombico', '0.99', '0.97', '22.7', '12.967', '0.48', '10.2', '3.203', '-', '0.000089', '3.16',
          'Acido', '2   8   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('17');
          goto 1;
         end;
      if ch2 = 'R' then
         begin
          Esque;
          Elemento('18', 'Ar', 'Argon', '39.948', 'Gasoso', '3', '40', '99.2%', '87.3', '83.81', '1.784', '',
          'C£bico, face centrada', '0.98', '0.88', '28.5', '15.759', '0.52', '6.447', '1.188', '-', '0.0001772', '-',
          '', '2   8   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('18');
          goto 1;
         end;
     end;
  if ch1 = '4' then
     begin
      if ch2 = 'A' then
         begin
          Esque;
          Elemento('19', 'K', 'Pot†ssio', '39.0983', 'S¢lido', '2', '39', '93.1%', '1032', '336,35', '0.86', '1',
          'C£bico, corpo centrado', '2.03', '2.77', '45.46', '4.341', '0.75', '79.87', '2.334', '0.139', '1.024', '0.82',
          'B†sico', '2   8   8   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('19');
          goto 1;
         end;
      if ch2 = 'B' then
         begin
          Esque;
          Elemento('20', 'Ca', 'C†lcio', '40.08', 'S¢lido', '6', '40', '97%', '1757', '1112', '1.55', '2',
          'C£bico, face centrada', '1.74', '2.23', '29.9', '6.113', '0.63', '153.60', '8.54', '0.298', '2.0', '1.0',
          'B†sico', '2   8   8   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('20');
          goto 1;
         end;
      if ch2 = 'C' then
         begin
          Esque;
          Elemento('21', 'Sc', 'EscÉndio', '44.9559', 'S¢lido', '1', '45', '100%', '3104', '1812', '3.0', '3',
          'Hexagonal', '1.44', '2.09', '15.0', '6.54', '0.6', '314.2', '14.1', '0.0177', '0.158', '1.36',
          'B†sico', '2   8   8   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('21');
          goto 1;
         end;
      if ch2 = 'D' then
         begin
          Esque;
          Elemento('22', 'Ti', 'TitÉnio', '47.9', 'S¢lido', '5', '48', '74.0%', '3562', '1943', '4.5', '4 3',
          'Hexagonal', '1.32', '2.0', '10.64', '6.82', '0.52', '421.0', '15.45', '0.0234', '0.219', '1.54',
          'Neutro', '2   8   8   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('22');
          goto 1;
         end;
      if ch2 = 'E' then
         begin
          Esque;
          Elemento('23', 'V', 'Van†dio', '50.9415', 'S¢lido', '1', '51', '99.7%', '3682', '2175', '5.8', '5 4 3 2',
          'C£bico, corpo centrado', '1.22', '1.92', '8.78', '6.74', '0.49', '0.452', '20.9', '0.0489', '0.307', '1.63',
          'Neutro', '2   8   8   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('23');
          goto 1;
         end;
      if ch2 = 'F' then
         begin
          Esque;
          Elemento('24', 'Cr', 'Cr¢mio', '51.996', 'S¢lido', '4', '52', '83.8%', '2945', '2130', '7.19', '6 3 2',
          'C£bico, corpo centrado', '1.18', '1.85', '7.23', '6.766', '0.45', '344.3', '16.9', '0.0774', '0.937', '1.66',
          'Acido', '2   8   8   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('24');
          goto 1;
         end;
      if ch2 = 'G' then
         begin
          Esque;
          Elemento('25', 'Mn', 'ManganÇsio', '54.938', 'S¢lido', '1', '55', '100%', '2335', '1517', '7.43', '7 6 4 2 3',
          'C£bico, corpo centrado', '1.17', '1.79', '1.39', '7.435', '0.48', '226.0', '12.05', '0.00695', '0.0782', '1.55',
          'Acido', '2   8   8   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('25');
          goto 1;
         end;
      if ch2 = 'H' then
         begin
          Esque;
          Elemento('26', 'Fe', 'Ferro', '55.847', 'S¢lido', '4', '56', '91.7%', '3135', '1809', '7.86', '2 3',
          'C£bico, corpo centrado', '1.17', '1.72', '7.1', '7.87', '0.44', '349.6', '13.8', '0.0993', '0.802', '1.83',
          'Neutro', '2   8   8   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('26');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('27', 'Co', 'Cobalto', '58.9332', 'S¢lido', '1', '59', '100%', '3201', '1768', '8.9', '2 3',
          'Hexagonal', '1.16', '1.67', '6.7', '7.86', '0.42', '376.5', '16.19', '0.172', '1.0', '1.88',
          'Neutro', '2   8   9   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('27');
          goto 1;
         end;
      if ch2 = 'J' then
         begin
          Esque;
          Elemento('28', 'Ni', 'N°quel', '58.70', 'S¢lido', '5', '58', '67.8%', '3187', '1726', '8.9', '2 3',
          'C£bico, face centrada', '1.15', '1.62', '6.59', '7.635', '0.44', '370.4', '17.47', '0.143', '0.907', '1.91',
          'B†sico', '2   8  10   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('28');
          goto 1;
         end;
      if ch2 = 'K' then
         begin
          Esque;
          Elemento('29', 'Cu', 'Cobre', '63.546', 'S¢lido', '2', '63', '69.1%', '2836', '1357.6', '8.96', '2 1',
          'C£bico, face centrada', '1.17', '1.57', '7.1', '7.726', '0.38', '300.3', '13.05', '0.596', '4.01', '1.9',
          'B†sico', '2   8  18   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('29');
          goto 1;
         end;
      if ch2 = 'L' then
         begin
          Esque;
          Elemento('30', 'Zn', 'Zinco', '65.38', 'S¢lido', '5', '64', '48.9%', '1180', '692.73', '7.14', '2',
          'Hexagonal', '1.25', '1.53', '9.2', '9.394', '0.39', '115.3', '7.322', '0.166', '1.16', '1.65',
          'Neutro', '2   8  18   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('30');
          goto 1;
         end;
      if ch2 = 'M' then
         begin
          Esque;
          Elemento('31', 'Ga', 'G†lio', '69.72', 'L°quido', '2', '69', '60.5%', '2478', '302.9', '5.91', '3',
          'Ortorombico', '1.26', '1.81', '11.8', '5.999', '0.37', '258.7', '5.59', '0.0678', '0.406', '1.81',
          'Neutro', '2   8  18   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('31');
          goto 1;
         end;
      if ch2 = 'N' then
         begin
          Esque;
          Elemento('32', 'Ge', 'GermÉnio', '72.59', 'S¢lido', '5', '74', '36.7%', '3107', '1210.4', '5.32', '4',
          'C£bico, face centrada', '1.22', '1.52', '13.6', '7.899', '0.32', '330.9', '36.94', '1.45x10^8', '0.599', '2.01',
          'Neutro', '2   8  18   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('32');
          goto 1;
         end;
      if ch2 = 'O' then
         begin
          Esque;
          Elemento('33', 'As', 'ArsÇnio', '74.9216', 'S¢lido', '1', '75', '100%', '876', '1081(28atm)', '5.72', 'Ò3 5',
          'Romboedrico', '1.2', '1.33', '13.1', '9.81', '0.33', '34.74', '-', '0.0345', '0.5', '2.18',
          'Acido', '2   8  18   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('33');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('34', 'Se', 'SelÇnio', '78.96', 'S¢lido', '6', '80', '49.8%', '958', '494', '4.8', '-2 4 6',
          'Hexagonal', '1.16', '1.22', '16.45', '9.752', '0.32', '37.7', '6.694', '10^12', '0.0204', '2.55',
          'Acido', '2   8  18   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('34');
          goto 1;
         end;
      if ch2 = 'Q' then
         begin
          Esque;
          Elemento('35', 'Br', 'Bromo', '79.904', 'L°quido', '2', '79', '50.6%', '332.25', '265.9', '3.12', 'Ò1 5',
          'Ortorombico', '1.14', '1.12', '23.5', '11.814', '0.473', '15.438', '5.286', '-', '0.00122', '3.16',
          'Acido', '2   8  18   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('35');
          goto 1;
         end;
      if ch2 = 'R' then
         begin
          Esque;
          Elemento('36', 'Kr', 'Cr°pton', '83.8', 'Gasoso', '6', '84', '56.9%', '119.8', '115.78', '3.74', '',
          'C£bico, face centrada', '1.12', '1.03', '38.9', '13.999', '0.248', '9.029', '1.638', '-', '0.0000949', '-',
          '', '2   8  18   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('36');
          goto 1;
         end;
     end;
  if ch1 = '5' then
     begin
      if ch2 = 'A' then
         begin
          Esque;
          Elemento('37', 'Rb', 'Rub°dio', '85.4678', 'S¢lido', '1', '85', '72.1%', '961', '312.64', '1.53', '1',
          'C£bico, corpo centrado', '2.16', '2.98', '55.9', '4.177', '0.363', '72.216', '2.192', '0.0779', '0.582', '0.82',
          'B†sico', '2   8  18   8   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('37');
          goto 1;
         end;
      if ch2 = 'B' then
         begin
          Esque;
          Elemento('38', 'Sr', 'Estrìncio', '87.62', 'S¢lido', '4', '88', '82.5%', '1650', '1041', '2.6', '2',
          'C£bico, face centrada', '1.91', '2.45', '33.7', '5.695', '0.3', '144.0', '8.3', '0.0762', '0.353', '0.95',
          'B†sico', '2   8  18   8   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('38');
          goto 1;
         end;
      if ch2 = 'C' then
         begin
          Esque;
          Elemento('39', 'Y', 'Itrio', '88.9059', 'S¢lido', '1', '89', '100%', '3611', '1799', '4.5', '3',
          'Hexagonal', '1.62', '2.27', '19.8', '6.38', '0.3', '363.0', '11.4', '0.0166', '0.172', '1.22',
          'B†sico', '2   8  18   8   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('39');
          goto 1;
         end;
      if ch2 = 'D' then
         begin
          Esque;
          Elemento('40', 'Zr', 'Zirc¢nio', '91.22', 'S¢lido', '5', '90', '51.5%', '4682', '2125', '6.49', '4',
          'Hexagonal', '1.45', '2.16', '14.1', '6.84', '0.27', '58.2', '16.9', '0.0236', '0.227', '1.33',
          'Neutro', '2   8  18   8   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('40');
          goto 1;
         end;
      if ch2 = 'E' then
         begin
          Esque;
          Elemento('41', 'Nb', 'Ni¢bio', '92.9064', 'S¢lido', '1', '93', '100%', '5017', '2740', '8.55', '5 3',
          'C£bico, corpo centrado', '1.34', '2.08', '10.87', '6.88', '0.26', '682.0', '26.4', '0.0693', '0.537', '1.6',
          'Acido', '2   8  18   8   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('41');
          goto 1;
         end;
      if ch2 = 'F' then
         begin
          Esque;
          Elemento('42', 'Mo', 'MolibdÇnio', '95.94', 'S¢lido', '7', '98', '23.8%', '4912', '2890', '10.2', '6 5 4 3 2',
          'C£bico, corpo centrado', '1.3', '2.01', '9.4', '7.099', '0.25', '598.0', '32.0', '0.187', '1.38', '2.16',
          'Acido', '2   8  18   8   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('42');
          goto 1;
         end;
      if ch2 = 'G' then
         begin
          Esque;
          Elemento('43', 'Tc', 'TecnÇcio', '98', 'P. SintÇticamente', '-', '-', '-', '4538', '2473', '11.5', '7',
          'Hexagonal', '1.27', '1.95', '8.5', '7.28', '0.21', '660.0', '24.0', '0.067', '0.506', '1.9',
          'Acido', '2   8  18   8   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('43');
          goto 1;
         end;
      if ch2 = 'H' then
         begin
          Esque;
          Elemento('44', 'Ru', 'RutÇnio', '101.07', 'S¢lido', '7', '102', '31.6%', '4423', '2523', '12.2', '2 3 4 6 8',
          'Hexagonal', '1.25', '1.89', '8.3', '7.37', '0.238', '595.0', '24.0', '0.137', '1.17', '2.2',
          'Acido', '2   8  18   8   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('44');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('45', 'Rh', 'R¢dio', '102.9055', 'S¢lido', '1', '103', '100%', '3970', '2236', '12.4', '2 3 4',
          'C£bico, face centrada', '1.25', '1.83', '8.3', '7.46', '0.242', '493', '21.5', '0.211', '1.5', '2.28',
          'Neutro', '2   8  18   9   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('45');
          goto 1;
         end;
      if ch2 = 'J' then
         begin
          Esque;
          Elemento('46', 'Pd', 'Pal†dio', '106.4', 'S¢lido', '6', '106', '27.3%', '3237', '1825', '12.0', '2 4',
          'C£bico, face centrada', '1.28', '1.79', '8.9',' 8.34', '0.24', '357.0', '17.6', '0.095', '0.718', '2.2',
          'B†sico', '2   8  18  10   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('46');
          goto 1;
         end;
      if ch2 = 'K' then
         begin
          Esque;
          Elemento('47', 'Ag', 'Prata', '107.868', 'S¢lido', '2', '107', '51.4%', '2436', '1234', '10.5', '1',
          'C£bico, face centrada', '1.34', '1.75', '10.3', '7.576', '0.235', '250.58', '11.3', '0.63', '4.29', '1.93',
          'Neutro', '2   8  18  18   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('47');
          goto 1;
         end;
      if ch2 = 'L' then
         begin
          Esque;
          Elemento('48', 'Cd', 'C†dmio', '112.41', 'S¢lido', '8', '114', '28.8%', '1040', '594.18', '8.65', '2',
          'Hexagonal', '1.48', '1.71', '13.1', '8.993', '0.23', '99.57', '6.192', '0.138', '0.968', '1.69',
          'B†sico', '2   8  18  18   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('48');
          goto 1;
         end;
      if ch2 = 'M' then
         begin
          Esque;
          Elemento('49', 'In', 'Indio', '114.82', 'S¢lido', '1', '113', '4.3%', '2346', '429.76', '7.31', '3',
          'Tetragonal', '1.44', '2.0', '15.7', '5.786', '0.23', '231.5', '3.263', '0.116', '0.816', '1.78',
          'Neutro', '2   8  18  18   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('49');
          goto 1;
         end;
      if ch2 = 'N' then
         begin
          Esque;
          Elemento('50', 'Sn', 'Estanho', '118.69', 'S¢lido', '10', '120', '33%', '2876', '505.06', '7.3', '4 2',
          'Tetragonal', '1.41', '1.72', '16.3', '7.344', '0.227', '295.8', '7.029', '0.0917', '0.666', '1.96',
          'Neutro', '2   8  18  18   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('50');
          goto 1;
         end;
      if ch2 = 'O' then
         begin
          Esque;
          Elemento('51', 'Sb', 'Antim¢nio', '121.75', 'S¢lido', '2', '121', '57.3%', '1860', '904', '6.68', 'Ò3 5',
          'Romboedrico', '1.4', '1.53', '18.23', '8.641', '0.21', '77.14', '19.87', '0.0288', '0.243', '2.05',
          'Acido', '2   8  18  18   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('51');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('52', 'Te', 'Tel£rio', '127.6', 'S¢lido', '8', '130', '34.5%', '1261', '722.65', '6.24', '-2 4 6',
          'Hexagonal', '1.36', '1.42', '20.5', '9.009', '0.2', '52.55', '17.49', '2x10^-6', '0.0235', '2.1',
          'Acido', '2   8  18  18   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('52');
          goto 1;
         end;
      if ch2 = 'Q' then
         begin
          Esque;
          Elemento('53', 'I', 'Iodo', '126.9045', 'S¢lido', '1', '127', '100%', '458.4', '386.7', '4.92', 'Ò1 5 7',
          'Ortorombico', '1.33', '1.32', '25.74', '10.451', '0.214', '20.752', '7.824', '8x10^16', '0.00449', '2.66',
          'Acido', '2   8  18  18   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('53');
          goto 1;
         end;
      if ch2 = 'R' then
         begin
          Esque;
          Elemento('54', 'Xe', 'XÇnon', '131.3', 'Gasoso', '9', '132', '26.9%', '165.03', '161.36', '5.89', '',
          'C£bico, face centrada', '1.31', '1.24', '37.3', '12.13', '0.158', '12.636', '2.297', '-', '0.0000569', '-',
          '', '2   8  18  18   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('54');
          goto 1;
         end;
     end;
  if ch1 = '6' then
     begin
      if ch2 = 'A' then
         begin
          Esque;
          Elemento('55', 'Cs', 'CÇsio', '132.9054', 'L°quido', '1', '133', '100%', '944', '301.55', '1.87', '1',
          'C£bico, corpo centrado', '2.35', '3.34', '71.07', '3.894', '0.24', '67.74', '2.092', '0.0489', '0.359', '0.79',
          'B†sico', '2   8  18  18   8   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('55');
          goto 1;
         end;
      if ch2 = 'B' then
         begin
          Esque;
          Elemento('56', 'Ba', 'B†rio', '137.33', 'S¢lido', '7', '138', '70.4%', '2171', '1002', '3.5', '2',
          'C£bico, corpo centrado', '1.98', '2.78', '39.24', '5.212', '0.204', '142.0', '7.75', '0.03', '0.184', '0.89',
          'B†sico', '2   8  18  18   8   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('56');
          goto 1;
         end;
      if ch2 = 'C' then
         begin
          Esque;
          Elemento('57', 'La', 'LantÉnio', '138.9055', 'S¢lido', '1', '139', '99.9%', '3730', '1193', '6.7', '3',
          'Hexagonal', '1.69', '2.74', '20.73', '5.58', '0.19', '414.0', '8.2', '0.0126', '0.135', '1.1',
          'B†sico', '2   8  18  18   8   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('57');
          goto 1;
         end;
      if ch2 = 'D' then
         begin
          Esque;
          Elemento('72', 'Hf', 'H†fnio', '178.49', 'S¢lido', '6', '180', '35.2%', '4876', '2500', '13.1', '4',
          'Hexagonal', '1.44', '2.16', '13.6', '6.65', '0.14', '575.0', '24.06', '0.0312', '0.23', '1.3',
          'Neutro', '2   8  18  32   8   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('72');
          goto 1;
         end;
      if ch2 = 'E' then
         begin
          Esque;
          Elemento('73', 'Ta', 'TÉntalo', '180.9479', 'S¢lido', '2', '181', '99.99%', '5731', '3287', '16.6', '5',
          'C£bico, corpo centrado', '1.34', '2.09', '10.9', '7.89', '0.13', '824', '35.4', '0.0761', '0.575', '1.5',
          'Acido', '2   8  18  32   8   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('73');
          goto 1;
         end;
      if ch2 = 'F' then
         begin
          Esque;
          Elemento('74', 'W', 'VolfrÉmio', '183.85', 'S¢lido', '5', '184', '30.6%', '5828', '3680', '19.3', '6 5 4 3 2',
          'C£bico, corpo centrado', '1.3', '2.02', '9.53', '7.98', '0.13', '824.0', '35.4', '0.189', '1.74', '2.36',
          'Acido', '2   8  18  32   8   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('74');
          goto 1;
         end;
      if ch2 = 'G' then
         begin
          Esque;
          Elemento('75', 'Re', 'RÇnio', '186.207', 'S¢lido', '2', '187', '62.9%', '5869', '3453', '21.0', '7 6 4 2 -1',
          'Hexagonal', '1.28', '1.97', '8.85', '7.88', '0.13', '715.0', '33.2', '0.0542', '0.479', '1.9',
          'Acido', '2   8  18  32   8   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('75');
          goto 1;
         end;
      if ch2 = 'H' then
         begin
          Esque;
          Elemento('76', 'Os', 'Osmio', '190.2', 'S¢lido', '7', '192', '41%', '5285', '3300', '22.4', '2 3 4 6 8',
          'Hexagonal', '1.26', '1.92', '8.49', '8.7', '0.13', '746', '31.8', '0.109', '0.876', '2.2',
          'Acido', '2   8  18  32   8   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('76');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('77', 'Ir', 'Ir°dio', '192.22', 'S¢lido', '2', '193', '61.5%', '4701', '2716', '22.5', '2 3 4 6',
          'C£bico, face centrada', '1.27', '1.87', '8.54', '9.1', '0.13', '604', '26.1', '0.197', '1.47', '2.2',
          'B†sico', '2   8  18  32   9   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('77');
          goto 1;
         end;
      if ch2 = 'J' then
         begin
          Esque;
          Elemento('78', 'Pt', 'Platina', '195.09', 'S¢lido', '4', '195', '33.8%', '4100', '2045', '21.4', '2 4',
          'C£bico, face centrada', '1.3', '1.83', '9.1', '9.0', '0.13', '510.0', '19.6', '0.0966', '0.716', '2.28',
          'B†sico', '2   8  18  32  10   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('78');
          goto 1;
         end;
      if ch2 = 'K' then
         begin
          Esque;
          Elemento('79', 'Au', 'Ouro', '196.9665', 'S¢lido', '1', '197', '100%', '3130', '1337.58', '19.3', '3 1',
          'C£bico, face centrada', '1.34', '1.79', '10.2', '9.225', '0.128', '334.4', '12.55', '0.452', '3.17', '2.54',
          'Neutro', '2   8  18  32  18   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('79');
          goto 1;
         end;
      if ch2 = 'L' then
         begin
          Esque;
          Elemento('80', 'Hg', 'Merc£rio', '200.59', 'L°quido', '7', '202', '29.8%', '630', '234.28', '13.53', '2 1',
          'Romboedrico', '1.49', '1.76', '14.82', '10.437', '0.139', '59.229', '2.295', '0.0104', '0.0834', '2.0',
          'B†sico', '2   8  18  32  18   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('80');
          goto 1;
         end;
      if ch2 = 'M' then
         begin
          Esque;
          Elemento('81', 'Ti', 'TitÉnio', '204.37', 'S¢lido', '5', '48', '74.0%', '1746', '577', '11.85', '3 1',
          'Hexagonal', '1.48', '2.08', '17.2', '6.108', '0.13', '164.1', '4.142', '0.0617', '0.461', '2.04',
          'B†sico', '2   8  18  32  18   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('81');
          goto 1;
         end;
      if ch2 = 'N' then
         begin
          Esque;
          Elemento('82', 'Pb', 'Chumbo', '207.2', 'S¢lido', '8', '208', '51.7%', '2023', '600.6', '11.4', '4 2',
          'C£bico, face centrada', '1.47', '1.81', '18.17', '7.416', '0.13', '177.7', '4.799', '0.0481', '0.353', '2.33',
          'Neutro', '2   8  18  32  18   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('82');
          goto 1;
         end;
      if ch2 = 'O' then
         begin
          Esque;
          Elemento('83', 'Bi', 'Bismuto', '208.9804', 'S¢lido', '1', '209', '100%', '1837', '544.52', '9.8', '3 5',
          'Romboedrico', '1.46', '1.63', '21.3', '7.289', '0.12', '104.8', '11.3', '0.00867', '0.0787', '2.02',
          'Acido', '2   8  18  32  18   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('83');
          goto 1;
         end;
      if ch2 = 'I' then
         begin
          Esque;
          Elemento('84', 'Po', 'Pol¢nio', '209', 'S¢lido', '-', '-', '-', '1235', '527', '9.4', '4 2',
          'Monocl°nico', '1.46', '1.53', '22.23', '8.42', '-', '-', '-', '0.0219', '0.2', '2.0',
          'Neutro', '2   8  18  32  18   6');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('84');
          goto 1;
         end;
      if ch2 = 'Q' then
         begin
          Esque;
          Elemento('85', 'At', 'Astato', '210', 'S¢lido', '-', '-', '-', '610', '575', '-', 'Ò1 3 5 7',
          '', '1.45', '1.43', '-', '-', '-', '-', '-', '-', '0.017', '2.2',
          '', '2   8  18  32  18   7');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('85');
          goto 1;
         end;
      if ch2 = 'R' then
         begin
          Esque;
          Elemento('86', 'Rn', 'R†don', '222', 'Gasoso', '-', '-', '-', '211', '202', '9.91', '',
          'C£bico, face centrada', '-', '1.34', '50.5', '10.748', '0.09', '16.4', '2.89', '-', '0.0000364', '-',
          '', '2   8  18  32  18   8');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('86');
          goto 1;
         end;
     end;
  if ch1 = '7' then
     begin
      if ch2 = 'A' then
         begin
          Esque;
          Elemento('87', 'Fr', 'FrÉncio', '223', 'L°quido', '-', '-', '-', '950', '300', '-', '1',
          'C£bico, corpo centrado', '-', '-', '-', '-', '-', '-', '-', '0.03', '0.15', '0.7',
          'B†sico', '2   8  18  32  18   8   1');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('87');
          goto 1;
         end;
      if ch2 = 'B' then
         begin
          Esque;
          Elemento('88', 'Ra', 'R†dio', '226.0254', 'S¢lido', '-', '-', '-', '1809', '973', '5', '2',
          'C£bico, corpo centrado', '-', '-', '45.2', '5.279', '-' ,'-', '-', '-', '0.186', '0.9',
          'B†sico', '2   8  18  32  18   8   2');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('88');
          goto 1;
         end;
      if ch2 = 'C' then
         begin
          Esque;
          Elemento('89', 'Ac', 'Actic°nio', '227.0278', 'S¢lido', '-', '-', '-' , '3473', '1323', '10.07', '3',
          'C£bico, face centrada', '-', '-', '22.54', '5.17', '-', '-', '-', '-', '0.12', '1.1',
          '', '2   8  18  32  18   8   3');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('89');
          goto 1;
         end;
      if ch2 = 'D' then
         begin
          Esque;
          Elemento('104', 'Unq', 'Unilqu†dio', '261', 'P. SintÇticamente', '-' ,'-', '-' ,'-', '-', '-', '-' ,
          '', '-', '-', '-' ,'-' ,'-' ,'-', '-', '-', '0.23', '-',
          '', '2   8  18  32  32  18   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('104');
          goto 1;
         end;
      if ch2 = 'E' then
         begin
          Esque;
          Elemento('105', 'Unp', 'Unilpàntio', '262', 'P. SintÇticamente', '-', '-' ,'-', '-', '-' ,'-' ,'-',
          '', '-', '-', '-', '-' ,'-' ,'-', '-' ,'-', '0.58', '-',
          '', '2   8  18  32  32  18   4');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('105');
          goto 1;
         end;
      if ch2 = 'F' then
         begin
          Esque;
          Elemento('106', 'Unh', 'UnilhÇxio', '263', 'P. SintÇticamente', '-', '-', '-', '-', '-', '-', '-',
          '', '-', '-', '-', '-', '-', '-' ,'-', '-', '-', '-',
          '', '2   8  18  32  32  18   5');
          Espe;
          ch3:= upcase(ch3);
          if ch3= 'I' then
             Pmenu('106');
          goto 1;
         end;
     end;
  if ch1 = '8' then
     begin
      LanAct('8');
      goto 1;
     end;
  if ch1 = '9' then
     begin
      LanAct('9');
      goto 1;
     end;
6:goto 4;
end;

{ Main Procedure }
begin
  Inicializa; { Gr†ficos }
  Nucleo; { onde est† a apresentaáÑo }
  Principal; { ...mente se daqui chama todas as funáîes do programa }
End.
{ EOF - Para mais informaáîes contacte o programador  ass.  Isaac MSC }