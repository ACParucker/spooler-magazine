unit M256;

interface

uses dos;

const
      on = true;     { para uso com sobrep, tapa, etc. }
      off  = false;

type tipo_fonte = array[20..127, 1..8] of string[9];
     tipo_cor = record
                  verm, verde, azul : byte
                end;
     tip_pal = array[0..255] of tipo_cor;


var acor,
    sobre, altcar, fund : byte;
    apa : boolean;
    xlim, ylim, xliminf, yliminf : word;
    fonte : tipo_fonte;


{$S-}

    procedure mmcga;
    procedure mini;
    procedure ligacor         (cor : byte);

    procedure fundo           (cor : byte);
    procedure ponto           (x, y : word);
    function getponto        (x, y : word) : byte;
    procedure rectaASM        (x, y, x1, y1 : word);
    procedure recta           (x, y, x1, y1 : integer);
    procedure rectangulo      (x, y, x1, y1 : word);
    procedure circulo         (x1, y1, raio : word);
    procedure bar             (x, y, x1, y1 : word);
    procedure derrama         (x, y : word; ecor, bcor : byte);
    procedure sobrep          (s : boolean);

    procedure poetexto        (x, y : word; txt : string);
    procedure tapa            (t : boolean; tcor : byte);
    procedure fonte_duplex;
    procedure fonte_omissao;

    procedure ligapal         (pal : tip_pal);
    procedure paleteA         (var pal : tip_pal);
    procedure paleteB         (var pal : tip_pal);
    procedure pciclo          (var pal : tip_pal);
    procedure ligaporto       (x, y, x1, y1 : word);

    function str_            (arg : integer) : string;
    function str__           (arg : word) : string;



