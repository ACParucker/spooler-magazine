{ Esta UNIT ‚ a que compila as ultimas 2 fontes.OBJ para o Execut vel }
unit BGIFont3;

interface

procedure SimplexFontProc;
procedure TscrewFontProc;

implementation

procedure SimplexFontProc; external;
{$L SIMP.OBJ }

procedure TscrewFontProc; external;
{$L TSCR.OBJ }

end.

