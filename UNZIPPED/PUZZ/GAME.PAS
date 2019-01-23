{$i le_pic.pas}
procedure grelha(fmd:shortint);
 begin
   case fmd of
     1:begin squares:=3; litt:=3; end;
     2:begin squares:=4; litt:=2; end;   {calculos para divisao imagem}
     3:begin squares:=6; litt:=0; end;
   end;
   x2:=359 div squares; y2:=264 div squares;{divide "tabua" por n quadrados}
   usecolor(15); x:=333; y:=233;
   for i:=1 to squares do begin
     for d:=1 to squares do begin          {faz rectangulos}
       rectangle(x,y,x+x2,y+y2); inc(x,x2);
     end;
     x:=333; inc(y,y2);
   end;
 end;

procedure restaura_pos;                     {Restaura posicoes}
 begin x:=ax; y:=ay; xpos:=axpos; ypos:=aypos; end;


procedure start(fmd:shortint;s:char); {Posiciona blocos e come‡a jogo}
var
    blk,dst       :pointer;
    size          :word;
    m,n,o,p,numero:shortint;

 begin
   limpa; pic(nivel); grelha(fmd);         {le imagem e faz grelha}
   usecolor(0); bar(maxx-335-x2+litt,497-y2,687+litt,497);
   grelha(fmd); L_T(2,6); palavra:='';
   case fmd of
     1:palavra:=' * F cil *';
     2:palavra:=' * M‚dio *';
     3:palavra:=' * Dificil *';
   end;
   usecolor(0);
   for t:=0 to 2 do outtextxy(460+t,510,palavra);    {escreve nivel}
   str(nivel,palavra); L_T(2,7); usecolor(15);
   for t:=0 to 2 do outtextxy(470+t,527,'PUZZLE '+palavra);
   for ypos:=1 to squares do
     for xpos:=1 to squares do
       square_pos[ypos,xpos]:='00';    {inicia posicoes array todas a 0}
   str(squares,palavra); insert(palavra,palavra,2);
   square_pos[squares,squares]:=palavra;
   case squares of
     3:numero:=4;
     4:numero:=6;       {numero de blocos a trocar}
     6:numero:=17;
   end;
   for i:=1 to numero do begin
     repeat
       m:=random(squares)+1;      {procura bloco a 00}
       n:=random(squares)+1;
     until(square_pos[m,n]='00');
     str(m,palavra); str(n,palavra2); insert(palavra2,palavra,2);
     square_pos[m,n]:=palavra;   {guarda posicao m,n em array}
     repeat
       o:=random(squares)+1;     {procura outro bloco a 00}
       p:=random(squares)+1;
     until(square_pos[o,p]='00');
     str(o,palavra); str(p,palavra2); insert(palavra2,palavra,2);
     square_pos[m,n]:=palavra;
     str(m,palavra); str(n,palavra2); insert(palavra2,palavra,2);
     square_pos[o,p]:=palavra;   {guarda posicao o,p em array}
     if squares=3 then begin x:=211+m*x2; y:=145+n*y2; end
     else if squares=4 then begin x:=242+m*x2; y:=167+n*y2; end
     else begin x:=274+m*x2; y:=189+n*y2; end;
     size:=imagesize(x+litt,y,x+litt+x2,y+y2); getmem(blk,size);
     getimage(x+litt,y,x+litt+x2,y+y2,blk^);
     if squares=3 then begin x:=211+o*x2; y:=145+p*y2; end
     else if squares=4 then begin x:=242+o*x2; y:=167+p*y2; end
     else begin x:=274+o*x2; y:=189+p*y2; end;
     size:=imagesize(x+litt,y,x+litt+x2,y+y2); getmem(dst,size);
     getimage(x+litt,y,x+litt+x2,y+y2,dst^);
     putimage(x+litt,y,blk^,normalput); freemem(blk,size);
     if squares=3 then begin x:=211+m*x2; y:=145+n*y2; end
     else if squares=4 then begin x:=242+m*x2; y:=167+n*y2 end
     else begin x:=274+m*x2; y:=189+n*y2; end;
     putimage(x+litt,y,dst^,normalput); freemem(dst,size);
   end;
   for m:=1 to squares do for n:=1 to squares do begin
     str(m,palavra); str(n,palavra2); insert(palavra2,palavra,2);
     if square_pos[m,n]='00' then square_pos[m,n]:=palavra;
   end;
   size:=imagesize(maxx-336-x2+litt,497-y2,maxx-336+litt,497);
   getmem(blk,size);
   getimage(maxx-336-x2+litt,497-y2,maxx-336+litt,497,blk^);
   x:=687-x2; y:=497-y2; ax:=x; ay:=y;
   xpos:=squares; ypos:=squares; blkx:=x; blky:=y;
   blkxpos:=xpos; blkypos:=ypos;
   if s='j' then begin                 {se opcao por jogadas escreve}
     str(jogadas,palavra);             {valores iniciais das jogadas}
     usecolor(0);
     bar(655,510,693,530); bar(330,510,368,530);
     usecolor(15);
     outtextxy(657,508,palavra); outtextxy(332,508,palavra);
   end;
   repeat
     size:=imagesize(x+litt,y,x+litt+x2,y+y2); getmem(dst,size);
     getimage(x+litt,y,x+litt+x2,y+y2,dst^);
     usecolor(41); for i:=0 to 4 do rectangle(x+litt+i,y+i,x+litt+x2-i,y+y2-i);
     tecla:=readkey; ax:=x; ay:=y; axpos:=xpos; aypos:=ypos;
     if ord(tecla)=32 then begin        {carregou em space}
       if s='j' then begin              {se opcao jogadas, decrementa um}
         usecolor(0);
         bar(655,510,693,530); bar(330,510,368,530);
         dec(jogadas); str(jogadas,palavra);
         usecolor(15);
         outtextxy(657,508,palavra); outtextxy(332,508,palavra);
       end;
       putimage(x+litt,y,blk^,normalput);     {recoloca bloco negro}
       putimage(blkx+litt,blky,dst^,normalput);{recoloca bloco escolhido}
       freemem(dst,size);                      {liberta memoria}
       palavra:=square_pos[blkxpos,blkypos];
       palavra2:=square_pos[xpos,ypos];
       square_pos[blkxpos,blkypos]:=palavra2;{guarda no array de posicoes o}
       square_pos[xpos,ypos]:=palavra;       {valor dos blocos trocados}
       blkx:=x; blky:=y; blkxpos:=xpos; blkypos:=ypos;
     end
     else begin
       putimage(x+litt,y,dst^,normalput); freemem(dst,size); barra_puzz;
     end;
     {verifica posicao do rectangulo vermelho  \/}
     if xpos<1 then begin xpos:=1; inc(x,x2); end;
     if xpos>squares then begin xpos:=squares; dec(x,x2); end;
     if ypos<1 then begin ypos:=1; inc(y,y2); end;
     if ypos>squares then begin ypos:=squares; dec(y,y2); end;
     if (xpos=blkxpos) and (ypos<blkypos-1) then restaura_pos;
     if (xpos=blkxpos) and (ypos>blkypos+1) then restaura_pos;
     if (ypos=blkypos) and (xpos<blkxpos-1) then restaura_pos;
     if (ypos=blkypos) and (xpos>blkxpos+1) then restaura_pos;
     if (xpos=blkxpos+1) and (ypos<>blkypos) then restaura_pos;
     if (xpos=blkxpos-1) and (ypos<>blkypos) then restaura_pos;
     if (ypos=blkypos+1) and (xpos<>blkxpos) then restaura_pos;
     if (ypos=blkypos-1) and (xpos<>blkxpos) then restaura_pos;
     sair:=true;
     for m:=1 to squares do for n:=1 to squares do begin
       str(m,palavra); str(n,palavra2); insert(palavra2,palavra,2);
       if square_pos[m,n]<>palavra then sair:=false;
       {corre array de posicoes, se os valores encontrados }
       {estiverem iguais aos valores iniciais do array= puzzle completo}
     end;
   until(ord(tecla)=27) or (sair=true) or (jogadas=0);
   if sair=true then begin
     sound(700); delay(200); nosound;    {puzzle feito, le imagem completa}
     pic(nivel);
     delay(3000);
   end;
 end;

