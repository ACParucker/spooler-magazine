{$M $4000,0,64000 }

program DSB;

uses crt,dos,graph;
{$I-}
var

   up,down,x,y,y1,mousex,mousey,execresult:integer;
   reg : registers;
   key : char;
   size : word;
   screen : pointer;
   msgop,msg,msg2,msg3 : string;
   saida,verifica,mudoubutao : boolean;
   pass:array [1..5] of char;
   driver, mode: integer;



procedure  ecrainicial;  (*Constroi ecra inicial*)

begin
     setfillstyle(xhatchfill,8);
     Bar(0, 0, 639, 479);        (*Background*)
     setfillstyle(solidfill,7);
     bar(200,130,439,349);       (*Caixa dos Menus*)
     setfillstyle(solidfill,9);
     bar(230,150,409,169);       (*Menus*)
     bar(230,190,409,209);
     bar(230,230,409,249);
     bar(230,270,409,289);
     bar(230,310,409,329);
     setfillstyle(solidfill,1);
     bar(230,150,409,169);       (*1¯ updown*)
     bar(240,170,415,175);       (*Sombras*)
     bar(240,210,415,215);
     bar(240,250,415,255);
     bar(240,290,415,295);
     bar(240,330,415,335);
     bar(410,154,415,175);
     bar(410,194,415,215);
     bar(410,234,415,255);
     bar(410,274,415,295);
     bar(410,314,415,335);
     setfillstyle(solidfill,9);
     bar(0,460,639,479); (*Status Line*)
     bar(0,0,639,25);    (*Top Line*)
     setcolor(15);
     settextstyle(defaultfont, horizdir, 2);
     outtextxy(265,153,'INSERIR');
     outtextxy(265,193,'RETIRAR');
     outtextxy(249,233,'MODIFICAR');
     outtextxy(257,273,'CREDITOS');
     outtextxy(281,313,'SAIDA');
     settextjustify(centertext, toptext);
     outtextxy(639 div 2,6,'DISKBLOCK V1.0');
end;

procedure sl; (*Escreve mensagem na linha de fundo*)
begin
     setcolor(15);
     settextjustify(centertext, toptext);
     setfillstyle(solidfill,9);
     bar(0,460,639,479); (*Status Line*)
     if down=1 then
     begin
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Codifica Disco');
     end;
     if down=2 then
     begin
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Descodifica Disco');
     end;
     if down=3 then
     begin
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Modifica Password');
     end;
     if down=4 then
     begin
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Creditos');
     end;

end;


procedure bardown; (*Posiciona uma opcao abaixo*)

begin
     settextjustify(lefttext, toptext);
     if down=1 then
     begin
          setfillstyle(solidfill,9);
          bar(230,150,409,169);
          setcolor(15);
          outtextxy(265,153,'INSERIR');
          setfillstyle(solidfill,1);
          bar(230,190,409,209);
          setcolor(15);
          outtextxy(265,193,'RETIRAR');
          up:=5;
     end;
     if down=2 then
     begin
          setfillstyle(solidfill,9);
          bar(230,190,409,209);
          setcolor(15);
          outtextxy(265,193,'RETIRAR');
          setfillstyle(solidfill,1);
          bar(230,230,409,249);
          setcolor(15);
          outtextxy(249,233,'MODIFICAR');
          up:=4;
     end;
     if down=3 then
     begin
          setfillstyle(solidfill,9);
          bar(230,230,409,249);
          setcolor(15);
          outtextxy(249,233,'MODIFICAR');
          setfillstyle(solidfill,1);
          bar(230,270,409,289);
          setcolor(15);
          outtextxy(257,273,'CREDITOS');
          up:=3;
     end;
     if down=4 then
     begin
          setfillstyle(solidfill,9);
          bar(230,270,409,289);
          setcolor(15);
          outtextxy(257,273,'CREDITOS');
          setfillstyle(solidfill,1);
          bar(230,310,409,329);
          setcolor(15);
          outtextxy(281,313,'SAIDA');
          up:=2;
     end;
     if down=5 then
     begin
          setfillstyle(solidfill,9);
          bar(230,310,409,329);
          setcolor(15);
          outtextxy(281,313,'SAIDA');
          setfillstyle(solidfill,1);
          bar(230,150,409,169);
          setcolor(15);
          outtextxy(265,153,'INSERIR');
          up:=1;
     end;
     inc(down);
     if down=6 then down:=1;
