{ Auxiliar nß 2 do auxiliar 2 do MinÇrius }
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

{ P†gina do EcrÑ Como reconhecer }
procedure R1P1;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,175,'1. ESTRUTURA GEOMETRICA');
  EscE(70,205,'CRISTALOGRAFIA BASICA');
  EscE(80,235,'Os cristais sÑo minerais com superf°cie original poliÇdrica, a  qual');
  EscE(80,250,'resulta do  arranjo  regular das  molÇculas formadoras do ret°culo');
  EscE(80,265,'cristalino.');
  EscE(80,280,'A forma geomÇtrica dos cristais, est† definida em tràs grupos:');
  EscE(80,310,'1. ISOMETRICOS - Compostos  exclusivamente  pelo  sistema  hom¢nimo,');
  EscE(100,325,'tambÇm denominado c£bico, com uma face fundamental que determina');
  EscE(100,340,'tràs parÉmetros iguais nos eixos cristalogr†ficos.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R1P2;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'2. DIMETRICOS - Formados   pelo   sistema   hexagonal,  trigonal  e');
  EscE(100,190,'tetragonal,  onde  a  face  fundamental   produz   dois  valores');
  EscE(100,205,'diferentes nos eixos cristalogr†ficos: valores  iguais nos  eixos');
  EscE(100,220,'do mesmo plano.');
  EscE(80,250,'3. TRIMETRICOS - Formados  pelo sistema  ortorrìmbico,  monocl°nico');
  EscE(100,265,'e tricl°nico, nos  quais a  face fundamental produz  tràs valores');
  EscE(100,280,'diferentes nos eixos cristalogr†ficos.');
  EscE(80,310,'Textos especializados explicam detalhadamente a cristalografia, pois');
  EscE(80,325,'um bom  conhecimento  desse  ramo cient°fico Ç  essencial  para  se');
  EscE(80,340,'reconhecer  os   minerais.  Por   exemplo,  um  epidoto  pode  ser');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R1P3;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'diferenciado com facilidade de uma vesuvianita, pois esta tem um');
  EscE(80,190,'h†bito tetragonal, enquanto o epidoto tem um h†bito monoclinico.');
  EscE(80,220,'Consulte o Quadro dos Sistemas Cristalinos (F10).');
  EscE(70,250,'RETICULO CRISTALINO');
  EscE(80,280,'No  estado  s¢lido,  um cristal  Ç  um  arranjo  tridimensional  de');
  EscE(80,295,'part°culas,  segundo  um   padrÑo  definido  de   repetiáÑo.  Essas');
  EscE(80,310,'part°culas  (†tomos,  moleculas  e  iîes)  ocupam  os  vÇrtices  de');
  EscE(80,325,'min£sculos  paralelep°pedos que, justapostos em  fileiras e colunas,');
  EscE(80,340,'formam o chamado reticulo espacial.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R1P4;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'As part°culas nos vÇrtices dos  paralelep°pedos ou  celas unit†rias');
  EscE(80,190,'sÑo os n¢s, pontos  de  entrelaáamento da  estrutura. Uma sÇrie de');
  EscE(80,205,'n¢s  dispostos  na  mesma  direcáÑo, forma  uma  fileira  e v†rias');
  EscE(80,220,'fileiras  na   mesma  direcáÑo,   definem  um   plano   recticular.');
  EscE(70,250,'POLIMORFISMO');
  EscE(80,280,'ê  a  propriedade  segundo  a  qual  um  composto  qu°mico   pode');
  EscE(80,295,'cristalizar-se  em   diferentes   ret°culos   espaciais.  O  sistema');
  EscE(80,310,'ou  classe  do   ret°culo  muda,  enquanto   o  mineral  permanece');
  EscE(80,325,'quimicamente   inalterado.   O   polimorfismo   resulta   de  certas');
  EscE(80,340,'condiáîes de temperatura e pressÑo que ocorrem durante a formaáÑo');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R1P5;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'formaáÑo do mineral.');
  EscE(80,190,'Quartzo ‡ e ·, tridimita e cristobalita sÑo derivaáîes polimorfas do');
  EscE(80,205,'di¢xido de sil°cio.');
  EscE(80,220,'Exemplos  t°picos de  dimorfismo sÑo  as piritas (celas  elementares');
  EscE(80,235,'c£bicas) e marcassitas (ortorrìmbicas); diamantes (c£bicas) e grafi-');
  EscE(80,250,'tas (hexagfonais); calcitas (trigonais) e aragonitas (ortorrìmbicas).');
  EscE(70,280,'ISOMORFISMO');
  EscE(80,310,'ê  a  propriedade  segundo  a  qual  minerais  com  diferenáas  de');
  EscE(80,325,'composiáÑo  qu°mica cristalizam em formas idànticas: os vÇrtices dos');
  EscE(80,340,'ret°culos  conservam o  mesmo padrÑo  mas sÑo ocupados por †tomos');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R1P6;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'nÑo semelhantes. Muitas espÇcies minerais de composiáÑo an†loga sÑo');
  EscE(80,190,'isomorfas, possu°ndo  †tomos ou  iîes com aproximadamente o  mesmo');
  EscE(80,205,'raio. A substituiáÑo isom¢rfica pode ocorrer em qualquer escala,');
  EscE(80,220,'embora por vezes, seja limitada.');
  EscE(80,235,'Os   carbonatos  trigonais   oferecem  um  exemplo  de  uma  sÇrie');
  EscE(80,250,'isom¢rfica: calcita (CaCO3), rodocrosita (MnCO3), siderita (FeCO3).');
  EscE(80,265,'O isomorfismo Ç muito frequente na natureza, enqanto as  estruturas');
  EscE(80,280,'cristalinas £nicas sÑo excepcionais.');
  EscE(70,310,'AGREGADOS CRISTALINOS');
  EscE(80,340,'Em estado  natural, os  cristais aparecem  mais frequentemente  em');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R1P7;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'grupos do que isolados. Os agregados cristalinos  que se erguem de');
  EscE(80,190,'uma base  plana, sÑo  denominados  drusas;  os que  crescem  numa');
  EscE(80,205,'superf°cie  cìncava sÑo os geodos. Onde houver  iso-orientaáÑo, os');
  EscE(80,220,'cristais formarÑo agrupamentos paralelos.');
  EscE(80,235,'Outro fen¢meno  importante, Ç a geminaáÑo: ela ocorre  quando dois');
  EscE(80,250,'ou mais  cristais desenvolvem-se  conforme leis de  geminaáÑo  bem');
  EscE(80,265,'definidas. Neste caso, os cristais assumem formatos  caracter°sticos');
  EscE(80,280,'e j† classificados - radiais,  fibrosos,  laminados,  e  assim  por');
  EscE(80,295,'diante. TambÇm foram  classificadas  in£meras formas: estalagm°ticas,');
  EscE(80,310,'mamelares, coral¢ides, etc.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P1;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,175,'2. PROPRIEDADES FISICAS DOS MINERAIS');
  EscE(70,205,'Nem  sempre  estÑo disponiveis espÇcimes a partir dos quais se possa');
  EscE(70,220,'observar  a   estrutura cristalina  e identificar  um  mineral. Muitas');
  EscE(70,235,'vezes, podemos   examinar  apenas  fragmentos,  ou um  pouco de p¢;');
  EscE(70,250,'devemos,  portanto,   recorrer   a   outros  dados.  O  estudo  das');
  EscE(70,265,'propriedades f°sicas  dos minerais vai trazer-nos  muitas informáîes.');
  EscE(70,280,'Pode ser  empreendido  a  baixo custo, embora, naturalmente, existam');
  EscE(70,295,'experimentos que exijam  aparelhos caros e treinamento especializado');
  EscE(70,310,'de   pesquisa. As  propriedades  f°sicas  dos  cristais  sÑo de duas');
  EscE(70,325,'espÇcies:  escalares  e  vectoriais.  As  primeiras  sÑo  quantidades');
  EscE(70,340,'independentes do factor direcáÑo; as ultimas variam conforme a direc-');
  EscE(70,355,'áÑo. A densidade relativa e a fusibilidade sÑo propriedades escalares.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P2;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'DENSIDADE RELATIVA');
  EscE(80,205,'Trata-se de uma das mais  importantes propriedades de um mineral. ê');
  EscE(80,220,'definida como a razÑo entre o seu peso e o peso de um volume igual');
  EscE(80,235,'de  †gua destilada, a 4''C. Quanto  mais  densos  os  †tomos  em uma');
  EscE(80,250,'estrutura, maior a  densidade  relativa. Ela pode ser medida com um');
  EscE(80,265,'picnìmetro, uma  balanáa-de-vestf†lia ou uma  balanáa de  torsÑo e');
  EscE(80,280,'l°quidos pesados.');
  EscE(80,295,'O picn¢metro ou  garrafa  de  densidade  Ç um frasco  pequeno e de');
  EscE(80,310,'gargalo largo, com uma  tampa de  vidro  ligada Ö base,  e um tubo');
  EscE(80,325,'capilar  no  centro da  tampa. O mineral Ç  cuidadosamente  pesado,');
  EscE(80,340,'atribuindo-se  ao seu peso o valor m. Pesa-se, a seguir, a garrafa');
  EscE(80,355,'de †gua destilada; chama-se p ao valor encontrado. Coloca-se dentro');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P3;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'da  garrafa  o  mineral  caso  este  esteja  insol£vel na  †gua - e');
  EscE(80,190,'recoloca a  tampa, tomando-se cuidado para que o n°vel de †gua nÑo');
  EscE(80,205,'ultrapasse o  n°vel anterior no  tubo capilar. Pesadas  em conjunto,');
  EscE(80,220,'a  garrafa e o  mineral atingem o  peso n. A  densidade pode  entÑo');
  EscE(80,235,'ser expressa pela formula: m / ((p + m) - n)');
  EscE(80,250,'A  densidade   constitui  uma  indicaáÑo  £til   para  identificaáÑo,');
  EscE(80,265,'sendo  sempre  incluida  na  descriáÑo  do  mineral.  Para  medi-la');
  EscE(80,280,'com  uma  balanáa-de-vestf†lia,  pesa-se   inicialmente  o  espÇcime');
  EscE(80,295,'mineral   sobre  uma  plataforma,  fora  da  †gua,  com  a  balanáa');
  EscE(80,310,'equlibrada  por meio de  pesos  remov°veis. A  seguir, retira-se  o');
  EscE(80,325,'mineral da  plataforma, os  pesos conhecidos  sÑo substituidos, e a');
  EscE(80,340,'balanáa Ç  reajustada. Temos desse  modo o peso da amostra, que  Ç');
  EscE(80,355,'entÑo colocada no prato da  balanáa e mergulhada na †gua. A balanáa');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P4;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'perde  o equilibrio, pois a  amostra  recebe um impulso  ascendente');
  EscE(80,190,'igual ao  peso da †gua  deslocada. Podemos  calcular esse  peso ao');
  EscE(80,205,'ajustarmos a  balanáa: a relaáÑo entre o resultado  obtido e o peso');
  EscE(80,220,'da  amostra antes  da imersÑo  nos d†  a densidade  relativa. Se um');
  EscE(80,235,'mineral  for   sol£vel  na  †gua,  devemos  empregar  l°quidos  nÑo');
  EscE(80,250,'solventes  ou  pesados em  uma balanáa  de  torsÑo. Na  pr†tica, as');
  EscE(80,265,'indicaáîes  sobre a  densidade podem ser obtidas  pela  observaáÑo');
  EscE(80,280,'directa. Os  res°duos de  detritos rochosos e  outro materiais  mais');
  EscE(80,295,'leves sÑo arrastados rio abaixo pela †gua corrente. De acordo com a');
  EscE(80,310,'sua densidade, os minerais recebem a seguinte classificaáÑo:');
  EscE(80,325,'muito  leves, com  densidade 2; leves, com  densidade  de  2  a  3;');
  EscE(80,340,'densos, com  densidade de 3 a 5; muito densos, com  densidade de 5');
  EscE(80,355,'a 10; extremamente densos, com densidade igual ou superior a 10.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P5;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'FUSIBILIDADE');
  EscE(80,205,'O ponto  fusÑo dos  minerais Ç outra propriedade  escalar  bastante');
  EscE(80,220,'£til, mas  dificil de calcular. Podemos, entretanto  determinar se um');
  EscE(80,235,'mineral pode ou nÑo ser fundido submetendo fragmentos † chama de um');
  EscE(80,250,'bico  de  Bunsen, que supera  1000''C, ou  com maáarico de  boca  e');
  EscE(80,265,'carvÑo  vegetal. Dispomos tambÇm da  escala emp°rica de  Von Kobell,');
  EscE(80,280,'que lista, sete minerais - padrÑo para  prop¢sitos de comparaáÑo. A');
  EscE(80,295,'escala inclui os seguintes minerais t°picos:');
  EscE(80,325,'1. Estibinita  - fusÑo a 525''C na chama de f¢sforo ou vela');
  EscE(80,340,'2. Calcopirita - fusÑo a 800''C na chama de g†s (bico de Bunsen)');
  EscE(80,355,'3. Almandina   - fusÑo a 1050''C na chama de g†s (maáarico)');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P6;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'4. Actinolita  - fusÑo  a  1200''C  na  chama   de  maáarico  quando');
  EscE(80,190,'                surgem crenulaáîes nas arestas do fragmento');
  EscE(80,205,'5. Ortoclasio  - fusÑo   a  1300''C  na   chama  de   maáarico;   as');
  EscE(80,220,'                crenulaáîes nas arestas nÑo surgem de imediato');
  EscE(80,235,'6. Bronzita    - fusÑo  a  1400''C  na   chama  de  maáarico;  forma');
  EscE(80,250,'                crenulaáîes apenas se estiver em estilhaáos finos');
  EscE(80,265,'7. Quartzo     - fusÑo  acima   de  1400''C;  nÑo   Ç  fundido  pela');
  EscE(80,280,'chama de maáarico');
  EscE(80,310,'Na pr†tica, muitas  espÇcies  podem  ser  reconhecidas  por meio de');
  EscE(80,325,'testes  de  fusibilidade. A maioria das  descriáîes fornece o  ponto');
  EscE(80,340,'de  fusÑo ou  indica se  um mineral  pode ser  fundido e  com   que');
  EscE(80,355,'facilidade.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P7;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'As  propriedades  vetoriais,  sÑo  as  de  dureza  e  clivagem, as');
  EscE(80,190,'qualidades magnÇticas e elÇctricas e o comportamento ¢ptico.');
  EscE(70,220,'DUREZA');
  EscE(80,250,'ê definida como o grau de  resistància de um cristal aos arranhîes.');
  EscE(80,265,'Testes  com uma agulha de aáo  mostrarÑo o grau de  dureza de uma');
  EscE(80,280,'amostra e nos  premitirÑo saber se Ç, por exemplo, calcita, apatita');
  EscE(80,295,'ou  quartzo. A  dureza  de  um  mineral  depende da sua coesÑo, e,');
  EscE(80,310,'portanto,  de  sua  estrutura;  em  todos  os  cristais, mesmo nos');
  EscE(80,325,'pretencentes  ao  sistema  c£bico, a  dureza  varia com a direcáÑo');
  EscE(80,340,'estrutural. Embora  seja  dificil  calcul†-la com precisÑo, a dureza');
  EscE(80,355,'pode   ser   medida   com   o   auxilio   de aparelhos denominados');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P8;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'escler¢metros.');
  EscE(80,190,'No escler¢metro de  Seebeck, o espÇcime Ç  colocado em cima de uma');
  EscE(80,205,'plataforma  m¢vel  sobre a qual est†  montada uma  agulha  ligada a');
  EscE(80,220,'v†rios pesos. O grau de dureza Ç  evidenciado pelo peso necess†rio');
  EscE(80,235,'para  produzir  um  arranhÑo minimo. A escala  empirica  de Mohs Ç');
  EscE(80,250,'comumente usada como padrÑo  de dureza. Variaáîes de dureza entre');
  EscE(80,265,'os dez minerais  referidos nessa escala sÑo  irregulares, mas cada');
  EscE(80,280,'mineral produzir† arranhîes naqueles situados acima dele.');
  EscE(80,310,'ESCALA DE MOHS');
  EscE(90,340,' 1. Talco       muito mole (1-2)    pode ser arranhado pela unha');
  EscE(90,355,' 2. Gipsita');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P9;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(90,175,' 3. Calcita     mole (2-3)          pode ser arranhada por um');
  EscE(90,190,'                                  fio de ferro');
  EscE(90,205,' 4. Fluorita    semi-dura (3-4)     pode ser arranhada pela');
  EscE(90,220,'                                  lÉmina de um canivete');
  EscE(90,235,' 5. Apatita     dura (5-6´)        dificilmente arranhada pela');
  EscE(90,250,'                                  lÉmina de um canivete');
  EscE(90,265,' 6. Ortocl†sio');
  EscE(90,280,' 7. Quartzo');
  EscE(90,295,' 8. Topazio     muito duro (6´-10)  nÑo Ç arranhado por uma');
  EscE(90,310,'                                  ponta de aáo');
  EscE(90,325,' 9. Cor°ndon');
  EscE(90,340,'10. Diamante');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P10;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'Se  determinado  espÇcime  consegue arranhar  um  desses  minerais');
  EscE(80,190,'padrÑo   mas   nÑo  o  situado  imediatamente  abaixo   na   escala');
  EscE(80,205,'considera-se que tem um grau de dureza intermediario em relaáÑo aos');
  EscE(80,220,'dois minerais da escala.');
  EscE(70,250,'CLIVAGEM');
  EscE(80,280,'A maioria dos  cristais - nÑo  todos - tàm  a propriedade de sofrer');
  EscE(80,295,'rupturas  ao  longo  de certos planos conhecidos  como  planos  de');
  EscE(80,310,'clivagem.');
  EscE(80,325,'A calcita  tem boa clivagem; as piritas, a magnetita e o quartzo nÑo');
  EscE(80,340,'se clivam. A clivagem est† estritamente  relacionada com a estrutura');
  EscE(80,355,'cristalina. Ocorre entre a planos cujas  distÉncias  de  ligaáÑo sÑo');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P11;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'grandes  e, portanto  fracas. Os  planos de  clivagem  sÑo  sempre');
  EscE(80,190,'paralelos  a uma  face efectiva  ou poss°vel - do  cristal. Por meio');
  EscE(80,205,'da  clivagem,  cristais  mal  formados  podem  recuperar  uma forma');
  EscE(80,220,'perfeita. Este processo chama-se lapidaáÑo. Muitos  cristais  sofrem');
  EscE(80,235,'fraturas ao longo de um ou mais planos; o Éngulo entre os planos de');
  EscE(80,250,'clivagem pode ajudar a identificar o cristal.');
  EscE(70,280,'ELECTRICIDADE');
  EscE(80,310,'Os metais em estado puro, os sulfetos e os oxidos sÑo condutores de');
  EscE(80,325,'electricidade. No  entanto,  a  maioria  dos  minerais  Ç dieletrica,');
  EscE(80,340,'isto Ç, nÑo condutora de electricidade.');
  EscE(80,355,'Alguns minerais dieletricos com eixos polares (eixos cujos  extremos');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P12;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'sÑo  dessemelhantes)  poderÑo adquirir,  sob pressÑo,  uma  carga');
  EscE(80,190,'elÇctrica, positiva  em  uma das extremidades  e  negativa na outra.');
  EscE(80,205,'Este  fen¢meno Ç conhecido  como piezelectricidade. Se  for aplicada');
  EscE(80,220,'tensÑo ao longo do eixo polar, a carga Ç invertida. Sendo altamente');
  EscE(80,235,'piezelectrico, o quartzo Ç usado na  fabricaáÑo de relogios digitais');
  EscE(80,250,'e de  v†rios  aparelhos  de  precisÑo: osciladores,  geradores  de');
  EscE(80,265,'impulso etc. Certos  cristais  produzem  cargas elÇtricas em algumas');
  EscE(80,280,'das suas superf°cies quando submetidos a  variaáîes de temperatura.');
  EscE(80,295,'O fen¢meno  Ç  conhecido como  piroelectricidade. A  turmalina  Ç um');
  EscE(80,310,'t°pico  mineral  piroelÇctrico. As  cargas  podem  ser  identificadas');
  EscE(80,325,'por meio de um elÇctrìmetro - ou  melhor ainda, soprando-se chumbo');
  EscE(80,340,'vermelho e  enxofre  em  p¢  atravÇs  de  um pedaáo de seda, para');
  EscE(80,355,'carregar as  part°culas  com electricidade  est†tica. Tendo recebido');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P13;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'uma  carga  positiva, o chumbo vermelho  deposita-se  na poráÑo do');
  EscE(80,190,'mineral carregada de electricidade negativa. O enxofre, que recebeu');
  EscE(80,205,'uma  carga  negativa, deposita-se na poráÑo do  mineral  com carga');
  EscE(80,220,'positiva.');
  EscE(70,250,'MAGNETISMO');
  EscE(80,280,'Os   minerais   reagem   Ö   aáÑo   de   um  magneto. Denominam-se');
  EscE(80,295,'ferromagnÇticos os minerais com  uma  reacáÑo forte. Os de resposta');
  EscE(80,310,'mais   fraca,   atra°dos   apenas   por   imans   poderosos,   sÑo');
  EscE(80,325,'paramagnÇticos; os diamagnÇticos sÑo repelidos pelo campo magnÇrico.');
  EscE(80,340,'A   magnetita  Ç  ferromagnÇtica.  A  hematita   e  a  siderita  sÑo');
  EscE(80,355,'paramagnÇticos,  enquanto  o  enxofre,  o  quartzo  e  outros  sÑo');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P14;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'diamagnÇticos. As  propriedades  inatas  da  magnetita fazem dela um');
  EscE(80,190,'magneto natural de longa duraáÑo. Nos chamados espÇcimes polares, o');
  EscE(80,205,'magnetismo  nas  extermidades Ç  diferente. Quando o  magnetismo tem');
  EscE(80,220,'cargas  idànticas  nas duas  extermidades, o  espÇcime  denomina-se');
  EscE(80,235,'bipolar.');
  EscE(80,265,'PROPRIEDADES OPTICAS');
  EscE(80,295,'Ao atingir  um  objecto, a luz incidente Ç  parcialmente  refletida e');
  EscE(80,310,'parcialmente   absorvida  por  ele. Por esse  motivo  o  brilho dos');
  EscE(80,325,'cristais varia  conforme a  intensidade do reflexo. A classificaáÑo a');
  EscE(80,340,'seguir, baseada  nas  graduaáîes de brilho, Ç util na  identificaáÑo');
  EscE(80,355,'dos minerais.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P15;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'adamantino    - muito brilhante (o brilho do diamante)');
  EscE(80,190,'subadamantino - um pouco menos brilhante (linarita)');
  EscE(80,205,'v°treo        - brilho semelhante ao do vidro (quartzo)');
  EscE(80,220,'met†lico      - brilho dos metais, inteiramente opaco Ö luz');
  EscE(80,235,'submet†lico   - minerais com este brilho sÑo opacos, mas');
  EscE(80,250,'               transparentes na secáÑo delgada de');
  EscE(80,265,'               microsc¢pio (cin†brio)');
  EscE(80,280,'nacarado     - levemente iridescente, como a pÇrola (micas)');
  EscE(80,295,'sedoso       - qualidade t°pica dos minerais fibrosos (asbesto)');
  EscE(80,310,'resinoso     - faiscantes e tendentes ao amarelo (enxofre)');
  EscE(80,325,'gorduroso    - de um brilho s£btil (talco maciáo e nefelina)');
  EscE(80,340,'fosco        - refletem muito pouco brilho (quiolita) sÑo');
  EscE(80,355,'               quase invis°veis na †gua.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P16;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'COR');
  EscE(80,205,'Trata-se   de   uma   indicaáÑo  £til  apenas   para   os  minerais');
  EscE(80,220,'idiocrom†ticos  de cor  invari†vel. A maioria  dos  minerais, porÇm,');
  EscE(80,235,'Ç alocrom†tica. Isto significa que sua  cor varia de  acordo  com os');
  EscE(80,250,'†tomos presentes no ret°culo  cristalino. Os minerais idiocrom†ticos,');
  EscE(80,265,'tais como o  enxofre, cuprita, malaquita  e  cin†brio conservam sua');
  EscE(80,280,'coloraáÑo (esmaecida) quando reduzidos a p¢. Os  minerais alocrom†-');
  EscE(80,295,'ticos sob a forma de p¢ em geral tàm cor cinzenta ou esbranquiáada.');
  EscE(70,325,'LUMINESCENCIA');
  EscE(80,355,'Quando energizados por meios  mecÉnicos ou qu°micos, ou pelo calor,');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P17;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'alguns  minerais  emitem  ondas  e  assumem  diferentes cores - Ç o');
  EscE(80,190,'fen¢meno  de  luminescància.  A  fosforescància  ocorrre  quando  a');
  EscE(80,205,'emissÑo   continua   ap¢s  a  retirada   da  energia  excitante;  a');
  EscE(80,220,'fluorescància  ocorre  quando a emissÑo cessa  com  a retirada  do');
  EscE(80,235,'est°mulo. A  espetacular  fluorescància  conhecida  como  efeito  de');
  EscE(80,250,'Wood Ç o  resultado de  radiaáîes de ondas  curtas sobre  minerais');
  EscE(80,265,'radioactivos.  A  fluorescància  pode  ser  induzida  por  meio  de');
  EscE(80,280,'lÉmpadas ultravioletas port†teis. ê importante na procura de minerais');
  EscE(80,295,'radioactivos  para  utilizaáÑo  industrial. A autunita, a scheelita e');
  EscE(80,310,'outros  minerais  apresentam  fluorescància sempre. Outros - como a');
  EscE(80,325,'escapolita, a  calcita  e  a  fluorita - sÑo fluorescentes s¢ quando');
  EscE(80,340,'apresentam imperfeiáîes estruturais.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R2P18;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'RADIOACTIVIDADE');
  EscE(80,205,'Muitos  minerais  contÇm  elementos  radioactivos - entre  os  quais');
  EscE(80,220,'o  urÉnio, o  t¢rio  e  o  r†dio - que  se  encontram  num  estado');
  EscE(80,235,'cont°nuo  de  transmutaáÑo,  emitindo  particulas  alfa  e   beta  e');
  EscE(80,250,'raios  gama.  Estes  fen¢menos  afectarÑo  uma   placa  fotogr†fica');
  EscE(80,265,'e  serÑo  registrados  num  contador  Geiger.  Autunita,  turbenita,');
  EscE(80,280,'carnotita,  betafita   e   uraninita   sÑo   exemplos   de  minerais');
  EscE(80,295,'radioactivos.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P1;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,175,'3. TESTES QUIMICOS');
  EscE(70,205,'A analise qu°mica  qualitativa e quantitativa das espÇcies pode exigir');
  EscE(70,220,'tempo e esforco consider†veis. Todavia, experiàncias  mais r†pidas e');
  EscE(70,235,'valiosas  tornam-se  poss°veis com o aux°lio da alguns  reagentes  e');
  EscE(70,250,'itens pouco  dispendiosos de equipamento. Tudo o que precisamos Ç de');
  EscE(70,265,'alguns tubos de ensaio, um pequeno  gancho de fio de platina com uma');
  EscE(70,280,'aláa, um maáarico, um bico de  Bunsen, uma  esp†tula, um canivete e');
  EscE(70,295,'um almofariz de †gata.');
  EscE(70,310,'Os compostos qu°micos necess†rios incluem o †cido clor°drico, n°trico,');
  EscE(70,325,'carbonato   de  s¢dio,  nitrato  de  cobalto,  idodeto  de  pot†ssio,');
  EscE(70,340,'per¢xido de hidrogÇnio, enxofre, di¢xido de chumbo, cloreto de b†rio');
  EscE(70,355,'e amon°aco.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P2;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'Para comeáar, podemos colocar um pouco de  mineral em p¢ em um tubo');
  EscE(70,190,'de  ensaio com  algumas gotas  de †cido  clor°drico. A efervescància');
  EscE(70,205,'imediata  vai dizer-nos  que  mineral Ç  um  carbonato. Se o p¢  nÑo');
  EscE(70,220,'mostrar efervescància poderemos aquece-lo, pois alguns minerais, por');
  EscE(70,235,'exemplo a dolomita, s¢ fervem quando aquecidos.');
  EscE(70,250,'Para testar o ouro em  estado puro, um s°lex  negro e esfregado com');
  EscE(70,265,'um pedaáo de ouro, e em  seguida com o espÇcime sob  exame. Depois,');
  EscE(70,280,'algumas  gotas  de  †cido  n°trico  sÑo  pingadas  nos  traáos assim');
  EscE(70,295,'formados. O ouro  nÑo Ç afectado pelo  †cido n°trico: assim, as  duas');
  EscE(70,310,'peáas sÑo de ouro  se todas as marcas permanecerem vis°veis. Se  os');
  EscE(70,325,'traáos deixados pelo espÇcime forem destru°dos, ele nÑo Ç de ouro.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P3;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICAÄAO DOS SULFETOS');
  EscE(80,205,'Os dados  f°sicos sÑo  £teis neste  ponto: os sulfetos  sÑo  moles e');
  EscE(80,220,'opacos, com brilho met†lico e alta densidade. Queimam em contato com');
  EscE(80,235,'o ar  produzindo di¢xido  de enxofre (SO2), de odor  caracter°stico.');
  EscE(80,250,'Quando  aquecidos  num   tubo  fechado,  flores   de  enxofre  sÑo');
  EscE(80,265,'cristalizadas em  suas paredes. SÑo sol£veis no †cido: a  adiáÑo do');
  EscE(80,280,'†cido clor°drico resulta no †cido  sulf°drico (H2S), g†s t¢xico e de');
  EscE(80,295,'cheiro desagrad†vel.');
  EscE(70,325,'IDENTIFICAÄAO DOS HALETOS');
  EscE(80,355,'Se forem  cloretos sol£veis  em  †gua,  uma soluáÑo  de n°trato  de');
end;


{ P†gina do EcrÑ Como reconhecer }
procedure R3P4;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'prata (AgNO3),  produzir†  um  precipitado  branco  de  cloreto  de');
  EscE(80,190,'prata, (AgCI).');
  EscE(80,205,'Se  forem  insol£veis  em  †gua,  os  testes  sÑo feitos com  †cido');
  EscE(80,220,'n°trico (HNO3), e n°trato de prata (AgNO3). Flocos brancos de cloreto');
  EscE(80,235,'de prata (AgCI) sÑo formados com o aquecimento.');
  EscE(80,250,'Para testar  fluoretos, adicione †cido sulf£rico (H2SO4) a  um pouco');
  EscE(80,265,'do mineral  em po. Com um ligeiro aquecimento, sÑo emitidos  vapores');
  EscE(80,280,'brancos de  †cido  flur°drico (HF), que  corroem  o tubo  de  vidro.');
  EscE(80,295,'Deve-se tomar cuidado, esses vapores sÑo muito corrosivos.');
  EscE(80,310,'O  teste  para  os  iodetos  consiste  em  adicionar  bissulfato  de');
  EscE(80,325,'pot†ssio (KHSO4) ao  mineral em  p¢, que  entÑo liberar†  vapor  de');
  EscE(80,340,'iodo de coloraáÑo viol†cea.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P5;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICAÄAO DOS CARBONATOS');
  EscE(80,205,'A adiáÑo  de †cidos  a quente ou  a frio,  resulta na  produáÑo de');
  EscE(80,220,'di¢xido  de  carbono (CO2).  Se  forem  submetidos  a  temperaturas');
  EscE(80,235,'elevadas, os  carbonatos  se calcificarÑo,  produzindo CO2 e  seus');
  EscE(80,250,'¢xidos  respectivos. Embora  quimicamente  idànticas, a  calcita e a');
  EscE(80,265,'aragonita  se  cristalizam   de  maneira  diversa.  Se  este  h†bito');
  EscE(80,280,'diferente  nÑo  for  identificado  porque  ambas  as  amostras  sÑo');
  EscE(80,295,'microcristalinas  (isto   Ç,  com   cristais  vis°veis   apenas   ao');
  EscE(80,310,'microsc¢pio), os dois minerais podem ser distinguidos por intermÇdio');
  EscE(80,325,'do teste  de Meigen. Para  este  teste, uma  soluáÑo  de nitrato de');
  EscE(80,340,'cobalto (CO(NO3)2) Ç  acrescentada  ao  mineral  em  p¢  no tubo de');
  EscE(80,355,'ensaio Ç mantida por alguns segundos em ponto de ebuliáÑo. O  p¢ de');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P6;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'aragonita  assumira  uma  coloraáÑo  violeta,  enquanto  a  calcita');
  EscE(80,190,'permanecera branca.');
  EscE(70,220,'IDENTIFICAÄAO DE BORATOS');
  EscE(80,250,'Reduzidos a p¢ e em contato com o †cido sulf£rico, apresentam chama');
  EscE(80,265,'de cor verde no maáarico.');
  EscE(70,295,'IDENTIFICAÄAO DE SULFATOS');
  EscE(80,325,'Se  forem sol£veis em  †gua ou em  †cido clor°drico, produzirÑo  um');
  EscE(80,340,'precipitado branco, o sulfato de b†rio (BaSO4), quando adicionado a');
  EscE(80,355,'uma soluáÑo de cloreto de b†rio (BaCl2).');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P7;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'A reacáÑo  hÇpar, tambÇm usada  para os sulfatos, Ç  aplic†vel aos');
  EscE(80,190,'sulfatos  insol£veis. O mineral em  p¢ Ç  misturado a carbonato  de');
  EscE(80,205,'s¢dio (Na2Co3), e aquecido  ao  maáarico sobre  o carvÑo  vegetal.');
  EscE(80,220,'Colocado sobre uma superf°cie de prata e lavado na †gua, o res°duo');
  EscE(80,235,'produzir†  †cido sulf°drico (H2S), que  provoca o  enegrecimento da');
  EscE(80,250,'prata. Este res°duo tambÇm contÇm sulfeto de s¢dio (Na2S).');
  EscE(70,280,'IDENTIFICAÄAO DOS FOSFATOS');
  EscE(80,310,'Eles fundem-se ao serem submetidos Ö chama de um maáarico, tingindo');
  EscE(80,325,'de verde a chama. SÑo sol£veis em †cido n°trico (HNO3); se molibdato');
  EscE(80,340,'de am¢nia for adicionado Ö soluáÑo, o resultado Ç o  fosfomolibdato,');
  EscE(80,355,'um precipitado amarelo de am¢nia.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P8;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICAÄAO DOS ARSENIATOS');
  EscE(80,205,'Eles fundem-se ao serem submetidos Ö chama de um maáarico. O vapor');
  EscE(80,220,'produzido  tem  um  cheiro de  arsÇnio  e as  chamas  assumem uma');
  EscE(80,235,'tonalidade azulada.');
  EscE(80,250,'Para distinguir entre fosfatos e arseniatos, acrescentamos  acetato');
  EscE(80,265,'de magnÇsio (Mg(CH3COO)2) Ö  soluáÑo  amoniacal  do  mineral, e  a');
  EscE(80,280,'seguir   filtramos  o  precipitado   e  acrescentamos  nitrato   de');
  EscE(80,295,'prata (AgNO3). Um fosfato tornar-se-† amarelo, um arseniato  ficar†');
  EscE(80,310,'de um tom castanho-avermelhado.');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P9;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,175,'IDENTIFICAÄAO DOS VANADIATOS');
  EscE(80,205,'Dissolvem-se no †cido n°trico dilu°do (HNO3). Ao evaporar sobre  uma');
  EscE(80,220,'lÉmina de metal, a soluáÑo deixa um dep¢sito vermelho de  pent¢xido');
  EscE(80,235,'de divan†dio (V2O5). Se for acrescentado per¢xido de hidrogÇnio,  a');
  EscE(80,250,'soluáÑo torna-se castanho-avermelhada.');
  EscE(70,280,'TESTES DE CHAMA');
  EscE(80,310,'R†pidos e £teis, estes testes  indicam que elementos estÑo presentes');
  EscE(80,325,'em determinado mineral. Os atomos excitados pelo calor de uma chama');
  EscE(80,340,'contÇm  eletrîes  em  movimento  nas  suas  orbitas  exteriores. Ao');
  EscE(80,355,'retrocederem  para orbitas mais internas, esses eletrîes emitem, em');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P10;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'forma  de  luz,  a   energia  absorvida.  Para  fazer  nosso  teste');
  EscE(80,190,'mergulhamos  um fio  de platina em †cido clor°drico,  colocamos  uma');
  EscE(80,205,'pitada de mineral em p¢ sobre o fio e o submetemos Ö chama:');
  EscE(80,235,'O S¢dio produz uma intensa chama amarela');
  EscE(80,250,'O c†lcio produz uma chama vermelho-alaranjada');
  EscE(80,265,'O cobre produz uma chama verde-brilhante');
  EscE(80,280,'O b†rio produz uma firme chama verde-amarelada');
  EscE(80,295,'O estrìncio produz uma chama vermelha-brilhante');
  EscE(80,310,'O l°tio produz uma chama vermelha-escarlate');
  EscE(80,325,'O pot†ssio produz uma chama violeta');
  EscE(80,355,'Por exemplo, um fragmento de  calcopirita pode ser  distinguido  das');
end;

{ P†gina do EcrÑ Como reconhecer }
procedure R3P11;
begin
  setfillstyle(1,3);
  bar(46,161,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,175,'piritas pelo tom  verde-acobreado de chama  produzida em um r†pido');
  EscE(80,190,'teste deste gÇnero.');
end;

end.