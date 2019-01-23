{           Ficheiro: Dados.Pas                                              }
{           DescriáÑo: Os Dados Da Sorte                                     }
{           ProgramaáÑo por: Nuno Miguel Oliveira Brito                      }
{           Para a: Spooler Magazine dos Utilizadores PC                     }
program dados_da_sorte;
uses crt, dos, graph, drivers;
type registo=record
                   palavra,tema:string[20];
                   n_letras,n_vogais,espacos:integer;
             end;
     abc=record
               letra:char;
               flag:boolean;
         end;
     topmais=record
                   vencedor:string[10];
                   pont:integer;
             end;
     { Vari†veis globais }
var f:file of registo;   { Para as Palavras  }
    g:file of topmais;   { Para os Hi-Scores }
    rec:topmais;
    recaux,escolhida:registo;
    x,y,top,num,num2,letras,pont_cpu,i,i2,i3,aux_cpu,aux1,aux2,aux3,ntpal,pontuacao1,pontuacao2,pontuacao3,
    letras_encontradas:integer;
    s:pathstr;
    ar:array[1..200] of registo;
    arr:array[1..10] of topmais;
    vencedor,cpu,jogador1,jogador2,jogador3,jogador:string[10];
    pass,cod:string[4];
    dado1,dado2:array [1..10] of integer;
    c,ch,letra,opcao:char;
    abcedario:array [1..26] of abc;
    jogar,palavras,flag,ja_inscritos,quit,diz_mensagem1:boolean;
    adiv:string[20];
    st:string;

procedure mensagem;          { Mensagem para o utilizador. }
begin
     settextstyle(1,0,3);
     setcolor(white);outtextxy(110,440,'Prima uma tecla para continuar. . .');
     while keypressed do opcao:=readkey;opcao:=readkey;
     { Este ciclo while retira do buffer todas teclas premidas atÇ ao   }
     { momento ( Ç muitas vezes utilizado ao longo do programa )        }
     { ê o chamado, 'vazar' o buffer do teclado .                       }
end;

procedure nocursor;          { Desliga o cursor }
var r:registers;
begin
     r.ch:=100;r.cl:=10;r.ah:=1;intr($10,r);
end;

procedure cursor;            { Ligar o cursor }
var r:registers;
begin
     r.ch:=11;r.cl:=12;r.ah:=1;intr($10,r);
end;

procedure sair;    { Sa° de uma certa operaáÑo }
begin
     quit:=true;exit;
end;

procedure inic_graficos;    { Inicia os gr†ficos}
var graphdriver,graphmode:integer;
begin
     graphdriver:=detect;
     initgraph(graphdriver,graphmode,'');
end;

procedure ver_graficos;             { Verifica se a placa gr†fica Ç VGA }
var graphdriver,graphmode:integer;  { Se nÑo for nÑo executa o jogo     }
    r:registers;
