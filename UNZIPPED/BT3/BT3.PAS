 { Batch Tools 3
  Autor ÄÄÄÄÄÄ Luis Manuel Santos Guerra
  Linguagem ÄÄ Turbo Pascal 6.0
  Objectivo ÄÄ Criar ferramentas para rotinas batch
  Inicio ÄÄÄÄÄ 94-10-26 ÄÂÄ v1.0
  Fim ÄÄÄÄÄÄÄÄ 94-11-03 ÄÙ


  Evolu‡„o do programa:

  94-10-26   - Constru‡„o do Corpo do Programa e inclus„o das procedures:
               Ligar_Cursor, Desligar_Cursor, Esvaziar Buffer do Teclado,
               Obter Caracter, WriteXY, Upcase_String, Verify, Sintaxe, Ver
             - Constru‡„o das procedures GetXY, Typeit3, Factorial

  94-10-27   - Constru‡„o da procedure Scroll Vertical 2
             - Altera‡”es em Factorial e Sintaxe

  94-10-28   - Constru‡„o ou altera‡„o das seguintes procedures auxiliares:
               Procura Ficheiro, Inicializa Rato, Apontar Seta do Rato,
               Mostra Seta do Rato, Esconde Seta do Rato, Valor X do Rato,
               Valor Y do Rato, Detectar Movimento do Rato, Teclar Rato,
             - Constru‡„o da procedure MenuMouse

  93-10-30   - Constru‡„o das procedures:
               Detecta Rato Dentro de Janela, YesNoBox
             - Altera‡”es em Inicializar Rato, MenuMouse e Sintaxe
             - Constru‡„o de uma batch file de nome Bt3Menu.Bat para teste
               conjunto das fun‡”es MenuMouse, YesNoBox e TypeIt 3 de BT3

  93-10-31   - Alem„o est  agora dispon¡vel em YesNoBox
             - Constru‡„o das seguintes procedures auxiliares:
               Atribuir Moldura, Fazer Moldura
             - Altera‡”es menores em MenuMouse e YesNoBox
             - Constru‡„o da procedure SysBox e Browse 2

  93-11-02   - Constru‡„o de FillWin, DosShell, e de Procura Direct¢rio
             - Separa‡„o de DosShell e Procura Direct¢rio para BT3Shell.Exe
             - Constru‡„o de uma batch file de nome BT3Shell.Bat para servir
               de demonstra‡„o … fun‡„o DosShell
             - Altera‡”es em Sintaxe e Ver

  93-11-03   - Constru‡„o da procedure TypeTxt e suas fun‡”es Insert, Delete,
               e procedure Append e suas fun‡”es Left_In, Left_Out, Right_In
               Right_Out
             - Altera‡”es em Sintaxe e Ver
             - Conclus„o da vers„o 1.0


  Bugs?
  Sugest”es?
  Escreva para:

  Luis Manuel Santos Guerra
  Rua Ferreira de Castro, n§6, 2§dto
  Cova de Piedade
  2800 Almada }

program bt3 (input,output);

{$N+,E+}

uses
    dos,crt;

var
   x,y,x1,y1,x2,y2,tpos,cor1,cor2,cor3 : byte;
   mx,my,i,i2,time,tsize : integer;
   c,s,txt,tmp_str : string;
   line : string[80];
   is_mouse,exit : boolean;
   key : char;
   ft : text;
   r : registers;

procedure sintaxe; forward;


{ DESLIGAR CURSOR }
procedure desligar_cursor;

begin
     r.ah := 01;
     r.ch := 40;
     r.cl := 0;
     intr($10,r);
end;


{ LIGAR CURSOR }
procedure ligar_cursor;

begin
     r.ah := 01;
     r.ch := 3;
     r.cl := 4;
     intr($10,r);
end;


{ INICIALIZA RATO }
procedure ini_mouse;

begin
     is_mouse := false;
     r.ax := 0;
     intr($33,r);
     if r.ax <> 0 then is_mouse := true;
end;


{ APONTAR SETA DO RATO }
procedure aim_mouse(x,y:integer);

begin
     r.ax := 4;
     r.cx := x;
     r.dx := y;
     intr($33,r);
     mx := x;
     my := y;
