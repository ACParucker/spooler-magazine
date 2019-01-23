unit PalFX;          {Telmo Menezes - 1994}

interface

uses Graf256,Crt;

type
  PalAf=array[0..255] of boolean;

var
  PAf:PalAf;
  pafk:byte;

procedure DefPAf(ipa:PalAf);
procedure MonoPal(var ip:pal;ir,ig,ib:real);
procedure EsbPal(var ip:pal);
procedure EscurPal(var ip:pal;ie:byte);
procedure ClarPal(var ip:pal;ie:byte);
procedure FadeOff(is:word);
procedure Fade2(ip:pal;is:word);
procedure FadePCX(is:string;iw:word);

implementation

procedure DefPAf(ipa:PalAf);
begin
  PAf:=ipa;
end;

procedure MonoPal(var ip:pal;ir,ig,ib:real);
  var
    n,m:byte;
  begin
    for n:=0 to 255 do if PAf[n] then begin
      m:=round((ip[n].r*0.3)+(ip[n].g*0.59)+(ip[n].b*0.11));
      ip[n].r:=round(m*ir);
      ip[n].g:=round(m*ig);
      ip[n].b:=round(m*ib);
    end;
  end;

procedure EsbPal(var ip:pal);
  var
    n:byte;
  begin
    for n:=0 to 255 do if PAf[n] then begin
      ip[n].r:=round((ip[n].r*0.3)+(ip[n].g*0.59)+(ip[n].b*0.11));
      ip[n].g:=round((ip[n].r*0.3)+(ip[n].g*0.59)+(ip[n].b*0.11));
      ip[n].b:=round((ip[n].r*0.3)+(ip[n].g*0.59)+(ip[n].b*0.11));
    end;
  end;

procedure EscurPal(var ip:pal;ie:byte);
  var
    n,m:byte;
  begin
    for m:=1 to ie do begin
      for n:=0 to 255 do if PAf[n] then begin
        if ip[n].r>1 then ip[n].r:=ip[n].r-1
          else ip[n].r:=0;
        if ip[n].g>1 then ip[n].g:=ip[n].g-1
          else ip[n].g:=0;
        if ip[n].b>1 then ip[n].b:=ip[n].b-1
          else ip[n].b:=0;
      end;
    end;
  end;

procedure ClarPal(var ip:pal;ie:byte);
  var
    n,m:byte;
  begin
    for m:=1 to ie do begin
      for n:=0 to 255 do if PAf[n] then begin
        if ip[n].r<63 then ip[n].r:=ip[n].r+1
          else ip[n].r:=63;
        if ip[n].g<63 then ip[n].g:=ip[n].g+1
          else ip[n].g:=63;
        if ip[n].b<63 then ip[n].b:=ip[n].b+1
          else ip[n].b:=63;
      end;
    end;
  end;

procedure FadeOff(is:word);
  var
    p:pal;
    n,m:byte;
  begin
    LePal(p);
    for m:=1 to 63 do begin
      EscurPal(p,1);
      delay(is);
      EscPal(p);
    end;
  end;

procedure Fade2(ip:pal;is:word);
  var
    p:pal;
    n,m:byte;
  begin
    LePal(p);
    for m:=1 to 63 do begin
      for n:=0 to 255 do if PAf[n] then begin
        if p[n].r<ip[n].r then p[n].r:=p[n].r+1;
        if p[n].g<ip[n].g then p[n].g:=p[n].g+1;
        if p[n].b<ip[n].b then p[n].b:=p[n].b+1;
        if p[n].r>ip[n].r then p[n].r:=p[n].r-1;
        if p[n].g>ip[n].g then p[n].g:=p[n].g-1;
        if p[n].b>ip[n].b then p[n].b:=p[n].b-1;
      end;
      delay(is);
      EscPal(p);
    end;
  end;

procedure FadePCX(is:string;iw:word);
  var
    pp,pa:pal;
    n:byte;
  begin
    DesVid;
    LePCX(is);
    LePal(pa);
    for n:=0 to 255 do begin
      pp[n].r:=0;
      pp[n].g:=0;
      pp[n].b:=0;
    end;
    EscPal(pp);
    LigVid;
    Fade2(pa,iw);
  end;

begin
  for pafk:=0 to 255 do PAf[pafk]:=true;
end.