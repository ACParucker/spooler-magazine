Program SELECT;

{ Select   Vers„o 2.0

  (C) Rui Dias Quintino 1993

  para a SPOOLER Magazine


  Sugest”es, Corre‡”es, Troca de Material Inform tico ?

  Escrevam para :

  Rui Dias Quintino
  Rua Lic¡nio de Carvalho  N§126
  3880 Ovar }



Uses dos,crt;


{$M $4000,0,15000 }



Type FXINFO=^FX_REC;
     FX_REC=record
         NAME:string[12];
         PROX:FXINFO;
         ANT:FXINFO;
         ATTR:word;
         SL:boolean;
         TIME,SIZE:longint;
       end;


Var CABECA,TEMP,CORRENTE,AUX,GUARDA:FXINFO;
    PERCFX,TOTALFXS,NFX,FXSM,FXSE,PERCM,U,I,J,LACTUAL:integer;
    TOTALBYTES,BYTESM,BYTESE:longint;
    AUX2:searchrec;
    FX:file;
    SL:boolean;
    OPCAO:char;
    COM:string;


{ ---------------------- }
Procedure Caixa(X1,Y1,X2,Y2,COR:byte);

{ Desenha Caixas de um determinada cor,
  dada a coordenada do canto superior esquerdo e inferior direito.
  Usada no desenho e apresenta‡„o do ecrƒn. }

Var I:integer;

Begin
  textcolor(COR);
  gotoxy(X1,Y1);write('Ú');
  gotoxy(X2,Y2);write('Ù');
  gotoxy(X2,Y1);write('¿');
  gotoxy(X1,Y2);write('À');
  gotoxy(3,4);
  for I:=X1+1 to X2-1 do
    begin
      gotoxy(I,Y1);write('Ä');
      gotoxy(I,Y2);write('Ä');
    end;
  for I:=Y1+1 to Y2-1 do
    begin
      gotoxy(X1,I);write('³');
      gotoxy(X2,I);write('³');
    end;
End;
{ ---------------------- }




{ ---------------------- }
Procedure LerFxs;

{ Lˆ os fxs do direct¢rio corrente e ordena-os alfabeticamente.
  Ver SPOOLERs 15 e 26 para mais pormenores. }

Begin
  CABECA:=NIL;
  TOTALFXS:=0;
  TOTALBYTES:=0;
  findfirst('*.*',anyfile-directory-sysfile-hidden-volumeid,AUX2);
  while doserror=0 do
    begin
      new(CORRENTE);
      GUARDA^.ANT:=CORRENTE;
      CORRENTE^.NAME:=AUX2.NAME;
      CORRENTE^.TIME:=AUX2.TIME;
      CORRENTE^.SIZE:=AUX2.SIZE;
      CORRENTE^.SL:=false;
      CORRENTE^.PROX:=CABECA;
      CORRENTE^.ANT:=GUARDA;
      CORRENTE^.ATTR:=AUX2.ATTR;
      GUARDA:=CORRENTE;
      CABECA:=GUARDA;
      TOTALFXS:=TOTALFXS+1;
      TOTALBYTES:=TOTALBYTES+CORRENTE^.SIZE;
      findnext(AUX2);
    end;
  for I:=1 to TOTALFXS-1 do
    begin
      AUX:=CABECA;
      GUARDA:=AUX^.PROX;
      for J:=1 to TOTALFXS-1 do
        begin
          if AUX^.NAME>GUARDA^.NAME
            then
              begin
                TEMP^.NAME:=AUX^.NAME;
                AUX^.NAME:=GUARDA^.NAME;
                GUARDA^.NAME:=TEMP^.NAME;
                TEMP^.ATTR:=AUX^.ATTR;
                AUX^.ATTR:=GUARDA^.ATTR;
                GUARDA^.ATTR:=TEMP^.ATTR;
                TEMP^.SIZE:=AUX^.SIZE;
                AUX^.SIZE:=GUARDA^.SIZE;
                GUARDA^.SIZE:=TEMP^.SIZE;
                TEMP^.TIME:=AUX^.TIME;
                AUX^.TIME:=GUARDA^.TIME;
                GUARDA^.TIME:=TEMP^.TIME;
                TEMP^.SL:=AUX^.SL;
                AUX^.SL:=GUARDA^.SL;
                GUARDA^.SL:=TEMP^.SL;
              end;
          AUX:=AUX^.PROX;
          GUARDA:=AUX^.PROX;
        end;
    end;

