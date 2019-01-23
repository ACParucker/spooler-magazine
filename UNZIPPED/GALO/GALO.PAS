program Galo;

{Programa - Telmo Menezes
 Gr ficos - Miguel Miraldo
 Set/94                   }

uses Graph,Graf256,Rato320,Crt,PalFX;

type
  jogador=record
    ns:byte;
    tj:boolean;
    nc:byte;
  end;

var
  s:array[0..17] of imm;
  n:array[0..9] of imm;
  m:array[0..3] of imm;
  f:array[1..6] of img;
  t:array[1..3,1..3] of byte;
  j:array[1..2] of jogador;
  x1,x2,x3,y1,y2,y3,ven:byte;
  pa,pm:longint;
  sj,sm:boolean;
  ef:pal;

procedure LimpT;        {Reinicializa tabuleiro de jogo}
  var
    k,l:byte;
  begin
    for k:=1 to 3 do
      for l:=1 to 3 do
        t[k,l]:=0;
  end;

procedure Inicio;       {procedimentos iniciais necess rios}
  var
    k:byte;
  begin
    IniGraf;
    IniRat;
    DesVid;
    DesRat;
    for k:=0 to 17 do
      CarImm('sim',s[k],k);
    for k:=0 to 9 do
      CarImm('num',n[k],k);
    for k:=0 to 3 do
      CarImm('men',m[k],k);
    sj:=false;
    pm:=0;
  end;

procedure EscSim(ix,iy,is:byte);   {Coloca s¡mbolo no tabuleiro}
  begin
    DesRat;
    EscImm(29+((ix-1)*46),26+((iy-1)*40),s[is]);
    LigRat;
  end;

procedure EscNum(ix,iy:word;nu:longint;ic:byte);   {Escreve n£mero}
  var
    alg:array[1..5] of byte;
    k:byte;
    n2:longint;
  begin
    n2:=nu;
    for k:=1 to 5 do begin
      alg[k]:=round(frac(n2/10)*10);
      n2:=round(int(n2/10));
    end;
    for k:=ic downto 1 do
      EscImm(ix+((5-k)*15),iy,n[alg[k]])
  end;

procedure Joga(ix,iy,nj:byte);      {Realiza jogada}
  begin
    t[ix,iy]:=nj;
    EscSim(ix,iy,j[nj].ns);
  end;

procedure DetJog(var ix,iy:byte);   {Detecta jogada humana}
  var
    rx,ry:word;
  begin
    repeat
      ix:=0;
      iy:=0;
      repeat until RatB<>0;
      if RatB=1 then begin
        rx:=RatX;
        ry:=RatY;
        if (rx>=29) and (rx<75) then ix:=1;
        if (rx>=75) and (rx<121) then ix:=2;
        if (rx>=121) and (rx<167) then ix:=3;
        if (ry>=26) and (ry<66) then iy:=1;
        if (ry>=66) and (ry<106) then iy:=2;
        if (ry>=106) and (ry<146) then iy:=3;
      end;
      if RatB=2 then sm:=false;
    until ((ix<>0) and (iy<>0)) or (not sm);
  end;

procedure JogH(nj:byte);            {Realiza jogada humana}
  var
    hx,hy:byte;
  begin
    if sm then begin
      repeat DetJog(hx,hy) until (t[hx,hy]=0) or (not sm);
      if sm then begin
        Joga(hx,hy,nj);
        sound(500);
        delay(10);
        nosound;
      end;
    end;
  end;

procedure ACol(nc:byte);         {Coordenadas das colunas}
  begin
    if nc<4 then begin
      x1:=1;
      x2:=2;
      x3:=3;
      y1:=nc;
      y2:=nc;
      y3:=nc;
    end;
    if (nc>=4) and (nc<7) then begin
      y1:=1;
      y2:=2;
      y3:=3;
      x1:=nc-3;
      x2:=nc-3;
      x3:=nc-3;
    end;
    if nc=7 then begin
      x1:=1;
      x2:=2;
      x3:=3;
      y1:=1;
      y2:=2;
      y3:=3;
    end;
    if nc=8 then begin
      x1:=1;
      x2:=2;
      x3:=3;
      y1:=3;
      y2:=2;
      y3:=1;
    end;
  end;

procedure PisCol(ic:byte);       {Pisca coluna}
  begin
    ACol(ic);
    putimage(29+((x1-1)*46),26+((y1-1)*40),s[j[t[x1,y1]].ns].im^,2);
    putimage(29+((x2-1)*46),26+((y2-1)*40),s[j[t[x2,y2]].ns].im^,2);
    putimage(29+((x3-1)*46),26+((y3-1)*40),s[j[t[x3,y3]].ns].im^,2);
    delay(25);
    EscSim(x1,y1,j[t[x1,y1]].ns);
    EscSim(x2,y2,j[t[x2,y2]].ns);
    EscSim(x3,y3,j[t[x3,y3]].ns);
    delay(25);
  end;

