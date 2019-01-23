{$M 16384,0,200000 }
Unit Efeitos;

Interface

Uses Crt;

Type
    Screenptr= Record { Mapa de um ecran 80x25 }
               Pos: Array [1..80,1..25] Of Record
                Ch: Char;
                At: Byte;
               End;
               Cursx, Cursy: Integer;
               End; { do Record }



Var
   Loop: Integer;
   Ecran: Array[0..3999] Of Byte; { Vari†vel para guardar um Çcran}
   ScreenSegment,Loc : Word;
   Locate: Pointer;

Procedure Quadro(x,y,x1,y1,cor: Integer);

Procedure Quadro1(x,y,x1,y1,cor: Integer);

Procedure Quadro2(x,y,x1,y1,cor: Integer);

Procedure quadro3(x,y,x1,y1,cor: integer);

Procedure Quadro4(x,y,x1,y1: integer);

Procedure Cls;

Procedure Memoria(Oque,Oque1: Char);

Procedure Encher(Car: Char);

procedure top;
Implementation


{*****************************}
{ Limpa o Çcran. }

Procedure Cls;


Var
   xr, yr: Integer;
Begin
  Textbackground(0);
  Randomize;
  Gotoxy(1,25);
  Delline;
  For Loop:= 1 To 4000 Do
      Begin
        xr:= Random(79)+1;
        yr:= Random(24)+1;
        Gotoxy(xr,yr);
        Write('  ');
      End;

  Clrscr;
End;


(****************************)
{ Faz a sombra dos quadros. }

Procedure Quadro;
Begin
  Window(x,y,x1,y1);
  Textbackground(Cor);
  Clrscr;
  Window(1,1,80,25);
  Loc:= ((x-1)*2)-1;

  For Loop:= y+1 To y1 Do { Linhas }
	Begin
         FillChar( Ptr(Screensegment, (Loc + (160 * (Loop-1))))^, 1, $08);
         FillChar( Ptr(Screensegment, (Loc -2 +(160 * (Loop-1))))^, 1, $08);
	End;
  Loc:= ((x-2)*2)-1;

  For Loop:= x To x1   Do
      Begin
       FillChar( Ptr(Screensegment, (Loc + (160 * y1)))^, 1, $08);
       Loc:= LOc+ 2;
      End;



End;

(****************************)
Procedure Quadro1;

