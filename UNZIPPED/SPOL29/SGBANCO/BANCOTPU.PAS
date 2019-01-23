unit BancoTpu;
interface
 uses dos,crt,printer;

 var
  conta                :shortint; {***** Var Escreve ####}
  conta1               :shortint;
  COORD                :shortint;
  XS,
  YS                   :shortint;
  st                   : string;
  Maximo,
  Minimo               : byte;
  cha                  :char;   {**** Var Escreve *****}
  DataLancamento       ,        {***** Var Dos Lancamentos *****}
  ReferenciaLancamento ,
  CredV                ,
  DescricaoLancamento  : string;
  NumeroLancamento     : integer;
  ValorLancamento      : string; {***** Var Dos Lancamentos ****}
  Carater              : char;   {***** Dados Iniciais ****}
  NomeBanco,
  Dependencia,
  NumeroConta,
  Titular,
  DataInicial,
  PalavraChave,
  SaldoInicial         : string; {****** Dados Iniciais ****}
  FileCliente          : text; { ****** Ficheiro do cliente ******}
  FileConta            : text; { ****** ficheiro da Conta *******}
  Mask                 : string;
  aux,s                : string; {********* Var Directorio ********}
  Ordena               ,
  PassWordV            ,
  Encripta             : boolean;
  EncriptaST           ,
  OrdenaSt             ,
  PassWordSt           ,
  PassWordVSt          : string;
  PassWord             : string;
  FicC                 : Text; {Ficheiro ConfiguraáÑo}
  Ficheiro             : string;
  OpPrin               : array [1..9] of string;
  VDesce               : integer;
  VDesceF              : integer;
  VDesceE              : integer;
  VDesceS              : integer;
  VDesceU              : integer;
  Sair                 : boolean;
  zero                 : boolean;
  NomeFicheiro         : string;
  CTIni                ,         {cores}
  CFIni                ,
  CTUltima             ,
  CFUltima             ,
  CTCabecalho          ,
  CFCabecalho          ,
  CTFundo              ,
  CFFundo              ,
  CTOpNao              ,
  CFOpNao              ,
  CTOpSim              ,
  CFOpSim              ,
  CTErro               ,
  CFErro               ,
  CTAvisos             ,
  CFAvisos             ,
  CTPerguntas          ,
  CFPerguntas          ,
  CTFichas             ,
  CFFichas             ,
  CTInf                ,
  CFInf                : integer;

 FUNCTION ISFILE (var Nome :string):boolean;{ O Ficheiro existe ?......}
 PROCEDURE SET_CURSOR(Cr:integer);
 Procedure Inicio;
 Procedure up (Var s : string);
 Procedure OpPrincipais;
 Procedure OpFicheiro;
 Procedure OpEditar;
 Procedure OpServicos;
 Procedure OpUtils;
 Procedure Desce(Coluna,MaxV,MinV:integer;var w:integer);
 Procedure Sobe(Coluna,MaxV,MinV:integer;var w:integer);
 Procedure SobreSai(Coluna:integer;var Opcao:string;var w:integer);
 Procedure CaixaF (X,Y,Z,H : integer);
 Procedure Cabecalho;
 Procedure Menu;
 Procedure MenuPrincipal;
 Procedure MenuFicheiros;
 Procedure MenuEditar;
 Procedure MenuServicos;
 Procedure MenuUtils;
 Procedure Erros (Erro : integer);
 Procedure CaixaS (X,Y,Z,H : integer);
 Procedure Inf(n : byte;var x : integer);
 Procedure L25_1;
 Procedure L25_2;
 Procedure L25_3;
 Procedure L25_4;
 Procedure L25_5;
 Procedure L25_6;
 Procedure L25_7;
 Procedure L25_8;
 Procedure PaginaInformacao;
 Procedure Variaveis_Zero;
 Procedure Cores;
 Procedure Directorio;
 Procedure MudaDirectorio;
 Procedure Passeio;
 Procedure Escreve(Tipo,Max,X,Y : shortint);
 Procedure Ordena_Data;

Implementation

Procedure Ordena_Data;

var

J,M,N,U :integer;
X,Y: longint;
A : array[0..1500] of longint;
B : array[0..1500] of longint;
Ref:string[5];
Descri:string[12];
Valor:string[10];
Numero:integer;
NumeroII:integer;
ficheiro:text;
ficheiro1:text;
e    : char;
StFich,
StFich1 : string[12];
Fim   : boolean;

begin
 M:=0;
 N:=0;
 U:=-1;
 X:=0;
 Y:=0;
 For J := 0 to 1500 do
  begin
   A[J] :=0;
   B[J] :=0;
  end;
 J:=0;
 CredV :='';
 Ref:='';
 Descri:='';
 Valor:='';
 Numero:=0;
 NumeroII:=0;
 e    :=#0;
 StFich:='';
 StFich1 :='';

 TextColor(CTFundo);
 TextBackGround(CFFundo);
 Clrscr;
 Cabecalho;
 TextColor(CTAvisos);
 TextBackGround(CFAvisos);
 GotoXY(1,10);write('Estou a ordenar ');
 StFich := concat(NomeFicheiro,'.MOV');
 StFich1:= concat(NomeFicheiro,'.APA');
 {$I-}
 assign(Ficheiro,StFich);
 reset(ficheiro);
 {$I+}
 If IORESULT <> 0 then
  Begin
   Erros(2);
   Erros(0);
   Exit;
  end;
 U:=0;
 {$I-}
 Readln(ficheiro,CredV);
 Readln(ficheiro,A[U]);
 Readln(ficheiro,Ref);
 Readln(ficheiro,Descri);
 Readln(ficheiro,Valor);
 Readln(ficheiro,Numero);
 {$I+}
 If IORESULT <> 0 then
  begin
   Erros(6);
   Erros(0);
   Exit;
  end;
 while not EOF(ficheiro) do
  begin
   {$I-}
   Inc(U);
   Readln(ficheiro,CredV);
   Readln(ficheiro,A[U]);
   Readln(ficheiro,Ref);
   Readln(ficheiro,Descri);
   Readln(ficheiro,Valor);
   Readln(ficheiro,Numero);
   {$I+}
   If IORESULT <> 0 then
    begin
     Erros(6);
     Erros(0);
     Exit;
    end;
  end;{While}
 If (CredV='CRêDITO')or(CredV='DêBITO') then
  begin
   For J:=0 to(U-1) do
    begin
     M := (U-1)-J;
     For N:= 0 to M do
      begin
       If A[N]<A[N+1] then
        begin
        end
       else
        begin
         X:=A[N+1];
         A[N+1]:=A[N];
         A[N]:=X;
        end;
      end;
    end;
   assign(ficheiro1,StFich1);
   {$I-}
   rewrite(ficheiro1);
   {$I+}
   If IORESULT <> 0 then
    begin
     Erros(6);
     Erros(0);
     Exit;
    end;
   for M := 0 to U do
    begin
     {$I-}
     Reset(ficheiro);
     {$I+}
     If IORESULT <> 0 then
      Begin
       Erros(6);
       Erros(0);
       Exit;
      end;
     GotoXY(1,20);
     if U <> 0 then write('OrdenaáÑo - ',((M*100)/U):3:0,' % realizada ',chr(13));
     repeat
      repeat
       {$I-}
       Readln(ficheiro,CredV);
       Readln(ficheiro,X);
       Readln(ficheiro,ReferenciaLancamento);
       Readln(ficheiro,DescricaoLancamento);
       Readln(ficheiro,ValorLancamento);
       Readln(ficheiro,NumeroII);
       {$I+}
       If IORESULT <> 0 then
        Begin
         Erros(6);
         Erros(0);
         Exit;
        end;
      until X=A[M];
      J:=0;
      Repeat
       numero := B[J];
       inc(J);
      until (numero=NumeroII)or(J=M+1);
     until (numero<>NumeroII);
     {$I-}
     append(ficheiro1);
     B[M] := NumeroII;
     writeln(ficheiro1,CredV);
     writeln(ficheiro1,A[M]);
     writeln(ficheiro1,ReferenciaLancamento);
     writeln(ficheiro1,DescricaoLancamento);
     writeln(ficheiro1,ValorLancamento);
     writeln(ficheiro1,NumeroII);
     {$I+}
     If IORESULT <> 0 then
      begin
       Erros(6);
       Erros(0);
       Exit;
      end;
    end;{***FOR***}
   {$I-}
   close(ficheiro);
   close(ficheiro1);
   Erase(Ficheiro);
   Rename(Ficheiro1,StFich);
   {$I+}
   If IORESULT <> 0 then
    Begin
     Erros(3);
     Erros(0);
     Exit;
    end;
  end
 else
  begin
   Erros(6);
   Erros(0);
  end;
end;

Procedure Escreve (Tipo,Max,X,Y :shortint);
 {****
    Tipo : 0 - Tudo
           1 - Letras
           2 - Numeros
           3 - Letras & Numeros
           4 - Numeros com decimais}

 var
 Flag1,
 Flag2 : boolean;
 zero  : boolean;
 STAUX : string;
 Var8  : boolean;
 Var8_2: byte;
 begin

 XS := X;
 YS := Y;
 zero:=false;
 Set_Cursor($0607);
 If Conta1 = 0 then delete(staux,1,255) else staux := st;
 Conta := 0;
 GotoXY(XS,YS);
 repeat
 zero := false;
 repeat
  cha := readkey;
     if cha=#0 then
      begin
       cha := readkey;
       zero := true;
      end;
  if (cha<>#8)or(cha<>#32)or(cha<>#13)or(cha<>#75)or(cha<>#77)or(cha<>#72)or(cha<>#80)or(cha<>#82)or(cha<>#27) then
  case Tipo of
      0 : begin
           Flag1 := true;
           Flag2 := true;
          end;
      1 : begin
           if ('A'<=cha)and(cha<='Ø')or(cha=',')or(cha=':')or(cha=';')or(cha='*')or(cha='.')or(cha='_')or(cha='-')
           {Cont}or(cha='/')or(cha=' ')then Flag1 := true
           else Flag1 := false;
           Flag2:=false;
          end;
      2 : begin
           if ('0'<=cha)and(cha<='9')then Flag1 := true
           else Flag1 := false;
           Flag2 :=false;
          end;
      3 : begin
           if ('A'<=cha)and(cha<='Ø')or(cha=',')or(cha=':')or(cha=';')or(cha='*')or(cha='.')or(cha='_')or(cha='-')
           {cont}or(cha='/')or(cha=' ')or('0'<=cha)and(cha<='9') then Flag1 := true
           else Flag1 := false;
           Flag2:= false;
          end;
      4 : begin
           if ('0'<=cha)and(cha<='9')or(cha='.')then Flag1 := true
           else Flag1 := false;
           Flag2 :=false;
          end;
  end;
 If(cha=#8)or(cha=#13)or(cha=#75)and(zero=true)or(cha=#77)and(zero=true)or(cha=#72)and(zero=true)or(cha=#80)
 {***} and(zero=true)or(cha=#82)and(zero=true)or(cha=#27) then Flag2:=true;
 until (Flag1=True)or(Flag2=true);
 If Flag2 = true then
 Case cha of
    #8:begin
        Var8 := true;
        if (conta=conta1) then
         begin
          delete(staux,Conta,1);
          if Conta>0 then dec(Conta);
          if Conta1>0 then dec(Conta1);
          If XS>X then
          begin
           dec(XS);
           GotoXY(XS,YS);
           write (' ');
           GotoXY(XS,YS);
          end;
          If XS=X then
          begin
           GotoXY(XS,YS);
           write (' ');
           GotoXY(XS,YS);
          end;
          Var8 := False;
         end;
        if (conta=0)and(Var8=True) then
         begin
          delete(staux,conta1,1);
          GotoXY(XS,YS);
          write(staux,' ');
          GotoXY(XS,YS);
          Var8 := False;
          if conta1<>0 then dec(conta1);
         end;
        if (conta<conta1)and(Var8=True) then
         begin
          delete(staux,conta,1);
          if XS>X then dec(XS);
          GotoXY(XS,YS);
          Var8_2:= Conta1-Conta;
          write(copy(staux,conta,Var8_2),' ');
          GotoXY(XS,YS);
          if Conta>0 then dec(Conta);
          if Conta1>0 then dec(Conta1);
          Var8 := false;
         end;

        end;
    #13:begin
         inc (COORD);
         if COORD >MAXIMO then COORD := MINIMO;
        end;
 end;
 if zero=true then
 Case cha of
    #80:begin
         inc (COORD);
         if COORD >MAXIMO then COORD := MINIMO;
        end;
    #72:begin
         dec (COORD);
         if COORD <MINIMO then COORD := MAXIMO;
        end;
    #75:begin
        if (Conta>0)and(Conta1>0) then dec(Conta);
        if XS>X then dec(XS);
        GotoXY(XS,YS);
       end;
    #77:begin
         if Conta<Conta1 then
          begin
           inc(Conta);
           inc(XS);
          end;
         GotoXY(XS,YS);
        end;
 end;
 { if (Flag2=false)and(Flag1=true)and(zero=false)then
   begin
    if (Conta<Max)and(Conta1<Max) then
     begin
      If Conta=Conta1 then Inc(Conta1);
      inc (Conta);
      insert(cha,staux,Conta);
      GotoXY(XS,YS);
      write (cha);
      inc (XS);
     end;
   end;}
 if (Flag2=false)and(Flag1=true)and(zero=false)then
   begin
    if (Conta<Max)and(Conta1<Max) then
     begin
       if conta<=conta1 then
        begin
         inc(conta);
         inc(conta1);
         insert(cha,staux,conta);
         GotoXY(X,Y);
         write(copy(staux,0,conta1));
         inc(XS);
         GotoXY(XS,YS);
        end;
     end;
   end;
 until (cha=#13)or(cha=#27)or(cha=#72)and(zero=true)or(cha=#80)and(zero=true);
 st := copy(staux,0,Conta1);
 Set_Cursor($0800);

end;{escreve}

Procedure Directorio;
var
  tamanho        : real;
  vezes          : byte;
  Masks          : string;
  contador,
  coluna         : byte;
  DirInfo        : SearchRec;
begin
  TextColor(CTFundo);
  TextBackGround(CFFundo);
  Clrscr;
  Cabecalho;
  Masks := Mask;
  L25_6;
  TextColor(CTInf);
  TextBackGround(CFInf);
  GotoXY(1,23);write('Mask Anterior : ',Mask);
  GotoXY(1,24);write('Novo Mask : ');
  st:=Mask;
  Conta1:=0;
  Escreve(3,60,13,24);
  up (st);
  Mask:=st;
  TextColor(Black);
  TextBackGround(Black);
  GotoXY(1,23);write('                                                                              ');
  GotoXY(1,24);write('                                                                              ');
  If (Mask = '') or (Mask = #27) or (Mask = #32) then Mask := Masks;
  contador := 3;
  coluna := 4;
  vezes := 0;
  TextColor(CTCabecalho);
  TextBackGround(CFCabecalho);
  GotoXY (3,2);  write (' Nome.Ext     Tamanho ');
  GotoXY (29,2); write (' Nome.Ext     Tamanho ');
  GotoXY (55,2); write (' Nome.Ext     Tamanho ');
  TextColor(CTInf);
  TextBackGround(CFInf);
  writeln;
  FindFirst(mask,directory,dirinfo);
  If DosError = 18 then Erros(2);
  while DosError = 0 do
    begin
      if DirInfo.Attr = Directory then
       begin
        TextColor(Green);
        gotoxy (coluna,contador);
        writeln ('<',dirinfo.name,'>');
        TextColor(CTInf);
       end
      else
       begin
        gotoxy (coluna,contador);
        write (dirinfo.name);
        tamanho := dirinfo.size;
        gotoxy ((coluna+13),contador);
        writeln (tamanho:7:0);
       end;
      FindNext(dirinfo);
      inc (contador);
      if contador = 24 then
        begin
          contador := 3;
          inc (coluna,26);
          inc (vezes);
          If vezes = 3 then
           begin
            Erros(0);
            TextColor(CTFundo);
            TextBacKGround(CFFundo);
            clrscr;
            Cabecalho;
            TextColor(CTCabecalho);
            TextBackGround(CFCabecalho);
            gotoxy (3,2);  write (' Nome.Ext      Tamanho ');
            gotoxy (29,2); write (' Nome.Ext      Tamanho ');
            GotoXY (55,2); write (' Nome.Ext      Tamanho ');
            TextColor(CTInf);
            TextBackGround(CFInf);
            contador := 3;
            coluna := 4;
            vezes := 0;
           end;
        end;
    end;
  Erros(0);
  MenuUtils;
end;{****** Fim Directorio *****}

Procedure MudaDirectorio;
begin
    TextColor(CTFundo);
    TextBackGround(CFFundo);
    Clrscr;
    Cabecalho;
    L25_5;
    Getdir (0,s);
    aux:='';
    L25_6;
    TextColor(CTInf);
    TextBackGround(CFInf);
    GotoXY(1,23);write('Directorio Anterior : ',s);
    GotoXY(1,24);write('Novo Directorio : ');
    st:=aux;
    Conta1:=0;
    Escreve(3,60,19,24);
    up(st);
    aux:=st;
    {$I-}
    ChDir (aux);
    {$I+}
    if IORESULT <> 0 then Erros(4);
    MenuUtils;
end;

Procedure Passeio;
begin
  Clrscr;
  GotoXY(1,10);
  writeln('Escreva EXIT para regressar ao BANCO ');
  Set_Cursor($0607);
  swapvectors;
  exec('\COMMAND.COM','');
  swapvectors;
  Set_Cursor($0800);
  MenuUtils;
end;{Passeio}

Procedure Cores;
begin
CTIni      := 3{cyan};
CFIni      := 1{blue};
CTUltima   := 14{yellow};
CFUltima   := 1{blue};
CTCabecalho:= 14{yellow};
CFCabecalho:= 1{blue};
CTFundo    := 8{DGray};
CFFundo    := 0{black};
CTOpNao    := 7{LGray};
CFOpNao    := 0{black};
CTOpSim    := 2{green};
CFOpSim    := 1{blue};
CTErro     := 14{yellow};
CFErro     := 4{red};
CTAvisos   := 7{LGray};
CFAvisos   := 0{Black};
CTPerguntas:= 14{yellow};
CFPerguntas:= 1{blue};
CTFichas   := 14{yellow};
CFFichas   := 0{black};
CTInf      := 7{LGray};
CFInf      := 0{Black};
end;

Procedure Variaveis_Zero;
begin
 Mask                 :='*.*';
 DataLancamento       :='';
 ReferenciaLancamento :='';
 DescricaoLancamento  :='';
 CredV                :='';
 NumeroLancamento     :=0;
 ValorLancamento      :=''; {***** Var Dos Lancamentos ****}
 Carater              :=#0;   {***** Variavel do menu principal ****}
 NomeBanco            :='';
 Dependencia          :='';
 NumeroConta          :='';
 Titular              :='';
 DataInicial          :='';
 PalavraChave         :='';
 SaldoInicial         :='';{****** Dados Iniciais ****}
 NomeFicheiro         :='SEM_NOME';
 VDesce               :=1;
 VDesceF              :=1;
 VDesceE              :=1;
 VDesceS              :=1;
 VDesceU              :=1;
end;


Procedure PaginaInformacao;
var
 i : byte;
 a : char;
begin
 TextColor(LightBlue);
 TextBackGround(0);
 clrscr;
 caixas(1,1,79,23);
 TextColor(Blue);
 for i := 2 to 23 do
  begin
   GotoXY(80,i); write('€');
  end;
 for i := 2 to 80 do
  begin
   GotoXY(i,24); write('ﬂ');
  end;
 TextColor(Green);
 TextBackGround(Blue);
 GotoXY(3,2); write('                     SOGMI - IMFORMATICA & PROGRAMAÄéO                     ');
 TextColor(Yellow);
 TextBackGround(0);
 GotoXY(2,4);  write(' Porto, 1993 ');
 GotoXY(2,6);  write(' T°tulo do programa               - BANCO');
 GotoXY(2,8);  write(' Programador                      - Nuno Costeira da Rocha');
 GotoXY(2,10); write(' Envio de correspondància para    - Nuno Costeira da Rocha');
 GotoXY(2,11); write('                                    R. AIROSA, 62 ');
 GotoXY(2,12); write('                                    4200 - PORTO  ');
 GotoXY(30,14); write(' -*- AVISO -*- ');
 GotoXY(2,16); write('  Esta versÑo publicada pela revista SPOOLER Ç dominio p£blico podendo ser ');
 GotoXY(2,17); write(' copiada e partes dela podem ser usadas por todos.  ');
 GotoXY(2,19); write('  Esta versÑo foi testada, contudo o autor nÑo se responsbiliza por qualquer');
 GotoXY(2,20); write(' perda motivada pela utilizaáÑo deste programa.  ');
 GotoXY(2,22); write(' DESEJO A TODOS UNS BONS SALDOS BANCÜRIOS !... ');
 Erros(0);
end;



Procedure L25_1;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' ',chr(24),chr(25),' - Muda OpáÑo   Alt-X - Sair   F1 - Autor...                                ');
 TextColor(CTIni);
 TextBackGround(CFIni);
 GotoXY(2,25);write(chr(24),chr(25));
 GotoXY(20,25);write('Alt-X');
 GoToXY(35,25);write('F1');
end;

Procedure L25_2;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' ',chr(24),chr(25),' - Muda OpáÑo   Esc - Menu Anterior   Alt-X - Sair                          ');
 TextColor(CTIni);
 TextBackGround(CFIni);
 GotoXY(2,25);write(chr(24),chr(25));
 GotoXY(20,25);write('Esc');
 GotoXY(42,25);write('Alt-X');
end;


Procedure L25_3;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' ',chr(24),chr(25),',<ƒŸ-Muda Campo  ',chr(26),chr(27),'-Movimenta-se Dentro do Campo  ',
 'Esc-Termina IntroduáÑo    ');
 TextColor(CTIni);
 TextBackGround(CFIni);
 GotoXY(2,25);write(chr(24),chr(25),',<ƒŸ');
 GotoXY(21,25);write(chr(26),chr(27));
 GotoXY(54,25);write('Esc');
end;

Procedure L25_4;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' ',chr(26),chr(27),'-Movimenta-se Dentro do Campo  Esc-Aborta IntroduáÑo  <ƒŸ-Termina e Grava   ');
 TextColor(CTIni);
 TextBackGround(CFIni);
 GotoXY(58,25);write('<ƒŸ');
 GotoXY(2,25);write(chr(26),chr(27));
 GotoXY(35,25);write('Esc');
end;


Procedure L25_5;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' ',chr(24),chr(25),'-Muda Campo  <ESPAÄO>-Muda OpáÑo   Esc-Aborta ConfiguraáÑo  <ƒŸ-Grava       ');
 TextColor(CTIni);
 TextBackGround(CFIni);
 GotoXY(2,25);write(chr(24),chr(25));
 GotoXY(17,25);write('<ESPAÄO>');
 GotoXY(39,25);write('Esc');
 GotoXY(64,25);write('<ƒŸ');
end;

Procedure L25_6;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' ',chr(26),chr(27),'-Movimenta-se Dentro do Campo  <ƒŸ-Termina IntroduáÑo e Continua            ');
 TextColor(CTIni);
 TextBackGround(CFIni);
 GotoXY(35,25);write('<ƒŸ');
 GotoXY(2,25);write(chr(26),chr(27));
