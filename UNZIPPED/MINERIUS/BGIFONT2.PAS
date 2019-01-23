{ Esta UNIT ‚ a que compila as outras 4 fontes.OBJ para o Execut vel }
unit BGIFont2;

interface

procedure BoldedFontProc;
procedure EuropeFontProc;
procedure LComandFontProc;
procedure ScriptFontProc;

implementation

procedure BoldedFontProc; external;
{$L BOLD.OBJ }

procedure EuropeFontProc; external;
{$L EURO.OBJ }

procedure LComandFontProc; external;
{$L LCOM.OBJ }

procedure ScriptFontProc; external;
{$L SCRI.OBJ }

end.