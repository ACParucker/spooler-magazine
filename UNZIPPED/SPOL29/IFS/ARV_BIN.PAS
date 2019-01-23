program arvore_binaria;

uses graph;

var gd,gm:integer;

function sinal(x:real):real;
begin
  if x>0 then sinal:=1;
  if x=0 then sinal:=0;
  if x<0 then sinal:=-1
end;


procedure arvore( x ,y                   : real;
                  angulo, ramos, tamanho : real;
		  altura                 : real;
                  profundidade           : integer);

var i, xint, yint            : integer;
    xinc, yinc, inicio, alfa : real;

begin
	xint:=round(x); yint:=round(y);
	if profundidade=0 then
	begin
		setcolor(green);
		moveto(xint-2,yint); lineto(xint+2,yint);
		moveto(xint,yint-4); lineto(xint,yint+4);
	end
	else
	begin
		inicio:=angulo-ramos/2;
		alfa:=ramos/4;
		if profundidade<=2 then altura:=altura/2;
		xinc:=tamanho*cos(angulo/180*pi);
		yinc:=tamanho*sin(angulo/180*pi);
		angulo:=inicio;
		setcolor(red);
		moveto(xint,yint); lineto(round(x+xinc),round(y+yinc));
		for i:=1 to 5 do
		begin
			arvore(x+xinc,y+yinc,
			  angulo/2+sinal(angulo)*random(round(abs(angulo))+1),
			  ramos*0.8,
			  tamanho*altura/2+random(round(tamanho*altura)+1),
			  altura, profundidade-1);
		  {a Profundidade diminui at‚ 0 para terminar}
			angulo:=angulo+alfa;
		end
	end
end;


begin
	randomize;
	gd:=9;gm:=2; initgraph(gd,gm,'c:\tp\bgi');
	{ x ,   y, angulo,ramos,tamanho,altura,profundidade }
	{ 320, 480, -90,  100,   70,    0.7,      6 }
	arvore( 320, 450, -90,  1,   100,    0.5,      6);
	arvore( 160, 450, -90,  1,   50,    0.5,      6);
	arvore( 480, 450, -90,  1,   40,    0.5,      6);
	setcolor(yellow);
	outtextxy(10,10,'Carregue em ENTER');
	readln;
	closegraph
end.



