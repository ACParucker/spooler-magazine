{ Batch Tools 2
  Autor ÄÄÄÄÄÄ Luis Manuel Santos Guerra
  Linguagem ÄÄ Turbo Pascal 6.0
  Objectivo ÄÄ Criar ferramentas para rotinas batch
  Inicio ÄÄÄÄÄ 94-10-16 ÄÂÄ v1.0
  Fim ÄÄÄÄÄÄÄÄ 94-10-20 ÄÙ


  Evolu‡„o do programa:

  94-10-16   - Constru‡„o do Corpo do Programa e inclus„o das procedures:
               Ligar_Cursor, Desligar_Cursor, Esvaziar Buffer do Teclado,
               WriteXY, Upcase_String, Verify, Sintaxe, Ver
             - Constru‡„o das procedures Crush, PauseKey, Dice, ColorRef
             - Rotinas .Bat para demonstra‡„o de PauseKey e Dice

  94-10-17   - Constru‡„o da procedure Scramble e de uma rotina em batch 
               file para demonstra‡„o de Scramble
             - Constru‡„o da fun‡„o In na procedure Slice
             - Altera‡”es menores em Sintaxe, Verify

  94-10-18   - Contru‡„o da procedure Repeat e de uma rotina em batch de
               nome Repeat.Bat
             - Constru‡„o da procedure TypeChr

  94-10-19   - Constru‡„o da procedure AsciiTbl e altera‡”es em TypeChr
             - Fus„o das procedures ColorRef e AsciiTbl em RefTable
             - Constru‡„o da procedure TypeXY Vertical
             - Novas fun‡”es em Crush: Left_In, Left_Out, Right_In, Right_Out
             - Implementa‡„o da procedure Obter Caracter para auxilio … nova
               procedure Scroll Vertical
             - Mais uma batch file de exemplo: VScroll.Bat

  94-10-20   - Constru‡„o das procedures MoveCor e PaintTxt
             - Elabora‡„o de um rascunho inicial para o documento bt2v1.0, e
               cria‡„o da batch file MoveCor.Bat como demonstra‡„o
             - Aumento de precis„o em In e contru‡„o da fun‡„o Out em Slice
             - Constru‡„o da procedure Colorize

  94-10-21   - Constru‡„o das procedures TypeIt2 e PaintWin
             - Mais rotinas batch: Colorize.Bat e TypeIt2.Bat
             - CONCLUSŽO desta vers„o de BT2

  Bugs?
  Sugest”es?
  Escreva para:

  Luis Manuel Santos Guerra
  Rua Ferreira de Castro, n§6, 2§dto
  Cova de Piedade
  2800 Almada }

program bt2 (input,output);

uses
    dos,crt;

var
   x,y,tpos,cor1,cor2 : byte;
   i,i2,time,tsize    : integer;
   c,s,txt,tmp_str    : string;
   key : char;
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


{ OBTER CARACTER }
function getchar(x,y:byte):char;

begin
    r.ah:=$2;
    r.dh:=y-1;
    r.dl:=x-1;
    r.bh:=0;
    intr($10,r);
    fillchar(r,sizeof(r),0);
    r.ah:=8;
    r.bh:=0;
    intr($10,r);
    getchar:=chr(r.al);
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


{ REFERENCE TABLE }
procedure reftable;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 2 then sintaxe;
     if upcasestr(paramstr(2)) <> '?' then sintaxe;
     desligar_cursor;
     clrscr;
     if c = 'ASCIITBL' then
        writexy (1,2,'Batch Tools 2 v1.0 þ Tabela ASCII de caracteres');
     if c = 'COLORREF' then
        writexy (1,2,'Batch Tools 2 v1.0 þ Tabela de cores dispon¡veis');
     i := -1;
     tpos := 0;
     x := 1;
     repeat
           for y := 4 to 19 do
               begin
                    inc(i);
                    str(i,s);
                    if c = 'COLORREF' then normvideo;
                    if (i >= 96) and (i <= 99) then inc(x);
                    if c = 'ASCIITBL' then
                       begin
                            textattr := 7;
                            writexy(x,y,s);
                            textattr := 15;
                            writexy(x+length(s),y,chr(i));
                       end;
                    if c = 'COLORREF' then
                       begin
                            writexy(x,y,s);
                            textattr := i;
                            writexy(x+length(s),y,'þ');
                       end;
                    if (i >= 96) and (i <= 99) then dec(x);
               end;
               x := x + 5;
     until i = 255;
     writeln;
     ligar_cursor;
     halt;