implementation

    procedure ligacor;
    begin
         acor := cor
    end;

    procedure sobrep;
    begin
         if s then sobre := 0 else sobre := 255
    end;

    procedure tapa;
    begin
         if t then apa := on else apa := off;
         fund := tcor
    end;

    {$W-}
    procedure mmcga;assembler;
  { Coloca em modo gr fico MCGA 320x200 256 cores. }
    asm
              mov     al, 0         { Fun‡„o "alerar modo de imagem" }
              mov     ax, 19        { Modo 19 - 320x200 256 Cores }
              int     10h           { Chamar interrup‡„o }
    end;

    procedure ponto;assembler;
  { Coloca um ponto nas coords x, y com a cor cor }
    asm
                 MOV     CX, y
                 ADD     CX, yliminf { somar limite inferior de porto }
                 MOV     DX, x
                 ADD     DX, xliminf { somar limite inferior de porto }
                 MOV     AX, ylim    { Testar se coord y fora do limite }
                 CMP     AX, CX
                 JC      @sair       { Sair, se fora do limite (y < ylim) }

                 MOV     AX, xlim    { Testar se coord x fora do limite }
                 CMP     AX, DX
                 JC      @sair       { Sair, se fora do limite (x < xlim) }
           { Multiplicar y por 320 (y * 320 = y * 256  +  y * 64) }
                 MOV     AX, CX      { y para AX }
                 SHL     AX, 8       { Multiplicar por 256 }
                 SHL     CX, 6       { Mulitplicar por 64 }
                 ADD     CX, AX      { Somar os 2 valores }
           { At‚ aqui: CX = y * 320 }
                 ADD     CX, DX      { Somar DX a CX. Agora CX = y * 320 + x }
           { At‚ aqui: CX = y * 320 + x }
                 MOV     AX, 0A000h  { Endere‡o base da mem¢ria de imagem }
                 MOV     ES, AX      { Copiar seg AX para ES }
           { At‚ aqui: ES = SEG do endere‡o do ponto na mem¢ria de imagem }
                 MOV     SI, CX      { Copiar para DI o ofset do endere‡o do
                                        ponto (x,y) no ecran }
           { At‚ aqui: ES = seg, SI = ofs do endere‡o do ponto na mem¢ria
             de imagem }
                 MOV     AL, acor    { Byte cor para AL }
                 MOV     AH, sobre
                 CMP     AH, $FF     { Testar a flag para saber se impress„o }
                 JZ      @naoxor     { com XOR. }
                 MOV     AL, [ES:SI] { Obter o ponto do ecran }
                 XOR     AL, acor    { Ponto do ecran XOR ponto a colocar }

      @naoxor:   MOV     [ES:SI], AL { Byte cor para o ecran, fazendo o ponto }
        @sair:                       { visivel }
    end;

    function getponto;assembler;
 { Devolve a cor da posi‡„o x, y do ecran }
    asm
                 MOV     CX, y
                 ADD     CX, yliminf
                 MOV     DX, x
                 ADD     DX, xliminf
                 MOV     AX, CX      { C lculos identicos aos do    }
                 SHL     AX, 8       { procedimento anterior        }
                 SHL     CX, 6
                 ADD     CX, AX
                 ADD     CX, DX
                 MOV     AX, 0A000h
                 MOV     ES, AX
                 MOV     SI, CX
           { Obter o byte do endere‡o da posi‡„o (x,y) do ecran }
                 MOV     AH, 0        { Zerar o byte alto de AX }
                 MOV     AL, [ES:SI]  { Obt‚m o valor do ponto }
    end;

    procedure fundo;assembler;
  { Coloca a cor corfundo em todo o ecran (apagando tudo) }
    asm
                 MOV     AX, 0A000h   { Inicializar seg da area de imagem }
                 MOV     ES, AX       { Seg para ES }
                 MOV     SI, 64002    { Inicializar ofs/contador }
                 MOV     AL, cor      { Cor do fundo para AX }
                 MOV     AH, AL

       @pbyte:   DEC     SI           { Decrementar 2 pontos (2 pos de mem) }
                 DEC     SI           { ... }
                 MOV     [ES:SI], AX  { "Pintar" 2 pontos consecutivos }
                 JNZ     @pbyte       { Se SI n„o ‚ 0, pr¢ximo byte }
    end;

   procedure rectaASM;assembler;
 { Desenha uma recta da posi‡„o (x, y) … posi‡„o (x1, y1) }
   var xd, dy, ddx, ddy, l, b : word;
   asm
               PUSH    x
               PUSH    y
               CALL    ponto
               MOV     AX, x1
               SUB     AX, x
               JNC     @naonega1
               NEG     AX             { Negativo }
               MOV     BX, -1h
               JMP     @guarda1

   @naonega1:  MOV     BX, 01h
    @guarda1:  MOV     xd, BX
               MOV     x1, AX

               MOV     AX, y1
               SUB     AX, y
               JNC     @naonega2
               NEG     AX
               MOV     BX, -1h
               JMP     @guarda2

   @naonega2:  MOV     BX, 01h
    @guarda2:  MOV     dy, BX
               MOV     y1, AX

               CMP     AX, x1         { x1 >= y1? }
               JC      @op1
               JZ      @op1

               MOV     b, AX          { b = y1 }
               MOV     AX, x1
               MOV     l, AX          { l = x1 }
               XOR     AX, AX
               MOV     ddx, AX        { ddx = 0 }
               MOV     AX, dy
               MOV     ddy, AX        { ddy = dy }
               JMP     @calc

        @op1:  OR      AX, x1         { x1 + y1 = 0? }
               JZ      @fim

               MOV     AX, y1
               MOV     l, AX          { l = y1 }
               MOV     AX, x1
               MOV     b, AX          { b = x1 }
               XOR     AX, AX
               MOV     ddy, AX        { ddy = 0 }
               MOV     AX, xd
               MOV     ddx, AX        { ddx = xd }

       @calc:  MOV     SI, b
               MOV     BX, SI
               SHR     SI, 1

      @ciclo:  ADD     SI, l
               CMP     SI, b
               JC      @dd
               SUB     SI, b
               MOV     CX, dy
               MOV     DX, xd
               JMP     @pponto

         @dd:  MOV     CX, ddy
               MOV     DX, ddx


     @pponto:  OR      DX, DX       { DX = 0? }
               JZ      @ok1
               DEC     DX           { DX = 1? }
               JNZ     @nega1
               INC     x
               JMP     @ok1

      @nega1:  DEC     x

        @ok1:  MOV     DX, x        { DX = x }

               OR      CX, CX
               JZ      @ok2
               DEC     CX
               JNZ     @nega2
               INC     y
               JMP     @ok2

      @nega2:  DEC     y

        @ok2:  MOV     CX, y        { CX = y }

    { PONTO }
               PUSH    SI

               ADD     CX, yliminf
               ADD     DX, xliminf

               MOV     AX, ylim
               CMP     AX, CX
               JC      @fim

               MOV     AX, xlim
               CMP     AX, DX
               JC      @fim

               MOV     AX, CX
               SHL     CX, 8
               SHL     AX, 6
               ADD     CX, AX
               ADD     CX, DX

               MOV     AX, 0A000h
               MOV     ES, AX
               MOV     SI, CX

               MOV     AL, acor     { Byte cor para AL }
               MOV     AH, sobre
               CMP     AH, $FF      { Testar flag para saber se ponto com XOR }
               JZ      @naoxor
               MOV     AL, [ES:SI]
               XOR     AL, acor

     @naoxor:  MOV     [ES:SI], AL

               POP     SI
{ END PONTO }

               DEC     BX
               JNZ     @ciclo

        @fim:
   end;
   {$W+}


    procedure rectangulo;assembler;
    var aux, auy : word;
    asm
               JMP     @inicio


       @pixel: PUSH    AX
               MOV     CX, AX
               MOV     DX, BX

     { PONTO } ADD     CX, yliminf
               ADD     DX, xliminf
               MOV     AX, ylim
               CMP     AX, CX
               JC      @fip
               MOV     AX, xlim
               CMP     AX, DX
               JC      @fip
               MOV     AX, CX
               SHL     CX, 8
               SHL     AX, 6
               ADD     CX, AX
               ADD     CX, DX
               MOV     AX, 0A000h
               MOV     ES, AX
               MOV     SI, CX
               MOV     AL, acor
               MOV     AH, sobre
               CMP     AH, $FF
               JZ      @naoxor
               MOV     AL, [ES:SI]
               XOR     AL, acor
     @naoxor:  MOV     [ES:SI], AL
        @fip:  POP     AX
               RETN



     @inicio:  MOV     AX, x
               MOV     aux, AX
               MOV     AX, y
               MOV     auy, AX

               MOV     BX, y1
               CMP     BX, y
               JNC     @ok
               MOV     AX, y
               MOV     y, BX
               MOV     BX, AX
               MOV     y1, BX

         @ok:  MOV     AX, x1
               CMP     AX, x
               JNC     @ok1
               MOV     BX, x
               MOV     x, AX
               MOV     AX, BX
               MOV     x1, AX

        @ok1:  INC     x1
               INC     y1

               MOV     AX, y
               MOV     BX, x

       @ppix:  CALL    @pixel
               INC     BX
               CMP     BX, x1
               JC      @ppix
               DEC     BX

      @ppix1:  CALL    @pixel
               INC     AX
               CMP     AX, y1
               JC      @ppix1
               DEC     AX

      @ppix2:  CALL    @pixel
               DEC     BX
               CMP     BX, aux
               JNC     @ppix2
               INC     BX

      @ppix3:  CALL    @pixel
               DEC     AX
               CMP     AX, auy
               JNC     @ppix3

               POP     SP
    end;


    procedure bar;assembler;
    asm
                   MOV     BX, y1
                   CMP     BX, y
                   JNC     @ok
                   MOV     AX, y
                   MOV     y, BX
                   MOV     BX, AX
                   MOV     y1, BX

             @ok:  MOV     AX, x1
                   CMP     AX, x
                   JNC     @ok1
                   MOV     BX, x
                   MOV     x, AX
                   MOV     AX, BX
                   MOV     x1, AX

                   INC     x1
                   INC     y1

            @ok1:  MOV     BX, y

         @plinha:  MOV     AX, x

         @pponto:  MOV     CX, BX
                   MOV     DX, AX
                   PUSH    AX

         { PONTO } ADD     CX, yliminf
                   ADD     DX, xliminf
                   MOV     AX, ylim
                   CMP     AX, CX
                   JC      @fimp
                   MOV     AX, xlim
                   CMP     AX, DX
                   JC      @fimp
                   MOV     AX, CX
                   SHL     CX, 8
                   SHL     AX, 6
                   ADD     CX, AX
                   ADD     CX, DX
                   MOV     AX, 0A000h
                   MOV     ES, AX
                   MOV     SI, CX
                   MOV     AL, acor
                   MOV     AH, sobre
                   CMP     AH, $FF
                   JZ      @naoxor
                   MOV     AL, [ES:SI]
                   XOR     AL, acor
         @naoxor:  MOV     [ES:SI], AL

           @fimp:  POP     AX

                   INC     AX
                   CMP     AX, x1
                   JC      @pponto

                   INC     BX
                   CMP     BX, y1
                   JC      @plinha
    end;

    procedure recta;
  { Desenha uma recta da posi‡„o (x, y) … posi‡„o (x1, y1), com a cor cor }
    var
       dx, dy, ddx, ddy : shortint;
       b, i, l, ix, iy, cont : word;

    begin
         ponto (x, y);
         x1 := x1 - x;
         y1 := y1 - y;

         if x1 > 0 then dx := 1 else dx := -1;
         if y1 > 0 then dy := 1 else dy := -1;

         x1 := abs(x1);
         y1 := abs(y1);

         if x1 >= y1 then
            begin
              if x1 + y1 = 0 then exit;
              l := y1;
              b := x1;
              ddx := dx;
              ddy := 0
            end
         else
            begin
              l := x1;
              b := y1;
              ddx := 0;
              ddy := dy
            end;

         i := b shr 1;   { i := b div 2 }

         for cont := b downto 1 do
         begin
              i := i + l;
              if i < b then begin
                  ix := ddx;
                  iy := ddy
                end
              else begin
                  dec(i, b);
                  ix := dx;
                  iy := dy
                end;

              inc(y, iy);
              inc(x, ix);
              ponto (x, y)
         end

    end;


    procedure circulo;
    const c12 = 2 * pi /  36;  { 2*pi/36 o circulo ‚ formado por 36 rectas. }
    var                       { para alterar o n§ de rectas, basta substituir }
      m0, z : real;           { o 36 pelo n§ de rectas desejadas }
      rx, ry, rx1, ry1 : word;
      arcos : byte;

    begin
         arcos := {}37{}; { ‚ preciso substituir tamb‚m este n§, o 37, que }
         m0 := raio * 1.2; { dever  ser o n§ de arcos + 1. Neste caso, 36+1=37  }
         rx1 := x1 + round(m0);
         ry1 := y1;
         z := 0;
         repeat
            rx := x1 + round(m0 * cos(z));
            ry := y1 + round(raio * sin(z));
            recta (rx1, ry1, rx, ry);
            rx1 := rx;
            ry1 := ry;
            z := z + c12;
            dec (arcos)
         until arcos = 0
    end;



