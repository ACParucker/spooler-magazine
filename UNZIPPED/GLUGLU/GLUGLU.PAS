{******          GLUG-GLUG.  Programado em Turbo Pascal  1993          ******}
{****** Autor: PAULO ALEXANDRE F. MOREIRA     Telef.9898076  Rio Tinto ******}

program gluglu (input,output);
uses
  graph,crt,dos,peixes,areas,bgidriv,bgifont;

type
  ficheiro = file;
  matriz1 = array [1..20] of string;
  matriz2 = array [1..20] of longint;
  v = array [1..3] of integer;

var
  totitem,temitem,area,vidas : byte;
  bx,by,mx,my,script         : word;
  tiro,mitem                 : matriz;
  mpeixe                     : matrizp;
  vtiro                      : v;
  grafs1,grafs2,grafs3       : pointer;
  grafs4,oldint              : pointer;
  vel,vel2                   : integer;
  pontos,max                 : longint;
  sentido                    : string;
  tecla                      : char;
  fich                       : ficheiro;
  fichpont                   : text;
  tabpont                    : matriz1;
  tabnum                     : matriz2;
  andar,primeiro,morreu,sai  : boolean;
  tec_e,tec_d,tec_c,tec_b,tec_f : boolean;


procedure aborta(msg : string);{ ******************************************* }
begin
  writeln(msg, ': ', grapherrormsg(graphresult));
  halt(1);
end; {* aborta *}

procedure abrir_modo_grafico;{ ********************************************* }
var
  graphdriver,graphmode,error : integer;
begin
  if registerBGIdriver(@CGAdriverproc) < 0 then
    aborta('CGA');
  if registerBGIfont(@smallfontproc) < 0 then
    aborta('Small');
  if registerBGIfont(@triplexfontproc) < 0 then
    aborta('Triplex');
  graphdriver := cga;
  graphmode := 1;
  initgraph(graphdriver, graphmode, '');
  if graphresult <> grok then
  begin
    writeln('Erro inicial,graficos: ', grapherrormsg(graphdriver));
    halt(1);
  end;
end; {* abrir_modo_grafico *}

procedure por_imagem;{ ***************************************************** }
var tamanho : integer;
    imag    : pointer;
begin
  assign(fich,'gluglu.pic');
  reset(fich,1);
  imag := ptr ($b800,$0000);
  tamanho := 7;
  blockRead(fich,imag^,7,tamanho);
  imag := ptr ($b800,$0000);
  tamanho := 16391;
  blockRead(fich,imag^,16391,tamanho);
end; {* por_imagem *}

procedure carrega_grafs1;{ ************************************************* }
var
  tamanho : integer;
begin
  tamanho := 8672;
  assign(fich,'grafs1.spr');
  reset(fich,1);
  GetMem(grafs1,tamanho);
  BlockRead(fich,grafs1^,tamanho,tamanho);
  close(fich);
end; {* carrega_grafs1 *}

procedure carrega_grafs2;{ ************************************************* }
var
  tamanho : integer;
begin
  tamanho := 8588;
  assign(fich,'grafs2.spr');
  reset(fich,1);
  GetMem(grafs2,tamanho);
  BlockRead(fich,grafs2^,tamanho,tamanho);
  close(fich);
end; {* carrega_grafs2 *}

procedure carrega_grafs3;{ ************************************************* }
var
  tamanho : integer;
begin
  tamanho := 10430;
  assign(fich,'grafs3.spr');
  reset(fich,1);
  GetMem(grafs3,tamanho);
  BlockRead(fich,grafs3^,tamanho,tamanho);
  close(fich);
end; {* carrega_grafs3 *}

procedure carrega_grafs4;{ ************************************************* }
var
  tamanho : integer;
begin
  tamanho := 11496;
  assign(fich,'grafs4.spr');
  reset(fich,1);
  GetMem(grafs4,tamanho);
  BlockRead(fich,grafs4^,tamanho,tamanho);
  close(fich);
end; {* carrega_grafs4 *}

procedure inicio;{ ********************************************************* }
var
  cabecalho,chao,item   : pointer;
  fiog,barco,mergulhaep : pointer;
  i : byte;
