{ Auxiliar nß 2 do MinÇrius }
Unit Mine2;

interface

uses Crt, Graph, Dos, Mine21, Mine22, Mine3, KeyTTT5, StrnTTT5;

procedure Form;
procedure Como;
procedure Clas;
procedure Lito;

implementation

const G50 : FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);

var ch : char;
    v,d : word;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F1P1;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,185,'1. MINERAIS DE ORIGEM MAGMATICA');
  EscE(70,200,'O magma Ç  um  material  fundido que  apresenta  temperaturas  muito');
  EscE(70,215,'elevadas  e Ç  composto  por  v†rios  elementos, muitos  dos  quais');
  EscE(70,230,'vol†teis.  Em  geral, os  elementos   predominantes  sÑo  o  sil°cio,');
  EscE(70,245,'alum°nio, c†lcio, magnÇsio, s¢dio, pot†ssio  e  ferro.  TambÇm  est†');
  EscE(70,260,'presente uma boa  quantidade de †gua sob a forma de vapor. A perda');
  EscE(70,275,'de calor produz a cristalizaáÑo do magma, que nÑo ocorre de maneira');
  EscE(70,290,'homogÇnica, mas  segundo  um  processo  gradual  e  selectivo.  Os');
  EscE(70,305,'v†rios est†gios da cristalizaáÑo estÑo profundamente afectados pela');
  EscE(70,320,'pressÑo  e  pela  temperatura.  SÑo  os  est†gios   ortomagm†ticos,');
  EscE(70,335,'pegmat°ticos, pneumatol°ticos e hidrotermais.');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F1P2;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,185,'ESTAGIO ORTOMAGMATICO');
  EscE(80,200,'Os primeiros a  cristalizar, sÑo os minerais  acess¢rios: zirc¢nio,');
  EscE(80,215,'titanita  e  apatita. Seguem-se  os  minerais  que  contÇm  ferro e');
  EscE(80,230,'magnÇsio: piroxÇnio, anfib¢lio, biotita, etc. Mais  tarde, Ç a  vez');
  EscE(80,245,'da albita, anortita, ortocl†sio e do quartzo. TambÇm aparecem nesse');
  EscE(80,260,'est†gio alguns  minerais metal°feros: cromita, pirrotita, magnetita');
  EscE(80,275,'e esfÇnio.');
  EscE(80,290,'Quanto mais pr¢ximo estiver o magma da superf°cie, mais r†pido ser†');
  EscE(80,305,'o processo de  resfriamento. Esse aspecto afecta  consideravelmente');
  EscE(80,320,'a sequància de  cristalizaáÑo. Durante  este est†gio, os  elementos');
  EscE(80,335,'vol†teis - cloro, fl£or, boro e vapor de †gua - pouco participam do');
  EscE(80,350,'processo de  cristalizaáÑo  e se  concentram  no  magma  residual,');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F1P3;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,185,'ampliando dessa maneira a sua pressÑo interna.');
  EscE(70,200,'ESTAGIO PEGMATITICO');
  EscE(80,215,'Ocorre  a uma  temperatura  inferior (entre 660 e 700''C) mas a uma');
  EscE(80,230,'pressÑo  mais  elevada  do  que  a  do  est†gio Ortomagm†tico; os');
  EscE(80,245,'elementos  vol†teis  passam a  desempenhar plenamente o seu papel.');
  EscE(80,260,'ê durante o est†gio pegmat°tico que se formam os grandes cristais.');
  EscE(80,275,'Os  colecionadores   interessam-se   particularmente   por   essas');
  EscE(80,290,'rochas - os pegmatitos - tamto  pela  beleza das  formas como pela');
  EscE(80,305,'raridade  das  espÇcies  minerais. Os  pegmatitos  incluem berilos');
  EscE(80,320,'preciosos esmeraldas, †guas-marinhas, top†zios, muitas  variedades');
  EscE(80,335,'de  turmalina,  apatitas,  espondumÇnios,  uraninitas   e   outras');
  EscE(80,350,'espÇcies raras.');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F1P4;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,185,'Durante este est†gio, todo o magma residual se cristaliza. Lentamen-');
  EscE(80,200,'te, a temperatura cai para a faixa de 500-380''C. Nem todos os  ele-');
  EscE(80,215,'mentos vol†teis participam desta etapa: os remanescentes estÑo agora');
  EscE(80,230,'nas fissuras deixadas pela solidificaáÑo das rochas circunvizinhas.');
  EscE(70,245,'ESTAGIO PNEUMATOLITICO');
  EscE(80,260,'Os res°duos  gasosos e o vapor reagem com as rochas  mais  pr¢xi-');
  EscE(80,275,'mas e produzem novas espÇcies minerais. Este est†gio Ç  caracteri-');
  EscE(80,290,'zado     pela   cassiterita,  molibdenita,  scheelita,  vesuvianita,');
  EscE(80,305,'ilva°ta, grossul†ria, espessarita e  outras granadas. Os  dep¢sitos');
  EscE(80,320,'assim   formados  sÑo  denominados  ''dep¢sitos  pneumatol°ticos  de');
  EscE(80,335,'contacto'', pois  formam-se na †rea de  contacto entre o magma e as');
  EscE(80,350,'rochas ao seu redor.');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F1P5;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,185,'ESTAGIO HIDROTERMAL');
  EscE(80,200,'Quando a temperatura do magma cristalizado cai abaixo dos 370''C, o');
  EscE(80,215,'vapor  se  transforma  em l°quido e deposita os seus  constitu°ntes');
  EscE(80,230,'minerais  em  fissuras  e  fracturas, formando  veios  de  minerais');
  EscE(80,245,'preciosos  que substituem  parcialmente os calc†rios, quando entram');
  EscE(80,260,'em  contacto  com  estes.  Muitos  sulfetos  se  cristalizam  dessa');
  EscE(80,275,'maneira: pirita (FeS2), quartzo (SiO2)... Existem  espÇcies t°picas');
  EscE(80,290,'de  temperaturas  altas,  mÇdias  e  baixas,  formadas  segundo  a');
  EscE(80,305,'distÉncia em relaáÑo ao magma.');
  EscE(80,320,'Quando o  magma  sobe  em  direcáÑo Ö  superficie, em  vez  de se');
  EscE(80,335,'solidificar  a  uma  certa profundidade, muitos gases e vapores  se');
  EscE(80,350,'formam ao  longo  das  superficies  rochosas  que  acompanham  as');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F1P6;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(80,185,'fissuras. Desse modo, aparecem  novos  minerais: enxofre, hematita,');
  EscE(80,200,'e v†rios outros...');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F2P1;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,185,'2. MINERAIS DE ORIGEM SEDIMENTAR');
  EscE(70,200,'As rochas sÑo  eroditas e transformadas pela acáÑo f°sica e  qu°mica');
  EscE(70,215,'da atmosfera. Os minerais que elas  contÇm sÑo  dissolvidos na †gua,');
  EscE(70,230,'e  transportados para  outras  †reas. Ao  se  cristalizarem  ap¢s  a');
  EscE(70,245,'evaporaáÑo da †gua, formam os dep¢sitos secund†rios. Dentre eles, os');
  EscE(70,260,'dep¢sitos  resultantes  de  processos  qu°micos  ou  biol¢gicos  sÑo');
  EscE(70,275,'particularmente importantes.');
  EscE(70,290,'O  carbonato de c†lcio, insol£vel, transforma-se em  bicarbonato  de');
  EscE(70,305,'c†lcio, sol£vel  em  †gua, e no  di¢xido de carbono. Desse modo, os');
  EscE(70,320,'calc†rios dissolvem-se lentamente; a †gua transporta-os ao longo das');
  EscE(70,335,'fissuras  do  solo  e  dos  regatos  e  rios atÇ  ao  mar. Durante o');
  EscE(70,350,'percurso, Ö  medida que a †gua  se  evapora, o carbonato de c†lcio');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F2P2;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,185,'solidifica-se  outra vez sob a forma de estalactites e estalagmites,');
  EscE(70,200,'de travertino ou de belos cristais de calcita. O mesmo acontece  com');
  EscE(70,215,'as  dolomitas, embora  sejam  menos  sol£veis, e com  a  gipsita e a');
  EscE(70,230,'anidrita, relativamente sol£veis e que  se cristalizam quando a †gua');
  EscE(70,245,'evapora. Dep¢sitos  deste  gÇnero, chamados  de  evaporitos, atingem');
  EscE(70,260,'muitas vezes grandes dimensîes.');
  EscE(70,275,'Menos  frequentes sÑo os  dep¢sitos de sais de pot†ssio formados por');
  EscE(70,290,'silvita, carnallita, cainita, bischofita, leonita, etc. Todos  devem');
  EscE(70,305,'sua existància a processos  qu°micos. Parece que o  enxofre pode ter');
  EscE(70,320,'origem  biol¢gica  devido Ö  acáÑo de  bactÇrias sobre a  gipsita. A');
  EscE(70,335,'limonita, tambÇm  pode  resultar da  acáÑo de  bactÇrias que  formam');
  EscE(70,350,'col¢nias no  fundo  de  pantÉnos e lagos  e  agem  sobre  o  ferro.');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F2P3;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,185,'Considera-se  que   muitos  minerais  formados   pela  alteraáÑo  de');
  EscE(70,200,'dep¢sitos sulfurosos tambÇm tenham origem sedimentar. Esta  alteraáÑo');
  EscE(70,215,'produz †cido sulf£rico (H2SO4), que reage com outros minerais. Se os');
  EscE(70,230,'dep¢sitos  estiverem  em  contacto  com o ar, tambÇm se  manifesta a');
  EscE(70,245,'oxidaáÑo  e a  carbonetaáÑo. ê  a  chamada  area  de  oxidaáÑo  dos');
  EscE(70,260,'dep¢sitos   minerais, dentro   da   qual   sÑo  encontradas   muitas');
  EscE(70,275,'espÇcies:  siderita, limonita,  cerussita,  anglesita,  smithsonita,');
  EscE(70,290,'etc. Uma  parte  das soluáîes  qu°micas criadas  pela alteraáÑo  dos');
  EscE(70,305,'dep¢sitos  superficiais, pode se infiltrar a uma certa profundidade,');
  EscE(70,320,'longe da atmosfera, e depositar sais num ambiente que nÑo Ç oxidante');
  EscE(70,335,'e sim redutor. Ali  podem ser  encontrados  elementos em estado puro');
  EscE(70,350,'como a prata e o cobre ou a covellita, calcocita, ...');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F3P1;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(50,185,'3. MINERAIS DE ORIGEM METAMORFICA');
  EscE(70,200,'As rochas nÑo sÑo objectos est†ticos: elas sofrem v†rias alteraáîes,');
  EscE(70,215,'decorrentes dos  deslocamentos, da  sedimentaáÑo e das mudanáas de');
  EscE(70,230,'profundidade.  Isto    causa    tensîes,  altas   pressîes  e  altas');
  EscE(70,245,'temperaturas:  tràs factores  determinantes de  alteraáîes  f°sicas e');
  EscE(70,260,'qu°micas nos componentes minerais.');
  EscE(70,275,'No   que  se   refere  Ö   profundidade,  existem   tràs  ambientes');
  EscE(70,290,'caracter°sticos:');
  EscE(70,320,'1'' A epizona  (entre  5000 e  7000m)');
  EscE(70,335,'2'' A mesozona (entre  7000 e 12000m)');
  EscE(70,350,'3'' A catazona (entre 12000 e 20000m)');
