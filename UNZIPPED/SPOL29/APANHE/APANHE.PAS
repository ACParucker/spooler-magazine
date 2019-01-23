Program ApanheSePuder (Input, Ouput);

Uses
  Crt, Drivers, Objects;

Var
  Event: TEvent;
  MouseWhere: TPoint;
  P, Q, cur: Byte;


Procedure Caixa (var apaga, desenha, cur: Byte);

var
  cor: Byte;

begin
  Case apaga of
    1 : Window (1,1,8,4);
    2 : Window (72,1,80,4);
    3 : Window (72,21,80,25);
    4 : Window (1,21,8,25);
  end;
  if apaga > 0 then ClrScr;
  cor := Random (4);
  Case cor of
    0 : cor:=4;
    1 : cor:=3;
    2 : cor:=5;
    3 : cor:=6;
  end;
  TextColor (cor);
  Case desenha of
    1 : Window (1,1,8,4);
    2 : Window (72,1,80,4);
    3 : Window (72,23,80,25);
    4 : Window (1,23,8,25);
  end;
  Gotoxy (1,1);
  Writeln ('…ÕÕÕÕÕª');
  Writeln ('∫AQUI!∫');
  Write   ('»ÕÕÕÕÕº');
  Window (1,1,80,25);
  cur:=desenha;
  apaga:=0; desenha:=0;
end;

Function Seguinte (ant: Byte): Byte;

var
  novo: Byte;

begin
  Repeat
    novo := Random (4) + 1;
  Until (novo <> ant);
  Seguinte:=novo;
end;


BEGIN
  ClrScr;
  TextColor (Green);
  Gotoxy (30,9); Write ('Apanhe o Quadrado !');
  TextColor (Yellow);
  Gotoxy (38,11); Write ('…Õª');
  Gotoxy (38,12); Write ('∫ ∫');
  Gotoxy (38,13); Write ('»Õº');
  TextColor (LightBlue);
  Gotoxy (22,15); Write ('Carregue Aqui Quando Quiser Desistir !');
  p:=0; q:=2; cur:=2;
  Caixa (p,q,cur);
  InitEvents;
  Repeat
    Gotoxy (39,12);
    GetMouseEvent (Event);
    MouseWhere.X := Event.Where.X;
    MouseWhere.Y := Event.Where.Y;
    if (Event.What = evMouseMove) then
    Case Event.Where.X of
      0 ..  7 : Case Event.Where.Y of
                  0 .. 3  : begin p:=1; q:=Seguinte(1); end;
                  4 .. 19 : begin p:=0; q:=0; end;
                  21 .. 25: begin p:=4; q:=Seguinte(4); end;
                end;
      8 .. 70 : begin p:=0; q:=0; end;
     71 .. 79 : Case Event.Where.Y of
                  0 .. 3  : begin p:=2; q:=Seguinte(2); end;
                  4 .. 19 : begin p:=0; q:=0; end;
                  21 .. 25: begin p:=3; q:=Seguinte(3); end;
                end;
    end;
    if (p<>0) and (q<>0) then
      begin
        if (p = cur) then Caixa(p,q,cur);
      end;
  Until (Event.What = evMouseDown) and (MouseWhere.X = 38) and (MouseWhere.Y = 11);
  DoneEvents;
  TextColor (15); TextBackGround (0); ClrScr;
END.