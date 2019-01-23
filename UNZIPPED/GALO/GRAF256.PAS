unit Graf256;        {Telmo Menezes - 1994}

interface

uses Crt,Dos,Graph;

type
  img=record
    i1:pointer;
    c:longint;
  end;
  imm=record
    i1:pointer;
    im:pointer;
    c:longint;
  end;
  Cor=record
    r,g,b:byte;
  end;
  Pal=array[0..255] of Cor;

procedure IniGraf;
procedure FimGraf;
procedure LeImg(ix1,iy1,ix2,iy2:word;var iim:img);
procedure LeImgR(ix1,iy1,ix2,iy2:word;var iim:img);
procedure EscImg(ix,iy:word;im:integer;iim:img);
procedure ApgImg(iim:img);
procedure CriaFichImg(is:string);
procedure GrvImg(iff:string;iim:img);
procedure CarImg(iff:string;var iim:img;ic:word);
procedure CarImgR(iff:string;var iim:img;ic:word);
procedure EscImm(ix,iy:word;iim:imm);
procedure ApgImm(iim:imm);
procedure CarImm(iff:string;var iim:imm;ic:word);
procedure CarImmR(iff:string;var iim:imm;ic:word);
procedure LigVid;
procedure DesVid;
procedure EscCor(icor:byte;idat:Cor);
procedure EscPal(idat:Pal);
procedure LeCor(icor:byte;var idat:Cor);
procedure LePal(var idat:Pal);
procedure LePalPCX(is:String;var ip:pal);
procedure CriaFichPal(is:string);
procedure GrvPal(iff:string;idat:Pal);
procedure CarPal(iff:string;var idat:Pal;ic:word);
procedure LePCX(is:string);

implementation

procedure IniGraf;
  var
    GraphDriver,GraphMode,VGA256:integer;
    regs:registers;
  begin
    VGA256:=InstallUserdriver('VGA256',nil);
    GraphDriver:=VGA256;
    InitGraph(GraphDriver,GraphMode,'');
    regs.ah:=0;
    regs.al:=$13;
    intr($10,regs);
  end;

procedure FimGraf;
  begin
    CloseGraph;
  end;

procedure LeImg(ix1,iy1,ix2,iy2:word;var iim:img);
  begin
    iim.c:=((ix2-ix1+1)*(iy2-iy1+1))+6;
    getmem(iim.i1,iim.c);
    getimage(ix1,iy1,ix2,iy2,iim.i1^);
  end;

procedure LeImgR(ix1,iy1,ix2,iy2:word;var iim:img);
  begin
    iim.c:=((ix2-ix1+1)*(iy2-iy1+1))+6;
    getimage(ix1,iy1,ix2,iy2,iim.i1^);
  end;

procedure EscImg(ix,iy:word;im:integer;iim:img);
  begin
    putimage(ix,iy,iim.i1^,im);
  end;

procedure ApgImg(iim:img);
  begin
    freemem(iim.i1,iim.c);
  end;

procedure CriaFichImg(is:string);
  var
    ifil1:file;
  begin
    assign(ifil1,is+'.liv');
    rewrite(ifil1);
    close(ifil1);
  end;

procedure GrvImg(iff:string;iim:img);
  var
    ifil1:file;
  begin
    assign(ifil1,iff+'.liv');
    reset(ifil1,1);
    seek(ifil1,filesize(ifil1));
    blockwrite(ifil1,iim.i1^,iim.c);
    close(ifil1);
  end;

function Byte2Word(lb,hb:byte):word;
  begin
    Byte2Word:=(hb*256)+lb;
  end;

procedure CarImg(iff:string;var iim:img;ic:word);
  var
    ifil1:file;
    ifilb:file of byte;
    ni,ti:longint;
    t1,t2:byte;
    cx,cy:word;
  begin
    assign(ifil1,iff+'.liv');
    assign(ifilb,iff+'.liv');
    reset(ifilb);
    ti:=0;
    if ic>0 then
      for ni:=1 to ic do begin
        seek(ifilb,ti);
        read(ifilb,t1);
        read(ifilb,t2);
        cx:=Byte2Word(t1,t2);
        read(ifilb,t1);
        read(ifilb,t2);
        cy:=Byte2Word(t1,t2);
        ti:=ti+(cx*cy)+6
      end;
    seek(ifilb,ti);
    read(ifilb,t1);
    read(ifilb,t2);
    cx:=Byte2Word(t1,t2);
    read(ifilb,t1);
    read(ifilb,t2);
    cy:=Byte2Word(t1,t2);
    close(ifilb);
    reset(ifil1,1);
    seek(ifil1,ti);
    iim.c:=(cx*cy)+6;
    getmem(iim.i1,iim.c);
    blockread(ifil1,iim.i1^,iim.c);
    close(ifil1);
  end;

