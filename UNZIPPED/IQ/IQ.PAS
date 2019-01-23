{$M 65520, 0, 65535}

Program IQ (Input, Output);    { Por Carlos Miguel Queir¢s Fria‡as }
                               { Aluno da F.C.U.L. - Informatica   }
                               { Para a Revista SPOOLER            }
                               { Outubro de 1993                   }


Uses
  Crt, Dos, Graph, BgiDriv, BgiFont;
  { BgiDriv apenas cont‚m o EGAVGA.BGI }


Var
  i, X, Y: Byte;
  fim: Boolean;


Type

  Um6 = 1 .. 6;

  Zero2 = 0 .. 2;

  St5 = String[5];

  St12 = String[12];

  Opcoes = Array [1 .. 9] of String[16];

  Tem = Array [1 .. 7] of String[14];

  Tem2 = Array [1 .. 7] of String[8];

  Arr20 = Array [1 .. 20] of Byte;

  Question = Record
                   q: String[132];                   { Quest„o - max 132 }
                 ans: Array [1 .. 5] of String[40];  { 5 Op‡”es - max 40 }
               certa: #65 .. #69;                    { Resposta Correcta }
             end;

  SetOfQuestions = Array [1 .. 10] of question;  { Question rio de 10 perguntas }

  Assunto = Array [1 .. 6] of Setofquestions;  { Conjunto de 6 question rios (necess rio para formar um ficheiro completo) }

  Time = record
           hh, mm, ss, s100: Word;  { horas, minutos, segundos, cent‚simos de segundo }
         end;

  Records = record
              Nome: String[13];     { Nome do jogador detentor do Recorde }
              Assunto: String[12];  { Assunto }
              PONTIQ: Byte;         { Pontua‡„o }
            end;

  Recs = Array [1 .. 15] of Records;  { Lista de 15 registos }

  T = File of Recs;  { Ficheiro de Records }

  Assunto_Fich = Record
                   nome_fich: st12;  { Nome do ficheiro }
                   assunto: st12;    { Assunto do question rio }
                 end;

  Adds = Array [1 .. 9] of Word;  { Vector de elementos a adicionar }

  Med = Array [1 .. 9] of Real;  { Vector de M‚dias }


Const

  { As pr¢ximas 3 vari veis v„o ser definidas como constantes,
    embora sendo arrays ‚ perfeitamente poss¡vel defini-los como
    tal, atrav‚s da defini‡„o de todos os seus elementos }

  { Op‡”es do Menu }
  MainMenu : Opcoes = ('     Jogar      ','     Duelo      ','     Criar      ',
                       '    Importar    ','    Recordes    ','    Graficos    ',
                       '     Shell      ','   Sair para    ','     o Dos.     ');

  { Temas Principais (criados pelo programador) }
  Temas : Tem = ('   DESPORTO   ',' INFORMATICA  ','   CIENCIAS   ','  TELEVISAO   ',
                 '    CINEMA    ','  HISTORIA    ','  GEOGRAFIA   ');

  { Nomes dos ficheiros dos temas principais (devido ao condicionalismo dos 8 caracteres) }
  FileNames : Tem2 = ('DESPORTO','INFORMAT','CIENCIAS','TELEVISA',
                      'CINEMA  ','HISTORIA','GEOGRAFI');



{  **********     Procedimentos     **********  }


Procedure Hide_Cursor (Color: Byte);
{ Esconder Cursor utilizando a cor existente no canto superior esquerdo
  do ‚cran, e criando um janela de 2 caracteres, que posteriormente vai ser limpa. }

begin
  TextBackGround (Color); TextColor (Color);
  Window (1,1,2,1);
  GotoXY (1,1);
  ClrEol;
end;


Procedure WriteXY (X, Y: Byte; s: String; cor: Byte);
{ A ideia deste procedimento ‚ a mesma do ®OutTextXY¯ (do modo gr fico),
 ou seja, escrever uma String no ‚cran, inserindo na mesma instru‡„o
 as suas coordenadas e a sua cor. }

begin
  TextColor (cor);
  GotoXY (X,Y);
  Write (s);
end;


Procedure Esvazia_Buffer;
{ Basicamente o que este procedimento faz ‚ ®despejar¯ para uma vari vel
  todos os ®toques¯ em teclas, que fiquem armazenados no buffer do teclado.
  A aplica‡„o pr tica disto, por exemplo, ‚ que se carregarmos em ®Enter¯
  duas vezes e tivermos um Menu ®por baixo¯ do outro, ‚ evitada a escolha
  imediata da 1¦ op‡„o do 2§ Menu }

var
  ch: Char;

begin
  Repeat
    if KeyPressed then ch:=ReadKey;
  Until (not KeyPressed);
end;


Procedure Hold;
{ Serve para deixar o utilizador ver o conte£do do ‚cran durante o tempo
  que ele desejar, pois a pr¢xima instru‡„o s¢ ser  executada depois de
  ser premida qualquer tecla. Normalmente, a chamada a este procedimento
  ‚ sempre acompanhada de uma mensagem do g‚nero ®Carregue em alguma tecla
  para continuar }

begin
  Esvazia_Buffer;
  Repeat Until KeyPressed;
end;


Procedure Abertura;
{ Este procedimento destina-se iniciar o programa (em modo de texto).
  A sua caracter¡stica mais especial ‚ a de escrever no ‚cran aleatoriamente
  116 blocos, recorrendo a combina‡”es de 4, por forma a escrever
  em cada 29 sectores os 4 blocos (²²), necess rios … forma‡„o de ®I.Q.¯. (29 * 4 = 116) }

type
  posicao = Record
              x: Byte;
              y: Byte;
            end;

  X = Array [1 .. 116] of posicao;

  Z = Array [1 .. 4] of 1 .. 4;

const
  { Pontos }
  quadrado : X =
  ((x:1;y:1),   (x:3;y:1),   (x:5;y:1),   (x:7;y:1),   (x:9;y:1),
   (x:11;y:1),  (x:13;y:1),  (x:15;y:1),  (x:29;y:1),  (x:31;y:1),
   (x:33;y:1),  (x:35;y:1),  (x:37;y:1),  (x:39;y:1),  (x:41;y:1),
   (x:43;y:1),  (x:1;y:2),   (x:3;y:2),   (x:5;y:2),   (x:7;y:2),
   (x:9;y:2),   (x:11;y:2),  (x:13;y:2),  (x:15;y:2),  (x:29;y:2),
   (x:31;y:2),  (x:33;y:2),  (x:35;y:2),  (x:37;y:2),  (x:39;y:2),
   (x:41;y:2),  (x:43;y:2),  (x:7;y:3),   (x:9;y:3),   (x:29;y:3),
   (x:31;y:3),  (x:41;y:3),  (x:43;y:3),  (x:7;y:4),   (x:9;y:4),
   (x:29;y:4),  (x:31;y:4),  (x:41;y:4),  (x:43;y:4),  (x:7;y:5),
   (x:9;y:5),   (x:29;y:5),  (x:31;y:5),  (x:41;y:5),  (x:43;y:5),
   (x:7;y:6),   (x:9;y:6),   (x:29;y:6),  (x:31;y:6),  (x:41;y:6),
   (x:43;y:6),  (x:7;y:7),   (x:9;y:7),   (x:29;y:7),  (x:31;y:7),
   (x:41;y:7),  (x:43;y:7),  (x:7;y:8),   (x:9;y:8),   (x:29;y:8),
   (x:31;y:8),  (x:41;y:8),  (x:43;y:8),  (x:7;y:9),   (x:9;y:9),
   (x:29;y:9),  (x:31;y:9),  (x:35;y:9),  (x:37;y:9),  (x:41;y:9),
   (x:43;y:9),  (x:7;y:10),  (x:9;y:10),  (x:29;y:10), (x:31;y:10),
   (x:37;y:10), (x:39;y:10), (x:43;y:10), (x:1;y:11),  (x:3;y:11),
   (x:5;y:11),  (x:7;y:11),  (x:9;y:11),  (x:11;y:11), (x:13;y:11),
   (x:15;y:11), (x:19;y:11), (x:29;y:11), (x:31;y:11), (x:33;y:11),
   (x:35;y:11), (x:39;y:11), (x:41;y:11), (x:47;y:11), (x:1;y:12),
   (x:3;y:12),  (x:5;y:12),  (x:7;y:12),  (x:9;y:12),  (x:11;y:12),
   (x:13;y:12), (x:15;y:12), (x:19;y:12), (x:29;y:12), (x:31;y:12),
   (x:33;y:12), (x:35;y:12), (x:37;y:12), (x:41;y:12), (x:43;y:12),
   (x:47;y:12));

  { Combinac”es de 4, 4 a 4 = 4! = 1 * 2 * 3 * 4 = 24. }
  comb : Array [1 .. 24] of Z =
         ((1,2,3,4),(1,2,4,3),(1,3,2,4),(1,3,4,2),(1,4,2,3),(1,4,3,2),
          (2,1,3,4),(2,1,4,3),(2,3,1,4),(2,3,4,1),(2,4,1,3),(2,4,3,1),
          (3,1,2,4),(3,1,4,2),(3,2,1,4),(3,2,4,1),(3,4,1,2),(3,4,2,1),
          (4,1,3,2),(4,1,2,3),(4,2,1,3),(4,2,3,1),(4,3,1,2),(4,3,2,1));

var
  i, j, k, num: Byte;
  ja: Array [1 .. 29] of Z;

begin
  ClrScr;
  TextBackGround (LightBlue);
  ClrEol;
  GotoXY (1,25);
  ClrEol;
  GotoXY (1,1);
  Write ('  I.Q. - MEDIDOR DE INTELIGENCIA E CONHECIMENTO - FEITO PARA A REVISTA SPOOLER');
  GotoXY (1,25);
  Write ('  AUTOR : CARLOS M. Q. FRIA€AS - @ 1993 CMF SoftWonders - Feito em TPascal 6.0');
  TextBackGround (Black);
  TextColor (Black);

  GotoXY (1,4);
  TextColor (Red);

  For i:=1 to 29 do
    begin
      num := Random (24) + 1;
      ja[i]:=comb[num];
    end;

  Window (17,7,65,18);
  For j:=1 to 4 do
    For i:=1 to 29 do
      begin
        GotoXY (quadrado[ja[i][j]+(4*(i-1))].x,quadrado[ja[i][j]+(4*(i-1))].y);
        Write ('²²');
        Delay (10);
      end;

  gotoxy (1,1);
  Delay (2000);
  Window (1,1,80,25);
end;


Procedure Fecho;
{ Procedimento que faz um efeito com as cores, utilizado para assinalar
  o fim de utiliza‡„o do programa, e para agradecer ao utilizador pela
  aten‡„o dispensada. }

var
  i, j, k, p, col: Byte;