end;


{ COLORIZE }
procedure colorize;

var lim1,lim2: byte;

begin
     if paramcount = 1 then sintaxe;
     if (paramcount <> 8) then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),lim1,i);
     val(paramstr(5),lim2,i);
     val(paramstr(6),time,i);
     txt := paramstr(7);
     s := upcasestr(paramstr(8));
     if lim1 = lim2 then lim2 := lim1+1;
     delete(txt,81-x,length(txt));
     tsize := length(txt);
     randomize;
     if s = 'TECLA' then
        begin
             repeat
                   repeat textattr := random(lim2) until textattr >= lim1;
                   i := random(tsize)+1;
                   writexy(x+i-1,y,txt[i]);
                   delay(time);
             until keypressed;
             flushkbd;
        end;
     if s = 'FIMTXT' then
        for i := 1 to tsize do
            begin
                 repeat textattr := random(lim2) until textattr >= lim1;
                 writexy(x+i-1,y,txt[i]);
                 delay(time);
            end;
     ligar_cursor;
     halt;
end;


{ CRUSH }
procedure crush;

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
     delete(txt,81-x,length(txt));
     tsize := length(txt);
     tpos := tsize div 2;
     if s = 'DTRO' then
        begin
             writexy(x,y,txt);
             for i := 0 to tpos do
                 begin
                      tsize := length(txt);
                      tpos := tsize div 2;
                      delete(txt,tpos + 1,1);
                      delete(txt,tpos,1);
                      writexy(x + i,y,' '+ txt +' ');
                      delay(time);
                 end;
        end;
     if s = 'FORA' then
        begin
             for i := 1 to tpos do
                 begin
                      tmp_str := copy(txt,1,i) + copy(txt,tsize-i+1,i);
                      writexy(x + tpos - i,y,tmp_str);
                      delay(time);
                 end;
             writexy(x,y,txt);
        end;
     if s = 'ESQ_DTRO' then
        begin
             for i := 1 to tsize do
                 begin
                      writexy(x,y,txt);
                      delete(txt,tsize,tsize);
                      insert(' ',txt,1);
                      delay(time);
                 end;
             writexy(x,y,txt);
        end;
     if s = 'ESQ_FORA' then
        begin
             for i := 1 to tsize do
                 begin
                      writexy(x,y,copy(txt,tsize-i+1,tsize));
                      delay(time);
                 end;
        end;
     if s = 'DIR_DTRO' then
        begin
             for i := 1 to tsize do
                 begin
                      writexy(x,y,txt + ' ');
                      delete(txt,1,1);
                      delay(time);
                 end;
             writexy(x,y,txt + ' ');
        end;
     if s = 'DIR_FORA' then
        begin
             for i := 1 to tsize do
                 begin
                      writexy(x+tsize-i,y,copy(txt,1,i));
                      delay(time);
                 end;
        end;
     ligar_cursor;
     halt;
end;


{ DADOS }
procedure dice;

begin
     if paramcount = 1 then sintaxe;
     if (paramcount <> 2) and (paramcount <> 4) then sintaxe;
     if paramcount = 2 then s := upcasestr(paramstr(2));
     if paramcount = 4 then
        begin
             val(paramstr(2),cor1,i);
             val(paramstr(3),time,i);
             s := upcasestr(paramstr(4));
             textattr := cor1;
        end;
     if s <> 'SORTEIA' then sintaxe;
     desligar_cursor;
     randomize;
     if paramcount = 2 then
        begin
             i := random(6)+1;
             str(i,tmp_str);
        end;
     if paramcount = 4 then
        begin
             x := wherex;
             y := wherey;
             repeat
                   i := random(6)+1;
                   str(i,tmp_str);
                   writexy(x,y,tmp_str);
                   delay(time);
             until keypressed;
             key := readkey;
             flushkbd;
        end;
     ligar_cursor;
     halt(i);
end;


