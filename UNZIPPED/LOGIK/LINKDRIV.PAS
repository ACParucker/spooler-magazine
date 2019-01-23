
     (* UNIT que linka os drivers graphicos numa unidade  .TPU
        Permitindo assim compilar os drivers desejados num unico
        ficheiro .EXE 
     *) 

unit LinkDriv;

interface

procedure EgaVgaDriver;

implementation

procedure EgaVgaDriver; external;
{$L EGAVGA.OBJ }

end .