end;

procedure barup; (*Posiciona uma opcao acima*)
begin
     settextjustify(lefttext, toptext);
     if up=1 then
     begin
          setfillstyle(solidfill,9);
          bar(230,150,409,169);
          setcolor(15);
          outtextxy(265,153,'INSERIR');
          setfillstyle(solidfill,1);
          bar(230,310,409,329);
          setcolor(15);
          outtextxy(281,313,'SAIDA');
          down:=5;
     end;
     if up=2 then
     begin
          setfillstyle(solidfill,9);
          bar(230,310,409,329);
          setcolor(15);
          outtextxy(281,313,'SAIDA');
          setfillstyle(solidfill,1);
          bar(230,270,409,289);
          setcolor(15);
          outtextxy(257,273,'CREDITOS');
          down:=4;
     end;
     if up=3 then
     begin
          setfillstyle(solidfill,9);
          bar(230,270,409,289);
          setcolor(15);
          outtextxy(257,273,'CREDITOS');
          setfillstyle(solidfill,1);
          bar(230,230,409,249);
          setcolor(15);
          outtextxy(249,233,'MODIFICAR');
          down:=3;
     end;
     if up=4 then
     begin
          setfillstyle(solidfill,9);
          bar(230,230,409,249);
          setcolor(15);
          outtextxy(249,233,'MODIFICAR');
          setfillstyle(solidfill,1);
          bar(230,190,409,209);
          setcolor(15);
          outtextxy(265,193,'RETIRAR');
          down:=2;
     end;
     if up=5 then
     begin
          setfillstyle(solidfill,9);
          bar(230,190,409,209);
          setcolor(15);
          outtextxy(265,193,'RETIRAR');
          setfillstyle(solidfill,1);
          bar(230,150,409,169);
          setcolor(15);
          outtextxy(265,153,'INSERIR');
          down:=1;
     end;
     inc(up);
     if up=6 then up:=1;
end;

(*O uso da proxima procedure era para nao estar a escrever n vezes a mesma coisa*)
procedure posicao;
begin
     if down=1 then
     begin
          y:=150;y1:=170;x:=265;
          msgop:='INSERIR';
     end;
     if down=2 then
     begin
          y:=190;y1:=210;x:=265;
          msgop:='RETIRAR';
     end;
     if down=3 then
     begin
          y:=230;y1:=250;x:=249;
          msgop:='MODIFICAR';
     end;
     if down=4 then
     begin
          y:=270;y1:=290;x:=257;
          msgop:='CREDITOS';
     end;
     if down=5 then
     begin
          y:=310;y1:=330;x:=281;
          msgop:='SAIDA';
     end;
end;

procedure piscar;

begin
     posicao;
     settextjustify(lefttext, toptext);
     setfillstyle(solidfill,10);
     bar(230,y,409,y+19);
     setfillstyle(solidfill,1);
     bar(240,y+4,415,y+23);
     setcolor(15);
     outtextxy(x+10,y+7,msgop);
     delay(750);
     setfillstyle(solidfill,1);
     bar(230,y,409,y+19);
     setfillstyle(solidfill,1);
     bar(240,y1,415,y1+5);
     bar(410,y+4,415,y1+5);
     setcolor(15);
     outtextxy(x,y+3,msgop);
end;

(*Vai ler e escrever a password*)
procedure password;

var
   w,z:integer;
   label 10,20,goend;

begin
   for w:=1 to 6 do
   begin
        10:  key:=readkey;
        if key=chr(9) then goto 10;
        if key=#0 then
        begin
             key:=readkey;
             goto 10;
        end;
        if key=chr(27) then goto goend;
	if key=chr(13) then
        begin
             if w<=5 then
             begin
                  for z:=w to 5 do
                  begin
                       pass[z]:=chr(32);
                  end;
             end;
             goto 20;
        end;
        if key=chr(8) then
        begin
	     if w=1 then goto 10;
	     w:=w-1;
             setcolor(5);
             outtextxy((145+textwidth(msg))+((w-1)*(textwidth('A'))),y,'€');
             setcolor(15);
             goto 10;
	end;
        if w<=5 then pass[w]:=key;
        if w<=5 then outtextxy((145+textwidth(msg))+((w-1)*(textwidth('A'))),y,'*');
        if w=6 then
        begin
             if key<>chr(13) then goto 10;
        end;
   end;
