{ Este programa embora provavelmente um pouco confuso e mal comentado mostra
que e como � possivel usarem-se EGB's para montar uma pequena anima��o, com
sprites n�o muito grandes, usando unicamente o PASCAL (isto sem contar com o
assembler das rotinas gr�ficas da unidade M256). Quero nesta pequena intro-
du��o apenas tentar explicar os m�todos utilizados na 'anima��o', que incluem
fazer um EGB passar por cima de uma imagem sem a danificar e passar por detr�s
tamb�m de uma imagem sem se danificar.
  O m�todo para a coloca��o de um EGB no ecran 'sem danos' � simples:

         1� guarda-se uma c�pia da imagem de fundo que se encontra no
            ecran (var vcran);
         2� copia-se para um pequeno buffer (var buff) (cujo tamanho � x
            pontos maior para cada lado (cima, baixo, esq, dir) do que o
            tamanho do EGB, em que x � o n� m�x de pontos de uma s� vez
            que se deseja mover o EGB), o peda�o da imagem de fundo que
            vai ser sobreposta pelo EGB (esta opera��o � efectuada pelo
            procedimento poefundo);
         3� copia-se para o buffer o EGB, ficando este por cima da imagem
            de fundo. � nesta opera��o que se podem definir c�digos de cor
            que s�o especiais, ou seja, que n�o s�o copiados para o buffer
            (ex: a cor de fundo do EGB), etc. (esta opera��o � efectuada
            pelo procedimento mixsnopy);
         4� por �ltimo, estando j� a imagem pronta na mem�ria, � s� coloc�-
            -la no ecran, na posi��o de onde a imagem de fundo do buffer
            foi retirada, (esta opera��o � efectuada pelo procedimento
            poeima) sobrepondo a imagem anterior do EGB, n�o sendo neces-
            s�rio apag�-la antes de imprimir a nova. Procedendo deste modo
            a imagem n�o pisca nem um pouco!

  NOTA: Voc�s poderam dizer - ocupar 64000 bytes de mem�ria s� para guardar
        a imagem de fundo, porque n�o utilizar o array mais pequeno, digamos
        s� com o tamanho da �rea que vai ser sobreposta? A resposta � simples:
        s� porque � mais f�cil, e tamb�m um pouco mais r�pido fazer dessa
        maneira. Obviamente que � possivel usar um array apenas com as dimen-
        s�es da �rea sobreposta, mas esse m�todo acarreta mais computa��o e
        a� teriamos que sair do PASCAL para entrar noutras linguagens
        (ASSEMBLY). Al�m do mais, mais 64000 menos 64000...

        O mais trabalhoso nisto tudo, �, sem d�vida fazer os desenhos.
        Carregando numa tecla durante a anima��o, esta � acelerada.

Espero ter-me feito entender m�nimamente, e fico � espera de algumas das
vossas anima��es. Podem (e devem) tentar melhorar e at� refazer o m�todo
utilizado. Qualquer pergunta que queiram fazer terei todo o gosto em vos
responder (desde que eu saiba...). Boas anima��es!
}

uses M256, CRT{, mousea};
const cam = '';
      atraso = 150;
type tmp = array[0..29, 0..(185*2)] of byte;
     i = array[0..199, 0..319] of byte;

