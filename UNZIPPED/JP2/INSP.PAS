{
Titulo: Inserir Palavras (utilit rio do Jogo Das Palavras).
Autor: Nuno Andr‚ Porto Morgado.
Para: SPOOLER Magazine do utilizadors PC.
Programado em Turbo Pascal 6.0 da Borland.
}
Program Inserir_Palavras;

uses crt,dos; {Declara‡„o das Units usadas}

const enter=#13;  {Declara‡„o das constantes das teclas utilizadas}
      esc=#27;
      backsp=#8;
      esq=#75;
      dir=#77;

type conj=record   {Declara‡„o das estruturas e tipos que o programa utiliza}
            palavra:array[1..25] of char;
            nletras:byte;
          end;
     palavras=array[1..1000] of conj;

var c:char;        {Declara‡„o das variaveis globais}
    p:palavras;
    fim:byte;
    fimpal,fimpal2:integer;

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


function inserepalavra(var str:conj):boolean; {Fun‡„o que mete no array
    interno a palavra e que devolve false se foi pressionado o ESCAPE}
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
               str.palavra[fim]:=c;
               write(c);
             end;
      until (((fim>3) or (fim=25)) and (c=enter)) or (c=esc);
      if c<>esc then str.nletras:=fim
                else inserepalavra:=false
    end;

procedure inve; {procedimento que inverte as cores para marcar a op‡„o}
begin
  textbackground(15);
  textcolor(0)
end;

function continuar:boolean; {Fun‡„o que verifica se quer continuar a
        introduzir palavras ou se sai. Neste caso grava as palavras para o
                          PALAVRAS.JP}
label 50;
var b:boolean;
begin
  b:=true;
  repeat
  50:
  gotoxy(17,25);
  write(' CONTINUAR                       SAIR ');
  if b then begin gotoxy(17,25);
                  inve;
                  write(' CONTINUAR ');
                  normvideo
            end
       else begin gotoxy(49,25);
                  inve;
                  write(' SAIR ');
                  normvideo
            end;
  while not(buffervazio) do c:=readkey;
  repeat
    c:=readkey
  until (c=enter) or (c=esq) or (c=dir) or (c=esc);
  if c=esc then begin
  window(20,10,59,16);
  textbackground(15);
  clrscr;
  gotoxy(5,2);
  textcolor(0+blink);
  write('A(s) palavra(s) introduzidas n„o');
  gotoxy(13,3);
  write('ser„o gravados!');
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
  normvideo;
  clrscr;
  if c='S' then begin
                 clrscr;
                 highvideo;
                 writeln('* * * * * INSERIR PALAVRAS * * * * *');
                 writeln('   (c) Nuno Andr‚ Porto Morgado');
                 writeln('SPOOLER Magazine dos utilizadores PC');
                 normvideo;
                 writeln;writeln;
                 apcur(false);
                 halt
                end
           else begin
                  gotoxy(1,11);
                  write('Escolher CONTINUAR para inserir mais palavras, SAIR para gravar as palavras');
                  gotoxy(1,13);
                  write('e sair do programa ou ESCAPE para n„o gravar as palavras e sair do programa.');
                  goto 50
                end
  end;
  if c=esq then b:=true
           else if c=dir then b:=false;
  until c=enter;
  continuar:=b
end;

procedure lerpalavra; {Procedimento que lˆ o n§ de palavras existente no
                                    PALAVRAS.JP}
var f:file of conj;
begin
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
     close(f);
  end
end;

{ * CORPO DO PROGRAMA * }

begin
  checkbreak:=false;
  clrscr;
  apcur(true);
  fimpal:=0;
  gotoxy(14,3);
  highvideo;
  write('Inserir Palavras - Utilit rio Do Jogo Das Palavras');
  normvideo;
  gotoxy(4,15);
  write('Este utilit rio insere a palavras no disco para serem usadas no JOGO DAS');
  gotoxy(16,16);
  write('PALAVRAS na op‡„o de jogar contra o computador.');
  gotoxy(17,25);
  write('Prima ENTER para continuar ou ESCAPE para sair');
  while not(buffervazio) do c:=readkey;
  repeat
    c:=readkey;
  until (c=enter) or (c=esc);
  if c=esc then begin
                 clrscr;
                 highvideo;
                 writeln('* * * * * INSERIR PALAVRAS * * * * *');
                 writeln('   (c) Nuno Andr‚ Porto Morgado');
                 writeln('SPOOLER Magazine dos utilizadores PC');
                 normvideo;
                 writeln;writeln;
                 apcur(false);
                 halt;
                end;
  lerpalavra;
  repeat
    clrscr;
    fimpal2:=fimpal;
    gotoxy(14,3);
    highvideo;
    write('Inserir Palavras - Utilit rio Do Jogo Das Palavras');
    normvideo;
    gotoxy(26,19);
    write('Palavras em disco: ');
    highvideo;
    write(fimpal);
    normvideo;
    inc(fimpal);
    gotoxy(11,13);
    write('Palavra (entre 4 e 25 letras): ');
    if not inserepalavra(p[fimpal]) then dec(fimpal);
    gotoxy(25,19);
    write(' Palavras em disco: ');
    highvideo;
    write(fimpal);
    normvideo;
  until not(continuar);
  if (fimpal>0) and (fimpal2<>fimpal) then gravarpalavras;
  clrscr;
  highvideo;
  writeln('* * * * * INSERIR PALAVRAS * * * * *');
  writeln('   (c) Nuno Andr‚ Porto Morgado');
  writeln('SPOOLER Magazine dos utilizadores PC');
  normvideo;
  writeln;writeln;
  apcur(false);
end.