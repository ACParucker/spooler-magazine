program ComBan;
uses seguranca;
var a:string;
    ch:char;
    ficheiro:text;
    ficheiro2:text;
    i        : integer;
    indicador: integer;
    data,
    data2,
    Sigla,
    dependencia,
    conta,
    nome,
    valor,
    valor2,
    palavrachave     : string;
    referencia,
    debito,
    credito,
    descricao:string;
    ajudex:boolean;

Procedure DescodificaDI;
begin
 Sigla:=FDesencripta(Sigla);
 Dependencia:=FDesencripta(Dependencia);
 Conta:=FDesencripta(Conta);
 Nome:=FDesencripta(Nome);
 Valor:=FDesencripta(Valor);
 Data:=FDesencripta(Data);
 PalavraChave:=FDesencripta(PalavraChave);
end;

Procedure CodificaDI;
begin
 Sigla:=FEncripta(Sigla);
 Dependencia:=FEncripta(Dependencia);
 Conta:=FEncripta(Conta);
 Nome:=FEncripta(Nome);
 Valor:=FEncripta(Valor);
 Data:=FEncripta(Data);
 PalavraChave:=FEncripta(PalavraChave);
end;

procedure Tudo_Bem;
begin

 assign(Ficheiro,'BANCO.DAD');
 reset(Ficheiro);
 read(Ficheiro,a);
 data:=copy(a,0,8);
 data2:=data;
 data[1]:=data2[5];
 data[2]:=data2[6];
 data[3]:=data2[7];
 data[4]:=data2[8];
 data[5]:=data2[3];
 data[6]:=data2[4];
 data[7]:=data2[1];
 data[8]:=data2[2];
 sigla:=copy(a,9,6);
 dependencia:=copy(a,15,10);
 conta := copy(a,25,10);
 nome:=copy(a,35,10);
 valor:=copy(a,48,10);
 assign(Ficheiro2,concat(paramstr(1),'.DI'));
 rewrite(Ficheiro2);
 append(Ficheiro2);
 indicador :=1;
 valor2:='';
 for i := 1 to 10 do
  begin
   if valor[i]<>' 'then
    begin
     insert(valor[i],valor2,indicador);
     inc(indicador);
    end;
  end;
 valor:=valor2;
 writeln(Ficheiro2,Sigla);
 writeln(Ficheiro2,Dependencia);
 writeln(Ficheiro2,Conta);
 writeln(Ficheiro2,Nome);
 writeln(Ficheiro2,Valor);
 writeln(Ficheiro2,Data);
 if paramcount = 2 then writeln(Ficheiro2,paramstr(2))else writeln(Ficheiro2,'');
 close(ficheiro2);
 assign(ficheiro,'BANCO.FIC');
 assign(ficheiro2,concat(Paramstr(1),'.MOV'));
 rewrite(ficheiro2);
 append(ficheiro2);
 reset(Ficheiro);
 indicador :=0;
 repeat
  inc(indicador);
  data:='';
  debito:='';
  credito:='';
  referencia:='';
  descricao:='';

  for i := 1 to 6 do
   begin
    read(ficheiro,ch);
    insert(ch,data,i);
   end;
   data2[1]:='1';
   data2[2]:='9';
   data2[3]:=data[5];
   data2[4]:=data[6];
   data2[5]:=data[3];
   data2[6]:=data[4];
   data2[7]:=data[1];
   data2[8]:=data[2];
  for i := 1 to 6 do
   begin
    read(ficheiro,ch);
    insert(ch,referencia,i);
   end;
  for i := 1 to 11 do
   begin
    read(ficheiro,ch);
    if ch<>' 'then insert(ch,debito,i);
   end;
  for i := 1 to 11 do
   begin
    read(ficheiro,ch);
    if ch<>' 'then insert(ch,credito,i);
   end;
  for i := 1 to 20 do
   begin
    read(ficheiro,ch);
    insert(ch,descricao,i);
   end;
  for i := 1 to 6 do read(ficheiro,ch);
  if Debito <> '0' then
   begin
    Valor:=Debito;
    Writeln(ficheiro2,'DêBITO');
   end;
  if (Credito <> '0') and (Debito = '0')then
   begin
    Valor:=Credito;
    writeln(ficheiro2,'CRêDITO');
   end;
  writeln(ficheiro2,data2);
  writeln(ficheiro2,referencia);
  writeln(Ficheiro2,descricao);
  writeln(Ficheiro2,valor);
  writeln(ficheiro2,indicador);
 until EOF(Ficheiro);
 close(ficheiro2);
 assign(ficheiro2,concat(paramstr(1),'.DI'));
 reset(ficheiro2);
 append(ficheiro2);
 writeln(ficheiro2,indicador);
 close(ficheiro2);
 close(ficheiro);