begin
  for i:= 1 to 3 do
    begin
      tiro[i,1]:= -100; tiro[i,2]:= 0;
    end;
  clearviewport;
  cabecalho := ptr(seg(grafs1^),ofs(grafs1^));
  chao := ptr(seg(grafs1^),ofs(grafs1^)+2646);
  barco := ptr(seg(grafs1^),ofs(grafs1^)+3212);
  mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
  fiog := ptr(seg(grafs1^),ofs(grafs1^)+4794);
  item := ptr(seg(grafs1^),ofs(grafs1^)+4804);
  putimage(0,0,cabecalho^,xorput);
  putimage(0,193,chao^,xorput);
  putimage(bx,16,barco^,normalput);
  putimage(mx,my,mergulhaep^,xorput);
  putimage(mx+10,39,fiog^,xorput);
  putimage(2,1,item^,xorput);
  escrever_pontuacao(pontos,max);
  escrever_maximo(max);
  settextstyle(2,0,4); escrever_vidas(vidas); settextstyle(0,0,1);
end; {* inicio *}

procedure som1;{ *********************************************************** }
var s : integer;
begin
  for s := 30 to 32 do
    begin
      sound(s*20);sound(s*400);
      delay(1);
    end;
  for s := 32 downto 30 do
    begin
      sound(s*20);sound(s*400);
      delay(1);
    end;
  nosound;
end; {* som1 *}

procedure som2;{ *********************************************************** }
var s : integer;
begin
  for s := 1 to 2 do
    begin
      sound(s*10000);
      delay(1);
    end;
  for s := 2 downto 1 do
    begin
      sound(s*10000);
      delay(1);
    end;
  nosound;
end; {* som2 **}

procedure som3;{ *********************************************************** }
var s : integer;
begin
  for s := 1 to 5 do
    begin
      sound(s*2000);
      delay(3);
    end;
  for s := 5 downto 1 do
    begin
      sound(s*200);
      delay(3);
    end;
  nosound;
end; {* som3 *}

procedure poe_pixel;{ ****************************************************** }
const
  seed   = 1962;
  numpts = 2000;
var
  x,y,i,color : word;
  xmax,ymax   : integer;
  viewinfo    : viewporttype;
begin
  getviewsettings(viewinfo);
  with viewinfo do
  begin
    xmax := (x2-x1-1);
    ymax := (y2-y1-1);
  end;
  while not keypressed do
  begin
    randseed := seed;
    i := 0;
    while (not keypressed) and (i < numpts) do
    begin
      inc(i);
      putpixel(random(xmax)+1, random(ymax)+1, 1);
    end;
    delay(vel-24);
    randseed := seed;
    i := 0;
    while (not keypressed) and (i < numpts) do
    begin
      inc(i);
      x := random(xmax)+1;
      y := random(ymax)+1;
      color := getpixel(x, y);
      if color = 1 then
        putpixel(x, y, 0);
    end;
  end;
end; {* poe_pixel *}

procedure apaga_item(i:byte);{ ********************************************* }
var
  item : pointer;
begin
  som1;
  item := ptr(seg(grafs1^),ofs(grafs1^)+4804);
  putimage(2,1,item^,xorput);
  item := ptr(seg(grafs1^),ofs(grafs1^)+4804+62*mitem[i,2]);
  putimage(2,1,item^,xorput);
  putimage(mitem[i,1],179,item^,xorput);
  temitem:= i;
end; {* apaga_item *}

procedure apanha_item;{ **************************************************** }
var
  i    : byte;
begin
  for i:= 1 to 3 do
    begin
      if (mx+13>mitem[i,1]) and (mx-4<mitem[i,1]) and (temitem=0) then
        apaga_item(i)
      else if (mx-4<mitem[i,1]+14) and (mx+13>mitem[i,1]+14) and (temitem=0) then
        apaga_item(i);
    end;
end; {* apanha_item *}

procedure larga_item;{ ***************************************************** }
var
  item : pointer;
