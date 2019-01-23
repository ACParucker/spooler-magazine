Unit utilites;
interface
Uses crt,graph,dos;

Type pal=record
          r,g,b:integer
         end;
     palt=array[0..15] of pal;

Var plt:palt;

Procedure ig(gd,gm:integer);
Procedure aim(xi,yi,xf,yf:integer;var p:pointer;var t:word);
Procedure jan(xi,yi,xf,yf,cor1,cor2,
cor,gro:integer;var p:pointer;var t:word);
Procedure jan2(xi,yi,xf,yf,cor1,cor2,
cor,gro:integer);
Procedure jan3(xi,yi,xf,yf,cor1,cor2,gro:integer);
Procedure jan4(xi,yi,xf,yf,cor:integer;var p:pointer;var t:word;s:string);
Procedure jan5(xi,yi,xf,yf,cor:integer;s:string);
Function lerl(x,y,t,cora,corl,tam:integer;ch:char):string;
Procedure escreve(x,y,cor:integer;s:string);
Procedure escreve2(x,y,cor:integer;s:string);
Procedure escreve3(x,y,cor,cor2:integer;s:string);
Procedure escreve4(x,y,cor:integer;s:string);
Procedure imagem(x,y:integer;s:string);
Procedure imagem2(s:string;var p:pointer;var t:word);
Procedure gravarim(x,y,xf,yf:integer;st:string);
Procedure imagem_t(s:string);
Procedure gravar_t(st:string);
Procedure inicrato;
Procedure rato;
Procedure Ratopos(var x,y:integer);
Function Ratotec:integer;
Procedure escrato;
Procedure definir(x,y,xf,yf:integer);
Function verrato:boolean;
Procedure ratocoord(x,y:integer);
Procedure tecla(x,y,xf,yf:integer;estado:boolean);
Procedure Pintar(x,y,cor,corl:integer);
Function detecta(xi,yi,xf,yf:integer):boolean;
Procedure fundo(cor1,cor2,cor3:integer);
Procedure marca(x,y,xf,yf:integer;est:boolean);
Procedure efesp(x,y,v,t,ca:integer;s:string;ch:char);
Procedure disco(x,y,xf,yf:longint;cord,corl,cors,corp,grossura:integer);
Procedure Palete(cor,r,g,b:integer);
Procedure coresRGB(cor:integer;var r,g,b:integer);
Procedure gr_palete(nome:string);
Procedure cr_palete(nome:string);

Implementation

{ *** INICIALIZA O MODO GRÜFICO *** }

Procedure ig(gd,gm:integer);
Begin
     Initgraph(gd,gm,'');
end;

{ *** CAPTURA UMA PARTE PRê-DEFENIDA DA IMAGEM *** }

Procedure aim(xi,yi,xf,yf:integer;var p:pointer;var t:word);
Begin
     t:=Imagesize(xi,yi,xf,yf);Getmem(p,t);
     Getimage(xi,yi,xf,yf,p^);
end;

{ *** DESENHA UMA JANELA E COM DETERMINADAS CORES E GUARDA O QUE ESTIVER POR BAIXO *** }

Procedure jan(xi,yi,xf,yf,cor1,cor2,cor,gro:integer;var p:pointer;var t:word);
Var x:integer;
Begin
     aim(xi,yi,xf,yf,p,t);
     For x:=1 to gro do
      begin
           Setcolor(cor1);
           Line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
           Setcolor(cor2);
           Line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     Setcolor(cor);
     For x:=yi+(gro+1) to yf-(gro+1) do
      begin
       Line(xi+(gro+1),x,xf-(gro+1),x);
      end;
     Setcolor(darkgray);
     rectangle(xi,yi,xf,yf);
end;

{ *** DESENHA O MESMO TIPO DE JANELA DO PROCEDIMENTO ANTERIOR MAS NAO GUARDA *** }
{ ***                         O QUE ESTIVER POR BAIXO                        *** }

Procedure jan2(xi,yi,xf,yf,cor1,cor2,cor,gro:integer);
Var x:integer;
Begin
     For x:=1 to gro do
      begin
           Setcolor(cor1);
           Line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
           Setcolor(cor2);
           Line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     Setcolor(cor);
     For x:=yi+(gro+1) to yf-(gro+1) do
      begin
       Line(xi+(gro+1),x,xf-(gro+1),x);
      end;
     Setcolor(darkgray);
     rectangle(xi,yi,xf,yf)
