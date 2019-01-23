{ Este programa embora provavelmente um pouco confuso e mal comentado mostra
que e como Ç possivel usarem-se EGB's para montar uma pequena animaáÑo, com
sprites nÑo muito grandes, usando unicamente o PASCAL (isto sem contar com o
assembler das rotinas gr†ficas da unidade M256). Quero nesta pequena intro-
duáÑo apenas tentar explicar os mÇtodos utilizados na 'animaáÑo', que incluem
fazer um EGB passar por cima de uma imagem sem a danificar e passar por detr†s
tambÇm de uma imagem sem se danificar.
  O mÇtodo para a colocaáÑo de um EGB no ecran 'sem danos' Ç simples:

         1ß guarda-se uma c¢pia da imagem de fundo que se encontra no
            ecran (var vcran);
         2ß copia-se para um pequeno buffer (var buff) (cujo tamanho Ç x
            pontos maior para cada lado (cima, baixo, esq, dir) do que o
            tamanho do EGB, em que x Ç o nß m†x de pontos de uma s¢ vez
            que se deseja mover o EGB), o pedaáo da imagem de fundo que
            vai ser sobreposta pelo EGB (esta operaáÑo Ç efectuada pelo
            procedimento poefundo);
         3ß copia-se para o buffer o EGB, ficando este por cima da imagem
            de fundo. ê nesta operaáÑo que se podem definir c¢digos de cor
            que sÑo especiais, ou seja, que nÑo sÑo copiados para o buffer
            (ex: a cor de fundo do EGB), etc. (esta operaáÑo Ç efectuada
            pelo procedimento mixsnopy);
         4ß por £ltimo, estando j† a imagem pronta na mem¢ria, Ç s¢ coloc†-
            -la no ecran, na posiáÑo de onde a imagem de fundo do buffer
            foi retirada, (esta operaáÑo Ç efectuada pelo procedimento
            poeima) sobrepondo a imagem anterior do EGB, nÑo sendo neces-
            s†rio apag†-la antes de imprimir a nova. Procedendo deste modo
            a imagem nÑo pisca nem um pouco!

  NOTA: Vocàs poderam dizer - ocupar 64000 bytes de mem¢ria s¢ para guardar
        a imagem de fundo, porque nÑo utilizar o array mais pequeno, digamos
        s¢ com o tamanho da †rea que vai ser sobreposta? A resposta Ç simples:
        s¢ porque Ç mais f†cil, e tambÇm um pouco mais r†pido fazer dessa
        maneira. Obviamente que Ç possivel usar um array apenas com as dimen-
        sîes da †rea sobreposta, mas esse mÇtodo acarreta mais computaáÑo e
        a° teriamos que sair do PASCAL para entrar noutras linguagens
        (ASSEMBLY). AlÇm do mais, mais 64000 menos 64000...

        O mais trabalhoso nisto tudo, Ç, sem d£vida fazer os desenhos.
        Carregando numa tecla durante a animaáÑo, esta Ç acelerada.

Espero ter-me feito entender m°nimamente, e fico Ö espera de algumas das
vossas animaáîes. Podem (e devem) tentar melhorar e atÇ refazer o mÇtodo
utilizado. Qualquer pergunta que queiram fazer terei todo o gosto em vos
responder (desde que eu saiba...). Boas animaáîes!
}

uses M256, CRT{, mousea};
const cam = '';
      atraso = 150;
type tmp = array[0..29, 0..(185*2)] of byte;
     i = array[0..199, 0..319] of byte;

