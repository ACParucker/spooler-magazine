{           Ficheiro: Instalar.Pas                                           }
{           Descri‡„o: Instala‡„o dos Dados Da Sorte                         }
{           Programa‡„o por: Nuno Miguel Oliveira Brito                      }
{           Para a: Spooler Magazine dos Utilizadores PC                     }

program instalar_no_disco_os_dds;
uses crt,dos,drivers;
const cdrive:byte=3;
var int:boolean;
    y,perc:integer;

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

procedure percentagem;   { Percentagem de instala‡„o }
var i:integer;
begin
     textcolor(white);
     for i:=12 to y do
     begin
          gotoxy(y,17);
          write('ÛÛÛÛÛ');
     end;
     y:=y+5;
end;

procedure barra;
var i:integer;
    c:char;
begin
     textcolor(white);
     gotoxy(12,16);write('0%');
     gotoxy(63,16);write('100%');
     textcolor(lightgray);
     for i:=12 to 66 do
     begin
          gotoxy(i,17);
          write('±');
     end;
end;

procedure instalar;    { Instalar os dados da sorte num disco }
label inic,fim;
var s:string;
    dir:string[80];
    c:char;
    i:integer;
begin
     cursor;
     inic:clrscr;
     perc:=0;
     getdir(0,s);
     textcolor(lightgreen);
     gotoxy(22,1);write('Instala‡„o dos Dados da Sorte');
     gotoxy(30,3);write('Vers„o 1.0');
     textcolor(white);
     gotoxy(8,10);write('Directoria Corrente: ',s);
     textcolor(lightblue);
     gotoxy(8,15);write('Ex: C:\DDS');
   { Caso a escolha seja c:\jogos\dados, a directoria 'jogos' j  tem que   }
   { existir, pois ele s¢ cria a £ltima directoria, neste caso era 'dados' }
     textcolor(white);
     gotoxy(8,13);write('Directoria de Instala‡„o (0-Sair): ');
     readln(dir);
     if dir='0' then begin
                          int:=true;
                          goto fim;
                     end;
     for i:=1 to 80 do
         dir[i]:=upcase(dir[i]);
     {$I-}
     nocursor;
     mkdir(dir);
     if ioresult<>0 then
        begin
             textcolor(lightgreen+128);
             gotoxy(1,24);write('Esc');
             textcolor(white);
             gotoxy(4,24);write(' - Sair');
             window(20,10,59,16);
             textbackground(red);
             clrscr;
             textcolor(white);
             gotoxy(4,2);write('N„o consigo criar essa directoria!');
             gotoxy(11,5);write('Prima uma tecla . . .');
             while keypressed do c:=readkey;c:=readkey;
             window(1,1,80,25);
             textbackground(black);
             cursor;
             if c=chr(27) then begin
                                    int:=true;
                                    goto fim;
                               end;
             goto inic;
        end;
     clrscr;
     barra;
     textcolor(lightgreen);
     gotoxy(23,1);write('Instala‡„o dos Dados da Sorte');
     gotoxy(32,3);write('Vers„o 1.0');
     textcolor(white);
     gotoxy(19,12);write('Copiando os ficheiros para a directoria :');
     gotoxy(33,14);write(dir);
     textcolor(lightred);
     gotoxy(29,24);write('Espere um momento . . .');
     swapvectors;
     {$M 4000,0,0}
     exec(getenv('COMSPEC'),'/C COPY '+s+'dados.exe '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'dados.pas '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'instalar.exe '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'instalar.pas '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'retirarp.exe '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'retirarp.pas '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'dds.txt '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'dds.ico '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'egavga.bgi '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'*.dds '+dir+' >>filelist.dds');
     percentagem;
     exec(getenv('COMSPEC'),'/C COPY '+s+'*.chr '+dir+' >>filelist.dds');
     perc:=perc+1;
     percentagem;
     delay(500);
     {$M 16384,0,65360}
     swapvectors;
     fim:
     normvideo;clrscr;textcolor(lightgray);
     cursor;
     writeln('ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
     writeln('º  ¯ ¯ ¯ ¯ OS DADOS DA SORTE ® ® ® ®  º');
     writeln('º   (c) Nuno Miguel Oliveira Brito    º');
     writeln('º SPOOLER Magazine dos utlizadores PC º');
     writeln('ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');
     writeln;
     if int=false then writeln('Instala‡„o Completa.')
                  else writeln('Instala‡„o Interrompida.');
end;

begin
     y:=12;
     checkbreak:=false;
     int:=false;
     instalar;
end.