{ MOVECOR }
procedure movecor;

var rpt : integer;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 9 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),cor2,i);
     val(paramstr(6),time,i);
     txt := paramstr(7);
     val(paramstr(8),rpt,i);
     s := upcasestr(paramstr(9));
     delete(txt,81-x,length(txt));
     tsize := length(txt);
     for i := 1 to rpt do
         begin
              if (s = 'AMBOS') or (s = 'ESQ') or (s = 'DIR') then
                 begin
                      textattr := cor1;
                      writexy(x,y,txt);
                      if (s = 'AMBOS') or (s = 'ESQ') then
                         for i2 := 1 to tsize do
                             begin
                                  textattr := cor2;
                                  writexy(x+i2-1,y,txt[i2]);
                                  delay(time);
                                  textattr := cor1;
                                  writexy(x+i2-1,y,txt[i2]);
                             end;
                      if (s = 'AMBOS') or (s = 'DIR') then
                         for i2 := tsize downto 1 do
                             begin
                                  textattr := cor2;
                                  writexy(x+i2-1,y,txt[i2]);
                                  delay(time);
                                  textattr := cor1;
                                  writexy(x+i2-1,y,txt[i2]);
                             end;
                 end;
         end;
     ligar_cursor;
     halt;
end;


{ PINTAR TEXTO }
procedure painttxt;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 5 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),tsize,i);
     textattr := cor1;
     for i := 1 to tsize do
         begin
              key := getchar(x+i-1,y);
              writexy(x+i-1,y,key);
         end;
     ligar_cursor;
     halt;
end;


{ PINTAR JANELA }
procedure paintwin;

var x1,y1,x2,y2 : byte;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 6 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x1,i);
     val(paramstr(3),y1,i);
     val(paramstr(4),x2,i);
     val(paramstr(5),y2,i);
     val(paramstr(6),cor1,i);
     textattr := cor1;
     for i := x1 to x2 do
         for i2 := y1 to y2 do
             begin
                  key := getchar(i,i2);
                  writexy(i,i2,key);
             end;
     ligar_cursor;
     halt;
end;


{ PAUSA }
procedure pausekey;

var key_set : array [1..8] of char;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 4 then sintaxe;
     desligar_cursor;
     val(paramstr(2),cor1,i);
     txt := paramstr(3);
     tmp_str := copy(paramstr(4),1,8);
     for i := 1 to length(tmp_str) do
         key_set[i] := tmp_str[i];
     textattr := cor1;
     write(txt);
     repeat
           key := readkey;
           for i := 1 to 8 do
               if key = key_set[i] then
                  begin
                       ligar_cursor;
                       halt(i);
                  end;
           flushkbd;
     until key = key_set[i];
end;


{ REPEAT }
procedure repeatn;

var
   ft    : text;
   times : word;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 3 then sintaxe;
     val(paramstr(2),times,i);
     if i <> 0 then sintaxe;
     str(times,tmp_str);
     txt := upcasestr(paramstr(3));
     if (txt = '') then sintaxe;
     {$I-}
     assign(ft,txt);
     reset(ft);
     if (ioresult <> 0) then
        begin
             rewrite(ft);
             write(ft,tmp_str);
             close(ft);
             {$I+}
             halt;
        end
     else
         read(ft,tmp_str);
         val(tmp_str,times,i);
         if i <> 0 then sintaxe;
         close(ft);
         if times <= 1 then
            begin
                 erase(ft);
                 {$I+}
                 halt;
            end
         else
             rewrite(ft);
             times := times - 1;
             str(times,tmp_str);
             write(ft,tmp_str);
             close(ft);
    {$I+}
    halt;
end;


{ SCRAMBLE }
procedure scramble;

var
   mixtbl  : array [1..80] of byte;
   notseed : byte;