End;
{ ---------------------- }




{ ---------------------- }
Procedure DesligaCursor;

{ Desliga o Cursor. }

Var R:registers;

Begin
  R.ah:=01;
  R.ch:=40;
  R.cl:=0;
  intr($10,R);
End;
{ ---------------------- }



{ ---------------------- }
Procedure Barra(LINHA:integer);

{ Desenha a barra de selec‡„o numa dada linha. }
 
Begin
  LINHA:=LINHA+7;
  gotoxy(27,LINHA);write('±');
  gotoxy(40,LINHA);write('±');
End;
{ ---------------------- }




{ ---------------------- }
Procedure Actualizar;

{ Actualiza variada informac‡„o relativa aos fxs seleccionados. }

Begin
  gotoxy(28,17);write('Fxs Sel. : ',FXSM,' Fxs, ',BYTESM,' Bytes           ');
  gotoxy(28,19);write('Fxs N.Sel. : ',TOTALFXS-FXSM,' Fxs, ',TOTALBYTES-BYTESM,' Bytes            ');
  PERCFX:=round((100.0*NFX)/TOTALFXS);
  gotoxy(35,5);write(TOTALBYTES,' Byte(s) em ',TOTALFXS,' Fx(s)     ',PERCFX,'%','      ');
End;
{ ---------------------- }




{ ---------------------- }
Procedure Imprime(LINHA:integer;FX:FXINFO);

{ Imprime a informa‡„o relativa a um fx numa dada linha. }

Var FXT:datetime;
    TEMP:string;

Begin
  if FX^.SL then textcolor(lightred)
    else textcolor(lightcyan);
  LINHA:=LINHA+7;
  gotoxy(28,LINHA);write(FX^.NAME,' ':12-length(FX^.NAME));
  gotoxy(44,LINHA);write(FX^.SIZE:9);
  unpacktime(FX^.TIME,FXT);
  gotoxy(55,LINHA);
  if FXT.DAY<10 then write(' ');
  write(FXT.DAY,'-');
  if FXT.MONTH<10 then write('0');
  write(FXT.MONTH,'-');
  str(FXT.YEAR,TEMP);
  delete(TEMP,1,2);
  write(TEMP);
  gotoxy(65,LINHA);
  if FXT.HOUR<10 then write(' ');
  write(FXT.HOUR,':');
  if FXT.MIN<10 then write('0');write(FXT.MIN);
  gotoxy(72,LINHA);
  if FX^.ATTR and readonly<>0 then write('R')
    else write('.');
  if FX^.ATTR and archive<>0 then write('A')
    else write('.');
    textcolor(lightcyan);
End;
{ ---------------------- }




{ ---------------------- }
Procedure LigaCursor;

{ Liga o Cursor. }

Var R:registers;

Begin
  R.ah:=01;
  R.ch:=3;
  R.cl:=4;
  intr($10,R);
End;
{ ---------------------- }




{ ---------------------- }
Procedure RodaBaixo;

{ Roda a lista de fxs uma linha para baixo. }

Begin
  I:=1;
  GUARDA:=CORRENTE;
  while (I<>6) and (CORRENTE<>NIL) do
    begin
      imprime(LACTUAL+I,CORRENTE);
      CORRENTE:=CORRENTE^.PROX;
      I:=I+1;
    end;
  CORRENTE:=GUARDA;
End;
{ ---------------------- }




{ ---------------------- }
Procedure Esconde;

{ Esconde os fxs que n„o dever„o sofrer o comando. }
 
Var ATTR:word;

Begin
  CORRENTE:=CABECA;
  while CORRENTE<>NIL do
    begin
      if((not SL) and (CORRENTE^.SL)) or (SL and (not CORRENTE^.Sl))
        then
          begin
            assign(FX,CORRENTE^.NAME);
            getfattr(FX,ATTR);
            ATTR:=ATTR+hidden;
            setfattr(FX,ATTR);
          end;
      CORRENTE:=CORRENTE^.PROX;
    end;
End;
{ ---------------------- }





{ ---------------------- }
Procedure Mostra;

{ Recupera os atributos originais dos fxs alterados pela procedure ESCONDE. }