end; { Tudo Bem , Podes continuar }

Procedure Tudo_Fixe;
begin
 assign(Ficheiro2,concat(paramstr(2),'.DI'));
 reset(ficheiro2);
 readln(Ficheiro2,Sigla);
 readln(Ficheiro2,Dependencia);
 readln(Ficheiro2,Conta);
 readln(Ficheiro2,Nome);
 readln(Ficheiro2,Valor);
 readln(Ficheiro2,Data);
 readln(Ficheiro2,PalavraChave);
 readln(Ficheiro2,Indicador);
 DescodificaDI;
 rewrite(Ficheiro2);
 append(ficheiro2);
 writeln(Ficheiro2,Sigla);
 writeln(Ficheiro2,Dependencia);
 writeln(Ficheiro2,Conta);
 writeln(Ficheiro2,Nome);
 writeln(Ficheiro2,Valor);
 writeln(Ficheiro2,Data);
 writeln(Ficheiro2,PalavraChave);
 writeln(Ficheiro2,Indicador);
 close(Ficheiro2);
end;{ Tudo Fixe, mas cuidado com o degrau}

Procedure Tudo_Nice;
begin
 assign(Ficheiro2,concat(paramstr(2),'.DI'));
 reset(ficheiro2);
 readln(Ficheiro2,Sigla);
 readln(Ficheiro2,Dependencia);
 readln(Ficheiro2,Conta);
 readln(Ficheiro2,Nome);
 readln(Ficheiro2,Valor);
 readln(Ficheiro2,Data);
 readln(Ficheiro2,PalavraChave);
 readln(Ficheiro2,Indicador);
 CodificaDI;
 rewrite(Ficheiro2);
 append(ficheiro2);
 writeln(Ficheiro2,Sigla);
 writeln(Ficheiro2,Dependencia);
 writeln(Ficheiro2,Conta);
 writeln(Ficheiro2,Nome);
 writeln(Ficheiro2,Valor);
 writeln(Ficheiro2,Data);
 writeln(Ficheiro2,PalavraChave);
 writeln(Ficheiro2,Indicador);
 close(Ficheiro2);
end;{ Tudo Nice, adrenalina 100%, ProgramaáÑo Radical !! }

procedure ajuda;
begin
 writeln('Programa COMBAN v2.01-Conversor banc†rio (c) 1993 SOGMI- NUNO COSTEIRA DA ROCHA');
 writeln('-------------------------------------------------------------------------------');
 writeln('                                                                               ');
 writeln('  PARAMETROS INVÜLIDOS                                                                   ');
 writeln;
 writeln(' Digite COMBAN </H | /h> para ecran de ajuda                                          ');
 writeln;
 writeln('  >- AVISO - O AUTOR NéO SE RESPONSABILIZA POR QUALQUER DANO CAUSADO POR ESTE  ');
 writeln('  SOFTWARE OU PELA SUA UTILIZAÄéO DEFEITUOSA                                   ');
 ajudex:=true;
end;

