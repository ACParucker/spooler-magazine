{****************************************************************************}
{*                                                                          *}
{*      TITULO        : AGENDA V.2.5                                        *}
{*                                                                          *}
{*      AUTOR         : Vasco Nascimento                                    *}
{*                                                                          *}
{*      PARA          : SPOOLER Magazine dos utilizadores PC                *}
{*                                                                          *}
{*      PROGRAMADO EM : TURBO PASCAL 6.0                                    *}
{*                                                                          *}
{*      FICHEIRO      : AGEINTRO.PAS                                        *}
{*                                                                          *}
{*      FUN€¶O        : Introdu‡Æo e Linkagem de fontes e driver gr fico    *}
{*                                                                          *}
{****************************************************************************}



UNIT ageintro;

INTERFACE



{/////////////////////Procedures e Fun‡äes da unit///////////////////////////}



Procedure Intro;
Procedure EgaVgaDriverProc;
Procedure LittProc;
Procedure SansProc;
Procedure TripProc;
Procedure Abort(Msg : string);





IMPLEMENTATION

USES crt,graph;


{////////////Procedures de linkagem de fontes e do driver gr fico////////////}



Procedure EgaVgaDriverProc;external;
  {$L egavga.obj}

Procedure LittProc;external;
  {$L litt.obj}

Procedure SansProc;external;
  {$L sans.obj}

Procedure TripProc;external;
  {$L trip.obj}



{//////////Procedure que aborta o programa em caso de falha Gr fica//////////}



Procedure Abort(Msg : string);

begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;



{////////////Procedure que faz um delaypress at‚ uma tecla ser premida////////////}



Procedure delaypress(time:integer);
  var cont:integer;
      c:char;
  begin
    for cont:=1 to time do begin
      delay(1);
      if keypressed then exit;
    end;
  end;



{////////////////////////////////Introdu‡Æo//////////////////////////////////}



Procedure Intro;
  var cont,cor,x,y:integer;
  begin
    cleardevice;
    setrgbpalette(2,0,0,0);
    setrgbpalette(3,0,0,0);
    setcolor(2);
    settextjustify(1,1);
    settextstyle(3,0,4);
    outtextxy(320,160,'Vasco Nascimento');
    setcolor(3);
    outtextxy(320,240,'Apresenta');
    cont:=0;
    cor:=2;
    delaypress(500);
    if keypressed then exit;
    repeat
      setrgbpalette(cor,cont,0,0);
      delaypress(10);
      if keypressed then exit;
      cont:=cont+1;
    until cont=50;
    cont:=0;
    cor:=3;
    delaypress(2000);
    if keypressed then exit;
    repeat
      setrgbpalette(cor,cont,cont,cont);
      delaypress(10);
      if keypressed then exit;
      cont:=cont+1;
    until cont=50;
    settextjustify(1,1);
    cont:=10;
    delaypress(1000);
    if keypressed then exit;
    repeat
      settextstyle(1,0,cont);
      setcolor(9);
      outtextxy(320,320,'Agenda');
      delaypress(50);
      if keypressed then exit;
      setcolor(0);
      outtextxy(320,320,'Agenda');
      cont:=cont-1;
    until cont=4;
    setcolor(9);
    outtextxy(320,320,'Agenda');
    delaypress(500);
    if keypressed then exit;
    settextstyle(0,0,1);
    cont:=141;
    repeat
        setcolor(15);
        outtextxy(cont*4,450,'@1994');
        setcolor(0);
        outtextxy(cont*4,450,'@1994');
        cont:=cont-2;
        if keypressed then exit;
    until cont=1;
    setcolor(15);
    outtextxy(20,450,'@1994');
    cont:=50;
    cor:=2;
    delaypress(2000);
    if keypressed then exit;
    repeat
      setrgbpalette(cor,cont,0,0);
      delaypress(10);
      if keypressed then exit;
      cont:=cont-1;
    until cont=0;
    cont:=50;
    cor:=3;
    delaypress(2000);
    if keypressed then exit;
    repeat
      setrgbpalette(cor,cont,cont,cont);
      delaypress(10);
      if keypressed then exit;
      cont:=cont-1;
    until cont=0;
    delaypress(2000);
    if keypressed then exit;
    randomize;
    cont:=0;
    repeat
      x:=random(160)+240;
      y:=random(40)+310;
      putpixel(x,y,0);
      cont:=cont+1;
      if keypressed then exit;
    until cont=10000;
    setfillstyle(1,0);
    bar(240,310,400,350);
  end;



BEGIN

END.