Unit PFA;

Interface

Uses crt,dos;

Const
     ligado=true;
     desligado=false;

Type Video_buffer=array[1..80,1..25] of record
                                         coord:char;
                                         cor:integer
                                        end;

Var xin,yin,xfi,yfi:integer;
    vdi:Video_buffer;

Procedure paracima(x,y,xf,yf,nl,cor:integer);
Procedure parabaixo(x,y,xf,yf,nl,cor:integer);
Procedure ler(var car:char;var code:integer);
Function Lertec(x,y,t:integer):string;
Procedure cursor(c:boolean);
Function detcar(x,y:integer;var c:integer):char;
Procedure tamcur(i,f:byte);
Procedure letr(x,y,v:byte;s:string);
Procedure tabular(xi,xf,y:integer;s:string);
Procedure cores(t,f:byte);
Function verifica(s:string):boolean;
Function Procura(s,s2:string):boolean;
Function existe(s:string):boolean;
Procedure limpaarea(x,y,xf,yf:byte);
Procedure enchearea(x,y,xf,yf:byte;ch:char);
Procedure enche3d(x,y,xf,yf,c1,c2:integer;f:char);
Procedure caixa(x,y,xf,yf,cor,corf:integer;estl:byte);
Procedure apanha_bloco(xi,yi,xf,yf:integer);
Procedure repoe_bloco;
Function npl(i:longint):string;
Function lpn(s:string):longint;
Function premir:char;

Implementation

Procedure paracima(x,y,xf,yf,nl,cor:integer);
Var R:Registers;
Begin
     R.AH:=$06;
     R.AL:=nl;
     R.BH:=cor;
     R.CH:=y-1;
     R.CL:=x-1;
     R.DH:=yf-1;
     R.DL:=xf-1;
     Intr($10,R)
end;

Procedure parabaixo(x,y,xf,yf,nl,cor:integer);
Var R:Registers;
Begin
     R.AH:=$07;
     R.AL:=nl;
     R.BH:=cor;
     R.CH:=y-1;
     R.CL:=x-1;
     R.DH:=yf-1;
     R.DL:=xf-1;
     Intr($10,R)
end;

Procedure ler(var car:char;var code:integer);
Var R:Registers;
Begin
     R.ah:=00;Intr($16,R);car:=chr(R.al);code:=R.ah
end;


Function Lertec(x,y,t:integer):string;
Type palavra=array[1..101]of char;

Var s:string;
    car:char;
    code,xm,ym,c:integer;
    p:palavra;

Begin
     Gotoxy(x,y);Writeln('Û');
     For code:=1 to t do
         begin p[code]:=' ' end;
     xm:=x;ym:=y;c:=1;
     repeat
           Ler(car,code);car:=Upcase(car);
           if car=chr(8) then
                             begin
                                  if x>xm then
                                              begin
                                                   x:=x-1;c:=c-1;p[c]:=' ';
                                                   Gotoxy(x,y);Writeln('Û ')
                                               end
                             end
                         else
           if (code=28)
           or (code=1) then
                          else
                             begin
                                  if c=t+1 then else begin
                                                         Gotoxy(x,y);Writeln(car,'Û');p[c]:=car;
                                                    end;
                                  if c>=t+1 then begin
                                                     x:=xm+t;c:=t+1
                                                 end
                                                    else
                                                begin
                                                     x:=x+1;c:=c+1
                                                end;
                             end;
     until (code=28) or (code=1);
     s:='';Gotoxy(x,y);Writeln(' ');
     For x:=1 to c do
         begin
              s:=s+p[x]
         end;
     delete(s,length(s),length(s));
     case code of
      28:Lertec:=s;
      1:Lertec:='sai'
     end;
end;

Procedure cursor(c:boolean);
Var R:Registers;
Begin
     Case c of
      ligado:
             Begin
              R.ah:=$01;
              R.ch:=06;
              R.cl:=07;
              Intr($10,R)
             end;
      desligado:
                Begin
                 R.ah:=$01;
                 R.ch:=244;
                 Intr($10,R)
                end;
     end;

end;

Function detcar(x,y:integer;var c:integer):char;
Var R:Registers;
Begin
     Gotoxy(x,y);
     R.ah:=$08;
     R.bh:=0;
     Intr($10,R);
     detcar:=chr(R.al);c:=R.ah
end;

Procedure tamcur(i,f:byte);
Var R:Registers;
Begin
     R.Ah:=$01;
     R.Ch:=i;
     R.Cl:=f;
     Intr($10,R)
end;

Procedure letr(x,y,v:byte;s:string);
Var aux:integer;
Begin
     aux:=1;
     Repeat
      Gotoxy(x,y);Writeln(s[aux]);
      Gotoxy(x+1,y);Writeln('Û');
      Sound(50);delay(v);Nosound;
      inc(x);inc(aux);
      if x>79 then begin
                    Gotoxy(x,y);Writeln(' ');
                    x:=1;inc(y)
                   end
     until aux>length(s);
     Gotoxy(x,y);Writeln(' ');
     Writeln