begin
     if paramcount = 1 then sintaxe;
     if (paramcount <> 3) and (paramcount <> 4) then sintaxe;
     val(paramstr(2),cor1,i);
     txt := paramstr(3);
     tsize := length(txt);
     if tsize > 80 then
        begin
             delete(txt,81,tsize);
             tsize := length(txt);
        end;
     randomize;
     for i := 1 to 80 do
         mixtbl[i] := 0;
     i := 0;
     while i <= tsize do
           begin
                tpos := random(tsize)+1;
                notseed := 0;
                for i2 := 1 to i do
                    if tpos <> mixtbl[i2] then inc(notseed);
                if notseed = i then
                   begin
                        mixtbl[i] := tpos;
                        inc(i);
                   end;
           end;
     textattr := cor1;
     for i := 1 to tsize do
         write(txt[mixtbl[i]]);
     if paramcount = 4 then
        begin
             val(paramstr(4),i2,i);
             normvideo;
             x := wherex-tsize;
             writeln;
             y := wherey;
             for i := 1 to i2 do
                 begin
                      writexy(x,y+i-1,'? ');
                      readln(s);
                      if s = txt then halt(1);
                 end;
             halt(0);
        end;
     halt;
end;


{ SLICE }
procedure slice;

var
   half1,half2    : string;
   size1,size2,x1 : byte;

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
     tsize := length(txt);
     half1 := copy(txt,1,tsize div 2);
     half2 := copy(txt,(tsize div 2)+1,tsize);
     size2 := length(half2);
     textattr := cor1;
     if s = 'DTRO' then
        begin
             for i := 1 to x do
                 insert(' ',half1,1);
             size1 := length(half1);
             i := 1;
             i2 := 80;
             tpos := 1;
             repeat
                   writexy(1,y,copy(half1,size1-i+1,size1));
                   writexy(i2,y,copy(half2,1,tpos-2) + ' ');
                   if i < x then inc(i);
                   if (i2 > x) then
                      begin
                           dec(i2);
                           inc(tpos);
                      end;
                   delay(time);
             until (i >= x ) and (i2 <= x);
        end;
     if s = 'FORA' then
        begin
             if x-length(half1) < 0 then
                delete(half1,x+1,length(half1));
             size1 := length(half1);
             i2 := x+size2-80;
             if x+size2 > 80 then
                delete(half2,size2-i2,size2);
             i := -1;
             i2 := x;
             repeat
                   writexy(x-size1-i,y,half1 + ' ');
                   writexy(i2+1,y,' ' + half2);
                   if x-size1-i > 1 then inc(i) else
                      delete(half1,1,1);
                   if i2+size2+1 < 80 then inc(i2) else
                      delete(half2,size2,size2);
                   size1 := length(half1);
                   size2 := length(half2);
                   delay(time);
             until (size1 = 0) and (size2 = 0);
             gotoxy(1,y);
             clreol;
        end;
     ligar_cursor;
     halt;
end;


{ TYPECHR }
procedure typechr;

var vchr : byte;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 7 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),time,i);
     val(paramstr(6),vchr,i);
     key := chr(vchr);
     txt := '';
     val(paramstr(7),i2,i);
     textattr := cor1;
     for i := 1 to i2 do
         begin
              insert(key,txt,1);
              writexy(x,y,txt);
              if x+length(txt) > 80 then
                 begin
                      i := i2;
                      gotoxy(1,wherey-1);
                 end;
              delay(time);
         end;
     ligar_cursor;
     halt;
end;


{ TYPEIT 2 }
procedure typeit2;

var freq,speed : integer;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 9 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),cor2,i);
     val(paramstr(6),freq,i);
     val(paramstr(7),time,i);
     val(paramstr(8),speed,i);
     txt := paramstr(9);
     delete(txt,80-x,length(txt));
     tmp_str := 'Ü';
     for i := x to 79 do
         tmp_str:= tmp_str + 'Ä';
     tsize := length(tmp_str);
     for i := 1 to length(txt) do
         begin
              textattr := cor1;
              writexy(x,y,copy(txt,1,i));
              textattr := cor2;
              delete(tmp_str,tsize-i,tsize);
              tsize := length(tmp_str);
              writexy(wherex,y,tmp_str);
              playsnd(freq,time);
              nosound; delay(speed);
         end;
     gotoxy(x+length(txt),y);
     clreol;
     ligar_cursor;
     halt;
end;


{ SCROLL VERTICAL }
procedure vscroll;