procedure derrama;
const aa = 500;
var p1, p2, px, py, t, s, d, pon : integer;
    qx, qy : array[1..aa] of integer;
begin
     acor := ecor;
     p1 := 1;                    p2 := 2;
     qx[1] := x;                 qy[1] := y;
     repeat
         for d := 1 to 4 do
         begin
             case d of
                  1 : begin  t := -1;  s := 0   end;
                  2 : begin  t := 0;   s := 1   end;
                  3 : begin  t := 1;   s := 0   end;
                  4 : begin  t := 0;   s := -1  end
             end;
             px := qx[p1] + t;       py := qy[p1] + s;
             pon := getponto(px, py);
             if (pon <> bcor) and (pon <> acor) and
                (px <= xlim) and (py <= ylim) and
                (px >= 0) and (py >= 0) then
               begin
                  ponto(px, py);
                  qx[p2] := px;         qy[p2] := py;
                  inc(p2);
                  if p2 > aa then p2 := 1
               end
         end;
         inc (p1);
         if (p1 > aa) then p1 := 1
     until p2 = p1
end;


function str_;
var st : string;
begin
     str(arg, st);
     str_ := st
end;

function str__;
var st : string;
begin
     str(arg, st);
     str__ := st
end;


procedure ligapal;
var reg : registers;
begin
     with Reg do
          begin
               AX := $1012;
               BX := 0;
               CX := 256;
               ES := seg(pal);
               DX := ofs(pal)
          end;
     intr($10, reg);
end;

procedure paletea;
var i : byte;
begin
     for i := 0 to 63 do     { Cinzento 0-63 }
         begin
              pal[i].verm := i;
              pal[i].verde := i;
              pal[i].azul := i
         end;
     for i := 64 to 127 do     {Vermelho 0-63}
         begin
              pal[i].verm := i - 64;
              pal[i].verde := 0;
              pal[i].azul := 0
         end;
     for i := 128 to 191 do     {Verde 0-63}
         begin
              pal[i].verm := 0;
              pal[i].verde := i - 128;
              pal[i].azul := 0
         end;
     for i := 192 to 255 do     {Azul 0-63}
         begin
              pal[i].verm := 0;
              pal[i].verde := 0;
              pal[i].azul := i - 192
         end
end;

procedure paleteB (var pal : tip_pal);
var i : byte;
begin
     for i := 0 to 35 do     { azul }
         begin
              pal[i].verm := 0;
              pal[i].verde := 0;
              pal[i].azul := round ((i + 28) * 1.8)
         end;
     for i := 36 to 71 do     { verde }
         begin
              pal[i].verm := 0;
              pal[i].verde := round ((i - 8) * 1.8);
              pal[i].azul := 0
         end;
     for i := 72 to 107 do     { cian }
         begin
              pal[i].verm := 0;
              pal[i].verde := round ((i - 44) * 1.8);
              pal[i].azul := round ((i - 44) * 1.8)
         end;
     for i := 108 to 143 do     { vermelho }
         begin
              pal[i].verm := round ((i - 80) * 1.8);
              pal[i].verde := 0;
              pal[i].azul := 0
         end;
     for i := 144 to 179 do     { magenta }
         begin
              pal[i].verm := round ((i - 116) * 1.8);
              pal[i].verde := 0;
              pal[i].azul := round ((i - 116) * 1.8)
         end;
     for i := 180 to 215 do     { marrom }
         begin
              pal[i].verm := round ((i - 152) * 1.8);
              pal[i].verde := round ((i - 152) * 1.8);
              pal[i].azul := 0
         end;
     for i := 216 to 251 do     { cinzento }
         begin
              pal[i].verm := round ((i - 188) * 1.8);
              pal[i].verde := round ((i - 188) * 1.8);
              pal[i].azul := round ((i - 188) * 1.8)
         end
end;

procedure pciclo (var pal : tip_pal);
var i : byte;
    tem : tipo_cor;
begin
     tem := pal[0];
     for i := 1 to 255 do
         pal[i-1] := pal[i];
     pal[255] := tem;
     ligapal (pal)
end;



  procedure ligaporto;
  begin
     if (x > 319) or (y > 199) then exit;
     xliminf := x;
     xlim := x1;
     yliminf := y;
     ylim := y1
  end;

    procedure mini;
    begin
         mmcga;
         sobrep(off);
         acor := 15;
         ligaporto(0, 0, 319, 199);
         altcar := 8;
         tapa(off, 0);
         fonte_omissao
    end;