20:
   msg:='';
   for z:=1 to 5 do
   begin
        msg:=msg+pass[z];
   end;
   if msg='     ' then msg:='.....';
   if msg=msg2 then verifica:=true;
   if msg2='' then msg2:=msg;
goend:
   if key=chr(27) then msg2:='Carregou Escape';
end;

(*Verifica qual o erro originado ao tentar efectuar umas das 3 primeiras opcaoes*)
procedure verexecres; 

begin
     setcolor(15);
     settextjustify(centertext, toptext);
     if execresult=0 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'OK');
     end;

     if execresult=1 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Password Errada');
     end;
     if execresult=2 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Erro de Leitura');
     end;
     if execresult=3 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Erro de Escrita');
     end;
     if execresult=4 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Falta de Mem¢ria');
     end;
     if execresult=5 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'J† Est† Protegido');
     end;
     if execresult=6 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Impossivel Proteger');
     end;
     if execresult=7 then
     begin
          setfillstyle(solidfill,9);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Disco NÑo Est† Protegido');
     end;
     delay(1500);
end;


procedure selecao;

var
   drive : string;
   s : string;
   label goend;

(*Verifica drive seleccionada*)
procedure io;
begin
     getdir(0,s);
     chdir(msg);
     if IOresult=152 then
     begin
          settextjustify(centertext, toptext);
          bar(0,460,639,479); (*Status Line*)
          outtextxy(639 div 2,462,'Erro de Leitura');
          settextjustify(lefttext, toptext);
          msg:='erro';
          delay(1500);
     end;
     chdir(s);
end;


