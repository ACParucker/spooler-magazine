Program QuebraV10;



{ QUEBRA Vers„o 1.0
  (C) Rui Dias Quintino 1993

  Para a SPOOLER Magazine

  Um utilit rio de fraccionamento de fxs.


  Pode (e deve) ser distribu¡do livremente desde que n„o seja alterado.

  Sugest”es,Correc‡”es,Troca de ideas ,para :

  Rua Licin¡o de Carvalho  N§126
  3880 Ovar                          }



{$M 17384,0,0}   { Aumenta o stack para 17384 bytes
                   Necess rio para a procedure }


Uses dos,crt;


Const MAXPARTES=99;   { Define o tamanho m ximo de blocos que poder„o
                        ser gerados }



{ ----------------- }
Procedure Break;

{ Procedure que trata de todo o processamento na divis„o do fx }
 
Var FROMFX,TOFX:file;
    TOTALTOCOP,TOTALCOP:real;
    COPIED,FXSIZE:LONGINT;
    I,PARTES:0..MAXPARTES;
    PERC:1..100;
    LAST,NOME:string;
    SIZES:array[1..MAXPARTES] of longint;
    BUFFER:array[1..14000] of char;
    NUMREAD,NUMWRITTEN:word;
    BYTES:longint;
    X,Y:byte;
    PATH:pathstr;
    DIR:dirstr;
    NAME:namestr;
    EXT:extstr;


Begin

 { As linhas seguintes destinam-se a verificar se o fx dado
   atrav‚s do parƒmetro ‚ v lido.Se este n„o existe ou tem atributo 'R'
   ent„o o programa aborta a execu‡„o ,imprimindo uma mensagem de erro }
 {$I-}
  assign(FROMFX,paramstr(1));
  reset(FROMFX,1);
 {$I+}
  if ioresult<>0
    then
      begin
        writeln;
        writeln('Erro no acesso ao ficheiro...');
        halt;
      end;

  fsplit(paramstr(1),DIR,NAME,EXT);  { Separa o nome em 3 componentes }
  writeln;
  writeln;
  X:=wherex;
  Y:=wherey;
  if Y=25 then Y:=Y-1;
  TOTALCOP:=0;
  TOTALTOCOP:=filesize(FROMFX);
  PARTES:=0;


 { O ciclo seguinte destina-se a recolher do utilizador o tamanho de cada
   bloco at‚ que se perfa‡a ou ultrapasse o tamanho do fx. ou se atinja
   o valor m ximo de blocos (99) }
  repeat
    begin
      gotoxy(X,Y);
      clreol;
      write('TOTAL : ',round(TOTALCOP),'  RESTAM : ',round(TOTALTOCOP-TOTALCOP),'   Tamanho da ',PARTES+1,'¦ parte : ');
      read(SIZES[PARTES+1]);
      TOTALCOP:=TOTALCOP+SIZES[PARTES+1];
      PARTES:=PARTES+1;
    end;
  until (TOTALCOP>=TOTALTOCOP) or (PARTES=MAXPARTES);


 { Estas linhas servem para verificar se a soma do tamanho dos v rios blocos
   difere do tamanho do fx .Se sim aborta com mensagem de erro. }
  if TOTALCOP<>TOTALTOCOP
    then
      begin
        writeln;
        writeln('Valores n„o aceit veis...');
        halt;
      end;

  TOTALCOP:=0;  { n§ de bytes j  copiados do fx original }


 { Aqui se inicia o ciclo mais importante ,ou seja aquele que realiza
   grande parte do trabalho de manipula‡„o e o fraccionamento dos fxs }
  for I:= 1 to PARTES do
    begin
      NOME:=NAME;
      COPIED:=0;  { n§ de bytes j  copiados do fx original para o novo fx }
      str(I,LAST);
      case I of                          { Define o nome e a ext do fx. }
        1..9:NOME:=NOME+'.00'+LAST;      { que conter  o novo bloco }
        else NOME:=NOME+'.0'+LAST;       { Nome ‚ o nome original do fx. }
      end;                               { Ext. ‚ dada pelo n§ do bloco }
      assign(TOFX,NOME);
      seek(FROMFX,round(TOTALCOP));      { Procura posi‡„o seguinte no fx original }
      rewrite(TOFX,1);


     { Este ciclo copia os bytes requesitados a partir da posi‡„o seguinte
       do fx.original para o novo bloco }
      repeat
        if COPIED+14000>SIZES[I] then BYTES:=SIZES[I]-COPIED { Define n§ de bytes a utilizar do buffer }
        else BYTES:=sizeof(BUFFER);
        blockread(FROMFX,BUFFER,BYTES,NUMREAD);
        blockwrite(TOFX,BUFFER,NUMREAD,NUMWRITTEN);
        COPIED:=COPIED+NUMREAD;
        TOTALCOP:=TOTALCOP+NUMREAD;
        gotoxy(1,y);
        clreol;
        PERC:=round((TOTALCOP*100)/TOTALTOCOP);
        write('Parte ',I,' de ',PARTES,'  > ',PERC,' %');
      until (COPIED=SIZES[I]);
      close (TOFX);
    end;


 { Se o 2§ parƒmetro ‚ "a" ou "A" ent„o apaga o fx original ap¢s a sua divi-
   s„o }
  if (paramstr(2)='a') or (paramstr(2)='A') then erase(FROMFX);

  close(FROMFX);   {Fecha fx original }

 { Informa de como se deve reunir o fx novamente }
  writeln;
  writeln;
  writeln('Para reagrupar escreva  : COLA ',paramstr(1));

End;
{ ----------------- }



BEGIN

 { Tro‡o principal do programa
   - Imprime Introdu‡„o
   - Apresenta modo de utiliza‡„o e acaba se n„o foi dado ao programa
     qualquer parƒmetro
   - Se foi dado pelo menos 1 parƒmetro executa a procedure Break  }
  writeln;
  writeln('Quebra   Vers„o 1.0');
  writeln('(C) Rui Dias Quintino 1993');
  writeln;
  writeln('Para a SPOOLER Magazine');
  if paramcount>=1 then break
    else
      begin
        writeln;
        writeln('Sintaxe :  QUEBRA  < fx a fraccionar >   [ A ]');
        writeln;
        writeln('           A - apaga o fx original');
      end;

END.