end;

Procedure L25_7;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' Prima a tecla que determina a sua escolha (S-Sim, N-NÑo, A-Aborta)           ');
end;

Procedure L25_8;
begin
 TextColor(CTUltima);
 textBackGround(CFUltima);
 GotoXY(1,25);write(' ',chr(24),chr(25),'-Muda Campo  <ESPAÄO>-Muda OpáÑo   Esc-Termina IntroduáÑo                   ');
 TextColor(CTIni);
 TextBackGround(CFIni);
 GotoXY(2,25);write(chr(24),chr(25));
 GotoXY(17,25);write('<ESPAÄO>');
 GotoXY(39,25);write('Esc');
end;


Procedure CaixaS (X,Y,Z,H : integer);

Var

 t1,
 t2,
 i : integer;

Begin

  GotoXY (Z,Y); Write ('ø');
  GotoXY (X,H); Write ('¿');

  t1 := Z - (X + 1);

  For I := 1 to t1 do

   begin
    GotoXY (X+I,y);
    Write ('ƒ');
    GotoXy (X+I,h);
    write ('ƒ');
   end;


  t2 := H - (Y + 1);

  For I := 1 to t2 do

   begin
    GotoXY (x,y+I);
    write ('≥');
    GotoXy (z,y+I);
    write ('≥');

   end;


  GotoXY (X,Y); Write ('⁄');
  GotoXY (Z,H); Write ('Ÿ');
  GotoXy (x+1,y+1);

