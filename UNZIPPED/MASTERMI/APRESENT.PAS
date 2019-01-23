UNIT Apresent;

Interface

Uses Crt, Graph;

Const
{$I MstMind.pas }
{$I Corcu.pas }

Var
  grDriver: Integer;
  grMode: Integer;
  ErrCode: Integer;
  Titulo, I, Z : Integer;

Procedure StripesIn(X, Y : Integer; Frase : String);
Procedure StripesOut(X, Y : Integer; Frase : String);
Procedure FecharHoriz(X1, Y1, X2, Y2 : Integer);
Procedure FecharVert(X1, Y1, X2, Y2 : Integer);
Procedure Botao(X1, Y1, X2, Y2 : Integer; Fundo, Cor1, Cor2, Cor3 : Byte);
Procedure Quadro;
Procedure EcranMenu;
Procedure Principal;

Implementation


Procedure StripesIn(X, Y : Integer; Frase : String);
Var
    I, Z : Integer;
begin
  SetColor(8);
  OutTextXY(X, Y, Frase);
  For Z := (Y + TextHeight(Frase) + 5) downto Y do
    begin
      For I := X to (X + TextWidth(Frase)) do
         begin
           If GetPixel(I, Z) <> 0 then PutPixel(I, Z, 7);
           If GetPixel(I, Z + 5) <> 0 then PutPixel(I, Z + 5, 15);
         end;
      delay (100);
    end;
end;

Procedure StripesOut(X, Y : Integer; Frase : String);
Var
    I, Z : Integer;
begin
  SetColor(15);
  OutTextXY(X, Y, Frase);
  SetColor(0);
  For Z := Y to (Y + TextHeight(Frase) + 20) do
    begin
      For I := X to (X + TextWidth(Frase)) do
         begin
           If GetPixel(I, Z) <> 0 then PutPixel(I, Z, 7);
           If GetPixel(I, Z - 5) <> 0 then PutPixel(I, Z - 5, 8);
         end;
      Line(X, Z - 10, X + TextWidth(Frase), Z - 10);
      Delay(100);
    end;
end;

Procedure FecharHoriz(X1, Y1, X2, Y2 : Integer);
begin
  SetColor(0);
  for I := 1 to ((Y2 - Y1) div 2) do
     begin
       Line(X1, Y1 + I, X2, Y1 + I);
       Line(X1, Y2 - I, X2, Y2 - I);
       Delay(10);
     end;
end;

Procedure FecharVert(X1, Y1, X2, Y2 : Integer);
begin
  SetColor(0);
  for I := 1 to ((X2 - X1) div 2) do
     begin
       Line(X1 + I, Y1, X1 + I, Y2);
       Line(X2 - I, Y1, X2 - I, Y2);
       Delay(10);
     end;
end;

Procedure Botao(X1, Y1, X2, Y2 : Integer; Fundo, Cor1, Cor2, Cor3 : Byte);
Var
   Bordo1, Bordo2 : array[1..6] of PointType;
   CorAnt : Integer;

begin
  CorAnt := GetColor;
  {Inicia Bordo Lateral Esquerdo e Superior }
  Bordo1[1].X := X1;         Bordo1[1].Y := Y1;
  Bordo1[2].X := X2;         Bordo1[2].Y := Y1;
  Bordo1[3].X := X2 - Fundo; Bordo1[3].Y := Y1 + Fundo;
  Bordo1[4].X := X1 + Fundo; Bordo1[4].Y := Y1 + Fundo;
  Bordo1[5].X := X1 + Fundo; Bordo1[5].Y := Y2 - Fundo;
  Bordo1[6].X := X1;         Bordo1[6].Y := Y2;
  {Inicia Bordo Lateral Direito e Inferior }
  Bordo2[1].X := X2;         Bordo2[1].Y := Y1;
  Bordo2[2].X := X2;         Bordo2[2].Y := Y2;
  Bordo2[3].X := X1        ; Bordo2[3].Y := Y2;
  Bordo2[4].X := X1 + Fundo; Bordo2[4].Y := Y2 - Fundo;
  Bordo2[5].X := X2 - Fundo; Bordo2[5].Y := Y2 - Fundo;
  Bordo2[6].X := X2 - Fundo; Bordo2[6].Y := Y1 + Fundo;
  {Desenha Botao }
  SetFillStyle(SolidFill, Cor2);
  Bar(X1, Y1, X2, Y2);
  SetFillStyle(SolidFill, Cor1); SetColor(Cor1);
  FillPoly(SizeOf(Bordo1) div SizeOf(PointType), Bordo1);
  SetFillStyle(SolidFill, Cor3); SetColor(Cor3);
  FillPoly(SizeOf(Bordo2) div SizeOf(PointType), Bordo2);
  SetColor(CorAnt);
