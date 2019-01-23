Unit seguranca;

interface

 uses crt;

 Function FEncripta(st:string):string;
 Function FDesencripta(st:string):string;

implementation

Function FEncripta(st:string):string; { Encripta as variaveis }
var
  i,
  a : shortint;

begin
 for i := 1 to length(st) do
  begin
  a:= ord(st[i])+length(st);
  delete (st,i,1);
  insert (chr(a),st,i);
  end;
  FEncripta := st;
end;

Function FDesencripta(st:string):string; { desencripta as variaveis }
var
  i,
  a : shortint;
begin
 for i := length(st) downto 1 do
  begin
  a:= ord(st[i])-length(st);
  delete (st,i,1);
  insert (chr(a),st,i);
  end;
 FDesencripta := st;
end;
end.