end; {*** Caixa S ****}

Procedure Inf(n : byte;var x : integer);

begin
 TextColor(CTInf);
 TextBackGround(CFInf);
 if n = 1 then
  case x of
    1 : begin
         GotoXY(1,24);
         write('Gravar, Ler, Renovar , Gravar Como, Ficheiros de conta                         ');
        end;
    2 : begin
         GotoXY(1,24);
         write('Editar, Corrigir, Apagar, Arranjar, Lanáamentos                                ');
        end;
    3 : begin
         GotoXY(1,24);
         write('Extrato, Saldo Actual, OrdenaáÑo por datas                                     ');
        end;
    4 : begin
         GotoXY(1,24);
         write('ConfiguraáÑo do Programa, Direct¢rio, Muda de Direct¢rio, Shell ao DOS         ');
        end;
    5 : begin
         GotoXY(1,24);
         write('Sair do Programa                                                               ');
        end;
  end;
 if n = 2 then
  case x of
    1 : begin
         GotoXY(1,24);
         write('Introduz os dados iniciais da nova conta que vai criar                         ');
        end;
    2 : begin
         GotoXY(1,24);
         write('Là a partir do disco uma conta j† gravada                                       ');
        end;
    3 : begin
         GotoXY(1,24);
         write('Muda os dados iniciais Ö conta actual                                          ');
        end;
    4 : begin
         GotoXY(1,24);
         write('Muda o nome e a PassWord Ö conta actual                                        ');
        end;
    5 : begin
         GotoXY(1,24);
         write('Retorna ao menu anterior                                                       ');
        end;
  end;
 if n = 3 then
  Case x of
    1 : begin
         GotoXY(1,24);
         write('Introduz todos os dados relativamente a um lanáamento                          ');
        end;
    2 : begin
         GotoXY(1,24);
         write('Corrige os dados relativos a um lanáamento                                     ');
        end;
    3 : begin
         GotoXY(1,24);
         write('Apaga um lanáamento do ficheiro                                                ');
        end;
    4 : begin
         GotoXY(1,24);
         write('Renumera os lanáamentos dentro do ficheiro                                     ');
        end;
    5 : begin
         GotoXY(1,24);
         write('Retorna ao menu anterior                                                       ');
        end;
  end;
 if n = 4 then
  Case x of
    1 : begin
         GotoXY(1,24);
         write('Apresenta o extracto da conta no ecran a partir da data selecionada             ');
        end;
    2 : begin
         GotoXY(1,24);
         write('Imprime o extracto a partir da data selecionada                                 ');
        end;
    3 : begin
         GotoXY(1,24);
         write('Apresenta o saldo disponivel actualmente                                       ');
        end;
    4 : begin
         GotoXY(1,24);
         write('Executa a ordenaáÑo dos lanáamentos pela sua data                              ');
        end;
    5 : begin
         GotoXY(1,24);
         write('Retorna ao menu anterior                                                       ');
        end;
  end;
 if n = 5 then
  Case x of
    1 : begin
         GotoXY(1,24);
         write('Configura o programa tornando-o mais personalizado                             ');
        end;
    2 : begin
         GotoXY(1,24);
         write('F†z uma listagem de todos os ficheiros que se encontram no directorio escolhido');
        end;
    3 : begin
         GotoXY(1,24);
         write('Muda o directorio de trabalho, de onde sÑo LIDOS e GRAVADOS os ficheiros       ');
        end;
    4 : begin
         GotoXY(1,24);
         write('OS Shell                                                                       ');
        end;
    5 : begin
         GotoXY(1,24);
         write('Retorna ao menu anterior                                                       ');
        end;
  end;
