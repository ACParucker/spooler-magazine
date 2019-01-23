{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}
{              Procedimentos de Hugo Jorge Rodrigues Meneses               }
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure MoveCursor(X,Y:Byte);
Var R :Registers;
Begin
   R.Ah:=$2;
   R.Dh:=Y-1;
   R.Dl:=X-1;
   R.Bh:=0;
   Intr($10,R);
End;

Procedure EscreveXY(X,Y,Cor:Byte; S:String);

Begin
   MoveCursor(X,Y);
   TextAttr := Cor;
   Write(S);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Erro(Mensagem:String);
Begin
   Window(10, 11, 70, 13);
   ClrScr;
   Caixa(10, 11, 70, 13, Caixa_Simples, 78);
   CorXX(11, 12, 69, 78);
   EscreveXY(13, 12, 78, Mensagem);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Le_Tecla(Var Tecla:Integer);

Var R:Registers;

Begin
    R.Ah :=$8;
    Msdos(R);
    Tecla:=R.Al;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure CorNormal;

Begin
  TextBackGround(Black);
  TextColor(LightGray);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Linha(c:char;n:integer);

Var f:integer;
Begin
  For f:=1 To n Do
      Write(c);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Function CheckEMS: Boolean;
Var
   EMSDeviceName, EMSName  : string[8];
   Position                : Word;
   Regs                    : registers;
 Begin
    EMSName:='';
    EMSDeviceName:='EMMXXXX0';
    with Regs do
    Begin
      ah:=$35;
      al:=$67;
      Intr($21,Regs);

      For Position:=0 to 7 do
        EMSName:=EMSName+Chr(mem[ES:Position+$0A]);
        CheckEMS:=True;

      If EMSName<>EMSDeviceName then CheckEMS:=False;
    end;
  end;

Procedure GetConfig;

Var AT   : Boolean;           { PC ‚ um AT ? }
    Regs : Registers;         { Registos do processador }
    GraphDriver, GraphMode  : Integer;
    Placa : String;
    UmNumero : String;

Begin
   Window(1, 4, 80, 20);
   ClrScr;
   Caixa(1, 4, 80, 20, Caixa_Simples, 127);
   TextBackGround(Red);
   TextColor(Yellow);
   GotoXY(2, 2);
   Linha(' ', 78);
   GotoXY(2, 3);
   Write('                             CONFIGURA€AO DO PC                               ');
   GotoXY(2, 4);
   Linha('Ä', 78);
   If Mem[$F000:$FFFE] = $FC Then AT := true    { testar se ‚ um AT }
                             Else AT := false;  { PC ou XT }

   EscreveXY(2, 8, 30, ' Tipo               : ');
   Case Mem[$F000:$FFFE] of
        $FF : Write('PC');  { $FF = PC }
        $FE : Write('XT');  { $FE = XT }
        $FC : Write('AT')   { $FC = AT }
   End;
   WriteLn(' ':54);
   EscreveXY(2, 9, 30, ' Processador        : INTEL ');
   If AT Then Write('80286, 80386 ou 80486')
         Else Write('8088 ou 8086         ');
   Intr($12, Regs);       { RAM }
   Write(' ':29);
   EscreveXY(2, 10, 30, ' Mem¢ria RAM        : ');
   Write(Regs.ax,'KB':4);
   WriteLn(' ':49);
   EscreveXY(2, 11, 30, ' Mem¢ria XMS        : ');
   Regs.ax := $4300;
   Intr($2F, Regs);
   If Regs.al = $80 Then
      Write('Instalada    ')
   Else
      Write('N„o instalada');
   WriteLn(' ':43);
   EscreveXY(2, 12, 30, ' Mem¢ria EMS        : ');
   If CheckEMS Then
      Write('Instalada    ')
   Else
      Write('N„o instalada');
   WriteLn(' ':43);
   DetectGraph(GraphDriver, GraphMode);
   If (GraphDriver = EGA) or (GraphDriver = EGA64) or (GraphDriver = EGAMono) then
         Placa:=('EGA');
   If (GraphDriver = CGA)      Then Placa:=('CGA          ');
   If (GraphDriver = VGA)      Then Placa:=('VGA          ');
   If (GraphDriver = MCGA)     Then Placa:=('MCGA         ');
   If (GraphDriver = HercMono) Then Placa:=('HERCULES     ');
   If (GraphDriver = PC3270)   Then Placa:=('3270 PC      ');
   If (GraphDriver = IBM8514)  Then Placa:=('IBM 8514     ');
   If (GraphDriver = ATT400)   Then Placa:=('AT&T 400 Line');
   EscreveXY(2, 13, 30, ' Placa Grafica      : ');
   Write(Placa, ' ':43);
   Intr($11, Regs);             { BIOSÄConfigura‡„o }
   EscreveXY(2, 14, 30, ' Modo video inicial : ');
   Case Regs.al and 48 of       { Modo de video inicial }
         0 : Write('Nao definido');
        16 : Write('40x25 Cor   ');
        32 : Write('80x25 Cor   ');
        48 : Write('80x25 Mono  ')
   End;
   WriteLn(' ':44);
   EscreveXY(2, 15, 30, ' Drives             : ');
   Write(Succ(Regs.al shr 6 and 3):2, ' ':54);
   EscreveXY(2, 16, 30, ' Disco              : ');
   Str(DiskSize(0), UmNumero);
   UmNumero := Especial(UmNumero);
   WriteLn(UmNumero:12, ' Kb', ' ':41);
   EscreveXY(2, 17, 30, ' Espa‡o livre       : ');
   Str(DiskFree(0), UmNumero);
   UmNumero := Especial(UmNumero);
   WriteLn(UmNumero:12, ' Kb', ' ':41);
   EscreveXY(2, 18, 30, ' CartasÄRS232       : ');
   WriteLn(Regs.ah shr 1 and 3: 2, ' ':54);
   EscreveXY(2, 19, 30, ' Portas paralelas   : ');
   WriteLn(Regs.ah shr 6: 2, ' ':54);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Frame(x1, y1, x2, y2:Integer);
    Const
       cse = 201; { É }
       cie = 200; { È }
       csd = 187; { » }
       cid = 188; { ¼ }
       ver = 186; { º }
       hor = 205; { Í }
    Var
       f:Integer;
       Vezes:Integer;
    Begin
      GotoXY(x1,y1);
      Write(Chr(cse));
      For f:=x1+1 To x2-1 Do
          Write(Chr(hor));
      Write(chr(csd));
      GotoXY(x1,y2);
      Write(chr(cie));
      For f:=x1+1 To x2-1 Do
          Write(Chr(hor));
      Write(chr(cid));
      For f:=y1+1 To y2-1 Do
      Begin
        GotoXY(x1,f);
        Write(Chr(ver));
        GotoXY(x2,f);
        Write(Chr(ver));
      End;
      If y2-y1 >= 3 Then
         Begin
           GotoXY(x2, y1+1);
           Write(Chr(219));
           For Vezes := 1 To y2 - y1 - 2 Do
               Begin
                 GotoXY(x2, y1 + 1 + Vezes);
                 Write(Chr(177));
               End;
           Randomize;
         End;
    End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure LeStr(col,lin,max:integer;var str:string;caracter:char;tipo:string);
{
  col e lin  - Posicoes no ecran
  max        - Tamanho maximo da string
  str        - String
  caracter   - Caracter usado na construcao da linha (ş)
  tipo       - (S)how ou (H)idden
}

