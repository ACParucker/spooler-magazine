Uses Crt, Dos, Graph;

const h1=235; h2=302; h3=369;
      v1=260; v2=327; v3=396;

Var t : text;
    ch : char;
    x, y, jog, pri : byte;
    galo, cruz, bola : array[1..40,1..40] of byte;
    a, b, c, d, e, f, g, h, i : byte;
    k, n, mx, my, mb, m, maq, hum, njogos, phum, pmaq, empate : integer;
    r : registers;
    q : boolean;
    rnd : byte;



Procedure opengraph;
var Gd, Gm : Integer;
begin
 Gd := Detect;
 InitGraph(Gd, Gm, '');
 if GraphResult <> grOk then Halt(1);
end;


Procedure readbola;
begin
 x:=1; y:=1;
 assign(t, 'bola.gal');
 reset(t);
 while not eof(t) do
  begin
   read(t, ch);
   if (ch<>#13) and (ch<>#10) then
    begin
     bola[x,y]:=ord(ch)-176;
     x:=x+1;
     if x=41 then begin
                   x:=1; y:=y+1;
                  end;
    end;
  end;
 close(t);
end;


Procedure readcruz;
begin
 x:=1; y:=1;
 assign(t, 'cruz.gal');
 reset(t);
 while not eof(t) do
  begin
   read(t, ch);
   if (ch<>#13) and (ch<>#10) then
    begin
     cruz[x,y]:=ord(ch)-176;
     x:=x+1;
     if x=41 then begin
                   x:=1; y:=y+1;
                  end;
    end;
  end;
 close(t);
end;


Procedure readgalo;
begin
 x:=1; y:=1;
 assign(t, 'galo.gal');
 reset(t);
 while not eof(t) do
  begin
   read(t, ch);
   if (ch<>#13) and (ch<>#10) then
    begin
     galo[x,y]:=ord(ch)-176;
     x:=x+1;
     if x=41 then begin
                   x:=1; y:=y+1;
                  end;
    end;
  end;
 close(t);
end;


procedure putbola(a, b : integer);
begin
 for y:=1 to 40 do
  begin
   for x:=1 to 40 do
    begin
     putpixel(x+a,y+b,bola[x,y]);
    end;
  end;
 q:=true;
 sound(100);
 delay(5);
 nosound;
end;


procedure putcruz(a, b : integer);
begin
 for y:=1 to 40 do
  begin
   for x:=1 to 40 do
    begin
     putpixel(x+a,y+b,cruz[x,y]);
    end;
  end;
 q:=false;
 sound(100);
 delay(5);
 nosound;
end;


procedure putgalo(a, b : integer);
begin
 for y:=1 to 40 do
  begin
   for x:=1 to 40 do
    begin
     putpixel(x+a,y+b,galo[x,y]);
    end;
  end;
end;


procedure apresentacao;
begin
 if pri=0 then begin
 cleardevice;
 for k:=1 to 5000 do
  begin
   putpixel(random(getmaxx),random(getmaxy),lightgray);
  end;


 setcolor(lightgreen);
 SetTextStyle(3, HorizDir, 10);
 outtextxy(98,0,'O GALO');
 SetTextStyle(3, HorizDir, 2);
 outtextxy(266,150,'Versao 2.0');
 setcolor(lightblue);
 outtextxy(235,190,'Por Tiago Santos');

 setcolor(lightgray);
 for k:=400 to 450 do
  line(40,k,80,k);
 putgalo(40,400);
 for k:=400 to 450 do
  line(560,k,600,k);
 putgalo(560,400);
 setcolor(lightgreen);
 SetTextStyle(1, HorizDir, 1);
 outtextxy(41,380,'AJUDA');
 outtextxy(557,380,'ACERCA');

 end;


 setcolor(lightgray);
 for k:=250 to 450 do
  line(220,k,420,k);

 setcolor(black);
 line(240,317,400,317);
 line(240,384,400,384);
 line(287,270,287,430);
 line(354,270,354,430);
end;


procedure openmouse;
begin
 r.ax:=1;
  intr($33,r);
end;


procedure closemouse;
begin
 r.ax:=2;
  intr($33,r);
end;


procedure mousestate;
begin
 r.ax:=3;
  intr($33,r);
 mx:=r.cx;
 my:=r.dx;
 mb:=r.bx;
end;


procedure ajuda;
begin
 setcolor(lightgray);
 for k:=250 to 350 do
  line(40,k,190,k);

 setcolor(lightgreen);
 outtextxy(45,260,'     `O GALO`     ');
 outtextxy(45,270,'                  ');
 outtextxy(45,280,'  Usar o rato para');
 outtextxy(45,290,'movimentar a seta,');
 outtextxy(45,300,'e o botao esquerdo');
 outtextxy(45,310,'para escolher.    ');
 outtextxy(45,330,'  ESC para sair.  ');
 openmouse;
 repeat
  mousestate;
 until mb=2;
 closemouse;

 setcolor(black);
 for k:=250 to 350 do
  line(40,k,190,k);
 for k:=1 to 250 do
   putpixel(random(150)+40,random(100)+250,lightgray);
end;


procedure acerca;
begin
 setcolor(lightgray);
 for k:=250 to 350 do
  line(450,k,600,k);

 setcolor(lightgreen);
 outtextxy(455,260,'     `O GALO`     ');
 outtextxy(455,270,'    Versao 2.0    ');
 outtextxy(455,300,'   Tiago Santos   ');
 outtextxy(455,320,'Apartado 183      ');
 outtextxy(455,330,'Rebelva-Carcavelos');
 outtextxy(455,340,'2775 Parede       ');
 openmouse;
 repeat
  mousestate;
 until mb=2;
 closemouse;

 setcolor(black);
 for k:=250 to 350 do
  line(450,k,600,k);
 for k:=1 to 250 do
  putpixel(random(150)+450,random(100)+250,lightgray);
end;


procedure inic;
begin
 a:=0; b:=a; c:=b;
 d:=c; e:=d; f:=e;
 g:=f; h:=g; i:=h;
 jog:=0;
 pri:=0;
end;


procedure computador;
begin

 if q=false then begin

 if (a=0) and (b=2) and (c=2) and (q=false) then begin
                                    a:=2;
                                    putbola(h1,v1);
                                    jog:=jog+1;
                                   end;
 if (a=2) and (b=0) and (c=2) and (q=false) then begin
                                    b:=2;
                                    putbola(h2,v1);
                                    jog:=jog+1;
                                   end;
 if (a=2) and (b=2) and (c=0) and (q=false) then begin
                                    c:=2;
                                    putbola(h3,v1);
                                    jog:=jog+1;
                                   end;

 if (d=0) and (e=2) and (f=2) and (q=false) then begin
                                    d:=2;
                                    putbola(h1,v2);
                                    jog:=jog+1;
                                   end;
 if (d=2) and (e=0) and (f=2) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (d=2) and (e=2) and (f=0) and (q=false) then begin
                                    f:=2;
                                    putbola(h3,v2);
                                    jog:=jog+1;
                                   end;

 if (g=0) and (h=2) and (i=2) and (q=false) then begin
                                    g:=2;
                                    putbola(h1,v3);
                                    jog:=jog+1;
                                   end;
 if (g=2) and (h=0) and (i=2) and (q=false) then begin
                                    h:=2;
                                    putbola(h2,v3);
                                    jog:=jog+1;
                                   end;
 if (g=2) and (h=2) and (i=0) and (q=false) then begin
                                    i:=2;
                                    putbola(h3,v3);
                                    jog:=jog+1;
                                   end;



 if (a=0) and (d=2) and (g=2) and (q=false) then begin
                                    a:=2;
                                    putbola(h1,v1);
                                    jog:=jog+1;
                                   end;
 if (a=2) and (d=0) and (g=2) and (q=false) then begin
                                    d:=2;
                                    putbola(h1,v2);
                                    jog:=jog+1;
                                   end;
 if (a=2) and (d=2) and (g=0) and (q=false) then begin
                                    g:=2;
                                    putbola(h1,v3);
                                    jog:=jog+1;
                                   end;

 if (b=0) and (e=2) and (h=2) and (q=false) then begin
                                    b:=2;
                                    putbola(h2,v1);
                                    jog:=jog+1;
                                   end;
 if (b=2) and (e=0) and (h=2) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (b=2) and (e=2) and (h=0) and (q=false) then begin
                                    h:=2;
                                    putbola(h2,v3);
                                    jog:=jog+1;
                                   end;

 if (c=0) and (f=2) and (i=2) and (q=false) then begin
                                    c:=2;
                                    putbola(h3,v1);
                                    jog:=jog+1;
                                   end;
 if (c=2) and (f=0) and (i=2) and (q=false) then begin
                                    f:=2;
                                    putbola(h3,v2);
                                    jog:=jog+1;
                                   end;
 if (c=2) and (f=2) and (i=0) and (q=false) then begin
                                    i:=2;
                                    putbola(h3,v3);
                                    jog:=jog+1;
                                   end;

 if (a=0) and (e=2) and (i=2) and (q=false) then begin
                                    a:=2;
                                    putbola(h1,v1);
                                    jog:=jog+1;
                                   end;
 if (a=2) and (e=0) and (i=2) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (a=2) and (e=2) and (i=0) and (q=false)then begin
                                    i:=2;
                                    putbola(h3,v3);
                                    jog:=jog+1;
                                   end;

 if (c=0) and (e=2) and (g=2) and (q=false) then begin
                                    c:=2;
                                    putbola(h3,v1);
                                    jog:=jog+1;
                                   end;
 if (c=2) and (e=0) and (g=2) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (c=2) and (e=2) and (g=0) and (q=false) then begin
                                    g:=2;
                                    putbola(h1,v3);
                                    jog:=jog+1;
                                   end;

 end;

{***********}

 if q=false then begin

 if (a=0) and (b=1) and (c=1) and (q=false) then begin
                                    a:=2;
                                    putbola(h1,v1);
                                    jog:=jog+1;
                                   end;
 if (a=1) and (b=0) and (c=1) and (q=false) then begin
                                    b:=2;
                                    putbola(h2,v1);
                                    jog:=jog+1;
                                   end;
 if (a=1) and (b=1) and (c=0) and (q=false) then begin
                                    c:=2;
                                    putbola(h3,v1);
                                    jog:=jog+1;
                                   end;

 if (d=0) and (e=1) and (f=1) and (q=false) then begin
                                    d:=2;
                                    putbola(h1,v2);
                                    jog:=jog+1;
                                   end;
 if (d=1) and (e=0) and (f=1) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (d=1) and (e=1) and (f=0) and (q=false) then begin
                                    f:=2;
                                    putbola(h3,v2);
                                    jog:=jog+1;
                                   end;

 if (g=0) and (h=1) and (i=1) and (q=false) then begin
                                    g:=2;
                                    putbola(h1,v3);
                                    jog:=jog+1;
                                   end;
 if (g=1) and (h=0) and (i=1) and (q=false) then begin
                                    h:=2;
                                    putbola(h2,v3);
                                    jog:=jog+1;
                                   end;
 if (g=1) and (h=1) and (i=0) and (q=false) then begin
                                    i:=2;
                                    putbola(h3,v3);
                                    jog:=jog+1;
                                   end;



 if (a=0) and (d=1) and (g=1) and (q=false) then begin
                                    a:=2;
                                    putbola(h1,v1);
                                    jog:=jog+1;
                                   end;
 if (a=1) and (d=0) and (g=1) and (q=false) then begin
                                    d:=2;
                                    putbola(h1,v2);
                                    jog:=jog+1;
                                   end;
 if (a=1) and (d=1) and (g=0) and (q=false) then begin
                                    g:=2;
                                    putbola(h1,v3);
                                    jog:=jog+1;
                                   end;

 if (b=0) and (e=1) and (h=1) and (q=false) then begin
                                    b:=2;
                                    putbola(h2,v1);
                                    jog:=jog+1;
                                   end;
 if (b=1) and (e=0) and (h=1) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (b=1) and (e=1) and (h=0) and (q=false) then begin
                                    h:=2;
                                    putbola(h2,v3);
                                    jog:=jog+1;
                                   end;

 if (c=0) and (f=1) and (i=1) and (q=false) then begin
                                    c:=2;
                                    putbola(h3,v1);
                                    jog:=jog+1;
                                   end;
 if (c=1) and (f=0) and (i=1) and (q=false) then begin
                                    f:=2;
                                    putbola(h3,v2);
                                    jog:=jog+1;
                                   end;
 if (c=1) and (f=1) and (i=0) and (q=false) then begin
                                    i:=2;
                                    putbola(h3,v3);
                                    jog:=jog+1;
                                   end;

 if (a=0) and (e=1) and (i=1) and (q=false) then begin
                                    a:=2;
                                    putbola(h1,v1);
                                    jog:=jog+1;
                                   end;
 if (a=1) and (e=0) and (i=1) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (a=1) and (e=1) and (i=0) and (q=false) then begin
                                    i:=2;
                                    putbola(h3,v3);
                                    jog:=jog+1;
                                   end;

 if (c=0) and (e=1) and (g=1) and (q=false) then begin
                                    c:=2;
                                    putbola(h3,v1);
                                    jog:=jog+1;
                                   end;
 if (c=1) and (e=0) and (g=1) and (q=false) then begin
                                    e:=2;
                                    putbola(h2,v2);
                                    jog:=jog+1;
                                   end;
 if (c=1) and (e=1) and (g=0) and (q=false) then begin
                                    g:=2;
                                    putbola(h1,v3);
                                    jog:=jog+1;
                                   end;

 end;

 {********}

 if q=false then begin

   rnd:=random(9)+1;

   if e=0 then rnd:=5;

   if (rnd=1) and (a=0) then begin
                              a:=2;
                              putbola(h1,v1);
                              jog:=jog+1;
                             end;
   if (rnd=2) and (b=0) then begin
                              b:=2;
                              putbola(h2,v1);
                              jog:=jog+1;
                             end;
   if (rnd=3) and (c=0) then begin
                              c:=2;
                              putbola(h3,v1);
                              jog:=jog+1;
                             end;

   if (rnd=4) and (d=0) then begin
                              d:=2;
                              putbola(h1,v2);
                              jog:=jog+1;
                             end;
   if (rnd=5) and (e=0) then begin
                              e:=2;
                              putbola(h2,v2);
                              jog:=jog+1;
                             end;
   if (rnd=6) and (f=0) then begin
                              f:=2;
                              putbola(h3,v2);
                              jog:=jog+1;
                             end;

   if (rnd=7) and (g=0) then begin
                              g:=2;
                              putbola(h1,v3);
                              jog:=jog+1;
                             end;
   if (rnd=8) and (h=0) then begin
                              h:=2;
                              putbola(h2,v3);
                              jog:=jog+1;
                             end;
   if (rnd=9) and (i=0) then begin
                              i:=2;
                              putbola(h3,v3);
                              jog:=jog+1;
                             end;
  end;

end;



begin
 randomize;
 inic;
 readbola;
 readcruz;
 readgalo;

 opengraph;
 apresentacao;
 r.ax:=0;
  intr($33,r);
 openmouse;

 maq:=0; hum:=0; njogos:=0; empate:=0;
 q:=true;

  while ch<>#27 do
   begin
    if keypressed then ch:=readkey;
    mousestate;
    if mb=1 then begin
                 closemouse;

                 if (mx>40) and (mx<80) and (my>400) and (my<457) then ajuda;
                 if (mx>560) and (mx<600) and (my>400) and (my<457) then acerca;

                 if q=true then begin
                  if (mx>240) and (mx<287) and (my>270) and (my<317) and (a=0) then
                   begin
                    a:=1;
                    putcruz(h1,v1);
                    jog:=jog+1;
                   end;
                  if (mx>287) and (mx<354) and (my>270) and (my<317) and (b=0) then
                   begin
                    b:=1;
                    putcruz(h2,v1);
                    jog:=jog+1;
                   end;
                  if (mx>354) and (mx<400) and (my>270) and (my<317) and (c=0) then
                   begin
                    c:=1;
                    putcruz(h3,v1);
                    jog:=jog+1;
                   end;
                  if (mx>240) and (mx<287) and (my>317) and (my<384) and (d=0) then
                   begin
                    d:=1;
                    putcruz(h1,v2);
                    jog:=jog+1;
                   end;
                  if (mx>287) and (mx<354) and (my>317) and (my<384) and (e=0) then
                   begin
                    e:=1;
                    putcruz(h2,v2);
                    jog:=jog+1;
                   end;
                  if (mx>354) and (mx<400) and (my>317) and (my<384) and (f=0) then
                   begin
                    f:=1;
                    putcruz(h3,v2);
                    jog:=jog+1;
                   end;
                  if (mx>240) and (mx<287) and (my>384) and (my<430) and (g=0) then
                   begin
                    g:=1;
                    putcruz(h1,v3);
                    jog:=jog+1;
                   end;
                  if (mx>287) and (mx<354) and (my>384) and (my<430) and (h=0) then
                   begin
                    h:=1;
                    putcruz(h2,v3);
                    jog:=jog+1;
                   end;
                  if (mx>354) and (mx<400) and (my>384) and (my<430) and (i=0) then
                   begin
                    i:=1;
                    putcruz(h3,v3);
                    jog:=jog+1;
                   end;
                 end;

               openmouse;
              end;


    if (a=1) and (b=a) and (c=a) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v1); putgalo(h2,v1); putgalo(h3,v1);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;
    if (d=1) and (e=d) and (f=d) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v2); putgalo(h2,v2); putgalo(h3,v2);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;
    if (g=1) and (h=g) and (i=g) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v3); putgalo(h2,v3); putgalo(h3,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;

    if (a=1) and (d=a) and (g=a) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v1); putgalo(h1,v2); putgalo(h1,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;
    if (b=1) and (e=b) and (h=b) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h2,v1); putgalo(h2,v2); putgalo(h2,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;
    if (c=1) and (f=c) and (i=c) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h3,v1); putgalo(h3,v2); putgalo(h3,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;

    if (a=1) and (e=a) and (i=a) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v1); putgalo(h2,v2); putgalo(h3,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;
    if (c=1) and (e=c) and (g=c) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v3); putgalo(h2,v2); putgalo(h3,v1);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       hum:=hum+1; njogos:=njogos+1;
                                      end;


    {**********}


    if (a=2) and (b=a) and (c=a) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v1); putgalo(h2,v1); putgalo(h3,v1);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;
    if (d=2) and (e=d) and (f=d) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v2); putgalo(h2,v2); putgalo(h3,v2);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;
    if (g=2) and (h=g) and (i=g) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v3); putgalo(h2,v3); putgalo(h3,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;

    if (a=2) and (d=a) and (g=a) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v1); putgalo(h1,v2); putgalo(h1,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;
    if (b=2) and (e=b) and (h=b) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h2,v1); putgalo(h2,v2); putgalo(h2,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;
    if (c=2) and (f=c) and (i=c) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h3,v1); putgalo(h3,v2); putgalo(h3,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;

    if (a=2) and (e=a) and (i=a) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v1); putgalo(h2,v2); putgalo(h3,v3);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;
    if (c=2) and (e=c) and (g=c) then begin
                                       closemouse;
                                       sound(1000); delay(10); nosound;
                                       delay(500);
                                       putgalo(h1,v3); putgalo(h2,v2); putgalo(h3,v1);
                                       delay(2500); inic; pri:=1; apresentacao; openmouse;
                                       maq:=maq+1; njogos:=njogos+1;
                                      end;


    if q=false then begin
                     closemouse;
                     computador;
                     openmouse;
                    end;

    if jog>=9 then begin
                    closemouse;
                    delay(2500);
                    inic;
                    pri:=1;
                    apresentacao;
                    openmouse;
                    empate:=empate+1;
                    njogos:=njogos+1;
                   end;
   end;

 closemouse;
 CloseGraph;
 if njogos>0 then begin
 writeln('- Em ',njogos,' jogos o computador ganhou ',maq,', voce ganhou ',hum,' e empataram ',empate,'.');
 if njogos>empate then
 begin
 phum:=(100*hum) div (njogos-empate);
 pmaq:=100-phum;
 writeln('- Dos ',njogos-empate,' jogos em que nao existiu empate o computador obteve uma classificacao');
 writeln('  de ',pmaq,'% e voce obteve ',phum,'%.');
 end;
 writeln;
 end;
 writeln('O GALO  Versao 2.0  por  Tiago Santos');
end.

