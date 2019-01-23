const jndx = 120;   jddx = 117;  { constantes que definem as dimens”es de }
      jndy = 50;    jddy = 70;   { duas janelas, uma grande e outra pequena }
      jnix = 91;    jdix = 90;
      jniy = 62;    jdiy = 52;
      on = true;   off = false;


type fich = record
                  nom : string[12];
                  tam : longint;
            end;
const MaxFiles = 512;
var
 { guarda a imagem ocupada pela janela, para que essa imagem seja restituida }
   janela : array[0..120, 0..74] of byte;  { depois }
 { Guarda os nomes e tamanhos dos ficheiros }
   files : array[1..MaxFiles] of fich;
 { nfiles tem o n§ de (fichs + dirs), ndirs tem o n§ de directorias }
   nfiles, ndirs : word;
 { o path actual }
   path : string;




   procedure getim(jix, jiy, jdx, jdy : word);
  { Imprime em (jix, jiy) uma janela com a larg jinix e a altura jiniy.
    Al‚m disso ainda guarda a imagem que a janela ocupa num array.
    O tamanho m x da janela ‚ limitada pelo tamanho do array                  }
   var co, co1, ofs : word;
   begin
       hidemouse;
       ofs := jiy * 320 + jix;
       for co := 0 to jdy do
       begin   { guarda a imagem no array }
           for co1 := 0 to jdx do
           begin
               janela[co1, co] := mem[$A000:ofs];
               inc(ofs)
           end;
           inc(ofs, 319 - jdx)
       end;
       acor := 8;
       bar(jix, jiy, jix + jdx, jiy + jdy);  { 'abre' a janela }
       acor := 10;
       rectangulo(jix, jiy, jix + jdx, jiy + jdy); { imprime uma borda }
       acor := 7
   end;

   procedure putim(jix, jiy, jdx, jdy : word);
   { repor  rea ocupada pela janela }
   var co, co1, ofs : word;
   begin
       ofs := jiy * 320 + jix;
       for co := 0 to jdy do
       begin     { rep”e linha a linha }
           for co1 := 0 to jdx do
           begin { rep”e uma linha }
               mem[$A000:ofs] := janela[co1, co];
               inc(ofs)
           end;
           inc(ofs, 319 - jdx)
       end
   end;

   procedure janp(onoff : boolean); begin
 { Abre ou fecha uma janela pequena. }
       if onoff then getim(jnix, jniy, jndx, jndy)
       else putim(jnix, jniy, jndx, jndy)
   end;

   procedure jang(onoff : boolean); begin
 { Abre ou fecha uma janela grande. }
       if onoff then getim(jdix, jdiy, jddx, jddy)
       else putim(jdix, jdiy, jddx, jddy)
   end;






(*********************************************************************************)
(********* OBTER UMA STRING DO UTILIZADOR                                        *)
var ch : char;

