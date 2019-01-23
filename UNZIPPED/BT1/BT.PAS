{ Batch Tools
  Autor ÄÄÄÄÄÄ Luis Manuel Santos Guerra
  Linguagem ÄÄ Turbo Pascal 6.0
  Objectivo ÄÄ Criar ferramentas para rotinas batch
  Inicio ÄÄÄÄÄ 94-03-19 ÄÂÄ v1.0
  Fim ÄÄÄÄÄÄÄÄ 94-03-20 ÄÙ
  Inicio ÄÄÄÄÄ 94-03-27 ÄÂÄ v1.1á
  Fim ÄÄÄÄÄÄÄÄ 94-03-30 ÄÙ
  Inicio ÄÄÄÄÄ 94-10-11 ÄÂÄ v1.1
  Fim ÄÄÄÄÄÄÄÄ 94-10-14 ÄÙ

  Evolu‡„o do programa:

  94-03-19   - Inclus„o dos programas DosColor, Sirene, TypeIt, Cursor,
               TypeXY em Batch Tools, e ligeiras modifica‡”es neles
             - Constru‡„o do Corpo do Programa e das seguintes procedures:
               Verificar, Cr‚ditos, Sintaxe
             - Constru‡„o de novas fun‡”es e procedures no Batch Tools:
               Bip, Fade, Pausa, Janela

  94-03-20   - Finaliza‡„o do procedimento Fade
             - Constru‡„o da procedure Rel¢gio
             - Altera‡”es em Sintaxe, Verify e outras procedures
             - Conclus„o (por agora) desta vers„o de Batch Tools (v1.0)

  94-03-26   - Constru‡„o de uma rotina batch com instru‡”es Batch Tools,
               de nome BtDemo.Bat, compilada para .Com por Bat2Exec v1.2

  94-03-27   - Constru‡„o das seguintes procedures: Data, Vers„o
             - Altera‡”es em todo o c¢digo do programa levam a v1.1á

  94-03-28   - Altera‡„o na fun‡„o Fade, corrige procedimento scroll right
             - Suporte para espanhol na fun‡„o Data
             - Implementa‡„o da fun‡„o Janela, com mais tipos de molduras:
               Dupla Vertical e Dupla Horizontal
             - Altera‡”es em Sintaxe, Verify e outras procedures

  94-03-29   - Reconstru‡„o integral da fun‡„o scroll right em Fade
             - Constru‡„o da rotina Browse em Batch Tools
             - Altera‡”es menores em Sintaxe, Verify e quase todo o programa

  94-03-30   - Altera‡”es na procedure Browse (n„o foram necess rias)
             - Aumento de precis„o das fun‡”es Fade In e Fade Out em Fade
             - Constru‡„o da procedure MenuBar e dos ficheiros auxiliares
               de nome Menu.Bt e BtMenu.Bat, para testes
             - Altera‡”es menores em todo o programa

  94-10-11   - Revis„o geral da vers„o BT v1.1á (agora BT v1.1)
             - Altera‡„o das procedures Sintaxe, Creditos, Vers„o
             - Constru‡„o das fun‡”es Left_In, Left_Out, Right_In, Right_Out
               na procedure Fade; Fade separa-se em Fade e Scroll
             - Reconstru‡„o integral da fun‡„o scroll right em Scroll
             - Correc‡„o de cor na fun‡„o Cheia da procedure Janela
             - Altera‡„o da procedure MenuBar para obter acesso directo a um
               item, pressionando a tecla correspondente [1 a 8 (m ximo)]

  94-10-12   - Altera‡”es menores em todo o programa (correc‡„o ortogr fica)
               e altera‡”es de fundo na procedure Sintaxe
             - Altera‡”es nas procedures Fade e TypeIt de modo a 'truncarem'
               ou n„o exibiriem strings que ultrapassem a coluna 80

  94-10-13   - Constru‡„o das procedures WriteXY, Upcase String e PlaySnd
               para a simplifica‡„o do c¢digo
             - Constru‡„o das procedures Verificar Ficheiro, Mostrar P gina,
               e Reabrir Ficheiro, para auxilio a Browse e MenuBar
             - Altera‡„o da procedure Browse com implenta‡„o das teclas:
               Down, PgDn, Home, End

  94-10-14   - Altera‡”es na declara‡„o de variaveis locais e globais
             - Inclus„o da procedure Esvaziar Buffer do Teclado
               para uso nas procedures Relogio e Sirene

  Bugs?
  Sugest”es?
  Escreva para:

  Luis Manuel Santos Guerra
  Rua Ferreira de Castro, n§6, 2§dto
  Cova de Piedade
  2800 Almada }