end;

{ *** DESENHA A MOLDURA DE UMA JANELA *** }

Procedure jan3(xi,yi,xf,yf,cor1,cor2,gro:integer);
Var x:integer;
Begin
     For x:=1 to gro do
      begin
           Setcolor(cor1);
           Line(xi+x,yi+x,xf-x,yi+x);Line(xf-x,yi+x,xf-x,yf-x);
           Setcolor(cor2);
           Line(xi+x,yi+x,xi+x,yf-x);Line(xi+x,yf-x,xf-x,yf-x)
      end;
     Setcolor(darkgray);
     rectangle(xi,yi,xf,yf)
end;

{ *** DESENHA UMA GAVETA (UTILIZADO NOS PROCEDIMENTOS POSTERIORES) *** }

Procedure gaveta(x,y:integer);
Begin
     Setcolor(darkgray);
     Line(x+5,y,x+30,y);
     Line(x+30,y,x+35,y+5);
     Line(x+35,y+5,x,y+5);
     Line(x,y+5,x+5,y);
     Line(x,y+5,x,y+15);
     Line(x,y+15,x+35,y+15);
     Line(x+35,y+15,x+35,y+5);
     Pintar(x+6,y+1,darkgray,darkgray);
     Pintar(x+5,y+6,cyan,darkgray);
     Line(x+10,y+10,x+25,y+10);
     Line(x+12,y+11,x+23,y+11)
end;

{ *** DESENHA OUTRO TIPO DE JANELA GUARDANDO O QUE ESTIVER POR BAIXO *** }

Procedure jan4(xi,yi,xf,yf,cor:integer;var p:pointer;var t:word;s:string);
Begin
     if (xi+40<xf) or (yi+20<yi) then
     begin
      aim(xi,yi,xf,yf,p,t);
      Setviewport(xi,yi,xf,yf,clipon);
      Clearviewport;
      Setviewport(0,0,getmaxx,getmaxy,clipon);
      Setcolor(darkgray);
      rectangle(xi,yi,xf,yf);
      Line(xi,yi+20,xf,yi+20);
      Line(xi+40,yi,xi+40,yi+20);
      Pintar(xi+1,yi+1,lightgray,darkgray);
      Pintar(xi+41,yi+1,lightgray,darkgray);
      Pintar(xi+1,yi+21,white,darkgray);
      Gaveta(xi+3,yi+2);
      Escreve2(xi+50,yi+5,cor,s)
     end;
end;

{ *** DESENHA O MESMO TIPO DE JANELA DO PROCEDIMENTO ANTERIOR MAS NAO GUARDA *** }
{ ***                       O QUE ESTIVER POR BAIXO                          *** }

Procedure jan5(xi,yi,xf,yf,cor:integer;s:string);
Begin
     if (xi+40<xf) or (yi+20<yi) then
     begin
      Setviewport(xi,yi,xf,yf,clipon);
      Clearviewport;
      Setviewport(0,0,getmaxx,getmaxy,clipon);
      Setcolor(darkgray);
      rectangle(xi,yi,xf,yf);
      Line(xi,yi+20,xf,yi+20);
      Line(xi+40,yi,xi+40,yi+20);
      Pintar(xi+1,yi+1,lightgray,darkgray);
      Pintar(xi+41,yi+1,lightgray,darkgray);
      Pintar(xi+1,yi+21,white,darkgray);
      Gaveta(xi+3,yi+2);
      Escreve2(xi+50,yi+5,cor,s)
     end;
end;

{ *** DESEMPENHA O MESMO PAPEL QUE O READLN EM MODO TEXTO *** }

Function Lerl(x,y,t,cora,corl,tam:integer;ch:char):string;

Type palavra=array[1..101]of char;

Procedure ler(var car:char;var code:integer);

Var R:Registers;

Begin
     R.ah:=00;Intr($16,R);car:=chr(R.al);code:=R.ah
end;

Procedure apagarl(x,y,tam:integer);

