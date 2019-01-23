{    Programa em Turbo Pascal 7.0 por    }
{         Isaac MSC  Mem Martins         }
{                                        }
{ Programado em 19/7/1994 para a revista }
{                                        }
{            SPOOLER Magazine            }
{                                        }
{  Originalmente o Min‚rius.Exe tem as   }
{  fontes com os caract‚res portugueses  }
{                                        }
{ ATEN€ŽO:  Se esta ‚ a primeira vez que }
{ usa o Min‚rius, fa‡a:                  }
{     Alt-O+C+C+K_Full+Enter+Alt-C+B     }
{                                        }
Program Minerius;
{$M 32768,0,655360}
uses Crt, Graph, Printer, Mine0, Mine1, Mine2, Mine3, Dos, StrnTTT5,
     MiscTTT5, KeyTTT5, WinTTT5, BGIdriv, BGIfont, BGIfont2, BGIfont3;

{ Constante que d  50% de qualquer cor }
const G50 : FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);
var OldSaida : Pointer;
    Bolded, Europe, Lcomand, Script, Simplex, Tscrew : Integer;
    Sai : Boolean;

{ Oÿ$F+ faz com que pr‚ definidamente exista uma vari vel, Pointer    }
{ que est  pr‚ definida: faz qualquer coisa se alguma outra acontecer }
{ Sem que seja preciso fazer uma rotina que chame uma Procedure ...   }
{ Pois j  foi pr‚ definido . }
{$F+}

{ Antes de sair de qualquer parte do programa, o computador chama esta proc. }
procedure SairProc;
var
  Ver : Word;
begin
  ExitProc := OldSaida;
  CloseGraph;
  Writeln;
  writeln('Obrigado por ter utilizado o Min‚rius,   ass.');
  writeln('                                              Isaac MSC');
  writeln;
  Ver := DosVersion;
  WriteLn('DOS vers„o ',Lo(Ver),'.',Hi(Ver));
end;
{$F-}

procedure Abort(Msg : string);
begin
end;

{ Procedure de Inicializa‡„o do modo gr fico e de registra‡„o de fontes }
procedure Inicializa;
var Gd, Gm: Integer;
begin
  DirectVideo := False; OldSaida := ExitProc; ExitProc := @SairProc;
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then Abort('');
  if RegisterBGIfont(@GothicFontProc) < 0 then Abort('');
  if RegisterBGIfont(@SansSerifFontProc) < 0 then Abort('');
  if RegisterBGIfont(@SmallFontProc) < 0 then Abort('');
  if RegisterBGIfont(@TriplexFontProc) < 0 then Abort('');
  if RegisterBGIfont(@BoldedFontProc) < 0 then Abort('');
  if RegisterBGIfont(@EuropeFontProc) < 0 then Abort('');
  if RegisterBGIfont(@LcomandFontProc) < 0 then Abort('');
  if RegisterBGIfont(@ScriptFontProc) < 0 then Abort('');
  if RegisterBGIfont(@SimplexFontProc) < 0 then Abort('');
  if RegisterBGIfont(@TscrewFontProc) < 0 then Abort('');
  if MaxAvail < 65720 then
     begin
       writeln('Lamento mas o computador n„o tem mem¢ria suficiente!');
       writeln('O Min‚rius necessita de 512Kb (524288 bytes)');
       writeln('Ter  que libertar ',(65720 - MaxAvail) div 1024,'Kb');
       halt;
     end;
  Gd := Detect; InitGraph(Gd, Gm, '');
  setgraphmode(2);
  if GraphResult <> grOk then Halt(1);
  Bolded := InstallUserFont('BOLD');
  Europe := InstallUserFont('EURO');
  Lcomand := InstallUserFont('LCOM');
  Script := InstallUserFont('SCRI');
  Simplex := InstallUserFont('SIMP');
  Tscrew := InstallUserFont('TSCR');
end;

{ Main procedure }
begin
  Inicializa; { o modo gr fico }
  Apresenta; { o ecr„ de abertura do programa }
  Menu; { que d  acesso a todas as outras fun‡”es do programa }
end.
{ EOF - Para mais informa‡”es contacte o programador  ass.  Isaac MSC }