procedure ajudaplus;
begin
 writeln('Programa COMBAN v2.01-Conversor banc†rio (c) 1993 SOGMI- NUNO COSTEIRA DA ROCHA');
 writeln('-------------------------------------------------------------------------------');
 writeln(' Modos de utilizaáÑo:                                                          ');
 writeln('  - Para converter ficheiros do formato BANCO(SPOOLER nß8) em ficheiros formato');
 writeln('    SGBAN digite:                                                              ');
 writeln('     COMBAN <Nome do ficheiro de conta> <PassWord>                             ');
 writeln('     <Nome do ficheiro de conta> - nome do ficheiro que vai conter os dados    ');
 writeln('                                   convertidos que serÑo usados pelo SGBAN     ');
 writeln('     <PassWord> - PassWord que controla o acesso a essa conta (facultativo)    ');
 writeln;
 writeln('  - Para codificar ficheiros de conta digite:                                  ');
 writeln('     COMBAN </D | /h> <Nome do ficheiro de conta>                              ');
 writeln('     <Nome do ficheiro de conta> - nome do ficheiro de conta que quer codificar');
 writeln('                                                                               ');
 writeln('  - Para descodificar ficheiros de conta digite:                               ');
 writeln('     COMBAN </C | /c> <Nome do ficheiro de conta>                              ');
 writeln('     <Nome do ficheiro de conta> - nome do ficheiro de conta que vai ser       ');
 writeln('                                   descodificado                               ');
 writeln('-------------------------------------------------------------------------------');
 writeln(' Deve ser corrido no direct¢rio onde se encontram os ficheiros a converter     ');
 writeln('-------------------------------------------------------------------------------');
 writeln('  >- AVISO - O AUTOR NéO SE RESPONSABILIZA POR QUALQUER DANO CAUSADO POR ESTE  ');
 writeln('  SOFTWARE OU PELA SUA UTILIZAÄéO DEFEITUOSA                                   ');
 ajudex:=true;
end;

procedure inicio;
begin
 writeln('Programa COMBAN v2.01- Conversor banc†rio (c) 1993 SOGMI-NUNO COSTEIRA DA ROCHA');
 writeln('-------------------------------------------------------------------------------');
 writeln('  >- AVISO - O AUTOR NéO SE RESPONSABILIZA POR QUALQUER DANO CAUSADO POR ESTE  ');
 writeln('  SOFTWARE OU PELA SUA UTILIZAÄéO DEFEITUOSA                                   ');
 ajudex:=true;
end;

begin
 ajudex:=false;
 for i := 1 to 23 do write(' SOGMI ');
 writeln;
 If (paramstr(1)='/H')or(paramstr(1)='/h') then ajudaplus;
 If paramcount=0 then ajuda;
 If (ajudex=False)and((paramstr(1)='/D')or(paramstr(1)='/d')) then
  begin
   Inicio;
   writeln;
   {$I-}
    assign(ficheiro,concat(Paramstr(2),'.DI'));
    reset(ficheiro);
   {$I+}
   If IORESULT <> 0 then writeln(' ERRO - NÑo encontro ficheiros a converter ')
    else
     begin
      {$I-}
      assign(ficheiro,concat(paramstr(2),'.TEM'));
      rewrite(ficheiro);
      erase(ficheiro);
      {$I+}
      if IORESULT <> 0 then writeln(' ERRO - Disco protegido contra escrita ')
       else
        begin
         Tudo_Fixe;
         writeln(' Ficheiros convertidos com sucesso !!...');
        end;
     end;
    ajudex:=true;
  end;

 If (ajudex=False)and((paramstr(1)='/C')or(paramstr(1)='/c')) then
  begin
   Inicio;
   writeln;
   {$I-}
    assign(ficheiro,concat(Paramstr(2),'.DI'));
    reset(ficheiro);
   {$I+}
   If IORESULT <> 0 then writeln(' ERRO - NÑo encontro ficheiros a converter ')
    else
     begin
      {$I-}
      assign(ficheiro,concat(paramstr(2),'.TEM'));
      rewrite(ficheiro);
      erase(ficheiro);
      {$I+}
      if IORESULT <> 0 then writeln(' ERRO - Disco protegido contra escrita ')
       else
        begin
         Tudo_Nice;
         writeln(' Ficheiros convertidos com sucesso !!...');
        end;
     end;
    ajudex:=true;
  end;

 If (ajudex=False)and(paramcount<=2) then
  begin
   Inicio;
   writeln;
   {$I-}
    assign(ficheiro,'BANCO.DAD');
    reset(ficheiro);
    assign(ficheiro,'BANCO.FIC');
    reset(ficheiro);
   {$I+}
   If IORESULT <> 0 then writeln(' ERRO - NÑo encontro ficheiros a converter ')
    else
     begin
      {$I-}
      assign(ficheiro,concat(paramstr(1),'.DI'));
      rewrite(ficheiro);
      {$I+}
      if IORESULT <> 0 then writeln(' ERRO - Disco protegido contra escrita ')
       else
        begin
         Tudo_Bem;
         writeln(' Ficheiros convertidos com sucesso !!...');
        end;
     end;
   Ajudex := True;
  end;
 If ajudex = false then ajuda;
end.