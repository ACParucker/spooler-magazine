uses crt, dos;

const
  TamCodigo = 7;
  Codigo : array[1..TamCodigo] of byte = ($FD, $00, $B8, $00, 
                                          $00, $A0, $0F);

var
  Fonte,Destino  : string;
  Tipo           : string;
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
var
  T: char;

  procedure ObtemUmNomeFicheiro;
  begin
    writeln('Ficheiro fonte: ',Fonte);
    write('Ficheiro destino [');
    fsplit(Fonte, Dir, Nome, Extensao);
    Destino := Dir+Nome+'.BSV';
    write(Destino,']...');
    readln(Destino);
    Destino := Maiusculas(Destino);
    if Destino='' then
      Destino:=Dir+Nome+'.BSV';
  end;

  procedure ObtemDoisNomesFicheiro;
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
    Destino := Dir+Nome+'.BSV';
    write(Destino,']...');
    readln(Destino);
    Destino := Maiusculas(Destino);
    if Destino='' then
      Destino:=Dir+Nome+'.BSV';
  end;

  procedure ObtemTipo;
  begin
    write('Compilar para [C]or ou [M]ono ? ');
    repeat
      T := upcase(readkey);
    until T in ['C','M'];
    writeln(T);
    if T='C' then
      Tipo := '/COR'
    else
      Tipo := '/MONO';
  end;

begin
  if paramcount=0 then
  begin
    ObtemDoisNomesFicheiro;
    ObtemTipo;
  end;
  if paramcount=1 then
  begin
    Tipo := Maiusculas(paramstr(1));
    if (Tipo<>'/MONO') and (Tipo<>'/COR') and (Tipo[1]<>'/') then
    begin
      Fonte := Maiusculas(paramstr(1));
      ObtemUmNomeFicheiro;
      ObtemTipo;
      exit;
    end;
    if (Tipo[1]='/') and (Tipo<>'/MONO') and (Tipo<>'/COR') then
    begin
      writeln(Tipo,' : Parƒmetro inv lido'#10#13);
      halt;
    end;
    ObtemDoisNomesFicheiro;
  end;
  if paramcount=2 then
  begin
    Fonte := Maiusculas(paramstr(1));
    if Fonte[1] = '/' then
    begin
      writeln('Erro de sintaxe.');
      halt;
    end;
    Tipo := Maiusculas(paramstr(2));
    if (Tipo<>'/MONO') and (Tipo<>'/COR') and (Tipo[1]='/') then
    begin
      writeln(Tipo,' : Parƒmetro inv lido');
      halt;
    end;
    if Tipo[1]<>'/' then
    begin
      Destino := Tipo;
      writeln('Ficheiro destino : ',Destino);
      ObtemTipo;
    end;
    if Tipo[1]='/' then
      ObtemUmNomeFicheiro;
  end;
  if paramcount=3 then
  begin
    Fonte := Maiusculas(paramstr(1));
    Destino := Maiusculas(paramstr(2));
    Tipo := Maiusculas(paramstr(3));
    if (Fonte[1]='/') or (Destino[1]='/') then
    begin
      writeln('Erro de sintaxe.');
      halt;
    end;
    if (Tipo<>'/COR') and (Tipo<>'/MONO') then
    begin
      writeln(Tipo,' : Parƒmetro inv lido.');
      halt;
    end;
    writeln('Ficheiro fonte   : ',Fonte);
    writeln('Ficheiro destino : ',Destino);
  end;
  writeln;
end;

procedure DeterminaEnderecoVideo;
begin
  if Tipo='/MONO' then
    Codigo[3] := $B0;
end;

procedure CompilaParaBsv;
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
  write('Compilando ');
  if Tipo='/COR' then
    write('para placas policrom ticas...')
  else
    write('para placas monocrom ticas...');
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
  writeln(#10#13'FOTO2BSV 1.0                        (c) Vasco Veloso 1994'+
          #10#13+
          #10#13'Transforma ficheiros bin rios gravados pelo FOTOGRAFA em'+
          #10#13'ficheiros bin rios no formato BSave.'+
          #10#13+
          #10#13'Sintaxe: FOTO2BSV [origem] [destino] [/MONO | /COR]'+
          #10#13);
  ObtemNomesFicheiros;
  DeterminaEnderecoVideo;
  CompilaParaBsv;
end.