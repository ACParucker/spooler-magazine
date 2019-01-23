procedure credits;                        {Escreve autor}
 begin
   for i:=230 to 450 do begin
     d:=random(2);
     if d=0 then usecolor(28) else usecolor(27);
     line(300,i,maxx-300,i);
   end;
   usecolor(0); for i:=1 to 2 do rectangle(300+i,230+i,maxx-300-i,450-i);
   usecolor(0);
   L_T(8,4); for i:=1 to 10 do outtextxy(420+i,260+i,'PUZZLE');
   usecolor(41); for i:=1 to 3 do outtextxy(416+i,260+i,'PUZZLE');
   usecolor(0); L_T(8,1); for i:=1 to 10 do outtextxy(555+i,275+i,'v 1.0');
   usecolor(41); for i:=1 to 3 do outtextxy(551+i,275+i,'v 1.0');
   usecolor(0); for i:=1 to 10 do outtextxy(410+i,330+i,'Programa‡„o & Arte');
   usecolor(27); for i:=1 to 3 do outtextxy(406+i,330+i,'Programa‡„o & Arte');
   usecolor(0); for i:=1 to 10 do outtextxy(450+i,360+i,'Rui Tempero');
   usecolor(27); for i:=1 to 3 do outtextxy(446+i,360+i,'Rui Tempero');
   l_t(10,1);
   usecolor(0); for i:=1 to 10 do outtextxy(395+i,425+i,'(C)1994, Rui Tempero Software');
   usecolor(30); for i:=1 to 3 do outtextxy(391+i,425+i,'(C)1994, Rui Tempero Software');
   tecla:=readkey; limpa;
 end;

procedure help;                          {Escreve teclas}
 begin
     for i:=230 to 450 do begin
     d:=random(2);
     if d=0 then usecolor(28) else usecolor(27);
     line(300,i,maxx-300,i);
   end;
   usecolor(0); for i:=1 to 2 do rectangle(300+i,230+i,maxx-300-i,450-i);
   L_T(8,3);
   usecolor(0); for i:=1 to 10 do outtextxy(475+i,230+i,'TECLAS');
   usecolor(41); for i:=1 to 3 do outtextxy(471+i,230+i,'TECLAS');
   usecolor(0); bar(370,290,400,320); x:=330; bar(330,390,450,420);
    for i:=0 to 2 do begin bar(x,330,x+30,360); inc(x,40); end;
   usecolor(26); bar(365,285,395,315); x:=325; bar(325,385,445,415);
    for i:=0 to 2 do begin bar(x,325,x+30,355); inc(x,40); end;
   usecolor(15); outtextxy(348,383,'SPACE');
    line(375,290,375,310); line(375,330,375,350);
    line(330,340,350,340); line(410,340,430,340);
    for i:=1 to 9 do begin
      line(375,290,370+i,295); line(375,350,370+i,345);
      line(330,340,335,335+i); line(430,340,425,335+i);
    end;
    usecolor(0);
    for i:=1 to 10 do begin
      outtextxy(480+i,300+i,'Escolhe bloco');
      outtextxy(480+i,380+i,'Move bloco');
    end;
    usecolor(27);
    for i:=1 to 3 do begin
      outtextxy(476+i,300+i,'Escolhe bloco');
      outtextxy(476+i,380+i,'Move bloco');
   end;
   tecla:=readkey; limpa;
 end;