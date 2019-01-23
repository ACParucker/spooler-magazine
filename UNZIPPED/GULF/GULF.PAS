Program Gulf115 (Input, Output); { CRISE NO GOLFO VERSAO 1.15 }


Uses
  Crt, Dos, Graph, BgiDriv, BgiFont;
  { BgiDriv contÇm apenas o driver de EGAVGA }


Type

  Linhas = array [1 .. 4] of String [15];

  Linhas2 = array [1 .. 5] of String [15];

  st7 = String [7];

  Arr1 = Array [1 .. 4] of st7;

  Zero49 = 0 .. 49;

  Um4 = 1 .. 4;

  Arr2 = Array [1 .. 4] of Zero49;

  XY = record
         x: Word;
         y: Word;
       end;

  Int1 = -1 .. 3;


Var
  GraphDriver : Integer;  { O Device Driver Gr†fico }
  GraphMode   : Integer;  { O Valor do Modo Gr†fico }
  ErrorCode   : Integer;
  Jog: Arr1;              { Vector que vai conter os nomes dos jogadores }
  texto: st7;
  k, res: Byte;
  posit: Arr2;            { Vector que vai conter as posiáoes dos jogadores }
  jogador: Um4;
  Cor: Array [1 .. 49] of Char;
  Lugares: Array [1 .. 49] of XY;  { Coordenadas }
  NoPlay: Array [1 .. 4] of -1 .. 3;  { Vector que contÇm o nß de vezes que cada jogador vai estar sem jogar }
  esc, snd: Boolean;  { Vari†veis para controle de sa°da antecipada e de som }


Const
  Casa: Array [0 .. 49] of Linhas =
  (('               ','               ','               ','               '),
   ('Invasao do     ','Koweit         ','Fica 1 x sem   ','Jogar.         '),
   ('Condenacao do  ','Iraque na ONU  ','Avanáa 1 casa. ','               '),
   ('Declarado      ','Embargo        ','Econ¢mico      ','Avanáa 3 casas.'),
   ('FÇrias no      ','Algarve.       ','Vai p/ Partida.','Nao joga 2 x   '),
   ('Contingente    ','Americano.     ','Vai p/ casa 9. ','               '),
   ('Contingente    ','Inglàs.        ','Vai p/ casa 9. ','               '),
   ('Contingente dos','outros aliados.','Avanáa 1 Casa. ','               '),
   ('Estrangeiros no','Iraque sao     ','feitos refÇns. ','Recua 4 casas. '),
   ('     SORTE     ','               ','Tira uma Carta.','               '),
   ('Iniciativa     ','Diplom†tica da ','O.N.U.  -  Nao ','joga uma vez.  '),
   ('Tratado de paz ','Irao - Iraque. ','Volta Ö casa 4.','               '),
   ('Anexaáao do    ','Kuweit.        ','Volta Ö partida','               '),
   ('Aumento de     ','Combust°veis   ','Recua 3 casas. ','               '),
   ('Embargo Jordano','Fica 2 vezes   ','sem jogar.     ','               '),
   ('2ß Contingente ','Americano.     ','Avanáa 3 casas.','               '),
   ('Factura Alema  ','Do esforáo     ','Militar aliado.','Vai p/ casa 20.'),
   ('Queda nas      ','Bolsas         ','Internacionais.','Vai p/ casa 8. '),
   ('Solidariedade  ','L°bia.         ','Recua 6 casas. ','               '),
   ('Contingentes   ','Arabes Aliados.','Avanáa 3 casas.','               '),
   ('     SORTE     ','               ','Tira uma carta.','               '),
   ('Solidariedade  ','Argelina.      ','Recua atÇ Ö    ','Casa 12.       '),
   ('Al† Ç Grande.  ','               ','Fique onde est†','     !!!!!     '),
   ('Libertaáao de  ','RefÇns.        ','Avanáa 1 casa. ','               '),
   ('Massacre de    ','Palestinianos  ','em JerusalÇm.  ','Vai p/ casa 15.'),
   ('Condenaáao de  ','Israel na ONU. ','Avanáa 3 casas.','               '),
   ('2ß Aumento de  ','Combust°veis.  ','Recua 3 casas. ','               '),
   ('Factura        ','Nip¢nica do    ','Esforáo Militar','Avanáa 3 casas.'),
   ('     SORTE     ','               ','Tira uma carta.','               '),
   ('Libertaáao de  ','RefÇns.        ','Avanáa 3 casas.','               '),
   ('Racionamento de','Combust°veis no','Iraque.        ','Avanáa 1 casa. '),
   ('Novos          ','Contingentes   ','Aliados.       ','Avanáa 6 casas.'),
   ('Al† Ç Grande.  ','               ','Fique onde est†','               '),
   ('3ß Contingente ','Americano.     ','Avanáa 4 casas.','               '),
   ('Iniciativa     ','Diplom†tica da ','R£ssia.        ','Avanáa 3 casas.'),
   ('Bombardeamento ','Israelita da   ','Faixa de Gaza. ','Recua 6 casas. '),
   ('Greve Geral na ','Palestina.     ','Fica 3 x sem   ','Jogar.         '),
   ('     SORTE     ','               ','Tira uma carta.','               '),
   ('Manifestaáao   ','Pacifista nos  ','E.U.A.  -  Fica','2 x sem jogar. '),
   ('Manifesto sobre','o uso de armas ','Nucleares.     ','Vai p/ casa 23.'),
   ('Manifestaáao   ','contra Hussein ','no Iraque.     ','Avanáa 2 casas.'),
   ('Atentado       ','Falhado contra ','Hussein.       ','Recua 4 casas. '),
   ('Poáos de Petr¢-','leo Sauditas   ','Atacados.      ','Vai p/ casa 28.'),
   ('Desembarque    ','Aliado no      ','Kuweit.        ','Avanáa 2 casas.'),
   ('Desorganizaáao ','das Foráas     ','Aliadas.       ','Vai p/ Partida.'),
   ('     SORTE     ','               ','Tira uma carta.','               '),
   ('Atentados      ','Arabes em Paris','e Nova York.   ','Vai p/ casa 22.'),
   ('M°ssil         ','Iraquiano      ','Atinge Israel. ','Recua 2 casas. '),
   ('Hussein morre  ','de Enfarte.    ','O FIM ESTA     ','PERTO !        '),
   (' FIM DA CRISE. ','               ','    GANHOU     ','               '));

  Sorte : Array [1 .. 28] of Linhas2 =
  (('Dà o seu 13ß   ','màs ao Fundo de','Apoio Ös Foráas','Aliadas.       ','Recua 5 casas. '),
   ('M†rio Soares Ç ','Nomeado o      ','Arbitro da     ','Crise.   - Fica','3 x sem jogar. '),
   ('Xeque-Mate,    ','Governo        ','Koweitiano no  ','Ex°lio.        ','Vai p/ Partida.'),
   ('ê publicado o  ','Relat¢rio da   ','ONU sobre o    ','Crescimento Ec.','Recua 3 casas. '),
   ('Fica Ö espera  ','de um aviao em ','Ama durante    ','1 màs.         ','Recua 5 casas. '),
   ('Hussein        ','Encontra-se    ','Deprimido.     ','Progrida !     ','Jogue outra vez'),
   ('Alvaro Cunhal  ','Apoia a Crise. ','               ','               ','Vai p/ Partida.'),
   ('Foi mobilizado ','para a Foráa   ','Operacional de ','Urgància.      ','Recua 8 casas. '),
   ('Demite-se da   ','Associaáao de  ','Amizade        ','Portugal-Iraque','Recua 5 casas. '),
   ('Torres Couto   ','Vai p/ o Iraque','Tentar o acordo','de conc. social','Recua 8 casas. '),
   ('ê confundido   ','com um comando ','Arabe. ê preso ','em Paris.      ','Recua 4 casas. '),
   ('Descoberto     ','Petr¢leo no    ','Entroncamento. ','               ','Jogue outra vez'),
   ('Explosao em    ','Lisboa...      ','Duma Caixa da  ','E.D.P.         ','Recua 5 casas. '),
   ('Eduardo Moniz  ','Convidado para ','Dirigir a T.V. ','Iraquiana.     ','Avanáa 2 casas.'),
   ('Cicciolina faz ','Amor com       ','Saddam Hussein.','Animos + calmos','Avanáa 3 casas.'),
   ('Pinto da Costa ','Afinal Ç primo ','De Saddam      ','Hussein.       ','Recua 3 casas. '),
   ('Governo explica','os c†lculos da ','Inflaáao para o','Pr¢ximo Ano.   ','Recua 8 casas. '),
   ('ê enviado como ','Volunt†rio em  ','Substituiáao de','RefÇns.        ','Recua 7 casas. '),
   ('O Governo      ','Ameaáa baixar  ','o Preáo dos    ','Combust°veis.  ','Avanáa 3 casas.'),
   ('Aposta no fim  ','da Crise...    ','Perde !        ','               ','Nao joga 1 vez.'),
   ('Estava de      ','FÇrias no      ','Koweit.        ','ê feito refÇm. ','Vai p/ Partida.'),
   ('Cai um m°ssil  ','SCUD no Est†dio','das Antas.     ','               ','Recua 7 casas. '),
   ('Saddam tambÇm  ','vem dar um     ','"Concerto" em  ','Alvalade.      ','Avanáa 2 casas.'),
   ('Desencontro    ','Secreto entre  ','Deus Pinheiro e','Sadam Hussein. ','Recua 5 casas. '),
   ('Participa no   ','Desembarque    ','Aliado.        ','ê ferido.      ','Recua 3 casas. '),
   ('O Bairrada sobe','O preáo do     ','Barril Ç       ','Competitivo.   ','Avanáa 1 casa. '),
   ('Durao Barroso  ','Oferece-se para','negociaáoes em ','Ama.   -   Fica','2 x sem jogar. '),
   ('Sousa Cintra   ','Distribui Agua ','aos Soldados   ','Aliados Ö borla','Jogue outra vez'));

   { As mensagens estao estruturadas Æpor linhasØ para que se defina um valor
     horizontal, e se incremente uma vari†vel para os pontos verticais
     Nota: os pontos referem-se ao local onde se escreve cada linha. }