end;


{ MOSTRA SETA DO RATO }
procedure show_mouse;

begin
     r.ax := 01;
     Intr($33,r);
end;


{ ESCONDE SETA DO RATO }
procedure hide_mouse;

begin
     r.ax := 02;
     intr($33,r);
end;


{ VALOR X DO RATO }
function x_mouse:integer;

begin
     r.ax := 03;
     intr($33,r);
     x_mouse := r.cx div 8 + 1;
end;


{ VALOR Y DO RATO }
function y_mouse:integer;

begin
     r.ax := 03;
     intr($33,r);
     y_mouse := r.dx div 8 + 1;
end;


{ DETECTA MOVIMENTO DO RATO }
function mov_mouse:boolean;

begin
     mov_mouse := false;
     if (x_mouse <> mx) or (y_mouse <> my) then
        begin
             mx := x_mouse;
             my := y_mouse;
             mov_mouse := true;
        end;
end;


{ DETECTA RATO DENTRO DE JANELA }
function win_mouse(x1,y1,x2,y2:integer):boolean;

begin
     win_mouse := false;
     if (x1 < mx) and (x2 > mx) and (y1 < my) and (y2 > my) then
        win_mouse := true;
end;


{ TECLAR RATO }
function key_mouse:integer;

begin
     r.ax := 03;
     intr($33,r);
     key_mouse := r.bx;
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
    r.ah := 2;
    r.dh := y-1;
    r.dl := x-1;
    r.bh := 0;
    intr($10,r);
    fillchar(r,sizeof(r),0);
    r.ah := 8;
    r.bh := 0;
    intr($10,r);
    getchar := chr(r.al);
end;


{ WRITEXY }
procedure writexy(x,y:byte; s:string);

begin
     gotoxy(x,y);
     write(s);
end;


{ GETXY }
procedure getxy;

begin
     x := wherex;
     y := wherey;
end;


{ ATRIBUIR MOLDURA }
function frameattr(s:string):string;

begin
     if s = 'DUPLA' then frameattr := 'ÉÈ»¼Íº¹Ì';
     if s = 'DPHOR' then frameattr := 'ÕÔ¸¾Í³µÆ';
     if s = 'DPVER' then frameattr := 'ÖÓ·½Äº¶Ç';
     if s = 'NORMAL' then frameattr := 'ÚÀ¿ÙÄ³´Ã';
end;


{ FAZER MOLDURA }
procedure frame(x1,y1,x2,y2:byte);

begin
     s := frameattr(s);
     for i := x1 to x2 do
         for i2 := y1 to y2 do
             writexy(i,i2,' ');
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
end;


{ UPCASE STRING }
function upcasestr(s:string):string;

begin
     for i:= 1 to length(s) do
         s[i] := upcase(s[i]);
     upcasestr := s;
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


{ APPEND }
procedure append;

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
     delete(txt,81-x,length(txt));
     tsize := length(txt);
     textattr := cor1;
     if s = 'ESQ_DTRO' then
        begin
             for i := tsize downto 1 do
                 for i2 := 1 to (x+i-2) do
                     begin
                          writexy(i2,y,' '+txt[i]);
                          delay(time);
                     end;
             writexy(x,y,txt[1]);
        end;
     if s = 'ESQ_FORA' then
        begin
             writexy(x,y,txt);
             for i := tsize downto 1 do
                 for i2 := (x+i-1) to 79 do
                     begin
                          writexy(i2,y,' '+txt[i]);
                          writexy(80,y,' ');
                          delay(time);
                     end;
             gotoxy(x,wherey-1);
        end;
     if s = 'DIR_DTRO' then
        for i := 1 to tsize do
            for i2 := 79 downto (x+i-1) do
                begin
                     writexy(i2,y,txt[i]+' ');
                     delay(time);
                end;
     if s = 'DIR_FORA' then
        begin
             writexy(x,y,txt);
             for i := 1 to tsize do
                 for i2 := (x+i-2) downto 1 do
                     begin
                          writexy(i2,y,txt[i]+' ');
                          writexy(1,y,' ');
                          delay(time);
                     end;
        end;
     ligar_cursor;
     halt;