begin
     settextjustify(lefttext, toptext);
     size:=imagesize(129,110,510,355);
     getmem(screen,size);
     (*Grava imagem em memoria*)
     getimage(129,110,510,355,screen^);
     setfillstyle(solidfill,9);
     bar(0,460,639,479); (*Status Line*)
     if down=1 then
     begin
          setfillstyle(solidfill,5);
          bar(129,115,510,202);
          setfillstyle(solidfill,9);
          bar(133,119,506,198);
          outtextxy(256,135,'Drive: ');
          setcolor(5);
          outtextxy(256+textwidth('Drive: '),135,'€');
          setcolor(15);
          settextjustify(centertext, toptext);
          outtextxy(639 div 2,462,'Escolha Drive');
          settextjustify(lefttext, toptext);
          repeat
                key:=readkey;
                if (key<>chr(13)) then
                begin
                     setcolor(5);
                     outtextxy(256+textwidth('Drive: '),135,'€');
                     setcolor(15);
                end;
                if (key=chr(13)) then
                begin
                     if x=1 then x:=2;
                end;
                if (key=chr(65)) or (key=chr(97)) then
                begin
                     outtextxy(256+textwidth('Drive: '),135,key);
                     drive:='0';x:=1;
                end;
                if (key=chr(66)) or (key=chr(98)) then
                begin
                     outtextxy(256+textwidth('Drive: '),135,key);
                     drive:='1';x:=1;
                end;
                if key=chr(27) then goto goend;
          until (x=2);
          if drive='0' then msg:='a:\';
          if drive='1' then msg:='b:\';
          io;
          if msg='erro' then goto goend;
          bar(0,460,639,479); (*Status Line*)
          outtextxy(145,170,'Escreva Password:');
          msg:='Escreva Password:';
          setcolor(5);
          outtextxy(145+textwidth(msg),170,'€€€€€');
          setcolor(15);
          settextjustify(centertext, toptext);
          outtextxy(639 div 2,462,'<Enter>-Finaliza <Esc>-Menu Principal');
          settextjustify(lefttext, toptext);
          msg2:='';y:=170;
          password;
          verifica:=false;
          if msg2='Carregou Escape' then goto goend;
          repeat
                bar(133,119,506,198);
                outtextxy(145,170,'VerificaáÑo:');
                msg:='VerificaáÑo:';
                setcolor(5);
                outtextxy(145+textwidth(msg),170,'€€€€€');
                setcolor(15);
                password;
                if msg2='Carregou Escape' then verifica:=true;
          until (verifica=true);
          if msg2<>'Carregou Escape' then
          begin
               msg:='LetIn 1 '+drive+' '+msg2;
               SwapVectors;
               Exec('db.exe',msg);
               SwapVectors;
               execresult:=dosexitcode;
               verexecres;
          end;
     end;

     if down=2 then
     begin
          setfillstyle(solidfill,5);
          bar(129,155,510,242);
          setfillstyle(solidfill,9);
          bar(133,159,506,238);
          outtextxy(256,175,'Drive: ');
          setcolor(5);
          outtextxy(256+textwidth('Drive: '),175,'€');
          setcolor(15);
          settextjustify(centertext, toptext);
          outtextxy(639 div 2,462,'Escolha Drive');
          settextjustify(lefttext, toptext);
          repeat
                key:=readkey;
                if (key<>chr(13)) then
                begin
                     setcolor(5);
                     outtextxy(256+textwidth('Drive: '),175,'€');
                     setcolor(15);
                end;
                if (key=chr(13)) then
                begin
                     if x=1 then x:=2;
                end;
                if (key=chr(65)) or (key=chr(97)) then
                begin
                     outtextxy(256+textwidth('Drive: '),175,key);
                     drive:='0';x:=1;
                end;
                if (key=chr(66)) or (key=chr(98)) then
                begin
                     outtextxy(256+textwidth('Drive: '),175,key);
                     drive:='1';x:=1;
                end;
                if key=chr(27) then goto goend;
          until (x=2);
          if drive='0' then msg:='a:\';
          if drive='1' then msg:='b:\';
          io;
          if msg='erro' then goto goend;
          bar(0,460,639,479); (*Status Line*)
          outtextxy(145,210,'Escreva Password:');
          msg:='Escreva Password:';
          setcolor(5);
          outtextxy(145+textwidth(msg),210,'€€€€€');
          setcolor(15);
          settextjustify(centertext, toptext);
          outtextxy(639 div 2,462,'<Enter>-Finaliza <Esc>-Menu Principal');
          settextjustify(lefttext, toptext);
          msg2:='';y:=210;
          password;
          verifica:=false;
          if msg2='Carregou Escape' then goto goend;
          if msg2<>'Carregou Escape' then
          begin
               msg:='LetIn 2 '+drive+' '+msg2;
               SwapVectors;
               Exec('db.exe',msg);
               SwapVectors;
               execresult:=dosexitcode;
               verexecres;
          end;
     end;

     if down=3 then
     begin
          setfillstyle(solidfill,5);
          bar(129,195,510,282);
          setfillstyle(solidfill,9);
          bar(133,199,506,278);
          outtextxy(256,215,'Drive: ');
          setcolor(5);
          outtextxy(256+textwidth('Drive: '),215,'€');
          setcolor(15);
          settextjustify(centertext, toptext);
          outtextxy(639 div 2,462,'Escolha Drive');
          settextjustify(lefttext, toptext);
          repeat
                key:=readkey;
                if (key<>chr(13)) then
                begin
                     setcolor(5);
                     outtextxy(256+textwidth('Drive: '),215,'€');
                     setcolor(15);
                end;
                if (key=chr(13)) then
                begin
                     if x=1 then x:=2;
                end;

                if (key=chr(65)) or (key=chr(97)) then
                begin
                     outtextxy(256+textwidth('Drive: '),215,key);
                     drive:='0';x:=1;
                end;
                if (key=chr(66)) or (key=chr(98)) then
                begin
                     outtextxy(256+textwidth('Drive: '),215,key);
                     drive:='1';x:=1;
                end;
                if key=chr(27) then goto goend;
          until (x=2);
          if drive='0' then msg:='a:\';
          if drive='1' then msg:='b:\';
          io;
          if msg='erro' then goto goend;
          bar(0,460,639,479); (*Status Line*)
          outtextxy(145,250,'Escreva Password:');
          msg:='Escreva Password:';
          setcolor(5);
          outtextxy(145+textwidth(msg),250,'€€€€€');
          setcolor(15);
          settextjustify(centertext, toptext);
          outtextxy(639 div 2,462,'<Enter>-Finaliza <Esc>-Menu Principal');
          settextjustify(lefttext, toptext);
          msg2:='';y:=250;
          password;
          verifica:=false;
          if msg2='Carregou Escape' then goto goend;
          msg3:=msg2;
          bar(133,199,506,278);
          outtextxy(145,250,'Nova Password:');
          msg:='Nova Password:';
          setcolor(5);
          outtextxy(145+textwidth(msg),250,'€€€€€');
          setcolor(15);
          msg2:='';y:=250;
          password;
          verifica:=false;
          repeat
                bar(133,199,506,278);
                outtextxy(145,250,'VerificaáÑo:');
                msg:='VerificaáÑo:';
                setcolor(5);
                outtextxy(145+textwidth(msg),250,'€€€€€');
                setcolor(15);
                password;
                if msg2='Carregou Escape' then verifica:=true;
          until (verifica=true);
          if msg2<>'Carregou Escape' then
          begin
               msg:='LetIn 3 '+drive+' '+msg3+' '+msg2;
               SwapVectors;
               Exec('db.exe',msg);
               SwapVectors;
               execresult:=dosexitcode;
               verexecres;
          end;
     end;

     if down=4 then
     begin
          setfillstyle(solidfill,5);
          bar(129,110,510,355);
          setfillstyle(solidfill,9);
          bar(133,114,506,351);
          outtextxy(242,145,'DISK BLOCK');
          outtextxy(140,210,'Programado por:');
          outtextxy(190,270,'Carlos Leitao');
          outtextxy(190,292,'Miguel Gonáalves');
          repeat until keypressed;
     end;

