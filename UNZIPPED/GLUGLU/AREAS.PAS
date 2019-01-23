{******          GLUG-GLUG. Programado em Turbo Pascal  1993           ******}
{****** Autor: PAULO ALEXANDRE F. MOREIRA     Telef.9898076  Rio Tinto ******}

unit areas;


interface

uses graph,crt,peixes;

procedure coloca_items(var mitem:matriz; grafs1:pointer; var temitem,totitem:byte);
procedure inicio2(var sai:boolean; grafs1:pointer; var mitem,tiro:matriz; var bx,mx,my:word; pontos,max:longint;
             var area,vidas,temitem:byte);
procedure mover_peixes(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; var grafs2,grafs1:pointer;
             var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz;
             var bx,mx,my:word; var sentido:string; var pontos,max:longint);


implementation

var primeiro2 : boolean;

procedure coloca_items(var mitem:matriz; grafs1:pointer; var temitem,totitem:byte);
var
  item : pointer;
  i    : byte;
begin
  totitem:= 0;
  temitem:= 0;
  randomize;
  for i:= 1 to 3 do
    begin
      mitem[i,1] := 40+random(230); mitem[i,2] := 1+random(4);
      item := ptr(seg(grafs1^),ofs(grafs1^)+4804+62*mitem[i,2]);
      putimage(mitem[i,1],179,item^,xorput);
    end;
end; {* coloca_items *}

procedure coloca_items2(mitem:matriz; grafs1:pointer; var temitem:byte);
var
  item : pointer;
  i    : byte;
begin
  randomize;
  for i:= 1 to 3 do
    if mitem[i,1] <> 0 then
      begin
        item := ptr(seg(grafs1^),ofs(grafs1^)+4804+62*mitem[i,2]);
        putimage(mitem[i,1],179,item^,xorput);
      end;
  temitem:= 0;
end; {* coloca_items *}

procedure inicio2(var sai:boolean; grafs1:pointer; var mitem,tiro:matriz; var bx,mx,my:word; var pontos,max:longint;
             var area,vidas,temitem:byte);
var
  cabecalho,chao,item   : pointer;
  fiog,barco,mergulhaep : pointer;
  i : byte;
begin
  if area = 91 then
    begin
      setcolor(1); escrever_pontuacao(pontos,max);
      setcolor(3); pontos:= pontos+5000; escrever_pontuacao(pontos,max);
      settextstyle(5,0,2); outtextxy(120,80,'Parabens!');
      settextstyle(5,0,1);
      outtextxy(10,110,'As 25 areas do jogo est„o completas.');
      settextstyle(0,0,1); delay(4000);
      sai:= true;
    end
  else if vidas = 0 then
    begin
      setcolor(1); settextstyle(2,0,4); escrever_vidas(vidas+1);
      setcolor(3); escrever_vidas(vidas);
      settextstyle(5,0,4); outtextxy(80,100,'Fim do jogo');
      settextstyle(0,0,1); delay(3000);
      sai:= true;
    end
  else
    begin
      for i:= 1 to 3 do
        begin
          tiro[i,1]:= -100; tiro[i,2]:= 0;
        end;
      bx := 125; mx := 156; my := 40;
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
      setcolor(3); escrever_pontuacao(pontos,max); escrever_maximo(max);
      if not primeiro2 then
        case area of
          70  : vidas:= vidas+2;
          75  : vidas:= vidas+2;
          80  : vidas:= vidas+2;
          85  : vidas:= vidas+2;
        end;
      primeiro2:= false;
      settextstyle(2,0,4); escrever_vidas(vidas); settextstyle(0,0,1);
      coloca_items2(mitem,grafs1,temitem);
    end;
end; {* inicio2 *}

procedure morte(var sai,primeiro:boolean; grafs1:pointer; var mitem,tiro:matriz; var bx,mx,my:word; var sentido:string;
          pontos,max:longint; var area,vidas,temitem:byte);
begin
  vidas:= vidas-1;
  primeiro2:= true;
  inicio2(sai,grafs1,mitem,tiro,bx,mx,my,pontos,max,area,vidas,temitem);
  primeiro:= true; sentido:= 'esq';
end; {* morte *}

