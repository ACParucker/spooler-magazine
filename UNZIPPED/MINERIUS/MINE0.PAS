{ Auxiliar Principal do Min‚rius }
Unit Mine0;

interface

uses Crt, Graph, Mine21, Mine1, Mine2, Mine3, KeyTTT5;

procedure Menu;
procedure Apresenta;

implementation

const G50 : FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);

var ch : char;
    mx, my, v, Cur, Cur2: Integer;

{ Ecr„ de abertura do Min‚rius }
procedure Apresenta;
var Color : byte;
begin
  mx:= 639; my:= 479;
  for Color := 0 to 42 do begin SetRGBPalette(0, Color, Color, Color); delay(25); end;
  setRGBpalette(7,0,0,0);
  setRGBpalette(1,32,32,32);
  setRGBpalette(2,0,32,32);
  setRGBpalette(5,28,14,0);
  setcolor(8);
  line(0,0,mx-1,0);
  line(0,0,0,my-1);
  setcolor(15);
  line(mx,0,mx,my);
  line(0,my,mx,my);
  SetFillPattern(G50,6);
  bar(1,1,mx-1,my-1);
  setcolor(15);
  line(50,20,590,20);
  line(50,20,50,140);
  setcolor(8);
  line(51,140,590,140);
  line(590,140,590,21);
  setfillstyle(1,0);
  bar(51,21,589,139);
  setcolor(15);
  line(50,400,590,400);
  line(50,400,50,460);
  setcolor(8);
  line(51,460,590,460);
  line(590,460,590,401);
  setfillstyle(1,0);
  bar(51,401,589,459);
  settextjustify(1,1);
  settextstyle(10,0,6);
  setcolor(8);
  outtextxy(320,60,'® Min‚rius ¯');
  setcolor(15);
  outtextxy(321,61,'® Min‚rius ¯');
  settextstyle(5,0,0);
  setcolor(1);
  outtextxy(324,419,'Programado por  Isaac MSC');
  setcolor(15);
  outtextxy(320,415,'Programado por  Isaac MSC');
  setcolor(8);
  line(220,160,220,379);
  line(220,160,419,160);
  setcolor(11);
  line(220,380,420,380);
  line(420,380,420,160);
  setfillstyle(1,3);
  bar(221,161,419,379);
  setcolor(2);
  Quartzo(324,168,5,0);
  setcolor(15);
  Quartzo(320,164,5,0);
  settextstyle(2,0,2);
  setcolor(2);
  outtextxy(321,374,'(Estrutura do Cristal de Quartzo)');
  setcolor(15);
  outtextxy(320,373,'(Estrutura do Cristal de Quartzo)');
  ch := getkey;
end;

{ Faz as barras em 3d e a mensagem, consoante o estado True OR False }
procedure Barras(Qual : Byte; Tipo : Boolean);
Label 1, 2;
var x1, x2, x3, x4, x5, x7, y1, y2, y3, y4, y5, y7: Integer;
    Head, Mess: String;
