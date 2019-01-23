unit enfounit;
interface
uses crt,graph,dos;

type pal=record
          r,g,b:integer
         end;
     palt=array[0..15] of pal;

var plt:palt;
    xin,yin,xfi,yfi:integer;

procedure limpa_parte(x,y,xf,yf,cor:integer);
procedure ig(gd,gm:integer);
procedure aim(xi,yi,xf,yf:integer;var p:pointer;var t:word);
procedure jan(xi,yi,xf,yf,cor1,cor2,
cor,gro:integer;var p:pointer;var t:word);
procedure jan2(xi,yi,xf,yf,cor1,cor2,
cor,gro:integer);
function  lerl(x,y,t,cora,corl,tam:integer;ch:char):string;
procedure escreve(x,y,cor:integer;s:string);
procedure escreve2(x,y,cor:integer;s:string);
procedure escreve3(x,y,cor,cor2:integer;s:string);
procedure inicrato;
procedure rato;
procedure Ratopos(var x,y:integer);
function  Ratotec:integer;
procedure escrato;
procedure definir(x,y,xf,yf:integer);
procedure tecla(x,y,xf,yf:integer;estado:boolean);
function  detecta(xi,yi,xf,yf:integer):boolean;
procedure marca(x,y,xf,yf:integer;est:boolean);
procedure efesp(x,y,v,t,ca:integer;s:string;ch:char);
function  premir:char;

procedure Enter_para_continuar;
procedure mostra_enforcado;
procedure mostra_tecla1;
procedure apaga_tecla1;
procedure mostra_tecla2;
procedure apaga_tecla2;
procedure mostra_tecla3;
procedure apaga_tecla3;
procedure titulo_criar_optar;
procedure titulo_escolher_apagar;
procedure titulo_apagar_tema;
procedure janela_do_titulo;
procedure titulo_inserir;
procedure titulo_apagar;
procedure titulo_geral;
procedure letras;
procedure erros;


implementation


procedure limpa_parte(x,y,xf,yf,cor:integer);
var aux:integer;
begin
     setcolor(cor);
     for aux:=y to yf do
      line(x,aux,xf,aux)
end;

procedure ig(gd,gm:integer);
begin
     initgraph(gd,gm,'')
end;

procedure aim(xi,yi,xf,yf:integer;var p:pointer;var t:word);
begin
     t:=imagesize(xi,yi,xf,yf);getmem(p,t);
     getimage(xi,yi,xf,yf,p^)
end;

procedure jan(xi,yi,xf,yf,cor1,cor2,cor,gro:integer;var p:pointer;var t:word);
var x:integer;
begin
     aim(xi,yi,xf,yf,p,t);
     for x:=1 to gro do
      begin
           setcolor(cor1);
           line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
           setcolor(cor2);
           line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     setcolor(cor);
     for x:=yi+(gro+1) to yf-(gro+1) do
      begin
       line(xi+(gro+1),x,xf-(gro+1),x)
      end;
     setcolor(darkgray);
     rectangle(xi,yi,xf,yf)
end;

procedure jan2(xi,yi,xf,yf,cor1,cor2,cor,gro:integer);
var x:integer;
begin
     for x:=1 to gro do
      begin
           setcolor(cor1);
           line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
           setcolor(cor2);
           line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     setcolor(cor);
     for x:=yi+(gro+1) to yf-(gro+1) do
      begin
       line(xi+(gro+1),x,xf-(gro+1),x);
      end;
     setcolor(darkgray);
     rectangle(xi,yi,xf,yf)
end;


function lerl(x,y,t,cora,corl,tam:integer;ch:char):string;

type palavra=array[1..101]of char;

procedure ler(var car:char;var code:integer);

var r:registers;
begin
     r.ah:=00;intr($16,r);car:=chr(r.al);code:=r.ah
end;

procedure apagarl(x,y,tam:integer);

var u:integer;
begin
     for u:=y to y+tam do
         begin
              setcolor(cora);
              line(x,u,x+tam,u)
         end;
     setcolor(corl)
end;

var s:string;
    car:char;
    code,xm,ym,c:integer;
    p:palavra;

begin
     for code:=1 to t do
         begin p[code]:=' ' end;
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
                                  if c>=t+1 then begin
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
                          begin
                           s:=s+p[x]
                          end;
                         lerl:=s
                        end;
end;

