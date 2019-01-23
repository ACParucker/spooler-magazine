{*************************************}
{* FastExecute V1.0 por Tiago Santos *}
{*                                   *}
{* Qualquer sugestao ou critica pode *}
{* ser enviado para:                 *}
{* Apartado 183 Rebelva-Carcavelos   *}
{* 2775 Parede                       *}
{*************************************}

{$M $4000,0,0 }   { 16K stack, no heap }

uses dos, crt;

var r    : registers;
    c, m, x, y, xcur, ycur,k, xdir, ydir : byte;
    fn   : array[1..12] of char;
    ecr : array[1..80,1..25] of char;
    execute, pnf : boolean;
    da, sn, adir, se, updir, he, hs, hor, min, seg, ano, mes, dia : string;
    t : text;
    ye, mo, di, dow, hora, minuto, segundo, hund : Word;


procedure getcurpos;
begin
 xcur:=wherex;
 ycur:=wherey;
end;


procedure setcurpos;
begin
 gotoxy(xcur,ycur);
end;


procedure cursor(c : byte);
begin
 if c=0 then
  begin
   r.ah:=1;
   r.bh:=0;
   r.cx:=$ffff;
    intr($10,r);
  end else
  begin
   r.ah:=1;
   r.bh:=0;
   r.cx:=$0809;
    intr($10,r);
  end;
end;


procedure mouse(m : byte);
begin
 if m=0 then
  begin
   r.ax:=2;
    intr($33,r);
  end else
  begin
    r.ax:=0;
    intr($33,r);
   r.ax:=1;
    intr($33,r);
  end;
end;


procedure cdir;
begin
 {$I-}
 chdir(paramstr(1));
 if ioresult<>0 then pnf:=true;
end;


procedure dirw;
var dirinfo : searchrec;
begin
 textbackground(black);
 textcolor(lightgray);
 clrscr;
 xdir:=1;
 ydir:=1;
 FindFirst('*.exe', archive, DirInfo);
  while DosError = 0 do
  begin
    gotoxy(xdir,ydir);
    xdir:=xdir+16;
    if xdir>70 then begin
                     xdir:=1;
                     ydir:=ydir+1;
                    end;
    Write(DirInfo.Name);
    FindNext(DirInfo);
  end;
 FindFirst('*.com', archive, DirInfo);
  while DosError = 0 do
  begin
    gotoxy(xdir,ydir);
    xdir:=xdir+16;
    if xdir>70 then begin
                     xdir:=1;
                     ydir:=ydir+1;
                    end;
    Write(DirInfo.Name);
    FindNext(DirInfo);
  end;
end;


procedure detectar;
begin
 for y:=1 to 25 do
  begin
   for x:=1 to 80 do
    begin
     gotoxy(x,y);
     r.ah:=8;
     r.bh:=0;
      intr($10,r);
     ecr[x,y]:=char(r.al);
    end;
  end;

 x:=9;
 for y:=1 to 25 do
  begin
   gotoxy(1,y);
   if (ecr[x,y]=' ') and (ecr[x+1,y]='E') and
       (ecr[x+2,y]='X') and (ecr[x+3,y]='E') then
        begin
         textbackground(blue);
         for k:=1 to 12 do
          write(ecr[k,y]);
        end;
   if (ecr[x,y]=' ') and (ecr[x+1,y]='C') and
       (ecr[x+2,y]='O') and (ecr[x+3,y]='M') then
        begin
         textbackground(red);
         for k:=1 to 12 do
          write(ecr[k,y]);
        end;
  end;


  for x:=1 to 9 do
  begin
   for y:=1 to 25 do
    begin
     if (ecr[x,y]='.') and (ecr[x+1,y]='E') and
         (ecr[x+2,y]='X') and (ecr[x+3,y]='E') then
        begin
         textbackground(blue);
         k:=1;
         repeat
          gotoxy(k,y);
          write(ecr[k,y]);
          k:=k+1;
         until ecr[k,y]=' ';
        end;
     if (ecr[x,y]='.') and (ecr[x+1,y]='C') and
         (ecr[x+2,y]='O') and (ecr[x+3,y]='M') then
        begin
         textbackground(red);
         k:=1;
         repeat
          gotoxy(k,y);
          write(ecr[k,y]);
          k:=k+1;
         until ecr[k,y]=' ';
        end;
    end;
  end;


 for x:=13 to 73 do
  begin
   for y:=1 to 25 do
    begin
     if (ecr[x,y]='.') and (ecr[x+1,y]='E') and
         (ecr[x+2,y]='X') and (ecr[x+3,y]='E') then
        begin
         textbackground(blue);
         k:=x+3;
         while ecr[k,y]<>' ' do
          begin
           gotoxy(k,y);
           write(ecr[k,y]);
           k:=k-1;
          end;
        end;
     if (ecr[x,y]='.') and (ecr[x+1,y]='C') and
         (ecr[x+2,y]='O') and (ecr[x+3,y]='M') then
        begin
         textbackground(red);
         k:=x+3;
         while ecr[k,y]<>' ' do
          begin
           gotoxy(k,y);
           write(ecr[k,y]);
           k:=k-1;
          end;
        end;
    end;
  end;