end;

Procedure Quadro;
Var
   I, Z : Integer;

begin
  SetColor(9);
  SetFillStyle(SolidFill, 7);
  Bar(170, 50, 470, 430);
  SetLineStyle(SolidLn, 0, ThickWidth);
  Rectangle(170, 50, 470, 430);
  SetLineStyle(SolidLn, 0, NormWidth);

  Botao(190, 70, 450, 410, 4, 8, 7, 15);
  Botao(210, 90, 430, 390, 4, 8, 7, 15);

  SetTextStyle(TriplexFont, HorizDir, 6);
  SetTextJustify(CenterText, TopText);
  SetColor(8);
  For Z := 1 to 4 do
    For I := 1 to 2 do
       begin
         OutTextXY(324 + I, 105 + Z, 'MASTER');
         OutTextXY(324 + I, 155 + Z, 'MIND');
       end;
  SetColor(15);
  For Z := 1 to 3 do
    For I := 1 to 3 do
       begin
         OutTextXY(318 + I, 98 + Z, 'MASTER');
         OutTextXY(318 + I, 148 + Z, 'MIND');
       end;
  SetColor(9);
  OutTextXY(320, 100, 'MASTER');
  OutTextXY(320, 150, 'MIND');

  SetTextStyle(Titulo, HorizDir, 1);
  SetColor(0);
  OutTextXY(320, 210, 'Vers„o 1.1');
  SetColor(4);
  SetUserCharSize(1, 2, 1, 2);
  OutTextXY(320, 342, 'Escrito por :');
  SetColor(0);
  SetTextStyle(Titulo, HorizDir, 2);
  OutTextXY(320, 360, 'Pedro Nunes');

  SetColor(8);
  Rectangle(271, 241, 371, 341);
  SetColor(15);
  Rectangle(270, 240, 370, 340);
  PutImage(280, 265, MstMind, NormalPut);
end;

Procedure EcranMenu;

Var
    I, Z  : Integer;
    Frase : String;

Procedure Aparece(X, Y, N, D , C : Integer; Frase : String);
var i : Integer;
begin
 For I := 1 to N do
    begin
      SetColor(C);
      SetUserCharSize(I, D, I, D);
      OutTextXY(X, Y, Frase);
      Delay(5);
    end;
 For I := 1 to N - 1 do
    begin
      SetColor(0);
      SetUserCharSize(I, D, I, D);
      OutTextXY(X, Y, Frase);
      Delay(5);
    end;
 SetColor(C);
 SetUserCharSize(N, D, N, D);
 OutTextXY(X, Y, Frase);
end;

Begin
 SetTextStyle(8, HorizDir, 1);
 SetUserCharSize (1,3,1,3);
 SetTextJustify(CenterText, CenterText);
 Frase := 'MASTER';
 for i := 1 to length(Frase) do
     Aparece(40, I * 70 - 55, 15, 5, 14, Frase[I]);
 Delay(100);
 Frase := 'IND';
 for i := 1 to length(Frase) do
     Aparece(50 + I * 60, 15, 15, 5, 14, Frase[I]);

 For I := 34 to 63 do
     For Z := 35 to 420 do
         If GetPixel(I, Z) <> 0 then PutPixel(I, Z, 12);

 For I := 63 to 250 do
     For Z := 35 to 67 do
         If GetPixel(I, Z) <> 0 then PutPixel(I, Z, 12);

 SetColor(12);
 Line(255, 35, 600, 35); Line(600, 35, 600, 450);
 SetTextStyle (0,0,1);
 SetColor (15);
 OutTextxy (490,450,'(c) Pedro Nunes 1993');
 SetColor (12);
 Line (580, 450, 600, 450);
 Line(34, 450, 400, 450); Line(34, 423, 34, 450);
End;

Procedure Principal;

Begin
  Titulo := InstallUserFont('TITU');
  SetTextStyle(TriplexFont, HorizDir, 4);
  SetTextJustify(LeftText, TopText);
  PutImage(225, 1, corcu, NormalPut);
  StripesIn(170, 300, 'SPOOLER apresenta');
  StripesOut(170, 300, 'SPOOLER apresenta');
  FecharHoriz(225, 1, 390, 220);
  Quadro;
  Delay(2000);
End;

End.