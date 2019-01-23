{******          GLUG-GLUG. Programado em Turbo Pascal  1993           ******}
{****** Autor: PAULO ALEXANDRE F. MOREIRA     Telef.9898076  Rio Tinto ******}

unit peixes;


interface

uses graph,crt;

type
  matrizp = array [1..7, 1..8] of integer; {*[x,y,ext,extot,inc,contfig,incfig,ntiros]*}
  matriz  = array [1..3, 1..2] of integer;

procedure escrever_maximo(var max:longint);
procedure escrever_pontuacao(var pontos,max:longint);
procedure escrever_vidas(vidas:integer);

procedure inicializa_peixe(i:byte; var mpeixe:matrizp; grafs2:pointer);
procedure peixe_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
procedure mata_peixe(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
procedure move_peixe(i:byte; var mpeixe:matrizp; grafs2:pointer);

procedure inicializa_piranha(i:byte; var mpeixe:matrizp; grafs2:pointer);
procedure piranha_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
procedure mata_piranha(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
procedure move_piranha(i:byte; var mpeixe:matrizp; grafs2:pointer; mx,my:word);

procedure inicializa_tubarao(i:byte; var mpeixe:matrizp; grafs2:pointer);
procedure tubarao_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
procedure mata_tubarao(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
procedure move_tubarao(i:byte; var mpeixe:matrizp; grafs2:pointer);

procedure inicializa_caranguejo(i:byte; var mpeixe:matrizp; grafs2:pointer);
procedure caranguejo_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
procedure move_caranguejo(i:byte; var mpeixe:matrizp; grafs2:pointer);

procedure inicializa_mina(i:byte; grafs2:pointer; fx,fy:byte);
procedure mina_mata_merg(i:byte; var morreu:boolean; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string; fx,fy:byte);

procedure inicializa_medusa(i:byte; var mpeixe:matrizp; grafs2:pointer);
procedure medusa_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
procedure mata_medusa(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
procedure move_medusa(i:byte; var mpeixe:matrizp; grafs2:pointer; mx,my:word);

procedure inicializa_lula(i:byte; var mpeixe:matrizp; grafs2:pointer);
procedure lula_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
procedure mata_lula(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
procedure move_lula(i:byte; var mpeixe:matrizp; grafs2:pointer);

procedure inicializa_tubarao2(i:byte; var mpeixe:matrizp; grafs1:pointer);
procedure tubarao2_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
procedure mata_tubarao2(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
procedure move_tubarao2(i:byte; var mpeixe:matrizp; grafs1:pointer);


implementation

procedure som4;{ ************************************************************ }
var s : integer;
begin
  for s := 1 to 20 do
    begin
      sound(s*100);
      delay(1);
    end;
  for s := 20 downto 1 do
    begin
      sound(s*100);
      delay(1);
    end;
  nosound;
end; {* som4 *}

procedure som5;{ ************************************************************ }
var s : integer;
begin
  for s := 1 to 20 do
    begin
      sound(s*50);
      delay(3);
    end;
  for s := 20 downto 1 do
    begin
      sound(s*50);
      delay(3);
    end;
  nosound;
end; {* som5 *}

procedure som6;{ ************************************************************ }
var s : integer;
begin
  for s := 1 to 60 do
    begin
      sound(s*random(50));
      delay(random(4));
    end;
  for s := 60 downto 1 do
    begin
      sound(s*random(50));
      delay(random(4));
    end;
  nosound;
end; {* som6 *}

procedure escrever_maximo(var max:longint);
var
  c    : integer;
  smax : string;
begin
  str(max:5,smax);
  for c := 1 to 5 do
    if smax[c] = #32 then
      smax[c] := #48;
  outtextxy(245,6,smax);
end; {* escrever_maximo *}

procedure escrever_pontuacao(var pontos,max:longint);
var
  c       : integer;
  spontos : string;
begin
  str(pontos:5,spontos);
  for c := 1 to 5 do
    if spontos[c] = #32 then
      spontos[c] := #48;
  outtextxy(112,6,spontos);
  if pontos > max then
    begin
      setcolor(1); escrever_maximo(max);
      setcolor(3); max:= pontos; escrever_maximo(max);
    end;
end; {* escrever_pontuacao *}

procedure escrever_vidas(vidas:integer);
var
  c : integer;
  svidas : string;
begin
  str(vidas:2,svidas);
  for c := 1 to 2 do
    if svidas[c] = #32 then
      svidas[c] := #48;
  outtextxy(290,1,svidas);
end;

procedure inicializa_peixe(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  r     : byte;
  peixe : pointer;
begin
  r:= random(2);
  if r = 0 then
    begin
      mpeixe[i,1]:= 0; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= 2; mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
    end
  else
    begin
      mpeixe[i,1]:= 292; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= -2; mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end;
  peixe := ptr(seg(grafs2^),ofs(grafs2^)+94*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
end; {* inicializa_peixe *}

procedure peixe_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
var
  peixe,merg : pointer;
  j : byte;
begin
  if (mpeixe[i,1]<=mx+3) and (mpeixe[i,1]+26>=mx+3) and
     (mpeixe[i,2]+11>=my) and (mpeixe[i,2]<=my+42) then
    begin
      peixe := ptr(seg(grafs2^),ofs(grafs2^)+94*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
      if mpeixe[i,6]>=3 then
        peixe := ptr(seg(grafs2^),ofs(grafs2^)+658)
      else
        peixe := ptr(seg(grafs2^),ofs(grafs2^)+564);
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+13) and (mpeixe[i,1]+26>=mx+13) and
          (mpeixe[i,2]+11>=my) and (mpeixe[i,2]<=my+42) then
    begin
      peixe := ptr(seg(grafs2^),ofs(grafs2^)+94*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
      if mpeixe[i,6]>=3 then
        peixe := ptr(seg(grafs2^),ofs(grafs2^)+658)
      else
        peixe := ptr(seg(grafs2^),ofs(grafs2^)+564);
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* peixe_mata_merg *}

procedure mata_peixe(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
var
  peixe,bala : pointer;
  j : byte;
begin
  for j:= 1 to 3 do
    if (tiro[j,1]+5<=mpeixe[i,1]+26) and (tiro[j,1]+5>=mpeixe[i,1]) and
       (tiro[j,2]>=mpeixe[i,2]) and (tiro[j,2]<=mpeixe[i,2]+11) then
      begin
        peixe := ptr(seg(grafs2^),ofs(grafs2^)+94*mpeixe[i,6]);
        putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
        bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
        putimage(tiro[j,1],tiro[j,2],bala^,xorput);
        if mpeixe[i,6]>=3 then
          peixe := ptr(seg(grafs2^),ofs(grafs2^)+658)
        else
          peixe := ptr(seg(grafs2^),ofs(grafs2^)+564);
        putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
        som4;
        setcolor(1); escrever_pontuacao(pontos,max);
        setcolor(3); pontos:= pontos+25; escrever_pontuacao(pontos,max);
        putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
        tiro[j,1]:= -100;
        inicializa_peixe(i,mpeixe,grafs2);
      end;
end; {* mata_peixe *}

procedure move_peixe(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  peixe : pointer;
begin
  peixe := ptr(seg(grafs2^),ofs(grafs2^)+94*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
  mpeixe[i,1]:= mpeixe[i,1]+mpeixe[i,5];
  mpeixe[i,6]:= mpeixe[i,6]+mpeixe[i,7];
  if (mpeixe[i,2]>40) and (mpeixe[i,2]<180) then mpeixe[i,2]:= mpeixe[i,2]-1+random(3)
    else if mpeixe[i,2]=40 then mpeixe[i,2]:= mpeixe[i,2]+1
      else if mpeixe[i,2]=180 then mpeixe[i,2]:= mpeixe[i,2]-1;
  mpeixe[i,3]:= mpeixe[i,3]+2;
  peixe := ptr(seg(grafs2^),ofs(grafs2^)+94*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
  if mpeixe[i,7]>0 then
    begin
      if (mpeixe[i,6]=2) or (mpeixe[i,6]=5) then mpeixe[i,7]:= -mpeixe[i,7]
    end
  else
    begin
      if (mpeixe[i,6]=0) or (mpeixe[i,6]=3) then mpeixe[i,7]:= -mpeixe[i,7];
    end;
  if (mpeixe[i,3] >= mpeixe[i,4]) or (mpeixe[i,1]<2) or (mpeixe[i,1]>292) then
    begin
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= -mpeixe[i,5];
      if mpeixe[i,5]>0 then
        begin
          mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
        end
      else
        begin
          mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
        end;
      peixe := ptr(seg(grafs2^),ofs(grafs2^)+94*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],peixe^,xorput);
    end;
end; {* move_peixe *}

procedure inicializa_piranha(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  r     : byte;
  piranha : pointer;
begin
  r:= random(2);
  if r = 0 then
    begin
      mpeixe[i,1]:= 0; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= 1; mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
    end
  else
    begin
      mpeixe[i,1]:= 298; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= -1; mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end;
  piranha := ptr(seg(grafs2^),ofs(grafs2^)+752+78*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
end; {* inicializa_piranha *}

procedure piranha_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
var
  piranha,merg : pointer;
  j : byte;
begin
  if (mpeixe[i,1]<=mx+3) and (mpeixe[i,1]+21>=mx+3) and
     (mpeixe[i,2]+12>=my) and (mpeixe[i,2]<=my+42) then
    begin
      piranha := ptr(seg(grafs2^),ofs(grafs2^)+752+78*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
      if mpeixe[i,6]>=3 then
        piranha := ptr(seg(grafs2^),ofs(grafs2^)+1298)
      else
        piranha := ptr(seg(grafs2^),ofs(grafs2^)+1220);
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+13) and (mpeixe[i,1]+21>=mx+13) and
          (mpeixe[i,2]+12>=my) and (mpeixe[i,2]<=my+42) then
    begin
      piranha := ptr(seg(grafs2^),ofs(grafs2^)+752+78*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
      if mpeixe[i,6]>=3 then
        piranha := ptr(seg(grafs2^),ofs(grafs2^)+1298)
      else
        piranha := ptr(seg(grafs2^),ofs(grafs2^)+1220);
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* piranha_mata_merg *}

procedure mata_piranha(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
var
  piranha,bala : pointer;
  j : byte;
begin
  for j:= 1 to 3 do
    if (tiro[j,1]+5<=mpeixe[i,1]+21) and (tiro[j,1]+5>=mpeixe[i,1]) and
       (tiro[j,2]>=mpeixe[i,2]) and (tiro[j,2]<=mpeixe[i,2]+12) then
      begin
        piranha := ptr(seg(grafs2^),ofs(grafs2^)+752+78*mpeixe[i,6]);
        putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
        bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
        putimage(tiro[j,1],tiro[j,2],bala^,xorput);
        if mpeixe[i,6]>=3 then
          piranha := ptr(seg(grafs2^),ofs(grafs2^)+1298)
        else
          piranha := ptr(seg(grafs2^),ofs(grafs2^)+1220);
        putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
        som4;
        setcolor(1); escrever_pontuacao(pontos,max);
        setcolor(3); pontos:= pontos+10; escrever_pontuacao(pontos,max);
        putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
        tiro[j,1]:= -100;
        inicializa_piranha(i,mpeixe,grafs2);
      end;
end; {* mata_piranha *}

procedure move_piranha(i:byte; var mpeixe:matrizp; grafs2:pointer; mx,my:word);
var
  piranha : pointer;
begin
  piranha := ptr(seg(grafs2^),ofs(grafs2^)+752+78*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
  if mpeixe[i,1]<=mx then
    begin
      if mpeixe[i,6]<3 then mpeixe[i,6]:= 4;
      mpeixe[i,1]:= mpeixe[i,1]+1
    end
  else
    begin
      if mpeixe[i,6]>2 then mpeixe[i,6]:= 1;
      mpeixe[i,1]:= mpeixe[i,1]-1;
    end;
  mpeixe[i,6]:= mpeixe[i,6]+mpeixe[i,7];
  if (mpeixe[i,2]>40) and (mpeixe[i,2]<180) then
    if mpeixe[i,2]>my then mpeixe[i,2]:= mpeixe[i,2]-random(3)
      else mpeixe[i,2]:= mpeixe[i,2]+random(3)
  else if mpeixe[i,2]<=40 then mpeixe[i,2]:= mpeixe[i,2]+1+random(2);
  mpeixe[i,3]:= mpeixe[i,3]+1;
  piranha := ptr(seg(grafs2^),ofs(grafs2^)+752+78*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
  if mpeixe[i,7]>0 then
    begin
      if (mpeixe[i,6]=2) or (mpeixe[i,6]=5) then mpeixe[i,7]:= -mpeixe[i,7]
    end
  else
    begin
      if (mpeixe[i,6]=0) or (mpeixe[i,6]=3) then mpeixe[i,7]:= -mpeixe[i,7];
    end;
  if (mpeixe[i,3] >= mpeixe[i,4]) or (mpeixe[i,1]<1) or (mpeixe[i,1]>298) then
    begin
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= -mpeixe[i,5];
      if mpeixe[i,5]>0 then
        begin
          mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
        end
      else
        begin
          mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
        end;
      piranha := ptr(seg(grafs2^),ofs(grafs2^)+752+78*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],piranha^,xorput);
    end;
end; {* move_piranha *}

procedure inicializa_tubarao(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  r     : byte;
  tubarao : pointer;
begin
  r:= random(2);
  if r = 0 then
    begin
      mpeixe[i,1]:= 0; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 165+random(100);
      mpeixe[i,5]:= 1; mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
    end
  else
    begin
      mpeixe[i,1]:= 266; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 165+random(100);
      mpeixe[i,5]:= -1; mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end;
  tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
end; {* inicializa_tubarao *}

procedure tubarao_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
var
  tubarao,merg,caifig : pointer;
  tamfig : word;
  j,cai : byte;
begin
  if (mpeixe[i,1]<=mx+3) and (mpeixe[i,1]+52>=mx+3) and
     (mpeixe[i,2]+24>=my) and (mpeixe[i,2]<=my+42) then
    begin
      tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      if mpeixe[i,6]>=3 then
        tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3770)
      else
        tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3428);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+13) and (mpeixe[i,1]+52>=mx+13) and
          (mpeixe[i,2]+24>=my) and (mpeixe[i,2]<=my+42) then
    begin
      tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      if mpeixe[i,6]>=3 then
        tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3770)
      else
        tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3428);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+9) and (mpeixe[i,1]+52>=mx+9) and
          (mpeixe[i,2]+24>=40) and (mpeixe[i,2]<=my) then
    begin
      tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      if mpeixe[i,6]>=3 then
        tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3770)
      else
        tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3428);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      tamfig := imagesize(mx,my,mx+17,my+42);
      getmem(caifig,tamfig);
      getimage(mx,my,mx+17,my+42,caifig^);
      putimage(mx,my,caifig^,xorput);
      for cai := my to 148 do
        begin
          putimage(mx,cai,caifig^,xorput);
          delay(25);
          putimage(mx,cai,caifig^,xorput);
        end;
      freemem(caifig,tamfig);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,148,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* tubarao_mata_merg *}

procedure mata_tubarao(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
var
  tubarao,bala : pointer;
  j : byte;
begin
  for j:= 1 to 3 do
    if (tiro[j,1]+5<=mpeixe[i,1]+52) and (tiro[j,1]+5>=mpeixe[i,1]) and
       (tiro[j,2]>=mpeixe[i,2]) and (tiro[j,2]<=mpeixe[i,2]+24) then
      begin
        tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
        putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
        bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
        putimage(tiro[j,1],tiro[j,2],bala^,xorput);
        if mpeixe[i,6]>=3 then
          tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3770)
        else
          tubarao := ptr(seg(grafs2^),ofs(grafs2^)+3428);
        putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
        som4;
        setcolor(1); escrever_pontuacao(pontos,max);
        setcolor(3); pontos:= pontos+125; escrever_pontuacao(pontos,max);
        putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
        tiro[j,1]:= -100;
        inicializa_tubarao(i,mpeixe,grafs2);
      end;
end; {* mata_tubarao *}

procedure move_tubarao(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  tubarao : pointer;
begin
  tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
  mpeixe[i,1]:= mpeixe[i,1]+mpeixe[i,5];
  mpeixe[i,6]:= mpeixe[i,6]+mpeixe[i,7];
  mpeixe[i,3]:= mpeixe[i,3]+1;
  tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
  if mpeixe[i,7]>0 then
    begin
      if (mpeixe[i,6]=2) or (mpeixe[i,6]=5) then mpeixe[i,7]:= -mpeixe[i,7]
    end
  else
    begin
      if (mpeixe[i,6]=0) or (mpeixe[i,6]=3) then mpeixe[i,7]:= -mpeixe[i,7];
    end;
  if (mpeixe[i,3] >= mpeixe[i,4]) or (mpeixe[i,1]<1) or (mpeixe[i,1]>265) then
    begin
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 165+random(100);
      mpeixe[i,5]:= -mpeixe[i,5];
      if mpeixe[i,5]>0 then
        begin
          mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
        end
      else
        begin
          mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
        end;
      tubarao := ptr(seg(grafs2^),ofs(grafs2^)+1376+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao^,xorput);
    end;
end; {* move_tubarao *}

procedure inicializa_caranguejo(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  r     : byte;
  caranguejo : pointer;
begin
  r:= random(2);
  if r = 0 then
    begin
      mpeixe[i,1]:= 0; mpeixe[i,2]:= 180;
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(120);
      mpeixe[i,5]:= 1+random(2); mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end
  else
    begin
      mpeixe[i,1]:= 300; mpeixe[i,2]:= 180;
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(120);
      mpeixe[i,5]:=-(1+random(2)); mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end;
  caranguejo := ptr(seg(grafs2^),ofs(grafs2^)+7344+110*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],caranguejo^,xorput);
end; {* inicializa_caranguejo *}

procedure caranguejo_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
var
  caranguejo,merg : pointer;
  j : byte;
begin
  if (mpeixe[i,1]<=mx+3) and (mpeixe[i,1]+16>=mx+3) and
     (mpeixe[i,2]+13>=my) and (mpeixe[i,2]<=my+42) then
    begin
      caranguejo := ptr(seg(grafs2^),ofs(grafs2^)+7344+110*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],caranguejo^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+13) and (mpeixe[i,1]+16>=mx+13) and
          (mpeixe[i,2]+13>=my) and (mpeixe[i,2]<=my+42) then
    begin
      caranguejo := ptr(seg(grafs2^),ofs(grafs2^)+7344+110*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],caranguejo^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* caranguejo_mata_merg *}

procedure move_caranguejo(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  caranguejo : pointer;
begin
  caranguejo := ptr(seg(grafs2^),ofs(grafs2^)+7344+110*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],caranguejo^,xorput);
  mpeixe[i,1]:= mpeixe[i,1]+mpeixe[i,5];
  mpeixe[i,6]:= mpeixe[i,6]+mpeixe[i,7];
  mpeixe[i,3]:= mpeixe[i,3]+mpeixe[i,5];
  caranguejo := ptr(seg(grafs2^),ofs(grafs2^)+7344+110*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],caranguejo^,xorput);
  if mpeixe[i,7]>0 then
    begin
      if mpeixe[i,6]=2 then mpeixe[i,7]:= -mpeixe[i,7]
    end
  else
    begin
      if mpeixe[i,6]=0 then mpeixe[i,7]:= -mpeixe[i,7];
    end;
  if (mpeixe[i,3] >= mpeixe[i,4]) or (mpeixe[i,1]<1) or (mpeixe[i,1]>300) then
    begin
      putimage(mpeixe[i,1],mpeixe[i,2],caranguejo^,xorput);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(120);
      mpeixe[i,5]:= -mpeixe[i,5];
      if mpeixe[i,5]>0 then
        begin
          mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
        end;
      caranguejo := ptr(seg(grafs2^),ofs(grafs2^)+7344+110*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],caranguejo^,xorput);
    end;
end; {* move_caranguejo *}

procedure inicializa_mina(i:byte; grafs2:pointer; fx,fy:byte);
var
  mina : pointer;
begin
  mina := ptr(seg(grafs2^),ofs(grafs2^)+7674);
  putimage(fx,fy,mina^,normalput);
  setcolor(1); setlinestyle(1,0,1);
  line(fx+14,fy+27,fx+14,192)
end; {* inicializa_mina *}

procedure explode_mina(grafs1:pointer; fx,fy:byte);
var
  z : byte;
  explosao : pointer;
begin
  for z:= 0 to 2 do
    begin
      explosao := ptr(seg(grafs1^),ofs(grafs1^)+7166+502*z);
      putimage(fx-15,fy,explosao^,normalput);
      som6;
    end;
  putimage(fx-15,fy,explosao^,xorput);
end;

procedure mina_mata_merg(i:byte; var morreu:boolean; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string; fx,fy:byte);
var
  mina,merg : pointer;
  j : byte;
begin
  if (fx<=mx+3) and (fx+26>=mx+3) and
     (fy+28>=my) and (fy<=my+42) then
    begin
      mina := ptr(seg(grafs2^),ofs(grafs2^)+7674);
      putimage(fx,fy,mina^,xorput);
      explode_mina(grafs1,fx,fy);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (fx<=mx+13) and (fx+26>=mx+13) and
          (fy+28>=my) and (fy<=my+42) then
    begin
      mina := ptr(seg(grafs2^),ofs(grafs2^)+7674);
      putimage(fx,fy,mina^,xorput);
      explode_mina(grafs1,fx,fy);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (fx+14=mx) or (fx+14=mx+16) then if (fy+28<=my) and (193>=my+42) then
    begin
      mina := ptr(seg(grafs2^),ofs(grafs2^)+7674);
      putimage(fx,fy,mina^,xorput);
      explode_mina(grafs1,fx,fy);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* mina_mata_merg *}

procedure inicializa_medusa(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  r     : byte;
  medusa : pointer;
begin
  r:= random(2);
  if r = 0 then
    begin
      mpeixe[i,1]:= 0; mpeixe[i,2]:= 40+random(120);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= 1; mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end
  else
    begin
      mpeixe[i,1]:= 282; mpeixe[i,2]:= 40+random(120);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= -1; mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end;
  medusa := ptr(seg(grafs2^),ofs(grafs2^)+4112+276*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
end; {* inicializa_medusa *}

procedure medusa_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
var
  medusa,merg : pointer;
  j : byte;
begin
  if (mpeixe[i,1]<=mx+3) and (mpeixe[i,1]+37>=mx+3) and
     (mpeixe[i,2]+25>=my) and (mpeixe[i,2]<=my+42) then
    begin
      medusa := ptr(seg(grafs2^),ofs(grafs2^)+4112+276*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
      medusa := ptr(seg(grafs2^),ofs(grafs2^)+4940);
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+13) and (mpeixe[i,1]+37>=mx+13) and
          (mpeixe[i,2]+25>=my) and (mpeixe[i,2]<=my+42) then
    begin
      medusa := ptr(seg(grafs2^),ofs(grafs2^)+4112+276*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
      medusa := ptr(seg(grafs2^),ofs(grafs2^)+4940);
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* medusa_mata_merg *}

procedure mata_medusa(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
var
  medusa,bala : pointer;
  j : byte;
begin
  for j:= 1 to 3 do
    if (tiro[j,1]+5<=mpeixe[i,1]+37) and (tiro[j,1]+5>=mpeixe[i,1]) and
       (tiro[j,2]>=mpeixe[i,2]) and (tiro[j,2]<=mpeixe[i,2]+25) then
      begin
        medusa := ptr(seg(grafs2^),ofs(grafs2^)+4112+276*mpeixe[i,6]);
        putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
        bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
        putimage(tiro[j,1],tiro[j,2],bala^,xorput);
        medusa := ptr(seg(grafs2^),ofs(grafs2^)+4940);
        putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
        som4;
        setcolor(1); escrever_pontuacao(pontos,max);
        setcolor(3); pontos:= pontos+10; escrever_pontuacao(pontos,max);
        putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
        tiro[j,1]:= -100;
        inicializa_medusa(i,mpeixe,grafs2);
      end;
end; {* mata_medusa *}

procedure move_medusa(i:byte; var mpeixe:matrizp; grafs2:pointer; mx,my:word);
var
  medusa : pointer;
begin
  medusa := ptr(seg(grafs2^),ofs(grafs2^)+4112+276*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
  mpeixe[i,1]:= mpeixe[i,1]+mpeixe[i,5];
  mpeixe[i,6]:= mpeixe[i,6]+mpeixe[i,7];
  if (mpeixe[i,2]>40) and (mpeixe[i,2]+25<190) then
    mpeixe[i,2]:= mpeixe[i,2]-1+random(3)
  else if mpeixe[i,2]<=40 then mpeixe[i,2]:= mpeixe[i,2]+1+random(2)
    else if mpeixe[i,2]+25>=190 then mpeixe[i,2]:= mpeixe[i,2]-(1+random(2));
  mpeixe[i,3]:= mpeixe[i,3]+1;
  medusa := ptr(seg(grafs2^),ofs(grafs2^)+4112+276*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
  if mpeixe[i,7]>0 then
    begin
      if mpeixe[i,6]=2 then mpeixe[i,7]:= -mpeixe[i,7]
    end
  else
    begin
      if mpeixe[i,6]=0 then mpeixe[i,7]:= -mpeixe[i,7];
    end;
  if (mpeixe[i,3] >= mpeixe[i,4]) or (mpeixe[i,1]<1) or (mpeixe[i,1]>282) then
    begin
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 180+random(100);
      mpeixe[i,5]:= -mpeixe[i,5];
      medusa := ptr(seg(grafs2^),ofs(grafs2^)+4112+276*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],medusa^,xorput);
    end;
end; {* move_medusa *}

procedure inicializa_lula(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  r    : byte;
  lula : pointer;
begin
  r:= random(2);
  if r = 0 then
    begin
      mpeixe[i,1]:= 0; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 0;
      mpeixe[i,5]:= 3+random(2); mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
    end
  else
    begin
      mpeixe[i,1]:= 278; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 0;
      mpeixe[i,5]:= -(3+random(2)); mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end;
  lula := ptr(seg(grafs2^),ofs(grafs2^)+5216+266*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
end; {* inicializa_lula *}

procedure lula_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
var
  lula,merg,caifig : pointer;
  tamfig : word;
  j,cai : byte;
begin
  if (mpeixe[i,1]<=mx+3) and (mpeixe[i,1]+37>=mx+3) and
     (mpeixe[i,2]+25>=my) and (mpeixe[i,2]<=my+42) then
    begin
      lula := ptr(seg(grafs2^),ofs(grafs2^)+5216+266*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
      if mpeixe[i,6]>=3 then
        lula := ptr(seg(grafs2^),ofs(grafs2^)+7078)
      else
        lula := ptr(seg(grafs2^),ofs(grafs2^)+6812);
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+13) and (mpeixe[i,1]+37>=mx+13) and
          (mpeixe[i,2]+25>=my) and (mpeixe[i,2]<=my+42) then
    begin
      lula := ptr(seg(grafs2^),ofs(grafs2^)+5216+266*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
      if mpeixe[i,6]>=3 then
        lula := ptr(seg(grafs2^),ofs(grafs2^)+7078)
      else
        lula := ptr(seg(grafs2^),ofs(grafs2^)+6812);
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* lula_mata_merg *}

procedure mata_lula(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
var
  lula,bala : pointer;
  j : byte;
begin
  for j:= 1 to 3 do
    if (tiro[j,1]+5<=mpeixe[i,1]+37) and (tiro[j,1]+5>=mpeixe[i,1]) and
       (tiro[j,2]>=mpeixe[i,2]) and (tiro[j,2]<=mpeixe[i,2]+25) then
      begin
        lula := ptr(seg(grafs2^),ofs(grafs2^)+5216+266*mpeixe[i,6]);
        putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
        bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
        putimage(tiro[j,1],tiro[j,2],bala^,xorput);
        if mpeixe[i,6]>=3 then
          lula := ptr(seg(grafs2^),ofs(grafs2^)+7078)
        else
          lula := ptr(seg(grafs2^),ofs(grafs2^)+6812);
        putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
        som4;
        setcolor(1); escrever_pontuacao(pontos,max);
        setcolor(3); pontos:= pontos+50; escrever_pontuacao(pontos,max);
        putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
        tiro[j,1]:= -100;
        inicializa_lula(i,mpeixe,grafs2);
      end;
end; {* mata_lula *}

procedure move_lula(i:byte; var mpeixe:matrizp; grafs2:pointer);
var
  lula : pointer;
begin
  lula := ptr(seg(grafs2^),ofs(grafs2^)+5216+266*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
  mpeixe[i,1]:= mpeixe[i,1]+mpeixe[i,5];
  mpeixe[i,6]:= mpeixe[i,6]+mpeixe[i,7];
  lula := ptr(seg(grafs2^),ofs(grafs2^)+5216+266*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
  if mpeixe[i,7]>0 then
    begin
      if (mpeixe[i,6]=2) or (mpeixe[i,6]=5) then mpeixe[i,7]:= -mpeixe[i,7]
    end
  else
    begin
      if (mpeixe[i,6]=0) or (mpeixe[i,6]=3) then mpeixe[i,7]:= -mpeixe[i,7];
    end;
  if (mpeixe[i,1]<3) or (mpeixe[i,1]>278) then
    begin
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
      mpeixe[i,5]:= -mpeixe[i,5];
      if mpeixe[i,5]>0 then
        begin
          mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
        end
      else
        begin
          mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
        end;
      lula := ptr(seg(grafs2^),ofs(grafs2^)+5216+266*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],lula^,xorput);
    end;
end; {* move_lula *}

procedure inicializa_tubarao2(i:byte; var mpeixe:matrizp; grafs1:pointer);
var
  r     : byte;
  tubarao2 : pointer;
begin
  r:= random(2);
  if r = 0 then
    begin
      mpeixe[i,1]:= 0; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 165+random(100);
      mpeixe[i,5]:= 1; mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
    end
  else
    begin
      mpeixe[i,1]:= 266; mpeixe[i,2]:= 40+random(130);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 165+random(100);
      mpeixe[i,5]:= -1; mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
    end;
  mpeixe[i,8]:= 0;
  tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
end; {* inicializa_tubarao2 *}

procedure tubarao2_mata_merg(i:byte; var morreu:boolean; var mpeixe:matrizp; grafs2,grafs1:pointer;
          var bx,mx,my:word; sentido:string);
var
  tubarao2,merg,caifig : pointer;
  tamfig : word;
  j,cai : byte;
begin
  if (mpeixe[i,1]<=mx+3) and (mpeixe[i,1]+52>=mx+3) and
     (mpeixe[i,2]+24>=my) and (mpeixe[i,2]<=my+42) then
    begin
      tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      if mpeixe[i,6]>=3 then
        tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3770)
      else
        tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3428);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+13) and (mpeixe[i,1]+52>=mx+13) and
          (mpeixe[i,2]+24>=my) and (mpeixe[i,2]<=my+42) then
    begin
      tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      if mpeixe[i,6]>=3 then
        tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3770)
      else
        tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3428);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,my,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end
  else if (mpeixe[i,1]<=mx+9) and (mpeixe[i,1]+52>=mx+9) and
          (mpeixe[i,2]+24>=40) and (mpeixe[i,2]<=my) then
    begin
      tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      if mpeixe[i,6]>=3 then
        tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3770)
      else
        tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3428);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      som4;
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      tamfig := imagesize(mx,my,mx+17,my+42);
      getmem(caifig,tamfig);
      getimage(mx,my,mx+17,my+42,caifig^);
      putimage(mx,my,caifig^,xorput);
      for cai := my to 148 do
        begin
          putimage(mx,cai,caifig^,xorput);
          delay(25);
          putimage(mx,cai,caifig^,xorput);
        end;
      freemem(caifig,tamfig);
      if sentido = 'esq' then
        merg := ptr(seg(grafs2^),ofs(grafs2^)+7912)
      else merg := ptr(seg(grafs2^),ofs(grafs2^)+8188);
      putimage(mx,148,merg^,normalput);
      for j:=1 to 3 do
        som5;
      delay(1000);
      morreu:= true;
    end;
end; {* tubarao2_mata_merg *}

procedure mata_tubarao2(i:byte; var mpeixe:matrizp; grafs2,grafs1:pointer; var tiro:matriz; var pontos,max:longint);
var
  tubarao2,bala : pointer;
  j : byte;
begin
  for j:= 1 to 3 do
    if (tiro[j,1]+5<=mpeixe[i,1]+52) and (tiro[j,1]+5>=mpeixe[i,1]) and
       (tiro[j,2]>=mpeixe[i,2]) and (tiro[j,2]<=mpeixe[i,2]+24) then
      begin
        mpeixe[i,8]:= mpeixe[i,8]+1;
        bala := ptr(seg(grafs1^),ofs(grafs1^)+3724);
        putimage(tiro[j,1],tiro[j,2],bala^,xorput);
        tiro[j,1]:= -100;
        if mpeixe[i,8] = 9 then
          begin
            tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
            putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
            if mpeixe[i,6]>=3 then
              tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3770)
            else
              tubarao2 := ptr(seg(grafs2^),ofs(grafs2^)+3428);
            putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
            som4;
            setcolor(1); escrever_pontuacao(pontos,max);
            setcolor(3); pontos:= pontos+200; escrever_pontuacao(pontos,max);
            putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
            inicializa_tubarao2(i,mpeixe,grafs2);
            tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
            putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
          end;
      end;
end; {* mata_tubarao2 *}

procedure move_tubarao2(i:byte; var mpeixe:matrizp; grafs1:pointer);
var
  tubarao2 : pointer;
begin
  tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
  mpeixe[i,1]:= mpeixe[i,1]+mpeixe[i,5];
  mpeixe[i,6]:= mpeixe[i,6]+mpeixe[i,7];
  mpeixe[i,3]:= mpeixe[i,3]+1;
  tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
  putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
  if mpeixe[i,7]>0 then
    begin
      if (mpeixe[i,6]=2) or (mpeixe[i,6]=5) then mpeixe[i,7]:= -mpeixe[i,7]
    end
  else
    begin
      if (mpeixe[i,6]=0) or (mpeixe[i,6]=3) then mpeixe[i,7]:= -mpeixe[i,7];
    end;
  if (mpeixe[i,3] >= mpeixe[i,4]) or (mpeixe[i,1]<1) or (mpeixe[i,1]>265) then
    begin
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
      mpeixe[i,3]:= 0; mpeixe[i,4]:= 165+random(100);
      mpeixe[i,5]:= -mpeixe[i,5];
      if mpeixe[i,5]>0 then
        begin
          mpeixe[i,6]:= 3; mpeixe[i,7]:= 1;
        end
      else
        begin
          mpeixe[i,6]:= 0; mpeixe[i,7]:= 1;
        end;
      tubarao2 := ptr(seg(grafs1^),ofs(grafs1^)+5114+342*mpeixe[i,6]);
      putimage(mpeixe[i,1],mpeixe[i,2],tubarao2^,xorput);
    end;
end; {* move_tubarao2 *}

end.