var ymax : byte;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 7 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),time,i);
     txt := paramstr(6);
     delete(txt,81-x,length(txt));
     tsize := length(txt);
     s := upcasestr(paramstr(7));
     if s = 'BAIXO' then
        for i := 1 to tsize do
            for i2 := 1 to y do
                begin
                     key := getchar(x+i-1,i2);
                     textattr := cor1;
                     writexy(x+i-1,i2,txt[i]);
                     delay(time);
                     if i2 < y then
                        begin
                             normvideo;
                             writexy(x+i-1,i2,key);
                        end;
                end;
     val(paramstr(7),ymax,i);
     if (ymax = 25) or (ymax = 43) or (ymax = 50) then
        for i := 1 to tsize do
            for i2 := ymax downto y do
                begin
                     key := getchar(x+i-1,i2);
                     textattr := cor1;
                     writexy(x+i-1,i2,txt[i]);
                     delay(time);
                     if i2 > y then
                        begin
                             normvideo;
                             writexy(x+i-1,i2,key);
                        end;
                end;
     ligar_cursor;
     halt;
end;


{ TYPEXY VERTICAL }
procedure vtypexy;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 8 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),cor2,i);
     val(paramstr(6),time,i);
     txt := paramstr(7);
     tsize := length(txt);
     tmp_str := paramstr(8);
     tmp_str := tmp_str[1];
     for i := 1 to tsize do
         begin
              textattr := cor2;
              writexy(x,y+i,tmp_str);
              textattr := cor1;
              writexy(x,y+i-1,txt[i]);
              delay(time);
         end;
     writexy(x,y+tsize,' ');
     gotoxy(x,y+tsize-1);
     ligar_cursor;
     halt;
end;



{ VERSŽO }
procedure version;

begin
     writeln;
     writeln('Batch Tools 2 v1.0 (c) 1994');
     writeln('por Luis Manuel Santos Guerra');
     writeln('para a revista SPOOLER');
     writeln('em 94-10-16');
     halt;
end;


{ CREDITOS }
procedure creditos;

begin
     writeln;
     writeln('Batch Tools 2 v1.0 (c) 1994');
     writeln('por Luis Manuel Santos Guerra');
     writeln('para a revista SPOOLER');
     writeln('em 94-10-16');
     writeln;
     writeln('Sintaxe:');
     writeln('Bt2');
     writeln('Bt2 [comando]');
     writeln('Bt2 [comando] [parƒmetros]');
     writeln;
     writeln('Comandos de Batch Tools:');
     writeln('AsciiTbl   PaintTxt   TypeChr');
     writeln('ColorRef   PaintWin   TypeIt2');
     writeln('Colorize   PauseKey   VScroll');
     writeln('Crush      Repeat     VTypeXY');
     writeln('Dice       Scramble   Ver');
     writeln('MoveCor    Slice');
     halt;
end;


{ SINTAXE }
procedure sintaxe;