var vcran : ^i;
    ecran : i absolute $A000:0000;
    snop : array[1..12, 0..29, 0..31] of byte;
  { buffer c/ uma dimens�o de 33x33 pontos (cada snopy tem 30x32 pontos) }
    buff : array[0..32, 0..32] of byte;
    a, b : byte;  { Contadores para os ciclos da anima��o }



    procedure pausa(n : word);
{ Faz um 'delay' de n milissegundos mas incurta-o se � pressionada uma tecla }
     begin
          repeat
                delay(1);
                dec(n)
          until keypressed or (n = 0);
          if keypressed then readkey
     end;


    procedure loadsnopy;
 { Carrega os 2 ficheiros EGB que cont�m o snopy em v�rias posi�oes,
   colocando-as na var snop }
    var f : file of byte;
    var x, y : word;
        s : ^tmp; { var tempor�ria, apenas para ajudar no carregamento dos EGB's }

       procedure movesnopy (n, d : word);
     { Passar os gr�ficos da var s tempor�ria para a snop }
       var x, y : byte;
       begin
            for y := 0 to 29 do
                for x := 0 to 28 do
                    snop[n, y, x + 2] := s^[y, x + d]
       end;

    begin
       { Encher as vars com a cor de fundo dos EGB's. Necess�rio, pois estas
         vars s�o 'maiores' do que os EGB's. }
         fillchar(s, sizeof(s), 208);
         fillchar(snop, sizeof(snop), 208);
         new(s);  { Alocar mem }
         assign(f, cam + 'SNOPY2.EGB');
         reset(f);
         for x := 1 to 13 do read(f, a);  { Descartar o cabe�alho }
         for y := 0 to 29 do              { Carregar o bloco }
             for x := 0 to 184 do
                 read(f, s^[y, x]);
         close(f);
         assign(f, cam + 'SNOPY2B.EGB');
         reset(f);
         for x := 1 to 13 do read(f, a);  { Descartar o cabe�alho }
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
         { O c�digo de cor do fundo sobre o qual o snopy foi desenhado � 208,
           e logo a condi��o seguinte serve para ignorar esse c�digo, evitando
           que o snopy apare�a dentro de uma caixa. }
                      if a <> 208 then
                          begin
                               b := buff[y + 1, x + 2];
         { O snopy foi desenhado com a cor 15 para branco, mas a palete da
           imagem de fundo tem essa cor alterada. Assim, a linha seguinte
           serve para substituir esse c�digo de cor por outro que seja branco
           na palete da imagem de fundo. }
                               if a = 15 then a := 208;
         { A condi��o da linha seguinte "faz" com que o snopy passe por detr�s
           do carro. Os c�digos de cor que formam o carro est�o entre 25 e 32.
           Assim, ao imprimir um ponto do snopy, � verificada o c�digo de cor
           que se encontra na posi��o de destino do ponto, e, se este f�r um
           dos c�digos do carro, o "ponto do snopy" n�o � impresso. }
                               if (b < 25) or (b > 32) then
                                  buff[y + 1, x + 2] := a
                          end
                 end
    end;

    procedure poefundo(a, b : word);
  { Copia uma �rea rectangular da imagem de fundo guardada na mem�ria (n�o no
    buffer de video) para a var buff. Essa �rea tem como canto sup esq (a,b),
    e a largura e a altura s�o as da var buff. }
    var y : byte;
    begin
         for y := 0 to 32 do
             move(vcran^[y + b, a], buff[y], sizeof(buff[y]));
    end;

    procedure poeima(a, b : integer);
  { Copia a imagem contida na var buff para a posi��o (a,b) do ecran }
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
  { Coloca a posi��o n do snopy na posi��o (x,y) do ecran }
    begin
         poefundo(x, y);  { Imagem de fundo para o buff }
         mixsnopy(n);     { Snopy para o buff }
         poeima(x, y)     { Buff para o ecran }
    end;


    procedure ini;
    begin
         mini;
         loadsnopy; { Carregar os gr�ficos }
         loadfundo;
       { Copia do buffer de video para uma var na mem�ria convencional }
         vcran^ := ecran;
         pausa(20);
{         fundo(0);}
(*         showmouse;    { Usei este tro�o de programa que est� em coment�rio }
         fonte_duplex;  { para descobrir os c�digos de cor que 'o carro usa' }
         repeat
               if mousebp = 1 then
                  begin
                       hidemouse;
                       pt(0,0,#21#21#21#21#21#21#21#21#21, 0);
                       pt(0,0,stri(getponto(mgetxpos, getypos)), 208);
                       showmouse;
                  end
         until mousebp = 2;*)
         ligaRGBpal(254, 0, 0, 0);  { "Eliminar uma cor indesej�vel" }
    end;

    procedure anim;
  { Produzir a anima��o }
    var px, py : integer;
        del1, del2 : word;
        l : boolean;
    begin
       { posi��o inicial do snopy }
         py := 151; { 169 }
         px := -29; { -29 para o snopy vir de fora do ecran }
         l := on;
         repeat   { O snopy anda at� +- 1/5 do ecran... }
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
     new(vcran);     { Alocar mem�ria para a vari�vel }
     ini;
     anim;
     readkey;
     dispose(vcran);  { Desalocar a mem�ria alocada � vari�vel }
     textmode(lastmode);
     clrscr;
     writeln(' Qualquer contacto com o autor (cr�ticas, sugest�es, informa��es, etc.),');
     writeln;
     writeln('        telf. 4956868 da rede de Lisboa, ou');
     writeln('  carta dirigida a NSJ,');
     writeln;
     writeln('      Rua Jos� Mergulh�o, n�4 6�L Reboleira Sul  2700 Amadora ');
     writeln;
     writeln('Ent�o at� � pr�xima!');
     writeln
end.



















