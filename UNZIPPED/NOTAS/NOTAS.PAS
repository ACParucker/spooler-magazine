{============================================================================}
{                                                                            }
{   Notas                                                                    }
{   Versao 1.2                                                               }
{   1989, 1990                                                               }
{                                                                            }
{============================================================================}
program Notas;

{$M 8000,0,0}       { Stack, Low heap, High heap }
{$R+}               { Range checking }
{$S+}               { Stack checking }
{$I-}               { I/O checking }
{$F+}               { force far calls }
{$O-}               { Overlays allowed }
{$A-}               { Align data }
{$V+}               { var-string checking }
{$B+}               { Boolean evaluation }
{$N-}               { Numeric processing }
{$E+}               { Emulation }
{$D+}               { Debug information }
{$L-}               { Local symbols }

uses
   Crt,
   Texto, Teclado, Video;

const
   Gln = 20;
   GCol = 60;
   GCX = 4;
   GCY = 9;

   Cima = 1;
   Baixo = 3;
   Esq = 4;
   Dir = 2;

   CObj = 14;
   CG = 197;
   MaxNiv = 10;
   MaxQ = 50;

type
   TObj= record
      CX: Byte;
      CY: Byte;
   end;

   EstTiro=( Inactivo, Activo, Inicio );

   TDI= record
      CX: Byte;
      CY: Byte;
      Dir: Byte;
      Tiro: EstTiro;
      TCX: Byte;
      TCY: Byte;
      Car: Byte;
      Atr: Byte;
   end;

var
   Cores: record
      GCT: Byte;
      GCF: Byte;
      OCT: Byte;
      OCF: Byte;
      HCT: Byte;
      HCF: Byte;
      ICT: Byte;
      ICF: Byte;
      TCT: Byte;
      TCF: Byte;
      MCTA: Byte;
      MCFA: Byte;
      MCTD: Byte;
      MCFD: Byte;
      CT: Byte;
      CF: Byte;
   end;

   Cor: Boolean;
   CTec: Byte;

   hCX: Byte;
   hCY: Byte;

   HDir: Byte;
   HMorte: Boolean;
   Objs: Byte;
   DI: array [1..4] of TDI;

   DOb: array [1..MaxQ] of TObj;
   GObjs: array [1..Gln,1..GCol] of Boolean;

   Nivel: Byte;
   NQ: Byte;
   Vidas: Byte;
   Pontos: longint;
   Veloc: Byte;

{============================================================================}
procedure EscvHeroi;
var
   Car: Char;
begin
   case HDir of
      Cima: Car := Chr( 30 );
      Baixo: Car := Chr( 31 );
      Esq: Car := Chr( 17 );
      Dir: Car := Chr( 16 );
   end;
   TextColor( Cores.HCT );
   TextBackground( Cores.HCF );
   GotoXY( HCX, HCY );
   Write( Car );
end;
{============================================================================}
procedure VerifMorte;
var
   C, CA: word;
begin
   if ( ( Mem[SegVideo: OfsVideo( HCX, HCY ) ] in [ 24, 25, 26, 27 ] ) ) then
   begin
      HMorte := True;
      for CA := 205 downto 200 do
      for C := 1 to 4 do
      begin
         HDir := C;
         EscvHeroi;
         Sound( C * CA );
         Delay( 10 );
         NoSound;
      end;
   end;
end;
{============================================================================}
procedure ContHeroi;
var
   C: word;
   CodObj: Byte;