program bt (input,output);

uses
    dos,crt;

var
   x,y,x1,x2,y1,y2,tpos,cor1,cor2 : byte;
   cur_line,cur_page              : word;
   i,freq,time,tsize              : integer;
   c,s,txt,tmp_str  : string;
   ft               : text;
   key              : char;
   r   : registers;

procedure sintaxe; forward;


{ DESLIGAR CURSOR }
procedure desligar_cursor;

begin
     r.ah:=01;
     r.ch:=40;
     r.cl:=0;
     intr($10,r);
end;


{ LIGAR CURSOR }
procedure ligar_cursor;

begin
     r.ah:=01;
     r.ch:=3;
     r.cl:=4;
     intr($10,r);
end;


{ ESVAZIAR BUFFER DE TECLADO }
procedure flushkbd;

var
   head: integer absolute $0000:$041A;
   tail: integer absolute $0000:$041C;

begin
     tail := head;
end;


{ WRITEXY }
procedure writexy(x,y:byte; s:string);

begin
     gotoxy(x,y);
     write(s);
end;


{ UPCASE STRING }
function upcasestr(s:string):string;

begin
     for i:= 1 to length(s) do
         s[i] := upcase(s[i]);
     upcasestr := s;
end;


{ PLAYSND }
procedure playsnd(freq,time:word);

begin
     sound(freq);
     delay(time);
end;


{ PROCURA FICHEIRO }
procedure file_chk;

begin
     if (ioresult <> 0) or (txt = '') then
        begin
             writeln ('Erro: Ficheiro n„o encontrado ou inexistente.');
             halt;
        end;
end;


{ REABRE FICHEIRO }
procedure firstpos;

begin
     close(ft);
     reset(ft);
     cur_line := 1;
     cur_page := 1;
     clrscr;
end;


{ MOSTRA P†GINA }
procedure showpg;

begin
     for i := (y1+1) to y2 do
         begin
              readln(ft,txt);
              writeln(txt);
              inc(cur_line);
         end;
     inc(cur_page);
end;


{ BIP }
procedure bip;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 3 then sintaxe;
     val(paramstr(2),freq,i);
     val(paramstr(3),time,i);
     playsnd(freq,time);
     nosound;
     halt;
end;


{ BROWSE }
procedure browse;

var
   maxlines,numpag : word;