begin
  settextstyle(6,0,3);
  case Qual of
       1  : begin
              x1 := 20;  y1 := 50;
              x2 := 20;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Lista dos Minerais';
              Mess := 'Lista de todos os tipos de minerais por ordem alfab‚tica';
            end;
       2  : begin
              x1 := 20;  y1 := 110;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Forma‡„o dos Minerais';
              Mess := 'Como, de onde vˆm e como s„o formados os minerais';
            end;
       3  : begin
              x1 := 20;  y1 := 170;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Como reconhecer';
              Mess := 'Quais os m‚todos utilizados para reconhecer os minerais';
            end;
       4  : begin
              x1 := 20;  y1 := 230;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Classifica‡„o dos minerais';
              Mess := 'Quais as classes e como classificar os minerais';
            end;
       5  : begin
              x1 := 20;  y1 := 290;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Litosfera';
              Mess := 'Quais as percentagens dos elementos mais significativos na litosfera';
            end;
       6  : begin
              x1 := 340;  y1 := 50;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Dicion rio Min‚rius';
              Mess := 'Gloss rio dos termos mais importantes na Minerologia';
            end;
       7  : begin
              x1 := 340;  y1 := 110;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Indice dos sistemas';
              Mess := 'Indice dos minerais classificados segundo as classes a que pertencem';
            end;
       8  : begin
              x1 := 340;  y1 := 170;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Biblioteca';
              Mess := 'Alguns livros que o utilizador interessado em minerologia poder  adquirir';
            end;
       9  : begin
              x1 := 340;  y1 := 230;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Ajuda';
              Mess := 'Ajuda para o Min‚rius (F1)';
            end;
       10 : begin
              x1 := 340;  y1 := 290;
              x2 := x1;  y2 := y1+40;
              x3 := x1+280; y3 := y2;
              x4 := x3; y4 := y1;
              x5 := x1+140; y5 := y1+15;
              x7 := 320; y7 := 472;
              Head := 'Sair para o MS-DOS';
              Mess := 'Acaba o Min‚rius e vai para o Sistema Operativo (Esc)';
            end;
       else goto 2
  end;
  if Tipo then { se True ent„o a barra vai para dentro }
   begin
     setcolor(8);
     line(x1,y1,x4,y4);
     line(x1,y1,x1,y1+40);
     setcolor(11);
     line(x1+1,y1+40,x3,y3);
     line(x4,y4+1,x3,y3);
     setfillstyle(1,3);
     bar(x1+1,y1+1,x3-1,y3-1);
     setcolor(2);
     outtextxy(x5-1,y5-1,Head);
     setcolor(15);
     outtextxy(x5-2,y5-2,Head);
     setfillpattern(G50,6);
     bar(1,465,638,478);
     settextstyle(0,0,0);
     setcolor(8);
     outtextxy(x7+1,y7+1,Mess);
     setcolor(15);
     outtextxy(x7,y7,Mess);
   end
 else { outra coisa barra para fora }
   begin
     setcolor(15);
     line(x1,y1,x4,y4);
     line(x1,y1,x1,y1+40);
     setcolor(8);
     line(x1+1,y1+40,x3,y3);
     line(x4,y4+1,x3,y3);
     setfillstyle(1,0);
     bar(x1+1,y1+1,x3-1,y3-1);
     setcolor(1);
     outtextxy(x5,y5,Head);
     setcolor(15);
     outtextxy(x5-1,y5-1,Head);
   end;
2:
end;

{ Procedure que controla o teclado durante o Menu Principal }
procedure Menu;
Label 1,2,3,4,5;
begin
  setlinestyle(0,0,0);
  SetFillPattern(G50, 6);
  bar(1,1,mx-1,my-1);
  setfillstyle(1,0);
  bar(0,16,639,23);
  bar(0,456,639,463);
  setcolor(15);
  line(0,15,639,15);
  line(0,455,639,455);
  setcolor(8);
  line(0,24,638,24);
  line(0,464,639,464);
5:settextjustify(1,1);
  setRGBpalette(1,32,32,32);
  setfillpattern(G50,6);
  bar(1,1,638,14);
  settextstyle(0,0,0);
  setcolor(8);
  outtextxy(320,9,'Min‚rius - menu principal');
  setcolor(15);
  outtextxy(319,8,'Min‚rius - menu principal');
  setfillpattern(G50,5);
  bar(30,60,310,100);
  bar(30,120,310,160);
  bar(30,180,310,220);
  bar(30,240,310,280);
  bar(30,300,310,340);
  bar(350,60,630,100);
  bar(350,120,630,160);
  bar(350,180,630,220);
  bar(350,240,630,280);
  bar(350,300,630,340);
  setcolor(8);
  Pic3D04(162,362,2,0);
  Pic3D05(482,362,2,0);
  setcolor(15);
  Pic3D04(160,360,2,0);
  Pic3D05(480,360,2,0);
  setlinestyle(0,0,0);
  Barras(1,True);
  for v := 2 to 10 do Barras(v,False);
  Cur := 1;
  Cur2 := 1;