end;


{ BROWSE 2 }
procedure browse2;

begin
     if paramcount = 1 then sintaxe;
     if (paramcount <> 3) and (paramcount <> 9) then sintaxe;
     getxy;
     desligar_cursor;
     if paramcount = 9 then
        begin
             val(paramstr(2),x1,i);
             val(paramstr(3),y1,i);
             val(paramstr(4),x2,i);
             val(paramstr(5),y2,i);
             val(paramstr(6),cor1,i);
             val(paramstr(7),cor2,i);
             val(paramstr(8),time,i);
             txt := paramstr(9);
             window(x1,y1,x2,y2);
             textcolor(cor1);
             textbackground(cor2);
             clrscr;
             gotoxy(1,wherey);
        end;
     if paramcount = 3 then
        begin
             val(paramstr(2),time,i);
             txt := paramstr(3);
             gotoxy(1,wherey);
        end;
     {$I-}
     assign(ft,txt);
     reset(ft);
     file_chk;
     repeat
           readln(ft,txt);
           writeln(txt);
           delay(time);
           if keypressed then
              begin
                   key := readkey;
                   if (key = 'P') or (key ='p') then
                      repeat until keypressed;
                   flushkbd;
              end;
     until (key = #27) or eof(ft);
     flushkbd;
     if (paramcount = 9) and eof(ft) then
        for i := y1 to y2 do
            begin
                 writeln;
                 delay(time);
            end;
     if paramcount = 9 then
        begin
             normvideo;
             clrscr;
        end;
     close(ft);
     {$I+}
     ligar_cursor;
     halt;
end;


{ FACTORIAL }
procedure factorial;

var
   fact: extended;
   f: longint;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 4 then sintaxe;
     val(paramstr(2),cor1,i);
     val(paramstr(3),time,i);
     getxy;
     if paramstr(4) = '?' then
        begin
             writexy(x,y,'? ');
             read(txt);
             val(txt,f,i);
        end
     else val(paramstr(4),f,i);
     desligar_cursor;
     textattr := cor1;
     fact := 1;
     for i := f downto 2 do
         begin
              fact := fact * i;
              gotoxy(x,y);
              write(fact,' * ',i,' ');
              delay(time);
         end;
     gotoxy(x,y);
     write(f,'! =',fact);
     ligar_cursor;
     halt;
end;


{ FILLWIN }
procedure fillwin;

var vchr : byte;

begin
     if paramcount = 1 then sintaxe;
     if (paramcount <> 8) and (paramcount <> 9) then sintaxe;
     desligar_cursor;
     val(paramstr(2),x1,i);
     val(paramstr(3),y1,i);
     val(paramstr(4),x2,i);
     val(paramstr(5),y2,i);
     val(paramstr(6),cor1,i);
     val(paramstr(7),time,i);
     val(paramstr(8),vchr,i);
     key := chr(vchr);
     textattr := cor1;
     if paramcount = 8 then
        for i := y1 to y2 do
            for i2 := x1 to x2 do
                begin
                     writexy(i2,i,key);
                     delay(time);
                end;
     if upcasestr(paramstr(9))='RANDOM' then
        begin
             randomize;
             repeat
                    x := random(x2)+x1-1;
                    y := random(y2)+y1-1;
                    writexy(x,y,key);
                    delay(time);
             until keypressed;
             flushkbd;
        end;
     ligar_cursor;
     halt;
end;


{ MENU DE RATO }
procedure menumouse;

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
     desligar_cursor;
     ini_mouse;
     if is_mouse then
        begin
             aim_mouse(1,1);
             show_mouse;
        end;
     exit := false;
     repeat
           textattr := cor2;
           itemcode := i-y1+1;
           writexy(x,i,menuitem[itemcode]);
           if keypressed then
              begin
                   key := readkey;
                   case key of
                    #13,#27 : exit := true;
                     #9,#80 : begin
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
                                           exit := true;
                                      end;
                              end;
                   end;
                   flushkbd;
              end;
           if is_mouse and mov_mouse then
              if (y_mouse >= y1) and (y_mouse < y2) then
                 begin
                      if key_mouse <> 0 then exit := true;
                      textattr := cor1;
                      writexy(x,i,menuitem[itemcode]);
                      i := y_mouse;
                 end;
           if is_mouse and (key_mouse <> 0) then exit := true;
     until exit = true;
     hide_mouse;
     ligar_cursor;
     textattr := cor2;
     writexy(x,i,menuitem[itemcode]);
     if (key = #27) or (key_mouse = 2) then halt(0);
     halt(ord(itemcode));
end;


{ CAIXA INFO DO SISTEMA }
procedure sysbox;

var dsize,dused,dfree,mem:longint;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 7 then sintaxe;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),cor2,i);
     val(paramstr(6),cor3,i);
     s := upcasestr(paramstr(7));
     desligar_cursor;
     textattr := cor1;
     frame(x,y,x+18,y+9);
     dsize := disksize(0) div 1024;
     dfree := diskfree(0) div 1024;
     dused := dsize - dfree;
     mem := (memavail div 1024) + 57; { + mem¢ria ocupada por BT3 };
     ini_mouse;
     if is_mouse then
        begin
             writexy(x+2,y,s[7]+' '+s[8]);
             aim_mouse(1,1);
             show_mouse;
        end;
     textattr := cor2;
     writexy(x+2,y+1,'Drive:');
     writexy(x+2,y+5,'Mem:');
     writexy(x+2,y+7,'Dos Version:');
     if is_mouse then writexy(x+3,y,'þ');
     textattr := cor3;
     gotoxy(x+2,y+2); write(dsize,' kb total');
     gotoxy(x+2,y+3); write(dused,' kb used');
     gotoxy(x+2,y+4); write(dfree,' kb free');
     gotoxy(x+2,y+6); write(mem,' kb free');
     gotoxy(x+2,y+8); write(lo(dosversion),'.',hi(dosversion));
     exit := false;
     repeat
           if keypressed then
              begin
                   key := readkey;
                   if key = #27 then exit := true;
                   flushkbd;
              end;
           if is_mouse and ((x_mouse = x+3) and (y_mouse = y)) then
              if key_mouse <> 0 then exit := true;
           if is_mouse and (key_mouse = 2) then exit := true;
     until exit = true;
     hide_mouse;
     ligar_cursor;
     gotoxy(x,y+9);
     halt;