Procedure Casas;

var
  k: Byte;

begin

  { Indicaáao das cores de cada casa }
  { E - ENCARNADO, V - VERDE, C - CINZENTO }
  For k:=1 to 49 do
    Case k of
       1: cor[k]:='E';  2: cor[k]:='V';  3: cor[k]:='V';  4: cor[k]:='E';
       5: cor[k]:='V';  6: cor[k]:='V';  7: cor[k]:='V';  8: cor[k]:='E';
       9: cor[k]:='C'; 10: cor[k]:='E'; 11: cor[k]:='E'; 12: cor[k]:='E';
      13: cor[k]:='E'; 14: cor[k]:='E'; 15: cor[k]:='V'; 16: cor[k]:='V';
      17: cor[k]:='E'; 18: cor[k]:='E'; 19: cor[k]:='V'; 20: cor[k]:='C';
      21: cor[k]:='E'; 22: cor[k]:='C'; 23: cor[k]:='V'; 24: cor[k]:='E';
      25: cor[k]:='V'; 26: cor[k]:='E'; 27: cor[k]:='V'; 28: cor[k]:='C';
      29: cor[k]:='V'; 30: cor[k]:='V'; 31: cor[k]:='V'; 32: cor[k]:='C';
      33: cor[k]:='V'; 34: cor[k]:='V'; 35: cor[k]:='E'; 36: cor[k]:='E';
      37: cor[k]:='C'; 38: cor[k]:='E'; 39: cor[k]:='E'; 40: cor[k]:='V';
      41: cor[k]:='E'; 42: cor[k]:='E'; 43: cor[k]:='V'; 44: cor[k]:='E';
      45: cor[k]:='C'; 46: cor[k]:='E'; 47: cor[k]:='E'; 48: cor[k]:='C';
    end;

  { Coordenadas a utilizar para pintar as casas }
  Lugares[1].x:= 242; Lugares[1].y:= 477;
  Lugares[2].x:= 350; Lugares[2].y:= 400; 
  Lugares[3].x:= 410; Lugares[3].y:= 340; 
  Lugares[4].x:= 478; Lugares[4].y:= 242;
  Lugares[5].x:= 440; Lugares[5].y:= 185;
  Lugares[6].x:= 410; Lugares[6].y:= 110;
  Lugares[7].x:= 350; Lugares[7].y:=  50;
  Lugares[8].x:= 242; Lugares[8].y:=   2;
  Lugares[9].x:= 195; Lugares[9].y:=  20;
  Lugares[10].x:=140; Lugares[10].y:= 30;
  Lugares[11].x:= 30; Lugares[11].y:=150;
  Lugares[12].x:= 30; Lugares[12].y:=238;
  Lugares[13].x:= 30; Lugares[13].y:=242;
  Lugares[14].x:= 30; Lugares[14].y:=342;
  Lugares[15].x:=110; Lugares[15].y:=400;
  Lugares[16].x:=190; Lugares[16].y:=430;
  Lugares[17].x:=200; Lugares[17].y:=370;
  Lugares[18].x:=255; Lugares[18].y:=370;
  Lugares[19].x:=310; Lugares[19].y:=350;
  Lugares[20].x:=355; Lugares[20].y:=310;
  Lugares[21].x:=375; Lugares[21].y:=255;
  Lugares[22].x:=375; Lugares[22].y:=195;
  Lugares[23].x:=355; Lugares[23].y:=140;
  Lugares[24].x:=315; Lugares[24].y:=100;
  Lugares[25].x:=260; Lugares[25].y:= 80;
  Lugares[26].x:=195; Lugares[26].y:= 80;
  Lugares[27].x:=145; Lugares[27].y:=100;
  Lugares[28].x:=105; Lugares[28].y:=140;
  Lugares[29].x:= 85; Lugares[29].y:=195;
  Lugares[30].x:= 85; Lugares[30].y:=255;
  Lugares[31].x:=105; Lugares[31].y:=310;
  Lugares[32].x:=145; Lugares[32].y:=350;
  Lugares[33].x:=180; Lugares[33].y:=300;
  Lugares[34].x:=220; Lugares[34].y:=300;
  Lugares[35].x:=247; Lugares[35].y:=315;
  Lugares[36].x:=280; Lugares[36].y:=300;
  Lugares[37].x:=305; Lugares[37].y:=275;
  Lugares[38].x:=317; Lugares[38].y:=242;
  Lugares[39].x:=317; Lugares[39].y:=207;
  Lugares[40].x:=305; Lugares[40].y:=175;
  Lugares[41].x:=305; Lugares[41].y:=172;
  Lugares[42].x:=247; Lugares[42].y:=137;
  Lugares[43].x:=212; Lugares[43].y:=137;
  Lugares[44].x:=178; Lugares[44].y:=147;
  Lugares[45].x:=150; Lugares[45].y:=175;
  Lugares[46].x:=142; Lugares[46].y:=207;
  Lugares[47].x:=142; Lugares[47].y:=242;
  Lugares[48].x:=150; Lugares[48].y:=280;

