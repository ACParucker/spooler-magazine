{ Batch Tools 3
  ÀÄÄÄ BT3Shell
  Autor ÄÄÄÄÄÄ Luis Manuel Santos Guerra
  Linguagem ÄÄ Turbo Pascal 6.0
  Objectivo ÄÄ Uso de DosShell em batch files
  Inicio ÄÄÄÄÄ 94-11-02 ÄÂÄ v1.0
  Fim ÄÄÄÄÄÄÄÄ 94-11-02 ÄÙ

  Nota: Os ficheiros BT3Shell.Pas e BT3Shell.Exe
        s„o parte integrante do Batch Tools 3

  Evolu‡„o do programa:
  ...
  93-11-02   - Constru‡„o da procedures FillWin, DosShell, Procura Direct¢rio
             - Separa‡„o de DosShell e Procura Direct¢rio para BT3Shell.Exe
             - Altera‡”es em Sintaxe

  Bugs?
  Sugest”es?
  Escreva para:
  
  Luis Manuel Santos Guerra
  Rua Ferreira de Castro, n§6, 2§dto
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
             writeln ('Erro: Direct¢rio n„o encontrado ou inexistente.');
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
     writeln('ú Tecle EXIT para voltar … actual sess„o DOS ú');
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
                   writeln('Erro: N„o foi poss¡vel executar o COMMAND.COM');
           end;
     until (com = 'EXIT') or (doserror <> 0);
     write('ú Restaurando anterior sess„o DOS ú');
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