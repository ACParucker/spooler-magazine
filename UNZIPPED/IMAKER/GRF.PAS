{ Esta unit contem procedimentos e funáîes gr†ficas que permitem fazer alguns
  efeitos no cenario o que torna o ambiente do programa mais agrad†vel . }


Unit GRF;
interface
Uses crt,graph,dos;

Procedure Ig(gd,gm:integer);
Procedure Aim(xi,yi,xf,yf:integer;var p:pointer;var t:word);
Procedure Jan(xi,yi,xf,yf,cor1,cor2,cor,gro:integer;var p:pointer;var t:word);
Procedure Jan2(xi,yi,xf,yf,cor1,cor2,cor,gro:integer);
Procedure Jan3(xi,yi,xf,yf,cor1,cor2,gro:integer);
Function Lerl(x,y,t,cora,corl,tam:integer;ch:char):string;
Procedure Escreve(x,y,cor:integer;s:string);
Procedure Imagem(x,y:integer;s:string);
Procedure Gravarim(x,y,xf,yf:integer;st:string);
Procedure Inicrato;
Procedure Rato;
Procedure Ratopos(var x,y:integer);
Function Ratotec:integer;
Procedure Escrato;
Procedure Definir(xi,yi,xf,yf:integer);
Function Verrato:boolean;
Procedure Ratocoord(x,y:integer);
Function Detecta(xi,yi,xf,yf:integer):boolean;
Procedure Tecla(xi,yi,xf,yf:integer;estado:boolean);
Procedure Pintar(x,y,cor,corl:integer);
Procedure Marca(xi,yi,xf,yf:integer;est:boolean);

Implementation

{ *** INICIALIZA O MODO GRAFICO (SIMPLES MAS UTIL) *** }
{ Syntax : Ig ( driver gr†fico , modo gr†fico ) }

Procedure Ig(gd,gm:integer);
Begin
     Initgraph(gd,gm,'')
end;

{ *** SINTETIZA TUDO O QUE O GETIMAGE PRECISA NUM SO PROCEDIMENTO *** }
{ Syntax : Aim ( xi , yi , xf , yf , apontador , tamanho ) }

Procedure Aim(xi,yi,xf,yf:integer;var p:pointer;var t:word);
Begin
     t:=imagesize(xi,yi,xf,yf);getmem(p,t);
     getimage(xi,yi,xf,yf,p^)
end;

{ *** ELABORA UMA JANELA E (APANHA) A PARTE DA IMAGEM NA QUAL ESSA *** }
{ ***                        JANELA VAI ASSENTAR                   *** }
{ Syntax : Jan ( xi , yi , xf , yf , rebordo 1 , rebordo 2 , fundo , grossura ,apontador , tamanho ) }

Procedure Jan(xi,yi,xf,yf,cor1,cor2,cor,gro:integer;var p:pointer;var t:word);
Var x:integer;
Begin
     aim(xi,yi,xf,yf,p,t);
     for x:=1 to gro do
      begin
       setcolor(cor1);
       line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
       setcolor(cor2);
       line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     Setcolor(cor);
     for x:=yi+(gro+1) to yf-(gro+1) do
       line(xi+(gro+1),x,xf-(gro+1),x);
     setcolor(darkgray);
     rectangle(xi,yi,xf,yf)
end;

{ *** ELABORA UMA JANELA A MESMA JANELA MAS NAO GUARDA EM MEMORIA A *** }
{ ***               PARTE DA IMAGEM ONDE VAI ASSENTAR               *** }
{ Syntax : Jan2( xi , yi , xf , yf , rebordo 1 , rebordo 2 , fundo , grossura ) }

Procedure Jan2(xi,yi,xf,yf,cor1,cor2,cor,gro:integer);
Var x:integer;
Begin
     for x:=1 to gro do
      begin
       setcolor(cor1);
       line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
       setcolor(cor2);
       line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     setcolor(cor);
     for x:=yi+(gro+1) to yf-(gro+1) do
       line(xi+(gro+1),x,xf-(gro+1),x);
     setcolor(darkgray);
     rectangle(xi,yi,xf,yf)
end;

{ *** ELABORA APENAS O REBORDO DE UMA JANELA DO TIPO ANTERIOR *** }
{ Syntax : Jan3 ( xi , yi , xf , yf , rebordo 1 , rebordo 2 , grossura ) }

Procedure Jan3(xi,yi,xf,yf,cor1,cor2,gro:integer);
Var x:integer;
Begin
     for x:=1 to gro do
      begin
       setcolor(cor1);
       line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
       setcolor(cor2);
       line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     setcolor(darkgray);
     rectangle(xi,yi,xf,yf)