end;


Procedure Clean_Buffer;  { Se alguma tecla tiver sido pressionada,
                           o seu valor vai ser descarregado para uma
                           vari†vel que depois nao vai ser usada. }

var
  ch: Char;

begin
  Repeat
    if KeyPressed then ch:=ReadKey;
  Until (not KeyPressed);
end;


Procedure Le_Nome (x, y, complinha: byte; var texto: st7);

{ Editor de linha para ler nomes com um m†ximo de 7 caracteres }

var
  i, pos: byte;
  ch: char;
  ok: Boolean;

begin
  i:=0; ok:=false; pos:=x;
  gotoxy (x,y);
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
                        if whereX <> (x+complinha) then
                          begin
                            if y <> 2 then write('.')
                            else write (' ');
                          end;
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
                  if wherex <> (x+complinha) then
                  if y <> 2 then write('.') else write (' ');
                  pos:=pred(pos);
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


Procedure Inserir_Jogadores (var Jog: Arr1);

{ Leitura dos nomes dos jogadores }
{ Se um espaáo for deixado em branco, todos os jogadores atÇ ao 4 serao
  controlados pelo computador }

var
  i, j: Byte;

begin
  Window (1,4,80,11);
  For i:=1 to 7 do begin
                     Gotoxy (1,i);
                     if i mod 2 = 1 then TextBackGround (Blue) else TextBackGround (Black);
                     ClrEol;
                   end;

  TextColor (Yellow);
  i:=1;
  For j:=1 to 4 do begin
                     Gotoxy (1,i);
                     Write ('                          Jogador Nß ', j, '  :  [.......]');
                     i:=i+2;
                   end;

  j:=1;
  Jog[1]:='';  Jog[2]:='';  Jog[3]:='';  Jog[4]:='';
  repeat
    case j of
      1: Le_Nome (45,1,7,Jog[1]);
      2: Le_Nome (45,3,7,Jog[2]);
      3: Le_Nome (45,5,7,Jog[3]);
      4: Le_Nome (45,7,7,Jog[4]);
    end;
    if (Jog[1]<>'') then inc (j);
  until ((j=3) and (Jog[2]='')) or ((j=4) and (Jog[3]='')) or (j=5);
  for j:=1 to 4 do
    for i:=1 to 8 do Jog[j][i] := Upcase (Jog[j][i]);
end;


Procedure Quantos_Jogadores (var Jog: Arr1);

var
  i, j, nj, jc: Byte;

  { nj - nß jogadores | jc - jogadores controlados pelo computador }

begin
  nj:=4;
  if Jog[2] = '' then nj:=1 else if Jog[3] = '' then nj:=2 else if Jog[4] = '' then nj:=3;
  jc:=4-nj;
  case jc of
    0 : ;
    1 : Jog[4]:='COMP #1';
    2 : begin
          Jog[4]:='COMP #2';
          Jog[3]:='COMP #1';
        end;
    3 : begin
          Jog[4]:='COMP #3';
          Jog[3]:='COMP #2';
          Jog[2]:='COMP #1';
        end;
  end;
end;


Procedure Inicializar;

{ Inicializaáao do modo gr†fico, fontes e driver de placa gr†fica }

var
  k: Integer;
  textinfo: textsettingstype;
  p: Pointer;

Procedure Abort(Msg : string);

begin
  Writeln(Msg, ': ', GraphErrorMsg(GraphResult));
  Halt(1);
end;