begin
     if paramcount = 1 then sintaxe;
     if (paramcount <> 2) and (paramcount <> 8) then sintaxe;
     if paramcount = 8 then
        begin
             val(paramstr(2),x1,i);
             val(paramstr(3),y1,i);
             val(paramstr(4),x2,i);
             val(paramstr(5),y2,i);
             val(paramstr(6),cor1,i);
             val(paramstr(7),cor2,i);
             txt := paramstr(8);
             y := wherey;
             window(x1,y1,x2,y2);
             textcolor(cor1);
             textbackground(cor2);
             clrscr;
        end;
     if paramcount = 2 then 
        begin
             txt := paramstr(2);
             y1 := 1;
             y2 := 25;
        end;
     {$I-}
     assign(ft,txt);
     reset(ft);
     file_chk;
     maxlines := 0;
     cur_line := 1;
     cur_page := 1;
     repeat
           readln(ft,txt);
           inc(maxlines);
     until eof(ft);
     numpag := maxlines div (y2-(y1+1));
     firstpos;
     showpg;
     repeat
           key := readkey;
           case key of
                #71: begin
                          firstpos;
                          showpg;
                     end;
                #79: begin           
                          firstpos;
                          for i := 1 to (maxlines-(y2-(y1+1))) do
                              begin
                                   readln(ft,txt);
                                   inc(cur_line);
                              end;
                          showpg;
                     end;
                #80: begin
                          readln(ft,txt);
                          writeln(txt);
                          inc(cur_line);
                     end;
                #81: showpg;
           end;     
     until (key = #27);
     if paramcount = 8 then textcolor (15);
     close(ft);
     {$I+}
     flushkbd;
     if paramcount = 8 then
        begin
             textcolor(7);
             textbackground(0);
             clrscr;
             window(1,1,80,25);
             gotoxy(wherex,y);
        end;
     if paramcount = 2 then clrscr;
     halt;
end;


{ CURSOR }
procedure cursor;

begin
     if paramcount = 1 then sintaxe;
     if (paramcount <> 2) and (paramcount <> 4) then sintaxe;
     if paramcount = 2 then
        s := paramstr(2);
     if paramcount = 4 then
        begin
             val(paramstr(2),x,i);
             val(paramstr(3),y,i);
             gotoxy(x,y);
             s := paramstr(4);
        end;
    s := upcasestr(s);
    if s = 'LIGAR' then ligar_cursor;
    if s = 'DESLIGAR' then desligar_cursor;
    halt;
end;


{ DATA }
procedure data;

const 
     ds_por : array[0..6] of string = ('Domingo','Segunda','Ter‡a','Quarta','Quinta','Sexta','S bado');
     ds_ing : array[0..6] of string = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday');
     ds_fra : array[0..6] of string = ('Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vandredi','Samedi');
     ds_ale : array[0..6] of string = ('Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Sonnabend');
     ds_esp : array[0..6] of string = ('Domingo','Lunes','Martes','Mi‚rcoles','Jueves','Viernes','S bado');

var
   ano,mes,dia,ds  : word;
   tmp_mes,tmp_dia : string;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 4 then sintaxe;
     val(paramstr(2),cor1,i);
     s := upcasestr(paramstr(3));
     getdate(ano,mes,dia,ds);
     str(mes,tmp_mes);
     str(dia,tmp_dia);
     if length(tmp_mes) = 1 then tmp_mes := '0' + tmp_mes;
     if length(tmp_dia) = 1 then tmp_dia := '0' + tmp_dia;
     textattr := cor1;
     if s = 'POR' then write(ds_por[ds]);
     if s = 'ING' then write(ds_ing[ds]);
     if s = 'FRA' then write(ds_fra[ds]);
     if s = 'ALE' then write(ds_ale[ds]);
     if s = 'ESP' then write(ds_esp[ds]);
     if (s = 'POR') and (ds in [1..5]) then write('-Feira');
     s := upcasestr(paramstr(4));
     if s = 'ESF' then write(' ',tmp_dia:0,'-',tmp_mes,'-',ano:0);
     if s = 'SI' then write(' ',ano:0,'-',tmp_mes,'-',tmp_dia:0);
     if s = 'EUA' then write(' ',tmp_mes:0,'-',tmp_dia,'-',ano:0);
     halt;
end;


{ DOSCOLOR }
procedure doscolor;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 3 then sintaxe;
     val(paramstr(2),cor1,i);
     val(paramstr(3),cor2,i);
     textcolor(cor1);
     textbackground(cor2);
     clrscr;
     halt;
end;


{ FADE }
procedure fade;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 7 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),time,i);
     txt := paramstr(6);
     s := upcasestr(paramstr(7));
     textattr := cor1;
     tsize := length(txt);
     delete(txt,81-x,tsize);
     if s = 'DTRO' then
        begin
             tsize := length(txt);
             writexy(x,y,txt);
             for i := 1 to (tsize div 2) do
                 begin
                      writexy(x+i-1,y,' ');
                      writexy(x+tsize-i,y,' ');
                      delay(time);
                 end;
             writexy(x + (tsize div 2),y,' ');
        end;
     if s = 'FORA' then
        begin
             tmp_str := '';
             for i := 1 to length(txt) do
                 tmp_str := tmp_str + ' ';
             tpos := length(txt);
             tsize := (tpos div 2) + 1;
             tmp_str[tsize]:= txt[tsize];
             for i := 1 to tsize do
                 begin
                      writexy(x,y,(copy(tmp_str,1,tpos)));
                      tmp_str[tsize+i]:= txt[tsize+i];
                      tmp_str[tsize-i]:= txt[tsize-i];
                      delay(time);
                 end;
             writexy(x,y,txt);
        end;
     if s = 'ESQ_DTRO' then
        begin
             tsize := length(txt);
             writexy(x,y,txt);
             for i:= 1 to tsize do
                 begin
                      writexy(x+i-1,y,' ');
                      delay(time);
                 end;
        end;
     if s = 'ESQ_FORA' then
        begin
             tsize := length(txt);
             for i:= 1 to tsize do
                 begin
                      writexy(x,y,(copy(txt,1,i)));
                      delay(time);
                 end;
        end;
     if s = 'DIR_DTRO' then
        begin
             tsize := length(txt);
             writexy(x,y,txt);
             for i:= 1 to (tsize+1) do
                 begin
                      writexy(x+tsize-i+1,y,' ');
                      delay(time);
                 end;
        end;
     if s = 'DIR_FORA' then
        begin
             tsize := length(txt);
             for i:= 1 to tsize do
                 begin
                      writexy(x+tsize-i,y,copy(txt,tsize-i+1,i));
                      delay(time);
                 end;
        end;
     ligar_cursor;
     halt;
