program Feto_Barnsley_IFS;
uses crt,graph;

const iteradas:longint=100000;  {  n£mero de iteradas  }

var 	gd,gm,escolha:integer;
		x,y:real;
		n:longint;


 { Procedimentos que transformam (x,y) em f(x,y) }

procedure t0(var x,y:real);
var x1:real;
begin
	x1:=0.849*x+0.037*y+0.075;
	y:=-0.037*x+0.849*y+0.183;
	x:=x1;
end;
procedure t1(var x,y:real);
var x1:real;
begin
	x1:=0.197*x-0.226*y+0.4;
	y:=0.226*x+0.197*y+0.049;
	x:=x1;
end;
procedure t2(var x,y:real);
var x1:real;
begin
	x1:=-0.15*x+0.283*y+0.575;
	y:=0.26*x+0.237*y-0.084;
	x:=x1;
end;
procedure t3(var x,y:real);
var x1:real;
begin
	x1:=0.5;
	y:=0.16*y;
	x:=x1;
end;

begin

{ Neste caso, dado que trabalhamos com o sistema associado
 ao Turbo-Pascal da Borland, usamos os parƒmetros 9 e 2
 que correspondem … placa VGA no modo 640*480 com 16 cores.}
	gd:=9;gm:=2;
	initgraph(gd,gm,'c:\tp\bgi');

	{ Valores iniciais }
	x:=0.5;y:=0.5;
	randomize;
	for n:=1 to iteradas do
	begin


{ Conforme o valor da vari vel aleat¢ria escolha  aplicaremos
  uma das quatro fun‡”es }
		escolha:=random(100);
{ Os tamanhos dos intervalos poss¡veis para a vari vel escolha permitem
  ajustar a probabilidade de aplicarmos cada uma das fun‡oes }
		case escolha of
			0..72:t0(x,y);
			73..85:t1(x,y);
			86..96:t2(x,y);
			97..99:t3(x,y);
		end;

{ As primeiras 100 iteradas poder„o estar pouco pr¢ximas do nosso
  IFS por isso n„o as representamos           }
		if n>=100 then putpixel(round(80+480*x),round(480-450*y),10);
{ Dentro do comando putpixel, que desenha o ponto na cor
  10, fazemos a mudan‡a de coordenadas para a placa VGA        }

	end;

{ No fim do programa usamos este comando para que a
  imagem fique vis¡vel at‚ carregarmos numa tecla qualquer }
	repeat until keypressed;
        closegraph
end.
