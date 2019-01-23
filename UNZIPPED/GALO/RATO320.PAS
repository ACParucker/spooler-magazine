Unit Rato320;             {Telmo Menezes - 1992}

Interface

Uses Dos;

function RPres:boolean;
procedure IniRat;
procedure LigRat;
procedure DesRat;
function RatX:Word;
function RatY:Word;
function RatB:byte;
function RArea(ix1,iy1,ix2,iy2:word):boolean;
function RAreaE(ix1,iy1,ix2,iy2:word):boolean;
function RAreaD(ix1,iy1,ix2,iy2:word):boolean;
function RArea2(ix1,iy1,ix2,iy2:word):boolean;
function RAreaN(ix1,iy1,ix2,iy2:word):boolean;

implementation

var
  Regi:Registers;
  MAX,MBX,MCX,MDX:Word;
  RK:Char;

function RPres:boolean;
  var
    Regs:registers;
    Mseg,Mofs:word;
    mhandler:byte;
  begin
    regs.AX:=$3533;
    Intr($21,Regs);
    MSeg:=Regs.ES;
    MOfs:=Regs.BX;
    MHandler:=mem[Mseg:Mofs];
    RPres:=(mseg<>0) and (mhandler<>$CF)
  end;

procedure Inter(IAX,IBX,ICX,IDX:Word);
  begin
    Regi.AX:=IAX; Regi.BX:=IBX; Regi.CX:=ICX; Regi.DX:=IDX;
    Intr(51,Regi);
    MAX:=Regi.AX; MBX:=Regi.BX; MCX:=Regi.CX; MDX:=Regi.DX;
  end;

procedure LigRat;
  begin
    Inter(1,0,0,0);
  end;

procedure IniRat;
  begin
    Inter(0,2,0,0);
    LigRat;
  end;

procedure DesRat;
  begin
    Inter(2,0,0,0);
  end;

function RatX:Word;
  begin
    Inter(3,MBX,MCX,MDX);
    RatX:=MCX div 2;
  end;

function RatY:Word;
  begin
    Inter(3,MBX,MCX,MDX);
    RatY:=MDX;
  end;

function RatB:byte;
  begin
    MAX:=5;
    Inter(MAX,MBX,MCX,MDX);
    RatB:=MAX;
  end;

function RArea(ix1,iy1,ix2,iy2:word):boolean;
  begin
    RArea:=False;
    if (RatX>=ix1) and (RatY>=iy1) and (RatX<=ix2) and (RatY<=iy2) then
      RArea:=true;
  end;

function RAreaE(ix1,iy1,ix2,iy2:word):boolean;
  begin
    RAreaE:=False;
    if RArea(ix1,iy1,ix2,iy2) and (RatB=1) then RAreaE:=true;
  end;

function RAreaD(ix1,iy1,ix2,iy2:word):boolean;
  begin
    RAreaD:=False;
    if RArea(ix1,iy1,ix2,iy2) and (RatB=2) then RAreaD:=true;
  end;

function RArea2(ix1,iy1,ix2,iy2:word):boolean;
  begin
    RArea2:=False;
    if RArea(ix1,iy1,ix2,iy2) and (RatB=3) then RArea2:=true;
  end;

function RAreaN(ix1,iy1,ix2,iy2:word):boolean;
  begin
    RAreaN:=False;
    if RArea(ix1,iy1,ix2,iy2) and (RatB=0) then RAreaN:=true;
  end;

begin
end.