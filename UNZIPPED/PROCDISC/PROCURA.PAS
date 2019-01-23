Program Procura(Input,Output);

{Programadores:
               Fernando Pinheiro
               Antonio Sergio Costa
 Data:
      Oliveira de Azem‚is 06/04/93}





Uses Crt,Dos;

var
   Proc:         Boolean;
   Mask:         String;
   Pat,Pat1:     String;
   x:            byte;
   espera:       char;

procedure cabecalho;
begin
     clrscr;
     textBackground(black);
     textcolor(white);
     Writeln;
     Writeln('FILE MANAGER - PROCURA vr 1.00');
     Writeln('FERNANDO PINHEIRO & ANTONIO SERGIO COSTA');
     Writeln;
     textcolor(lightgray);
end;

procedure ajuda;
begin
     if (paramcount<>2)
     then begin
          Writeln('Uso: PROCURA <directorio> <ficheiro>');
          Writeln;
          Writeln('Este programa PROCURA dentro de um dado directorio (e sub-directorios) por um');
          Writeln('ou v rios ficheiros.');
          Writeln;
          Writeln('-Parametros-');
          Writeln('<directorio> : Direct¢rio onde o(s) ficheiros(s) ir /„o ser PROCURAdo(s).');
          Writeln('<ficheiro>   : Ficheiro ou ficheiros a ser(em) PROCURAdo(s).');
          Writeln;
          halt(1);
          end;
end;

function Findpath:string;
begin
     findpath:=paramstr(1);
end;

function FindMask:string;
begin
     Findmask:=paramstr(2);
end;

procedure Changedir(patr:string);
begin
     {$I-};
     chdir(patr);
     if IOresult<>0
     then begin;
          Writeln('Erro ao mudar para o directorio...');
          Writeln;
          Halt(2);
          end;
     {$I+};
end;

Function procur(msk:string;linhas:byte):byte;
var file1:            searchrec;
    direc:            string;
    nfich,i:          word;
    espera:           char;

begin
     findfirst(msk,Archive+ReadOnly+Hidden+SysFile,file1);
     if doserror=0 then Writeln(fexpand(file1.name));
     while doserror=0 do
     begin
          findnext(file1);
          if doserror=0 then
          begin
               Writeln(fexpand(file1.name));
               linhas:=linhas+1;
               if linhas>=23 then
               begin
                    espera:=readkey;
                    linhas:=0;
               end;
          end;
     end;
     findfirst('*.*',Directory,file1);
     nfich:=1;
     if (doserror=0) and ((file1.attr and directory)=directory) and (copy(file1.name,1,1)<>'.')
     then begin
          getdir(0,direc);
          changedir(file1.name);
          linhas:=linhas+procur(msk,linhas);
          changedir(direc);
          findfirst('*.*',$3f,file1);
          end;
      while doserror=0 do
      begin
           findnext(file1);
           nfich:=nfich+1;
           if (doserror=0) and ((file1.attr and directory)=directory) and (copy(file1.name,1,1)<>'.')
           then begin
                getdir(0,direc);
                changedir(file1.name);
                linhas:=linhas+procur(msk,linhas);
                changedir(direc);
                findfirst('*.*',$3f,file1);
                for i:=1 to (nfich-1) do
                     findnext(file1);
                end;
      end;
      Procur:=Linhas;
end;

Begin
     Cabecalho;
     Ajuda;
     pat:=findpath;
     mask:=findmask;
     Writeln('Procurar em: ',pat);
     Writeln('Ficheiro(s) a procurar: ',mask);
     Writeln;
     getdir(0,pat1);
     changedir(pat);
     x:=procur(mask,7);
     if x=23 then espera:=readkey;
     changedir(pat1);
     Writeln;
end.