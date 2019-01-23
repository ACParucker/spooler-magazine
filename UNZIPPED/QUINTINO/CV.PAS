Program ConverteV1;

{ Programa Converte Vers„o 1.0

  (C) Rui Dias Quintino 1993


  Para a SPOOLER Magazine }




Const HEXCODE:string ='0123456789ABCDEF';



{ --------------------- }
Procedure HexDec;

{ Converte os valores hexadecimais para decimais. }

Var CODE,I,J,Q,HEXVAL:integer;
    OK:boolean;
    HEX:string[4];
    DEC,NUM:word;


Begin
  HEX:=paramstr(2);
  for I:=1 to 4 do HEX[I]:=upcase(HEX[I]);
  for I:=1 to length(HEX) do
    begin
      OK:=false;
      for J:=1 to 16 do if HEX[I]=HEXCODE[J] then OK:=true;
      if not OK
      then
        begin
          writeln('Valor hexadecimal incorrecto...');
          halt(2);
        end;
    end;
  writeln;
  writeln('Hexadecimal ==> Decimal');
  writeln;
  write(HEX,' (16) ==> ');
  DEC:=0;
  for I:= 1 to length(HEX) do
    begin
      NUM:=1;
      for Q:=length(HEX)-1 downto I do NUM:=NUM*16;
      case HEX[I] of
        'A':HEXVAL:=10;
        'B':HEXVAL:=11;
        'C':HEXVAL:=12;
        'D':HEXVAL:=13;
        'E':HEXVAL:=14;
        'F':HEXVAL:=15;
      else val(HEX[I],HEXVAL,CODE);
      end;
      DEC:=DEC+HEXVAL*NUM;
    end;
  writeln(DEC,' (10)');
End;
{ --------------------- }




{ --------------------- }
Procedure DecHex;

{ Converte os valores decimais para hexadecimais. }

Var DEC,DIVDR:word;
    CODE,RESTO,I:integer;
    HEX:string[4];
    TEMP:string;

Begin
  val(paramstr(2),DEC,CODE);
  DIVDR:=DEC;
  writeln;
  writeln('Decimal ==> Hexadecimal');
  writeln;
  write(DEC,' (10) ==> ');
  HEX:='0000';
  I:=4;
  repeat
    RESTO:=DIVDR-((DIVDR div 16)*16);
    if RESTO>=10 then HEX[I]:=HEXCODE[RESTO+1]
      else
        begin
          str(RESTO,TEMP);
          HEX[I]:=TEMP[1];
        end;
    DIVDR:=DIVDR div 16;
    I:=I-1;
  until DIVDR<16;
  if DIVDR>=10 then HEX[I]:=HEXCODE[DIVDR+1]
      else
        begin
          str(DIVDR,TEMP);
          HEX[I]:=TEMP[1];
        end;
  writeln(HEX,' (16)');
End;
{ --------------------- }




{ --------------------- }
Procedure Converte;

{ Valida parƒmetros e chama a rotina necess ria. }

Var OPCAO:string;
    I:integer;

Begin
  OPCAO:=paramstr(1);
  for I:=1 to length(OPCAO) do OPCAO[I]:=upcase(OPCAO[I]);
  if OPCAO='HD' then hexdec
    else if OPCAO='DH' then dechex
           else
             begin
               writeln('Op‡„o Inv lida...');
               halt(1);
             end;
End;
{ --------------------- }



BEGIN

  writeln;
  writeln('CONVERTE  Vers„o 1.0');
  writeln('(C) Rui Dias Quintino 1993');
  writeln;
  writeln('Para a SPOOLER Magazine');
  writeln;
  if paramcount=2 then converte
    else
      begin
        writeln('Sintaxe :  CV   < op‡„o >   < valor >');
        writeln;
        writeln;
        writeln(' Op‡”es :  HD - Hexadecimal para Decimal');
        writeln;
        writeln('           DH - Decimal para Hexadecimal');
        writeln;
        writeln(' Nota : O valor deve situar-se entre 0 e 65535/FFFF');
        writeln;
      end;

END.