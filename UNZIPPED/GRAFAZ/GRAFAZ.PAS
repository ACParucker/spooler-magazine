(****************************************************************************)
(**                                                                        **)
(**                               GRAFAZ V1                                **)
(**                                                                        **)
(**                               NSJ  1994                                **)
(**                                                                        **)
(**                             MegaSoft 1994                              **)
(**                                                                        **)
(****************************************************************************)

{ Se recompilarem o GRAFAZ, retirem o X de todas as op‡”es do campo }
{ Run Time Errors em Options|Compiler. Isto faz como TPAS n„o se dˆ }
{ ao trabalho de acrescentar algum c¢digo extra ao programa, que    }
{ embora possa dar muito jeito durante a concep‡„o de um programa,  }
{ tira alguma velocidade.                                           }
{ O GRAFAZ deve ocupar +- 166 Kb de mem¢ria quando carregado.       }

{$M 56000,0,0}
uses m256, mousea, crt, dos;
{ maxmatx e maxmaty s„o as dimens”es reais m xs da matriz }
const maxmatx = 201;  cox = 127;            {201-127}
      maxmaty = 180;  coy = 190;            {180-190}
      botesq = 1;  { botesq = 2 para canhotos }
      botdir = 2;  { botdir = 1 para canhotos }

type tip_mat = array[1..maxmatx, 1..maxmaty] of byte;
{ core, cord s„o as cores activas, bot„o esqe dir do rato }
  { mbp guarda o estado dos bot”es do rato }
var core, cord, ppal, mbp, cor, increm, maxesp : byte;
    op : char;       { guarda a tecla pressionada }
{ matx, maty s„o os "ponteiros" da matriz;
  mx, my, oldmx, oldmy s„o vars para o rato }
    mx, my, matx, maty, oldmx, oldmy : integer;
    barx, bary : real;  { posi‡„o das barras laterais }
    matgraf : tip_mat;  { var array matriz }
    pal, pala : tip_pal; { paletes }
    camOMISSAO : string; { Directoria da palete OMISSAO.PAL }





(***********************************************************************************)

procedure mcores;
begin
{ imprime 2 'bars', 1 interior ao outro, em que cada 1 tem 1 das cores activa
  sendo o bar interior a cor associda ao bot„o esquerdo }
    acor := cord;
    hidemouse;
    bar(295, 171, 319, 187);  { rectangulo a cheio com a cor activa para o }
    acor := core;             { bot„o esquerdo do rato }
    bar(302, 176, 312, 182);  { rectangulo a cheio com a cor activa para o }
    showmouse                 { bot„o direito do rato }
end;


procedure cores(par : byte; mca : boolean);
{ imprime a palette no lado direito do ecran }
var co : byte;  begin
    for co := 0 to 20 do begin
{ somar … cor um deslocamento(par), para mostrar 1 determinada faixa de cores }
        acor := co + par;
        bar(295, co * 8, 319, co * 8 + 8);
    { assinalar as cores activas }
        if mca then begin
           if (pal[acor].verm + pal[acor].verde + pal[acor].azul) < 44 then acor := 15;
           sobre := 0;
           if (co + par) = core then poetexto(298, co * 8, 'E');
           if (co + par) = cord then poetexto(310, co * 8, 'D');
           sobre := 255
        end
    end
end;


procedure rodapal;  begin   { mostra uma diferente parte da palete }
    if (ppal < 235) and (mbp = botesq) then  { avan‡ar uma cor }
       begin
            inc(ppal);
            cores(ppal, on)
       end;
    if (ppal > 0) and (mbp = botdir) then    { recuar uma cor }
       begin
            dec(ppal);
            cores(ppal, on)
       end
end;


