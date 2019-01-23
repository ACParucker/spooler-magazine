{ ⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø }
{ ≥                                                                      ≥ }
{ ≥  Nome do Programa   : HMPCT.PAS                                      ≥ }
{ ≥  Nome do Programador: Hugo Jorge Rodrigues Meneses                   ≥ }
{ ≥  Morada   : 2¶ Travessa do Lazareto, Nß 1                            ≥ }
{ ≥             9000 Funchal                                             ≥ }
{ ≥             Ilha da Madeira                                          ≥ }
{ ≥  Telefone : 34 975                                                   ≥ }
{ ≥  Data     : Marco de 1994 - Versao 1                                 ≥ }
{ ≥                                                                      ≥ }
{ ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ }

Uses Dos, Crt, TCrt2, Fontes, Graph;

{$M 65520, 0, 65520}

{ Ficheiro a ser incluido com o tipo de letra usado pelo programa }
{ NOTA: Ver ficheiro ABC.BAT como construir este ficheiro         }
{$L Letras.Obj}

{ Declara o procedimento Letrinhas como External. Este procedimento  }
{ ficar† incluido no programa durante a compilaáÑo nÑo sendo preciso }
{ ter este ficheiro (Letras.OBJ) sempre junto ao executavel.         }

Procedure Letrinhas; External;

{*
DefiniáÑo do tipo de registo necess†rio para a identificaáÑo do ficheiros
com que se vai trabalhar
*}

Type pf = ^Ficheiros;
     Ficheiros = Record
                    Marca   : Boolean;
                    pa, pp  : pf;
                    Attr    : Byte;
                    Tamanho : Longint;
                    Nome    : String[12];
                    Datas   : LongInt;
                 End;

Const Caixa_Simples = '…Õª∫ºÕ»∫';

Var ini,ult,corrente : pf;
    NumFich          : Integer;
    f                : Text;
    Caminho          : PathStr;
    s, s2            : String;
    Tamanho          : String[24]; { Usado para mudar a apresentaáao do }
                                   { tamanho do ficheiro }
    Atributo         : Byte;
    n3               : Byte;
    Nome             : NameStr;
    Ext              : ExtStr;

    AData            : DateTime;
    Day, Month       : String[2];
    Year             : String[4];
    Hour, Minute, Second :String[2];

    O_Que_Escolhi    : Char;

    Lixo             : Integer;

    Comprimento      : Integer;

Function Espacos(n : Byte):String;
(* D† n espacos *)
Var s:string;
Begin
  FillChar(s[1], n, ' ');
  s[0] := Chr(n);
  Espacos := s;
End;

Function Especial(s: string):string;
{*
Esta funáÑo acrescenta pontos ao string que lhe Ç passado como parÉmetro
de modo a que de tràs em tràs caracteres da esquerda para a direita
fique colocado um ponto, isto Ç £til se se quer apresentar no ecrÑ um
n£mero com um ponto delimitando os milhares, milhîes e milhares de milhÑo.
Ex.: 1200020  --->  1.200.020
*}

Var n : Byte;

Begin
  If (Length(s) >= 4) And (Length(s) <= 6) Then
     Insert('.', s, Length(s) - 2)
  Else
     If (Length(s) > 6) And (Length(s) <= 9) then
        Begin
          Insert('.', s, Length(s)-2);
          Insert('.', s, Length(s)-6);
        End
     Else
        If (Length(s) > 9) Then
           Begin
             Insert('.', s, Length(s)-2);
             Insert('.', s, Length(s)-6);
             Insert('.', s, Length(s)-10);
           End;
     Especial := s;
End;

{$I Procs.Inc }

{ ------------------------------------------------------------------------ }

