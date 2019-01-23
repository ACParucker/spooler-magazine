
{
   ******************************************************************
   *                                                                *
   *           TURBO CRT 2  ---   Para Turbo PASCAL 5.0             *
   *                                                                *
   *  por:  Rui Dias                                                *
   *           Faro, Algarve, Portugal        Dezembro de  1990     *
   *                                                                *
   ****************************************************************** }


 UNIT   Tcrt2;

 INTERFACE

      CONST  Simples  ='⁄ƒø≥Ÿƒ¿≥';      { Tipos de caixas }
             Dupla    ='…Õª∫ºÕ»∫';
             DuplaHor ='’Õ∏≥æÕ‘≥';
             DuplaVert='÷ƒ∑∫Ωƒ”∫';
             classica ='€ﬂ€ﬁ€‹€›';

      TYPE   EcrTipo  = ARRAY [1..25,1..80] Of
                             RECORD
                                 Car :Char; { caractere }
                                 Cor :Byte; { cor       }
                             END;

             string8=string[8];
             string80=string[80];
             string25=string[25];


function     EcrSeg:word;
function     EcrOffs(x,y:byte):word;

procedure    EscreveHor(  X,Y:byte;  Str:string80; cor:BYTE);
procedure    EscreveVert( X,Y:byte;  Str:string25; cor:BYTE);

procedure    PoeCar( x,y :byte; ascii:char ; cor :byte);

procedure    corxx(x,y,x1 :byte;  cor:byte );
procedure    coryy(x,y,y1 :byte;  cor:byte );

procedure    ReplicarXX( x,y,x1:byte;   ascii:char;  cor:byte  );
procedure    ReplicarYY( x,y,y1:byte;   ascii:char;  cor:byte  );

procedure    Caixa(x1,y1,x2,y2:byte; s:string8; cor:byte );

procedure    GravaEcr(var ecran:EcrTipo);
procedure    PoeEcr(  var ecran:EcrTipo);

function     JanelaTam(x1,y1,x2,y2 :byte):word;
procedure    gravajanela(x,y,x1,y1 :byte; var im);
procedure    PoeJanela(  x,y,x1,y1 :byte; var im);

procedure    EncheArea(x1,y1,x2,y2: Byte ; ascii: Char ; cor:byte);

procedure    mudacor(x1,y1,x2,y2,cor:byte);

procedure    ApagaEcr;


 IMPLEMENTATION

  var     Ecr_Seg,          { Segmento e        }
          Ecr_Offs :Word;   { Offset   do ecran }

          Cont,Cont2     :Byte;   { Contador }


PROCEDURE InicioTurboCrt2;
{ Aponta a variavel(Ecr_Seg) para a posicao certa ** Privada ** }
Var
       bandeiras:byte absolute 0000:$0410;
BEGIN
   case ((bandeiras SHR 4) and $03) of
      1,2:Ecr_Seg:=$B800;   { Cores }
      3  :Ecr_Seg:=$B000;   { Mono  }
     else Halt;
   end;
END;

procedure Aponta(x,y:byte);
{ Obter o offset da posicao x,y ** Privada **}
begin
  dec(x);
  dec(y);
  Ecr_Offs:=(y*160)+(x*2);
end;

function EcrSeg:word;
begin
   ecrSeg:=Ecr_seg;
end;

function EcrOffs(x,y:byte):word;
begin
  aponta(x,y);
  ecrOffs:=Ecr_offs;
end;

procedure EscreveHor( X,Y:byte;  Str:string80; cor:BYTE);
begin
   aponta(x,y);
   for cont:=1 to Length(str) do
      begin
      Mem[ecr_seg:ecr_offs]:=ord(str[cont]);
      inc(ecr_offs);
      Mem[ecr_seg:ecr_offs]:=cor;
      inc(ecr_offs);
      end;
end;


procedure EscreveVert( X,Y:byte;  Str:string25; cor:BYTE);
begin
   aponta(x,y);
   for cont:=1 to Length(str) do
      begin
      Mem[ecr_seg:ecr_offs]:=ord(str[cont]);
      inc(ecr_offs);
      Mem[ecr_seg:ecr_offs]:=cor;
      inc(ecr_offs,159);
      end;
end;


procedure PoeCar( x,y :byte; ascii:char ; cor :byte);
begin
   aponta(x,y);
   Mem[ecr_seg:ecr_offs]:=ord(ascii);
   inc(ecr_offs);
   Mem[ecr_seg:ecr_offs]:=cor;
end;



