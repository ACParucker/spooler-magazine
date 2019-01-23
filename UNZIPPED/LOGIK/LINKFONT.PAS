
      (* UNIT que linka todas as fontes desejadas numa unidade .TPU
         Permitindo assim compilar todasas fontes desejadas num
         unico ficheiro .EXE
      *)
  
unit LinkFont;

interface

procedure Gothic;
procedure Bold;
procedure Triplex;

implementation

procedure Gothic; external;
{$L GOTH.OBJ }

procedure Bold; external;
{$L BOLD.OBJ }

procedure Triplex; external;
{$L TRIP.OBJ }

end.