begin
  som3;
  item := ptr(seg(grafs1^),ofs(grafs1^)+4804+62*mitem[temitem,2]);
  putimage(2,1,item^,xorput);
  item := ptr(seg(grafs1^),ofs(grafs1^)+4804);
  putimage(2,1,item^,xorput);
  mitem[temitem,1]:= 0;
  temitem:= 0;
  totitem:= totitem+1;
  setcolor(1); escrever_pontuacao(pontos,max);
  setcolor(3); pontos:= pontos+500; escrever_pontuacao(pontos,max);
  if totitem = 3 then
    begin
      area:= area+1;
      inicio2(sai,grafs1,mitem,tiro,bx,mx,my,pontos,max,area,vidas,temitem);
      primeiro:= true; sentido:= 'esq';
    end;
end; {* larga_item *}

procedure disparo;{ ******************************************************** }
var
  i    : byte;
  bala : pointer;
begin
  bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
  for i:= 1 to 3 do
    begin
      if tiro[i,1] = -100 then
        begin
          som2;
          if sentido = 'esq' then
            tiro[i,1]:= mx-10
          else
            tiro[i,1]:= mx+18;
          tiro[i,2]:= my+20;
          vtiro[i]:= tiro[i,1];
          putimage(tiro[i,1],tiro[i,2],bala^,xorput);
          i:=3;
        end;
    end;
end; {* disparo *}

procedure fio(c:byte);{ **************************************************** }
var
  f    : byte;
  fiog : pointer;
begin
  f:= 39;
  fiog := ptr(seg(grafs1^),ofs(grafs1^)+4794);
  repeat
    putimage(mx+c,f,fiog^,xorput); f:= f+8;
  until f>= my-1;
end; {* fio *}

procedure move_direita;{ *************************************************** }
var
  barco,mergulhaep,mergulhadp,mergulhaea,mergulhada : pointer;
begin
  bx := bx+2;
  barco := ptr(seg(grafs1^),ofs(grafs1^)+3212);
  putimage(bx,16,barco^,normalput);
  if my<150 then
    begin
      if sentido = 'esq' then
        begin
          fio(10);
          mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
          putimage(mx,my,mergulhaep^,xorput);
          sentido := 'dir';
          mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
          putimage(mx,my,mergulhadp^,xorput);
          fio(7);
        end;
      fio(7);
      mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
      putimage(mx,my,mergulhadp^,xorput);
      mx := mx+2;
      putimage(mx,my,mergulhadp^,xorput);
      fio(7);
    end
  else
    begin
      if andar then
        begin
          if sentido = 'esq' then
            begin
              fio(10);
              mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
              putimage(mx,my,mergulhaep^,xorput);
              sentido := 'dir';
              mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
              putimage(mx,my,mergulhadp^,xorput);
              fio(7);
            end;
          fio(7);
          mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
          putimage(mx,my,mergulhadp^,xorput);
          mx := mx+2;
          mergulhada := ptr(seg(grafs1^),ofs(grafs1^)+4530);
          putimage(mx,my,mergulhada^,xorput);
          fio(7);
          andar := false;
        end
      else
        begin
          if sentido = 'esq' then
            begin
              fio(10);
              mergulhaea := ptr(seg(grafs1^),ofs(grafs1^)+4002);
              putimage(mx,my,mergulhaea^,xorput);
              sentido := 'dir';
              mergulhada := ptr(seg(grafs1^),ofs(grafs1^)+4530);
              putimage(mx,my,mergulhada^,xorput);
              fio(7);
            end;
          fio(7);
          mergulhada := ptr(seg(grafs1^),ofs(grafs1^)+4530);
          putimage(mx,my,mergulhada^,xorput);
          mx := mx+2;
          mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
          putimage(mx,my,mergulhadp^,xorput);
          fio(7);
          andar := true;
        end;
    end;
  if my>142 then apanha_item;
end; {* move_direita *}

procedure move_esquerda;{ ************************************************** }
var
  barco,mergulhaep,mergulhadp,mergulhaea,mergulhada : pointer;