function JInfo(nj,nc:byte):byte;     {Ocupa‡ao das colunas}
  var
    ji:byte;
  begin
    ji:=0;
    ACol(nc);
    if t[x1,y1]=nj then ji:=ji+1;
    if t[x2,y2]=nj then ji:=ji+1;
    if t[x3,y3]=nj then ji:=ji+1;
    JInfo:=ji;
  end;

procedure JogP(var ix,iy:byte;nc:byte);    {Joga numa coluna}
  begin
    ACol(nc);
    if t[x1,y1]=0 then begin
      ix:=x1;
      iy:=y1;
    end;
    if t[x2,y2]=0 then begin
      ix:=x2;
      iy:=y2;
    end;
    if t[x3,y3]=0 then begin
      ix:=x3;
      iy:=y3;
    end;
  end;

procedure JogC(nj:byte);       {Calcula jogada do computador}
  var
    na:byte;
    k:byte;
    cx,cy:byte;
  begin
    if sm then begin
      randomize;
      delay(500);
      if nj=1 then na:=2 else na:=1;
      for k:=1 to 8 do if JInfo(na,k)+JInfo(nj,k)<3 then JogP(cx,cy,k);
      if j[nj].nc+1>random(10) then
        for k:=1 to 8 do if (JInfo(nj,k)=1) and (JInfo(na,k)=0) then JogP(cx,cy,k);
      if j[nj].nc+1>random(10) then
        for k:=1 to 8 do if (JInfo(na,k)=2) and (JInfo(nj,k)=0) then JogP(cx,cy,k);
      if j[nj].nc+1>random(10) then
        for k:=1 to 8 do if (JInfo(nj,k)=2) and (JInfo(na,k)=0) then JogP(cx,cy,k);
      Joga(cx,cy,nj);
      sound(1000);
      delay(10);
      nosound;
    end;
  end;

function AnaJog:byte;      {Analiza jogo}
  var
    k:byte;
    aj,cc:byte;
  begin
    aj:=0;
    cc:=0;
    for k:=1 to 3 do if JInfo(1,k)+JInfo(2,k)=3 then cc:=cc+1;
    if cc=3 then begin
      aj:=9;
      ven:=0;
    end;
    for k:=1 to 8 do if JInfo(1,k)=3 then begin
      aj:=k;
      ven:=1;
    end;
    for k:=1 to 8 do if JInfo(2,k)=3 then begin
      aj:=k;
      ven:=2;
    end;
    AnaJog:=aj;
  end;

procedure Jogo;         {Realiza um jogo}
  var
    k,jh,nc,vid:byte;
    cin,nor:pal;
    som,ini:boolean;
  begin
    sm:=true;
    jh:=0;
    pa:=0;
    if j[1].tj then jh:=1;
    if j[2].tj then
      if jh>0 then jh:=0 else jh:=2;
    vid:=0;
    if jh>0 then vid:=3;
    if jh>0 then
      if jh=1 then nc:=j[2].nc else nc:=j[1].nc;
    ini:=true;
    repeat;
      DesRat;
      if vid=0 then FadePCX('g3',10) else FadePCX('g3',2);
      EscNum(215,95,pm,5);
      EscNum(215,62,pa,5);
      if jh>0 then begin
        EscImm(203,130,s[j[jh].ns]);
        if vid>1 then EscImm(228,130,s[j[jh].ns]);
        if vid>2 then EscImm(253,130,s[j[jh].ns]);
      end;
      LigRat;
      LimpT;
      repeat
        if ini then begin
          if j[1].tj then JogH(1) else JogC(1);
          if AnaJog=0 then
            if j[2].tj then JogH(2) else JogC(2);
        end
        else begin
          if j[2].tj then JogH(2) else JogC(2);
          if AnaJog=0 then
            if j[1].tj then JogH(1) else JogC(1);
        end;
      until (AnaJog>0) or (not sm);
      if sm then begin
        if AnaJog=9 then begin
          LePal(cin);
          LePal(nor);
          MonoPal(cin,1,1,1);
          for k:=1 to 2 do begin
            Fade2(cin,2);
            Fade2(nor,2);
          end;
        end;
        if vid>0 then  begin
          if ven<>0 then
            if ven<>jh then begin
              vid:=vid-1;
              LePal(cin);
              LePal(nor);
              MonoPal(cin,1,0,0);
              Fade2(cin,5);
            end;
        end;
        if AnaJog<9 then begin
          DesRat;
          ACol(AnaJog);
          for k:=0 to 10 do begin
            if som then sound(1000);
            PisCol(AnaJog);
            som:=not som;
            nosound;
          end;
          LigRat;
        end;
        if ven=0 then pa:=pa+(nc*3)+1;
        if ven=jh then pa:=pa+(nc*9)+1;
        if pa>pm then pm:=pa;
        ini:=not ini;
      end;
    until (vid=0) or (not sm);
    FadeOff(10);
  end;

