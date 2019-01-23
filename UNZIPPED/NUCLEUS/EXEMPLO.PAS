{ Programado por Isaac MSC em 19/07/1994 }
{ Para   a   revista   SPOOLER  Magazine }
Program Exemplo; { Nome do programa }

Uses Crt, KeyTTT5; { Usa a UNIT CRT e KEYTTT5 do TechnoJock's Turbo Toolkit }

var ch: char;      { Define }
    Out,curr:byte; { as vari†veis }

procedure MBar(X,Y: Integer;txt: string;d: boolean); { Cria as Barras }
begin
  if d then { se estÑo ligadas }
     begin
       textcolor(14);
       textbackground(3);
     end
  else { se estÑo desligadas }
     begin
       textcolor(14);
       textbackground(1);
     end;
  gotoxy(x,y); { pîe o cursor no sitio escolhido }
  write(' '+txt+' '); { escreve o texto dentro da barra }
  gotoxy(1,1); { volta a por o cursor no °nicio }
end;

function QB: byte; { controla o rato }
label 1,2,3; { DefiniáÑo de Labels }
begin
1:MBar(30,10,'1. Insere  registo',False); { Chama }
  MBar(30,11,'2. Elimina registo',False); { a procedure }
  MBar(30,12,'3. Sai  para o DOS',False); { MBar (Make Bar) }
  case curr of { no caso da currente barra ser }
       1: MBar(30,10,'1. Insere  registo',True); { 1 }
       2: MBar(30,11,'2. Elimina registo',True); { 2 }
       3: MBar(30,12,'3. Sai  para o DOS',True); { 3 }
  end;
2:ch:= getkey; { funáÑo KEYTTT5 que controla os movimentos do rato }
  case ord(ch) of { no caso do ordinal(da CHAR ch) ser }
       128: curr:= curr - 1; { currente barra = currente barra - 1 }
       129: curr:= curr + 1; { currente barra = currente barra + 1 }
       132: begin QB:= 0; goto 3; end; { Mouse Esc (RightButton) }
       133: begin QB:= curr; goto 3; end; { Mouse Enter (LeftButton) }
  else goto 2; { se nÑo for nada do especificado entÑo vai para o Label 2 }
  end;
  if curr = 0 then curr:= 1 { se currente barra = o entÑo curr = 1 }
  else if curr = 4 then curr:= 3; { se curr = 4 entÑo curr = 3 }
  goto 1; { vai para o Label 1 }
3:
end;

begin
  ClrScr; { Limpa o ecrÑ }
  MBar(30,10,'1. Insere  registo',False); { Chama }
  MBar(30,11,'2. Elimina registo',False); { a procedure }
  MBar(30,12,'3. Sai  para o DOS',False); { MBar (Make Bar) }
  curr:= 1; { define o valor da var BYTE curr = 1 }
  Out:= QB; { chama a function QB atravÇs da var BYTE Out }
  textcolor(15); { Define o a cor foreground 15(Branco) }
  textbackground(0); { Define a cor background 0(Preto) }
  gotoxy(1,20); { Mete o cursor na coluna 1 da linha 20 }
  writeln('OpáÑo escolhida: ',Out); { Diz qual a opáÑo escolhida }
  writeln; { uma linha de espaáo }
  writeln('ê facil!'); { coment†rio alusivo ao programa Exemplo }
  delay(1000); { pausa de 1 segundo = 1000 milÇsimos de segundo }
end.