begin
  bx := bx-2;
  barco := ptr(seg(grafs1^),ofs(grafs1^)+3212);
  putimage(bx,16,barco^,normalput);
  if my<150 then
    begin
      if sentido = 'dir' then
        begin
          fio(7);
          mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
          putimage(mx,my,mergulhadp^,xorput);
          sentido := 'esq';
          mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
          putimage(mx,my,mergulhaep^,xorput);
          fio(10);
        end;
      fio(10);
      mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
      putimage(mx,my,mergulhaep^,xorput);
      mx := mx-2;
      putimage(mx,my,mergulhaep^,xorput);
      fio(10);
    end
  else
    begin
      if andar then
        begin
          if sentido = 'dir' then
            begin
              fio(7);
              mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
              putimage(mx,my,mergulhadp^,xorput);
              sentido := 'esq';
              mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
              putimage(mx,my,mergulhaep^,xorput);
              fio(10);
          end;
          fio(10);
          mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
          putimage(mx,my,mergulhaep^,xorput);
          mx := mx-2;
          mergulhaea := ptr(seg(grafs1^),ofs(grafs1^)+4002);
          putimage(mx,my,mergulhaea^,xorput);
          fio(10);
          andar := false;
        end
      else
        begin
          if sentido = 'dir' then
            begin
              fio(7);
              mergulhada := ptr(seg(grafs1^),ofs(grafs1^)+4530);
              putimage(mx,my,mergulhada^,xorput);
              sentido := 'esq';
              mergulhaea := ptr(seg(grafs1^),ofs(grafs1^)+4002);
              putimage(mx,my,mergulhaea^,xorput);
              fio(10);
            end;
          fio(10);
          mergulhaea := ptr(seg(grafs1^),ofs(grafs1^)+4002);
          putimage(mx,my,mergulhaea^,xorput);
          mx := mx-2;
          mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
          putimage(mx,my,mergulhaep^,xorput);
          fio(10);
          andar := true;
        end;
    end;
  if my>142 then apanha_item;
end; {* move_esquerda *}

procedure move_cima;{ ****************************************************** }
var
  mergulhaep,mergulhadp,mergulhaea,mergulhada : pointer;
begin
  if sentido = 'esq' then
    begin
      if my<150 then
        begin
          fio(10);
          mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
          putimage(mx,my,mergulhaep^,xorput);
          my := my-2;
          putimage(mx,my,mergulhaep^,xorput);
          fio(10);
        end
      else
        begin
          if andar then
            begin
              fio(10);
              mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
              putimage(mx,my,mergulhaep^,xorput);
              my := my-2;
              putimage(mx,my,mergulhaep^,xorput);
              fio(10);
            end
          else
            begin
              fio(10);
              mergulhaea := ptr(seg(grafs1^),ofs(grafs1^)+4002);
              putimage(mx,my,mergulhaea^,xorput);
              my := my-2;
              mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
              putimage(mx,my,mergulhaep^,xorput);
              fio(10);
            end;
        end;
    end
  else
    begin
      if my<150 then
        begin
          fio(7);
          mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
          putimage(mx,my,mergulhadp^,xorput);
          my := my-2;
          putimage(mx,my,mergulhadp^,xorput);
          fio(7);
        end
      else
        begin
          if andar then
            begin
              fio(7);
              mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
              putimage(mx,my,mergulhadp^,xorput);
              my := my-2;
              putimage(mx,my,mergulhadp^,xorput);
              fio(7);
            end
          else
            begin
              fio(7);
              mergulhada := ptr(seg(grafs1^),ofs(grafs1^)+4530);
              putimage(mx,my,mergulhada^,xorput);
              my := my-2;
              mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
              putimage(mx,my,mergulhadp^,xorput);
              fio(7);
            end;
        end;
    end;
  if (my=40) and (temitem<>0) then larga_item;
end; {* move_cima *}

procedure move_baixo;{ ***************************************************** }
var
  mergulhaep,mergulhadp : pointer;
begin
  if sentido = 'esq' then
    begin
      fio(10);
      mergulhaep := ptr(seg(grafs1^),ofs(grafs1^)+3738);
      putimage(mx,my,mergulhaep^,xorput);
      my := my+2;
      putimage(mx,my,mergulhaep^,xorput);
      fio(10);
    end
  else
    begin
      fio(7);
      mergulhadp := ptr(seg(grafs1^),ofs(grafs1^)+4266);
      putimage(mx,my,mergulhadp^,xorput);
      my := my+2;
      putimage(mx,my,mergulhadp^,xorput);
      fio(7);
    end;
  if my=150 then andar := true;
  if my>142 then apanha_item;
end; {* move_baixo *}

procedure move_balas;{ ***************************************************** }
var
  i    : byte;
  bala : pointer;
