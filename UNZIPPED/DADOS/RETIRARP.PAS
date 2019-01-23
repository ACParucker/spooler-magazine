{           Ficheiro: RetirarP.Pas                                           }
{           Descri‡„o: Retirar palavras do ficheiro                          }
{           Programa‡„o por: Nuno Miguel Oliveira Brito                      }
{           Para a: Spooler Magazine dos Utilizadores PC                     }

program Apagar_Palavras;
uses crt,dos;
label 01;
type registo=record
                   palavra,tema:string[20];
                   n_vogais,n_letras,espacos:integer;
             end;
     palavras=array[1..1000] of registo;

var f:file of registo;  { Variaveis globais }
    ar:palavras;
    pos,apagadas,z,i,j,ntpal,pal,l,nt:integer;
    c:char;
    alteracoes:boolean;
    cod,pass:string;

procedure nocursor;   { Desliga o cursor }
var r:registers;
begin
     r.ch:=100;r.cl:=10;r.ah:=1;intr($10,r);
end;

procedure cursor;     { Ligar o cursor }
var r:registers;
begin
     r.ch:=11;r.cl:=12;r.ah:=1;intr($10,r);
end;

procedure sair;     { Procedimento de sa¡da }
var x,y:integer;
begin
     normvideo;clrscr;textcolor(lightgray);textbackground(black);
     gotoxy(1,1);writeln('ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
     gotoxy(1,2);writeln('º  ¯ ¯ ¯ ¯ OS DADOS DA SORTE ® ® ® ®  º');
     gotoxy(1,3);writeln('º   (c) Nuno Miguel Oliveira Brito    º');
     gotoxy(1,4);writeln('º SPOOLER Magazine dos utlizadores PC º');
     gotoxy(1,5);writeln('ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');
     cursor;
end;

procedure writeprotected;  { Verifica se a disquette est  protegida }
begin
     window(20,10,59,16);
     textbackground(4);textcolor(15+blink);
     clrscr;
     gotoxy(7,2);write('A diskette est  protegida!');
     normvideo;textbackground(4);
     gotoxy(2,4);write('Desprotega a diskette e prima ENTER.');
end;

procedure lerfich; { Lˆ no ficheiro o n£mero de palavras existentes }
var s:pathstr;
begin
     ntpal:=0;
     for i:=1 to 20 do ar[i].palavra:='';
     assign(f,'palavras.dds');
     s:=fsearch('palavras.dds',getenv('Path'));
     if s='' then rewrite(f)
             else reset(f);
     while not(eof(f)) do
     begin
          inc(ntpal);
          read(f,ar[ntpal]);
     end;
     if ntpal>0 then close(f);
end;

procedure gravarpal; { Gravar as palavras no respectivo ficheiro }
label 01;
begin
     assign(f,'palavras.dds');
     01:
     {$i-}
     rewrite(f);
     {$i+}
     { Verifica se a disquete se encontra protegida ou n„o }
     if ioresult=150 then begin
                               nocursor;
                               writeprotected;
                               repeat
                                     c:=readkey;
                               until (c=chr(13));
                               window(1,1,80,25);
                               textbackground(black);
                               clrscr;
                               cursor;
                               if c=chr(13) then goto 01;
                          end
                     else if ioresult=0 then begin
                                                  for i:=1 to ntpal do
                                                      write(f,ar[i]);
                                             end;
     close(f);
     if ntpal=0 then
        begin
             swapvectors;
             {$M 4000,0,0}
             exec(getenv('comspec'),'/CDEL PALAVRAS.DDS >>FILELIST.DDS');
             {$M 16384,0,65360}
             swapvectors;
        end;
end;

procedure apaga(var pal:integer); { Apagar uma ou mais palavras selecionadas }
begin
     pos:=1;
     textcolor(black);
     gotoxy(50,3);write('Teclas: Enter - Seleccionar');
     gotoxy(58,4);write('Esc   - Sair');
     gotoxy(58,5);write(chr(24),'     - Cima');
     gotoxy(58,6);write(chr(25),'     - Baixo');
     window(20,10,59,16);
     textbackground(red);
     clrscr;
     textcolor(white);
     gotoxy(8,2);write('Deseja apagar a palavra:');
     textcolor(white+blink);
     gotoxy((33-ar[pal].n_letras) div 2,3);
     write(ar[pal].palavra);
     textbackground(red);textcolor(white);
     cursor;
     gotoxy(13,5);write('Op‡„o(S/N): ');
     while keypressed do c:=readkey;
     repeat
           c:=upcase(readkey);
     until (c='S') or (c='N');
     window(1,1,80,25);
     if c='S' then begin
                        alteracoes:=true;
                        inc(apagadas);
                        dec(ntpal);
                        for i:=pal to ntpal do ar[i]:=ar[i+1];
                        pal:=1;l:=0;
                   end;
     textbackground(black);
     clrscr;
     nocursor;
end;

procedure principal;  { Procedimento principal do programa }
label 01,02;
begin
     pos:=1;
     apagadas:=0;
     nocursor;
     textbackground(black);clrscr;
     lerfich;
     if ntpal=0 then
        begin
             textcolor(lightgreen);
             gotoxy(16,1);write('Apagar Palavras - Utilit rio dos Dados Da Sorte');
             textcolor(lightgray);
             gotoxy(50,3);write('Teclas: Esc - Sair');
             gotoxy(27,9);write('Ficheiro sem palavras!');
             while keypressed do c:=readkey;
             repeat
                   c:=readkey;
             until(c=chr(27));
             sair;halt(0);
        end;
     l:=0;z:=5;pal:=1;
     repeat
           01:
           gotoxy(1,4);write('                                          ');
           textcolor(lightgreen);
           gotoxy(16,1);
           write('Apagar Palavras - Utilit rio dos Dados Da Sorte');
           textcolor(yellow);
           gotoxy(2,4);write('N§ Palavras: ',ntpal);
           gotoxy(22,4);write('Posi‡„o N§: ');
           gotoxy(34,4);write(pos);
           textcolor(lightgray);
           if ntpal>20 then nt:=20
                       else nt:=ntpal;
           for i:=1 to nt do
           begin
                if pal=(i+l) then begin
                                       textbackground(lightgray);
                                       textcolor(black);
                                  end;
                for j:=1 to 20 do
                begin
                     gotoxy(j+1,i+5);
                     write(ar[i+l].palavra[j]);
                end;
                textbackground(black);
                textcolor(lightgray);
           end;
           if ntpal=0 then begin
                                textcolor(lightgray);
                                gotoxy(50,3);
                                write('Teclas: Esc - Sair');
                                textcolor(lightblue);
                                gotoxy(24,9);
                                write('Terminaram-se as palavras!');
                                while keypressed do c:=readkey;
                                repeat
                                      c:=readkey;
                                until(c=chr(27));
                                goto 02;
                           end;
           textcolor(lightgray);
           gotoxy(50,3);write('Teclas: Enter - Seleccionar');
           gotoxy(58,4);write('Esc   - Sair');
           gotoxy(58,5);write(chr(24),'     - Cima');
           gotoxy(58,6);write(chr(25),'     - Baixo');
           while keypressed do c:=readkey;
           repeat
                 c:=readkey;
           until(c=chr(27)) or (c=chr(13)) or (c=#80) or (c=#72);
           if (c=#80) and (pal<ntpal) then
              begin
                   pos:=pos+1;
                   textcolor(magenta);
                   gotoxy(58,6);
                   write(chr(25));
                   if (pal-l)=20 then inc(l);
                   inc(pal);
                   delay(50);
              end
           else if (c=#72) and (pal>1) then
                begin
                     pos:=pos-1;
                     textcolor(magenta);
                     gotoxy(58,5);
                     write(chr(24));
                     if (pal-l)=1 then dec(l);
                     dec(pal);
                     delay(50);
                end
           else if (c=chr(13)) and (ntpal>0) then apaga(pal)
     until (c=chr(27));
     02:
     if alteracoes=true then
        begin
             textcolor(black);
             gotoxy(50,3);write('Teclas: Enter - Seleccionar');
             gotoxy(58,4);write('Esc   - Sair');
             gotoxy(58,5);write(chr(24),'     - Cima');
             gotoxy(58,6);write(chr(25),'     - Baixo');
             window(20,10,59,16);
             textbackground(red);
             clrscr;
             textcolor(white);
             gotoxy(16,2);
             write('ATEN€ŽO');
             textcolor(white+blink);
             gotoxy(7,3);
             write('Foram apagadas ',apagadas,' palavra(s)!');
             textcolor(white);
             gotoxy(4,5);write('Ctrl-G gravar altera‡”es, Ctrl-N');
             gotoxy(3,6);write('sair sem gravar e Enter para voltar.');
             while keypressed do c:=readkey;
             repeat
                   c:=upcase(readkey);
             until(c=chr(13)) or (c=^G) or (c=^N);
             normvideo;
             window(1,1,80,25);
             if c=^G then gravarpal;
             if c=chr(13) then begin
                                    clrscr;
                                    goto 01;
                               end;
        end;
     sair;
end;

procedure password;   { Verifica se a password est  certa em rela‡„o …   }
label 01,02;          { password escolhida ao acaso pelo computador      }
var x,y,n_pass:integer;
    st:string;
begin
     randomize;
     for x:=1000 to 9999 do   { Escolhe uma password       }
         n_pass:=random(x);   {  um n£mero de 1000 a 9999 }
     01:clrscr;window(1,1,80,25);textbackground(black);clrscr;
     textcolor(lightgreen);
     gotoxy(16,1);write('Apagar Palavras - Utilit rio dos Dados Da Sorte');
     textcolor(10+blink);gotoxy(1,24);write('Esc ');
     textcolor(white);gotoxy(5,24);write('- Sair');
     normvideo;i:=1;
     gotoxy(30,12);write('PassWord: ');
     cod:='    ';
     x:=40;
     repeat                          { Lˆ a password caracter a caracter }
           c:=readkey;c:=upcase(c);
           if (c=chr(27)) or (c=chr(13)) then goto 02;
           cod[i]:=c;
           if (c=chr(8)) and (x>40) then begin
                                              i:=i-1;
                                              dec(x);
                                              gotoxy(x,12);write('');
                                         end
                                    else if (c<>chr(8)) then begin
                                                                  i:=i+1;
                                                                  gotoxy(x,12);write('*');
                                                                  inc(x);
                                                             end;
           02:
     until ((i>4) or (c=chr(13)) or (c=chr(44)) or (c=chr(27)));
     if c=chr(27) then begin
                            sair;exit;
                       end;
     str(n_pass,pass);
     if c=chr(44) then    { Para ver a password premir Alt+Z }
        begin
             nocursor;
             textcolor(black);gotoxy(1,24);write('Esc ');
             gotoxy(5,24);write('- Sair');
             window(20,10,59,16);textbackground(red);
             clrscr;textcolor(white);
             gotoxy(12,2);write('A PassWord ‚ : ');
             textcolor(lightgreen+128);gotoxy(16,4);write(n_pass);
             textcolor(white);
             gotoxy(6,6);write('Prima uma tecla para continuar');
             while keypressed do c:=readkey;c:=readkey;
             cursor;
             goto 01;
        end
     else if (i=5) and (cod=pass) then principal
                                  else begin
                                            clrscr;nocursor;
                                            gotoxy(29,12);textcolor(white+128);
                                            write('PassWord Errada !!');
                                            delay(1500);
                                            sair;
                                       end;
end;
                       { Corpo Principal }
begin
     checkbreak:=false;
     alteracoes:=false;
     password;
end.
