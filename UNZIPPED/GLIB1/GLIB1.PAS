{      Unit em Turbo Pascal 7.0 por      }  { Para mais informa‡”es ou      }
{         Isaac MSC  Mem Martins         }  { cr¡ticas constructivas,       }
{                                        }  { contacte-me:                  }
{ Programado em 28/7/1994 para a revista }  {                               }
{                                        }  { Isaac MSC                     }
{            SPOOLER Magazine            }  { R. Pedro Vaz, 3 2Dto          }
{                                        }  { 2860 Alhos Verdos             }
Unit GLib1; {     Graphics Library Vol.1 }  { PORTUGAL                      }

interface { Public }

uses Crt, Graph;
type Tipo = (Off, On);
var def: integer;

procedure Initialize(colors: Boolean; pt: string);
procedure SetAllRGB;
procedure Beep;
function RKey: char;
function RStrM(X,Y: integer;bc,size: byte;str,txt: string;var sda: byte;tt: boolean): string;
function RStrU(X,Y: integer;bc,size: byte;str,txt: string;var sda: byte;tt: boolean): string;
function RStrN(X,Y: integer;bc,size: byte;str,txt: string;var sda: byte;tt: boolean): string;
function RStrV(X,Y: integer;bc,size: byte;txt: string;var sda: byte;tt: boolean): string;
function RStrD(X,Y: integer;bc: byte;str,txt: string;var sda: byte;tt: boolean): string;
procedure WW(X,Y: integer; txt: string; bc: byte);
procedure WB(X,Y: integer; txt: string; bc: byte);
procedure Box(X,Y,sX,sY,ft,fs: integer;txt: string;Tipo: Tipo);
procedure SetRGB(c, r, g, b: byte);
procedure FadeIn;
procedure FadeOut;
procedure QFadeIn;
procedure QFadeOut;
procedure SaveScr(x1,y1,x2,y2: integer;page: byte);
procedure ReadScr(page: byte);

implementation { Private }

var Gd, Gm: Integer;
    pal: palettetype;
    red, green, blue: array[0..15] of byte;
    s1,s2,s3: array[1..10] of word;
    p1,p2,p3: array[1..10] of pointer;
    xx,yy1,yy2,yy3: array[1..10] of integer;

procedure Initialize; { Inicializa os gr ficos modificando ou n„o as cores }
Label 1;
begin
  if pt = '' then pt:= 'C:\TP';
  Gd := VGA; Gm := VGAHI; InitGraph(Gd, Gm, pt);
  if GraphResult <> grOk then Halt(1);
  getpalette(pal);
  if not colors then goto 1;
  red[0]:= 42; green[0]:= 42; blue[0]:= 42;
  red[1]:= 0; green[1]:= 42; blue[1]:= 42;
  red[2]:= 42; green[2]:= 42; blue[2]:= 0;
  red[3]:= 32; green[3]:= 32; blue[3]:= 32;
  red[4]:= 0; green[4]:= 32; blue[4]:= 32;
  red[5]:= 32; green[5]:= 32; blue[5]:= 0;
  red[6]:= 52; green[6]:= 52; blue[6]:= 52;
  red[7]:= 0; green[7]:= 52; blue[7]:= 52;
  red[8]:= 52; green[8]:= 52; blue[8]:= 0;
  red[9]:= 63; green[9]:= 63; blue[9]:= 63;
  red[10]:= 0; green[10]:= 0; blue[10]:= 0;
  red[11]:= 22; green[11]:= 42; blue[11]:= 32;
  red[12]:= 12; green[12]:= 32; blue[12]:= 22;
  red[13]:= 32; green[13]:= 52; blue[13]:= 42;
  red[14]:= 42; green[14]:= 22; blue[14]:= 32;
  red[15]:= 22; green[15]:= 32; blue[15]:= 42;
  setrgbpalette(pal.colors[0],42,42,42);
  setrgbpalette(pal.colors[1],0,42,42);
  setrgbpalette(pal.colors[2],42,42,0);
  setrgbpalette(pal.colors[3],32,32,32);
  setrgbpalette(pal.colors[4],0,32,32);
  setrgbpalette(pal.colors[5],32,32,0);
  setrgbpalette(pal.colors[6],52,52,52);
  setrgbpalette(pal.colors[7],0,52,52);
  setrgbpalette(pal.colors[8],52,52,0);
  setrgbpalette(pal.colors[9],63,63,63);
  setrgbpalette(pal.colors[10],0,0,0);
  setrgbpalette(pal.colors[11],22,42,32);
  setrgbpalette(pal.colors[12],12,32,22);
  setrgbpalette(pal.colors[13],32,52,42);
  setrgbpalette(pal.colors[14],42,22,32);
  setrgbpalette(pal.colors[15],22,32,42);
