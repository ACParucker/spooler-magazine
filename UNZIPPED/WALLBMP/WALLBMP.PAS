Program WallBmp (Input,Output);
Uses Crt,Dos;

Type
  Fich=  ^Bmp;

  Bmp= Record
         Nome:     String[13];
         Seguinte: Fich;         {Lista de ficheiros BMP}
       End;

Var
  FichCab,FichBmp,FichAux: Fich; {Cabe‡a, Elemento e Auxiliar da lista}

  InfoFicheiro:  SearchRec;      {Ficha com a informa‡„o de cada ficheiro}
  Path, PathWin: PathStr;        {Directoria dos BMP's; directoria do WIN.INI}
  i: Byte;                       {Serve para varios usos (contadores, etc...)}
  TotalBmp:  Integer;            {N§ total de ficheiros BMP}
  ExisteBmp: Boolean;            {Se existem ou n„o BMP's}
  ExisteWin: Boolean;            {Se existe ou n„o o WIN.INI}
  Descomp:   Boolean;            {Se procedeu … descompress„o}
  BmpSort:   Word;               {BMP sorteado}
  BmpSelect: String [8];         {BMP seleccionado}
  Ext:       String [3];         {Extens„o (ZIP,ARJ,BMP)}
  Str10:     String [10];        {"; Wallbmp=" ou "Wallpaper="}
  Str14:     String [14];        {"TileWallPaper="}
  Linha:     String;             {Linhas do WIN.INI}
  WallWin, WinIni: Text;         {Fich. alterado e tempor rio; fich. WIN.INI}


{****************************************************************************}


Procedure Apaga_Temp;
Begin
  Close (WallWin);
  Close (WinIni);

  {$M $4000,0,0}
  SwapVectors;
  Exec ('\COMMAND.COM','/c ERASE '  + PathWin + '\WIN.INI');
  Exec ('\COMMAND.COM','/c RENAME ' + PathWin + '\WALLWIN.TMP ' + 'WIN.INI');
  SwapVectors
  {Apaga WIN.INI e renomeia fich. tempor rio para WIN.INI}
End;


{****************************************************************************}


Procedure Apaga_Fich;
Var
  FichDel: String;

Begin
  Reset (WinIni);
  {Faz um reset ao pointer dentro do WIN.INI}

  Repeat
    Readln  (WinIni, Linha);
    Str10:= Linha;
    If (Str10 <> '; Wallbmp=') and (Str10 <> '; wallbmp=') and
       (Str10 <> ';         ')
      Then Writeln (WallWin, Linha)
    Else Begin
      If (Str10 <> ';         ') Then
        Begin
          FichDel:= Copy (Linha, 11, Length(Path) + 13);
          {$M $4000,0,0}
          SwapVectors;
          Exec ('\COMMAND.COM','/c ERASE ' + FichDel);
          SwapVectors
        End;
      Delete (Linha, 1, 255)
    End;
  Until (Eof(WinIni));

  Apaga_Temp;
  Halt
  {Apaga o ficheiro e faz uma c¢pia do WIN.INI sem a linha "; Wallbmp="}

End;

{****************************************************************************}


Procedure Bak_WinIni;
Begin
  {$M $4000,0,0}
  SwapVectors;
  Exec ('\COMMAND.COM','/c COPY ' + PathWin + '\WIN.INI ' + PathWin + '\WININI.BAK');
  SwapVectors
End;
{Cada vez que passa por Alt_WinIni faz um backup do WIN.INI para WININI.BAK}


{****************************************************************************}

Procedure Decisao;

Begin

  Repeat
    Readln  (WinIni, Linha);
    Str10:= Linha;
  Until (Eof(WinIni)) or (Str10 = '; Wallbmp=') or (Str10 = '; wallbmp=')
       or (Str10 = ';         ');
  {"; Wallbmp=" ‚ um c¢digo (gravado no WIN.INI) que indica ao programa
   a necessidade de apagar um fich. espec¡fico. Este c¢digo s¢ ‚ inserido
   no WIN.INI quando se efectua uma descompress„o de ficheiro e tem como
   objectivo garantir a unicidade de um £nico ficheiro para cada BMP}
  {";         " ‚ um c¢digo (gravado no WIN.INI que indica ao programa
   que foi utilizado um BMP que n„o foi descomprimido}

  If Not (Eof(WinIni)) Then Apaga_Fich

End;

{****************************************************************************}


Procedure Dir (Ext: String);              {Dir de uma determinada extens„o}

Procedure AdicBmp (Info: SearchRec);      {Passa o nome do .BMP para lista}
Begin
  With Info do
    Begin
      New (FichBmp);
      FichBmp^.Nome:= Name;
      If FichCab= Nil then
        FichCab:= FichBmp
      Else
        FichAux^.Seguinte:= FichBmp;
      FichAux:= FichBmp;
      FichBmp^.Seguinte:= Nil;
      Inc (TotalBmp)
    End
End;

Begin
  FindFirst (Path + Ext, Anyfile, InfoFicheiro);
  If DosError <> 18 Then ExisteBmp:=True
  Else Exit;
  {Procura 1§ fich. que satisfaz condi‡”es
   DosError=18 => N„o existe nenhum BMP}

  AdicBmp (InfoFicheiro);
  Repeat
    FindNext (InfoFicheiro);
    If DosError <> 18 Then AdicBmp (InfoFicheiro)
  Until DosError = 18
  {Procura pr¢x. fich. do tipo do FindFirst e passa-os para lista}

End;


{****************************************************************************}


Procedure Selecciona;                     {Selecciona BMP atrav‚s de sorteio}
Var
  Loc: Byte;

Begin

  Repeat
    Randomize;
    BmpSort:= Random (TotalBmp + 1);
  Until (BmpSort <> 0);
  {Sorteia um n§ entre o total de BMP}

  FichAux:= FichCab;
  If BmpSort > 1 then
    For i:= 1 to BmpSort - 1 do FichAux:=FichAux^.Seguinte;
  {Avan‡a na lista at‚ encontar o BMP correspondente ao BmpSort}

  Loc:= Pos ('.', FichAux^.Nome);
  Ext:= Copy (FichAux^.Nome, Loc + 1, 3);
  {Procura a localiza‡„o do ponto na string e copia extens„o para Ext}

  For i:=1 to 3 do Ext[i]:= UpCase (Ext[i]);
  Delete (FichAux^.Nome, Loc, 4);
  BmpSelect:= FichAux^.Nome
  {Passa extens„o para letras mai£sculas
   Apaga 4 caracteres (.ext) desde a localiza‡„o achada na string
   e BmpSelect fica s¢ com o nome do ficheiro escolhido (sem extens„o}

End;


{****************************************************************************}


Procedure Desc_Bmp (Formato: String);    {Descomprime ficheiro}
Begin

  Writeln ('                 WALLBMP 1.2 Colabora‡„o do Leitor S‚rgio Duarte');
  Writeln ('                 ***********************************************');
  {$M $4000,0,102400}

  SwapVectors;
  If Formato= 'ZIP' Then
    Exec ('\COMMAND.COM','/c pkunzip ' + Path + '\' + BmpSelect + ' ' + Path)

  Else If Formato= 'ARJ' Then
    Exec ('\COMMAND.COM','/c arj e ' + Path + '\' + BmpSelect + ' ' + Path);

  If (Formato= 'ZIP') Or (Formato= 'ARJ') Then Descomp:= True;
  SwapVectors

End;


{****************************************************************************}

Procedure Alt_WinIni;
Begin
  Bak_WinIni;
  Reset (WinIni);
  {Faz um reset ao pointer dentro do WIN.INI}

  Repeat
    Delete  (Linha, 1, 255);
    Readln  (WinIni, Linha);
    Str10:= Linha;
    Str14:= Linha;

    If (Str10 <> 'Wallpaper=') and (Str10 <> 'wallpaper=') and
       (Str14 <> 'TileWallPaper=') and (Str14 <> 'tilewallpaper=')
     Then Writeln (WallWin, Linha);
    {Nenhuma linha de intresse ao programa, ent„o grava linha igual}

    If (Str10 = 'Wallpaper=') or (Str10 = 'wallpaper=') Then
      Writeln (WallWin, Str10 + Path + '\' + BmpSelect + '.BMP');
    {Grava linha com Wallpaper alterado}

    If (Str14 = 'TileWallPaper=') or (Str14 = 'tilewallpaper=') Then
      Begin
        Writeln (WallWin, 'TileWallPaper=1');
        If Descomp = True Then
          Writeln (WallWin, '; Wallbmp=' + Path + '\' + BmpSelect + '.BMP')
        Else
          Writeln (WallWin, ';         ')
          {Grava linha com TileWallPaper como 'True', por defeito
           Se descomprimiu, grava linha com indica‡„o do ficheiro a apagar,
           se n„o, grava s¢ ;}
      End;

  Until (Eof(WinIni));

  Apaga_Temp

End;

{****************************************************************************}


Procedure FimPrograma (Errorlevel: Byte);  {Acaba o programa com diferentes
                                            errorlevels e mensagens de acordo.
                                            0 - OK
                                            1 - N„o existem BMP
                                            2 - N„o existe WIN.INI
                                            3 - N„o existe a directoria}
Begin
  If Errorlevel<> 0 Then
    Begin
      Sound (400); Delay (400); Nosound
    End;

  Case Errorlevel of
    1: Writeln ('Erro: Ficheiros n„o encontrados em ',Path);
    2: Writeln ('Erro: Win.Ini n„o encontrado em ',PathWin);
    3: Writeln ('Erro: Directoria n„o encontrada - ', Path);
    4: Writeln ('Erro: Directoria n„o encontrada - ', PathWin)
  End;
  Halt (Errorlevel)
End;


{****************************************************************************}


Procedure Param;                          {Testa parƒmentros passados ao prog}
Begin
  Clrscr;

  If ParamCount <> 2 Then                 {Se n§ parƒmentros diferente de 2}
    Begin
      Writeln;
      Writeln ('WALLBMP 1.2 Colabora‡„o do Leitor S‚rgio Duarte');
      Writeln; Writeln;
      Writeln ('Sintaxe: WALLBMP Parƒmetro1 Parƒmetro2');
      Writeln;
      Writeln ('Parƒmetro1 - Directoria exclusiva dos ficheiros .BMP');
      Writeln ('Parƒmetro2 - Directoria do WIN.INI');
      Writeln; Writeln;
      Halt;
    End

  Else

    Begin
      Path:= ParamStr(1);
      If Path [Length(Path)]= '\' Then Delete (Path, Length(Path), 1);
      FindFirst (Path + '\*.*', AnyFile, InfoFicheiro);
      If Doserror = 3 Then Fimprograma (3);
      {Path fica com o 1§ parƒmetro
      Retira £ltima back-slash
      Doserror=3 directoria inexistente}

      PathWin:= ParamStr(2);
      If PathWin [Length(PathWin)]= '\' Then Delete (PathWin, Length(PathWin), 1);
      FindFirst (PathWin + '\*.*', AnyFile, InfoFicheiro);
      If Doserror = 3 Then Fimprograma (4);
      FindFirst (PathWin + '\win.ini', AnyFile, InfoFicheiro);
      If Doserror = 18 Then Fimprograma (2)
      {PathWin fica com o 2§ parƒmetro
      Retira £ltima back-slash
      Doserror=18 WIN.INI inexistente}
      Else
        Assign  (WinIni,  PathWin + '\WIN.INI');
        Assign  (WallWin, PathWin + '\WALLWIN.TMP');
        Reset   (WinIni);
        Rewrite (WallWin)
  End

End;


{****************************************************************************}


Begin
  CheckBreak:= False;
  ExisteBmp := False;
  Descomp   := False;
  TotalBmp  := 0;
  Fichcab   := Nil;
  {Inicializa‡„o de vari veis}

  Param;
  Decisao;
  Dir ('\*.ZIP');
  Dir ('\*.ARJ');
  Dir ('\*.BMP');
  If Not ExisteBmp Then FimPrograma (1);
  Selecciona;
  Desc_Bmp (Ext);
  Alt_WinIni;

  CheckBreak:=True;
  FimPrograma(0)
End.