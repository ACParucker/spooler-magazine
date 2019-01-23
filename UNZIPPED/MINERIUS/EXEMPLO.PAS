{ Programado por Isaac MSC em 19/07/1994 }
{ Para   a   revista   SPOOLER  Magazine }
program Exemplo; { Nome do programa }

uses Crt, Graph, Mine21; { Usa as units Crt, Graph, Mine21 }

var Gd, Gm: Integer; { Define as vari veis }
    pal: palettetype; { esta ‚ a vari vel que nos d  acesso a mudar as cores }
    ff: integer; {}
    ch: char;    {}

procedure Pics(qp: byte); { Procedure chama os Pics3D## }
const x = 320; { declara‡„o de constantes }
      y = 80;  {}
      s = 8;   {}
      w = 3;   {}
begin
  case qp of { se o qp for: }
       14: begin { 14 ent„o corre este begin end; }
             setcolor(4); { escolhe cor 4: cyan escuro }
             Pic3D14(x+5,y+5,s,w); { executa o desenho 5 pixels abaixo }
             setcolor(6); { escolhe cor 6: branco }
             Pic3D14(x,y,s,w); { executa o desenho de forma a dar 3D }
           end;
       15: begin                { igual ao 14 s¢ que ‚ 15 [...] }
             setcolor(4);
             Pic3D15(x+5,y+5,s,w);
             setcolor(6);
             Pic3D15(x,y,s,w);
           end;
       16: begin                { igual ao 14 s¢ que ‚ 16 [...] }
             setcolor(4);
             Pic3D16(x+5,y+5,s,w);
             setcolor(6);
             Pic3D16(x,y,s,w);
           end;
       17: begin                { igual ao 14 s¢ que ‚ 17 [...] }
             setcolor(4);
             Pic3D17(x+5,y+5,s,w);
             setcolor(6);
             Pic3D17(x,y,s,w);
           end;
       18: begin                { igual ao 14 s¢ que ‚ 18 [...] }
             setcolor(4);
             Pic3D18(x+5,y+5,s,w);
             setcolor(6);
             Pic3D18(x,y,s,w);
           end;
       19: begin                { igual ao 14 s¢ que ‚ 19 [...] }
             setcolor(4);
             Pic3D19(x+5,y+5,s,w);
             setcolor(6);
             Pic3D19(x,y,s,w);
           end;
       20: begin                { igual ao 14 s¢ que ‚ 20 [...] }
             setcolor(4);
             Pic3D20(x+5,y+5,s,w);
             setcolor(6);
             Pic3D20(x,y,s,w);
           end;
       21: begin                { igual ao 14 s¢ que ‚ 21 [...] }
             setcolor(4);
             Pic3D21(x+5,y+5,s,w);
             setcolor(6);
             Pic3D21(x,y,s,w);
           end;
       22: begin                { igual ao 14 s¢ que ‚ 22 [...] }
             setcolor(4);
             Pic3D22(x+5,y+5,s,w);
             setcolor(6);
             Pic3D22(x,y,s,w);
           end;
       23: begin                { igual ao 14 s¢ que ‚ 23 [...] }
             setcolor(4);
             Pic3D23(x+5,y+5,s,w);
             setcolor(6);
             Pic3D23(x,y,s,w);
           end;
  end;
end;

procedure MkPics; { Controla o teclado e faz a mudan‡a de Pics }
begin { in¡cio de MkPics }
  for ff:= 14 to 23 do       { executa ff de 14 para 23 e faz }
      begin                  { come‡a rotina }
        Pics(ff);            { chama a proc. Pics com o valor de ff }
        ch:= readkey;        { espera at‚ que o seja pressionada uma tecla }
        setfillstyle(1,3);   { define o estilo de preenchimento }
        bar(150,70,490,410); { com o estilo faz uma caixa de x1,y1 a x2,y2 }
      end;                   { acaba rotina }
end; { fim de MkPics }

begin { inicio do Main Procedure }
  Gd := VGA;   { define que o graphdriver seja VGA }
  Gm := VGAHI; { define tamb‚m que o graphmode seja VGA HIgh resolution }
  InitGraph(Gd, Gm, '\tp7\bgi');  { inicia o modo gr fico }
  if GraphResult <> grOk then Halt(1); { se existe um erro, acaba }
  getpalette(pal); { regista na VAR pal toda a informa‡„o sobre as cores, }
  { qual o valor RGB (R= Red G= Green B= Blue) de cada uma delas, o tamanho }
  for ff:= 0 to 42 do setrgbpalette(pal.colors[0],ff,ff,ff); { inicia o }
  { programa fazendo um fade da cor preta at‚ ao cinzento }
  setrgbpalette(pal.colors[1],32,32,32); { define 1:= Cinzento escuro }
  setrgbpalette(pal.colors[2],52,52,52); { define 2:= Cinzento claro }
  setrgbpalette(pal.colors[3],00,42,42); { define 3:= Azul marinho (cyan) }
  setrgbpalette(pal.colors[4],00,32,32); { define 4:= Cyan escuro }
  setrgbpalette(pal.colors[5],00,52,52); { define 5:= Cyan claro }
  setrgbpalette(pal.colors[6],63,63,63); { define 6:= Branco }
  setcolor(1); { escolhe a cor 1 }
  rectangle(0,0,638,478); { faz um rectanglo }
  setcolor(2); { escolhe a cor 2 }
  rectangle(1,1,639,479); { faz outro rectanglo que d  o efeito 3D dentro }
  settextjustify(1,1); { define que o texto seja centrado em x e y }
  setcolor(1); { escolhe a cor 1 }
  outtextxy(322,22,'Programa EXEMPLO para a Spooler Magazine');  { escreve }
  outtextxy(322,462,'pressione uma tecla'); { 2 pixels abaixo }
  setcolor(6); { escolhe a cor 6 }
  outtextxy(320,20,'Programa EXEMPLO para a Spooler Magazine'); { escreve }
  outtextxy(320,460,'pressione uma tecla'); { de maneira a dar 3D }
  setfillstyle(1,3); { define estilo de preenchimento }
  bar(140,60,500,420); { com o estilo faz uma caixa de x1,y1 a x2,y2 }
  setcolor(4); { escolhe a cor 4 }
  rectangle(141,61,500,420); { faz um rectanglo }
  setcolor(5); { escolhe a cor 2 }
  rectangle(140,60,499,419); { faz outro rectanglo que d  o efeito 3D fora }
  MkPics; { chama a proc MkPics }
  RestoreCRtMode; { restaura o ecr„ e volta ao estado normal: 80x25 textmode }
end. { EOF }