end;

{ Faz uma p†gina do EcrÑ do FormaáÑo dos Minerais }
procedure F3P2;
begin
  setfillstyle(1,3);
  bar(46,171,598,358);
  settextstyle(2,0,5);
  settextjustify(0,0);
  EscE(70,185,'Na epizona, a  temperatura  Ç baixa (200''C) e as altas  pressîes sÑo');
  EscE(70,200,'irregulares. Ali tàm origem  enquanto derivaáîes de outros  minerais,');
  EscE(70,215,'in£meros  silicatos: clorita, sericita, talco, etc.  Na  mesozona,  a');
  EscE(70,230,'temperatura atinge os 400''C, a pressÑo permanece irregular e ocorre');
  EscE(70,245,'a formaáÑo de estaurolita, cianita, e das granadas e hornblendas. Na');
  EscE(70,260,'catazona,  a  profundidades  muito  maiores,  a  temperatura  chega');
  EscE(70,275,'aos 600''C. A  pressÑo Ç  elevada  e mais ou  menos igual  em toda a');
  EscE(70,290,'superf°cie  da  massa.  Os  minerais  formados  nesse  ambiente, sÑo');
  EscE(70,305,'semelhantes aos  originados pela solidificaáÑo do magma:  sillimanita,');
  EscE(70,320,'cordierita, grafita, granada almandina, ortocl†sio, [...] e piroxÇnio.');
end;

{ Faz as caixas consoante estejam ligadas ou desligadas }
procedure T1(t: boolean);
begin
  if t then
     begin
       setfillstyle(1,3);
       bar(360,375,600,387);
       setcolor(7);
       line(360,375,599,375);
       line(360,375,360,386);
       setcolor(11);
       line(600,387,360,387);
       line(600,387,600,375);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(2);
       outtextxy(481,380,'Minerais de origem magm†tica');
       setcolor(15);
       outtextxy(480,379,'Minerais de origem magm†tica');
     end
  else
     begin
       setfillstyle(1,0);
       bar(360,375,600,387);
       setcolor(15);
       line(360,375,600,375);
       line(360,375,360,387);
       setcolor(7);
       line(600,387,361,387);
       line(600,387,600,376);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(1);
       outtextxy(481,380,'Minerais de origem magm†tica');
       setcolor(15);
       outtextxy(480,379,'Minerais de origem magm†tica');
     end;
end;

{ Faz as caixas consoante estejam ligadas ou desligadas }
procedure T2(t: boolean);
begin
  if t then
     begin
       setfillstyle(1,3);
       bar(360,392,600,404);
       setcolor(7);
       line(360,392,599,392);
       line(360,392,360,403);
       setcolor(11);
       line(600,404,360,404);
       line(600,404,600,392);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(2);
       outtextxy(481,397,'Minerais de origem sedimentar');
       setcolor(15);
       outtextxy(480,396,'Minerais de origem sedimentar');
     end
  else
     begin
       setfillstyle(1,0);
       bar(360,392,600,404);
       setcolor(15);
       line(360,392,600,392);
       line(360,392,360,404);
       setcolor(7);
       line(600,404,361,404);
       line(600,404,600,393);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(1);
       outtextxy(481,397,'Minerais de origem sedimentar');
       setcolor(15);
       outtextxy(480,396,'Minerais de origem sedimentar');
     end;
end;

{ Faz as caixas consoante estejam ligadas ou desligadas }
procedure T3(t: boolean);
begin
  if t then
     begin
       setfillstyle(1,3);
       bar(360,408,600,420);
       setcolor(7);
       line(360,408,599,408);
       line(360,408,360,419);
       setcolor(11);
       line(600,420,360,420);
       line(600,420,600,408);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(2);
       outtextxy(481,413,'Minerais de origem metam¢rfica');
       setcolor(15);
       outtextxy(480,412,'Minerais de origem metam¢rfica');
     end
  else
     begin
       setfillstyle(1,0);
       bar(360,408,600,420);
       setcolor(15);
       line(360,408,600,408);
       line(360,408,360,420);
       setcolor(7);
       line(600,420,361,420);
       line(600,420,600,409);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(1);
       outtextxy(481,413,'Minerais de origem metam¢rfica');
       setcolor(15);
       outtextxy(480,412,'Minerais de origem metam¢rfica');
     end;
end;

{ Controlador do Teclado no ecrÑ FormaáÑo dos Minerais }
procedure Form;
Label 1,2,3,4,5;
var pag, tipo, totp : byte;
    St : string;
begin
  Ec('FormaáÑo dos Minerais','F1 - Ajuda  Esc - Vai para o Menu principal  Rato - Escolhe outro t¢pico');
  goto 5;
3:Ec2('FormaáÑo dos Minerais','F1 - Ajuda  Esc - Vai para o Menu principal  Rato - Escolhe outro t¢pico');
5:outtextxy(45,385,'Esc   F1    Enter TABs');
  outtextxy(45,395,'PgDn  PgUp  Home  End');
  outtextxy(45,405,'SetaE SetaD SetaC SetaB');
  outtextxy(45,415,'ClicE ClicD  Rato');
  settextjustify(1,1);
  setcolor(4);
  settextstyle(8,0,0);
  EscE(320,73,'FormaáÑo dos Minerais');
  setcolor(2);
  line(45,100,594,100);
  setcolor(15);
  line(44,99,593,99);
  settextjustify(0,0);
  settextstyle(2,0,5);
  EscE(50,120,'  A origem dos minerais est† totalmente relacionada com a formaáÑo e a');
  EscE(50,135,'evoluáÑo das rochas. Estas sÑo formadas pela solidificaáÑo do magma(1),');
  EscE(50,150,'pela  sedimentaáÑo de  dep¢sitos  qu°micos(2) ou pelo  metamorfismo das');
  EscE(50,165,'rochas prÇ-existentes(3).');
  pag := 1;
  tipo := 1;
  totp := 6;
  F1P1;
  T1(True);
  T2(False);
  T3(False);
  settextjustify(2,0);
  settextstyle(2,0,0);
  St := 'Minerais de origem Magm†tica';
  setcolor(1);
  outtextxy(600,371,St);
  setcolor(15);
  outtextxy(599,370,St);
  settextstyle(3,0,0);
  outtextxy(352,407,Int_to_Str(totp));
1:SetFillStyle(1,7);
  settextjustify(2,0);
  settextstyle(3,0,0);
  bar(201,376,269,419);
  setcolor(15);
  outtextxy(272,407,Int_to_Str(Pag));
