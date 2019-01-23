{*   Auxiliar n§5 do Nutritus 1.0   *}

unit Nutri33;

interface
procedure Logotipo(X,Y: Integer);
implementation
uses Crt, Graph;

{ Logotipo do autor }
procedure Logotipo(X,Y: Integer);
var StartX,StartY,Radius: Integer;
begin
StartX := X;
StartY := Y;
setcolor(8);
line(StartX+100,StartY+100,StartX+100,StartY+176);
line(StartX+100,StartY+100,StartX+174,StartY+100);
setcolor(15);
moveto(StartX+174,StartY+101);
lineto(StartX+174,StartY+176);
lineto(StartX+101,StartY+176);
setcolor(1);
line(StartX+105,StartY+165,StartX+111,StartY+165);
line(StartX+108,StartY+165,StartX+108,StartY+171);
line(StartX+105,StartY+172,StartX+111,StartY+172);
line(StartX+113,StartY+172,StartX+117,StartY+172);
line(StartX+117,StartY+172,StartX+118,StartY+171);
line(StartX+118,StartY+171,StartX+117,StartY+170);
line(StartX+117,StartY+170,StartX+114,StartY+170);
line(StartX+114,StartY+170,StartX+113,StartY+169);
line(StartX+113,StartY+169,StartX+114,StartY+168);
line(StartX+114,StartY+168,StartX+118,StartY+168);
line(StartX+120,StartY+168,StartX+123,StartY+168);
line(StartX+123,StartY+168,StartX+124,StartY+169);
line(StartX+124,StartY+169,StartX+124,StartY+172);
line(StartX+124,StartY+172,StartX+121,StartY+172);
line(StartX+121,StartY+172,StartX+120,StartY+171);
line(StartX+120,StartY+171,StartX+121,StartY+170);
line(StartX+121,StartY+170,StartX+124,StartY+170);
line(StartX+126,StartY+168,StartX+129,StartY+168);
line(StartX+129,StartY+168,StartX+130,StartY+169);
line(StartX+130,StartY+169,StartX+130,StartY+172);
line(StartX+130,StartY+172,StartX+127,StartY+172);
line(StartX+127,StartY+172,StartX+126,StartY+171);
line(StartX+126,StartY+171,StartX+127,StartY+170);
line(StartX+127,StartY+170,StartX+130,StartY+170);
line(StartX+137,StartY+168,StartX+133,StartY+168);
line(StartX+133,StartY+168,StartX+132,StartY+169);
line(StartX+132,StartY+169,StartX+132,StartY+171);
line(StartX+132,StartY+171,StartX+133,StartY+172);
line(StartX+133,StartY+172,StartX+137,StartY+172);
line(StartX+148,StartY+172,StartX+148,StartY+165);
line(StartX+148,StartY+165,StartX+149,StartY+165);
line(StartX+149,StartY+165,StartX+150,StartY+166);
line(StartX+150,StartY+166,StartX+150,StartY+168);
line(StartX+150,StartY+168,StartX+151,StartY+169);
line(StartX+151,StartY+169,StartX+151,StartY+170);
line(StartX+151,StartY+169,StartX+152,StartY+168);
line(StartX+152,StartY+168,StartX+152,StartY+166);
line(StartX+152,StartY+166,StartX+153,StartY+165);
line(StartX+153,StartY+165,StartX+154,StartY+165);
line(StartX+154,StartY+165,StartX+154,StartY+172);
line(StartX+156,StartY+172,StartX+160,StartY+172);
line(StartX+160,StartY+172,StartX+162,StartY+170);
line(StartX+162,StartY+170,StartX+161,StartY+169);
line(StartX+161,StartY+169,StartX+160,StartY+169);
line(StartX+160,StartY+169,StartX+159,StartY+168);
line(StartX+159,StartY+168,StartX+157,StartY+168);
line(StartX+157,StartY+168,StartX+156,StartY+167);
line(StartX+156,StartY+167,StartX+158,StartY+165);
line(StartX+158,StartY+165,StartX+162,StartY+165);
line(StartX+170,StartY+171,StartX+169,StartY+172);
line(StartX+169,StartY+172,StartX+166,StartY+172);
line(StartX+166,StartY+172,StartX+164,StartY+170);
line(StartX+164,StartY+170,StartX+164,StartY+167);
line(StartX+164,StartY+167,StartX+166,StartY+165);
line(StartX+166,StartY+165,StartX+169,StartY+165);
line(StartX+169,StartY+165,StartX+170,StartY+166);
putpixel(StartX+140,StartY+132,1);
setcolor(2);
circle(StartX+140,StartY+132,4);
setcolor(3);
circle(StartX+140,StartY+132,8);
setcolor(4);
circle(StartX+140,StartY+132,12);
setcolor(5);
circle(StartX+140,StartY+132,16);
setcolor(6);
circle(StartX+140,StartY+132,20);
setcolor(9);
circle(StartX+140,StartY+132,24);
setcolor(10);
circle(StartX+140,StartY+132,28);
setcolor(7);
SetFillStyle(1,7);
bar(StartX+105,StartY+105,StartX+126,StartY+126);
setcolor(15);
line(StartX+105,StartY+105,StartX+105,StartY+125);
line(StartX+105,StartY+105,StartX+125,StartY+105);
setcolor(8);
line(StartX+125,StartY+106,StartX+125,StartY+125);
line(StartX+125,StartY+125,StartX+106,StartY+125);
setcolor(14);
for Radius := 1 to 7 do
  Circle(StartX+115, StartY+115, Radius*1);
setcolor(1);
Circle(StartX+115, StartY+115, 8);
end;

end.