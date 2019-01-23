uses crt, dos;

const
  TamCodigo = 39;
  Codigo : array[1..TamCodigo] of byte = ($B4, $0F, $CD, $10, $3C, $07, $72,
                                          $09, $3C, $0A, $77, $0A, $B8, $00,
                                          $B0, $EB, $08, $B8, $00, $B8, $EB,
                                          $03, $B8, $00, $A0, $8E, $C0, $BF,
                                          $00, $00, $BE, $27, $01, $B9, $D0,
                                          $07, $F3, $A5, $C3);

var
  Fonte,Destino  :string;
  a              : word;
  Dir            : DirStr;
  Nome           : NameStr;
  Extensao       : ExtStr;

function Maiusculas(S:string):string;
var
  A : byte;
begin
  for A:=1 to length(S) do
    S[A] := upcase(S[A]);
  Maiusculas := S;
end;

function Existe(Ficheiro: string): Boolean;
var
  f: file;
begin
  {$I-}
  Assign(f, Ficheiro);
  Reset(f);
  Close(f);
  {$I+}
  Existe := (IOResult = 0) and (Ficheiro <> '');
end;

procedure ObtemNomesFicheiros;
begin
  if paramcount=0 then
  begin
    write('Ficheiro fonte.....');
    readln(Fonte);
    if Fonte='' then
    begin
      writeln('ERRO FATAL: Ficheiro fonte inexistente.');
      halt;
    end;
    Fonte := Maiusculas(Fonte);
    write('Ficheiro destino [');
    fsplit(Fonte, Dir, Nome, Extensao);
    Extensao := '.COM';
    Destino := Dir+Nome+Extensao;
    write(Destino,']...');
    readln(Destino);
    Destino := Maiusculas(Destino);
    if Destino='' then
      Destino:=Dir+Nome+'.COM'
    else
    begin
      fsplit(Destino, Dir, Nome, Extensao);
      if Extensao <> '.COM' then
        Destino := Dir+Nome+'.COM';
    end;
  end;
  if paramcount=1 then
  begin
    Fonte:=paramstr(1);
    Fonte := Maiusculas(Fonte);
    if Fonte[1] = '/' then
    begin
      writeln('N„o s„o aceites interruptores (switches).'#13#10+
              'Sintaxe: FOTO2COM [origem] [destino]');
      halt;
    end;
    writeln('Ficheiro fonte: ',Fonte);
    write('Ficheiro destino [');
    fsplit(Fonte, Dir, Nome, Extensao);
    Extensao := '.COM';
    Destino := Dir+Nome+Extensao;
    write(Destino,']...');
    readln(Destino);
    Destino := Maiusculas(Destino);
    if Destino='' then
      Destino:=Dir+Nome+'.COM'
    else
    begin
      fsplit(Destino, Dir, Nome, Extensao);
      if Extensao <> '.COM' then
        Destino := Dir+Nome+'.COM';
    end;
  end;
  if paramcount=2 then
  begin
    Fonte:=paramstr(1);
    Destino := paramstr(2);
    if (Fonte[1] = '/') or (Destino[1] = '/') then
    begin
      writeln('N„o s„o aceites interruptores (switches).'#13#10+
              'Sintaxe: FOTO2COM [origem] [destino]');
      halt;
    end;
    fsplit(Destino, Dir, Nome, Extensao);
    Extensao := '.COM';
    Destino := Dir+Nome+Extensao;
    writeln('Ficheiro fonte   : ',Maiusculas(Fonte));
    writeln('Ficheiro destino : ',Maiusculas(Destino));
  end;
  writeln;
end;

procedure CompilaParaCom;
var
  FFonte,
  FDestino : file of byte;
  Dado: byte;
  CodErro:word;
  T: char;

  procedure ERRO(Ficheiro:string; CodErro:word);
  var
    Mens: string;
  begin
    case CodErro of
      2: Mens := 'Ficheiro n„o encontrado';
      3: Mens := 'Directoria inv lida';
      5: Mens := 'Acesso negado';
      101: Mens := 'Disco cheio';
      150: Mens := 'Disco protegido contra escrita';
      152: Mens := 'Drive n„o est  pronta';
    else
      Mens := 'ERRO no tratamento do ficheiro';
    end;
    writeln(#13#10,Maiusculas(Ficheiro),' -> ',Mens);
  end;

begin
  {$I-}
  assign(FFonte, Fonte);
  reset(FFonte);
  CodErro := IoResult;
  if CodErro<>0 then
  begin
    ERRO(Fonte, CodErro);
    exit;
  end;
  if Existe(Destino) then
  begin
    write('ATEN€ŽO: Ficheiro de destino j  existente !'#13#10+
          'Reescrever o conte£do (S/N) ? ');
    repeat
      T := upcase(readkey);
    until T in ['S','N'];
    writeln(T);
    if T='N' then
      exit;
    writeln;
  end;
  write('Compilando...');
  assign(FDestino, Destino);
  rewrite(FDestino);
  CodErro := IoResult;
  if CodErro<>0 then
  begin
    ERRO(Destino, CodErro);
    exit;
  end;
  for A:=1 to TamCodigo do
  begin
    write(FDestino, Codigo[A]);
    CodErro := IoResult;
    if CodErro<>0 then
    begin
      ERRO(Destino, CodErro);
      exit;
    end;
  end;
  repeat
    read(FFonte, Dado);
    CodErro := IoResult;
    if CodErro<>0 then
    begin
      ERRO(Fonte, CodErro);
      exit;
    end;
    write(FDestino,Dado);
    CodErro := IoResult;
    if CodErro<>0 then
    begin
      ERRO(Destino, CodErro);
      exit;
    end;
  until eof(FFonte);
  writeln('Compilado.');
end;

begin
  writeln(#10#13'FOTO2COM 1.1                        (c) Vasco Veloso 1994'+
          #10#13+
          #10#13'Transforma ficheiros bin rios gravados pelo FOTOGRAFA em'+
          #10#13'execut veis no formato .COM'+
          #10#13);
  ObtemNomesFicheiros;
  CompilaParaCom;
end.