end;


{ TYPEIT 3 }
procedure typeit3;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 6 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     val(paramstr(5),time,i);
     txt := paramstr(6);
     delete(txt,81-x,length(txt));
     tsize := length(txt);
     textattr := cor1;
     for i := 1 to tsize do
         begin
              case ord(txt[i]) of
                   33..47: i2 := 33;
                   48..57: i2 := 48;
                   65..90: i2 := 65;
                   97..122: i2 := 97;
                   128..165: i2 := 128;
                   176..223: i2 := 176;
                   224..235: i2 := 224;
                   236..253: i2 := 236;
              else i2 := ord(txt[i]);
              end;
              for i2 := i2 to ord(txt[i]) do
                  begin
                       writexy(x+i-1,y,chr(i2));
                       delay(time);
                  end;
         end;
     ligar_cursor;
     halt;
end;


{ TYPETXT }
procedure typetxt;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 6 then sintaxe;
     desligar_cursor;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor1,i);
     txt := paramstr(5);
     s := upcasestr(paramstr(6));
     delete(txt,81-x,length(txt));
     tsize := length(txt);
     for i := 1 to 80 do
         line[i] := getchar(i,y);
     if s = 'INSERIR' then
        begin
             insert(txt,line,x);
             writexy(1,y,copy(line,1,80));
             textattr := cor1;
             writexy(x,y,txt);
        end;
     if s = 'DELETAR' then
        begin
             delete(line,x,tsize);
             gotoxy(1,y);
             clreol;
             writexy(1,y,copy(line,1,80-tsize));
        end;
     ligar_cursor;
     halt;
end;