procedure Menu;            {Menu}
  var
    sm:boolean;
  begin
    sm:=false;
    DesRat;
    FadePCX('g2',10);
    LeImg(100,170,117,190,f[1]);
    LeImg(220,170,237,190,f[2]);
    LeImg(61,132,125,145,f[3]);
    LeImg(182,132,246,145,f[4]);
    LeImg(270,95,316,140,f[5]);
    LeImg(3,95,49,140,f[6]);
    EscNum(40,170,j[1].nc,1);
    EscNum(160,170,j[2].nc,1);
    if j[1].tj then EscImm(61,132,m[0]) else EscImm(61,132,m[1]);
    if j[2].tj then EscImm(182,132,m[2]) else EscImm(182,132,m[3]);
    EscImm(270,95,s[j[2].ns]);
    EscImm(3,95,s[j[1].ns]);
    LigRat;
    repeat
      if RAreaE(54,169,89,189) and (j[1].nc>0) then begin
        DesRat;
        j[1].nc:=j[1].nc-1;
        EscImg(100,170,0,f[1]);
        EscNum(40,170,j[1].nc,1);
        LigRat;
        delay(200);
      end;
      if RAreaE(126,167,158,191) and (j[1].nc<9) then begin
        j[1].nc:=j[1].nc+1;
        EscImg(100,170,0,f[1]);
        EscNum(40,170,j[1].nc,1);
        delay(200);
      end;
      if RAreaE(176,168,209,192) and (j[2].nc>0) then begin
        DesRat;
        j[2].nc:=j[2].nc-1;
        EscImg(220,170,0,f[2]);
        EscNum(160,170,j[2].nc,1);
        LigRat;
        delay(200);
      end;
      if RAreaE(245,167,270,191) and (j[2].nc<9) then begin
        j[2].nc:=j[2].nc+1;
        EscImg(220,170,0,f[2]);
        EscNum(160,170,j[2].nc,1);
        delay(200);
      end;
      if RAreaE(3,95,49,140) then begin
        j[1].ns:=j[1].ns+1;
        if j[1].ns=18 then j[1].ns:=0;
        if j[1].ns=j[2].ns then j[1].ns:=j[1].ns+1;
        if j[1].ns=18 then j[1].ns:=0;
        DesRat;
        EscImg(3,95,0,f[6]);
        EscImm(3,95,s[j[1].ns]);
        LigRat;
        delay(200);
      end;
      if RAreaE(270,95,316,140) then begin
        j[2].ns:=j[2].ns+1;
        if j[2].ns=18 then j[2].ns:=0;
        if j[1].ns=j[2].ns then j[2].ns:=j[2].ns+1;
        if j[2].ns=18 then j[2].ns:=0;
        DesRat;
        EscImg(270,95,0,f[5]);
        EscImm(270,95,s[j[2].ns]);
        LigRat;
        delay(200);
      end;
      if RAreaE(61,132,125,145) then begin
        j[1].tj:=not j[1].tj;
        DesRat;
        EscImg(61,132,0,f[3]);
        if j[1].tj then EscImm(61,132,m[0]) else EscImm(61,132,m[1]);
        LigRat;
        delay(200);
      end;
      if RAreaE(182,132,246,145) then begin
        j[2].tj:=not j[2].tj;
        DesRat;
        EscImg(182,132,0,f[4]);
        if j[2].tj then EscImm(182,132,m[2]) else EscImm(182,132,m[3]);
        LigRat;
        delay(200);
      end;
      if RAreaE(223,19,299,94) then sm:=true;
      if RAreaE(18,25,74,78) then begin
        sm:=true;
        sj:=true;
      end;
    until sm;
    FadeOff(10);
  end;

begin
  Inicio;
  FadePCX('g1',10);
  LePal(ef);
  MonoPal(ef,1,0,1);
  repeat until keypressed or (RatB<>0);
  Fade2(ef,10);
  FadeOff(3);
  LigRat;
  j[1].ns:=2;
  j[2].ns:=10;
  j[1].tj:=true;
  j[2].tj:=false;
  j[1].nc:=5;
  j[2].nc:=5;
  Menu;
  if not sj then
    repeat
      Jogo;
      Menu;
    until sj;
  FimGraf;
  writeln('Miguel Miraldo & Telmo Menezes - 1994');
end.