2:ch := getkey;
  case Ord(Ch) of
       199:    begin
                 if pag = 1 then goto 2;
                 if totp = 6 then F1P1;
                 if totp = 3 then F2P1;
                 if totp = 2 then F3P1;
                 pag := 1;
                 goto 1;
               end;
       207:    begin
                 if (pag = totp) then goto 2;
                 if totp = 6 then begin F1P6; pag := 6; end;
                 if totp = 3 then begin F2P3; pag := 3; end;
                 if totp = 2 then begin F3P2; pag := 2; end;
                 goto 1;
               end;
       200,201:
               begin
                 pag := pag - 1;
                 if pag = 0 then pag := totp;
                 if totp = 6 then
                    begin
                      if pag = 1 then F1P1;
                      if pag = 2 then F1P2;
                      if pag = 3 then F1P3;
                      if pag = 4 then F1P4;
                      if pag = 5 then F1P5;
                      if pag = 6 then F1P6;
                      goto 1;
                    end;
                 if totp = 3 then
                    begin
                      if pag = 1 then F2P1;
                      if pag = 2 then F2P2;
                      if pag = 3 then F2P3;
                      goto 1;
                    end;
                 if totp = 2 then
                    begin
                      if pag = 1 then F3P1;
                      if pag = 2 then F3P2;
                      goto 1;
                    end;
               end;
       208,209:
               begin
                 pag := pag + 1;
                 if pag = (totp+1) then pag := 1;
                 if totp = 6 then
                    begin
                      if pag = 1 then F1P1;
                      if pag = 2 then F1P2;
                      if pag = 3 then F1P3;
                      if pag = 4 then F1P4;
                      if pag = 5 then F1P5;
                      if pag = 6 then F1P6;
                      goto 1;
                    end;
                 if totp = 3 then
                    begin
                      if pag = 1 then F2P1;
                      if pag = 2 then F2P2;
                      if pag = 3 then F2P3;
                      goto 1;
                    end;
                 if totp = 2 then
                    begin
                      if pag = 1 then F3P1;
                      if pag = 2 then F3P2;
                      goto 1;
                    end;
               end;
       128:    begin
                 if tipo = 1 then goto 2;
                 tipo := tipo - 1;
                 if tipo = 1 then begin T2(False); T1(True); end;
                 if tipo = 2 then begin T3(False); T2(True); end;
                 goto 2;
               end;
       129:    begin
                 if tipo = 3 then goto 2;
                 tipo := tipo + 1;
                 if tipo = 2 then begin T1(False); T2(True); end;
                 if tipo = 3 then begin T2(False); T3(True); end;
                 goto 2;
               end;
       9,205:  begin
                 if tipo = 3 then tipo := 0;
                 tipo := tipo + 1;
                 if tipo = 1 then begin T3(False); T1(True); end;
                 if tipo = 2 then begin T1(False); T2(True); end;
                 if tipo = 3 then begin T2(False); T3(True); end;
                 goto 2;
               end;
       143,203:
               begin
                 if tipo = 1 then tipo := 4;
                 tipo := tipo - 1;
                 if tipo = 1 then begin T2(False); T1(True); end;
                 if tipo = 2 then begin T3(False); T2(True); end;
                 if tipo = 3 then begin T1(False); T3(True); end;
                 goto 2;
               end;
       13,133: begin
                 if (tipo = 1) and (totp = 6) then goto 2;
                 if (tipo = 2) and (totp = 3) then goto 2;
                 if (tipo = 3) and (totp = 2) then goto 2;
                 if tipo = 1 then begin totp := 6; pag := 1; F1P1; end;
                 if tipo = 2 then begin totp := 3; pag := 1; F2P1; end;
                 if tipo = 3 then begin totp := 2; pag := 1; F3P1; end;
                 setfillstyle(1,7);
                 bar(281,376,349,419);
                 setcolor(15);
                 settextjustify(2,0);
                 settextstyle(3,0,0);
                 outtextxy(352,407,Int_to_Str(totp));
                 setfillstyle(1,0);
                 bar(420,361,609,374);
                 settextjustify(2,0);
                 settextstyle(2,0,0);
                 if tipo = 1 then St := 'Minerais de origem Magm†tica';
                 if tipo = 2 then St := 'Minerais de origem Sedimentar';
                 if tipo = 3 then St := 'Minerais de origem Metam¢rfica';
                 setcolor(1);
                 outtextxy(600,371,St);
                 setcolor(15);
                 outtextxy(599,370,St);
                 goto 1;
               end;
       27,132: begin
                 setfillpattern(G50,6);
                 bar(1,30,638,450);
                 goto 4;
               end;
       187:    begin
                 Ajuda(2);
                 goto 3;
               end;
       else
               goto 2;
  end;
4:
end;

{ Define e cria o ecrÑ do Quadro dos Sistemas Cristalinos }
procedure QSC;
Label 1,2,3,4;
var Size1, Size2 : Word;
    p1, p2 : Pointer;
    vari : boolean;
{ Mostra os minerais em ponto grande }
procedure IDT(let: byte);
var Nome, Grup, Sist, Letr : array[1..23] of string;
begin
  Nome[ 1]:= 'cubo (ou hexaedro)'; Grup[ 1]:= 'isomÇtrico'; Sist[ 1]:= 'c£bico'; Letr[ 1]:= 'A';
  Nome[ 2]:= 'octaedro'; Grup[ 2]:= 'isomÇtrico'; Sist[ 2]:= 'c£bico'; Letr[ 2]:= 'B';
  Nome[ 3]:= 'rombododecaedro'; Grup[ 3]:= 'isomÇtrico'; Sist[ 3]:= 'c£bico'; Letr[ 3]:= 'C';
  Nome[ 4]:= 'tetraexaedro'; Grup[ 4]:= 'isomÇtrico'; Sist[ 4]:= 'c£bico'; Letr[ 4]:= 'D';
  Nome[ 5]:= 'trapezoedro'; Grup[ 5]:= 'isomÇtrico'; Sist[ 5]:= 'c£bico'; Letr[ 5]:= 'E';
  Nome[ 6]:= 'trioctaedro'; Grup[ 6]:= 'isomÇtrico'; Sist[ 6]:= 'c£bico'; Letr[ 6]:= 'F';
  Nome[ 7]:= 'hexaoctaedro'; Grup[ 7]:= 'isomÇtrico'; Sist[ 7]:= 'c£bico'; Letr[ 7]:= 'G';
  Nome[ 8]:= 'bipirÉmide di-hexagonal'; Grup[ 8]:= 'dimÇtrico'; Sist[ 8]:= 'hexagonal'; Letr[ 8]:= 'H';
  Nome[ 9]:= 'bipirÉmide hexagonal'; Grup[ 9]:= 'dimÇtrico'; Sist[ 9]:= 'hexagonal'; Letr[ 9]:= 'I';
  Nome[10]:= 'prisma di-hexagonal'; Grup[10]:= 'dimÇtrico'; Sist[10]:= 'hexagonal'; Letr[10]:= 'J';
  Nome[11]:= 'prisma hexagonal'; Grup[11]:= 'dimÇtrico'; Sist[11]:= 'hexagonal'; Letr[11]:= 'L';
  Nome[12]:= 'romboedro'; Grup[12]:= 'dimÇtrico'; Sist[12]:= 'trigonal'; Letr[12]:= 'M';
  Nome[13]:= 'escalenoedro'; Grup[13]:= 'dimÇtrico'; Sist[13]:= 'trigonal'; Letr[13]:= 'N';
  Nome[14]:= 'pirÉmide di-tetragonal'; Grup[14]:= 'dimÇtrico'; Sist[14]:= 'tetragonal'; Letr[14]:= 'O';
  Nome[15]:= 'pirÉmide tetragonal'; Grup[15]:= 'dimÇtrico'; Sist[15]:= 'tetragonal'; Letr[15]:= 'P';
  Nome[16]:= 'prisma di-tetragonal'; Grup[16]:= 'dimÇtrico'; Sist[16]:= 'tetragonal'; Letr[16]:= 'Q';
  Nome[17]:= 'prisma tetragonal'; Grup[17]:= 'dimÇtrico'; Sist[17]:= 'tetragonal'; Letr[17]:= 'R';
  Nome[18]:= 'bipirÉmide rìmbica'; Grup[18]:= 'trimÇtrico'; Sist[18]:= 'ortorrìmbico'; Letr[18]:= 'S';
  Nome[19]:= 'prisma rìmbico'; Grup[19]:= 'trimÇtrico'; Sist[19]:= 'ortorrìmbico'; Letr[19]:= 'T';
  Nome[20]:= 'prisma rìmbico'; Grup[20]:= 'trimÇtrico'; Sist[20]:= 'ortorrìmbico'; Letr[20]:= 'U';
  Nome[21]:= 'prisma rìmbico'; Grup[21]:= 'trimÇtrico'; Sist[21]:= 'ortorrìmbico'; Letr[21]:= 'V';
  Nome[22]:= 'prisma monocl°nico'; Grup[22]:= 'trimÇtrico'; Sist[22]:= 'monocl°nico'; Letr[22]:= 'X';
  Nome[23]:= 'pinac¢ide'; Grup[23]:= 'trimÇtrico'; Sist[23]:= 'tricl°nico'; Letr[23]:= 'Z';
  settextstyle(3,0,0);
  setcolor(2);
  outtextxy(172,102,Letr[let]);
  setcolor(15);
  outtextxy(170,100,Letr[let]);
  case let of
        1: begin setcolor(2); Pic3D01(323,83,6,3); setcolor(15); Pic3D01(320,80,6,3); end;
        2: begin setcolor(2); Pic3D02(323,83,6,3); setcolor(15); Pic3D02(320,80,6,3); end;
        3: begin setcolor(2); Pic3D03(323,83,6,3); setcolor(15); Pic3D03(320,80,6,3); end;
        4: begin setcolor(2); Pic3D04(323,83,6,3); setcolor(15); Pic3D04(320,80,6,3); end;
        5: begin setcolor(2); Pic3D05(323,83,6,3); setcolor(15); Pic3D05(320,80,6,3); end;
        6: begin setcolor(2); Pic3D06(323,83,6,3); setcolor(15); Pic3D06(320,80,6,3); end;
        7: begin setcolor(2); Pic3D07(323,83,6,3); setcolor(15); Pic3D07(320,80,6,3); end;
        8: begin setcolor(2); Pic3D08(323,83,6,3); setcolor(15); Pic3D08(320,80,6,3); end;
        9: begin setcolor(2); Pic3D09(323,83,6,3); setcolor(15); Pic3D09(320,80,6,3); end;
       10: begin setcolor(2); Pic3D10(323,83,6,3); setcolor(15); Pic3D10(320,80,6,3); end;
       11: begin setcolor(2); Pic3D11(323,83,6,3); setcolor(15); Pic3D11(320,80,6,3); end;
       12: begin setcolor(2); Pic3D12(323,83,6,3); setcolor(15); Pic3D12(320,80,6,3); end;
       13: begin setcolor(2); Pic3D13(323,83,6,3); setcolor(15); Pic3D13(320,80,6,3); end;
       14: begin setcolor(2); Pic3D14(323,83,6,3); setcolor(15); Pic3D14(320,80,6,3); end;
       15: begin setcolor(2); Pic3D15(323,83,6,3); setcolor(15); Pic3D15(320,80,6,3); end;
       16: begin setcolor(2); Pic3D16(323,83,6,3); setcolor(15); Pic3D16(320,80,6,3); end;
       17: begin setcolor(2); Pic3D17(323,83,6,3); setcolor(15); Pic3D17(320,80,6,3); end;
       18: begin setcolor(2); Pic3D18(323,83,6,3); setcolor(15); Pic3D18(320,80,6,3); end;
       19: begin setcolor(2); Pic3D19(323,83,6,3); setcolor(15); Pic3D19(320,80,6,3); end;
       20: begin setcolor(2); Pic3D20(323,83,6,3); setcolor(15); Pic3D20(320,80,6,3); end;
       21: begin setcolor(2); Pic3D21(323,83,6,3); setcolor(15); Pic3D21(320,80,6,3); end;
       22: begin setcolor(2); Pic3D22(323,83,6,3); setcolor(15); Pic3D22(320,80,6,3); end;
       23: begin setcolor(2); Pic3D23(323,83,6,3); setcolor(15); Pic3D23(320,80,6,3); end;
  end;
  settextstyle(6,0,3);
  setcolor(2);
  outtextxy(242,353,Nome[let]);
  outtextxy(242,383,Grup[let]);
  outtextxy(242,413,Sist[let]);
  setcolor(15);
  outtextxy(240,351,Nome[let]);
  outtextxy(240,381,Grup[let]);
  outtextxy(240,411,Sist[let]);