procedure CarImgR(iff:string;var iim:img;ic:word);
  var
    ifil1:file;
    ifilb:file of byte;
    ni,ti:longint;
    t1,t2:byte;
    cx,cy:word;
  begin
    assign(ifil1,iff+'.liv');
    assign(ifilb,iff+'.liv');
    reset(ifilb);
    ti:=0;
    if ic>0 then
      for ni:=1 to ic do begin
        seek(ifilb,ti);
        read(ifilb,t1);
        read(ifilb,t2);
        cx:=Byte2Word(t1,t2);
        read(ifilb,t1);
        read(ifilb,t2);
        cy:=Byte2Word(t1,t2);
        ti:=ti+(cx*cy)+6
      end;
    seek(ifilb,ti);
    read(ifilb,t1);
    read(ifilb,t2);
    cx:=Byte2Word(t1,t2);
    read(ifilb,t1);
    read(ifilb,t2);
    cy:=Byte2Word(t1,t2);
    close(ifilb);
    reset(ifil1,1);
    seek(ifil1,ti);
    iim.c:=(cx*cy)+6;
    blockread(ifil1,iim.i1^,iim.c);
    close(ifil1);
  end;

procedure EscImm(ix,iy:word;iim:imm);
  begin
    putimage(ix,iy,iim.im^,orput);
    putimage(ix,iy,iim.i1^,andput);
  end;

procedure ApgImm(iim:imm);
  begin
    freemem(iim.i1,iim.c);
    freemem(iim.im,iim.c);
  end;

procedure CarImm(iff:string;var iim:imm;ic:word);
  var
    ifil1:file;
    ifilb:file of byte;
    ni,ti,k:longint;
    t1,t2:byte;
    cx,cy,ms,mo:word;
  begin
    assign(ifil1,iff+'.liv');
    assign(ifilb,iff+'.liv');
    reset(ifilb);
    ti:=0;
    if ic>0 then
      for ni:=1 to ic do begin
        seek(ifilb,ti);
        read(ifilb,t1);
        read(ifilb,t2);
        cx:=Byte2Word(t1,t2);
        read(ifilb,t1);
        read(ifilb,t2);
        cy:=Byte2Word(t1,t2);
        ti:=ti+(cx*cy)+6
      end;
    seek(ifilb,ti);
    read(ifilb,t1);
    read(ifilb,t2);
    cx:=Byte2Word(t1,t2);
    read(ifilb,t1);
    read(ifilb,t2);
    cy:=Byte2Word(t1,t2);
    close(ifilb);
    reset(ifil1,1);
    seek(ifil1,ti);
    iim.c:=(cx*cy)+6;
    getmem(iim.i1,iim.c);
    getmem(iim.im,iim.c);
    blockread(ifil1,iim.i1^,iim.c);
    close(ifil1);
    putimage(0,0,iim.i1^,0);
    for ni:=0 to cy-1 do
      for ti:=0 to cx-1 do
        if mem[$A000:(ni*320)+ti]=255 then mem[$A000:(ni*320)+ti]:=0
          else mem[$A000:(ni*320)+ti]:=255;
    getimage(0,0,cx-1,cy-1,iim.im^);
  end;

procedure CarImmR(iff:string;var iim:imm;ic:word);
  var
    ifil1:file;
    ifilb:file of byte;
    ni,ti,k:longint;
    t1,t2:byte;
    cx,cy,ms,mo:word;
  begin
    assign(ifil1,iff+'.liv');
    assign(ifilb,iff+'.liv');
    reset(ifilb);
    ti:=0;
    if ic>0 then
      for ni:=1 to ic do begin
        seek(ifilb,ti);
        read(ifilb,t1);
        read(ifilb,t2);
        cx:=Byte2Word(t1,t2);
        read(ifilb,t1);
        read(ifilb,t2);
        cy:=Byte2Word(t1,t2);
        ti:=ti+(cx*cy)+6
      end;
    seek(ifilb,ti);
    read(ifilb,t1);
    read(ifilb,t2);
    cx:=Byte2Word(t1,t2);
    read(ifilb,t1);
    read(ifilb,t2);
    cy:=Byte2Word(t1,t2);
    close(ifilb);
    reset(ifil1,1);
    seek(ifil1,ti);
    iim.c:=(cx*cy)+6;
    blockread(ifil1,iim.i1^,iim.c);
    close(ifil1);
    putimage(0,0,iim.i1^,0);
    for ni:=0 to cy-1 do
      for ti:=0 to cx-1 do
        if mem[$A000:(ni*320)+ti]=255 then mem[$A000:(ni*320)+ti]:=0
          else mem[$A000:(ni*320)+ti]:=255;
    getimage(0,0,cx-1,cy-1,iim.im^);
  end;