goend:
     (*Repoe imagem anterior*)
     putimage(129,110,screen^,normalput);
     (*Liberta a memoria utilizada para gravar imagem*)
     freemem(screen,size);

     if down=5 then
     begin
          setcolor(0);
          x:=0;
          for y1:=0 to 40 do
          begin
               x:=y1;
               for y:=0 to 16 do
               begin
                    if x<640 then line(x,0,x,479);
                    x:=x+40;
               end;
          end;
          saida:=true;
     end;
end;

(*Faz com que o cursor do rato fique activo*)
procedure ligarato;
begin
     (*Este registo permite activar o cursor do rato*)
     reg.ax:=1;
     intr($33,reg);(*Interrupt do rato*)
end;

(*Desactiva o cursor do rato*)
procedure deslrato;
begin
     (*Este registo permite desactivar o rato*)
     reg.ax:=2;
     intr($33,reg);(*Interrupt do rato*)
end;

(*Verifica se algum botao do rato foi primido*)
function buttonpressed : boolean;

begin
        (*Este registo permite verificar posicao do rato*)
	reg.ax := 3;
	intr($33,reg);(*Interrupt do rato*)
	if ((reg.bx and 7) <> 0) then buttonpressed := true
	else buttonpressed := false;
end;

procedure deslbut; (*Tira sombriado da opcao*)

begin
     settextjustify(lefttext, toptext);
     setfillstyle(solidfill,9);
     bar(230,y,409,y+19);
     setcolor(15);
     outtextxy(x,y+3,msgop);
end;

procedure ligabut; (*Desenha sombriado na opcao onde se encontra o cursor*)

begin
     settextjustify(lefttext, toptext);
     setfillstyle(solidfill,1);
     bar(230,y,409,y+19);
     setcolor(15);
     outtextxy(x,y+3,msgop);
end;

procedure mousepos; (*Analisa a posicao x e y do rato e selecciona opcao*)

