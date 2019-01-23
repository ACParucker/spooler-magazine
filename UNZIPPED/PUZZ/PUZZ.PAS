uses
  Crt, Dos, Graph, Windos;

var
  w,q,t,d,i             :integer;  {Globais}
  f                     :text;     {Files de imagens}
  fmd,nivel             :shortint; {Escolha fac/med/dif, N§ de imagem}
  blkxpos,blkypos       :shortint; {Posicoes dos blocos na grelha}
  xpos,ypos,axpos,aypos :shortint; {Posicoes bloco escolhido, Auxiliares}
  squares,litt          :shortint; {N§ blocos dividem imagem, margem de erro}
  square_pos            :array[1..6,1..6] of string[2];
                                   {Posicoes originais dos quadrados}
  tecla                 :char;     {Inputs do utilizador}
  g                     :shortint; {Guarda valor escolha menu principal}
  jogadas               :integer;  {N§ jogadas que faltam}
  blkx,blky             :integer;  {Posicoes onde sera posto bloco escolhido}
  ax,ay                 :integer;  {Guarda posicoes de x,y}
  horz                  :integer;  {Regula posicoes escolhas menu principal}
  x,y                   :integer;  {Posicoes onde sera posto bloco negro}
  x2,y2                 :integer;  {Margens de in/decrementacao }
  palavra,palavra2      :string;   {Escrita para ecran}
  iniciar,sair          :boolean;  {Iniciar programa, sair do nivel}

{$i svga256}

