{ Auxiliar n§ 1 do auxiliar 3 do Min‚rius }
Unit Mine31;

interface

uses Crt, Graph, Mine21, KeyTTT5, StrnTTT5;

procedure Acerca(ecra: byte);

implementation

const G50 : FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);

var ch : char;
    q: integer;

{ Ecr„ do Min‚rius  Acerca }
procedure Acerca(ecra: byte);
Label 2,3,4;
var c1: string;
begin
3:setfillpattern(G50,6);
  bar(1,465,638,478);
  settextstyle(0,0,0);
  settextjustify(1,1);
  c1:= 'Esc/ClicD - Volta atr s';
  setcolor(8);
  outtextxy(320,473,c1);
  setcolor(15);
  outtextxy(319,472,c1);
  setlinestyle(0,0,0);
  setfillstyle(1,0);
  bar(20,30,620,440);
  setcolor(15);
  line(20,30,620,30);
  line(21,31,619,31);
  line(20,30,20,440);
  line(21,31,21,439);
  setcolor(8);
  line(620,440,620,31);
  line(619,439,619,32);
  line(620,440,21,440);
  line(619,439,22,439);
  setfillpattern(G50,5);
  bar(621,40,630,450);
  bar(30,441,630,450);
  setfillstyle(1,3);
  bar(40,150,600,420);
  setcolor(8);
  line(40,150,599,150);
  line(40,150,40,419);
  setcolor(15);
  line(600,150,600,420);
  line(600,420,40,420);
  SetRGBpalette(4,48,48,48);
  SetRGBpalette(7,0,48,48);
  setcolor(7);
  Ass(100,170,1,0);
  Ass(390,170,1,0);
  Ass(100,220,1,0);
  Ass(390,220,1,0);
  Ass(100,270,1,0);
  Ass(390,270,1,0);
  Ass(100,320,1,0);
  Ass(390,320,1,0);
  Ass(100,370,1,0);
  Ass(390,370,1,0);
  Logotipo(-60,-50);
  settextstyle(7,0,8);
  settextjustify(1,1);
  setcolor(1);
  outtextxy(373,66,'Min‚rius');
  setcolor(15);
  outtextxy(370,63,'Min‚rius');
  settextstyle(2,0,6);
  setcolor(1);
  outtextxy(373,117,'Um programa sobre Minerologia');
  setcolor(15);
  outtextxy(370,114,'Um programa sobre Minerologia');
  settextstyle(2,0,5);
  EscE(320,160,'Programador:');
  settextstyle(8,0,0);
  settextjustify(0,0);
  setcolor(2);
  outtextxy(52,202,'Isaac MSC');
  setcolor(15);
  outtextxy(50,200,'Isaac MSC');
  settextstyle(8,0,3);
  setcolor(2);
  outtextxy(52,232,'Tel. (065) 38716');
  setcolor(15);
  outtextxy(50,230,'Tel. (065) 38716');
  setcolor(2);
  outtextxy(52,262,'Av. Luisa Todi, 339 1Dto');
  setcolor(15);
  outtextxy(50,260,'Av. Luisa Todi, 339 1Dto');
  setcolor(2);
  outtextxy(52,292,'2900 Set£bal');
  setcolor(15);
  outtextxy(50,290,'2900 Set£bal');
  settextstyle(2,0,5);
  settextjustify(1,1);
  EscE(320,312,'Colaboradores:');
  settextstyle(8,0,3);
  settextjustify(0,0);
  setcolor(2);
  outtextxy(52,352,'Pedro Miguel Cabrita');
  setcolor(15);
  outtextxy(50,350,'Pedro Miguel Cabrita');
  setcolor(2);
  outtextxy(52,382,'Filipe Miguel Carrajola');
  setcolor(15);
  outtextxy(50,380,'Filipe Miguel Carrajola');
  setcolor(2);
  outtextxy(52,412,'Luis Silva Nunes');
  setcolor(15);
  outtextxy(50,410,'Luis Silva Nunes');
  { Controlador do teclado }
2:ch := getkey;
  case Ord(ch) of
       27,132: goto 4;
       else
               goto 2;
  end;
4:setfillpattern(G50,6);
  bar(20,30,630,450);
  SetRGBpalette(4,56,56,56);
  SetRGBpalette(7,0,0,0);
end;

end.