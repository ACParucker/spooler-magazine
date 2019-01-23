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
{*      FICHEIRO      : GTEXT.PAS                                           *}
{*                                                                          *}
{*      FUN€¶O        : Cont‚m rotinas para edi‡Æo em modo gr fico                              *}
{*                                                                          *}
{****************************************************************************}



UNIT Gtext;

INTERFACE



{//////////////////////////Constantes Declaradas/////////////////////////////}



 CONST
   cr = #13;
   esc = #27;
   bs = #08;
   up = $4800;
   down = $5000;
   left = $4B00;
   right = $4D00;
   pgup = $4900;
   pgdown = $5100;
   home = $4700;
   ends = $4F00;
   insert = $5200;
   delete = $5300;



{/////////////////////////////Tipos Declarados///////////////////////////////}



 TYPE elementos=string[30];



{/////////////////////Procedures e Fun‡äes da unit///////////////////////////}



 Function Kb:integer;
 Function InToStr(num:longint;tam:integer):string;
 Procedure UpcaseStr(s:string);
 Function Pad(s:string;c:char;tam:byte):string;
 Procedure ReadInt(var code:longint;max,delcolor:word);
 Procedure ReadEle(var s:elementos;maxchars:integer;delcolor:word);
 Procedure ReadStr(var s:string;maxchars:integer;delcolor:word);



IMPLEMENTATION

USES graph, crt;



{////////////////Procedure que passa uma String para Mai£sculas//////////////}



  Procedure UpcaseStr(s:string);
    var i:integer;

    begin
      for i:=1 to length(s) do
        s[i]:=upcase(s[i]);
    end;



{/Fun‡Æo que transforma um n§ inteiro numa string com um determinado tamanho/}



  Function InToStr(num:LongInt;tam:integer):string;
    var s:string;
        cont:integer;

    begin
      str(num,s);
      if length(s) < tam then
        begin
          move(s[1], s[succ(tam - length(s))],length(s));
          fillchar(s[1],tam - length(s),'0');
        end;
      s[0]:=char(tam);
      intostr:=s;
    end;



{////Fun‡Æo que acaba de preencher uma string com um determinado caracter////}



    Function Pad(s:string;c:char;tam:byte):string;
      begin
        if length(s) < tam then
          fillchar(s[succ(length(s))], tam-length(s), c);
        s[0]:=char(tam);
        Pad:=s;
      end;



{///////////////////////////Fun‡Æo que lˆ uma tecla//////////////////////////}



  Function Kb:integer;
    var ch1,ch2:integer;

    begin
      ch1:=ord(readkey);
      if ch1 = 0 then begin
        ch2 := ord(readkey);
        ch2 := ch2 shl 8;
        ch2 := ch2 or ch1;
        kb:=ch2;
      end
      else
        kb := ch1;
    end;



{////////////////////Procedure que edita o tipo ELEMENTOS////////////////////}



  Procedure ReadEle(var s:elementos;maxchars:integer;delcolor:word);
    begin
      readstr(s,maxchars,delcolor);
      if length(s) < 29 then begin
        repeat
          s:=s+' ';
        until length(s) = 29;
        s:=s+chr(13);
      end;
    end;



{/////////////////////Procedure que edita o tipo INTEGER/////////////////////}



  Procedure ReadInt(var code:longint;max,delcolor:word);
  var
    s:elementos;
    i:integer;
  begin
    readstr(s,max,delcolor);
    val(s,code,i);
  end;



{//////////////////////Procedure que edita o tipo STRING/////////////////////}



 Procedure ReadStr(var s:string;maxchars:integer;delcolor:word);
  const
    buff2: string[2] = 'c_';
  var
    i, int, currloc, oldcolor: integer;
    view: viewporttype;
    charbuff: string[2];
    ch: char;
  begin
    s[0] := #0;
    currloc := 0;
    charbuff[0] := #1;
    getviewsettings(view);
    if maxchars <= 0 then exit;
    outtextxy(getx,gety,'_');
    int := kb;
    ch:=chr(int);
    ch:=upcase(ch);
    repeat
    while ch <> cr do begin
      if ch=chr(27) then ch:=chr(32);
      if ch=chr(199) then ch:=chr(142);
      if ch=chr(229) then ch:=chr(153);
      if ch=chr(130) then ch:=chr(144);
      if (int=up) or (int=down) or (int=left) or (int=right) or (int=home)
        or (int=ends)or (int=pgup) or (int=pgdown) or (int=insert)
        or (int=delete) then ch:=chr(32);
      if ch = bs then begin
        if currloc > 0 then begin
           if currloc<= maxchars then begin
             oldcolor := getcolor;
             setcolor(delcolor);
             charbuff[1] := s[currloc];
             buff2[1] := s[currloc];
             outtextxy(getx-textwidth(charbuff),gety,buff2);
             setcolor(oldcolor);
             moveto(getx-textwidth(charbuff),gety);
             dec(currloc);
             s[0]:=chr(currloc);
           end;
        end;
      end;
      if ch <> bs then begin
        if currloc < maxchars then begin
          oldcolor := getcolor;
          setcolor(delcolor);
          outtextxy(getx,gety,'_');
          setcolor(oldcolor);
          inc(currloc);
          s[0] := chr(currloc);
          s[currloc] := ch;
          outtext(ch);
        end
        else begin
          sound(200); delay(100); nosound;
        end
      end;
      if currloc <= maxchars then
        outtextxy(getx,gety,'_');
      int := kb;
      ch:=chr(int);
      ch:=upcase(ch);
    end;
    until ch=cr;
    if currloc <= maxchars then begin
      oldcolor := getcolor;
      setcolor(getbkcolor);
      outtextxy(getx,gety,'_');
      setcolor(oldcolor);
    end;
    if length(s) = 0 then begin
       sound(200);
       delay(100);
       nosound;
       readstr(s,maxchars,delcolor);
    end;
  end;



  BEGIN

  END.