Var u:integer;

Begin
     For u:=y to y+tam do
         begin
              Setcolor(cora);
              Line(x,u,x+tam,u)
         end;
     Setcolor(corl)
end;

Var s:string;
    car:char;
    code,xm,ym,c:integer;
    p:palavra;

Begin
     For code:=1 to t do
         begin p[code]:=' ' end;
     xm:=x;ym:=y;c:=1;
     Setcolor(corl);
     Outtextxy(x,y,ch);
     repeat
           Setcolor(corl);
           Ler(car,code);car:=Upcase(car);
           if car=chr(8) then
                             begin
                                  if x>xm then
                                              begin
                                                   apagarl(x,y,tam);
                                                   x:=x-tam;c:=c-1;p[c]:=' ';
                                                   apagarl(x,y,tam);
                                                   Outtextxy(x,y,ch)
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
                                                         Outtextxy(x,y,car+ch);
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
                   Lerl:='sai'
                   else
                        begin
                         For x:=1 to (c-1) do
                          begin
                           s:=s+p[x]
                          end;
                         Lerl:=s
                        end;
end;

{ *** ESCREVA A FONTE DE ORIGEM DE MANEIRA DIFERENTE *** }

Procedure Escreve(x,y,cor:integer;s:string);
Begin
     Setcolor(white);
     Outtextxy(x,y+1,s);
     Outtextxy(x-1,y,s);
     Outtextxy(x-1,y+1,s);
     Setcolor(darkgray);
     Outtextxy(x+1,y,s);
     Outtextxy(x,y-1,s);
     Outtextxy(x+1,y-1,s);
     Setcolor(cor);
     Outtextxy(x+1,y,s)
end;

{ *** ESCREVE COM A FONTE DE ORIGEM DE MANEIRA DIFERENTE *** }

Procedure escreve2(x,y,cor:integer;s:string);
Begin
     Setcolor(darkgray);
     Outtextxy(x-1,y,s);
     Outtextxy(x+1,y,s);
     Outtextxy(x,y-1,s);
     Outtextxy(x,y+1,s);
     Outtextxy(x-1,y-1,s);
     Outtextxy(x+1,y-1,s);
     Outtextxy(x-1,y+1,s);
     Outtextxy(x+1,y+1,s);
     Setcolor(cor);
     Outtextxy(x,y,s)
end;

{ *** ESCREVE COM A FONTE DE ORIGEM DE MANEIRA DIFERENTE *** }

Procedure escreve3(x,y,cor,cor2:integer;s:string);
Begin
     Setcolor(cor);
     Outtextxy(x+2,y-2,s);
     Outtextxy(x+1,y-1,s);
     Outtextxy(x,y,s);
     Setcolor(cor2);
     Outtextxy(x-1,y+1,s)
end;

{ *** ESCREVE A FONTE DE ORIGEM DE MANEIRA DIFERENTE *** }

Procedure Escreve4(x,y,cor:integer;s:string);
Begin
     Setcolor(white);
     Outtextxy(x,y-2,s);
     Outtextxy(x+2,y,s);
     Outtextxy(x+2,y-2,s);
     Setcolor(darkgray);
     Outtextxy(x+1,y,s);
     Outtextxy(x,y-1,s);
     Outtextxy(x+1,y-1,s);
     Setcolor(cor);
     Outtextxy(x+1,y,s)
end;

{ *** CARREGA UMA IMAGEM ARMAZENADA EM DISCO PARA O ECRAN *** }

Procedure imagem(x,y:integer;s:string);

Label fim;

Var p:pointer;
    t:word;
    f:file;

Begin
     if fsearch(s,getenv('Path'))='' then goto fim;
     Assign(f,s);Reset(f,1);
     t:=filesize(f);
     Getmem(p,t);
     Blockread(f,p^,t);
     close(f);
     Putimage(x,y,p^,normalput);
     Freemem(p,t);
     fim:
end;

{ *** CARREGA UMA IMAGEM ARMAZENADA EM DISCO PARA UM APONTADOR *** }

Procedure imagem2(s:string;var p:pointer;var t:word);

Label fim;

Var f:file;