end;


{ JANELA }
procedure janela;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 7 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x1,i);
     val(paramstr(3),y1,i);
     val(paramstr(4),x2,i);
     val(paramstr(5),y2,i);
     val(paramstr(6),cor1,i);
     s := upcasestr(paramstr(7));
     textattr := cor1;
     if s = 'CHEIA' then
        begin
             for y := y1 to y2 do
                 for x:= x1 to x2 do
                     writexy(x,y,'Û');
             ligar_cursor;
             halt;
        end;
     if s = 'FORTE' then s := 'ÜÛÜÛÜÛ';
     if s = 'DUPLA' then s := 'ÉÈ»¼Íº';
     if s = 'DPHOR' then s := 'ÕÔ¸¾Í³';
     if s = 'DPVER' then s := 'ÖÓ·½Äº';
     if s = 'NORMAL' then s := 'ÚÀ¿ÙÄ³';
     for i := (y1 + 1) to (y2 - 1) do
         begin
              writexy(x1,i,s[6]);
              writexy(x2,i,s[6]);
         end;
     for i := (x1 + 1) to (x2 - 1) do
         begin
              writexy(i,y1,s[5]);
              writexy(i,y2,s[5]);
         end;
     writexy(x1,y1,s[1]);
     writexy(x2,y1,s[3]);
     writexy(x1,y2,s[2]);
     writexy(x2,y2,s[4]);
     ligar_cursor;
     halt;
end;


{ MENU DE BARRA }
procedure menubar;

var
   menuitem : array[1..8] of string[40];
   itemchar : array[1..8] of char;
   itemcode : word;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 6 then sintaxe;
     val(paramstr(2),x,i);
     val(paramstr(3),y1,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),cor2,i);
     txt := paramstr(6);
     ligar_cursor;
     {$I-}
     assign(ft,txt);
     reset(ft);
     file_chk;
     i := 0;
     repeat
           readln(ft,txt);
           if length(txt) <> 0 then
              begin
                   gotoxy(x,y1+i);
                   inc(i);
                   menuitem[i] := txt;
                   itemchar[i] := txt[1];
                   textattr := cor1;
                   write(menuitem[i]);
              end;
     until (i = 8) or (eof(ft));
     close(ft);
     {$I+}
     y2 := y1+i;
     i := y1;
     repeat
           textattr := cor2;
           itemcode := i-y1+1;
           writexy(x,i,menuitem[itemcode]);
           key := readkey;
           case key of
                #80 : begin
                           textattr := cor1;
                           writexy(x,i,menuitem[itemcode]);
                           inc(i);
                           if i = y2 then i := y1;
                      end;
                #72 : begin
                           textattr := cor1;
                           writexy(x,i,menuitem[itemcode]);
                           dec(i);
                           if i < y1 then i := y2-1;
                      end;
                '1'..'8': begin
                               if ord(key) <= ord(itemchar[y2-y1]) then
                                  begin
                                       textattr := cor1;
                                       writexy(x,i,menuitem[itemcode]);
                                       itemcode := ord(key)-48;
                                       i := itemcode+y1-1;
                                       textattr := cor2;
                                       writexy(x,i,menuitem[itemcode]);
                                  end;
                          end;
           end;
     until (key = #13) or (key in ['1'..'8']);
     halt(ord(itemcode));
end;


{ PAUSA }
procedure pausa;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 2 then sintaxe;
     val(paramstr(2),time,i);
     desligar_cursor;
     delay(time);
     ligar_cursor;
     halt;
end;


{ RELŸGIO }
procedure relogio;

var
   hr,min,sec,hund        : word;
   tmp_hr,tmp_min,tmp_sec :string;

begin
     x := wherex;
     if (paramcount = 1) or (paramcount > 4 ) then sintaxe;
     if paramcount = 2 then
        begin
             val(paramstr(2),cor1,i);
             s := 'MIN';
        end;
     if paramcount = 3 then
        begin
             val(paramstr(2),cor1,i);
             s := upcasestr(paramstr(3));
        end;
     if paramcount = 4 then
        begin
             val(paramstr(2),cor1,i);
             s := upcasestr(paramstr(3));
             tmp_str := upcasestr(paramstr(4));
        end;
     if (s='MIN') or (s='SEG') or (s='CENT') then
        begin
             desligar_cursor;
             textattr := cor1;
             repeat
                   gettime(hr,min,sec,hund);
                   gotoxy(x,wherey);
                   if tmp_str = 'LIGAR' then
                      begin
                           if hr < 12 then write('am');
                           if hr >= 12 then
                              begin
                                   hr := hr - 12;
                                   write('pm');
                              end;
                      end;
                   str(hr,tmp_hr);
                   str(min,tmp_min);
                   str(sec,tmp_sec);
                   if length(tmp_hr) = 1 then tmp_hr := '0' + tmp_hr;
                   if length(tmp_min) = 1 then tmp_min := '0' + tmp_min;
                   if length(tmp_sec) = 1 then tmp_sec := '0' + tmp_sec;
                   if tmp_str = 'DESLIGAR' then gotoxy(x,wherey);
                   if tmp_str = 'LIGAR' then gotoxy(x+3,wherey);
                   if s='MIN' then write(tmp_hr,':',tmp_min);
                   if s='SEG' then write(tmp_hr,':',tmp_min,':',tmp_sec);
                   if s='CENT' then write(tmp_hr,':',tmp_min,':',tmp_sec,':',hund);
             until keypressed;
             flushkbd;
             ligar_cursor;
             halt;
        end
     else sintaxe;
end;


{ SCROLL }
procedure scroll;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 7 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),time,i);
     txt := paramstr(6);
     s := upcasestr(paramstr(7));
     textattr := cor1;
     if s = 'ESQ' then
        begin
             for i := 2 to x do
                 txt := ' ' + txt;
             tpos := length(txt);
             for i := 1 to length(txt) do
                 begin
                      tsize := i;
                      if ((tsize + x) > 80) then tsize := 80;
                      writexy(1,y,copy(txt,tpos,tsize));
                      tpos := length(txt) - i;
                      delay(time);
                 end;
        end;
    if s = 'DIR' then
        begin
             tsize := length(txt);
             txt := txt + ' ';
             x1 := 0;
             for i := x to (tsize+79) do
                 begin
                      x1 := x1 + 1;
                      if (81-x1) >= 1 then
                          writexy(81-x1,y,copy(txt,1,x1))
                      else
                          begin
                               delete(txt,1,1);
                               writexy(1,y,copy(txt,1,80));
                          end;
                      delay(time);
                 end;
        end;
     ligar_cursor;
     halt;