(***************************************************************************)
(***********************************TEXTO***********************************)
(***************************************************************************)
procedure fonte_duplex;
const ux = 1;
begin
     fonte[32, ux]   := '   ';     fonte[46, ux]   := '   ';  fonte[63, ux]   := ' 0000  ';
     fonte[32, ux+1] := '   ';     fonte[46, ux+1] := '   ';  fonte[63, ux+1] := '000000 ';
     fonte[32, ux+2] := '   ';     fonte[46, ux+2] := '   ';  fonte[63, ux+2] := '00  00 ';
     fonte[32, ux+3] := '   ';     fonte[46, ux+3] := '   ';  fonte[63, ux+3] := '   00  ';
     fonte[32, ux+4] := '   ';     fonte[46, ux+4] := '   ';  fonte[63, ux+4] := '  00   ';
     fonte[32, ux+5] := '   ';     fonte[46, ux+5] := '   ';  fonte[63, ux+5] := '  00   ';
     fonte[32, ux+6] := '   ';     fonte[46, ux+6] := '00 ';  fonte[63, ux+6] := '       ';
     fonte[32, ux+7] := '   ';     fonte[46, ux+7] := '00 ';  fonte[63, ux+7] := '  00   ';

   {            0                                      1                            2                           3   }
     fonte[48, ux]   := ' 00000  ';fonte[49, ux]   := '  00   ';fonte[50, ux]   := ' 00000  ';fonte[51, ux]   := '000000  ';
     fonte[48, ux+1] := '0000000 ';fonte[49, ux+1] := ' 000   ';fonte[50, ux+1] := '0000000 ';fonte[51, ux+1] := '0000000 ';
     fonte[48, ux+2] := '00  000 ';fonte[49, ux+2] := '0000   ';fonte[50, ux+2] := '00  000 ';fonte[51, ux+2] := '     00 ';
     fonte[48, ux+3] := '00 0 00 ';fonte[49, ux+3] := '  00   ';fonte[50, ux+3] := '   000  ';fonte[51, ux+3] := ' 00000  ';
     fonte[48, ux+4] := '00 0 00 ';fonte[49, ux+4] := '  00   ';fonte[50, ux+4] := ' 000    ';fonte[51, ux+4] := ' 00000  ';
     fonte[48, ux+5] := '000  00 ';fonte[49, ux+5] := '  00   ';fonte[50, ux+5] := '000     ';fonte[51, ux+5] := '     00 ';
     fonte[48, ux+6] := '0000000 ';fonte[49, ux+6] := '000000 ';fonte[50, ux+6] := '0000000 ';fonte[51, ux+6] := '0000000 ';
     fonte[48, ux+7] := ' 00000  ';fonte[49, ux+7] := '000000 ';fonte[50, ux+7] := '0000000 ';fonte[51, ux+7] := '000000  ';

   {                   4                              5                               6                           7   }
     fonte[52, ux]   := '    000 ';fonte[53, ux]   := '0000000 ';fonte[54, ux]   := '0000000 ';fonte[55, ux]   := '0000000 ';
     fonte[52, ux+1] := '  00000 ';fonte[53, ux+1] := '0000000 ';fonte[54, ux+1] := '0000000 ';fonte[55, ux+1] := '0000000 ';
     fonte[52, ux+2] := ' 00  00 ';fonte[53, ux+2] := '00      ';fonte[54, ux+2] := '00      ';fonte[55, ux+2] := '    00  ';
     fonte[52, ux+3] := '00   00 ';fonte[53, ux+3] := '0000000 ';fonte[54, ux+3] := '0000000 ';fonte[55, ux+3] := '   00   ';
     fonte[52, ux+4] := '0000000 ';fonte[53, ux+4] := '0000000 ';fonte[54, ux+4] := '0000000 ';fonte[55, ux+4] := '   00   ';
     fonte[52, ux+5] := '0000000 ';fonte[53, ux+5] := '     00 ';fonte[54, ux+5] := '00   00 ';fonte[55, ux+5] := '  00    ';
     fonte[52, ux+6] := '     00 ';fonte[53, ux+6] := '0000000 ';fonte[54, ux+6] := '0000000 ';fonte[55, ux+6] := ' 00     ';
     fonte[52, ux+7] := '     00 ';fonte[53, ux+7] := '000000  ';fonte[54, ux+7] := '0000000 ';fonte[55, ux+7] := ' 00     ';

   {                     8                           9                                :                           ; }
     fonte[56, ux]   := ' 00000  ';fonte[57, ux]   := '000000 ';fonte[58, ux]   := '    ';fonte[59, ux]   := '     ';
     fonte[56, ux+1] := '0000000 ';fonte[57, ux+1] := '000000 ';fonte[58, ux+1] := '    ';fonte[59, ux+1] := '     ';
     fonte[56, ux+2] := '00   00 ';fonte[57, ux+2] := '00  00 ';fonte[58, ux+2] := '000 ';fonte[59, ux+2] := ' 000 ';
     fonte[56, ux+3] := ' 00000  ';fonte[57, ux+3] := '000000 ';fonte[58, ux+3] := '000 ';fonte[59, ux+3] := ' 000 ';
     fonte[56, ux+4] := ' 00000  ';fonte[57, ux+4] := '000000 ';fonte[58, ux+4] := '    ';fonte[59, ux+4] := '     ';
     fonte[56, ux+5] := '00   00 ';fonte[57, ux+5] := '    00 ';fonte[58, ux+5] := '000 ';fonte[59, ux+5] := ' 000 ';
     fonte[56, ux+6] := '0000000 ';fonte[57, ux+6] := '000000 ';fonte[58, ux+6] := '000 ';fonte[59, ux+6] := ' 000 ';
     fonte[56, ux+7] := ' 00000  ';fonte[57, ux+7] := '000000 ';fonte[58, ux+7] := '    ';fonte[59, ux+7] := '000  ';

   {                    A                             B                              C                             D   }
     fonte[65, ux]   := ' 00000  ';fonte[66, ux]   := '000000  ';fonte[67, ux]   := ' 00000  ';fonte[68, ux]   := ' 00000  ';
     fonte[65, ux+1] := '0000000 ';fonte[66, ux+1] := '0000000 ';fonte[67, ux+1] := '0000000 ';fonte[68, ux+1] := ' 000000 ';
     fonte[65, ux+2] := '00   00 ';fonte[66, ux+2] := '00   00 ';fonte[67, ux+2] := '00   00 ';fonte[68, ux+2] := ' 00  00 ';
     fonte[65, ux+3] := '0000000 ';fonte[66, ux+3] := '000000  ';fonte[67, ux+3] := '00      ';fonte[68, ux+3] := ' 00  00 ';
     fonte[65, ux+4] := '0000000 ';fonte[66, ux+4] := '000000  ';fonte[67, ux+4] := '00      ';fonte[68, ux+4] := ' 00  00 ';
     fonte[65, ux+5] := '00   00 ';fonte[66, ux+5] := '00   00 ';fonte[67, ux+5] := '00   00 ';fonte[68, ux+5] := ' 00  00 ';
     fonte[65, ux+6] := '00   00 ';fonte[66, ux+6] := '0000000 ';fonte[67, ux+6] := '0000000 ';fonte[68, ux+6] := ' 000000 ';
     fonte[65, ux+7] := '00   00 ';fonte[66, ux+7] := '000000  ';fonte[67, ux+7] := ' 00000  ';fonte[68, ux+7] := ' 00000  ';

   {                    E                              F                             G                              H   }
     fonte[69, ux]   := '0000000 ';fonte[70, ux]   := '0000000 ';fonte[71, ux]   := '0000000 ';fonte[72, ux]   := '00   00 ';
     fonte[69, ux+1] := '0000000 ';fonte[70, ux+1] := '0000000 ';fonte[71, ux+1] := '0000000 ';fonte[72, ux+1] := '00   00 ';
     fonte[69, ux+2] := '00      ';fonte[70, ux+2] := '00      ';fonte[71, ux+2] := '00      ';fonte[72, ux+2] := '00   00 ';
     fonte[69, ux+3] := '000000  ';fonte[70, ux+3] := '000000  ';fonte[71, ux+3] := '00 0000 ';fonte[72, ux+3] := '0000000 ';
     fonte[69, ux+4] := '000000  ';fonte[70, ux+4] := '000000  ';fonte[71, ux+4] := '00 0000 ';fonte[72, ux+4] := '0000000 ';
     fonte[69, ux+5] := '00      ';fonte[70, ux+5] := '00      ';fonte[71, ux+5] := '00   00 ';fonte[72, ux+5] := '00   00 ';
     fonte[69, ux+6] := '0000000 ';fonte[70, ux+6] := '00      ';fonte[71, ux+6] := '0000000 ';fonte[72, ux+6] := '00   00 ';
     fonte[69, ux+7] := '0000000 ';fonte[70, ux+7] := '00      ';fonte[71, ux+7] := '0000000 ';fonte[72, ux+7] := '00   00 ';

   {                    I                             J                               K                         L   }
     fonte[73, ux]   := '000000 ';fonte[74, ux]   := '000000 ';fonte[75, ux]   := '00   00 ';fonte[76, ux]   := '00      ';
     fonte[73, ux+1] := '000000 ';fonte[74, ux+1] := '000000 ';fonte[75, ux+1] := '00  00  ';fonte[76, ux+1] := '00      ';
     fonte[73, ux+2] := '  00   ';fonte[74, ux+2] := '    00 ';fonte[75, ux+2] := '00 00   ';fonte[76, ux+2] := '00      ';
     fonte[73, ux+3] := '  00   ';fonte[74, ux+3] := '    00 ';fonte[75, ux+3] := '0000    ';fonte[76, ux+3] := '00      ';
     fonte[73, ux+4] := '  00   ';fonte[74, ux+4] := '    00 ';fonte[75, ux+4] := '0000    ';fonte[76, ux+4] := '00      ';
     fonte[73, ux+5] := '  00   ';fonte[74, ux+5] := '00  00 ';fonte[75, ux+5] := '00 00   ';fonte[76, ux+5] := '00      ';
     fonte[73, ux+6] := '000000 ';fonte[74, ux+6] := '000000 ';fonte[75, ux+6] := '00  00  ';fonte[76, ux+6] := '0000000 ';
     fonte[73, ux+7] := '000000 ';fonte[74, ux+7] := '000000 ';fonte[75, ux+7] := '00   00 ';fonte[76, ux+7] := '0000000 ';

   {                    M                              N                               O                           P    }
     fonte[77, ux]   := '00   00 ';fonte[78, ux]   := '00   00 ';fonte[79, ux]   := ' 00000  ';fonte[80, ux]   := '000000  ';
     fonte[77, ux+1] := '000 000 ';fonte[78, ux+1] := '000  00 ';fonte[79, ux+1] := '0000000 ';fonte[80, ux+1] := '0000000 ';
     fonte[77, ux+2] := '0000000 ';fonte[78, ux+2] := '000  00 ';fonte[79, ux+2] := '00   00 ';fonte[80, ux+2] := '00   00 ';
     fonte[77, ux+3] := '00 0 00 ';fonte[78, ux+3] := '0000 00 ';fonte[79, ux+3] := '00   00 ';fonte[80, ux+3] := '0000000 ';
     fonte[77, ux+4] := '00   00 ';fonte[78, ux+4] := '00 0000 ';fonte[79, ux+4] := '00   00 ';fonte[80, ux+4] := '000000  ';
     fonte[77, ux+5] := '00   00 ';fonte[78, ux+5] := '00  000 ';fonte[79, ux+5] := '00   00 ';fonte[80, ux+5] := '00      ';
     fonte[77, ux+6] := '00   00 ';fonte[78, ux+6] := '00  000 ';fonte[79, ux+6] := '0000000 ';fonte[80, ux+6] := '00      ';
     fonte[77, ux+7] := '00   00 ';fonte[78, ux+7] := '00   00 ';fonte[79, ux+7] := ' 00000  ';fonte[80, ux+7] := '00      ';

   {                    Q                              R                             S                            T   }
     fonte[81, ux]   := ' 00000  ';fonte[82, ux]   := '000000  ';fonte[83, ux]   := ' 000000 ';fonte[84, ux]   := '00000000 ';
     fonte[81, ux+1] := '0000000 ';fonte[82, ux+1] := '0000000 ';fonte[83, ux+1] := '0000000 ';fonte[84, ux+1] := '00000000 ';
     fonte[81, ux+2] := '00   00 ';fonte[82, ux+2] := '00   00 ';fonte[83, ux+2] := '00      ';fonte[84, ux+2] := '   00    ';
     fonte[81, ux+3] := '00   00 ';fonte[82, ux+3] := '0000000 ';fonte[83, ux+3] := '000000  ';fonte[84, ux+3] := '   00    ';
     fonte[81, ux+4] := '00   00 ';fonte[82, ux+4] := '00000   ';fonte[83, ux+4] := ' 000000 ';fonte[84, ux+4] := '   00    ';
     fonte[81, ux+5] := '00 0000 ';fonte[82, ux+5] := '00 000  ';fonte[83, ux+5] := '     00 ';fonte[84, ux+5] := '   00    ';
     fonte[81, ux+6] := '0000000 ';fonte[82, ux+6] := '00  000 ';fonte[83, ux+6] := '0000000 ';fonte[84, ux+6] := '   00    ';
     fonte[81, ux+7] := ' 000000 ';fonte[82, ux+7] := '00   00 ';fonte[83, ux+7] := '000000  ';fonte[84, ux+7] := '   00    ';

   {                    U                              V                               W                           X  }
     fonte[85, ux]   := '00   00 ';fonte[86, ux]   := '00   00 ';fonte[87, ux]   := '00   00 ';fonte[88, ux]   := '00   00 ';
     fonte[85, ux+1] := '00   00 ';fonte[86, ux+1] := '00   00 ';fonte[87, ux+1] := '00   00 ';fonte[88, ux+1] := '00   00 ';
     fonte[85, ux+2] := '00   00 ';fonte[86, ux+2] := '00   00 ';fonte[87, ux+2] := '00   00 ';fonte[88, ux+2] := ' 00 00  ';
     fonte[85, ux+3] := '00   00 ';fonte[86, ux+3] := '00   00 ';fonte[87, ux+3] := '00   00 ';fonte[88, ux+3] := '  000   ';
     fonte[85, ux+4] := '00   00 ';fonte[86, ux+4] := '00   00 ';fonte[87, ux+4] := '00   00 ';fonte[88, ux+4] := '  000   ';
     fonte[85, ux+5] := '00   00 ';fonte[86, ux+5] := '000 000 ';fonte[87, ux+5] := '00 0 00 ';fonte[88, ux+5] := ' 00 00  ';
     fonte[85, ux+6] := '0000000 ';fonte[86, ux+6] := ' 00000  ';fonte[87, ux+6] := '0000000 ';fonte[88, ux+6] := '00   00 ';
     fonte[85, ux+7] := '0000000 ';fonte[86, ux+7] := '  000   ';fonte[87, ux+7] := ' 00 00  ';fonte[88, ux+7] := '00   00 ';

   {                    Y                              Z                                                              }
     fonte[89, ux]   := '00    00 ';fonte[90, ux]   := '0000000 ';fonte[22, ux]   := '00000000';fonte[95, ux]   := '        ';
     fonte[89, ux+1] := '00    00 ';fonte[90, ux+1] := '0000000 ';fonte[22, ux+1] := '00000000';fonte[95, ux+1] := '        ';
     fonte[89, ux+2] := '00    00 ';fonte[90, ux+2] := '    000 ';fonte[22, ux+2] := '00000000';fonte[95, ux+2] := '        ';
     fonte[89, ux+3] := ' 00  00  ';fonte[90, ux+3] := '   000  ';fonte[22, ux+3] := '00000000';fonte[95, ux+3] := '        ';
     fonte[89, ux+4] := '  0000   ';fonte[90, ux+4] := '  000   ';fonte[22, ux+4] := '00000000';fonte[95, ux+4] := '        ';
     fonte[89, ux+5] := '   00    ';fonte[90, ux+5] := ' 000    ';fonte[22, ux+5] := '00000000';fonte[95, ux+5] := '        ';
     fonte[89, ux+6] := '   00    ';fonte[90, ux+6] := '0000000 ';fonte[22, ux+6] := '00000000';fonte[95, ux+6] := '        ';
     fonte[89, ux+7] := '   00    ';fonte[90, ux+7] := '0000000 ';fonte[22, ux+7] := '00000000';fonte[95, ux+7] := '0000000 ';

   {                                                                                                                   }
     fonte[61, ux]   := '        ';fonte[21, ux]   := '000000';  fonte[22, ux]   := '0000   ';fonte[23, ux]   := '0000    ';
     fonte[61, ux+1] := '        ';fonte[21, ux+1] := '000000';  fonte[22, ux+1] := '0      ';fonte[23, ux+1] := '0       ';
     fonte[61, ux+2] := '0000000 ';fonte[21, ux+2] := '000000';  fonte[22, ux+2] := '000    ';fonte[23, ux+2] := '000     ';
     fonte[61, ux+3] := '0000000 ';fonte[21, ux+3] := '000000';  fonte[22, ux+3] := '0   0  ';fonte[23, ux+3] := '0   00  ';
     fonte[61, ux+4] := '        ';fonte[21, ux+4] := '000000';  fonte[22, ux+4] := '0  00  ';fonte[23, ux+4] := '0  0  0 ';
     fonte[61, ux+5] := '0000000 ';fonte[21, ux+5] := '000000';  fonte[22, ux+5] := '    0  ';fonte[23, ux+5] := '     0  ';
     fonte[61, ux+6] := '0000000 ';fonte[21, ux+6] := '000000';  fonte[22, ux+6] := '    0  ';fonte[23, ux+6] := '    0   ';
     fonte[61, ux+7] := '        ';fonte[21, ux+7] := '000000';  fonte[22, ux+7] := '   000 ';fonte[23, ux+7] := '   0000 ';

   {                                                                                                                  }
     fonte[24, ux]   := '0000    ';fonte[25, ux]   := '0000    ';  fonte[26, ux]   := '0000    ';fonte[27, ux]   := ' 0 ';
     fonte[24, ux+1] := '0       ';fonte[25, ux+1] := '0       ';  fonte[26, ux+1] := '0       ';fonte[27, ux+1] := ' 0 ';
     fonte[24, ux+2] := '000     ';fonte[25, ux+2] := '000     ';  fonte[26, ux+2] := '000     ';fonte[27, ux+2] := ' 00';
     fonte[24, ux+3] := '0   00  ';fonte[25, ux+3] := '0   0 0 ';  fonte[26, ux+3] := '0   000 ';fonte[27, ux+3] := ' 00';
     fonte[24, ux+4] := '0  0  0 ';fonte[25, ux+4] := '0   0 0 ';  fonte[26, ux+4] := '0   0   ';fonte[27, ux+4] := ' 00';
     fonte[24, ux+5] := '     0  ';fonte[25, ux+5] := '    000 ';  fonte[26, ux+5] := '    00  ';fonte[27, ux+5] := ' 00';
     fonte[24, ux+6] := '   0  0 ';fonte[25, ux+6] := '      0 ';  fonte[26, ux+6] := '      0 ';fonte[27, ux+6] := ' 0 ';
     fonte[24, ux+7] := '    00  ';fonte[25, ux+7] := '      0 ';  fonte[26, ux+7] := '    00  ';fonte[27, ux+7] := ' 0 ';

     fonte[28, ux]   := '  0   ';fonte[29, ux]   := '00000 ';fonte[30, ux]   := '00   ';fonte[31, ux]   := '  00 ';
     fonte[28, ux+1] := ' 000  ';fonte[29, ux+1] := ' 000  ';fonte[30, ux+1] := '0000 ';fonte[31, ux+1] := '0000 ';
     fonte[28, ux+2] := '00000 ';fonte[29, ux+2] := '  0   ';fonte[30, ux+2] := '000  ';fonte[31, ux+2] := ' 000 ';
     fonte[28, ux+3] := '      ';fonte[29, ux+3] := '      ';fonte[30, ux+3] := '00   ';fonte[31, ux+3] := '  00 ';
     fonte[28, ux+4] := '      ';fonte[29, ux+4] := '      ';fonte[30, ux+4] := '     ';fonte[31, ux+4] := '     ';
     fonte[28, ux+5] := '      ';fonte[29, ux+5] := '      ';fonte[30, ux+5] := '     ';fonte[31, ux+5] := '     ';
     fonte[28, ux+6] := '      ';fonte[29, ux+6] := '      ';fonte[30, ux+6] := '     ';fonte[31, ux+6] := '     ';
     fonte[28, ux+7] := '      ';fonte[29, ux+7] := '      ';fonte[30, ux+7] := '     ';fonte[31, ux+7] := '     ';