Begin
     if fsearch(s,getenv('Path'))='' then goto fim;
     Assign(f,s);Reset(f,1);
     t:=filesize(f);
     Getmem(p,t);
     Blockread(f,p^,t);
     close(f);
     fim:
end;

{ *** GRAVA UMA IMAGEM PARA O DISCO *** }

Procedure gravarim(x,y,xf,yf:integer;st:string);

var p:pointer;
    t:word;
    f:file;
Begin
     aim(x,y,xf,yf,p,t);
     Assign(f,st);Rewrite(f,1);
     Blockwrite(f,p^,t);
     close(f);
     Freemem(p,t)
end;

{ *** CARREGA UMA IMAGEM TOTAL , OU SEJA DE RESOLUÄéO MÜXIMA , PARA O ECRAN *** }

Procedure imagem_t(s:string);

Type pos=array[1..3] of integer;

Var f:file;
    p:pointer;
    t:word;
    ps:pos;
    ct,aux:integer;
Begin
     aux:=getmaxy div 3;
     ps[1]:=0;ps[2]:=aux;ps[3]:=aux*2;
     ct:=1;
     t:=Imagesize(0,0,getmaxx,aux);;
     if fsearch(s,getenv('Path'))<>'' then
         BEGIN
          Assign(f,s);Reset(f,1);
          Repeat
           Getmem(p,t);Blockread(f,p^,t);
           Putimage(0,ps[ct],p^,normalput);Freemem(p,t);inc(ct)
          until ct>3;
          close(f);
         END;
end;

{ **** GRAVA A IMAGEM TOTAL NUM FICHEIRO **** }

Procedure gravar_t(st:string);
Type pos=array[1..3] of record
                         inicio,fim:integer;
                        end;
var p:pointer;
    t:word;
    f:file;
    ps:pos;
    ct,aux:integer;
Begin
     aux:=getmaxy div 3;
     ps[1].inicio:=0;ps[1].fim:=aux;
     ps[2].inicio:=aux;ps[2].fim:=aux*2;
     ps[3].inicio:=aux*2;ps[3].fim:=getmaxy;ct:=1;
     t:=Imagesize(0,0,getmaxx,aux);
     Assign(f,st);Rewrite(f,1);
     Repeat
      aim(0,ps[ct].inicio,getmaxx,ps[ct].fim,p,t);
      Blockwrite(f,p^,t);Freemem(p,t);inc(ct)
     until ct>3;
     close(f);
end;

{ *** INICIALIZA O RATO *** }

Procedure Inicrato;
Var R:Registers;
Begin
     R.ax:=00;Intr($33,R);
end;

{ *** MOSTRA O CURSOR DO RATO *** }

Procedure Rato;
Var R:Registers;
Begin
     R.ax:=01;Intr($33,R)
end;

{ *** DEVOLVE A POSIÄéO ACTUAL DO RATO *** }

Procedure Ratopos(var x,y:integer);
Var R:Registers;
Begin
     R.ax:=03;Intr($33,R);
     x:=R.cx;y:=R.dx
end;

{ *** DEVOLVE O VALOR DA TECLA DO RATO PREMIDA *** }

Function Ratotec:integer;
Var R:Registers;
Begin
     R.ax:=03;Intr($33,R);
     Ratotec:=R.bx
end;

{ *** ESCONDE O CURSOR DO RATO *** }

Procedure escrato;
Var R:Registers;
Begin
     R.ax:=02;Intr($33,R)
end;

{ *** DEFINE UMA AREA DE TRABALHO PARA O RATO *** }

Procedure definir(x,y,xf,yf:integer);
Var R:Registers;
Begin
     R.ax:=7;R.cx:=x;R.dx:=xf;Intr($33,r);
     R.ax:=8;R.cx:=y;R.dx:=yf;Intr($33,r)
end;

{ *** VERIFICA A EXISTENCIA DO RATO *** }

Function verrato:boolean;
Var R:Registers;
Begin
     verrato:=false;
     R.ax:=0;
     Intr($33,r);
     if r.ax<>0 then verrato:=true
end;

{ *** POSICIONA O RATO NUMAS DETERMINADAS COORDENADAS *** }

