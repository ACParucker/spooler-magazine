Program DISCO(input,output);

{Programadores:
               Fernando Pinheiro
               Antonio Sergio Costa
 Data:
      Oliveira de Azem‚is 06/04/93}






uses dos,crt;

var
    tamanhom:   longint;
    livrem:     longint;
    tamanhok:   longint;
    livrek:     longint;
    tamanhop:   longint;
    livrep:     longint;
    tamanho:    Longint;
    livre:      Longint;
    drive:      byte;
    parmtr:     string[2];
    opcao:      string[1];

begin

textbackground(black);
textcolor(white);
Writeln;
Writeln('FILE MANAGER - DISCO vr 1.00');
Writeln('FERNANDO PINHEIRO & ANTONIO SERGIO COSTA');
Writeln;

textcolor(LightGray);

if (paramcount<1) or (paramcount>2)
then begin
     Writeln('Uso: DISCO <drive> [ B | M | K | P | A ]');
     Writeln;
     Writeln('Este programa indica o espa‡o livre de um disco em v rias unidades.');
     Writeln;
     Writeln('-Parametros-');
     Writeln('<drive>: Drive a ser pesqui
     Writeln('B : Indica o espa‡o livre em disco em Bytes');
     Writeln('M : Indica o espa‡o livre em disco em MegaBytes  ');
     Writeln('K : Indica o espa‡o livre em disco em KiloBytes  ');
     Writeln('P : Indica o espa‡o livre em disco em Percentagem');
     Writeln('A : Indica o espa‡o livre em disco em todos os tipos');
     Writeln('(Caso n„o seja indicado nenhum parametro ser  assumida a op‡„o B (Bytes))');
     Writeln;
     halt(1);
     end;

parmtr:=paramstr(1);
if ord(parmtr[1])>90 then parmtr[1]:=chr(ord(parmtr[1])-32);
drive:=ord(parmtr[1])-64;

tamanho:=Disksize(drive);
livre:=Diskfree(drive);

if (tamanho=-1) or (livre=-1)
then begin
     Writeln('Erro no primeiro parametro passado...');
     Writeln;
     halt(2);
     end;

Writeln('Unidade ',parmtr[1],':');
Writeln;

If Paramcount=2 then opcao:=paramstr(2) else opcao:='B'; {Nesta linha pode-se mudar a op‡„o por Default}

If ord(opcao[1])>90 then opcao[1]:=chr(ord(opcao[1])-32);

if (opcao<>'B') and (opcao<>'P') and (opcao<>'K') and (opcao<>'M') and (opcao<>'A')
then begin
     Writeln('Erro no segundo parametro passado...');
     Writeln;
     halt(3);
     end;

If (opcao='B') or (opcao='A')
then begin
     Writeln('   Tamanho do disco em BYTES:         ',tamanho:9);
     Writeln('   Espa‡o livre no disco em BYTES:    ',livre:9);
     Writeln;
     end;

if (opcao='K') or (opcao='A')
then begin
     tamanhok:=tamanho div 1024;
     livrek:=livre div 1024;
     Writeln('   Tamanho do disco em KILOBYTES:     ',tamanhok:9);
     Writeln('   Espa‡o livre no disco em KILOBYTES:',livrek:9);
     Writeln;
     end;


if (opcao='M') or (opcao='A')
then begin
     tamanhom:=tamanho div 1048576;
     livrem:=livre div 1048576;
     Writeln('   Tamanho do disco em MEGABYTES:     ',tamanhom:9);
     Writeln('   Espa‡o livre no disco em MEGABYTES:',livrem:9);
     Writeln;
     end;

if (opcao='P') or (opcao='A')
then begin
     tamanhok:=tamanho div 1024;
     livrek:=livre div 1024;
     tamanhop:=100;
     livrep:=(livrek*100) div tamanhok;
     Writeln('   Tamanho do disco em PERCENTAGEM:     ',tamanhop:7,'%');
     Writeln('   Espa‡o livre no disco em PERCENTAGEM:',livrep:7,'%');
     Writeln;
     end;

end.