{ SCROLL VERTICAL 2 }
procedure vscroll2;

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
     for i := 1 to y do
         begin
              for i2 := 1 to tsize do
                  line[i2] := getchar(i2,i);
              textattr := cor1;
              writexy(x,i,txt);
              delay(time);
              if i < y then
                 begin
                      normvideo;
                      writexy(1,i,copy(line,1,tsize));
                 end;
         end;
     val(paramstr(7),ymax,i);
     if (ymax = 25) or (ymax = 43) or (ymax = 50) then
     for i := ymax downto y do
         begin
              for i2 := 1 to tsize do
                  line[i2] := getchar(i2,i);
              textattr := cor1;
              writexy(x,i,txt);
              delay(time);
              if i > y then
                 begin
                      normvideo;
                      writexy(1,i,copy(line,1,tsize));
                 end;
         end;
     ligar_cursor;
     halt;
end;


{ CAIXA SIM-NŽO }
procedure yesnobox;

var
   yn_use : array[0..1] of string;

begin
     if paramcount = 1 then sintaxe;
     if paramcount <> 8 then sintaxe;
     val(paramstr(2),x,i);
     val(paramstr(3),y,i);
     val(paramstr(4),cor3,i);
     val(paramstr(5),cor1,i);
     val(paramstr(6),cor2,i);
     s := upcasestr(paramstr(7));
     txt := upcasestr(paramstr(8));
     desligar_cursor;
     if txt = 'POR' then
        begin
             yn_use[0] := ' N„o ';
             yn_use[1] := ' Sim ';
        end;
     if txt = 'ENG' then
        begin
             yn_use[0] := ' No  ';
             yn_use[1] := ' Yes ';
        end;
     if txt = 'FRA' then
        begin
             yn_use[0] := ' Non ';
             yn_use[1] := ' Oui ';
        end;
     if txt = 'ALE' then
        begin
             yn_use[0] := 'Nein ';
             yn_use[1] := ' Ja  ';
        end;
     textattr := cor3;
     frame(x,y,x+17,y+4);
     writexy(x+1,y+1,' ÚÄÄÄÄÄ¿ÚÄÄÄÄÄ¿ ');
     writexy(x+1,y+2,' ³     ³³     ³ ');
     writexy(x+1,y+3,' ÀÄÄÄÄÄÙÀÄÄÄÄÄÙ ');
     ini_mouse;
     if is_mouse then
        begin
             writexy(x+2,y,s[7]+' '+s[8]);
             aim_mouse(1,1);
             show_mouse;
        end;
     textattr := cor1;
     if is_mouse then writexy(x+3,y,'þ');
     writexy(x+3,y+2,yn_use[1]);
     writexy(x+10,y+2,yn_use[0]);
     exit := false;
     i := 1;
     repeat
           textattr := cor2;
           if i = 1 then writexy(x+3,y+2,yn_use[1]);
           if i = 0 then writexy(x+10,y+2,yn_use[0]);
           if keypressed then
              begin
                   key := readkey;
                   case key of
                   #13,#27 : exit := true;
                #9,#75,#77 : begin
                                  textattr := cor1;
                                  if i = 1 then writexy(x+3,y+2,yn_use[1]);
                                  if i = 0 then writexy(x+10,y+2,yn_use[0]);
                                  if i = 1 then dec(i) else inc(i);
                             end;                      
                   end;
                   flushkbd;
              end;
           if is_mouse and mov_mouse then
              begin
                   textattr := cor1;
                   if win_mouse(x+2,y+1,x+8,y+3) then
                      begin
                           if key_mouse <> 0 then exit := true;
                           writexy(x+10,y+2,yn_use[0]);
                           i := 1;
                      end;
                   if win_mouse(x+9,y+1,x+15,y+3) or
                      ((x_mouse = x+3) and (y_mouse = y)) then
                      begin
                           if key_mouse <> 0 then exit := true;
                           writexy(x+3,y+2,yn_use[1]);
                           i := 0;
                      end;
              end;
           if is_mouse and (key_mouse <> 0) then exit := true;
     until exit = true;
     hide_mouse;
     ligar_cursor;
     gotoxy(x,y+4);
     if (key = #27) or (key_mouse = 2) then halt(0);
     halt(i);
end;


{ VERSŽO }
procedure version;

begin
     writeln;
     writeln('Batch Tools 3 v1.0 (c) 1994');
     writeln('por Luis Manuel Santos Guerra');
     writeln('para a revista SPOOLER');
     writeln('em 94-11-03');
     halt;
end;


{ CREDITOS }
procedure creditos;

begin
     writeln;
     writeln('Batch Tools 3 v1.0 (c) 1994');
     writeln('por Luis Manuel Santos Guerra');
     writeln('para a revista SPOOLER');
     writeln('em 94-11-03');
     writeln;
     writeln('Sintaxe:');
     writeln('Bt3');
     writeln('Bt3 [comando]');
     writeln('Bt3 [comando] [parƒmetros]');
     writeln;
     writeln('Comandos de Batch Tools:');
     writeln('Append    FillWin    TypeTxt');
     writeln('Browse2   MenuMouse  YesNoBox');
     writeln('DosShell  SysBox     VScroll2');
     writeln('Fact      TypeIt3    Ver');
     halt;
end;


{ SINTAXE }
procedure sintaxe;

begin
     if c = 'APPEND' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Append [coluna] [linha] [cor] [tempo] [texto] [append]');
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
             writeln('[append]');
             writeln('Modo de aparecimento do texto seleccionando uma das seguintes');
             writeln('op‡”es apresentadas: ESQ_DTRO, ESQ_FORA, DIR_DTRO, DIR_FORA.');
        end;
     if c = 'BROWSE2' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Browse2 [tempo] [fich.ext]');
             writeln('Browse2 [x1] [y1] [x2] [y2] [cor_texto] [cor_fundo] [tempo] [fich.ext]');
             writeln;
             writeln('[x1] e [x2]');
             writeln('Define as coordenadas horizontais esquerda e direita da janela.');
             writeln('x2 > x1 e x1 e x2 tˆm valores entre 1 e 80, no modo 80x25.');
             writeln;
             writeln('[y1] e [y2]');
             writeln('Define as coordenadas verticais superior e inferior da janela.');
             writeln('y2 > y1 e y1 e y2 tˆm valores entre 1 e 25, no modo 80x25.');
             writeln;
             writeln('[tempo]');
             writeln('Tempo de leitura para cada linha do texto a apresentar.');
             writeln;
             writeln('[cor_texto] e [cor_fundo]');
             writeln('Define as cores do texto e de fundo. Valor num‚rico entre 0 e 16.');
             writeln;
             writeln('[fich.ext]');
             writeln('Ficheiro de texto a abrir para leitura. Indica‡„o da drive e path ‚');
             writeln('opcional. Pode ser [drive:][\path\][fich.txt] em vez de [fich.txt].');
        end;
     if c = 'DOSSHELL' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('BT3Shell.Exe');
             writeln;
             writeln('Descri‡„o:');
             writeln('Esta ‚ uma fun‡„o externa ao BT3, localizada noutro ficheiro execut vel.');
             writeln('Ao executar o ficheiro BT3Shell.Exe ‚ criada uma nova sess„o DOS, … qual');
             writeln('se poder  regressar posteriormente, quando teclar EXIT na prompt do DOS.');
             writeln('A fun‡„o BT3Shell tem como objectivo o seu uso exclusivo em batch files.');
        end;
     if c = 'FACT' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Fact [cor] [tempo] [num]');
             writeln('Fact [cor] [tempo] [?]');
             writeln;
             writeln('[cor]');
             writeln('Cor do texto a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln('Torna mais legiveis todas as parcelas do c lculo.');
             writeln;
             writeln('[num] e [?]');
             writeln('N£mero inteiro, tal que [num] ò 1. Se em vez de [num] usar');
             writeln('como parƒmetro ?, BT3 pergunta pelo valor de [num].');
        end;
     if c = 'FILLWIN' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('FillWin [x1] [y1] [x2] [y2] [cor] [tempo] [chr] [random]');
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
             writeln('Cor dos caracteres a apresentar, que varia entre 0 e 255.');
             writeln;
             writeln('[tempo]');
             writeln('Atraso na escrita medido em milisegundos.');
             writeln;
             writeln('[chr]');
             writeln('Valor ASCII do caracter a ser escrito no interior da janela.');
             writeln('Use a fun‡„o AsciiTbl em BT2 para saber o n£mero decimal que');
             writeln('lhe ‚ correspondente na tabela.');
             repeat until keypressed;
             flushkbd;
             writeln;
             writeln('[random]');
             writeln('Escrevendo neste espa‡o RANDOM, a janela acima  definida ser ');
             writeln('preenchida aleatoriamente, at‚ que seja pressionada uma tecla');
             writeln('qualquer. Este parƒmetro ‚ opcional.');
        end;
     if c = 'MENUMOUSE' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('MenuMouse [coluna] [linha] [cor_item] [cor_sel] [fich.ext]');
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
     if c = 'SYSBOX' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('SysBox [coluna] [linha] [cor1] [cor2] [cor3] [moldura]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor1]');
             writeln('Determina a cor da moldura da caixa e do but„o de sa¡da.');
             writeln('Os limites para o valor num‚rico de cor s„o 0 e 255.');
             writeln;
             writeln('[cor2] e [cor3]');
             writeln('Determinam a cor dos t¡tulos e a cor do texto normal.');
             writeln('Os limites para o valor num‚rico de cor s„o 0 e 255.');
             writeln;
             writeln('[moldura]');
             writeln('Selecciona moldura: NORMAL, DUPLA, DPHOR, DPVER.');
        end;
     if c = 'TYPEIT3' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('Typeit3 [coluna] [linha] [cor] [tempo] [texto]');
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
             writeln('separador o caracter inv¡sivel (Alt+255). Se o texto tem mais do que');
             writeln('80 caracteres, a parte em excesso ser  truncada.');
        end;
     if c = 'TYPETXT' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('TypeTxt [coluna] [linha] [cor] [texto] [typetxt]');
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
             writeln('separador o caracter inv¡sivel (Alt+255). Se o texto tem mais do que');
             writeln('80 caracteres, a parte em excesso ser  truncada.');
             writeln;
             writeln('[typetxt]');
             writeln('Escolha uma das seguintes op‡”es apresentadas: INSERIR para inserir o');
             writeln('o texto nas coordenadas indicadas, e DELETAR para apagar o texto  que');
             writeln('foi escrito atrav‚s do comando anterior.');
        end;
     if c = 'VSCROLL2' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('VScroll2 [coluna] [linha] [cor] [tempo] [texto] [scroll]');
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
     if c = 'YESNOBOX' then
        begin
             writeln;
             writeln('Sintaxe:');
             writeln('YesNoBox [coluna] [linha] [cor1] [cor2] [cor3] [moldura] [l¡ngua]');
             writeln;
             writeln('[coluna] e [linha]');
             writeln('Define as coordenadas x e y no monitor, de valores entre 1 a 80');
             writeln('para o primeiro caso, e 1 a 25 no segundo, no modo 80x25.');
             writeln;
             writeln('[cor1]');
             writeln('Determina a cor da moldura da caixa e dos but”es.');
             writeln('Os limites para o valor num‚rico de cor s„o 0 e 255.');
             writeln;
             writeln('[cor2] e [cor3]');
             writeln('Determinam a cor do item normal e a cor do item seleccionado.');
             writeln('Os limites para o valor num‚rico de cor s„o 0 e 255.');
             writeln;
             writeln('[moldura]');
             writeln('Selecciona moldura: NORMAL, DUPLA, DPHOR, DPVER.');
             writeln;
             writeln('[l¡ngua]');
             writeln('Escolha da l¡ngua nativa, entre as seguintes: portuguˆs, inglˆs,');
             writeln('francˆs e alem„o. As entradas respectivas s„o POR, ENG, FRA, ALE.');
             writeln('Ao escolher Sim ou N„o, o valor de sa¡da em ErrorLevel ‚ 1 ou 0.');
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
             if c = 'APPEND' then append;
             if c = 'BROWSE2' then browse2;
             if c = 'DOSSHELL' then sintaxe;
             if c = 'FACT' then factorial;
             if c = 'FILLWIN' then fillwin;
             if c = 'MENUMOUSE' then menumouse;
             if c = 'SYSBOX' then sysbox;
             if c = 'TYPEIT3' then typeit3;
             if c = 'TYPETXT' then typetxt;
             if c = 'VSCROLL2' then vscroll2;
             if c = 'YESNOBOX' then yesnobox;
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