end;


{ SIRENE }
procedure sirene;

var
   freq2,step,num,cont,cont2 : integer;
   sirene,filtro             : boolean;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 8 then sintaxe;
     val(paramstr(2),freq,i);
     val(paramstr(3),freq2,i);
     val(paramstr(4),time,i);
     val(paramstr(5),step,i);
     val(paramstr(6),num,i);
     s := upcasestr(paramstr(7));
     if (s = 'S+') or (s = '/S+') then sirene := true;
     if (s = 'S-') or (s = '/S-') then sirene := false;
     s := upcasestr(paramstr(8));
     if (s = 'F+') or (s = '/F+') then filtro := true;
     if (s = 'F-') or (s = '/F-') then filtro := false;
     cont := 1;
     cont2 := freq;
     if freq < freq2 then
        while (cont <= num) and (not keypressed) do
              begin
                   while (cont2 <= freq2) and (not keypressed) do
                         begin
                              playsnd(cont2,time);
                              if filtro = false then nosound;
                              cont2 := cont2 + step;
                         end;
                   if sirene = true then
                      while (cont2 >= freq) and (not keypressed) do
                            begin
                                 playsnd(cont2,time);
                                 if filtro = false then nosound;
                                 cont2 := cont2 - step;
                            end;
                   inc(cont);
                   cont2 := freq;
              end;
     if freq > freq2 then
        begin
             while (cont <= num) and (not keypressed) do
                   begin
                        while (cont2 >= freq2) and (not keypressed) do
                              begin
                                   playsnd(cont2,time);
                                   if filtro = false then nosound;
                                   cont2 := cont2 - step;
                              end;
                        if sirene = true then
                           while (cont2 <= freq) and (not keypressed) do
                                 begin
                                      playsnd(cont2,time);
                                      if filtro = false then nosound;
                                      cont2 := cont2 + step;
                                 end;
                        inc(cont);
                        cont2 := freq;
                   end;
        end;
     nosound;
     flushkbd;
     halt;
end;


{ TYPEIT }
procedure typeit;

