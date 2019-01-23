
program spooler_test;
  type
      teste = array [1..255] of string; (* cada string tem 256
bytes *)
                                        (* cada array ter  255*256
bytes *)
                                        (* 65280, quase 64k *)
  var
    P1, P2: ^teste;
    f:integer;
  begin
    Writeln('Antes de pedir a memoria...');
    Writeln('Estao disponiveis ',MemAvail, ' bytes.');
    Writeln('O maior bloco disponivel tem ', MaxAvail, ' bytes.');
    New(P1); new(p2);  (* estamos a alocar 127,5K de RAM *)
    Writeln('Depois de pedir a memoria...');
    Writeln('Estao disponiveis ',MemAvail, ' bytes.');
    Writeln('O maior bloco disponivel tem ', MaxAvail, ' bytes.');
    (* exemplo da afectacao das variaveis *)
    for f:=1 to 255 do
      begin
        p1^[f]:='ola';
        p2^[f]:='ole';
      end;
    Dispose(P1); dispose(p2);
    Writeln('Depois de libertar a memoria...');
    Writeln('Estao disponiveis ',MemAvail, ' bytes.');
    Writeln('O maior bloco disponivel tem ', MaxAvail, ' bytes.');
  end.