begin
   VerifMorte;
   if ( HMorte ) then Exit;
   CTec := 0;
   if ( KeyPressed ) then
   begin
      CTec:=LerTecla;
      if ( CTec = 0 ) then CTec := LerTecla;
   end;
   case CTec of
      CursorUp: HDir := Cima;
      Cursordown: HDir := Baixo;
      CursorLeft: HDir := Esq;
      CursorRight: HDir := Dir;
   end;
   TextColor( Cores.GCT );
   TextBackground( Cores.GCF );
   GotoXY( HCX, hCY );
   Write( Chr( CG ) );
   case ( HDir ) of
      Cima:
      begin
         hCX := hCX - 1;
         if ( hCX < GCX ) then hCX := GCX +Gln - 1;
      end;
      Baixo:
      begin
         hCX := hCX + 1;
         if ( hCX > GCX + Gln - 1 ) then hCX := GCX;
      end;
      Esq:
      begin
         hCY := hCY - 1;
         if ( hCY < GCY ) then hCY := GCY + GCol - 1;
      end;
      Dir:
      begin
         hCY := hCY + 1;
         if ( hCY > GCY + GCol - 1 ) then hCY := GCY;
      end;
   end;
   VerifMorte;
   if ( HMorte ) then Exit;
   CodObj := Mem[ SegVideo: OfsVideo( hCX, hCY ) ];
   EscvHeroi;
   for C:=100 to 300 do Sound( C * 2 );
   NoSound;
   if ( CodObj = CObj ) then
   begin
      Randomize;
      for C := 2000 downto 1500 do Sound( C * 2 );
      NoSound;
      GObjs[ hCX - GCX + 1, hCY - GCY + 1 ] := False;
      Objs := Objs - 1;
      TextColor( Cores.CT );
      TextBackground( Cores.CF );
      GotoXY( 0, 9 );
      Write( 'Objectos: ', Objs : 2 );
      Pontos := Pontos + Nivel * 100;
   end;
end;
{============================================================================}
procedure VerifTiro;
var
   C: Byte;
begin
   for C := 1 to 4 do
   if ( DI[C].Tiro = Inactivo ) then
   case ( C ) of
      Cima:
      begin
         if ( DI[C].CY = hCY ) then
         begin
            DI[C].Tiro := Inicio;
            DI[C].tCX := GCX;
            DI[C].tCY := hCY;
         end;
      end;
      Baixo:
      begin
         if ( DI[C].CY = hCY ) then
         begin
            DI[C].Tiro := Inicio;
            DI[C].tCX := GCX + Gln - 1;
            DI[C].tCY := hCY;
         end;
      end;
      Esq:
      begin
         if ( DI[C].CX = hCX ) then
         begin
            DI[C].Tiro := Inicio;
            DI[C].tCX := hCX;
            DI[C].tCY := GCY;
         end;
      end;
      Dir:
      begin
         if ( DI[C].CX = hCX ) then
         begin
            DI[C].Tiro := Inicio;
            DI[C].tCX := hCX;
            DI[C].tCY := GCY + GCol - 1;
         end;
      end;
   end;
end;
{============================================================================}
procedure ContTiros;
var
   C: Byte;
begin
{ Restaura caractere e atributo }
   for C := 4 downto 1 do
   begin
      if ( DI[C].Tiro = Activo ) then
      begin
         Mem[ SegVideo: OfsVideo( DI[C].tCX, DI[C].tCY ) ] := DI[C].Car;
         Mem[ SegVideo: OfsVideo( DI[C].tCX, DI[C].tCY ) + 1] := DI[C].Atr;
      end;
   end;

{ Incrementa coordenadas }
   for C := 1 to 4 do
   if ( DI[C].Tiro = Activo ) then
   case C of
      Cima:
      begin
         DI[C].tCX := DI[C].tCX + 1;
         if ( DI[C].tCX > GCX + Gln - 1 ) then DI[C].Tiro := Inactivo;
      end;
      Baixo:
      begin
         DI[C].tCX := DI[C].tCX - 1;
         if ( DI[C].tCX < GCX ) then DI[C].Tiro := Inactivo;
      end;
      Esq:
      begin
         DI[C].tCY := DI[C].tCY + 1;
         if ( DI[C].tCY > GCY + GCol - 1 ) then DI[C].Tiro := Inactivo;
      end;
      Dir:
      begin
         DI[C].tCY := DI[C].tCY - 1;
         if ( DI[C].tCY < GCY ) then DI[C].Tiro := Inactivo;
      end;
   end;

{ Inicializa os novos tiros }
   for C := 4 downto 1 do
   if ( DI[C].Tiro = Inicio ) then DI[C].Tiro := Activo;

