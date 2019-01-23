procedure loadpal (stri : string);forward;


procedure palom;
{ carregar e activar a palete por omiss„o. }
var aux : string;
begin
     aux := path;
     path := camOMISSAO;
     loadpal('omissao');
     ligapal(pal);
     pala := pal;
     path := aux;
end;


procedure menupal; begin
    janp(on);
    acor := 7;
    poetexto(jnix + 5, jniy + 6,  '1 EDITAR PALETE');
    poetexto(jnix + 5, jniy + 16, '2 CARREGAR PAL.');
    poetexto(jnix + 5, jniy + 26, '3 GRAVAR PALETE');
    poetexto(jnix + 5, jniy + 36, '4 PAL. OMISSAO');
    showmouse
end;


procedure prepal;
{ come‡o comun aos procedimentos seguintes }
begin
     hidemouse;
     janp(off);     { fechar a janela do menu }
     showmouse
end;


(********************************************************************************)
(******* GRAVAR PALETE                                                          *)

  procedure gravapal;
{ grava a palete activa }
  var stri : string[9];
      fpal : file of tip_pal;
  begin
       prepal;   { fechar janela do menu }
       stri := dialogo;  { obter do utilizador um nome para o ficheiro }
 { gravar s¢ se a tecla de saida da Fn dialogo f“r um ENTER. Assim, se a tecla
   de saida f“r ESC, a palete n„o ‚ gravada }
       if ch = #13 then  begin
           if stri = '' then stri := 'SEM_NOME';{ se string vazia, dar 1 nome }
           assign (fpal, path + stri + '.PAL');
           {$I-}
           reset(fpal);  { testar se j  existe um ficheiro com o nome }
           {$I+}          { especificado }
           ch := ' ';
           if ioresult = 0 then begin  { se j  existe, perguntar se ‚ para }
              janp(on);                { sobrepor }
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
              rewrite(fpal);
              write(fpal, pal)
           end;
           close(fpal)
       end;
       menupal
  end;


(*********************************************************************************)
(******* CARREGAR PALETE                                                         *)

  procedure loadpal(stri : string);
{ carrega uma palete cujo nome est  contido em stri }
  var fpal : file of tip_pal;
  begin
       assign (fpal, path + stri + '.PAL');
       {$I-}
       reset(fpal);    { abrir o ficheiro }
       {$I+}
       if ioresult <> 0 then begin { se o ficheiro n„o existe, dar a conhecer }
          janp(on);                { o facto ao utilizador }
          poetexto(jnix + 10, jniy + 27, 'ENIEXISTENTE');  acor := 12;
          poetexto(jnix + 15, jniy + 14, stri);
          tecb;  { esperar tecla ou clic do rato }
          janp(off);
          showmouse
       end
          else begin
                    read(fpal, pal);  { se o ficheiro existe, carreg -lo }
                    close(fpal)      { fechar o ficheiro }
               end
  end;


  procedure carregapal;
{ carregar uma palete }
  var stri : string[9];
  begin
       prepal;
       stri := dialogo1(off); { obter do utilizador o nome do ficheiro }
       if stri = '' then  { Sair do procedimento se n„o h  nenhum nome }
         begin
            menupal; 
            exit
         end;
       loadpal(stri);   { Carregar a palete }
       ligapal(pal);    { Activar a palete }
       menupal
  end;



(********************************************************************************)
(******** CICLO MENU PALETE                                                     *)

