{============================================================================}
{                                                                            }
{   Unidade Texto                                                            }
{   1989, 1990                                                               }
{                                                                            }
{============================================================================}
unit Texto;

{$R-}               { Range checking }
{$S-}               { Stack checking }
{$I-}               { I/O checking }
{$F-}               { force far calls }
{$O-}               { Overlays allowed }
{$A-}               { Align data }
{$V-}               { var-string checking }
{$B-}               { Boolean evaluation }
{$N-}               { Numeric processing }
{$E-}               { Emulation }
{$D-}               { Debug information }
{$L-}               { Local symbols }

interface

procedure LnHoriz( CX, CY, Cp, Tp, CT, CF: Byte );
procedure LnVert( CX, CY, Alt, Tp, CT, CF: Byte );
procedure LnHorizC( CX, CY, Cp, Tp, CT, CF: Byte );
procedure LnVertC( CX, CY, Alt, Tp, CT, CF: Byte );
procedure Caixa( CX, CY, Cp, Alt, Tp: Byte; CT,CF: Byte);
procedure ApgQuadro( CX, CY, Cp, Alt, CT, CF: Byte );
procedure Quadro( CX, CY, Cp, Alt, Tp, CT, CF, CTCx, CFCx: Byte );
procedure EscvExp( CX, CY, H, V, CdCar: Byte; Pch: Boolean; T: string; CT, CF: Byte );
procedure EscvCars( CX, CY, Cp, Alt, CdCar, CT, CF: Byte );

implementation

uses
   Crt,
   Video;

{============================================================================}
procedure LnHoriz( CX, CY, Cp, Tp, CT, CF: Byte );
const
   Cars: array [ 1..3 ] of Char = ( 'Í', 'Ä', Chr( 15 ) );
var
   Atr: Byte;
   CdCar: Byte;
   OfsV: Word;
begin
   CdCar := Ord( Cars[ Tp ] );
   Atr := CF * 16 + CT;
   for CY := CY to CY + Cp - 1 do
   begin
      OfsV := OfsVideo( CX, CY );
      Mem[ SegVideo: OfsV ] := CdCar;
      Mem[ SegVideo: OfsV + 1 ] := Atr;
   end;
end;
{============================================================================}
procedure LnVert( CX, CY, Alt, Tp, CT, CF: Byte );
const
   Cars: array [ 1..3 ] of Char =
   ( 'º', '³', Chr( 15 ) );
var
   Atr: Byte;
   CdCar: Byte;
   OfsV: Word;
begin
   CdCar := Ord( Cars[ Tp ] );
   Atr := CF * 16 + CT;
   for CX := CX to CX + Alt - 1 do
   begin
      OfsV := OfsVideo( CX, CY );
      Mem[ SegVideo: OfsV ] := CdCar;
      Mem[ SegVideo: OfsV + 1 ] := Atr;
   end;
end;
{============================================================================}
procedure LnHorizC( CX, CY, Cp, Tp, CT, CF: Byte );
const
   Cars: array [ 1..12, 1..3 ] of Char=
   ( ( 'É', '»', Chr( 1 ) ),
     ( 'Ú', '¿', Chr( 2 ) ),
     ( 'Õ', '¸', chr( 1 ) ),
     ( 'Ö', '·', Chr( 2 ) ),
     ( Chr( 15 ), Chr( 15 ), Chr( 3 ) ),
     ( 'Ã', '´', Chr( 2 ) ),
     ( 'È', '¼', Chr( 1 ) ),
     ( 'À', 'Ù', Chr( 2 ) ),
     ( 'Ô', '¾', Chr( 1 ) ),
     ( 'Ó', '½', Chr( 2 ) ),
     ( Chr( 15 ), Chr( 15 ), Chr( 3 ) ),
     ( 'Ã', '´', Chr( 2 ) ) );
var
   OfsV: Word;
   Cdce: Byte;
   Cdcd: Byte;
   Tplh: Byte;
begin
   Cdce := Ord( Cars[ Tp, 1 ] );
   Cdcd := Ord( Cars[ Tp, 2 ] );
   Tplh := Ord( Cars[ Tp, 3 ] );
   OfsV := OfsVideo( CX, CY );
   Mem[ SegVideo: OfsV ] := Cdce;
   Mem[ SegVideo: OfsV + 1 ] := CF * 16 + CT;
   LnHoriz( CX, CY + 1, Cp - 2, Tplh, CT, CF );
   OfsV := OfsVideo( CX, CY + Cp - 1 );
   Mem[ SegVideo: OfsV ] := Cdcd;
   Mem[ SegVideo: OfsV + 1 ] := CF * 16 + CT;
end;
{============================================================================}
procedure LnVertC( CX, CY, Alt, Tp, CT, CF: Byte );
const
   Cars: array [ 1..12, 1..3 ] of Char=
   ( ( 'É', 'È', Chr( 1 ) ),
     ( 'Ú', 'À', Chr( 2 ) ),
     ( 'Õ', 'À', Chr( 2 ) ),
     ( 'Õ', 'Ô', Chr( 2 ) ),
     ( 'Ö', 'Ó', Chr( 1 ) ),
     ( Chr( 15 ), Chr( 15 ), Chr( 3 ) ),
     ( '»', '¼', Chr( 1 ) ),
     ( '¿', 'Ù', Chr( 2 ) ),
     ( '¸', 'Ù', Chr( 2 ) ),
     ( '¸', '¾', Chr( 2 ) ),
     ( '·', '½', Chr( 1 ) ),
     ( Chr( 15 ), Chr( 15 ), Chr( 3 ) ) );