begin
  bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
  for i:= 1 to 3 do
    if tiro[i,1]<>-100 then
      begin
        putimage(tiro[i,1],tiro[i,2],bala^,xorput);
        if sentido = 'esq' then
          begin
            if tiro[i,1]<=mx-10 then
              tiro[i,1]:= tiro[i,1]-20
            else
              tiro[i,1]:= tiro[i,1]+20;
          end
        else
          begin
            if tiro[i,1]>=mx+18 then
              tiro[i,1]:= tiro[i,1]+20
            else
              tiro[i,1]:= tiro[i,1]-20;
          end;
        putimage(tiro[i,1],tiro[i,2],bala^,xorput);
        if (tiro[i,1]<10) or (tiro[i,1]>320) or (abs(tiro[i,1]-vtiro[i])>160) then
          begin
            putimage(tiro[i,1],tiro[i,2],bala^,xorput);
            tiro[i,1]:= -100;
          end;
      end;
end; {* move_balas *}

procedure mostrar_pontuacoes;{ ********************************************* }
var
  c : integer;
begin
  clearviewport;
  setcolor(2);
  settextstyle(triplexfont,horizdir,5);
  outtextxy(10,5,'TOP Glug-Glug');
  settextstyle(0,0,1);
  setcolor(3);
  for c := 1 to 10 do
    outtextxy(17,c*12+50,tabpont[c]);
  poe_pixel;
end;

procedure ler_nome( posx,posy : integer; var txt : string; pic : string);{ * }
var c,cmax : integer;
    parar  : boolean;
    tecla3 : char;

procedure por_caracter;
begin
  setcolor(3);
  outtextxy(posx,posy,tecla3);
  txt := txt + tecla3;
  posx := posx + 8;
  inc(c);
  if c <= cmax then
    repeat
      if pos(pic[c],'9#ALNX!$*') = 0 then
        begin
          outtextxy(posx,posy,pic[c]);
          txt := txt + pic[c];
          posx := posx + 8;
          inc(c);
        end;
    until pos(pic[c],'9#ALNX!$*') > 0;
end;

procedure apagar_caracter;
begin
  setcolor(0);
  posx := posx - 8;
  outtextxy(posx,posy,txt[length(txt)]);
  dec(c);
  delete(txt,length(txt),1);
  repeat
    if pos(pic[c],'9#ALNX!$*') = 0 then
      begin
        delete(txt,length(txt),1);
        posx := posx - 8;
        dec(c);
      end;
  until pos(pic[c],'9#ALNX!$*') > 0
end;

begin
  parar := false;
  txt := '';
  cmax := length(pic);
  for c := 1 to cmax do
    if pos(pic[c],'9#ALNX!$*') = 0 then
      begin
        outtextxy(c*8+posx,posy,pic[c]);
      end;
  c := 1;
  repeat
    repeat until keypressed;
    tecla3 := readkey;
    if ord(tecla3) > 31 then
      if c <= cmax then
        begin
          if pic[c] = '9' then
            begin
              if pos(tecla3,'0123456789') > 0 then
                por_caracter
            end
          else
            if pic[c] = 'X' then
              por_caracter;
    end;
    if ( ord(tecla3) = 8 ) and ( c > 1 ) then
      apagar_caracter;
    if ord(tecla3) = 13 then
      parar := true;
  until parar;
end; {* mostrar_pontuacoes *}

procedure verifica_pontuacao;{ ********************************************* }
var
  ang,rot       : real;
  c,posi,px,py  : integer;
  nome,ll,tn,tp : string;
  item          : pointer;

procedure abre_espaco;
var
  d : integer;
begin
  posi := 10;
  while (( pontos > tabnum[posi-1]) and ( posi > 2 )) do
    dec(posi);
  if pontos > tabnum[1] then
    dec(posi);
  for d := 10 downto posi+1 do
    begin
      tabpont[d] := tabpont[d-1];
      tabnum[d] := tabnum[d-1];
    end;
end;