procedure area_a(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 6 do
        inicializa_peixe(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_peixe(i,mpeixe,grafs2);
    mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=7);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
end; {* area_a *}

procedure area_b(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 4 do
        inicializa_peixe(i,mpeixe,grafs2);
      for i:= 5 to 6 do
        inicializa_medusa(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_peixe(i,mpeixe,grafs2);
    mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=5);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_medusa(i,mpeixe,grafs2,mx,my);
        mata_medusa(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        medusa_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_b *}

procedure area_c(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(180,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 4 do
        inicializa_peixe(i,mpeixe,grafs2);
      for i:= 5 to 6 do
        inicializa_piranha(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_peixe(i,mpeixe,grafs2);
    mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=5);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_c *}

procedure area_d(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(70,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 3 do
        inicializa_medusa(i,mpeixe,grafs2);
      for i:= 4 to 6 do
        inicializa_piranha(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_medusa(i,mpeixe,grafs2,mx,my);
    mata_medusa(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    medusa_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=4);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_d *}

procedure area_e(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(280,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 4 do
        inicializa_piranha(i,mpeixe,grafs2);
      for i:= 5 to 6 do
        inicializa_lula(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_piranha(i,mpeixe,grafs2,mx,my);
    mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=5);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_lula(i,mpeixe,grafs2);
        mata_lula(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        lula_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_e *}

procedure area_f(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 3 do
        inicializa_medusa(i,mpeixe,grafs2);
      for i:= 4 to 6 do
        inicializa_caranguejo(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_medusa(i,mpeixe,grafs2,mx,my);
    mata_medusa(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    medusa_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=4);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_caranguejo(i,mpeixe,grafs2);
        caranguejo_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_f *}

procedure area_g(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 3 do
        inicializa_lula(i,mpeixe,grafs2);
      for i:= 4 to 6 do
        inicializa_caranguejo(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_lula(i,mpeixe,grafs2);
    mata_lula(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    lula_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=4);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_caranguejo(i,mpeixe,grafs2);
        caranguejo_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_g *}

procedure area_h(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(200,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(80,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 4 do
        inicializa_piranha(i,mpeixe,grafs2);
      for i:= 5 to 6 do
        inicializa_caranguejo(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_piranha(i,mpeixe,grafs2,mx,my);
    mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=5);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_caranguejo(i,mpeixe,grafs2);
        caranguejo_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_h *}

procedure area_i(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(90,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(130,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(150,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 6 do
        inicializa_piranha(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_piranha(i,mpeixe,grafs2,mx,my);
    mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=7);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
end; {* area_i *}

procedure area_j(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
            var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
            var sentido:string; var pontos,max:longint);
var
  i : byte;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 3 do
        inicializa_peixe(i,mpeixe,grafs2);
      for i:= 4 to 6 do
        inicializa_lula(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_peixe(i,mpeixe,grafs2);
    mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=4);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_lula(i,mpeixe,grafs2);
        mata_lula(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        lula_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_j *}

procedure area_k(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(200,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(80,179,caveira^,xorput);
      putimage(110,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 3 do
        inicializa_tubarao(i,mpeixe,grafs2);
      for i:= 4 to 6 do
        inicializa_caranguejo(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_tubarao(i,mpeixe,grafs2);
    mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=4);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_caranguejo(i,mpeixe,grafs2);
        caranguejo_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_k *}

procedure area_l(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(160,179,caveira^,xorput);
      putimage(190,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 2 do
        inicializa_peixe(i,mpeixe,grafs2);
      for i:= 3 to 4 do
        inicializa_piranha(i,mpeixe,grafs2);
      for i:= 5 to 6 do
        inicializa_tubarao(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_peixe(i,mpeixe,grafs2);
    mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=3);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=5);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao(i,mpeixe,grafs2);
        mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_l *}

procedure area_m(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      for i:= 1 to 1 do
        inicializa_mina(i,grafs2,100,100);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_mina(i,grafs2,100,100);
      for i:= 2 to 7 do
        inicializa_peixe(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    mina_mata_merg(i,morreu,grafs2,grafs1,bx,mx,my,sentido,100,100);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_peixe(i,mpeixe,grafs2);
        mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=8);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_m *}

procedure area_n(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(300,179,caveira^,xorput);
      putimage(210,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(190,179,caveira^,xorput);
      putimage(90,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_tubarao(i,mpeixe,grafs2);
      for i:= 2 to 6 do
        inicializa_piranha(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_tubarao(i,mpeixe,grafs2);
    mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_n *}

procedure area_o(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(230,179,caveira^,xorput);
      putimage(210,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(190,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 2 do
        inicializa_tubarao2(i,mpeixe,grafs1);
      for i:= 3 to 6 do
        inicializa_peixe(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_tubarao2(i,mpeixe,grafs1);
    mata_tubarao2(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    tubarao2_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=3);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_peixe(i,mpeixe,grafs2);
        mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_o *}

procedure area_p(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(50,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(160,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_tubarao2(i,mpeixe,grafs1);
      for i:= 2 to 6 do
        inicializa_caranguejo(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_tubarao2(i,mpeixe,grafs1);
    mata_tubarao2(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    tubarao2_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_caranguejo(i,mpeixe,grafs2);
        caranguejo_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_p *}

procedure area_q(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(130,179,caveira^,xorput);
      putimage(290,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(80,179,caveira^,xorput);
      for i:= 1 to 1 do
        inicializa_mina(i,grafs2,160,120);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_mina(i,grafs2,160,120);
      for i:= 2 to 7 do
        inicializa_piranha(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    mina_mata_merg(i,morreu,grafs2,grafs1,bx,mx,my,sentido,160,120);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=8);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_q *}

procedure area_r(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(110,179,caveira^,xorput);
      putimage(220,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(280,179,caveira^,xorput);
      for i:= 1 to 1 do
        inicializa_mina(i,grafs2,200,90);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_mina(i,grafs2,200,90);
      for i:= 2 to 5 do
        inicializa_piranha(i,mpeixe,grafs2);
      for i:= 6 to 6 do
        inicializa_tubarao(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    mina_mata_merg(i,morreu,grafs2,grafs1,bx,mx,my,sentido,200,90);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=6);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao(i,mpeixe,grafs2);
        mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_r *}

procedure area_s(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(120,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 3 do
        inicializa_peixe(i,mpeixe,grafs2);
      for i:= 4 to 5 do
        inicializa_piranha(i,mpeixe,grafs2);
      for i:= 6 to 7 do
        inicializa_caranguejo(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_peixe(i,mpeixe,grafs2);
    mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=4);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=6);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_caranguejo(i,mpeixe,grafs2);
        caranguejo_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=8);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_s *}

procedure area_t(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(240,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(100,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 2 do
        inicializa_tubarao(i,mpeixe,grafs2);
      for i:= 3 to 6 do
        inicializa_peixe(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_tubarao(i,mpeixe,grafs2);
    mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=3);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_peixe(i,mpeixe,grafs2);
        mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_t *}

procedure area_u(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(110,179,caveira^,xorput);
      putimage(200,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_lula(i,mpeixe,grafs2);
      for i:= 2 to 5 do
        inicializa_piranha(i,mpeixe,grafs2);
      for i:= 6 to 6 do
        inicializa_tubarao(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_lula(i,mpeixe,grafs2);
    mata_lula(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    lula_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=6);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao(i,mpeixe,grafs2);
        mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_u *}

procedure area_v(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      inicializa_mina(1,grafs2,200,120);
      inicializa_mina(2,grafs2,100,90);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      inicializa_mina(1,grafs2,200,120);
      inicializa_mina(2,grafs2,100,90);
      for i:= 3 to 7 do
        inicializa_peixe(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  mina_mata_merg(i,morreu,grafs2,grafs1,bx,mx,my,sentido,200,120);
  i:=i+1;
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      mina_mata_merg(i,morreu,grafs2,grafs1,bx,mx,my,sentido,100,90);
      i:=i+1;
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_peixe(i,mpeixe,grafs2);
        mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=8);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_v *}

procedure area_w(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(180,179,caveira^,xorput);
      putimage(220,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_medusa(i,mpeixe,grafs2);
      for i:= 2 to 5 do
        inicializa_peixe(i,mpeixe,grafs2);
      for i:= 6 to 6 do
        inicializa_tubarao2(i,mpeixe,grafs1);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_medusa(i,mpeixe,grafs2,mx,my);
    mata_medusa(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    medusa_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_peixe(i,mpeixe,grafs2);
        mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=6);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao2(i,mpeixe,grafs1);
        mata_tubarao2(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao2_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_w *}

procedure area_x(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(120,179,caveira^,xorput);
      putimage(150,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_medusa(i,mpeixe,grafs2);
      for i:= 2 to 4 do
        inicializa_peixe(i,mpeixe,grafs2);
      for i:= 5 to 5 do
        inicializa_tubarao2(i,mpeixe,grafs1);
      for i:= 6 to 6 do
        inicializa_tubarao(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_medusa(i,mpeixe,grafs2,mx,my);
    mata_medusa(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    medusa_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_peixe(i,mpeixe,grafs2);
        mata_peixe(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        peixe_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=5);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao2(i,mpeixe,grafs1);
        mata_tubarao2(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao2_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=6);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao(i,mpeixe,grafs2);
        mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_x *}

procedure area_y(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(80,179,caveira^,xorput);
      putimage(210,179,caveira^,xorput);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      for i:= 1 to 1 do
        inicializa_lula(i,mpeixe,grafs2);
      for i:= 2 to 4 do
        inicializa_piranha(i,mpeixe,grafs2);
      for i:= 5 to 5 do
        inicializa_tubarao2(i,mpeixe,grafs1);
      for i:= 6 to 6 do
        inicializa_tubarao(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  repeat
    move_lula(i,mpeixe,grafs2);
    mata_lula(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
    lula_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
    i:=i+1;
  until (morreu) or (i=2);
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=5);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao2(i,mpeixe,grafs1);
        mata_tubarao2(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao2_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=6);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_tubarao(i,mpeixe,grafs2);
        mata_tubarao(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        tubarao_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=7);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_y *}

procedure area_z(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz; var bx,mx,my:word;
          var sentido:string; var pontos,max:longint);
var
  i : byte;
  caveira : pointer;
begin
  randomize;
  if primeiro then
    begin
      if not morreu then coloca_items(mitem,grafs1,temitem,totitem);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8464);
      putimage(120,179,caveira^,xorput);
      putimage(250,179,caveira^,xorput);
      caveira := ptr(seg(grafs2^),ofs(grafs2^)+8526);
      putimage(170,179,caveira^,xorput);
      inicializa_mina(1,grafs2,210,85);
      inicializa_mina(2,grafs2,130,110);
      setcolor(3); settextstyle(5,0,4); outtextxy(115,100,'Area '+chr(area));
      delay (3000);
      setcolor(0); outtextxy(115,100,'Area '+chr(area)); settextstyle(0,0,1);
      inicializa_mina(1,grafs2,210,85);
      inicializa_mina(2,grafs2,130,110);
      for i:= 3 to 7 do
        inicializa_piranha(i,mpeixe,grafs2);
    end;
  primeiro:= false; morreu:= false; i:=1;
  mina_mata_merg(i,morreu,grafs2,grafs1,bx,mx,my,sentido,210,85);
  i:=i+1;
  if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
  if not morreu then
    begin
      mina_mata_merg(i,morreu,grafs2,grafs1,bx,mx,my,sentido,130,110);
      i:=i+1;
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
  if not morreu then
    begin
      repeat
        move_piranha(i,mpeixe,grafs2,mx,my);
        mata_piranha(i,mpeixe,grafs2,grafs1,tiro,pontos,max);
        piranha_mata_merg(i,morreu,mpeixe,grafs2,grafs1,bx,mx,my,sentido);
        i:=i+1;
      until (morreu) or (i=8);
      if morreu then morte(sai,primeiro,grafs1,mitem,tiro,bx,mx,my,sentido,pontos,max,area,vidas,temitem);
    end;
end; {* area_z *}

procedure mover_peixes(var sai,primeiro,morreu:boolean; var mpeixe:matrizp; var grafs2,grafs1:pointer;
             var area,vidas,temitem,totitem:byte; var tiro,mitem:matriz;
             var bx,mx,my:word; var sentido:string; var pontos,max:longint);
begin
  case area of
    65  : area_a(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    66  : area_b(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    67  : area_c(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    68  : area_d(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    69  : area_e(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    70  : area_f(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    71  : area_g(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    72  : area_h(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    73  : area_i(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    74  : area_j(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    75  : area_k(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    76  : area_l(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    77  : area_m(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    78  : area_n(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    79  : area_o(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    80  : area_p(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    81  : area_q(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    82  : area_r(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    83  : area_s(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    84  : area_t(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    85  : area_u(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    86  : area_v(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    87  : area_w(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    88  : area_x(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    89  : area_y(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
    90  : area_z(sai,primeiro,morreu,mpeixe,grafs2,grafs1,area,vidas,temitem,totitem,tiro,mitem,bx,mx,my,sentido,pontos,max);
  end;
end; {* mover_peixes *}

end.