procedure LigVid;
  begin
    asm
      MOV BL,$36
      MOV AX,$1200
      INT $10
    end;
  end;

procedure DesVid;
  begin
    asm
      MOV BL,$36
      MOV AX,$1201
      INT $10
    end;
  end;

procedure EscCor(icor:byte;idat:Cor);
  begin
    port[$3C8]:=icor;
    port[$3C9]:=idat.r;
    port[$3C9]:=idat.g;
    port[$3C9]:=idat.b;
  end;

procedure EscPal(idat:Pal);
  var
    nloop:byte;
  begin
    for nloop:=0 to 255 do begin
      port[$3C8]:=nloop;
      port[$3C9]:=idat[nloop].r;
      port[$3C9]:=idat[nloop].g;
      port[$3C9]:=idat[nloop].b;
    end;
  end;

procedure LeCor(icor:byte;var idat:Cor);
  begin
    port[$3C7]:=icor;
    idat.r:=port[$3C9];
    idat.g:=port[$3C9];
    idat.b:=port[$3C9];
  end;

procedure LePal(var idat:Pal);
  var
    nloop:byte;
  begin
    for nloop:=0 to 255 do begin
      port[$3C7]:=nloop;
      idat[nloop].r:=port[$3C9];
      idat[nloop].g:=port[$3C9];
      idat[nloop].b:=port[$3C9];
    end;
  end;

procedure LePalPCX(is:string;var ip:pal);
  var
    ifil:file;
    memt:array[0..767] of byte;
    k:word;
  begin
    assign(ifil,is);
    reset(ifil,1);
    seek(ifil,filesize(ifil)-768);
    blockread(ifil,memt,sizeof(memt));
    close(ifil);
    for k:=0 to 767 do memt[k]:=memt[k] shr 2;
    for k:=0 to 255 do begin
      ip[k].r:=memt[k*3];
      ip[k].g:=memt[(k*3)+1];
      ip[k].b:=memt[(k*3)+2];
    end;
  end;

procedure GrvPal(iff:string;idat:Pal);
  var
    ifil:file of pal;
  begin
    assign(ifil,iff+'.pal');
    reset(ifil);
    seek(ifil,filesize(ifil));
    write(ifil,idat);
    close(ifil);
  end;

procedure CarPal(iff:string;var idat:Pal;ic:word);
  var
    ifil:file of pal;
  begin
    assign(ifil,iff+'.pal');
    reset(ifil);
    seek(ifil,ic);
    read(ifil,idat);
    close(ifil);
  end;

procedure CriaFichPal(is:string);
  var
    ifil:file of pal;
  begin
    assign(ifil,is+'.pal');
    rewrite(ifil);
    close(ifil);
  end;

procedure LePCX(is:string);
  var
    ifil:file;
    palt:pal;
    cort:cor;
    pe,pb,rep:longint;
    k,err:integer;
    bl:byte;
    mtemp:array[1..$1400] of byte;
  begin
    assign(ifil,is);
    reset(ifil,1);
    seek(ifil,128);
    cort.r:=0;
    cort.g:=0;
    cort.b:=0;
    for k:=0 to 255 do palt[k]:=cort;
    EscPal(palt);
    rep:=0;
    pe:=0;
    pb:=$1400+1;
    while(pe<64000) do begin
      if(pb>$1400) then begin
        pb:=1;
        blockread(ifil,mtemp,sizeof(mtemp),err);
      end;
      bl:=mtemp[pb];
      inc(pb,1);
      rep:=1;
      if (bl and $C0)=$C0 then begin
        rep:=bl and $3F;
        if(pb>$1400) then begin
          pb:=1;
          blockread(ifil,mtemp,sizeof(mtemp),err);
        end;
        bl:=mtemp[pb];
        inc(pb,1);
      end;
      fillchar(mem[$A000:pe],rep,bl);
      inc(pe,rep);
    end;
    close(ifil);
    LePalPCX(is,palt);
    EscPal(palt);
  end;

begin
end.