begin
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
      { Desenhar Tabuleiro }
      Circle (240,239,239);
      Circle (240,239,179);
      Circle (240,239,119);
      Circle (240,239,59);
      Line (240, 1, 240, 180); Line (240, 298, 240, 479);
      Line (1, 239, 181, 239); Line (299, 239, 479, 239);
      Line (71, 408, 198, 281); Line (281, 198, 408, 71);
      Line (71, 71, 198, 198); Line (281, 281, 408, 408);
      Line (20 , 148, 185, 215); Line (295, 263, 460, 330);
      Line (20 , 330, 185, 263); Line (295, 215, 460, 148);
      Line (149, 19, 216, 186); Line (264, 294, 331, 459);
      Line (149, 459, 216, 294); Line (264, 184, 331, 19);
      SetFillStyle (1,14);
      FloodFill (240,240,15);
      SetTextStyle (1,0,3);
      SetColor (Brown);
      OutTextXY (200, 225, 'VITORIA');

      SetColor (White);
      Rectangle (0,0,480,479);

      SetColor (LightGray);
      SetTextStyle (2,0,6);
      OutTextXY (8, 0, 'Jogador');
      OutTextXY (8, 15, '   1   ');
      OutTextXY (8, 30, Jog[1]);
      OutTextXY (8, 424, 'Jogador');
      OutTextXY (8, 439, '   2   ');
      OutTextXY (8, 454, Jog[2]);
      OutTextXY (408, 0, 'Jogador');
      OutTextXY (408, 15, '   3   ');
      OutTextXY (408, 30, Jog[3]);
      OutTextXY (408, 424, 'Jogador');
      OutTextXY (408, 439, '   4   ');
      OutTextXY (408, 454, Jog[4]);

      { Inicializaáao da parte lateral }
      SetColor (White);
      Rectangle (485,45,639,145);
      Rectangle (485,215,639,315);
      Rectangle (485,379,639,479);
      SetTextStyle (3,0,4);
      SetColor (Green);
      OutTextXY (500, 0, 'EVENTOS');
      OutTextXY (525, 170, 'DADO');
      OutTextXY (500, 335, ' SORTE ');
      SetTextStyle (2,0,5);
      SetColor (White);
      Rectangle (515,155,609,172);
      OutTextXY (520,156, ' Som : ON');
      Rectangle (513,322,609,339);
      OutTextXY (520,323, ' L°der : -');

      { Pintar ÆCasasØ }
      { Encarnado }
      SetFillStyle (1,4);
      FloodFill (242,477,15); FloodFill (478,242,15); FloodFill (242,2,15);     { 1, 4, 8 }
      FloodFill (140,30,15); FloodFill (30,150,15); FloodFill (30,238,15);      { 10, 11, 12 }
      FloodFill (30,242,15); FloodFill (30,342,15); FloodFill (200,370,15);     { 13, 14, 17 }
      FloodFill (255,370,15); FloodFill (375,255,15); FloodFill (315,100,15);   { 18, 21, 24 }
      FloodFill (195,80,15); FloodFill (247,315,15); FloodFill (280,300,15);    { 26, 35, 36 }
      FloodFill (317,242,15); FloodFill (317,207,15); FloodFill (305,172,15);   { 38, 39, 41 }
      FloodFill (247,137,15); FloodFill (178,147,15); FloodFill (142,207,15);   { 42, 44, 46 }
      FloodFill (142,242,15);                                                   { 47 }

      { Verde }
      SetFillStyle (1,2);
      FloodFill (350,400,15); FloodFill (410,340,15); FloodFill (440,185,15);   { 2, 3, 5 }
      FloodFill (410,110,15); FloodFill (350,50,15); FloodFill (110,400,15);    { 6, 7, 15 }
      FloodFill (190,430,15); FloodFill (310,350,15); FloodFill (355,140,15);   { 16, 19, 23 }
      FloodFill (260,80,15); FloodFill (145,100,15); FloodFill (85,195,15);     { 25, 27, 29 }
      FloodFill (85,255,15); FloodFill (105,310,15); FloodFill (180,300,15);    { 30, 31, 33 }
      FloodFill (220,300,15); FloodFill (305,175,15); FloodFill (212,137,15);   { 34, 40, 43 }

      { Cinzento }
      SetFillStyle (1,7);
      FloodFill (195,20,15); FloodFill (355,310,15); FloodFill (375,195,15);    { 9, 20, 22 }
      FloodFill (105,140,15); FloodFill (145,350,15); FloodFill (305,275,15);   { 28, 32, 37 }
      FloodFill (150,175,15); FloodFill (150,280,15);                           { 45, 48 }

      SetColor (15);
      Arc (240, 239, 248, 270, 179); Arc (240, 239, 226, 247, 119); Arc (240, 239, 206, 225, 59);
      Arc (240, 239, 248, 270, 180); Arc (240, 239, 226, 247, 120); Arc (240, 239, 206, 225, 60);
      Arc (240, 239, 248, 270, 181); Arc (240, 239, 226, 247, 121); Arc (240, 239, 206, 225, 61);

      {  NUMEROS  }
      SetTextStyle (3,0,1);
      SetColor (White);
      OutTextXY (275,430,'1'); OutTextXY (350,400,'2'); OutTextXY (410,340,'3');
      OutTextXY (440,265,'4'); OutTextXY (440,185,'5'); OutTextXY (410,110,'6');
      OutTextXY (350,50,'7'); OutTextXY (275,20,'8'); OutTextXY (195,20,'9');
      OutTextXY (110,50,'10'); OutTextXY (55,110,'11'); OutTextXY (25,185,'12');
      OutTextXY (25,265,'13'); OutTextXY (55,340,'14'); OutTextXY (110,400,'15');
      OutTextXY (190,430,'16'); OutTextXY (200,370,'17'); OutTextXY (255,370,'18');
      OutTextXY (310,350,'19'); OutTextXY (355,310,'20'); OutTextXY (375,255,'21');
      OutTextXY (375,195,'22'); OutTextXY (355,140,'23'); OutTextXY (315,100,'24');
      OutTextXY (260,80,'25'); OutTextXY (195,80,'26'); OutTextXY (145,100,'27');
      OutTextXY (105,140,'28'); OutTextXY (85,195,'29'); OutTextXY (85,255,'30');
      OutTextXY (105,310,'31'); OutTextXY (145,350,'32'); OutTextXY (180,300,'33');
      OutTextXY (212,315,'34'); OutTextXY (247,315,'35'); OutTextXY (280,300,'36');
      OutTextXY (305,275,'37'); OutTextXY (317,242,'38'); OutTextXY (317,207,'39');
      OutTextXY (305,172,'40'); OutTextXY (282,147,'41'); OutTextXY (247,137,'42');
      OutTextXY (212,137,'43'); OutTextXY (178,147,'44'); OutTextXY (150,172,'45');
      OutTextXY (142,207,'46'); OutTextXY (142,242,'47'); OutTextXY (150,275,'48');

      { Indicaáao de cores de cada jogador }
      Rectangle (95,5,115,25);
      Rectangle (365,5,385,25);
      SetFillStyle (1,5); FloodFill (366,6,15);
      Rectangle (95,454,115,474);
      SetFillStyle (1,1); FloodFill (96,455,15);
      Rectangle (365,454,385,474);
      SetFillStyle (1,6); FloodFill (366,455,15);

      { Areas para controle de posiáao }
      SetColor (LightGray);
      Rectangle (12,72,38,88);
      Rectangle (12,391,38,407);
      Rectangle (442,72,468,88);
      Rectangle (442,391,468,407);

    end
  else Halt (1);

