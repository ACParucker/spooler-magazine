uses crt, m256;
var stri : string[8];
    x, y, dx, dy : byte;
    fgraf : file of byte;
    f : string[127];
    op : char;
    matgraf : array[1..255, 1..189] of byte;

procedure im;
var xx, yy, ofs : word;
begin
     acor := 0;
     bar(0, 0, 293, 189);
     ofs := 320;
     for yy := 1 to dy do
        begin
            for xx := 1 to dx do
                mem[$A000:ofs + xx] := matgraf[xx, yy];
            inc(ofs, 320)
        end
end;

procedure proc;
begin
    assign (fgraf, f);  { Elemento Gr fico Bidimencional }
    {$I-}
    reset(fgraf);
    {$I+}
    if ioresult <> 0 then writeln(f,' n„o existe.')
    else begin
          stri := '        ';
          for x := 1 to 8 do
              begin
                   read(fgraf, y);
                   stri[x] := chr(y)
              end;
          read(fgraf, y);    { consumir o #13 }
          if (stri <> 'GRAFAZ 1') and (y <> 13) then
             begin
                  writeln(f, ' n„o ‚ um EGB.');
                  close(fgraf)
             end
          else begin
                    mini;
                    read(fgraf, x);
                    read(fgraf, y);
                    read(fgraf, dx);
                    read(fgraf, dy);

                    inc(dx);  { ajustar as dimens”es }
                    inc(dy);
                    for y := 1 to dy do
                        for x := 1 to dx do
                            read(fgraf, matgraf[x, y]);

                    close(fgraf);
                    im;   { imprimir o EGB }
                    acor := 14;
                    sobre := 0;
                    rectangulo(0, 0, dx + 1, dy + 1);
                    fonte_duplex;
                    poetexto(0, 190,'VERSAO ' + stri[8] +
                               '.0               ALTURA: ' + str_(dy) +
                               '      LARGURA: ' + str_(dx));
                    op := readkey;
                    textmode(80)
               end
         end
end;

begin
    textcolor(lightgray);
    textbackground(black);
    clrscr;

    repeat
          writeln;
          writeln('Nome do ficheiro (incluindo o "path" e extens„o) ?');
          readln(f);
          if f <> '' then proc
    until f = ''
end.




