procedure codcor;  begin    { imprime no canto inferior direito do visor o }
    acor := 0;              { n§ da cor sobre a qual se clicou com o rato }
    hidemouse;
    poetexto(296, 190, #21);
    poetexto(302, 190, #21);
    poetexto(308, 190, #21);
    poetexto(314, 190, #21);
    acor := 7;
    if mx > 294 then mx := 318;
    poetexto(296, 190, str_(getponto(mx, my)));
    showmouse;
    esp_br
end;



var aux : word;

   procedure desmat; { desenha o conte£do do array matriz na grelha }
   var x, y, mty, mtx : word;

       procedure barPAS (x, y : word);
   { Este proc. coloca um bar na pos (x,y) com 4 pontos de lado }
       var ofst, conty, contx, aux : word;
       begin
            ofst := (y shl 8 + y shl 6) + x;
            aux := 5;
            conty := ofst + (aux shl 8 + aux shl 6);
            repeat
               for contx := ofst to (ofst + 4) do
                   mem[$A000:contx] := acor;
               inc(ofst, 320)
            until ofst = conty
       end;

   begin
        mty := 10;
        for y := maty to (maty + 29) do begin
            mtx := 11;
            for x := matx to (matx + 46) do begin
                acor := matgraf[x, y];
                barPAS(mtx, mty);
                inc(mtx, 6)
            end;
            inc(mty, 6)
        end
   end;


const p = 6;    cy = 9;    cx = 10;   c = 8;
      compx = 292;
      compy = 189;
      cbx = 20;     cby = 12;
      corintbar = 1;
      corbordbar = 9;

procedure barrax;  begin
{ imprime a barra lateral dos x's, ou seja a barra que est  em cima }
    acor := 0;
    hidemouse;
    bar(19, 1, 283, 6);  { limpar o interior da caixa da barra }
    aux := 18 + round(barx);   { calcular a posi‡„o da barra }
    acor := corbordbar;
    bar(aux, 1, aux + cbx, 6);  { desenhar bot„o }
    acor := corintbar;
 { desenhar a 'sombra' do bot„o }
    rectaASM(aux + cbx, 1, aux + cbx, 6);
    rectaASM(aux + cbx, 6, aux, 6);
    rectaASM(aux + cbx - 1, 2, aux + cbx - 1, 6);
    rectaASM(aux + cbx - 1, 5, aux + 1, 5);
    desmat;  { desenhar a matriz na nova posi‡„o }
    showmouse
end;


procedure barray;  begin
{ imprime a barra lateral dos y's, ou seja a barra que est  do lado esquerdo }
    acor := 0;
    hidemouse;
    bar(1, 17, 7, 181); { limpar o interior da caixa da barra }
    aux := 26 + round(bary);    { calcular a posi‡„o da barra }
    acor := corbordbar;
    bar(1, 16 + round(bary), 7, aux + cby);  { desenhar bot„o }
    acor := corintbar;
 { desenhar a 'sombra' do bot„o }
    rectaASM(7, aux - 10, 7, aux + cby);
    rectaASM(7, aux + cby, 1, aux + cby);
    rectaASM(6, aux - 9, 6, aux + cby);
    rectaASM(6, aux + cby - 1, 2, aux + cby - 1);
    desmat;  { desenhar a matriz na nova posi‡„o }
    showmouse
end;


   procedure grelha;
 { desenha a grelha para a matriz }
   var co : word;
   begin
        acor := 1;
    {    ponto(cx,cy);}
        co := cy;
        repeat       { desenha as linhas horizontais da grelha }
             rectaASM(cx, co, compx, co);
             inc(co, p)
        until co = compy + p;
        co := cx;
        repeat       { desenha as linhas verticais da grelha }
             rectaASM(co, cy, co, compy);
             inc(co, p)
        until co = compx + p
   end;


procedure matriz;
{ imprime toda a parte relativa … matriz ampliada }
begin
      grelha;   { desenhar a grelha }
   { indicadores laterais }
      acor := 8;
   { desenha a caixa para o indicador vertical de posi‡„o }
      rectangulo(0, cy, c, compy);
      rectaASM(0, cy + 7, c, cy + 7);
      rectaASM(0, compy - 7, c, compy - 7);
   { desenha a caixa para o indicador horizontal de posi‡„o }
      rectangulo(cx, 0, compx, 7);
      rectaASM(cx + c, 0, cx + c, 6);
      rectaASM(compx - c, 0, compx - c, 6);
   { desenha o quadrado do canto superior esquerdo }
      rectangulo(0, 0, c, c - 1);
      rectangulo(3, 3, c, c - 1);
      acor := 9;
   { imprimir setas das caixas }
      poetexto(2, 12, #28);   poetexto(2, compy - 5, #29);
      poetexto(13, 2, #31);   poetexto(compx - 6, 2, #30);
      barrax;  barray;  { imprimir as barras de posi‡„o }
      desmat  { imprimir a matriz ampliada }
end;


const palav = 11;
      tecfunc = 3;

procedure impopc; begin
{ imprimir op‡”es }
     acor := tecfunc;
     poetexto(1, 192, #22);              poetexto(37, 192, #23);
     poetexto(98, 192, #24);             poetexto(175, 192, #25);
     poetexto(237, 192, #26);            acor := palav;
     poetexto(8, 192, 'VER');            poetexto(45, 192, 'GRAVAR');
     poetexto(106, 192, 'CARREGAR');     poetexto(183, 192, 'PALETE');
     poetexto(245, 192, 'OPCOES')
end;


procedure ini;
begin
     mini;            { coloca em modo MCGA }
     fonte_duplex;    { activa a fonte ('quase' igual … duplex) }
   { 'reseta' o array matriz, colocando 0 em todas as posi‡”es }
     fillchar (matgraf, sizeof(matgraf), 0);
     impopc;        { imprime a £ltima linha do ecran }
     matx := 1;     maty := 1;  { canto sup esq da parte visivel da matriz }
     barx := 1;     bary := 1;  { coords dos indicadores vertic e horizont }
     matriz;        { desenhar a matriz }
     cord := 0;     { var para a cor escolhida pelo bot„o esquerdo do rato }
     core := 15;    { var para a cor escolhida pelo bot„o direito do rato }
     cor := 0;      { inicializar cor 0 para o editor de paletes }
     ppal := 0;     { var deslocamento para a apresenta‡„o da palete … direita }
     increm := 1;   { espalhar uma cor a passos de increm }
     maxesp := 31;  { espalhar uma cor por outras maxesp cores }
     cores(ppal, on); { mostra a palette }
     mcores;        { mostra as cores activas }
     mousenewpos(280, 100);  { rato no centro da matriz }
     showmouse;
end;


 procedure mudacor;  begin
{ escolher uma cor }
     hidemouse;
     cores(ppal, off);
     acor := getponto(mx, my);  { obter a cor presente na posi‡„o do rato }
     case mbp of
          botesq : core := acor;
          botdir : cord := acor
     end;
     cores(ppal, on);
     showmouse;
     mcores;    { mostrar as cores activas }
     esp_br
 end;


 procedure matpixel;
{ imprime um ponto na grelha, na posi‡„o do rato }
 var auxx, auxy : word;
 begin
  { limita os movimentos do rato … grelha }
    xposminmax(cx + 10, compx * 2 - 1);   yposminmax(cy + 1, compy - 1);
  { imprimir pontos enquanto f“r pressionado um bot„o do rato }
    while mousebp <> 0 do begin
    { obter posi‡„o do rato }
     mx := getxpos div 2;    my := getypos;
    { imprimir ponto s¢ se o rato foi movido }
       if (oldmx <> mx) or (oldmy <> my) then begin
       { calcular a posi‡„o do ponto aumentado(bar) no ecran }
           auxx := cx + ((mx - cx) div p) * p + 1;
           auxy := cy + ((my - cy) div p) * p + 1;
       { decidir que cor usar }
           if mbp = botesq then acor := core else acor := cord;
           hidemouse;
       { imprimir o ponto na grelha }
           bar(auxx, auxy, auxx + 4, auxy + 4);
           showmouse;
       { colcocar o ponto na matriz }
           matgraf[matx + ((mx - cx) div p), maty + ((my - cy) div p)] := acor;
           oldmx := mx;
           oldmy := my
       end
    end;
  { devolver liberdade total ao rato }
    xposminmax(0, 639);   yposminmax(0, 199)
 end;


const baryp = maxmaty / coy;
      barxp = maxmatx / cox;
      co = 18;

 procedure movebary;
{ alterar a  rea vertical visivel da matriz }
 begin
   { se o cursor do rato estiver no interior da caixa respectiva, mover a
     matriz 1 ponto para cima, a n„o ser que j  esteja no topo }
      if (my > cy) and (my < (cy + 7)) and (maty > 1)  then begin
         bary := bary - baryp;   { decrementar a posi‡„o da barra }
         dec(maty);              { decrementar o ponteiro da matriz }
         barray                  { mover barra e matriz }
      end;
   { se o cursor do rato estiver no interior da caixa respectiva, mover a
     matriz 1 ponto para baixo, a n„o ser que j  esteja no fim }
      if (my > (compy - 7)) and (my < compy) and (maty < (maxmaty - 29)) then begin
         bary := bary + baryp;   { incrementar a posi‡„o da barra }
         inc(maty);              { incrementar o ponteiro da matriz }
         barray                  { mover barra e matriz }
      end;
   { se o cursor estiver dentro da caixa do bot„o, emt„o mover o bot„o …
     'vontade do rato', enquanto f“r premido um dos bot”es do rato }
      if (my > (cx + 7)) and (my < (compy - 8)) then begin
       { limitar a a‡„o do rato … caixa do bot„o }
         xposminmax(2, 12);    yposminmax(cx + 7, compy - 8);
         oldmy := getypos;      { guardar y actual do rato }
         bary := getypos - co;  { obter 1§ novo valor para }
       { verificar os limites da pos‡„o da barra }
         if bary > 143 then bary := 143;
         if bary < 1 then bary := 1;
       { calcular o novo valor do poiter y para a matriz }
         maty := round(bary / baryp);
         barray;  { mover a barra e a matriz }

         while mousebp <> 0 do begin
               my := getypos;   { obter posi‡„o do rato }
             { se a nova posi‡„o y do rato ‚ diferente da antiga, ‚ porque o
               rato foi movido, e ent„o move a barra e a matriz }
               if (oldmy <> my) then begin
                   bary :=  my - co;  { calcular a nova posi‡„o da barra }
               { verificar os limites da pos‡„o da barra }
                   if bary > 143 then bary := 143;
                   if bary < 1 then bary := 1;
               { calcular o novo valor do poiter y para a matriz }
                   maty := round(bary / baryp);
                   barray;    { mover a barra e a matriz }
                   oldmy := my   { guardar o valor y do rato }
               end
         end;
         { devolver ao rato a liberdade total }
         xposminmax(0, 639);    yposminmax(0, 199)
      end
 end;


 procedure movebarx;
{ alterar a  rea horizontal visivel da matriz }
 begin
 { se o cursor do rato estiver no interior da caixa respectiva, mover a matriz
   1 ponto para a esquerdo, a n„o ser que j  esteja no extremo esquerdo }
      if (mx > cx) and (mx < (cx + 7)) and(matx > 1) then begin
         barx := barx - barxp;   { decrementar a posi‡„o da barra }
         dec(matx);              { decrementar o ponteiro da matriz }
         barrax                  { mover barra e matriz }
      end;
 { se o cursor do rato estiver no interior da caixa respectiva, mover a matriz
   1 ponto para a direita, a n„o ser que j  esteja no extremo direito }
      if (mx > (compx - 8)) and (mx < compx) and (matx < (maxmatx - 46)) then begin
         barx := barx + barxp;   { incrementar a posi‡„o da barra }
         inc(matx);              { incrementar o ponteiro da matriz }
         barrax                  { mover barra e matriz }
      end;
   { se o cursor estiver dentro da caixa do bot„o, emt„o mover o bot„o …
     'vontade do rato', enquanto f“r premido um dos bot”es do rato }
      if (mx > (cx + 8)) and (mx < (compx - 8)) then begin
      { limitar a a‡„o do rato … caixa do bot„o }
         yposminmax(1, 6);    xposminmax(cx + 26, (compx - 8) * 2);
         oldmx := mx;        { guardar y actual do rato }
         barx := mx - co;    { obter 1§ novo valor para }
      { verificar os limites da pos‡„o da barra }
         if barx > 245 then barx := 245;
         if barx < 1 then barx := 1;
      { calcular o novo valor do poiter y para a matriz }
         matx := round(barx / barxp);
         barrax;  { mover barra e matriz }

         while mousebp <> 0 do begin
               mx := getxpos div 2;   { obter posi‡„o do rato }
             { se a nova posi‡„o y do rato ‚ diferente da antiga, ‚ porque o
               rato foi movido, e ent„o move a barra e a matriz }
               if (oldmx <> mx) then begin
                   barx :=  mx - co;     { calcular a nova posi‡„o da barra }
               { verificar os limites da pos‡„o da barra }
                   if barx > 245 then barx := 245;
                   if barx < 1 then barx := 1;
               { calcular o novo valor do poiter y para a matriz }
                   matx := round(barx / barxp);
                   barrax;      { mover barra e matriz }
                   oldmx := mx  { guardar o valor y do rato }
               end
         end;
         { devolver ao rato a liberdade total }
         xposminmax(0, 639);    yposminmax(0, 199)
      end
 end;

{$I grafazin }
{$I grafpal }

  procedure ciclo;
  var mostra : boolean;
                         procedure tooglecod;  begin
 { faz o "toogle" entre }    mostra := not(mostra); { inverte o valor da var }
 { mostrar ou n„o       }    if mostra then acor := 9
 { o n§ de uma cor      }    else acor := 0;
                             hidemouse;
                    { se mostra ‚ true, a cor activa ‚ visivel e a recta ver-
                      -se- . Caso contr rio a cor ‚ preta e n„o se vˆ a recta }
                             rectaASM(294, 199, 319, 199);
                             showmouse;
                             esp_br   { espera que sejam libertados todos os }
                         end;         { bot”es do rato }

  begin
       mostra := false;
       repeat
             op := #1;
        { s¢ lˆ uma tecla se houve alguma perssionada pois se n„o fosse assim
          o rato n„o funcionaria porque a execu‡„o ficaria aqui presa }
             if keypressed then op := readkey;
             if op = #0 then begin
                op := readkey;
                case op of
              { F1 } #59 : ver;
              { F2 } #60 : gravar;
              { F3 } #61 : carregar;
              { F4 } #62 : palete;
              { F5 } #63 : opcoes
                end;
                op := #1
             end;

             mbp := mousebp;  { obter o estado dos bot”es do rato }
             mx := getxpos div 2; { obter posi‡„o x do rato }
             my := getypos;    { obter posi‡„o y do rato }
             if mbp <> 0 then begin  { se foi premido algum bot„o... }
             { marcar "ponto" na matriz, se n„o se est  em modo 'ver c¢d cor' }
                 if (mx < 292) and (mx > 9) and (my > 8) and (my < 188) and
                    not(mostra) then matpixel;
             { "rodar" a palete }
                 if (mx > 294) and (my > 170) and (my < 187) then rodapal;
             { mostrar o n§ da cor, se a var mostra o permitir (f“r = true) }
                 if mostra then codcor;
             { escolher cores, mas s¢ se n„o est  em modo 'ver c¢digo de cor' }
                 if (mx > 294) and (my < 169) and not(mostra) then mudacor;
             { mostrar o canto superior esquerdo da matriz }
                 if (mx < 8) and (my < 8) then begin
                 { 'resetar' as vari veis }
                     matx := 1;   maty := 1;  barx := 1;  bary := 1;
                     barray;  barrax    { imprimir o canto da matriz }
                 end
             end;

        { se foi premido o bot„o esquerdo do rato... }
             if (mbp = botesq) then begin
             { se o rato estiver no canto inferior direito do ecran a var
               booleana mostra ser  invertida }
                if (mx > 294) and (my > 187) then tooglecod;
             { alterar a parte vertical visivel da matriz }
                if (mx < 8) then movebary;
             { alterar a parte horizontal visivel da matriz }
                if (my < 7) then movebarx;
           { Escolher op‡”es por clic do rato. }
                if (my > 191) and (mx < 294) then begin
                    if (mx > 0) and (mx < 32) then ver;            { F1 }
                    if (mx > 36) and (mx < 92) then gravar;        { F2 }
                    if (mx > 97) and (mx < 169) then carregar;     { F3 }
                    if (mx > 174) and (mx < 231) then palete;      { F4 }
                    if (mx > 237) and (mx < 293) then opcoes       { F5 }
                end
             end;

          { se foi pressionada a tecla ESC, para sair, pedir confirma‡„o }
             if op = #27 then begin
                   janp(on);    { abria uma janela de di logo }
                   poetexto(jnix + 38, jniy + 20, 'SAIR ?');
                   showmouse;
                   op := upcase(readkey);
                   hidemouse;
                   janp(off);   { fechar janela }
                   showmouse;
                   if op = 'S' then op := #27
             end

       until op = #27
  end;


begin
   { Obter o path dos ficheiros por omiss„o (dir actual) }
     getdir(0, path);
     if path[length(path)] <> '\' then
        path := path + '\';  
     camOMISSAO := path;
     ini;        { inicializar vars, ecran }
     palom;      { palete por omiss„o }
     ciclo;      { ciclo de utiliza‡„o }
     hidemouse;
     textmode(lastmode); { voltar ao modo activo antes da entrada no programam }
     clrscr;
     writeln(' Qualquer contacto com o autor (cr¡ticas, sugest”es, informa‡”es, etc.),');
     writeln;
     writeln('        telf. 4956868 da rede de Lisboa, ou');
     writeln('  carta dirigida a NSJ,');
     writeln;
     writeln('      Rua Jos‚ Mergulh„o, n§4 6§L Reboleira Sul  2700 Amadora ');
     writeln;
     writeln('Ent„o at‚ … pr¢xima!');
     writeln
end.