{ Guarda caratere e atributo }
   for C := 1 to 4 do
   begin
      if ( DI[C].Tiro = Activo ) then
      begin
         DI[C].Car := Mem[ SegVideo: OfsVideo( DI[C].tCX, DI[C].tCY ) ];
         DI[C].Atr := Mem[ SegVideo: OfsVideo( DI[C].tCX, DI[C].tCY ) + 1 ];
      end;
   end;

{ Escreve os tiros }
   for C := 1 to 4 do
   begin
      if ( DI[C].Tiro = Activo ) then
      begin
         TextColor( Cores.TCT );
         TextBackground( Cores.TCF );
         GotoXY( DI[C].TCX, DI[C].TCY );
         case C of
            Cima: Write( Chr( 25 ) );
            Baixo: Write( Chr( 24 ) );
            Esq: Write( Chr( 26 ) );
            Dir: Write( Chr( 27 ) );
         end;
      end;
   end;
end;
{============================================================================}
procedure ContIni;
var
   C: Byte;
begin
   VerifTiro;
   ContTiros;
   for C:=1 to 4 do
   begin
      if ( DI[C].Tiro = Inactivo ) then
      begin
         TextColor( Cores.OCT );
         TextBackground( Cores.OCF );
         GotoXY( DI[C].CX, DI[C].CY );
         Write( ' ' );
         case C of
            Cima, Baixo:
            begin
               case DI[C].Dir of
                  Esq:
                  begin
                     DI[C].CY := DI[C].CY - 1;
                     if ( DI[C].CY < GCY ) then
                     begin
                        DI[C].CY := GCY;
                        DI[C].Dir := Dir;
                     end;
                  end;
                  Dir:
                  begin
                     DI[C].CY := DI[C].CY + 1;
                     if ( DI[C].CY > GCY + GCol - 1 ) then
                     begin
                        DI[C].CY := GCY + GCol - 1;
                        DI[C].Dir := Esq;
                     end;
                  end;
               end;
            end;
            Esq, Dir:
            begin
               case DI[C].Dir of
                  Cima:
                  begin
                     DI[C].CX := DI[C].CX - 1;
                     if ( DI[C].CX < GCX ) then
                     begin
                        DI[C].CX := GCX;
                        DI[C].Dir := Baixo;
                     end;
                  end;
                  Baixo:
                  begin
                     DI[C].CX := DI[C].CX + 1;
                     if ( DI[C].CX > GCX + Gln - 1 ) then
                     begin
                        DI[C].CX := GCX + Gln - 1;
                        DI[C].Dir := Cima;
                     end;
                  end;
               end;
            end;
         end;
         TextColor( Cores.ICT );
         TextBackground( Cores.ICF );
         GotoXY( DI[C].CX, DI[C].CY );
         Write( Chr( 2 ) );
      end;
   end;
end;
{============================================================================}
procedure AltObjs;
var
   Objt: Byte;
   D: Byte;
   OCX: Byte;
   OCY: Byte;
   CAlt: Byte;
begin
   CAlt:=1;
   while( CAlt < Nivel ) do
   begin
      if ( Random( MaxNiv + 10 - Nivel ) >= 5 ) then
      Exit;

      repeat
         Objt := Random( NQ ) + 1;
         OCX := DOb[ Objt ].CX;
         OCY := DOb[ Objt ].CY;
      until( GObjs[ OCX - GCX + 1, OCY - GCY + 1 ] );

      if ( Mem[ SegVideo: OfsVideo(  DOb[Objt].CX,
           DOb[Objt].CY ) ] = CObj ) then
      begin
         repeat
            OCX := DOb[Objt].CX;
            OCY := DOb[Objt].CY;
            D:=Random( 4 ) + 1;
            case D of
               Cima: OCX:=OCX-1;
               Baixo: OCX:=OCX+1;
               Esq: OCY:=OCY-1;
               Dir: OCY:=OCY+1;
            end;
         until( (OCX >= GCX) and (OCX <= GCX + Gln - 1) and
                (OCY >= GCY) and (OCY <= GCY + GCol - 1) );

         if ( Mem[ SegVideo: OfsVideo( OCX, OCY ) ] <> CG ) then
         begin
            Delay( 5 );
            Exit;
         end;

         TextColor( Cores.GCT );
         TextBackground( Cores.GCF );
         GotoXY( DOb[Objt].CX, DOb[Objt].CY );
         Write( Chr( CG ) );
         GObjs[ DOb[Objt].CX - GCX + 1, DOb[Objt].CY - GCY + 1 ] := False;
         DOb[Objt].CX := OCX;
         DOb[Objt].CY := OCY;
         GObjs[ DOb[Objt].CX - GCX + 1, DOb[Objt].CY - GCY + 1 ] := True;
         TextColor( Cores.OCT );
         TextBackground( Cores.OCF );
         GotoXY( DOb[Objt].CX, DOb[Objt].CY );
         Write( Chr(CObj) );
         CAlt := CAlt + 1;
      end;
   end;