var
   cursor : string;
   speed  : word;
   tmp_x  : byte;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 8 then sintaxe;
     desligar_cursor;
     val(paramstr(2),cor1,i);
     val(paramstr(3),cor2,i);
     val(paramstr(4),freq,i);
     val(paramstr(5),time,i);
     val(paramstr(6),speed,i);
     txt := paramstr(7);
     cursor := paramstr(8);
     tmp_str := '';
     tmp_x := wherex;
     delete(txt,80-length(cursor),length(txt));
     for i := 1 to length(txt) do
         begin
              tmp_str := tmp_str + txt[i];
              textattr := cor1;
              writexy(tmp_x,wherey,tmp_str);
              textattr := cor2;
              writexy(wherex,wherey,cursor);
              playsnd(freq,time);
              nosound; delay(speed);
              x := wherex;
              if x = 80 then i := length(txt);
         end;
     if length(cursor) = 1 then
        writexy(wherex-length(cursor),wherey,#255);
     ligar_cursor;
     halt;
end;


{ TYPEXY }
procedure typexy;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 5 then sintaxe;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     txt := paramstr(5);
     textattr := cor1;
     writexy(x,y,txt);
     halt;
end;


{ VERSŽO }
procedure version;

begin
     writeln;
     writeln('Batch Tools v1.1 (c) 1994');
     writeln('por Luis Manuel Santos Guerra');
     writeln('para a revista SPOOLER');
     writeln('em 94-10-11');
     halt;
end;


{ CREDITOS }
procedure creditos;

begin
     writeln;
     writeln('Batch Tools v1.1 (c) 1994');
     writeln('por Luis Manuel Santos Guerra');
     writeln('para a revista SPOOLER');
     writeln('em 94-10-11');
     writeln;
     writeln('Sintaxe:');
     writeln('Bt');
     writeln('Bt [comando]');
     writeln('Bt [comando] [parƒmetros]');
     writeln;
     writeln('Comandos de Batch Tools:');
     writeln('Bip        Fade      Scroll');
     writeln('Browse     Janela    Sirene');
     writeln('Cursor     MenuBar   TypeIt');
     writeln('Data       Pausa     TypeXY');
     writeln('DosColor   Relogio   Ver');
     halt;
end;


{ SINTAXE }
procedure sintaxe;

begin
     if c = 'BIP' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Bip [freq] [freq_tempo]');
             writeln;
             writeln('[freq]');
             writeln('Frequˆncia do som medido em Hertz, que');
             writeln('varia entre os valores 0 e 32767.');
             writeln;
             writeln('[freq_tempo]');
             writeln('Dura‡„o do som medido em milisegundos.');
        end;
     if c = 'BROWSE' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Browse [fich.ext]');
             writeln('Browse [x1] [y1] [x2] [y2] [cor_texto] [cor_fundo] [fich.ext]');
             writeln;
             writeln('[x1] e [x2]');
             writeln('Define as coordenadas horizontais esquerda e direita da janela.');
             writeln('x2 > x1 e x1 e x2 tˆm valores entre 1 e 80, no modo 80x25.');
             writeln;
             writeln('[y1] e [y2]');
             writeln('Define as coordenadas verticais superior e inferior da janela.');
             writeln('y2 > y1 e y1 e y2 tˆm valores entre 1 e 25, no modo 80x25.');
             writeln;
             writeln('[cor_texto] e [cor_fundo]');
             writeln('Define as cores do texto e de fundo. Valor num‚rico entre 0 e 16.');
             writeln;
             writeln('[fich.ext]');
             writeln('Ficheiro de texto a abrir para leitura. Indica‡„o da drive e path ‚');
             writeln('opcional. Pode ser [drive:][\path\][fich.txt] em vez de [fich.txt].');
        end;
     if c = 'CURSOR' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Cursor [coluna] [linha] [status]');
             writeln('Cursor [status]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Coordenadas do monitor, que variam entre 1 a 80,');
             writeln('e 1 a 25, no modo de texto 80x25.');
             writeln('Estes dois parƒmetros s„o opcionais em conjunto.');
             writeln;
             writeln('[status]');
             writeln('Com LIGAR ou DESLIGAR, pode ligar ou desligar o cursor.');
        end;
     if c = 'DATA' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Data [cor] [l¡ngua] [formato]');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[l¡ngua]');
             writeln('Escolha da l¡ngua nativa, entre as seguintes: portuguˆs, inglˆs, francˆs,');
             writeln('alem„o e espanhol. As entradas respectivas s„o POR, ING, FRA, ALE, ESP.');
             writeln;
             writeln('[formato]');
             writeln('Escolha de um dos padr”es de disposi‡„o da data. Teclar ESF para selec‡„o do');
             writeln('European Standart (dd-mm-aaaa), SI para o Sistema Internacional (aaaa-mm-dd)');
             writeln('e teclar EUA caso se queira usar o sistema norte-americano (mm-dd-aaaa).');
        end;
     if c = 'DOSCOLOR' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('DosColor [cor_texto] [cor_fundo]');
             writeln;
             writeln('[cor_texto] e [cor_fundo]');
             writeln('Define as cores do texto e de fundo.');
             writeln('Valor num‚rico entre 0 e 16.');
        end;
     if c = 'FADE' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Fade [coluna] [linha] [cor] [tempo] [texto] [fade]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[texto]');
             writeln('Texto a escrever no ‚cran. Caso se escrevam v rias palavras use como');
             writeln('separador o caracter inv¡sivel (Alt+255). Se o texto a apresentar no');
             writeln('‚cran ultrapassar a coluna 80 a parte em excesso ser  truncada.');
             writeln;
             writeln('[fade]');
             writeln('Modo de aparecimento do texto em fade seleccionando uma das seguintes');
             writeln('op‡”es apresentadas: DTRO, FORA, ESQ_DTRO, ESQ_FORA, DIR_DTRO, DIR_FORA.');
        end;
     if c = 'JANELA' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Janela [x1] [y1] [x2] [y2] [cor] [moldura]');
             writeln;
             writeln('[x1] e [x2]');
             writeln('Define as coordenadas horizontais esquerda e direita da janela.');
             writeln('x2 > x1 e x1 e x2 tˆm valores entre 1 e 80, no modo 80x25.');
             writeln;
             writeln('[y1] e [y2]');
             writeln('Define as coordenadas verticais superior e inferior da janela.');
             writeln('y2 > y1 e y1 e y2 tˆm valores entre 1 e 25, no modo 80x25.');
             writeln;
             writeln('[cor]');
             writeln('Cor da moldura, de valor num‚rico entre 0 e 255.');
             writeln;
             writeln('[moldura]');
             writeln('Selecciona moldura: NORMAL, DUPLA, DPHOR, DPVER, FORTE, CHEIA.');
        end;
     if c = 'MENUBAR' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('MenuBar [coluna] [linha] [cor_item] [cor_sel] [fich.ext]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25. Estas');
             writeln('coordenadas s„o do primeiro item; os outros ser„o alinhados.');
             writeln;
             writeln('[cor_item] e [cor_sel]');
             writeln('Determina a cor dos itens normais e a cor do item seleccionado.');
             writeln('Os limites para o valor num‚rico de cor s„o 0 e 255.');
             writeln;
             writeln('[fich.ext]');
             writeln('Ficheiro de texto a abrir para leitura. No interior est„o os itens');
             writeln('do menu a apresentar (at‚ 8), um em cada linha, com o m ximo de 40');
             writeln('caracteres cada. Varie a valor da coluna e/ou n£mero de caracteres');
             writeln('de um item para que o texto de cada item caiba todo em cada linha.');
             writeln('O primeiro caracter de um item tem de ser um n£mero inteiro. Assim');
             writeln('sendo, esse caracter ter  o valor 1 no primeiro item, 2 no segundo');
             writeln('e assim sucessivamente, at‚ 8 para o oitavo item. Depois de teclar');
             writeln('Enter - na escolha do item - o valor ErrorLevel ser  o do primeiro');
             writeln('caracter do item seleccionado.');
        end;
     if c = 'PAUSA' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Pausa [tempo]');
             writeln;
             writeln('[tempo]');
             writeln('Dura‡„o da pausa medida em milisegundos.');
        end;
     if c = 'RELOGIO' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Relogio [cor] [formato] [am/pm]');
             writeln;
             writeln('[cor]');
             writeln('Cor dos caracteres do rel¢gio, de valor num‚rico entre 0 e 255.');
             writeln;
             writeln('[formato]');
             writeln('Escrever neste espa‡o SEG para ver os segundos ou CENT para ter precis„o');
             writeln('de d‚cimas e cent‚simas de segundo. Para s¢ obter o formato Hora:Minuto,');
             writeln('escrever neste espa‡o MIN. O valor por omiss„o ‚ MIN.');
             writeln;
             writeln('[am/pm]');
             writeln('Para usar o formato am/pm teclar LIGAR neste espa‡o. Para usar o formato');
             writeln('convencional, use DESLIGAR neste espa‡o. O valor por omiss„o ‚ DESLIGAR,');
             writeln('mas deve-se teclar o parƒmetro anterior antes de escrever algo neste.');
        end;
     if c = 'SCROLL' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Scroll [coluna] [linha] [cor] [tempo] [texto] [scroll]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Respectivamente as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('e 1 a 25, no modo 80x25. Com [modo] RIGHT, o valor da coluna pertence ao');
             writeln('£ltimo caracter do [texto] e pode ser igual ao seu n£mero de caracteres.');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, cujo valor varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[texto]');
             writeln('Texto a escrever no ‚cran. No caso de se escreverem v rias palavras, use');
             writeln('o caracter inv¡sivel (Alt+255) em lugar do space. O n£mero de caracteres');
             writeln('que ‚ considerado como limite varia com o tamanho do environment.');
             writeln;
             writeln('[scroll]');
             writeln('Modo de aparecimento do texto em scroll, seleccionando uma das seguintes');
             writeln('op‡”es apresentadas: ESQ, DIR.');
        end;
     if c = 'SIRENE' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Sirene [freq_ini] [freq_fin] [freq_tempo] [inc] [rpt] [sirene] [filtro]');
             writeln;
             writeln('[freq_ini] e [freq_fin]');
             writeln('Frequˆncia inicial e final em hertz, com valores entre 0 e 32767.');
             writeln;
             writeln('[freq_tempo]');
             writeln('Dura‡„o do som em cada frequˆncia medido em milisegundos.');
             writeln;
             writeln('[inc]');
             writeln('Incremento de frequˆncia.');
             writeln;
             writeln('[rpt]');
             writeln('N£mero de vezes que o ciclo ‚ repetido.');
             writeln;
             writeln('[sirene]');
             writeln('Com esta op‡„o o ciclo de som ascende e descende na escala.');
             writeln('Escrever nesse espa‡o S+ para ligar ou S- para desligar.');
             writeln;
             writeln('[filtro]');
             writeln('A experimentar, modifica de certo modo o som de cada ciclo.');
             writeln('Escrever nesse espa‡o F+ para ligar ou F- para desligar.');
        end;
     if c = 'TYPEIT' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Typeit [cor_txt] [cor_cur] [freq] [freq_tempo] [tempo] [texto] [cursor]');
             writeln;
             writeln('[cor_txt] e [cor_cur]');
             writeln('Define as cores do texto e do cursor. Valor num‚rico entre 0 e 255.');
             writeln;
             writeln('[freq]');
             writeln('Frequˆncia do som da batida medido em Hertz. Varia entre 0 e 32767.');
             writeln;
             writeln('[freq_tempo]');
             writeln('Dura‡„o do som medido em milisegundos.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[texto]');
             writeln('Texto a escrever no ‚cran. Caso se escrevam v rias palavras use como');
             writeln('separador o caracter inv¡sivel (Alt+255). Se o texto tem mais do que');
             writeln('80 caracteres, a parte em excesso ser  truncada.');
             writeln;
             writeln('[cursor]');
             writeln('Cursor que precede a frase a escrever no ‚cran. Pode ter mais do que');
             writeln('um caracter. O cursor apenas ser  apagado se tiver um s¢ caracter.');
        end;
     if c = 'TYPEXY' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Typexy [coluna] [linha] [cor] [texto]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Respectivamente as coordenadas x e y no monitor, de valores entre');
             writeln('1 a 80 para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, cujo valor varia entre 0 e 255.');
             writeln;
             writeln('[texto]');
             writeln('Frase a escrever no ‚cran. Caso o texto tenha v rias palavras, use');
             writeln('caracter (Alt+255) no lugar do space. O n£mero de caracteres que ‚');
             writeln('considerado como limite varia com o tamanho do environment.');
        end;
     halt;
end;


{ VERIFY }
procedure verify;

begin
     if paramcount < 1 then creditos;
     c := upcasestr(paramstr(1));
     if paramcount >= 1 then
        begin
             if c = 'BIP' then bip;
             if c = 'BROWSE' then browse;
             if c = 'CURSOR' then cursor;
             if c = 'DATA' then data;
             if c = 'DOSCOLOR' then doscolor;
             if c = 'FADE' then fade;
             if c = 'JANELA' then janela;
             if c = 'MENUBAR' then menubar;
             if c = 'PAUSA' then pausa;
             if c = 'RELOGIO' then relogio;
             if c = 'SCROLL' then scroll;
             if c = 'SIRENE' then sirene;
             if c = 'TYPEIT' then typeit;
             if c = 'TYPEXY' then typexy;
             if c = 'VER' then version
             else creditos;
        end;
end;


{ CORPO DO PROGRAMA }
begin
     nosound;
     checkbreak := false;
     verify;
end.
