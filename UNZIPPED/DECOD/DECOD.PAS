Program DECOD;


{ DECOD   Verso 1.3

  (C) Rui Dias Quintino 1994

  SPOOLER MAGAZINE


  Rui Dias Quintino

  Rua Licกnio de Carvalho  Nง126
  3880 Ovar }



Uses dos,crt;


Const  MARCA:string='DCD FILE  (C) RDQ - SPOOLER';



{ ---------------------------------- }
Procedure Proceed;

Var FXD:file of byte;
    FX1,FX2:file;
    NFX1,NFX2,NFXD:pathstr;
    TABELAC,TABELAD:array [0..255] of byte;
    BUFFER:array [1..5000] of byte;
    NR,NW:word;
    OPCAO:char;
    P1:string;
    I:0..256;
    J:byte;

Begin
  writeln;
  P1:=paramstr(1);
  P1:=upcase(P1[1]);
  if (P1<>'D') and (P1<>'C')
    then
      begin
        writeln('                              PARMETRO INV‘LIDO');
        writeln;
        halt;
      end;
  NFX1:=paramstr(2);
  NFX2:=paramstr(3);
  NFXD:='';
  if (NFX2[1]='#') or (NFX2='')
    then
      begin
        writeln('                          O ACTUAL FX SER RE-ESCRITO !');
        writeln;
        write('                            QUER CONTINUAR (S/N) ?  ');
        repeat OPCAO:=upcase(readkey) until OPCAO in ['S','N'];
        writeln(OPCAO);
        if OPCAO='N'
          then
            begin
              writeln;
              halt;
            end;
            writeln;
            writeln;
        NFXD:=NFX2;
        delete(NFXD,1,1);
        NFX2:='TEMPDCD.$$$';
      end
  else 
    begin
      NFXD:=paramstr(4);
      delete(NFXD,1,1);
    end;
  if NFXD='' then NFXD:='DEFAULT';
  NFXD:=NFXD+'.DCD';
  assign(FXD,NFXD);
 {$I-}
  reset(FXD);
 {$I+}
  if IORESULT<>0
    then
      begin
        writeln;
        writeln('                               ERRO AO LER FX DCD');
        writeln;
        halt;
      end;
  for I:=1 to 27 do
    begin
     {$I-}
      read(FXD,J);
      if (IORESULT<>0) or (J<>ord(MARCA[I]))
        then
          begin
            writeln('                               ERRO AO LER FX DCD');
            writeln;
            writeln;
            halt;
          end;
     {$I+}
    end;
  for I:=0 to 255 do
    begin
      read(FXD,J);
      TABELAC[I]:=J;
      TABELAD[J]:=I;
    end;
  close(FXD);
  assign(FX1,NFX1);
  assign(FX2,NFX2);
 {$I-}
  reset(FX1,1);
  if IORESULT<>0
    then
      begin
        writeln('                                ERRO AO CONVERTER FX');
        writeln;
        halt;
      end;
  rewrite(FX2,1);
  if IORESULT<>0
    then
      begin
        writeln('                                ERRO AO CRIAR FX');
        writeln;
        halt;
      end;
  repeat
    blockread(FX1,BUFFER,sizeof(BUFFER),NR);
    for I:=1 to NR do
      begin
        if P1='C' then BUFFER[I]:=TABELAC[BUFFER[I]]
          else BUFFER[I]:=TABELAD[BUFFER[I]];
      end;
    blockwrite(FX2,BUFFER,NR,NW);
  until (NR=0) or (NW<>NR);
  if NFX2='TEMPDCD.$$$'
    then
      begin
        close(FX1);
        erase(FX1);
        close(FX2);
        rename(FX2,NFX1);
      end;
  writeln('                            FX CONVERTIDO COM SUCESSO');
  writeln;
End;
{ ---------------------------------- }







BEGIN

  writeln;
  writeln('                   ษออออออออออออออออออออออออออออออออออออออออป');
  writeln('                   บ                                        บ');
  writeln('                   บ DESCODIFICADOR/CODIFICADOR  Verso 1.3 บ');
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
        writeln('           SINTAXE : DECOD  C/D  < NOME DO FX > [ < NOME DO NOVO FX > ]');
        writeln('                                 [ #< NOME DO FX (DES)CODIFICADOR > ]');
        writeln;
      end
  else proceed;

END.



