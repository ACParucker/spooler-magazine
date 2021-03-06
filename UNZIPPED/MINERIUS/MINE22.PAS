{ Auxiliar n� 2 do auxiliar 2 do Min�rius }
Unit Mine22;

interface

uses Crt, Graph, Mine21;

procedure R1P1;
procedure R1P2;
procedure R1P3;
procedure R1P4;
procedure R1P5;
procedure R1P6;
procedure R1P7;
procedure R2P1;
procedure R2P2;
procedure R2P3;
procedure R2P4;
procedure R2P5;
procedure R2P6;
procedure R2P7;
procedure R2P8;
procedure R2P9;
procedure R2P10;
procedure R2P11;
procedure R2P12;
procedure R2P13;
procedure R2P14;
procedure R2P15;
procedure R2P16;
procedure R2P17;
procedure R2P18;
procedure R3P1;
procedure R3P2;
procedure R3P3;
procedure R3P4;
procedure R3P5;
procedure R3P6;
procedure R3P7;
procedure R3P8;
procedure R3P9;
procedure R3P10;
procedure R3P11;

implementation

const G50 : FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);

var ch : char;
    v,d : word;

{ P�gina do Ecr� Como reconhecer }
procedure R1P1;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,175,'1. ESTRUTURA GEOMETRICA');
  EscE(70,205,'CRISTALOGRAFIA BASICA');
  EscE(80,235,'Os cristais s�o minerais com superf�cie original poli�drica, a  qual');
  EscE(80,250,'resulta do  arranjo  regular das  mol�culas formadoras do ret�culo');
  EscE(80,265,'cristalino.');
  EscE(80,280,'A forma geom�trica dos cristais, est� definida em tr�s grupos:');
  EscE(80,310,'1. ISOMETRICOS - Compostos  exclusivamente  pelo  sistema  hom�nimo,');
  EscE(100,325,'tamb�m denominado c�bico, com uma face fundamental que determina');
  EscE(100,340,'tr�s par�metros iguais nos eixos cristalogr�ficos.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R1P2;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'2. DIMETRICOS - Formados   pelo   sistema   hexagonal,  trigonal  e');
  EscE(100,190,'tetragonal,  onde  a  face  fundamental   produz   dois  valores');
  EscE(100,205,'diferentes nos eixos cristalogr�ficos: valores  iguais nos  eixos');
  EscE(100,220,'do mesmo plano.');
  EscE(80,250,'3. TRIMETRICOS - Formados  pelo sistema  ortorr�mbico,  monocl�nico');
  EscE(100,265,'e tricl�nico, nos  quais a  face fundamental produz  tr�s valores');
  EscE(100,280,'diferentes nos eixos cristalogr�ficos.');
  EscE(80,310,'Textos especializados explicam detalhadamente a cristalografia, pois');
  EscE(80,325,'um bom  conhecimento  desse  ramo cient�fico �  essencial  para  se');
  EscE(80,340,'reconhecer  os   minerais.  Por   exemplo,  um  epidoto  pode  ser');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R1P3;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'diferenciado com facilidade de uma vesuvianita, pois esta tem um');
  EscE(80,190,'h�bito tetragonal, enquanto o epidoto tem um h�bito monoclinico.');
  EscE(80,220,'Consulte o Quadro dos Sistemas Cristalinos (F10).');
  EscE(70,250,'RETICULO CRISTALINO');
  EscE(80,280,'No  estado  s�lido,  um cristal  �  um  arranjo  tridimensional  de');
  EscE(80,295,'part�culas,  segundo  um   padr�o  definido  de   repeti��o.  Essas');
  EscE(80,310,'part�culas  (�tomos,  moleculas  e  i�es)  ocupam  os  v�rtices  de');
  EscE(80,325,'min�sculos  paralelep�pedos que, justapostos em  fileiras e colunas,');
  EscE(80,340,'formam o chamado reticulo espacial.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R1P4;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'As part�culas nos v�rtices dos  paralelep�pedos ou  celas unit�rias');
  EscE(80,190,'s�o os n�s, pontos  de  entrela�amento da  estrutura. Uma s�rie de');
  EscE(80,205,'n�s  dispostos  na  mesma  direc��o, forma  uma  fileira  e v�rias');
  EscE(80,220,'fileiras  na   mesma  direc��o,   definem  um   plano   recticular.');
  EscE(70,250,'POLIMORFISMO');
  EscE(80,280,'�  a  propriedade  segundo  a  qual  um  composto  qu�mico   pode');
  EscE(80,295,'cristalizar-se  em   diferentes   ret�culos   espaciais.  O  sistema');
  EscE(80,310,'ou  classe  do   ret�culo  muda,  enquanto   o  mineral  permanece');
  EscE(80,325,'quimicamente   inalterado.   O   polimorfismo   resulta   de  certas');
  EscE(80,340,'condi��es de temperatura e press�o que ocorrem durante a forma��o');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R1P5;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'forma��o do mineral.');
  EscE(80,190,'Quartzo � e �, tridimita e cristobalita s�o deriva��es polimorfas do');
  EscE(80,205,'di�xido de sil�cio.');
  EscE(80,220,'Exemplos  t�picos de  dimorfismo s�o  as piritas (celas  elementares');
  EscE(80,235,'c�bicas) e marcassitas (ortorr�mbicas); diamantes (c�bicas) e grafi-');
  EscE(80,250,'tas (hexagfonais); calcitas (trigonais) e aragonitas (ortorr�mbicas).');
  EscE(70,280,'ISOMORFISMO');
  EscE(80,310,'�  a  propriedade  segundo  a  qual  minerais  com  diferen�as  de');
  EscE(80,325,'composi��o  qu�mica cristalizam em formas id�nticas: os v�rtices dos');
  EscE(80,340,'ret�culos  conservam o  mesmo padr�o  mas s�o ocupados por �tomos');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R1P6;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'n�o semelhantes. Muitas esp�cies minerais de composi��o an�loga s�o');
  EscE(80,190,'isomorfas, possu�ndo  �tomos ou  i�es com aproximadamente o  mesmo');
  EscE(80,205,'raio. A substitui��o isom�rfica pode ocorrer em qualquer escala,');
  EscE(80,220,'embora por vezes, seja limitada.');
  EscE(80,235,'Os   carbonatos  trigonais   oferecem  um  exemplo  de  uma  s�rie');
  EscE(80,250,'isom�rfica: calcita (CaCO3), rodocrosita (MnCO3), siderita (FeCO3).');
  EscE(80,265,'O isomorfismo � muito frequente na natureza, enqanto as  estruturas');
  EscE(80,280,'cristalinas �nicas s�o excepcionais.');
  EscE(70,310,'AGREGADOS CRISTALINOS');
  EscE(80,340,'Em estado  natural, os  cristais aparecem  mais frequentemente  em');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R1P7;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'grupos do que isolados. Os agregados cristalinos  que se erguem de');
  EscE(80,190,'uma base  plana, s�o  denominados  drusas;  os que  crescem  numa');
  EscE(80,205,'superf�cie  c�ncava s�o os geodos. Onde houver  iso-orienta��o, os');
  EscE(80,220,'cristais formar�o agrupamentos paralelos.');
  EscE(80,235,'Outro fen�meno  importante, � a gemina��o: ela ocorre  quando dois');
  EscE(80,250,'ou mais  cristais desenvolvem-se  conforme leis de  gemina��o  bem');
  EscE(80,265,'definidas. Neste caso, os cristais assumem formatos  caracter�sticos');
  EscE(80,280,'e j� classificados - radiais,  fibrosos,  laminados,  e  assim  por');
  EscE(80,295,'diante. Tamb�m foram  classificadas  in�meras formas: estalagm�ticas,');
  EscE(80,310,'mamelares, coral�ides, etc.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P1;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,175,'2. PROPRIEDADES FISICAS DOS MINERAIS');
  EscE(70,205,'Nem  sempre  est�o disponiveis esp�cimes a partir dos quais se possa');
  EscE(70,220,'observar  a   estrutura cristalina  e identificar  um  mineral. Muitas');
  EscE(70,235,'vezes, podemos   examinar  apenas  fragmentos,  ou um  pouco de p�;');
  EscE(70,250,'devemos,  portanto,   recorrer   a   outros  dados.  O  estudo  das');
  EscE(70,265,'propriedades f�sicas  dos minerais vai trazer-nos  muitas inform��es.');
  EscE(70,280,'Pode ser  empreendido  a  baixo custo, embora, naturalmente, existam');
  EscE(70,295,'experimentos que exijam  aparelhos caros e treinamento especializado');
  EscE(70,310,'de   pesquisa. As  propriedades  f�sicas  dos  cristais  s�o de duas');
  EscE(70,325,'esp�cies:  escalares  e  vectoriais.  As  primeiras  s�o  quantidades');
  EscE(70,340,'independentes do factor direc��o; as ultimas variam conforme a direc-');
  EscE(70,355,'��o. A densidade relativa e a fusibilidade s�o propriedades escalares.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P2;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'DENSIDADE RELATIVA');
  EscE(80,205,'Trata-se de uma das mais  importantes propriedades de um mineral. �');
  EscE(80,220,'definida como a raz�o entre o seu peso e o peso de um volume igual');
  EscE(80,235,'de  �gua destilada, a 4''C. Quanto  mais  densos  os  �tomos  em uma');
  EscE(80,250,'estrutura, maior a  densidade  relativa. Ela pode ser medida com um');
  EscE(80,265,'picn�metro, uma  balan�a-de-vestf�lia ou uma  balan�a de  tors�o e');
  EscE(80,280,'l�quidos pesados.');
  EscE(80,295,'O picn�metro ou  garrafa  de  densidade  � um frasco  pequeno e de');
  EscE(80,310,'gargalo largo, com uma  tampa de  vidro  ligada � base,  e um tubo');
  EscE(80,325,'capilar  no  centro da  tampa. O mineral �  cuidadosamente  pesado,');
  EscE(80,340,'atribuindo-se  ao seu peso o valor m. Pesa-se, a seguir, a garrafa');
  EscE(80,355,'de �gua destilada; chama-se p ao valor encontrado. Coloca-se dentro');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P3;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'da  garrafa  o  mineral  caso  este  esteja  insol�vel na  �gua - e');
  EscE(80,190,'recoloca a  tampa, tomando-se cuidado para que o n�vel de �gua n�o');
  EscE(80,205,'ultrapasse o  n�vel anterior no  tubo capilar. Pesadas  em conjunto,');
  EscE(80,220,'a  garrafa e o  mineral atingem o  peso n. A  densidade pode  ent�o');
  EscE(80,235,'ser expressa pela formula: m / ((p + m) - n)');
  EscE(80,250,'A  densidade   constitui  uma  indica��o  �til   para  identifica��o,');
  EscE(80,265,'sendo  sempre  incluida  na  descri��o  do  mineral.  Para  medi-la');
  EscE(80,280,'com  uma  balan�a-de-vestf�lia,  pesa-se   inicialmente  o  esp�cime');
  EscE(80,295,'mineral   sobre  uma  plataforma,  fora  da  �gua,  com  a  balan�a');
  EscE(80,310,'equlibrada  por meio de  pesos  remov�veis. A  seguir, retira-se  o');
  EscE(80,325,'mineral da  plataforma, os  pesos conhecidos  s�o substituidos, e a');
  EscE(80,340,'balan�a �  reajustada. Temos desse  modo o peso da amostra, que  �');
  EscE(80,355,'ent�o colocada no prato da  balan�a e mergulhada na �gua. A balan�a');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P4;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'perde  o equilibrio, pois a  amostra  recebe um impulso  ascendente');
  EscE(80,190,'igual ao  peso da �gua  deslocada. Podemos  calcular esse  peso ao');
  EscE(80,205,'ajustarmos a  balan�a: a rela��o entre o resultado  obtido e o peso');
  EscE(80,220,'da  amostra antes  da imers�o  nos d�  a densidade  relativa. Se um');
  EscE(80,235,'mineral  for   sol�vel  na  �gua,  devemos  empregar  l�quidos  n�o');
  EscE(80,250,'solventes  ou  pesados em  uma balan�a  de  tors�o. Na  pr�tica, as');
  EscE(80,265,'indica��es  sobre a  densidade podem ser obtidas  pela  observa��o');
  EscE(80,280,'directa. Os  res�duos de  detritos rochosos e  outro materiais  mais');
  EscE(80,295,'leves s�o arrastados rio abaixo pela �gua corrente. De acordo com a');
  EscE(80,310,'sua densidade, os minerais recebem a seguinte classifica��o:');
  EscE(80,325,'muito  leves, com  densidade 2; leves, com  densidade  de  2  a  3;');
  EscE(80,340,'densos, com  densidade de 3 a 5; muito densos, com  densidade de 5');
  EscE(80,355,'a 10; extremamente densos, com densidade igual ou superior a 10.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P5;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'FUSIBILIDADE');
  EscE(80,205,'O ponto  fus�o dos  minerais � outra propriedade  escalar  bastante');
  EscE(80,220,'�til, mas  dificil de calcular. Podemos, entretanto  determinar se um');
  EscE(80,235,'mineral pode ou n�o ser fundido submetendo fragmentos � chama de um');
  EscE(80,250,'bico  de  Bunsen, que supera  1000''C, ou  com ma�arico de  boca  e');
  EscE(80,265,'carv�o  vegetal. Dispomos tamb�m da  escala emp�rica de  Von Kobell,');
  EscE(80,280,'que lista, sete minerais - padr�o para  prop�sitos de compara��o. A');
  EscE(80,295,'escala inclui os seguintes minerais t�picos:');
  EscE(80,325,'1. Estibinita  - fus�o a 525''C na chama de f�sforo ou vela');
  EscE(80,340,'2. Calcopirita - fus�o a 800''C na chama de g�s (bico de Bunsen)');
  EscE(80,355,'3. Almandina   - fus�o a 1050''C na chama de g�s (ma�arico)');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P6;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'4. Actinolita  - fus�o  a  1200''C  na  chama   de  ma�arico  quando');
  EscE(80,190,'                surgem crenula��es nas arestas do fragmento');
  EscE(80,205,'5. Ortoclasio  - fus�o   a  1300''C  na   chama  de   ma�arico;   as');
  EscE(80,220,'                crenula��es nas arestas n�o surgem de imediato');
  EscE(80,235,'6. Bronzita    - fus�o  a  1400''C  na   chama  de  ma�arico;  forma');
  EscE(80,250,'                crenula��es apenas se estiver em estilha�os finos');
  EscE(80,265,'7. Quartzo     - fus�o  acima   de  1400''C;  n�o   �  fundido  pela');
  EscE(80,280,'chama de ma�arico');
  EscE(80,310,'Na pr�tica, muitas  esp�cies  podem  ser  reconhecidas  por meio de');
  EscE(80,325,'testes  de  fusibilidade. A maioria das  descri��es fornece o  ponto');
  EscE(80,340,'de  fus�o ou  indica se  um mineral  pode ser  fundido e  com   que');
  EscE(80,355,'facilidade.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P7;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'As  propriedades  vetoriais,  s�o  as  de  dureza  e  clivagem, as');
  EscE(80,190,'qualidades magn�ticas e el�ctricas e o comportamento �ptico.');
  EscE(70,220,'DUREZA');
  EscE(80,250,'� definida como o grau de  resist�ncia de um cristal aos arranh�es.');
  EscE(80,265,'Testes  com uma agulha de a�o  mostrar�o o grau de  dureza de uma');
  EscE(80,280,'amostra e nos  premitir�o saber se �, por exemplo, calcita, apatita');
  EscE(80,295,'ou  quartzo. A  dureza  de  um  mineral  depende da sua coes�o, e,');
  EscE(80,310,'portanto,  de  sua  estrutura;  em  todos  os  cristais, mesmo nos');
  EscE(80,325,'pretencentes  ao  sistema  c�bico, a  dureza  varia com a direc��o');
  EscE(80,340,'estrutural. Embora  seja  dificil  calcul�-la com precis�o, a dureza');
  EscE(80,355,'pode   ser   medida   com   o   auxilio   de aparelhos denominados');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P8;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'escler�metros.');
  EscE(80,190,'No escler�metro de  Seebeck, o esp�cime �  colocado em cima de uma');
  EscE(80,205,'plataforma  m�vel  sobre a qual est�  montada uma  agulha  ligada a');
  EscE(80,220,'v�rios pesos. O grau de dureza �  evidenciado pelo peso necess�rio');
  EscE(80,235,'para  produzir  um  arranh�o minimo. A escala  empirica  de Mohs �');
  EscE(80,250,'comumente usada como padr�o  de dureza. Varia��es de dureza entre');
  EscE(80,265,'os dez minerais  referidos nessa escala s�o  irregulares, mas cada');
  EscE(80,280,'mineral produzir� arranh�es naqueles situados acima dele.');
  EscE(80,310,'ESCALA DE MOHS');
  EscE(90,340,' 1. Talco       muito mole (1-2)    pode ser arranhado pela unha');
  EscE(90,355,' 2. Gipsita');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P9;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(90,175,' 3. Calcita     mole (2-3)          pode ser arranhada por um');
  EscE(90,190,'                                  fio de ferro');
  EscE(90,205,' 4. Fluorita    semi-dura (3-4)     pode ser arranhada pela');
  EscE(90,220,'                                  l�mina de um canivete');
  EscE(90,235,' 5. Apatita     dura (5-6�)        dificilmente arranhada pela');
  EscE(90,250,'                                  l�mina de um canivete');
  EscE(90,265,' 6. Ortocl�sio');
  EscE(90,280,' 7. Quartzo');
  EscE(90,295,' 8. Topazio     muito duro (6�-10)  n�o � arranhado por uma');
  EscE(90,310,'                                  ponta de a�o');
  EscE(90,325,' 9. Cor�ndon');
  EscE(90,340,'10. Diamante');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P10;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'Se  determinado  esp�cime  consegue arranhar  um  desses  minerais');
  EscE(80,190,'padr�o   mas   n�o  o  situado  imediatamente  abaixo   na   escala');
  EscE(80,205,'considera-se que tem um grau de dureza intermediario em rela��o aos');
  EscE(80,220,'dois minerais da escala.');
  EscE(70,250,'CLIVAGEM');
  EscE(80,280,'A maioria dos  cristais - n�o  todos - t�m  a propriedade de sofrer');
  EscE(80,295,'rupturas  ao  longo  de certos planos conhecidos  como  planos  de');
  EscE(80,310,'clivagem.');
  EscE(80,325,'A calcita  tem boa clivagem; as piritas, a magnetita e o quartzo n�o');
  EscE(80,340,'se clivam. A clivagem est� estritamente  relacionada com a estrutura');
  EscE(80,355,'cristalina. Ocorre entre a planos cujas  dist�ncias  de  liga��o s�o');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P11;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'grandes  e, portanto  fracas. Os  planos de  clivagem  s�o  sempre');
  EscE(80,190,'paralelos  a uma  face efectiva  ou poss�vel - do  cristal. Por meio');
  EscE(80,205,'da  clivagem,  cristais  mal  formados  podem  recuperar  uma forma');
  EscE(80,220,'perfeita. Este processo chama-se lapida��o. Muitos  cristais  sofrem');
  EscE(80,235,'fraturas ao longo de um ou mais planos; o �ngulo entre os planos de');
  EscE(80,250,'clivagem pode ajudar a identificar o cristal.');
  EscE(70,280,'ELECTRICIDADE');
  EscE(80,310,'Os metais em estado puro, os sulfetos e os oxidos s�o condutores de');
  EscE(80,325,'electricidade. No  entanto,  a  maioria  dos  minerais  � dieletrica,');
  EscE(80,340,'isto �, n�o condutora de electricidade.');
  EscE(80,355,'Alguns minerais dieletricos com eixos polares (eixos cujos  extremos');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P12;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'s�o  dessemelhantes)  poder�o adquirir,  sob press�o,  uma  carga');
  EscE(80,190,'el�ctrica, positiva  em  uma das extremidades  e  negativa na outra.');
  EscE(80,205,'Este  fen�meno � conhecido  como piezelectricidade. Se  for aplicada');
  EscE(80,220,'tens�o ao longo do eixo polar, a carga � invertida. Sendo altamente');
  EscE(80,235,'piezelectrico, o quartzo � usado na  fabrica��o de relogios digitais');
  EscE(80,250,'e de  v�rios  aparelhos  de  precis�o: osciladores,  geradores  de');
  EscE(80,265,'impulso etc. Certos  cristais  produzem  cargas el�tricas em algumas');
  EscE(80,280,'das suas superf�cies quando submetidos a  varia��es de temperatura.');
  EscE(80,295,'O fen�meno  �  conhecido como  piroelectricidade. A  turmalina  � um');
  EscE(80,310,'t�pico  mineral  piroel�ctrico. As  cargas  podem  ser  identificadas');
  EscE(80,325,'por meio de um el�ctr�metro - ou  melhor ainda, soprando-se chumbo');
  EscE(80,340,'vermelho e  enxofre  em  p�  atrav�s  de  um peda�o de seda, para');
  EscE(80,355,'carregar as  part�culas  com electricidade  est�tica. Tendo recebido');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P13;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'uma  carga  positiva, o chumbo vermelho  deposita-se  na por��o do');
  EscE(80,190,'mineral carregada de electricidade negativa. O enxofre, que recebeu');
  EscE(80,205,'uma  carga  negativa, deposita-se na por��o do  mineral  com carga');
  EscE(80,220,'positiva.');
  EscE(70,250,'MAGNETISMO');
  EscE(80,280,'Os   minerais   reagem   �   a��o   de   um  magneto. Denominam-se');
  EscE(80,295,'ferromagn�ticos os minerais com  uma  reac��o forte. Os de resposta');
  EscE(80,310,'mais   fraca,   atra�dos   apenas   por   imans   poderosos,   s�o');
  EscE(80,325,'paramagn�ticos; os diamagn�ticos s�o repelidos pelo campo magn�rico.');
  EscE(80,340,'A   magnetita  �  ferromagn�tica.  A  hematita   e  a  siderita  s�o');
  EscE(80,355,'paramagn�ticos,  enquanto  o  enxofre,  o  quartzo  e  outros  s�o');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P14;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'diamagn�ticos. As  propriedades  inatas  da  magnetita fazem dela um');
  EscE(80,190,'magneto natural de longa dura��o. Nos chamados esp�cimes polares, o');
  EscE(80,205,'magnetismo  nas  extermidades �  diferente. Quando o  magnetismo tem');
  EscE(80,220,'cargas  id�nticas  nas duas  extermidades, o  esp�cime  denomina-se');
  EscE(80,235,'bipolar.');
  EscE(80,265,'PROPRIEDADES OPTICAS');
  EscE(80,295,'Ao atingir  um  objecto, a luz incidente �  parcialmente  refletida e');
  EscE(80,310,'parcialmente   absorvida  por  ele. Por esse  motivo  o  brilho dos');
  EscE(80,325,'cristais varia  conforme a  intensidade do reflexo. A classifica��o a');
  EscE(80,340,'seguir, baseada  nas  gradua��es de brilho, � util na  identifica��o');
  EscE(80,355,'dos minerais.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P15;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'adamantino    - muito brilhante (o brilho do diamante)');
  EscE(80,190,'subadamantino - um pouco menos brilhante (linarita)');
  EscE(80,205,'v�treo        - brilho semelhante ao do vidro (quartzo)');
  EscE(80,220,'met�lico      - brilho dos metais, inteiramente opaco � luz');
  EscE(80,235,'submet�lico   - minerais com este brilho s�o opacos, mas');
  EscE(80,250,'               transparentes na sec��o delgada de');
  EscE(80,265,'               microsc�pio (cin�brio)');
  EscE(80,280,'nacarado     - levemente iridescente, como a p�rola (micas)');
  EscE(80,295,'sedoso       - qualidade t�pica dos minerais fibrosos (asbesto)');
  EscE(80,310,'resinoso     - faiscantes e tendentes ao amarelo (enxofre)');
  EscE(80,325,'gorduroso    - de um brilho s�btil (talco maci�o e nefelina)');
  EscE(80,340,'fosco        - refletem muito pouco brilho (quiolita) s�o');
  EscE(80,355,'               quase invis�veis na �gua.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P16;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'COR');
  EscE(80,205,'Trata-se   de   uma   indica��o  �til  apenas   para   os  minerais');
  EscE(80,220,'idiocrom�ticos  de cor  invari�vel. A maioria  dos  minerais, por�m,');
  EscE(80,235,'� alocrom�tica. Isto significa que sua  cor varia de  acordo  com os');
  EscE(80,250,'�tomos presentes no ret�culo  cristalino. Os minerais idiocrom�ticos,');
  EscE(80,265,'tais como o  enxofre, cuprita, malaquita  e  cin�brio conservam sua');
  EscE(80,280,'colora��o (esmaecida) quando reduzidos a p�. Os  minerais alocrom�-');
  EscE(80,295,'ticos sob a forma de p� em geral t�m cor cinzenta ou esbranqui�ada.');
  EscE(70,325,'LUMINESCENCIA');
  EscE(80,355,'Quando energizados por meios  mec�nicos ou qu�micos, ou pelo calor,');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P17;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'alguns  minerais  emitem  ondas  e  assumem  diferentes cores - � o');
  EscE(80,190,'fen�meno  de  luminesc�ncia.  A  fosforesc�ncia  ocorrre  quando  a');
  EscE(80,205,'emiss�o   continua   ap�s  a  retirada   da  energia  excitante;  a');
  EscE(80,220,'fluoresc�ncia  ocorre  quando a emiss�o cessa  com  a retirada  do');
  EscE(80,235,'est�mulo. A  espetacular  fluoresc�ncia  conhecida  como  efeito  de');
  EscE(80,250,'Wood � o  resultado de  radia��es de ondas  curtas sobre  minerais');
  EscE(80,265,'radioactivos.  A  fluoresc�ncia  pode  ser  induzida  por  meio  de');
  EscE(80,280,'l�mpadas ultravioletas port�teis. � importante na procura de minerais');
  EscE(80,295,'radioactivos  para  utiliza��o  industrial. A autunita, a scheelita e');
  EscE(80,310,'outros  minerais  apresentam  fluoresc�ncia sempre. Outros - como a');
  EscE(80,325,'escapolita, a  calcita  e  a  fluorita - s�o fluorescentes s� quando');
  EscE(80,340,'apresentam imperfei��es estruturais.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R2P18;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'RADIOACTIVIDADE');
  EscE(80,205,'Muitos  minerais  cont�m  elementos  radioactivos - entre  os  quais');
  EscE(80,220,'o  ur�nio, o  t�rio  e  o  r�dio - que  se  encontram  num  estado');
  EscE(80,235,'cont�nuo  de  transmuta��o,  emitindo  particulas  alfa  e   beta  e');
  EscE(80,250,'raios  gama.  Estes  fen�menos  afectar�o  uma   placa  fotogr�fica');
  EscE(80,265,'e  ser�o  registrados  num  contador  Geiger.  Autunita,  turbenita,');
  EscE(80,280,'carnotita,  betafita   e   uraninita   s�o   exemplos   de  minerais');
  EscE(80,295,'radioactivos.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P1;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,175,'3. TESTES QUIMICOS');
  EscE(70,205,'A analise qu�mica  qualitativa e quantitativa das esp�cies pode exigir');
  EscE(70,220,'tempo e esforco consider�veis. Todavia, experi�ncias  mais r�pidas e');
  EscE(70,235,'valiosas  tornam-se  poss�veis com o aux�lio da alguns  reagentes  e');
  EscE(70,250,'itens pouco  dispendiosos de equipamento. Tudo o que precisamos � de');
  EscE(70,265,'alguns tubos de ensaio, um pequeno  gancho de fio de platina com uma');
  EscE(70,280,'al�a, um ma�arico, um bico de  Bunsen, uma  esp�tula, um canivete e');
  EscE(70,295,'um almofariz de �gata.');
  EscE(70,310,'Os compostos qu�micos necess�rios incluem o �cido clor�drico, n�trico,');
  EscE(70,325,'carbonato   de  s�dio,  nitrato  de  cobalto,  idodeto  de  pot�ssio,');
  EscE(70,340,'per�xido de hidrog�nio, enxofre, di�xido de chumbo, cloreto de b�rio');
  EscE(70,355,'e amon�aco.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P2;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'Para come�ar, podemos colocar um pouco de  mineral em p� em um tubo');
  EscE(70,190,'de  ensaio com  algumas gotas  de �cido  clor�drico. A efervesc�ncia');
  EscE(70,205,'imediata  vai dizer-nos  que  mineral �  um  carbonato. Se o p�  n�o');
  EscE(70,220,'mostrar efervesc�ncia poderemos aquece-lo, pois alguns minerais, por');
  EscE(70,235,'exemplo a dolomita, s� fervem quando aquecidos.');
  EscE(70,250,'Para testar o ouro em  estado puro, um s�lex  negro e esfregado com');
  EscE(70,265,'um peda�o de ouro, e em  seguida com o esp�cime sob  exame. Depois,');
  EscE(70,280,'algumas  gotas  de  �cido  n�trico  s�o  pingadas  nos  tra�os assim');
  EscE(70,295,'formados. O ouro  n�o � afectado pelo  �cido n�trico: assim, as  duas');
  EscE(70,310,'pe�as s�o de ouro  se todas as marcas permanecerem vis�veis. Se  os');
  EscE(70,325,'tra�os deixados pelo esp�cime forem destru�dos, ele n�o � de ouro.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P3;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICA�AO DOS SULFETOS');
  EscE(80,205,'Os dados  f�sicos s�o  �teis neste  ponto: os sulfetos  s�o  moles e');
  EscE(80,220,'opacos, com brilho met�lico e alta densidade. Queimam em contato com');
  EscE(80,235,'o ar  produzindo di�xido  de enxofre (SO2), de odor  caracter�stico.');
  EscE(80,250,'Quando  aquecidos  num   tubo  fechado,  flores   de  enxofre  s�o');
  EscE(80,265,'cristalizadas em  suas paredes. S�o sol�veis no �cido: a  adi��o do');
  EscE(80,280,'�cido clor�drico resulta no �cido  sulf�drico (H2S), g�s t�xico e de');
  EscE(80,295,'cheiro desagrad�vel.');
  EscE(70,325,'IDENTIFICA�AO DOS HALETOS');
  EscE(80,355,'Se forem  cloretos sol�veis  em  �gua,  uma solu��o  de n�trato  de');
end;


{ P�gina do Ecr� Como reconhecer }
procedure R3P4;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'prata (AgNO3),  produzir�  um  precipitado  branco  de  cloreto  de');
  EscE(80,190,'prata, (AgCI).');
  EscE(80,205,'Se  forem  insol�veis  em  �gua,  os  testes  s�o feitos com  �cido');
  EscE(80,220,'n�trico (HNO3), e n�trato de prata (AgNO3). Flocos brancos de cloreto');
  EscE(80,235,'de prata (AgCI) s�o formados com o aquecimento.');
  EscE(80,250,'Para testar  fluoretos, adicione �cido sulf�rico (H2SO4) a  um pouco');
  EscE(80,265,'do mineral  em po. Com um ligeiro aquecimento, s�o emitidos  vapores');
  EscE(80,280,'brancos de  �cido  flur�drico (HF), que  corroem  o tubo  de  vidro.');
  EscE(80,295,'Deve-se tomar cuidado, esses vapores s�o muito corrosivos.');
  EscE(80,310,'O  teste  para  os  iodetos  consiste  em  adicionar  bissulfato  de');
  EscE(80,325,'pot�ssio (KHSO4) ao  mineral em  p�, que  ent�o liberar�  vapor  de');
  EscE(80,340,'iodo de colora��o viol�cea.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P5;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICA�AO DOS CARBONATOS');
  EscE(80,205,'A adi��o  de �cidos  a quente ou  a frio,  resulta na  produ��o de');
  EscE(80,220,'di�xido  de  carbono (CO2).  Se  forem  submetidos  a  temperaturas');
  EscE(80,235,'elevadas, os  carbonatos  se calcificar�o,  produzindo CO2 e  seus');
  EscE(80,250,'�xidos  respectivos. Embora  quimicamente  id�nticas, a  calcita e a');
  EscE(80,265,'aragonita  se  cristalizam   de  maneira  diversa.  Se  este  h�bito');
  EscE(80,280,'diferente  n�o  for  identificado  porque  ambas  as  amostras  s�o');
  EscE(80,295,'microcristalinas  (isto   �,  com   cristais  vis�veis   apenas   ao');
  EscE(80,310,'microsc�pio), os dois minerais podem ser distinguidos por interm�dio');
  EscE(80,325,'do teste  de Meigen. Para  este  teste, uma  solu��o  de nitrato de');
  EscE(80,340,'cobalto (CO(NO3)2) �  acrescentada  ao  mineral  em  p�  no tubo de');
  EscE(80,355,'ensaio � mantida por alguns segundos em ponto de ebuli��o. O  p� de');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P6;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'aragonita  assumira  uma  colora��o  violeta,  enquanto  a  calcita');
  EscE(80,190,'permanecera branca.');
  EscE(70,220,'IDENTIFICA�AO DE BORATOS');
  EscE(80,250,'Reduzidos a p� e em contato com o �cido sulf�rico, apresentam chama');
  EscE(80,265,'de cor verde no ma�arico.');
  EscE(70,295,'IDENTIFICA�AO DE SULFATOS');
  EscE(80,325,'Se  forem sol�veis em  �gua ou em  �cido clor�drico, produzir�o  um');
  EscE(80,340,'precipitado branco, o sulfato de b�rio (BaSO4), quando adicionado a');
  EscE(80,355,'uma solu��o de cloreto de b�rio (BaCl2).');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P7;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'A reac��o  h�par, tamb�m usada  para os sulfatos, �  aplic�vel aos');
  EscE(80,190,'sulfatos  insol�veis. O mineral em  p� �  misturado a carbonato  de');
  EscE(80,205,'s�dio (Na2Co3), e aquecido  ao  ma�arico sobre  o carv�o  vegetal.');
  EscE(80,220,'Colocado sobre uma superf�cie de prata e lavado na �gua, o res�duo');
  EscE(80,235,'produzir�  �cido sulf�drico (H2S), que  provoca o  enegrecimento da');
  EscE(80,250,'prata. Este res�duo tamb�m cont�m sulfeto de s�dio (Na2S).');
  EscE(70,280,'IDENTIFICA�AO DOS FOSFATOS');
  EscE(80,310,'Eles fundem-se ao serem submetidos � chama de um ma�arico, tingindo');
  EscE(80,325,'de verde a chama. S�o sol�veis em �cido n�trico (HNO3); se molibdato');
  EscE(80,340,'de am�nia for adicionado � solu��o, o resultado � o  fosfomolibdato,');
  EscE(80,355,'um precipitado amarelo de am�nia.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P8;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICA�AO DOS ARSENIATOS');
  EscE(80,205,'Eles fundem-se ao serem submetidos � chama de um ma�arico. O vapor');
  EscE(80,220,'produzido  tem  um  cheiro de  ars�nio  e as  chamas  assumem uma');
  EscE(80,235,'tonalidade azulada.');
  EscE(80,250,'Para distinguir entre fosfatos e arseniatos, acrescentamos  acetato');
  EscE(80,265,'de magn�sio (Mg(CH3COO)2) �  solu��o  amoniacal  do  mineral, e  a');
  EscE(80,280,'seguir   filtramos  o  precipitado   e  acrescentamos  nitrato   de');
  EscE(80,295,'prata (AgNO3). Um fosfato tornar-se-� amarelo, um arseniato  ficar�');
  EscE(80,310,'de um tom castanho-avermelhado.');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P9;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICA�AO DOS VANADIATOS');
  EscE(80,205,'Dissolvem-se no �cido n�trico dilu�do (HNO3). Ao evaporar sobre  uma');
  EscE(80,220,'l�mina de metal, a solu��o deixa um dep�sito vermelho de  pent�xido');
  EscE(80,235,'de divan�dio (V2O5). Se for acrescentado per�xido de hidrog�nio,  a');
  EscE(80,250,'solu��o torna-se castanho-avermelhada.');
  EscE(70,280,'TESTES DE CHAMA');
  EscE(80,310,'R�pidos e �teis, estes testes  indicam que elementos est�o presentes');
  EscE(80,325,'em determinado mineral. Os atomos excitados pelo calor de uma chama');
  EscE(80,340,'cont�m  eletr�es  em  movimento  nas  suas  orbitas  exteriores. Ao');
  EscE(80,355,'retrocederem  para orbitas mais internas, esses eletr�es emitem, em');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P10;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'forma  de  luz,  a   energia  absorvida.  Para  fazer  nosso  teste');
  EscE(80,190,'mergulhamos  um fio  de platina em �cido clor�drico,  colocamos  uma');
  EscE(80,205,'pitada de mineral em p� sobre o fio e o submetemos � chama:');
  EscE(80,235,'O S�dio produz uma intensa chama amarela');
  EscE(80,250,'O c�lcio produz uma chama vermelho-alaranjada');
  EscE(80,265,'O cobre produz uma chama verde-brilhante');
  EscE(80,280,'O b�rio produz uma firme chama verde-amarelada');
  EscE(80,295,'O estr�ncio produz uma chama vermelha-brilhante');
  EscE(80,310,'O l�tio produz uma chama vermelha-escarlate');
  EscE(80,325,'O pot�ssio produz uma chama violeta');
  EscE(80,355,'Por exemplo, um fragmento de  calcopirita pode ser  distinguido  das');
end;

{ P�gina do Ecr� Como reconhecer }
procedure R3P11;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'piritas pelo tom  verde-acobreado de chama  produzida em um r�pido');
  EscE(80,190,'teste deste g�nero.');
end;

end.