end;

Procedure tabular(xi,xf,y:integer;s:string);
Var aux:integer;
Begin
     aux:=length(s);
     Gotoxy(xi+(abs(((xf-xi) div 2)-(aux div 2))),y);
     Write(s)
end;

Procedure cores(t,f:byte);
Begin
     Textcolor(t);
     Textbackground(f)
end;

Function verifica(s:string):boolean;
Var x:integer;
Begin
     verifica:=false;
     For x:=1 to length(s) do
      begin
       if s[x] in ['1','2','3','4','5','6','7','8','9','0','.','-'] then
           begin verifica:=true;x:=length(s) end
      end;
end;

Function Procura(s,s2:string):boolean;

Var x,c,a:integer;
    b:boolean;

Begin
     b:=false;a:=0;
     For x:=1 to length(s) do
         begin
              if s[x]=s2[1] then
                                begin
                                     a:=x;a:=a-1;
                                     For c:=1 to length(s2) do
                                         begin
                                              If s[a+c]<>s2[c] then
                                                                   begin
                                                                        b:=false;
                                                                        c:=length(s2)
                                                                   end
                                                               else b:=true
                                         end;
                                end;
              if b=true then x:=length(s)
         end;
     Procura:=b
end;

Function existe(s:string):boolean;
Begin
     existe:=false;
     if fsearch(s,getenv('PATH'))<>'' then existe:=true
end;

Procedure limpaarea(x,y,xf,yf:byte);
Var a:string;
    c:byte;
Begin
     a:='';
     For c:=x to xf do
       a:=a+' ';
     For c:=y to yf do
       begin
        Gotoxy(x,c);Write(a)
       end
end;

Procedure enchearea(x,y,xf,yf:byte;ch:char);
Var a:string;
    c:byte;
Begin
     a:='';
     For c:=x to xf do
       a:=a+ch;
     For c:=y to yf do
       begin
        Gotoxy(x,c);Write(a)
       end
end;

Procedure enche3d(x,y,xf,yf,c1,c2:integer;f:char);
Var aux:string;
    aux2:integer;
Begin
     aux:='';
     Textcolor(c2);
     For aux2:=x to xf do
      begin
       aux:=aux+f;
       Gotoxy(aux2+2,yf+1);Write(f);
      end;
     Gotoxy(xf+1,yf+1);Write(f);
     For aux2:=y to yf do
      begin
       Textcolor(c1);
       Gotoxy(x,aux2);Write(aux);
       Textcolor(c2);
       Gotoxy(xf+1,aux2+1);Write(f,f)
      end
end;

Procedure caixa(x,y,xf,yf,cor,corf:integer;estl:byte);
Var aux:integer;
    c1,c2,c3,c4,lh,lv:char;
Begin
     case estl of
      1:begin c1:='É';c2:='»';c3:='È';c4:='¼';lh:='Í';lv:='º' end;
      2:begin c1:='Ú';c2:='¿';c3:='À';c4:='Ù';lh:='Ä';lv:='³' end;
      3:begin c1:='Õ';c2:='¸';c3:='Ô';c4:='¾';lh:='Í';lv:='³' end;
      4:begin c1:='Ö';c2:='·';c3:='Ó';c4:='½';lh:='Ä';lv:='º' end
     end;
     cores(cor,corf);
     For aux:=x+1 to xf-1 do
      begin
       Gotoxy(aux,y);Write(lh);
       Gotoxy(aux,yf);Write(lh)
      end;
     For aux:=y+1 to yf-1 do
      begin
       Gotoxy(x,aux);Write(lv);
       Gotoxy(xf,aux);Write(lv)
      end;
     Gotoxy(x,y);Write(c1);
     Gotoxy(xf,y);Write(c2);
     Gotoxy(x,yf);Write(c3);
     Gotoxy(xf,yf);Write(c4)
end;

Procedure apanha_bloco(xi,yi,xf,yf:integer);
Var cor,px,py:integer;
Begin
     For px:=xi to xf do
      begin
       For py:=yi to yf do
        begin
         vdi[px,py].coord:=detcar(px,py,cor);
         vdi[px,py].cor:=cor
        end;
      end;
     xin:=xi;xfi:=xf;yin:=yi;yfi:=yf
end;

Procedure repoe_bloco;
Var px,py:integer;
Begin
     For px:=xin to xfi do
      begin
       For py:=yin to yfi do
        begin
         textattr:=vdi[px,py].cor;
         Gotoxy(px,py);Write(vdi[px,py].coord)
        end;
       end;
end;

Function npl(i:longint):string;
Var aux:string;
Begin str(i,aux);npl:=aux end;

Function lpn(s:string):longint;
Var aux,erco:integer;
Begin Val(s,aux,erco);lpn:=aux end;

Function premir:char;
Var c:char;
Begin if keypressed then c:=readkey else c:=#255;premir:=c end;

Begin
     xin:=0;xfi:=0;
     yin:=0;yfi:=0
end.