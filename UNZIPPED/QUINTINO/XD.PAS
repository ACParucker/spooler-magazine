Program XDIR;

{ XDIR V1.1
  (C) Rui Dias Quintino 1993

  Feito e Compilado em Turbo Pascal 6.0


  Para a SPOOLER Magazine


  Sugest”es e Troca de Ideias para:

  Rui Dias Quintino
  Rua Lic¡nio de Carvalho  N§126
  3880 Ovar }




{$M $900,0,0 }   { Permite a execu‡„o de outro programa dentro deste }


Uses dos;


 
{ --------------- }
Procedure Proceed;

Var COM,TEMP:string[127];
    I:integer;
    DIR,DORIG:string;
    PAL:string[8];

Begin
  if paramcount>=2
    then
      begin
        PAL:=paramstr(2);
        for I:=1 to length(PAL) do PAL[I]:=upcase(PAL[I]);
      end
  else PAL:='RT';
  DIR:=paramstr(1);
  getdir(0,DORIG);
  for I:=1 to length(paramstr(1)) do DIR[I]:=upcase(DIR[I]);
 {$I-}
  chdir(DIR);
 {$I+}
  if IORESULT<>0
    then
      begin
        writeln('Erro no acesso ao direct¢rio...');
        writeln;
        halt(1);   { Sai retornando erro 1 se n„o existir o direct¢rio }
      end;
  writeln('Escreva ',PAL,' para voltar...');
  writeln;
  getdir(0,DIR);
  write(DIR+'>');     { Imprime o PROMPT (inalter vel) }
  readln(COM);
  TEMP:=COM;
  for I:=1 to length(TEMP) do TEMP[I]:=upcase(TEMP[I]);
  while TEMP<>PAL do       { Executa at‚ introduzir palavra de retorno }
    begin
      swapvectors;
      exec(getenv('COMSPEC'),'/C '+COM);
      swapvectors;
      getdir(0,DIR);
      writeln;
      write(DIR+'>');   { Imprime o PROMPT (inalter vel) }
      readln(COM);
      TEMP:=COM;
      for I:=1 to length(TEMP) do TEMP[I]:=upcase(TEMP[I]);
    end;
 {$I-}
  chdir(DORIG);  { Volta ao direct¢rio original. }
 {$I+}
   if IORESULT<>0
    then
      begin
        writeln;
        writeln('Erro no acesso ao direct¢rio original...');
        writeln;
        halt(2);  { Sai retornando erro 2 no caso de ouver erro ao voltar }
      end;
End;
{ --------------- }



BEGIN

  writeln;
  writeln('XDIR Vers„o 1.1');
  writeln('(C) Rui Dias Quintino 1993');
  writeln;
  writeln('Para a SPOOLER Magazine');
  writeln;
  if paramcount>=1 then proceed
    else
      begin
        writeln('Sintaxe : XD  < direct¢rio >  [ < palavra de retorno > ]');
        writeln;
        writeln('   Nota : A palavra de retorno por defeito ‚ RT');
        writeln;
      end;

END.