1:
end;

procedure SetAllRGB; { Define as cores }
begin
  red[0]:= 42; green[0]:= 42; blue[0]:= 42;
  red[1]:= 0; green[1]:= 42; blue[1]:= 42;
  red[2]:= 42; green[2]:= 42; blue[2]:= 0;
  red[3]:= 32; green[3]:= 32; blue[3]:= 32;
  red[4]:= 0; green[4]:= 32; blue[4]:= 32;
  red[5]:= 32; green[5]:= 32; blue[5]:= 0;
  red[6]:= 52; green[6]:= 52; blue[6]:= 52;
  red[7]:= 0; green[7]:= 52; blue[7]:= 52;
  red[8]:= 52; green[8]:= 52; blue[8]:= 0;
  red[9]:= 63; green[9]:= 63; blue[9]:= 63;
  red[10]:= 0; green[10]:= 0; blue[10]:= 0;
  red[11]:= 22; green[11]:= 42; blue[11]:= 32;
  red[12]:= 12; green[12]:= 32; blue[12]:= 22;
  red[13]:= 32; green[13]:= 52; blue[13]:= 42;
  red[14]:= 42; green[14]:= 22; blue[14]:= 32;
  red[15]:= 22; green[15]:= 32; blue[15]:= 42;
  setrgbpalette(pal.colors[0],42,42,42);
  setrgbpalette(pal.colors[1],0,42,42);
  setrgbpalette(pal.colors[2],42,42,0);
  setrgbpalette(pal.colors[3],32,32,32);
  setrgbpalette(pal.colors[4],0,32,32);
  setrgbpalette(pal.colors[5],32,32,0);
  setrgbpalette(pal.colors[6],52,52,52);
  setrgbpalette(pal.colors[7],0,52,52);
  setrgbpalette(pal.colors[8],52,52,0);
  setrgbpalette(pal.colors[9],63,63,63);
  setrgbpalette(pal.colors[10],0,0,0);
  setrgbpalette(pal.colors[11],22,42,32);
  setrgbpalette(pal.colors[12],12,32,22);
  setrgbpalette(pal.colors[13],32,52,42);
  setrgbpalette(pal.colors[14],42,22,32);
  setrgbpalette(pal.colors[15],22,32,42);
end;

procedure Beep; { Faz um beep }
var z: integer;
begin
  for z:= 3000 downto 2000 do Sound(z);
  delay(100);
  NoSound;
end;

function RKey; { Indica o valor em char da tecla pressionada }
var ch1,ch2: char;
    d: boolean;
begin
  d:= False;
  ch1:= readkey;
  if ch1 = #0 then begin D:= True; ch2:= readkey; end;
  RKey:= ch1;
  if d then RKey:= chr(ord(ch2)+128);
end;

function RStrM; { Lˆ uma string do tipo mensagem }
Label 1,2,3,4,5,6,7;
var CStr: string;
    cc: char;
    cou,uoc: byte;
    fcou: integer;
    cur: boolean;