end;

{ *** TEM A MESMA FUNÄéO QUE O READLN MAS ê USADO EM MODO GRAFICO *** }
{     Syntax :                                                        }
{ string := Lerl (x,y,<tamanho da frase>,<cor de eliminacao>,         }
{                     <cor da letra>,<tamanho da fonte>,<cursor>);    }


Function Lerl(x,y,t,cora,corl,tam:integer;ch:char):string;
Type palavra=array[1..101]of char;

Procedure Ler(var car:char;var code:integer);
Var r:Registers;
Begin
     r.ah:=00;
     intr($16,r);
     car:=chr(r.al);
     code:=r.ah
end;

Procedure Apagarl(x,y,tam:integer);
Var u:integer;
Begin
     for u:=y to y+tam do
         begin
          setcolor(cora);
          line(x,u,x+tam,u)
         end;
     setcolor(corl)
end;

Var s:string;
    car:char;
    code,xm,ym,c:integer;
    p:palavra;

Begin
     for code:=1 to t do
       p[code]:=' ';
     xm:=x;ym:=y;c:=1;
     setcolor(corl);
     outtextxy(x,y,ch);
     repeat
           setcolor(corl);
           ler(car,code);car:=upcase(car);
           if car=chr(8) then
                          begin
                           if x>xm then
                                    begin
                                     apagarl(x,y,tam);
                                     x:=x-tam;c:=c-1;p[c]:=' ';
                                     apagarl(x,y,tam);
                                     outtextxy(x,y,ch)
                                    end
                          end
                         else
           if code=28 then
                         else
           if code=1 then
                         else
                             begin
                              if c=t+1 then else begin
                                                  apagarl(x,y,tam);
                                                  outtextxy(x,y,car+ch);
                                                  p[c]:=car
                                                 end;
                              if c>=t+1 then
                                         begin
                                          x:=xm+(t*tam);c:=t+1
                                         end
                                        else
                                         begin
                                          x:=x+tam;c:=c+1
                                         end;
                             end;
     until (code=28) or (code=1);
     s:='';apagarl(x,y,tam);
     if code=1 then
                lerl:='sai'
               else
                begin
                 for x:=1 to (c-1) do
                   s:=s+p[x];
                 lerl:=s
                end
end;

{ *** ESCREVE A FONTE ORIGINAL COM UM REBORDO *** }
{ Syntax : Escreve ( x , y , cor das letras , ' STRING ' ) }

Procedure Escreve(x,y,cor:integer;s:string);
Begin
     setcolor(darkgray);
     outtextxy(x-1,y,s);
     outtextxy(x+1,y,s);
     outtextxy(x,y-1,s);
     outtextxy(x,y+1,s);
     outtextxy(x-1,y-1,s);
     outtextxy(x+1,y-1,s);
     outtextxy(x-1,y+1,s);
     outtextxy(x+1,y+1,s);
     setcolor(cor);
     outtextxy(x,y,s)
end;

{ *** CARREGA UMA PARTE DA IMAGEM PARA UMA DETERMINADA POSICAO *** }
{ Syntax : Imagem ( x , y , ' NOME DA IMAGEM ' ) }

Procedure Imagem(x,y:integer;s:string);
Var p:pointer;
    t:word;
    f:file;

Begin
     if fsearch(s,getenv('Path'))<>'' then
                                       Begin
                                        assign(f,s);reset(f,1);
                                        t:=filesize(f);
                                        getmem(p,t);
                                        blockread(f,p^,t);
                                        close(f);
                                        putimage(x,y,p^,normalput);
                                        freemem(p,t)
                                       end
end;

{ *** GRAVA UMA DETERMINADA PARTE DA IMAGEM PARA UM FICHEIRO *** }
{ Syntax : Gravarim ( xi , yi , xf , yf , ' NOME DA IMAGEM ' ) }

Procedure Gravarim(x,y,xf,yf:integer;st:string);
var p:pointer;
    t:word;
    f:file;
Begin
     aim(x,y,xf,yf,p,t);
     assign(f,st);rewrite(f,1);
     blockwrite(f,p^,t);
     close(f);
     freemem(p,t)
end;

{ *** INICIA O DRIVER DO RATO *** }
{ Syntax : Inicrato }

Procedure Inicrato;
Var r:Registers;
Begin
     r.ax:=00;
     intr($33,r)
end;

{ *** MOSTRA O RATO *** }
{ Syntax : Rato }

Procedure Rato;
Var r:Registers;
Begin
     r.ax:=01;
     Intr($33,r)