end;


Procedure OpPrincipais;
begin
 OpPrin[1]:=' 1 - Ficheiro            ';
 OpPrin[2]:=' 2 - Editar              ';
 OpPrin[3]:=' 3 - Serviáos            ';
 OpPrin[4]:=' 4 - Utils do Sistema    ';
 OpPrin[5]:=' 5 - Sair                ';
 OpPrin[6]:='';
 OpPrin[7]:='';
 OpPrin[8]:='';
 OpPrin[9]:='';
end;{OpPrincipais}

Procedure OpFicheiro;
begin
 OpPrin[1]:=' 1 - Nova Conta          ';
 OpPrin[2]:=' 2 - Là Conta            ';
 OpPrin[3]:=' 3 - Renova Conta        ';
 OpPrin[4]:=' 4 - Grava Como          ';
 OpPrin[5]:=' 5 - Menu Anterior       ';
 OpPrin[6]:='';
 OpPrin[7]:='';
 OpPrin[8]:='';
 OpPrin[9]:='';
end;{OpFicheiro}

Procedure OpEditar;
begin
 OpPrin[1]:=' 1 - Edita Lanáamento    ';
 OpPrin[2]:=' 2 - Corrige Lanáamento  ';
 OpPrin[3]:=' 3 - Apaga Lanáamento    ';
 OpPrin[4]:=' 4 - Arranja Lanáamentos ';
 OpPrin[5]:=' 5 - Menu Anterior       ';
 OpPrin[6]:='';
 OpPrin[7]:='';
 OpPrin[8]:='';
 OpPrin[9]:='';
