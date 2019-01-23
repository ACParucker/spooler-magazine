
      (* UNIT que linka todas as fontes desejadas numa unidade .TPU
         Permitindo assim compilar todas as fontes desejadas num
         unico ficheiro .EXE
      *)
  
unit LinkFont;

interface

procedure BoldFont;
procedure TscrFont;

implementation

procedure BoldFont; external;
{$L BOLD.OBJ }

procedure TscrFont; external;
{$L TSCR.OBJ }

end.