Function Completa( s:string; tam:byte; posicao:char):string;
{*
FunáÑo que  permite completar um string com espaáos para que este fique com
o tamanho desejado e para que se possa alinhar o mesmo quando for imprimido
no ecrÑ.  Esta  rotina  utiliza utiliza  a funáÑo anterior (Espaáos) para a
introduáÑo dos espaáos no string.
*}
(* Completa um string com espacos alinhando-o a' esquerda, centro, direita *)

Var  b:byte;
Begin
  b:=Length(s);
  Case posicao Of
      'E' : completa := s + Espacos(tam-b);
      'C' : completa := Espacos((tam-b) Div 2 ) + s + Espacos((tam-b) Div 2)
                        + Espacos((tam-b) Mod 2);
      'D' : completa := Espacos(tam-b)+ s;
  End;
End;

{ ------------------------------------------------------------------------ }

Procedure SomaReg(Var ini, ult:pf; Var dirinfo:searchrec);
{**
Este Ç o procedimento que permite a criaáÑo de novos registos na lista.
Este procedimento Ç utilizado pelo procedimento CriaLista.
**}
Begin
     If ini = nil Then
        Begin
             New(ini);
             ini^.pp:=nil;
             ini^.pa:=nil;
             ult:=ini;
             { dados }
             ini^.nome := dirinfo.name;
             ini^.tamanho := dirinfo.size;
             ini^.attr := dirinfo.attr;
             ini^.datas := dirinfo.time;
             ini^.marca := False;
             corrente:=ini;
         End
      Else
         Begin
             New(ult^.pp);
             ult^.pp^.pa:=ult;
             ult:=ult^.pp;
             ult^.pp:=nil;
             { dados }
             ult^.nome := dirinfo.name;
             ult^.tamanho := dirinfo.size;
             ult^.attr := dirinfo.attr;
             ult^.datas := dirinfo.time;
             ult^.marca := False;
          End;
End;

{ ------------------------------------------------------------------------ }

Procedure CriaLista;
{**
Este procedimento cria os registos correspondentes aos ficheiros que vÑo
ser listados
**}
Var DirInfo : SearchRec;
Begin
  ini := nil;
{  FindFirst('*.*', anyfile-hidden-directory-volumeid, DirInfo);}
  FindFirst('*.*', AnyFile+Directory+Hidden, DirInfo);
  While DosError = 0 Do
  Begin
    NumFich := NumFich + 1;
    SomaReg(ini, ult, DirInfo);
    FindNext(DirInfo);
  End;
  If NumFich=0 then
     Begin
       Window(1, 1, 80, 25);
       Textmode(CO80);
       ClrScr;
       Textcolor(12);
       Writeln('NÑo existem ficheiros com a especificaáÑo indicada');
       Writeln('ou a directoria indicada Ç inv†lida!');
       Halt;
     End;
End;

{ ------------------------------------------------------------------------ }

Procedure ListarIni(num:byte);
{*
O ListarIni vai listar a primeira p†gina de ficheiros (os seus nomes sÑo
retirados da lista criada atr†s) no ecrÑ
*}
Var  n:byte;
     d: DirStr;
     nm: NameStr; { Nome }
     E: ExtStr;

Begin
   ClrScr;
   n := 0;
   While (corrente <> Nil) And (n < num) Do
         Begin
            n:=n+1;
            GotoXY(3,n);
            FSplit(corrente^.nome, d, nm, e);
            Write(nm);
            GotoXY(11,n);
            Write(e);
            GotoXY(11,n);
            If corrente^.attr = $10 Then
            Begin
               GotoXY(3,n);
               Write(e);
               GotoXY(11,n);
               Write('[DIR]');
            End;
            GotoXY(16,n);
            Str(corrente^.tamanho, tamanho);
            Tamanho := Especial(Tamanho);
            Write(Tamanho : 12);
            { Data }
            GotoXY(30, n);
            UnpackTime(corrente^.datas, AData);
            Str(AData.Day, Day);
            If Length(Day) = 1 Then Day := '0' + Day;
            Write(Day);
            Write('/');
            Str(AData.Month, Month);
            If Length(Month) = 1 Then Month := '0' + Month;
            Write(Month);
            Write('/');
            Str(AData.Year, Year);
            Write(Year);
            { Hora }
            GotoXY(42, n);
            Str(AData.Hour, Hour);
            If Length(Hour) = 1 Then Hour := '0' + Hour;
            Write(Hour:2);
            Write(':');
            Str(AData.Min, Minute);
            If Length(Minute) = 1 Then Minute := '0' + Minute;
            Write(Minute);
            Write(':');
            Str(AData.Sec, Second);
            If Length(Second) = 1 Then Second := '0' + Second;
            Write(Second);
            { Atributos dos ficheiros }
            GotoXY(52, n);
            Atributo := corrente^.attr;
            { Somente um atributo }
            If Atributo =  0 Then Write('No Attributes');
            If Atributo =  1 Then Write('..R.');          { Read Only }
            If Atributo =  2 Then Write('H...');          { Hidden }
            If Atributo =  4 Then Write('.S..');          { System }
            If Atributo = 16 Then Write('Directory');     { Directory }
            If Atributo = 32 Then Write('...A');          { Archive }
            If Atributo = 40 Then Write('Volume Label');
            { Varios atributos juntos }
            If Atributo =  7 Then Write('HSR.'); { System/Hidden/Read Only }
            If Atributo = 33 Then Write('..RA'); { Read Only/Archive }
            If Atributo = 34 Then Write('H..A'); { Hidden/Archive }
            If Atributo = 35 Then Write('H.RA'); { Hidden/Read Only/Archive }
            If Atributo = 36 Then Write('.S.A'); { System/Archive }
            If Atributo = 37 Then Write('.SRA'); { System/Read Only/Archive }
            If Atributo = 39 Then Write('HSRA'); { System/Hidden/Read Only/Archive }
            corrente:=corrente^.pp;
         End;
End;

{ ------------------------------------------------------------------------ }

Procedure RodaLista(dir:boolean;num:byte);
{**
Este procedimento permite a deslocaáÑo dos nomes de ficheiros, que sÑo
listados no ecrÑ duma vez, para cima ou para baixo, para que seja poss°vel
mostrar os nomes seguintes Ö p†gina listada ou anteriores se j† tiver havido
deslocaáÑo dos nomes.
**}
Var
     d  : DirStr;
     nm : NameStr;
     e  : ExtStr;
Begin
  If dir and (corrente^.pp <> Nil) Then
     Begin
        corrente:=corrente^.pp;
        GotoXY(1,1);
        DelLine;
        FSplit(corrente^.nome, d, nm, e);
        GotoXY(3,num);
        Write(nm);
        GotoXY(11, num);
        Write(e);
        Gotoxy(11, num);
        If corrente^.attr = $10 Then
        Begin
           GotoXY(3,num);
           Write(e);
           GotoXY(11,num);
           Write('[DIR]');
        End;
        GotoXY(16, num);
        Str(corrente^.tamanho, tamanho);
        Tamanho := Especial(Tamanho);
        Write(Tamanho : 12);
        { Data }
        GotoXY(30, num);
        UnpackTime(corrente^.datas, AData);
        Str(AData.Day, Day);
        If Length(Day) = 1 Then Day := '0' + Day;
        Write(Day);
        Write('/');
        Str(AData.Month, Month);
        If Length(Month) = 1 Then Month := '0' + Month;
        Write(Month);
        Write('/');
        Str(AData.Year, Year);
        Write(Year);
        { Hora }
        GotoXY(42, num);
        Str(AData.Hour, Hour);
        If Length(Hour) = 1 Then Hour := '0' + Hour;
        Write(Hour);
        Write(':');
        Str(AData.Min, Minute);
        If Length(Minute) = 1 Then Minute := '0' + Minute;
        Write(Minute);
        Write(':');
        Str(AData.Sec, Second);
        If Length(Second) = 1 Then Second := '0' + Second;
        Write(Second);
        { Atributos dos ficheiros }
        GotoXY(52, num);
        Atributo := corrente^.attr;
        { Somente um atributo }
        If Atributo =  0 Then Write('No Attributes');
        If Atributo =  1 Then Write('..R.');          { Read Only }
        If Atributo =  2 Then Write('H...');          { Hidden }
        If Atributo =  4 Then Write('.S..');          { System }
        If Atributo = 16 Then Write('Directory');     { Directory }
        If Atributo = 32 Then Write('...A');          { Archive }
        If Atributo = 40 Then Write('Volume Label');
        { Varios atributos juntos }
        If Atributo =  7 Then Write('HSR.'); { System/Hidden/Read Only }
        If Atributo = 33 Then Write('..RA'); { Read Only/Archive }
        If Atributo = 34 Then Write('H..A'); { Hidden/Archive }
        If Atributo = 35 Then Write('H.RA'); { Hidden/Read Only/Archive }
        If Atributo = 36 Then Write('.S.A'); { System/Archive }
        If Atributo = 37 Then Write('.SRA'); { System/Read Only/Archive }
        If Atributo = 39 Then Write('HSRA'); { System/Hidden/Read Only/Archive }
     End;

  If Not(dir) then
     Begin
        corrente:=corrente^.pa;
        GotoXY(1,1);
        InsLine;
        GotoXY(3, 1);
        FSplit(corrente^.nome, d, nm, e);
        Write(nm);
        GotoXY(11, 1);
        Write(e);
        Gotoxy(11, 1);
        If corrente^.attr = $10 Then
        Begin
           GotoXY(3, 1);
           Write(e);
           GotoXY(11, 1);
           Write('[DIR]');
        End;
        GotoXY(16, 1);
        Str(corrente^.tamanho, Tamanho);
        Tamanho := Especial(Tamanho);
        Write(Tamanho : 12);
        { Data }
        GotoXY(30, 1);
        UnpackTime(corrente^.datas, AData);
        Str(AData.Day, Day);
        If Length(Day) = 1 Then Day := '0' + Day;
        Write(Day);
        Write('/');
        Str(AData.Month, Month);
        If Length(Month) = 1 Then Month := '0' + Month;
        Write(Month);
        Write('/');
        Str(AData.Year, Year);
        Write(Year);
        { Hora }
        GotoXY(42, 1);
        Str(AData.Hour, Hour);
        If Length(Hour) = 1 Then Hour := '0' + Hour;
        Write(Hour);
        Write(':');
        Str(AData.Min, Minute);
        If Length(Minute) = 1 Then Minute := '0' + Minute;
        Write(Minute);
        Write(':');
        Str(AData.Sec, Second);
        If Length(Second) = 1 Then Second := '0' + Second;
        Write(Second);
        { Atributos dos ficheiros }
        GotoXY(52, 1);
        Atributo := corrente^.attr;
        { Somente um atributo }
        If Atributo =  0 Then Write('No Attributes');
        If Atributo =  1 Then Write('..R.');          { Read Only }
        If Atributo =  2 Then Write('H...');          { Hidden }
        If Atributo =  4 Then Write('.S..');          { System }
        If Atributo = 16 Then Write('Directory');     { Directory }
        If Atributo = 32 Then Write('...A');          { Archive }
        If Atributo = 40 Then Write('Volume Label');
        { Varios atributos juntos }
        If Atributo =  7 Then Write('HSR.'); { System/Hidden/Read Only }
        If Atributo = 33 Then Write('..RA'); { Read Only/Archive }
        If Atributo = 34 Then Write('H..A'); { Hidden/Archive }
        If Atributo = 35 Then Write('H.RA'); { Hidden/Read Only/Archive }
        If Atributo = 36 Then Write('.S.A'); { System/Archive }
        If Atributo = 37 Then Write('.SRA'); { System/Read Only/Archive }
        If Atributo = 39 Then Write('HSRA'); { System/Hidden/Read Only/Archive }
     End;
End;

{ ------------------------------------------------------------------------ }

Procedure Teclado( s: string );
Var n:Byte;
    ch:Char;
    r:registers;
Begin
  If s='' Then
     While Keypressed Do ch := ReadKey
  Else
     Begin
       If Odd(Length(s)) Then s := s + ' ';
       For n:=1 To Length(s) do
           If Odd(n) Then
              Begin
                r.ah := 5;
                r.ch := Ord(s[n+1]);
                r.cl := Ord(s[n]);
                Intr($16, r);
              End;
           End;
End;

{ ------------------------------------------------------------------------ }

Procedure Barra(x1, y1, x2, y2 : Byte);
{*
Este Ç o procedimento principal do programa. ê aqui que se controla o
movimento da 'barra iluminada' e que controla todas as funáîes das
teclas utilizadas no programa.
ê este procedimento que define as dimensîes da caixa que ir† conter
os nomes dos ficheiros listados no ecrÑ e que define e controla os limites
de movimentaáÑo da 'barra iluminada' de escolha e os limites de listagem
de ficheiros
*}
Var posi, Cor, CorB, n, n4 :byte;
    ch              : Char;
    s               : String[2];
    s1,s2,stemp     : String;
    nbytes          : Longint;

Begin
   n4 := 1;
   nbytes := 0;
   stemp := '';
   CorB := 31;
   Cor := 31;
   corrente := ini;
   Posi := 1;
   Window(x1, y1, x2, y2);
   TextBackground(7);
   TextColor(0);
   Caixa(x1-1, y1-1, x2+1, y2+1, Caixa_Simples, 127);
   ListarIni(y2 - y1 + 1);
   CorXX(x1, y1, x2, CorB);
   Corrente := ini;
   Repeat
      Str(nbytes,s2);
      s2 := Especial(s2);

      ch := readkey;

      If ch=#13 Then     { verifica se a tecla ENTER foi ou nÑo primida}
         Begin
            Teclado(#0 + 'P');
            corrente^.marca := Not(corrente^.marca);
            If corrente^.marca Then
               CorXX(x1, y1 - 1 + posi, x2, 30)
            Else
               CorXX(x1, y1 - 1 + posi, x2, 31);
         End;

      { Marca ˚ }
      If corrente^.marca Then
         Begin
            Cor := 7*16+14;  { 7 * 16 + 14 = 128 }
            PoeCar(x2 - 2, posi + y1 - 1, #251, 127);
         End
      Else
         Begin
            Cor := 7*16;   { 7 * 16 = 112 }
            PoeCar(x2 - 2, posi + y1 - 1, ' ', 127);
         End;

      If ch = #27 Then
         Begin
            TextMode(C80);
            LigaCursor;
            Halt;
         End; { Se a tecla ESC for primida o programa Ç abortado }

      If ch = #0 Then  { Verifica se a tecla primida foi uma tecla especial:
                         <-, ->, PgUp, PgDn, etc.}
         Case ReadKey Of
            'I': Begin   { PGUP }
                   CorXX(x1, y1 - 1 + posi, x2, Cor);{ cor Ç a cor que fica }
                   n4 := posi;
                   While (posi > 1) And (corrente^.pa <> nil) Do
                         Begin
                            posi := posi - 1;
                            corrente:=corrente^.pa;
                         End;
                   n4 := n4 - posi;
                   While (y2 - y1 + 1 - n4 > 0) And (corrente^.pa <> Nil) Do
                         Begin
                            n4 := n4 + 1;
                            RodaLista(False, 1);
                         End;
                   CorXX(x1, y1 - 1 + posi, x2, CorB);
                End;
            'Q': Begin    { PGDN }
                   CorXX(x1, y1 - 1 + posi, x2, Cor);
                   n4:=posi;
                   While (posi < y2 - y1 + 1)  and (corrente^.pp <> Nil) do
                   Begin
                     posi:=posi+1;
                     corrente:=corrente^.pp;
                   End;
                   n4 := y2-y1+1-(posi-n4);
                   If n4 = 0 then n4 := y2-y1+1;
                   While (y2-y1+1+n4>y2-y1+1) And (corrente^.pp<>nil) Do
                         Begin
                           n4:=n4-1;
                           RodaLista(True, y2 - y1 + 1);
                         End;
                   CorXX(x1, y1 - 1 + posi, x2, CorB);
                 End;
           'H': If (posi >= 1) Then  { Seta para cima }
                   Begin
                     If (posi = 1) and (corrente <> ini) then
                        Begin
                          CorXX(x1, y1 - 1 + posi, x2, Cor);
                          RodaLista(False, y2 - y1 + 1);
                          CorXX(x1, y1 - 1 + posi, x2, CorB);
                        End
                     Else
                        If (posi > 1) Then { Nao e' a 1¶ linha }
                           Begin
                             corrente := corrente^.pa;
                             CorXX(x1, y1 - 2 + posi, x2, CorB);
                             CorXX(x1, y1 - 1 + posi, x2, Cor);
                             posi := posi-1;
                             Str(posi, s);
                           End;
                        End;
           'P':If posi < NumFich Then    { Seta para baixo }
                  Begin
                     If posi < y2 - y1 + 1 then
                        Begin
                           corrente:=corrente^.pp;
                           CorXX(x1, y1 + posi, x2, Corb);
                           CorXX(x1, y1 - 1 + posi, x2, Cor);
                           posi := posi + 1;
                        End
                     Else
                        Begin
                           CorXX(x1, y1 - 1 + posi, x2, Cor);
                           RodaLista(True, y2 - y1 + 1);
                           CorXX(x1, y1 - 1 + posi, x2, Corb);
                        End;
                     Str(posi, s);
                  End;
         End;
      O_Que_Escolhi := UpCase(ch)
                       { Guarda a tecla primida para usar no Executa }
   Until UpCase(ch) In ['A', 'C',  'D', 'I', 'M', 'N', 'R', 'V'];
                       { Teclas usadas para acabar seleccao }
End;

{ ------------------------------------------------------------------------ }

Function VerificaDecisao:Boolean;  {pede confirmacao ao utilizador}
Var Tecla : Char;
Const t = 12;
      l = 26;
      b = 13;
      r = 54;
Begin
   Window(l, t, r, b);
   Clrscr;
   Caixa(l-1, t-1, r+1, b+1, Caixa_Simples, 78);
   WriteLn('  Confirme, por favor  ?');
     Write('  Continuo (S)im (N)Ño ? ');
   PoeCar(r - 3, b, '€', 31);
   Repeat
      Tecla := ReadKey;
      If Tecla = #27 Then Tecla := 'N';
      Tecla := UpCase(Tecla);
   Until Tecla In ['S','N'];
   If Tecla = 'S' Then VerificaDecisao := True;
   If Tecla = 'N' Then VerificaDecisao := False;
   If Tecla = 'S' Then Write('Sim') Else Write('Nao');
End;

{ ------------------------------------------------------------------------ }

Procedure Corre(Programa:String);
{*
O procedure Corre comanda a execuáÑo de programas no DOS
*}
Var ODirectorioOndeEstou : String;
Begin
  GetDir(0, ODirectorioOndeEstou);
  Window(1, 1, 80, 25);
  CorNormal;
  ClrScr;
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '/C' + Programa);
  SwapVectors;
  If DosError <> 0 Then  { Error ? }
     Begin
       ClrScr;
       Erro('OperaáÑo nÑo Ç poss°vel!');
       Halt(0);
     End;
  EscreveXY(1, 24, 71, 'Prima uma tecla para continuar . . . ');
  Le_Tecla(Lixo);
  ChDir(ODirectorioOndeEstou);
End;

{ ------------------------------------------------------------------------ }

Procedure Executa(O_Que:Char);
Var FileaUsar : File;
    ParaOnde  : String;
    NovoNome  : String;
    Comando   : String;

    FromF     : File;
    ToF       : File;
    NumRead, NumWritten: Word;
    OBuffer   : Char;
    i         : Integer;

    Comprimento : Integer;

Const Barra = '\';

Begin
  LigaCursor;
  Case O_Que Of
       'A': Begin      { A P A G A R }
               If VerificaDecisao Then
               Begin
                  corrente := ini;
                  While corrente <> nil Do
                  Begin
                    If corrente^.marca Then Apaga_Ficheiro(corrente^.nome);
                    corrente:=corrente^.pp;
                  End;
               End;
            End;
       'C': Begin    { C O P I A R }
               ParaOnde := '';
               Window(10, 11, 70, 13);
               ClrScr;
               Caixa(10, 11, 70, 13, Caixa_Simples, 71);
               CorXX(11, 12, 69, 71);
               Window(1, 1, 80, 24); { Para voltar a janela normal }
               EscreveXY(15, 12, 71, 'Directorio destino ');
               LeStr(35, 12, 24, ParaOnde, '˛', 'S');
               If ParaOnde <> '' Then
                  Begin
                     { Para se nao tiver uma \ no fim introduzi-la }
                     Comprimento := Length(ParaOnde);
                     If Pos('\', ParaOnde) < Comprimento - 1 Then
                        ParaOnde := ParaOnde + '\';
                     corrente := ini;
                     While corrente <> nil Do
                           Begin
                              Window(10, 11, 70, 13);
                              ClrScr;
                              Caixa(10, 11, 70, 13, Caixa_Simples, 71);
                              CorXX(11, 12, 69, 71);
                              GotoXY(3, 2);
                              If corrente^.marca Then
                                 Begin
                                    { Se nÑo existir uma \ no fim copia
                                      sem o nome do ficheiro. Isto Ç para
                                      o caso de se querer copiar um
                                      ficheiro com um "nome destino"
                                      diferente }
                                    If ParaOnde[Comprimento] <> '\' Then
                                    Begin
                                      If corrente^.attr <> $10 Then
                                      Copia_Ficheiro(corrente^.nome,
                                         ParaOnde);
                                    End;
                                    { Caso o ultimo caractere seja uma \
                                      copia sem nome depois da barra }
                                    If ParaOnde[Comprimento] = '\' Then
                                    Begin
                                      If corrente^.attr <> $10 Then
                                      Copia_Ficheiro(corrente^.nome,
                                         ParaOnde + corrente^.nome);
                                    End;
                                 End;
                              corrente:=corrente^.pp;
                           End;
                  End;
            End;

       'D': Begin     { M U D A R  D E  D I R E C T O R I O }
               corrente := ini;
               While corrente <> nil Do
                     Begin
                        If corrente^.marca Then
                           If corrente^.attr = $10 Then
                              Begin
                                 If Length(Caminho) = 3 Then
                                      ChDir(Caminho + corrente^.nome)
                                 Else
                                      ChDir(Caminho + '\' + corrente^.nome);
                              End;
                        corrente:=corrente^.pp;
                     End;
            End;

       'I': Begin      { I N F O R M A Ä O E S }
               GetConfig;
               Le_Tecla(Lixo);
            End;

       'M': Begin     { M O V E R  F I C H E I R O S }
               ParaOnde := '';
               Window(10, 11, 70, 13);
               ClrScr;
               Caixa(10, 11, 70, 13, Caixa_Simples, 71);
               CorXX(11, 12, 69, 71);
               Window(1, 1, 80, 24); { Para voltar a janela normal }
               EscreveXY(22, 12, 71, 'Mover para ');
               LeStr(35, 12, 24, ParaOnde, '˛', 'S');
               If ParaOnde <> '' Then
                  Begin
                     Comprimento := Length(ParaOnde);
                     corrente := ini;
                     While corrente <> nil Do
                     Begin
                        Window(10, 11, 70, 13);
                        ClrScr;
                        Caixa(10, 11, 70, 13, Caixa_Simples, 71);
                        CorXX(11, 12, 69, 71);
                        GotoXY(3, 2);
                        If corrente^.marca Then
                           Begin
                              { Caso nao seja um directorio }
                              If corrente^.attr <> $10 Then
                                 Begin
                                    { Se tiver uma \ no fim copia sem
                                      o nome do ficheiro. Isto Ç pra o
                                      caso de se querer copiar um
                                      ficheiro com um "nome destino"
                                      diferente }
                                    If ParaOnde[Comprimento] <> '\' Then
                                    Begin
                                      Copia_Ficheiro(corrente^.nome,
                                         ParaOnde);
                                      Apaga_Ficheiro(corrente^.nome);
                                    End;
                                    { Caso o ultimo caractere seja uma \
                                      copia sem nome depois da barra }
                                    If ParaOnde[Comprimento] = '\' Then
                                    Begin
                                      Copia_Ficheiro(corrente^.nome,
                                         ParaOnde + corrente^.nome);
                                      Apaga_Ficheiro(corrente^.nome);
                                    End;
                                 End;
                           End;
                        corrente:=corrente^.pp;
                     End;
                  End;
            End;

       'N': Begin    { R E N A M E }
              corrente := ini;
              While corrente <> nil Do
                    Begin
                       If corrente^.marca Then
                       Begin
                          If corrente^.attr <> $10 Then
                          Begin
                             NovoNome := '';
                             Window(10, 11, 70, 13);
                             ClrScr;
                             Caixa(10, 11, 70, 13, Caixa_Simples, 71);
                             CorXX(11, 12, 69, 71);
                             { Para voltar a janela normal }
                             Window(1, 1, 80, 24);
                             EscreveXY(12, 12, 71,
                                 'Novo nome para '+corrente^.nome);
                             LeStr(WhereX+1, 12, 24, NovoNome, '˛', 'S');
                             If NovoNome <> '' Then
                                Renomeia_Ficheiro(corrente^.nome, NovoNome);
                          End;
                       End;
                       corrente:=corrente^.pp;
                    End;
            End;

       'R': Begin       { C O R R E R  U M  P R O G R A M A }
               corrente := ini;
               While corrente <> nil Do
               Begin
                  LoadRomFont8x16;       { Volta as letras normais }
                  If corrente^.marca Then Corre(corrente^.nome);
                  corrente:=corrente^.pp;
               End;
            End;

       'V': Begin   { V I S U A L I Z A R  F I C H E I R O S }
               corrente := ini;
               While corrente <> nil Do
               Begin
                  If corrente^.marca Then
                     Begin
                        If corrente^.attr <> $10 Then
                        Begin
                           Window( 1, 1, 80, 25);
                           ClrScr;
                           Window( 1, 1, 80, 3);
                           ClrScr;
                           Caixa(1, 1, 80, 3, Caixa_Simples, 127);
                           CorXX(2, 2, 79, 31);
                           EscreveHor(3, 2, corrente^.nome, 31);
                           Caixa(1, 4, 80, 25, Caixa_Simples, 127);
                           Window(2, 5, 79, 24);
                           Assign(FromF, corrente^.nome);
                           Reset(FromF, 1);
                           i := 0;
                           Repeat
                             BlockRead(FromF, OBuffer, SizeOf(OBuffer),
                                       NumRead);
                             Write(OBuffer);
                             If Ord(OBuffer) = 10 Then Inc(i);
                             If i = 18 Then
                                Begin
                                   Le_Tecla(Lixo);
                                   { Se for uma tecla especial retorna como
                                     se fosse a tecla ESC }
                                   If Ord(Lixo) = 0 Then Lixo := 27;
                                   If Lixo = 27 Then Exit;
                                   ClrScr;
                                   i := 0
                                End;
                           Until (NumRead = 0);
                           Close(FromF);
                           Le_Tecla(Lixo);
                        End;
                     End;
                  corrente:=corrente^.pp;
               End;
            End;

  End;  { Case }
  DesligaCursor;

End;

(*    P R O G R A M A   P R I N C I P A L  *)

Label 1;

Begin
1:
   If ParamCount = 1 Then
      Begin
         {$I-}
         ChDir(ParamStr(1));
         {$I+}
         If IOResult <> 0 Then
            Begin
              ClrScr;
              Erro('Directorio inexistente');
              Window(1, 1, 80, 24);
              GotoXY(1, 24);
              Halt(0);
            End;
      End;
   { Muda o tipo de letras a utilizar no ecran }
   LoadLinkFont(@Letrinhas, 16);
   ClrScr;
   DesligaCursor;
   { Linha com o nome do directorio }
   { Para evitar que quando se muda de directorio apareáa o resto do nome
     directorio anterior }
   Window( 1, 1, 80, 3);
   ClrScr;
   Caixa(1, 1, 80, 3, Caixa_Simples, 127);
   CorXX(2, 2, 79, 31);
   GetDir(0, Caminho);
   { Para se nao tiver uma \ no fim introduzi-la }
   Comprimento := Length(Caminho);
   If Caminho[Comprimento] <> '\' Then Caminho := Caminho + '\';
   EscreveHor(3, 2, Caminho + '*.*', 31);
   { Linha com os comandos }
   Caixa(1, 21, 80, 25, Caixa_Simples, 127);
   CorXX(2, 22, 79, 31);
   CorXX(2, 23, 79, 31);
   CorXX(2, 24, 79, 31);
   { Comandos do programa }
   EscreveHor(3, 22, 'Teclas a usar:                                           (c) Hugo Meneses 94', 31);
   EscreveHor(3, 23, 'A Apagar Ficheiros   C Copiar Ficheiros   M Mover Ficheiros   N Mudar o nome', 31);
   EscreveHor(3, 24, 'D Mudar de Directorio  I Informaáîes  R Executar  V Visualizar ESC para sair', 31);
   Erro('Aguarde, se faz favor . . .');
   NumFich:=0;
   CriaLista;
   Barra(2, 5, 79, 19);
   Executa(O_Que_Escolhi);
   LoadRomFont8x16;       { Volta as letras normais }
   Goto 1
End.

*

{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}