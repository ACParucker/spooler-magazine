{
Titulo: Modificar Palavras (utilitario do JOGO DAS PALAVRAS).
Autor:Nuno Andr‚ Porto Morgado.
Para SPOOLER Magazine dos utilizadors PC.
Programado em Turbo Pascal 7.0 da Borland.
}
program Modificar_Palavras;
uses crt,dos,printer;   {Declara‡„o das units usadas}
label 99; {Declara‡„o das labels globais}
const enter=#13;  {Declara‡„o das constantes das teclas utilizadas}
      esc=#27;
      cima=#72;
      baixo=#80;
      backsp=#8;

type palavra=array[1..25] of char;
     conj=record    {declara‡„o das estruturas e tipos que o programa utiliza}
           pal:palavra;
           num:byte;
          end;
     palavras=array[1..1000] of conj;

var f:file of conj;  {Declara‡„o das variaveis globais}
    p:palavras;
    i,j,fimpal,selpal,ovl,fp:integer;
    c:char;
    erroprint:boolean;
    modif:boolean;

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


procedure codigo;  {Procedimento que verifica a c¢digo inserida}
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
  if str<>'MODIFICAR PALAVRAS' then begin
                                     clrscr;
                                     highvideo;
                                     writeln('* * * * * MODIFICAR PALAVRAS * * * * *');
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
    if fimpal=0 then erase(f);
    close(f);
  end
end;

function inserepalavra(var pal:conj):boolean; {Fun‡„o que mete no array
    interno a palavra e que devolve false se foi pressionado o ESCAPE}
    var str:palavra;
        fim:byte;
          c:char;
    begin
      fim:=0;
      inserepalavra:=true;
      repeat
        c:=readkey;
        if (c=backsp) and (fim>0) then begin
                                         dec(fim);
                                         gotoxy(wherex-1,wherey);
                                         write(' ');
                                         gotoxy(wherex-1,wherey)
                                       end
        else if (c<>enter) and (c<>esc) and (c<>backsp) and (fim<25) then begin
               inc(fim);
               str[fim]:=c;
               write(c);
             end;
      until (((fim>3) or (fim=25)) and (c=enter)) or (c=esc);
      if c<>esc then begin
                       pal.pal:=str;
                       pal.num:=fim;
                       modif:=true
                     end
                else inserepalavra:=false
    end;


procedure modifica(var selpal:integer); {Procedimento que modifica a palavra
                                          selec‡ionada}
var i:byte;
begin
  window(20,10,59,16);
  textbackground(15);
  clrscr;
  gotoxy(5,3);
  textcolor(0);
  write('Modificar ');
  textcolor(0+blink);
  for i:=1 to p[selpal].num do write(p[selpal].pal[i]);
  textcolor(0);
  gotoxy(9,5);
  write('para: ');
  inserepalavra(p[selpal]);
  window(1,1,80,25);
  normvideo;
  clrscr
end;

{ * CORPO DO PROGRAMA * }
begin
  checkbreak:=false;
  modif:=false;
  clrscr;
  gotoxy(14,1);
  highvideo;
  write('Modificar Palavras - Utilit rio do JOGO DAS PALAVRAS');
  normvideo;
  codigo;
  apcur(true);
  clrscr;
  lerpalavra;
  if fimpal=0 then
       begin
         99:
         gotoxy(14,1);
         highvideo;
         write('Modificar Palavras - Utilit rio do JOGO DAS PALAVRAS');
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
         writeln('* * * * * MODIFICAR PALAVRAS * * * * *');
         writeln('   (c) Nuno Andr‚ Porto Morgado');
         writeln('SPOOLER Magazine dos utilizadores PC');
         normvideo;
         writeln;writeln;
         apcur(false);
         halt
       end;
  ovl:=0;
  selpal:=1;
  repeat
    gotoxy(14,1);
    highvideo;
    write('Modificar Palavras - Utilit rio do JOGO DAS PALAVRAS');
    normvideo;
    gotoxy(14,3);
    write('Cursores e ENTER para seleccionar ESC para sair');
    gotoxy(15,4);
    write('N§ de palavras: ');
    highvideo;
    write(fimpal);
    normvideo;
    gotoxy(40,4);
    write('Palavra actual: ');
    highvideo;
    write(selpal,' ');
    normvideo;
    if fimpal>20 then fp:=20
                 else fp:=fimpal;
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
    while not(buffervazio) do c:=readkey;
    repeat
      c:=readkey
    until (c=esc) or (c=enter) or (c=baixo) or (c=cima);
    if (c=baixo) and (selpal<fimpal) then begin
                                            if (selpal-ovl)=20 then inc(ovl);
                                            inc(selpal)
                                          end
       else  if (c=cima) and (selpal>1) then begin
                                              if (selpal-ovl)=1 then dec(ovl);
                                              dec(selpal)
                                             end
          else if c=enter then modifica(selpal);
    if fimpal=0 then goto 99
  until (c=esc);
  if modif then gravarpalavras;
  clrscr;
  highvideo;
  writeln('* * * * * MODIFICAR PALAVRAS * * * * *');
  writeln('   (c) Nuno Andr‚ Porto Morgado');
  writeln('SPOOLER Magazine dos utilizadores PC');
  normvideo;
  writeln;writeln;
  apcur(false)
end.