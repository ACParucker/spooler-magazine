{$M $4000,0,$4000}
Program Banco;

Uses
 Crt,Dos,printer,BancoTPU,Seguranca;

Procedure TiraEspacos(var a:string);
begin
while pos(' ',a)>0 do
delete(a,pos(' ',a),1);
end;

Procedure LimpaDI;
begin
NomeBanco:='';
Dependencia:='';
NumeroConta:='';
Titular:='';
SaldoInicial:='';
DataInicial:='';
PalavraChave:='';
end;

Procedure FichaDI;
begin
 GotoXY(1,25);ClrEol;
 GotoXY(1,23);ClrEol;
 GotoXY(1,24);ClrEol;
 TextColor(CTCabecalho);
 TextBackGround(CFCabecalho);
 Cabecalho;
 L25_3;
 TextColor(CTFichas);
 TextBackGround(CFFichas);
 CaixaS(1,2,79,12);
 GotoXY(2,4);write(' Nome Do Banco (X.X.X.)  - ',NomeBanco);
 GotoXY(2,5);write(' Dependencia             - ',Dependencia);
 GotoXY(2,6);write(' Numero de Conta         - ',NumeroConta);
 GotoXY(2,7);write(' Titular                 - ',Titular);
 GotoXY(2,8);write(' Saldo Inicial           - ',SaldoInicial);
 GotoXY(2,9);write(' Data Inicial (aaaammdd) - ',DataInicial);
 GotoXY(2,10);write(' PassWord                - ',PalavraChave);

end;

Procedure PerguntasDI;
begin
 case COORD of
  1 : begin
       st:=NomeBanco;
       Conta1:=length(NomeBanco);
       Escreve(1,6,29,4);
       NomeBanco:=st;
      end;
  2 : begin
       st:=Dependencia;
       Conta1:=length(Dependencia);
       Escreve(1,13,29,5);
       Dependencia:=st;
      end;
  3 : begin
       st:=NumeroConta;
       Conta1:=length(NumeroConta);
       Escreve(3,13,29,6);
       NumeroConta:=st;
      end;
  4 : begin
       st:=Titular;
       Conta1:=length(Titular);
       Escreve(1,30,29,7);
       Titular:=st;
      end;
  5 : begin
       st:=SaldoInicial;
       Conta1:=length(SaldoInicial);
       Escreve(4,10,29,8);
       SaldoInicial:=st;
      end;
  6 : begin
       st:=DataInicial;
       Conta1:=length(DataInicial);
       Escreve(2,8,29,9);
       DataInicial:=st;
      end;
  7 : begin
       st:=PalavraChave;
       Conta1:=Length(PalavraChave);
       Escreve(3,10,29,10);
       PalavraChave:=st;
      end;
 end;
end;

Procedure DescodificaDI;
begin
 NomeBanco:=FDesencripta(NomeBanco);
 Dependencia:=FDesencripta(Dependencia);
 NumeroConta:=FDesencripta(NumeroConta);
 Titular:=FDesencripta(Titular);
 SaldoInicial:=FDesencripta(SaldoInicial);
 DataInicial:=FDesencripta(DataInicial);
 PalavraChave:=FDesencripta(PalavraChave);
end;
Procedure CodificaDI;
begin
 NomeBanco:=FEncripta(NomeBanco);
 Dependencia:=FEncripta(Dependencia);
 NumeroConta:=FEncripta(NumeroConta);
 Titular:=FEncripta(Titular);
 SaldoInicial:=FEncripta(SaldoInicial);
 DataInicial:=FEncripta(DataInicial);
 PalavraChave:=FEncripta(PalavraChave);
end;

Procedure Le_Conta;
var
 Ficheiro       : string;
 a              : char;
 PalavraChavena : string;
 PalavraCorrecta: boolean;

begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 ClrScr;
 Cabecalho;
 L25_6;
 TextColor(CTPerguntas);
 TextBackGround(CFPerguntas);
 GotoXY (1,24); Write ('Nome do ficheiro - ');
 st:=NomeFicheiro;
 Conta1:=0;
 Escreve(3,8,19,24);
 up(st);
 NomeFicheiro:=st;
 If NomeFicheiro=''then NomeFicheiro:='SEM_NOME';
 Ficheiro:= concat(NomeFicheiro,'.DI');
 PalavraCorrecta:=False;
 TextColor(CTPerguntas);
 TextBackGround(CFPerguntas);
 GotoXY (1,24); write ('PassWord do ficheiro - ');
 st:=PalavraChavena;
 Conta1:=0;
 Escreve(3,10,23,24);
 PalavraChavena:=st;
 If IsFile(Ficheiro)and(NomeFicheiro<>'SEM_NOME') then
  begin
   {$I-}
   assign (FileCliente,Ficheiro);
   reset(FileCliente);
   readln(FileCliente,NomeBanco);
   readln(FileCliente,Dependencia);
   readln(FileCliente,NumeroConta);
   readln(FileCliente,Titular);
   readln(FileCliente,SaldoInicial);
   readln(FileCliente,DataInicial);
   readln(FileCliente,PalavraChave);
   readln(fileCliente,NumeroLancamento);
   close(FileCliente);
   If Encripta then DescodificaDI;
   {$I+}
   If IORESULT <> 0 then
    Begin
     Erros(3);
     Erros(0);
     NomeFicheiro:='SEM_NOME';
     MenuFicheiros;
     Exit;
    end;
   If PalavraChavena=PalavraChave then
    begin
     TextColor(CTAvisos);
     TextBackGround(CFAvisos);
     GotoXY(1,23); write ('PassWord Correcta');
     PalavraCorrecta:=true;
    end
   else
    begin
     TextColor(CTErro);
     TextBackGround(CFErro);
     GotoXY(1,23);write(' PassWord Incorrecta ');
     Erros(0);
     PalavraCorrecta:=False;
     NomeFicheiro:='SEM_NOME';
    end;
   end
  else
   Begin
    NomeFicheiro:='SEM_NOME';
    if (IsFile(Ficheiro)=False)and(NomeFicheiro<>'SEM_NOME') then Erros(2) else Erros(6);
    Erros(0);
  end;
 MenuFicheiros;
end;{Le Conta}


Procedure Renova_Conta;
var
 Ficheiro    : string;
 Outra       : string;
 Ch          : char;
 PalavraChavena : string;
 PalavraCorrecta: boolean;

begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 Clrscr;
 Cabecalho;
 L25_6;
 TextColor(CTPerguntas);
 TextBackGround(CFPerguntas);
 PalavraCorrecta:=False;
 Ficheiro:= concat(NomeFicheiro,'.DI');
 GotoXY (1,24); write (' PassWord do ficheiro - ');
 st:=PalavraChavena;
 Conta1:=0;
 Escreve(3,10,24,24);
 PalavraChavena:=st;
 {$I-}
 assign (FileCliente,Ficheiro);
 reset(FileCliente);
 readln(FileCliente,NomeBanco);
 readln(FileCliente,Dependencia);
 readln(FileCliente,NumeroConta);
 readln(FileCliente,Titular);
 readln(FileCliente,SaldoInicial);
 readln(FileCliente,DataInicial);
 readln(FileCliente,PalavraChave);
 readln(fileCliente,NumeroLancamento);
 close(FileCliente);
 If Encripta then DescodificaDI;
 {$I+}
 If IORESULT <> 0 then
  Begin
   Erros(3);
   Erros(0);
   MenuFicheiros;
   Exit;
  end;
 If PalavraChave=PalavraChavena then
  begin
   TextColor(CTAvisos);
   TextBackGround(CFAvisos);
   GotoXY(1,23); write ('PassWord Correcta');
   PalavraCorrecta:=true;
  end
 else
  begin
   TextColor(CTAvisos);
   TextBackGround(CFAvisos);
   GotoXY(1,23);write('PassWord Incorrecta');
   PalavraCorrecta:=False;
  end;
 If PalavraCorrecta then
  begin
   FichaDI;
   GotoXY(2,2);write(' RenovaáÑo dos Dados Iniciais ');
   COORD:=1;
   Maximo :=7;
   Minimo :=1;
   repeat
    PerguntasDI;
   until (cha=#27);
   L25_7;
   TextColor(CTPerguntas);
   TextBackGround(CFPerguntas);
   GotoXY(1,24); write(' Deseja prosseguir com a renovaáÑo de dados (S\n) ? - ');
   ch :=upcase( readkey);
   If ch<>'N' then
    begin
     {$I-}
     assign (FileCliente,Ficheiro);
     If Encripta then CodificaDI;
     rewrite(FileCliente);
     append(FileCliente);
     writeln(FileCliente,NomeBanco);
     writeln(FileCliente,Dependencia);
     writeln(FileCliente,NumeroConta);
     writeln(FileCliente,Titular);
     writeln(FileCliente,SaldoInicial);
     writeln(FileCliente,DataInicial);
     writeln(fileCliente,PalavraChave);
     writeln(FileCliente,NumeroLancamento);
     close(FileCliente);
     {$I+}
     If IORESULT <> 0 then
      Begin
       Erros(3);
       Erros(0);
       MenuFicheiros;
       Exit;
      end;
    end;
  end;
 MenuFicheiros;
end;{Renova Conta}


Procedure Nova_Conta;
var
 Ficheiro    : string;
 Outra       : string;
 Ch          : char;
 Sai         : boolean;
 NomeCorrecto: boolean;

begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 Clrscr;
 LimpaDI;
 FichaDI;
 TextColor(CTFichas);
 TextBackGround(CFFichas);
 GotoXY(2,2);write(' IntroduáÑo dos Dados Iniciais ');
 COORD:=1;
 Maximo :=7;
 Minimo :=1;
 repeat
  PerguntasDI;
 until (cha=#27);
 Sai := False;
 NomeCorrecto:=False;
 repeat
  L25_4;
  TextBackGround(CFFundo);
  GotoXY(1,24);ClrEol;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24);write (' Nome para o ficheiro desta conta - ');
  st:=NomeFicheiro;
  Conta1:=0;
  Escreve(3,8,37,24);
  up(st);
  NomeFicheiro:=st;
  If NomeFicheiro='' then NomeFicheiro:='SEM_NOME';
  Ficheiro:= concat(NomeFicheiro,'.DI');
  if IsFile (Ficheiro)and(NomeFicheiro<>'SEM_NOME') then Sai:=False
    else
     begin
      If NomeFicheiro<>'SEM_NOME' then NomeCorrecto:=True else NomeCorrecto:=False;
      Sai := true;
     end;
  if Sai=False then
   Begin
    TextColor(CTErro);
    TextBackGround(CFErro);
    GotoXY(1,23); write (' Erro 7 : Ficheiro j† existente ');
    L25_7;
    TextColor(CTPerguntas);
    TextBackGround(CFPerguntas);
    GotoXY (1,24); Write (' Quer dar novo nome (S\n\a)? -             ');
    Ch := readkey;
    if (ch='N')or(ch='n') then
     begin
      Sai := true;
      NomeCorrecto:=True;
     end;
    if (ch='A')or(ch='a') then
     begin
      Sai := True;
      NomeCorrecto := False;
      NomeFicheiro:='SEM_NOME';
     end;
   end;
 until Sai=true;
 If NomeCorrecto and(NomeFicheiro<>'SEM_NOME')then
  begin
   {$I-}
   NumeroLancamento:=0;
   assign (FileCliente,Ficheiro);
   If Encripta then CodificaDI;
   rewrite(FileCliente);
   append(FileCliente);
   writeln(FileCliente,NomeBanco);
   writeln(FileCliente,Dependencia);
   writeln(FileCliente,NumeroConta);
   writeln(FileCliente,Titular);
   writeln(FileCliente,SaldoInicial);
   writeln(FileCliente,DataInicial);
   writeln(fileCliente,PalavraChave);
   writeln(FileCliente,NumeroLancamento);
   close(FileCliente);
   Ficheiro:=Concat(NomeFicheiro,'.MOV');
   Assign(FileConta,Ficheiro);
   Rewrite(FileConta);
   Close(FileConta);
   {$I+}
   If IORESULT <> 0 then
    Begin
     Erros(3);
     Erros(0);
     NomeFicheiro:='SEM_NOME';
     MenuFicheiros;
     Exit;
    end;
  end;
 MenuFicheiros;
end;{Nova Conta}



Procedure Renova_Nome(var NomeAntigo,NovoNome:string);
var
 FileAux : text;
 Ficheiro: string;

begin
 ficheiro := concat(NomeAntigo,'.MOV');
 assign(FileConta,Ficheiro);
 ficheiro := concat(NovoNome,'.MOV');
 assign(FileAux,Ficheiro);
 {$I-}
 reset(FileConta);
 rewrite(FileAux);
 append(FileAux);
 while not EOF(FileConta) do
  begin
   readln(FileConta,CredV);
   readln(FileConta,DataLancamento);
   readln(FileConta,ReferenciaLancamento);
   readln(FileConta,DescricaoLancamento);
   readln(FileConta,ValorLancamento);
   readln(FileConta,NumeroLancamento);
   writeln(FileAux,CredV);
   writeln(FileAux,DataLancamento);
   writeln(FileAux,ReferenciaLancamento);
   writeln(FileAux,DescricaoLancamento);
   writeln(FileAux,ValorLancamento);
   writeln(FileAux,NumeroLancamento);
  end;
 close  (FileConta);
 close  (FileAux);
 {$I+}
 If IORESULT <> 0 then
  begin
   Erros(3);
   Erros(0);
   MenuEditar;
   Exit;
  end;

end;{Renova_Nome}


Procedure Grava_Como;
var
 Ficheiro       : string;
 NovoNome       : string;
 AntigoNome     : string;
 a              : char;
 PalavraChavena : string;
 PalavraCorrecta: boolean;
 Sai,
 NomeCorrecto   : boolean;

begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 ClrScr;
 Cabecalho;
 L25_6;
 TextColor(CTPerguntas);
 TextBackGround(CFPerguntas);
 PalavraCorrecta:=False;
 GotoXY (1,24); write (' PassWord do ficheiro - ');
 st:=PalavraChavena;
 Conta1:=0;
 Escreve(3,10,24,24);
 PalavraChavena:=st;
 AntigoNome:=NomeFicheiro;
 Ficheiro:= concat(NomeFicheiro,'.DI');
 {$I-}
 assign (FileCliente,Ficheiro);
 reset(FileCliente);
 readln(FileCliente,NomeBanco);
 readln(FileCliente,Dependencia);
 readln(FileCliente,NumeroConta);
 readln(FileCliente,Titular);
 readln(FileCliente,SaldoInicial);
 readln(FileCliente,DataInicial);
 readln(FileCliente,PalavraChave);
 readln(fileCliente,NumeroLancamento);
 close(FileCliente);
 If Encripta then DescodificaDI;
 {$I+}
 If IORESULT <> 0 then
  Begin
   Erros(3);
   Erros(0);
   MenuFicheiros;
   Exit;
  end;
 If PalavraChave=PalavraChavena then
  begin
   TextColor(CTAvisos);
   TextBackGround(CFAvisos);
   GotoXY(1,23); write ('PassWord Correcta');
   PalavraCorrecta:=true;
   L25_7;
   TextColor(CTPerguntas);
   TextBackGround(CFPerguntas);
   GotoXY(1,24); write (' Pretende dar nova PassWord (S\n)? - ');
   Set_Cursor($0607);
   a:=upcase(readkey);
   Set_Cursor($0800);
   if a<>'N' then
    begin
     TextColor(CtFundo);
     TextBackGround(CFFundo);
     GotoXY(1,25);ClrEol;
     GotoXY(1,24);ClrEol;
     L25_6;
     TextColor(CTPerguntas);
     TextBackGround(CFPerguntas);
     GotoXY (1,24); write (' Nova PassWord do ficheiro - ');
     st:=PalavraChave;
     Conta1:=0;
     Escreve(3,10,29,24);
     PalavraChave:=st;
    end;
  end
 else
  begin
   TextColor(CTFundo);
   TextBackGround(CFFundo);
   GotoXY(1,24);ClrEol;
   TextColor(CTAvisos);
   TextBackGround(CFAvisos);
   GotoXY(1,24);write('PassWord Incorrecta');
   Erros(6);
   Erros(0);
   PalavraCorrecta:=False;
  end;
 If PalavraCorrecta then
  begin
   Sai:=False;
   NomeCorrecto:=False;
   repeat
    L25_6;
    TextColor(CtFundo);
    TextBackGround(CFFundo);
    GotoXY(1,23);ClrEol;
    GotoXY(1,24);ClrEol;
    TextColor(CTPerguntas);
    TextBackGround(CFPerguntas);
    GotoXY (1,24); write ('Novo nome para o ficheiro - ');
    st:=NomeFicheiro;
    Conta1:=0;
    Escreve(3,8,29,24);
    up(st);
    NomeFicheiro:=st;
    If NomeFicheiro='' then NomeFicheiro:='SEM_NOME';
    Ficheiro:= concat(NomeFicheiro,'.DI');
    if IsFile (Ficheiro)and(NomeFicheiro<>'SEM_NOME') then Sai:=False
      else
       begin
        If (NomeFicheiro<>'SEM_NOME') then NomeCorrecto:=True else NomeCorrecto:=False;
        Sai := true;
       end;
    if Sai=False then
     Begin
      TextColor(CTErro);
      TextBackGround(CFErro);
      GotoXY(1,23); write ('Erro 7 : Ficheiro j† existente ');
      L25_7;
      TextColor(CTFundo);
      TextBackGround(CFFundo);
      GotoXY(1,24);ClrEol;
      TextColor(CTPerguntas);
      TextBackGround(CFPerguntas);
      GotoXY (1,24); Write ('Quer dar novo nome (S\n\a)? - ');
      Set_Cursor($0607);
      a := readkey;
      Set_Cursor($0800);
      if (a='N')or(a='n') then
       begin
        Sai := true;
        NomeCorrecto:=True;
       end;
      if (a='A')or(a='a') then
       begin
        Sai := True;
        NomeCorrecto := False;
       end;
     end;
   until Sai=true;
   NovoNome:=NomeFicheiro;
   If (NomeCorrecto=true)and(NomeFicheiro<>'SEM_NOME')then
    begin
     {$I-}
     assign (FileCliente,Ficheiro);
     If Encripta then DescodificaDI;
     rewrite(FileCliente);
     append(FileCliente);
     writeln(FileCliente,NomeBanco);
     writeln(FileCliente,Dependencia);
     writeln(FileCliente,NumeroConta);
     writeln(FileCliente,Titular);
     writeln(FileCliente,SaldoInicial);
     writeln(FileCliente,DataInicial);
     writeln(fileCliente,PalavraChave);
     writeln(FileCliente,NumeroLancamento);
     close(FileCliente);
     Renova_Nome(AntigoNome,NovoNome);
     {$I+}
     If IORESULT <> 0 then
      Begin
       Erros(3);
       Erros(0);
       MenuFicheiros;
       Exit;
      end;
    end;
  end;
 MenuFicheiros;
end;{Grava Como}


Procedure FicheiroManeger;
var
 carater : char;
 sairF   : boolean;

begin
 sairF:=False;
 MenuFicheiros;
 Repeat
  repeat
   zero := False;
   carater := readkey;
   if carater =#0 then
    begin
     zero := True;
     carater := readkey;
    end;
  until (carater='1')or(carater='2')or(carater='3')or(carater='4')or(carater='5')or(carater='6')or(carater='7')or
  {***Cont linha **}(carater='8')or(carater='9')or(carater='0')or(carater=#45)or(carater=#27)or(carater=#72)
  {cont} and(zero=true)or(carater=#80)and(zero=true)or(carater=#13);
 case carater of
   #72 : Sobe(26,5,1,VDesceF);
   #80 : Desce(26,5,1,VDesceF);
   #13 : case VDesceF of
          1 : Nova_Conta;
          2 : Le_Conta;
          3 : if NomeFicheiro<>'SEM_NOME' then Renova_Conta;
          4 : if NomeFicheiro<>'SEM_NOME' then Grava_Como;
          5 : SairF:=True;
         end;
   #27 : SairF:=True;
   #45 : Sair :=True;
   '1' : Nova_Conta;
   '2' : Le_Conta;
   '3' : if NomeFicheiro<>'SEM_NOME' then Renova_Conta;
   '4' : if NomeFicheiro<>'SEM_NOME' then Grava_Como;
   '5' : SairF:=True;
 end;
 Inf(2,VDesceF);
 until SairF or Sair;
 MenuPrincipal;

end;



{  -*- SOGMI - INFORMÜTICA - NUNO COSTEIRA DA ROCHA -*- }



Procedure LimpaEditar;
begin
 DataLancamento       :='';
 ReferenciaLancamento :='';
 DescricaoLancamento  :='';
 ValorLancamento      :='';
end;{**** Limpa Editar *******}

Procedure FichaLan;
begin
  TextColor(CTFundo);
  TextBackGround(CFFundo);
  Clrscr;
  L25_3;
  Cabecalho;
  TextColor(CTFichas);
  TextBackGround(CFFichas);
  CaixaS(1,2,80,9);
  GotoXY(2,2); write(' Editar o lanáamento n£mero - ',NumeroLancamento,'  ');
  GotoXY(2,3); write(' Data (aaaammdd)         - ',DataLancamento);
  GotoXY(2,4); write(' Referància              - ',ReferenciaLancamento);
  GotoXY(2,5); write(' DescriáÑo               - ',DescricaoLancamento);
  GotoXY(2,6); write(' Valor                   - ',ValorLancamento);
  GotoXY(2,7); write(' Lanáamento de           - ',CredV);
end;

Procedure PerguntasLan;
var
 duas    :boolean;
 a       :char;
begin
 case COORD of
  1 : begin
       repeat
        Conta1:=length(DataLancamento);
        st:=DataLancamento;
        Escreve(2,8,29,3);
       until Length(st)=8;
       DataLancamento:=st;
      end;
  2 : begin
       st:=ReferenciaLancamento;
       Conta1:=length(ReferenciaLancamento);
       Escreve(1,10,29,4);
       ReferenciaLancamento:=st;
      end;
  3 : begin
       st:=DescricaoLancamento;
       Conta1:=length(DescricaoLancamento);
       Escreve(3,20,29,5);
       DescricaoLancamento:=st;
      end;
  4 : begin
       st:=ValorLancamento;
       Conta1:=length(ValorLancamento);
       Escreve(4,10,29,6);
       ValorLancamento:=st;
      end;
  5 : begin
       L25_8;
       TextColor(CTFichas);
       TextBackGround(CFFichas);
       Set_Cursor($0607);
       GotoXY(28,7);
       repeat
        a:=readkey;
        case a of
         #32 : begin
                duas := true;
                if CredV = 'CRêDITO' then
                  begin
                   CredV :='DêBITO';
                   GotoXY(29,7); write ('DêBITO ');
                   GotoXY(29,7);
                   duas :=false;
                  end;
                if (CredV = 'DêBITO') and duas then
                  begin
                   CredV :='CRêDITO';
                   GotoXY(29,7); write('CRêDITO');
                   GotoXY(29,7);
                  end;
               end;
         #13 : COORD :=1;
         #72 : COORD :=4;
         #80 : COORD :=1;
         #27 : Cha := #27;
        end;
       until (a=#13)or(a=#27)or(a=#72)or(a=#80);
       Set_Cursor($0800);
       L25_3;
       TextColor(CTFichas);
       TextBackGround(CFFichas);
      end;

 end; {Case}
end; {Perguntas}


Procedure Lancamentos_Apaga;

var
 a          : char;
 NumRegisto : word;
 NumII      : word;
 code       : integer;
 ficheiro   : string;
 FileAux    : text;
 Erro       : integer;

begin
 repeat
  TextColor(CTFundo);
  TextBackGround(CFFundo);
  Clrscr;
  Cabecalho;
  L25_6;
  TextBackGround(CFFundo);
  GotoXY(1,24);ClrEol;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24);write(' Nß lanáamento a apagar - ');
  Conta1:=0;
  Escreve(4,4,27,24);
  val(st,NumRegisto,code);
  L25_7;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24);write(' Deseja mesmo apagar (N\s) ? - ');
  Set_Cursor($0607);
  a:=upcase(readkey);
  Set_Cursor($0800);
  If a='S' then
   begin
    {$I-}
    Ficheiro:= concat(NomeFicheiro,'.APA');
    Assign(FileAux,Ficheiro);
    Ficheiro:= concat(NomeFicheiro,'.MOV');
    Assign(FileConta,Ficheiro);
    Reset(FileConta);
    Rewrite(FileAux);
    Append(FileAux);
    {$I+}
    if IOResult <> 0 then
     begin
      Erros(6);
      Erros(0);
      MenuEditar;
      Exit;
     end;
    {$I-}
    repeat
     readln(FileConta,CredV);
     readln(FileConta,DataLancamento);
     readln(FileConta,ReferenciaLancamento);
     readln(FileConta,DescricaoLancamento);
     readln(FileConta,ValorLancamento);
     readln(FileConta,NumII);
     If NumII <> NumRegisto then
      begin
       writeln(FileAux,CredV);
       writeln(FileAux,DataLancamento);
       writeln(FileAux,ReferenciaLancamento);
       writeln(FileAux,DescricaoLancamento);
       writeln(FileAux,ValorLancamento);
       writeln(FileAux,NumII);
      end;
    until EOF(FileConta);
    Close(FileConta);
    Close(FileAux);
    Erase(FileConta);
    Rename(FileAux,Ficheiro);
    {$I+}
    if IoResult <> 0 then
     begin
      Erros(6);
      Erros(0);
      Exit;
     end;
   end; { Proc Apagar }
  L25_7;
  TextBackGround(CFFundo);
  GotoXY(1,24);ClrEol;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24); write(' Deseja apagar outro lanáamento (S\n) ? - ');
  Set_Cursor($0607);
  a := upcase(readkey);
  Set_Cursor($0800);
 until a='N';
 MenuEditar;
end;{**** Lancamentos Apaga ****}

Procedure Lancamentos_Arranjo;
var
 FileAux : text;
 I       : integer;
 Ficheiro:string;

begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 Clrscr;
 Cabecalho;
 TextColor(CTAvisos);
 TextBackGround(CFAvisos);
 GotoXY(1,15); write (' INICIO DO ARRANJO');
 ficheiro := concat(NomeFicheiro,'.MOV');
 assign(FileConta,Ficheiro);
 assign(FileAux,'BANCO.APA');
 {$I-}
 reset(FileConta);
 rewrite(FileAux);
 append(FileAux);
 I:= 0;
 while not EOF(FileConta) do
  begin
   inc(I);
   readln(FileConta,CredV);
   readln(FileConta,DataLancamento);
   readln(FileConta,ReferenciaLancamento);
   readln(FileConta,DescricaoLancamento);
   readln(FileConta,ValorLancamento);
   readln(FileConta,NumeroLancamento);
   writeln(FileAux,CredV);
   writeln(FileAux,DataLancamento);
   writeln(FileAux,ReferenciaLancamento);
   writeln(FileAux,DescricaoLancamento);
   writeln(FileAux,ValorLancamento);
   writeln(FileAux,I);
  end;
 close  (FileConta);
 close  (FileAux);
 Erase(FileConta);
 Rename(FileAux,Ficheiro);
 {$I+}
 If IORESULT <> 0 then
  begin
   Erros(3);
   Erros(0);
   MenuEditar;
   Exit;
  end;
 NumeroLancamento:=I;
 {$I-}
 Ficheiro:=concat(NomeFicheiro,'.DI');
 assign (FileCliente,Ficheiro);
 rewrite(FileCliente);
 append(FileCliente);
 writeln(FileCliente,NomeBanco);
 writeln(FileCliente,Dependencia);
 writeln(FileCliente,NumeroConta);
 writeln(FileCliente,Titular);
 writeln(FileCliente,SaldoInicial);
 writeln(FileCliente,DataInicial);
 writeln(fileCliente,PalavraChave);
 writeln(FileCliente,NumeroLancamento);
 close(FileCliente);
 {$I+}
 If IOresult <> 0 then
  begin
   Erros(3);
   Erros(0);
   MenuEditar;
   Exit;
  end;
 TextColor(CTAvisos);
 TextBackGround(CFAvisos);
 GotoXY(1,15); write (' ARRANJO COMPLETO ');
 Erros(0);
 MenuEditar;

end;{Lancamentos_ARRANJO}

Procedure Lancamentos_Corrige;

var
 a                      : char;
 NumRegisto             : integer;
 code                   : integer;
 ficheiro               : string;
 CredVII                ,
 DataLancamentoII       ,
 ReferenciaLancamentoII ,
 DescricaoLancamentoII  ,
 ValorLancamentoII      : String;
 NumeroLancamentoII     : integer;
 FileAux                : text;

begin
 Repeat
  TextColor(CTFundo);
  TextBackGround(CFFundo);
  Clrscr;
  Cabecalho;
  L25_6;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24);write(' Nß do lanáamento - ');
  Conta1:=0;
  Escreve(2,4,21,24);
  val(st,NumRegisto,code);
  ficheiro := concat(NomeFicheiro,'.MOV');
  If Isfile(Ficheiro) then
   begin
    {$I-}
    Assign(FileConta,Ficheiro);
    Reset(FileConta);
    while(not Eof(FileConta))and(NumeroLancamento<>NumRegisto) do
     begin
      readln(FileConta,CredV);
      readln(FileConta,DataLancamento);
      readln(FileConta,ReferenciaLancamento);
      readln(FileConta,DescricaoLancamento);
      readln(FileConta,ValorLancamento);
      readln(FileConta,NumeroLancamento);
     end;{while}
    {$I+}
    If IORESULT <> 0 then
     begin
      Erros(3);
      Erros(0);
      MenuEditar;
      Exit;
     end;{ioresult}
    if NumeroLancamento<>NumRegisto then
     begin
      TextColor(CTErro);
      TextBackGround(CFErro);
      GotoXY(1,23);write(' NÑo Encontro Esse Lanáamento ');
     end {if}
    else
     begin
      FichaLan;
      COORD:=1;
      Maximo :=5;
      Minimo :=1;
      repeat
       PerguntasLan;
      until (cha=#27);
      Ficheiro := Concat(NomeFicheiro,'.APA');
      {$I-}
      Assign(FileAux,Ficheiro);
      Rewrite(FileAux);
      Append(FileAux);
      Reset(FileConta);
      Repeat
       readln(FileConta,CredVII);
       readln(FileConta,DataLancamentoII);
       readln(FileConta,ReferenciaLancamentoII);
       readln(FileConta,DescricaoLancamentoII);
       readln(FileConta,ValorLancamentoII);
       readln(FileConta,NumeroLancamentoII);
       If NumeroLancamentoII=NumeroLancamento then
        begin
         writeln(FileAux,CredV);
         writeln(FileAux,Datalancamento);
         writeln(FileAux,ReferenciaLancamento);
         writeln(FileAux,DescricaoLancamento);
         writeln(FileAux,ValorLancamento);
         writeln(FileAux,NumeroLancamento);
        end {if}
       else
        begin
         writeln(FileAux,CredVII);
         writeln(FileAux,DatalancamentoII);
         writeln(FileAux,ReferenciaLancamentoII);
         writeln(FileAux,DescricaoLancamentoII);
         writeln(FileAux,ValorLancamentoII);
         writeln(FileAux,NumeroLancamentoII);
        end;{else}
      until EOF(FileConta);
      {$I+}
      If IORESULT<>0 then
       begin
        Erros(3);
        Erros(0);
        MenuEditar;
        Exit;
       end;
     end;
   end
  else
   begin
    Erros(2);
    Erros(0);
    MenuEditar;
    Exit;
   end;
  {$I-}
  Close(FileConta);
  Close(FileAux);
  Erase(FileConta);
  Ficheiro:=concat(NomeFicheiro,'.MOV');
  Rename(FileAux,Ficheiro);
  {$I+}
  If IOResult <> 0 then
   begin
    Erros(0);
    Erros(3);
    MenuEditar;
    Exit;
   end;
  TextBackGround(CfFundo);
  GotoXY(1,24);ClrEol;
  L25_7;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24); write(' Deseja corrigir outro lanáamento (S\n) ? - ');
  Set_Cursor($0607);
  a := upcase(readkey);
  Set_Cursor($0800);
 Until a='N';
 MenuEditar;