var vcran : ^i;
    ecran : i absolute $A000:0000;
    snop : array[1..12, 0..29, 0..31] of byte;
  { buffer c/ uma dimensÑo de 33x33 pontos (cada snopy tem 30x32 pontos) }
    buff : array[0..32, 0..32] of byte;
    a, b : byte;  { Contadores para os ciclos da animaáÑo }



    procedure pausa(n : word);
{ Faz um 'delay' de n milissegundos mas incurta-o se Ç pressionada uma tecla }
     begin
          repeat
                delay(1);
                dec(n)
          until keypressed or (n = 0);
          if keypressed then readkey
     end;


    procedure loadsnopy;
 { Carrega os 2 ficheiros EGB que contàm o snopy em v†rias posiáoes,
   colocando-as na var snop }
    var f : file of byte;
    var x, y : word;
        s : ^tmp; { var tempor†ria, apenas para ajudar no carregamento dos EGB's }

       procedure movesnopy (n, d : word);
     { Passar os gr†ficos da var s tempor†ria para a snop }
       var x, y : byte;
       begin
            for y := 0 to 29 do
                for x := 0 to 28 do
                    snop[n, y, x + 2] := s^[y, x + d]
       end;

    begin
       { Encher as vars com a cor de fundo dos EGB's. Necess†rio, pois estas
         vars sÑo 'maiores' do que os EGB's. }
         fillchar(s, sizeof(s), 208);
         fillchar(snop, sizeof(snop), 208);
         new(s);  { Alocar mem }
         assign(f, cam + 'SNOPY2.EGB');
         reset(f);
         for x := 1 to 13 do read(f, a);  { Descartar o cabeáalho }
         for y := 0 to 29 do              { Carregar o bloco }
             for x := 0 to 184 do
                 read(f, s^[y, x]);
         close(f);
         assign(f, cam + 'SNOPY2B.EGB');
         reset(f);
         for x := 1 to 13 do read(f, a);  { Descartar o cabeáalho }
         for y := 0 to 29 do              { Carregar o bloco }
             for x := 185 to 369 do
                 read(f, s^[y, x]);
         close(f);

         movesnopy(1, 0);
         movesnopy(2, 31);
         movesnopy(3, 62);
         movesnopy(4, 93);
         movesnopy(5, 94 + 30);
         movesnopy(6, 95 + 60);
         movesnopy(7, 185);
         movesnopy(8, 216);
         movesnopy(9, 187 + 60);
         movesnopy(10, 188 + 90);
         movesnopy(11, 189 + 120);
         movesnopy(12, 190 + 150);
         dispose(s);   { Libertar a mem }
    end;

    procedure loadfundo;
  { Carrega a imagem de fundo directamente para o buffer de video }
    var f : file;
        pal : tip_pal; 
    begin
         assign(f, cam + 'imagem1.EGB');
         reset(f, 1);
         blockread(f, pal, sizeof(pal));
         ligapal(pal);
         blockread(f, ecran, sizeof(ecran));
         close(f);
    end;


    procedure mixsnopy(n : byte);
  { Mistura a imagem n do snopy contida na var snop com a var buff }
    var x, y, a, b : byte;
    begin
         for y := 0 to 29 do
             for x := 0 to 30 do
                 begin
                      a := snop[n, y, x];
         { O c¢digo de cor do fundo sobre o qual o snopy foi desenhado Ç 208,
           e logo a condiáÑo seguinte serve para ignorar esse c¢digo, evitando
           que o snopy apareáa dentro de uma caixa. }
                      if a <> 208 then
                          begin
                               b := buff[y + 1, x + 2];
         { O snopy foi desenhado com a cor 15 para branco, mas a palete da
           imagem de fundo tem essa cor alterada. Assim, a linha seguinte
           serve para substituir esse c¢digo de cor por outro que seja branco
           na palete da imagem de fundo. }
                               if a = 15 then a := 208;
         { A condiáÑo da linha seguinte "faz" com que o snopy passe por detr†s
           do carro. Os c¢digos de cor que formam o carro estÑo entre 25 e 32.
           Assim, ao imprimir um ponto do snopy, Ç verificada o c¢digo de cor
           que se encontra na posiáÑo de destino do ponto, e, se este fìr um
           dos c¢digos do carro, o "ponto do snopy" nÑo Ç impresso. }
                               if (b < 25) or (b > 32) then
                                  buff[y + 1, x + 2] := a
                          end
                 end
    end;

    procedure poefundo(a, b : word);
  { Copia uma †rea rectangular da imagem de fundo guardada na mem¢ria (nÑo no
    buffer de video) para a var buff. Essa †rea tem como canto sup esq (a,b),
    e a largura e a altura sÑo as da var buff. }
    var y : byte;
    begin
         for y := 0 to 32 do
             move(vcran^[y + b, a], buff[y], sizeof(buff[y]));
    end;

    procedure poeima(a, b : integer);
  { Copia a imagem contida na var buff para a posiáÑo (a,b) do ecran }
    var x, y : byte;
    begin
         for y := 0 to 31 do
             for x := 0 to 31 do
                 begin
                      acor := buff[y, x];
                      ponto(x + a, y + b)
                 end
    end;

    procedure poesnopy(n, x, y : word);
  { Coloca a posiáÑo n do snopy na posiáÑo (x,y) do ecran }
    begin
         poefundo(x, y);  { Imagem de fundo para o buff }
         mixsnopy(n);     { Snopy para o buff }
         poeima(x, y)     { Buff para o ecran }
    end;


    procedure ini;
    begin
         mini;
         loadsnopy; { Carregar os gr†ficos }
         loadfundo;
       { Copia do buffer de video para uma var na mem¢ria convencional }
         vcran^ := ecran;
         pausa(20);
{         fundo(0);}
(*         showmouse;    { Usei este troáo de programa que est† em coment†rio }
         fonte_duplex;  { para descobrir os c¢digos de cor que 'o carro usa' }
         repeat
               if mousebp = 1 then
                  begin
                       hidemouse;
                       pt(0,0,#21#21#21#21#21#21#21#21#21, 0);
                       pt(0,0,stri(getponto(mgetxpos, getypos)), 208);
                       showmouse;
                  end
         until mousebp = 2;*)
         ligaRGBpal(254, 0, 0, 0);  { "Eliminar uma cor indesej†vel" }
    end;

    procedure anim;
  { Produzir a animaáÑo }
    var px, py : integer;
        del1, del2 : word;
        l : boolean;
    begin
       { posiáÑo inicial do snopy }
         py := 151; { 169 }
         px := -29; { -29 para o snopy vir de fora do ecran }
         l := on;
         repeat   { O snopy anda atÇ +- 1/5 do ecran... }
               poesnopy(3, px, py);
               pausa(atraso);
               inc(px, 2);
               if l then poesnopy(1, px, py) else poesnopy(2, px, py);
               inc(px, 2);
               l := not(l);
               pausa(atraso);
         until px > 45;

         dec(px, 2);
         poesnopy(3, px, py);
         pausa(550);
         poesnopy(4, px, py);
         pausa(1000);

         for del1 := 1 to 2 do    { ...pisca o olho... }
             begin
                  poesnopy(3, px, py);
                  pausa(90);
                  poesnopy(4, px, py);
                  pausa(150);
             end;
         pausa(300);
         poesnopy(3, px, py);
         pausa(500);
         for del1 := 7 to 10 do   { ...ri-se... }
             begin
                  poesnopy(del1, px, py);
                  pausa(150);
             end;
         pausa(1000);
         l := on;
         repeat           { ...e vai-se embora. }
               poesnopy(3, px, py);
               pausa(atraso);
               inc(px, 2);
               if l then poesnopy(1, px, py) else poesnopy(2, px, py);
               inc(px, 2);
               l := not(l);
               pausa(atraso);
         until px > 320;

    end;


begin
     new(vcran);     { Alocar mem¢ria para a vari†vel }
     ini;
     anim;
     readkey;
     dispose(vcran);  { Desalocar a mem¢ria alocada Ö vari†vel }
     textmode(lastmode);
     clrscr;
     writeln(' Qualquer contacto com o autor (cr°ticas, sugestîes, informaáîes, etc.),');
     writeln;
     writeln('        telf. 4956868 da rede de Lisboa, ou');
     writeln('  carta dirigida a NSJ,');
     writeln;
     writeln('      Rua JosÇ MergulhÑo, nß4 6ßL Reboleira Sul  2700 Amadora ');
     writeln;
     writeln('EntÑo atÇ Ö pr¢xima!');
     writeln
end.



















