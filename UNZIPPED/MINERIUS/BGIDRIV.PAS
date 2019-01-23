{ Esta UNIT ‚ a que compila o EGAVGA.OBJ para o Execut vel }
unit BGIDriv;

interface

procedure EgaVgaDriverProc;

implementation

procedure EgaVgaDriverProc; external;
{$L EGAVGA.OBJ }

end.