end;
{============================================================================}
procedure Entrar;
var
   C: Byte;
begin
   LimparBufferT;
   repeat
      for C := 1 to NQ do
      begin
         TextColor( Cores.GCT );
         TextBackground( Cores.GCF );
         GotoXY( DOb[C].CX, DOb[C].CY );
         Write( Chr( CG ) );
      end;
      Delay( 100 );
      for C := 1 to NQ do
      begin
         TextColor( Cores.OCT );
         TextBackground( Cores.OCF );
         GotoXY( DOb[C].CX, DOb[C].CY );
         Write( Chr( CObj ) );
      end;
      Delay(100);
   until( keypressed );
 end;
{============================================================================}
procedure Ecran;
var
   C: Byte;
   CA: Byte;
   CQuad: string[ 2 ];
begin
   EscvCars( GCX - 1, GCY - 1, GCol+2, Gln+2, 32, Cores.GCT, Cores.GCF );
   Str( NQ, CQuad);
   if ( NQ < 10 ) then CQuad := '0' + CQuad;
   for CA:=1 to 3 do
   for C:=176 to 178 do
   begin
      EscvExp( 9, 9, 1, 1, C, False, 'Quadro' + CQuad, Cores.CT, Cores.CF );
      Delay( 50 );
   end;
   EscvExp( 9, 9, 1, 1, C, False, 'Quadro' + CQuad, 0, 0 );
   EscvCars( GCX, GCY, GCol, Gln, CG, Cores.GCT, Cores.GCF );
   TextColor( Cores.CT );
   TextBackground( Cores.CF );
   GotoXY( 0, 9 );
   Write( 'Objectos: ',Objs : 2 );
   GotoXY( 0, 32 );
   Write( 'Vidas: ',Vidas : 2 );
   GotoXY( 0, 51 );
   Write( 'Pontos: ',Pontos : 10 );
   for C:=1 to NQ do
   begin
      TextColor( Cores.OCT );
      TextBackground( Cores.OCF );
      GotoXY( DOb[C].CX, DOb[C].CY );
      Write( Chr( CObj ) );
   end;
   for C:=1 to 4 do
   begin
      TextColor( Cores.OCT );
      TextBackground( Cores.OCF );
      GotoXY( DI[C].CX, DI[C].CY );
      Write( Chr( 2 ) );
   end;
   EscvHeroi;
end;
{============================================================================}
procedure IDadosQuadro;
var
   Ln: Byte;
   Col: Byte;
   C: Byte;
begin
   Objs := NQ;
   hCX := GCX + 10;
   hCY := GCY + 20;
   HDir := Random( 3 ) + 1;
   DI[ Cima ].CX := GCX - 1;
   DI[ Cima ].CY := GCY;
   DI[ Cima ].Dir := Dir;
   DI[ Cima ].Tiro := Inactivo;
   DI[ Baixo ].CX := GCX + Gln;
   DI[ Baixo ].CY := GCY + GCol - 1;
   DI[ Baixo ].Dir := Esq;
   DI[ Baixo ].Tiro := Inactivo;
   DI[ Esq ].CX := GCX + Gln - 1;
   DI[ Esq ].CY := GCY - 1;
   DI[ Esq ].Dir := Cima;
   DI[ Esq ].Tiro := Inactivo;
   DI[ Dir ].CX := GCX;
   DI[ Dir ].CY := GCY + GCol;
   DI[ Dir ].Dir := Baixo;
   DI[ Dir ].Tiro := Inactivo;
   for Ln := 1 to Gln do
   for Col := 1 to GCol do
   begin
      GObjs[ Ln, Col ] := False;
   end;
   for C := 1 to NQ do
   begin
      GObjs[ DOb[ C ].CX - GCX + 1, DOb[ C ].CY - GCY + 1 ] := True;
   end;