end;

{ Controlador do Teclado durante o QSC }
procedure Let(let: byte; var vari: boolean);
Label 1,2,3,4,5;
var p: pointer;
    s: word;
begin
  S := ImageSize(160,70,490,430);
  GetMem(P, S);
  GetImage(160,70,490,430,P^);
  setfillstyle(1,3);
  bar(160,70,480,420);
  setlinestyle(0,0,0);
  setcolor(0);
  line(160,70,490,70);
  line(160,70,160,430);
  setcolor(2);
  rectangle(162,72,480,420);
  line(162,332,480,332);
  setcolor(11);
  rectangle(161,71,479,419);
  line(161,331,479,331);
  setfillpattern(G50,1);
  bar(481,80,490,430);
  bar(170,421,480,430);
  settextstyle(2,0,5);
  settextjustify(0,0);
  setcolor(2);
  outtextxy(170,352,'Nome:');
  outtextxy(170,382,'Grupo:');
  outtextxy(170,412,'Sistema:');
  setcolor(15);
  outtextxy(169,351,'Nome:');
  outtextxy(169,381,'Grupo:');
  outtextxy(169,411,'Sistema:');
  IDT(let);
  Vari := False;
1:ch := getkey;
  case Ord(ch)  of
       187:     begin Ajuda(32); vari := True; goto 5; end;
       027,132: goto 4;
       065,097: begin
                  if let=  1 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  1; IDT( 1); goto 1;
                end;
       066,098: begin
                  if let=  2 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  2; IDT( 2); goto 1;
                end;
       067,099: begin
                  if let=  3 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  3; IDT( 3); goto 1;
                end;
       068,100: begin
                  if let=  4 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  4; IDT( 4); goto 1;
                end;
       069,101: begin
                  if let=  5 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  5; IDT( 5); goto 1;
                end;
       070,102: begin
                  if let=  6 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  6; IDT( 6); goto 1;
                end;
       071,103: begin
                  if let=  7 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  7; IDT( 7); goto 1;
                end;
       072,104: begin
                  if let=  8 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  8; IDT( 8); goto 1;
                end;
       073,105: begin
                  if let=  9 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:=  9; IDT( 9); goto 1;
                end;
       074,106: begin
                  if let= 10 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 10; IDT(10); goto 1;
                end;
       076,108: begin
                  if let= 11 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 11; IDT(11); goto 1;
                end;
       077,109: begin
                  if let= 12 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 12; IDT(12); goto 1;
                end;
       078,110: begin
                  if let= 13 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 13; IDT(13); goto 1;
                end;
       079,111: begin
                  if let= 14 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 14; IDT(14); goto 1;
                end;
       080,112: begin
                  if let= 15 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 15; IDT(15); goto 1;
                end;
       081,113: begin
                  if let= 16 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 16; IDT(16); goto 1;
                end;
       082,114: begin
                  if let= 17 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 17; IDT(17); goto 1;
                end;
       083,115: begin
                  if let= 18 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 18; IDT(18); goto 1;
                end;
       084,116: begin
                  if let= 19 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 19; IDT(19); goto 1;
                end;
       085,117: begin
                  if let= 20 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 20; IDT(20); goto 1;
                end;
       086,118: begin
                  if let= 21 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 21; IDT(21); goto 1;
                end;
       088,120: begin
                  if let= 22 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 22; IDT(22); goto 1;
                end;
       090,122: begin
                  if let= 23 then goto 1;
                  setfillstyle(1,3);bar(170,79,470,330);bar(237,333,478,418);
                  let:= 23; IDT(23); goto 1;
                end;
       else
                goto 1;
  end;
4:PutImage(160, 70, P^, NormalPut);
5:FreeMem(p,s);
end;
{ Main QSC }
begin
  Size1 := ImageSize(20,30,630,240);
  Size2 := ImageSize(20,240,630,450);
  GetMem(P1, Size1);
  GetImage(20,30,630,240,P1^);
  GetMem(P2, Size2);
  GetImage(20,240,630,450,P2^);