procedure escreve(x,y,cor:integer;s:string);
begin
     setcolor(white);
     outtextxy(x,y+1,s);
     outtextxy(x-1,y,s);
     outtextxy(x-1,y+1,s);
     setcolor(darkgray);
     outtextxy(x+1,y,s);
     outtextxy(x,y-1,s);
     outtextxy(x+1,y-1,s);
     setcolor(cor);
     outtextxy(x+1,y,s)
end;

procedure escreve2(x,y,cor:integer;s:string);
begin
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

procedure escreve3(x,y,cor,cor2:integer;s:string);
begin
     setcolor(cor);
     outtextxy(x+2,y-2,s);
     outtextxy(x+1,y-1,s);
     outtextxy(x,y,s);
     setcolor(cor2);
     outtextxy(x-1,y+1,s)
end;

procedure inicrato;
var r:registers;
begin
     r.ax:=00;intr($33,r)
end;

procedure rato;
var r:registers;
begin
     r.ax:=01;Intr($33,r)
end;

procedure ratopos(var x,y:integer);
var r:registers;
begin
     r.ax:=03;intr($33,r);
     x:=r.cx;y:=r.dx
end;

function ratotec:integer;
var r:registers;
begin
     r.ax:=03;intr($33,R);
     ratotec:=r.bx
end;

procedure escrato;
var r:Registers;
begin
     r.ax:=02;intr($33,R)
end;

procedure definir(x,y,xf,yf:integer);
var r:registers;
begin
     r.ax:=7;r.cx:=x;r.dx:=xf;intr($33,r);
     r.ax:=8;r.cx:=y;r.dx:=yf;intr($33,r)
end;

procedure tecla(x,y,xf,yf:integer;estado:boolean);
var cor1,cor2:integer;
begin
     case estado of
      false:begin cor1:=white;cor2:=darkgray end;
      true:begin cor1:=darkgray;cor2:=white end
     end;
     setcolor(darkgray);
     rectangle(x,y,xf,yf);
     setfillstyle(1,lightgray);
     floodfill(x+1,y+1,darkgray);
     setcolor(cor1);
     line(x+1,y+1,xf-1,y+1);
     line(xf-1,y+1,xf-1,yf-1);
     setcolor(cor2);
     line(x+1,y+1,x+1,yf-1);
     line(x+1,yf-1,xf-1,yf-1)
end;

function detecta(xi,yi,xf,yf:integer):boolean;
var x,y:integer;
begin
     detecta:=false;ratopos(x,y);
     if (xi<x) and (xf>x) and (yi<y) and (yf>y) then detecta:=true
end;

procedure marca(x,y,xf,yf:integer;est:boolean);
var p:pointer;
    t:word;
begin
     escrato;
     aim(x+2,y+2,xf-2,yf-3,p,t);
     tecla (x,y,xf,yf,est);
     putimage(x+3,y+3,p^,normalput);
     while ratotec=1 do begin end;
     tecla(x,y,xf,yf,not est);
     putimage(x+2,y+2,p^,normalput);
     freemem(p,t);
     rato
end;

procedure efesp(x,y,v,t,ca:integer;s:string;ch:char);
var aux,aux2,c:integer;
begin
     for aux:=1 to length(s) do
      begin
       outtextxy(x+((aux-1)*t),y,s[aux]);
       outtextxy(x+(aux*t),y,ch);
       sound(100);delay(v);nosound;
       c:=getcolor;setcolor(ca);
       for aux2:=y to y+t do
         line(x+(aux*t),aux2,x+(aux*t)+t,aux2);
       setcolor(c)
      end;
end;

function premir:char;
var c:char;
begin if keypressed then c:=readkey else c:=#255;premir:=c end;

procedure Enter_para_continuar;
begin
      Settextstyle(0,0,1);
      setcolor(5);
      efesp(128,340,10,8,15,'Prima Space ou uma das teclas do rato para sair','_')
end;

procedure mostra_enforcado;
begin
     settextstyle(1,0,6);
     escreve3(178,20,6,10,'ENFORCADO')
end;

procedure mostra_tecla1;
begin
     settextstyle(1,0,1);
     tecla(40,40,155,70,false);
     escreve2(68,43,12,'T');
     escreve2(81,43,15,'emas');
end;

procedure apaga_tecla1;
begin
     limpa_parte(38,38,157,72,3)
end;

procedure mostra_tecla2;
begin
     settextstyle(1,0,1);
     tecla(486,40,601,70,false);
     escreve2(526,43,12,'S');
     escreve2(539,43,15,'air')
