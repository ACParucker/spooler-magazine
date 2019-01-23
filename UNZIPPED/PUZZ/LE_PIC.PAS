procedure le_pic(k,l:integer;s:string);    {Le imagens}
var
    q,w   :integer;
    carac :char;

begin
  assign(f,'amk\'+s+'.amk'); reset(f);
  readln(f,q); readln(f,w); y:=0;
  repeat
    for x:=0 to q do begin
      read(f,tecla); putpixel(k+x,l+y,ord(tecla));
    end;
    readln(f); inc(y);
  until(eof(f));
  close(f);
end;

{((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))}
procedure pic(nivel:shortint);   {Relaciona nivel com nome imagem}
 begin
   for i:=230 to 500 do begin
     d:=random(2); if d=0 then usecolor(28) else usecolor(27);
     line(330,i,maxx-330,i);
   end;
   case nivel of
     1:le_pic(330,230,'metallic');
     2:le_pic(330,230,'manowar');
     3:le_pic(330,230,'hellowee');
     4:le_pic(330,230,'carin');
     5:le_pic(330,230,'ship');
   end;
   usecolor(0); for i:=0 to 2 do rectangle(330+i,230+i,maxx-330-i,499+i);
 end;