end;

{ *** INDICA A POSICAO DO RATO *** }
{ Syntax : Ratopos ( coordenada x , coordenada y ) }

Procedure Ratopos(var x,y:integer);
Var r:Registers;
Begin
     r.ax:=03;
     Intr($33,r);
     x:=R.cx;
     y:=R.dx
end;

{ *** INDICA A TECLA DO RATO QUE FOI PREMIDA : 0 - NENHUMA         *** }
{                                              1 - TECLA ESQUERDA      }
{                                              2 - TECLA DIREITA       }
{ Syntax : integer := Ratotec }

Function Ratotec:integer;
Var r:Registers;
Begin
     r.ax:=03;
     Intr($33,r);
     ratotec:=r.bx
end;

{ *** ESCONDE O RATO *** }
{ Syntax : Escrato }

Procedure Escrato;
Var r:Registers;
Begin
     r.ax:=02;
     intr($33,r)
end;

{ *** DEFINE UMA JANELA DE TRABALHO PARA O RATO *** }
{ Syntax : Definir ( xi , yi , xf , yf ) }

Procedure Definir(xi,yi,xf,yf:integer);
Var r:Registers;
Begin
     r.ax:=7;
     r.cx:=xi;
     r.dx:=xf;
     intr($33,r);
     r.ax:=8;
     r.cx:=yi;
     r.dx:=yf;
     intr($33,r)
end;

{ * VERIFICA A INSTALACAO DO RATO : TRUE - INSTALADO , FALSE - NAO INSTALADO * }
{ Syntax : boolean := Verrato }

Function Verrato:boolean;
Var r:Registers;
Begin
     verrato:=false;
     r.ax:=0;
     intr($33,r);
     if r.ax<>0 then verrato:=true
end;

{ *** COLOCA O CURSOR DO RATO NUMA DETERMINADA POSICAO *** }
{ Syntax : Ratocoord ( coordenada x , coordenada y ) }

Procedure Ratocoord(x,y:integer);
Var r:Registers;
Begin
     r.ax:=$4;
     r.cx:=x;
     r.dx:=y;
     intr($33,r)
end;

{ *** DETECTA A PRESENCA DO RATO NUMA DETERMINADA JANELA *** }
{ Syntax : boolean := Detecta( xi , yi , xf , yf ) }

Function Detecta(xi,yi,xf,yf:integer):boolean;
var x,y:integer;
Begin
     detecta:=false;ratopos(x,y);
     if (xi<x) and (xf>x) and (yi<y) and (yf>y) then detecta:=true
end;

{ *** ELABORA UMA TECLA *** }
{ Syntax : Tecla ( xi , yi , xf , yf , estado da tecla (true,false) ) }

Procedure Tecla(xi,yi,xf,yf:integer;estado:boolean);
Var cor1,cor2:integer;
Begin
     case estado of
      false:begin cor1:=white;cor2:=darkgray end;
      true:begin cor1:=darkgray;cor2:=white end
     end;
     setcolor(darkgray);
     rectangle(xi,yi,xf,yf);
     setfillstyle(1,lightgray);
     floodfill(xi+1,yi+1,darkgray);
     setcolor(cor1);
     line(xi+1,yi+1,xf-1,yi+1);
     line(xf-1,yi+1,xf-1,yf-1);
     setcolor(cor2);
     line(xi+1,yi+1,xi+1,yf-1);
     line(xi+1,yf-1,xf-1,yf-1)
end;

{ *** SINTETIZA O USO DO FLOODFILL *** }
{ Syntax : Pintar ( coordenada x , coordenada y , cor de pintura , cor limite ) }

Procedure Pintar(x,y,cor,corl:integer);
Begin
     setfillstyle(1,cor);
     floodfill(x,y,corl)
end;

{ *** FAZ O EFEITO DE PRESSéO DA TECLA *** }
{ NOTA : Este procedimento funciona em conjunto com o procedimento tecla }
{ Syntax : Marca ( xi , yi , xf , yf , estado de marca ( true , false) }


Procedure Marca(xi,yi,xf,yf:integer;est:boolean);
Var p:pointer;
    t:word;
Begin
     escrato;
     aim(xi+2,yi+2,xf-2,yf-3,p,t);
     tecla (xi,yi,xf,yf,est);
     putimage(xi+3,yi+3,p^,normalput);
     while ratotec=1 do begin end;
     tecla(xi,yi,xf,yf,not est);
     putimage(xi+2,yi+2,p^,normalput);
     freemem(p,t);
     rato
end;

Begin
end.