end;
{============================================================================}
procedure IQuadro;
var
   C: Byte;
   CA: Byte;
begin
   Randomize;
   for C:=1 to NQ do
   begin
      repeat
         DOb[C].CX := Random( Gln ) + GCX;
         DOb[C].CY := Random( GCol ) + GCY;
         for CA := 1 to C - 1 do
         if ( (DOb[CA].CX = DOb[C].CX) and ( DOb[CA].CY = DOb[C].CY ) ) then
          DOb[C].CX:=0;
      until( ( DOb[C].CX <> 0 ) and
       not ( ( hCX = DOb[C].CX ) and ( hCY = DOb[C].CY ) ) );
   end;
   IDadosQuadro;
   Ecran;
end;
{============================================================================}
procedure ReIQuadro;
begin
   IDadosQuadro;
   Ecran;
end;
{============================================================================}
procedure EscolherNivel;
var
   Texto: string [2];
   CTec: Byte;
begin
   TextBackground( Cores.CF );
   ClrScr;
   TextColor( 15 );
   GotoXY( 22, 15 );
   Write( 'Use as teclas Cima e Baixo para seleccionar Nivel' );
   Nivel := 1;
   repeat
      Str( Nivel, Texto );
      if( Nivel < 10 ) then Texto := '0' + Texto;
      EscvExp( 6, 25, 2, 2, ord('Û'), True, Texto, 3, 0 );
      repeat
         CTec := LerTecla;
      until ( CTec in [ Enter, CursorUp, Cursordown ] );
      case CTec of
         Cursordown: Nivel := Nivel + 1;
         CursorUp: Nivel := Nivel - 1;
      end;
      Sound( Nivel * 100 );
      Delay( 5 );
      NoSound;
      if ( Nivel < 1 ) then Nivel := MaxNiv;
      if ( Nivel > MaxNiv ) then Nivel := 1;
   until( CTec = Enter );
end;
{============================================================================}
procedure Jogar;
var
   FimJ: Boolean;
begin
   EscolherNivel;
   TextColor( Cores.CT );
   TextBackground( Cores.CF );
   ClrScr;
   Vidas := 6;
   Pontos := 0;
   FimJ := False;
   HMorte:=False;
   NQ := 1;
   repeat
      if ( not HMorte ) then
         IQuadro
      else
         ReIQuadro;
      Entrar;
      HMorte := False;
      repeat
         AltObjs;
         Contini;
         ContHeroi;
      Delay( ( Veloc - 1 ) * 20 );
      Delay( 20 + ( MaxNiv - Nivel ) * 2 );
         Pontos := Pontos + Nivel;
         TextColor( Cores.CT );
         TextBackground( Cores.CF );
         GotoXY( 0, 51 );
         Write( 'Pontos: ', Pontos : 10 );
      until( ( CTec = Esc ) or ( Objs = 0 ) or ( HMorte ) );
      if ( HMorte ) then
      begin
         Vidas := Vidas - 1;
         TextColor( Cores.CT );
         TextBackground( Cores.CF );
         GotoXY( 0, 32 );
         Write( 'Vidas: ', Vidas : 2 );
         if( Vidas = 0 ) then FimJ := True;
      end;
      if ( CTec = Esc ) then FimJ := True;
      if ( Objs = 0 ) then NQ := NQ + 1;
      if ( NQ > MaxQ ) then FimJ := True;
   until( FimJ );
   if ( Vidas = 0 ) then
    EscvExp( 6, 6, 1,2, ord('²'), False, 'Game Over', Cores.CT, Cores.CF );
   if ( NQ > MaxQ ) then
    EscvExp( 6, 15, 1,2, ord('±'), False, 'The end', Cores.CT, Cores.CF );
   if ( CTec <> Esc ) then Delay( 2000 );