end;


procedure moustate;
begin
 r.ax:=3;
  intr($33,r);
 x:=r.cx div 8+1;
 y:=r.dx div 8+1;
 gotoxy(x,y);
end;


procedure horas;
function LeadingZero(w : Word) : String;
var s : String;
begin
 Str(w:0,s);
 if Length(s) = 1 then s:='0'+s;
  LeadingZero := s;
end;
begin
 GetTime(hora,minuto,segundo,hund);
end;


procedure data;
begin
 GetDate(ye,mo,di,dow);
end;


procedure executar;
begin
 mouse(0);
 textbackground(black); textcolor(lightgray);
 gotoxy(xcur,ycur);
 clrscr;
 data;
 str(ye, ano); str(mo, mes); str(di, dia);
 if length(mes)=1 then mes:='0'+mes;
 if length(dia)=1 then dia:='0'+dia;
 da:=ano+'/'+mes+'/'+dia;
 horas;
 str(hora, hor); str(minuto, min); str(segundo, seg);
 if length(hor)=1 then hor:='0'+hor;
 if length(min)=1 then min:='0'+min;
 if length(seg)=1 then seg:='0'+seg;
 he:=hor+':'+min+' '+seg;
 swapvectors;
 Exec(sn,'');
 swapvectors;
 horas;
 str(hora, hor); str(minuto, min); str(segundo, seg);
 if length(hor)=1 then hor:='0'+hor;
 if length(min)=1 then min:='0'+min;
 if length(seg)=1 then seg:='0'+seg;
 hs:=hor+':'+min+' '+seg;
 updir:=paramstr(1);
 for k:=1 to Length(updir) do
   updir[k]:=upcase(updir[k]);
 if paramstr(1)='' then se:=adir+'\'+sn else se:=updir+'\'+sn;
 assign(t, 'c:\fe.dat');
 append(t);
 writeln(t, he,' ³ ',hs,' ³ ',da,' ³ ',se);
 close(t);
end;



begin
 pnf:=false;
 getdir(0,adir);
 if paramstr(1)<>'' then cdir;

 if pnf=false then begin

  dirw;
  execute:=false;
  getcurpos;
  cursor(0);
  detectar;
  mouse(1);

  repeat
   moustate;

   if r.bx=1 then begin
                   gotoxy(x,y);
                   r.ah:=8;
                   r.bh:=0;
                    intr($10,r);

                   if (r.ah=48) or (r.ah=96)
                    then execute:=true else
                     begin
                      sound(25);
                      delay(10);
                      nosound;
                     end;


                  end;
    if (execute=true) and (x<13) then begin
                                       for k:=1 to 12 do
                                        fn[k]:=ecr[k,y];
                                       sn:=fn[1]+fn[2]+fn[3]+fn[4]+
                                            fn[5]+fn[6]+fn[7]+fn[8]+
                                             fn[9]+fn[10]+fn[11]+fn[12];
                                       executar;
                                      end;

    if (execute=true) and (x>16) and (x<29) then begin
                                                  for k:=17 to 28 do
                                                   fn[k-16]:=ecr[k,y];
                                                  sn:=fn[1]+fn[2]+fn[3]+fn[4]+
                                                      fn[5]+fn[6]+fn[7]+fn[8]+
                                                      fn[9]+fn[10]+fn[11]+fn[12];
                                                   executar;
                                                  end;

    if (execute=true) and (x>32) and (x<45) then begin
                                                  for k:=33 to 44 do
                                                   fn[k-32]:=ecr[k,y];
                                                  sn:=fn[1]+fn[2]+fn[3]+fn[4]+
                                                      fn[5]+fn[6]+fn[7]+fn[8]+
                                                      fn[9]+fn[10]+fn[11]+fn[12];
                                                   executar;
                                                  end;

    if (execute=true) and (x>48) and (x<61) then begin
                                                  for k:=49 to 60 do
                                                   fn[k-48]:=ecr[k,y];
                                                  sn:=fn[1]+fn[2]+fn[3]+fn[4]+
                                                      fn[5]+fn[6]+fn[7]+fn[8]+
                                                      fn[9]+fn[10]+fn[11]+fn[12];
                                                   executar;
                                                  end;

    if (execute=true) and (x>64) and (x<77) then begin
                                                  for k:=65 to 76 do
                                                   fn[k-64]:=ecr[k,y];
                                                  sn:=fn[1]+fn[2]+fn[3]+fn[4]+
                                                      fn[5]+fn[6]+fn[7]+fn[8]+
                                                      fn[9]+fn[10]+fn[11]+fn[12];
                                                   executar;
                                                  end;

  until (r.bx=2) or (execute=true);

    cursor(0);
    repeat
     moustate;
    until r.bx=2;

    mouse(0);
    setcurpos;
    cursor(1);

  end;

  chdir(adir);
  textbackground(black);
  textcolor(green);
  clrscr;
  writeln('FastExecute V1.0 por Tiago Santos');
  textcolor(lightgray);
end.