end;{OpEditar}

Procedure OpServicos;
begin
 OpPrin[1]:=' 1 - Extrato - Ecran      ';
 OpPrin[2]:=' 2 - Extrato - Impressora ';
 OpPrin[3]:=' 3 - Saldo Actual         ';
 OpPrin[4]:=' 4 - Ordena por Datas     ';
 OpPrin[5]:=' 5 - Menu Anterior        ';
 OpPrin[6]:='';
 OpPrin[7]:='';
 OpPrin[8]:='';
 OpPrin[9]:='';
end;{OpServicos}

Procedure OpUtils;
begin
 OpPrin[1]:=' 1 - ConfiguraáÑo         ';
 OpPrin[2]:=' 2 - Directorio           ';
 OpPrin[3]:=' 3 - Muda Directorio      ';
 OpPrin[4]:=' 4 - OS Shell             ';
 OpPrin[5]:=' 5 - Menu Anterior        ';
 OpPrin[6]:='';
 OpPrin[7]:='';
 OpPrin[8]:='';
 OpPrin[9]:='';
end;{OpUtils   }

Procedure Desce(Coluna,MaxV,MinV:integer;var w:integer);
var
 z  : integer;

begin
 w := w+1;
 z := w-1;

 If w>MaxV then
  begin
   w:=MinV;
   z:=MaxV;
  end;
 TextColor(CTOpNao);
 TextBackGround(CFOpNao);
 GotoXY(Coluna,z+7);write(OpPrin[z]);
 TextColor(CTOpSim);
 TextBackGround(CFOpSim);
 GotoXY(Coluna,w+7);write(OpPrin[w]);
