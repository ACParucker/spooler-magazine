{
Titulo: Apagar Palavras (utilitario do JOGO DAS PALAVRAS).
Autor:Nuno Andr‚ Porto Morgado.
Para SPOOLER Magazine dos utilizadors PC.
Programado em Turbo Pascal 7.0 da Borland.
}
program Apagar_Palavras;
uses crt,dos,printer;   {Declara‡„o das units usadas}
label 50; {Declara‡„o global de "labels"}
const enter=#13;  {Declara‡„o das constantes das teclas utilizadas}
      esc=#27;
      cima=#72;
      baixo=#80;

type palavra=array[1..25] of char;
     conj=record    {declara‡„o das estruturas e tipos que o programa utiliza}
           pal:palavra;
           num:byte;
          end;
     palavras=array[1..1000] of conj;

var f:file of conj;  {Declara‡„o das variaveis globais}
    p,p2:palavras;
    i,j,fimpal,fimpal2,selpal,selpal2,ovl,ovl2,fp:integer;
    c,c2:char;
    erroprint:boolean;
    pospal:array[1..1000] of integer;

Procedure apcur(b:boolean);  {Procedimento que liga ou desliga o cursor}
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

Function BufferVazio:Boolean; {Fun‡„o que devolve TRUE se o Buffer do teclado
                                estiver vazio e FALSE caso contrario}
Var R : Registers;
Begin
     R.Ah:=$01;
     Intr($16,R);
     BufferVazio := (r.flags And  64 = 64)
End;

procedure invert(b:boolean); {Procedimento que inverte a cor do texto com a
                               cor de fundo}
begin
 if b then begin
            textbackground(7);
            textcolor(0)
           end
      else begin
            textbackground(0);
            textcolor(7)
           end
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
  if str<>'APAGAR PALAVRAS' then begin
                                  clrscr;
                                  highvideo;
                                  writeln('* * * * * APAGAR PALAVRAS * * * * *');
                                  writeln('   (c) Nuno Andr‚ Porto Morgado');
                                  writeln('SPOOLER Magazine dos utilizadores PC');
                                  writeln;
                                  writeln('C¢digo incorrecto...');
                                  normvideo;
                                  writeln;writeln;
                                  halt
                                end
end;

procedure lerpalavra; {Procedimento que lˆ o n§ de palavras existente no
                                    PALAVRAS.JP}
var f:file of conj;
begin
  fimpal:=0;
  assign(f,'PALAVRAS.JP');
  {$i-}
  reset(f);
  {$i-}
  if ioresult=0 then  while not(eof(f)) do
                       begin
                         inc(fimpal);
                         {$i-}
                         read(f,p[fimpal]);
                         {$i+}
                         if ioresult<>0 then begin
                                               fimpal:=0;
                                               close(f);
                                               exit
                                             end
                       end;
  if fimpal>0 then close(f)
end;

procedure gravarpalavras; {Procedimento que grava as palavras}
label 99;
var f:file of conj;
    i:integer;
    wp:boolean;

begin
  assign(f,'PALAVRAS.JP');
  99:
  {$i-}
  rewrite(f);
  {$i+}
  wp:=ioresult=150;
  if wp then
  begin
    clrscr;
    gotoxy(25,13);
    textcolor(15+blink);
    write('A diskette est  protegida!');
    normvideo;
    gotoxy(4,15);
    write('Desprotega a diskette e prima ENTER ou prima ESCAPE se n„o quiser gravar.');
    while not(buffervazio) do c:=readkey;
    repeat
      c:=readkey;
    until (c=esc) or (c=enter);
    if c<>esc then goto 99
  end;
  if not wp then begin
    for i:=1 to fimpal do
      write(f,p[i]);
    close(f)
  end;
  if fimpal=0 then erase(f)
end;

procedure recuperar; {Procedimento que recupera palavras apagadas}
var i:integer;
    c:char;
begin
  clrscr;
  ovl2:=0;
  selpal2:=1;
  repeat
    gotoxy(14,1);
    highvideo;
    write('Apagar Palavras - Utilit rio do JOGO DAS PALAVRAS');
    normvideo;
    gotoxy(11,3);
    write('Cursores e ENTER para seleccionar ou ESC para voltar');
    gotoxy(15,6);
    write('Palavras apagadas para serem recuperadas:');
    if fimpal2>18 then fp:=18
                  else fp:=fimpal2;
    for i:=1 to fp do
      begin
        if selpal2=(i+ovl2) then invert(true);
        gotoxy(45,i+7);
        for j:=p2[i+ovl2].num downto 1 do
          begin
            write(p2[i+ovl2].pal[j]);
            gotoxy(wherex-2,i+7)
          end;
          for j:=20 to 45-p2[i+ovl2].num do begin
                                              gotoxy(j,i+7);
                                              write(' ')
                                            end;
        invert(false);
      end;
    while not(buffervazio) do c:=readkey;
    repeat
      c:=readkey
    until (c=enter) or (c=baixo) or (c=cima) or (c=esc);
    if (c=baixo) and (selpal2<fimpal2) then begin
                                            if (selpal2-ovl2)=18 then inc(ovl2);
                                            inc(selpal2)
                                          end
       else  if (c=cima) and (selpal2>1) then begin
                                              if (selpal2-ovl2)=1 then dec(ovl2);
                                              dec(selpal2)
                                             end
          else if c=enter then begin
                                 dec(fimpal2);
                                 inc(fimpal);
                                 for i:=fimpal downto pospal[selpal2] do
                                   p[i]:=p[i-1];
                                 p[pospal[selpal2]]:=p2[selpal2];
                                 for i:=selpal2 to fimpal2 do p2[i]:=p2[i+1];
                                 selpal2:=1;
                                 ovl2:=0
                               end
  until (c=esc) or (c=enter);
  clrscr
