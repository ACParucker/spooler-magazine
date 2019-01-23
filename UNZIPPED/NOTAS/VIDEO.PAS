{============================================================================}
{                                                                            }
{   Unidade Video                                                            }
{   1989, 1990                                                               }
{                                                                            }
{============================================================================}
unit Video;

{$R-}               { Range checking }
{$S-}               { Stack checking }
{$I-}               { I/O checking }
{$F+}               { Force far calls }
{$O-}               { Overlays allowed }
{$A-}               { Align data }
{$V-}               { var-string checking }
{$B-}               { Boolean evaluation }
{$N-}               { Numeric processing }
{$E-}               { Emulation }
{$D-}               { Debug information }
{$L-}               { Local symbols }

interface

const { cores }
   Preto= 0;
   Azul= 1;
   Verde= 2;
   Ciao= 3;
   Vermelho= 4;
   Magenta= 5;
   Castanho= 6;
   CinzentoClaro= 7;
   CinzentoEscuro= 8;
   AzulClaro= 9;
   VerdeClaro= 10;
   CiaoClaro= 11;
   VermelhoClaro= 12;
   MagentaClaro= 13;
   Amarelo= 14;
   Branco= 15;

const
   SegCRom=$F000;
   OfsCRom=$FA6E;

   SegCars: Word= SegCRom;
   OfsCars: Word= OfsCRom;

type
   TAdaptVideo= ( AdaptMono, AdaptCor );

function AdaptVideo: TAdaptVideo;
function SegVideo: Word;
function OfsVideo( X, Y: Word ): Word;
procedure Border( cor: Byte );
procedure EscondCursor;
procedure MostCursor;
procedure GotoXY( X, Y: Byte );

implementation

uses
   Crt, Dos;

{============================================================================}
function AdaptVideo: TAdaptVideo;
begin
   if ( Mem[ $40:$49 ] <> 7 ) then
   AdaptVideo := AdaptCor
      else
   AdaptVideo := AdaptMono;
end;
{============================================================================}
function SegVideo: Word;
const
{ Segmentos Video }
   SegAdaptMono= $B000;
   SegAdaptCor= $B800;
begin
   if ( AdaptVideo = AdaptMono ) then
   SegVideo := SegAdaptMono
      else
   SegVideo := SegAdaptCor;
end;
{============================================================================}
function OfsVideo( X, Y: Word ): Word;
begin
   OfsVideo := X * 80 * 2 + Y * 2;
end;
{============================================================================}
procedure Border( Cor: Byte );
const
   SetColorPalette = $0B;
var
   Regs: Registers;
begin
    Regs.AH := SetColorPalette;
    Regs.BH := $00;
    Regs.BL := Cor;
    Intr( $10, Regs );
end;
{============================================================================}
procedure AltCursor( Topo, Fundo: Byte );
var
   Regs: Registers;
begin
   Regs.AX := $0100;
   Regs.CH := topo;
   Regs.CL := Fundo;
   Intr( $10, Regs );
end;
{============================================================================}
procedure EscondCursor;
begin
   AltCursor( $30,$30 );
end;
{============================================================================}
procedure MostCursor;
begin
   if ( AdaptVideo = AdaptMono ) then
   AltCursor( 12, 13 )
      else
   AltCursor( 7, 8 );
end;
{============================================================================}
procedure GotoXY( X, Y: Byte );

{ Redefinicao do procedimento da unidade Crt.
  Este procedimento posiciona o cursor na Linha, Coluna
  ( 0 - 24, 0 - 79 ) }

begin
   Crt.GotoXY( Y + 1, X + 1 );
end;
{============================================================================}
end.