end;

procedure apaga_tecla2;
begin
     limpa_parte(484,38,603,72,3)
end;

procedure mostra_tecla3;
begin
     settextstyle(1,0,1);
     tecla(260,420,375,450,false);
     escreve2(274,423,12,'C');
     escreve2(287,423,15,'ontinuar')
end;

procedure apaga_tecla3;
begin
      limpa_parte(258,418,377,452,3)
end;

procedure  titulo_criar_optar;
begin
     cleardevice;
     jan2(0,0,getmaxx,70,11,1,3,2);
     jan2(0,getmaxy-70,getmaxx,getmaxy,11,1,3,2);
     jan2(20,60,getmaxx-20,getmaxx-200,1,1,9,2);
     settextstyle(1,0,4);
     escreve(40,7,12,'** CRIAR OU OPTAR POR UM TEMA **')
end;

procedure titulo_escolher_apagar;
begin
     cleardevice;
     jan2(0,0,getmaxx,70,11,1,3,2);
     jan2(0,getmaxy-70,getmaxx,getmaxy,11,1,3,2);
     jan2(20,60,getmaxx-20,getmaxx-200,1,1,9,2);
     settextstyle(1,0,4);
     escreve(108,7,12,'***  APAGAR PALAVRAS  ***')
end;

procedure titulo_apagar_tema;
begin
     cleardevice;
     jan2(0,0,getmaxx,70,11,1,3,2);
     jan2(0,getmaxy-70,getmaxx,getmaxy,11,1,3,2);
     jan2(20,60,getmaxx-20,getmaxx-200,1,1,9,2);
     settextstyle(1,0,4);
     escreve(140,7,12,'***  APAGAR TEMA  ***')
end;

procedure janela_do_titulo;
begin
       cleardevice;
      jan2(0,0,getmaxx,70,11,1,3,2);
      jan2(0,getmaxy-70,getmaxx,getmaxy,11,1,3,2);
      jan2(20,50,getmaxx-20,getmaxx-200,1,1,4,2);
      settextstyle(1,0,4)
end;

procedure titulo_inserir;
begin

      escreve(80,7,12,'****  INSERIR PALAVRAS  ****');
      Settextstyle(1,0,1);
      escreve2(86,70,10,'Palavras existentes');
      escreve2(390,70,10,'Palavras novas')
end;

procedure titulo_apagar;
begin
      escreve(90,7,12,'****  APAGAR PALAVRAS  ****');
      Settextstyle(1,0,1);
      escreve2(86,70,10,'Palavras existentes');
      escreve2(380,70,10,'Palavras a apagar')
end;


procedure titulo_geral;
begin
      jan2(76,110,getmaxx-364,getmaxy-60,1,1,15,2);
      jan2(360,110,getmaxx-80,getmaxy-140,1,1,15,2);
      settextstyle(1,0,1);
      tecla(405,145,520,175,false);
      escreve2(420,148,12,'C');
      escreve2(433,148,15,'ontinuar');
      tecla(405,280,520,310,false);
      escreve2(446,283,12,'S');
      escreve2(459,283,15,'air');
      definir(360,110,getmaxx-90,getmaxy-150)
end;

procedure letras;
begin
    tecla(110,170,250,210,false);
    settextstyle(1,0,1);
    escreve2(156,179,12,'J');
    escreve2(166,179,15,'ogar');
    tecla(370,170,510,210,false);
    escreve2(410,179,12,'O');
    escreve2(447,178,15,'~');
    escreve2(423,179,15,'p‡oes');
    tecla(110,270,250,310,false);
    escreve2(136,279,12,'Esc');
    escreve2(176,279,15,'/ Dos')
end;

(* Erros existentes , com diskete protegida, ficheiro  *)

procedure erros;
var saux:string;
    px:integer;
    c:char;
    p:pointer;
    w:word;
begin
     jan(100,200,getmaxx-100,250,15,4,12,2,p,w);
     saux:='**** ERRO NO DISCO OU DISCO PROTEGIDO ****';
     px:=100+((((getmaxx-100)-100) div 2)-((length(saux)*8) div 2));
     escreve2(px,220,14,saux);
     repeat c:=premir until (ratotec=1) or (ratotec=2) or ((ord(c)>=0) and (ord(c)<=122));
     putimage(100,200,p^,normalPut);
     freemem(p,w)
end;


begin
     xin:=0;xfi:=0;
     yin:=0;yfi:=0
end.