3:ch := getkey;
    case Ord(ch) of
         200:      begin
                     Cur := Cur - 1;
                     if Cur < 1 then Cur := 10;
                     goto 1;
                   end;
         208, 32:  begin
                     Cur := Cur + 1;
                     if Cur > 10 then Cur := 1;
                     goto 1;
                   end;
         205, 9:   begin
                     case Cur of
                          1:  Cur := 6;
                          2:  Cur := 7;
                          3:  Cur := 8;
                          4:  Cur := 9;
                          5:  Cur := 10;
                          6:  Cur := 2;
                          7:  Cur := 3;
                          8:  Cur := 4;
                          9:  Cur := 5;
                          10: Cur := 1;
                     end;
                     goto 1;
                   end;
         203, 143: begin
                     case Cur of
                          1:  Cur := 10;
                          2:  Cur := 6;
                          3:  Cur := 7;
                          4:  Cur := 8;
                          5:  Cur := 9;
                          6:  Cur := 1;
                          7:  Cur := 2;
                          8:  Cur := 3;
                          9:  Cur := 4;
                          10: Cur := 5;
                     end;
                     goto 1;
                   end;
         129:      begin  { MouseDown }
                     case Cur of
                          1:  Cur := 2;
                          2:  Cur := 3;
                          3:  Cur := 4;
                          4:  Cur := 5;
                          5:  goto 3;
                          6:  Cur := 7;
                          7:  Cur := 8;
                          8:  Cur := 9;
                          9:  Cur := 10;
                          10: goto 3;
                     end;
                     goto 1;
                   end;
         128:      begin { MouseUp }
                     case Cur of
                          1:  goto 3;
                          2:  Cur := 1;
                          3:  Cur := 2;
                          4:  Cur := 3;
                          5:  Cur := 4;
                          6:  goto 3;
                          7:  Cur := 6;
                          8:  Cur := 7;
                          9:  Cur := 8;
                          10: Cur := 9;
                     end;
                     goto 1;
                   end;
         130:      begin { MouseLeft }
                     case Cur of
                          1:  goto 3;
                          2:  goto 3;
                          3:  goto 3;
                          4:  goto 3;
                          5:  goto 3;
                          6:  Cur := 1;
                          7:  Cur := 2;
                          8:  Cur := 3;
                          9:  Cur := 4;
                          10: Cur := 5;
                     end;
                     goto 1;
                   end;
         131:      begin { MouseRight }
                     case Cur of
                          1:  Cur := 6;
                          2:  Cur := 7;
                          3:  Cur := 8;
                          4:  Cur := 9;
                          5:  Cur := 10;
                          6:  goto 3;
                          7:  goto 3;
                          8:  goto 3;
                          9:  goto 3;
                          10: goto 3;
                     end;
                     goto 1;
                   end;
         207:      begin Cur := 10; goto 1; end;
         199:      begin Cur := 1; goto 1; end;
{MousEsc}132,27:   begin Barras(Cur2,False); Barras(10,True); delay(250); Halt; end;
{MoEnter}133,13:   goto 4;
{ F1 }   187:      begin Cur := 9; if Cur2 = Cur then goto 4; Barras(Cur2,False); Barras(Cur,True); delay(250); goto 4; end;
    else goto 2;
    end;
1:  case Cur of
         1 : begin Barras(Cur2,False); Barras(1,True); Cur2 := 1; goto 2; end;
         2 : begin Barras(Cur2,False); Barras(2,True); Cur2 := 2; goto 2; end;
         3 : begin Barras(Cur2,False); Barras(3,True); Cur2 := 3; goto 2; end;
         4 : begin Barras(Cur2,False); Barras(4,True); Cur2 := 4; goto 2; end;
         5 : begin Barras(Cur2,False); Barras(5,True); Cur2 := 5; goto 2; end;
         6 : begin Barras(Cur2,False); Barras(6,True); Cur2 := 6; goto 2; end;
         7 : begin Barras(Cur2,False); Barras(7,True); Cur2 := 7; goto 2; end;
         8 : begin Barras(Cur2,False); Barras(8,True); Cur2 := 8; goto 2; end;
         9 : begin Barras(Cur2,False); Barras(9,True); Cur2 := 9; goto 2; end;
         10: begin Barras(Cur2,False); Barras(10,True); Cur2 := 10; goto 2; end;
    end;
2:goto 3;
4:case Cur of
       1 : begin List; goto 5; end;
       2 : begin Form; goto 5; end;
       3 : begin Como; goto 5; end;
       4 : begin Clas; goto 5; end;
       5 : begin Lito; goto 5; end;
       6 : begin Dici; goto 5; end;
       7 : begin Indi; goto 5; end;
       8 : begin Bibl; goto 5; end;
       9 : begin Ajuda(0); goto 5; end;
       10: begin delay(250); Halt; end;
  end;
end;

end.