end;

Procedure Sobe(Coluna,MaxV,MinV:integer;var w:integer);
var
 z  : integer;

begin
 w := w-1;
 z := w+1;

 If w<MinV then
  begin
   z:=MinV;
   w:=MaxV;
  end;
 TextColor(CTOpNao);
 TextBackGround(CFOpNao);
 GotoXY(Coluna,z+7);write(OpPrin[z]);
 TextBackGround(CFOpSim);
 TextColor(CTOpSim);
 GotoXY(Coluna,w+7);write(OpPrin[w]);
end;
Procedure SobreSai(Coluna:integer;var Opcao:string;var w:integer);

begin
 TextBackGround(CFOpSim);
 TextColor(CTOpSim);
 GotoXY(Coluna,w+7);write(Opcao);
end;

Procedure CaixaF (X,Y,Z,H : integer);

Var

 t1,
 t2,
 i : integer;

Begin

  GotoXY (Z,Y); Write ('∏');
  GotoXY (X,H); Write ('¿');

  t1 := Z - (X + 1);

  For I := 1 to t1 do

   begin
    GotoXY (X+I,y);
    Write ('Õ');
    GotoXy (X+I,h);
    write ('ƒ');
   end;


  t2 := H - (Y + 1);

  For I := 1 to t2 do

   begin
    GotoXY (x,y+I);
    write ('≥');
    GotoXy (z,y+I);
    write ('≥');

   end;


  GotoXY (X,Y); Write ('’');
  GotoXY (Z,H); Write ('Ÿ');
  GotoXy (x+1,y+1);

