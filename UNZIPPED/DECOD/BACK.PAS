Program Back;


{
                      ษอออออออออออออออออออออออออออออออออป
                      บ        BACK -- Verso 1.0       บ
                      บ    (C) Rui Dias Quintino 1993   บ
                      บ                                 บ
                      ฬอออออออออออออออออออออออออออออออออน
                      บ                                 บ
                      บ    *** SPOOLER  Magazine ***    บ
                      บ                                 บ
                      ฬอออออออออออออออออออออออออออออออออน
                      บ                                 บ
                      บ        Rui Dias Quintino        บ
                      บ                                 บ
                      บ Rua Licกnio de Cravalho  Nง 126 บ
                      บ            3880 Ovar            บ
                      บ                                 บ
                      ศอออออออออออออออออออออออออออออออออผ
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
  getdir(0,DORIG);         { GUARDA O DIRECTRIO ORIGINAL. }
 {$I-}
  chdir(DIR);              { MUDA PARA O DIRECTRIO PEDIDO. }
 {$I+}
  if ioresult <>0
    then
      begin
        writeln('Directขrio Inv lido...');
        halt(1);
      end;
  COM:='';
  for I:=2 to paramcount do COM:=COM+paramstr(I)+' ';
  swapvectors;
  exec(getenv('COMSPEC'), '/C '+COM);     { EXECUTA COMANDO. }
  swapvectors;
 {$I-}
  chdir(DORIG);      { RETORNA AO DIRECTRIO ORIGINAL. }
 {$I+}
  if ioresult<>0
    then
      begin
        writeln('Erro ao voltar para o directขrio ',DORIG,'...');
        halt(2);
      end;
End;
{ -------------- }





BEGIN

  writeln;
  writeln('**** BACK  Verso 1.0 ****');
  writeln('(C) Rui Dias Quintino 1993');
  writeln;
  writeln('**** SPOOLER MAGAZINE ****');
  writeln;
  if paramcount>=2 then ok
    else writeln('Sintaxe :  BACK  < directขrio >  < comando a executar >');

END.