begin
  if area = 91 then area:= 90;
  if pontos > tabnum[10] then
    begin
      clearviewport;
      ang := 6.283/50;
      rot := 0;
      item := ptr(seg(grafs1^),ofs(grafs1^)+5052);
      for c := 1 to 50 do
      begin
        px := round(cos(rot)*130+160);
        py := round(sin(rot)*60+79);
        putimage(px-8,py-8,item^,orput);
        rot := rot + ang;
        sound(round(cos(rot)*200)+1000);
        delay(10);
      end;
      nosound;
      setcolor(3);
      outtextxy(65,55,'PARABENS! BOA PONTUACAO!');
      setcolor(2);
      outtextxy(80,75,'INTRODUZA O SEU NOME');
      ler_nome(80,95,nome,'XXXXXXXXXXXXXXXXXXXX');
      for c := length(nome) to 19 do
        nome := nome + ' ';
      abre_espaco;
      tn:= chr(area);
      str(pontos:6,tp);
      ll := nome + '..    ' + tn + '   ' + tp;
      tabpont[posi] := ll;
      tabnum[posi] := pontos;
      mostrar_pontuacoes;
    end;
end; {* verifica_pontuacao *}

procedure apres_menu;{ ***************************************************** }
var
  cabeca,opcoes,pam : pointer;
  c : byte;
begin
  clearviewport;
  cabeca:= ptr(seg(grafs3^),ofs(grafs3^)+1592);
  opcoes:= ptr(seg(grafs3^),ofs(grafs3^)+8078);
  putimage(0,0,cabeca^,normalput);
  putimage(70,105,opcoes^,normalput);
  for c:= 0 to 3 do
    begin
      pam:= ptr(seg(grafs3^),ofs(grafs3^)+398*c);
      putimage(105,175,pam^,normalput);
      delay(vel*15);
    end;
  setcolor(3); settextstyle(0,0,1);
end; {* apres_menu *}

{$F+} 
procedure keyboardH; interrupt;{ ******************************************* }
var tecla : byte;
begin
  asm
    in  al,60h      
    mov tecla,al    
    in  al,61h      
    or  al,80h      
    out 61h,al
    and al,7fh      
    out 61h,al
    mov al,20h      
    out 20h,al
  end;
  case tecla of
    $1      : sai := true;
    $4b     : tec_e := true;
    $4b+$80 : tec_e := false;
    $4d     : tec_d := true;
    $4d+$80 : tec_d := false;
    $48     : tec_c := true;
    $48+$80 : tec_c := false;
    $50     : tec_b := true;
    $50+$80 : tec_b := false;
    $39     : tec_f := true;
    $39+$80 : tec_f := false;
    else;
  end;
end; {* keyboardH *}
{$F-}

procedure jogar;{ ********************************************************** }
begin
  inicio;
  tec_e := false; tec_d := false; tec_c := false ;
  tec_b := false; tec_f := false; sai := false;
  getintvec($09,oldint);
  setintvec($09,addr(keyboardH));
  repeat
    if tec_e and (bx>1)   then move_esquerda;
    if tec_d and (bx<235) then move_direita;
    if tec_c and (my>40)  then move_cima;
    if tec_b and (my<150) then move_baixo;
    if tec_f then disparo;
    if (tec_e) or (tec_d) or (tec_c) or (tec_b) then delay(vel2) else delay(vel);
    move_balas;
    mover_peixes(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,
                 mitem,bx,mx,my,sentido,pontos,max);
  until sai;
  setintvec($09,oldint);
  verifica_pontuacao;
  apres_menu;
  tecla:= #0; area:= 65; vidas:= 6; pontos:= 0; morreu:= false;
  bx:= 125; mx:= 156; my:= 40; sentido:= 'esq'; primeiro:=  true;
end; {* jogar *}

procedure ler_pontuacoes;{ ************************************************* }
var linha : string;
    c     : integer;
    pont  : longint;

procedure calcula_pontuacao;
var d,erro : integer;
    t      : string;
begin
  t := '';
  for d := 31 to 36 do
    t := t + linha[d];
  val(t,pont,erro);
end;

begin
  assign(fichpont,'gluglu.rec');
  reset(fichpont);
  for c := 1 to 10 do
    begin
      readln(fichpont,linha);
      tabpont[c] := linha;
      calcula_pontuacao;
      tabnum[c] := pont;
    end;
  close(fichpont);
  max:= tabnum[1];
end;