3:SetRGBpalette(4,56,56,56);
  setfillpattern(G50,6);
  bar(1,465,638,478);
  settextstyle(0,0,0);
  settextjustify(1,1);
  setcolor(7);
  outtextxy(320,473,'F1 - Ajuda  Esc - Volta atr†s  A a Z - Zoom e informaáÑo sobre cristal');
  setcolor(15);
  outtextxy(319,472,'F1 - Ajuda  Esc - Volta atr†s  A a Z - Zoom e informaáÑo sobre cristal');
  setlinestyle(0,0,0);
  setfillstyle(1,0);
  bar(20,30,620,440);
  setcolor(15);
  line(20,30,620,30);
  line(21,31,619,31);
  line(20,30,20,440);
  line(21,31,21,439);
  setcolor(7);
  line(620,440,620,31);
  line(619,439,619,32);
  line(620,440,21,440);
  line(619,439,22,439);
  setfillpattern(G50,5);
  bar(621,40,630,450);
  bar(30,441,630,450);
  setcolor(1);
  rectangle(25,35,614,434);
  line(25,63,614,63);
  line(40,63,40,434);
  line(599,63,599,434);
  line(25,116,614,116);
  line(40,169,614,169);
  line(40,222,614,222);
  line(25,275,614,275);
  line(40,328,614,328);
  line(40,381,614,381);
  setcolor(4);
  rectangle(26,36,615,435);
  line(26,64,615,64);
  line(41,64,41,435);
  line(600,64,600,435);
  line(26,117,615,117);
  line(41,170,615,170);
  line(41,223,615,223);
  line(26,276,615,276);
  line(41,329,615,329);
  line(41,382,615,382);
  settextstyle(8,0,1);
  settextjustify(1,0);
  setcolor(1);
  outtextxy(321,55,'Quadro dos Sistemas Cristalinos');
  setcolor(15);
  outtextxy(320,54,'Quadro dos Sistemas Cristalinos');
  settextstyle(2,1,2);
  settextjustify(1,1);
  setcolor(1);
  outtextxy(31,90,'isomÇtrico');
  outtextxy(31,196,'dimÇtrico');
  outtextxy(31,355,'trimÇtrico');
  setcolor(15);
  outtextxy(30,89,'isomÇtrico');
  outtextxy(30,195,'dimÇtrico');
  outtextxy(30,354,'trimÇtrico');
  setcolor(1);
  outtextxy(606,90,'c£bico');
  outtextxy(606,143,'hexagonal');
  outtextxy(606,196,'trigonal');
  outtextxy(606,249,'tetragonal');
  outtextxy(606,302,'ortorrìmbico');
  outtextxy(606,355,'monocl°nico');
  outtextxy(606,408,'tricl°nico');
  setcolor(15);
  outtextxy(605,89,'c£bico');
  outtextxy(605,142,'hexagonal');
  outtextxy(605,195,'trigonal');
  outtextxy(605,248,'tetragonal');
  outtextxy(605,301,'ortorrìmbico');
  outtextxy(605,354,'monocl°nico');
  outtextxy(605,407,'tricl°nico');
  settextstyle(2,0,0);
  settextjustify(0,0);
  setcolor(1);
  outtextxy(61,76,'A');
  outtextxy(131,76,'B');
  outtextxy(201,76,'C');
  outtextxy(271,76,'D');
  outtextxy(341,76,'E');
  outtextxy(411,76,'F');
  outtextxy(481,76,'G');
  outtextxy(61,129,'H');
  outtextxy(131,129,'I');
  outtextxy(201,129,'J');
  outtextxy(271,129,'L');
  outtextxy(61,182,'M');
  outtextxy(131,182,'N');
  outtextxy(61,235,'O');
  outtextxy(131,235,'P');
  outtextxy(201,235,'Q');
  outtextxy(271,235,'R');
  outtextxy(61,288,'S');
  outtextxy(131,288,'T');
  outtextxy(201,288,'U');
  outtextxy(271,288,'V');
  outtextxy(61,341,'X');
  outtextxy(61,394,'Z');
  setcolor(15);
  outtextxy(60,75,'A');
  outtextxy(130,75,'B');
  outtextxy(200,75,'C');
  outtextxy(270,75,'D');
  outtextxy(340,75,'E');
  outtextxy(410,75,'F');
  outtextxy(480,75,'G');
  outtextxy(60,128,'H');
  outtextxy(130,128,'I');
  outtextxy(200,128,'J');
  outtextxy(270,128,'L');
  outtextxy(60,181,'M');
  outtextxy(130,181,'N');
  outtextxy(60,234,'O');
  outtextxy(130,234,'P');
  outtextxy(200,234,'Q');
  outtextxy(270,234,'R');
  outtextxy(60,287,'S');
  outtextxy(130,287,'T');
  outtextxy(200,287,'U');
  outtextxy(270,287,'V');
  outtextxy(60,340,'X');
  outtextxy(60,393,'Z');
  setcolor(1);
  Pic3D01(91,71,1,0);
  Pic3D02(161,71,1,0);
  Pic3D03(231,71,1,0);
  Pic3D04(301,71,1,0); 
  Pic3D05(371,71,1,0); 
  Pic3D06(441,71,1,0); 
  Pic3D07(511,71,1,0); 
  Pic3D08(91,124,1,0);
  Pic3D09(161,124,1,0);
  Pic3D10(231,124,1,0);
  Pic3D11(301,124,1,0);
  Pic3D12(91,177,1,0);
  Pic3D13(161,177,1,0);
  Pic3D14(91,230,1,0);
  Pic3D15(161,230,1,0);
  Pic3D16(231,230,1,0);
  Pic3D17(301,230,1,0);
  Pic3D18(91,283,1,0);
  Pic3D19(161,283,1,0);
  Pic3D20(231,283,1,0);
  Pic3D21(301,283,1,0);
  Pic3D22(91,336,1,0);
  Pic3D23(91,389,1,0);
  setcolor(15);
  Pic3D01(90,70,1,0);
  Pic3D02(160,70,1,0);
  Pic3D03(230,70,1,0);
  Pic3D04(300,70,1,0);
  Pic3D05(370,70,1,0);
  Pic3D06(440,70,1,0);
  Pic3D07(510,70,1,0);
  Pic3D08(90,123,1,0);
  Pic3D09(160,123,1,0);
  Pic3D10(230,123,1,0);
  Pic3D11(300,123,1,0);
  Pic3D12(90,176,1,0);
  Pic3D13(160,176,1,0);
  Pic3D14(90,229,1,0);
  Pic3D15(160,229,1,0);
  Pic3D16(230,229,1,0);
  Pic3D17(300,229,1,0);
  Pic3D18(90,282,1,0);
  Pic3D19(160,282,1,0);
  Pic3D20(230,282,1,0);
  Pic3D21(300,282,1,0);
  Pic3D22(90,335,1,0);
  Pic3D23(90,388,1,0);
  vari := False;
1:if Vari then goto 3;
  ch := getkey;
2:case Ord(ch)  of
       187:     begin Ajuda(31); goto 3; end;
       027,132: goto 4;
       065,097: begin Let( 1,vari); goto 1; end;
       066,098: begin Let( 2,vari); goto 1; end;
       067,099: begin Let( 3,vari); goto 1; end;
       068,100: begin Let( 4,vari); goto 1; end;
       069,101: begin Let( 5,vari); goto 1; end;
       070,102: begin Let( 6,vari); goto 1; end;
       071,103: begin Let( 7,vari); goto 1; end;
       072,104: begin Let( 8,vari); goto 1; end;
       073,105: begin Let( 9,vari); goto 1; end;
       074,106: begin Let(10,vari); goto 1; end;
       076,108: begin Let(11,vari); goto 1; end;
       077,109: begin Let(12,vari); goto 1; end;
       078,110: begin Let(13,vari); goto 1; end;
       079,111: begin Let(14,vari); goto 1; end;
       080,112: begin Let(15,vari); goto 1; end;
       081,113: begin Let(16,vari); goto 1; end;
       082,114: begin Let(17,vari); goto 1; end;
       083,115: begin Let(18,vari); goto 1; end;
       084,116: begin Let(19,vari); goto 1; end;
       085,117: begin Let(20,vari); goto 1; end;
       086,118: begin Let(21,vari); goto 1; end;
       088,120: begin Let(22,vari); goto 1; end;
       090,122: begin Let(23,vari); goto 1; end;
       else                 
                goto 1;
  end;
4:
  PutImage(20, 30, P1^, NormalPut); PutImage(20,240, P2^, NormalPut);
  FreeMem(P1, Size1); FreeMem(P2, Size2);
  setlinestyle(0,0,0);
end;

{ Caixas on or off }
procedure R1(t: boolean);
begin
  if t then
     begin
       setfillstyle(1,3);
       bar(360,375,600,387);
       setcolor(7);
       line(360,375,599,375);
       line(360,375,360,386);
       setcolor(11);
       line(600,387,360,387);
       line(600,387,600,375);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(2);
       outtextxy(481,380,'Estrutura GeomÇtrica');
       setcolor(15);
       outtextxy(480,379,'Estrutura GeomÇtrica');
     end
  else
     begin
       setfillstyle(1,0);
       bar(360,375,600,387);
       setcolor(15);
       line(360,375,600,375);
       line(360,375,360,387);
       setcolor(7);
       line(600,387,361,387);
       line(600,387,600,376);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(1);
       outtextxy(481,380,'Estrutura GeomÇtrica');
       setcolor(15);
       outtextxy(480,379,'Estrutura GeomÇtrica');
     end;
end;

{ Caixas on or off }
procedure R2(t: boolean);
begin
  if t then
     begin
       setfillstyle(1,3);
       bar(360,392,600,404);
       setcolor(7);
       line(360,392,599,392);
       line(360,392,360,403);
       setcolor(11);
       line(600,404,360,404);
       line(600,404,600,392);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(2);
       outtextxy(481,397,'Propriedades F°sicas dos Minerais');
       setcolor(15);
       outtextxy(480,396,'Propriedades F°sicas dos Minerais');
     end
  else
     begin
       setfillstyle(1,0);
       bar(360,392,600,404);
       setcolor(15);
       line(360,392,600,392);
       line(360,392,360,404);
       setcolor(7);
       line(600,404,361,404);
       line(600,404,600,393);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(1);
       outtextxy(481,397,'Propriedades F°sicas dos Minerais');
       setcolor(15);
       outtextxy(480,396,'Propriedades F°sicas dos Minerais');
     end;
end;

{ Caixas on or off }
procedure R3(t: boolean);
begin
  if t then
     begin
       setfillstyle(1,3);
       bar(360,408,600,420);
       setcolor(7);
       line(360,408,599,408);
       line(360,408,360,419);
       setcolor(11);
       line(600,420,360,420);
       line(600,420,600,408);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(2);
       outtextxy(481,413,'Testes Qu°micos');
       setcolor(15);
       outtextxy(480,412,'Testes Qu°micos');
     end
  else
     begin
       setfillstyle(1,0);
       bar(360,408,600,420);
       setcolor(15);
       line(360,408,600,408);
       line(360,408,360,420);
       setcolor(7);
       line(600,420,361,420);
       line(600,420,600,409);
       settextstyle(2,0,0);
       settextjustify(1,1);
       setcolor(1);
       outtextxy(481,413,'Testes Qu°micos');
       setcolor(15);
       outtextxy(480,412,'Testes Qu°micos');
     end;
