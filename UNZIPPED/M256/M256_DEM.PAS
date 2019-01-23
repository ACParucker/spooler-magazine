program MCGA_demo;
uses crt, m256;
var con : word;
    pal : tip_pal;
    f : file of byte;
    blas : array[1..115, 1..24] of byte;

    procedure blast;
  { carrega o gr fico 'BLAST' para o array blas }
     var x, y, dx, dy : byte;begin
        assign(f, 'blast.EGB');   reset(f);
        for x := 1 to 11 do
            read(f, y);
        read(f, dx);             read(f, dy);
        inc(dx);  inc(dy);
        for y := 1 to dy do
            for x := 1 to dx do read(f, blas[x, y]);
        close(f)
     end;

     procedure blastgr(x, y : word);
  { imprime o gr fico 'BLAST' na pos (x,y) }
     var px, py : integer;
         row, bit : byte;
     begin
          py := y * 320;
          for row := 1 to 24 do begin
              px := py + x;
              for bit := 1 to 115 do
              begin
                   if blas[bit, row] <> 0 then
                      mem[$A000:px] := blas[bit, row];
                   inc(px)
              end;
              inc(py, 320)
          end
     end;

     procedure texto(a : byte);
   { imprime 'MCGA 256  MCGA 256..' de alto a baixo no ecran }
     begin
          con := a;
          sobrep(on);
          repeat
                poetexto(1, con, 'MCGA 256  MCGA 256  MCGA 256  MCGA 256  MCGA 256  MCGA 256');
                inc(con, 10)
          until con > 194;
          sobrep(off)
     end;

begin
     mini;          { colocar em MCGA }
     blast;         { carregar o gr fico 'BLAST' }
     paleteA(pal);  { definir uma palete }
     ligapal(pal);  { activar a palete definida }
     fundo(0);      { cor do fundo e limpar ecran }

     for con := 32 to 95 do
         begin                   { cantos }
            acor := con - 32;
            rectaASM (con, 0, 0, con);
            rectaASM (320 - con, 0, 320, con)
         end;

     for con := 96 to 158 do
         begin                   { cantos }
            acor := 158 - con;
            rectaASM (con, 0, 0, con);
            rectaASM (320 - con, 0, 320, con)
         end;

     fonte_duplex; { activar a fonte duplex }
     acor := 128;  { activar a cor 128 }
     texto(2);   { imprimir 'MCGA 256  MCGA 256 ...'(a partir da coluna 2) }
     readkey;

     fundo(0);   { cor do fundo }
     for con := 32 to 95 do begin
       acor := con - 32;            { foco de luz }
       rectaASM (0, 0, con, 199);
       rectaASM (319, 0, con+ 129, 199);
     end;

     for con := 96 to 158 do begin
       acor := 158 - con;           { foco de luz }
       rectaASM (0, 0, con, 199);
       rectaASM (319, 0, con+ 129, 199);
     end;

     acor := 64;
     texto(1);   { imprimir 'MCGA 256  MCGA 256 ...' }
     readkey;
     fundo(0);

     for con := 0 to 63 do begin
         acor := 63 - con;         { linhas horizontais com gradua‡„o de cor }
         recta(0, con, 319, con);
         recta(0, con + 127, 319, con + 127)
     end;

     for con := 63 downto 0 do begin
         acor := con;              { linhas horizontais com gradua‡„o de cor }
         recta(0, con + 63, 319, con + 63)
     end;

     ligacor(192);       { activar a cor 192 }
     texto(1);           { imprimir 'MCGA 256  MCGA 256 ...' }
     blastgr(102, 52);   { imprimir 'BLAST' }
     readkey;

     fundo(0);      { cor do fundo }
     paleteB(pal);  { definir uma palete }
     ligapal(pal);  { activar a palete definida }
     for con := 0 to 19 do begin
         acor := con + 10 + random(150);  { escolher uma cor }
         tapa(on, random(155) + 100);  { tapa=on com cor de fundo aleat¢ria }
         poetexto(0, 2 + con * 10, ' POETEXTO COM TAPA=ON ');
         tapa(off, 0);
         poetexto(157, 2 + con * 10, ' POETEXTO COM TAPA=OFF ')
     end;

     readkey;
     repeat until not(keypressed); { esperar que a tecla seja despressionada }
     acor := 6;
     bar(120, 50, 200, 81);
     acor := 100;
     rectangulo(120, 50, 200, 81);
     acor := 20;
     poetexto(137, 62, 'PCICLO');
     circulo(160, 99, 105);
     circulo(160, 99, 65);

     repeat
           pciclo(pal);   { fazer um ciclo … palete }
           delay(30);     { pequeno atraso }
           ligapal(pal)   { activar a palete rodada }
     until keypressed;    { repeti‡„o at‚ ser pressionada uma tecla }

     textmode(lastmode);
     writeln('  Qualquer informa‡„o, telfs. 4956868 ou 4952152 ou 4951297.');
     writeln('  Aguarde NOVIDADES! ');
     writeln
end.