end;


Procedure Invert_Sound (var ch: Char);

{ Funciona como um interruptor, quando est† ligado (ON) passa a desligado
  (OFF) e vice-versa. }

begin
  SetColor (15);
  SetTextStyle (2,0,5);
  SetViewPort (520, 156, 608, 169, ClipOn);
  ClearViewPort;
  if snd=true then
    begin
      snd:=false;
      OutTextXY (0, 0, ' Som : OFF');
    end
  else
    begin
      snd:=true;
      OutTextXY (0, 0, ' Som : ON');
    end;
  Clean_Buffer;
  ch:=#127;  { Esta atribuiáao garante o controle deste procedimento }
end;


Procedure Pinta (res: Byte);  { Desenha o n£mero de pintas do dado }

var
  k: Word;

begin

  Case res of
    1 : for k:=1 to 3 do Circle (27,30,k);
    2 : begin
          for k:=1 to 3 do Circle (12,16,k);
          for k:=1 to 3 do Circle (42,44,k);
        end;
    3 : begin
          for k:=1 to 3 do Circle (12,16,k);
          for k:=1 to 3 do Circle (27,30,k);
          for k:=1 to 3 do Circle (42,44,k);
        end;
    4 : begin
          for k:=1 to 3 do Circle (12,16,k);
          for k:=1 to 3 do Circle (12,44,k);
          for k:=1 to 3 do Circle (42,16,k);
          for k:=1 to 3 do Circle (42,44,k);
        end;
    5 : begin
          for k:=1 to 3 do Circle (12,16,k);
          for k:=1 to 3 do Circle (12,44,k);
          for k:=1 to 3 do Circle (42,16,k);
          for k:=1 to 3 do Circle (42,44,k);
          for k:=1 to 3 do Circle (27,30,k);
        end;
    6 : begin
          for k:=1 to 3 do Circle (12,16,k);
          for k:=1 to 3 do Circle (12,44,k);
          for k:=1 to 3 do Circle (42,16,k);
          for k:=1 to 3 do Circle (42,44,k);
          for k:=1 to 3 do Circle (12,30,k);
          for k:=1 to 3 do Circle (42,30,k);
        end;
  end;

end;


Procedure Watch_Keys (var esc: Boolean);  { VERIFICAÄAO DAS TECLAS 'ESCAPE' E 'S' }

var
  ch: Char;

