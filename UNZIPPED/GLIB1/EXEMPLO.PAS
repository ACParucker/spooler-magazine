Program Exemplo; { Nome do programa }

uses Crt, Graph, GLib1; { Usa as units Crt, Graph e GLib1 }

var ch: char;          { define vari veis }
    m,u,n,v,d: string; {}
    out: byte;         {}

begin  { main procedure }    { []:= procedure ou function do system.tpu }
  writeln('Pressione uma tecla para executar  procedure Initialize'); {}
  ch:= RKey; { GLIB1 }
  Initialize(False,''); { GLIB1 }
  setgraphbufsize(32*1024); {}
  setcolor(15); {}
  outtextxy(0,20,'Pressione uma tecla para executar  procedure SetAllRGB'); {}
  ch:= RKey; { GLIB1 }
  SetAllRGB; { GLIB1 }
  setcolor(15); {}
  outtextxy(0,40,'Pressione uma tecla para executar  procedure Beep'); {}
  ch:= RKey; { GLIB1 }
  Beep; { GLIB1 }
  setcolor(15); {}
  outtextxy(0,60,'Ao pressionar uma tecla vai executar  function RKey'); {}
  ch:= RKey; { GLIB1 }
  setcolor(15); {}
  outtextxy(0,80,'Pressione uma tecla para executar  function RStrM'); {}
  ch:= RKey; { GLIB1 }
  m:= RStrM(10,100,3,35,'Av. Luisa Todi','Morada:',out,False); { GLIB1 }
  m:= RStrM(10,100,3,35,'Av. Luisa Todi','Morada:',out,True); { GLIB1 }
  setcolor(15); {}
  outtextxy(0,120,'Pressione uma tecla para executar  function RStrU'); {}
  ch:= RKey; { GLIB1 }
  u:= RStrU(10,140,3,40,'Isaac MSC','Nome:',out,False); { GLIB1 }
  u:= RStrU(10,140,3,40,'Isaac MSC','Nome:',out,True); { GLIB1 }
  setcolor(15); {}
  outtextxy(0,160,'Pressione uma tecla para executar  function RStrN'); {}
  ch:= RKey; { GLIB1 }
  n:= RStrN(10,180,3,4,'2900','C¢digo Postal:',out,False); { GLIB1 }
  n:= RStrN(10,180,3,4,'2900','C¢digo Postal:',out,True); { GLIB1 }
  setcolor(15); {}
  outtextxy(0,200,'Pressione uma tecla para executar  function RStrV'); {}
  ch:= RKey; { GLIB1 }
  v:= RStrV(10,220,3,10,'Valor cobran‡a:',out,False); { GLIB1 }
  v:= RStrV(10,220,3,10,'Valor cobran‡a:',out,True); { GLIB1 }
  setcolor(15); {}
  outtextxy(0,240,'Pressione uma tecla para executar  function RStrD'); {}
  ch:= RKey; { GLIB1 }
  d:= RStrD(10,260,3,'19940820','Data:',out,False); {}
  d:= RStrD(10,260,3,'19940820','Data:',out,True);  {}
  setcolor(15); {}
  outtextxy(0,280,'Pressione uma tecla para executar  procedure WW'); {}
  ch:= RKey; { GLIB1 }
  WW(10,300,'Spooler',3); { GLIB1 }
  setcolor(15); {}
  outtextxy(0,320,'Pressione uma tecla para executar  procedure WB'); {}
  ch:= RKey; {}
  WB(10,340,'Magazine',3); { GLIB1 }
  setcolor(15); {}
  outtextxy(0,360,'Pressione uma tecla para executar  procedure Box'); {}
  ch:= RKey; { GLIB1 }
  Box(50,380,40,20,0,0,'Ok',Off); { GLIB1 }
  settextjustify(0,0); {}
  setcolor(15); {}
  outtextxy(0,400,'Pressione uma tecla para executar  procedure SetRGB'); {}
  ch:= RKey; {}
  SetRGB(15,63,0,0); { GLIB1 }
  setcolor(15); {}
  outtextxy(0,410,'Pressione uma tecla para executar  procedure FadeIn'); {}
  ch:= RKey; { GLIB1 }
  FadeIn; { GLIB1 }
  FadeOut; { GLIB1 }
  setcolor(15); {}
  outtextxy(0,420,'Acabou de ver a  procedure FadeIn seguida da  procedure FadeOut'); {}
  outtextxy(0,430,'Pressione uma tecla para executar  procedure QFadeIn'); {}
  ch:= RKey; { GLIB1 }
  QFadeIn; { GLIB1 }
  delay(1000); {}
  QFadeOut; { GLIB1 }
  setcolor(15); {}
  outtextxy(0,440,'Acabou de ver a  procedure QFadeIn +delay(1000) seguida da  procedure QFadeOut'); {}
  outtextxy(0,450,'Pressione uma tecla para executar  procedure SaveScr e  ClearViewPort'); {}
  ch:= RKey; { GLIB1 }
  SaveScr(0,0,639,450,1); { GLIB1 }
  ClearViewPort; {}
  setcolor(15); {}
  outtextxy(0,460,'Pressione uma tecla para executar  procedure ReadScr'); {}
  ch:= RKey; { GLIB1 }
  ReadScr(1); { GLIB1 }
  WB(0,475,'Programado por  Isaac MSC  Mem Martins  28 de Julho de 1994',3); { GLIB1 }
  ch:= RKey; { GLIB1 }
  CloseGraph; {}
end. {}