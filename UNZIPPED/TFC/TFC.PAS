Program WCS_Text_Files_Compiler;
{
ÚÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂ¿
ÃÅÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÅÁÁÁÁÁÁÁ´
Ã´ ÛßßÛßßÛ ÛßßßÛ Û   Û ÛßßÛßßÛ     ÛßßßÛ ßßÛßß Û     ÛßßßÛ ÛßßßÛ     ³ v1.50 ³
Ã´    Û    ÛÜ     ßÜß     Û        ÛÜ      Û   Û     ÛÜ    ÛÜÜÜÜ     ÃÂÂÂÂÂÂÂ´
Ã´    Û    Û   Ü Üß ßÜ    Û        Û       Û   Û   Ü Û   Ü Ü   Û     ÃÅÅÅÅÅÅÅ´
Ã´   ßßß   ßßßßß ß   ß   ßßß       ß     ßßßßß ßßßßß ßßßßß ßßßßß     ÃÅÅÅÅÅÅÅ´
Ã´ ÛßßßßÛ ÛßßßßÛ ÛÜ   ÜÛ ÛßßßßÜ ßßÛßß Û     ÛßßßÛ ÛßßßßÜ             ÃÅÅÅÅÅÅÅ´
Ã´ Û      Û    Û Û ßÜß Û ÛÜÜÜÜß   Û   Û     ÛÜ    ÛÜÜÜÜß             ÃÅÅÅÅÅÅÅ´
Ã´ Û    Ü Û    Û Û     Û Û        Û   Û   Ü Û   Ü Û    Û             ÃÅÅÅÅÅÅÅ´
Ã´ ßßßßßß ßßßßßß ß     ß ß      ßßßßß ßßßßß ßßßßß ß    ß             ÃÅÅÅÅÅÅÅ´
Ã´ Criado e Desenvolvido por Hugo Ferreira em Abril de 1993.         ÃÅÅÅÅÅÅÅ´
ÃÅÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÂÅÅÅÅÅÅÅÅ´
ÀÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÁÙ
 ðððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
 Este programa n„o e perfeito, n„o foi elaborado para o ser!
 Por esta raz„o, ‚ natural que a test -lo e utiliz -lo, ache que lhe falta
 algo faz falta, escreva-me e diga-me qual a sua sugest„o...
 Abra a carteira, gaste um selo, e colabore. Quem sabe se ainda n„o ficamos
 bons amigos...  Na detec‡„o de BUGS, pe‡o que me escrevam para a morada a
 seguir indicada, se n„o detectarem BUGS, escrevam na mesma!

 Devem enviar a correspondencia para a seguinte morada:

 West Coast Software
 Praceta do Barro, 6 - Alcoit„o
 2765 ESTORIL

 ðððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððððð
}

uses Crt, Dos;

{$V-,R-,S-,I-}
{>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> TIPOS <<<<<<<<<<<<<<<<<<<<<<<<<<<<}
TYPE DirType = array[0..512] of string[12];
     St12 = String[12];
     St6 = String[6];
     WinState = record Wx1, Wy1, Wx2, Wy2: Byte; end;
{>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CONSTANTES <<<<<<<<<<<<<<<<<<<<<<<<<}
Const  Leitor : Array [0..41] of byte =  ($BE, $00, $00, $BB, $2A, $01, $33,
                                          $C9, $B4, $02, $2E, $8A, $10, $CD,
                                          $21, $46, $74, $16, $0A, $C0, $74,
                                          $12, $3C, $0A, $75, $EE, $41, $83,
                                          $F9, $18, $75, $E8, $32, $E4, $CD,
                                          $16, $33, $C9, $EB, $E0, $CD, $20);

       Extens: array [1..21] of string[4] =
            ('.SYS', '.EXE', '.COM', '.OVR', '.OVL', '.BIN', '.ZIP', '.ARJ',
             '.LZH', '.ARC', '.PAK', '.ZOO', '.MOD', '.NST', '.GIF', '.PCX',
             '.VOC', '.MID', '.WAV', '.BMP', '.DLL');
       EOF_MARKER : byte = 0;
{>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> VARIAVEIS <<<<<<<<<<<<<<<<<<<<<<<<<<}
Var    Origem, Destino : File;
       NumDePar, Check,
       Ponto, Tamanho  : Word;
       Ponteiro, Buffer: Pointer;
       ParUm, ParDois  : String;
       Dir             : DirType;
       Pk              : byte;
       Cursor, Max     : byte;
       ExitLoop, First : boolean;
       Numero          : St6;
       ch              : char;
       Linha, Coluna   : byte;
       x1, y1, x2, y2  : byte;
       MemWinSze,
       MemWinOrg,
       MemWinDst,
       MemWinLne,
       offset          : word;
       ScrMsk          : array [1..6]  of record
                           name: string[8];
                           ext : string[4];
                           attr: word;
                         end;
       DirMsk          : record
                           name: array [1..512] of string[8];
                           ext : array [1..512] of string[4];
                           attr: array [1..512] of word;
                           NbrOfRec: integer;
                         end;
       Label inicio;