Var ATTR:word;

Begin
  CORRENTE:=CABECA;
  while CORRENTE<>NIL do
    begin
      if((not SL) and (CORRENTE^.SL)) or (SL and (not CORRENTE^.Sl))
        then
          begin
            assign(FX,CORRENTE^.NAME);
            getfattr(FX,ATTR);
            ATTR:=ATTR-hidden;
            setfattr(FX,ATTR);
          end;
      CORRENTE:=CORRENTE^.PROX;
    end;
End;
{ ---------------------- }





{ ---------------------- }
Procedure RodaCima;

{ Roda a lista de fxs uma posi‡„o para cima. }

Begin
  I:=1;
  GUARDA:=CORRENTE;
  while (I<>6) and (CORRENTE<>NIL) do
    begin
      imprime(LACTUAL-I,CORRENTE);
      CORRENTE:=CORRENTE^.ANT;
      I:=I+1;
    end;
  CORRENTE:=GUARDA;
End;
{ ---------------------- }




{ ---------------------- }
Procedure TudoOk;

{ Procedure principal do programa.
  Coordena as v rias sub-rotinas, imprime o men£, executa o comando, etc. }

Begin
  lerfxs;
  if TOTALFXS=0
    then
      begin
        writeln('N„o existem Fxs no direct¢rio presente...');
        writeln;
        halt;
      end;
  clrscr;
  textmode(co80);
  desligacursor;
  COM:='';
  for I:=1 to paramcount do COM:=COM+paramstr(I)+' ';
  textbackground(black);
  caixa(1,3,25,15,green);
  caixa(26,3,79,15,green);
  caixa(26,16,79,20,green);
  caixa(1,21,79,25,green);
  caixa(1,16,25,20,green);
  textcolor(yellow);
  gotoxy(2,1);write(COM);
  textcolor(lightcyan);
  gotoxy(9,23);write('SELECT V2.0  (C) Rui Dias Quintino 1993 para a SPOOLER MAGAZINE':red);
  NFX:=1;
  PERCFX:=round(100/TOTALFXS);
  gotoxy(35,5);write(TOTALBYTES,' Byte(s) em ',TOTALFXS,' Fx(s)     ',PERCFX,'%');
  gotoxy(4,5);write('Esc - Sai para o Dos');
  gotoxy(4,7);write('Enter - Executa Com.');
  gotoxy(6,10);write('Teclas do Cursor');
  gotoxy(6,11);write('    PgDn/PgUp   ');
  gotoxy(5,13);write('Spc para Marcar Fx');
  gotoxy(4,18);write('(E)XCLUI      [   ]');
  FXSM:=0;
  BYTESM:=0;
  gotoxy(28,17);write('Fxs Sel. : ',FXSM,' Fxs, ',BYTESM,' Bytes');
  gotoxy(28,19);write('Fxs N.Sel. : ',TOTALFXS-FXSM,' Fxs, ',TOTALBYTES-BYTESM,' Bytes');
  CORRENTE:=CABECA;
  SL:=true;
  I:=1;
  while (CORRENTE<>NIL) and (I<>7) do
    begin
      imprime(I,CORRENTE);
      CORRENTE:=CORRENTE^.PROX;
      I:=I+1;
    end;
  BYTESM:=0;
  CORRENTE:=CABECA;
  LACTUAL:=1;
  barra(LACTUAL);
  NFX:=1;
  repeat
    OPCAO:=upcase(readkey);
    if OPCAO='E'
      then
        begin
          gotoxy(20,18);
          if Sl
            then
             begin
               SL:=false;
               textcolor(yellow);write('û');
             end
           else
             begin
               SL:=true;
               write(' ');
             end;
          textcolor(lightcyan);
          actualizar;
          sound(300);
          delay(20);
          nosound;
        end
    else if OPCAO=#27
          then
            begin
              textcolor(lightgray);
              textmode(co80);
              ligacursor;
              halt;
            end
    else if (OPCAO=' ') 
           then
             begin
               CORRENTE^.SL:=not(CORRENTE^.SL);
               imprime(LACTUAL,CORRENTE);
               if NFX<>TOTALFXS then NFX:=NFX+1;
               if CORRENTE^.SL
                 then
                   begin
                     FXSM:=FXSM+1;
                     BYTESM:=BYTESM+CORRENTE^.SIZE
                   end
                 else
                   begin
                     FXSM:=FXSM-1;
                     BYTESM:=BYTESM-CORRENTE^.SIZE;
                   end;
               actualizar;
               if (CORRENTE^.PROX<>NIL)
                 then
                   begin
                     if LACTUAL=6 then rodacima;
                     gotoxy(27,LACTUAL+7);write(' ');
                     gotoxy(40,LACTUAL+7);write(' ');
                     if LACTUAL<>6 then LACTUAL:=LACTUAL+1;
                     CORRENTE:=CORRENTE^.PROX;
                     imprime(LACTUAL,CORRENTE);
                     barra(lactual);
                     actualizar;
                   end;
             end
    else if OPCAO=#0
      then
        begin
          OPCAO:=readkey;
          if (OPCAO='H') and (NFX<>1)
            then
              begin
                if LACTUAL=1 then rodabaixo;
                gotoxy(27,LACTUAL+7);write(' ');
                gotoxy(40,LACTUAL+7);write(' ');
                CORRENTE:=CORRENTE^.ANT;
                if LACTUAL<>1 then LACTUAL:=LACTUAL-1;
                imprime(LACTUAl,CORRENTE);
                barra(LACTUAL);
                NFX:=NFX-1;
                actualizar;
              end;
           if (OPCAO='P') and (NFX<>TOTALFXS)
             then
               begin
                 if LACTUAL=6 then rodacima;
                 gotoxy(27,LACTUAL+7);write(' ');
                 gotoxy(40,LACTUAL+7);write(' ');
                 CORRENTE:=CORRENTE^.PROX;
                 if LACTUAL<>6 then LACTUAL:=LACTUAL+1;
                 imprime(LACTUAl,CORRENTE);
                 barra(LACTUAL);
                 NFX:=NFX+1;
                 actualizar;
               end;
            if (OPCAO='Q') and (NFX<>TOTALFXS)
             then
               begin
                 U:=1;
                 while (U<=6) and (NFX<>TOTALFXS) do
                   begin
                     if LACTUAL=6 then rodacima;
                     gotoxy(27,LACTUAL+7);write(' ');
                     gotoxy(40,LACTUAL+7);write(' ');
                     CORRENTE:=CORRENTE^.PROX;
                     if LACTUAL<>6 then LACTUAL:=LACTUAL+1;
                     imprime(LACTUAl,CORRENTE);
                     barra(LACTUAL);
                     NFX:=NFX+1;
                     U:=U+1;
                   end;
                 actualizar;
               end;
            if (OPCAO='I') and (NFX<>1)
              then
                begin
                  U:=1;
                  while (U<=6) and (NFX<>1) do
                    begin
                      if LACTUAL=1 then rodabaixo;
                      gotoxy(27,LACTUAL+7);write(' ');
                      gotoxy(40,LACTUAL+7);write(' ');
                      CORRENTE:=CORRENTE^.ANT;
                      if LACTUAL<>1 then LACTUAL:=LACTUAL-1;
                      imprime(LACTUAl,CORRENTE);
                      barra(LACTUAL);
                      NFX:=NFX-1;
                      U:=U+1;
                    end;
                  actualizar;
                end;
        end;
  until OPCAO=#13;
  esconde;
  textcolor(lightgray);
  clrscr;
  ligacursor;
  swapvectors;
  exec(getenv('COMSPEC'),'/C '+COM);
  swapvectors;
  mostra;
  writeln;
  desligacursor;
  writeln('Prima uma tecla...');
  OPCAO:=readkey;
  ligacursor;
  clrscr;
  caixa(1,1,32,6,green);
  textcolor(lightcyan);
  gotoxy(2,2);write('Rui Dias Quintino');
  gotoxy(2,4);write('Rua Lic¡nio de Carvalho  N§126');
  gotoxy(2,5);write('3880 Ovar');
  writeln;
  writeln;
  textcolor(lightgray);
End;
{ ---------------------- }




BEGIN

  writeln;
  writeln('SELECT   Vers„o 2.0');
  writeln('(C) Rui Dias Quintino 1993');
  writeln;
  writeln('Para a SPOOLER Magazine');
  writeln;
  if paramcount=0
    then
      begin
        writeln('Sintaxe :  SL  < comando >');
        halt;
      end
    else tudook;

END.