begin
     if c = 'ASCIITBL' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('AsciiTbl [?]');
             writeln;
             writeln('[?]');
             writeln('Ao teclar ?, ‚ apresentada a tabela ASCII dos');
             writeln('caracteres disponiveis e dos valores decimais');
             writeln('correspondentes, de valor entre de 0 a 255.');
        end;
     if c = 'COLORREF' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('ColorRef [?]');
             writeln;
             writeln('[?]');
             writeln('Ao teclar ?, visualizam-se exemplos de todas as');
             writeln('combina‡”es de cor que se encontram dispon¡veis');
             writeln('em Batch Tools, cujo valor varia entre 0 e 255.');
        end;
     if c = 'COLORIZE' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Colorize [coluna] [linha] [lim1] [lim2] [tempo] [texto] [opt]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[lim1] e [lim2]');
             writeln('Respectivamente, os limites inferior e superior do valor que a cor');
             writeln('a ser aleatoriamente atribuida a cada caracter do [texto] ir  ter,');
             writeln('de acordo com: 0 <= lim1 <= lim2 <= 255. Mais info, use ColorRef.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[texto]');
             writeln('Texto a escrever no ‚cran. Caso se escrevam v rias palavras use como');
             writeln('separador o caracter inv¡sivel (Alt+255). Se o texto a apresentar no');
             writeln('‚cran ultrapassar a coluna 80 a parte em excesso ser  truncada.');
             writeln;
             writeln('[opt]');
             writeln('Escolha como op‡„o TECLA ou FIMTXT: o ciclo de atribui‡„o aleat¢ria');
             writeln('de cores a cada caracter termina, respectivamente, se uma tecla for');
             writeln('pressionada ou quando for atribuida nova cor a todos os caracteres.');
        end;
     if c = 'CRUSH' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Crush [coluna] [linha] [cor] [tempo] [texto] [crush]');
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
             writeln('[crush]');
             writeln('Modo de aparecimento do texto seleccionando uma das seguintes op‡”es');
             writeln('apresentadas: DTRO, FORA, ESQ_DTRO, ESQ_FORA, DIR_DTRO, DIR_FORA.');
        end;
     if c = 'DICE' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Dice [cor] [tempo] [sorteia]');
             writeln('Dice [sorteia]');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso no sorteio de um valor aleat¢rio, em milisegundos.');
             writeln('Serve para tornar o valor mais leg¡vel (n„o exagere!).');
             writeln;
             writeln('[sorteia]');
             writeln('Ao teclar SORTEIA como parƒmetro, ‚ sorteado aleatoriamente');
             writeln('um valor num‚rico entre 1 e 6, E esse valor tem sa¡da  para');
             writeln('ErrorLevel. Se [sorteia] for o £nico parƒmetro, o sorteio ‚');
             writeln('imediato e o resultado n„o tem output para o monitor.');
        end;
     if c = 'MOVECOR' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('MoveCor [coluna] [linha] [cor_txt] [cor_cur] [tempo] [texto] [rpt] [movecor]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor_txt] e [cor_cur]');
             writeln('Define a cor do texto e do cursor, cujo valor varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[texto]');
             writeln('Texto a escrever no ‚cran. Caso se escrevam v rias palavras use como');
             writeln('separador o caracter inv¡sivel (Alt+255). Se o texto a apresentar no');
             writeln('‚cran ultrapassar a coluna 80 a parte em excesso ser  truncada.');
             writeln;
             writeln('[rpt]');
             writeln('N£mero de vezes que a opera‡„o [movecor] ‚ repetida.');
             writeln;
             writeln('[movecor]');
             writeln('Escolha um dos seguintes e veja o resultado: ESQ, DIR, AMBOS.');
        end;
     if c = 'PAINTTXT' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('PaintTxt [coluna] [linha] [cor] [tamanho]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor]');
             writeln('Cor a atribuir a texto que se encontre presente no ‚cran,');
             writeln('que varia entre 0 e 255.');
             writeln;
             writeln('[tamanho]');
             writeln('N£mero de caracteres aos quais quer atribuir nova cor.');
        end;
     if c = 'PAINTWIN' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('PaintWin [x1] [y1] [x2] [y2] [cor]');
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
             writeln('Cor a atribuir a texto que se encontre presente na janela');
             writeln('que foi definida com as coordenadas acima.');
        end;
     if c = 'PAUSEKEY' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Pausekey [cor] [texto] [teclas]');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[texto]');
             writeln('Texto onde se apresentam as teclas que anulam a pausa.');
             writeln;
             writeln('[teclas]');
             writeln('Lista das teclas (letras ou n£meros), at‚ 8 no m ximo.');
             writeln('Ap¢s a press„o de uma dessas teclas, ser   devolvido o');
             writeln('valor ErrorLevel igual … posi‡„o dessa tecla na lista.');
        end;
     if c = 'REPEAT' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Repeat [n] [nome.rpt]');
             writeln;
             writeln('[n]');
             writeln('N£mero de vezes que uma batch file recursiva ‚ executada.');
             writeln;
             writeln('[nome.rpt]');
             writeln('Nome do ficheiro onde se grava o valor de [n]. A instru‡„o');
             writeln('"Repeat [n] [nome.rpt]" s¢ deve usada  com a "If Not Exist');
             writeln('[nome.rpt] GoTo End" e apenas em batch files recursivas. ‘');
             writeln('medida que se repete "Repeat [n] [nome.rpt]" o valor [n] ‚');
             writeln('decrementado, e gravado no ficheiro [nome.rpt]. No momento');
             writeln('em que [n] tiver o valor 1, o ficheiro ser  apagado. O uso');
             writeln('da instru‡„o "If Not Exist [nome.rpt] GoTo End" verifica a');
             writeln('ausˆncia de [nome.rpt], e salta para a label  identificada');
             writeln('como End. As instru‡”es "Repeat..." e "If Not..." s¢ podem');
             writeln('ser usadas no inicio da batch file a executar; a label End');
             writeln('deve ser a £ltima linha dessa mesma batch file.');
             writeln('Examine a batch file Repeat.Bat que serve de demonstra‡„o.');
        end;
     if c = 'SCRAMBLE' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Scramble [cor] [texto] [rpt]');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[texto]');
             writeln('Conjunto de caracteres, cuja posi‡„o relativa');
             writeln('ser  aleatoriamente alterada.');
             writeln;
             writeln('[rpt]');
             writeln('N£mero de vezes que se pergunta pela palavra original.');
             writeln('Este parƒmetro ‚ opcional. Devolve um valor ErrorLevel');
             writeln('1 ao acertar na palavra original, e 0 ao falhar  todas');
             writeln('as tentantivas permitidas com [rpt].');
        end;
     if c = 'SLICE' then
        begin
             writeln;
             writeln('Sintaxe');
             writeln('Slice [coluna] [linha] [cor] [tempo] [texto] [slice]');
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
             writeln('[slice]');
             writeln('Modo de aparecimento do texto seleccionando uma das seguintes');
             writeln('op‡”es apresentadas: DTRO, FORA');
        end;
     if c = 'TYPECHR' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('TypeChr [coluna] [linha] [cor] [tempo] [chr] [n]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor]');
             writeln('Cor do caracter a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[chr]');
             writeln('Valor ASCII do caracter a ser escrito [n] vezes no ‚cran.');
             writeln('Use a fun‡„o AsciiTbl para saber o n£mero decimal que lhe');
             writeln('corresponde na tabela.');
             writeln;
             writeln('[n]');
             writeln('N£mero de vezes que [chr] ‚ escrito.');
        end;
     if c = 'TYPEIT2' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Typeit2 [coluna] [linha] [cor_txt] [cor_bar] [freq] [freq_tempo] [tempo] [texto]');
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor_txt] e [cor_bar]');
             writeln('Define as cores do texto e da barra. Valor num‚rico entre 0 e 255.');
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
        end;
     if c = 'VSCROLL' then
        begin
             writeln('Sintaxe:');
             writeln('VScroll [coluna] [linha] [cor] [tempo] [texto] [scroll]');
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
             writeln('[scroll]');
             writeln('Modo de aparecimento do texto seleccionando uma das seguintes');
             writeln('op‡”es apresentadas: BAIXO, 25, 43, 50.');
        end;
     if c = 'VTYPEXY' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('VTypexy [coluna] [linha] [cor_txt] [cor_cur] [tempo] [texto] [cursor]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Respectivamente as coordenadas x e y no monitor, de valores entre');
             writeln('1 a 80 para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor_txt] e [cor_cur]');
             writeln('Define a cor do texto e do cursor, cujo valor varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[texto]');
             writeln('Frase a escrever no ‚cran. Caso o texto tenha v rias palavras, use');
             writeln('caracter (Alt+255) no lugar do space. O n£mero de caracteres a ser');
             writeln('considerado como limite deve ser igual ao valor m ximo de y.');
             writeln;
             writeln('[cursor]');
             writeln('Cursor que precede a frase a escrever no ‚cran.');
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
             if c = 'ASCIITBL' then reftable;
             if c = 'COLORREF' then reftable;
             if c = 'COLORIZE' then colorize;
             if c = 'CRUSH' then crush;
             if c = 'DICE' then dice;
             if c = 'MOVECOR' then movecor;
             if c = 'PAINTTXT' then painttxt;
             if c = 'PAINTWIN' then paintwin;
             if c = 'PAUSEKEY' then pausekey;
             if c = 'REPEAT' then repeatn;
             if c = 'SCRAMBLE' then scramble;
             if c = 'SLICE' then slice;
             if c = 'TYPECHR' then typechr;
             if c = 'TYPEIT2' then typeit2;
             if c = 'VTYPEXY' then vtypexy;
             if c = 'VSCROLL' then vscroll;
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