{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
procedure WriteXY(X, Y: byte; Strg: string);
begin
  GotoXY(x, y);
  Write(Strg);
end;
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
procedure DrawBox(X, Y: byte);
begin
  TextAttr:=$1F;
  WriteXY(X, Y,   'ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  WriteXY(X, Y+1, '³               ³ West Coast Software, 1993.³');
  WriteXY(X, Y+2, '³               ³ Text Files Compiler v1.50 ³');
  WriteXY(X, Y+3, '³               ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
  WriteXY(X, Y+4, '³               ³ Compilar :                ³');
  WriteXY(X, Y+5, '³               ³ Para     :                ³');
  WriteXY(X, Y+6, '³               ³ Bytes    :                ³');
  WriteXY(X, Y+7, 'ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
  WriteXY(X, Y+8, '³                                           ³');
  WriteXY(X, Y+9, 'ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
end;
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
procedure OpenWin;
var
  i: byte;
begin
    x1:=17;
    y1:=9;
    x2:=63;
    y2:=28;

    MemWinSze:= ((x2-x1) * (y2-y1)) * 2;
    MemWinLne:= (x2-x1)*2;
    GetMem(Buffer, MemWinSze);
    MemWinDst:= ofs(Buffer^);

    for i := y1 to y2 do
     begin
      offset := 160 * i + (x1 * 2);
      MemWinOrg:= offset;
      Move(mem[$B800:MemWinOrg], mem[Seg(Buffer^):MemWinDst], MemWinLne);
      inc(MemWinDst, MemWinLne);
     end;
end;
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
procedure CloseWin;
var
  i: byte;
  W: winstate;
begin
     x1:=17;
     y1:=9;
     x2:=63;
     y2:=28;

     MemWinSze:= ((x2-x1) * (y2-y1)) * 2;
     MemWinLne:= (x2-x1)*2;
     MemWinOrg:= ofs(Buffer^);

     for i := y1 to y2-1 do
     begin
      offset := 160 * i + (x1 * 2);
      MemWinDst:= offset;
      Move(mem[seg(Buffer^):MemWinOrg], mem[$B800:MemWinDst], MemWinLne);
      inc(MemWinOrg, MemWinLne);
     end;
     FreeMem(Buffer, MemWinSze);
end;
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
procedure EndProg;
begin
  GotoXY(Coluna, Linha);
  CloseWin;
  asm
    mov ah, 01
    mov ch, 03
    mov cl, 04
    int 10h
  end;
  Halt;
end;
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
function HandleFiles(X1, Y1: byte): St12;
var DirInfo              : SearchRec;
    CurrFile, a, b       : integer;
    P                    : PathStr;
    D                    : DirStr;
    N                    : NameStr;
    E                    : ExtStr;
    keyval               : integer;
    ChangeDir            : boolean;
    FileName             : string[12];
    ClrX, ClrXMen, MenX,
    StrX, BarX   , BotX  : integer;

procedure FFiles;
var c: integer;
    Label L3;
begin
 FindFirst('*.*', Archive + directory, DirInfo);
    CurrFile:=1;
    while DosError = 0 do
      begin
        FSplit(DirInfo.Name, D, N, E);
        DirMsk.name[Currfile]:=N;
        DirMsk.ext[Currfile]:=E;
        DirMsk.attr[Currfile]:=Dirinfo.attr;
        Inc(CurrFile);

L3:     FindNext(DirInfo);
     end;
     DirMsk.NbrOfRec:=CurrFile-1;
     Max:=CurrFile-1;
     if Max>6 then Max:=6;
     For c:=1 to 6 do
       begin
         if c > DirMsk.NbrOfRec then
           begin
             ScrMsk[c].Name:='        ';
             ScrMsk[c].ext:='    ';
             ScrMsk[c].Attr:=$20;
           end
         else
           begin
             ScrMsk[c].Name:=DirMsk.Name[c];
             ScrMsk[c].Ext:=DirMsk.Ext[c];
             ScrMsk[c].Attr:=DirMsk.Attr[c];
           end;
       end;
     CurrFile:=1;
 end;

Procedure WriteDir;
var a: byte;
begin
    For a:=1 to 6 do
     begin
       if (ScrMsk[a].attr and directory <> 0) then
         begin
           WriteXY(X1, Y1 + (a-1), '             ');
           if Cursor=a then TextAttr:=$1B else TextAttr:=$1F;
           WriteXY(X1, Y1 + (a-1), '\' + ScrMsk[a].Name+ScrMsk[a].Ext);
         end
       else
         begin
           WriteXY(X1, Y1 + (a-1), '             ');
           if Cursor=a then TextAttr:=$1B else TextAttr:=$1F;
           WriteXY(X1, Y1 + (a-1), ScrMsk[a].Name+ScrMsk[a].Ext);
         end;
      end;

     
     if ScrMsk[Cursor].Attr=$10 then TextAttr:=$1C else TextAttr:=$1E;

     WriteXY(X1+27, Y1 + 3, '             ');
     WriteXY(X1+27, Y1 + 3, ScrMsk[Cursor].Name+ScrMsk[Cursor].Ext);
end;
begin
   ExitLoop:=False;
   ChangeDir:=FALSE;
   Cursor:=1; Max:=6;
   FFiles;
   TextAttr:=$1F;
   WriteDir;

 repeat
   repeat until keypressed;
     Ch:=ReadKey;
     if ch=#0 then
       case readkey of
         #81: begin
                First:=TRUE;
                inc(CurrFile, 6);
                if CurrFile > DirMsk.NbrOfRec then dec(CurrFile, 6);
                  b:=1;
                  For a:=CurrFile to CurrFile + 5 do
                    begin
                     if a > DirMsk.NbrOfRec then
                       begin
                         if First=TRUE then begin Cursor:=b-1; First:=FALSE; end;
                         ScrMsk[b].Name:='        ';
                         ScrMsk[b].ext:='    ';
                         ScrMsk[b].Attr:=$20;
                       end
                     else
                       begin
                         Max:=b;
                         ScrMsk[b].Name:=DirMsk.Name[a];
                         ScrMsk[b].Ext:=DirMsk.Ext[a];
                         ScrMsk[b].Attr:=DirMsk.Attr[a];
                        end;
                       inc(b);
                     end;
               end;


         #73: begin
                First:=TRUE;
                if CurrFile > 1 then dec(CurrFile, 6);
                  b:=1;
                  For a:=CurrFile to CurrFile + 5 do
                    begin
                      if a > DirMsk.NbrOfRec then
                        begin
                          if First=TRUE then begin Cursor:=b-1; First:=FALSE; end;
                          ScrMsk[b].Name:='        ';
                          ScrMsk[b].ext:='    ';
                          ScrMsk[b].Attr:=$20;
                        end
                      else
                        begin
                          Max:=b;
                          ScrMsk[b].Name:=DirMsk.Name[a];
                          ScrMsk[b].Ext:=DirMsk.Ext[a];
                          ScrMsk[b].Attr:=DirMsk.Attr[a];
                        end;
                        inc(b);
                      end;
                   end;
        #80: if Cursor < Max then Inc(Cursor);
        #72: if Cursor > 1 then Dec(Cursor);
        end;
        if ch=chr(13) then
          begin
            if ScrMsk[Cursor].Attr=$10 then
              ChangeDIR:=TRUE
            else
              ExitLoop:=TRUE;
            end;
        if ch=chr(27) then
          begin
            Filename:='????';
            ExitLoop:=TRUE;
          end;
        if ChangeDir then
          begin
            {$i-}
            ChDir(ScrMsk[Cursor].Name+ScrMsk[Cursor].Ext);
            {$i+}
            If IOresult = 0 then
              begin
                FFiles;
                FileName:='*';
                Cursor:=1;
              end;
            ChangeDir:=FALSE;
          end;

      WriteDir;
     until ExitLoop;
 HandleFiles:=Filename;
end;
{þþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþþ}
begin
  WriteLn;
  TextAttr:=$0F; WriteLn('West Coast Software Text Files Compiler v1.50, 1993.');
  TextAttr:=$07; WriteLn('Criado e desenvolvido por Hugo Ferreira em Abril de 1993.');
  WriteLn;
  asm
    mov ah, 01
    mov ch, 40
    mov cl, 0
    int 10h
  end;
  Linha:=WhereY;
  Coluna:=WhereX;
  OpenWin;
  repeat
inicio:
   begin
     DrawBox(18, 10);
     repeat
       
       ParUm:=HandleFiles(20, 11);
       if ParUm='????' then EndProg;
       ExitLoop:=TRUE;
       for Pk:=1 to 21 do
         begin
           If ScrMsk[Cursor].Ext=Extens[pk] then
             begin
               ExitLoop:=FALSE;
               WriteXY(20, 18, 'O ficheiro n„o pode ser compilado.');
               delay(1500);
               WriteXY(20, 18, '                                  ');
             end;
         end;

     until ExitLoop;
   end;
   ExitLoop:=FALSE;
   ParUm:=ScrMsk[Cursor].Name + ScrMsk[Cursor].Ext;

   if NumDePar>=2 then ParDois:=ParamStr(2) else ParDois:=ParUm ;
   ParDois:= ScrMsk[Cursor].Name + '.COM';
   GotoXY(3, 9);

   Assign (Destino, ParDois);
   ReWrite (Destino, 1);
   if IOResult <> 0 then
   begin
     writeln('Erro ao criar o ficheiro: ', ParDois, #7);
     WriteLn;
     Halt(1);
   end;

   Assign (Origem, ParUm);
   Reset (Origem, 1);
   if IOResult <> 0 then
   begin
     writeln('Ficheiro ', ParUm,' n„o econtrado. (?)', #7);
     WriteLn;
     Halt(1);
   end;

   Tamanho:=FileSize(Origem);
   WriteXY(47, 15, ParDois);
   Str(Tamanho, Numero);
   WriteXY(47, 16, Numero);

   BlockWrite(Destino, Leitor, 42, Check);
   Getmem(Ponteiro, Tamanho);
   BlockRead (Origem , Ponteiro^ , Tamanho, Check);
   BlockWrite(Destino, Ponteiro^ , Tamanho, Check);
   Blockwrite(Destino, EOF_MARKER,       1, Check);
   Close(Origem); Close(Destino);
   FreeMem(Ponteiro, Tamanho);

   Ch:=chr(0);
   WriteXY(20, 18, 'Ficheiro compilado com sucesso.');
   delay(1500);
   WriteXY(20, 18, '                               ');
   WriteXY(20, 18, 'Compilar novo ficheiro (S/N)?');
   ch:=readkey;
   if upcase(Ch)='N' then ExitLoop:=TRUE;
  Until ExitLoop;
  EndProg;
end.
