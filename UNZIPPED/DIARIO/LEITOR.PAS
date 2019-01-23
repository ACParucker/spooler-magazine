{
  []======================================================================[]
  ||                                                                      ||
  ||    Di rio Electr¢nico v1 por Pedro Cardoso & Radioactive Design      ||
  ||                             Leitor                                   ||
  []======================================================================[]

  Para questäes ou sugestäes, escrevam-me. Quero contactar com outros
  programadores, tanto de jogos de programas.

  Pedro Cardoso
  R. Ant¢nio Sardinha 43
  Gafanha da Nazar‚
  3830 Ilhavo

}

Uses Crt;

var f:file;
    x:integer;
    data:string;
    ano, mes, dia : Word;


function ToStr(i: Longint): string; { converte uma vari vel num‚rica em String }
var
  s: string[11];
begin
  Str(i, s);
  ToStr := s;
end;


{ ---------------------- Parte Principal -------------------------- }
Begin
TextColor(10);
Writeln(#10,#10,'Di rio Electr¢nico v1.0 -- Leitor            (C) Radioactive Design 1994');
Textcolor(9);
Writeln('Qual o dia ? (1-31) : ');
readln(dia);
Writeln('Qual o mˆs ? (1-12) : ');
readln(mes);
Writeln('Qual o ano ? (94-??) : ');
Readln(ano);


data:=ToStr(dia) + '-' + ToStr(mes) + '-' + ToStr(ano) + '.DAT';

Assign(f,data);
Reset(f);
BlockRead(f, Mem[$B800:0], 4000,x);
GotoXY(1,1);
Repeat Until KeyPressed;
TextColor(7);
Writeln('Di rio Electr¢nico v1.0 -- Leitor            (C) Radioactive Design 1994');
end.

