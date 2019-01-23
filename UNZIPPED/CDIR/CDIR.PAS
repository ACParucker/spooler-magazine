Program CDir(INPUT,OUTPUT);

uses Crt, Dos;

type
 TlinhaType=String[81];
 corestype=(Info, Exe, Com, Bat, Txt, Outro, Dir);
 Sdir=String[12];
 SubDirType=Record
             Total, Primeiro, Selec:integer;
             Direct:array[1..100] of SDir;
            end;

var
 Tlinha:Array[1..6] of TlinhaType;
 cores:array[Info..Dir] of Char;
 Linha:String;
 VirtDir, RealDir:String;
 SubDir:SubDirType;
 DirY, NX: Integer;
 MaximoX: Word;
 TFiles, TSize, TReadOnly, TArchive, THidden, TSystem,
 TDir, TEXE, TCOM, TBAT, TTXT, TFreeSize  : LongInt;
 Escrever:Boolean;

Procedure Nome;
BEGIN
 Writeln;
 writeln('Costume Dir  v1.0');
 writeln('por ',#80,#101,#100,#114,#111,#32,#83,#105,#110,#111,#103,#97,#115);
 writeln;
 DirY:=WhereY;
END;

Procedure Fim;
BEGIN
 NormVideo;
END;

Procedure Erro;
BEGIN
 WriteLn('Comando desconhecido');
 writeln;
 writeln('CDIR [Directoria]|[/C]|[/?]');
 Writeln('  /? Mostrar o Ecran de Ajuda');
END;

Procedure Ajuda;
BEGIN
 writeln('CDIR [Directoria]|[/C]|[/?]');
 Writeln('  /? Mostra este Ecran');
 Writeln('  /C Configura as Cores');
 writeln;
 Writeln('Controlos:');
 Writeln('  ',#27,'  ',#24,'  ',#25,'  ',#26,'     ³');
 Writeln('  PUp  PDown     ³  Navega pelas Directorias e Drives');
 Writeln('  Home  End      ³');
 Writeln('  <Space>  Mostra o Conteudo da Directoria com as Cores Escolhidas');
 Writeln('  <Enter>  Termina o CDIR, Ficando na Directoria Seleccionada');
 Writeln('  <Esc>    Termina o CDIR, Ficando na Directoria Inicial');
 Writeln('  < "X" >  Selecciona a Directoria come‡ada por "X"');
 Writeln;
 WriteLn('Se de alguma forma o CDIR lhe for util, agrade‡a-me escrevendo');
 WriteLn('um postal da sua Regi„o, para ver at‚ onde o CDIR chegou.');
 writeln;
 WriteLn('                                            Pedro Sinogas');
 Writeln('                                            R.A Lte 6A - Madorna');
 Writeln('                                            2775 PAREDE');
END;

procedure InputDados(param:coresType);
var
 s:string[255];
 vs,code,i:integer;
 ix,iy:byte;
 ch:char;
begin
 ix:=WhereX;
 iy:=WhereY;

 ReadLn(s);
 if iy=hi(windmax)+1 then iy:=iy-1;

 val(s,vs,code);

 i:=length(s);
 fillchar(s,256,' ');
 s[0] := Char(Pred(i+1));
 gotoxy(ix,iy);
 Write(s);
 gotoxy(ix,iy);

 if (code=0) and (vs<16) then
  Cores[param]:=char(vs);

 Writeln(Ord(cores[param]))
end;

Procedure Configuracao;
var
 f:file;
 ch:char;
 ferro:integer;
BEGIN
 assign(f,'CDIR.EXE');
 {$I-}
 reset(f,1);
 ferro:=ioresult;
 {$I+}
 if ferro=2 then
 Begin
  Writeln('CDIR.EXE nao encontrado');
  Halt;
 end;
 Writeln('Escolha a Cor:');
 Write(' das Informa‡”es      [',Ord(cores[INFO]):2,']: ');
 InputDados(INFO);
 Write(' dos Ficheiros .EXE   [',Ord(cores[EXE]):2,']: ');
 InputDados(EXE);
 Write(' dos Ficheiros .COM   [',Ord(cores[COM]):2,']: ');
 InputDados(COM);
 Write(' dos Ficheiros .BAT   [',Ord(cores[BAT]):2,']: ');
 InputDados(BAT);
 Write(' dos Ficheiros .TXT   [',Ord(cores[TXT]):2,']: ');
 InputDados(TXT);
 Write(' dos outros Ficheiros [',Ord(cores[Outro]):2,']: ');
 InputDados(Outro);
 Write(' dos Direct¢rios      [',Ord(cores[Dir]):2,']: ');
 InputDados(Dir);
  seek(f,5567);
  ch:=Chr(Ord(Cores[INFO])+65);
  BlockWrite(f,ch,1);
  ch:=Chr(Ord(Cores[EXE])+65);
  BlockWrite(f,ch,1);
  ch:=Chr(Ord(Cores[COM])+65);
  BlockWrite(f,ch,1);
  ch:=Chr(Ord(Cores[BAT])+65);
  BlockWrite(f,ch,1);
  ch:=Chr(Ord(Cores[TXT])+65);
  BlockWrite(f,ch,1);
  ch:=Chr(Ord(Cores[OUTRO])+65);
  BlockWrite(f,ch,1);
  ch:=Chr(Ord(Cores[DIR])+65);
  BlockWrite(f,ch,1);
 close(f);
END;

procedure inicio;
var
 f:file;
 p:String;
begin
 p:='OPPPPPO'; {Configura‡„o ABCDEFGHIJKLMNOP (Cores de 0 a 15)}
 Cores[Info] :=Chr(Ord(p[1])-65);
 Cores[EXE]  :=Chr(Ord(p[2])-65);
 Cores[COM]  :=Chr(Ord(p[3])-65);
 Cores[BAT]  :=Chr(Ord(p[4])-65);
 Cores[TXT]  :=Chr(Ord(p[5])-65);
 Cores[Outro]:=Chr(Ord(p[6])-65);
 Cores[DIR]  :=Chr(Ord(p[7])-65);
 textcolor(ord(cores[Info]));
 nome;
end;

Procedure GetDrives;
var
 a,i,Result:integer;
 d:String;
Begin
   a:=1;
   i:=a;
   while (a<27) do
   begin
    if ((192 and memw[$40:$10])>0) or (a<>2) then
    begin
     {$I-}
     getdir(a,d);
     chdir(d);
     Result:=IOResult;
     {$I+}
     If (Result=0) or (Result=152) then
     Begin
      SubDir.Direct[i]:=Chr(a+64)+':';
      If copy(VirtDir,1,2)=SubDir.Direct[i] then SubDir.Selec:=i;
      Inc(i);
     End;
    end;
    inc(a);
   end;

   {$I-}
    chdir(RealDir);
    result:=IOResult;
   {$I+}

   SubDir.Total:=i-1;
   VirtDir:='';

   SubDir.Primeiro:=SubDir.Selec;

   if SubDir.Selec>Subdir.Primeiro+5 then Subdir.Primeiro:=Subdir.Selec;
   if SubDir.Primeiro+5>SubDir.total then
    if SubDir.Total-5<2 then
     SubDir.Primeiro:=1
    else
     SubDir.Primeiro:=SubDir.Total-5;
End;


Function Extensao(var s:SearchRec):string;
var
  D: DirStr;
  N: NameStr;
  Ext: ExtStr;
  t:string;
Begin
 FSplit(S.Name, D, N, Ext);
 t:=Copy(Ext,2,3);
 Extensao:=Copy(Ext,2,3);
End;

Function Num2NumPelicas(num:LongInt): String;
Var
 NumTemp:String;
Begin
 str(Num:9,NumTemp);
 if Num>=1000 then
  Insert('.',NumTemp,9-2)
 else
  NumTemp:=' '+NumTemp;
 if Num>=1000000 then
  Insert('.',NumTemp,9-5)
 else
  NumTemp:=' '+NumTemp;
 Num2NumPelicas:=NumTemp;
End;

Procedure A_Linha(S:SearchRec);
Const
  Meses : array [1..12] of String[3] =
  ('Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez');
var
  T:DateTime;
  i: integer;
  D: DirStr;
  N: NameStr;
  E: ExtStr;
  Tempo, Tamanho, Hora, Dia, Atributo :String;
Begin
 FSplit(S.Name, D, N, E);

 FillChar(d,10-length(n),' ');
 d[0]:=Char(Pred(10-length(n)));

 if length(e)=0 then e:=e+'    ';
 if length(e)=1 then e:=e+'   ';
 if length(e)=2 then e:=e+'  ';
 if length(e)=3 then e:=e+' ';

 if ((S.Attr and Directory)>0) and (length(n)=0) Then
  Linha:=E+D+' '
 else
  Linha:=N+D+E+' ';

 TSize:=TSize+S.Size;
 Inc(TFiles);
 If VirtDir='' then
  TFreeSize:=DiskFree(Ord(SubDir.Direct[SubDir.Selec][1])-64)
 else
  TFreeSize:=DiskFree(Ord(VirtDir[1])-64);

 if (S.Attr and Directory)>0 Then
  Linha:=Linha+'   <DIR>   '
 else
  Linha:=Linha+Num2NumPelicas(S.Size);

  UnpackTime(S.Time,T);  {Day-Of-Week Getdate}

  Str(T.Day:0,Tempo);
  if length(Tempo)=1 then
   Tempo:='0'+Tempo;
  Dia:=Tempo;

  Dia:=Dia+'-'+meses[T.Month];

  Str(T.Year:2,Tempo);
  Tempo:=copy(Tempo,3,2);
  Dia:=Dia+'-'+Tempo;

  Linha:=linha+' '+dia;

  Str(T.Hour:0,Tempo);
  if length(Tempo)=1 then
   Tempo:=' '+Tempo;

  Hora:=Tempo;

  Str(T.Min:0,Tempo);
  if length(Tempo)=1 then
   Tempo:='0'+Tempo;

   Hora:=Hora+':'+Tempo;

  Linha:=Linha+' '+Hora;

  if (s.Attr and Hidden)>0 then
  Begin
   Atributo:='H';
   Inc(THidden)
  End
  Else
   Atributo:='.';

  if (s.Attr and SysFile)>0 then
  Begin
   Atributo:=Atributo+'S';
   Inc(TSystem)
  End
  Else
   Atributo:=Atributo+'.';

  if (s.Attr and ReadOnly)>0 then
  Begin
   Atributo:=Atributo+'R';
   Inc(TReadOnly)
  End
  Else
   Atributo:=Atributo+'.';

  if (s.Attr and Archive)>0 then
  Begin
   Atributo:=Atributo+'A';
   Inc(TArchive)
  End
  Else
   Atributo:=Atributo+'.';

   Linha:=Linha+' '+Atributo;

End;

Procedure Pagina(var Ecran:Byte);
Var
 ch:Char;
Begin
   dec(Ecran);
   if Ecran=0 then
   begin
    TextColor(ord(cores[Info]));
    writeln(' Qualquer tecla para continuar ...');
    Write;
    ch:=readkey;
    Writeln;
    If VirtDir='' then
     WriteLn(SubDir.Direct[SubDir.Selec],'\',' (Continuacao)')
    else
     WriteLn(VirtDir+'\'+SubDir.Direct[SubDir.Selec],' (Continuacao)');
    Ecran:=hi(windmax)-2;
   end
End;

procedure Ordena;
Var
 i1,i2:Integer;
 Temp:Sdir;
Begin
  for i1:=1 to SubDir.total do
  begin
   for i2:=i1+1 to SubDir.total do
    if SubDir.Direct[i1]>SubDir.Direct[i2] then
    Begin
     temp:=SubDir.Direct[i1];
     SubDir.Direct[i1]:=SubDir.Direct[i2];
     SubDir.Direct[i2]:=Temp;
    End;
  End;
End;


Procedure GetSubDir(s:String);
Var
 Dir:  SearchRec;
 D:    DirStr;
 N:    NameStr;
 E:    ExtStr;
 I:    Integer;
 Temp: Sdir;
Begin
  FindFirst(s+'\*.*', Directory, Dir);
  SubDir.total:= 0;
  while DosError = 0 do
  begin
    FSplit(Dir.name,D,N,E);
    if (length(N)>0) and ((Dir.Attr And Directory)>0) then
    begin
     inc(SubDir.Total);
     FillChar(d,9-length(n),' ');
     d[0]:=Char(Pred(9-length(N)));
     SubDir.Direct[SubDir.Total]:=N+D;
     FillChar(d,5-length(e),' ');
     d[0]:=Char(Pred(5-length(e)));
     SubDir.Direct[SubDir.Total]:=SubDir.Direct[SubDir.Total]+e+D;
    end;
    FindNext(Dir);
  end;

  SubDir.Primeiro:=1;
  SubDir.selec:=1;

  If SubDir.Total>SubDir.Primeiro then Ordena;
End;

Procedure CheckLinha25;
Begin
 if WhereY>24 then
 Begin
  Writeln;
  Dec(DirY);
 End;
End;

Procedure EscreveVEcran;
Var
 I: Integer;
Begin
 NormVideo;
 TextColor(ord(cores[INFO]));
 if (SubDir.Total<6) AND (NX<=SubDir.Total) then NX:=SubDir.Total Else NX:=6;
 For I:=1 to NX do
 Begin
  GotoXY(1,DirY+I-1);
  CheckLinha25;
  GotoXY(1,DirY+I-1);
  write(Tlinha[I]);
 End;
End;

Procedure LimpaVEcran;
Var
 I: Integer;

Begin
 For I:=1 to 6 do
 Begin
  FillChar(Tlinha[I], Succ(MaximoX), ' ');
  Tlinha[I][0] := Char(MaximoX)
 End;
End;

Procedure Substitui(var MainStr: TLinhaType; SubStr:String; index: Byte);
Begin
 MainStr:=Copy(MainStr,1,index-1)+SubStr+copy(MainStr,index+length(SubStr),
                                     length(mainStr)-index+length(SubStr));
End;

Procedure MostrarDir;
var
 X,I,Max:Integer;
Begin
 If VirtDir='' then
 begin
  if MaximoX>14 then
  Begin
   LimpaVEcran;
   X:=1;
   MaximoX:=x+13;
  end
  else
  begin
   X:=1;
   MaximoX:=x+13;
   LimpaVEcran;
  end;
 end
 else
 Begin
  LimpaVEcran;
  X:=length(VirtDir)+2;
  MaximoX:=x+13;
  Substitui(TLinha[1],VirtDir+'\',1);
 end;
 max:=SubDir.Primeiro+5;
 if SubDir.Total<=max then max:=SubDir.total;
 for I:=SubDir.Primeiro to max do
 begin
  Substitui(Tlinha[(I-SubDir.Primeiro)+1],SubDir.Direct[I],x);

  if (i=SubDir.primeiro) and (SubDir.Primeiro>1) then
  begin
   NormVideo;
   TextColor(ord(cores[INFO]));
   Substitui(Tlinha[(I-SubDir.Primeiro)+1],' '+#24,Maximox-2);
  end;

  if (i=max) and (max<SubDir.total) then
  begin
   NormVideo;
   TextColor(ord(cores[INFO]));
   Substitui(Tlinha[(I-SubDir.Primeiro)+1],' '+#25,Maximox-2);
  end;

 end;
 EscreveVEcran;
 GotoXY(X,SubDir.Selec-SubDir.Primeiro+DirY);
 TextBackGround(4);
 TextColor(14);
 Write(SubDir.Direct[SubDir.Selec]);
 NormVideo;
End;

Function CheckDrive:Boolean;
Var
 erro1:word;
 lixo:String;
 backCheck:Boolean;
Begin
 if VirtDir<>'' then
 Begin
  {$I-}
  getdir(ord(VirtDir[1])-64,lixo);
  chdir(lixo);
  erro1:=ioresult;
  {$I+}
  If erro1=0 then backCheck:=True else
  begin
   BackCheck:=False;
   GetDrives;
  end;
 End
 else
  Backcheck:=True;
 if not(BackCheck) then MostrarDir;
 CheckDrive:=BackCheck;
end;


procedure List;
var
 ecran:byte;
 DirInfo:SearchRec;
 fim:boolean;
 s:String;
 ch:char;
 result:Word;
Begin
 {$I-}
 If VirtDir='' then
  FindFirst(SubDir.Direct[SubDir.Selec]+'\*.*',$3f, DirInfo)
 else
  FindFirst(VirtDir+'\'+SubDir.Direct[SubDir.Selec]+'\*.*',$3f, DirInfo);
 result:=DosError;
 {$I+}
 if result=0 then
 begin
  LimpaVEcran;
  EscreveVEcran;
  TFiles   :=0;
  TSize    :=0;
  TReadOnly:=0;
  TArchive :=0;
  THidden  :=0;
  TSystem  :=0;
  TDir     :=0;
  TEXE     :=0;
  TCOM     :=0;
  TBAT     :=0;
  TTXT     :=0;
  TFreeSize:=0;
  GotoXY(1,DirY);
  CheckLinha25;
  TextColor(ord(cores[Info]));

  If VirtDir='' then
   WriteLn(SubDir.Direct[SubDir.Selec],'           ')
  else
   WriteLn(VirtDir+'\'+SubDir.Direct[SubDir.Selec],'           ');
  fim:=false;
  Ecran:=hi(windmax)-2;
  while not fim do
  begin
   if DosError = 0 then
   Begin
    if (DirInfo.Attr and VolumeID)=0 then
    begin
     S:=(Extensao(DirInfo));
     TextColor(Ord(cores[OUTRO]));

     if S='EXE' then
     Begin
      TextColor(Ord(cores[EXE]));
      Inc(TEXE);
     End;

     if S='COM' then
     Begin
      TextColor(Ord(cores[COM]));
      Inc(TCOM);
     End;

     if S='BAT' then
     Begin
      TextColor(Ord(cores[BAT]));
      Inc(TBAT);
     End;

     if S='TXT' then
     Begin
      TextColor(Ord(cores[TXT]));
      Inc(TTXT);
     End;

     if (DirInfo.Attr and Directory)>0 then
     Begin
      TextColor(Ord(cores[DIR]));
      Inc(TDir);
     End;

     A_Linha(DirInfo);
     WriteLn(Linha);
     Pagina(Ecran)
    end;
    FindNext(DirInfo);
   end
   else
   begin
    textcolor(ord(cores[Info]));
    Writeln('              ',Num2NumPelicas(Tsize),' Bytes  ');
    Pagina(Ecran);
    Writeln('              ',Num2NumPelicas(TFreeSize),' Bytes Livres');
    Pagina(Ecran);
    Writeln;
    Pagina(Ecran);
    WriteLn(' Ficheiros Listados (',TFiles,'):');
    Pagina(Ecran);
    WriteLn('    *.EXE: ',TEXE:4,'    *.COM: ',TCOM:4,'      *.BAT: ',TBAT:4,'     *.TXT: ',TTXT:4);
    Pagina(Ecran);
    WriteLn('   Hidden: ',THidden:4,'   System: ',TSystem:4,'   ReadOnly: '
            ,TReadOnly:4,'   Archive: ',TArchive:4,'   Dir:',Tdir:4);
    Writeln;
    Pagina(Ecran);
    if ecran<8 then ecran:=1 else ecran:=ecran-6;
    Pagina(Ecran);
    if ecran=hi(windmax)-2 then writeln;
    fim:=true;
   end;
  end;
  DirY:=WhereY;
  CheckLinha25;
  mostrarDir;
 end;
End;


Procedure DesceDir;
var
 SelecBackUp, PrimeiroBackUP, TotalBackUP   :integer;
 Dir:SearchRec;
Begin
 SelecBackup:=SubDir.Selec;
 PrimeiroBackup:=SubDir.Primeiro;

 If VirtDir='' then
  GetSubDir(SubDir.Direct[SubDir.Selec])
 else
  GetSubDir(VirtDir+'\'+SubDir.Direct[SubDir.Selec]);

 if SubDir.total>0 then
 Begin
  if VirtDir='' then
  Begin
   GetDrives;
   SubDir.Selec:=SelecBackUP;
   VirtDir:=SubDir.Direct[SubDir.Selec];
  end
  else
  Begin
   GetSubDir(VirtDir);
   SubDir.Selec:=SelecBackUP;
   FindFirst(VirtDir+'\'+SubDir.Direct[SubDir.Selec], Directory, Dir);
   VirtDir:=VirtDir+'\'+Dir.Name;
  End;

  GetSubDir(VirtDir);
  if escrever then MostrarDir;
 end
 else
 Begin
  if VirtDir='' then
   GetDrives
  else
   GetSubDir(VirtDir);
  SubDir.Selec:=SelecBackUP;
  SubDir.Primeiro:=PrimeiroBackup;
 End;
End;

Procedure SobeDir;
var
 a:integer;
 old,d:String;
Begin
 if pos('\',VirtDir)>0 then
 Begin
  a:=length(VirtDir);
  While copy(VirtDir,a,1)<>'\' do dec(a);
  old:=copy(VirtDir,a+1,length(VirtDir)-a);
  VirtDir:=copy(VirtDir,1,a-1);
  GetSubDir(VirtDir);

  FillChar(d,13-length(old),' ');
  d[0]:=Char(Pred(13-length(old)));
  old:=old+d;

  For a:=1 to SubDir.total do
   if SubDir.Direct[a]=old then SubDir.Selec:=a;

  Subdir.Primeiro:=Subdir.Selec;
  if SubDir.Primeiro+5>SubDir.total then
   if SubDir.Total-5<2 then
    SubDir.Primeiro:=1
   else
    SubDir.Primeiro:=SubDir.Total-5;

  MostrarDir;
 End
 Else
 Begin
  if VirtDir<>'' then
  Begin
   GetDrives;
   MostrarDir;
  end
 End;
end;

Procedure Cima;
Begin
 if SubDir.Selec>1 then
 begin
  dec(SubDir.Selec);
  if SubDir.Primeiro>Subdir.Selec then dec(SubDir.Primeiro);
  MostrarDir;
 end;
End;

Procedure Baixo;
Begin
 if SubDir.Selec<SubDir.total then
 begin
  inc(SubDir.Selec);
  if SubDir.Primeiro+5<Subdir.Selec then inc(SubDir.Primeiro);
  MostrarDir;
 end;
End;

Procedure TPageUP;
var
 sbak:integer;
Begin
 sbak:=subdir.selec;
 if SubDir.Selec=Subdir.Primeiro then
 begin
  SubDir.Selec:=SubDir.Selec-5;
  if SubDir.Selec<1 then SubDir.Selec:=1;
  SubDir.Primeiro:=SubDir.Selec;
 end
 else
  SubDir.Selec:=SubDir.Primeiro;
 if sbak<>subdir.selec then MostrarDir;
end;

Procedure TPageDown;
var
 sbak:integer;
Begin
 if (SubDir.Selec=Subdir.Primeiro+5) or (SubDir.Selec=SubDir.Total) then
 begin
  SubDir.Selec:=SubDir.Selec+5;

  if SubDir.Selec>SubDir.Total then SubDir.Selec:=SubDir.Total;

  SubDir.Primeiro:=SubDir.Selec-5;

  If SubDir.Primeiro<1 then SubDir.Primeiro:=1;
 end
 else
 begin
  SubDir.Selec:=SubDir.Primeiro+5;
  if SubDir.Selec>SubDir.Total then SubDir.Selec:=SubDir.Total;
 end;

 if sbak<>subdir.selec then MostrarDir;
end;

Procedure THome;
var sbak:integer;
Begin
 sbak:=SubDir.Selec;
 SubDir.Selec:=1;
 SubDir.Primeiro:=1;
 if sbak<>subdir.selec then MostrarDir;
end;

Procedure TEnd;
var sbak:integer;
Begin
 Sbak:=SubDir.Selec;
 SubDir.Selec:=SubDir.Total;
 SubDir.Primeiro:=SubDir.Total-5;
 If SubDir.Primeiro<1 then SubDir.Primeiro:=1;
 if sbak<>subdir.selec then MostrarDir;
end;

Procedure Tecla(ch:char);
var
 i,backup:integer;
Begin
 backup:=SubDir.Selec;
 for i:=SubDir.total downto 1 do
  if copy(SubDir.Direct[i],1,1)=upcase(ch) then SubDir.Selec:=i;
 if backup<>SubDir.selec then
 Begin
  if SubDir.Selec<Subdir.Primeiro then Subdir.Primeiro:=Subdir.Selec;
  if SubDir.Selec>Subdir.Primeiro+5 then Subdir.Primeiro:=Subdir.Selec;
  if SubDir.Primeiro+5>SubDir.total then SubDir.Primeiro:=SubDir.Total-5;

  MostrarDir;
 End;
End;

Function ChangeDir:Char;
Var
 result:Word;
Begin
 {$I-}
 If VirtDir='' then
  Chdir(SubDir.Direct[SubDir.Selec]+'\')
 else
  Chdir(VirtDir+'\'+SubDir.Direct[SubDir.Selec]);
 Result:=IOResult;
 {$I+}
 if Result=0 then ChangeDir:=#27 else ChangeDir:=#0;
End;


Procedure Navegar;
var
 ch:char;
Begin
 GetDir(0,VirtDir);
 RealDir:=VirtDir;
 GetSubDir(VirtDir);
 MaximoX:=length(VirtDir)+1;
 NX:=1;
 if length(virtdir)=3 then virtdir:=copy(VirtDir,1,2);
 escrever:=False;
 Descedir;
 Escrever:=True;
 Sobedir;
 repeat
  ch:=readkey;
  if ((ch=#27) or CheckDrive) then
  begin
   if ch=#0 then {Setas}
   begin
    ch:=readkey;
    case ch of
     'H': Cima;
     'P': Baixo;
     'K': SobeDir;
     'M': DesceDir;
     'Q': TPageDown;
     'I': TPageUp;
     'G': THome;
     'O': TEnd;
    end
   end
   else
   Begin
    case ch of
     ' ': List;
     #13: Ch:=ChangeDir;
    else
     if ch<>#27 then tecla(ch) else {$I-} chdir(RealDir); {$I+}
    End;
   end;
  end
  else
   if ch=#0 then ch:=readkey;
 until ch=#27;
 LimpaVEcran;
 EscreveVEcran;
 GotoXY(1,DirY-1);
End;

Function Num(substr,mainstr:string):integer;
var
 a,TempNum:integer;
begin
 TempNum:=0;
 for a:=1 to length(Mainstr) do
  if copy(MainStr,a,length(SubStr))=SubStr then inc(TempNum);
 Num:=TempNum;
end;

Function UCase(s:String): String;
var
  i : Integer;
begin
  UCase:=s;
  for i := 1 to Length(s) do
    UCase[i] := UpCase(s[i]);
end;

function Ultimo(s:string):string;
var
 i,posi:integer;
begin
 for i:=1 to length(s) do
  if copy(s,i,1)='\' then posi:=i;
 Ultimo:=copy(s,posi,length(s)-posi+1);
end;

Procedure CD_Directo(s:String);
Var
 i:integer;
 Dir:SearchRec;
 RealDir,backup:string;
Begin
 RealDir:='';
 s:=Ucase(s);
 GetDir(0,VirtDir);
 VirtDir:=copy(Virtdir,1,2);
 SubDir.Selec:=1;
 GetSubDir(VirtDir);

repeat


 While SubDir.Total>0 do
 Begin
  VirtDir:=VirtDir+'\'+SubDir.Direct[SubDir.Selec];
  GetSubDir(VirtDir);

   FindFirst(VirtDir,Directory,dir);

   if s=Copy(Dir.Name,1,length(s)) then
    if (Num('\',realdir)<Num('\',virtdir)) and ((length(Dir.Name)<length(Ultimo(Realdir))) or (RealDir='')) then
     RealDir:=VirtDir;
  end;

 BackUp:=Ultimo(VirtDir);
 Backup:=copy(backup,2,length(backup));
 VirtDir:=Copy(VirtDir,1,length(VirtDir)-length(BackUp)-1);
 GetSubDir(VirtDir);
 for i:=1 to SubDir.Total do
  if Backup=SubDir.Direct[i] then subDir.Selec:=i+1;
 if SubDir.Selec>SubDir.Total then SubDir.Total:=0;

until VirtDir='';


 {Fim}
 If RealDir='' then
  Begin
   Write('Directoria ou ');
   erro
  end
 else
  Chdir(RealDir);
End;

VAR
 Parametros:String[2];
BEGIN
 inicio;
 IF ParamCount>0 then
  IF ParamCount=1 then
  Begin
    Parametros:=copy(ParamStr(1),1,2);
    if parametros[1]='/' then
     Case Parametros[2] of
      '?'    : Ajuda;
      'C','c': Configuracao;
     Else
      Erro
     end
    Else
     CD_Directo(ParamStr(1));
  end
  Else
   Erro
 Else
  Navegar;
 Fim;
END.