begin
     intr($11,r);
     if (r.al and 48)=16 then
        begin
             cursor;normvideo;clrscr;textcolor(lightgray);
             writeln('…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª');
             writeln('∫  Ø Ø Ø Ø OS DADOS DA SORTE Æ Æ Æ Æ  ∫');
             writeln('∫   (c) Nuno Miguel Oliveira Brito    ∫');
             writeln('∫ SPOOLER Magazine dos utlizadores PC ∫');
             writeln('»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
             writeln;
             write('Os Dados da Sorte s¢ funcionam em 80x25.');
             halt(1);  { NÑo chega a executar o jogo }
        end;
     detectgraph(graphdriver,graphmode);
     if (graphdriver=VGA) then
        begin
             inic_graficos;
             settextstyle(3,0,3);setcolor(lightred);
             outtextxy(170,200,'PLACA VGA DETECTADA');
             delay(1000);cleardevice;
        end
     else begin
               cursor;normvideo;clrscr;textcolor(lightgray);
               writeln('…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª');
               writeln('∫  Ø Ø Ø Ø OS DADOS DA SORTE Æ Æ Æ Æ  ∫');
               writeln('∫   (c) Nuno Miguel Oliveira Brito    ∫');
               writeln('∫ SPOOLER Magazine dos utlizadores PC ∫');
               writeln('»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
               writeln;
               write('Placa VGA nÑo detectada.');
               halt(1);  { NÑo chega a executar o jogo }
          end;
end;

procedure writeprotected;  { Verifica se a disquette est† protegida }
begin
     window(20,10,59,16);
     textbackground(4);textcolor(15+blink);
     clrscr;
     gotoxy(7,2);write('A diskette est† protegida!');
     normvideo;textbackground(4);
     gotoxy(2,4);write('Desprotega a diskette e prima ENTER.');
end;

procedure gravarscores;  { Grava as pontuaáîes }
begin
     rec.vencedor:=vencedor;
     top:=top+1;
     write(g,rec);
     arr[top]:=rec;
end;

procedure trocar;    { Ordena as pontuaáîes caso estejam desordenadas }
var z:topmais;
begin
     if x<>y then begin
                       z:=arr[x];arr[x]:=arr[y];arr[y]:=z;
                  end;
end;

procedure trocadirecta;   { Troca dos high-scores }
var tp:integer;
begin
     for x:=1 to pred(top) do
         for y:=x+1 to top do
             if not(arr[x].pont>=arr[y].pont) then trocar;
     if jogar=true then gravarscores;
     jogar:=false;
end;

procedure lerscores; { Là no ficheiro o n£mero de scores existentes }
label fim;
var t,y:integer;
begin
     y:=6;top:=0;
     assign(g,'scores.dds');
     s:=fsearch('scores.dds',getenv(''));
     if s='' then rewrite(g)
             else reset(g);
     clrscr;nocursor;textcolor(yellow);
     gotoxy(30,1);write('Os Dados Da Sorte');
     textcolor(white);
     gotoxy(28,3);write('H I G H - S C O R E S');
     gotoxy(20,5);write('NOMES');
     gotoxy(49,5);writeln('PONTUAÄôES');
     while not(eof(g)) do
     begin
          inc(top);
          read(g,rec);
     end;
     trocadirecta;
     for i:=1 to top do
     begin
          rec:=arr[i];
          y:=y+1;textcolor(i+1);
          gotoxy(17,y);write(arr[i].vencedor);
          gotoxy(53,y);write(arr[i].pont);
          delay(200);
          if (i=10) then begin
                              top:=i;goto fim;
                         end;
     end;
     fim:textcolor(white);
     gotoxy(30,22);write('Nß de Scores: ',top);
     gotoxy(22,24);write('Prima uma tecla para continuar. . .');
     while keypressed do c:=readkey;c:=readkey;
     cursor;
     close(g);
end;

procedure carrega_scores;   { Carrega a tabela dos Hi-Scores (PontuaáÑo). }
var g:file of topmais;
begin
     top:=0;
     for i:=1 to 10 do vencedor[i]:=' ';
     assign(g,'scores.dds');
     s:=fsearch('scores.dds',getenv(''));
     if s='' then rewrite(g)
             else begin
                       reset(g);
                       i:=1;
                       while not eof(g) do
                       begin
                            read(g,rec);
                            arr[i]:=rec;
                            top:=top+1;
                            i:=i+1;
                       end;
                  end;
     close(g);
end;

procedure topten;    { Escreve no ficheiro os hi-scores }
begin
     assign(g,'scores.dds');
     s:=fsearch('scores.dds',getenv(''));
     if s='' then rewrite(g)
             else begin
                       reset(g);
                       while not eof(g) do read(g,rec);
                       if (vencedor=jogador1) then rec.pont:=pontuacao1
                          else if (vencedor=jogador2) then rec.pont:=pontuacao2
                          else if (vencedor=jogador3) then rec.pont:=pontuacao3
                          else if (vencedor='CPU') then rec.pont:=pont_cpu;
                       trocadirecta;
                  end;
     close(g);
end;

procedure ver_mouse;   { Verifica se o rato est† instalado }
var regs:registers;
begin
     setcolor(lightblue);settextstyle(1,0,4);
     regs.ax:=$00;regs.bx:=$00;
     intr($33,regs);
     if (regs.ax<>0) and (regs.bx<>0) then outtextxy(200,210,'Rato Instalado')
                                      else begin
                                                outtextxy(170,180,'Rato NÑo Instalado');
                                                outtextxy(182,230,'Teclado Instalado');
                                                flag:=true;
                                           end;
     delay(1200);setcolor(black);
     for x:=160 to 270 do begin
                               line(70,x,575,x);
                               delay(5);
                          end;
     delay(40);
     while keypressed do c:=readkey;
end;

procedure inic_abcedario;     { Inicializa o Abced†rio a True }
begin
     for i:=1 to 26 do
     begin
          abcedario[i].letra:=chr(64+i);
          abcedario[i].flag:=true;
     end;
end;

procedure escreve_abcedario;  { Escreve no Çcran o Abced†rio }
var i:char;
begin
     setcolor(lightgreen);rectangle(595,5,630,420);
     setfillstyle(1,blue);floodfill(596,6,lightgreen);
     setcolor(white);
     line(596,6,596,419);line(596,6,629,6);
     line(629,6,629,419);line(596,419,629,419);
     settextstyle(2,0,6);setcolor(white);
     x:=610;y:=15;
     for i:='A' to 'Z' do
     begin
          outtextxy(610,y,i);y:=y+15;
     end;
end;

procedure mudar_letra;        { Muda no Çcran a letra escolhida para outra }
var l:char;                   { cor                                        }
    w:integer;
begin
     w:=15;
     settextstyle(2,0,6);setcolor(lightred);
     for l:='A' to 'Z' do
     begin
          if letra=l then outtextxy(610,w,l);
          w:=w+15;
     end;
end;

procedure apagar_versao;   { Limpa a parte da versÑo }
begin
     setfillstyle(1,lightblue);floodfill(211,31,black);
     setcolor(lightblue);rectangle(210,30,410,130);
     line(211,31,211,129);line(211,31,409,31);
     line(211,129,409,129);line(409,31,409,129);
     settextstyle(2,0,5);
     outtextxy(220,40,'JOGO: Os Dados Da Sorte');
     outtextxy(270,60,'VersÑo 1.0');
     outtextxy(240,80,'Copyright (c) 1993');
     outtextxy(215,100,'Nuno Miguel Oliveira Brito');
     settextstyle(1,0,5);setcolor(white);
     outtextxy(210,20,'OS DADOS');
     outtextxy(210,80,'DA SORTE');
     settextstyle(1,0,5);setcolor(red+brown);
     outtextxy(212,22,'OS DADOS');
     outtextxy(212,82,'DA SORTE');
end;

procedure versao;    { VersÑo dos Dados da Sorte }
var c:integer;
begin
     setcolor(black);
     rectangle(210,30,410,130);
     setfillstyle(1,lightgray);floodfill(211,31,black);
     setcolor(white);line(211,31,211,129);line(211,31,409,31);
     setcolor(darkgray);line(211,129,409,129);line(409,31,409,129);
     settextstyle(2,0,5);setcolor(white);
     outtextxy(220,40,'JOGO: Os Dados Da Sorte');
     outtextxy(270,60,'VersÑo 1.0');
     outtextxy(240,80,'Copyright (c) 1993');
     outtextxy(215,100,'Nuno Miguel Oliveira Brito');
end;

function mouse:integer;       { FunáÑo que coordena todas as coordenadas   }
var c:integer;                {  do rato                                   }
begin
     c:=0;
     repeat
           if mousebuttons=mbleftbutton then
              begin
                   if (mousewhere.x in[3..18]) and (mousewhere.y in[21..45]) then
                      begin
                           setcolor(white);circle(135,275,5);
                           setfillstyle(1,white);floodfill(136,276,white);
                           while mousebuttons=mbleftbutton do
                           begin end;
                           c:=1;delay(150);
                      end;
                   if (mousewhere.x in[21..35]) and (mousewhere.y in[21..45]) then
                      begin
                           setcolor(white);circle(275,275,5);
                           setfillstyle(1,white);floodfill(276,276,white);
                           while mousebuttons=mbleftbutton do
                           begin end;
                           c:=2;delay(150);
                      end;
                   if (mousewhere.x in[38..53]) and (mousewhere.y in[21..45]) then
                      begin
                           setcolor(white);circle(415,275,5);
                           setfillstyle(1,white);floodfill(416,276,white);
                           while mousebuttons=mbleftbutton do
                           begin end;
                           c:=3;delay(150);
                      end;
                   if (mousewhere.x in[56..70]) and (mousewhere.y in[21..45]) then
                      begin
                           setcolor(white);circle(555,275,5);
                           setfillstyle(1,white);floodfill(556,276,white);
                           while mousebuttons=mbleftbutton do
                           begin end;
                           c:=4;delay(150);
                      end;
                   if (mousewhere.x in[73..78]) and (mousewhere.y in[25..32]) then
                      begin
                           while mousebuttons=mbleftbutton do
                           begin end;
                           c:=5;
                      end;
              end;
           if mousebuttons=mbrightbutton then
              begin
                   if (mousewhere.x in[0..80]) and (mousewhere.y in[0..80]) then
                      begin
                           doneevents;  { Retira a seta do rato do Çcran }
                           versao;
                           initevents;  { Coloca a seta do rato no Çcran }
                           while mousebuttons=mbleftbutton do
                           begin end;
                           c:=6;
                           repeat until mousebuttons=mbrightbutton;
                           doneevents;apagar_versao;initevents;
                      end;
              end;
     until c<>0;
     mouse:=c;
end;

procedure desenha_portas(x1,y1,x2,y2:integer);  { Desenha as 4 portas }
begin
     setcolor(brown);
     rectangle(x1,y1,x2,y2);
     setfillstyle(1,brown);floodfill(x1+1,y1+1,brown);
     setcolor(white);
     line(x1+2,y2-1,x2-1,y2-1);
     line(x2-1,y2-1,x2-1,y1+2);
     setcolor(black);
     line(x1+1,y1+1,x2-1,y1+1);
     line(x1+1,y1+1,x1+1,y2-1);
end;

procedure desenha_placas(a1,b1,a2,b2:integer);  { Desenha as 4 Placas }
begin
     setcolor(black);
     rectangle(a1,b1,a2,b2);
     setfillstyle(1,lightgray);floodfill(a1+1,b1+1,black);
     setcolor(white);
     line(a1+1,b1+1,a2-1,b1+1);
     line(a1+1,b1+1,a1+1,b2-1);
     setcolor(darkgray);
     line(a1+2,b2-1,a2-1,b2-1);
     line(a2-1,b2-1,a2-1,b1+2);
end;

procedure desenha_fechaduras(x1,y1,q:integer);  { Desenha as 4 fechaduras }
begin
     setcolor(black);
     circle(x1,y1,q);
     setfillstyle(1,black);floodfill(x1+1,y1+1,black);
     setcolor(black);
     circle(x1,y1+10,q-2);
     putpixel(x1-1,y1+14,black);putpixel(x1-1,y1+15,black);
     putpixel(x1-2,y1+16,black);putpixel(x1-2,y1+17,black);
     putpixel(x1-2,y1+18,black);putpixel(x1-2,y1+19,black);
     putpixel(x1-1,y1+20,black);putpixel(x1,y1+20,black);
     putpixel(x1+1,y1+20,black);putpixel(x1+2,y1+19,black);
     putpixel(x1+2,y1+18,black);putpixel(x1+2,y1+17,black);
     putpixel(x1+2,y1+16,black);putpixel(x1+1,y1+15,black);
     putpixel(x1+1,y1+14,black);putpixel(x1+1,y1+13,black);
     putpixel(x1,y1+13,brown);
     setfillstyle(1,black);floodfill(x1+2,y1+11,black);
     setcolor(black);
     circle(x1-45,y1-75,q-3);
     setfillstyle(1,black);floodfill(x1-44,y1-74,black);
end;

procedure desenha_papel_de_ajuda;     { Desenha o papel da Ajuda }
begin
     setcolor(black);
     rectangle(580,200,630,265);
     setfillstyle(1,white);floodfill(581,201,black);
     settextstyle(2,0,3);
     setcolor(lightred);
     outtextxy(595,207,'AJUDA');
     setcolor(black);
     line(592,222,617,222);
     line(590,229,617,229);
     line(590,236,617,236);
     line(590,243,617,243);
end;

procedure ajuda;     { O texto da pequena Ajuda }
begin
     cleardevice;
     setcolor(black);
     rectangle(0,0,659,479);
     setfillstyle(1,lightblue);floodfill(1,1,lightblue);
     setcolor(black);
     rectangle(145,10,480,440);
     setfillstyle(1,white);floodfill(146,11,black);
     settextstyle(1,0,5);
     setcolor(lightred);
     outtextxy(240,30,'AJUDA');
     settextstyle(2,0,5);
     setcolor(black);
     outtextxy(153,100,'Cada uma destas portas s¢ poder† ser      ');
     outtextxy(153,120,'aberta atravÇs do rato (botÑo esquerdo) ou');
     outtextxy(153,140,'primindo Ctrl + a 1¶letra de cada palavra.');
     outtextxy(160,160,' FunáÑo de cada porta :                   ');
     outtextxy(153,180,'JOGAR, Ç dentro desta porta que tudo se   ');
     outtextxy(153,200,'desenrola, isto Ç, Ç l† que se pode jogar ');
     outtextxy(153,220,'aos Dados da Sorte, mas primeiro os joga- ');
     outtextxy(153,240,'dores tem que se inscrever para poderem   ');
     outtextxy(153,260,'jogar.                                    ');
     outtextxy(153,280,'INSCRIÄôES, porta esta que serve para os  ');
     outtextxy(153,300,'jogadores se inscreverem.                 ');
     outtextxy(153,320,'BASTIDORES, dentro desta porta pode-se ver');
     outtextxy(153,340,'todas as palavras que existem no ficheiro ');
     outtextxy(153,360,'e acrescentar mais palavras nesse.        ');
     outtextxy(153,380,'Porta de SAIDA, sem coment†rios.          ');
     settextstyle(1,0,1);
     outtextxy(160,410,'Prima uma tecla para continuar.');
     while keypressed do opcao:=readkey;opcao:=readkey;
end;

procedure introduz_palavra;   { Introduzir palavras novas no ficheiro }
label 01,02,03,04;
begin
     cursor;opcao:=' ';
     assign(f,'palavras.dds');
     s:=fsearch('palavras.dds',getenv('PATH'));
     01:
     if s='' then rewrite(f)
             else begin
                       reset(f);
                       while not eof(f) do read(f,recaux);
                  end;
     for i:=1 to 20 do
     begin
          recaux.palavra[i]:=' ';
          recaux.tema[i]:=' ';
     end;
     clrscr;
     if opcao<>'S' then
        begin
             gotoxy(1,1);textcolor(white);
             write('Deseja vàr ( ) a lista de palavras ou introduzir ( ) mais? ');
             textcolor(10+blink);gotoxy(1,24);write('Esc ');
             gotoxy(13,1);write('v');
             gotoxy(51,1);;write('i');
             textcolor(white);gotoxy(5,24);write('- Sair');
             gotoxy(60,1);textcolor(white);
             repeat
                   while keypressed do c:=readkey;c:=readkey;c:=upcase(c);
             until (c='V') or (c='I') or (c=chr(27));
        end;
     if c=chr(27) then
        begin
             inic_graficos;exit;
        end;
     if c='I' then
        begin
             clrscr;gotoxy(1,1);textcolor(lightgreen);
             writeln('Qual a palavra que deseja introduzir ? [M†x: 20 Caracteres]');
             textcolor(white);readln(recaux.palavra);
             for i:=1 to 20 do recaux.palavra[i]:=upcase(recaux.palavra[i]);
             gotoxy(1,4);textcolor(lightgreen);
             writeln('Qual o tema ? [M†x: 20 Caracteres]');
             textcolor(white);readln(recaux.tema);
             for i:=1 to 20 do recaux.tema[i]:=upcase(recaux.tema[i]);
             recaux.n_letras:=0;
             recaux.n_vogais:=0;
             recaux.espacos:=0;
             i:=1;
             while (i<20) do
             begin
                  if (recaux.palavra[i]=' ') and (recaux.palavra[i+1]=' ')
                     then  { NÑo faz "nada" }
                  else if (recaux.palavra[i]=' ') then
                       recaux.espacos:=recaux.espacos+1
                  else recaux.n_letras:=recaux.n_letras+1;
                  i:=i+1;
             end;
             i:=1;
             while (i<20) do
             begin
                  if (recaux.palavra[i] in ['A','E','I','O','U']) then
                     recaux.n_vogais:=recaux.n_vogais+1;
                  i:=i+1;
             end;
             repeat
                   gotoxy(1,24);write('Deseja gravar no ficheiro?(S/N): ');
                   while keypressed do opcao:=readkey;opcao:=readkey;opcao:=upcase(opcao);
             until (opcao='S') or (opcao='N');
             if (opcao='S') then
                begin
                     03:
                     {$i-}
                     write(f,recaux);
                     {$i+}
                     { Verifica se a disquete se encontra protegida ou nÑo }
                     if ioresult=150 then begin
                                               nocursor;writeprotected;
                                               repeat
                                                     c:=readkey;
                                               until (c=chr(13));
                                               window(1,1,80,25);
                                               textbackground(black);
                                               clrscr;cursor;
                                               if c=chr(13) then goto 03;
                                           end
                     else if ioresult=0 then
                          begin
                               ntpal:=ntpal+1;
                               ar[ntpal]:=recaux;
                          end;
                end;
             clrscr;
             if c<>'V' then
                begin
                     repeat
                           clrscr;
                           write('Deseja inserir outra palavra?(S/N): ');
                           while keypressed do opcao:=readkey;opcao:=readkey;opcao:=upcase(opcao);
                     until (opcao='S') or (opcao='N');
                     reset(f);
                     if opcao='S' then goto 01;
                end;
        end
     else if c='V' then reset(f);
     inic_graficos;
     02:settextstyle(1,0,2);setcolor(green);
     outtextxy(520,450,'Esc - Sair');
     settextstyle(2,0,6);setcolor(lightgreen);
     outtextxy(40,10,'PALAVRAS');
     outtextxy(280,10,'TEMAS');
     outtextxy(450,10,'LETRAS');
     outtextxy(550,10,'VOGAIS');
     i:=30;
     setcolor(white);
     str(ntpal,st);outtextxy(1,460,'Nß de Palavras:'+st);
     while not eof(f) do
     begin
          read(f,recaux);
          outtextxy(1,i,recaux.palavra);
          outtextxy(225,i,recaux.tema);
          str(recaux.n_letras,st);outtextxy(465,i,st);
          str(recaux.n_vogais,st);outtextxy(575,i,st);
          delay(100);i:=i+19;
          if i>=401 then begin
                              setcolor(yellow);
                              outtextxy(1,440,'Prima uma tecla para vàr as restantes palavras . . .');
                              while keypressed do opcao:=readkey;opcao:=readkey;
                              if opcao=chr(27) then goto 04;
                              setcolor(black);
                              outtextxy(1,i,recaux.palavra);
                              outtextxy(215,i,recaux.tema);
                              str(recaux.n_letras,st);outtextxy(465,i,st);
                              str(recaux.n_vogais,st);outtextxy(575,i,st);
                              delay(100);
                              i:=30;cleardevice;
                              goto 02;
                         end;
     end;
     if (ntpal=0) then
        outtextxy(180,220,'Ficheiro sem palavras. . .');
     while keypressed do opcao:=readkey;opcao:=readkey;
     if opcao=chr(27) then goto 04;
     04:close(f);
end;

procedure password;   { Verifica se a password introduzida est† certa em re- }
label 01,02;          { laáÑo Ö password escolhida ao acaso pelo computador. }
var n_pass,x:integer; { Caso seja diferente nÑo executa a funáÑo .           }
begin
     randomize;
     for x:=1000 to 9999 do   { Escolhe uma password       }
         n_pass:=random(x);   { ê um n£mero de 1000 a 9999 }
     closegraph;
     01:textbackground(black);
     clrscr;window(1,1,80,25);textbackground(black);clrscr;
     textcolor(10+blink);
     gotoxy(1,24);write('Esc ');
     textcolor(white);
     gotoxy(5,24);write('- Sair');
     normvideo;i:=1;
     gotoxy(30,12);write('PassWord: ');
     x:=40;cod:='    ';
     repeat                          { Là a password caracter a caracter }
           c:=readkey;c:=upcase(c);
           if (c=chr(27)) or (c=chr(13)) then goto 02;
           cod[i]:=c;
           if (c=chr(8)) and (x>40) then begin
                                              i:=i-1;
                                              dec(x);
                                              gotoxy(x,12);write('');
                                         end
                                    else if (c<>chr(8)) then
                                         begin
                                              i:=i+1;
                                              gotoxy(x,12);write('*');
                                              inc(x);
                                         end;
           02:
     until ((i>4) or (c=chr(13)) or (c=chr(44)) or (c=chr(27)));
     clrscr;
     str(n_pass,pass);
     if c=chr(27) then begin
                            inic_graficos;
                            exit;
                       end;
     if c=chr(44) then  { Para ser mais f†cil adivinhar, existe esta pequena }
        begin           { combinaáÑo de teclas ( ALT+Z ) para ver a password }
             nocursor;  { escolhida. Sendo assim mais f†cil de entrar.       }
             textcolor(black);gotoxy(1,24);write('Esc ');
             gotoxy(5,24);write('- Sair');
             window(20,10,59,16);textbackground(red);
             clrscr;textcolor(white);
             gotoxy(12,2);write('A PassWord Ç : ');
             textcolor(lightgreen+128);gotoxy(18,4);write(n_pass);
             textcolor(white);
             gotoxy(6,6);write('Prima uma tecla para continuar');
             while keypressed do c:=readkey;c:=readkey;
             cursor;
             goto 01;
        end
     else if (i=5) and (cod=pass) then introduz_palavra
                                    else begin
                                              clrscr;nocursor;
                                              gotoxy(29,12);textcolor(white+128);
                                              write('PassWord Errada !!');
                                              delay(1500);inic_graficos;
                                         end;
end;

procedure verificar_pal;   { Verifica se o ficheiro tem palavras. }
begin
     if ntpal=0 then begin
                          settextstyle(1,0,2);setcolor(lightred);
                          outtextxy(235,100,'A T E N Ä é O');
                          setcolor(white);
                          outtextxy(90,170,'NÑo existem palavras residentes em ficheiro.');
                          palavras:=true;delay(2000);
                          setcolor(black);
                          for x:=80 to 200 do begin
                                                   line(70,x,575,x);
                                                   delay(5);
                                              end;
                          while keypressed do c:=readkey;
                     end;
end;

procedure carrega_ar;         { Carrega o array com as palavras existentes }
label 01;                     {  no ficheiro                               }
var f:file of registo;
begin
     ntpal:=0;
     assign(f,'palavras.dds');
     s:=fsearch('palavras.dds',getenv('PATH'));
     if (s='') then begin
                         01:
                         {$i-}
                         rewrite(f);
                         {$i+}
                         if ioresult=150 then
                            begin
                                 writeprotected;
                                 repeat
                                       while keypressed do c:=readkey;c:=readkey;
                                 until (c=chr(13));
                                 window(1,1,80,25);
                                 textbackground(black);clrscr;
                                 if c=chr(13) then goto 01;
                            end;
                         verificar_pal;
                    end
     else begin
               reset(f);
               i:=1;
               while not eof(f) do
               begin
                    read(f,recaux);
                    ar[i]:=recaux;
                    ntpal:=ntpal+1;
                    i:=i+1;
               end;
               verificar_pal;
          end;
     close(f);
end;

procedure escolhe_pal;        { Escolhe no ficheiro uma palavra para ser }
var pospal:integer;           { descoberta pelos jogadores.              }
begin
     cleardevice;randomize;
     pospal:=(random(ntpal-1))+1;
     escolhida:=ar[pospal];
end;

procedure inscricao;          { Faz a inscriáÑo de cada jogador, no m†ximo }
label fim;                    { 3, e no m°nimo 1, sendo o seu parceiro o   }
begin                         { computador. ( BOA SORTE !! )               }
     closegraph;
     repeat
           repeat
                 clrscr;
                 textcolor(lightred);
                 gotoxy(31, 9);write('<I>nscriáîes');
                 gotoxy(31,11);write('<H>igh-Scores');
                 gotoxy(31,13);write('<A>bandonar');
                 textcolor(lightgray);
                 gotoxy(31,16);write('OpáÑo? ');
                 while keypressed do c:=readkey;c:=readkey;c:=upcase(c);
           until (c='I') or (c='H') or (c='A');
           if (c='H') then begin
                                lerscores;
                                goto fim;
                           end;
           if (c='A') then goto fim;
           clrscr;
           textcolor(white);gotoxy(1,24);
           write('AtenáÑo: Se a escolha for apenas um jogador o seu advers†rio ser† o computador.');
           gotoxy(1,1);write('Quantos jogadores vÑo jogar? [M†x:3 Jogadores] (0-Sair): ');
           aux_cpu:=0;aux1:=0;aux2:=0;aux3:=0;
           repeat
                 while keypressed do opcao:=readkey;opcao:=readkey;
                 case opcao of
                      '0':goto fim;
                      '1':aux1:=1;
                      '2':aux2:=1;
                      '3':aux3:=1;
                 end;
           until opcao in ['0','1','2','3'];
           ja_inscritos:=true;
           clrscr;
           if (aux1=1) then
              begin
                   writeln('Insira o nome do primeiro jogador [M†x: 10 Caracteres]: ');
                   readln(jogador1);
                   for i:=1 to 10 do jogador1[i]:=upcase(jogador1[i]);
                   aux_cpu:=1;aux1:=1;aux2:=0;aux3:=0;
              end;
           if (aux2=1) then
              begin
                   writeln('Insira o nome do primeiro jogador [M†x: 10 Caracteres]: ');
                   readln(jogador1);
                   for i:=1 to 10 do jogador1[i]:=upcase(jogador1[i]);
                   clrscr;
                   writeln('Insira o nome do segundo jogador [M†x: 10 Caracteres]: ');
                   readln(jogador2);
                   for i:=1 to 10 do jogador2[i]:=upcase(jogador2[i]);
                   aux_cpu:=0;aux1:=1;aux2:=1;aux3:=0;
              end;
           if (aux3=1) then
              begin
                   writeln('Insira o nome do primeiro jogador [M†x: 10 Caracteres]: ');
                   readln(jogador1);
                   for i:=1 to 10 do jogador1[i]:=upcase(jogador1[i]);
                   clrscr;
                   writeln('Insira o nome do segundo jogador [M†x: 10 Caracteres]: ');
                   readln(jogador2);
                   for i:=1 to 10 do jogador2[i]:=upcase(jogador2[i]);
                   clrscr;
                   writeln('Insira o nome do terceiro jogador [M†x: 10 Caracteres]: ');
                   readln(jogador3);
                   for i:=1 to 10 do jogador3[i]:=upcase(jogador3[i]);
                   aux_cpu:=0;aux1:=1;aux2:=1;aux3:=1;
              end;
           if aux2=0 then jogador2:=' ';
           if aux3=0 then jogador3:=' ';
           clrscr;
           if (jogador1=jogador2) and (aux2<>0) then
              begin
                   write('O nome do 1ßjogador Ç igual ao do 2ßjogador');
                   ja_inscritos:=false;
                   while keypressed do c:=readkey;c:=readkey;
              end;
           if (jogador2=jogador3) and (aux2<>0) and (aux3<>0) then
              begin
                   write('O nome do 2ßjogador Ç igual ao do 3ßjogador');
                   ja_inscritos:=false;
                   while keypressed do c:=readkey;c:=readkey;
              end;
           if (jogador1=jogador3) and (aux3<>0) then
              begin
                   write('O nome do 1ßjogador Ç igual ao do 3ßjogador');
                   ja_inscritos:=false;
                   while keypressed do c:=readkey;c:=readkey;
              end;
           fim:
     until (c='A');
     inic_graficos;
end;

function poder:integer;       { Define o poder que Ç dado a cada dado. }
var y:integer;
begin
     i:=0;y:=0;
     settextstyle(2,0,6);setcolor(white);
     outtextxy(4,400,'Prima a tecla de ØBackSpaceÆ para dar foráa aos dados.');
     outtextxy(4,420,'Quando escolher a foráa prima ØEnterÆ.');
     setcolor(darkgray);outtextxy(0,440,'ƒƒƒƒƒƒƒƒƒƒ ');
     if jogador='CPU' then begin
                                randomize;
                                i:=10;i:=random(i)+1;
                                for i2:=1 to i do
                                begin
                                     setcolor(white);
                                     outtextxy((i2-1)*10,440,'ƒ');
                                     delay(500);
                                end;
                                if i=1 then poder:=1
                                       else poder:=i;
                           end
     else begin
               repeat
                     while keypressed do opcao:=readkey;c:=readkey;
                     if c=chr(27) then sair;
                     if c=#32 then
                        begin
                             i:=i+1;
                             for i2:=1 to i do
                             begin
                                  setcolor(white);
                                  outtextxy((i2-1)*10,440,'ƒ');
                             end;
                             if i>10 then
                                begin
                                     i:=0;
                                     setcolor(black);outtextxy(0,440,'ƒƒƒƒƒƒƒƒƒƒƒ ');
                                     setcolor(darkgray);outtextxy(0,440,'ƒƒƒƒƒƒƒƒƒƒ ');
                                end;
                        end;
               until (c=#13) or (c=#27);
               if i=0 then i:=1;
               poder:=i;
          end;
     settextstyle(2,0,6);setcolor(black);
     outtextxy(4,400,'Prima a tecla de ØBackSpaceÆ para dar foráa aos dados.');
     outtextxy(4,420,'Quando escolher a foráa prima ØEnterÆ.');
     outtextxy(0,440,'ƒƒƒƒƒƒƒƒƒƒ ');
end;

procedure numeros_dados;      { Faz "rodar" os dados. }
begin
     i2:=poder;randomize;
     for i:=1 to 10 do
     begin
          dado1[i]:=0;
          dado2[i]:=0;
     end;
     for i:=1 to i2 do dado1[i]:=(random(6)+1); { Um n£mero ao acaso para o 1ßDado }
     for i:=1 to i2 do dado2[i]:=(random(6)+1); { Um n£mero ao acaso para o 2ßDado }
end;

procedure virar_letra(pos:integer);  { Vira a letra escolhida, se existir. }
begin
     settextstyle(2,0,6);setcolor(black);
     outtextxy((pos*12)+2,6,escolhida.palavra[pos]);
end;

procedure ecra_tema;  { Escreve no Çcran o tema respectivo da palavra chave. }
begin
     settextstyle(1,0,2);
     setcolor(green);outtextxy(520,440,'Esc - Sair');
     setcolor(white);
     for i:=1 to (escolhida.n_letras+escolhida.espacos) do
     begin
          if escolhida.palavra[i]=' ' then outtextxy((12*i),3,' ')
                                      else outtextxy((12*i),3,'€');
     end;
     settextstyle(1,0,1);
     setcolor(lightred);outtextxy(0,140,'TEMA : '+escolhida.tema+'');
     settextstyle(1,0,2);
     num2:=escolhida.n_letras;
     num:=escolhida.n_letras+escolhida.espacos;
end;

procedure procura_letra;   { Procura na palavra chave uma letra introduzida }
var i3:integer;            { pelo jogador. }
begin
     letras_encontradas:=0;
     for i:=1 to num+escolhida.espacos do
     begin
          if escolhida.palavra[i]=letra then
             begin
                  letras_encontradas:=letras_encontradas+1;
                  letras:=letras+1;
                  escolhida.n_letras:=pred(escolhida.n_letras);
                  i3:=500;
                  sound(50+i3);delay(200);
                  virar_letra(i);nosound;
             end;
     end;
     if letras_encontradas=0 then
        begin
             setcolor(white);
             sound(1000);delay(50);
             outtextxy(4,350,'NÑo existe nenhum '+letra+' na palavra !');
             nosound;delay(1000);sound(500);delay(175);
             outtextxy(4,380,'Perdeu a vez . . .');
             letras:=letras+1;
             nosound;
             if jogador='CPU' then delay(2500)
             else begin
                       outtextxy(10,440,'Prima uma tecla para continuar.');
                       while keypressed do opcao:=readkey;opcao:=readkey;
                       if opcao=chr(27) then sair;
                  end;
             setcolor(black);
             outtextxy(4,350,'NÑo existe nenhum '+letra+' na palavra !');
             outtextxy(4,380,'Perdeu a vez . . .');
             outtextxy(10,440,'Prima uma tecla para continuar.');
        end
     else
         begin
              str(letras_encontradas,st);setcolor(white);
              outtextxy(4,380,'Existe '+st+' '+letra+' na palavra !');
              if jogador='CPU' then delay(2500)
                               else begin
                                         outtextxy(10,440,'Prima uma tecla para continuar.');
                                         while keypressed do opcao:=readkey;opcao:=readkey;
                                         if opcao=chr(27) then sair;
                                    end;
              setcolor(black);
              outtextxy(4,380,'Existe '+st+' '+letra+' na palavra !');
              outtextxy(10,440,'Prima uma tecla para continuar.');
              settextstyle(1,0,3);setcolor(lightgray);
              if jogador=jogador1 then begin
                                            str(pontuacao1,st);
                                            outtextxy(535,10,+st);
                                       end;
              if jogador=jogador2 then begin
                                            str(pontuacao2,st);
                                            outtextxy(535,55,+st);
                                       end;
              if jogador=jogador3 then begin
                                            str(pontuacao3,st);
                                            outtextxy(535,100,+st);
                                       end;
              if jogador='CPU' then begin
                                         str(pont_cpu,st);
                                         outtextxy(535,55,+st);
                                    end;
              settextstyle(2,0,6);
         end;
end;

procedure nao_pode;
begin
     sound(1000);delay(100);
     outtextxy(0,350,'NÑo pode apagar !!');
     nosound;delay(1500);
     setcolor(black);outtextxy(0,350,'NÑo pode apagar !!');
     setcolor(white);
     while keypressed do c:=readkey;
end;

procedure adivinhar; { FunáÑo feita, para caso o jogador j† ter adivinhado a }
label 02;            { palavra escondida a poder adivinhar, sendo a sua pon- }
var l:integer;       { tuaáÑo dada pelo nß de letras que a palavra tem, vezes}
begin                { o n£mero dado pelos dados                             }
     settextstyle(1,0,1);setcolor(white);
     outtextxy(0,400,'Escreva correctamente a(s) palavra(s): ');
     adiv:='';
     for i:=1 to num do adiv:=adiv+' ';
     x:=350;i:=1;l:=0;
     repeat
           c:=readkey;c:=upcase(c);
           if (c=chr(27)) or (c=chr(13)) then goto 02;
           if (c=chr(8)) then nao_pode
                         else begin
                                   adiv[i]:=c;
                                   inc(i);inc(l);
                                   outtextxy(x,400,c);
                                   x:=x+11;
                              end;
           02:
     until ((c=chr(13)) or (c=chr(44)) or (c=chr(27)) or (l=num));
     setcolor(black);
     outtextxy(0,400,'Escreva correctamente a(s) palavra(s): ');
     for i:=350 to 380 do outtextxy(i,400,adiv);
end;

procedure palpite;   { Là o palpite do jogador e a respectiva pontuáÑo. }
label 01,02,03;
var tot:integer;
begin
     i2:=1;
     while (dado1[i2]<>0) and (i2<>10) do i2:=i2+1;
     tot:=(dado1[i2-1]+dado2[i2-1]);
     i:=1;
     settextstyle(1,0,1);setcolor(lightblue);
     outtextxy(0,180,'Ctrl+A - Adivinhar');outtextxy(90,200,'Palavra(s)');
     str(tot,st);settextstyle(2,0,6);
     setcolor(white);outtextxy(4,300,'Insira uma letra por '+st+' pontos :');
     while keypressed do letra:=readkey;letra:=readkey;letra:=upcase(letra);
     setcolor(black);outtextxy(4,300,'Insira uma letra por '+st+' pontos :');
     settextstyle(1,0,1);setcolor(black);
     outtextxy(0,180,'Ctrl+A - Adivinhar');outtextxy(90,200,'Palavra(s)');
     settextstyle(2,0,6);
     if letra=^A then begin
                           adivinhar;
                           if escolhida.palavra=adiv then
                              begin
                                   for i:=1 to num do
                                   begin
                                        if escolhida.palavra[i]=escolhida.palavra[i] then
                                           begin
                                                i3:=500;
                                                sound(50+i3);delay(200);
                                                virar_letra(i);nosound;
                                           end;
                                   end;
                                   if (escolhida.n_letras>escolhida.n_vogais) then
                                      begin
                                           tot:=tot*num2;
                                           setcolor(white);
                                           outtextxy(4,280,'A pontuaáÑo Ç vezes o nß de letras');
                                      end;
                                      escolhida.n_letras:=0;
                                      settextstyle(1,0,3);setcolor(lightgray);
                                      if jogador=jogador1 then
                                         begin
                                              str(pontuacao1,st);outtextxy(535,10,+st);
                                         end;
                                      if jogador=jogador2 then
                                         begin
                                              str(pontuacao2,st);outtextxy(535,55,+st);
                                         end;
                                      if jogador=jogador3 then
                                         begin
                                              str(pontuacao3,st);outtextxy(535,100,+st);
                                         end;
                                      if jogador='CPU' then
                                         begin
                                              str(pont_cpu,st);outtextxy(535,55,+st);
                                         end;
                                         settextstyle(2,0,6);
                                         goto 03;
                              end
                           else if (escolhida.palavra<>adiv) or (c=chr(13)) then
                                begin
                                     sound(50);
                                     setcolor(white);outtextxy(0,350,'Est† incorrecto.');
                                     outtextxy(10,440,'Prima uma tecla para continuar.');
                                     delay(100);nosound;
                                     while keypressed do opcao:=readkey;opcao:=readkey;
                                     if opcao=chr(27) then sair;
                                     setcolor(black);outtextxy(0,350,'Est† incorrecto.');
                                     sound(500);delay(175);
                                     setcolor(white);outtextxy(4,330,'Perdeu a vez . . .');
                                     nosound;
                                     while keypressed do opcao:=readkey;opcao:=readkey;
                                     if opcao=chr(27) then sair;
                                     setcolor(black);outtextxy(4,330,'Perdeu a vez . . .');
                                     outtextxy(10,440,'Prima uma tecla para continuar.');
                                     letras_encontradas:=0;
                                     goto 02;
                                end;
                      end;
     if (letra=chr(27)) then begin
                                  quit:=true;exit;
                             end;
     if letra in['1','2','3','4','5','6','7','8','9','0'] then
        begin
             settextstyle(2,0,6);setcolor(white);
             outtextxy(1,320,'Escolha apenas letras e nÑo n£meros.');
             delay(1000);sound(500);delay(175);
             outtextxy(1,360,'Perdeu a vez.');
             nosound;
             outtextxy(10,440,'Prima uma tecla para continuar.');
             while keypressed do c:=readkey;c:=readkey;c:=upcase(c);
             if c=chr(27) then sair;
             setcolor(black);
             outtextxy(1,320,'Escolha apenas letras e nÑo n£meros.');
             outtextxy(1,360,'Perdeu a vez.');
             outtextxy(10,440,'Prima uma tecla para continuar.');
             letras_encontradas:=0;
             goto 02;
        end;
     if (letra=chr(32)) or (letra=chr(13)) then
        begin
             settextstyle(2,0,6);setcolor(white);
             if letra=chr(32) then outtextxy(1,300,'A tecla premida foi o BackSpace.');
             if letra=chr(13) then outtextxy(1,300,'A tecla premida foi o Enter.');
             outtextxy(1,320,'Escolha apenas letras.');
             delay(1000);sound(500);delay(175);
             outtextxy(1,360,'Perdeu a vez.');
             nosound;
             outtextxy(10,440,'Prima uma tecla para continuar.');
             while keypressed do c:=readkey;c:=readkey;c:=upcase(c);
             if c=chr(27) then sair;
             setcolor(black);
             if letra=chr(32) then outtextxy(1,300,'A tecla premida foi o BackSpace.');
             if letra=chr(13) then outtextxy(1,300,'A tecla premida foi o Enter.');
             outtextxy(1,320,'Escolha apenas letras.');
             outtextxy(1,360,'Perdeu a vez.');
             outtextxy(10,440,'Prima uma tecla para continuar.');
             letras_encontradas:=0;
             goto 02;
        end;
     i3:=1;
     while (i3<=26) do
     begin
          if (abcedario[i3].letra=letra) then
             begin
                  if (abcedario[i3].flag=false) then
                     begin
                          letras_encontradas:=0;
                          setcolor(white);
                          outtextxy(4,300,'A letra '+letra+' j† foi escolhida .');
                          delay(1000);
                          sound(500);delay(175);
                          setcolor(white);outtextxy(4,330,'Perdeu a vez . . .');
                          nosound;
                          outtextxy(10,440,'Prima uma tecla para continuar.');
                          while keypressed do opcao:=readkey;opcao:=readkey;
                          if opcao=chr(27) then sair;
                          setcolor(black);
                          outtextxy(4,300,'A letra '+letra+' j† foi escolhida .');
                          outtextxy(4,330,'Perdeu a vez . . .');
                          outtextxy(10,440,'Prima uma tecla para continuar.');
                          exit;
                     end
                  else begin
                            abcedario[i3].flag:=false;
                            mudar_letra;
                       end;
                  goto 01;
             end
          else i3:=i3+1;
     end;
     01:
     if (letra in['A','E','I','O','U']) and (escolhida.n_letras>escolhida.n_vogais) then
        begin
             settextstyle(2,0,6);setcolor(white);
             outtextxy(610,15,'A');outtextxy(610,75,'E');
             outtextxy(610,135,'I');outtextxy(610,225,'O');
             outtextxy(610,315,'U');
             abcedario[i3].flag:=true;
             sound(200);delay(300);
             letras_encontradas:=0;
             setcolor(white);
             outtextxy(4,300,''++jogador++',a letra '+letra+' Ç uma vogal,');
             outtextxy(4,330,'e ainda existem consoantes na palavra .');
             nosound;delay(1000);sound(500);delay(175);
             outtextxy(4,360,'Perdeu a vez . . .');
             nosound;
             outtextxy(10,440,'Prima uma tecla para continuar.');
             while keypressed do opcao:=readkey;opcao:=readkey;
             if opcao=chr(27) then sair;
             setcolor(black);
             outtextxy(4,300,''++jogador++',a letra '+letra+' Ç uma vogal,');
             outtextxy(4,330,'e ainda existem consoantes na palavra .');
             outtextxy(4,360,'Perdeu a vez . . .');
             outtextxy(10,440,'Prima uma tecla para continuar.');
        end
     else procura_letra;
     if (escolhida.n_letras=escolhida.n_vogais) and (diz_mensagem1) then
        begin
             setcolor(white);
             outtextxy(4,300,'ATENÄéO : Acabaram-se as consoantes !');
             delay(1000);
             outtextxy(4,330,'Mas o Cuco nÑo tocou . . .');
             diz_mensagem1:=false;
             while keypressed do opcao:=readkey;opcao:=readkey;
             if opcao=chr(27) then sair;
             setcolor(black);
             outtextxy(4,300,'ATENÄéO : Acabaram-se as consoantes !');
             outtextxy(4,330,'Mas o Cuco nÑo tocou . . .');
        end;
     tot:=tot*letras_encontradas;
     03:
     if (jogador=jogador1) and (tot<>0) then
        begin
             pontuacao1:=pontuacao1+tot;
             setcolor(white);str(tot,st);
             outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
             str(pontuacao1,st);
             outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
             outtextxy(4,340,'ParabÇns '+jogador+' . . .');
             outtextxy(10,440,'Prima uma tecla para continuar.');
             settextstyle(1,0,3);
             setcolor(lightblue);str(pontuacao1,st);outtextxy(535,10,+st);
             while keypressed do opcao:=readkey;opcao:=readkey;
             if opcao=chr(27) then sair;
             settextstyle(2,0,6);setcolor(black);
             outtextxy(4,280,'A pontuaáÑo Ç vezes o nß de letras');
             str(tot,st);
             outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
             str(pontuacao1,st);
             outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
             outtextxy(4,340,'ParabÇns '+jogador+' . . .');
             outtextxy(10,440,'Prima uma tecla para continuar.');
        end
     else if (jogador=jogador2) and (tot<>0) then
          begin
               pontuacao2:=pontuacao2+tot;
               setcolor(white);str(tot,st);
               outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
               str(pontuacao2,st);
               outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
               outtextxy(4,340,'ParabÇns '+jogador+' . . .');
               outtextxy(10,440,'Prima uma tecla para continuar.');
               settextstyle(1,0,3);
               setcolor(lightblue);str(pontuacao2,st);outtextxy(535,55,+st);
               while keypressed do opcao:=readkey;opcao:=readkey;
               if opcao=chr(27) then sair;
               settextstyle(2,0,6);setcolor(black);
               outtextxy(4,280,'A pontuaáÑo Ç vezes o nß de letras');
               str(tot,st);
               outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
               str(pontuacao2,st);
               outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
               outtextxy(4,340,'ParabÇns '+jogador+' . . .');
               outtextxy(10,440,'Prima uma tecla para continuar.');
          end
     else if (jogador=jogador3) and (tot<>0) then
          begin
               pontuacao3:=pontuacao3+tot;
               setcolor(white);str(tot,st);
               outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
               str(pontuacao3,st);
               outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
               outtextxy(4,340,'ParabÇns '+jogador+' . . .');
               outtextxy(10,440,'Prima uma tecla para continuar.');
               settextstyle(1,0,3);
               setcolor(lightblue);str(pontuacao3,st);outtextxy(535,100,+st);
               while keypressed do opcao:=readkey;opcao:=readkey;
               if opcao=chr(27) then sair;
               settextstyle(2,0,6);setcolor(black);
               outtextxy(4,280,'A pontuaáÑo Ç vezes o nß de letras');
               str(tot,st);
               outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
               str(pontuacao3,st);
               outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
               outtextxy(4,340,'ParabÇns '+jogador+' . . .');
               outtextxy(10,440,'Prima uma tecla para continuar.');
          end;
     02:
end;

procedure verificar;  { Verifica se a letra introduzida existe no Abced†rio }
begin
     for i3:=1 to 26 do
         if (i3=i3) then abcedario[i3].letra:=chr(64+i3);
end;

procedure palpite_cpu;  { Palpite do Computador e o respectivo resultado }
label 01,02;
var tot:integer;
begin
     i2:=1;
     while (dado1[i2]<>0) and (i2<>10) do i2:=i2+1;
     tot:=(dado1[i2-1]+dado2[i2-1]);
     i:=1;str(tot,st);
     setcolor(white);outtextxy(4,300,'Insira uma letra por '+st+' pontos :');
     delay(2500);
     02:verificar;
     i3:=random(i3);letra:=abcedario[i3].letra;
     if abcedario[i3].letra='#13' then abcedario[i3].flag:=false;
     setcolor(black);outtextxy(4,300,'Insira uma letra por '+st+' pontos :');
     if letra=#27 then sair;
     i3:=1;
     while (i3<=26) do
     begin
          if (abcedario[i3].letra=letra) then
             begin
                  if (abcedario[i3].flag=false) then
                     begin
                          letras_encontradas:=0;
                          goto 02;
                     end
                  else begin
                            if letra=' ' then begin
                                                   abcedario[i3].flag:=false;
                                                   goto 02;
                                              end;
                            if ((letra<>'A') and (letra<>'E') and (letra<>'I') and (letra<>'O') and (letra<>'U')) and
                               (escolhida.n_letras<=escolhida.n_vogais) then goto 02;
                            abcedario[i3].flag:=false;
                            mudar_letra;
                       end;
                  goto 01;
             end
          else i3:=i3+1;
     end;
     01:
     if (letra in['A','E','I','O','U']) and (escolhida.n_letras>escolhida.n_vogais) then
        begin
             letras_encontradas:=0;
             abcedario[i3].flag:=true;
             settextstyle(2,0,6);setcolor(white);
             outtextxy(610, 15,'A');outtextxy(610, 75,'E');
             outtextxy(610,135,'I');outtextxy(610,225,'O');
             outtextxy(610,315,'U');
             goto 02;
        end
     else procura_letra;
     if (escolhida.n_letras=escolhida.n_vogais) and (diz_mensagem1) then
        begin
             setcolor(white);
             outtextxy(4,300,'ATENÄéO : Acabaram-se as consoantes !');
             delay(1000);
             outtextxy(4,330,'Mas o Cuco nÑo tocou . . .');
             diz_mensagem1:=false;
             delay(2500);setcolor(black);
             outtextxy(4,300,'ATENÄéO : Acabaram-se as consoantes !');
             outtextxy(4,330,'Mas o Cuco nÑo tocou . . .');
        end;
     tot:=tot*letras_encontradas;
     if (jogador='CPU') and (tot<>0) then
        begin
             pont_cpu:=pont_cpu+tot;
             setcolor(white);str(tot,st);
             outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
             str(pont_cpu,st);
             outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
             outtextxy(4,340,'ParabÇns Cpu . . .');
             settextstyle(1,0,3);
             setcolor(lightblue);str(pont_cpu,st);outtextxy(535,55,+st);
             delay(2500);
             settextstyle(2,0,6);
             setcolor(black);str(tot,st);
             outtextxy(4,300,'Vocà acaba de somar '+st+' pontos.');
             str(pont_cpu,st);
             outtextxy(4,320,'Fica agora com um total de '+st+' pontos');
             outtextxy(4,340,'ParabÇns Cpu . . .');
        end;
end;

procedure condicao_preta_1;   { Escreve os pontos no primeiro dado }
begin
     sound(500);delay(10);
     setcolor(black);
     if (dado1[i]=1) then
        begin
             circle(254,211,3);setfillstyle(1,black);floodfill(255,212,black);
        end;
     if (dado1[i]=2) then
        begin
             circle(245,201,3);setfillstyle(1,black);floodfill(246,202,black);
             circle(262,221,3);setfillstyle(1,black);floodfill(263,222,black);
        end;
     if (dado1[i]=3) then
        begin
             circle(245,201,3);setfillstyle(1,black);floodfill(246,202,black);
             circle(254,211,3);setfillstyle(1,black);floodfill(255,212,black);
             circle(262,221,3);setfillstyle(1,black);floodfill(263,222,black);
        end;
     if (dado1[i]=4) then
        begin
             circle(245,201,3);setfillstyle(1,black);floodfill(246,202,black);
             circle(262,201,3);setfillstyle(1,black);floodfill(263,202,black);
             circle(245,221,3);setfillstyle(1,black);floodfill(246,222,black);
             circle(262,221,3);setfillstyle(1,black);floodfill(263,222,black);
        end;
     if (dado1[i]=5) then
        begin
             circle(245,201,3);setfillstyle(1,black);floodfill(246,202,black);
             circle(262,201,3);setfillstyle(1,black);floodfill(263,202,black);
             circle(245,221,3);setfillstyle(1,black);floodfill(246,222,black);
             circle(262,221,3);setfillstyle(1,black);floodfill(263,222,black);
             circle(254,211,3);setfillstyle(1,black);floodfill(255,212,black);
        end;
     if (dado1[i]=6) then
        begin
             circle(245,201,3);setfillstyle(1,black);floodfill(246,202,black);
             circle(262,201,3);setfillstyle(1,black);floodfill(263,202,black);
             circle(245,221,3);setfillstyle(1,black);floodfill(246,222,black);
             circle(262,221,3);setfillstyle(1,black);floodfill(263,222,black);
             circle(245,211,3);setfillstyle(1,black);floodfill(246,212,black);
             circle(262,211,3);setfillstyle(1,black);floodfill(263,212,black);
        end;
     nosound;
end;

procedure condicao_branca_1;  { Apaga os pontos no primeiro dado }
begin
     setcolor(lightmagenta);
     rectangle(232,185,275,235);
     rectangle(235,188,272,232);
     setfillstyle(1,white);floodfill(240,190,lightmagenta);
     setcolor(lightmagenta);
     rectangle(290,185,333,235);
     rectangle(293,188,330,232);
     setfillstyle(1,white);floodfill(294,189,lightmagenta);
     setcolor(white);
     circle(254,211,3);setfillstyle(1,white);floodfill(255,212,white);
     circle(245,201,3);setfillstyle(1,white);floodfill(246,202,white);
     circle(262,221,3);setfillstyle(1,white);floodfill(263,222,white);
     circle(245,201,3);setfillstyle(1,white);floodfill(246,202,white);
     circle(254,211,3);setfillstyle(1,white);floodfill(255,212,white);
     circle(262,221,3);setfillstyle(1,white);floodfill(263,222,white);
     circle(245,201,3);setfillstyle(1,white);floodfill(246,202,white);
     circle(262,201,3);setfillstyle(1,white);floodfill(263,202,white);
     circle(245,221,3);setfillstyle(1,white);floodfill(246,222,white);
     circle(262,221,3);setfillstyle(1,white);floodfill(263,222,white);
     circle(245,201,3);setfillstyle(1,white);floodfill(246,202,white);
     circle(262,201,3);setfillstyle(1,white);floodfill(263,202,white);
     circle(245,221,3);setfillstyle(1,white);floodfill(246,222,white);
     circle(262,221,3);setfillstyle(1,white);floodfill(263,222,white);
     circle(254,211,3);setfillstyle(1,white);floodfill(255,212,white);
     circle(245,201,3);setfillstyle(1,white);floodfill(246,202,white);
     circle(262,201,3);setfillstyle(1,white);floodfill(263,202,white);
     circle(245,221,3);setfillstyle(1,white);floodfill(246,222,white);
     circle(262,221,3);setfillstyle(1,white);floodfill(263,222,white);
     circle(245,211,3);setfillstyle(1,white);floodfill(246,212,white);
     circle(262,211,3);setfillstyle(1,white);floodfill(263,212,white);
end;

procedure condicao_preta_2;  { Escreve os pontos no segundo dado }
begin
     sound(500);
     delay(10);
     setcolor(black);
     if (dado2[i]=1) then
        begin
             circle(312,211,3);setfillstyle(1,black);floodfill(313,212,black);
        end;
     if (dado2[i]=2) then
        begin
             circle(303,201,3);setfillstyle(1,black);floodfill(304,202,black);
             circle(320,221,3);setfillstyle(1,black);floodfill(321,222,black);
        end;
     if (dado2[i]=3) then
        begin
             circle(303,201,3);setfillstyle(1,black);floodfill(304,202,black);
             circle(312,211,3);setfillstyle(1,black);floodfill(313,212,black);
             circle(320,221,3);setfillstyle(1,black);floodfill(321,222,black);
        end;
     if (dado2[i]=4) then
        begin
             circle(303,201,3);setfillstyle(1,black);floodfill(304,202,black);
             circle(320,201,3);setfillstyle(1,black);floodfill(321,202,black);
             circle(303,221,3);setfillstyle(1,black);floodfill(304,222,black);
             circle(320,221,3);setfillstyle(1,black);floodfill(321,222,black);
        end;
     if (dado2[i]=5) then
        begin
             circle(303,201,3);setfillstyle(1,black);floodfill(304,202,black);
             circle(320,201,3);setfillstyle(1,black);floodfill(321,202,black);
             circle(303,221,3);setfillstyle(1,black);floodfill(304,222,black);
             circle(320,221,3);setfillstyle(1,black);floodfill(321,222,black);
             circle(312,211,3);setfillstyle(1,black);floodfill(313,212,black);
        end;
     if (dado2[i]=6) then
        begin
             circle(303,201,3);setfillstyle(1,black);floodfill(304,202,black);
             circle(320,201,3);setfillstyle(1,black);floodfill(321,202,black);
             circle(303,221,3);setfillstyle(1,black);floodfill(304,222,black);
             circle(320,221,3);setfillstyle(1,black);floodfill(321,222,black);
             circle(303,211,3);setfillstyle(1,black);floodfill(304,212,black);
             circle(320,211,3);setfillstyle(1,black);floodfill(321,212,black);
        end;
     nosound;
end;

procedure condicao_branca_2;  { Apaga os pontos no segundo dado }
begin
     setcolor(white);
     circle(312,211,3);setfillstyle(1,white);floodfill(313,212,white);
     circle(303,201,3);setfillstyle(1,white);floodfill(304,202,white);
     circle(320,221,3);setfillstyle(1,white);floodfill(321,222,white);
     circle(303,201,3);setfillstyle(1,white);floodfill(304,202,white);
     circle(312,211,3);setfillstyle(1,white);floodfill(313,212,white);
     circle(320,221,3);setfillstyle(1,white);floodfill(321,222,white);
     circle(303,201,3);setfillstyle(1,white);floodfill(304,202,white);
     circle(320,201,3);setfillstyle(1,white);floodfill(321,202,white);
     circle(303,221,3);setfillstyle(1,white);floodfill(304,222,white);
     circle(320,221,3);setfillstyle(1,white);floodfill(321,222,white);
     circle(303,201,3);setfillstyle(1,white);floodfill(304,202,white);
     circle(320,201,3);setfillstyle(1,white);floodfill(321,202,white);
     circle(303,221,3);setfillstyle(1,white);floodfill(304,222,white);
     circle(320,221,3);setfillstyle(1,white);floodfill(321,222,white);
     circle(312,211,3);setfillstyle(1,white);floodfill(313,212,white);
     circle(303,201,3);setfillstyle(1,white);floodfill(304,202,white);
     circle(320,201,3);setfillstyle(1,white);floodfill(321,202,white);
     circle(303,221,3);setfillstyle(1,white);floodfill(304,222,white);
     circle(320,221,3);setfillstyle(1,white);floodfill(321,222,white);
     circle(303,211,3);setfillstyle(1,white);floodfill(304,212,white);
     circle(320,211,3);setfillstyle(1,white);floodfill(321,212,white);
end;

procedure mostra_dados;  { Mostra o resultado final dos dois dados }
begin
     settextstyle(2,0,6);
     i:=1;i2:=500;
     while (dado1[i]<>0) and (i<10) do
     begin
          condicao_branca_1;condicao_preta_1;
          delay(50+i2);
          i2:=i2-50;i:=i+1;
     end;
     i:=1;i2:=500;
     while (dado2[i]<>0) and (i<10) do
     begin
          condicao_branca_2;condicao_preta_2;
          delay(50+i2);
          i2:=i2-50;i:=i+1;
     end;
end;

procedure jogador1_a_jogar;  { Verifica se Ç o primeiro jogador a jogar }
begin
     jogador:=jogador1;setcolor(darkgray);
     rectangle(246,3,582,47);rectangle(250,7,578,43);
     setfillstyle(1,white);floodfill(247,6,darkgray);
     setfillstyle(1,lightgray);floodfill(251,8,darkgray);
     rectangle(525,7,525,43);rectangle(528,7,528,43);
     setfillstyle(1,white);floodfill(526,8,darkgray);
     if aux2<>0 then
        begin
             setcolor(darkgray);
             rectangle(246,48,582,92);rectangle(250,52,578,88);
             setfillstyle(1,white);floodfill(247,49,darkgray);
             setfillstyle(1,lightgray);floodfill(251,53,darkgray);
             setcolor(darkgray);
             rectangle(525,52,525,88);rectangle(528,52,528,88);
             setfillstyle(1,white);floodfill(526,53,darkgray);
        end;
     if aux3<>0 then
        begin
             setcolor(darkgray);
             rectangle(246,93,582,137);rectangle(250,97,578,133);
             setfillstyle(1,white);floodfill(247,94,darkgray);
             setfillstyle(1,lightgray);floodfill(251,98,darkgray);
             setcolor(darkgray);
             rectangle(525,97,525,133);rectangle(528,97,528,133);
             setfillstyle(1,white);floodfill(526,98,darkgray);
        end;
     settextstyle(1,0,3);setcolor(lightblue);
     outtextxy(255,10,'JOGADOR : '+jogador1);
     settextstyle(1,0,3);setcolor(darkgray);
     if aux2<>0 then outtextxy(255,55,'JOGADOR : '+jogador2);
     if aux3<>0 then outtextxy(255,100,'JOGADOR : '+jogador3);
     if aux_cpu<>0 then
        begin
             setcolor(darkgray);
             rectangle(246,48,582,92);rectangle(250,52,578,88);
             setfillstyle(1,white);floodfill(247,49,darkgray);
             setfillstyle(1,lightgray);floodfill(251,53,darkgray);
             setcolor(darkgray);
             rectangle(525,52,525,88);rectangle(528,52,528,88);
             setfillstyle(1,white);floodfill(526,53,darkgray);
             settextstyle(1,0,3);setcolor(darkgray);
             outtextxy(255,55,'JOGADOR : CPU');
        end;
end;

procedure jogador2_a_jogar;  { Verifica se Ç o segundo jogador a jogar }
begin
     if (aux2<>0) and (aux_cpu=0) then
        begin
             settextstyle(1,0,3);setcolor(lightgray);
             outtextxy(255,55,'JOGADOR : '+jogador2);
             settextstyle(1,0,3);setcolor(lightgray);
             outtextxy(255,10,'JOGADOR : '+jogador1);
             settextstyle(1,0,3);setcolor(darkgray);
             outtextxy(255,10,'JOGADOR : '+jogador1);
             jogador:=jogador2;
             settextstyle(1,0,3);setcolor(lightblue);
             outtextxy(255,55,'JOGADOR : '+jogador2);
        end;
end;

procedure jogador3_a_jogar;  { Verifica se Ç o terceiro jogador a jogar }
begin
     if aux3<>0 then
        begin
             settextstyle(1,0,3);setcolor(lightgray);
             outtextxy(255,100,'JOGADOR : '+jogador3);
             settextstyle(1,0,3);setcolor(darkgray);
             outtextxy(255,55,'JOGADOR : '+jogador2);
             jogador:=jogador3;
             settextstyle(1,0,3);setcolor(lightblue);
             outtextxy(255,100,'JOGADOR : '+jogador3);
        end;
end;

procedure jogar_cpu;  { Verifica se Ç o computador a jogar }
begin
     jogador:='CPU';
     settextstyle(1,0,3);setcolor(lightgray);
     outtextxy(255,10,'JOGADOR : '+jogador1);
     settextstyle(1,0,3);setcolor(darkgray);
     outtextxy(255,10,'JOGADOR : '+jogador1);
     settextstyle(1,0,3);setcolor(lightgray);
     outtextxy(255,55,'JOGADOR : CPU');
     settextstyle(1,0,3);setcolor(lightblue);
     outtextxy(255,55,'JOGADOR : CPU');
end;

procedure jogadas;     { Jogadas feitas por todos os jogadores }
label acabou,fim,03,04;
var v,n_jogadas,tot:integer;
    st1,st2,st3:string;
begin
     cleardevice;
     if ja_inscritos=false then
        begin
             settextstyle(1,0,1);setcolor(white);
             outtextxy(0,10,'Por favor, ');
             outtextxy(20,50,'Antes de jogar dirija-se Ös inscriáîes mais o seu parceiro. . .');
             mensagem;
        end
     else if (ntpal=0) then
          begin
               settextstyle(1,0,1);setcolor(white);
               outtextxy(0,0,'NÑo exitem palavras no ficheiro para jogar . . .');
               mensagem;
          end
     else
         begin
              cleardevice;
              escolhe_pal;    { Escolhe palavra do ficheiro para se jogar }
              ecra_tema;      { Escreve o tema da respectiva palavra      }
              quit:=false;diz_mensagem1:=true;
              n_jogadas:=1;
              letras:=0;      { Letras pedidas=0 }
              pontuacao1:=0;pontuacao2:=0;pontuacao3:=0;pont_cpu:=0;
              jogador:=jogador1;
              inic_abcedario;     { Inicia a tabela do Abced†rio }
              escreve_abcedario;  { Escreve no Çcran o Abced†rio }
              jogador1_a_jogar;
              repeat
                    if (aux_cpu<>0) and (jogador='CPU') then
                       begin
                            condicao_branca_1;condicao_branca_2;
                            numeros_dados;mostra_dados;palpite_cpu;
                       end
                    else begin
                              condicao_branca_1;condicao_branca_2;
                              numeros_dados;
                              if c<>chr(27) then begin
                                                      mostra_dados;
                                                      palpite;
                                                 end
                              else quit:=true;
                         end;
                    if (letras>60) then { Caso o n£mero de letras pedidas for}
                       begin            { superior a 60 o jogo acaba, isto Ç,}
                            v:=0;       { toca o "Cuco", e a sua pontuaáÑo Ç }
                            repeat      { a obtida atÇ ao momento            }
                                  sound(3000);delay(300);
                                  sound(2000);delay(200);
                                  sound(1000);delay(100);
                                  sound(100);delay(100);
                                  sound(50);delay(100);
                                  v:=v+1;
                            until v=3;
                            settextstyle(1,0,2);setcolor(black);
                            outtextxy(520,440,'Esc - Sair');
                            nosound;
                            setcolor(white);
                            outtextxy(4,300,'O Cuco j† tocou . . .');
                            outtextxy(4,330,'E voáàs nÑo adivinharam a palavra.');
                            outtextxy(4,360,'A palavra era : '+escolhida.palavra);
                            for i:=1 to num do
                            begin
                                 if escolhida.palavra[i]=escolhida.palavra[i] then
                                    begin
                                         i3:=500;virar_letra(i);
                                    end;
                            end;
                            while keypressed do opcao:=readkey;opcao:=readkey;
                            goto acabou;
                       end;
                    if quit=true then goto fim;
                    if (letras_encontradas=0) and (jogador=jogador1) then
                       begin
                            if (aux2=0) and (aux_cpu<>0) then goto 03
                               else begin
                                         jogador2_a_jogar;goto 04;
                                         if aux3=0 then goto 03;
                                    end;
                            goto 03;
                       end
                    else if (letras_encontradas=0) and (jogador=jogador2) then
                         begin
                              if aux3=0 then goto 03
                                        else begin
                                                  jogador3_a_jogar;goto 04;
                                             end;
                              goto 03;
                         end
                    else if (letras_encontradas=0) and (jogador='CPU') then
                            jogador1_a_jogar
                    else if (letras_encontradas=0) and (jogador=jogador3) then
                         begin
                              03:
                              if aux_cpu<>0 then begin
                                                      jogar_cpu;goto 04;
                                                 end;
                              jogador1_a_jogar;
                         end;
                    04:
                    if (escolhida.n_letras=0) then
                       begin
                            settextstyle(1,0,2);setcolor(black);
                            outtextxy(520,440,'Esc - Sair');
                            sound(300);delay(300);
                            settextstyle(2,0,6);setcolor(white);
                            outtextxy(4,350,'Muito bem acaba de adivinhar a palavra...');
                            outtextxy(4,370,' ParabÇns, a palavra era '+escolhida.palavra);
                            nosound;
                            outtextxy(10,440,'Prima uma tecla para continuar.');
                            while keypressed do opcao:=readkey;opcao:=readkey;
                            if opcao=chr(27) then sair;
                            settextstyle(2,0,6);setcolor(black);
                            outtextxy(4,350,'Muito bem acaba de adivinhar a palavra...');
                            outtextxy(4,370,' ParabÇns, a palavra era '+escolhida.palavra);
                            outtextxy(10,440,'Prima uma tecla para continuar.');
                            if n_jogadas=4 then goto acabou;
                            n_jogadas:=n_jogadas+1;
                            escolhe_pal;ecra_tema;
                            jogador1_a_jogar;
                            inic_abcedario;escreve_abcedario;
                            diz_mensagem1:=true;
                       end;
              until (n_jogadas>4);  { Caso o n£mero de jogadas for 4 entÑo }
              acabou:cleardevice;   { d† o resultado final                 }
              jogar:=true;
              setcolor(white);rectangle(0,0,getmaxx,getmaxy);
              setfillstyle(1,lightgray);floodfill(1,1,white);
              settextstyle(1,0,3);setcolor(black);
              outtextxy(200,40,'RESULTADOS FINAIS');
              if (aux1=1) and (aux2=0 ) and (aux3=0) then
                 begin
                      setcolor(lightgreen);
                      str(pontuacao1,st1);outtextxy(150,100,jogador1+' : '+st1);
                      str(pont_cpu,st2);outtextxy(150,130,'CPU : '+st2);
                      setcolor(lightblue+128);
                      if (pontuacao1>pont_cpu) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador1);
                              vencedor:=jogador1;
                         end;
                      if (pontuacao1<pont_cpu) then
                         begin
                              outtextxy(180,300,'VENCEDOR : CPU');
                              vencedor:='CPU';
                         end;
                      if (pontuacao1=pont_cpu) then outtextxy(180,300,'HOUVE UM EMPATE');
                 end;
              if (aux1=1) and (aux2=1) and (aux3=0) then
                 begin
                      setcolor(lightgreen);
                      str(pontuacao1,st1);outtextxy(150,100,jogador1+' : '+st1);
                      str(pontuacao2,st2);outtextxy(150,130,jogador2+' : '+st2);
                      setcolor(lightblue+128);
                      if (pontuacao1>pontuacao2) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador1);
                              vencedor:=jogador1;
                         end;
                      if (pontuacao1<pontuacao2) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador2);
                              vencedor:=jogador2;
                         end;
                      if (pontuacao1=pontuacao2) then outtextxy(180,300,'HOUVE UM EMPATE');
                 end;
              if (aux1=1) and (aux2=1) and (aux3=1) then
                 begin
                      setcolor(lightgreen);
                      str(pontuacao1,st1);outtextxy(150,100,jogador1+' : '+st1);
                      str(pontuacao2,st2);outtextxy(150,130,jogador2+' : '+st2);
                      str(pontuacao3,st3);outtextxy(150,160,jogador3+' : '+st3);
                      setcolor(lightblue+128);
                      if (pontuacao1>pontuacao2) and (pontuacao2>pontuacao3) and (pontuacao1>pontuacao3) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador1);
                              vencedor:=jogador1;
                         end;
                      if (pontuacao1>pontuacao2) and (pontuacao2<pontuacao3) and (pontuacao1<pontuacao3) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador3);
                              vencedor:=jogador3;
                         end;
                      if (pontuacao1<pontuacao2) and (pontuacao2>pontuacao3) and (pontuacao1<pontuacao3) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador2);
                              vencedor:=jogador2;
                         end;
                      if (pontuacao1>pontuacao2) and (pontuacao2<pontuacao3) and (pontuacao1>pontuacao3) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador1);
                              vencedor:=jogador1;
                         end;
                      if (pontuacao1<pontuacao2) and (pontuacao2<pontuacao3) and (pontuacao1<pontuacao3) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador3);
                              vencedor:=jogador3;
                         end;
                      if (pontuacao1<pontuacao2) and (pontuacao2>pontuacao3) and (pontuacao1>pontuacao3) then
                         begin
                              outtextxy(180,300,'VENCEDOR : '+jogador2);
                              vencedor:=jogador2;
                         end;
                      if (pontuacao1=pontuacao2) and (pontuacao2=pontuacao3) and (pontuacao1=pontuacao3) then
                         outtextxy(180,300,'HOUVE UM EMPATE');
                 end;
              mensagem;topten;
              settextstyle(1,0,3);setcolor(white);
              goto fim;
         end;
     fim:cleardevice;
     ja_inscritos:=false;    { Tem que se fazer novas inscriáîes }