end; {*** Caixa F ****}

Procedure Cabecalho;
begin
 TextColor(CTCabecalho);
 TextBackGround(CFCabecalho);
 GotoXY(1,1);write('                             * SOGMI - Dpt. PROGRAMAÄéO -*- Programa BANCO     ');
 GotoXY(1,1);write(' Conta Actual : ',NomeFicheiro);
end;

Procedure Menu;
begin
 TextBackGround(CFFundo);
 TextColor(CTFundo);
 Clrscr;
 Cabecalho;
 TextColor(CTOpNao);
 TextBackGround(CFOpNao);
 GotoXY(26,8); write (OpPrin[1]);
 GotoXY(26,9); write (OpPrin[2]);
 GotoXY(26,10);write (OpPrin[3]);
 GotoXY(26,11);write (OpPrin[4]);
 GotoXY(26,12);write (OpPrin[5]);
 GotoXY(26,13);write (OpPrin[6]);
 GotoXY(26,14);write (OpPrin[7]);
 GotoXY(26,15);write (OpPrin[8]);
 GotoXY(26,16);write (OpPrin[9]);
 TextColor(CTAvisos);
 TextBackGround(CFAvisos);
end;

Procedure MenuPrincipal;
begin
 OpPrincipais;
 Menu;
 SobreSai(26,OpPrin[VDesce],VDesce);
 Inf(1,Vdesce);
 L25_1;
end;

Procedure MenuFicheiros;
begin
 OpFicheiro;
 Menu;
 SobreSai(26,OpPrin[VDesceF],VDesceF);
 Inf(2,VdesceF);
 L25_2;
end;

Procedure MenuEditar;
begin
 OpEditar;
 Menu;
 SobreSai(26,OpPrin[VDesceE],VDesceE);
 Inf(3,VDesceE);
 L25_2;
end;

Procedure MenuServicos;
begin
 OpServicos;
 Menu;
 SobreSai(26,OpPrin[VDesceS],VDesceS);
 Inf(4,VDesceS);
 L25_2;
end;

Procedure MenuUtils;
begin
 OpUtils;
 Menu;
 SobreSai(26,OpPrin[VDesceU],VDesceU);
 Inf(5,VDesceU);
 L25_2;
end;

Procedure Erros (Erro : integer);
var
 a : char;
begin
 Case Erro of
    0 : begin
         TextColor(CTAvisos);
         TextBackGround(CFAvisos);
         GotoXY(1,25); write ('Qualquer tecla para continuar                                                  ');
         a:= readkey;
        end;
    2 : begin
         TextColor(CTErro);
         TextBackGround(CFErro);
         GotoXY (1,15); write (' ERRO 02 : NéO ENCONTRO FICHEIRO                                   ');
        end;
    3 : begin
         TextColor(CTErro);
         TextBackGround(CFErro);
         GotoXY (1,15); write (' ERRO 03 : ERRO DE ESCRITA\LEITURA                                 ');
        end;
    4 : begin
         TextColor(CTErro);
         TextBackGround(CFErro);
         GotoXY (1,15); write (' ERRO 04 : NéO SE ENCONTRA DIRECTORIO                              ');
        end;
    6 : begin
         TextColor(CTErro);
         TextBackGround(CFErro);
         GotoXY (1,15); write (' ERRO 06 : OPERAÄéO NéO EXECUTADA                                  ');
        end;
  100 : begin
         TextColor(CTErro);
         TextBackGround(CFErro);
         GotoXY(1,15); write (' ERRO FATAL - FICHEIRO DE CONFIGURAÄéO INEXISTENTE OU INVALIDO            ');
        end;
 end;
end;

FUNCTION ISFILE (var Nome :string):boolean;{ O Ficheiro existe ?......}

var
 fich : file of char;

begin

 {$I-}
   assign(fich,Nome);
   Reset(fich);
   Close(fich);
 {$I+}

 isfile := (IORESULT = 0);

end;

PROCEDURE SET_CURSOR(Cr:integer);

{ procedimento de definecao do tipo de cursor

     cr = $0800 .... $FFFF -- desaparece o cursor (no IBM -- $0909);
     cr = $0000 .... $0007 -- faz aparecer o cursor a partir da 1<- linha e de
                              altura 1 ... 8;
     cr = $0107 .... $0700 -- faz aparecer o cursor a partir da linha 1 ... 8,
                              com altura dependente do ultimo digito }

var result : registers;

begin
  with result do
    begin
      AX := $0100;
      CX := cr;
      intr ($10,result);
    end;

end;{***** SetCursor ****}



Procedure Inicio;
var
 a: char;