{)))))))))))))))))))))))}

procedure nivel_dif(b:shortint;c:integer);    {Nivel a ler}
 begin
   L_T(8,4); usecolor(0);
   for i:=0 to 5 do begin
     case b of
       1:outtextxy(325+i,293+i,'F cil');
       2:outtextxy(465+i,293+i,'M‚dio');
       3:outtextxy(610+i,293+i,'Dificil');
     end;
   end;
   usecolor(c);
   for i:=0 to 3 do begin
     case b of
       1:outtextxy(321+i,293+i,'F cil');
       2:outtextxy(461+i,293+i,'M‚dio');
       3:outtextxy(606+i,293+i,'Dificil');
     end;
   end;
 end;

procedure game(s:char);      {Inicializa ecran para imagem}
 begin                       {Controla o nivel e saida}
   usecolor(0);
   for i:=300 to 340 do begin
     d:=random(2); if d=0 then usecolor(28) else usecolor(27);
     x:=300;
     for t:=1 to 3 do begin line(x,i,x+130,i); inc(x,147); end;
   end;
   usecolor(0); x:=300;
   for t:=1 to 3 do begin
     for i:=1 to 2 do begin
       rectangle(x+i,300+i,x+130-i,340-i);
     end;
     inc(x,147);
   end;
   for b:=1 to 3 do nivel_dif(b,27);
   usecolor(0); L_T(8,2);
   for i:=1 to 8 do begin
     outtextxy(485+i,250+i,'N¡vel');
     line(310,265+i,475,265+i); line(555,265+i,720,265+i);
     line(306+i,265+i,306+i,290+i); line(712+i,265+i,712+i,290+i);
   end;
   usecolor(27);
   for i:=1 to 3 do begin
     outtextxy(481+i,250+i,'N¡vel');
     line(306,265+i,475,265+i); line(551,265+i,715,265+i);
     line(306+i,265+i,306+i,290+i); line(712+i,265+i,712+i,290+i);
   end; horz:=1;
   {escolhe nivel de dificuldade \/}
   repeat
     nivel_dif(horz,41); tecla:=readkey; nivel_dif(horz,27);
     barra_puzz;
     if horz<1 then horz:=1;
     if horz>3 then horz:=3;
   until(ord(tecla)=13) or (tecla=#27);
   if tecla=#27 then begin
     tecla:='\'; limpa; exit;   {se opcao=ESC voltar menu principal}
   end;
   nivel:=1; fmd:=horz;
   case fmd of
     1:jogadas:=100;
     2:jogadas:=300;           {inicializa n§ de jogadas}
     3:jogadas:=500;
   end;
   repeat
     if nivel=6 then begin limpa; exit; end;  {nivel=6 sai do jogo}
     start(fmd,s);                            {comeca jogo}
     if sair=true then begin
       inc(nivel);                            {aumenta nivel}
       case fmd of
         1:jogadas:=101-nivel;     {diminui jogadas consoante nivel}
         2:jogadas:=303-nivel*3;
         3:jogadas:=505-nivel*5;
       end;
     end;
   until(sair=false);
   limpa;
 end;