procedure gravar_pontuacoes;{ ********************************************** }
var c : integer;
begin
  assign(fichpont,'gluglu.rec');
  rewrite(fichpont);
  for c := 1 to 10 do
    writeln(fichpont,tabpont[c]);
  close(fichpont);
end; {* gravar_pontuacoes *}

procedure recordes;{ ******************************************************* }
begin
  mostrar_pontuacoes;
  apres_menu;
end; {* recordes *}

procedure escrever(py:integer; txt:string);{ ******************************* }
var
  c,cx,cy : integer;
  caneta  : pointer;
  c2      : byte;
begin
  setcolor(0);
  cy:= py*12 ; c2:= 0;
  for c := 1 to length(txt) do
    begin
      cx:= c*8;
      outtextxy(59+cx,cy,txt[c]);
      caneta := ptr(seg(grafs4^),ofs(grafs4^)+9318+726*c2);
      putimage(59+cx,cy+20,caneta^,xorput);
      if txt[c]<>' ' then
        begin
          c2:= c2+1;
          delay(vel*3);
        end;
      putimage(59+cx,cy+20,caneta^,xorput);
      if c2=3 then c2:= 0;
    end;
end; {* escrever *}

procedure instrucoes;{ ***************************************************** }
var
  folha : pointer;
begin
  clearviewport;
  folha := ptr(seg(grafs4^),ofs(grafs4^));
  putimage(65,1,folha^,normalput);
  settextstyle(5,0,1);
  escrever( 1,'       Instru‡”es       ');
  escrever( 3,'  Foram  detectados  v -');
  escrever( 4,'rios objectos  poluentes');
  escrever( 5,'no fundo  do m ar .     ');
  escrever( 6,'  A sua miss„o ser , re-');
  escrever( 7,'colhe-los pelas  vinte e');
  escrever( 8,'cinco …reas que perfazem');
  escrever( 9,'o  jogo . Alguns  destes');
  escrever(10,'objectos podem estar es-');
  escrever(11,'  ndidos sendo  necess -');
  escrever(12,'    vasculhar o leito do');
  escrever(14,'       P g. um  de duas.');
  tecla:= readkey;
  putimage(65,1,folha^,normalput);
  escrever( 1,'m ar .                  ');
  escrever( 2,'  Tenha  cuidado com  os');
  escrever( 3,'peixes,m oluscos e minas');
  escrever( 4,'que ir  encontrar , pois');
  escrever( 5,'estes ser-lhe-„o fatais.');
  escrever( 6,'  Para  m atar o tubar„o');
  escrever( 7,'azul, ‚ necess rio  dis-');
  escrever( 8,'parar sobre ele nove ve-');
  escrever( 9,'zes.                    ');
  escrever(10,'  Quanto …s m inas,estas');
  escrever(11,'  m  de ser torneadas.  ');
  escrever(14,'             Boa sorte! ');
  tecla:= readkey;
  apres_menu;
end; {* recordes *}

procedure velocidade;{ ***************************************************** }
var c     : integer;
    ss,x  : word;
begin
  c := 0;
  repeat
    gettime(x,x,x,ss);
  until ss < 5;
  repeat
    inc(c);
    gettime(x,x,x,ss);
  until ss > 40;
  if c < 1700  then
    begin
      vel := 24;
      vel2:= 0
    end
  else
  if (c > 1700) and (c < 2700) then
    begin
      vel := 60;
      vel2:= 65
    end
  else
    begin
      vel := 180;
      vel2:= 195;
    end;
end; {* velocidade *}


begin { ************************ modulo principal ************************** }
  abrir_modo_grafico;
  por_imagem;
  carrega_grafs1; carrega_grafs2;
  carrega_grafs3; carrega_grafs4;
  ler_pontuacoes;
  velocidade;
  script:= installuserfont('SCRI.CHR');
  repeat until keypressed;
  apres_menu;
  tecla:= #0; area:= 65; vidas:= 6; pontos:= 0; morreu:= false;
  bx:= 125; mx:= 156; my:= 40; sentido:= 'esq'; primeiro:=  true;
  repeat
    if keypressed then
      begin
        tecla := readkey;
        case tecla of
          #59 : jogar;
          #60 : recordes;
          #61 : instrucoes;
        end;
      end;
  until tecla = #27;
  gravar_pontuacoes;
  closegraph;
end.