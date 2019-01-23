{
  []======================================================================[]
  ||                                                                      ||
  ||               Di rio Electr¢nico v1 por Pedro Cardoso                ||
  ||                                                                      ||
  []======================================================================[]

  Quem tiver quest”es ou sugest”es, escrevam-me. Quero contactar com outros
  programadores, tanto de jogos de programas.

  Pedro Cardoso
  R. Ant¢nio Sardinha 43
  Gafanha da Nazar‚
  3830 Ilhavo

}

Uses Dos,Crt;

const
  days : array [0..6] of String[13] =('Domingo','Segunda-feira','Ter‡a-feira',
     'Quarta-feira','Quinta-feira','Sexta-feira','S bado');

  Right  = ^D;
  Up     = ^E;
  Left   = ^S;
  Down   = ^X;
  Ins    = ^V;
  Del    = ^G;
  Enter  = ^M;
  ESC    = #27;
  Home   = #30;
  EndK   = #31;
  Tab    = #9;
  Bksp   = #8;


var     (* ##################### Vari veis ##################### *)

  ano, mes, dia, dow : Word;
  x,y:integer;
  ch:char;
  data_de_hoje:string;
  ficheiro:file ;


(* ###################### Procededures & Functions ########################*)

function GetKey: char;
var Kbd: Char;
begin
  Kbd := ReadKey;
  If Kbd = #0 then
    Case ReadKey of
      #72: Kbd := Up; 
      #75: Kbd := Left;
      #77: Kbd := Right;
      #80: Kbd := Down; 
      #82: Kbd := Ins;
      #83: Kbd := Del;
      #13: Kbd := Enter;
      #27: Kbd := ESC;
      #71: Kbd := Home;
      #79: Kbd := EndK;
      #08: Kbd := Bksp;
    end;
  GetKey:= Kbd;
end;

function ToStr(i: Longint): string; { converte uma vari vel num‚rica em String }
var
  s: string[11];
begin
  Str(i, s);
  ToStr := s;
end;

Procedure Quit;        { sai e grava o texto para um ficheiro }
begin
{$V-,S+,I+}
Textcolor(5);
Gotoxy(1,1);
ClrEOL;
Write('                            Di rio Electr¢nico      ',#10);
Gotoxy(1,2);
ClrEOL;
Textcolor(1);
Write(days[dow],'                                                     Dia ',dia , '-', mes , '-' , ano ,#10);
Gotoxy(1,25);
ClrEOL;
Assign(ficheiro,data_de_hoje);
Rewrite(ficheiro,1);
Blockwrite(ficheiro, mem[$B800:0], 4000);
Close(ficheiro);
ClrScr;
halt(0);
end;


{ %%%%%%%%%%%%%%%%%%%%%%%%% B L O C O  P R I N C I P A L %%%%%%%%%%%%%%%%%%%%}
Begin
ClrScr;
GetDate(ano,mes,dia,dow);

data_de_hoje:=(tostr(dia)+ '-'+ tostr(mes) + '-'+ tostr(ano-1900)+'.Dat');

   TextColor(9);
   Writeln('Di rio v1  - Editor -  ');
   Textcolor(12);
   Gotoxy(25,1);
   Writeln('Dia : ',dia,'/',mes,'/',ano,' ',days[dow]);
   Textcolor(14);
   Gotoxy(59,1);
   WriteLn(' por Pedro Cardoso ''94',#0);
   TextColor(green);
   Gotoxy(1,2);
   Writeln('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
   gotoxy(1,25);
   TextColor(red);
   Write('ESC = Sair & Gravar texto   ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ    Ficheiro : ',data_de_hoje);

 TextColor(7);
 TextBackGround(0);
 X:=1;
 Y:=3;


repeat

if x>79 then begin
             x:=0;
             Y:=y+1;
             end;

if x<1 then x:=1;
if y<3 then y:=3;
if y>24 then y:=24;


gotoxy(x,y);


     ch:=getkey;

     Case ch of
     Up   : y:=y-1;
     Down : y:=y+1;
     Right: x:=x+1;
     Left : x:=x-1;
     EndK : x:=79;
     Home : x:=1;
     Tab  : x:=x+8;
     Esc  : quit;
     Enter: begin
            x:=1;
            if y<26 then y:=y+1;
            gotoxy(x,y);
            end;
     Del  : begin
            if x<80 then X:=x+1;
            gotoxy(x,y);
            write(' ');
            end;
     Bksp : begin
            if x>1 then X:=x-1;
            gotoxy(x,y);
            write(' ');
            end
     else begin
          write(ch);
          x:=x+1;
          end;
     end;

   
until false;

end.