Begin
  Textcolor(cor);
  For Loop:= x To x1 Do
             Begin
               Gotoxy(Loop,y);
               Write(#223);
               Gotoxy(Loop,y1);
               Write(#220);
             End;

  For Loop:= y To y1 Do
             Begin
               Gotoxy(x,Loop);
               Write(#219);
               Gotoxy(x1,Loop);
               Write(#219);
             End;



End;

(****************************)

Procedure Quadro3(x,y,x1,y1,cor :integer);
begin
Textcolor(cor);
  Gotoxy(x,y);
  Write(#201);
  Gotoxy(x1,y);
  Write(#187);
  Gotoxy(x,y1);
  Write(#200);
           Gotoxy(x1,y1);
           Write(#188);

  For Loop:= x+1 To x1-1 Do
             Begin
               Gotoxy(Loop,y);
               Write(#205);
               Gotoxy(Loop,y1);
               Write(#205);
             End;

  For Loop:= y+1 To y1-1 Do
             Begin
               Gotoxy(x,Loop);
               Write(#186);
               Gotoxy(x1,Loop);
               Write(#186);
             End;


end;

{****************************}
{ Grava ou Là um determinado ecran. }

Procedure Memoria;

Begin
  Oque:= Upcase(Oque);
  Oque1:= Upcase(Oque1);

  If Oque='G' Then
  Begin
  Getmem(Locate,4000);
  Move( Ptr(Screensegment, 0000)^,Locate^,4000);
  End;
  If Oque='L' Then
  Begin
  Move(Locate^, Ptr(Screensegment,0000)^,4000);
  If Oque1='F' Then Freemem(LOcate,4000);
  End;

End;
(****************************)
{ Enche o ecran inteiro com um determinado caracter. }
Procedure Encher;

Begin
  Loop:= 0;
  Repeat
             Fillchar(Ptr(Screensegment, LOop)^,1,Car);
             Loop:= Loop+2;
 Until Loop>= 3999;
End;

(****************************)

Procedure Quadro2;

Begin
  Textcolor(cor);
  Gotoxy(x,y);
  Write(#218);
  Gotoxy(x1,y);
  Write(#191);
  Gotoxy(x,y1);
  Write(#192);
  If (x1=80) And (y1=25) Then
       Begin
         Fillchar(Ptr(Screensegment,3998)^,1,'Ÿ');
         If Lo(Lastmode)<> 7 Then
                           Fillchar(Ptr(Screensegment,3999)^,1,$01);
       End
     Else
         Begin
           Gotoxy(x1,y1);
           Write(#217);
         End;

  For Loop:= x+1 To x1-1 Do
             Begin
               Gotoxy(Loop,y);
               Write(#196);
               Gotoxy(Loop,y1);
               Write(#196);
             End;

  For Loop:= y+1 To y1-1 Do
             Begin
               Gotoxy(x,Loop);
               Write(#179);
               Gotoxy(x1,Loop);
               Write(#179);
             End;



End;

(****************************)

Procedure Quadro4;

Begin
  textbackground(7);
  Textcolor(15);
  Gotoxy(x,y);
  Write(#218);
  Gotoxy(x,y1);
  Write(#192);
  textcolor(0);
  Gotoxy(x1,y);
  Write(#191);
  
  If (x1=80) And (y1=25) Then
       Begin
         Fillchar(Ptr(Screensegment,3998)^,1,'Ÿ');
         If Lo(Lastmode)<> 7 Then
                           Fillchar(Ptr(Screensegment,3999)^,1,$70);
       End
     Else
         Begin
           Gotoxy(x1,y1);
           Write(#217);
         End;

  For Loop:= x+1 To x1-1 Do
             Begin
               textcolor(15);
               Gotoxy(Loop,y);
               Write(#196);
               textcolor(0);
               Gotoxy(Loop,y1);
               Write(#196);
             End;

  For Loop:= y+1 To y1-1 Do
             Begin
               textcolor(15);
               Gotoxy(x,Loop);
               Write(#179);
               textcolor(0);
               Gotoxy(x1,Loop);
               Write(#179);
             End;



End;

(****************************)
procedure top;

begin

   textcolor(0);
   textbackground(3);
   clrscr;
   quadro3(1,1,80,25,0);
   gotoxy(1,5);
   write('…Õº');
   gotoxy(1,4);
   write('  ∫');
   gotoxy(1,3);
   write('  …ÕÕº');
   gotoxy(1,2);
   write('     ∫');
   gotoxy(1,1);
   write('     …');
   gotoxy(1,25);
   write('     »');
   gotoxy(1,24);
   write('     ∫');
   gotoxy(1,23);
  write( '  »ÕÕª');
  gotoxy(1,22);
  write('  ∫');
  gotoxy(1,21);
  write('»Õª');
  gotoxy(1,20);
  gotoxy(78,5);
  write('»Õª');
  gotoxy(75,4);
  write('   ∫  ');
  gotoxy(75,3);
  write( '»ÕÕª  ');
  gotoxy(75,2);
  write('∫     ');
  gotoxy(75,1);
  write('ª     ');
  gotoxy(75,25);
  write('º    ');
  gotoxy(75,24);
  write('∫     ');
  gotoxy(75,23);
  write('…ÕÕº  ');
  gotoxy(75,22);
  write('   ∫  ');
  gotoxy(75,21);
  write('   …Õº');

  if lo(lastmode)= 7 then { Se for existir uma placa de video, MONO }
                          { vai para B000 se nÑo vai para B800. }
    begin
     fillchar(ptr($B000,3998)^,1,32);
     fillchar(ptr($B000,3999)^,1,$33);
     end
     else
     begin
       fillchar(ptr($B800,3998)^,1,32);
     fillchar(ptr($B800,3999)^,1,$33);
     end;



end;
(****************************)

Begin

  { Verifica se a placa de video Ç mono ou poli. }

  If (Lo(Lastmode)= 7) Then {mono }
                    Screensegment:= $B000

  Else
      Screensegment:= $B800;




End.