end;{****Lancamentos Corrige****}

Procedure Lancamentos_Editar;
var
 Ficheiro :string;
 a        :char;
begin
 Repeat
  LimpaEditar;
  inc(NumeroLancamento);
  CredV:='CRêDITO';
  FichaLan;
  COORD:=1;
  Maximo :=5;
  Minimo :=1;
  repeat
   PerguntasLan;
  until (cha=#27);
  ficheiro := concat(NomeFicheiro,'.MOV');
  {$I-}
  assign (FileConta,Ficheiro);
  reset  (FileConta);
  append (FileConta);
  writeln(FileConta,CredV);
  writeln(FileConta,DataLancamento);
  writeln(FileConta,ReferenciaLancamento);
  writeln(FileConta,DescricaoLancamento);
  writeln(FileConta,ValorLancamento);
  writeln(fileconta,NumeroLancamento);
  close  (FileConta);
  {$I+}
  If IORESULT <> 0 then
   Begin
    Erros(3);
    Erros(0);
   end;
  L25_7;
  TextBackGround(CFFundo);
  GotoXY(1,24);ClrEol;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24); write (' Deseja editar novo lanáamento (S\n) ? - ');
  Set_Cursor($0607);
  a:=upcase(readkey);
  Set_Cursor($0800);
 until a='N';
 {$I-}
 Ficheiro:=concat(NomeFicheiro,'.DI');
 assign (FileCliente,Ficheiro);
 rewrite(FileCliente);
 append(FileCliente);
 writeln(FileCliente,NomeBanco);
 writeln(FileCliente,Dependencia);
 writeln(FileCliente,NumeroConta);
 writeln(FileCliente,Titular);
 writeln(FileCliente,SaldoInicial);
 writeln(FileCliente,DataInicial);
 writeln(fileCliente,PalavraChave);
 writeln(FileCliente,NumeroLancamento);
 close(FileCliente);
 {$I+}
 If IOresult <> 0 then
  begin
   Erros(3);
   Erros(0);
  end;
 MenuEditar;
