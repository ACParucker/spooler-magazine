program Mostra_Palavras;
uses crt,dos,printer;
label 50,99,1;
const enter=#13;
      esc=#27;
      esq=#75;
      dir=#77;

type palavra=array[1..25] of char;
     conj=record
           pal:palavra;
           num:byte;
          end;

var f:file of conj;
    p:conj;
    i,numpal,cont:byte;
    c,c2:char;
    erroprint:boolean;

Procedure apcur(b:boolean);
    Var Regs:Registers;
    Begin
      With Regs do
        Begin
          Ax:=$100;
          if b then Cx:=$3030
               else Cx:=$180e;
          Intr($10,Regs)
        End
    End;

Function BufferVazio:Boolean;
Var R : Registers;
Begin
     R.Ah:=$01;
     Intr($16,R);
     BufferVazio := (r.flags And  64 = 64)
End;

function printerro(b:boolean):boolean;
begin
  printerro:=true;
  if b then begin
  window(15,10,65,16);
  textbackground(15);
  textcolor(0+blink);
  clrscr;
  gotoxy(11,2);
  write('A impressora n„o est  pronta!');
  textcolor(0);
  gotoxy(5,4);
  write('Verifique se ela est  ligada, tem o papel');
  gotoxy(13,5);
  write('e est  pronta a imprimir.');
  gotoxy(2,7);
  write('I para voltar a tentar ou outra tecla para voltar');
  while not(buffervazio)do c:=readkey;
  c:=upcase(readkey);
  if c='I' then printerro:=false
  end;
  window(1,1,80,25);
  normvideo
end;

procedure codigo;  {Procedimento que verifica o c¢digo inserido}
var str:string;
      i:byte;
begin
   gotoxy(26,13);
   write('CŸDIGO:');
   gotoxy(34,13);
   textcolor(0);
   read(str);
   normvideo;
   for i:=1 to length(str) do
     str[i]:=upcase(str[i]);
  if str<>'MOSTRAR PALAVRAS' then begin
                                    clrscr;
                                    highvideo;
                                    writeln('* * * * * MOSTRAR PALAVRAS * * * * *');
                                    writeln('   (c) Nuno Andr‚ Porto Morgado');
                                    writeln('SPOOLER Magazine dos utilizadores PC');
                                    writeln;
                                    writeln('C¢digo incorrecto...');
                                    normvideo;
                                    writeln;writeln;
                                    halt
                                  end
end;

begin
  checkbreak:=false;
  clrscr;
  gotoxy(14,1);
  highvideo;
  write('Mostrar Palavras - Utilit rio do JOGO DAS PALAVRAS');
  normvideo;
  codigo;
  apcur(true);
  repeat
    assign(f,'PALAVRAS.JP');
    50:
    {$i-}
    reset(f);
    {$i+}
    if ioresult=0 then begin
      cont:=0;
      while not eof(f) do
        begin
          inc(cont);
          {$i-}
          read(f,p);
          {$i+}
          if ioresult<>0 then goto 99
        end;
        {$i-}
        reset(f);
        {$i+}
        1:
        clrscr;
        numpal:=0;
        if ioresult<>0 then goto 99;
      repeat
        {$i-}
        read(f,p);
        {$i+}
        if ioresult<>0 then goto 99;
        window(1,6,80,25);
        for i:=1 to 20 do
          begin
            gotoxy(26,i);
            write('³');
            gotoxy(52,i);
            write('³')
          end;
        gotoxy(1,numpal+1);
        for i:=1 to p.num do write(p.pal[i]);
        inc(numpal)
      until eof(f) or (numpal=20);
      if not eof(f) then begin
        repeat
          read(f,p);
          gotoxy(27,numpal-19);
          for i:=1 to p.num do write(p.pal[i]);
          inc(numpal);
        until eof(f) or (numpal=40);
        if not eof(f) then
          repeat
            read(f,p);
            gotoxy(54,numpal-39);
            for i:=1 to p.num do write(p.pal[i]);
            inc(numpal);
          until eof(f) or (numpal=60)
        end;
        window(1,1,80,25);
        gotoxy(14,1);
        highvideo;
        write('Mostrar Palavras - Utilit rio do JOGO DAS PALAVRAS');
        normvideo;
        gotoxy(9,3);
        write('I para imprimir, ENTER para a pr¢xima p gina ou ESC para sair');
        gotoxy(30,4);
        write('N§ de palavras: ');
        highvideo;
        write(cont);
        normvideo;
        while not(buffervazio) do c:=readkey;
        repeat
          c:=upcase(readkey)
        until (c='I') or (c=esc) or (c=enter);
        if c='I' then begin
          repeat
            reset(f);
            {$i-}
            writeln(lst,' * * * JOGO DAS PALAVRAS * * *');
            writeln(lst,'  (c) Nuno Andr‚ Porto Morgado');
            writeln(lst,'SPOOLER Magazine dos utilizadores PC');
            {$i+}
            erroprint:=ioresult<>0;
          until printerro(erroprint);
        if not erroprint then begin
          writeln(lst,'');
          writeln(lst,'N§ palavras existentes: ',cont);
          writeln(lst,'');
          writeln(lst,'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
          writeln(lst,'');
          while not eof(f) do
            begin
              read(f,p);
              for i:=1 to p.num do write(lst,p.pal[i]);
              writeln(lst,'')
            end;
          window(17,9,62,17);
          textbackground(15);
          textcolor(0+blink);
          clrscr;
          gotoxy(12,2);
          write('* * * A V I S O * * *');
          textcolor(0);
          gotoxy(2,4);
          write('A impressora acabou de receber as palavras a');
          gotoxy(2,5);
          write('imprimir. Se n„o imprimir todas ‚ porque n„o');
          gotoxy(3,6);
          write('houve espa‡o na 1¦ p gina para as imprimir');
          gotoxy(6,7);
          write('ficando na mem¢ria da impressora. Se');
          gotoxy(3,8);
          write('aconteceu isto volte folha ou ponha outra.');
          while not(buffervazio)do c2:=readkey;
          c2:=readkey;
          normvideo;
          window(1,1,80,25);
        end
        else goto 50;
      end
      else if c=enter then if not(eof(f)) then goto 1
                                          else begin
                                                 window(18,11,62,15);
                                                 textbackground(15);
                                                 textcolor(0+blink);
                                                 clrscr;
                                                 gotoxy(4,3);
                                                 write('N„o existem mais palavras no ficheiro!');
                                                 while not(buffervazio)do c2:=readkey;
                                                 c2:=readkey;
                                                 normvideo;
                                                 window(1,1,80,25);
                                                 goto 50
                                               end;
      window(1,1,80,25);
      close(f)
    end
    else begin
           99:
           gotoxy(14,1);
           highvideo;
           write('Mostrar Palavras - Utilit rio do JOGO DAS PALAVRAS');
           normvideo;
           gotoxy(22,3);
           write('         ESC para sair          ');
           gotoxy(31,14);
           write('N„o h  palavras!');
           while not(buffervazio) do c:=readkey;
           repeat
             c:=readkey
           until (c=esc);
         end;
  until c=esc;
  clrscr;
  highvideo;
  writeln('* * * * * MOSTRAR PALAVRAS * * * * *');
  writeln('   (c) Nuno Andr‚ Porto Morgado');
  writeln('SPOOLER Magazine dos utilizadores PC');
  normvideo;
  writeln;writeln;
  apcur(false)
end.