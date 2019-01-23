Program GERADCD;

{ GERADCD 1.3

  Gerador de fxs aleatขrios DCDs para o DECOD

  (C) Rui Dias Quintino 1994

  SPOOLER MAGAZINE



  Rui Dias Quintino
  Rua Licกnio de Carvalho Nง126
  3880 Ovar }




Uses dos,crt;


Const MARCA:string='DCD FILE  (C) RDQ - SPOOLER';




{ ----------------------------------- }
Procedure Proceed;

Var SAIDOS:array [0..255] of boolean;
    TABELA:array [0..255] of byte;
    RESTAM,F,RNDBYTE,J:byte;
    I:0..256;
    FX:file of byte;
    NOMEFX:string[8];


Begin
  for I:=0 to 255 do SAIDOS[I]:=false;
  RESTAM:=255;
  I:=0;
  repeat
    randomize;
    RNDBYTE:=trunc(random(RESTAM+1));
    F:=0;
    J:=0;
    repeat
      J:=J+1;
      if not(SAIDOS[J]) then F:=F+1;
    until F>RNDBYTE;
    RESTAM:=RESTAM-1;
    TABELA[I]:=J;
    SAIDOS[J]:=true;
    I:=I+1;
  until I=256;
  for I:=0 to 255 do
    begin
      for J:=0 to 255 do
        begin
          if (TABELA[I]=TABELA[J]) and (I<>J)
            then
              begin
                writeln('ERRO  ',I,',',J,' : ',TABELA[I],',',TABELA[J]);
                readln;
              end;
        end;
    end;
  NOMEFX:=paramstr(1);
  for I:=1 to 8 do NOMEFX[I]:= upcase(NOMEFX[I]);
  assign(FX,NOMEFX+'.DCD');
 {$I-}
  rewrite(FX);
  if IORESULT<> 0 then
    begin
      writeln;
      writeln('                            IMPOSSVEL CRIAR FX DCD');
      writeln;
      halt;
    end;
 {$I+}
  for I:=1 to 27 do
    begin
      J:=ord(MARCA[I]);
     {SI-}
      write(FX,J);
      if IORESULT<>0 then
        begin
          writeln;
          writeln('            ERRO AO ESCREVER FX');
          writeln;
          halt;
        end;
     {$I+}
    end;
  for I:=0 to 255 do write(FX,TABELA[I]);
  close(FX);
  writeln;
  writeln('                           FX DCD CRIADO COM SUCESSO');
End;
{ ----------------------------------- }




BEGIN

  writeln;
  writeln('                   ษออออออออออออออออออออออออออออออออออออออออป');
  writeln('                   บ                                        บ');
  writeln('                   บ  Gerador de Ficheiros DCD  Verso 1.3  บ');
  writeln('                   บ                                        บ');
  writeln('                   บ       (C) Rui Dias Quintino 1994       บ');
  writeln('                   บ                                        บ');
  writeln('                   บ            SPOOLER MAGAZINE            บ');
  writeln('                   บ                                        บ');
  writeln('                   ศออออออออออออออออออออออออออออออออออออออออผ');
  writeln;
  if paramcount=0
    then
      begin
        writeln;
        writeln('                       SINTAXE :  GERADCD  < NOME DO FX >');
        writeln;
      end
  else proceed;

END.