end;{****** Lancamentos Editar ***}


Procedure EditarManeger;
var
 carater : char;
 sairE   : boolean;

begin
 sairE:=False;
 MenuEditar;
 Repeat
  repeat
   zero := False;
   carater := readkey;
   if carater =#0 then
    begin
     zero := True;
     carater := readkey;
    end;
  until (carater='1')or(carater='2')or(carater='3')or(carater='4')or(carater='5')or(carater='6')or(carater='7')or
  {***Cont linha **}(carater='8')or(carater='9')or(carater='0')or(carater=#45)or(carater=#27)or(carater=#72)
  {cont} and(zero=true)or(carater=#80)and(zero=true)or(carater=#13);
 case carater of
   #72 : Sobe(26,5,1,VDesceE);
   #80 : Desce(26,5,1,VDesceE);
   #13 : case VDesceE of
          1 : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Editar;
          2 : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Corrige;
          3 : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Apaga;
          4 : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Arranjo;
          5 : SairE:=True;
         end;
   #27 : SairE:=True;
   #45 : Sair :=True;
   '1' : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Editar;
   '2' : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Corrige;
   '3' : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Apaga;
   '4' : if NomeFicheiro<>'SEM_NOME' then Lancamentos_Arranjo;
   '5' : SairE:=True;
 end;
 Inf(3,VDesceE);
 until SairE or Sair;
 If Ordena and (NomeFicheiro<>'SEM_NOME')then Ordena_Data;
 MenuPrincipal;

end;



Procedure ExtratoImpressora;
var
  Y       :byte;
  Numero  :integer;
  Ficheiro:string;
  Saldo   :single;
  SaldoInicialInt:single;
  ValorLancamentoInt:single;
  Data    :string;
  DataLL  :longint;
  DataI   :longint;
Begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 ClrScr;
 Cabecalho;
 Data := '00000000';
 L25_6;
 TextColor(CTPerguntas);
 TextBackGround(CFPerguntas);
 GotoXY(1,24); write(' Apartir da data (aaaammdd) - ',Data);
 repeat
  Conta1:=length(Data);
  st:=Data;
  Escreve(2,8,31,24);
 until (length(st)=8)and(cha = #13);
 Data := st;
 val(Data,DataI,numero);
 {$I-}
 writeln(lst,'');
 {$I+}
 If IORESULT = 0 then
  begin
   Saldo := 0;
   writeln(lst,'Conta nß ',NumeroConta,' do banco ',NomeBanco,' da dependància ',Dependencia);
   writeln(lst,'Titular ',Titular,'   Data de abertura - ',copy(DataInicial,0,4),'/',copy(DataInicial,5,2),'/',
   {Cont Linha} copy(DataInicial,7,2));
   writeln (lst,'  ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ');
   writeln (lst,'   Data      | Referància | DÇbito        | CrÇdito      | Saldo          | Lanc ');
   val(SaldoInicial,SaldoInicialInt,Numero);
   Saldo := Saldo+SaldoInicialInt;
   Ficheiro := concat(NomeFicheiro,'.MOV');
   If IsFile(Ficheiro) then
    begin
     assign (FileConta,Ficheiro);
     {$I-}
     reset(FileConta);
     {$I+}
     If IORESULT <> 0 then
      Begin
       Erros(3);
       Erros(0);
       MenuServicos;
       Exit;
      end;
     repeat
      {$I-}
      readln  (FileConta,CredV);
      readln  (FileConta,DataLancamento);
      Val(DataLancamento,DataLL,Numero);
      readln  (FileConta,ReferenciaLancamento);
      readln  (FileConta,DescricaoLancamento);
      readln  (FileConta,ValorLancamento);
      readln  (FileConta,NumeroLancamento);
      Val(ValorLancamento,ValorLancamentoInt,Numero);
      If CredV= 'DêBITO' then Saldo := Saldo - ValorLancamentoInt;
      If CredV= 'CRêDITO' then Saldo := Saldo + ValorLancamentoInt;
      {$I+}
      If IORESULT <>0 then
       Begin
        Erros (3);
        Erros (0);
        MenuServicos;
        Exit;
       end;
     until (DataLL>=DataI)or Eof(FileConta);
    If DataLL<DataI then
     begin
      str(DataLL:8,DataLancamento);
      ReferenciaLancamento:='Saldo act';
      CredV:='INDETERMINADO';
      ValorLancamentoInt:=0;
     end;
     Y := 0;
     {$I-}
     while not EOF(FileConta) do
      begin
       inc(Y);
       if Y=53 then
        begin
         Y := 1;
         writeln(lst,chr(12));
         writeln(lst,'Conta nß ',NumeroConta,' do banco ',NomeBanco,' da dependància ',Dependencia);
         writeln(lst,'Titular ',Titular,'   Data de abertura - ',copy(DataInicial,0,4),'/',copy(DataInicial,5,2),'/',
         {Cont Linha} copy(DataInicial,7,2));
         writeln (lst,'  ƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ');
         writeln (lst,'   Data      | Referància | DÇbito        | CrÇdito      | Saldo          | Lanc ');
        end;
       write (lst,'  ',copy(DataLancamento,0,4),'/',copy(DataLancamento,5,2),'/',copy(DataLancamento,7,2));
       ReferenciaLancamento:=concat(ReferenciaLancamento,'            ');
       write (lst,'   ',copy(ReferenciaLancamento,0,10));
       If CredV = 'INDETERMINADO' then
        begin
         write(lst,'                                  ',Saldo:14:2);
        end;
       If CredV = 'DêBITO' then
        begin
         write(lst,'   ',ValorLancamentoInt:13:2,'                   ',Saldo:14:2);
        end;
       If CredV = 'CRêDITO' then
        begin
         write(lst,'                  ',ValorLancamentoInt:13:2,'    ',Saldo:14:2);
        end;
       write(lst,'   ',NumeroLancamento);
       writeln(lst,'');
       readln  (FileConta,CredV);
       readln  (FileConta,DataLancamento);
       readln  (FileConta,ReferenciaLancamento);
       readln  (FileConta,DescricaoLancamento);
       readln  (FileConta,ValorLancamento);
       readln  (FileConta,NumeroLancamento);
       Val(ValorLancamento,ValorLancamentoInt,Numero);
       If CredV= 'DêBITO' then Saldo := Saldo - ValorLancamentoInt;
       If CredV= 'CRêDITO' then Saldo := Saldo + ValorLancamentoInt;
      end;
     write (lst,'  ',copy(DataLancamento,0,4),'/',copy(DataLancamento,5,2),'/',copy(DataLancamento,7,2));
     ReferenciaLancamento:=concat(ReferenciaLancamento,'            ');
     write (lst,'   ',copy(ReferenciaLancamento,0,10));
     If CredV = 'INDETERMINADO' then
      begin
       write(lst,'                                  ',Saldo:14:2);
      end;
     If CredV = 'DêBITO' then
      begin
       write(lst,'   ',ValorLancamentoInt:13:2,'                   ',Saldo:14:2);
      end;
     If CredV = 'CRêDITO' then
      begin
       write(lst,'                  ',ValorLancamentoInt:13:2,'    ',Saldo:14:2);
      end;
     write(lst,'   ',NumeroLancamento);
     writeln(lst,'');
     writeln(lst,chr(12));
     close  (FileConta);
     {$I+}
     If IORESULT <>0 then
      Begin
       Erros(3);
       Erros(0);
       MenuServicos;
       Exit;
      end;
      GotoXY(1,25);ClrEol;
      Erros(0);
    end {***** Is FILE ***}
   else
    begin
     Erros(2);
     Erros(0);
    end { Else IsFile}
  end { Inicio }
 else
  begin

   TextColor(CTErro);
   TextBackGround(CFErro);
   GotoXY(45,14); write ('   ⁄ƒƒƒƒø    ');
   GotoXY(10,15); write (' ERRO 01 : IMPRESSORA NéO PREPARADA  ⁄¡ƒƒƒƒ¡ø   ');
   GotoXY(45,16); write ('  ≥ ƒƒ   ≥›  ');
   GotoXY(45,17); write ('  ¿ƒƒƒƒƒƒŸ   ');
   Erros(0);
   TextColor(CTFundo);
   TextBackGround(CFFundo);
   Clrscr;
  end;
  MenuServicos;
end;{** Impressora **}

Procedure ExtratoEcran;
var
  Y       :byte;
  Numero  :integer;
  Ficheiro:string;
  Saldo   :real;
  SaldoInicialInt:real;
  ValorLancamentoInt:real;
  Data    :string;
  DataLL  :longint;
  DataI   :longint;

 Procedure FichaExtrato;
  begin
   TextColor(CTFundo);
   GotoXY(1,4);write(' ’ÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ∏');
   GotoXY(1,5);write(' ≥            ≥             ≥               ≥               ≥                ≥');
   TextColor(CTFichas);
   GotoXY(4,5); write('Data');
   GotoXY(17,5);write('Referància');
   GotoXY(31,5);write('DÇbito');
   GotoXY(47,5);write('CrÇdito');
   GotoXY(63,5);write('Saldo');
   TextColor(CTFundo);
   GotoXY(1,6);write(' √ƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥');
   Y:=7;
   repeat
    GotoXY(1,Y);write(' ≥            ≥             ≥               ≥               ≥                ≥');
    inc(Y);
   until y=24;
   GotoXY(1,Y);write (' ‘ÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕæ');
  end;{Ficha Extrato}

begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 ClrScr;
 Data := '00000000';
 Cabecalho;
 L25_6;
 TextColor(CTPerguntas);
 TextBackGround(CFPerguntas);
 GotoXY(1,24); write(' Apartir da data (aaaammdd) - ',Data);
 repeat
  Conta1:=length(Data);
  st:=Data;
  Escreve(2,8,31,24);
 until (length(st)=8)and(cha = #13);
 Data := st;
 val(Data,DataI,numero);
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 Clrscr;
 Saldo := 0;
 Cabecalho;
 TextColor(CTFichas);
 TextBackGround(CFFichas);
 GotoXY(1,2);writeln('Conta nß ',NumeroConta,' do banco ',NomeBanco,' da dependància ',Dependencia);
 writeln('Titular ',Titular,'   Data de abertura - ',copy(DataInicial,0,4),'/',copy(DataInicial,5,2),'/',
 {CONT LINHA} copy(DataInicial,7,2));
 FichaExtrato;
 TextColor(CtFichas);
 Val(SaldoInicial,SaldoInicialInt,Numero);
 Saldo := SaldoInicialInt;
 Ficheiro := concat(NomeFicheiro,'.MOV');
 If IsFile(Ficheiro) then
  begin
   assign (FileConta,Ficheiro);
   {$I-}
   reset(FileConta);
   {$I+}
   If IORESULT <> 0 then
    begin
     Erros(3);
     Erros(0);
     MenuServicos;
     Exit;
    end;
   Repeat
    {$I-}
    readln  (FileConta,CredV);
    readln  (FileConta,DataLancamento);
    Val(DataLancamento,DataLL,Numero);
    readln  (FileConta,ReferenciaLancamento);
    readln  (FileConta,DescricaoLancamento);
    readln  (FileConta,ValorLancamento);
    readln  (FileConta,Numero);
    Val(Valorlancamento,ValorLancamentoInt,Numero);
    If CredV= 'DêBITO' then Saldo := Saldo - ValorLancamentoInt;
    If CredV= 'CRêDITO' then Saldo := Saldo + ValorLancamentoInt;
    {$I+}
    If IORESULT <> 0 then
     Begin
      Erros (3);
      Erros (0);
      MenuServicos;
      exit;
     end;
   until (DataLL>=DataI)or Eof(FileConta);
   If DataLL<DataI then
    begin
     str(DataLL:8,DataLancamento);
     ReferenciaLancamento:='Saldo act';
     CredV:='INDETERMINADO';
     ValorLancamentoInt:=0;
    end;
   Y := 7;
   while not EOF(FileConta) do
    begin
     If Y = 23 then
      begin
       Erros(0);
       Y := 4;
       repeat
        GotoXY(1,Y);ClrEol;
        inc(Y);
       until Y = 25;
       Fichaextrato;
       TextColor(CTFichas);
       Y := 7;
      end;
     GotoXY (4,Y); write (copy(DataLancamento,0,4),'/',copy(DataLancamento,5,2),'/',copy(DataLancamento,7,2));
     GotoXY (17,Y);write (ReferenciaLancamento);
     If CredV = 'DêBITO' then
      begin
       GotoXY (31,Y);write(ValorLancamentoInt:13:2);
      end;
     If CredV = 'CRêDITO' then
      begin
       GotoXY (47,Y); write(ValorLancamentoInt:13:2);
      end;
     GotoXY(63,Y); write(Saldo:14:2);
     inc(Y);
     readln  (FileConta,CredV);
     readln  (FileConta,DataLancamento);
     readln  (FileConta,ReferenciaLancamento);
     readln  (FileConta,DescricaoLancamento);
     readln  (FileConta,ValorLancamento);
     readln  (FileConta,Numero);
     val(ValorLancamento,ValorLancamentoInt,Numero);
     If CredV= 'DêBITO' then Saldo := Saldo - ValorLancamentoInt;
     If CredV= 'CRêDITO' then Saldo := Saldo + ValorLancamentoInt;
    end;
   close  (FileConta);
   GotoXY (4,Y); write (copy(DataLancamento,0,4),'/',copy(DataLancamento,5,2),'/',copy(DataLancamento,7,2));
   GotoXY (17,Y);write (ReferenciaLancamento);
   If CredV = 'DêBITO' then
    begin
     GotoXY (31,Y);write(ValorLancamentoInt:13:2);
    end;
   If CredV = 'CRêDITO' then
    begin
     GotoXY (47,Y); write(ValorLancamentoInt:13:2);
    end;
   GotoXY(63,Y); write(Saldo:14:2);
   {$I+}
   If IORESULT <> 0 then
    Begin
     Erros(3);
     Erros(0);
     Exit;
    end;
   Erros(0);
  end {*** If IsfILe ***}
 else
  begin
   Erros(2);
   Erros(0);
  end;
 MenuServicos;
end;{** Extrato Ecran **}


Procedure SaldoActual;

var
  a       : char;
  Numero  : integer;
  Ficheiro:string;
  Saldo   :single;
  SaldoInicialInt:single;
  ValorLancamentoInt:single;

begin
 Clrscr;
 Saldo := 0;
 Cabecalho;
 TextColor(CTFichas);
 TextBackGround(CFFichas);
 GotoXY(1,3);write('Conta nß ',NumeroConta,' do banco ',NomeBanco,' da dependància ',Dependencia);
 GotoXY(1,5);write('Titular ',Titular,'   Data de abertura - ',copy(DataInicial,0,4),'/',copy(DataInicial,5,2),'/',
 {CONT LINHA} copy(DataInicial,7,2));
 GotoXY(1,7);writeln ('  ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ  ');
 writeln;
 writeln;
 val(SaldoInicial,SaldoInicialInt,Numero);
 Saldo := Saldo+SaldoInicialInt;
 Ficheiro := concat(NomeFicheiro,'.MOV');
 assign (FileConta,Ficheiro);
 {$I-}
 reset(FileConta);
 while not eof(FileConta) do
  begin
   readln  (FileConta,CredV);
   readln  (FileConta,DataLancamento);
   readln  (FileConta,ReferenciaLancamento);
   readln  (FileConta,DescricaoLancamento);
   readln  (FileConta,ValorLancamento);
   readln  (FileConta,Numero);
   val(ValorLancamento,ValorLancamentoInt,Numero);
    If CredV = 'DêBITO' then  Saldo := Saldo - ValorLancamentoInt;
    If CredV = 'CRêDITO' then Saldo := Saldo + ValorLancamentoInt;
  end;
 close  (FileConta);
 {$I+}
 If IORESULT <>0 then
  Begin
   Erros(3);
   Erros(0);
   MenuServicos;
   Exit;
  end;
 writeln('     SALDO ACTUAL(esc) - ',Saldo:13:2);
 Erros(0);

 MenuServicos;
end;{** SaldoActual **}

Procedure FechaAno;

var
  a       : char;
  Numero  : integer;
  Ficheiro:string;
  Saldo   :single;
  Fim     : boolean;

begin
 Clrscr;
 Saldo := 0;
 GotoXY(1,15);write(' Fecho do Ano ');
 Ficheiro := concat(NomeFicheiro,'.MOV');
 assign (FileConta,Ficheiro);
 {$I-}
 reset(FileConta);
 {$I+}
 If IORESULT <> 0 then
  Begin
   Erros(3);
   Erros(0);
   MenuPrincipal;
   Exit;
  End;
 repeat
  Fim := False;
  {$I-}
  readln  (FileConta,CredV);
  readln  (FileConta,DataLancamento);
  readln  (FileConta,ReferenciaLancamento);
  readln  (FileConta,DescricaoLancamento);
  readln  (FileConta,ValorLancamento);
  readln  (FileConta,Numero);
  If CredV = 'DêBITO' then  Saldo := Saldo {- ValorLancamento};
  If CredV = 'CRêDITO' then Saldo := Saldo {+ ValorLancamento};
  If EOF(FileConta) then Fim := True;
  {$I+}
  If IORESULT <> 0 then
   Begin
    Erros(3);
    Erros(0);
    MenuPrincipal;
    Exit;
   end;
 until Fim;
 {$I-}
 if Saldo>=0 then CredV:='CRêDITO';
 if Saldo<0  then CredV:='DêBITO';
 rewrite(FileConta);
 append(FileConta);
 numero:=1;
 NumeroLancamento := 1;
 writeln  (FileConta,CredV);
 writeln  (FileConta,'00000000');
 writeln  (FileConta,'FEANO');
 writeln  (FileConta,'FECHO ANO');
 writeln  (FileConta,Saldo);
 writeln  (FileConta,Numero);
 close (FileConta);
 assign(FileConta,Concat(NomeFicheiro,'.ORD'));
 rewrite(FileConta);
 erase(FileConta);
 {$I+}
 If IORESULT <> 0 then
  begin
   Erros(3);
   Erros(0);
   MenuPrincipal;
   Exit;
  end;
 gotoXY(1,24);write (' Qualquer Tecla Para Continuar ');
 a:= readkey;
 Clrscr;
 MenuPrincipal;

end;{** Fecha Ano **}

Procedure ServicosManeger;
var
 carater : char;
 sairS   : boolean;

begin
 sairS:=False;
 MenuServicos;
 Repeat
  repeat
   zero := False;
   carater := readkey;
   if carater =#0 then
    begin
     zero := True;
     carater := readkey;
    end;
  until (carater='1')or(carater='2')or(carater='3')or(carater='4')or(carater='5')or(carater='6')or(carater='7')or
  {***Cont linha **}(carater='8')or(carater='9')or(carater='0')or(carater=#45)or(carater=#27)or(carater=#72)
  {cont} and(zero=true)or(carater=#80)and(zero=true)or(carater=#13);
 case carater of
   #72 : Sobe(26,5,1,VDesceS);
   #80 : Desce(26,5,1,VDesceS);
   #13 : case VDesceS of
          1 : if NomeFicheiro<>'SEM_NOME' then ExtratoEcran;
          2 : if NomeFicheiro<>'SEM_NOME' then ExtratoImpressora;
          3 : if NomeFicheiro<>'SEM_NOME' then SaldoActual;
          4 : begin
               If NomeFicheiro<>'SEM_NOME' then Ordena_Data;
               MenuServicos;
              end;
          5 : SairS:=True;
         end;
   #27 : SairS:=True;
   #45 : Sair :=True;
   '1' : if NomeFicheiro<>'SEM_NOME' then ExtratoEcran;
   '2' : if NomeFicheiro<>'SEM_NOME' then ExtratoImpressora;
   '3' : if NomeFicheiro<>'SEM_NOME' then SaldoActual;
   '4' : begin
          if NomeFicheiro<>'SEM_NOME' then Ordena_Data;
          MenuServicos;
         end;
   '5' : SairS:=True;
 end;
 Inf(4,VDesceS);
 until SairS or Sair;
 MenuPrincipal;

end;

Procedure Configura;
var
  TudoOK : boolean;
  a : char;
  x: byte;
  PassWordX : string;
  stri:string;
  Fic : text;
begin
 TextColor(CTFundo);
 TextBackGround(CFFundo);
 Clrscr;
 Cabecalho;
 PassWord :='COMO ESTÜ ?...';
 Set_Cursor($0607);
 TudoOK := true;
 assign(Fic,'BANCO.CFG');
 SetFAttr(Fic,archive);
 Reset(Fic);
 readln(Fic,EncriptaSt);
 readln(Fic,OrdenaSt);
 readln(Fic,PassWordVSt);
 readln(Fic,PassWordX);
 close(Fic);
 SetFAttr(FicC,Hidden);
 {$I+}
 if IORESULT <> 0 then
  begin
   Erros(100);
   Erros(0);
   MenuUtils;
   Exit;
  end;
 If EncriptaSt='TRUE' then Encripta := True else Encripta:=False;
 If OrdenaSt='TRUE' then Ordena := True else Ordena:=False;
 If PassWordVSt='TRUE' then PassWordV := True else PassWordV :=False;
 if PassWordV then
  begin
   L25_6;
   TextColor(CTPerguntas);
   TextBackGround(CFPerguntas);
   GotoXY(1,24); write('PassWord do Programa - ');
   st:=PassWord;
   Conta1:=0;
   Escreve(3,30,24,24);
   PassWord:=st;
   TextColor(black);
   TextBackGround(black);
   GotoXY(1,24); ClrEol;
   If PassWord<>PassWordX then
    begin
     TudoOK :=False;
     Erros(6);
     Erros(0);
     MenuUtils;
     Exit;
    end;
  end;
 If TudoOK then
  begin
   Set_Cursor($0607);
   TextColor(CTFichas);
   TextBackGround(CFFichas);
   If Encripta=True then stri :='ACTIVA' else stri :='DESACTIVA';
   GotoXY(1,3); write (' CodificaáÑo de dados - ',stri);
   TextColor(CTInf);
   TextBackGround(CFInf);
   GotoXY(1,5); write ('-> Quando activa protege os dados dos ficheiros codificando-os');
   TextColor(CTFichas);
   TextBackGround(CFFichas);
   If Ordena=True then stri :='ACTIVA' else stri :='DESACTIVA';
   GotoXY(1,6); write (' OrdenaáÑo autom†tica - ',stri);
   TextColor(CTInf);
   TextBackGround(CFInf);
   GotoXY(1,8); write ('-> Quando activa ordena o ficheiro dos lanáamentos sempre que h† uma alteraáÑo ');
   TextColor(CTFichas);
   TextBackGround(CFFichas);
   If PassWordV=True then stri :='ACTIVA' else stri :='DESACTIVA';
   GotoXY(1,9); write (' PassWord inicial     - ',stri);
   TextColor(CTInf);
   TextBackGround(CFInf);
   GotoXY(1,11); write ('-> Quando activa condiciona o acesso ao programa e a esta configuraáÑo');
   L25_5;
   x := 3;
   GotoXY(25,3);
   TextColor(CTFichas);
   TextBackGround(CFFichas);
   repeat
    repeat
     a:= readkey;
    until (a=#0)or(a=#13)or(a=#27)or(a=#32);
     if a = #0 then a:=readkey;
    case a of
     #72 : begin
            if x>3 then x:=x-3 else x:=9;
            GotoXY(25,x);
           end;
     #80 : begin
            if x<7 then x:=x+3 else x:=3;
            GotoXY(25,x);
           end;
     #32 : case x of
            3 : begin
                 If Encripta = true then
                  begin
                   Encripta := False;
                   GotoXY(25,3); write ('DESACTIVA');
                  end
                 else
                  begin
                   Encripta := True;
                   GotoXY(25,3); write ('ACTIVA   ');
                  end;
                 GotoXY(25,3);
                end;
            6 : begin
                 If Ordena = true then
                  begin
                   Ordena := False;
                   GotoXY(25,6); write ('DESACTIVA');
                  end
                 else
                  begin
                   Ordena := True;
                   GotoXY(25,6); write ('ACTIVA   ');
                  end;
                 GotoXY(25,6);
                end;
            9 : begin
                 If PassWordV = true then
                  begin
                   PassWordV := False;
                   GotoXY(25,9); write ('DESACTIVA');
                  end
                 else
                  begin
                   PassWordV := True;
                   GotoXY(25,9); write ('ACTIVA   ');
                  end;
                 GotoXY(25,9);
                end;
           end;
    end;
   until (a=#13)or(a=#27);
   if a=#13 then
    begin
     if PassWordV then
      begin
       L25_6;
       TextColor(CTPerguntas);
       TextBackGround(CFPerguntas);
       GotoXY(1,24); write('PassWord do programa - ');
       st:=PassWord;
       Conta1:=0;
       Escreve(3,30,24,24);
       PassWord:=st;
      end
     else
      PassWord:='';
     {$I-}
     assign(Fic,'BANCO.CFG');
     SetFAttr(fic,archive);
     Rewrite(Fic);
     Append(Fic);
     writeln(Fic,Encripta);
     writeln(Fic,Ordena);
     writeln(Fic,PassWordV);
     writeln(Fic,PassWord);
     write(Fic,' CONFIGURAÄéO DO PROGRAMA BANCO ');
     close(Fic);
     SetFAttr(Fic,Hidden);
     {$I+}
     if IORESULT <> 0 then
      begin
       Erros(3);
       Erros(0);
      end;
    end;
  End;{If TudoOK}
  MenuUtils;
  Set_Cursor($0800);
end;

Procedure ServicosUtils;
var
 carater : char;
 sairU   : boolean;

begin
 sairU:=False;
 MenuUtils;
 Repeat
  repeat
   zero := False;
   carater := readkey;
   if carater =#0 then
    begin
     zero := True;
     carater := readkey;
    end;
  until (carater='1')or(carater='2')or(carater='3')or(carater='4')or(carater='5')or(carater='6')or(carater='7')or
  {***Cont linha **}(carater='8')or(carater='9')or(carater='0')or(carater=#45)or(carater=#27)or(carater=#72)
  {cont} and(zero=true)or(carater=#80)and(zero=true)or(carater=#13);
 case carater of
   #72 : Sobe(26,5,1,VDesceU);
   #80 : Desce(26,5,1,VDesceU);
   #13 : case VDesceU of
          1 : Configura;
          2 : Directorio;
          3 : MudaDirectorio;
          4 : Passeio;
          5 : SairU:=True;
         end;
   #27 : SairU:=True;
   #45 : Sair :=True;
   '1' : Configura;
   '2' : Directorio;
   '3' : MudaDirectorio;
   '4' : Passeio;
   '5' : SairU:=True;
 end;
 Inf(5,VDesceU);
 until SairU or Sair;
 MenuPrincipal;
end;

Begin
 Inicio;
 Clrscr;
 Cores;
 Variaveis_Zero;
 {$I-}
 assign(FicC,'BANCO.CFG');
 SetFAttr(FicC,archive);
 Reset(FicC);
 readln(FicC,EncriptaSt);
 readln(FicC,OrdenaSt);
 readln(FicC,PassWordVSt);
 readln(FicC,PassWord);
 close(FicC);
 If EncriptaSt='TRUE' then Encripta := True else Encripta:=False;
 If OrdenaSt='TRUE' then Ordena := True else Ordena:=False;
 If PassWordVSt='TRUE' then PassWordV := True else PassWordV :=False;
 SetFAttr(FicC,Hidden);
 {$I+}
 if IORESULT <> 0 then
  begin
   Erros(100);
   Erros(0);
  end;
if PassWordV then
 begin
  L25_6;
  TextColor(CTPerguntas);
  TextBackGround(CFPerguntas);
  GotoXY(1,24); write('PassWord do Programa - ');
  st:=PassWordst;
  Conta1:=0;
  Escreve(3,30,24,24);
  PassWordst:=st;
  If PassWordSt<>PassWord then
   begin
    TextColor(CTFundo);
    TextBackGround(CFFundo);
    clrscr;
    textColor(yellow+blink);
    TextBackGround(red);
    writeln(' PassWord Errada');
    writeln(' OPERAÄéO ABORTADA - ACESSO NEGADO ');
    writeln;
    textColor(green);
    textBackGround(blue);
    writeln(' BANCO um programa SOGMI para si !... ');
    set_cursor($0607);
    Halt;
   end;
 end;
 NomeFicheiro := 'SEM_NOME';
 MenuPrincipal;
 Sair:=False;
 Repeat
  repeat
   zero := False;
   carater := readkey;
   if carater =#0 then
    begin
     zero := True;
     carater := readkey;
    end;
  until (carater='1')or(carater='2')or(carater='3')or(carater='4')or(carater='5')or(carater='6')or(carater='7')or
  {***Cont linha **}(carater='8')or(carater='9')or(carater='0')or(carater=#45)or(carater=#27)or(carater=#72)
  {cont} and(zero=true)or(carater=#80)and(zero=true)or(carater=#13)or(carater=#59)and(zero);
 case carater of
   #72 : Sobe(26,5,1,VDesce);
   #80 : Desce(26,5,1,VDesce);
   #59 : begin
          PaginaInformacao;
          MenuPrincipal;
         end;
   #13 : case VDesce of
          1 : FicheiroManeger;
          2 : EditarManeger;
          3 : ServicosManeger;
          4 : ServicosUtils;
          5 : Sair:=true;
         end;
   '1' : FicheiroManeger;
   '2' : EditarManeger;
   '3' : ServicosManeger;
   '4' : ServicosUtils;
   '5' : sair:=true;
 end;
 Inf(1,Vdesce);
 until (carater=#45)or sair;
 TextColor(white);
 TextBackGround(Black);
 ClrScr;
 TextColor(Green);
 TextBackGround(blue);
 Write('Trabalharam no SGMBA o seu BANCO -*- NUNO COSTEIRA DA ROCHA -+- VOLTE SEMPRE!...');
 TextColor(white);
 TextBackGround(Black);
 Set_Cursor($0607);

end.