begin
  if (KeyPressed = true) then
    begin
      ch:=Readkey;
      if ch=#27 then esc:=true;
      { CONTROLE DO SOM }
      if (ch=#83) or (ch=#115) then Invert_Sound (ch);
    end;
end;


Procedure Rodar (var res: Byte; jogador: Um4);

type
  comb = Array [1 .. 6] of 1 .. 6;

var
  i, v, srt: Byte;
  ch: Char;

const 
  combdado : Array [1 .. 30] of comb =
             ((1,3,2,4,6,5),(1,4,6,5,2,3),(1,2,3,4,5,6),(1,6,5,3,2,4),(1,5,6,4,3,2),
              (2,1,3,6,5,4),(2,3,5,4,1,6),(2,4,3,5,6,1),(2,5,1,6,4,5),(2,6,1,4,5,3),
              (3,1,4,6,5,2),(3,2,5,1,4,6),(3,4,6,5,2,1),(3,5,2,4,1,6),(3,6,5,4,1,2),
              (4,1,5,4,2,6),(4,2,5,1,6,3),(4,3,2,6,1,5),(4,5,3,1,2,6),(4,6,5,1,3,2),
              (5,1,2,4,3,6),(5,2,4,6,1,3),(5,3,4,1,2,6),(5,4,3,2,6,1),(5,6,2,1,4,3),
              (6,1,3,4,5,2),(6,2,5,4,3,1),(6,3,4,1,5,2),(6,4,2,5,3,1),(6,5,1,2,4,3));

{ Nß TOTAL DE COMBINAÄOES SEM REPETIÄOES = 6! = 1 * 2 * 3 * 4 * 5 * 6 = 720. }

begin
  Delay (1000);
  SetViewPort (486,216,638,314,ClipOn);
  ClearViewPort;
  SetTextStyle (3,0,2);

  if pos('COMP', Jog[jogador]) > 0 then  { ... se o jogador Ç controlado pelo computador ... }
    begin
      ClearViewPort;
      SetColor (14);
      OutTextXY (25, 15, 'Jogada de');
      For i:=1 to 6 do
        begin
          SetColor (14);
          OutTextXY (30, 45, Jog[jogador]);
          Delay (150);
          SetColor (0);
          OutTextXY (30, 45, Jog[jogador]);
          Delay (150);
        end;
      ClearViewPort;
      Watch_Keys (esc);
    end
  else Repeat  { ... se o jogador nao Ç controlado pelo computador ... }
         Delay (300);
         SetColor (14);
         SetTextStyle (3,0,2);
         SetViewPort (486,216,638,315,ClipOn);
         OutTextXY (25, 10, Jog[jogador]);
         OutTextXY (10, 37, 'Carregue em');
         OutTextXY (10, 62, ' < ENTER > ');
         if KeyPressed then ch := readkey;
         { CONTROLE DO SOM }
         if (ch=#83) or (ch=#115) then Invert_Sound (ch);
         SetViewPort (490,216,634,252,ClipOn);
         ClearViewPort;
       Until (ch = #13) or (ch = #27);

  If (ch = #27) then esc := true
  else
    begin  { Limpa janelas laterais }
      SetViewPort (490,216,638,314,ClipOn);
      ClearViewPort;
      SetViewPort (490,380,638,478,ClipOn);
      ClearViewPort;
      SetViewPort (490,48,638,140,ClipOn);
      ClearViewPort;

      Randomize;
      res := Random (6) + 1;
      i:=1; v:=1;
      SetColor (14);
      SetViewPort (532,236,586,296,ClipOn);
      Rectangle (0,0,54,60);
      srt := Random (30) + 1;  { Sorteio das 30 combinaáoes }

      while (v < 2) do
        begin
          Pinta (combdado[srt,i]);
          if snd=true then
            begin
              Sound (combdado[srt,i]*1000);
              Delay (16*combdado[srt,i]);
              NoSound;
            end;
          Delay (120);
          ClearViewPort;
          Rectangle (0,0,54,60);
          inc (i);
          if i mod 7 = 0 then begin i:=1; inc (v); end;
        end;

      Pinta (res);
      if snd=true then  { Som do rolar do dado }
        begin
          Sound (res*1000);
          Delay (20*res);
          NoSound;
        end;
      Delay (2000);
    end;
end;


Procedure Dado (var res: Byte; jogador: Um4);

begin
  Rodar (res, jogador);
  SetViewPort (0,0,639,479,ClipOn);  { Voltar ao referencial m†ximo }
end;


Procedure Actualizar_Cores (oldpos: Byte; posit: Arr2; Jogador: Um4);

{ Executar as alteraáoes provocadas por uma jogada no tabuleiro }

var
  X, Y: Word;
  k, qual, numcor: Byte;
  outro: Boolean;

begin
  Delay (200);
  outro:=false;
  if oldpos > 0 then begin
                       for k:=1 to 4 do if oldpos = posit[k] then
                         begin
                           outro:=true;
                           qual:=k;
                         end;

                       if outro = false then Case cor[oldpos] of
                                               'E' : numcor:=4;
                                               'V' : numcor:=2;
                                               'C' : numcor:=7;
                                             end
                       else Case qual of
                              1 : numcor:=0;
                              2 : numcor:=1;
                              3 : numcor:=5;
                              4 : numcor:=6;
                            end;

                       SetFillStyle (1,numcor);
                       X := Lugares[oldpos].x;
                       Y := Lugares[oldpos].y;
                       FloodFill (X, Y, 15);
                       Delay (200);
                     end;

  Case jogador of
    1 : SetFillStyle (1,0);
    2 : SetFillStyle (1,1);
    3 : SetFillStyle (1,5);
    4 : SetFillStyle (1,6);
  end;

  X := Lugares[posit[jogador]].x;
  Y := Lugares[posit[jogador]].y;
  FloodFill (X, Y, 15);
end;


Procedure Act_Casas (p: Zero49; j: Um4);  { Actualizar o controle das posiáoes }

var
  q: String;

begin
  str (p,q);
  SetColor (White);
  SetTextStyle (2,0,6);
  Case j of
    1 : begin
          SetViewPort (10,70,40,90,ClipOn);
          ClearViewPort;
        end;
    2 : begin
          SetViewPort (10,389,40,409,ClipOn);
          ClearViewPort;
        end;
    3 : begin
          SetViewPort (440,70,470,90,ClipOn);
          ClearViewPort;
        end;
    4 : begin
          SetViewPort (440,389,470,409,ClipOn);
          ClearViewPort;
        end;
  end;
  Rectangle (2,2,28,18);
  if Length (q) = 1 then OutTextXY (20, 0, q) else OutTextXY (5, 0, q);
  SetViewPort (0,0,639,479,ClipOn);
end;


Procedure Som_Apropriado (mov: ShortInt; sj: Int1);

var
  j, k: Byte;
  l: Word;

begin
  if (mov>0) and (mov<26) then { PROGRESSAO }
                               For k:=1 to 120 do
                                 begin
                                   Sound (800+(2*k));
                                   Delay (5);
                                   NoSound;
                                 end;
  if (mov>-26) and (mov<0) then { REGRESSAO }
                                For k:=1 to 120 do
                                  begin
                                    Sound (800-(2*k));
                                    Delay (5);
                                    NoSound;
                                  end;
  if (mov=101) then { PARTIDA }
                    For j:=0 to 3 do
                      begin
                        For k:=20 downto 1 do
                          begin
                            Sound (600-(10*k)-(10*j));
                            Delay (10);
                            NoSound;
                          end;
                        Delay (50);
                      end;
  if (sj > 0) and (mov <> 101) then
    { FICA SEM JOGAR }
    begin
      l:=1000;
      while l>99 do
        begin
          Sound (l);
          Delay (20);
          NoSound;
          Delay (40);
          l:=l-100;
        end;
    end;
end;


Procedure Cartao_Sorte (p: Zero49; var mov: ShortInt; var sj: Int1);

var
  k, l: Byte;

begin

  SetViewPort (0,0,639,479,ClipOn);
  SetTextStyle (3,0,4);
  For k:=1 to 6 do
    begin
      SetColor (0);
      OutTextXY (500, 335, ' SORTE ');
      Delay (150);
      SetColor (2);
      OutTextXY (500, 335, ' SORTE ');
      Delay (150);
    end;

  if (snd=true) then
    begin
      Sound (250); Delay (110); NoSound; Delay (170);
      Sound (200); Delay (100); NoSound; Delay (160);
      Sound (150); Delay  (90); NoSound; Delay (150);
      Sound (200); Delay (100); NoSound; Delay (160);
      Sound (250); Delay (110); NoSound; Delay (170);
    end;

  Randomize;
  l := Random (28);
  SetViewPort (490,380,638,478,ClipOn);
  ClearViewPort;
  SetColor (White);
  SetTextStyle (2,0,5);
  for k:=0 to 4 do OutTextXY (10, 15+k*12, Sorte[l+1][k+1]);
  SetViewPort (0,0,639,479,ClipOn);

  Case l+1 of
     1 : mov:=-5;
     2 : sj:=3;
     3 : mov:=101;  { Partida }
     4 : mov:=-3;
     5 : mov:=-5;
     6 : sj:=-1;
     7 : mov:=101;  { Partida }
     8 : mov:=-8;
     9 : mov:=-5;
    10 : mov:=-8;
    11 : mov:=-4;
    12 : sj:=-1;
    13 : mov:=-5;
    14 : mov:=2;
    15 : mov:=3;
    16 : mov:=-3;
    17 : mov:=-8;
    18 : mov:=-7;
    19 : mov:=3;
    20 : sj:=1;
    21 : mov:=101;  { Partida }
    22 : mov:=-7;
    23 : mov:=2;
    24 : mov:=-5;
    25 : mov:=-3;
    26 : mov:=1;
    27 : sj:=2;
    28 : sj:=-1;
  end;

end;




Procedure After_Move (p: Zero49; var mov: ShortInt; var sj: Int1);

{ Verificar qual o progresso do jogador, ap¢s o lanáamento do dado }

begin
  sj:=0; mov:=0;
  Case p of
    1 : sj:=1;
    2 : mov:=1;   
    3 : mov:=3;   
    4 : begin mov:=101; sj:=2; end;  { Partida }
    5 : mov:=4;   
    6 : mov:=3;   
    7 : mov:=1;
    8 : mov:=-4;
    9 : Cartao_Sorte (p, mov, sj);
   10 : sj:=1;
   11 : mov:=-7;
   12 : mov:=101;  { Partida }
   13 : mov:=-3;
   14 : sj:=2;
   15 : mov:=3;
   16 : mov:=4;
   17 : mov:=-9;
   18 : mov:=-6;
   19 : mov:=3;
   20 : Cartao_Sorte (p, mov, sj);  { Sorte }
   21 : mov:=-9;
   22 : mov:=0;
   23 : mov:=1;
   24 : mov:=-9;
   25 : mov:=3;
   26 : mov:=-3;
   27 : mov:=3;
   28 : Cartao_Sorte (p, mov, sj);  { Sorte }
   29 : mov:=3;
   30 : mov:=1;
   31 : mov:=6;
   32 : mov:=0;
   33 : mov:=4;
   34 : mov:=3;
   35 : mov:=-6;
   36 : sj:=3;
   37 : Cartao_Sorte (p, mov, sj);  { Sorte }
   38 : sj:=2;
   39 : mov:=-16;
   40 : mov:=2;
   41 : mov:=-4;
   42 : mov:=-14;
   43 : mov:=2;
   44 : mov:=101; { Partida }
   45 : Cartao_Sorte (p, mov, sj);  { Sorte }
   46 : mov:=-24;
   47 : mov:=-2;
   48 : mov:=0;
   49 : mov:=0;
  end;
  if (snd=true) then Som_Apropriado (mov, sj);
end;


Procedure Display_Leader (posit: Arr2);

var
  k, l, max: Byte;
  nmbr, all: String[10];

begin
  max:=0;
  For k:=1 to 4 do if (posit[k]>max) then
                     begin
                       l:=k;
                       max:=posit[k];
                     end
                   else if (posit[k]=max) then l:=0;
  if l>0 then str (l, nmbr) else nmbr:='-';
  all:=Concat(' L°der : ',nmbr);
  SetTextStyle (2,0,5);
  SetColor (White);
  SetViewPort (514,323,608,338,ClipOn);
  ClearViewPort;
  OutTextXY (6,0,all);
end;


Procedure Jogada (var jogador: Um4; var posit: Arr2);

var
  k, oldpos, c: Byte;
  mov: ShortInt;
  sj: Int1;
  ch: Char;

begin

  { Verificar se o jogador nao tem puniáao a cumprir }
  c:=0;
  Repeat
    if Noplay[jogador] > 0 then begin
                                  dec (Noplay[jogador]);
                                  if jogador = 4 then jogador := 1 else inc (jogador);
                                end
    else inc (c);
  Until (NoPlay[jogador] = 0) or (c>3);

  Case jogador of
    1 : begin
          SetTextStyle (2,0,6);
          SetColor (LightGray);
          OutTextXY (  8, 424, 'Jogador'); OutTextXY (  8, 439, '   2   '); OutTextXY (  8, 454, Jog[2]);
          OutTextXY (408,   0, 'Jogador'); OutTextXY (408,  15, '   3   '); OutTextXY (408,  30, Jog[3]);
          OutTextXY (408, 424, 'Jogador'); OutTextXY (408, 439, '   4   '); OutTextXY (408, 454, Jog[4]);
          SetColor (Yellow);
          OutTextXY (8,   0, 'Jogador');
          OutTextXY (8,  15, '   1   ');
          OutTextXY (8,  30, Jog[1]);
        end;
    2 : begin
          SetTextStyle (2,0,6);
          SetColor (LightGray);
          OutTextXY (  8,   0, 'Jogador'); OutTextXY (  8,  15, '   1   '); OutTextXY (  8,  30, Jog[1]);
          OutTextXY (408,   0, 'Jogador'); OutTextXY (408,  15, '   3   '); OutTextXY (408,  30, Jog[3]);
          OutTextXY (408, 424, 'Jogador'); OutTextXY (408, 439, '   4   '); OutTextXY (408, 454, Jog[4]);
          SetColor (Yellow);
          OutTextXY (  8, 424, 'Jogador');
          OutTextXY (  8, 439, '   2   ');
          OutTextXY (  8, 454, Jog[2]);
        end;
    3 : begin
          SetTextStyle (2,0,6);
          SetColor (LightGray);
          OutTextXY (  8,   0, 'Jogador'); OutTextXY (  8,  15, '   1   '); OutTextXY (  8,  30, Jog[1]);
          OutTextXY (  8, 424, 'Jogador'); OutTextXY (  8, 439, '   2   '); OutTextXY (  8, 454, Jog[2]);
          OutTextXY (408, 424, 'Jogador'); OutTextXY (408, 439, '   4   '); OutTextXY (408, 454, Jog[4]);
          SetColor (Yellow);
          OutTextXY (408,   0, 'Jogador');
          OutTextXY (408,  15, '   3   ');
          OutTextXY (408,  30, Jog[3]);
        end;
    4 : begin
          SetTextStyle (2,0,6);
          SetColor (LightGray);
          OutTextXY (  8,   0, 'Jogador'); OutTextXY (  8,  15, '   1   '); OutTextXY (  8,  30, Jog[1]);
          OutTextXY (  8, 424, 'Jogador'); OutTextXY (  8, 439, '   2   '); OutTextXY (  8, 454, Jog[2]);
          OutTextXY (408,   0, 'Jogador'); OutTextXY (408,  15, '   3   '); OutTextXY (408,  30, Jog[3]);
          SetColor (Yellow);
          OutTextXY (408, 424, 'Jogador');
          OutTextXY (408, 439, '   4   ');
          OutTextXY (408, 454, Jog[4]);
        end;
  end;

  Watch_Keys (esc);
  if esc=false then Dado (res, jogador);
  Watch_Keys (esc);

  if esc=false then
    begin
      oldpos:=posit[jogador];
      posit[jogador]:=posit[jogador]+res;
      if posit[jogador] > 49 then posit[jogador] := 49 - (posit[jogador]-49);
      Actualizar_Cores (oldpos, posit, jogador);
      Act_Casas (posit[jogador], jogador);

      SetViewPort (490,48,638,140,ClipOn);
      SetColor (White);
      SetTextStyle (2,0,6);
      for k:=0 to 3 do OutTextXY (0, 10+k*15, Casa[posit[jogador]][k+1]);

      After_Move (posit[jogador], mov, sj);
      NoPlay[jogador] := NoPlay[jogador] + sj;

      oldpos := posit[jogador];
      if mov = 101 then posit[jogador]:=0 else posit[jogador] := posit[jogador] + mov;
      SetViewPort (0,0,639,479,ClipOn);
      Actualizar_Cores (oldpos, posit, jogador);
      Act_Casas (posit[jogador], jogador);
      Display_Leader (posit);

      Delay (2000);  { PAUSA APOS CADA JOGADA E ACTUALIZACAO DO TABULEIRO }

      if NoPlay[jogador] = -1 then begin
                                     NoPlay[jogador]:=0;
                                     if jogador = 1 then jogador:=4 else dec (jogador);
                                   end;

    end;

  SetViewPort (0,0,639,479,ClipOn);

end;


Procedure Hide_Cursor;  { Esconder o Cursor (Modo de Texto) }

begin
  Window (1,1,80,25);
  GotoXY (1,30);
end;


Procedure Abertura;                                       { MODO DE TEXTO }

var
  i, j: Byte;

begin
  ClrScr;
  Window (1,1,80,2);
  TextBackGround (Blue);
  TextColor (LightRed);
  ClrEol;
  Gotoxy (1,1);
  Write ('          CRISE NO GOLFO - V1.17          < POR CARLOS M. Q. FRIAÄAS >          ');
  TextBackGround (Black);
  TextColor (12);
  Window (1,13,80,24);
  Writeln('           ±±±±±   ±±±±±    ±±    ±±±±±   ±±±±±        ±±   ±   ±±±±±');
  Writeln('           ±       ±   ±    ±±    ±       ±            ±±±  ±   ±   ±');
  Writeln('           ±       ±±±±     ±±    ±±±±±   ±±±±±        ± ±± ±   ±   ±');
  Writeln('           ±       ±   ±    ±±        ±   ±            ±  ±±±   ±   ±');
  Writeln('           ±±±±±   ±   ±    ±±    ±±±±±   ±±±±±        ±   ±±   ±±±±±');
  Writeln;
  Writeln('                   ±±±±±   ±±±±±    ±±      ±±±±±   ±±±±±');
  Writeln('                   ±       ±   ±    ±±      ±       ±   ±');
  Writeln('                   ± ±±±   ±   ±    ±±      ±±±±±   ±   ±');
  Writeln('                   ±   ±   ±   ±    ±±      ±       ±   ±');
  Writeln('                   ±±±±±   ±±±±±    ±±±±±   ±       ±±±±±');

  For i:=77 downto 61 do begin
                           For j:=1 to 3 do
                             begin
                               GotoXY (i,j+6); Write ('±±');
                               GotoXY (i+2,j+6); Write ('  ');
                             end;
                           GotoXY (i,11); Write ('±±');
                           GotoXY (i+2,11); Write ('  ');
                           Hide_Cursor;
                           Delay (20);
                           Window (1,13,80,24);
                         end;

end;


Procedure Fecho;                                          { MODO GRAFICO }

var
  venc: 0 .. 4;
  i, k: Byte;

begin
  venc:=0;  { Sa°da Antecipada }
  For i:=1 to 4 do If posit[i] = 49 then venc := i;
  Delay (1000);
  ClearViewPort;

  Case venc of
         0 : begin
               SetTextStyle (3,0,4);
               OutTextXY ( 20, 100, 'Bom... Se nao querem jogar mais...');
               OutTextXY ( 20, 200, 'Vao fazer outra coisa qualquer...');
               OutTextXY ( 20, 300, 'Como por exemplo...');
               OutTextXY (420, 300, '  ESTUDAR !!!');
             end;
    1 .. 4 : begin
               { Som ÆTelegr†ficoØ }
               if (snd=true) then
                 For k:=1 to 4 do
                   begin
                     Sound (100); Delay (80); NoSound; Delay (4*k*4);
                     Sound (100); Delay (80); NoSound; Delay (7*k*6);
                     Sound (100); Delay (80); NoSound; Delay (10*k*4);
                     Sound (100); Delay (80); NoSound; Delay (13*k*4);
                     Sound (100); Delay (80); NoSound; Delay (16*k*4);
                   end;
               SetTextStyle (3,0,5);
               OutTextXY ( 170, 100, 'Acabou a Crise !');
               OutTextXY ( 50, 200, 'O Grande L°der Mundial Ç...');
               OutTextXY ( 220, 300, Jog[venc]);
             end;
  end;

  Delay (4000);
  ClearViewPort;
  SetTextStyle (3,0,5);
  SetColor (Red);
  OutTextXY ( 50, 180, '@ 1993 CMF SoftWonders');
  OutTextXY ( 45, 220, 'ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ');
  Delay (2000);
end;


{  PROGRAMA PRINCIPAL  }


BEGIN
  TextBackGround (Black); TextColor (Black);
  ClrScr;
  Casas;
  Abertura;
  Inserir_Jogadores (Jog);
  Quantos_Jogadores (Jog);
  Clean_Buffer;
  Inicializar;
  For k:=1 to 4 do posit[k]:=0;
  For k:=1 to 4 do Noplay[k]:=0;
  jogador:=1; esc:=false; snd:=true;
  Repeat
    Jogada (jogador, posit);
    inc (jogador);
    if jogador = 5 then jogador := 1;
  Until (posit[1]=49) or (posit[2]=49) or (posit[3]=49) or (posit[4]=49) or (esc=true);
  Fecho;
  CloseGraph;

  { Versao 1.00 - Terminado em 08/08/93 - 01:00 A.M. - 1045 Linhas. }

  { Versao 1.17 - Terminado em 16/10/93 - 01:30 A.M. - 1275 Linhas.
    7 melhoramentos : - Som (Com opáao de ligar/desligar);
                      - ÆBlinkØ do jogador que vai fazer a sua jogada;
                      - Revisao dos ÆDelaysØ;
                      - Inclusao do (.BGI) e dos (.CHR) no execut†vel;
                      - Alteraáao da definicao das constantes das casas;
                      - Indicaáao do jogador mais adiantado;
                      - Aumento de coment†rios na fonte (.PAS);          }

  {  Uma Produáao de Carlos M. Q. Friaáas para a SPOOLER  -  (CACEM - 1993)  }

END.