begin
  ClrScr;
  k:=0;
  p:=0;
  col:=9;
  Window (1,1,80,25);
  TextBackGround (Black);
  for i:=2 to 12 do
    begin
      TextColor (col);
      for j:=1 to 80-(k*2) do
        begin
          gotoxy (j+k,i);
          write (#176);
          gotoxy (j+k,26-i);
          write (#176)
        end;
      for j:=(2+p) to (24-p) do
        begin
          gotoxy ((i*2)-3,j);
          write ('°°');
          gotoxy (83-(i*2),j);
          write ('°°')
        end;
      k:=k+2;
      p:=p+1;
      Case col of
         9 : inc (col);
        10 : inc (col);
        11 : col:=9;
      end;
      Delay (50);
    end;
  GotoXY (23,13);
  TextColor (15);
  Write (' OBRIGADO POR TER USADO O PROGRAMA. ');
  Hide_Cursor (1);
  Delay (2000);
  TextBackGround (Black);
  TextColor (White);
  ClrScr;
end;


Procedure The_End;  { Deixar as cores em condi‡”es ®normais¯ }

begin
  Window (1,1,80,25);
  ClrScr;
  TextColor (White);
  TextBackGround (Black);
  ClrScr;
end;


Procedure Sombra (x1, y1, x2, y2: Byte);
{ Produ‡„o de uma sombra atrav‚s da indica‡„o dos limites da janela }

var
  k: Byte;

begin
  Window (1,1,80,25);
  TextBackGround (0);
  TextColor(0);
  for k:=y1 to y2 do
    begin
      gotoxy(x2+1,k+1);
      write('²²');
    end;
  for k:=x1 to x2 do
    begin
      gotoxy(k+2,y2+1);
      write('²');
    end;
end;


Procedure Janela (Tipo: Um6; estado: Zero2);
{ estado 2 : elimina a janela;
  estado 1 : n„o limpa a janela;
  estado 0 : limpa e inicializa a janela }
{ Atrav‚s deste procedimento podem ser chamadas 6 janelas, que v„o ser
  utilizadas nas v rias op‡”es do programa por in£meras ocasi”es.
  Os trˆs estados indicam qual o tipo de acc‡„o a executar em rela‡„o …
  janela pretendida. }

Type                                   
  dados = Array [1 .. 5] of Byte;  { As 4 coordenadas e a cor }
  janelas = Array [1 .. 6] of dados;  { 6 janelas }

Var
  m, n, o, mid: Byte;
  k: dados;

Const
  { Os pontos e as cores das 6 janelas v„o ser definidas como constantes,
    porque como ‚ ¢bvio estes elementos nunca ser„o alterados durante a
    execu‡„o do programa. }
  j: janelas = ( (  3,  3, 22, 22,  7),            { Menu Principal        }
                 ( 27,  3, 76,  4,  2),            { Coment rios           }
                 ( 27,  7, 76, 22,  1),            { Janela Principal      }
                 ( 11,  3, 68, 22,  1),            { Janela Central        }
                 (  2,  5,  9, 21,  7),            { Duelo Janela Esquerda }
                 ( 72,  5, 79, 21,  7));           { Duelo Janela Direita  }

begin
  {$I-}
  { As janelas 5 e 6 n„o tˆm sombra }
  if (Tipo<5) then Sombra (j[Tipo,1], j[Tipo,2], j[Tipo,3], j[Tipo,4]);
  Window (j[Tipo,1], j[Tipo,2], j[Tipo,3], j[Tipo,4]);
  TextBackGround (j[Tipo,5]);
  if estado = 0 then  { inicializar }
    begin
      TextColor (j[Tipo,5]);
      ClrScr;
    end;
  if estado = 2 then  { fechar }
    begin
      k:=j[Tipo];
      Window (1,1,80,25);
      TextBackGround (8); TextColor (7);
      mid := Round ((k[4]-k[2]+1)/2);  { C lculo do ®meio¯ da janela }
      For m:=k[2] to mid+k[2] do
        begin
          For n:=k[1] to k[3]+2 do begin
                                     Gotoxy (n,m);
                                     Write ('°');
                                   end;
          For o:=k[3]+2 downto k[1] do begin
                                         Gotoxy (o,k[4]+k[2]+1-m);
                                         Write ('°');
                                       end;
        end;
    end;
  {$I+}
end;


Procedure Init_Janela2;
{ Pr‚-defini‡„o da Janela 2 }

begin
  Janela (2, 0);
  WriteXY (15, 1, '****    M E N U    ****', 0);
  WriteXY (14, 2, '****    PRINCIPAL    ****', 0);
end;


Procedure Init_Janela3;
{ Pr‚-defini‡„o da Janela 3 }

begin
  Janela (3, 0);
  TextColor (14);
  GotoXY (1,3);
  WriteLn ('    ²²²²²²²²²²²²²          ²²²²²²²²²²²²²         ');
  WriteLn ('       ²²²²²²²             ²²²       ²²²         ');
  WriteLn ('         ²²²               ²²²       ²²²         ');
  WriteLn ('         ²²²               ²²²       ²²²         ');
  WriteLn ('         ²²²               ²²²       ²²²         ');
  WriteLn ('         ²²²               ²²²       ²²²         ');
  WriteLn ('         ²²²               ²²²       ²²²         ');
  WriteLn ('         ²²²               ²²²       ²²²         ');
  WriteLn ('         ²²²               ²²²   ²²  ²²²         ');
  WriteLn ('         ²²²               ²²²    ²² ²²²         ');
  WriteLn ('       ²²²²²²²             ²²²     ²²²²²         ');
  WriteLn ('    ²²²²²²²²²²²²²    ²²    ²²²²²²²²²²²²²²²  ²²   ');
end;


Procedure Init_Janela4 (numjog: Byte);
{ Pr‚-defini‡„o da Janela 4 }

var
  k: Byte;

begin
  TextBackGround (7);
  Window (18,5,61,7);
  For k:=1 to 3 do begin GotoXY (1,k); ClrEol; end;  { Rectƒngulo destinado …s perguntas }
  Janela (4, 1);
  { No caso de serem 2 jogadores, tˆm que ser indicadas tamb‚m as teclas
    do 2§ jogador (de 6 a 0) }
  Case numjog of
    1 : begin
          For k:=4 to 8 do Case k of
                             4 : WriteXY (7, k*2-1, '1 - [                                        ]', 10);
                             5 : WriteXY (7, k*2-1, '2 - [                                        ]', 10);
                             6 : WriteXY (7, k*2-1, '3 - [                                        ]', 10);
                             7 : WriteXY (7, k*2-1, '4 - [                                        ]', 10);
                             8 : WriteXY (7, k*2-1, '5 - [                                        ]', 10);
                           end;
          WriteXY (17,19, 'Utilize as teclas de 1 a 5', 15);
        end;
    2 : begin
          For k:=4 to 8 do Case k of
                             4 : WriteXY (5, k*2-1, '1 - [                                        ] - 6', 10);
                             5 : WriteXY (5, k*2-1, '2 - [                                        ] - 7', 10);
                             6 : WriteXY (5, k*2-1, '3 - [                                        ] - 8', 10);
                             7 : WriteXY (5, k*2-1, '4 - [                                        ] - 9', 10);
                             8 : WriteXY (5, k*2-1, '5 - [                                        ] - 0', 10);
                           end;
          WriteXY (11,19, 'Jogador 1 : 1 a 5 - Jogador 2 : 6 a 0', 15);
        end;
  end;
end;


Procedure Initialize;
{ Inicializa‡„o do ‚cran onde vai funcionar o Menu Principal }

var
  i, j: Byte;
  sorte: Word;

begin
  ClrScr;
  TextBackGround (6);
  TextColor (15);
  GotoXY (1,1); ClrEol; GotoXY (1,25); ClrEol;
  GotoXY  (34,1); Write ('I. Q.  -  V1.6');
  GotoXY (30,25); Write ('@ 1993 CMF SoftWonders');
  TextBackGround (0);
  TextColor (7);
  Randomize;
  sorte := Random (4);        { Sorteio da maneira de abrir o ‚cran }
  Case sorte of               { Cima, Baixo, Esquerda, Direita }
    0 : For i:=1 to 80 do     { O ‚cran vai ser aberto num dos 4 sentidos acima indicados }
          begin
            For j:=2 to 24 do begin
                                Gotoxy (i,j);
                                Write ('°');
                              end;
            Delay (5);
          end;
    1 : For i:=80 downto 1 do
          begin
            For j:=2 to 24 do begin
                                Gotoxy (i,j);
                                Write ('°');
                              end;
            Delay (5);
          end;
    2 : For i:=2 to 24 do
          begin
            For j:=1 to 80 do begin
                                Gotoxy (j,i);
                                Write ('°');
                              end;
            Delay (5);
          end;
    3 : For i:=24 downto 2 do
          begin
            For j:=1 to 80 do begin
                                Gotoxy (j,i);
                                Write ('°');
                              end;
            Delay (5);
          end;
  end;
  Init_Janela2;
  Init_Janela3;
end;


Procedure Info;
{ Quadro com a informa‡„o acerca do programa }
{ A ser ®afixado¯ na Janela 3 }

begin
  Janela (3, 0);
  TextColor (14);
  GotoXY (1,3);
  Writeln (' ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
  Writeln (' º                                              º');
  Writeln (' º A finalidade deste programa ‚ a de testar os º');
  Writeln (' º conhecimentos do utilizador acerca de v rios º');
  Writeln (' º  assuntos e de contribuir para o despertar   º');
  Writeln (' º   de um gosto salutar pela aprendizagem.     º');
  Writeln (' º                                              º');
  Writeln (' º        Programado em Turbo Pascal 6.0        º');
  Writeln (' º  Requisitos m¡nimos : 80286 & Monitor Poli.  º');
  Writeln (' º                                              º');
  Writeln (' º    Autor : Carlos Miguel Queir¢s Fria‡as     º');
  Writeln (' º    O Programa ‚ formado por 2.655 linhas.    º');
  Writeln (' º     E foi terminado em 24 / 10 / 1993.       º');
  Writeln (' º            @ 1993 CMF SoftWonders            º');
  Writeln (' º                                              º');
  Write   (' ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');
end;


Procedure EscreverOpcoes (opc: Opcoes);
{ Escrever na Janela 1 as Op‡”es do Menu Principal }

var
  i, j: Byte;

begin
  j:=4;
  TextColor (Yellow);
  TextBackGround (Blue);
  Writeln;
  GotoXY (3,2);
  Write (' MENU PRINCIPAL ');
  TextBackGround (White);
  TextColor (Blue);
  for i:=1 to 9 do
    begin
      GotoXY (3,j);
      Write (opc[i]);
      if i<8 then j:=j+2 else j:=j+1;
    end;
end;


Procedure Barra (i, y: Byte; opc: opcoes);
{ Desenho da barra do Menu Principal }

begin
  TextBackGround (Blue);
  TextColor (White);
  if i = 8 then begin
                  GotoXY (3,y);
                  Write (opc[i]);
                  GotoXY (3,y+1);
                  Write (opc[i+1]);
                end
  else begin
         GotoXY (3,y);
         Write (opc[i]);
       end;
end;


Procedure ApagaBarra (i, y: Byte; opc: opcoes);
{ Apaga a barra do Menu Principal }

begin
  GotoXY (3,y);
  TextBackGround (White);
  TextColor (Blue);
  Write (opc[i]);
  if i = 8 then begin
                  GotoXY (3,y+1);
                  TextBackGround (White);
                  TextColor (Blue);
                  Write (opc[i+1]);
                end;
end;


Procedure MovimentaBarra (var opcao: Byte; opc: opcoes);
{ Este procedimento faz a barra ®movimentar-se¯ utilizando os dois
  procedimentos anteriores (o de Desenhar a barra e o de apag -la). }

var
  ch: Char;
  i, y: Byte;

begin
  i:=1; y:=4;
  GotoXY (3,y);
  TextBackGround (Blue);
  TextColor (White);
  Write (opc[1]);
  TextBackGround (White);
  Repeat
    ch:=ReadKey;
    Case ch of
      #27: opcao:=0;  { Esc }
      #13: opcao:=i;  { Enter }
      #9: begin       { Tab }
            ApagaBarra (i, y, opc);
            inc (i);
            y:=y+2;
            if (opc[i]='') or (i>8) then
            begin
              i:=1;
              y:=4;
            end;
            Barra (i, y, opc);
          end;
      #0: begin
            ch:=ReadKey;
            Case ch of
              #80: begin                       { Baixo }
                     ApagaBarra (i, y, opc);
                     inc (i);
                     y:=y+2;
                     if (opc[i]='') or (i>8) then
                       begin
                         i:=1;
                         y:=4;
                       end;
                     Barra (i, y, opc);
                   end;
         #72, #15: begin                  { Cima , Shift+Tab }
                     ApagaBarra (i, y, opc);
                     dec (i);
                     y:=y-2;
                     If i<1 then
                       begin
                         i:=8;
                         y:=18;
                       end;
                     while opc[i]='' do
                       begin
                         dec (i);
                         y:=y-2;
                       end;
                     Barra (i, y, opc);
                   end;
            end;
          end;
    end;
  Until (ch=#13) or (ch=#27);  { At‚ que se carregue em 'Esc' ou 'Enter' }
end;


Procedure Le_Char (x, y: Byte; var ch: Char);
{ Procedimento para a leitura de um £nico caracter. }

begin
  GotoXY (x,y);
  ch:=ReadKey;
  Write (ch);
end;


Procedure EditorDeLinha (x, y, complinha: Byte; var texto: String; soint: Boolean; var enter: Boolean);
{ Este procedimento serve principalmente para editar as perguntas e as respostas da Op‡„o Criar. }

var
  i, j, k, pos, l, linhas, origy: Byte;
  ch: Char;
  ok: Boolean;
  p: Array [1 .. 3] of String[44];  { Para a introdu‡„o de novas quest”es }

begin
  i:=0; ok:=false; enter:=false; pos:=x; origy:=y;
  linhas:=1;
  if complinha=132 then begin  { Transforma‡„o de uma linha de comprimento 132 para 3 linhas de 44 cada }
                          linhas:=3;
                          complinha:=44;
                        end;
  l:=0;  { sobram ainda 2 linhas }
  GotoXY (x,y);
  repeat
    ch:=ReadKey;
    case ch of
      #0  : begin
              ch:=ReadKey;
              Case ch of
                #75 : begin                  { esquerda }
                        pos:=whereX-1;  
                        GotoXY (pos,y);  { colocar o cursor uma casa … esquerda }
                      end;
                #77 : begin                  { direita }
                        if (whereX-x < length (texto)-(l*44)) then
                          begin
                            pos:=whereX+1;
                            GotoXY (pos,y);  { colocar o cursor uma casa … direita }
                          end;
                      end;
                #71 : begin                  { home }
                        y:=origy;      { 1¦ linha }
                        l:=0;
                        GotoXY (x,y);
                        pos:=x;        { 1¦ coluna }
                      end;
                #79 : begin                          { end }
                        l := (length(texto) DIV complinha);
                        y:=origy+l;    { £ltima linha onde exite texto }
                        GotoXY (x+(length(texto) MOD complinha),y+l);
                        pos:=whereX;
                      end;
                #83 : begin                  { delete }
                        pos:=whereX;
                        Delete (texto, pos+(l*44)-x+1, 1);
                        For k:=1 to 3 do p[k]:='';
                        For k:=1 to linhas do begin GotoXY (x,origy+(k-1)); For j:=1 to complinha do Write (' '); end;
                        p[1]:=Copy(texto,1,44);
                        p[2]:=Copy(texto,45,44);
                        p[3]:=Copy(texto,89,44);
                        For k:=1 to linhas do begin GotoXY (x,origy+(k-1)); Write (p[k]); end;
                        GotoXY (pos,y);
                      end;
              end;
            end;
      #8 : begin                  { backspace }
             pos:=whereX;
             Delete (texto, pos+(l*44)-x, 1);
             For k:=1 to 3 do p[k]:='';
             For k:=1 to linhas do begin GotoXY (x,origy+(k-1)); For j:=1 to complinha do Write (' '); end;
             p[1]:=Copy(texto,1,44);
             p[2]:=Copy(texto,45,44);
             p[3]:=Copy(texto,89,44);
             For k:=1 to linhas do begin GotoXY (x,origy+(k-1)); Write (p[k]); end;
             dec(pos);
             GotoXY (pos,y);
           end;
      #13 : begin                            { carriage return }
             ok:=true;
             enter:=true;
            end;
      #9  : begin                            { tab }
              ok:=true;
            end;

      #32..#126, #128, #130..#153, #156, #158..#163, #166, #167, #169,
      #171, #172, #174, #175 :
         begin
           if not soint then
             begin
               GotoXY (pos,y);
               Write (ch);
               if pos=x+complinha then pos:=1 else pos:=succ(pos);
               if (pos+(l*44)-x)<=length(texto) then texto[pos+(l*44)-x]:=ch
               else texto:=texto+ch;
             end
           else
             if ch in ['0'..'9'] then
               begin
                 GotoXY (pos,y);
                 write (ch);
                 if pos=x+complinha then pos:=1 else pos:=succ(pos);
                 if (pos+(l*44)-x)<=length(texto) then texto[pos+(l*44)-x]:=ch
                 else texto:=texto+ch;
               end;
         end;

    end;
  if pos<=x-1 then if (l>0) and (linhas=3) then begin
                                                  pos:=x+43;
                                                  dec (l);  { subir uma linha }
                                                  dec (y);
                                                end
                   else pos:=x
  else if pos>=x+complinha   then if (l<2) and (linhas=3) then begin
                                                                 pos:=x;
                                                                 inc (l);  { descer uma linha }
                                                                 inc (y);
                                                               end
                             else pos:=x+complinha-1;
  GotoXY (pos,y);
  until ok=true;
end;


Procedure Le_Nome (x, y, complinha: byte; var texto: st12);
{ Lˆ um nome com um m ximo de 12 caracteres }

var
  i, pos: byte;
  ch: char;
  ok: Boolean;

begin
  i:=0; ok:=false; pos:=x;
  gotoxy (x,y);
  texto:='';
  repeat
    ch:=readkey;
    case ch of
      #0  : begin
              ch:=readkey;
              case ch of
                #75 : begin                  { esquerda }
                        pos:=whereX-1;
                        gotoxy (pos,y);
                      end;
                #77 : begin                  { direita }
                        if (whereX-x < length (texto)) and (texto<>#127) then
                          begin
                            pos:=whereX+1;
                            gotoxy (pos,y);
                          end;
                      end;
  {para tirar}  #83 : begin                  { delete }
                        pos:=whereX;
                        delete (texto, pos-x+1, 1);
                        for i:=(pos-x+1) to length(texto) do write (texto[i]);
                        if whereX <> (x+complinha) then write(' ');
                        gotoxy (pos,y);
                      end;
                #71 : begin                  { home }
                        gotoxy (x,y);
                        pos:=x;
                      end;
                #79 : begin                          { end }
                        gotoxy (x+length(texto),y);
                        pos:=whereX;
                      end;
              end;
            end;
      #13 : begin                            { carriage return }
             ok:=true;
            end;
      #8  : begin                             { backspace }
              pos:=whereX;
              if pos <> x then
                begin
                  delete(texto,pos-x,1);
                  gotoxy(pos-1,y);
                  for i:=(pos-x) to length(texto) do write (texto[i]);
                  if wherex <> (x+complinha) then write (' ');
                  pos:=pos-1;
                  gotoxy (pos,y);
                end;
            end;

      #32..#47, #58..#126, #128, #130..#153, #156, #158..#163, #166, #167, #169,
      #171, #172, #174, #175 : begin
                                 gotoxy (pos,y);
                                 write (ch);
                                 pos:=succ(pos);
                                 if (pos-x)<=length(texto) then texto[pos-x]:=ch
                                 else texto:=texto+ch;
                               end;

    end;
  if pos<=x then pos:=x;
  if pos>=x+complinha-1 then pos:=x+complinha-1;
  gotoxy (pos,y);
  until ok=true;
end;


Procedure Ler_Um_Numero (x, y, comp: Byte; var numero: Longint; enter: Boolean);
{ Procedimento utilizado para ler um n£mero }

var
  i: Byte;
  texto: String;
  code: Integer;

begin
  repeat
    texto:=#255;
    EditorDeLinha (x,y,comp,texto,true,enter);
    val (texto,numero,code);
    code:=numero;
  until code<>0;
end;


Procedure Escolher_Assunto (var ass: Byte);
{ Procedimento utilizado para seleccionar o assunto, aquando da escolha
  das Op‡”es ®Jogar¯, ®Duelo¯ e ®Criar¯. }

var
  ch: Char;
  escolhido: Boolean;

begin
  Janela (3, 0);
  WriteXY (18,  2, 'ESCOLHA O TEMA  : ', 4);
  WriteXY (13,  4, '[ F1 ]   -  DESPORTO        ', 14);
  WriteXY (13,  5, '[ F2 ]   -  INFORMATICA     ', 14);
  WriteXY (13,  6, '[ F3 ]   -  CIENCIAS        ', 14);
  WriteXY (13,  7, '[ F4 ]   -  TELEVISAO       ', 14);
  WriteXY (13,  8, '[ F5 ]   -  CINEMA          ', 14);
  WriteXY (13,  9, '[ F6 ]   -  HISTORIA        ', 14);
  WriteXY (13, 10, '[ F7 ]   -  GEOGRAFIA       ', 14);
  WriteXY (13, 11, '[ F8 ]   -  USER DEFINED    ', 14);

  ass:=11;
  Repeat
    ch := ReadKey;
    Case ch of
      #27: begin ass := 0; escolhido := true; end;
      #0: begin
            ch := ReadKey;
            Case ch of
              #59: ass:=1;
              #60: ass:=2;
              #61: ass:=3;
              #62: ass:=4;
              #63: ass:=5;
              #64: ass:=6;
              #65: ass:=7;
              #66: ass:=8;
            end;
            if ass < 9 then escolhido := true;
          end;
    end;
  Until (escolhido = true);
  if (ass > 0) and (ass < 8) then begin
                                    Janela (2, 0);
                                    WriteXY (18, 1, 'TEMA ESCOLHIDO :', 14);
                                    WriteXY (19, 2, Temas[ass], 14);
                                    Delay (500);
                                  end;
end;


Procedure Sortear (var nums: Arr20);
{ Sortear 20 n£meros entre os 60 poss¡veis. }

var
  k, new, Posit: Byte;
  fnd: Boolean;

begin
  Posit:=1;
  For k:=1 to 20 do nums[k]:=0;
  Randomize;
  Repeat
    new := Random (60) + 1;
    fnd:=false;
    For k:=1 to 20 do if new = nums[k] then fnd:=true;
    if fnd = false then begin
                          nums[Posit] := new;
                          inc (Posit);
                        end;
  Until Posit = 21;
end;


Procedure Timer (var start, stop, total: Time; mode: Byte);
{ Procedimento para contabilizar o tempo entre dois dados momentos da chamada do procedimento. }
{ mode 0 = ligar timer ; mode 1 = desligar timer e calcular diferen‡a entre os tempos }

type
  Variac = -1 .. 1;

var
  i: Byte;
  hh, mm, ss, s100: Word;
  add: Array [1 .. 3] of Variac;

begin
  GetTime (hh, mm, ss, s100);

  Case mode of
    0: begin start.ss:=ss; start.mm:=mm; start.s100:=s100; end;
    1: begin stop.ss:=ss; stop.mm:=mm; stop.s100:=s100; end;
  end;

  { Calcular o tempo }
  if mode = 1 then
    begin
      For i:=1 to 3 do add[i]:=0;
      if (stop.s100 >= start.s100) then total.s100 := stop.s100 - start.s100
      else begin
             total.s100 := stop.s100 + (100 - start.s100);
             add[1]:=-1;
           end;
      if (stop.ss >= start.ss) then total.ss := stop.ss - start.ss + add[1]
      else begin
             total.ss := stop.ss + (60 + add[1] - start.ss);
             add[2]:=-1;
           end;
      if (stop.mm >= start.mm) then total.mm := stop.mm - start.mm + add[2]
      else begin
             total.mm := stop.mm + (60 + add[2] - start.mm);
             add[3]:=-1;
           end;
      total.hh := stop.hh - start.hh + add[3];
    end;
end;


Procedure CalculaIQ (totalsec: Word; Var TOTALIQ: Byte);
{ Devolver Resultado atrav‚s dos segundos gastos por um jogador (j  incluindo as penaliza‡”es) }

begin
  Case totalsec of
       0 ..  100 : TOTALIQ := 200 - (totalsec DIV 10);
     100 ..  200 : TOTALIQ := 190 - ((totalsec-100) DIV 10);
     200 ..  300 : TOTALIQ := 180 - ((totalsec-200) DIV 10);
     300 ..  400 : TOTALIQ := 170 - ((totalsec-300) DIV 10);
     400 ..  500 : TOTALIQ := 160 - ((totalsec-400) DIV 10);
     500 ..  600 : TOTALIQ := 150 - ((totalsec-500) DIV 10);
     600 ..  700 : TOTALIQ := 140 - ((totalsec-600) DIV 10);
     700 ..  800 : TOTALIQ := 130 - ((totalsec-700) DIV 10);
     800 ..  900 : TOTALIQ := 120 - ((totalsec-800) DIV 10);
     900 .. 1000 : TOTALIQ := 110 - ((totalsec-900) DIV 10);
    1000 .. 1100 : TOTALIQ := 100 - ((totalsec-1000) DIV 10);
    1100 .. 1200 : TOTALIQ :=  90 - ((totalsec-1100) DIV 10);
    1200 .. 1300 : TOTALIQ :=  80 - ((totalsec-1200) DIV 10);
    1300 .. 1400 : TOTALIQ :=  70 - ((totalsec-1300) DIV 10);
    1400 .. 1500 : TOTALIQ :=  60 - ((totalsec-1400) DIV 10);
    1500 .. 1600 : TOTALIQ :=  50 - ((totalsec-1500) DIV 10);
    1600 .. 1700 : TOTALIQ :=  40 - ((totalsec-1600) DIV 10);
    1700 .. 1800 : TOTALIQ :=  30 - ((totalsec-1700) DIV 10);
    1800 .. 1900 : TOTALIQ :=  20 - ((totalsec-1800) DIV 10);
    1900 .. 2000 : TOTALIQ :=  10 - ((totalsec-1900) DIV 10);
  end;
end;


Procedure Mostrar_Score (TOTALIQ: Byte);
{ Procedimento para mostrar o resultado obtido, atrav‚s da passagem desse mesmo resultado. }
{ Algarismos armazenados em vectores constantes }

type
  numero = Array [1 .. 7] of String[10];

const

  N0 : numero = ('²²²²²²²²²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²²²²²²²²²');

  N1 : numero = (' ²²²²²    ',
                 '    ²²    ',
                 '    ²²    ',
                 '    ²²    ',
                 '    ²²    ',
                 '    ²²    ',
                 '²²²²²²²²²²');

  N2 : numero = ('²²²²²²²²²²',
                 '²²      ²²',
                 '        ²²',
                 '²²²²²²²²²²',
                 '²²        ',
                 '²²      ²²',
                 '²²²²²²²²²²');

  N3 : numero = ('²²²²²²²²²²',
                 '²²      ²²',
                 '        ²²',
                 '  ²²²²²²²²',
                 '        ²²',
                 '²²      ²²',
                 '²²²²²²²²²²');

  N4 : numero = ('²²      ²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²²²²²²²²²',
                 '        ²²',
                 '        ²²',
                 '        ²²');

  N5 : numero = ('²²²²²²²²²²',
                 '²²        ',
                 '²²        ',
                 '²²²²²²²²²²',
                 '        ²²',
                 '²²      ²²',
                 '²²²²²²²²²²');

  N6 : numero = ('²²²²²²²²²²',
                 '²²      ²²',
                 '²²        ',
                 '²²²²²²²²²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²²²²²²²²²');

  N7 : numero = ('²²²²²²²²²²',
                 '       ²²²',
                 '      ²²² ',
                 '     ²²²  ',
                 '    ²²²   ',
                 '   ²²²    ',
                 '  ²²²     ');

  N8 : numero = ('²²²²²²²²²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²²²²²²²²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²²²²²²²²²');

  N9 : numero = ('²²²²²²²²²²',
                 '²²      ²²',
                 '²²      ²²',
                 '²²²²²²²²²²',
                 '        ²²',
                 '²²      ²²',
                 '²²²²²²²²²²');

var
  i, j: Byte;
  result: String[3];

begin
  TextColor (15);
  GotoXY (21,4);
  Write ('P O N T U A € A O');
  For i:=1 to 3 do
    begin
      str (TOTALIQ, result);
      if length(result) = 2 then result := Concat ('0', result);
      if length(result) = 1 then result := Concat ('00', result);
      For j:=1 to 7 do    { Para cada uma das 7 linhas }
        begin
          GotoXY (11+((i-1)*14), 7+j);
          Case result[i] of
            '0': Write (N0[j]);
            '1': Write (N1[j]);
            '2': Write (N2[j]);
            '3': Write (N3[j]);
            '4': Write (N4[j]);
            '5': Write (N5[j]);
            '6': Write (N6[j]);
            '7': Write (N7[j]);
            '8': Write (N8[j]);
            '9': Write (N9[j]);
          end;
        end;
    end;
end;


Procedure Reset_Records (var g: T);
{ Utilizado no caso de o ficheiro n„o existir }

var
  i: Byte;
  v: Recs;

begin
  Rewrite (g);
  For i:=1 to 15 do
    begin
      v[i].Nome:='INCOGNITO';
      v[i].Assunto:='NENHUM      ';
      v[i].PONTIQ:=0;
    end;
  Write (g, v);
end;


Procedure Actualizar_Records (TOTALIQ, ass, numjog: Byte; nomef: st12);
{ Tal como o nome indica, ‚ utilizado para inserir o recorde do jogador, bem como o seu nome. }
{ Cada tabela de recordes tem 15 posi‡”es }

var
  i, m, place: Byte;
  g: T;
  v: Recs;
  Name: st12;
  h: file of Assunto_Fich;
  af: Assunto_Fich;
  found: Boolean;

begin
  {$I-}
  if numjog=1 then Assign (g, 'RECORDS') else Assign (g, 'RECORDS2');
  Reset (g);
  if IOResult <> 0 then Reset_Records (g);
  Close (g);
  {$I+}
  Reset (g);
  Read (g, v);
  if v[15].PONTIQ < TOTALIQ then
    begin
      { ENCONTAR POSI€ŽO }
      place:=16;
      Repeat
        dec (place);
      Until (TOTALIQ <= v[place-1].PONTIQ) or (PLACE=1);
      { BAIXAR POSI€ŽO }
      For i:=14 downto place do v[i+1]:=v[i];
      { COLOCAR RECORD }
      v[place].PONTIQ := TOTALIQ;
      Case ass of
        1: v[place].Assunto := 'DESPORTO    ';
        2: v[place].Assunto := 'INFORMATICA ';
        3: v[place].Assunto := 'CIENCIAS    ';
        4: v[place].Assunto := 'TELEVISAO   ';
        5: v[place].Assunto := 'CINEMA      ';
        6: v[place].Assunto := 'HISTORIA    ';
        7: v[place].Assunto := 'GEOGRAFIA   ';
        8: begin
             Assign (h, 'TEMAS');
             {$I-}
             Reset (h);
             found:=false;
             For m:=1 to length(nomef) do nomef[m] := Upcase (nomef[m]);
             Repeat
               Read (h, af);
               For m:=1 to length(af.nome_fich) do af.nome_fich[m] := Upcase (af.nome_fich[m]);
               if (af.nome_fich = nomef) then found:=true;
             until (found = true) or (eof(h));
             if (found = false) then af.assunto:='? ? ? ? ? ?';
             v[place].Assunto := af.assunto;
             Close (h);
             {$I+}
           end;
      end;
      WriteXY (19, 17, 'Nome  :  [            ]', 15);
      Le_Nome (29, 17, 12, Name);
      v[place].Nome := Name;
      Seek (g, 0);
      Write (g, v);
    end
  else Delay (3000);
  Close (g);
end;


Procedure Derrotado (Pont, jog: Byte);
{ Mostrar a pontua‡„o do jogador derrotado (referente ao Duelo). }

begin
  GotoXY (10, 19);
  Write ('Derrotado : ', 'Jogador ', jog, '  -  ', 'Pontua‡„o : ', Pont);
end;


Procedure Carregar (x: Byte);
{ Assinala se foi o jogador 1 ou o jogador 2 a carregar primeiro }
{ 1 - ESQUERDA ; 2 - DIREITA }

type
  mao = Array [1 .. 6] of String[5];
  botao = Array [1 .. 2] of String [8];
  Jn = Array [1 .. 2 , 1 .. 4] of Byte;

const
  esq : mao = ('²²²²²',
               '²²²²²',
               '²²²²²',
               '   ²²',
               '   ²²',
               '   ²²');

  dir : mao = ('²²²²²',
               '²²²²²',
               '²²²²²',
               '²²   ',
               '²²   ',
               '²²   ');

  bot : botao = ('  ±±±±  ',
                 ' °°°°°° ');

  Jan : Jn = ((3,6,8,17),(74,6,79,17));  { coordenadas de janelas }

var
  i, j: Byte;

begin
  Janela (4+x ,0);
  TextColor (1);
  For i:=1 to 2 do
    begin
      GotoXY (1,13+i);
      if i=2 then TextColor (4);
      Write (bot[i]);
    end;
  TextColor (0);
  For j:=1 to 7 do
    begin
      Window (jan[x,1],jan[x,2],jan[x,3],jan[x,4]);
      ClrScr;
      For i:=1 to 6 do
        begin
          GotoXY (1,(i-1)+j);
          Case x of
            1 : Write (esq[i]);
            2 : Write (dir[i]);
          end;
        end;
      Window (1,1,80,25);
      Hide_Cursor (6);  
      Delay (30);
      TextBackGround (7); TextColor (0);
    end;
  Sound (250);
  Delay (40);
  NoSound;
end;


Procedure OutPut_Tema (var nfch: St12);
{ Mostrar o tema, sabendo qual o nome do ficheiro }

var
  m: file of Assunto_Fich;
  mx: Assunto_Fich;
  nofile: Boolean;
  k: Byte;

begin
  nofile:=false;
  For k:=1 to 12 do nfch[k] := UpCase(nfch[k]);
  {$I-}
  Assign (m, 'TEMAS');
  Reset (m);
  if IOResult <> 0 then nofile:=true;
  {$I+}
  if (nofile = false) then
    Repeat
      Read (m, mx);
      For k:=1 to 12 do mx.nome_fich[k] := UpCase (mx.nome_fich[k]);
    Until (eof (m)) or (mx.nome_fich = nfch);
  if (nofile = false) then Close (m);
  if (mx.nome_fich = nfch) then
    begin
      WriteXY (24, 14, '            ', 14);
      WriteXY (14, 14, 'TEMA  :  [', 14);
      WriteXY (24, 14, mx.assunto, 14);
      WriteXY (36, 14, ']', 14);
    end
  else WriteXY (24, 14, '            ', 14);
end;


Procedure Escolher_UDR (var nf: St12; fileext: St5);
{ Este procedimento destina-se a escolher qual o ®USER DEFINED RESOURCE¯ a ser utilizado. }

{  *****  Neste procedimento ‚ utilizada uma estrutura de LISTA  *****  }

{ *NOTA* : As explica‡”es dadas neste procedimento aplicam-se tamb‚m ao
           procedimento Escolher_TXT, pois os dois s„o extremamente parecidos,
           no entanto, fazer um procedimento aplic vel …s duas necessidades
           revelou-se imposs¡vel, pois nos ficheiros (*.UDR) ‚ necess rio
           mostrar qual o seu tema, para al‚m de outras incompatibilidades,
           pois os procedimentos s„o usados em janelas diferentes. }

type
  fch = ^fich;
  fich = Record
           ant: fch;    { posi‡„o do elemento anterior }
           Nome: St12;  { elemento actual }
           seg: fch;    { posi‡„o do elemento seguinte }
         end;

var
  i, j: Byte;
  P, Q: fch;
  ch, ch2: Char;
  ext: St5;
  nofiles: Boolean;
  DirInfo: SearchRec;

begin
  nofiles:=false;
  ext:='';
  ext:=Copy(fileext,3,3);
  DirInfo.Name:='';

  FindFirst(fileext, Archive, DirInfo);

  if (Pos(ext, DirInfo.Name) > 0) then
  else nofiles:=true;  { N„o existem ficheiros com a extens„o pretendida }

  if (nofiles = false) then
    begin
      WriteXY ( 8, 13, 'Nome do Ficheiro  :  [            ] ', 14);
      WriteXY (14, 14, 'TEMA  :  [            ]', 14);
      WriteXY ( 8, 15, 'Utilize as ®setas¯ para pesquisar os', 14);
      WriteXY ( 5, 16, 'ficheiros (', 14);
      WriteXY (16, 16,  fileext, 14);
      WriteXY (21, 16, ') existentes no direct¢rio.', 14);

      { Carregar toda a informa‡„o para uma estrutura de lista }
      new (P);
      P^.Nome := DirInfo.Name;
      P^.ant:=nil;
      P^.seg:=nil;

      j:=1;
      While (DosError = 0) do  { A altera‡„o deste valor vir  do ®FindNext¯ }
      begin
        if j>1 then  { Devido ao FindFirst }
          begin
            new (Q);
            Q:=P;
            new (P);
            P^.ant:=Q;
            P^.Nome := DirInfo.Name;
            P^.seg:=nil;
          end;
        inc (j);
        FindNext (DirInfo);
      end;

      { Voltar ao in¡cio da lista }
      if P^.ant<>nil then  { n„o se faz se houver s¢ um elemento na lista }
        Repeat
          Q:=P;
          P:=P^.ant;
          P^.seg:=Q;
        Until (P^.ant = nil);

      WriteXY (30, 13, P^.Nome, 14);
      OutPut_Tema (P^.Nome);  { Mostrar Tema do 1§ elemento da lista }

      { Agora, vai ser poss¡vel ver todos os elementos da lista at‚
        que a tecla de ®Esc¯ ou de ®Enter¯ seja premida. }
      Repeat
        Hide_Cursor (6);
        Janela (3,1);
        ch:=Readkey;
        Case ch of
          #27 : nf := '';       { Esc - Abortar }
          #13 : nf := P^.Nome;  { Enter - Escolha do elemento actual }
          #0 : begin
                 ch2:=ReadKey;
                 Case ch2 of
                   #80 : if (P^.seg <> nil) then
                           { Descer na lista }
                           begin
                             Q:=P;
                             P:=P^.seg;
                             P^.ant:=Q;
                             WriteXY (30, 13, '            ', 14);
                             WriteXY (30, 13, P^.Nome, 14);
                             OutPut_Tema (P^.Nome);
                           end
                         else
                         { Mensagem Sonora, pois n„o ‚ poss¡vel descer mais }
                           begin
                             Sound (200);
                             Delay (100);
                             NoSound;
                           end;
                   #72 : If (P^.ant <> nil) then
                           { Subir na lista }
                           begin
                             Q:=P;
                             P:=P^.ant;
                             P^.seg:=Q;
                             WriteXY (30, 13, '            ', 14);
                             WriteXY (30, 13, P^.Nome, 14);
                             OutPut_Tema (P^.Nome);
                           end
                         else
                         { Mensagem Sonora, pois n„o ‚ poss¡vel subir mais }
                           begin
                             Sound (200);
                             Delay (100);
                             NoSound;
                           end;
                 end;
               end;
        end;
      Until (ch = #13) or (ch = #27);
      Release (Q);  { Libertar a mem¢ria }
      Release (P);  { Libertar a mem¢ria }
    end
  else 
    { Mostrar mensagem de erro }
    begin
      WriteXY ( 4, 14, 'N„o existem ficheiros (', 14);
      WriteXY (27, 14, fileext, 14);
      WriteXY (32, 14, ') no direct¢rio.', 14);
      Delay (2000);
    end;
end;


Procedure Jogar (numjog: Byte);

  { Procedimento Principal }
 { numjog = 1 ==> 1 jogador }
{ numjog = 2 ==> 2 jogadores }
{ Jogador 1 utiliza as teclas de 1 a 5 }
{ Jogador 2 utiliza as teclas de 6 a 0 }

type
  Resposta = #65 .. #69;

  player = record
             ts100: Byte;   { tempo (cent‚simos de segundo) }
             tsec: Word;    { tempo (segundos) }
             certas: Byte;  { n§ de respostas certas }
             Pont: Byte;    { pontua‡„o }
           end;

var
  f: file of Assunto;
  t: Assunto;
  i, j, k, m, ass, a, b, jogador, outro, vencedor: Byte;
  nf: St12;
  nums: Arr20;
  p: Array [1 .. 3] of String[44];
  ch: Char;
  resp: Resposta;
  start, stop, total: Time;
  ds: String[2];
  jog: Array [1 .. 2] of player;
  h: file of Assunto_Fich;
  af: Assunto_Fich;
  found, go: Boolean;
  setfalha: 1 .. 6;
  numfalha: 1 .. 10;
  nq: 1 .. 20;

label escape_way;

begin

  Janela (2, 0);
{*****  2  *****}
  { Output para a Janela 2 }
  Case numjog of
    1: begin
         WriteXY (11, 1, '  ****     J O G A R     ****  ', 0);
         WriteXY (11, 2, '****  (1   J O G A D O R)  ****', 0);
       end;
    2: begin
         WriteXY (9, 1, '  ****       D U E L O       ****  ', 0);
         WriteXY (9, 2, '****  (2   J O G A D O R E S)  ****', 0);
       end;
  end;

  Escolher_Assunto (ass);

  if ass > 0 then
    begin
      For i:=1 to 2 do
        begin
          jog[i].ts100:=0;
          jog[i].tsec:=0;
          jog[i].certas:=0;
        end;
      go:=true;
      if ass in [1 .. 7] then nf := Concat (FileNames [ass], '.RES')
      else begin
             Escolher_UDR (nf, '*.UDR');
             if (Pos ('.UDR', nf) > 0) then else goto escape_way;
           end;
      Assign (f, nf);
      {$I-}
      Reset (f);
      if IOResult <> 0 then goto escape_way;
      {$I+}
      Read (f, t);
      Close (f);
      if ass = 8 then
        begin
          Assign (h, 'TEMAS');
          Reset (h);
          found:=false;
          For m:=1 to length(nf) do nf[m] := Upcase (nf[m]);
          Repeat
            Read (h, af);
            For m:=1 to length(af.nome_fich) do af.nome_fich[m] := Upcase (af.nome_fich[m]);
            if (af.nome_fich = nf) then found:=true;
          until (found = true) or (eof(h));
          Close (h);
          if (found = false) then af.assunto:='? ? ? ? ? ?';
          Janela (2, 0);
          WriteXY (18, 1, 'TEMA ESCOLHIDO :', 14);
          WriteXY (19, 2, af.Assunto, 14);
          Delay (500);
        end;

      Sortear (nums);

      For i:=1 to 3 do Janela (i, 2);

{*****  2  *****}
      if (numjog = 1) then Janela (4, 0) else For i:=4 to 6 do Janela (i, 0);

      { Sub-Rotina para as 20 perguntas }
      For j:=1 to 20 do
        begin

          Init_Janela4 (numjog);
          a := (nums[j] DIV 10) + 1; b := (nums[j] MOD 10);
          TextColor (0); TextBackGround (7);
          p[1]:=Copy(t[a][b].q,1,44);
          p[2]:=Copy(t[a][b].q,45,44);
          p[3]:=Copy(t[a][b].q,89,44);
          GotoXY (8,3); Write (p[1]);
          GotoXY (8,4); Write (p[2]);
          GotoXY (8,5); Write (p[3]);

          TextColor (15); TextBackGround (1);
          For k:=4 to 8 do WriteXY (14-(numjog*2),  k*2-1, t[a][b].ans[k-3], 15);
          WriteXY (23, 17, 'Quest„o N§ ', 15); Write (j:2);

          Timer (start, stop, total, 0);  { Colocar o Contador a 0 }

          Repeat
            TextColor(31);
            Esvazia_Buffer;
            ch:=ReadKey;  { Leitura do teclado }
            if (ch = #27) then begin
                                 Janela (4, 2);  { Fechar Janelas }
                                 if (numjog=2) then begin Janela (5, 2); Janela (6, 2); end;
                                 Goto escape_way;
                               end;
{*****  2  *****}
            Case numjog of
              1 : Case ch of
                    #49: begin Timer (start, stop, total, 1); resp:=#65; GotoXY (7,7); Write ('1'); end;
                    #50: begin Timer (start, stop, total, 1); resp:=#66; GotoXY (7,9); Write ('2'); end;
                    #51: begin Timer (start, stop, total, 1); resp:=#67; GotoXY (7,11); Write ('3'); end;
                    #52: begin Timer (start, stop, total, 1); resp:=#68; GotoXY (7,13); Write ('4'); end;
                    #53: begin Timer (start, stop, total, 1); resp:=#69; GotoXY (7,15); Write ('5'); end;
                  end;
              2 : Case ch of
                    #49: begin Timer (start, stop, total, 1); resp:=#65; GotoXY (5,7); Write ('1'); end;
                    #50: begin Timer (start, stop, total, 1); resp:=#66; GotoXY (5,9); Write ('2'); end;
                    #51: begin Timer (start, stop, total, 1); resp:=#67; GotoXY (5,11); Write ('3'); end;
                    #52: begin Timer (start, stop, total, 1); resp:=#68; GotoXY (5,13); Write ('4'); end;
                    #53: begin Timer (start, stop, total, 1); resp:=#69; GotoXY (5,15); Write ('5'); end;
                    #54: begin Timer (start, stop, total, 1); resp:=#65; GotoXY (54,7); Write ('6'); end;
                    #55: begin Timer (start, stop, total, 1); resp:=#66; GotoXY (54,9); Write ('7'); end;
                    #56: begin Timer (start, stop, total, 1); resp:=#67; GotoXY (54,11); Write ('8'); end;
                    #57: begin Timer (start, stop, total, 1); resp:=#68; GotoXY (54,13); Write ('9'); end;
                    #48: begin Timer (start, stop, total, 1); resp:=#69; GotoXY (54,15); Write ('0'); end;
                  end;
            end;
          Until ((ch in [#49 .. #53]) and (numjog=1)) or ((ch in [#48 .. #57]) and (numjog=2));

          if ch in [#49 .. #53] then begin jogador:=1; outro:=2; end
          else begin jogador:=2; outro:=1; end;
{*****  2  *****}
          if (numjog = 2) then Carregar (jogador);
          ch:=' ';
          Hide_Cursor (6);
          Janela (4, 1);

          TextColor (15);
          ds:=''; str (total.s100, ds); if (length (ds) = 1) then ds := Concat ('0', ds);
          GotoXY (23,18); Write ('Tempo : ',total.ss:2, '.',ds);
          Delay (1000);
          GotoXY (23,18); Write ('             ');
          if (numjog = 2) then Janela (4+jogador, 0);
          Janela (4, 1);

          { Verificar Resposta }
{*****  2  *****}
          Case numjog of
            1 : if (t[a][b].certa = resp) then
                  begin
                    if total.ss > 25 then begin total.ss:=25; total.s100:=0; end;
                    jog[1].ts100 := jog[1].ts100 + total.s100;
                    jog[1].tsec := jog[1].tsec + total.ss;
                    inc (jog[1].certas);
                  end
                else
                  begin
                    jog[1].tsec := jog[1].tsec + 100;       { 100 seg. de penaliza‡„o }
                    { armazenar dados sobre a 1¦ falha }
                    if (go = true) then
                      begin
                        setfalha:=a;
                        numfalha:=b;
                        nq:=j;
                        go:=false;
                      end;
                  end;
            2 : if (t[a][b].certa = resp) then
                  begin
                    if total.ss > 25 then begin total.ss:=25; total.s100:=0; end;
                    jog[jogador].ts100 := jog[jogador].ts100 + total.s100;
                    jog[jogador].tsec := jog[jogador].tsec + total.ss;
                    inc (jog[jogador].certas);
                    jog[outro].tsec := jog[outro].tsec + 100;
                  end
                else
                  begin
                    jog[jogador].tsec := jog[jogador].tsec + 100;       { 100 seg. de penaliza‡„o }
                    jog[outro].tsec := jog[outro].tsec + 100;
                    { armazenar dados sobre a 1¦ falha }
                    if (go = true) then
                      begin
                        setfalha:=a;
                        numfalha:=b;
                        nq:=j;
                        go:=false;
                      end;
                  end;
          end;       

        end;


{*****  2  *****}
      Case numjog of
        1 : begin
              jog[1].tsec := jog[1].tsec + (jog[1].ts100 DIV 100);
              jog[1].ts100 := (jog[1].ts100 MOD 100);

              CalculaIQ (jog[1].tsec, jog[1].Pont);
              Janela (4, 0);
              Mostrar_Score (jog[1].Pont);
              Actualizar_Records (jog[1].Pont, ass, numjog, nf);
            end;
        2 : begin
              { DETERMINAR VENCEDOR }
              For i:=1 to 2 do
                begin
                  jog[i].tsec := jog[i].tsec + (jog[i].ts100 DIV 100);
                  jog[i].ts100 := (jog[i].ts100 MOD 100);
                  CalculaIQ (jog[i].tsec, jog[i].Pont);
                end;
              if jog[1].Pont > jog[2].Pont then vencedor:=1
              else if jog[2].Pont > jog[1].Pont then vencedor:=2
              else vencedor:=0;
              if vencedor <> 0 then
                begin
                  Janela (4, 0);
                  GotoXY (19,6);
                  TextColor (15);
                  Write ('VENCEDOR :  JOGADOR ', vencedor);
                  Mostrar_Score (jog[vencedor].Pont);
                  Case vencedor of
                    1: Derrotado (jog[2].Pont, 2);
                    2: Derrotado (jog[1].Pont, 1);
                  end;
                  Actualizar_Records (jog[vencedor].Pont, ass, numjog, nf);
                end
              else
                begin
                  Janela (4, 0);
                  GotoXY (22,6);
                  TextColor (15);
                  Write ('E M P A T E !!!');
                  Mostrar_Score (jog[1].Pont);  {  indiferente mostrar a pontua‡„o do 1 ou do 2 }
                  WriteXY (26, 19, 'JOGADOR 1', 15);
                  Actualizar_Records (jog[1].Pont, ass, numjog, nf);
                  Delay (1500);
                  WriteXY (26, 19, 'JOGADOR 2', 15);
                  Actualizar_Records (jog[2].Pont, ass, numjog, nf);
                end;
            end;
      end;

      if (go = false) then      { se houver alguma resposta falhada }
        begin
          { Mostrar UMA falha }
          Janela (4, 0);
          Init_Janela4 (numjog);
          TextColor (0); TextBackGround (7);
          p[1]:=Copy(t[setfalha][numfalha].q,1,44);
          p[2]:=Copy(t[setfalha][numfalha].q,45,44);
          p[3]:=Copy(t[setfalha][numfalha].q,89,44);
          GotoXY (8,3); Write (p[1]);
          GotoXY (8,4); Write (p[2]);
          GotoXY (8,5); Write (p[3]);
          TextColor (15); TextBackGround (1);
          For k:=4 to 8 do WriteXY (14-(numjog*2),  k*2-1, t[setfalha][numfalha].ans[k-3], 15);
          Case t[setfalha][numfalha].certa of
            'A': WriteXY (14-(numjog*2),   7, t[setfalha][numfalha].ans[1], 31);
            'B': WriteXY (14-(numjog*2),   9, t[setfalha][numfalha].ans[2], 31);
            'C': WriteXY (14-(numjog*2),  11, t[setfalha][numfalha].ans[3], 31);
            'D': WriteXY (14-(numjog*2),  13, t[setfalha][numfalha].ans[4], 31);
            'E': WriteXY (14-(numjog*2),  15, t[setfalha][numfalha].ans[5], 31);
          end;
          WriteXY (23, 17, 'Quest„o N§ ', 15); Write (nq:2);
          WriteXY (14,  2, 'CORREC€ŽO DE UMA RESPOSTA FALHADA', 15);
          WriteXY ( 3, 19, 'Carregue em alguma tecla para voltar ao Menu Principal.', 15);
          Hold;
        end;

{*****  2  *****}
      if (numjog = 1) then Janela (4, 2) else For i:=4 to 6 do Janela (i, 2);
    end;

  escape_way:;

  Init_Janela3;
  Init_Janela2;

end;


Procedure Criar;

Var
  f: file of Assunto;
  i, j, k, m, ass, n: Byte;
  UmTema: Assunto;
  bloco: setofquestions;
  numero: LongInt;
  enter: Boolean;
  texto: String;
  ch, sn: Char;
  txt, nf: st12;
  h: File of Assunto_Fich;
  af: Assunto_Fich;
  posaf: Integer;
  tam: ShortInt;

begin
  
  Janela (2, 0);
  WriteXY (8, 1, '****  Criar Grupo De Perguntas  ****', 0);

  Escolher_Assunto (ass); { o nome desta vari vel ‚ a abreviatura de assunto }
  Janela (3, 0);

  if ass > 0 then
    begin
      Janela (3, 1);
      WriteXY (8,  9, 'Para fazer um ®Set¯ de perguntas s„o  ', 14);
      WriteXY (8, 10, 'necess rias 10 quest”es.               ', 14);
      WriteXY (8, 12, 'Cada ficheiro pode conter 6 ®Sets¯.    ', 14);

      WriteXY (7, 3, 'Nome do Ficheiro  :  [        ] . UDR ', 14);
      WriteXY (21, 5, 'Set # [ ]', 14);
      if ass = 8 then WriteXY (15, 7, 'Tema  :  [            ]', 14);

      { Ler nome do ficheiro }
      Repeat
        nf:='';
        Le_Nome (29, 3, 8, nf);
        delete (nf,9,4);
        nf := Concat (nf, '.UDR');  { USER DEFINED RESOURCE }
        Assign (f, nf);
      Until (nf[1] <> '.') and (nf[1] <> ' ');

      { Ler n£mero do SET }
      Repeat
        WriteXY (21, 5, 'Set # [ ]', 14);
        Ler_Um_Numero (28, 5, 1, numero, enter);
      Until numero in [1 .. 6];
      n:=numero;

      { Encontrar Ficheiro }
      Assign (h, 'TEMAS');    { Encontrar o tema de um question rio '.UDR' }
      {$I-}
      Reset (h);
      if IOResult <> 0 then Rewrite (h);
      Close (h);
      {$I+}
      Reset (h);
      posaf:=-1;
      tam :=  (Filesize (h) - 1);
      if tam>-1 then For k:=0 to tam do
                       begin
                         Seek (h, k);
                         Read (h, af);
                         if (af.nome_fich = nf) then posaf:=k;
                       end
      else posaf:=-1;                        { ainda n„o existe }
      Close (h);

      if (posaf = -1) then                   { nova entrada }
        begin
          if (ass = 8) then
            begin
              txt:='';
              Le_Nome (25, 7, 12, txt);          { ler tema }
              For m:=1 to length(txt) do txt[m] := Upcase (txt[m]);
            end
          else txt:=Temas[ass];
          af.nome_fich:=nf;
          af.assunto:=txt;
        end;

      if (ass = 8) then
        begin
          Janela (2, 1);
          For j:=1 to Length (txt) do txt[j] := Upcase (txt[j]);
          WriteXY (20, 2, txt, 14);
          Janela (3, 1);
          TextColor (14);
        end;

      Janela (3, 0);
      {$I-}
      Reset (f);
      if IOResult <> 0 then begin
                              ReWrite (f);
                              For i:=1 to 6 do
                                For j:=1 to 10 do
                                  begin
                                    UmTema[i][j].q:='';
                                    For k:=1 to 5 do UmTema[i][j].ans[k]:='';
                                    UmTema[i][j].certa:='A';
                                  end;
                              Write (f, UmTema);
                              Close (f);
                            end
      else Close (f);
      {$I+}
      Reset (f);
      Read (f, UmTema);
      i:=1;
      While i < 11 do
        begin
          TextColor (14);
          TextBackGround (1);
          GotoXY (19,1); Write (i:2, ' ¦ Quest„o :');
          GotoXY (22,2); Write ('Set # ',n);
          GotoXY (13,16); Write ('Certa : [ ]');
          GotoXY (30,16); Write ('OK : [ ]');
          TextBackGround (7);
          Window (30,9,73,11);
          For j:=1 to 3 do begin GotoXY (1,j); ClrEol; end;
          Janela (3, 1);
          For j:=7 to 15 do Case j of
                               7 : WriteXY (3, j, 'A - [                                        ]', 14);
                               9 : WriteXY (3, j, 'B - [                                        ]', 14);
                              11 : WriteXY (3, j, 'C - [                                        ]', 14);
                              13 : WriteXY (3, j, 'D - [                                        ]', 14);
                              15 : WriteXY (3, j, 'E - [                                        ]', 14);
                            end;

          { Ler Pergunta }
          TextBackGround (LightGray);
          texto:='';
          EditorDeLinha (4, 3, 132, texto, false, enter);
          UmTema[n][i].q:=texto; texto:='';

          { Ler as 5 Respostas }
          TextBackGround (Blue);
          EditorDeLinha (8, 7, 40, texto, false, enter);
          UmTema[n][i].ans[1]:=texto; texto:='';
          EditorDeLinha (8, 9, 40, texto, false, enter);
          UmTema[n][i].ans[2]:=texto; texto:='';
          EditorDeLinha (8, 11, 40, texto, false, enter);
          UmTema[n][i].ans[3]:=texto; texto:='';
          EditorDeLinha (8, 13, 40, texto, false, enter);
          UmTema[n][i].ans[4]:=texto; texto:='';
          EditorDeLinha (8, 15, 40, texto, false, enter);
          UmTema[n][i].ans[5]:=texto; texto:='';

          { Ler a Resposta Certa }
          Repeat
            Le_Char (22, 16, ch);
            ch:=UpCase(ch);
            UmTema[n][i].certa:=ch;
          Until ch in [#65 .. #69];

          { Confirmar }
          Repeat
            sn:=' ';
            Le_Char (36, 16, sn);
            sn:=UpCase(sn);
          Until (sn=#83) or (sn=#78) or (sn=#27);  { S / N / ESC }
          if sn=#27 then i:=11;  { Sa¡da abrupta }

          Seek (f, 0);
          Write (f, UmTema);
          {  …s vezes h  cada falha de energia que at‚ d¢i  }

          if sn = 'S' then inc (i);

        end;

        if (sn <> #27) then
          begin
            Close (f);
            Reset (h);
            Seek (h, FileSize(h));
            Write (h, af);
            Close (h);
          end;
     end;

  Init_Janela2;
  Init_Janela3;
end;


Procedure Escolher_TXT (var nf: St12; fileext: St5);
{ Este procedimento destina-se a escolher qual o ficheiro TXT, a ser utilizado na importa‡„o dos dados. }

{  *****  Neste procedimento ‚ utilizada uma estrutura de LISTA  *****  }

{ *NOTA* : Ler as explica‡”es dadas para o procedimento Escolher_UDR }

type
  fch = ^fich;
  fich = Record
           ant: fch;
           Nome: St12;
           seg: fch;
         end;

var
  i, j: Byte;
  P, Q: fch;
  ch, ch2: Char;
  ext: St5;
  nofiles: Boolean;

  DirInfo: SearchRec;

begin
  nofiles:=false;
  ext:='';
  ext:=Copy(fileext,3,3);
  DirInfo.Name:='';

  FindFirst(fileext, Archive, DirInfo);

  if (Pos(ext, DirInfo.Name) > 0) then
  else nofiles:=true;  { N„o existem ficheiros com a extens„o pretendida }

  if (nofiles = false) then
    begin
      WriteXY (13, 5, 'Nome do Ficheiro  :  [            ] ', 14);
      WriteXY (12, 7, 'Utilize as ®setas¯ para pesquisar os', 14);
      WriteXY ( 9, 8, 'ficheiros (', 14);
      WriteXY (20, 8,  fileext, 14);
      WriteXY (25, 8, ') existentes no direct¢rio.', 14);

      new (P);
      P^.Nome := DirInfo.Name;
      P^.ant:=nil;
      P^.seg:=nil;

      j:=1;
      While (DosError = 0) do
      begin
        if j>1 then  { Devido ao FindFirst }
          begin
            new (Q);
            Q:=P;
            new (P);
            P^.ant:=Q;
            P^.Nome := DirInfo.Name;
            P^.seg:=nil;
          end;
        inc (j);
        FindNext (DirInfo);
      end;

      { Voltar ao in¡cio }
      if P^.ant<>nil then  { n„o se faz se houver s¢ um elemento na lista }
        Repeat
          Q:=P;
          P:=P^.ant;
          P^.seg:=Q;
        Until (P^.ant = nil);

      WriteXY (35, 5, P^.Nome, 14);

      Repeat
        Hide_Cursor (6);
        Janela (4,1);
        ch:=Readkey;
        Case ch of
          #27 : nf := '';
          #13 : nf := P^.Nome;
          #0 : begin
                 ch2:=ReadKey;
                 Case ch2 of
                   #80 : if (P^.seg <> nil) then
                           { Descer }
                           begin
                             Q:=P;
                             P:=P^.seg;
                             P^.ant:=Q;
                             WriteXY (35, 5, '            ', 14);
                             WriteXY (35, 5, P^.Nome, 14);
                           end
                         else
                           begin
                             Sound (200);
                             Delay (100);
                             NoSound;
                           end;
                   #72 : If (P^.ant <> nil) then
                           { Voltar ao in¡cio }
                           begin
                             Q:=P;
                             P:=P^.ant;
                             P^.seg:=Q;
                             WriteXY (35, 5, '            ', 14);
                             WriteXY (35, 5, P^.Nome, 14);
                           end
                         else
                           begin
                             Sound (200);
                             Delay (100);
                             NoSound;
                           end;
                 end;
               end;
        end;
      Until (ch = #13) or (ch = #27);
      Release (Q);
      Release (P);
    end
  else 
    begin
      WriteXY ( 8, 5, 'N„o existem ficheiros (', 14);
      WriteXY (31, 5, fileext, 14);
      WriteXY (36, 5, ') no direct¢rio.', 14);
      Delay (2000);
    end;
end;


Procedure Importar;
{ Procedimento que constr¢i um ficheiro UDR a partir de um ficheiro TXT }

var
  nf, filename: St12;
  f: File of Assunto;
  t: Assunto;
  i, j, k, l, setnr: Byte;
  texto: Text;
  p: Array [1 .. 3] of String[44];
  x: String[132];
  hip: String[40];
  ch: Char;
  h: file of Assunto_Fich;
  assimp: Assunto_Fich;
  tam: Integer;

label
  not_found;

begin
  For i:= 1 to 3 do Janela (i, 2);
  Janela (4, 0);
  WriteXY (13, 3, '*****  Importar Question rio  *****', 14);

  Escolher_TXT (nf, '*.TXT');
  if (Pos ('.TXT', nf) > 0) then else goto not_found;

  { Importa‡„o }

  Assign (texto, nf);
  Reset (texto);

  tam:=1; filename:='        ';
  Repeat
    filename[tam]:=nf[tam];
    inc(tam);
  Until nf[tam]='.';
  filename[0]:=Chr(tam-1);
  filename:=Concat(filename,'.UDR');
  For l:=1 to 12 do filename[l]:=Upcase(filename[l]);
  Assign (f, filename);
  Rewrite (f);

  { Leitura do Tema }
  Assign (h, 'TEMAS');
  Reset (h);
  assimp.nome_fich:='            ';
  assimp.assunto:='            ';
  if FileSize (h) > 0 then
    Repeat
      Read (h, assimp);
    Until (eof(h)) or (assimp.nome_fich=filename);
  if (assimp.nome_fich=filename) then Seek (h, FilePos(h)-1);
  For l:=1 to 6 do Read (texto, ch);
  Readln (texto, assimp.assunto);
  assimp.nome_fich:=filename;
  Write (h, assimp);
  Close (h);

  TextColor (14);
  For setnr:=1 to 6 do    { n§ de sets }
    begin
      GotoXY (15, 10+setnr);
      Write ('Set : ', setnr, ' ');
      Readln (texto);
      For j:=1 to 10 do    { n§ de quest”es }
        begin
          Readln (texto);  { Avan‡ar uma linha }
          Readln (texto, p[1]);  { Ler a 1¦ parte da quest„o }
          Readln (texto, p[2]);  { Ler a 2¦ parte da quest„o }
          Readln (texto, p[3]);  { Ler a 3¦ parte da quest„o }
          t[setnr][j].q:='';
          for l:=1 to 89 do t[setnr][j].q:=Concat (t[setnr][j].q, ' ');
          Insert (p[1], t[setnr][j].q, 1);
          Insert (p[2], t[setnr][j].q, 45);
          Insert (p[3], t[setnr][j].q, 89);
          { Ler as 5 hip¢teses }
          For k:=1 to 5 do begin
                             for l:=1 to 4 do read (texto, ch);
                             Readln (texto, hip);
                             t[setnr][j].ans[k] := hip;
                           end;
          { Ler a resposta certa }
          for l:=1 to 7 do read (texto, ch);
          Readln (texto, t[setnr][j].certa);
          Readln (texto);
          Write ('.');
          if j=10 then Readln (texto);
        end;
      Write (' Finalizado.');
      Delay (50);
    end;
  Write (f, t);
  Close (f);
  Close (texto);
  WriteXY (5, 19, 'Processamento Conclu¡do. Carregue em alguma tecla.', 14);
  Hold;
  not_found:;
  Janela (4, 2);
  Info;
  Init_Janela2;
end;


Procedure Show_Records;
{ Mostrar o conte£do dos dois ficheiros de RECORDES (Records e Records2). }
{ Cada tabela de recordes tem 15 posi‡”es }

var
  i, quadro: Byte;
  g: T;
  v: Recs;

begin
  For quadro:=1 to 2 do
    begin
      if (quadro = 1) then For i:=1 to 3 do Janela (i, 2);
      Janela (4, 0);
      TextColor (14);
      Case quadro of
        1: Assign (g, 'RECORDS');
        2: Assign (g, 'RECORDS2');
      end;
      {$I-}
      Reset (g);
      if IOResult <> 0 then Reset_Records (g);
      Close (g);
      {$I+}
      Reset (g);
      Read (g, v);
      Case quadro of
        1: begin
             GotoXY (27,2); Write   ('RECORDS');
             GotoXY (25,3); Write ('ÄÄÄÄÄÄÄÄÄÄÄ');
           end;
        2: begin
             GotoXY (20,2); Write   ('RECORDS (2 Jogadores)');
             GotoXY (18,3); Write ('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
           end;
      end;
      For i:=1 to 15 do
        begin
          Gotoxy (8,i+4);
          Writeln (i:2, '  -  ', v[i].Nome:12, '  -  ', v[i].Assunto:12, '  -  ', v[i].PONTIQ:3);
        end;
      Close (g);
      Esvazia_Buffer;
      Repeat Until KeyPressed;
      Janela (4, 2);
      if (quadro = 2) then
        begin
          Init_Janela3;
          Init_Janela2;
        end;
    end;
end;


Procedure Adquirir_Dados (var R1, R2: Recs; var Media: Med);
{ Usado na op‡„o 'Gr ficos' }
{ Procedimento para ler os ficheiros de Recordes, de forma a ser poss¡vel
  a sua representa‡„o gr fica. Para al‚m disto, s„o tamb‚m calculadas
  as suas m‚dias. }

type
  cnt = Array [1 .. 9] of 0 .. 30;

var
  i, j, k: Byte;
  g: T;
  v: Recs;
  Soma: Adds;
  Count: cnt;
  Total: Word;

begin
  For i:=1 to 9 do Soma[i]:=0;
  For i:=1 to 9 do Media[i]:=0;
  For i:=1 to 9 do Count[i]:=0;
  Total:=0;

  For i:=1 to 2 do
    begin
      Case i of
        1: Assign (g, 'RECORDS');
        2: Assign (g, 'RECORDS2');
      end;
      {$I-}
      Reset (g);
      If IOResult <> 0 then Reset_Records (g);
      Close (g);
      {$I+}
      Reset (g);
      Read (g, v);
      Case i of
        1: R1:=v;
        2: R2:=v;
      end;
      Close (g);
      For j:=1 to 15 do
        begin
          if v[j].Assunto = 'DESPORTO    ' then begin Soma[1]:=Soma[1]+v[j].PontIQ; inc (Count[1]); end else
          if v[j].Assunto = 'INFORMATICA ' then begin Soma[2]:=Soma[2]+v[j].PontIQ; inc (Count[2]); end else
          if v[j].Assunto = 'CIENCIAS    ' then begin Soma[3]:=Soma[3]+v[j].PontIQ; inc (Count[3]); end else
          if v[j].Assunto = 'TELEVISAO   ' then begin Soma[4]:=Soma[4]+v[j].PontIQ; inc (Count[4]); end else
          if v[j].Assunto = 'CINEMA      ' then begin Soma[5]:=Soma[5]+v[j].PontIQ; inc (Count[5]); end else
          if v[j].Assunto = 'HISTORIA    ' then begin Soma[6]:=Soma[6]+v[j].PontIQ; inc (Count[6]); end else
          if v[j].Assunto = 'GEOGRAFIA   ' then begin Soma[7]:=Soma[7]+v[j].PontIQ; inc (Count[7]); end else
          if (pos('NENHUM', v[j].Assunto) <= 0) then begin Soma[8]:=Soma[8]+v[j].PontIQ; inc (Count[8]); end
        end;
    end;

  For k:=1 to 8 do if (Count[k] <> 0) then Media[k] := (Soma[k] / Count[k]);
  For k:=1 to 8 do Count[9] := Count[9] + Count[k];

  For k:=1 to 8 do Total := Total + Soma[k];
  if (Count[9] <> 0) then Media[9] := (Total / Count[9]);
end;


Procedure Escala;
{ Desenho de uma escala (em modo gr fico) de 0 a 200. }

var
  i, j: Byte;
  number: String[3];

begin
  Line (1,450,1,50);
  For i:=0 to 20 do Line (  1, 50+(i*20),  10, 50+(i*20));
  Line (639,450,639,50);
  For i:=0 to 20 do Line (  629, 50+(i*20),  639, 50+(i*20));
  SetLineStyle (1,1,1);
  SetColor (7);
  For i:=0 to 20 do Line (  40, 50+(i*20),  599, 50+(i*20));

  SetColor (15);
  SetTextStyle (2,0,4);
  For j:=0 to 1 do
    For i:=0 to 19 do begin
                        str (200-(i*10), number);
                        if (length(number) = 2) then number := Concat (' ', number);
                        OutTextXY (  15+(594*j), 45+(i*20), number);
                      end;
end;


Procedure Graficos;
{ Procedimento de elabora‡„o e visualisa‡„o dos gr ficos decorrentes da
  leitura dos ficheiros de Recordes. }

var
  GraphDriver,                      { O Device Driver para Gr ficos }
  GraphMode,                        { O Valor do Modo Gr fico       }
  ErrorCode : Integer;              { Identificador de Erros        }
  i, j, graf: Byte;
  Media: Med;
  R1, R2: Recs;
  position: String[3];

Procedure Abort(Msg : string);

begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

begin
  Window (1,1,80,25);
  TextBackGround (0); TextColor (15);
  ClrScr;

  { Inclus„o dos '.CHR' e do '.BGI' }
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then
    Abort('EGA/VGA');
  if RegisterBGIfont(@GothicFontProc) < 0 then
    Abort('Gothic');
  if RegisterBGIfont(@SansSerifFontProc) < 0 then
    Abort('SansSerif');
  if RegisterBGIfont(@SmallFontProc) < 0 then
    Abort('Small');
  if RegisterBGIfont(@TriplexFontProc) < 0 then
    Abort('Triplex');

  GraphDriver := Detect;
  InitGraph (GraphDriver, GraphMode, '');
  ErrorCode := GraphResult;
  if ErrorCode = GrOk then
    begin

      {  *****  Gr ficos  *****  }

      Adquirir_Dados (R1, R2, Media);

{  *****  Gr ficos 1 & 2  *****  }

      For graf:=1 to 2 do
        begin
          ClearViewPort;
          Escala;
          SetColor (4);
          SetTextStyle (3,0,4);
          Case graf of
            1: OutTextXY (250,0,'Records (1)');
            2: OutTextXY (250,0,'Records (2)');
          end;
          SetColor (14);
          SetTextStyle (2,0,4);
          For i:=0 to 14 do
            begin
              Str (i+1, position);
              if (length(position)=2) then position := Concat (position, '§')
              else position := Concat (' ', position, '§');
              OutTextXY (46+(i*38),460, position);
            end;

          SetLineStyle (0,1,1);
          SetColor (15);
          Line (1,450,679,450);
          For i:=0 to 14 do
            begin
              SetFillStyle (1,i+1);
              Case graf of
                1: Bar (  44+(i*38), 450,  64+(i*38), 450-((Round(R1[i+1].PontIQ))*2));
                2: Bar (  44+(i*38), 450,  64+(i*38), 450-((Round(R2[i+1].PontIQ))*2));
              end;
            end;

          Esvazia_Buffer;
          Repeat Until KeyPressed;
        end;

{  *****  Gr fico 3  *****  }

      ClearViewPort;
      Escala;
      SetColor (4);
      SetTextStyle (3,0,4);
      OutTextXY (270,0,'M‚dias');

      SetColor (14);
      SetTextStyle (2,0,4);
      For i:=0 to 8 do
        Case i of
          0: OutTextXY (32+(i*65),460,' DESPORTO  ');
          1: OutTextXY (32+(i*65),460,'INFORMATICA');
          2: OutTextXY (30+(i*65),460,'  CIENCIAS ');
          3: OutTextXY (30+(i*65),460,' TELEVISAO ');
          4: OutTextXY (26+(i*65),460,'   CINEMA  ');
          5: OutTextXY (27+(i*65),460,'  HISTORIA ');
          6: OutTextXY (28+(i*65),460,' GEOGRAFIA ');
          7: OutTextXY (26+(i*65),460,'   OUTROS  ');
          8: OutTextXY (32+(i*65),460,'   TOTAL   ');
        end;

      SetLineStyle (0,1,1);
      SetColor (15);
      Line (1,450,679,450);
      For i:=0 to 8 do
        begin
          SetFillStyle (1,i+1);
          Bar (  48+(i*65), 450,  73+(i*65), 450-(Round(Media[i+1]*2)));
        end;

      Esvazia_Buffer;
      Repeat Until KeyPressed;

      CloseGraph;
    end
  else
    begin
      WriteLn('Erro  :  ', GraphErrorMsg(ErrorCode));
      Writeln;
      Writeln ('[  Carregue em qualquer tecla para continuar  ]');
      Repeat Until KeyPressed;
    end;

  Initialize;
end;


Procedure Shell;
{ Sa¡da tempor ria para o Sistema Operativo. }

var
  i: Byte;

begin
  Window (1,1,80,25);
  Textcolor (15); Textbackground (0);
  ClrScr;
  Window (17,1,64,25);
  TextColor (14); TextBackGround (1);
  For i:=2 to 8 do
    begin
      GotoXY (1,i);
      ClrEol;
    end;
  GotoXY (1,2);
  Writeln ('     ÛÛÛÛÛÛÛÛÛÛ              ÛÛÛÛÛÛÛÛÛÛ    ');
  Writeln ('         ÛÛ                  ÛÛ      ÛÛ    ');
  Writeln ('         ÛÛ                  ÛÛ      ÛÛ    ');
  Writeln ('         ÛÛ                  ÛÛ      ÛÛ    ');
  Writeln ('         ÛÛ                  ÛÛ  ßÛÜ ÛÛ    ');
  Writeln ('         ÛÛ                  ÛÛ    ßÛÜß    ');
  Writeln ('     ÛÛÛÛÛÛÛÛÛÛ  ÛÛ          ÛÛÛÛÛÛÛÜßÛ  ÛÛ');
  Window (1,1,80,25);
  Textcolor (White);
  Textbackground (Black);
  GotoXY (1,10);
  Writeln ('®Shelling¯ ...');
  Writeln;
  Writeln ('Tecle ®EXIT¯ para regressar ao I.Q.');
  Exec (GetEnv ('COMSPEC'), '');
  Initialize;
  Info;
end;


Procedure Sair (var fim: Boolean);
{ Confirma‡„o da Sa¡da }

var
  ch: Char;

begin

  Janela (3, 0);
  TextColor (5);
  GotoXY (1,3);
  WriteLn ('       ²²²²²²²²²         ²²      ²²²²     ²²  ');
  WriteLn ('      ²²²      ²²        ²²      ²²²²     ²²  ');
  WriteLn ('      ²²        ²        ²²      ²² ²²    ²²  ');
  WriteLn ('      ²²                ²²²      ²² ²²    ²²  ');
  WriteLn ('      ²²²               ²²²      ²²  ²²   ²²  ');
  WriteLn ('      ²²²²²²²²²         ²²       ²²  ²²   ²²  ');
  WriteLn ('        ²²²²²²²²²       ²²       ²²   ²²  ²²  ');
  WriteLn ('              ²²²      ²²²       ²²   ²²  ²²  ');
  WriteLn ('               ²²      ²²²       ²²    ²² ²²  ');
  WriteLn ('      ²        ²²      ²²        ²²    ²² ²²  ');
  WriteLn ('      ²²      ²²²      ²²        ²²     ²²²²  ');
  WriteLn ('       ²²²²²²²²²       ²²        ²²     ²²²²  ');

  Repeat
    ch := ReadKey;
    Case ch of
      's', 'S': fim := true;
      'n', 'N': fim := false;
    end;
  Until ch in ['s', 'S', 'n', 'N'];
  if fim = false then Janela (3, 0);

end;


Procedure Verifica_Temas;
{ Procedimento que no in¡cio do programa verifica a existˆncia do ficheiro
  de Temas, e que o cria se ele n„o existir. }

var
  h: file of Assunto_Fich;

begin
  {$I-}
  Assign (h, 'TEMAS');
  Reset (h);
  if IOResult <> 0 then Rewrite (h);
  Close (h);
  {$I+}
end;


Procedure Start;
{ Procedimanto Principal }
{ Daqui s„o chamadas todas as op‡”es. }

var
  opcao: Byte;
  total: LongInt;

begin
  fim:=false;
  Verifica_Temas;
  { Bloco Principal - Execu‡„o do Menu Principal }
  Repeat
    Esvazia_Buffer;
    opcao:=0;
    Janela (1, 0);
    EscreverOpcoes (MainMenu);
    MovimentaBarra (opcao, MainMenu);
    case opcao of
      1 : Jogar (1);
      2 : Jogar (2);
      3 : Criar;
      4 : Importar;
      5 : Show_Records;
      6 : Graficos;
      7 : Shell;
      8 : Sair (fim);
    end;
    Window (1,1,80,25);
  Until fim = true;
end;

{       Originalmente foram criados 7 ficheiros de ®Resources¯ (*.RES)       }

{       Cada qual com 6 conjuntos de 10 quest”es com 5 hip¢teses cada.       }

{ Espero sinceramente ter elaborado um programa que vos agrade. At‚ Sempre ! }

BEGIN
  Abertura;
  Initialize;
  Start;
  Fecho;
  The_End;
END.