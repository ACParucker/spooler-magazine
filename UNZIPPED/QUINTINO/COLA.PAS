Program ColaV10;


{ COLA  Vers�o 1.0
  (C) Rui Dias Quintino 1993


  Para a SPOOLER Magazine

  Um utilit�rio de desfraccionamento de fxs.


  Pode (e deve) ser distribu�do livremente desde que n�o seja alterado.

  Sugest�es,Correc��es,Troca de ideas ,para:

  Rua Licin�o de Carvalho  N�126
  3880 Ovar                          }



Uses dos,crt;



{ ----------------- }
Procedure Junta;

Var DIR:dirstr;
    NOME,LAST:string;
    NAME:namestr;
    PARTE:integer;
    X,Y:byte;
    EXT:extstr;
    BUFFER:array[1..14000] of char;
    NUMREAD,NUMWRITTEN:word;
    FROMFX,TOFX:file;
    NOMOREF:boolean;

Begin

  NOMOREF:=false;
  writeln;
  X:=wherex;
  Y:=wherey;
  fsplit(paramstr(1),DIR,NAME,EXT);  { Separa o nome nas suas 3 componentes }
  PARTE:=1;                          { Inicia o n� do bloco }
  assign(TOFX,paramstr(1));
  rewrite(TOFX,1);
  NOME:=NAME+'.001';  {  Nome do 1� bloco ser� naturalmente xxx.001');

  { As linhas seguintes destinam-se a verificar se o 1� fx
    existe e n�o tem atributo "R".Se tal n�o acontece aborta com
    mensagem de erro
    ( PROCESSO IGUAL AO UTILIZADO NO QUEBRA ) }
   {$I-}
    assign(FROMFX,NOME);
    reset(FROMFX,1);
   {$I+}
    if IORESULT<>0
      then
        begin
          writeln('Erro no acesso aos fxs...');
          erase(TOFX);
          close(TOFX);
          halt;
        end;


 { Este ciclo � bastante importante.� executado enquanto existirem fxs
   a "colar" }
  repeat

   { O ciclo seguinte realiza todo o trabalho de jun��o dos fxs
     Copia o fx bloco para a pr�xima posi��o do fx destino,pelo
     que este �ltimo vai sendo sempre acrescentado }
    repeat
      blockread(FROMFX,BUFFER,sizeof(BUFFER),NUMREAD);
      blockwrite(TOFX,BUFFER,NUMREAD,NUMWRITTEN);
      gotoxy(X,Y);
      clreol;
      write('Reunindo  ',PARTE,' � Parte...');
    until (NUMREAD=0) or (NUMWRITTEN<>NUMREAD);

    PARTE:=PARTE+1;     { Novo bloco }

   { Se existe a op��o 'A' apaga os fxs bloco � medida que os processa }
    if (paramstr(2)='a') or (paramstr(2)='A')
      then
        begin
          erase(FROMFX);
          close(FROMFX);
        end
    else close(FROMFX);

   { As linhas seguintes obt�em o nome completo do novo bloco
     Verificam se ele existe e n�o tem atributo "R".Se isto
     n�o acontece � atribu�da � vari�vel NOMOREF o valor true. }
    NOME:=NAME;
    str(PARTE,LAST);
    case PARTE of
      1..9:NOME:=NOME+'.00'+LAST;
      else NOME:=NOME+'.0'+LAST;
    end;
   {$I-}
    assign(FROMFX,NOME);
    reset(FROMFX,1);
   {$I+}
    if IORESULT<>0 then NOMOREF:=true;

  until NOMOREF; { At� NOMOREF ter o valor true (N�o existem mais fxs) }
  gotoxy(X,Y);
  clreol;
  writeln('Reconstru��o de fx terminada...');
  close(TOFX);

End;
{ ----------------- }



BEGIN

 { Tro�o principal do programa
  - Imprime Introdu��o
  - Apresenta modo de utiliza��o e acaba se n�o foi dado ao programa
    qualquer par�metro
  - Se foi dado pelo menos 1 par�metro executa a procedure Junta  }
  writeln;
  writeln('COLA  Vers�o 1.0');
  writeln('(C) Rui Dias Quintino 1993');
  writeln;
  writeln('Para a SPOOLER Magazine');
  if paramcount>=1 then junta
    else
      begin
        writeln;
        writeln('Sintaxe :  COLA  < fx a reagrupar >   [ A ]');
        writeln;
        writeln('           A - Apaga os fxs .001 , .002 ,etc');
      end;

END.