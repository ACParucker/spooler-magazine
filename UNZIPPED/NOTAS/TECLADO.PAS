{============================================================================}
{                                                                            }
{   Unidade Teclado                                                          }
{   1989, 1990                                                               }
{                                                                            }
{============================================================================}
unit Teclado;

{$R+}               { Range checking }
{$S+}               { Stack checking }
{$I+}               { I/O checking }
{$F+}               { force far calls }
{$O-}               { Overlays allowed }
{$A+}               { Align data }
{$V+}               { var-string checking }
{$B+}               { Boolean evaluation }
{$N-}               { Numeric processing }
{$E-}               { Emulation }
{$D+}               { Debug information }
{$L-}               { Local symbols }

interface

const
   { Teclas Codigo Normal }
   Enter= 13;
   Esc= 27;
   Tab= 9;
   PgUp= 73;
   PgDn= 81;
   DelBack= 8;
   Delforward= 83;

   { Teclas Codigo Extendido }
   Home= 71;
   Ed= 79;
   Inser= 82;

   CursorUp= 72;            Cursordown= 80;          CursorLeft= 75;
   CursorRight= 77;

function LerTecla: Byte;
procedure LimparBufferT;

implementation

uses
   Crt, Dos;

var
   TecExt: Boolean;

{============================================================================}
function LerTecla: Byte;
var
   CTec: Byte;
begin
   TecExt := False;
   CTec := Ord( ReadKey );
   if ( CTec = 0 ) then
   begin
      TecExt := True;
      CTec := Ord( ReadKey );
   end;
   LerTecla := CTec;
end;
{============================================================================}
procedure LimparBufferT;
begin
   Mem[ 0:1050 ] := Mem[ 0:1052 ];
end;
{============================================================================}
end.

