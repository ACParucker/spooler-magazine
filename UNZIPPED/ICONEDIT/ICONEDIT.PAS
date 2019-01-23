{$M 16384,0,655360}
Program DosIcon;

uses Graph,Auxiliar,Crt,Dos;

Type
 IconIDType=Array[0..61] of Byte;

Const
 IconX=356;
 IconY=120;
 ZoomX=31;
 ZoomY=121;
 IconID:IconIDType=(0,0,1,0,1,0,32,32,16,0,0,0,0,0,232,2,0,0,22,0,
                              0,0,40,0,0,0,32,0,0,0,64,0,0,0,1,0,4,0,0,0,0,
                              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

type
 IconType=array[0..765] of byte;
 Pixeltype=record Pixel:byte; Mask:Boolean; end;
 DIconType=array[0..31,0..31] of Pixeltype;
 ZColorType=Array[0..15] of Pointer;
 ButtonType=Record X1,Y1,X2,Y2:Integer; Bitmap:Pointer; Pressed:Boolean; End;

var
 VirtColor:Array[0..15] of Byte;
 Icon:IconType;
 DIcon:DIconType;
 ZoomCol:ZColorType;
 ch:Char;
 MainButton:Array[1..12] of ButtonType;
 Terminar, IconChanged:Boolean;
 RGBPalette:RGBPaletteType;
 Tool, FillX, FillY, ActiveColor, ScreenColor, RColor, LColor:Byte;
 FillCheck:Array[0..31,0..31] of Boolean;
 DatDir:String;

(*Begin****** Icon Procedures ****************)

Function IconOk(IconName:String): Boolean;
Var
 IconFile:File;
 ID: IconIDType;
 Aux:Boolean;
 Loop:integer;
Begin
 Aux:=True;
 assign(IconFile,IconName);
 {$I-}
 reset(IconFile,1);
 If IOResult>0 then Aux:=False;
 {$I+}
 If Aux then
 Begin
  If FileSize(IconFile)<>766 then Aux:=False;
   If Aux then
   Begin
    blockread(IconFile,ID,62);
    For Loop:=0 to 61 do
     If (IconID[Loop]<>ID[Loop]) and not((loop=42) or (loop=43)) then Aux:=False;
   End;
  close(IconFile);
 End;
 IconOk:=Aux;
End;

Procedure LoadIcon(IconName:String);
Var
 IconFile:File;
Begin
 assign(IconFile,IconName);
 reset(IconFile,1);
 blockread(IconFile,Icon,766);
 close(IconFile);
End;

Procedure SaveIcon(IconName:String);
Var
 IconFile:File;
Begin
 assign(IconFile,IconName);
 {$I-}
 rewrite(IconFile,1);
 {$I+}
 If IOResult=0 then
 Begin
  blockwrite(IconFile,Icon,766);
  close(IconFile);
 End;
End;

Procedure PaletteMismatch;
Var Loop:Integer;
Begin
 For Loop:=0 to 15 do
  With RGBPalette[Loop] do
  Begin
   B:=Icon[62+4*Loop];
   G:=Icon[63+4*Loop];
   R:=Icon[64+4*Loop];
  End;
  SetRGB16Palette(RGBPalette);
End;

Procedure PaletteAdapt;
Var Loop1,Loop2:Byte;
Begin
 For Loop1:=0 to 15 do
  For Loop2:=0 to 15 do
   With RGBPalette[Loop2] do
    If (B=Icon[62+4*Loop1]) And (G=Icon[63+4*Loop1]) And (R=Icon[64+4*Loop1])
       then VirtColor[Loop1]:=Loop2;
 IconChanged:=True;
 SetRGB16Palette(RGBPalette);
End;

Procedure InitButton(var Button:ButtonType);
Begin
 With Button do
 Begin
  GetImage(X1+2,Y1+2,X2-1,Y2-1,BitMap^);
 End;
End;

Procedure ActButton(var Button:ButtonType);
Begin
 With Button do
 Begin
  If Pressed then
  Begin
   SetColor(8);
   SetLineStyle(0,0,3);
   Moveto(X2,Y1+1);
   LineTo(X1,Y1+1);
   MoveTo(X1+1,Y1);
   LineTo(X1+1,Y2);
   PutImage(X1+3,Y1+3,BitMap^,0)
  End
  Else
  Begin
   SetColor(15);
   SetLineStyle(0,0,1);
   Moveto(X2,Y1);
   LineTo(X1,Y1);
   LineTo(X1,Y2);
   Moveto(X2-1,Y1+1);
   LineTo(X1+1,Y1+1);
   LineTo(X1+1,Y2-1);
   PutImage(X1+2,Y1+2,BitMap^,0)
  End;
 End;
End;

Procedure QPaletteBox;
Const
 Bx=165; By=162;
Var
 F:File;
 QPalette, BackGround:Pointer;
 ch1:Char;
 Sim, Nao:ButtonType;
 Termina:Boolean;
Begin
 HidePointer;
 GetMem(QPalette,20102);   
 GetMem(BackGround,20102);
 GetImage(Bx,By,Bx+250,By+156,BackGround^);
 Assign(f,DatDir+'iconedit.dat');
 Reset(f,1);
 Seek(f,174334);
 BlockRead(f,QPalette^,20102);
 Close(f);
 PutImage(Bx,By,QPalette^,0);
 With Sim do
 Begin
  x1:=bx+25; y1:=by+96; x2:=bx+91; y2:=by+132;
  GetMem(BitMap,ImageSize(X1+2,Y1+2,X2-1,Y2-1));
  InitButton(Sim);
  Pressed:=false;
 End;
 With Nao do
 Begin
  x1:=bx+156; y1:=by+96; x2:=bx+222; y2:=by+132;
  GetMem(BitMap,ImageSize(X1+2,Y1+2,X2-1,Y2-1));
  InitButton(Nao);
  Pressed:=False;
 End;

 ActButton(sim);
 ActButton(nao);

 ShowPointer;
 Termina:=False;

 Repeat
  Repeat Until Keypressed Or (MouseButton=1);
  If MouseButton=1 then
  Begin
   With Sim do
   Begin
    If MouseIn(X1,Y1,X2,Y2) then
    Begin
     HidePointer;
     Pressed:=True;
     ActButton(Sim);
     ShowPointer;
     Repeat until MouseButton=0;
     HidePointer;
     Pressed:=False;
     ActButton(Sim);
     ShowPointer;
     If MouseIn(X1,Y1,X2,Y2) then Begin PaletteMismatch; Termina:=True End;
    End;
   End;
   With Nao do
   Begin
    If MouseIn(X1,Y1,X2,Y2) then
    Begin
     HidePointer;
     Pressed:=True;
     ActButton(Nao);
     ShowPointer;
     Repeat until MouseButton=0;
     HidePointer;
     Pressed:=False;
     ActButton(Nao);
     ShowPointer;
     If MouseIn(X1,Y1,X2,Y2) then Begin PaletteAdapt; Termina:=True End;
    End;
   End;
  End;
  If Keypressed then
  Begin
   Ch1:=ReadKey;
   Case UpCase(Ch1) of
    #0 : ch1:=ReadKey;
    'S': Begin PaletteMismatch; Termina:=True End;
    'N': Begin PaletteAdapt; Termina:=True End;
   End;
  End;
 until termina;

 HidePointer;

 PutImage(Bx,By,BackGround^,0);
 FreeMem(QPalette,20102);
 FreeMem(BackGround,20102);
 ShowPointer;
End;

Procedure DescodificaIcon;
Var
 Lin, Col:Integer;
 Loop, Total:integer;
 PalOk:Boolean;
Begin
 For Loop:=0 to 15 do VirtColor[Loop]:=Loop;
 PalOk:=True;
 For Loop:=0 to 15 do
  With RGBPalette[Loop] do
   If (B<>Icon[62+4*Loop]) Or
      (G<>Icon[63+4*Loop]) Or
      (R<>Icon[64+4*Loop]) Or
      (0<>Icon[65+4*Loop]) then PalOk:=False;
 If Not(PalOk) then QPaletteBox;

 for lin:=31 downto 0 do
  for col:=0 to 15 do
  begin
   Total:=496+Col-Lin*16;
   DIcon[lin,col*2].pixel:=VirtColor[(Icon[126+Total] AND $F0) DIV $10];
   DIcon[Lin,Col*2].mask:=(Icon[638+Total Div 4] AND power(2, 7-((Total*2) Mod 8)))=0;   {0 Cor Real}
   DIcon[lin,col*2+1].pixel:=VirtColor[Icon[126+Total] AND $F];                                     {1  Inversa}
   DIcon[Lin,Col*2+1].mask:=(Icon[638+Total Div 4] AND power(2,7-((Total*2+1) Mod 8)))=0;
  end;
End;


Procedure CodificaIcon;
Var
 Lin, Col:Integer;
 Loop, Total:integer;
Begin

 For Loop:=0 to 15 do
  With RGBPalette[Loop] do
  Begin
   Icon[62+4*Loop]:=B;
   Icon[63+4*Loop]:=G;
   Icon[64+4*Loop]:=R;
   Icon[65+4*Loop]:=0;
  End;

 for lin:=31 downto 0 do
  for col:=0 to 15 do
  begin
   Total:=496+Col-Lin*16;
   Icon[126+Total]:=DIcon[lin,col*2].pixel*$10+DIcon[lin,col*2+1].Pixel;
   If DIcon[Lin,Col*2].mask then
    Icon[638+Total Div 4]:=Icon[638+Total Div 4] And (255-power(2, 7-((Total*2) Mod 8)))
   Else
    Icon[638+Total Div 4]:=Icon[638+Total Div 4] Or power(2, 7-((Total*2) Mod 8));
   If DIcon[Lin,Col*2+1].mask then
    Icon[638+Total Div 4]:=Icon[638+Total Div 4] And (255-power(2, 7-((Total*2+1) Mod 8)))
   Else
    Icon[638+Total Div 4]:=Icon[638+Total Div 4] Or power(2, 7-((Total*2+1) Mod 8));
  end;
End;

(*End******** Icon Procedures ****************)


Procedure DrawIcon;
Var
 Lin,Col:Integer;
Begin
 HidePointer;
 for lin:=0 to 31 do
  for col:=0 to 31 do
   with DIcon[lin,col] do
    if mask then
     putpixel(IconX+col,IconY+lin, pixel)
    else
     putpixel(IconX+col,IconY+lin, Pixel xor ScreenColor);
 ShowPointer;
End;

Procedure GetZoomColors;
Var
 Loop:integer;
 F:File;
Begin
 Assign(f,DatDir+'iconedit.dat');
 Reset(f,1);
 Seek(f,153624);
 For Loop:=0 to 15 do
 Begin
  GetMem(ZoomCol[Loop],38);
  BlockRead(f,ZoomCol[Loop]^,38);
 End;
 close(f);
End;

Procedure ActualizaZoom;
Var
 Lin,Col,AuxColor:integer;
Begin
 HidePointer;
 For Lin:=0 to 31 do
  For Col:=0 to 31 do
  Begin
   With DIcon[Lin,Col] do
    if mask then AuxColor:=Pixel Else AuxColor:=Pixel xor ScreenColor;
   PutImage(ZoomX+Col*9,ZoomY+Lin*9,ZoomCol[AuxColor]^,0);
  End;
 ShowPointer;
End;

Procedure DefineButtons;
Var
 i:integer;
Begin

 With MainButton[1] do Begin X1:=25;  Y1:=430; X2:=167; Y2:=466; Pressed:=True; End;
 With MainButton[2] do Begin X1:=181; Y1:=430; X2:=323; Y2:=466; Pressed:=False;End;
 For i:=3 to 7 do With MainButton[i] do Begin X1:=432; X2:=596; End;
 With MainButton[3] do Begin Y1:=126; Y2:=165; Pressed:=False;End;
 With MainButton[4] do Begin Y1:=176; Y2:=215; Pressed:=False;End;
 With MainButton[5] do Begin Y1:=226; Y2:=265; Pressed:=False;End;
 With MainButton[6] do Begin Y1:=313; Y2:=352; Pressed:=False;End;
 With MainButton[7] do Begin Y1:=363; Y2:=402; Pressed:=False;End;
 For i:=8 to 12 do With MainButton[i] do Begin X1:=351; X2:=392; End;
 With MainButton[8] do Begin Y1:=196; Y2:=237; Pressed:=True;End;
 With MainButton[9] do Begin Y1:=240; Y2:=281; Pressed:=False;End;
 With MainButton[10] do Begin Y1:=284; Y2:=325; Pressed:=False;End;
 With MainButton[11] do Begin Y1:=328; Y2:=369; Pressed:=False;End;
 With MainButton[12] do Begin Y1:=372; Y2:=413; Pressed:=False;End;

 For i:=1 to 12 do
 Begin
  With MainButton[i] do GetMem(BitMap,ImageSize(X1+2,Y1+2,X2-1,Y2-1));
  InitButton(MainButton[i]);
 End;
End;

Procedure SetInitPalette;
Var
 Loop:Integer;
Begin
 For Loop:=0 to 15 do
  With RGBPalette[Loop] do
   Begin
    r:=0; g:=0; b:=0;
   End;
 RGBPalette[1].r:=$80;
 RGBPalette[2].g:=$80;
 RGBPalette[3].r:=$80; RGBPalette[3].g:=$80;
 RGBPalette[4].b:=$80;
 RGBPalette[5].r:=$80; RGBPalette[5].b:=$80;
 RGBPalette[6].g:=$80; RGBPalette[6].b:=$80;
 RGBPalette[8].r:=$80; RGBPalette[8].g:=$80; RGBPalette[8].b:=$80;
 RGBPalette[7].r:=$C0; RGBPalette[7].g:=$C0; RGBPalette[7].b:=$C0;
 RGBPalette[9].r:=$FF;
 RGBPalette[10].g:=$FF;
 RGBPalette[11].r:=$FF;RGBPalette[11].g:=$FF;
 RGBPalette[12].b:=$FF;
 RGBPalette[13].r:=$FF;RGBPalette[13].b:=$FF;
 RGBPalette[14].g:=$FF;RGBPalette[14].b:=$FF;
 RGBPalette[15].r:=$FF;RGBPalette[15].g:=$FF;RGBPalette[15].b:=$FF;
End;

Procedure ClearIcon;
Var
 Lin, Col:integer;
Begin
  SetFillStyle(1,ScreenColor);
  Bar(IconX-3,IconY-3,IconX+31+3,IconY+31+3);
  For Lin:=0 to 31 do
   For Col:=0 to 31 do
   Begin
    DIcon[Lin,Col].Pixel:=0;
    DIcon[Lin,Col].Mask:=False;
   End;
End;

Procedure Inicio;
Var
 Loop:integer;
Begin
 GetDir(0,DatDir);
 If Length(DatDir)>3 then DatDir:=DatDir+'\';
 For Loop:=0 to 15 do VirtColor[Loop]:=Loop;
 IconChanged:=False;
 ScreenColor:=15;
 InitGraphics;
 InitMouse;
 GetZoomColors;
 SetInitPalette;
 DefineButtons;
 For Loop:=1 to 12 do ActButton(MainButton[Loop]);
 ShowPointer;
 SetRGB16Palette(RGBPalette);
 If (ParamCount=1) and IconOk(ParamStr(1)) then
 Begin
  LoadIcon(ParamStr(1));
  DescodificaIcon;
 end
  else ClearIcon;
 DrawIcon;
 ActualizaZoom;
 Terminar:=False;
 Tool:=1;
 ActiveColor:=1;
 LColor:=0;
 RColor:=15;
End;

Procedure Fim;
Begin
 HidePointer;
 EndGraphics;
 If Length(DatDir)>3 then DatDir:=Copy(DatDir,1,Length(DatDir)-1);
 ChDir(DatDir);
 EscreveFinal;
End;

Procedure ActiveColors(ColorSelect:Integer);
Begin
 If ColorSelect<>ActiveColor then
 Begin
  HidePointer;
  With MainButton[ActiveColor] do
  Begin
   inc(X1);Inc(X2);inc(Y1);Inc(Y2);
   InitButton(MainButton[ActiveColor]);
   Dec(X1);dec(X2);dec(Y1);dec(Y2);
   Pressed:=False;
  End;
  ActButton(MainButton[ActiveColor]);
  InitButton(MainButton[ColorSelect]);
  MainButton[ColorSelect].Pressed:=True;
  ActButton(MainButton[ColorSelect]);
  ShowPointer;
  Repeat until MouseButton=0;
  ActiveColor:=ColorSelect;
 End;
End;

Function QExitBox:Boolean;
Const
 Bx=165; By=162;
Var
 F:File;
 QPalette, BackGround:Pointer;
 ch1:Char;
 Sim, Nao:ButtonType;
 Termina:Boolean;
Begin
 HidePointer;
 GetMem(QPalette,20102);   
 GetMem(BackGround,20102);
 GetImage(Bx,By,Bx+250,By+156,BackGround^);
 Assign(f,DatDir+'iconedit.dat');
 Reset(f,1);
 Seek(f,154232);
 BlockRead(f,QPalette^,20102);
 Close(f);
 PutImage(Bx,By,QPalette^,0);
 With Sim do
 Begin
  x1:=bx+25; y1:=by+96; x2:=bx+91; y2:=by+132;
  GetMem(BitMap,ImageSize(X1+2,Y1+2,X2-1,Y2-1));
  InitButton(Sim);
  Pressed:=false;
 End;
 With Nao do
 Begin
  x1:=bx+156; y1:=by+96; x2:=bx+222; y2:=by+132;
  GetMem(BitMap,ImageSize(X1+2,Y1+2,X2-1,Y2-1));
  InitButton(Nao);
  Pressed:=False;
 End;

 ActButton(sim);
 ActButton(nao);

 ShowPointer;
 Termina:=False;

 Repeat
  Repeat Until Keypressed Or (MouseButton=1);
  If MouseButton=1 then
  Begin
   With Sim do
   Begin
    If MouseIn(X1,Y1,X2,Y2) then
    Begin
     HidePointer;
     Pressed:=True;
     ActButton(Sim);
     ShowPointer;
     Repeat until MouseButton=0;
     HidePointer;
     Pressed:=False;
     ActButton(Sim);
     ShowPointer;
     If MouseIn(X1,Y1,X2,Y2) then
     Begin
      QExitBox:=True;
      Termina:=True
     End;
    End;
   End;
   With Nao do
   Begin
    If MouseIn(X1,Y1,X2,Y2) then
    Begin
     HidePointer;
     Pressed:=True;
     ActButton(Nao);
     ShowPointer;
     Repeat until MouseButton=0;
     HidePointer;
     Pressed:=False;
     ActButton(Nao);
     ShowPointer;
     If MouseIn(X1,Y1,X2,Y2) then
     Begin
      QExitBox:=False;
      Termina:=True
     End;
    End;
   End;
  End;
  If Keypressed then
  Begin
   Ch1:=ReadKey;
   Case UpCase(Ch1) of
    #0 : ch1:=ReadKey;
    'S': Begin PaletteMismatch; Termina:=True End;
    'N': Termina:=True;
   End;
  End;
 until termina;

 HidePointer;

 PutImage(Bx,By,BackGround^,0);
 FreeMem(QPalette,20102);
 FreeMem(BackGround,20102);
 ShowPointer;
End;


Procedure Novo;
Var
 Aux:Boolean;
Begin
 HidePointer;

 MainButton[3].Pressed:=True;
 ActButton(MainButton[3]);

 ShowPointer; Repeat until MouseButton=0;
 With MainButton[3] do If MouseIn(X1,Y1,X2,Y2) or (ch='N') then
 Begin
  Aux:=True;
  If IconChanged then Aux:=QExitBox;
  If Aux then
  Begin
   SetInitPalette;
   SetRGB16Palette(RgbPalette);
   ClearIcon;
   DrawIcon;
   ActualizaZoom;
   IconChanged:=False;
  End;
 End;

 HidePointer;
 MainButton[3].Pressed:=False;
 ActButton(MainButton[3]);
 ShowPointer;
End;

Function CvtDir2Str(S:String):String;
Begin
 CvtDir2Str:=Copy(S,1,12);
End;

Function QLoadSaveIcon(Load:Boolean): String;
Const
 Bx=165; By=162;
Var
 F:File;
 QPalette, BackGround:Pointer;
 ch1:Char;
 Aceitar, Cancelar:ButtonType;
 Loop, Primeiro, Total:Byte;
 Directorio:array[1..100] of record Dir:Boolean; Name:String[13]; end;
 files:Searchrec;
 Termina:Boolean;
 tempx,tempy,tempb:word;
 Selected,Dir:String;

 Procedure ActualizaDir;
 Var
  AuxLoop:Byte;
 Begin
  Total:=0;

  FindFirst('*.*', Directory, files);
  while DosError = 0 do
  begin
   if ((Files.Attr and Directory)>0) and (Files.Name<>'.') then
   Begin
    inc(Total);
    Directorio[Total].Name:=Files.Name;
    Directorio[Total].Dir:=True;
   End;
   FindNext(Files);
  end;

  FindFirst('*.ICO', Archive, files);
  while DosError = 0 do
  begin
   inc(Total);
   Directorio[Total].Name:=Files.Name;
   Directorio[Total].Dir:=False;
   FindNext(Files);
  end;

  If Total>0 then
   Primeiro:=1
  Else
   Primeiro:=0;

  For AuxLoop:=Total+1 to 8 do
   Directorio[AuxLoop].name:='';

 End;

 Procedure EscreveDir(Escreve:Boolean);
 Var
  AuxLoop:Byte;
 Begin
  HidePointer;

  If Escreve then
   SetColor(0)
  Else
   SetColor(7);

  OutTextXY(Bx+32,By+20,Selected);

  For AuxLoop:=0 to 7 do
  Begin
   If Escreve then
   Begin
    If Directorio[Primeiro+AuxLoop].dir then SetColor(8) else Setcolor(0);
   End
   Else
    SetColor(7);
   OutTextXY(Bx+20,By+51+11*AuxLoop,Directorio[Primeiro+AuxLoop].name);
  End;
  ShowPointer;
 End;

Begin
 GetMem(QPalette,20102);
 GetMem(BackGround,20102);
 HidePointer;
 GetImage(Bx,By,Bx+250,By+156,BackGround^);
 Assign(f,DatDir+'iconedit.dat');
 Reset(f,1);
 Seek(f,214538);
 BlockRead(f,QPalette^,20102);
 PutImage(Bx,By,QPalette^,0);
 BlockRead(f,QPalette^,1106);
 if not(Load) then BlockRead(f,QPalette^,1106);
 PutImage(Bx+148,By+48,QPalette^,0);
 Close(f);
 if Load then Selected:='' else Selected:='NOVOICON.ICO';
 termina:=False;

 With Aceitar do
 Begin
  x1:=bx+146; y1:=by+46; x2:=bx+233; y2:=by+82;
  GetMem(BitMap,ImageSize(X1+2,Y1+2,X2-1,Y2-1));
  InitButton(Aceitar);
  Pressed:=false;
 End;

 With Cancelar do
 Begin
  x1:=bx+146; y1:=by+104; x2:=bx+233; y2:=by+140;
  GetMem(BitMap,ImageSize(X1+2,Y1+2,X2-1,Y2-1));
  InitButton(Cancelar);
  Pressed:=False;
 End;

 ShowPointer;

 ActualizaDir;
 EscreveDir(True);

 Repeat
  Repeat Until Keypressed Or (MouseButton=1);

  If MouseButton=1 then
  Begin

   With Aceitar do
   Begin
    If MouseIn(X1,Y1,X2,Y2) then
    Begin
     HidePointer;
     Pressed:=True;
     ActButton(Aceitar);
     ShowPointer;
     Repeat until MouseButton=0;
     HidePointer;
     Pressed:=False;
     ActButton(Aceitar);
     ShowPointer;
     If MouseIn(X1,Y1,X2,Y2) then
     Begin
      QLoadSaveIcon:=Selected;
      Termina:=True
     End;
    End;
   End;

   With Cancelar do
   Begin
    If MouseIn(X1,Y1,X2,Y2) then
    Begin
     HidePointer;
     Pressed:=True;
     ActButton(Cancelar);
     ShowPointer;
     Repeat until MouseButton=0;
     HidePointer;
     Pressed:=False;
     ActButton(Cancelar);
     ShowPointer;
     If MouseIn(X1,Y1,X2,Y2) then
     Begin
      Termina:=True
     End;
    End;
   End;

   If MouseIn(Bx+118,By+48,Bx+132,By+79) then     {Cima}
   Begin
    If Primeiro>1 then
    Begin
     EscreveDir(False);
     Dec(Primeiro);
     EscreveDir(True);
     Delay(50);
    End;
   End;

   If MouseIn(Bx+118,By+102,Bx+132,By+136) then   {Baixo}
   Begin
    If Primeiro<Total-7 then
    Begin
     EscreveDir(False);
     Inc(Primeiro);
     EscreveDir(True);
     Delay(50);
    End;
   End;

   If MouseIn(Bx+18,By+49,Bx+115,By+135) then     {Lista}
   Begin
    Repeat until MouseButton=0;
    EscreveDir(False);
    For loop:=0 to Total-Primeiro do
     If MouseIn(Bx+18,By+49+11*Loop,Bx+115,By+49+11*(Loop+1)) then
      If Directorio[Primeiro+Loop].Dir then
      Begin
       Selected:='';
       GetDir(0,Dir);
       If Length(Dir)>3 then
        ChDir(Dir+'\'+Directorio[Primeiro+Loop].Name)
       Else
        ChDir(Dir+Directorio[Primeiro+Loop].Name);
       ActualizaDir;
      End
      Else
       Selected:=Directorio[Primeiro+Loop].Name;
    EscreveDir(True);
    Delay(100);
   End;

   If MouseIn(Bx+28,By+16,Bx+231,By+28) then   {Input Line}
   Begin
    HidePointer;
    EscreveDir(False);
    Selected:='';
    EscreveDir(True);
    Repeat
     repeat
      SetColor(0);
      OutTextXY(Bx+32+Length(Selected)*8,By+20,'I');
      Delay(40);
      SetColor(7);
      OutTextXY(Bx+32+Length(Selected)*8,By+20,'I');
      Delay(30);
     until keypressed;
     Ch:=ReadKey;
     EscreveDir(False);
     if ch=#0 then
      ch:=ReadKey
     Else
      If ch=#8 then
       Selected:=copy(Selected,1,length(Selected)-1)
      else
       if (CH<>#27) and (CH<>#13) and (Length(Selected)<12) then Selected:=Selected+ch;
     EscreveDir(True);
    Until (Ch=#27) or (Ch=#13);
    if Ch=#13 then
    Begin
     Termina:=True;
     QLoadSaveIcon:=Selected;
    End;
    ShowPointer;
   End;

  End;

  If Keypressed then
  Begin
   Ch:=ReadKey;
   Case UpCase(Ch) of
    #27:Termina:=True;
    'G':if Not(load) then
        begin
         QLoadSaveIcon:=Selected;
         termina:=True
        end;
    'C':if load then
        begin
         QLoadSaveIcon:=Selected;
         termina:=True
        end;
    #0 :ch:=ReadKey;
   End;
  End;

 until termina;

 HidePointer;

 PutImage(Bx,By,BackGround^,0);
 ShowPointer;
 FreeMem(QPalette,20102);
 FreeMem(BackGround,20102);
End;

Procedure Carregar;
Var
 Aux:Boolean;
 IconName:String;
Begin
 HidePointer;
 MainButton[4].Pressed:=True;
 ActButton(MainButton[4]);

 ShowPointer; Repeat until MouseButton=0;
 With MainButton[4] do If MouseIn(X1,Y1,X2,Y2) or (ch='C') then
 Begin
  Aux:=True;
  If IconChanged then Aux:=QExitBox;
  If Aux then
  Begin
   IconName:=QLoadSaveIcon(True);
   If IconName<>'' then
   Begin
    If IconOk(IconName) then
    Begin
     LoadIcon(IconName);
     SetInitPalette;
     SetRGB16Palette(RgbPalette);
     DescodificaIcon;
     DrawIcon;
     ActualizaZoom;
     IconChanged:=False;
    End;
   End;
  End;
 End;

 HidePointer;
 MainButton[4].Pressed:=False;
 ActButton(MainButton[4]);
 ShowPointer;
End;

Procedure Gravar;
Var
 Ficheiro:String;
Begin
 HidePointer;
 MainButton[5].Pressed:=True;
 ActButton(MainButton[5]);

 ShowPointer; Repeat until MouseButton=0;
 With MainButton[5] do If MouseIn(X1,Y1,X2,Y2) or (ch='G') then
 Begin
  CodificaIcon;
  Ficheiro:=QLoadSaveIcon(False);
  If Ficheiro<>'' then
  Begin
   SaveIcon(Ficheiro);
   IconChanged:=False;
  End;
 End;

 HidePointer;
 MainButton[5].Pressed:=False;
 ActButton(MainButton[5]);
 ShowPointer;
End;

Procedure Sobre;
Const
 Bx=165; By=162;
Var
 F:File;
 QPalette, BackGround:Pointer;
 ch1:Char;
 Sim, Nao:ButtonType;
 Termina:Boolean;
Begin
 HidePointer;
 MainButton[6].Pressed:=True;
 ActButton(MainButton[6]);
 ShowPointer;
 Repeat until MouseButton=0;
 HidePointer;
 With MainButton[6] do If MouseIn(X1,Y1,X2,Y2) or (Ch='S') then
 Begin
  GetMem(QPalette,20102);
  GetMem(BackGround,20102);
  GetImage(Bx,By,Bx+250,By+156,BackGround^);
  Assign(f,DatDir+'iconedit.dat');
  Reset(f,1);
  Seek(f,194436);
  BlockRead(f,QPalette^,20102);
  Close(f);
  PutImage(Bx,By,QPalette^,0);

  Repeat Until Keypressed Or (MouseButton>0);
  If Keypressed then
  Begin
   Ch1:=ReadKey;
   If Ch1=#0 then Ch1:=ReadKey;
  End
  Else
   Repeat until MouseButton=0;

  PutImage(Bx,By,BackGround^,0);
  FreeMem(QPalette,20102);
  FreeMem(BackGround,20102);
 End;

 MainButton[6].Pressed:=False;
 ActButton(MainButton[6]);
 ShowPointer;
End;

Procedure Sair;
Begin
 HidePointer;
 MainButton[7].Pressed:=True;
 ActButton(MainButton[7]);

 ShowPointer; Repeat until MouseButton=0; 
 With MainButton[7] do If MouseIn(X1,Y1,X2,Y2) or (ch=#27) then
 Begin
  If IconChanged then
  Begin
   If QExitBox Then Terminar:=True;
  End
  Else Terminar:=True;
 End;

 HidePointer;
 MainButton[7].Pressed:=False;
 ActButton(MainButton[7]);
 ShowPointer;
End;

Procedure Tools(ToolSelect:integer);
Begin
 If ToolSelect<>Tool then
 Begin
  HidePointer;
  MainButton[Tool+7].Pressed:=False;
  ActButton(MainButton[Tool+7]);
  MainButton[ToolSelect+7].Pressed:=True;
  ActButton(MainButton[ToolSelect+7]);
  ShowPointer; Repeat until MouseButton=0; HidePointer;
  Tool:=ToolSelect;
  ShowPointer;
 End;
End;

Procedure Draw(Col, Lin, Color:Word; CMask: Boolean; Mbutton: Word);
Var
 AuxColor:Byte;
Begin
 HidePointer;
 If Cmask then
 Begin
  Dicon[Lin,Col].Pixel:=Color;
  Dicon[Lin,Col].Mask:=True;

  with DIcon[lin,col] do if mask then AuxColor:=Pixel else AuxColor:=Pixel xor ScreenColor;

  PutPixel(IconX+Col,IconY+Lin,AuxColor);
  Putimage(ZoomX+9*Col, ZoomY+9*Lin,ZoomCol[AuxColor]^,0);
 End
 Else
 Begin
  Dicon[Lin,Col].Mask:=False;
  If Mbutton=1 then Dicon[Lin,Col].Pixel:=0;

  with DIcon[lin,col] do if Mask then AuxColor:=Pixel else AuxColor:=Pixel xor ScreenColor;

  PutPixel(IconX+Col,IconY+Lin,AuxColor);
  Putimage(ZoomX+9*Col, ZoomY+9*Lin,ZoomCol[AuxColor]^,0);
 End;
 ShowPointer;
 IconChanged:=True;
End;

Function FloodOk(X,Y:Word):Boolean;
Begin
 If (X<32) and (Y<32) and (DIcon[FillY,FillX].Mask=DIcon[Y,X].Mask) and
    FillCheck[Y,X] and (DIcon[FillY,FillX].Pixel=DIcon[Y,X].Pixel) then
 Begin
  FillCheck[Y,X]:=False;
  FloodOk:=True
 End
 Else
  FloodOk:=False;
End;

Procedure Flood(X,Y,Color,MButton:Word;CMask:Boolean);
Var
 Fim:Boolean;
Begin

 Repeat
  Fim:=True;

  If (X>0) then
   If FloodOK(X-1,Y) then
   Begin
    Flood(X-1,Y,Color,Mbutton,CMask);
    Fim:=False
   End;

  If FloodOK(X+1,Y) then
  Begin
   Flood(X+1,Y,Color,Mbutton,CMask);
   Fim:=False
  End;

  If (Y>0) then
   If FloodOK(X,Y-1) then
   Begin
    Flood(X,Y-1,Color,Mbutton,CMask);
    Fim:=False
   End;

  If FloodOK(X,Y+1) then
  Begin
   Flood(X,Y+1,Color,Mbutton,CMask);
   Fim:=False
  End;

Until Fim;

 If CMask then
 Begin
  Dicon[Y,X].Mask:=True;
  Dicon[Y,X].Pixel:=Color;
 end
 Else
 Begin
  Dicon[Y,X].Mask:=False;
  If Mbutton=1 then Dicon[Y,X].Pixel:=0;
 end;
End;

Procedure Fill(Col, Lin, Color:Word; CMask: Boolean; Mbutton: Word);
Var
 X, Y:Integer;
Begin
 HidePointer;

 For x:=0 to 31 do
  For y:=0 to 31 do
   FillCheck[y,x]:=true;

 FillX:=Col;
 FillY:=Lin;
 FillCheck[Lin,Col]:=False;
 Flood(Col,Lin,Color,Mbutton,Cmask);

 DrawIcon;
 ActualizaZoom;

 ShowPointer;
 IconChanged:=True;
End;

Procedure SelectZone(Var X1,Y1,X2,Y2:Word);
Var
 OldX, OldY, Mbutton: Word;
Begin
 X2:=X1;
 Y2:=Y1;
 OldX:=x1;
 OldY:=Y1;

 SetLineStyle(1,1,1);
 
 Repeat
  Repeat
   GetMouseStatus(Mbutton,X2,Y2);
   If X2<ZoomX then X2:=0 else X2:=(X2-ZoomX) Div 9;
   If Y2<ZoomY then Y2:=0 else Y2:=(Y2-ZoomY) Div 9;
   If X2>32 then X2:=32;
   If Y2>32 then Y2:=32;
  Until (MButton=0) or (X2<>OldX) or (Y2<>OldY);
  SetColor(7);
  HidePointer;
  rectangle(ZoomX-1+X1*9,ZoomY-1+Y1*9,ZoomX-1+OldX*9,ZoomY-1+OldY*9);
  OldX:=X2;
  OldY:=Y2;
  SetColor(0);
  SetLineStyle(1,1,1);
  rectangle(ZoomX-1+X1*9,ZoomY-1+Y1*9,ZoomX-1+X2*9,ZoomY-1+Y2*9);
  ShowPointer;
 Until MButton=0;

 SetColor(7);
 SetLineStyle(0,1,1);
 HidePointer;
 rectangle(ZoomX-1+X1*9,ZoomY-1+Y1*9,ZoomX-1+X2*9,ZoomY-1+Y2*9);
 ShowPointer;
 If X1>X2 then Dec(X1) else Dec(x2);
 If Y1>Y2 then Dec(Y1) else Dec(y2);
End;

Procedure Xchange(Var Var1, Var2: Word);
Var
 AuxVar:Byte;
Begin
  AuxVar:=Var2;
  Var2:=Var1;
  Var1:=AuxVar;
End;

Procedure Select(Col, Lin: Word);
Var
 Col2,Lin2,Y,X,OldX, OldY,FinalX,FinalY, Mbutton, OldButton,Loop1,Loop2: Word;
 MxRel,MyRel: Integer;
 IconBackUp, IconPart:DIconType;
Begin
 SelectZone(Col,Lin,Col2,Lin2);

 If Col2<Col then XChange(Col,Col2);
 If Lin2<Lin then XChange(Lin,Lin2);

 X:=Col2-Col;
 Y:=Lin2-Lin;

 OldX:=Col;
 OldY:=Lin;
 FinalX:=Col;
 FinalY:=Lin;
 SetColor(0);
 SetLineStyle(1,1,1);
 HidePointer;
 rectangle(ZoomX-1+FinalX*9,ZoomY-1+FinalY*9,ZoomX+(FinalX+x)*9+8,ZoomY+(FinalY+y)*9+8);
 ShowPointer;
 IconPart:=DIcon;
 IconBackUp:=DIcon;
 IconChanged:=True;

  Repeat until MouseButton>0;

   If MouseButton=1 then
    For loop1:=Col to X+Col do
     For Loop2:=Lin to Y+Lin do
     Begin
      IconBackUp[Loop2,Loop1].Pixel:=0;
      IconBackUp[Loop2,Loop1].Mask:=False;
     End;

  While MouseIn(ZoomX-1+FinalX*9,ZoomY-1+FinalY*9,ZoomX+(FinalX+X)*9+8,ZoomY+(FinalY+Y)*9+8) do
  Begin
   If MouseButton=2 then
    For Loop1:=0 to X do
     For Loop2:=0 to Y do
     Begin
      IconBackUP[FinalY+Loop2,FinalX+Loop1].Mask:=IconPart[Lin+Loop2,Col+Loop1].mask;
      IconBackUP[FinalY+Loop2,FinalX+Loop1].Pixel:=IconPart[Lin+Loop2,Col+Loop1].Pixel;
     End;

   getMouseStatus(MButton,Loop1,Loop2);
   MxRel:=Loop1-(ZoomX+(FinalX*9));
   MyRel:=Loop2-(ZoomY+(FinalY*9));

   HidePointer;
   Repeat
    SetColor(7);
    rectangle(ZoomX-1+OldX*9,ZoomY-1+OldY*9,ZoomX+(OldX+x)*9+8,ZoomY+(OldY+y)*9+8);
    OldX:=FinalX;
    OldY:=FinalY;
    SetColor(0);
    rectangle(ZoomX-1+FinalX*9,ZoomY-1+FinalY*9,ZoomX+(FinalX+x)*9+8,ZoomY+(FinalY+y)*9+8);

    Repeat
     GetMouseStatus(Mbutton,FinalX,FinalY);
     Finalx:=FinalX-Mxrel;
     finalY:=FinalY-Myrel;
     If FinalX<ZoomX then FinalX:=0 else FinalX:=(FinalX-ZoomX) Div 9;
     If FinalY<ZoomY then FinalY:=0 else FinalY:=(FinalY-ZoomY) Div 9;
     If FinalX>31-X then FinalX:=31-X;
     If FinalY>31-Y then FinalY:=31-Y;
     If Mbutton>0 then OldButton:=MButton;
    Until (MButton=0) or (FinalX<>OldX) or (FinalY<>OldY);

   Until MButton=0;

   Dicon:=IconBackup;
   For Loop1:=0 to X do
    For Loop2:=0 to Y do
    Begin
     DIcon[FinalY+Loop2,FinalX+Loop1].Mask:=IconPart[Lin+Loop2,Col+Loop1].mask;
     DIcon[FinalY+Loop2,FinalX+Loop1].Pixel:=IconPart[Lin+Loop2,Col+Loop1].Pixel;
    End;

   DrawIcon;
   ActualizaZoom;

   SetColor(0);
   rectangle(ZoomX-1+FinalX*9,ZoomY-1+FinalY*9,ZoomX+(FinalX+x)*9+8,ZoomY+(FinalY+y)*9+8);

   ShowPointer;
   Repeat until MouseButton>0;
  End;

 SetColor(7);
 HidePointer;
 rectangle(ZoomX-1+OldX*9,ZoomY-1+OldY*9,ZoomX+(OldX+x)*9+8,ZoomY+(OldY+y)*9+8);
 ShowPointer;
 IconChanged:=True;
End;

Procedure Square(Col, Lin, Color:Word; CMask: Boolean; Mbutton: Word);
Var
 Col2,Lin2,Loop:Word;
Begin
 IconChanged:=True;
 SelectZone(Col,Lin,Col2,Lin2);
 If Col2<Col then Xchange(Col,Col2);
 If Lin2<Lin then Xchange(Lin,Lin2);

 For Loop:=Col to Col2 do
  If Cmask then
  Begin
   Dicon[Lin,Loop].Pixel:=Color;
   Dicon[Lin,Loop].Mask:=True;
   Dicon[Lin2,Loop].Pixel:=Color;
   Dicon[Lin2,Loop].Mask:=True;
  End
  Else
  Begin
   If MButton=1 then Dicon[Lin,Loop].Pixel:=0;
   Dicon[Lin,Loop].Mask:=False;
   If MButton=1 then Dicon[Lin2,Loop].Pixel:=0;
   Dicon[Lin2,Loop].Mask:=False;
  End;
 For Loop:=Lin to Lin2 do
  If Cmask then
  Begin
   Dicon[Loop,Col].Pixel:=Color;
   Dicon[Loop,Col].Mask:=True;
   Dicon[Loop,Col2].Pixel:=Color;
   Dicon[Loop,Col2].Mask:=True;
  End
  Else
  Begin
   If MButton=1 then Dicon[Loop,Col].Pixel:=0;
   Dicon[Loop,Col].Mask:=False;
   If MButton=1 then Dicon[Loop,Col2].Pixel:=0;
   Dicon[Loop,Col2].Mask:=False;
  End;

 DrawIcon;
 ActualizaZoom;
 IconChanged:=True;
End;

Procedure FSquare(Col, Lin, Color:Word; CMask: Boolean; Mbutton: Word);
Var
 Col2,Lin2,Loop1,Loop2,Aux:Word;
Begin
 IconChanged:=True;
 SelectZone(Col,Lin,Col2,Lin2);
 If Col2<Col then Xchange(Col,Col2);
 If Lin2<Lin then Xchange(Lin,Lin2);

 For Loop2:=Col to Col2 do
  For Loop1:=Lin to Lin2 do
   If Cmask then
   Begin
    Dicon[Loop1,Loop2].Pixel:=Color;
    Dicon[Loop1,Loop2].Mask:=True;
   End
   Else
   Begin
    If MButton=1 then Dicon[Loop1,Loop2].Pixel:=0;
    Dicon[Loop1,Loop2].Mask:=False;
   End;
 DrawIcon;
 ActualizaZoom;
 IconChanged:=True;
End;

Procedure Zoom;
Var
 MButton, MouseX, MouseY, Lin, Col, Color:Word;
Begin
 GetMouseStatus(MButton, MouseX, MouseY);
 If (MButton=1) or (MButton=2) then
 Begin
  Lin:=(MouseY-ZoomY) Div 9;
  Col:=(MouseX-ZoomX) Div 9;
  If ActiveColor=1 then
   If MButton=1 then Color:=LColor Else Color:=RColor
  Else
   Color:=ScreenColor;
  Case Tool of
   1: Draw(Col,Lin,Color,ActiveColor=1,MButton);
   2: Fill(Col,Lin,Color,ActiveColor=1,MButton);
   3: Select(Col,Lin);
   4: Square(Col,Lin,Color,ActiveColor=1,MButton);
   5: FSquare(Col,Lin,Color,ActiveColor=1,MButton);
  End;
 End;
End;

Procedure Palette;
Var
 Loop1, Loop2:Integer;
 BitMap      :Pointer;
 MouseBackUp, Backup, MX, MY :Word;
Begin
 Repeat
  BackUp:=MouseButton;
  if BackUp>0 then MouseBackUp:=BackUp;
 Until BackUp=0;

 GetMouseStatus(BackUp, Mx, My);
 HidePointer;

 Loop1:=(Mx-382) Div 28;
 Loop2:=(My-433) Div 16;

 If (Loop1>=0) and (Loop1<8) and ((Loop2=0) Or (Loop2=1)) then
 Begin

  GetMem(BitMap,ImageSize(382+28*Loop1,433+16*Loop2,407+28*Loop1,447+16*Loop2));
  GetImage(382+28*Loop1,433+16*Loop2,407+28*Loop1,447+16*Loop2,BitMap^);

  IF MouseBackUP=1 then
   IF ActiveColor=1 then
   Begin
    PutImage(35,442,BitMap^,0);
    LColor:=8-8*Loop2+Loop1;
   End
   Else
   Begin
    PutImage(35+156,442,BitMap^,0);
    GetImage(382+28*(7-Loop1),433+16*(1-Loop2),407+28*(7-Loop1),447+16*(1-Loop2),BitMap^);
    PutImage(132+156,442,BitMap^,0);
    ScreenColor:=8-8*Loop2+Loop1;
    SetFillStyle(1,ScreenColor);
    Bar(IconX-3,IconY-3,IconX+31+3,IconY+31+3);
    DrawIcon;
    ActualizaZoom;
   End;
   IF MouseBackUp=2 then
   IF ActiveColor=1 then
   Begin
    PutImage(132,442,BitMap^,0);
    RColor:=8-8*Loop2+Loop1;
   End
   Else
   Begin
    PutImage(132+156,442,BitMap^,0);
    GetImage(382+28*(7-Loop1),433+16*(1-Loop2),407+28*(7-Loop1),447+16*(1-Loop2),BitMap^);
    PutImage(35+156,442,BitMap^,0);
    ScreenColor:=8-8*(1-Loop2)+(7-Loop1);
    SetFillStyle(1,ScreenColor);
    Bar(IconX-3,IconY-3,IconX+31+3,IconY+31+3);
    DrawIcon;
    ActualizaZoom;
   End;
  End;
  ShowPointer;
End;

Procedure CheckObjects;
Begin
 With MainButton[1]  do If MouseIn(X1,Y1,X2,Y2) then ActiveColors(1) else
 With MainButton[2]  do If MouseIn(X1,Y1,X2,Y2) then ActiveColors(2) else
 With MainButton[3]  do If MouseIn(X1,Y1,X2,Y2) then Novo            else
 With MainButton[4]  do If MouseIn(X1,Y1,X2,Y2) then Carregar        else
 With MainButton[5]  do If MouseIn(X1,Y1,X2,Y2) then Gravar          else
 With MainButton[6]  do If MouseIn(X1,Y1,X2,Y2) then Sobre           else
 With MainButton[7]  do If MouseIn(X1,Y1,X2,Y2) then Sair            else
 With MainButton[8]  do If MouseIn(X1,Y1,X2,Y2) then Tools(1)        else
 With MainButton[9]  do If MouseIn(X1,Y1,X2,Y2) then Tools(2)        else
 With MainButton[10] do If MouseIn(X1,Y1,X2,Y2) then Tools(3)        else
 With MainButton[11] do If MouseIn(X1,Y1,X2,Y2) then Tools(4)        else
 With MainButton[12] do If MouseIn(X1,Y1,X2,Y2) then Tools(5)        else
 If MouseIn(381,432,602,462) then Palette                            else
 If MouseIn(ZoomX,ZoomY,ZoomX+287,ZoomY+287) then Zoom;     
End;

begin
 Inicio;

 Repeat
  Repeat 
   If MouseButton=1 then CheckObjects;
   If MouseButton=2 then
   Begin
    If MouseIn(ZoomX,ZoomY,ZoomX+287,ZoomY+287) then Zoom;     
    If MouseIn(381,432,602,462) then Palette;
   End;
 Until Keypressed or Terminar;
  if Keypressed then
  Begin
   Ch:=ReadKey;
   ch:=UPcase(ch);
   If Ch=#0 then
    Case Ord(ReadKey) of
     59: Tools(1);
     60: Tools(2);
     61: Tools(3);
     62: Tools(4);
     63: Tools(5)
    End
   Else
    Case ch of
     'I': ActiveColors(1);
     'F': ActiveColors(2);
     'N': Novo;
     'C': Carregar;
     'G': Gravar;
     'S': Sobre;
     #27: Sair
    End;
   End;
 until Terminar;

 Fim;
end.