end;

{ Controlador do teclado do ecrÑ Como reconhecer }
procedure Como;
Label 1,2,3,4,5;
var pag, tipo, totp : byte;
    St : string;
begin
  Ec('Como reconhecer','F1 - Ajuda  Esc - Vai para o Menu principal  F10 - Sistemas Cristalinos');
  goto 5;
3:Ec2('Como reconhecer','F1 - Ajuda  Esc - Vai para o Menu principal  F10 - Sistemas Cristalinos');
5:outtextxy(45,385,'Esc   F1    Enter TABs');
  outtextxy(45,395,'PgDn  PgUp  Home  End');
  outtextxy(45,405,'SetaE SetaD SetaC SetaB');
  outtextxy(45,415,'ClicE ClicD  Rato  F10');
  settextjustify(0,0);
  settextstyle(2,0,5);
  EscE(50,75,'Para reconhecer uma espÇcie mineral sÑo usados tràs mÇtodos:');
  EscE(50,105,'1. O registo da  aparància geomÇtrica dos  cristais e  a reconstrucáÑo');
  EscE(70,120,'do formato e do sistema de cristalizaáÑo.');
  EscE(50,135,'2. A an†lise das caracter°sticas f°sicas da amostra.');
  EscE(50,150,'3. A realizaáÑo de esperiàncias qu°micas, que nÑo danificam o cristal.');
  setcolor(2);
  line(45,160,594,160);
  setcolor(15);
  line(44,159,593,159);
  R1(True); R2(False); R3(False);
  settextjustify(2,0);
  settextstyle(2,0,0);
  St := 'Estrutura GeomÇtrica';
  setcolor(1);
  outtextxy(600,371,St);
  setcolor(15);
  outtextxy(599,370,St);
  tipo := 1;
  pag := 1;
  totp := 7;
1:case totp of
        7:  case pag of
                  1: R1P1;
                  2: R1P2;
                  3: R1P3;
                  4: R1P4;
                  5: R1P5;
                  6: R1P6;
                  7: R1P7;
            end;
       18:  case pag of
                  1: R2P1;
                  2: R2P2;
                  3: R2P3;
                  4: R2P4;
                  5: R2P5;
                  6: R2P6;
                  7: R2P7;
                  8: R2P8;
                  9: R2P9;
                 10: R2P10;
                 11: R2P11;
                 12: R2P12;
                 13: R2P13;
                 14: R2P14;
                 15: R2P15;
                 16: R2P16;
                 17: R2P17;
                 18: R2P18;
            end;
       11:  case pag of
                  1: R3P1;
                  2: R3P2;
                  3: R3P3;
                  4: R3P4;
                  5: R3P5;
                  6: R3P6;
                  7: R3P7;
                  8: R3P8;
                  9: R3P9;
                 10: R3P10;
                 11: R3P11;
            end;
  end;
  settextstyle(3,0,0);
  settextjustify(2,0);
  setcolor(15);
  outtextxy(352,407,Int_to_Str(totp));
  SetFillStyle(1,7);
  settextjustify(2,0);
  settextstyle(3,0,0);
  bar(201,376,269,419);
  setcolor(15);
  outtextxy(272,407,Int_to_Str(Pag));
2:ch := getkey;
  case Ord(ch) of
       199:    begin
                 if pag = 1 then goto 2;
                 Pag := 1;
                 goto 1;
               end;
       207:    begin
                 if pag = totp then goto 2;
                 pag := totp;
                 goto 1;
               end;
       208,209:
               begin
                 if pag = totp then begin pag := 1; goto 1; end;
                 pag := pag + 1;
                 goto 1;
               end;
       200,201:
               begin
                 if pag = 1 then begin pag := totp; goto 1; end;
                 pag := pag - 1;
                 goto 1;
               end;
       128:    begin
                 if tipo = 1 then goto 2;
                 tipo := tipo - 1;
                 if tipo = 1 then begin R2(False); R1(True); end;
                 if tipo = 2 then begin R3(False); R2(True); end;
                 goto 2;
               end;
       129:    begin
                 if tipo = 3 then goto 2;
                 tipo := tipo + 1;
                 if tipo = 2 then begin R1(False); R2(True); end;
                 if tipo = 3 then begin R2(False); R3(True); end;
                 goto 2;
               end;
       9,205:  begin
                 if tipo = 3 then tipo := 0;
                 tipo := tipo + 1;
                 if tipo = 1 then begin R3(False); R1(True); end;
                 if tipo = 2 then begin R1(False); R2(True); end;
                 if tipo = 3 then begin R2(False); R3(True); end;
                 goto 2;
               end;
       143,203:
               begin
                 if tipo = 1 then tipo := 4;
                 tipo := tipo - 1;
                 if tipo = 1 then begin R2(False); R1(True); end;
                 if tipo = 2 then begin R3(False); R2(True); end;
                 if tipo = 3 then begin R1(False); R3(True); end;
                 goto 2;
               end;
       13,133: begin
                 if (tipo = 1) and (totp = 7) then goto 2;
                 if (tipo = 2) and (totp = 18) then goto 2;
                 if (tipo = 3) and (totp = 11) then goto 2;
                 if tipo = 1 then totp := 7;
                 if tipo = 2 then totp := 18;
                 if tipo = 3 then totp := 11;
                 pag := 1;
                 setfillstyle(1,7);
                 bar(281,376,349,419);
                 setfillstyle(1,0);
                 bar(404,361,609,374);
                 settextjustify(2,0);
                 settextstyle(2,0,0);
                 if tipo = 1 then St := 'Estrutura GeomÇtrica';
                 if tipo = 2 then St := 'Propriedades F°sicas dos Minerais';
                 if tipo = 3 then St := 'Testes Qu°micos';
                 setcolor(1);
                 outtextxy(600,371,St);
                 setcolor(15);
                 outtextxy(599,370,St);
                 goto 1;
               end;
       196:    begin
                 QSC;
                 setfillpattern(G50,6);
                 bar(1,465,638,478);
                 settextjustify(1,1);
                 settextstyle(0,0,0);
                 setcolor(7);
                 outtextxy(320,473,'F1 - Ajuda  Esc - Vai para o Menu principal  F10 - Sistemas Cristalinos');
                 setcolor(15);
                 outtextxy(319,472,'F1 - Ajuda  Esc - Vai para o Menu principal  F10 - Sistemas Cristalinos');
                 goto 2;
               end;
       27,132: begin
                 setfillpattern(G50,6);
                 bar(1,30,638,450);
                 goto 4;
               end;
       187:    begin
                 Ajuda(3);
                 goto 3;
               end;
       else
               goto 2;
  end;
4:
end;

{ EcrÑ do ClassificaáÑo dos minerais }
procedure CP1;
begin
  setfillstyle(1,3);
  bar(45,101,598,358);
  settextjustify(0,0);
  settextstyle(2,0,5);
  EscE(50,120,'Conhecem-se  actualmente mais de  2000  espÇcies de minerais; cerca de');
  EscE(50,135,'vinte novas espÇcies sÑo  descobertas cada ano, nas diversas  regiîes.');
  EscE(50,150,'Uma vez que cada espÇcie pode abranger diversas variedades - em geral');
  EscE(50,165,'resultantes  da presenáa, em  quantidades m°nimas, de um  elemento que');
  EscE(50,180,'nÑo  costuma  integrar sua  estrutura  cristalina -, o n£mero  total de');
  EscE(50,195,'minerais isolados Ç, naturalmente, muito grande.');
  EscE(50,210,'Os  minerologistas  classificam esta  profusÑo de espÇcies e variedades');
  EscE(50,225,'de  maneiras  diferentes, segundo  caracter°sticas  genÇticas, f°sicas,');
  EscE(50,240,'qu°micas ou estruturais, ou segundo a  cristaloqu°mica. AlÇm  disso, os');
  EscE(50,255,'minerais podem ser batizados a partir do local da descoberta, a partir');
  EscE(50,270,'do nome do descobridor ou em homenagem a uma pessoa.');
  EscE(50,285,'Um dos sistemas de maior aceitaáÑo, Ç o do alemÑo  H. Strunz. Trata-se');
  EscE(50,300,'de uma classificaáÑo cristaloqu°mica baseada no tipo de estrutura e na');
  EscE(50,315,'composiáÑo  qu°mica. Os  minerais sÑo  divididos  em nove  classes, as');
  EscE(50,330,'classes subdividem-se em grupos, os grupos  em sÇries e as sÇries  em');
  EscE(50,345,'fam°lias  que incluem  unidades isoladas  espec°ficas. SÑo as seguintes');
end;