Procedure ratocoord(x,y:integer);
Var R:Registers;
Begin
     R.ax:=$4;
     R.cx:=x;
     R.dx:=y;
     Intr($33,R)
end;

{ *** DESENHA UMA TECLA DO TIPO 'WINDOWS' *** }

Procedure tecla(x,y,xf,yf:integer;estado:boolean);
Var cor1,cor2:integer;
Begin
     case estado of
      false:begin cor1:=white;cor2:=darkgray end;
      true:begin cor1:=darkgray;cor2:=white end
     end;
     Setcolor(darkgray);
     Rectangle(x,y,xf,yf);
     Setfillstyle(1,lightgray);
     Floodfill(x+1,y+1,darkgray);
     Setcolor(cor1);
     Line(x+1,y+1,xf-1,y+1);
     Line(xf-1,y+1,xf-1,yf-1);
     Setcolor(cor2);
     Line(x+1,y+1,x+1,yf-1);
     Line(x+1,yf-1,xf-1,yf-1)
end;

{ *** PINTA UM OBJECTO *** }

Procedure Pintar(x,y,cor,corl:integer);
Begin
     Setfillstyle(1,cor);
     Floodfill(x,y,corl)
end;

{ *** DETECTA A PRESENÄA DO RATO NUMA DETERMINADA POSIÄéO *** }

Function detecta(xi,yi,xf,yf:integer):boolean;
var x,y:integer;
Begin
     detecta:=false;ratopos(x,y);
     if (xi<x) and (xf>x) and (yi<y) and (yf>y) then detecta:=true
end;

{ *** DESENHA UM FUNDO EM FORMA DE HORIZONTE *** }

Procedure fundo(cor1,cor2,cor3:integer);
Var x,m,y:integer;
Begin
     Setcolor(cor1);
     rectangle(0,0,getmaxx,150);
     Pintar(2,2,cor1,cor1);
     Setcolor(cor2);
     rectangle(0,150,getmaxx,getmaxy);
     Pintar(2,152,cor2,cor2);
     Setcolor(cor3);
     x:=150;m:=1;
     repeat
      Line(0,x,getmaxx,x);
      x:=x+m;m:=m+1;
     until x>getmaxy;
     x:=10;m:=-300;
     repeat
      Line(x,150,x+m,getmaxy);
      x:=x+10;m:=m+10;
     until x>getmaxx
end;

{ *** FAZ O EFEITO DE PRESSéO DUMA TECLA TIPO 'WINDOWS' *** }

Procedure marca(x,y,xf,yf:integer;est:boolean);
Var p:pointer;
    t:word;
Begin
     escrato;
     aim(x+2,y+2,xf-2,yf-3,p,t);
     tecla (x,y,xf,yf,est);
     Putimage(x+3,y+3,p^,normalput);
     while ratotec=1 do begin end;
     tecla(x,y,xf,yf,not est);
     Putimage(x+2,y+2,p^,normalput);
     freemem(p,t);
     rato
end;

{ *** FAZ UM EFEITO DE ESCRITA (LETRA A LETRA) *** }

Procedure efesp(x,y,v,t,ca:integer;s:string;ch:char);
Var aux,aux2,c:integer;
Begin
     For aux:=1 to length(s) do
      begin
       Outtextxy(x+((aux-1)*t),y,s[aux]);
       Outtextxy(x+(aux*t),y,ch);
       sound(100);delay(v);nosound;
       c:=Getcolor;Setcolor(ca);
       For aux2:=y to y+t do
         line(x+(aux*t),aux2,x+(aux*t)+t,aux2);
       Setcolor(c)
      end;
end;

{ *** DESENHA UMA DISQUETE COM CORES E TAMANHO DETERMINADO *** }

Procedure disco(x,y,xf,yf:longint;cord,corl,cors,corp,grossura:integer);
Var maxcurv,
    maxabertv,
    maxaberth,
    maxax,maxay,
    maxxp,maxyp:longint;
    aux:integer;