procedure opcpal;
begin
     menupal;
     esp_br;
     repeat
        op := #1;
        if keypressed then op := readkey;
        case op of
             '1' : op := #27; { voltar … edi‡„o }
             '2' : carregapal;
             '3' : gravapal;
             '4' : palom
        end;

        mx := getxpos div 2;
        my := getypos;
        mbp := mousebp;

        if mbp = botesq then begin{ se f“r premido o bot„o esquerdo do rato... }
           if (mx > (jnix+7)) then begin
      {1}     if (my > (jniy+6)) and (my < (jniy+14)) and (mx < (jnix+112))
                 then op := #27;
      {2}     if (mx < (jnix+102)) and (my > (jniy+15)) and (my < (jniy+23))
                 then carregapal;
      {3}     if (mx < (jnix+118)) and (my > (jniy+25)) and (my < (jniy+33))
                 then gravapal;
         { se a op‡„o f“r 'palete omissao', carreg -la e sair do menu }
      {4}     if (mx < (jnix+110)) and (my > (jniy+36)) and (my < (jniy+44))
                 then begin  palom;  op := #27  end;
              esp_br
           end
        end;
        escolher_cor

     until (op = #27) or ((mousebp = botdir) and (mx < 294));

     op := #1;  { para n„o enganar o ciclo palete, uma vez que a var op ‚ }
     esp_br;
     hidemouse; { a¡ usada }
     janp(off); { fechar a janela }
     showmouse
end;


(*********************************************************************************)
(****** EDITOR DE PALETES                                                        *)

const dist = 75;
      alt = 92;


    procedure indica_cor;
    var c, c1 : integer;
    begin
         acor := 0;
         for c := 1 to 8 do      { apagar o indicador da posi‡„o antiga }
            for c1 := 0 to 31 do
               rectangulo(87 + c1 * 6, c * 6 - 1, 93 + c1 * 6, 4 + c * 6 + 1);
      { imprimir o indicador na nova posi‡„o }
         c := cor div 32 + 1;
         c1 := cor mod 32;
         acor := 15;
         rectangulo(87 + c1 * 6, c * 6 - 1, 93 + c1 * 6, 4 + c * 6 + 1)
      end;


    procedure indicador_vermelho;
 { imprime o indicador de vermelho da cor 'cor' }
    begin
         acor := 0;        { limpar a caixa }
         bar(dist + 9, alt + 1, dist + 77, alt + 7);
         acor := 12;
         bar(dist + pal[cor].verm + 9, alt + 1, dist + pal[cor].verm + 14, alt + 7)
    end;


    procedure indicador_verde;
 { imprime o indicador de verde da cor 'cor' }
    begin
         acor := 0;        { limpar a caixa }
         bar(dist + 9, alt + 12, dist + 77, alt + 18);
         acor := 10;
         bar(dist + pal[cor].verde + 9, alt + 12, dist + pal[cor].verde + 14, alt + 18)
    end;


    procedure indicador_azul;
 { imprime o indicador de azul da cor 'cor' }
    begin
         acor := 0;        { limpar a caixa }
         bar(dist + 9, alt + 23, dist + 77, alt + 29);
         acor := 9;
         bar(dist + pal[cor].azul + 9, alt + 23, dist + pal[cor].azul + 14, alt + 29)
    end;


    procedure indicadores;
{ desenhar os indicadores na posi‡„o correspondente … cor actual }
    begin
         indicador_vermelho;
         indicador_verde;
         indicador_azul
    end;


    procedure mostra_percentagem;
 { imprime a 'percentagem' de verm, verde e azul }
    begin
         acor := 0;  { apagar os valores antigos }
         bar(dist + 92, alt, dist + 110, alt + 31);
         acor := 12;
         poetexto(dist + 92, alt , str_(pal[cor].verm));
         acor := 10;
         poetexto(dist + 92, alt + 11, str_(pal[cor].verde));
         acor := 9;
         poetexto(dist + 92, alt + 22, str_(pal[cor].azul));
    end;


    procedure mostra_cor;
 { imprime o n§ da cor e um bar com essa mesma cor }
    begin
         acor := 0;    { apagar o valor antigo }
         bar(dist + 1, alt + 40, dist + 27, alt + 49);
         acor := 15;
         poetexto(dist - 24, alt + 40, 'COR ' + str_(cor));
         acor := cor;
         bar(dist + 28, alt + 39, dist + 110, alt + 50)
    end;


    procedure actualizar;
{ mostra o c¢digo de cor actual, assinala c/ um rectangulo a respectiva cor na
  palete da parte superior do ecran, coloca os indicadores das caixas de cores
  nas posi‡”es respeitantes … cor actual(var cor) e mostra tamb‚m as
  'percentagens' das trˆs cores }
    begin
         hidemouse;
         mostra_cor;
         indica_cor;
         indicadores;
         mostra_percentagem;
         showmouse
    end;


const ct = 13;     { cor dos triangulos }

    procedure aspecto_editor;
 { desenhar o ambiente do editor }
    var c, c1 : integer;
    begin
         hidemouse;
         acor := 0; { limpar parte do ecran }
         bar(0, 0, 293, 199);              acor := tecfunc;
       { op‡”es }
         poetexto(1, 1, #22);              poetexto(1, 11, #23);
         poetexto(1, 21, #24);             poetexto(1, 31, #25);
         poetexto(1, 41, #26);             poetexto(1, 51, #27);
         acor := palav;
         poetexto(9, 1, 'ESPALHAR');       poetexto(9, 11, 'RESET COR');
         poetexto(9, 21, 'RESET PAL');     poetexto(9, 31, 'UNDO');
         poetexto(9, 41, 'TROCAR');        poetexto(9, 51, 'COPIAR');
         acor := 1;
         bar(9, 178, 42, 189);
         acor := 10;
         poetexto(11, 180, 'SAIR');
     { imprimir toda a palete na parte superior do ecran }
         acor := 0;
         for c := 1 to 8 do
             for c1 := 0 to 31 do begin
                 bar(88 + c1 * 6, c * 6, 92 + c1 * 6, 4 + c * 6);
                 inc(acor)
             end;
     { imprimir caixa central }
         for c := 0 to 2 do begin{ imprimir 3 caixas para as barras das cores }
            acor := 7;
            rectangulo(dist, alt + c * 11, dist + 86, alt + 8 + c * 11);
{divis¢rias}recta(dist + 8, alt + c * 11, dist + 8, alt + 8 + c * 11);
{ ... }     recta(dist + 78, alt + c * 11, dist + 78, alt + 8 + c * 11);
     { imprimir + e - nas caixas }
            acor := 14;
     {-}    recta(dist + 1, alt + 4 + c * 11, dist + 6, alt + 4 + c * 11);
     {+}    recta(dist + 82, alt + 2 + c * 11, dist + 82, alt + 6 + c * 11);
     {+}    recta(dist + 80, alt + 4 + c * 11, dist + 84, alt + 4 + c * 11)
         end;

         acor := 7;
         rectangulo(dist - 24, alt - 4, dist + 111, alt + 34);
     { triangulos laterais }
         acor := ct;
         triangulo(dist - 18, alt + 14, dist - 8, alt + 14, dist - 13, alt - 2);
         triangulo(dist - 18, alt + 18, dist - 8, alt + 18, dist - 13, alt + 32);
         derrama(dist - 15, alt + 10, ct, ct);  { encher os triangulos }
         derrama(dist - 15, alt + 20, ct, ct);
         showmouse
    end;


    function selected_cor : integer;
  { verifica se o rato selecionou uma cor da palete que se encontra no topo do
    ecran, se selecionou devolve a cor, se n„o, devolve -1 }
    var aux : byte;
    begin
         selected_cor := - 1;
  { testar se a cor escolhida foi a cor 0 }
         if (mx > 87) and (mx < 92) and (my < 11) and (my > 5) then
           selected_cor := 0
         else
           begin
  { testar se a cor escolhida foi a cor 15 }
              if (mx > 177) and (mx < 183) and (my < 11) and (my > 5) then
                 selected_cor := 15
              else  { testar se outra cor }
                    if (mx > 87) and (mx < 279) and (my < 54) and
                       (my > 5) then begin
                          hidemouse;
                          aux := getponto(mx, my); { obter a cor sobre a }
                          showmouse;                   { qual o rato clicou }
                     { se a cor ‚ 0 ou 15 sair, porque quer dizer que clicou }
                          if not(aux in[0, 15]) then     { no intervalo das }
                             selected_cor := aux   { cores ou no indicador }
                     end
           end
    end;


    procedure esccor;
  { verifica se o rato selecionou uma cor da palete que se encontra no topo do
    ecran, e altera a var cor de acordo com a escolha }
    var aux : integer;
    begin
         aux := selected_cor;
         if aux <> -1 then
         begin
              cor := aux;
              actualizar;
              esp_br
         end
    end;


  procedure mover_verm;
{ alterar a 'percentagem' de vermelho da cor actual }

      procedure executa;
      begin
           with pal[cor] do ligaRGBpal(cor, verm, verde, azul);
           hidemouse;
           mostra_percentagem;  { actualiza ecran }
           indicador_vermelho;
           showmouse
      end;

  begin
 { se o cursor do rato estiver no interior da caixa respectiva, aumentar
   1 unidade de vermelho, a menos que o verm. j  seja 63 }
      if (mx > dist) and (mx < (dist + 8)) and (pal[cor].verm > 0) then begin
         dec(pal[cor].verm);  { incrementa a veri vel }
         executa;
         esp_br
      end;
 { se o cursor do rato estiver no interior da caixa respectiva, diminuir
   1 unidade de vermelho, a menos que o verm. j  seja 0 }
      if (mx > dist + 78) and (mx < (dist + 85)) and (pal[cor].verm < 63) then begin
         inc(pal[cor].verm);  { decrementa a veri vel }
         executa;
         esp_br
      end;
   { se o cursor estiver dentro da caixa do indicador, emt„o movˆ-lo …
     'vontade do rato', enquanto f“r premido um dos bot”es do rato }
      if (mx > (dist + 8)) and (mx < (dist + 78)) then begin
      { limitar os movimentos do rato … caixa de vermelhos }
         xposminmax((dist + 10) * 2, (dist + 73) * 2);
         yposminmax(alt + 1, alt + 7);
         mx := getxpos div 2;   { obter posi‡„o do rato }
      { mover o indicador para o sitio onde o clique do rato }
         pal[cor].verm := mx - dist - 10;
         executa;
         oldmx := mx;  { guardar y actual do rato }
      { enquanto f“r premido um bot„o do rato... }
         while mousebp <> 0 do begin
               mx := getxpos div 2;   { obter posi‡„o do rato }
             { se a nova posi‡„o y do rato ‚ diferente da antiga, ‚ porque o
               rato foi movido, e ent„o move a barra e a matriz }
               if oldmx <> mx then begin
                   oldmx := mx;  { guardar o valor y do rato }
                   pal[cor].verm := mx - dist - 10;
                   executa
               end
         end;
      { devolver ao rato a liberdade total }
         xposminmax(0, 639);    yposminmax(0, 199)
      end
  end;


  procedure mover_verde;
{ alterar a 'percentagem' de verde da cor actual }

      procedure executa;
      begin
           with pal[cor] do ligaRGBpal(cor, verm, verde, azul);
           hidemouse;
           mostra_percentagem;  { actualiza ecran }
           indicador_verde;
           showmouse
      end;

  begin
 { se o cursor do rato estiver no interior da caixa respectiva, aumentar
   1 unidade de verde, a menos que o verde. j  seja 63 }
      if (mx > dist) and (mx < (dist + 8)) and (pal[cor].verde > 0) then begin
         dec(pal[cor].verde);  { incrementa a veri vel }
         executa;
         esp_br
      end;
 { se o cursor do rato estiver no interior da caixa respectiva, diminuir
   1 unidade de verde, a menos que o verde. j  seja 0 }
      if (mx > dist + 78) and (mx < (dist + 85)) and (pal[cor].verde < 63) then begin
         inc(pal[cor].verde);  { decrementa a veri vel }
         executa;
         esp_br
      end;
   { se o cursor estiver dentro da caixa do indicador, emt„o movˆ-lo …
     'vontade do rato', enquanto f“r premido um dos bot”es do rato }
      if (mx > (dist + 8)) and (mx < (dist + 78)) then begin
      { limitar os movimentos do rato … caixa de verdes }
         xposminmax((dist + 10) * 2, (dist + 73) * 2);
         yposminmax(alt + 12, alt + 18);
         mx := getxpos div 2;   { obter posi‡„o do rato }
      { mover o indicador para o sitio onde o clique do rato }
         pal[cor].verde := mx - dist - 10;
         executa;
         oldmx := mx;  { guardar y actual do rato }
      { enquanto f“r premido um bot„o do rato... }
         while mousebp <> 0 do begin
               mx := getxpos div 2;   { obter posi‡„o do rato }
             { se a nova posi‡„o y do rato ‚ diferente da antiga, ‚ porque o
               rato foi movido, e ent„o move a barra e a matriz }
               if oldmx <> mx then begin
                   oldmx := mx;  { guardar o valor y do rato }
                   pal[cor].verde := mx - dist - 10;
                   executa
               end
         end;
      { devolver ao rato a liberdade total }
         xposminmax(0, 639);    yposminmax(0, 199)
      end
  end;


  procedure mover_azul;
{ alterar a 'percentagem' de azul da cor actual }

      procedure executa;
      begin
           with pal[cor] do ligaRGBpal(cor, verm, verde, azul);
           hidemouse;
           mostra_percentagem;  { actualiza ecran }
           indicador_azul;
           showmouse
      end;

  begin
 { se o cursor do rato estiver no interior da caixa respectiva, aumentar
   1 unidade de azul, a menos que o azul. j  seja 63 }
      if (mx > dist) and (mx < (dist + 8)) and (pal[cor].azul > 0) then begin
         dec(pal[cor].azul);  { incrementa a veri vel }
         executa;
         esp_br
      end;
 { se o cursor do rato estiver no interior da caixa respectiva, diminuir
   1 unidade de azul, a menos que o azul. j  seja 0 }
      if (mx > dist + 78) and (mx < (dist + 85)) and (pal[cor].azul < 63) then begin
         inc(pal[cor].azul);  { decrementa a veri vel }
         executa;
         esp_br
      end;
   { se o cursor estiver dentro da caixa do indicador, emt„o movˆ-lo …
     'vontade do rato', enquanto f“r premido um dos bot”es do rato }
      if (mx > (dist + 8)) and (mx < (dist + 78)) then begin
      { limitar os movimentos do rato … caixa de azuis }
         xposminmax((dist + 10) * 2, (dist + 73) * 2);
         yposminmax(alt + 23, alt + 29);
         mx := getxpos div 2;   { obter posi‡„o do rato }
      { mover o indicador para o sitio onde o clique do rato }
         pal[cor].azul := mx - dist - 10;
         executa;
         oldmx := mx;  { guardar y actual do rato }
      { enquanto f“r premido um bot„o do rato... }
         while mousebp <> 0 do begin
               mx := getxpos div 2;   { obter posi‡„o do rato }
             { se a nova posi‡„o y do rato ‚ diferente da antiga, ‚ porque o
               rato foi movido, e ent„o move a barra e a matriz }
               if oldmx <> mx then begin
                   oldmx := mx;  { guardar o valor y do rato }
                   pal[cor].azul := mx - dist - 10;
                   executa
               end
         end;
      { devolver ao rato a liberdade total }
         xposminmax(0, 639);    yposminmax(0, 199)
      end
  end;


(*********************************************************************************)
(******* OP€™ES DO EDITOR                                                        *)
procedure espalhar;
{ selecionada 1 cor, este procedimento 'espalha' essa cor pelas 63 seguintes,
  se possivel, em gradua‡„o }
var aux, c, soma : integer;
begin
   { guardar a var pal antes da altera‡„o, para ser possivel o UNDO }
     pala := pal;
     acor := 10;
     hidemouse;
     poetexto(9, 1, 'ESPALHAR'); { fazer o 'highligth' da op‡„o }
     showmouse;
     repeat     { espera que seja escolhida uma cor }
           mx := getxpos div 2;
           my := getypos;
           aux := -1;
           if mousebp <> 0 then aux := selected_cor
     until aux <> -1;
     esp_br;
   { espalhar a cor }
     c := 0;
     repeat
         inc(c);
         pal[aux + c] := pal[aux + c - 1];
         with pal[aux + c] do
         begin
             if (verm + 1) <= 63 then inc(verm) else verm := 63;
             if (verde + 1) <= 63 then inc(verde) else verde := 63;
             if (azul + 1) <= 63 then inc(azul) else azul := 63;
             soma := verm + verde + azul
         end
{ repetir at‚ fazer as maxesp cores ou chegar … cor mais clara possivel(branco) }
     until (c = 31) or (soma >= 189);{ cor mais clara = 63 + 63 + 63 = 189 }
     ligapal(pal);  { activar a nova palete }

     acor := 11;
     hidemouse;
     poetexto(9, 1, 'ESPALHAR'); { desfazer o 'highligth' da op‡„o }
     showmouse;
end;

procedure reset_cor;
begin
   { guardar a var pal antes da altera‡„o, para ser possivel o UNDO }
     pala := pal;
     with pal[cor] do begin
          verm := 0;
          verde := 0;
          azul := 0;
          ligaRGBpal(cor, verm, verde, azul)
     end;
     actualizar;
     esp_br
end;

procedure reset_pal;
var aux : byte;
begin
  { guardar a var pal antes da altera‡„o, para ser possivel o UNDO }
     pala := pal;
     acor := 10;
     hidemouse;
     poetexto(9, 21, 'RESET PAL');      { fazer um 'highligth' }
     showmouse;
     op := #27;
     esp_br;
  { esperar confirma‡„o, por tecla, c/ tecla <> ESC ou bot„o direito do rato }
     repeat
           if keypressed then op := upcase(readkey);
           aux := mousebp
     until (aux <> 0) or keypressed;
  { se houve confirma‡„o 'resetar' a palete, … excep‡„o das 15 1¦'s cores }
     if (op <> #27) or (aux = botesq) then begin
        for aux := 16 to 255 do
            with pal[aux] do begin
                 verm := 0;
                 verde := 0;
                 azul := 0
            end;
        ligapal(pal)
     end;
  { desfazer o 'highligth' }
     acor := 11;
     hidemouse;
     poetexto(9, 21, 'RESET PAL');
     showmouse;
     esp_br;
     op := #1
end;

procedure undo;
begin
     pal := pala;  { recupera o valor anterior, guardado em pala }
     actualizar;
     ligapal(pal);
     esp_br
end;

procedure trocar;
var aux, aux1 : integer;
    temp : tipo_cor;
begin
   { fazer o 'highligth' da op‡„o }
     acor := 10;
     hidemouse;
     poetexto(9, 41, 'TROCAR');
     showmouse;
   { guardar a var pal antes da altera‡„o, para ser possivel o UNDO }
     pala := pal;
     repeat     { espera que seja escolhida uma cor }
           mx := getxpos div 2;
           my := getypos;
           aux := -1;
           if mousebp <> 0 then aux := selected_cor
     until aux <> -1;
     esp_br;

     repeat     { espera que seja escolhida uma 2¦ cor }
           mx := getxpos div 2;
           my := getypos;
           aux1 := -1;
           if mousebp <> 0 then aux1 := selected_cor
     until aux1 <> -1;
     esp_br;
  { trocar as duas cores }
     temp := pal[aux];
     pal[aux] := pal[aux1];
     pal[aux1] := temp;
     actualizar;
     ligapal(pal);
  { desfazer o 'highligth' da op‡„o }
     acor := 11;
     hidemouse;
     poetexto(9, 41, 'TROCAR');
     showmouse
end;

procedure copiar_cor;
var aux, aux1 : integer;
begin
   { fazer o 'highligth' da op‡„o }
     acor := 10;
     hidemouse;
     poetexto(9, 51, 'COPIAR');
     showmouse;
   { guardar a var pal antes da altera‡„o, para ser possivel o UNDO }
     pala := pal;
     repeat     { espera que seja escolhida a cor a copiar }
           mx := getxpos div 2;
           my := getypos;
           aux := -1;
           if mousebp <> 0 then aux := selected_cor
     until aux <> -1;
     esp_br;

     repeat     { espera que seja escolhida a cor para onde copiar }
           mx := getxpos div 2;
           my := getypos;
           aux1 := -1;
           if mousebp <> 0 then aux1 := selected_cor
     until aux1 <> -1;
     esp_br;
  { copiar a cor }
     pal[aux1] := pal[aux];
     actualizar;
     ligapal(pal);
  { desfazer o 'highligth' da op‡„o }
     acor := 11;
     hidemouse;
     poetexto(9, 51, 'COPIAR');
     showmouse
end;


(*********************************************************************************)
(******* CICLO DO EDITOR DE PALETES                                              *)
procedure palete;
{ editor de paletes }
begin
     aspecto_editor;  { desenhar o ambiente do editor }
     showmouse;
     actualizar;      { colocar os itens de acordo com a cor actual }
     repeat
           op := #1;
           if keypressed then op := readkey;
           if op = #0 then begin
              op := readkey;
              case op of
              {F1} #59 : espalhar;
              {F2} #60 : reset_cor;
              {F3} #61 : reset_pal;
              {F4} #62 : undo;
              {F5} #63 : trocar;
              {F6} #64 : copiar_cor
              end
           end;

           mbp := mousebp;
           mx := getxpos div 2;
           my := getypos;

           if mbp = botesq then begin
         { clic em cima de um dos triƒngulos ? }
              if (mx > (dist - 24)) and (mx < dist) and (my < (alt + 34)) and
                 (my > (alt - 4)) then begin
                 hidemouse;
                 aux := getponto(mx, my); { aux = cor onde o rato clicou }
                 showmouse;
             { se aux f“r = … cor dos triƒngulos, incremtar ou decremtar 'cor' }
                 if aux = ct then if my > (alt + 16) then begin
                    dec(cor);
                    actualizar  { mostrar novos valores }
                 end else begin
                               inc(cor);
                               actualizar  { mostrar novos valores }
                          end;
                 esp_br
              end;
              esccor; { verificar se se pretende editar outra cor }
              if (my > alt) and (my < (alt + 8)) then mover_verm;
              if (my > alt + 11) and (my < (alt + 19)) then mover_verde;
              if (my > alt + 22) and (my < (alt + 30)) then mover_azul;

       {F1}   if (my < 10) and (mx < 70) then espalhar;
       {F2}   if (my < 20) and (my > 10) and (mx < 75) then reset_cor;
       {F3}   if (my < 30) and (my > 20) and (mx < 75) then reset_pal;
       {F4}   if (my < 40) and (my > 30) and (mx < 45) then undo;
       {F5}   if (my < 50) and (my > 40) and (mx < 65) then trocar;
       {F6}   if (my < 60) and (my > 50) and (mx < 62) then copiar_cor
           end;
        { abrir o menu palete }
           if (mousebp = botdir) and (mx < 294) then
                 begin
                    opcpal;       { chamar o menu }
                    hidemouse;
                    indicadores;{ pode ter havido um 'get default palet', etc }
                    showmouse
                 end;
           escolher_cor;
         { sair pelo rato }
           if (my < 190) and (my > 177) and (mx < 43) and (mx > 8) then
              op := #27

     until (op = #27) or ((mousebp = 3) and (mx < 294));

     op := #1;  { para n„o enganar o ciclo principal, j  que op tamb‚m ‚ }
     hidemouse; { usada a¡ }
     acor := 0;
     bar(0, 0, 294, 9); { apaga zona das caixas }
     bar(0, 0, 10, 189);
     matriz; { imprime a matriz }
     impopc; { desenhar a £ltima linha }
     showmouse;
     mbp := 0; { para n„o enganar o ciclo principal }
     esp_br
end;