begin
  if tt then goto 7;
  CStr:= str;
  settextstyle(0,0,0);
  settextjustify(0,1);
  WW(X,Y,txt,bc);
  setfillstyle(1,9);
  bar(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(10);
  rectangle(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(bc);
  line(x+textwidth(txt)+8+1,y+6,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  line(x+(textwidth(txt)+8)+(size*8)+12+1,y-5,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
  if not tt then goto 6;
7:CStr:= str;
  cou:= length(CStr);
  cur:= True;
1:setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
5:repeat
    if KeyPressed then goto 3;
    setcolor(10);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 2;
    delay(150);
2:  setcolor(9);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 3;
    delay(150);
  until KeyPressed;
3:cc:= RKey;
  if Ord(cc) in [32..142,144..174] then
     begin
       if cou = size then goto 4;
       setcolor(9);
       outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
       if cur then
          begin
            insert(cc,CStr,cou+1);
            CStr:= copy(CStr,1,size);
          end
       else
          begin
            CStr:= copy(CStr,0,cou)+cc+copy(CStr,cou+2,size);
            CStr:= copy(CStr,1,size);
          end;
       cou:= cou + 1;
       goto 1;
     end
  else begin
         case Ord(cc) of
              13: goto 4;
              8:  begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    setcolor(9);
                    outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                    delete(CStr,cou,1);
                    cou:= cou - 1;
                    goto 1;
                  end;
              203: begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    cou:= cou - 1;
                    goto 1;
                   end;
              205: begin
                     if (length(CStr)+1 > size) or (cou >= length(CStr)) then goto 5;
                     cou:= cou + 1;
                     goto 1;
                     end;
              199: begin
                     cou:= 0;
                     goto 5;
                   end;
              207: begin
                     cou:= length(CStr);
                     goto 5;
                   end;
              210: begin
                     if cur then
                        begin
                          cur:= False;
                          setcolor(10);
                          outtextxy(x+(textwidth(txt)+8)+4+(8*size),y,'I');
                        end
                     else
                        begin
                          cur:= True;
                          setcolor(9);
                          outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
                        end;
                     goto 5;
                   end;
              211: begin
                     if (length(CStr) = 0) or (cou = length(CStr)) then goto 5;
                     setcolor(9);
                     outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                     delete(CStr,cou+1,1);
                     goto 1;
                   end
         else     goto 4;
         end;
       end;
4:setcolor(9);
  outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
  Sda:= Ord(cc);
6:RStrM:= CStr;
end;

function RStrU; { Lˆ uma string do tipo mensagem mas em Maiusculas }
Label 1,2,3,4,5,6,7;
var CStr: string;
    cc: char;
    cou,uoc: byte;
    fcou: integer;
    cur: boolean;
begin
  if tt then goto 7;
  CStr:= str;
  settextstyle(0,0,0);
  settextjustify(0,1);
  WW(X,Y,txt,bc);
  setfillstyle(1,9);
  bar(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(10);
  rectangle(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(bc);
  line(x+textwidth(txt)+8+1,y+6,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  line(x+(textwidth(txt)+8)+(size*8)+12+1,y-5,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
  if not tt then goto 6;
7:CStr:= str;
  cou:= length(CStr);
  cur:= True;
1:setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
5:repeat
    if KeyPressed then goto 3;
    setcolor(10);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 2;
    delay(150);
2:  setcolor(9);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 3;
    delay(150);
  until KeyPressed;
3:cc:= RKey;
  if Ord(cc) in [32..142,144..174] then
     begin
       if cou = size then goto 4;
       setcolor(9);
       outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
       if cur then
          begin
            insert(UpCase(cc),CStr,cou+1);
            CStr:= copy(CStr,1,size);
          end
       else
          begin
            CStr:= copy(CStr,0,cou)+UpCase(cc)+copy(CStr,cou+2,size);
            CStr:= copy(CStr,1,size);
          end;
       cou:= cou + 1;
       goto 1;
     end
  else begin
         case Ord(cc) of
              13: goto 4;
              8:  begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    setcolor(9);
                    outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                    delete(CStr,cou,1);
                    cou:= cou - 1;
                    goto 1;
                  end;
              203: begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    cou:= cou - 1;
                    goto 1;
                   end;
              205: begin
                     if (length(CStr)+1 > size) or (cou >= length(CStr)) then goto 5;
                     cou:= cou + 1;
                     goto 1;
                     end;
              199: begin
                     cou:= 0;
                     goto 5;
                   end;
              207: begin
                     cou:= length(CStr);
                     goto 5;
                   end;
              210: begin
                     if cur then
                        begin
                          cur:= False;
                          setcolor(10);
                          outtextxy(x+(textwidth(txt)+8)+4+(8*size),y,'I');
                        end
                     else
                        begin
                          cur:= True;
                          setcolor(9);
                          outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
                        end;
                     goto 5;
                   end;
              211: begin
                     if (length(CStr) = 0) or (cou = length(CStr)) then goto 5;
                     setcolor(9);
                     outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                     delete(CStr,cou+1,1);
                     goto 1;
                   end
         else     goto 4;
         end;
       end;
4:setcolor(9);
  outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
  Sda:= Ord(cc);
6:RStrU:= CStr;
end;

function RStrN; { Lˆ uma string do tipo num‚rica }
Label 1,2,3,4,5,6,7;
var CStr: string;
    cc: char;
    cou,uoc: byte;
    fcou: integer;
    cur: boolean;
begin
  if tt then goto 7;
  CStr:= str;
  settextstyle(0,0,0);
  settextjustify(0,1);
  WW(X,Y,txt,bc);
  setfillstyle(1,9);
  bar(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(10);
  rectangle(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(bc);
  line(x+textwidth(txt)+8+1,y+6,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  line(x+(textwidth(txt)+8)+(size*8)+12+1,y-5,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
  if not tt then goto 6;
7:CStr:= str;
  cou:= length(CStr);
  cur:= True;
1:setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
5:repeat
    if KeyPressed then goto 3;
    setcolor(10);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 2;
    delay(150);
2:  setcolor(9);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 3;
    delay(150);
  until KeyPressed;
3:cc:= RKey;
  if Ord(cc) in [32,43,45,46,48..57] then
     begin
       if cou = size then goto 4;
       setcolor(9);
       outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
       if cur then
          begin
            insert(cc,CStr,cou+1);
            CStr:= copy(CStr,1,size);
          end
       else
          begin
            CStr:= copy(CStr,0,cou)+cc+copy(CStr,cou+2,size);
            CStr:= copy(CStr,1,size);
          end;
       cou:= cou + 1;
       goto 1;
     end
  else begin
         case Ord(cc) of
              13: goto 4;
              8:  begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    setcolor(9);
                    outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                    delete(CStr,cou,1);
                    cou:= cou - 1;
                    goto 1;
                  end;
              203: begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    cou:= cou - 1;
                    goto 1;
                   end;
              205: begin
                     if (length(CStr)+1 > size) or (cou >= length(CStr)) then goto 5;
                     cou:= cou + 1;
                     goto 1;
                     end;
              199: begin
                     cou:= 0;
                     goto 5;
                   end;
              207: begin
                     cou:= length(CStr);
                     goto 5;
                   end;
              210: begin
                     if cur then
                        begin
                          cur:= False;
                          setcolor(10);
                          outtextxy(x+(textwidth(txt)+8)+4+(8*size),y,'I');
                        end
                     else
                        begin
                          cur:= True;
                          setcolor(9);
                          outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
                        end;
                     goto 5;
                   end;
              211: begin
                     if (length(CStr) = 0) or (cou = length(CStr)) then goto 5;
                     setcolor(9);
                     outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                     delete(CStr,cou+1,1);
                     goto 1;
                   end
         else     goto 4;
         end;
       end;
4:if Ord(cc) in [58..142,144..174] then
     begin
       Beep;
       goto 5;
     end;
  setcolor(9);
  outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
  Sda:= Ord(cc);
6:RStrN:= CStr;
end;

function RStrV; { Lˆ uma string do do tipo valor num‚rico }
Label 1,2,3,4,5,6,7;
var CStr: string;
    cc: char;
    cou,uoc: byte;
    fcou: integer;
    cur: boolean;

Function PL(Str:string;Size:byte;Pad:char):string;
var temp : string;
begin
    Fillchar(Temp[1],Size,Pad);
    Temp[0] := chr(Size);
    If Length(Str) <= Size then
       Move(Str[1],Temp[1],length(Str))
    else
       Move(Str[1],Temp[1],size);
    PL := Temp;
end;

begin
  if tt then goto 7;
  CStr:= '';
  CStr:= PL(CStr,size,' ');
  settextstyle(0,0,0);
  settextjustify(0,1);
  WW(X,Y,txt,bc);
  setfillstyle(1,9);
  bar(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(10);
  rectangle(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(bc);
  line(x+textwidth(txt)+8+1,y+6,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  line(x+(textwidth(txt)+8)+(size*8)+12+1,y-5,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
  if not tt then goto 6;
7:CStr:= '';
  CStr:= PL(CStr,size,' ');
  cou:= size;
  uoc:= 0;
  cur:= False;
1:setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
5:repeat
    if KeyPressed then goto 3;
    setcolor(10);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 2;
    delay(150);
2:  setcolor(9);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 3;
    delay(150);
  until KeyPressed;
3:cc:= RKey;
  if Ord(cc) in [46,48..57] then
     begin
       if uoc = size then goto 4;
       if (cur) and (cc = '.') then
          begin
            Beep;
            goto 5;
          end;
       if (not cur) and (cc = '.') then cur:= True;
       setcolor(9);
       outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
       CStr:= copy(CStr,2,length(CStr)-1)+cc;
       CStr:= PL(CStr,size,' ');
       uoc:= uoc + 1;
       goto 1;
     end
  else begin
         case Ord(cc) of
              13: goto 4;
              8:  begin
                    if uoc = 0 then goto 5;
                    setcolor(9);
                    outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
                    if copy(CStr,succ(length(CStr) - 1),1) = '.' then cur:= False;
                    CStr:= ' '+copy(CStr,1,length(CStr)-1);
                    uoc:= uoc - 1;
                    goto 1;
                  end
         else     goto 4;
         end;
       end;
4:if Ord(cc) in [58..142,144..174] then
     begin
       Beep;
       goto 5;
     end;
  Sda:= Ord(cc);
6:RStrV:= CStr;
end;

function RStrD; { Lˆ uma string do tipo data (dd/mm/aaa) }
Label 1,2,3,4,5,6,7;
const size = 10;
var CStr: string;
    cc: char;
    cou,uoc: byte;
    fcou: integer;
    cur: boolean;

Function Valid_Date(Indate:string): boolean;
var D,M,Y : word;
    OK : Boolean;

Function StrtoInt(Str:string):integer;
var temp,code : integer;
begin
  If length(Str) = 0 then StrtoInt := 0
  else begin
         val(Str,temp,code);
         if code = 0 then StrtoInt := temp
         else StrtoInt := 0;
       end;
end;

Function Nth_Number(InStr:string;Nth:byte) : char;
var Counter : byte;
    B, Len : byte;
begin
  Counter := 0;
  B := 0;
  Len := Length(InStr);
  Repeat
    Inc(B);
    If InStr[B] in ['0'..'9'] then Inc(Counter);
  Until (Counter = Nth) or (B >= Len);
  If (Counter >= Len) and ( (InStr[Len] in ['0'..'9']) = false) then Nth_Number := #0
  else Nth_Number := InStr[B];
end;

Function Day(DStr:string): word;
var DayStr: string;
begin
  DayStr := Nth_Number(DStr,1)+Nth_Number(DStr,2);
  Day := StrToInt(DayStr);
end;

Function Month(DStr:string): word;
var MonStr: string;
begin
  MonStr := Nth_Number(DStr,3)+Nth_Number(DStr,4);
  Month := StrToInt(MonStr);
end;

Function Year(DStr:string): word;
var YrStr   : string;
    TmpYr   : word;
begin
  YrStr := Nth_Number(DStr,5)+Nth_Number(DStr,6)+Nth_Number(DStr,7)+Nth_Number(DStr,8);
  TmpYr := StrToInt(YrStr);
  If TmpYr < 78 then TmpYr := 2000 + TmpYr
  else If Tmpyr < 1000 then TmpYr := 1900 + TmpYr;
  Year := TmpYr;
end;

begin
  OK := true;
  D := Day(Indate);
  M := Month(Indate);
  Y := Year(Indate);
  If (D < 1) or (D > 31) or (M < 1) or (M > 12) or ((Y > 99) and (Y < 1900)) or (Y > 2078) then OK := False
  else Case M of
            4,6,9,11: OK := (D <= 30);
            2:        OK := (D <= 28) or ((D = 29) and (Y <> 1900) and (Y <> 0) and (Y mod 4 = 0));
       end;
  Valid_Date := OK;
end;

begin
  if tt then goto 7;
  CStr:= copy(Str,7,2)+'/'+copy(Str,5,2)+'/'+copy(Str,1,4);
  settextstyle(0,0,0);
  settextjustify(0,1);
  WW(X,Y,txt,bc);
  setfillstyle(1,9);
  bar(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(10);
  rectangle(x+textwidth(txt)+8,y-6,x+(textwidth(txt)+8)+(size*8)+12,y+5);
  setcolor(bc);
  line(x+textwidth(txt)+8+1,y+6,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  line(x+(textwidth(txt)+8)+(size*8)+12+1,y-5,x+(textwidth(txt)+8)+(size*8)+12+1,y+6);
  setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
  if not tt then goto 6;
7:CStr:= copy(Str,7,2)+'/'+copy(Str,5,2)+'/'+copy(Str,1,4);
  cou:= 0;
  cur:= False;
  setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+4+(8*size),y,'I');
1:setcolor(10);
  outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
5:repeat
    if KeyPressed then goto 3;
    setcolor(10);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 2;
    delay(150);
2:  setcolor(9);
    outtextxy((x+(textwidth(txt)+8)+2)+(8*cou),y+1,'_');
    if KeyPressed then goto 3;
    delay(150);
  until KeyPressed;
3:cc:= RKey;
  if Ord(cc) in [48..57] then
     begin
       if cou = size then goto 4;
       setcolor(9);
       outtextxy(x+(textwidth(txt)+8)+2,y,CStr);
       case cou of
            0: begin
                 CStr:= cc+copy(CStr,2,9);
                 cou:= 1;
                 goto 1;
               end;
            1: begin
                 CStr:= copy(CStr,1,1)+cc+copy(CStr,3,8);
                 cou:= 3;
                 goto 1;
               end;
            3: begin
                 CStr:= copy(CStr,1,3)+cc+copy(CStr,5,6);
                 cou:= 4;
                 goto 1;
               end;
            4: begin
                 CStr:= copy(CStr,1,4)+cc+copy(CStr,6,5);
                 cou:= 6;
                 goto 1;
               end;
            6: begin
                 CStr:= copy(CStr,1,6)+cc+copy(CStr,8,3);
                 cou:= 7;
                 goto 1;
               end;
            7: begin
                 CStr:= copy(CStr,1,7)+cc+copy(CStr,9,2);
                 cou:= 8;
                 goto 1;
               end;
            8: begin
                 CStr:= copy(CStr,1,8)+cc+copy(CStr,10,1);
                 cou:= 9;
                 goto 1;
               end;
            9: begin
                 CStr:= copy(CStr,1,9)+cc;
                 cou:= 10;
                 goto 1;
               end;
       end;
     end
  else begin
         case Ord(cc) of
              13: goto 4;
            8,203: begin
                    if (length(CStr) = 0) or (cou = 0) then goto 5;
                    case cou of
                         10: cou:= 9;
                          1: cou:= 0;
                          3: cou:= 1;
                          4: cou:= 3;
                          6: cou:= 4;
                          7: cou:= 6;
                          8: cou:= 7;
                          9: cou:= 8;
                    end;
                    goto 1;
                   end;
              205: begin
                     if cou+1 > size then goto 5;
                     case cou of
                          0: cou:= 1;
                          1: cou:= 3;
                          3: cou:= 4;
                          4: cou:= 6;
                          6: cou:= 7;
                          7: cou:= 8;
                          8: cou:= 9;
                          9: cou:= 10;
                     end;
                     goto 1;
                     end;
              199: begin
                     cou:= 0;
                     goto 5;
                   end;
              207: begin
                     cou:= length(CStr);
                     goto 5;
                   end
         else     goto 4;
         end;
       end;
4:if Ord(cc) in [58..142,144..174] then
     begin
       Beep;
       goto 5;
     end;
  if not Valid_Date(CStr) then
     begin
       Beep;
       cou:= 0;
       goto 5;
     end;
  setcolor(9);
  outtextxy(x+(textwidth(txt)+8)+2+(8*size),y,'Û');
  Sda:= Ord(cc);
6:RStrD:= copy(CStr,7,4)+copy(CStr,4,2)+copy(CStr,1,2);
end;

procedure WW; { Escreve uma string branca em 3D }
begin
  setcolor(bc);
  Outtextxy(x+1,y+1,txt);
  setcolor(9);
  Outtextxy(x,y,txt);
end;

procedure WB; { Escreve uma string preta em 3D }
begin
  setcolor(bc);
  Outtextxy(x+1,y+1,txt);
  setcolor(10);
  Outtextxy(x,y,txt);
end;

procedure Box; { Faz uma caixa consoante esteja On ou Off }
begin
  setfillstyle(1,0);
  bar(x-(sx div 2),y-(sy div 2),x+(sx div 2),y+(sy div 2));
  if tipo = On then setcolor(3) else setcolor(6);
  line(x-(sx div 2),y-(sy div 2),x+(sx div 2),y-(sy div 2));
  line(x-(sx div 2),y-(sy div 2),x-(sx div 2),y+(sy div 2));
  if tipo = On then setcolor(6) else setcolor(3);
  line(x+(sx div 2),y+(sy div 2),x-(sx div 2),y+(sy div 2));
  line(x+(sx div 2),y+(sy div 2),x+(sx div 2),y-(sy div 2)+1);
  settextjustify(1,1);
  settextstyle(ft,0,fs);
  setcolor(10);
  if tipo = On then outtextxy(X,Y-def,txt)
  else begin setcolor(9); outtextxy(X,Y-1-def,txt); end;
end;

procedure SetRGB; { Modifica uma cor com o R,G,B }
begin
  red[c]:= r; green[c]:= g; blue[c]:= b;
  setrgbpalette(pal.colors[c],r,g,b);
end;

procedure FadeIn; { Vai escurecendo as cores at‚ ficarem totalmente pretas }
var z: integer;
begin
  for z:= 1 to 9 do
      begin
        setrgbpalette(pal.colors[0],red[0] div z,green[0] div z,blue[0] div z);
        setrgbpalette(pal.colors[1],red[1] div z,green[1] div z,blue[1] div z);
        setrgbpalette(pal.colors[2],red[2] div z,green[2] div z,blue[2] div z);
        setrgbpalette(pal.colors[3],red[3] div z,green[3] div z,blue[3] div z);
        setrgbpalette(pal.colors[4],red[4] div z,green[4] div z,blue[4] div z);
        setrgbpalette(pal.colors[5],red[5] div z,green[5] div z,blue[5] div z);
        setrgbpalette(pal.colors[6],red[6] div z,green[6] div z,blue[6] div z);
        setrgbpalette(pal.colors[7],red[7] div z,green[7] div z,blue[7] div z);
        setrgbpalette(pal.colors[8],red[8] div z,green[8] div z,blue[8] div z);
        setrgbpalette(pal.colors[9],red[9] div z,green[9] div z,blue[9] div z);
        setrgbpalette(pal.colors[10],red[10] div z,green[10] div z,blue[10] div z);
        setrgbpalette(pal.colors[11],red[11] div z,green[11] div z,blue[11] div z);
        setrgbpalette(pal.colors[12],red[12] div z,green[12] div z,blue[12] div z);
        setrgbpalette(pal.colors[13],red[13] div z,green[13] div z,blue[13] div z);
        setrgbpalette(pal.colors[14],red[14] div z,green[14] div z,blue[14] div z);
        setrgbpalette(pal.colors[15],red[15] div z,green[15] div z,blue[15] div z);
     end;
  for z:= 0 to 15 do setrgbpalette(pal.colors[z],0,0,0);
end;

procedure FadeOut; { Volta a clarear as cores at‚ ficarem normais }
var z: integer;
begin
  for z:= 9 downto 1 do
      begin
        setrgbpalette(pal.colors[0],red[0] div z,green[0] div z,blue[0] div z);
        setrgbpalette(pal.colors[1],red[1] div z,green[1] div z,blue[1] div z);
        setrgbpalette(pal.colors[2],red[2] div z,green[2] div z,blue[2] div z);
        setrgbpalette(pal.colors[3],red[3] div z,green[3] div z,blue[3] div z);
        setrgbpalette(pal.colors[4],red[4] div z,green[4] div z,blue[4] div z);
        setrgbpalette(pal.colors[5],red[5] div z,green[5] div z,blue[5] div z);
        setrgbpalette(pal.colors[6],red[6] div z,green[6] div z,blue[6] div z);
        setrgbpalette(pal.colors[7],red[7] div z,green[7] div z,blue[7] div z);
        setrgbpalette(pal.colors[8],red[8] div z,green[8] div z,blue[8] div z);
        setrgbpalette(pal.colors[9],red[9] div z,green[9] div z,blue[9] div z);
        setrgbpalette(pal.colors[10],red[10] div z,green[10] div z,blue[10] div z);
        setrgbpalette(pal.colors[11],red[11] div z,green[11] div z,blue[11] div z);
        setrgbpalette(pal.colors[12],red[12] div z,green[12] div z,blue[12] div z);
        setrgbpalette(pal.colors[13],red[13] div z,green[13] div z,blue[13] div z);
        setrgbpalette(pal.colors[14],red[14] div z,green[14] div z,blue[14] div z);
        setrgbpalette(pal.colors[15],red[15] div z,green[15] div z,blue[15] div z);
     end;
  for z:= 0 to 15 do setrgbpalette(pal.colors[z],red[z],green[z],blue[z]);
end;

procedure QFadeIn; { Escurece de vez as cores }
var z: integer;
begin
  for z:= 0 to 15 do setrgbpalette(pal.colors[z],0,0,0);
end;

procedure QFadeOut; { Clareia as cores }
var z: integer;
begin
  for z:= 0 to 15 do setrgbpalette(pal.colors[z],red[z],green[z],blue[z]);
end;

procedure SaveScr; { Grava uma area do ecr„ na mem¢ria }
Label 1;
begin
  if ((((x2-x1)*(y2-y1)) div 2)+2048) > MemAvail then goto 1;
  Dispose(p1[page]);
  Dispose(p2[page]);
  Dispose(p3[page]);
  s1[page]:= imagesize(x1,y1,x2,y1+((y2-y1) div 3));
  s2[page]:= imagesize(x1,y1+((y2-y1) div 3),x2,y2-((y2-y1) div 3));
  s3[page]:= imagesize(x1,y2-((y2-y1) div 3),x2,y2);
  GetMem(p1[page],s1[page]);
  GetMem(p2[page],s2[page]);
  GetMem(p3[page],s3[page]);
  getimage(x1,y1,x2,y1+((y2-y1) div 3),p1[page]^);
  getimage(x1,y1+((y2-y1) div 3),x2,y2-((y2-y1) div 3),p2[page]^);
  getimage(x1,y2-((y2-y1) div 3),x2,y2,p3[page]^);
  xx[page]:= x1;
  yy1[page]:= y1;
  yy2[page]:= y1+((y2-y1) div 3);
  yy3[page]:= y2-((y2-y1) div 3);
1:
end;

procedure ReadScr; { Recupera para o ecr„ uma area gravada }
begin
  PutImage(xx[page],yy1[page],p1[page]^,0);
  PutImage(xx[page],yy2[page],p2[page]^,0);
  PutImage(xx[page],yy3[page],p3[page]^,0);
  FreeMem(p1[page],s1[page]);
  FreeMem(p2[page],s2[page]);
  FreeMem(p3[page],s3[page]);
end;

begin
  def:= 0;
end. { Fim da Unit GLib1 }