Begin
     if (abs(xf-x)>20) and
        (abs(yf-y)>20)
     then
      Begin
       Setviewport(x,y,xf,yf,Clipon);
       Clearviewport;
       Setviewport(0,0,getmaxx,getmaxy,Clipon);

       if xf<x then begin aux:=xf;xf:=x;x:=aux end;
       if yf<y then begin aux:=yf;yf:=y;y:=aux end;

       maxcurv:=((xf-x)*50) div getmaxx;
       maxaberth:=((xf-x)*339) div getmaxx;
       maxabertv:=((yf-y)*180) div getmaxy;
       maxax:=((xf-x)*60) div getmaxx;
       maxay:=((yf-y)*20) div getmaxy;
       maxxp:=((xf-x)*70) div getmaxx;
       maxyp:=((yf-y)*50) div getmaxy;

       { * DISQUETE * }

       Setcolor(cord);
       Line(x,y,xf-maxcurv,y);Line(xf-maxcurv,y,xf,y+maxcurv);
       Line(xf,y+maxcurv,xf,yf);Line(xf,yf,x,yf);Line(x,yf,x,y);
       pintar(x+3,y+3,cord,cord);

       For aux:=0 to grossura do
        begin
         Setcolor(corl);
         Line(x+aux,y+aux,xf-maxcurv,y+aux);
         Line(xf-maxcurv,y+aux,xf-aux,y+maxcurv+aux);
         Line(xf-aux,y+maxcurv+aux,xf-aux,yf-aux);
         Setcolor(cors);
         Line(xf-aux,yf-aux,x+aux,yf-aux);Line(x+aux,yf-aux,x+aux,y+aux);
        end;

       { * PLACA METALICA * }

       Setcolor(8);
       rectangle(x+ ((xf-x) div 2) - (maxaberth div 2),y,
                 x+ ((xf-x) div 2) + (maxaberth div 2),y+maxabertv);
       pintar( x+ (((xf-x) div 2) - (maxaberth div 2))+3,y+3,7,8);

       { * BURACO NA PLACA * }

       Setcolor(8);
       rectangle(x+((xf-x) div 2)+maxax,y+maxay,
                 x+((xf-x) div 2)+(2*maxax),y+maxabertv-maxay);
       pintar(x+(((xf-x) div 2)+maxax)+1,y+maxay+1,cord,8);

       { * PAPEL DA DISQUETE * }

       Setcolor(8);
       rectangle(x+maxxp,y+maxabertv+maxyp,xf-maxxp,yf-maxyp);
       pintar(x+maxxp+1,y+maxabertv+maxyp+1,corp,8)

      end;

end;

{ *** MODIFICA UMA DETERMINADA COR ATRAVêS DAS CORES VERMELHA, VERDE E AZUL *** }

Procedure Palete(cor,r,g,b:integer);
Begin
     if cor=6 then cor:=20 else
     if (cor>=8) and (cor<=15) then cor:=cor+48;
     Setrgbpalette(cor,r,g,b)
end;

{ *** CAPTURA AS TONALIDADES DE VERMELHO, VERDE E AZUL DE UMA COR *** }

Procedure coresRGB(cor:integer;var r,g,b:integer);
Var Reg:Registers;
Begin
     if cor=6 then cor:=20 else
     if (cor>=8) and (cor<=15) then cor:=cor+48;
     Reg.ax:=$1015;
     Reg.bx:=cor;
     Intr($10,Reg);
     g:=Reg.ch;
     b:=Reg.cl;
     r:=Reg.dh
end;

{ *** GRAVA UMA PALETE DE CORES *** }

Procedure gr_palete(nome:string);
Var f:file of palt;
    x:integer;
Begin
     For x:=0 to 15 do
       coresRGB(x,plt[x].r,plt[x].g,plt[x].b);
     Assign(f,nome+'.PAL');
     {$I-} Rewrite(f);
     Write(f,plt);
     Close(f) {$I+}
end;

{ *** CARREGA UMA PALETE DE CORES *** }

Procedure cr_palete(nome:string);
Var f:file of palt;
    x:integer;
Begin
     if FSearch(nome+'.PAL',GetEnv('PATH'))<>'' then
                                                 begin
                                                  Assign(f,nome+'.PAL');
                                                  Reset(f);
                                                  Read(f,plt);
                                                  Close(f);
                                                  For x:=0 to 15 do
                                                   Palete(x,plt[x].r,plt[x].g,plt[x].b)
                                                 end
end;

Begin
end.