{ EcrÑ do ClassificaáÑo dos minerais }
procedure CP2;
begin
  setfillstyle(1,3);
  bar(45,101,598,358);
  settextjustify(0,0);
  settextstyle(2,0,5);
  EscE(50,120,'as nove classes minerais:');
  EscE(50,150,'1. Elementos nativos (juntamente com os');
  EscE(70,165,'compostos, carbonetos, nitritos, fosfitos)');
  settextjustify(2,0); EscE(590,165,'Ò  50 espÇcies'); settextjustify(0,0);
  EscE(50,180,'2. Sulfetos (com seleniuretos, teluretos,');
  EscE(70,195,'arsenetos, antimonetos e bismutetos)');
  settextjustify(2,0); EscE(590,195,'Ò 300 espÇcies'); settextjustify(0,0);
  EscE(50,210,'3. Haletos');
  settextjustify(2,0); EscE(590,210,'Ò 100 espÇcies'); settextjustify(0,0);
  EscE(50,225,'4. Oxidos e hidr¢xidos');
  settextjustify(2,0); EscE(590,225,'Ò 250 espÇcies'); settextjustify(0,0);
  EscE(50,240,'5. Nitratos, carbonatos, boratos');
  settextjustify(2,0); EscE(590,240,'Ò 200 espÇcies'); settextjustify(0,0);
  EscE(50,255,'6. Sulfatos (com os cromatos, molibdatos, tungstatos)');
  settextjustify(2,0); EscE(590,255,'Ò 200 espÇcies'); settextjustify(0,0);
  EscE(50,270,'7. Fosfatos, arseniatos, vanadiatos');
  settextjustify(2,0); EscE(590,270,'Ò 350 espÇcies'); settextjustify(0,0);
  EscE(50,285,'8. Silicatos');
  settextjustify(2,0); EscE(590,285,'Ò 500 espÇcies'); settextjustify(0,0);
  EscE(50,300,'9. SubstÉncias orgÉnicas');
  settextjustify(2,0); EscE(590,300,'Ò  50 espÇcies'); settextjustify(0,0);
  EscE(50,330,'Os minerais mais largamente difundidos sÑo os silicatos, que constituem');
  EscE(50,345,'a maior parte da  litosfera. As seis  subdivisîes dessa  classe nÑo se');
end;

{ EcrÑ do ClassificaáÑo dos minerais }
procedure CP3;
begin
  setfillstyle(1,3);
  bar(45,101,598,358);
  settextjustify(0,0);
  settextstyle(2,0,5);
  EscE(50,120,'baseiam na composiáÑo qu°mica mas na estrutura do mineral.');
  EscE(50,135,'Todos  os  silicatos  contÇm  sil°cio (Si), um  elemento  tetravalente. A');
  EscE(50,150,'an†lise estrutural nos mostra que o iÑo de sil°cio (Si4+) est† sempre no');
  EscE(50,165,'centro de um tetraendro cujos vÇrtices sÑo ocupados por quatro iîes de');
  EscE(50,180,'oxigÇnio (O2-). Forma-se  dessa  maneira  a  s°lica (SiO4)4-,  estrutura');
  EscE(50,195,'b†sica dos silicatos. As subdivisîes dessa classe sÑo as seguintes:');
  EscE(50,225,'1. NESOSSILICATOS: Tetraedros isolados e distintos. Todas  as  valàncias');
  EscE(70,240,'livres  estÑo  saturadas com  catiîes. Exemplos: olivina, o grupo das');
  EscE(70,255,'granadas, top†zio, zircÑo.');
  EscE(50,270,'2. SOROSSILICATOS: Os tetraedros  formam pares  isolados, ligados entre');
  EscE(70,285,'si por um †tomo  de  oxigÇnio. Cria-se entÑo  a  estrutura (Si2O7)6-,');
  EscE(70,300,'com  as  seis  valàncias   livres  formando  uma  cadeia.  Exemplos:');
  EscE(70,315,'hemimorfita, epidoto, vesuvianita, ilva°ta.');
  EscE(50,330,'3. CICLOSSILICATOS: Tràs,  quatro  ou  seis   tetraedros (o  caso  mais');
  EscE(70,345,'habitual)  re£nem-se   formando   anÇis.  Exemplos:  berilo,  axinita,');
end;

{ EcrÑ do ClassificaáÑo dos minerais }
procedure CP4;
begin
  setfillstyle(1,3);
  bar(45,101,598,358);
  settextjustify(0,0);
  settextstyle(2,0,5);
  EscE(70,120,'turmalina, diopt†sio.');
  EscE(50,135,'4. INOSSILICATOS: TambÇm   conhecidos   como  silicatos   fibrosos.  Os');
  EscE(70,150,'tetraedros formam  cadeias que podem  ser simples (ou infinitas), no');
  EscE(70,165,'grupo  dos  piroxÇnios,  ou  duplas (ou  infinitas),  no  grupo  dos');
  EscE(70,180,'anfib¢lios. Os  minerais tÇm  uma  aparància  fibrosa  caracter°stica.');
  EscE(70,195,'Exemplos:    hedenberguita,    diops°dio  (piroxÇnios);    pargasita,');
  EscE(70,210,'hornblenda (anfib¢lios).');
  EscE(50,225,'5. FILOSSILICATOS: Os tràs pontos da  base de cada  tetraedro, em torno');
  EscE(70,240,'do †tomo  de s°lica, ligam-se aos pontos  das bases  dos  tetraedros');
  EscE(70,255,'vizinhos, formando superf°cies ou camadas. A f¢rmula (Si2=5)2- indica');
  EscE(70,270,'uma estrutura  na qual a relaáÑo da s°lica  para o oxigÇnio em  cada');
  EscE(70,285,'unidade Ç de 2 para 5. Exemplos: talco, crisotila, caolinita, etc.');
  EscE(50,300,'6. TECTOSSILICATOS: Os  tetraedros  juntam-se  nos   quatro   vÇrtices.');
  EscE(70,315,'Enquanto  nos  silicatos  de  camada  os  tetraedros estÑo dispostos');
  EscE(70,330,'tridimensionalmente, este  arranjo nÑo  deixa valàncias  livres  para');
  EscE(70,345,'†tomos de oxigÇnio - que nÑo poderiam, portanto, ligar-se a catiîes.');
end;

{ EcrÑ do ClassificaáÑo dos minerais }
procedure CP5;
begin
  setfillstyle(1,3);
  bar(45,101,598,358);
  settextjustify(0,0);
  settextstyle(2,0,5);
  EscE(70,120,'Mas as  ligaáîes ocorrem, pois  frequentemente o †tomo  tetravalente');
  EscE(70,135,'de s°lica Ç substitu°do por um †tomo trivalente de alum°nio.');
  EscE(50,165,'A  f¢rmula  qu°mica  do  ortocl†sio (K(AlSi3O8))  mostra,  por  exemplo,');
  EscE(50,180,'que  o  †tomo  Al  quebra  o  equil°brio  e  liberta  uma  valància  de');
  EscE(50,195,'oxigÇnio,  que  entÑo  pode  ligar-se  ao  catiÑo  K. Outros  exemplos:');
  EscE(50,210,'albita, anortita, leucita, analcima.');
end;

{ Controlador do Teclado do ecrÑ ClassificaáÑo dos minerais }
procedure Clas;
Label 1,2,3,4,5;
var pag : byte;
begin
  Ec('ClassificaáÑo dos Minerais','F1 - Ajuda  Esc - Vai para o Menu principal  End - Ultima p†gina');
  goto 5;
3:Ec2('ClassificaáÑo dos Minerais','F1 - Ajuda  Esc - Vai para o Menu principal  End - Ultima p†gina');
5:outtextxy(45,385,'Esc   F1');
  outtextxy(45,395,'PgDn  PgUp  Home  End');
  outtextxy(45,405,'            SetaC SetaB');
  outtextxy(45,415,'      ClicD');
  settextjustify(1,1);
  settextstyle(8,0,0);
  EscE(320,73,'Como sÑo classificados');
  setcolor(2);
  line(45,100,594,100);
  setcolor(15);
  line(44,99,593,99);
  CP1;
  pag := 1;
  settextstyle(3,0,0);
  settextjustify(2,0);
  setcolor(15);
  outtextxy(352,407,'5');
1:SetFillStyle(1,7);
  settextjustify(2,0);
  settextstyle(3,0,0);
  bar(201,376,269,419);
  setcolor(15);
  outtextxy(272,407,Int_to_Str(Pag));
2:ch:= getkey;
  case Ord(ch) of
       208,209:
               begin
                 pag := pag + 1;
                 if pag = 6 then pag := 1;
                 case pag of
                      1: CP1;
                      2: CP2;
                      3: CP3;
                      4: CP4;
                      5: CP5;
                 end;
                 goto 1;
               end;
       200,201:
               begin
                 pag := pag - 1;
                 if pag = 0 then pag := 5;
                 case pag of
                      1: CP1;
                      2: CP2;
                      3: CP3;
                      4: CP4;
                      5: CP5;
                 end;
                 goto 1;
               end;
       199:    begin
                 if pag = 1 then goto 2;
                 pag := 1;
                 CP1;
                 goto 1;
               end;
       207:    begin
                 if pag = 5 then goto 2;
                 pag := 5;
                 CP5;
                 goto 1;
               end;
       27,132: begin
                 setfillpattern(G50,6);
                 bar(1,30,638,450);
                 goto 4;
               end;
       187:    begin
                 Ajuda(4);
                 goto 3;
               end;
       else
               goto 2;
  end;
4:
end;

