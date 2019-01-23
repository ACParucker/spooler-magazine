{ Esta UNIT ‚ a que compila as 4 primeiras fontes.OBJ para o Execut vel }
unit BGIFont;
interface

procedure GothicFontProc;
procedure SansSerifFontProc;
procedure SmallFontProc;
procedure TriplexFontProc;

implementation

procedure GothicFontProc; external;
{$L GOTH.OBJ }

procedure SansSerifFontProc; external;
{$L SANS.OBJ }

procedure SmallFontProc; external;
{$L LITT.OBJ }

procedure TriplexFontProc; external;
{$L TRIP.OBJ }

end.