{//////////////////////////////////////////////////////////////////}
procedure barra_puzz;           {In/Decrementa posicoes rectangulo vermelho}
begin                           {    " "         " "    menu fac/med/dif   }
  if ord(tecla)=0 then begin
    tecla:=readkey;
    case ord(tecla) of
      72:begin dec(y,y2); dec(ypos); end;
      75:begin dec(horz); dec(x,x2); dec(xpos); end;
      77:begin inc(horz); inc(x,x2); inc(xpos); end;
      80:begin inc(y,y2); inc(ypos); end;
    end;
  end;
end;

procedure barra_mov;            {In/Decrementa posicoes menu proncipal}
 begin
   if ord(tecla)=0 then begin
     tecla:=readkey;
     case ord(tecla) of
       72:begin
            case b of
              3:b:=1;
              4:b:=2;
              5:b:=random(2)+3;
            end;
          end;
       75:begin
            case b of
              2:b:=1;
              4:b:=3;
            end;
          end;
       77:begin
            case b of
              1:b:=2;
              3:b:=4;
            end;
          end;
       80:begin
            case b of
              1:b:=3;
              2:b:=4;
              3:b:=5;
              4:b:=5;
            end;
          end;
     end;
   end;
 end;

 procedure ff;                  {Mostra mensagem de erro}
  begin
    clrscr;
    textcolor(8);
    for i:=1 to 80 do begin
      for q:=1 to 24 do begin
        gotoxy(i,q); write(' FALTAM FICHEIROS ');
      end;
      inc(i,19);
    end;
    textcolor(15);
    gotoxy(30,12); write(' FALTAM FICHEIROS ');
    tecla:=readkey;
  end;

{////////////////////////////////////////////////////////////////////}
procedure opcao(b:shortint;c:integer);   {Escreve opcoes menu proncipal}
 begin
   L_T(2,4); setcolor(15);
     outtextxy(570,560,'(C)1994, Rui Tempero Software');
   L_T(8,4); usecolor(0);
   for i:=0 to 5 do begin
     case b of
       1:outtextxy(349+i,224+i,'NORMAL');
       2:outtextxy(maxx-485+i,224+i,'JOGADAS');
       3:outtextxy(355+i,324+i,'TECLAS');
       4:outtextxy(maxx-468+i,324+i,'AUTOR');
       5:outtextxy(485+i,444+i,'FIM');
     end;
   end;
   usecolor(c);
   for i:=0 to 3 do begin
     case b of
       1:outtextxy(345+i,224+i,'NORMAL');
       2:outtextxy(maxx-489+i,224+i,'JOGADAS');
       3:outtextxy(351+i,324+i,'TECLAS');
       4:outtextxy(maxx-472+i,324+i,'AUTOR');
       5:outtextxy(481+i,444+i,'FIM');
     end;
   end;
 end;

procedure box_o(b,c:shortint);  {Faz parte fora de caixas}
 begin
   usecolor(c);
   for i:=1 to 2 do begin
     case b of
       1:rectangle(336+i,228+i,492+i,270+i);
       2:rectangle(maxx-336-i,228+i,maxx-492+i,270+i);
       3:rectangle(336+i,328+i,492+i,370+i);
       4:rectangle(maxx-336-i,328+i,maxx-492+i,370+i);
       5:rectangle(437+i,i+448,590+i,490+i);
     end;
   end;
 end;

procedure box_i(b:shortint);      {Fax parte dentro de caixas}
 begin
   case b of
     1:line(338,i,492,i);
     2:line(maxx-338,i,maxx-492,i);
     3:line(338,i+100,492,i+100);
     4:line(maxx-338,i+100,maxx-492,i+100);
     5:line(440,i+220,590,i+220);
   end;
 end;

procedure boxes(b:shortint);       {Controla escolha de fazer caixas}
 begin
   for i:=230 to 270 do begin
     d:=random(2); if d=0 then usecolor(28) else usecolor(27);
     if b=0 then begin for b:=1 to 7 do box_i(b); b:=0; end
     else box_i(b);
   end;
   if b=0 then begin for b:=1 to 7 do box_o(b,0); b:=0; end
   else box_o(b,0);
 end;

procedure limpa;                 {Limpa o ecran para entrada de novas opcoes}
var p:pointer; size:word; w:shortint;
 begin
   size:=imagesize(300,182,723,225);    {Define bloco de imagem}
   getmem(p,size);                      {Apanha memoria no tamanho do bloco}
   getimage(300,182,723,225,p^);        {Apanha o bloco no ecran}
   y:=225;
   for i:=0 to 7 do begin
     putimage(300,y+i*40,p^,normalput); {Poe imagem i vezes no ecran}
   end;
   freemem(p,size);                     {Liberta memoria}
 end;

procedure letras;         {Escreve informacao por baixo de NORMAL/JOGADAS}
 begin
   L_T(8,2); usecolor(0);
   for i:=1 to 8 do begin outtextxy(450+i,270+i,'Iniciar jogo');
     line(345+i,275+i,345+i,285+i); line(677+i,275+i,677+i,285+i);
     line(345+i,285+i,435+i,285+i); line(590+i,285+i,675+i,285+i);
   end;
   usecolor(27);
   for i:=1 to 3 do begin outtextxy(446+i,270+i,'Iniciar Jogo');
     line(341+i,275+i,341+i,285+i); line(677+i,275+i,677+i,285+i);
     line(341+i,285+i,431+i,285+i); line(586+i,285+i,676+i,285+i);
   end;
 end;
{///////////////////////////////////////////////////////////////////}
procedure masc;           {Faz mascara inicial do jogo}
 begin
   for i:=280 to maxx-280 do begin
     d:=random(2);
     if d=0 then usecolor(66) else usecolor(65);
     line(i,40,i,550);
   end;
   for i:=50 to 180 do begin
     d:=random(2);
     if d=0 then usecolor(28) else usecolor(27);
     line(300,i,maxx-300,i);
   end;
   usecolor(0); rectangle(300,50,maxx-300,180);
     rectangle(299,49,maxx-299,181);
   L_T(8,1);
   L_T(8,8);
   usecolor(0);
   for i:=0 to 20 do outtextxy(356+i,48+i,'PUZZLE');
   usecolor(25);
   for i:=0 to 5 do outtextxy(350+i,42+i,'PUZZLE');
   usecolor(0);
     fillellipse(312,62,5,5); fillellipse(maxx-308,62,5,5);
     fillellipse(312,172,5,5); fillellipse(maxx-308,172,5,5);
   usecolor(25);
     fillellipse(310,60,5,5); fillellipse(maxx-310,60,5,5);
     fillellipse(310,170,5,5); fillellipse(maxx-310,170,5,5);
   boxes(0);
   for b:=1 to 5 do opcao(b,27);
   letras;
 end;
{/////////////////////////////////////////////////////////////////}
function ve_sys:boolean;    {Ve se os ficheiros de sistema estao OK}
 var dirinfo:tsearchrec;
 begin
   for i:=1 to 13 do begin
     case i of
       1:findfirst('system\bold.chr',faarchive,dirinfo);
       2:findfirst('system\euro.chr',faarchive,dirinfo);
       3:findfirst('system\goth.chr',faarchive,dirinfo);
       4:findfirst('system\lcom.chr',faarchive,dirinfo);
       5:findfirst('system\litt.chr',faarchive,dirinfo);
       6:findfirst('system\sans.chr',faarchive,dirinfo);
       7:findfirst('system\scri.chr',faarchive,dirinfo);
       8:findfirst('system\simp.chr',faarchive,dirinfo);
       9:findfirst('system\trip.chr',faarchive,dirinfo);
      10:findfirst('system\tscr.chr',faarchive,dirinfo);
      11:findfirst('system\svga256.bgi',faarchive,dirinfo);
      12:findfirst('system\svga256.h',faarchive,dirinfo);
      13:findfirst('system\svga256.inc',faarchive,dirinfo);
     end;
     if doserror<>0 then begin ve_sys:=false; exit; end;
   end;
   ve_sys:=true;
 end;

function ve_amk:boolean;     {Ve se as imagens estao OK}
 var dirinfo:tsearchrec;
 begin
   for i:=1 to 6 do begin
     case i of
       1:findfirst('amk\carin.amk',faarchive,dirinfo);
       2:findfirst('amk\hellowee.amk',faarchive,dirinfo);
       3:findfirst('amk\manowar.amk',faarchive,dirinfo);
       4:findfirst('amk\metallic.amk',faarchive,dirinfo);
       5:findfirst('amk\ship.amk',faarchive,dirinfo);
       6:findfirst('amk\end.amk',faarchive,dirinfo);
     end;
     if doserror<>0 then begin ve_amk:=false; exit; end;
   end;
   ve_amk:=true;
 end;


{////////// Inicio  programa ////////////////////////////////////////}

{$i credits.pas}
{$i game.pas}
begin
  iniciar:=ve_sys;                             {ve ficheiros de sistema}
  if iniciar=true then iniciar:=ve_amk;        {se /\ OK ve ficheiros imagem}
  if iniciar=true then begin                   {se imagem OK come‡a}
    initialize;                                {inicia graficos}
    masc; b:=1;                                {faz mascara}
    repeat
      opcao(b,41);
      tecla:=readkey;                          {espera input utilizador}
      opcao(b,27); barra_mov;                  {analiza input}
      if ord(tecla)=27 then b:=5;              {opcao=ESC vai para o end}
      if ord(tecla)=13 then begin              {opcao=RETURN analiza: }
        limpa; g:=b;                           {limpa tabua}
        if b<>5 then begin
          case b of
            1:game('n');          {chama procedure game para jogo normal}
            2:game('j');          {chama procedure game para jogo por jogadas}
            3:help;               {chama procedure mostra tecla}
            4:credits;            {chama procedure mostra autor}
          end;
          boxes(0); letras;
          for b:=1 to 5 do opcao(b,27); b:=g;
        end;                      {refaz opcoes menu principal}
      end;
    until(ord(tecla)=13) and (b=5);
    le_pic(270,180,'end');        {le imagem final e escreve \/ }
    L_T(4,3); usecolor(14);
    outtextxy(300,225,'"And Bob shall wipe away all tears from');
    outtextxy(300,250,' their eyes; and there shall be no more');
    outtextxy(300,275,' Death. Neither sorrow, nor crying.');
    outtextxy(300,300,' Neither shall there be anymore Prain;');
    outtextxy(300,325,' For the former things are passed away."');
    outtextxy(300,375,' Revelations Ch.XXI V4');
    tecla:=readkey; CloseGraph;   {espera input de tecla, fecha graficos}
  end else ff                     {faltam ficheiros}
end.
