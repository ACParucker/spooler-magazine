VAR
    graphdriver,graphmode,errorcode,b:integer;
    color,maxx,maxy,maxcolor:word;
    oldexitproc:pointer;

function realdrawcolor(color:word) :word;
 begin
   if (getmaxcolor > 256) then setrgbpalette(1024,(color shr 10) and 31,(color shr 5) and 31,color and 31);
   realdrawcolor:=color;
 end;

function realfillcolor(color:word):word;
 begin
   if (getmaxcolor > 256) then setrgbpalette(1025,(color shr 10) and 31,(color shr 5) and 31,color and 31);
   realfillcolor:=color;
 end;

{$f+}
procedure MyExitProc;
 begin exitproc:=oldexitproc; closegraph; end;
{$f-}

{$f+}
function detectvga256:integer;       {detecta modo 1024x768x256}
var detecteddriver,suggestedmode:integer;
 begin
   detectgraph(detecteddriver,suggestedmode);
   if (detecteddriver=vga) or (detecteddriver=mcga) then begin
     suggestedmode:=4; detectvga256:=suggestedmode
   end else detectvga256:=grerror;
 end;
{$f-}

var autodetectpointer:pointer;
procedure initialize;               {inicializa graficos}
var pathtodriver:string;
 begin
   directvideo:=false; oldexitproc:=exitproc; exitproc:=@myexitproc;
   pathtodriver:='system'; autodetectpointer:=@detectvga256;
   graphdriver:=installuserdriver('svga256',autodetectpointer);
   graphdriver:=detect; initgraph(graphdriver,graphmode,pathtodriver);
   randomize; maxcolor:=getmaxcolor; maxx:=getmaxx; maxy:=getmaxy;
 end;

procedure usecolor(b:word);              {escolha cor}
 begin
   color:=b; setfillstyle(solidfill, realfillcolor(color));
   setcolor(realdrawcolor(color));
 end;

procedure L_T(i,b:integer);               {escolha tipo letra,dimensao}
 begin
   settextstyle(i,horizdir,b);
 end;