end;


procedure fonte_omissao;
const ux = 1;
begin
     fonte[32, ux]   := ' ';
     fonte[32, ux+1] := ' ';
     fonte[32, ux+2] := ' ';
     fonte[32, ux+3] := ' ';
     fonte[32, ux+4] := ' ';
     fonte[32, ux+5] := ' ';
     fonte[32, ux+6] := ' ';
     fonte[32, ux+7] := ' ';

   {            0                                      1                            2                           3   }
     fonte[48, ux]   := ' 000  ';fonte[49, ux]   := '  0  ';fonte[50, ux]   := ' 000  ';fonte[51, ux]   := ' 000  ';
     fonte[48, ux+1] := '0  00 ';fonte[49, ux+1] := ' 00  ';fonte[50, ux+1] := '0   0 ';fonte[51, ux+1] := '0   0 ';
     fonte[48, ux+2] := '0  00 ';fonte[49, ux+2] := '000  ';fonte[50, ux+2] := '0   0 ';fonte[51, ux+2] := '    0 ';
     fonte[48, ux+3] := '0 0 0 ';fonte[49, ux+3] := '  0  ';fonte[50, ux+3] := '  000 ';fonte[51, ux+3] := ' 000  ';
     fonte[48, ux+4] := '00  0 ';fonte[49, ux+4] := '  0  ';fonte[50, ux+4] := '00    ';fonte[51, ux+4] := '    0 ';
     fonte[48, ux+5] := '00  0 ';fonte[49, ux+5] := '  0  ';fonte[50, ux+5] := '0     ';fonte[51, ux+5] := '0   0 ';
     fonte[48, ux+6] := ' 000  ';fonte[49, ux+6] := ' 000 ';fonte[50, ux+6] := '00000 ';fonte[51, ux+6] := ' 000  ';

   {                   4                              5                               6                           7   }
     fonte[52, ux]   := '0   0 ';fonte[53, ux]   := '00000 ';fonte[54, ux]   := ' 0000 ';fonte[55, ux]   := '00000 ';
     fonte[52, ux+1] := '0   0 ';fonte[53, ux+1] := '0     ';fonte[54, ux+1] := '0     ';fonte[55, ux+1] := '    0 ';
     fonte[52, ux+2] := '0   0 ';fonte[53, ux+2] := '0     ';fonte[54, ux+2] := '0     ';fonte[55, ux+2] := '   0  ';
     fonte[52, ux+3] := '00000 ';fonte[53, ux+3] := '0000  ';fonte[54, ux+3] := '00000 ';fonte[55, ux+3] := '  0   ';
     fonte[52, ux+4] := '    0 ';fonte[53, ux+4] := '    0 ';fonte[54, ux+4] := '0   0 ';fonte[55, ux+4] := '  0   ';
     fonte[52, ux+5] := '    0 ';fonte[53, ux+5] := '0   0 ';fonte[54, ux+5] := '0   0 ';fonte[55, ux+5] := ' 0    ';
     fonte[52, ux+6] := '    0 ';fonte[53, ux+6] := ' 000  ';fonte[54, ux+6] := '00000 ';fonte[55, ux+6] := ' 0    ';

   {                     8                           9                                :                           ; }
     fonte[56, ux]   := ' 000  ';fonte[57, ux]   := '00000 ';fonte[58, ux]   := '  ';fonte[59, ux]   := '   ';
     fonte[56, ux+1] := '0   0 ';fonte[57, ux+1] := '0   0 ';fonte[58, ux+1] := '  ';fonte[59, ux+1] := '   ';
     fonte[56, ux+2] := '0   0 ';fonte[57, ux+2] := '0   0 ';fonte[58, ux+2] := '0 ';fonte[59, ux+2] := ' 0 ';
     fonte[56, ux+3] := ' 000  ';fonte[57, ux+3] := '00000 ';fonte[58, ux+3] := '  ';fonte[59, ux+3] := '   ';
     fonte[56, ux+4] := '0   0 ';fonte[57, ux+4] := '    0 ';fonte[58, ux+4] := '0 ';fonte[59, ux+4] := ' 0 ';
     fonte[56, ux+5] := '0   0 ';fonte[57, ux+5] := '    0 ';fonte[58, ux+5] := '  ';fonte[59, ux+5] := ' 0 ';
     fonte[56, ux+6] := ' 000  ';fonte[57, ux+6] := '0000  ';fonte[58, ux+6] := '  ';fonte[59, ux+6] := '0  ';

   {                    A                             B                              C                             D   }
     fonte[65, ux]   := ' 00  ';fonte[66, ux]   := '000  ';fonte[67, ux]   := ' 00  ';fonte[68, ux]   := '000  ';
     fonte[65, ux+1] := '0  0 ';fonte[66, ux+1] := '0  0 ';fonte[67, ux+1] := '0  0 ';fonte[68, ux+1] := '0  0 ';
     fonte[65, ux+2] := '0  0 ';fonte[66, ux+2] := '0  0 ';fonte[67, ux+2] := '0    ';fonte[68, ux+2] := '0  0 ';
     fonte[65, ux+3] := '0000 ';fonte[66, ux+3] := '000  ';fonte[67, ux+3] := '0    ';fonte[68, ux+3] := '0  0 ';
     fonte[65, ux+4] := '0  0 ';fonte[66, ux+4] := '0  0 ';fonte[67, ux+4] := '0    ';fonte[68, ux+4] := '0  0 ';
     fonte[65, ux+5] := '0  0 ';fonte[66, ux+5] := '0  0 ';fonte[67, ux+5] := '0  0 ';fonte[68, ux+5] := '0  0 ';
     fonte[65, ux+6] := '0  0 ';fonte[66, ux+6] := '000  ';fonte[67, ux+6] := ' 00  ';fonte[68, ux+6] := '000  ';

   {                    E                            F                             G                              H   }
     fonte[69, ux]   := '0000 ';fonte[70, ux]   := '0000 ';fonte[71, ux]   := ' 000 ';fonte[72, ux]   := '0  0 ';
     fonte[69, ux+1] := '0    ';fonte[70, ux+1] := '0    ';fonte[71, ux+1] := '0    ';fonte[72, ux+1] := '0  0 ';
     fonte[69, ux+2] := '0    ';fonte[70, ux+2] := '0    ';fonte[71, ux+2] := '0    ';fonte[72, ux+2] := '0  0 ';
     fonte[69, ux+3] := '000  ';fonte[70, ux+3] := '000  ';fonte[71, ux+3] := '0 00 ';fonte[72, ux+3] := '0000 ';
     fonte[69, ux+4] := '0    ';fonte[70, ux+4] := '0    ';fonte[71, ux+4] := '0  0 ';fonte[72, ux+4] := '0  0 ';
     fonte[69, ux+5] := '0    ';fonte[70, ux+5] := '0    ';fonte[71, ux+5] := '0  0 ';fonte[72, ux+5] := '0  0 ';
     fonte[69, ux+6] := '0000 ';fonte[70, ux+6] := '0    ';fonte[71, ux+6] := '0000 ';fonte[72, ux+6] := '0  0 ';

   {                    I                             J                               K                         L   }
     fonte[73, ux]   := '000 ';fonte[74, ux]   := '0000 ';fonte[75, ux]   := '0   0 ';fonte[76, ux]   := '0    ';
     fonte[73, ux+1] := ' 0  ';fonte[74, ux+1] := '   0 ';fonte[75, ux+1] := '0  0  ';fonte[76, ux+1] := '0    ';
     fonte[73, ux+2] := ' 0  ';fonte[74, ux+2] := '   0 ';fonte[75, ux+2] := '0 0   ';fonte[76, ux+2] := '0    ';
     fonte[73, ux+3] := ' 0  ';fonte[74, ux+3] := '   0 ';fonte[75, ux+3] := '00    ';fonte[76, ux+3] := '0    ';
     fonte[73, ux+4] := ' 0  ';fonte[74, ux+4] := '00 0 ';fonte[75, ux+4] := '0 0   ';fonte[76, ux+4] := '0    ';
     fonte[73, ux+5] := ' 0  ';fonte[74, ux+5] := '0  0 ';fonte[75, ux+5] := '0  0  ';fonte[76, ux+5] := '0    ';
     fonte[73, ux+6] := '000 ';fonte[74, ux+6] := '0000 ';fonte[75, ux+6] := '0   0 ';fonte[76, ux+6] := '0000 ';

   {                    M                              N                               O                           P    }
     fonte[77, ux]   := '0   0 ';fonte[78, ux]   := '0   0 ';fonte[79, ux]   := ' 00  ';fonte[80, ux]   := '000  ';
     fonte[77, ux+1] := '00 00 ';fonte[78, ux+1] := '00  0 ';fonte[79, ux+1] := '0  0 ';fonte[80, ux+1] := '0  0 ';
     fonte[77, ux+2] := '0 0 0 ';fonte[78, ux+2] := '00  0 ';fonte[79, ux+2] := '0  0 ';fonte[80, ux+2] := '0  0 ';
     fonte[77, ux+3] := '0   0 ';fonte[78, ux+3] := '0 0 0 ';fonte[79, ux+3] := '0  0 ';fonte[80, ux+3] := '000  ';
     fonte[77, ux+4] := '0   0 ';fonte[78, ux+4] := '0  00 ';fonte[79, ux+4] := '0  0 ';fonte[80, ux+4] := '0    ';
     fonte[77, ux+5] := '0   0 ';fonte[78, ux+5] := '0  00 ';fonte[79, ux+5] := '0  0 ';fonte[80, ux+5] := '0    ';
     fonte[77, ux+6] := '0   0 ';fonte[78, ux+6] := '0   0 ';fonte[79, ux+6] := ' 00  ';fonte[80, ux+6] := '0    ';

   {                    Q                              R                             S                            T   }
     fonte[81, ux]   := ' 000  ';fonte[82, ux]   := '000  ';fonte[83, ux]   := ' 00  ';fonte[84, ux]   := '00000 ';
     fonte[81, ux+1] := '0   0 ';fonte[82, ux+1] := '0  0 ';fonte[83, ux+1] := '0  0 ';fonte[84, ux+1] := '  0   ';
     fonte[81, ux+2] := '0   0 ';fonte[82, ux+2] := '0  0 ';fonte[83, ux+2] := '00   ';fonte[84, ux+2] := '  0   ';
     fonte[81, ux+3] := '0   0 ';fonte[82, ux+3] := '0 0  ';fonte[83, ux+3] := '  00 ';fonte[84, ux+3] := '  0   ';
     fonte[81, ux+4] := '0 0 0 ';fonte[82, ux+4] := '00   ';fonte[83, ux+4] := '   0 ';fonte[84, ux+4] := '  0   ';
     fonte[81, ux+5] := '0  00 ';fonte[82, ux+5] := '0 0  ';fonte[83, ux+5] := '0  0 ';fonte[84, ux+5] := '  0   ';
     fonte[81, ux+6] := ' 0000 ';fonte[82, ux+6] := '0  0 ';fonte[83, ux+6] := ' 00  ';fonte[84, ux+6] := '  0   ';

   {                    U                              V                               W                           X  }
     fonte[85, ux]   := '0  0 ';fonte[86, ux]   := '0   0 ';fonte[87, ux]   := '0   0 ';fonte[88, ux]   := '0   0 ';
     fonte[85, ux+1] := '0  0 ';fonte[86, ux+1] := '0   0 ';fonte[87, ux+1] := '0   0 ';fonte[88, ux+1] := '0   0 ';
     fonte[85, ux+2] := '0  0 ';fonte[86, ux+2] := '0   0 ';fonte[87, ux+2] := '0   0 ';fonte[88, ux+2] := ' 0 0  ';
     fonte[85, ux+3] := '0  0 ';fonte[86, ux+3] := '0   0 ';fonte[87, ux+3] := '0   0 ';fonte[88, ux+3] := '  0   ';
     fonte[85, ux+4] := '0  0 ';fonte[86, ux+4] := '0   0 ';fonte[87, ux+4] := '0   0 ';fonte[88, ux+4] := ' 0 0  ';
     fonte[85, ux+5] := '0  0 ';fonte[86, ux+5] := ' 0 0  ';fonte[87, ux+5] := '0 0 0 ';fonte[88, ux+5] := '0   0 ';
     fonte[85, ux+6] := '0000 ';fonte[86, ux+6] := '  0   ';fonte[87, ux+6] := ' 0 0  ';fonte[88, ux+6] := '0   0 ';

   {                    Y                              Z                                                              }
     fonte[89, ux]   := '0   0 ';fonte[90, ux]   := '00000 ';fonte[91, ux]   := ' 000000 ';fonte[92, ux]   := ' 000000 ';
     fonte[89, ux+1] := '0   0 ';fonte[90, ux+1] := '    0 ';fonte[91, ux+1] := ' 000000 ';fonte[92, ux+1] := ' 000000 ';
     fonte[89, ux+2] := '0   0 ';fonte[90, ux+2] := '   0  ';fonte[91, ux+2] := ' 000000 ';fonte[92, ux+2] := ' 000000 ';
     fonte[89, ux+3] := ' 0 0  ';fonte[90, ux+3] := '  0   ';fonte[91, ux+3] := ' 000000 ';fonte[92, ux+3] := ' 000000 ';
     fonte[89, ux+4] := '  0   ';fonte[90, ux+4] := ' 0    ';fonte[91, ux+4] := ' 000000 ';fonte[92, ux+4] := ' 000000 ';
     fonte[89, ux+5] := '  0   ';fonte[90, ux+5] := '0     ';fonte[91, ux+5] := ' 000000 ';fonte[92, ux+5] := ' 000000 ';
     fonte[89, ux+6] := '  0   ';fonte[90, ux+6] := '00000 ';fonte[91, ux+6] := ' 000000 ';fonte[92, ux+6] := ' 000000 ';

   {                                                                                                                   }
     fonte[93, ux]   := ' 000000 ';fonte[94, ux]   := ' 000000 ';fonte[95, ux]   := ' 000000 ';fonte[96, ux]   := ' 000000 ';
     fonte[93, ux+1] := ' 000000 ';fonte[94, ux+1] := ' 000000 ';fonte[95, ux+1] := ' 000000 ';fonte[96, ux+1] := ' 000000 ';
     fonte[93, ux+2] := ' 000000 ';fonte[94, ux+2] := ' 000000 ';fonte[95, ux+2] := ' 000000 ';fonte[96, ux+2] := ' 000000 ';
     fonte[93, ux+3] := ' 000000 ';fonte[94, ux+3] := ' 000000 ';fonte[95, ux+3] := ' 000000 ';fonte[96, ux+3] := ' 000000 ';
     fonte[93, ux+4] := ' 000000 ';fonte[94, ux+4] := ' 000000 ';fonte[95, ux+4] := ' 000000 ';fonte[96, ux+4] := ' 000000 ';
     fonte[93, ux+5] := ' 000000 ';fonte[94, ux+5] := ' 000000 ';fonte[95, ux+5] := ' 000000 ';fonte[96, ux+5] := ' 000000 ';
     fonte[93, ux+6] := ' 000000 ';fonte[94, ux+6] := ' 000000 ';fonte[95, ux+6] := ' 000000 ';fonte[96, ux+6] := ' 000000 ';

end;

procedure poetexto;
var px, py : integer;
    car, row, bit, cod, aux : byte;
begin
     for car := 1 to length(txt) do
     begin
        py := y;
        cod := ord(txt[car]);
        for row := 1 to altcar do
        begin
           px := x;
           for bit := 1 to length(fonte[cod, row]) do
           begin
             if fonte[cod, row][bit] <> ' ' then ponto(px, py)
             else if apa then begin
                         aux := acor;
                         acor := fund;
                         ponto(px, py);
                         acor := aux
                  end;
             inc(px)
           end;
           inc(py)
        end;
        inc(x, length(fonte[cod, 1]))
     end
end;



end.