procedure corxx(x,y,x1 :byte;  cor:byte    );
begin
   aponta(x,y);
   dec(Ecr_offs);
   for cont:=x to x1 do
     begin
     inc(ecr_offs,2);
     mem[ecr_seg:ecr_offs]:=cor;
     end;
end;

procedure coryy(x,y,y1 :byte;  cor:byte    );
begin
   aponta(x,y);
   inc(Ecr_offs);
   for cont:=y to y1 do
     begin
     mem[ecr_seg:ecr_offs]:=cor;
     inc(ecr_offs,160);
     end;
end;



procedure ReplicarXX(x,y,x1:byte;   ascii:char;  cor:byte  );
begin
   cont2:=ord(ascii);
   aponta(x,y);
   for cont:=x to x1 do
      begin
      Mem[ecr_seg:ecr_offs]:=cont2;
      inc(ecr_offs);
      Mem[ecr_seg:ecr_offs]:=cor;
      inc(ecr_offs);
      end;
end;

procedure ReplicarYY(x,y,y1:byte;   ascii:char;  cor:byte  );
begin
   cont2:=ord(ascii);
   aponta(x,y);
   for cont:=y to y1 do
      begin
      Mem[ecr_seg:ecr_offs]:=cont2;
      inc(ecr_offs);
      Mem[ecr_seg:ecr_offs]:=cor;
      inc(ecr_offs,159);
      end;
end;



procedure Caixa(x1,y1,x2,y2:byte; s:string8; cor:byte );
begin
   poeCar(x1,y1,s[1],cor);
   poeCar(x2,y1,s[3],cor);
   poeCar(x1,y2,s[7],cor);
   poeCar(x2,y2,s[5],cor);
   replicarXX(x1+1,y1,x2-1,s[2],cor);
   replicarXX(x1+1,y2,x2-1,s[6],cor);
   replicarYY(x1,y1+1,y2-1,s[8],cor);
   replicarYY(x2,y1+1,y2-1,s[4],cor);
end;


procedure GravaEcr(var ecran:EcrTipo);
var  pp:^byte;
begin
  pp:=ptr(Ecr_seg,0000);
  move(pp^,ecran,4000);
end;

procedure PoeEcr(var ecran:EcrTipo);
var  pp:^byte;
begin
  pp:=ptr(Ecr_seg,0000);
  move(ecran,pp^,4000);
end;

function JanelaTam(x1,y1,x2,y2:byte):word;
begin
  JanelaTam:=(y2-y1+1)*(x2-x1+1)*2;
end;


procedure gravajanela(x,y,x1,y1:byte; var im);
type
     imTipo=array[1..maxint] of byte;
var
     imagem:imTipo absolute im;
     bl,  { bytes por linha da janela }
     n    { indice da imagem          } :Word;
     pp:^byte;


begin
  bl:=(x1-x+1)*2;
  n:=1;

  for cont:=y to y1 do
  begin
     aponta(x,cont);
     pp:=ptr(Ecr_seg,Ecr_offs);

     move(pp^,imagem[n],bl);
     inc(n,bl)
  end;
end;



procedure PoeJanela(x,y,x1,y1:byte; var im);

type imTipo=array[1..maxint] of byte;

var  imagem:imTipo absolute im;
     bl,  { bytes por linha da janela }
     n    { indice da imagem          } :Word;
     pp:^byte;

begin
  bl:=(x1-x+1)*2;
  n:=1;

  for cont:=y to y1 do
  begin
     aponta(x,cont);
     pp:=ptr(Ecr_seg,Ecr_offs);

     move(imagem[n],pp^,bl);
     inc(n,bl)
  end;
end;


procedure EncheArea(x1,y1,x2,y2: Byte ; ascii: Char ; cor:byte);
var  ordinal:byte;
begin
  ordinal:=ord(ascii);
  for  cont:=y1 to y2 do
  begin
    aponta(x1,cont);
    for cont2:=x1 to x2 do
    begin
       mem[ecr_seg:ecr_offs]:=ordinal;
       inc(ecr_offs);
       mem[ecr_seg:ecr_offs]:=cor;
       inc(ecr_offs);
    end;
 end;
end;


procedure mudacor(x1,y1,x2,y2,cor:byte);
begin
  for  cont:=y1 to y2 do
  begin
    aponta(x1,cont);
    inc(ecr_offs);
    for cont2:=x1 to x2 do
    begin
       mem[ecr_seg:ecr_offs]:=cor;
       inc(ecr_offs,2);
    end;
 end;
end;


Procedure ApagaEcr;
Var  p:^byte;
begin
  p:=ptr(Ecr_Seg,0000);
  fillchar(p^,4000,0);
end;


BEGIN
  InicioTurboCrt2;
END.