begin
 Set_Cursor($0800);
 TextColor(LightGray);
 TextBackGround(black);
 ClrScr;
 TextColor(Green);
 TextBackground(Blue);
 GotoXY(20,1); write('  SOGMI - INFORMATICA PROGRAMACAO  ');
 TextBackGround(Black);
 GotoXY(20,3); write('   Nuno Miguel Costeira da Rocha   ');
 GotoXY(20,4); write('            Porto - 1993           ');
 TextColor(Blue);
 GotoXY(1,7); write('      ‹‹‹‹‹‹‹                                                           ');
 GotoXY(1,8); write('      ‹‹    ‹‹                                                          ');
 GotoXY(1,9); write('      ‹‹     ‹‹                                                         ');
 GotoXY(1,10);write('      ‹‹    ‹‹                                                          ');
 GotoXY(1,11);write('      ‹‹‹‹‹‹‹‹‹         ‹‹‹‹‹‹      ‹‹    ‹‹         ‹‹‹‹‹     ‹‹‹‹‹    ');
 GotoXY(1,12);write('      ‹‹       ‹‹            ‹‹     ‹‹  ‹‹‹‹‹‹     ‹‹‹       ‹‹‹   ‹‹‹  ');
 GotoXY(1,13);write('      ‹‹        ‹‹     ‹‹‹‹‹‹‹‹‹    ‹‹‹‹     ‹‹   ‹‹        ‹‹       ‹‹ ');
 GotoXY(1,14);write('      ‹‹       ‹‹     ‹‹       ‹‹   ‹‹       ‹‹    ‹‹‹       ‹‹‹   ‹‹‹  ');
 GotoXY(1,15);write('      ‹‹‹‹‹‹‹‹‹‹       ‹‹‹‹‹‹‹‹‹    ‹‹       ‹‹      ‹‹‹‹‹     ‹‹‹‹‹    ');
 TextColor(LightBlue);
 GotoXY(1,20);write('                          O SEU GESTOR DE CONTA ');
 TextColor(LightGray);
 GotoXY(1,25); write ('Qualquer tecla para continuar');
 a:= readkey;
end; {******* INICIO *********}


Procedure up (Var s : string);


var
  a : String;
  y : integer;

begin
  y := 0;
  a := s;

  while pos ('a',a) > 0 do
   begin
    a [pos ('a',a)] := 'A';
    y := y+1;
   end;

  while pos ('b',a) > 0 do
   begin
    a [pos ('b',a)] := 'B';
    y := y+1;
   end;

  while pos ('c',a) > 0 do
   begin
    a [pos ('c',a)] := 'C';
    y := y+1;
   end;

  while pos ('d',a) > 0 do
   begin
    a [pos ('d',a)] := 'D';
    y := y+1;
   end;

  while pos ('e',a) > 0 do
   begin
    a [pos ('e',a)] := 'E';
    y := y+1;
   end;

  while pos ('f',a) > 0 do
   begin
    a [pos ('f',a)] := 'F';
    y := y+1;
   end;

  while pos ('g',a) > 0 do
   begin
    a [pos ('g',a)] := 'G';
    y := y+1;
   end;

  while pos ('h',a) > 0 do
   begin
    a [pos ('h',a)] := 'H';
    y := y+1;
   end;

  while pos ('i',a) > 0 do
   begin
    a [pos ('i',a)] := 'I';
    y := y+1;
   end;

  while pos ('j',a) > 0 do
   begin
    a [pos ('j',a)] := 'J';
    y := y+1;
   end;

  while pos ('k',a) > 0 do
   begin
    a [pos ('k',a)] := 'k';
    y := y+1;
   end;

  while pos ('l',a) > 0 do
   begin
    a [pos ('l',a)] := 'L';
    y := y+1;
   end;

  while pos ('m',a) > 0 do
   begin
    a [pos ('m',a)] := 'M';
    y := y+1;
   end;

  while pos ('n',a) > 0 do
   begin
    a [pos ('n',a)] := 'N';
    y := y+1;
   end;

  while pos ('o',a) > 0 do
   begin
    a [pos ('o',a)] := 'O';
    y := y+1;
   end;

  while pos ('p',a) > 0 do
   begin
    a [pos ('p',a)] := 'P';
    y := y+1;
   end;

  while pos ('q',a) > 0 do
   begin
    a [pos ('q',a)] := 'Q';
    y := y+1;
   end;

  while pos ('r',a) > 0 do
   begin
    a [pos ('r',a)] := 'R';
    y := y+1;
   end;

  while pos ('s',a) > 0 do
   begin
    a [pos ('s',a)] := 'S';
    y := y+1;
   end;

  while pos ('t',a) > 0 do
   begin
    a [pos ('t',a)] := 'T';
    y := y+1;
   end;

  while pos ('u',a) > 0 do
   begin
    a [pos ('u',a)] := 'U';
    y := y+1;
   end;

  while pos ('v',a) > 0 do
   begin
    a [pos ('v',a)] := 'V';
    y := y+1;
   end;

  while pos ('w',a) > 0 do
   begin
    a [pos ('w',a)] := 'W';
    y := y+1;
   end;

  while pos ('x',a) > 0 do
   begin
    a [pos ('x',a)] := 'X';
    y := y+1;
   end;

  while pos ('y',a) > 0 do
   begin
    a [pos ('y',a)] := 'Y';
    y := y+1;
   end;

  while pos ('z',a) > 0 do
   begin
    a [pos ('z',a)] := 'Z';
    y := y+1;
   end;

  s := a;

end; {**** UP ****}
end.