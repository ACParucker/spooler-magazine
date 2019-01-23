{************************************}
{* KDEL Versao 1.0 por Tiago Santos *}
{* Qualquer duvida ou sugestao pode *}
{* ser enviada para:                *}
{* Apartado 183  Rebelva-Carcavelos *}
{* 2775 Parede                      *}
{************************************}

uses dos, crt, printer;

var ch : char;
    r : registers;
    x, y : byte;
    a, b, c, d, e, f, g, h : boolean;

procedure status; {obtem estado da impressora}
begin
 r.ah:=2;
 r.dx:=0; { 0 para LPT1 / 1 PARA LPT2 }
  intr($17,r);
end;


procedure inicializar; {inicializa a impressora}
begin
 r.ah:=1;
 r.dx:=0; { 0 para LPT1 / 1 PARA LPT2 }
  intr($17,r);
end;


procedure menu;
begin


 if a=true then begin
  textbackground(green);
  gotoxy(1,1); write(' Pica  ') end else
   begin
    textbackground(red);
    gotoxy(1,1); write(' Pica  ');
   end;

 if b=true then begin
  textbackground(green);
  gotoxy(1,2); write(' Elite ') end else
   begin
    textbackground(red);
    gotoxy(1,2); write(' Elite ');
   end;

 if c=true then begin
  textbackground(green);
  gotoxy(9,1); write(' NLQ 10cpi ') end else
   begin
    textbackground(red);
    gotoxy(9,1); write(' NLQ 10cpi ');
   end;

 if d=true then begin
  textbackground(green);
  gotoxy(9,2); write(' NLQ 12cpi ') end else
   begin
    textbackground(red);
    gotoxy(9,2); write(' NLQ 12cpi ');
   end;

 if e=true then begin
  textbackground(green);
  gotoxy(21,1); write(' Condensado ') end else
   begin
    textbackground(red);
    gotoxy(21,1); write(' Condensado ');
   end;

 if f=true then begin
  textbackground(green);
  gotoxy(21,2); write(' Dupla largura ') end else
   begin
    textbackground(red);
    gotoxy(21,2); write(' Dupla largura ');
   end;

 if g=true then begin
  textbackground(green);
  gotoxy(37,1); write(' Sublinhado ') end else
   begin
    textbackground(red);
    gotoxy(37,1); write(' Sublinhado ');
   end;

 if h=true then begin
  textbackground(green);
  gotoxy(37,2); write(' Italico ') end else
   begin
    textbackground(red);
    gotoxy(37,2); write(' Italico ');
   end;


 textbackground(black);
 gotoxy(x,y);
end;


procedure verificacao; {verifica caracteres especiais}
begin
 case ch of
  #8 : begin
        x:=x-1;
        if x=0 then x:=1;
        gotoxy(x,y); write(' '); gotoxy(x,y);
       end;
  #13 : begin
         y:=y+1;
         x:=1;
         gotoxy(x,y);
        end;
 else
  if (ch>#31) and (ch<#224) then begin
                                  gotoxy(x,y);
                                  write(ch);
                                  x:=x+1;
                                 end;
 end;
 if x=80 then begin
               x:=1; y:=y+1;
              end;
 if y=24 then begin
               clrscr;
               menu;
               x:=1; y:=4;
               gotoxy(x,y);
              end;
end;


procedure imprimir; {imprime caracter}
begin
 case ch of
  #8 : if x<>1 then write(lst, #127);
  #13 : writeln(lst);
  #224 : begin
          write(lst, #27+'P');     {+ pica}
          a:=true;
          b:=false;
          c:=b; d:=c;
         end;
  #225 : begin
          write(lst, #27+'M');     {+ elite}
          b:=true;
          a:=false;
          c:=a; d:=c;
         end;
  #226 : begin
          write(lst, #27+'n');     {+ nlq 10cpi}
          c:=true;
          a:=false;
          b:=a; d:=b;
         end;
  #227 : begin
          write(lst, #27+'o');     {+ nlq 12cpi}
          d:=true;
          a:=false;
          b:=a; c:=b;
         end;
  #228 : begin
          write(lst, #27+#15);    {+ condensado}
          e:=true;
         end;
  #229 : begin
          write(lst, #27+'W'+#1);  {+ doubro}
          f:=true;
         end;
  #230 : begin
          write(lst, #27+'-'+#1);  {+ sublinhado}
          g:=true;
         end;
  #231 : begin
          write(lst, #27+'4');     {+ italico}
          h:=true;
         end;
  #232 : begin
          write(lst, #18);    {- condensado}
          e:=false;
         end;
  #233 : begin
          write(lst, #27+'W'+#0);  {- doubro}
          f:=false;
         end;
  #234 : begin
          write(lst, #27+'-'+#0);  {- sublinhado}
          g:=false;
         end;
  #235 : begin
          write(lst, #27+'5');     {- italico}
          h:=false;
         end;
  else write(lst, ch);
 end;
 if (ch<#236) and (ch>#223) then menu;
end;


begin
 clrscr;
 status;
 inicializar;
 ch:=#0;
 a:=true;
 b:=false;
 c:=b; d:=c; e:=d;
 f:=e; g:=f; h:=g;
 writeln(' Pica    NLQ 10CPI   Condensado      Sublinhado');
 writeln(' Elite   NLQ 12CPI   Dupla largura   Italico');
 menu;
 x:=1; y:=4;
 gotoxy(x,y);

  while ch<>#27 do
   begin
    ch:=readkey;
    verificacao;
    imprimir;
   end;

 clrscr;
 writeln('Maquina Escrever Electronica  V1.0  por  Tiago Santos');
end.