end;

procedure menu;   { Menu Principal do Jogo }
label 01;
var cur:integer;
begin
     repeat
           doneevents;cleardevice;
           setcolor(black);rectangle(0,0,getmaxx,getmaxy);
           setfillstyle(1,lightblue);floodfill(1,1,lightgray);
           setcolor(black);
           line(0,350,640,350);line(0,370,640,370);
           setfillstyle(1,blue);floodfill(1,351,black);
           setfillstyle(1,lightgray);floodfill(1,372,black);
           settextstyle(2,0,4);
           desenha_portas(30,170,150,370);
           desenha_placas(55,220,125,245);
           desenha_fechaduras(135,275,5);
           setcolor(black);line(91,201,60,220);line(89,201,120,220);
           outtextxy(74,226,'JOGAR');
           desenha_portas(170,170,290,370);
           desenha_placas(195,220,265,245);
           desenha_fechaduras(275,275,5);
           setcolor(black);
           line(231,201,201,220);line(228,201,260,220);
           outtextxy(202,226,'INSCRIÄôES');
           desenha_portas(310,170,430,370);
           desenha_placas(335,220,405,245);
           desenha_fechaduras(415,275,5);
           setcolor(black);line(371,201,341,220);line(368,201,400,220);
           outtextxy(342,226,'BASTIDORES');
           desenha_portas(450,170,570,370);
           desenha_placas(475,220,545,245);
           desenha_fechaduras(555,275,5);
           setcolor(black);line(511,201,481,220);line(508,201,540,220);
           outtextxy(495,226,'SAIDA');
           desenha_papel_de_ajuda;
           settextstyle(1,0,5);setcolor(white);
           outtextxy(210,20,'OS DADOS');
           outtextxy(210,80,'DA SORTE');
           settextstyle(1,0,5);setcolor(red+brown);
           outtextxy(212,22,'OS DADOS');
           outtextxy(212,82,'DA SORTE');
           cur:=0;
           if (ch='R') then begin
                                 initevents;
                                 repeat cur:=mouse until cur in [1..5];
                            end
           else begin
                     repeat
                           01:settextstyle(2,0,6);setcolor(white);
                           outtextxy(170,450,'Ctrl + J / I / B / S / A / V');
                           while keypressed do ch:=readkey;ch:=readkey;ch:=upcase(ch);
                           if ch=chr(27) then sair;
                           case ch of
                                ^J:cur:=1;
                                ^I:cur:=2;
                                ^B:cur:=3;
                                ^S:cur:=4;
                                ^A:cur:=5;
                                ^V:cur:=6;
                           end;
                     until (ch=^J) or (ch=^I) or (ch=^B) or (ch=^S) or (ch=^A) or (ch=^V);
                end;
           doneevents;
           while keypressed do opcao:=readkey;
           case cur of
                1:jogadas;     { Jogadas feitas pelo jogador e palpites   }
                2:inscricao;   { InscriáÑo do jogadores                   }
                3:password;    { C¢digo para ver as palavras no ficheiro  }
                4:closegraph;  { Fecha os gr†ficos e sai do jogo          }
                5:ajuda;       { Ajuda sobre o jogo                       }
                6:begin    { Caso nÑo tenha rato as portas serÑo abertas }
                           { atravÇs do teclado                          }
                       settextstyle(2,0,6);setcolor(lightgray);
                       outtextxy(170,450,'Ctrl + J / I / B / S / A / V');
                       setcolor(white);
                       outtextxy(260,450,'Ctrl + V');
                       repeat
                             versao;
                             while keypressed do opcao:=readkey;c:=readkey;c:=upcase(c);
                       until (c=^V);
                       apagar_versao;
                       settextstyle(2,0,6);setcolor(lightgray);
                       outtextxy(260,450,'Ctrl + V');
                       goto 01;
                end;
           end;
     until (cur=4);
     if ntpal=0 then begin
                          swapvectors;
                          {$M 4000,0,0}
                          exec(getenv('comspec'),'/CDEL PALAVRAS.DDS >>FILELIST.DDS');
                          {$M 16384,0,65360}
                          swapvectors;
                     end;
     normvideo;clrscr;textcolor(lightgray);
     writeln('…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª');
     writeln('∫  Ø Ø Ø Ø OS DADOS DA SORTE Æ Æ Æ Æ  ∫');
     writeln('∫   (c) Nuno Miguel Oliveira Brito    ∫');
     writeln('∫ SPOOLER Magazine dos utlizadores PC ∫');
     writeln('»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
end;

procedure utilizar_rato;   { Verifica se Ç o rato ou teclado }
begin
     cursor;ver_mouse;
     if flag=false then ch:='R'     { Para o rato    }
                   else ch:='T';    { Para o teclado }
end;

procedure apresentacao;   { ApresentaáÑo do Jogo }
var maxx,maxy:integer;
begin
     if palavras=false then ver_graficos;
     x:=3;
     setcolor(lightblue);
     while x<60 do
     begin
          x:=x+3;y:=x;
          setcolor(white);rectangle(0,0,getmaxx,getmaxy);
          setcolor(blue);
          rectangle(x-2,x-2,getmaxx-x+2,getmaxy-x+2);
          rectangle(x,x,getmaxx-x,getmaxy-x);
     end;
     settextstyle(1,0,6);setcolor(lightcyan);
     outtextxy(86,86,'Os Dados Da Sorte');
     outtextxy(87,87,'Os Dados Da Sorte');
     outtextxy(88,88,'Os Dados Da Sorte');
     outtextxy(89,89,'Os Dados Da Sorte');
     setcolor(darkgray);outtextxy(90,90,'Os Dados Da Sorte');
     settextstyle(1,0,5);
     setcolor(lightred);outtextxy(220,228,'SPOOLER');
     setcolor(lightgreen);outtextxy(222,230,'SPOOLER');
     settextstyle(1,0,3);
     setcolor(lightred);outtextxy(150,280,'Magazine dos Utilizadores PC');
     setcolor(lightgreen);outtextxy(152,282,'Magazine dos Utilizadores PC');
     settextstyle(1,0,2);setcolor(white);
     outtextxy(150,420,'Por : Nuno Miguel Oliveira Brito');
     outtextxy(250,450,'VersÑo 1.0');
     while keypressed do opcao:=readkey;c:=readkey;
     setcolor(black);
     for x:=70 to 310 do begin
                              line(70,x,575,x);delay(5);
                         end;
     carrega_ar;             { Carrega as palavras para mem¢ria       }
     utilizar_rato;          { Rato ou teclado                        }
end;
                      { Corpo Principal do Programa }
begin
     checkbreak:=false;   { Impossibilita a utilizaáÑo das teclas Ctrl+Break }
     jogar:=false;flag:=false;palavras:=false;
     carrega_scores;         { Carrega os hi-scores para mem¢ria      }
     ja_inscritos:=false;    { Coloca as inscriáîes a zero            }
     apresentacao;           { ApresentaáÑo dos Dados da Sorte        }
     menu;                   { Menu e procedimento principal do jogo  }
end.
{                       Espero que se divirtam muito                         }
{                          com os Dados da Sorte                             }
{                               BOA SORTE !!                                 }