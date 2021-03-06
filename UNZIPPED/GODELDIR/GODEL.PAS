{=============================================================================
Nuno Antunes & Jorge Salgado

                Programa para apagar direct�rios ultra-r�pido

                                                              V 1.0 (c) 1994
============================================================================}
program godir;

uses crt,dos;

{$S-}

var
 cpath:pathstr;
 direc:pathstr;
 dirname,namedir:string;
 y:integer;

procedure apagafich;

var dirinfo:searchrec;
    f:file;

begin
 findfirst('*.*',anyfile,dirinfo);
 while doserror=0 do
  begin
   with dirinfo do
    begin
     if (attr<>directory) and (attr<>volumeid) then
      begin
       assign(f,name);
       setfattr(f,archive);
       erase(f);
      end;
     if (attr=directory) and (name<>'..') and (name<>'.') then
      begin
       chdir(name);
       apagafich;
       chdir('..');
       rmdir(name);
      end;
    end;
   findnext(dirinfo);
  end;
end;

procedure apagadir;
begin
 chdir('\');
 rmdir(direc);
end;

procedure confirma;
var con:char;

begin
 repeat
  con:=readkey;
  if con=#27 then
   begin
    chdir(cpath);
    halt
   end;
 until con in ['s','S','n','N'];
 if con in ['s','S'] then
  begin
   apagafich;
   apagadir;
   writeln;
   halt;
  end;
end;

procedure go_dir;
var dirInfo: searchrec;
begin
 findfirst('*.*',directory,dirinfo);
 while doserror=0 do
  begin
   if (dirinfo.attr=directory) and (dirinfo.name<>'.')and
      (dirinfo.name<>'..') then
    begin
     chdir(dirinfo.name);
     namedir:=copy(dirinfo.name,1,length(dirname));
     if namedir=dirname then
      begin
       getdir(0,direc);
       gotoxy(1,y);
       delline;
       gotoxy(1,y);
       write('Apagar ',direc,' (s/n)',' ');
       confirma;
      end;
     go_dir;
     chdir('..');
    end;
   findnext(dirinfo);
  end;
end;

function maiusculas(stg:string):string;
var
 i : integer;
begin
 for i := 1 to length(stg) do
  begin
   stg[i] := upcase(stg[i]);
  end;
 maiusculas:=stg;
end;

procedure nparm;
begin
 writeln('USAR: GODIR <nome da directoria>');
 halt;
end;

begin
 checkbreak:=false;
 textcolor(11);        {================ Por motivos de seguran�a ===============}
 writeln('PRO  SOFT    ',chr(78),chr(117),chr(110),chr(111),' ',chr(65),chr(110),
                         chr(116),chr(117),chr(110),chr(101),chr(115),' ',chr(38),' ',
                         chr(74),chr(111),chr(114),chr(103),chr(101),' ',chr(83),
                         chr(97),chr(108),chr(103),chr(97),chr(100),chr(111));
                      {================ Por motivos de seguran�a ===============}
 textcolor(12);
 write('GO-DEL  V1.0           Copyright (c) 1994');
 textcolor(7);
 writeln;
 y:=whereY;
 if paramcount=0 then nparm;
 dirname:=maiusculas(paramstr(1));
 getdir(0,cpath);
 chdir('\');
 go_dir;
 {$I-}chdir(cpath){$I-};
 if ioresult<>0 then chdir('\');
end.