function resp (zx, zy : word) : string;
{ obtem uma string do utilizador }
var tam : byte;
    st : string[8];

     procedure outcar;  
   { imprime a string numa posi‡„o da janela }
     begin
         acor := 8;
         hidemouse;
      { apaga a  rea }
         poetexto(zx, zy, #21#21#21#21#21#21#21#21#21#21#21#21#21);
         acor := 12;
      { imprime a string }
         poetexto(zx, zy, st + #21);
         showmouse
     end;

begin
    st := '';
    tam := 0;
    outcar;
    repeat
          ch := upcase(readkey);
          if ch = #0 then begin
             ch := readkey;
             ch := #1
          end;
       { se f“r um caracter v lido e a string n„o estiver cheia, acrescenta-o
         … string e imprime a string }
          if ((ch in['A'..'Z']) or (ch in['0'..'9']) or (ch = '_')) and
             (tam < 8 ) then begin
                  st := st + ch;
                  outcar;
                  inc(tam)
          end;
        { apagar um caracter da string }
          if (ch = #8) and (tam > 0) then begin
             dec(tam);
             delete(st, length(st), 1);
             outcar
          end
    until ch in[#13, #27];{ pedir um caracter at‚ ser pressionado ESC ou ENTER }
    resp := st
end;





function resp1 (ext : string; a, b : word) : string;
{ Obt‚m uma string do utilizador }
{ Abre uma janela com os ficheiros wicd (*.EGB ou *.PAL), dando ao utilizador }
{ a op‡„o de escolher um ficheiro }
const blarg = 119;
var ch : char;
    pfile : word;  { Cont‚m o 1§ ficheiro (o indice em files) da janela }
    ybarra : byte; { Posi‡„o da barra de sele‡„o, de 0 a 6 }


       procedure introduz_file (nome : string; tamanho : longint);
     { Introduz um ficheiro no array, alfab‚ticamente }
       var ftmp, ftmp1 : fich;
           c : word;
           d : boolean;
       begin
            ftmp.nom := nome;
            ftmp.tam := tamanho;
            d := on;
            for c := (ndirs + 1) to (nfiles) do
                if d then
                   begin
                     if (nome < files[c].nom) or (files[c].nom = '') then
                         begin
                              ftmp1 := files[c];
                              files[c] := ftmp;
                              d := off
                         end
                   end
                else begin
                          ftmp := files[c];
                          files[c] := ftmp1;
                          ftmp1 := ftmp
                     end
       end;

       procedure ler_dir;
     { Preenche a var files c/ 'os pedidos' actuais: ficheiros da directoria }
     { path, com a extens„o ext. Portanto faz como que uma actualiza‡„o.     }
     { NOTA: findfirst e findnext n„o se comportam como deviam...            }
       var f : searchrec;

           function nome (n : string) : string;
         { Dado o nome de um ficheiro com extens„o, devolve apenas o nome }
           var c : byte;
               s : string;
           begin
                c := 1;
                s := '';
                while (n[c] <> '.') and (c <= length(n)) do
                   begin
                        s := s + upcase(n[c]);
                        inc(c)
                   end;
                nome := s
           end;

       begin  { ler_dir }
          { "Limpar" a vari vel, apagando todo e qualquer registo anterior }
            fillchar(files, sizeof(files), 0);
            nfiles := 0;
          { Obter as directorias (s¢ sem extens„o) }
            findfirst(path + '*.*', directory, f);
            if f.name = '.' then findnext(f);    { Ignorar a pr¢pria (.) }
            while (DosError = 0) and (nfiles < MaxFiles) do
                  begin
                       if (f.attr and directory) <> 0 then
                          begin
                               inc(nfiles);
                               files[nfiles].nom := f.name;
                               files[nfiles].tam := -1;
                          end;
                       findnext(f)
                  end;
            ndirs := nfiles;  { guardar o n§ de directorias }
          { Obter os ficheiros }
            findfirst(path + '*.' + ext, archive, f);
            while (DosError = 0) and (nfiles < MaxFiles) do
                  begin
                       inc(nfiles);
                       introduz_file(nome(f.name), f.size);
                       findnext(f)
                  end
       end;   { ler_dir }

       procedure move_baixo;
     { Move a  rea dos ficheiros 1 char para baixo }
       var y, aux1 : word;
       begin
            for y := (b + 62) downto (b + 1) do
            begin
                 aux1 := y * 320 + a + 1;
                 move(mem[$A000:aux1], mem[$A000:aux1 + 320*10], blarg);
            end;
       end;

       procedure move_cima;
     { Move a  rea dos ficheiros 1 char para cima }
       var y, aux1 : word;
       begin
            for y := (b + 11) to (b + 72) do
            begin
                 aux1 := y * 320 + a + 1;
                 move(mem[$A000:aux1], mem[$A000:aux1 - 320*10], blarg);
            end;
       end;

       procedure barra (y : byte);
     { Coloca uma barra com XOR em cima de um nome de ficheiro }
       var aux : word;
       begin
            sobrep(on);
            acor := 6;
            aux := b + 2 + y * 10;
            bar(a + 1, aux, a + blarg, aux + 9);
            sobrep(off);
       end;

       procedure poe_nome (co : word);
       var aux : word;
       begin
            aux := b + 3 + (co - pfile) * 10;
            poetexto(a + 4, aux, files[co].nom);
            if files[co].tam <> -1 then
            poetexto(a + 78, aux, strl(files[co].tam))
            else poetexto(a + 78, aux, '-DIR-');
       end;

       procedure poe_files;
     { Imprime uma p gina de ficheiros }
       var co, aux : word;
       begin
            acor := 8;
            bar(a + 1, b + 1, a + 119, b + 72);
            acor := 7;
            for co := pfile to pfile + 6 do
              if co <= nfiles then poe_nome(co)
       end;

       procedure cima;
       begin
            if (ybarra = 0) then
               begin
                    if (pfile = 1) then exit  { N„o ‚ possivel recuar mais }
                    else begin
                              dec(pfile);
                              hidemouse;
                              barra(ybarra);  { Apagar a barra de posi‡„o }
                              move_baixo;
                              acor := 8;
                              bar(a + 4, b + 3, a + blarg, b + 12);
                              acor := 7;
                              poe_nome(pfile);
                              barra(ybarra);
                         end;
               end
            else begin
                      hidemouse;
                      barra(ybarra);  { Apagar a barra de posi‡„o }
                      dec(ybarra);
                      barra(ybarra);
                 end;
            showmouse;
       end;

       procedure baixo;
       begin
            if (ybarra = 6) then
               begin
                    if (pfile = nfiles - 6) then exit{ N„o ‚ possivel avan‡ar+ }
                    else begin
                              inc(pfile);
                              hidemouse;
                              barra(ybarra);  { Apagar a barra de posi‡„o }
                              move_cima;      { Mover os fichs para cima }
                              acor := 8;
                              bar(a + 4, b + 63, a + blarg, b + 72);
                              acor := 7;
                              poe_nome(pfile+6);{ Colocar o nome do 1§ fich }
                              barra(ybarra);  { Recolocar a barra de pos  }
                         end;
               end
            else begin
                      if (pfile + ybarra + 1) > nfiles then exit;
                      hidemouse;
                      barra(ybarra);  { Apagar a barra de posi‡„o }
                      inc(ybarra);
                      barra(ybarra);  { Barra na nova posi‡„o }
                 end;
            showmouse;
       end;

       procedure _pgup;
     { Mover a listagem 1 p gina para cima }
       const nlin = 7;
       begin
            if pfile = 1 then exit; { pfile => primeiro file a ser mostrado }
            hidemouse;
            barra(ybarra);
            if pfile > nlin then dec(pfile, nlin)
            else begin
                      pfile := 1;
                      ybarra := 0
                 end;
            poe_files;
            barra(ybarra);
            showmouse;
       end;

       procedure _pgdn;
     { Mover a listagem 1 p gina para baixo }
       const nlin = 7;
       begin
          { Se j  est  no fim, sair }
            if (pfile >= (nfiles - 7)) or (nfiles < 7) then exit;
            hidemouse;
            barra(ybarra);
          { Evitar que a barra fique fora dos files quando se move 1 p g
            para baixo }
            if ((pfile + nlin) < nfiles) and
               ((pfile + nlin + ybarra) > nfiles) then
                       ybarra := nfiles - (pfile + nlin);
          { Evitar que pfile tome um valor acima de nfiles }
            if (pfile + nlin) < nfiles then inc(pfile, nlin)
            else begin
                      pfile := nfiles - 7;
                      ybarra := 7
                 end;
            poe_files;
            barra(ybarra);
            showmouse;
       end;

       procedure _home;
     { Mostra a partir do inicio da listagem }
       begin
          { Se j  est  no inicio, sair }
            if (ybarra = 0) and (pfile = 1) then exit;
            hidemouse;
            barra(ybarra);  { Apaga a barra }
            ybarra := 0;    { Barra no principio da listagem }
            pfile := 1;
            poe_files;      { Mostra a listagem }
            barra(ybarra);  { Mostra a barra }
            showmouse;
       end;

       procedure _end;
     { Mostra a £ltima p gina da listagem }
       begin
          { Se j  est  no fim, sair }
            if (pfile >= (nfiles - 6)) or (nfiles < 6) then exit;
            hidemouse;
            barra(ybarra);
          { Barra no final da listagem }
            if nfiles < 7 then ybarra := nfiles else ybarra := 6;
            pfile := nfiles - 6;
            poe_files;
            barra(ybarra);
            showmouse;
       end;

       procedure tratadirs (index : word);
     { Foi selecionado um nome de directoria... }
       var c, c1 : word;
       auxpath : string;

                   procedure novadir;
                 { Ler a nova directoria e imprimir a 1¦ p gina }
                   begin
                        ler_dir;  { Ler os files da dir }
                        hidemouse;
                        barra(ybarra);
                        ybarra := 0;  { Barra no inicio da p gina }
                        pfile := 1;
                        poe_files;
                        barra(ybarra);
                        showmouse
                   end;

       begin  { tratadirs }
          { Se n„o f“r 'voltar … dir anterior', entrar na nova dir }
            if files[index].nom <> '..' then
               begin
                    path := path + files[index].nom + '\';
                    novadir;
                    exit
               end;
          { Retirar da var path a £ltima directoria }
            c := length(path) - 1;
            while path[c] <> '\' do dec(c);
            auxpath := '';
            for c1 := 1 to c do auxpath := auxpath + path[c1];
            path := auxpath;
            novadir
       end;  { tratadirs }

       function ok : string;
     { Selecionado um file.. }
       var index : word;
       begin { ok }
            ch := #1;
          { Obter o ¡ndice do file selecionado na var dfiles }
            index := pfile + ybarra;
          { Verificar se se trata de um file ou uma directoria }
            if files[index].tam = -1 then tratadirs(index)
            else begin
                      ok := files[index].nom; { Retornar o nome do file }
                      ch := #13  { Sinalizar a saida da fun‡„o resp1 }
                 end
       end;  { ok }

       function mouse_ok (my : word) : string;
     { Seleciona um ficheiro de acordo com o local no ecran em que o mouse }
     { foi clicado }
       var index : word;
       begin
            ch := #1;
            index := pfile + ((my - b - 2) div 10);
            if index > nfiles then exit;
          { Verificar se se trata de um file ou uma directoria }
            if (files[index].tam = -1) then tratadirs(index) else
               begin
                    mouse_ok := files[index].nom; { Retornar o nome do file }
                    ch := #13  { Sinalizar a saida da fun‡„o resp1 }
               end;
            esp_br;
       end;

       procedure apagarfile;
     { Apaga um ficheiro }
       const Esc = #27;
       var FileToBeDeleted : string;
           ftbd : file;
           o_ : char;
       begin
          { Se f“r uma directoria, sair }
             if files[pfile + ybarra].tam = -1 then exit;
          { Obter o nome do file }
             FileToBeDeleted := ok;
             esp_br;
             hidemouse;
             barra(ybarra);   { Apagar a barra }
             showmouse;
           { Esperar a confirma‡„o do utilizador }
             o_ := upcase(readkey);
             hidemouse;
             if o_ = 'S' then  { Se foi dada a confirma‡„o, apagar o file }
                begin
                     assign(ftbd, path + FileToBeDeleted + '.' + ext);
                     erase(ftbd);  { Apagar o ficheiro }
                     ler_dir;   { Reler a dir }
                     if (ybarra + pfile) > nfiles then ybarra := nfiles - 1;
                   { Reimprimir os nomes dos files }
                     poe_files;
                end;
             barra(ybarra);
             showmouse; { (op = ENTER) }
             ch := #1 { Desfazer o ENTER para n„o sair do ciclo da resp1 }
        end;  { ApagarFile }

        procedure procuraFletra (l : char);
      { Mostra os files que come‡am com a letra l }
        var c : word;
        begin
           { Se j  est  posicionado, sair }
             if ((files[pfile].nom[1] = l) and
                (files[pfile - 1].nom[1] <> l)) or
                (ndirs = nfiles) then exit;
             c := ndirs;
           { Procurar o 1§ file com essa letra }
             repeat
                   inc(c)
             until (c = nfiles) or (files[c].nom[1] = l);
             hidemouse;
             barra(ybarra);  { Esconder a barra de posi‡„o }
           { Mostrar a partir desse file }
             if files[c].nom[1] = l then
                begin
                     ybarra := 0;
                     pfile := c;
                     poe_files;
                end;
             barra(ybarra);  { Recolocar a barra de posi‡„o }
             showmouse;
        end;  { ProcuraFLetra }



begin   { resp1 }
    pfile := 1;
    ybarra := 0;
    ler_dir;             { Ler a directoria para a var files }
    poe_files;           { Imprimir os ficheiros no ecran }
    barra(ybarra);       { Colocar a barra de selec‡„o }
    showmouse;
    resp1 := '';
    repeat
          ch := #1;
          if keypressed then ch := upcase(readkey);
          if ch = #0 then
             case readkey of
                  #72 : cima;
                  #80 : baixo;
                  #73 : _pgup;
                  #81 : _pgdn;
                  #83 : apagarfile;
                  #71 : _home;
                  #79 : _end;
             end
          else
             case ch of
                  #13 : resp1 := ok;
        { Se ‚ pressionada uma tecla do alfabeto posiciona a barra nos fichs }
             'A'..'Z' : procuraFletra(ch);{ dessa que come‡am por essa letra }
             end;

        { Se pressionado o bot„o de menor utiliza‡„o do rato, sair }
          if mousebp = botdir then ch := #27;
        { Selecionar um ficheiro pelo rato }
          if (mousebp = botesq) and
             ((mgetxpos > a) and (mgetxpos < (a + 108))) and
             ((getypos > b) and (getypos < (b + 123))) then
                       resp1 := mouse_ok(getypos);

    until ch in[#13, #27];
    if ch = #27 then resp1 := '';
    esp_br;
end; { resp1 }





(********************************************)
(********************************************)

procedure imprmatriz;
{ imprime a matriz em tamanho natural }
var x, y, ofs  : word;
begin
     hidemouse;
     acor := 0;
   { apagar  rea ocupada pela grelha e caixas de posi‡„o }
     bar(0, 0, 293, 189);

     ofs := 320;  { come‡ar da linha 1 do ecran }
     for y := 1 to maxmaty do begin   { imprimir linha a linha }
         for x := 1 to maxmatx do  { imprimir uma linha }
             mem[$A000:ofs + x] := matgraf[x, y];
         inc(ofs, 320)  { pr¢xima linha }
     end;
     showmouse
end;

procedure tecb; begin
{ esperar que seja premida uma tecla ou seja pressionado um bot„o do rato }
     showmouse;
     repeat
           op := #1;
           if keypressed then begin
              op := readkey;
              if op = #0 then op := readkey
           end
     until (op <> #1) or (mousebp <> 0);  { espera tecla, ou clic do rato }
     op := #1; { no caso da tecla ter sido o ESC, isto n„o permite que se }
     esp_br;   { seja peddido ao utilizador a confirma‡„o de saida do programa }
     hidemouse
end;

procedure ver;   begin
{ mostra a matriz em tamanho natural, espera uma tecla ou clic do rato e repoe
  a grelha }
     imprmatriz;           { imprime a matriz em tamanho natural }
     tecb;                 { espera tecla ou clic }
     acor := 0;
     bar(0, 0, 294, 8); { apaga zona das caixas }
     bar(0, 0, 9, 189);
     matriz;  { desenha a grelha, matriz, etc. }
     showmouse
end;


function dialogo : string;
var s : string;
begin
     janp(on);    { abre uma janela pequena }
     poetexto(jnix + 7, jniy + 6, 'FICHEIRO:');
     showmouse;
     acor := 12;
     s := resp(jnix + 22, jniy + 28);
     dialogo := s;
     hidemouse;
     janp(off);   { fechar a janela }
     showmouse
end;


function dialogo1 (bool : boolean) : string;
const a = 90;    b = 50;
      c = 120;   d = 73;
begin
     getim(a, b, c, d);
     if bool then dialogo1 := resp1('EGB', a, b)
     else dialogo1 := resp1('PAL', a, b);
     hidemouse;
     putim(a, b, c, d);
     showmouse
end;


(****************************************************************************)
(*********** GRAVAR                                                          *)

procedure troca(var r1, r2 : byte);
var aux : byte;  begin
      aux := r1;
      r1 := r2;
      r2 := aux
end;

var rx1, ry1, rx2, ry2 : byte;
var a, b : byte;

  procedure defarea;  begin
{ define uma  rea na matriz em tamanho real, por um rectangulo, atrav‚s do
  rato, e devolve em rx1, ry1 o ponto superior esquerdo do rectangulo, e em
  rx2, ry2 o ponto inferior direito do rectangulo }
      imprmatriz;  { imprime a matriz em tamanho real }
   { restringe os movimentos do rato …  rea ocupada pela matriz }
      xposminmax(2, maxmatx * 2);
      yposminmax(1, maxmaty);
      repeat  { esperar que seja premida uma tecla qualquer }
      until mousebp <> 0;
      acor := 15;
      rx1 := getxpos div 2;
      ry1 := getypos;
      esp_br;
      rx2 := rx1;
      ry2 := ry1;
      sobre := 0;  { 'XOR = on' }
      hidemouse;
      rectangulo(rx1, ry1, rx2, ry2);
      showmouse;

      repeat
          { alterar a dimens„o do rectangulo se o rato foi movido }
            if ((getxpos div 2 <> rx2) or (getypos <> ry2)) then begin
                   hidemouse;
                   rectangulo(rx1, ry1, rx2, ry2); { apagar o rectangulo antigo }
                   rx2 := getxpos div 2;
                   ry2 := getypos;
                   rectangulo(rx1, ry1, rx2, ry2);  { imprimir o novo }
                   showmouse
               end
      until (mousebp <> 0) or keypressed;
      hidemouse;
      xposminmax(0, 639); { devolver a liberdade total ao rato }
      yposminmax(0, 199);
      showmouse;
      sobre := 255;  { 'XOR = off' }
      if rx2 < rx1 then troca(rx2, rx1);
      if ry2 < ry1 then troca(ry2, ry1);
      a := rx2 - rx1;   { a = largura do rectangulo }
      b := ry2 - ry1    { b = altura do rectangulo }
  end;

  procedure final;  begin
 { voltar … gralha }
      hidemouse;
      acor := 0;
      bar(0, 0, 294, 8);
      bar(0, 0, 9, 189);
      matriz;
      showmouse
  end;

procedure gravar;
{ gravar uma  rea defineda pelo utilizador }
var stri : string[8];
    x : byte;
    fgraf : file of byte;

begin
    defarea; { definir a  rea a gravar }
    stri := dialogo;  { obter do utilizador um nome para o ficheiro }
 { gravar s¢ se a tecla de saida da Fn dialogo foi um ENTER. Assim, se a tecla
   de saida foi ESC, a  rea n„o ‚ gravada }
    if ch = #13 then  begin
        if stri = '' then stri := 'SEM_NOME';{ se string vazia, dar 1 nome }
        assign (fgraf, path + stri + '.EGB');  { Elemento Gr fico Bidimencional }
        {$I-}
        reset(fgraf);{ testar se j  existe um ficheiro com o nome especificado }
        {$I+}
        ch := ' ';
        if ioresult = 0 then begin{ se j  existe, perguntar se ‚ para sobrepor }
           janp(on);
           poetexto(jnix + 16, jniy + 27, 'SOBREPOR ?');
           acor := 12;
           poetexto(jnix + 3, jniy + 14, stri + ' EXISTE');
           showmouse;
           repeat  ch := upcase(readkey)  until ch in['S', 'N'];
           hidemouse;
           janp(off);
           showmouse
        end;

        if ch in[' ', 'S'] then begin { gravar }
            rewrite(fgraf);
         { gravar cabe‡alho }
            x := 71;  write(fgraf, x);{ Assinatura do programa (9 caracteres) }
            x := 82;  write(fgraf, x);   { 'GRAFAZ 1' + ENTER }
            x := 65;  write(fgraf, x);    x := 70;  write(fgraf, x);
            x := 65;  write(fgraf, x);    x := 90;  write(fgraf, x);
            x := 32;  write(fgraf, x);    x := 49;  write(fgraf, x);
            x := 13;  write(fgraf, x);
            write(fgraf, rx1);  { posi‡„o x do EGB na matriz }
            write(fgraf, ry1);  { posi‡„o y do EGB na matriz }
            write(fgraf, a);  { largura do EGB }
            write(fgraf, b);  { altura do EGB  }
         { gravar corpo }
            repeat
                x := rx1;
                repeat
                   write(fgraf, matgraf[x, ry1]);
                   inc(x)
                until x > rx2;
                inc(ry1)
            until ry1 > ry2;

            close(fgraf)
        end else close(fgraf)
    end;
    final   { voltar … grelha de edi‡„o }
end;




(****************************************************************************)
(*********** CARREGAR  ******************************************************)

procedure carregar;
{ carregar um EGB de um ficheiro }
var stri, strk : string[8];
    x, y, dx, dy, a, b : byte;
    fgraf : file of byte;

begin
    stri := dialogo1(on); { obter do utilizador o nome do ficheiro }
    if stri = '' then exit; { Sair se n„o h  nome de ficheiro }
    assign (fgraf, path + stri + '.EGB');  { Elemento Gr fico Bidimencional }
    {$I-}
    reset(fgraf);
    {$I+}
    if ioresult <> 0 then begin { se o ficheiro n„o existe, dar a conhecer o }
        janp(on);               { facto ao utilizador }
        poetexto(jnix + 10, jniy + 27, 'INEXISTENTE');  acor := 12;
        poetexto(jnix + 15, jniy + 14, stri);
        tecb; { esperar tecla ou clic do rato }
        janp(off)
    end
    else begin    { se o ficheiro existe, carreg -lo }
          strk := '        ';
          for x := 1 to 8 do begin { ler o cabe‡alho para a string stri }
                read(fgraf, y);
                strk[x] := chr(y)
          end;  read(fgraf, y);    { consumir o #13 }
       { verificar se se trata de um EGB }
          if (strk <> 'GRAFAZ 1') and (y <> 13) then begin
             janp(on);
             poetexto(jnix + 12, jniy + 24, 'NAO E'' UM EGB');
             acor := 12;
             poetexto(jnix + 14, jniy + 10, stri);
             tecb;
             close(fgraf);
             janp(off)
          end
          else begin
               read(fgraf, x);    { obter as coordenadas do EGB na matriz }
               read(fgraf, y);
               read(fgraf, dx);   { obter as dimens”es }
               read(fgraf, dy);
               dx := x + dx;
               dy := y + dy;

               for b := y to dy do    { ler os dados do ficheiro }
                 for a := x to dx do
                    read(fgraf, matgraf[a, b]);

               close(fgraf);
               hidemouse;
               desmat        { desenhar a grelha }
          end
    end;
    showmouse
end;


procedure escolher_cor;
begin
     if mbp <> 0 then begin
          { escolher cores }
             if (mx > 294) and (my < 169) then mudacor;
          { "rodar" a palete }
             if (mx > 294) and (my > 170) and (my < 187) then rodapal
        end
end;


(****************************************************************************)
(*********** OPCOES                                                           *)

var saida : boolean;

procedure menu;  begin
    jang(on);
    acor := 7;
    poetexto(jdix + 8, jdiy + 6,  '1 COPIAR');
    poetexto(jdix + 8, jdiy + 16, '2 APAGAR AREA');
    poetexto(jdix + 8, jdiy + 26, '3 APAGAR TUDO');
    poetexto(jdix + 8, jdiy + 36, '4 ENCHER AREA');
    poetexto(jdix + 8, jdiy + 46, '5 MOVER');
    poetexto(jdix + 8, jdiy + 56, '6 SOBRE');
    showmouse
end;

procedure creditos;  begin
    esp_br;
    hidemouse;
    jang(off);
    showmouse;
    janp(on);  acor := 10;
    poetexto(jnix + 26, jniy + 12, 'GRAFAZ 1.0');
    poetexto(jnix + 32, jniy + 28, 'NSJ  1993');
    tecb;
    janp(off);
    showmouse;
    menu
end;

procedure prep;  begin
{ abre uma janela e seleciona uma  rea }
    hidemouse;
    jang(off);
    showmouse;
    defarea;
end;

procedure apagar;
var x : byte;  begin
    prep;   { selecionar  rea }
  { apagar a  rea selecionada }
    repeat
        x := rx1;
        repeat
           matgraf[x, ry1] := 0;
           inc(x)
        until x > rx2;
        inc(ry1);
    until ry1 > ry2;

    final;
    saida := off;{ indicar para n„o repor a  rea da janela … saida do menu op‡”es }
    op := #27    { indicar que ‚ para sair de OP€™ES }
end;

procedure limpar;
var x, y : byte;
begin
    acor := 10;
    hidemouse;
    poetexto(jdix + 8, jdiy + 26, '3 APAGAR TUDO');
    showmouse;
    op := #27;
    esp_br;
    repeat
    until (mousebp <> 0) or keypressed;   { esperar confirma‡„o }
    if keypressed then op := upcase(readkey);
    hidemouse;
    jang(off);
    showmouse;
  { se foi pressionado ESC ou o bot„o direito do rato }
    if (op <> #27) or (mousebp = botesq) then begin { se houve confirma‡„o }
         for y := 1 to maxmaty do           { limpar toda a matriz }
             for x := 1 to maxmatx do
                 matgraf[x, y] := 0;
         op := #27    { indicar que ‚ para sair de OPCOES }
    end;

    final;
    saida := off  { Indicar para n„o repor a  rea da janela … saida. }
end;


  procedure desarea;
{ desloca na  rea da matriz real um rectangulo definido por rx1, ry1, rx2, ry2 }
  begin
    { limita os movimentos do rato …  rea da matriz real }
      xposminmax(a * 2 + 2, maxmatx * 2);
      yposminmax(b + 1, maxmaty);
      acor := 15;
      esp_br;
      sobre := 0;  { 'XOR = on' }

      repeat
          { deslocar o rectangulo s¢ se o rato foi movido }
            if ((getxpos div 2 <> rx2) or (getypos <> ry2)) then begin
                   hidemouse;
                   rectangulo(rx1, ry1, rx2, ry2); { apagar rectangulo e }
                   rx2 := getxpos div 2;
                   rx1 := rx2 - a;
                   ry2 := getypos;
                   ry1 := ry2 - b;
                   rectangulo(rx1, ry1, rx2, ry2); { imprimi-lo na nova posi‡„o }
                   showmouse
               end
      until mousebp <> 0;
      hidemouse;
      rectangulo(rx1, ry1, rx2, ry2);
      xposminmax(0, 639);
      yposminmax(0, 199);
      showmouse;
      sobre := 255
  end;

procedure copiar;
{ copiar uma  rea definida pelo utilizador para outro s¡tio da matriz }
var x, y, u, tmp : byte;
    matgrafb : tip_mat;  { matriz auxiliar }
begin
    prep;   { definir a  rea a copiar }
 { copiar  rea para matriz auxiliar }
    tmp := ry1;
    y := 1;
    repeat
        u := rx1;
        x := 1;
        repeat
           matgrafb[x, y] := matgraf[u, ry1];
           inc(x);
           inc(u)
        until u > rx2;
        inc(ry1);
        inc(y)
    until ry1 > ry2;

    ry1 := tmp;
    desarea; { escolher s¡tio destino da c¢pia }
 { copiar area da matriz auxiliar para a matriz principal }
    y := 1;
    repeat
        u := rx1;
        x := 1;
        repeat
           if matgrafb[x, y] <> 0 then matgraf[u, ry1] := matgrafb[x, y];
           inc(x);
           inc(u)
        until u > rx2;
        inc(ry1);
        inc(y)
    until ry1 > ry2;

    final;
    menu          { imprimir o menu op‡”es }
end;

procedure mover;
{ mover uma  rea definida pelo utilizador para outro s¡tio da matriz }
var x, y, u, tmp : byte;
    matgrafb : tip_mat;  { matriz auxiliar }
begin
    prep;   { definir a  rea a mover }
 { copiar  rea para matriz auxiliar e apag -la da matriz principal }
    tmp := ry1;
    y := 1;
    repeat
        u := rx1;
        x := 1;
        repeat
           matgrafb[x, y] := matgraf[u, ry1];
           matgraf[u, ry1] := 0;
           inc(x);
           inc(u)
        until u > rx2;
        inc(ry1);
        inc(y)
    until ry1 > ry2;

    ry1 := tmp;
    desarea; { escolher s¡tio destino da  rea }
 { copiar  rea da matriz auxiliar para a matriz principal }
    y := 1;
    repeat
        u := rx1;
        x := 1;
        repeat
           if matgrafb[x, y] <> 0 then matgraf[u, ry1] := matgrafb[x, y];
           inc(x);
           inc(u)
        until u > rx2;
        inc(ry1);
        inc(y)
    until ry1 > ry2;

    final;
    menu          { imprimir o menu op‡”es }
end;


procedure encher;
{ encher uma  rea com uma determinada cor }
    procedure ench;
    const aa = 450;
    var p1, p2, px, py, t, s, d, pon, pg : integer;
        qx, qy : array[1..aa] of integer;
    begin
      p1 := 1;                         p2 := 2;
      qx[1] := getxpos div 2 + 2;      qy[1] := getypos + 1;
      pg := getponto(qx[1], qy[1]);
      if pg = acor then exit;
      repeat
         for d := 1 to 4 do begin
             case d of
                  1 : begin  t := -1;  s := 0   end;
                  2 : begin  t := 0;   s := 1   end;
                  3 : begin  t := 1;   s := 0   end;
                  4 : begin  t := 0;   s := -1  end
             end;
             px := qx[p1] + t;       py := qy[p1] + s;
             pon := getponto(px, py);
             if ((pon = 0) or (pon = pg)) and
                ((px <= maxmatx) and (py <= maxmaty) and
                (px >= 1) and (py >= 1)) then begin
                         ponto(px, py);
                         matgraf[px, py] := acor;
                         qx[p2] := px;         qy[p2] := py;
                         inc(p2);
                         if p2 > aa then p2 := 1
             end
         end;
         if mousebp = 2 then exit;
         inc (p1);     if (p1 > aa) then p1 := 1
      until p2 = p1
    end;

begin
    hidemouse;
    jang(off);
    showmouse;
    imprmatriz;  { imprimir a matriz em tamanho real }
    esp_br;
    repeat until (mousebp <> 0); { esperar ordem de enchimento }
  { decidir a cor de enchimento }
    if mousebp = 1 then acor := core else acor := cord;
    esp_br;
    hidemouse;
    ench;      { encher a  rea }
    showmouse;
    esp_br;
    final;
    menu       { imprimir o menu op‡”es }
end;




procedure opcoes;
begin
    saida := on;{ indicar para rep“r a  rea ocupada pela janela, at‚ ordem em }
    menu;       { contr rio }
    repeat
        op := #1;
        if keypressed then op := readkey;
        case op of
             '1' : copiar;
             '2' : apagar;
             '3' : limpar;
             '4' : encher;
             '5' : mover;
             '6' : creditos
        end;

        mx := getxpos div 2;
        my := getypos;
        mbp := mousebp;

        if mbp = botesq then begin { se f“r premido o bot„o esquerdo do rato... }
           if (mx > (jdix + 7)) then begin
      {1}     if (my > (jdiy + 6)) and (my < (jdiy + 14)) and
                 (mx < (jdix + 66)) then copiar;
      {6}     if (my > (jdiy + 55)) and (my < (jdiy + 65)) and
                 (mx < (jdix + 58)) then creditos;
      {6}     if (my > (jdiy + 45)) and (my < (jdiy + 55)) and
                 (mx < (jdix + 58)) then mover;
              if mx < (jdix + 102) then begin
      {2}        if (my > (jdiy + 15)) and (my < (jdiy + 23)) then apagar
      {3}        else
                    if (my > (jdiy + 25)) and (my < (jdiy + 34)) then limpar
                    else
      {4}              if(my > (jdiy + 35)) and (my < (jdiy + 44)) then encher
              end
           end;
        end;
        escolher_cor

    until (op = #27) or ((mousebp = botdir) and (mx < 294));

    if saida then begin
       hidemouse;
       jang(off);
       showmouse
    end;
    esp_br;
    op := #1
end;