begin
     posicao;
     (*Este registo permite verificar posicao do rato*)
     reg.ax := 3;
     intr($33,reg);(*Interrupt do rato*)
     mousex := reg.cx;
     mousey := reg.dx;
     deslrato;
     if (mousex>=230) and (mousex<=409) and (mousey>=150) and (mousey<=169) then
     begin
          deslbut;
          down:=1;
          up:=1;
          piscar;
          selecao;
     end;
     if (mousex>=230) and (mousex<=409) and (mousey>=190) and (mousey<=209) then
     begin
          deslbut;
          down:=2;
          up:=5;
          piscar;
          selecao;
     end;
     if (mousex>=230) and (mousex<=409) and (mousey>=230) and (mousey<=249) then
     begin
          deslbut;
          down:=3;
          up:=4;
          piscar;
          selecao;
     end;
     if (mousex>=230) and (mousex<=409) and (mousey>=270) and (mousey<=289) then
     begin
          deslbut;
          down:=4;
          up:=3;
          piscar;
          selecao;
     end;
     if (mousex>=230) and (mousex<=409) and (mousey>=310) and (mousey<=329) then
     begin
          deslbut;
          down:=5;
          up:=2;
          piscar;
          selecao;
     end;
end;

function mousemove : boolean; (*Verifica se houve movimento do rato*)

begin
     (*Este registo permite verificar se houve movimento do rato tanto no eixo do x como do y*)
     reg.ax := 11;
     intr($33,reg);(*Interrupt do rato*)
     x:=reg.cx;
     y:=reg.dx;
     if (x <> 0) or (y <> 0) then mousemove:=true
     else mousemove:=false;

end;

begin (*Main*)
      (*Inicializa modo grafico VGA 640*480 16 cores*)
      driver := vga;
      mode:=vgahi;
      initgraph(driver,mode,'egavga.bgi');
      if graphresult < 0 then halt(1);
      ecrainicial;
      saida:=false;
      down:=1;
      up:=1;
      sl;
      ligarato;
      repeat
      (*Analisa posicao do rato e posiona na nova opcao*)
      if mousemove = true then
      begin
          posicao;
          (*Este registo permite verificar posicao do rato*)
          reg.ax := 3;
          intr($33,reg);(*Interrupt do rato*)
          mousex := reg.cx;
          mousey := reg.dx;
          deslrato;
          mudoubutao:=false;
          if down<>1 then begin
          if ((mousex>=230) and (mousex<=409)) and ((mousey>=150) and (mousey<=169)) then
          begin
               deslbut;
               down:=1;
               up:=1;
               posicao;
               ligabut;
               mudoubutao:=true;
          end;
          end;
          if down<>2 then begin
          if ((mousex>=230) and (mousex<=409)) and ((mousey>=190) and (mousey<=209)) then
          begin
               deslbut;
               down:=2;
               up:=5;
               posicao;
               ligabut;
               mudoubutao:=true;
          end;
          end;
          if down<>3 then begin
          if ((mousex>=230) and (mousex<=409)) and ((mousey>=230) and (mousey<=249)) then
          begin
               deslbut;
               down:=3;
               up:=4;
               posicao;
               ligabut;
               mudoubutao:=true;
          end;
          end;
          if down<>4 then begin
          if ((mousex>=230) and (mousex<=409)) and ((mousey>=270) and (mousey<=289)) then
          begin
               deslbut;
               down:=4;
               up:=3;
               posicao;
               ligabut;
               mudoubutao:=true;
          end;
          end;
          if down<>5 then begin
          if ((mousex>=230) and (mousex<=409)) and ((mousey>=310) and (mousey<=329)) then
          begin
               deslbut;
               down:=5;
               up:=2;
               posicao;
               ligabut;
               mudoubutao:=true;
          end;
          end;
          if mudoubutao=true then sl;
          ligarato;
      end;
      (*Analisa teclado e seliciona o posiciona conforme tecla pressionada*)
      if keypressed=true then 
      begin
           key:=readkey;
           deslrato;
           if key=chr(27) then saida:=true;
           if key=chr(13) then
           begin
                piscar;
                selecao;
           end;
           if key=#0 then
           begin
                key:=readkey;
                if key=#80 then bardown; (*Posicciona uma opcao para baixo*)
                if key=#72 then barup; (*Posicciona uma opcao para cima*)
           end;
           sl;
           ligarato;
      end;
      (*Se tiver primido um botao do rato analisa sua posicao e coincidir com uma das opcoes selecciona-a*)
      if buttonpressed = true then 
      begin
           if reg.bx=1 then mousepos;
           sl;
           ligarato;
      end;
      until (saida=true);
      closegraph;
end.
