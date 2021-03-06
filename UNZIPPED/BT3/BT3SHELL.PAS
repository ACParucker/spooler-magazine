{ Batch Tools 3
  읕컴 BT3Shell
  Autor 컴컴컴 Luis Manuel Santos Guerra
  Linguagem 컴 Turbo Pascal 6.0
  Objectivo 컴 Uso de DosShell em batch files
  Inicio 컴컴� 94-11-02 컫� v1.0
  Fim 컴컴컴컴 94-11-02 켸

  Nota: Os ficheiros BT3Shell.Pas e BT3Shell.Exe
        s꼘 parte integrante do Batch Tools 3

  Evolu뇙o do programa:
  ...
  93-11-02   - Constru뇙o da procedures FillWin, DosShell, Procura Direct줿io
             - Separa뇙o de DosShell e Procura Direct줿io para BT3Shell.Exe
             - Altera뇯es em Sintaxe

  Bugs?
  Sugest봢s?
  Escreva para:
  
  Luis Manuel Santos Guerra
  Rua Ferreira de Castro, n�6, 2쬭to
  Cova de Piedade
  2800 Almada }
  

program bt3shell (input,output);

{$M 2000,0,0 }

uses
    dos,crt;

var
   com,old_dir,cur_dir : string;


{ UPCASE STRING }
function upcasestr(com:string):string;

var i : integer;

begin
     for i:= 1 to length(com) do
         com[i] := upcase(com[i]);
     upcasestr := com;
end;


{ PROCURA DIRECTORIO }
procedure dir_chk;

begin
     if (ioresult <> 0) or (old_dir = '') then
        begin
             writeln ('Erro: Direct줿io n꼘 encontrado ou inexistente.');
             halt;
        end;
end;


{ DOS SHELL }
procedure dosshell;

begin
     {I-}
     getdir(0,old_dir);
     dir_chk;
     {I+}
     writeln;
     writeln('� Tecle EXIT para voltar � actual sess꼘 DOS �');
     repeat
           getdir(0,cur_dir);
           write(cur_dir,'>');
           readln(com);
           com := upcasestr(com);
           if com <> '' then
           begin
                swapvectors;
                exec(getenv('COMSPEC'), '/C ' + com);
                swapvectors;
                writeln;
                if doserror <> 0 then
                   writeln('Erro: N꼘 foi poss죞el executar o COMMAND.COM');
           end;
     until (com = 'EXIT') or (doserror <> 0);
     write('� Restaurando anterior sess꼘 DOS �');
     {I-}
     chdir(old_dir);
     dir_chk;
     {I+}
     halt;
end;


{ CORPO DO PROGRAMA }
begin
     nosound;
     checkbreak := false;
     dosshell;
end.