end;

procedure apaga(var selpal:integer); {Procedimento que apaga a palavra
                                       selec‡ionada}
var i:byte;
begin
  window(20,10,59,16);
  textbackground(15);
  clrscr;
  gotoxy(9,2);
  textcolor(0);
  write('Vai apagar a palavra:');
  textcolor(0+blink);
  gotoxy((39-p[selpal].num) div 2,3);
  for i:=1 to p[selpal].num do write(p[selpal].pal[i]);
  normvideo;
  textbackground(15);
  textcolor(0);
  gotoxy(10,5);
  write('Tem a certeza? (S/N)');
  while not(buffervazio) do c:=readkey;
  repeat
    c:=upcase(readkey);
  until (c='S') or (c='N');
  window(1,1,80,25);
  if c='S' then begin
                  dec(fimpal);
                  inc(fimpal2);
                  p2[fimpal2]:=p[selpal];
                  pospal[fimpal2]:=selpal;
                  for i:=selpal to fimpal do p[i]:=p[i+1];
                  selpal:=1;
                  ovl:=0
                end;
  normvideo;
  clrscr;
end;

{ * CORPO DO PROGRAMA * }
begin
  checkbreak:=false;
  clrscr;
  gotoxy(14,1);
  highvideo;
  write('Apagar Palavras - Utilit rio do JOGO DAS PALAVRAS');
  normvideo;
  codigo;
  apcur(true);
  clrscr;
  lerpalavra;
  if fimpal=0 then
       begin
         gotoxy(14,1);
         highvideo;
         write('Apagar Palavras - Utilit rio do JOGO DAS PALAVRAS');
         normvideo;
         gotoxy(22,3);
         write('         ESC para sair          ');
         gotoxy(31,14);
         write('N„o h  palavras!');
         while not(buffervazio) do c:=readkey;
         repeat
           c:=readkey
         until (c=esc);
         clrscr;
         highvideo;
         writeln('* * * * * APAGAR PALAVRAS * * * * *');
         writeln('   (c) Nuno Andr‚ Porto Morgado');
         writeln('SPOOLER Magazine dos utilizadores PC');
         normvideo;
         writeln;writeln;
         apcur(false);
         halt
       end;
  ovl:=0;
  selpal:=1;
  fimpal2:=0;
  repeat
    50:
    gotoxy(14,1);
    highvideo;
    write('Apagar Palavras - Utilit rio do JOGO DAS PALAVRAS');
    normvideo;
    gotoxy(3,3);
    write('Cursores e ENTER para seleccionar, CTRL-R para recuperar e ESC para sair');
    if fimpal>20 then fp:=20
                 else fp:=fimpal;
        gotoxy(15,4);
        write('N§ de palavras: ');
        highvideo;
        write(fimpal,' ');
        normvideo;
        gotoxy(40,4);
        write('Palavra actual: ');
        highvideo;
        write(selpal,' ');
        normvideo;
    for i:=1 to fp do
      begin
        if selpal=(i+ovl) then invert(true);
        gotoxy(45,i+5);
        for j:=p[i+ovl].num downto 1 do
          begin
            write(p[i+ovl].pal[j]);
            gotoxy(wherex-2,i+5)
          end;
          for j:=20 to 45-p[i+ovl].num do begin
                                           gotoxy(j,i+5);
                                           write(' ')
                                          end;
        invert(false);
      end;
    if fimpal=0 then begin
                       gotoxy(31,14);
                       write('N„o h  palavras!')
                     end;
    while not(buffervazio) do c:=readkey;
    repeat
      c:=readkey
    until (c=esc) or (c=enter) or (c=baixo) or (c=cima) or (c=^R);
    if (c=baixo) and (selpal<fimpal) then begin
                                            if (selpal-ovl)=20 then inc(ovl);
                                            inc(selpal)
                                          end
       else  if (c=cima) and (selpal>1) then begin
                                              if (selpal-ovl)=1 then dec(ovl);
                                              dec(selpal)
                                             end
          else if (c=enter) and (fimpal>0) then apaga(selpal)
             else if c=^R then if fimpal2>0 then recuperar
                                            else begin
                                                   window(20,10,59,16);
                                                   textbackground(15);
                                                   textcolor(0);
                                                   clrscr;
                                                   gotoxy(7,3);
                                                   write('N„o h  nenhuma palavra para');
                                                   gotoxy(13,5);
                                                   write('ser recuperada');
                                                   while not(buffervazio) do c2:=readkey;
                                                   c2:=readkey;
                                                   normvideo;
                                                   window(1,1,80,25);
                                                   clrscr;
                                                 end;
  until (c=esc);
  if fimpal2>0 then
    begin
      window(20,10,59,16);
      textbackground(15);
      clrscr;
      gotoxy(5,2);
      textcolor(0+blink);
      write('As altera‡”es v„o ser gravadas!');
      textcolor(0);
      gotoxy(5,5);
      write('ENTER para gravar as altera‡”es,');
      gotoxy(1,6);
      write('ESC para voltar e CTRL-N para n„o gravar');
      while not(buffervazio) do c:=readkey;
      repeat
        c:=upcase(readkey);
        until (c=esc) or (c=enter) or (c=^N);
      normvideo;
      window(1,1,80,25);
      if c=enter then gravarpalavras
                 else if c=esc then begin
                                      clrscr;
                                      goto 50
                                    end
    end;
  clrscr;
  highvideo;
  writeln('* * * * * APAGAR PALAVRAS * * * * *');
  writeln('   (c) Nuno Andr‚ Porto Morgado');
  writeln('SPOOLER Magazine dos utilizadores PC');
  normvideo;
  writeln;writeln;
  apcur(false)
end.