end;
{============================================================================}
procedure QMenu;
begin
   TextColor( 11 );
   GotoXY( 24, 21 );
   Write(' (S) 1989 /\/\/-\[ ) Software. ');
   TextBackground( Cores.MCFa );
   TextColor( Cores.MCTa );
   GotoXY( 19, 31 );
   Write(' J');
   TextColor( Cores.MCTd );
   Write( 'ogar ' );
   TextColor( Cores.MCTa );
   Write( 'F' );
   TextColor( Cores.MCTd );
   Write( 'im ' );
end;
{============================================================================}
procedure EscvTitulo;
const
   Dados: array [1..5,1..3] of Byte=
   ( ( 3, 16, ord( 'N' ) ),
     ( 3, 26, ord( 'O' ) ),
     ( 3, 36, ord( 'T' ) ),
     ( 3, 46, ord( 'A' ) ),
     ( 3, 56, ord( 'S' ) ) );
var
   CT: Byte;
   C: Byte;
begin
   repeat
      for C:=1 to 5 do
      begin
         if ( Cor ) then
         CT := Random( 14 ) + 1
            else
         CT := 15;
         EscvExp( Dados[ C, 1 ], Dados[ C, 2 ], 1, 2, ord('Û'), False,
          Chr( Dados[ C, 3 ] ), CT, 0);
         Delay( 5 );
      end;
   until( KeyPressed );
end;
{============================================================================}
procedure Menu;
var
   Tec: Char;
   FimPrg: Boolean;
begin
   FimPrg:=False;
   repeat
      TextColor( Preto );
      TextBackground( Preto );
      ClrScr;
      QMenu;
      EscvTitulo;
      repeat
         if ( Cor ) then EscvTitulo;
         Tec := ReadKey;
      until( Tec in [ 'j', 'J', 'f', 'F' ] );
      Tec := Upcase( Tec );
      case Tec of
        'J': Jogar;
        'F': FimPrg:=True;
      end;
   until( FimPrg );
end;
{============================================================================}
procedure Ivar;
begin
   if ( AdaptVideo = AdaptMono ) then
      Cor := False
   else
      Cor := True;
   if ( Cor ) then
   begin
      Cores.GCT := Azul;
      Cores.GCF := Preto;
      Cores.OCT := Branco;
      Cores.OCF := Preto;
      Cores.HCT := Amarelo;
      Cores.HCF := Preto;
      Cores.ICT := CiaoClaro;
      Cores.ICF := Preto;
      Cores.TCT := MagentaClaro;
      Cores.TCF := Preto;
      Cores.MCTA := Branco;
      Cores.MCFA := Verde;
      Cores.MCTD := CinzentoClaro;
      Cores.MCFD := Verde;
      Cores.CT := Amarelo;
      Cores.CF := Preto;
   end else
   begin
      Cores.GCT :=7;
      Cores.GCF :=0;
      Cores.OCT :=15;
      Cores.OCF :=0;
      Cores.HCT :=15;
      Cores.HCF :=0;
      Cores.ICT :=15;
      Cores.ICF :=0;
      Cores.TCT :=15;
      Cores.TCF :=0;
      Cores.MCTA :=15;
      Cores.MCFA :=0;
      Cores.MCTD :=7;
      Cores.MCFD :=0;
      Cores.CT :=7;
      Cores.CF :=0;
   end;
end;
{============================================================================}
procedure VerifParametro;
var
   Est: integer;
begin
   Val( ParamStr( 1 ), Veloc, Est );
   if ( Est <> 0 ) or
      ( ( Est = 0 ) and ( ( Veloc < 1 ) or ( Veloc > 5 ) ) ) then
   begin
      TextColor( 15 );
      Write( 'NOTAS Velocidade ( 1 = Rapido, 5 = Lento )' );
      TextColor( 7 );
      Halt;
   end;
end;
{============================================================================}
begin
   VerifParametro;
   EscondCursor;
   TextColor( Preto );
   TextBackground( Preto );
   ClrScr;
   Ivar;
   Menu;
   MostCursor;
   TextColor( CinzentoClaro );
   TextBackground( Preto );
   ClrScr;
end.
