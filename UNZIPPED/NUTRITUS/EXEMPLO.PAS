{ Programado por Isaac MSC em 19/07/1994 }
{ Para   a   revista   SPOOLER  Magazine }
Program Exemplo; { Nome do programa }

uses Dos; { usa a UNIT DOS }

var OldSaida: Pointer; { define a vari vel OldSaida que seja um POINTER }

{$F+}              { inicia o processo FAR Call Model }
procedure SairProc; { SairProc }
var Ver: Word; { vari vel ver = WORD }
begin
  ExitProc:= OldSaida; { Desliga o comando ExitProc  em caso contr rio }
  writeln;             { esta procedure estaria aqui a correr at‚ amanh„ }
  writeln('Programado por  Isaac MSC'); {}
  writeln;                              {}
  ver:= DosVersion; { vari vel ver = … vers„o do Dos }
  writeln('MS-DOS vers„o ',Lo(Ver),'.',Hi(Ver)); { d  transformada a DosVer }
end;
{$F-}              { acaba o processo FAR Call Model }

begin
  OldSaida:= ExitProc; { POINTER OldSaida = ao comando EXITPROC }
  ExitProc:= @SairProc; { Vari vel comando ExitProc = … proc @SairProc }
  writeln('Testa o comando ExitProc'); {}
end. { Acaba o programa e executa autom ticamente a proc ExitProc }