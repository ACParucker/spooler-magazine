Program Back;


{
                      浜様様様様様様様様様様様様様様様様�
                      �        BACK -- Vers�o 1.0       �
                      �    (C) Rui Dias Quintino 1993   �
                      �                                 �
                      麺様様様様様様様様様様様様様様様様�
                      �                                 �
                      �    *** SPOOLER  Magazine ***    �
                      �                                 �
                      麺様様様様様様様様様様様様様様様様�
                      �                                 �
                      �        Rui Dias Quintino        �
                      �                                 �
                      � Rua Lic�nio de Cravalho  N� 126 �
                      �            3880 Ovar            �
                      �                                 �
                      藩様様様様様様様様様様様様様様様様�
}




{$M 2000,0,0 }




Uses dos;




{ -------------- }
Procedure Ok;

Var DIR,DORIG:dirstr;
    COM:string;
    I:integer;

Begin
  DIR:=paramstr(1);
  getdir(0,DORIG);         { GUARDA O DIRECT�RIO ORIGINAL. }
 {$I-}
  chdir(DIR);              { MUDA PARA O DIRECT�RIO PEDIDO. }
 {$I+}
  if ioresult <>0
    then
      begin
        writeln('Direct�rio Inv�lido...');
        halt(1);
      end;
  COM:='';
  for I:=2 to paramcount do COM:=COM+paramstr(I)+' ';
  swapvectors;
  exec(getenv('COMSPEC'), '/C '+COM);     { EXECUTA COMANDO. }
  swapvectors;
 {$I-}
  chdir(DORIG);      { RETORNA AO DIRECT�RIO ORIGINAL. }
 {$I+}
  if ioresult<>0
    then
      begin
        writeln('Erro ao voltar para o direct�rio ',DORIG,'...');
        halt(2);
      end;
End;
{ -------------- }





BEGIN

  writeln;
  writeln('**** BACK  Vers�o 1.0 ****');
  writeln('(C) Rui Dias Quintino 1993');
  writeln;
  writeln('**** SPOOLER MAGAZINE ****');
  writeln;
  if paramcount>=2 then ok
    else writeln('Sintaxe :  BACK  < direct�rio >  < comando a executar >');

END.