var
   OfsV: Word;
   Cdcs: Byte;
   Cdci: Byte;
   Tplv: Byte;
begin
   Cdcs := Ord( Cars[ Tp, 1 ] );
   Cdci := Ord( Cars[ Tp, 2 ] );
   Tplv := Ord( Cars[ Tp, 3 ] );
   OfsV := OfsVideo( CX, CY );
   Mem[ SegVideo: OfsV ] := Cdcs;
   Mem[ SegVideo: OfsV + 1 ] := CF * 16 + CT;
   LnVert( CX + 1, CY, Alt - 2, Tplv, CT, CF );
   OfsV := OfsVideo( CX + Alt - 1, CY );
   Mem[ SegVideo: OfsV ] := Cdci;
   Mem[ SegVideo: OfsV + 1 ] := CF * 16 + CT;
end;
{============================================================================}
procedure Caixa( CX, CY, Cp, Alt, Tp: Byte; CT,CF: Byte);
const
   Tps: array [ 1..6, 1..4 ] of Byte=
   ( ( 1, 1, 1, 1 + 6 ),
     ( 2, 2, 2, 2 + 6 ),
     ( 1, 2, 3, 3 + 6 ),
     ( 1, 1, 4, 4 + 6 ),
     ( 2, 2, 5, 5 + 6 ),
     ( 3, 3, 6, 6 + 6 ) );
var
   Tpls: Byte;
   Tpli: Byte;
   Tple: Byte;
   Tpld: Byte;
begin
   Tpls := Tps[ Tp, 1 ];
   Tpli := Tps[ Tp, 2 ];
   Tple := Tps[ Tp, 3 ];
   Tpld := Tps[ Tp, 4 ];
   LnVertC( CX, CY, Alt, Tple, CT, CF );
   LnVertC( CX, CY + Cp - 1, Alt, Tpld, CT, CF );
   LnHoriz( CX, CY + 1, Cp - 2, Tpls, CT, CF );
   LnHoriz( CX + Alt - 1, CY + 1, Cp - 2, Tpli, CT, CF );
end;
{============================================================================}
procedure ApgQuadro( CX, CY, Cp, Alt, CT, CF: Byte );
var
   Wind: record
      Min, Max: Word;
   end;
begin
   if( ( Cp<>0 ) and ( Alt <> 0 ) ) then
   begin
      Wind.Min := WindMin;
      Wind.Max := WindMax;
      TextColor( CT );
      TextBackground( CF );
      Window( CY + 1, CX + 1, CY + Cp, CX + Alt );
      ClrScr;
      WindMin := Wind.Min;
      WindMax := Wind.Max;
   end;
end;
{============================================================================}
procedure Quadro( CX, CY, Cp, Alt,Tp, CT,CF, CTCx, CFCx: Byte );
begin
   Caixa( CX, CY, Cp, Alt, Tp, CTCx, CFCx );
   ApgQuadro( CX + 1, CY + 1, Cp - 2, Alt - 2, CT, CF );
end;
{============================================================================}
procedure EscvExp( CX, CY, H, V, CdCar: Byte; Pch: Boolean; T: string; CT, CF: Byte );
var
   OfsV: Word;
   OfsCar: Word;
   Bits, Bit, Bytes: Byte;
   Cor, Car: Byte;
   ByteCar: Byte;
   CXA, CYA: Byte;
   ExtH, ExtV: Byte;
   CdCarA: Byte;
begin
   CXA := CX;
   CYA := CY;
   ExtV := 0;
   Bytes := 0;
   repeat
      for Car := 1 to Length( T )  do
      begin
         CdCarA := Ord( T[ Car ] );
         OfsCar := OfsCars + ( CdCarA * 8 ) + Bytes;
         ByteCar := Mem[ SegCars: OfsCar ];
         Bit := 128;
         for Bits := 0 to 7  do
         begin
            if ( ByteCar >= Bit ) then
            begin
               ByteCar := ByteCar - Bit;
               Cor := CF * 16 + CT;
               for ExtH := 1 to H  do
               begin
                  OfsV := OfsVideo( CXA, CYA );
                  Mem[ SegVideo: OfsV + 1 ]:= Cor;
                  Mem[ SegVideo: OfsV ] := CdCar;
                  CYA := CYA + 1;
               end;
            end
               else
            begin
               if ( Pch ) then
               begin
                  Cor := CT * 16 + CF;
                  for ExtH := 1 to H  do
                  begin
                     OfsV := OfsVideo( CXA, CYA );
                     Mem[ SegVideo: OfsV + 1 ] := Cor;
                     Mem[ SegVideo: OfsV ] := CdCar;
                     CYA := CYA + 1;
                  end;
               end
                  else
               begin
                  CYA := CYA + H;
               end;
            end;
            Bit := Bit DIV 2;
         end;
      end;
      CXA := CXA + 1;
      CYA := CY;
      ExtV := ExtV + 1;
      if ( ExtV = V ) then
      begin
         ExtV := 0;
         Bytes := Bytes + 1;
      end;
   until( Bytes = 8 );
end;
{============================================================================}
procedure EscvCars( CX, CY,Cp, Alt, CdCar, CT, CF: Byte );
var
   CadCars: string;
   C: Byte;
begin
   CadCars:='';
   for C := 1 to Cp  do CadCars := CadCars + Chr( CdCar ) +
    Chr( CF * 16 + CT );
   for CX := CX to CX + Alt - 1  do
   Move( CadCars[ 1 ], Mem[ SegVideo:OfsVideo( CX, CY ) ], Cp * 2 );
end;
{============================================================================}
end.