{ Procedure utilizada pelo ecrÑ Litosfera }
procedure Say(x,y: integer; E,S,P: string);
begin
  EscE(x,y,E);
  EscE(x+110,y,S);
  EscE(x+150,y,P);
end;

{ P†gina 1 do ecrÑ Litosfera }
procedure Pag1;
begin
  settextstyle(2,0,5);
  setcolor(7);
  Say(50,155,'OxigÇnio','O','46,6%');
  Say(50,170,'Sil°cio','Si','27,7%');
  Say(50,185,'Alum°nio','Al',' 8,1%');
  Say(50,200,'Ferro','Fe',' 5,0%');
  Say(50,215,'C†lcio','Ca',' 3,6%');
  Say(50,230,'S¢dio','Na',' 2,8%');
  Say(50,245,'Pot†ssio','K',' 2,6%');
  Say(50,260,'M†gnÇsio','Mg',' 2,1%');
  Say(50,275,'TitÉnio','Ti',' 0,4%');
  Say(50,290,'HidrogÇnio','H',' 0,1%');
  Say(50,305,'F¢sforo','P',' 0,1%');
  Say(50,320,'Manganàs','Mn',' 0,1%');
  Say(50,335,'Enxofre','S',' 0,05%');
  Say(50,350,'Carbono','C',' 0,03%');
  Say(335,155,'Cloro','Cl',' 0,03%');
  Say(335,170,'Rub°dio','Rb',' 0,03%');
  Say(335,185,'Fluor','F',' 0,03%');
  Say(335,200,'Estrìncio','Sr',' 0,03%');
  Say(335,215,'B†rio','Ba',' 0,02%');
  Say(335,230,'Zirc¢nio','Zr',' 0,02%');
  Say(335,245,'Cromo','Cr',' 0,02%');
  Say(335,260,'Van†dio','V',' 0,01%');
  Say(335,275,'Zinco','Zn',' 0,01%');
  Say(335,290,'N°quel','Ni',' 0,008%');
  Say(335,305,'Cobre','Cu',' 0,007%');
  Say(335,320,'TungstÇnio','W',' 0,007%');
  Say(335,335,'L°tio','Li',' 0,006%');
  Say(335,350,'Azoto','N',' 0,005%');
end;

{ P†gina 2 do ecrÑ Litosfera }
procedure Pag2;
begin
  settextstyle(2,0,5);
  setcolor(7);
  Say(50,155,'CÇrio','Ce',' 0,005%');
  Say(50,170,'Estanho','Sn',' 0,004%');
  Say(50,185,'Itrio','Y',' 0,003%');
  Say(50,200,'Neod°mio','Nd',' 0,002%');
  Say(50,215,'Ni¢bio','Nb',' 0,002%');
  Say(50,230,'Cobalto','Co',' 0,002%');
  Say(50,245,'LantÉnio','La',' 0,002%');
  Say(50,260,'Chumbo','Pb',' 0,002%');
  Say(50,275,'G†lio','Ga',' 0,001%');
  Say(50,290,'MolibdÇnio','Mo',' 0,001%');
  Say(50,305,'T¢rio','Th',' 0,001%');
  Say(50,320,'CÇsio','Cs',' 0,0007%');
  Say(50,335,'GermÉnio','Ge',' 0,0007%');
  Say(50,350,'Ber°lio','Be',' 0,0007%');
  Say(335,155,'Sam†rio','Sm',' 0,0006%');
  Say(335,170,'Gadol°nio','Gd',' 0,0005%');
  Say(335,185,'Praseod°mio','Pr',' 0,0005%');
  Say(335,200,'EscÉndio','Sc',' 0,0005%');
  Say(335,215,'ArsÇnio','As',' 0,0005%');
  Say(335,230,'H†fnio','Hf',' 0,0004%');
  Say(335,245,'Dispr¢sio','Dy',' 0,0004%');
  Say(335,260,'UrÉnio','U',' 0,0004%');
  Say(335,275,'Boro','B',' 0,0003%');
  Say(335,290,'ItÇrbio','Yb',' 0,0003%');
  Say(335,305,'êrbio','Er',' 0,0002%');
  Say(335,320,'TÉntalo','Ta',' 0,0002%');
  Say(335,335,'Bromo','Br',' 0,0002%');
  Say(335,350,'H¢lmio','Ho',' 0,0001%');
end;

{ P†gina 3 do ecrÑ Litosfera }
procedure Pag3;
begin
  settextstyle(2,0,5);
  setcolor(7);
  Say(50,155,'Eur¢pio','Eu',' 0,0001%');
  Say(50,170,'Antim°nio','Sb',' 0,0001%');
  Say(50,185,'TÇrbio','Tb',' 0,00009%');
  Say(50,200,'LutÇcio','Lu',' 0,00008%');
  Say(50,215,'T†lio','Tl',' 0,00006%');
  Say(50,230,'Merc£rio','Hs',' 0,00005%');
  Say(50,245,'Iodo','I',' 0,00003%');
  Say(50,260,'Bismuto','Bi',' 0,00002%');
  Say(50,275,'T£lio','Tm',' 0,00002%');
  Say(50,290,'C†dmio','Cd',' 0,00001%');
  Say(50,305,'Prata','Ag',' 0,00001%');
  Say(50,320,'Indio','In',' 0,00001%');
  Say(50,335,'SelÇnio','Se',' 0,00001%');
  Say(50,350,'Argon','Ar',' 0,000004%');
  Say(335,155,'Pal†dio','Pd',' 0,000001%');
  Say(335,170,'Platina','Pt',' 0,0000005%');
  Say(335,185,'Ouro','Au',' 0,0000005%');
  Say(335,200,'HÇlio','He',' 0,0000003%');
  Say(335,215,'Tel£rio','Te',' 0,0000002%');
  Say(335,230,'R¢dio','Rh',' 0,0000001%');
  Say(335,245,'RÇnio','Re',' 0,0000001%');
  Say(335,260,'Ir°dio','Ir',' 0,0000001%');
  Say(335,275,'Osmio','Os',' 0,0000001%');
  Say(335,290,'RutÇnio','Ru',' 0,0000001%');
  Say(335,305,'R†dio','Ra',' 0,0000000001%');
end;

{ Controlador do teclado no ecrÑ Litosfera }
procedure Lito;
Label 1,2,3,4,5;
var pag : string;
begin
  Ec('Litosfera','F1 - Ajuda  Esc - Vai para o Menu principal  End - Ultima p†gina');
  goto 5;
3:Ec2('Litosfera','F1 - Ajuda  Esc - Vai para o Menu principal  End - Ultima p†gina');
5:outtextxy(45,385,'Esc   F1');
  outtextxy(45,395,'PgDn  PgUp  Home  End');
  outtextxy(45,405,'            SetaC SetaB');
  outtextxy(45,415,'       ClicD');
  settextstyle(2,0,5);
  EscE(50, 75,'  A Litosfera (parte s¢lida da Terra) contÇm valiosas reliquias as quais');
  EscE(50, 90,'sÑo formadas atravÇs de elementos simples. A seguinte lista indica-nos');
  EscE(50,105,'esses elementos consoante a sua percentagem na litosfera.');
  EscE(50,135,'Elemento    S°mbolo    Percentagem   Elemento    S°mbolo    Percentagem');
  setcolor(2);
  line(50,141,595,141);
  line(320,126,320,355);
  setcolor(15);
  line(49,140,594,140);
  line(319,125,319,354);
  Pag1;
  Pag := '1';
1:SetFillStyle(1,7);
  settextjustify(2,0);
  settextstyle(3,0,0);
  bar(201,376,269,419);
  setcolor(15);
  outtextxy(272,407,Pag);
  outtextxy(352,407,'3');
  settextjustify(0,0);
  settextstyle(2,0,5);
2:ch := getkey;
  case Ord(ch) of
       208,209:
               begin
                 setfillstyle(1,3); bar(45,142,318,358); bar(321,142,598,358);
                 if Pag = '1' then begin Pag2; Pag := '2'; goto 1; end;
                 if Pag = '2' then begin Pag3; Pag := '3'; goto 1; end;
                 if Pag = '3' then begin Pag1; Pag := '1'; goto 1; end;
               end;
       200,201:
               begin
                 setfillstyle(1,3); bar(45,142,318,358); bar(321,142,598,358);
                 if Pag = '1' then begin Pag3; Pag := '3'; goto 1; end;
                 if Pag = '2' then begin Pag1; Pag := '1'; goto 1; end;
                 if Pag = '3' then begin Pag2; Pag := '2'; goto 1; end;
               end;
       199:    begin
                 if Pag = '1' then goto 2;
                 setfillstyle(1,3); bar(45,142,318,358); bar(321,142,598,358);
                 Pag1; Pag := '1'; goto 1;
               end;
       207:    begin
                 if Pag = '3' then goto 2;
                 setfillstyle(1,3); bar(45,142,318,358); bar(321,142,598,358);
                 Pag3; Pag := '3'; goto 1;
               end;
       27,132: begin
                 setfillpattern(G50,6);
                 bar(1,30,638,450);
                 goto 4;
               end;
       187:    begin
                 Ajuda(5);
                 goto 3;
               end;
       else
               goto 2;
  end;
4:
end;

end.