Const ENTER =Chr(13);
      BACKSP=Chr( 8);
      ESCAPE=Chr(27);

Var
  x, y, i : integer;
  c:char;
  Car: LongInt;

Label 10;

Begin
      GotoXY(col, lin);
      x := WhereX;
      y := WhereY;
      Linha(caracter, max);
      GotoXY(x, y);
      i:=0;
      Repeat
      10:
        Car := Ord(ReadKey);
        If Car = 0 Then   { Para evitar que primindo as teclas de fun‡ao }
           Begin          { sejam escritos caracteres.}
              Car := Ord(ReadKey);
              Goto 10;
           End;
        c:=Chr(Car);
        If (c<>ENTER) Then Begin
          If Ord(c)=27 Then
             Begin
               GotoXY(x, y);
               Linha(caracter, max);
               GotoXY(x, y);
               i:=0
             End;
          If (Ord(c)=8) Then (* BACKSPACE *)
            Begin
              If i>0 Then
              Begin
                Dec(i);
                GotoXY(col+i,lin);
                Write(caracter);  { ş - Caracter 254 }
                GotoXY(col+i,lin);
              End;
            End
          Else
            If Ord(c)>=Ord(' ') then
            Begin  (* N„o ‚ caracter de controle *)
               if i<max then begin
                  Str[i+1]:=c;
                  GotoXY(col+i,lin);
                  If tipo = 'H' Then
                     Write('*')
                  Else
                     Write(c);
                  Inc(i);
                End;
            End;
        End;
      Until c=ENTER;
      Str[0] := Chr(i);
      Linha(' ', max-Length(str));   { Limpa o resto da linha }
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Desligacursor;
Var       R:Registers;
Begin
   R.Ah:=01;
   R.Ch:=40;
   R.Cl:=0;
   Intr($10,R);
End;

Procedure Ligacursor;
Var       R:Registers;
Begin
   R.Ah:=01;
   R.Ch:=3;
   R.Cl:=4;
   Intr($10,R);
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Copia_Ficheiro(Origem, Destino: String);
Var FromF, ToF: file;
    NumRead, NumWritten: Word;
    buf: array[1..2048] of Char;
Begin
    {$I-}
    { Open Input File }
    Assign(FromF, Origem);
    { Record size = 1 }
    Reset(FromF, 1);
    { Open Output File }
    Assign(ToF, Destino);
    { Record size = 1 }
    Rewrite(ToF, 1);
    WriteLn('Copiando ', Origem, ' para ', Destino, '...');
    Repeat
      BlockRead(FromF, buf, SizeOf(buf), NumRead);
      BlockWrite(ToF, buf, NumRead, NumWritten);
    Until (NumRead = 0) or (NumWritten <> NumRead);
    Close(FromF);
    Close(ToF);
    {$I+}
    { Se for para usar esta funcao noutro programa retirar as proximas
    linhas }
    If IOResult <> 0 Then
       Begin
          { Esta mensagem ocorre quando copiamos um ficheiro para
            um lugar onde j  existe um directorio com o mesmo nome }
          Erro('ERRO: J  existe esse nome no directorio destino !!!');
          Le_Tecla(Lixo);
       End;
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Apaga_Ficheiro(Nome:String);
Var Ficheiro:File;

Begin
     Assign(Ficheiro, Nome);
     {$I-}
     Erase(Ficheiro);
     {$I+}
     If Ioresult <> 0 Then Halt(0)
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

Procedure Renomeia_Ficheiro(Nome1, Nome2:String);
Var Ficheiro:File;
Begin
     Assign(Ficheiro, Nome1);
     Rename(Ficheiro, Nome2)
End;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}