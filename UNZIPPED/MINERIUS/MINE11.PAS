{ Auxiliar nß 1 do auxiliar 1 do MinÇrius }
Unit Mine11;

interface

uses Crt, Graph, Printer, Mine21, Mine3, KeyTTT5, StrnTTT5, MiscTTT5;

procedure Pagp(nume: byte);

implementation

const G50: FillPatternType = ($AA, $55, $AA, $55, $AA, $55, $AA, $55);

var ch: char; v,d: word;

{ Mostra a percentagem imprimida }
procedure Perc(vp: byte);
begin
  setfillstyle(1,0);
  bar(130,190,400,320);
  settextstyle(7,0,10);
  settextjustify(2,0);
  setcolor(1);
  outtextxy(400,300,Int_to_Str(vp));
  setcolor(15);
  outtextxy(395,295,Int_to_Str(vp));
end;

{ Completa proc. que controla o teclado, escreve no ecrÑ e imprime }
procedure Fez(v1,v2,v3,v4,v5:string;v6,v7,v8:byte;v9,v10:string;v11,v12,v13,v14,v16,v17,v18,v19,v20,v21,v22,v23,v25:integer);
Label 1,2,3,4;
var tt: string;
    p3,p4,p5: pointer;
    s3,s4,s5: word;
begin
  S3 := ImageSize(119,114,530,355);
  GetMem(P3, S3);
  GetImage(119,114,530,355,P3^);
  setfillpattern(G50,2);
  bar(130,125,530,355);
  setfillstyle(1,0);
  bar(119,114,520,345);
  setcolor(1);
  rectangle(121,116,520,345);
  line(121,186,520,186);
  line(121,188,520,188);
  setcolor(15);
  rectangle(120,115,519,344);
  line(120,185,519,185);
  line(120,187,519,187);
  setfillpattern(G50,6);
  bar(1,465,638,478);
  settextjustify(1,1);
  settextstyle(0,0,0);
  setcolor(7);
  outtextxy(320,473,'F1 - Ajuda  Esc - Volta atr†s  Enter - Imprime mineral');
  setcolor(15);
  outtextxy(319,472,'F1 - Ajuda  Esc - Volta atr†s  Enter - Imprime mineral');
  settextstyle(2,0,6);
  settextjustify(1,0);
  EscE2(320,135,'Prepare a impressora em LPT1 e');
  EscE2(320,155,'pressione ENTER para imprimir');
  EscE2(320,175,'ou ESC para voltar atr†s');
  EscE2(320,335,'(Percentagem imprimida)');
  settextstyle(7,0,10);
  settextjustify(2,0);
  setcolor(1);
  outtextxy(490,300,'%');
  setcolor(15);
  outtextxy(485,295,'%');
  Perc(0);
2:ch:= getkey;
  case Ord(ch) of
       187:    begin
                 S4 := ImageSize(42,61,598,240);
                 GetMem(P4, S4);
                 S5 := ImageSize(42,241,598,420);
                 GetMem(P5, S5);
                 GetImage(42,61,598,240,P4^);
                 GetImage(42,241,598,420,P5^);
                 Ajuda(11);
                 setfillpattern(G50,6);
                 bar(1,1,638,14);
                 bar(1,465,638,478);
                 settextjustify(1,1);
                 settextstyle(0,0,0);
                 setcolor(7);
                 outtextxy(320,9,'MinÇrius - Lista dos Minerais');
                 outtextxy(320,473,'F1 - Ajuda  Esc - Volta atr†s  Enter - Imprime mineral');
                 setcolor(15);
                 outtextxy(319,8,'MinÇrius - Lista dos Minerais');
                 outtextxy(319,472,'F1 - Ajuda  Esc - Volta atr†s  Enter - Imprime mineral');
                 PutImage(42,61,P4^,0);
                 FreeMem(p4,s4);
                 PutImage(42,241,P5^,0);
                 FreeMem(p5,s5);
                 goto 2;
               end;
       13,133: goto 3;
       27,132: goto 4;
       else
               goto 2;
  end;
3:If not Printer_Ready then
     begin
       setfillstyle(1,0);
       bar(122,117,518,184);
       settextjustify(1,0);
       settextstyle(2,0,6);
       Beep;
       EscE2(320,155,'A impressora nÑo est† pronta');
       delay(2000);
       goto 4;
     end;
  setfillstyle(1,0);
  bar(122,117,518,184);
  settextjustify(1,0);
  settextstyle(2,0,6);
  EscE2(320,155,'Aguarde enquanto imprime');
{$I-}
  writeln(lst,#27,'G',#14,PadCenter(v1,40,' '));
  writeln(lst,#27,'4',#27, 'E','');
  Perc(5);
  writeln(lst,'F¢rmula qu°mica: '+v2);
  Perc(10);
  writeln(lst,'ComposiáÑo qu°mica: '+v3);
  Perc(15);
  writeln(lst,'Encontra-se em: '+v4);
  Perc(20);
  case v12 of
       0: tt:= 'nÑo Ç fluorescente ou radioactivo';
       2: tt:= 'mineral fluorescente';
       4: tt:= 'mineral radioactivo';
       6: tt:= 'mineral fluorescente e radioactivo';
  end;
  writeln(lst,'Tipo de mineral: '+tt);
  Perc(25);
  case v11 of
       1: tt:= 'Elemento Nativo';
       2: tt:= 'Sulfato';
       3: tt:= 'HalogÇnio ou Haleto';
       4: tt:= 'Oxido ou Hidroxido';
       5: tt:= 'Carbonato, Nitrato ou Borato';
       6: tt:= 'Cromato, Molibdato ou Tungstato';
       7: tt:= 'Fosfato, Arseniato ou Vanadato';
       8: tt:= 'Silicato';
  end;
  writeln(lst,'Classe mineral: '+tt);
  Perc(30);
  case v20 of
        2: tt:= 'em †gua (H2O)';
        4: tt:= 'em †cido clor°drico (HCI)';
        6: tt:= 'em †gua e em †cido clor°drico';
        8: tt:= 'em †cido n°trico (HNO3)';
       10: tt:= 'em †gua e em †cido n°trico';
       12: tt:= 'em †cido clor°drico e n°trico';
       14: tt:= 'em †gua, †cido clor°drico e n°trico';
       16: tt:= 'em †cido sulf£rico (H2SO4)';
       18: tt:= 'em †gua e em †cido sulf£rico';
       20: tt:= 'em †cido cloridrico e sulf£rico';
       22: tt:= 'em †gua, †cido clor°drico e sulf£rico';
       24: tt:= 'em †cido n°trico e sulf£rico';
       26: tt:= 'em †gua, †cido n°trico e sulf£rico';
       28: tt:= 'em †cido clor°drico, n°trico e sulf£rico';
       30: tt:= 'em †gua, †cido clor°drico, n°trico e sulf£rico';
       32: tt:= 'em †cido fluor°drico (HF)';
       34: tt:= 'em †gua e em †cido fluor°drico';
       36: tt:= 'em †cido clor°drico e fluor°drico';
       38: tt:= 'em †gua, †cido clor°drico e fluor°drico';
       40: tt:= 'em †cido n°trico e fluor°drico';
       42: tt:= 'em †gua, †cido n°trico e fluor°drico';
       44: tt:= 'em †cido clor°drico, n°trico e fluor°drico';
       46: tt:= 'em †gua, †cido clor°drico, n°trico e fluor°drico';
       48: tt:= 'em †cido sulf£rico e fluor°drico';
       50: tt:= 'em †gua, †cido sulf£rico e fluor°drico';
       52: tt:= 'em †cido clor°drico, sulf£rico e fluor°drico';
       54: tt:= 'em †gua, †cido clor°drico, sulf£rico e fluor°drico';
       56: tt:= 'em †cido n°trico, sulf£rico e fluor°drico';
       58: tt:= 'em †gua, †cido n°trico, sulf£rico e fluor°drico';
       60: tt:= 'em †cido clor°drico, n°trico, sulf£rico e fluor°drico';
       62: tt:= 'em †gua, †cido clor°drico, n°trico, sulf£rico e fluor°drico';
       64: tt:= 'Insol£vel em †cidos';
  end;
  writeln(lst,'Solubilidade: '+tt);
  Perc(35);
  case v21 of
       1: tt:= 'Muito rara';
       2: tt:= 'Rara';
       3: tt:= 'Comum';
       4: tt:= 'Muito comum';
  end;
  writeln(lst,'Ocorrància do mineral na Terra: '+tt);
  Perc(40);
  case v22 of
        2: tt:= 'Rochas °gneas';
        4: tt:= 'Rochas metam¢rficas';
        6: tt:= 'Rochas °gneas e metam¢rficas';
        8: tt:= 'Rochas sedimentares e dep¢sitos hidrotermais';
       10: tt:= 'Rochas °gneas, sedimentares e dep¢sitos hidrotermais';
       12: tt:= 'Rochas metam¢rficas, sedimentares e dep¢sitos hidrotermais';
       14: tt:= 'Rochas °gneas, metam¢rficas, sedimentares e dep¢s. hidrotermais';
  end;
  writeln(lst,'Origem: '+tt);
  Perc(45);
  case v23 of
        2: tt:= 'Metalurgia, industria de construáÑo';
        4: tt:= 'Joalharia';
        6: tt:= 'Metalurgia, industria de construáÑo e Joalharia';
        8: tt:= 'Ind£stria qu°mica';
       10: tt:= 'Metalurgia, industria de construáÑo e industria qu°mica';
       12: tt:= 'Metalurgia, industria de construáÑo Joalharia';
       14: tt:= 'Metalurgia, industria de construáÑo, ind£stria qu°mica e Joalharia';
       16: tt:= 'Colecionadores, pesquisa cient°fica';
       18: tt:= 'Metalurgia, ind. de construáÑo, colecionadores, pesquisa cient°fica';
       20: tt:= 'Joalharia, colecionadores, pesquisa cient°fica';
       22: tt:= 'Metalurgia, ind. de construáÑo, joalharia, colec., pesq. cient°fica';
       24: tt:= 'Ind. qu°mica, colecionadores, pesquisa cient°fica';
       26: tt:= 'Metalurgia, ind. de construáÑo, qu°mica, colecio., pesq. cient°fica';
       28: tt:= 'Ind. qu°mica, joalharia, colecionadores, pesquisa cient°fica';
       30: tt:= 'Metalurgia, ind. constru., qu°mica, joalharia, colec., pesq. cient.';
  end;
  writeln(lst,'Uso: '+tt);
  Perc(50);
  case v25 of
       0: tt:= 'NÑo Ç perecivel';
       1: tt:= 'ê perecivel';
  end;
  writeln(lst,'Cor predominante: '+v5);
  Perc(55);
  writeln(lst,'PreservaáÑo: '+tt);
  Perc(60);
  writeln(lst,'Densidade: '+v9+' g/cm3');
  Perc(65);
  writeln(lst,'Dureza: '+v10+' Mohs');
  Perc(70);
  case v13 of
       1: tt:= 'C£bico';
       2: tt:= 'Hexagonal';
       3: tt:= 'Trigonal';
       4: tt:= 'Tetragonal';
       5: tt:= 'Ortorrìmbico';
       6: tt:= 'Monocl°nico';
       7: tt:= 'Tricl°nico';
  end;
  writeln(lst,'Sistema cristalino: '+tt);
  Perc(75);
  case v14 of
       1: tt:= 'Perfeita';
       2: tt:= 'Imperfeita';
       3: tt:= 'InÇxistente';
  end;
  writeln(lst,'Tipo de Clivagem: '+tt);
  Perc(80);
  case v16 of
        1: tt:= 'Branco/incolor';
        2: tt:= 'Cinzento';
        3: tt:= 'Preto';
        4: tt:= 'Amarelo';
        5: tt:= 'Verde';
        6: tt:= 'Castanho';
        7: tt:= 'Azul';
        8: tt:= 'Vermelho';
        9: tt:= 'Laranja';
       10: tt:= 'Roxo';
  end;
  writeln(lst,'Cor do p¢ do mineral: '+tt);
  Perc(85);
  case v17 of
        0: tt:= 'NÑo tem brilho';
        1: tt:= 'Adamantino';
        2: tt:= 'Subadamantino';
        3: tt:= 'V°treo';
        4: tt:= 'Met†lico';
        5: tt:= 'Submet†lico';
        6: tt:= 'Nacarado';
        7: tt:= 'Sedoso';
        8: tt:= 'Resinoso';
        9: tt:= 'Oleoso';
       10: tt:= 'Opaco';
  end;
  writeln(lst,'Tipo de brilho: '+tt);
  Perc(90);
  case v18 of
       1: tt:= 'Fus°vel';
       2: tt:= 'Resistente Ö fusÑo';
       3: tt:= 'Infusivel';
  end;
  writeln(lst,'Fusibilidade: '+tt);
  Perc(95);
  case v19 of
       0: tt:= 'nÑo tem chama';
       1: tt:= 'Amarela';
       2: tt:= 'Verde';
       3: tt:= 'Vermelha';
       4: tt:= 'Laranja';
       5: tt:= 'Roxo';
       6: tt:= 'Laranja-amarelada';
       7: tt:= 'Verde-amarelado';
  end;
  writeln(lst,'Cor da chama: '+tt);
  writeln(lst,#27,'5', '');
  writeln(lst,PadRight('MinÇrius  programado em Pascal por Isaac MSC',80,' '));
  Perc(100);
  writeln(lst,#27,'F',#12);
{$I+}
  setfillstyle(1,0);
  bar(122,117,518,184);
  settextstyle(2,0,5);
  settextstyle(2,0,6);
  settextjustify(1,0);
  EscE2(320,155,'ImpressÑo completa');
  delay(1500);
4:PutImage(119,114,P3^,0);
  FreeMem(p3,s3);
  setfillpattern(G50,6);
  bar(1,465,638,478);
  settextjustify(1,1);
  settextstyle(0,0,0);
  setcolor(7);
  outtextxy(320,473,'F1 - Ajuda  Esc - Vai para o Menu principal  F10 - Imprime dados sobre mineral');
  setcolor(15);
  outtextxy(319,472,'F1 - Ajuda  Esc - Vai para o Menu principal  F10 - Imprime dados sobre mineral');
end;

{ PAGP+p†g. desejada, os dados que aparecem no ecrÑ passam para a impressora }
procedure Pagp(nume: byte);
begin
  case nume of
         1: Fez('Actinolita','Ca2(Mg,Fe'''')5Si8O22(OH)2','Silicato de c†lcio, magnÇsio e ferro',
                'Asia Central, Austria, Nova ZelÉndia','Verde',10,32,10,'3,2','5,7',8,0,6,1,5,
                3,1,0,64,4,4,4,0);
         2: Fez('Adamita','Zn2AsO4(OH)','Arsenato de zinco',
                'ArgÇlia, EUA, GrÇcia, It†lia, MÇxico','Verde',10,32,10,'4,4','3,5',7,2,5,1,1,
                3,1,0,28,1,10,16,0);
         3: Fez('Adul†ria','KAlSi3O8','Aluminossilicato de pot†ssio',
                'Alpes Su°áos, Austria e It†lia','Branco',60,60,60,'2,5','6,3',8,0,6,1,1,
                3,3,0,32,2,14,4,0);
         4: Fez('Analcima','NaAlSi2O6.H2O','Silicato hidratado de s¢dio e alum°nio',
                'Austr†lia, EUA','Branco',60,60,60,'2,3','5,5',8,0,1,3,1,
                3,1,1,28,4,10,16,0);
         5: Fez('Anat†sio','·-TiO2','Di¢xido de titÉnio',
                'Noruega, Inglaterra, EUA, a.URSS','Cinzento',40,40,40,'3,8','5,8',4,0,4,1,1,
                 1,3,0,64,1,12,16,0);
         6: Fez('Anglesita','PbSO4','Sulfato de chumbo',
                'Espanha, Tun°sia, Pa°s de Gales, Brasil','Branco',60,60,60,'6,3','3,0',6,2,5,1,1,
                1,1,0,8,2,10,2,0);
         7: Fez('Ankerita','Ca(Fe,Mg,Mn)(CO3)2','Carbonato de c†lcio e ferro com magnÇsio e manganàs',
                'It†lia, Su°áa, Franáa','Branco',60,60,60,'3,0','3,5',5,0,3,1,1,
                3,3,4,28,2,10,16,0);
         8: Fez('Antofilita','(Mg,Fe)7(Si8O22)(OH)22','Silicato b†sico de magnÇsio e ferro bivalente',
                'GroenlÉndia, FinlÉndia, Noruega','Verde',10,32,10,'3,1','5,5',8,0,5,1,1,
                3,2,0,64,2,4,16,0);
         9: Fez('Apatita','Ca5(F,Cl,OH)(PO4)3','Fosfato de c†lcio contendo v†rios aniîes',
                'MÇxico, Alemanha, Brasil, Austria, Canad†','Azul',9,21,63,'3,2','5,0',7,2,2,2,1,
                3,2,0,28,4,10,12,0);
        10: Fez('Apofilita','KCa4(Si4O10)2F.8H2O','Fluorsilicato hidratado de c†lcio e pot†ssio',
                'India, Canad†, IslÉndia, It†lia','Verde',10,32,10,'2,4','4,8',8,0,4,1,1,
                3,1,5,4,2,10,16,0);
        11: Fez('Aragonita','CaCO3','Carbonato de c†lcio',
                'Espanha, Franáa, Inglaterra','Branco',60,60,60,'3,0','3,8',5,2,5,2,1,
                8,3,4,28,2,12,16,0);
        12: Fez('Argentita','Ag2S','Sulfato de prata',
                'Noruega, Peru, MÇxico, EUA, Bol°via','Cinzento',40,40,40,'7,4','2,3',2,0,1,3,2,
                4,1,0,8,2,10,2,1);
        13: Fez('ArsÇnio','As','ArsÇnio em estado nativo',
                'RomÇnia, Franáa, JapÑo, Alemanha','Preto',8,8,8,'5,7','3,6',1,0,3,1,3,
                4,3,0,8,1,10,16,0);
        14: Fez('Arsenopirita','FeAsS','Sulfoarseniato de ferro',
                'Portugal, Austria, SuÇcia, BÇlgica, Alemanha','Cinzento',40,40,40,'6,1','5,9',2,0,6,1,2,
                4,1,0,8,3,14,2,0);
        15: Fez('Artinita','Mg2CO3(OH)2.3H2O','Carbonato b†sico hidratado de magnÇsio',
                'It†lia, EUA, a.Jugosl†via, Austria','Branco',60,60,60,'2,0','2,0',5,0,6,1,1,
                7,3,0,28,2,12,16,0);
        16: Fez('Atacamita','Cu2Cl(OH)3','Cloreto b†sico de cobre',
                'Chile, Peru, Bol°via, MÇxico, Austr†lia','Verde',10,32,10,'3,7','3,4',3,0,5,1,5,
                3,1,2,4,2,2,18,0);
        17: Fez('Auricalcita','(Zn,Cu)5(CO3)2(OH)6','Carbonato b†sico de zinco e cobre',
                'EUA, MÇxico, Inglaterra','Azul',9,21,63,'3,9','2,0',5,0,5,1,7,
                6,3,2,4,1,10,16,0);
        18: Fez('Autunita','Ca(UO2)2(PO4)2.10-12H2O','Fosfato hidratado de c†lcio e urÉnio',
                'Portugal, Franáa, Austr†lia, Alemanha','Verde',10,32,10,'3,1','2,0',7,6,4,2,4,
                3,1,0,30,2,14,2,0);
        19: Fez('Azurita','Cu3(CO3)2(OH)2','Carbonato b†sico de cobre',
                'a.URSS, It†lia, Nam°bia, GrÇcia','Azul',9,21,63,'3,7','3,7',5,0,6,1,7,
                1,1,2,28,2,10,4,1);
        20: Fez('Barita','BaSO4','Sulfato de b†rio',
                'RomÇnia, Brasil, EUA, Saara','Castanho',24,12,0,'4,4','3,3',6,2,5,1,1,
                3,2,7,64,3,10,10,0);
        21: Fez('Berilo','Al2Be3(Si6O18)','Silicato de ber°lio e alum°nio',
                'Colìmbia, Africa do Sul, Madag†scar, Brasil','Verde',10,32,10,'2,7','7,8',8,0,2,2,1,
                3,2,0,64,3,2,14,0);
        22: Fez('Betafita','(U,Ca)2(Ti,Nb,Ta)2O6(O,OH,F)','Oxido de urÉnio, c†lcio, titÉnio, ni¢bio e tÉntalo',
                'a.URSS, Canad†, Noruega, It†lia','Castanho',24,12,0,'5,6','4,2',4,4,1,3,2,
                3,2,0,28,1,6,2,0);
        23: Fez('Biotita','K(Mg,Fe)3AlSi3O10(OH)2','Silicato b†sico de pot†ssio, magnÇsio, ferro e alum°nio',
                'a.URSS, GroenlÉndia, Brasil','Preto',8,8,8,'3,2','2,7',8,0,6,1,6,
                3,2,0,20,4,6,16,0);
        24: Fez('Bismutinita','Bi2S3','Sulfato de bismuto',
                'Peru, MÇxico, Bol°via','Cinzento',40,40,40,'7,1','2,0',2,0,5,1,2,
                4,1,0,8,2,10,2,0);
        25: Fez('Bismutita','BiO2.CO3','Oxicarbonato de bismuto',
                'Espanha, Alemanha, TasmÉnia, EUA','Verde',10,32,10,'7,6','3,9',5,0,4,2,5,
                3,1,0,12,2,8,16,0);
        26: Fez('B¢rax','Na2B4O7.10H2O','Borato hidratado de s¢dio',
                'Tibete, IrÑo, EUA','Branco',60,60,60,'1,8','2,3',5,0,6,1,1,
                9,1,7,2,2,8,10,1);
        27: Fez('Bornita','Cu5FeS4','Sulfato de cobre e ferro',
                'Inglaterra, ZÉmbia, Austr†lia, Alemanha','Azul',9,21,63,'5,2','3,0',2,0,1,2,2,
                4,1,2,28,2,10,2,1);
        28: Fez('Bournonita','PbCuSbS3','Sulfoantimoniato de cobre e chumbo',
                'Espanha, It†lia, EUA, Peru, Chile','Cinzento',40,40,40,'5,8','3,0',2,0,5,1,2,
                4,1,0,8,2,10,2,1);
        29: Fez('Brasilianita','NaAl3(PO4)2(OH)4','Fosfato b†sico de s¢dio e alum°nio',
                'Brasil, EUA','Verde',10,32,10,'3,0','5,5',7,0,6,1,1,
                3,2,1,28,1,2,18,0);
        30: Fez('Brookita','x-TiO2','Oxido de titÉnio',
                'Suiáa, It†lia, EUA, Franáa','Vermelho',42,0,0,'4,1','5,7',4,0,5,2,4,
                1,3,0,64,1,12,16,0);
        31: Fez('Brucita','Mg(OH)2','Hidr¢xido de magnÇsio',
                'Canad†, a.URSS, USA','Verde',10,32,10,'2,4','2,5',4,0,3,1,1,
                7,3,0,28,2,12,10,0);
        32: Fez('Buerguerita','NaFe3''''''Al6B3Si6O30F','Ciclossilicato composto contendo boro',
                'MÇxico','Preto',8,8,8,'3,3','7,0',8,0,3,1,4,
                3,3,0,64,1,2,16,0);
        33: Fez('Cabazita','(Ca,Na2)(Al2Si4O12).6H2O','Aluminossilicato hidratado de c†lcio e s¢dio',
                'Alemanha, EUA, It†lia, Irlanda','Transparente',0,46,46,'2,1','4,5',8,0,3,1,1,
                3,1,0,4,3,14,16,0);
        34: Fez('Calced¢nia','SiO2','Oxido de sil°cio',
                'Austr†lia, Uruguai, Brasil, India','Amarelo',63,51,0,'2,6','6,8',4,0,3,3,2,
                3,3,0,32,3,8,12,0);
        35: Fez('Calcita','CaCO3','Carbonato de c†lcio',
                'Brasil, SuÇcia, Franáa, Noruega','Branco',60,60,60,'2,7','3,0',5,2,3,1,1,
                3,3,4,28,4,14,10,0);
        36: Fez('Calcopirita','CuFeS2','Sulfato de cobre e ferro',
                'EUA, Chile, Canad†, Zaire, Chipre','Amarelo',63,51,0,'4,2','3,8',2,0,4,3,5,
                4,1,2,8,4,14,2,1);
        37: Fez('Carnotita','K2 (UO2)2(VO4)2. 3H2O','Vanadato hidratado de uranila e pot†ssio',
                'a.URSS, EUA, Africa','Amarelo',63,51,0,'4,5','2,3',7,4,6,1,4,
                0,3,5,30,2,8,2,0);
        38: Fez('Cassiterita','SnO2','Oxido de estanho',
                'Franáa, Tchecoslov†quia','Preto',8,8,8,'6,9','6,6',4,0,4,2,4,
                1,3,0,64,2,10,2,0);
        39: Fez('Celestita','SrSO4','Sulfato de estrìncio',
                'Africa, Inglaterra, a.URSS, Austria','Azul',9,21,63,'4,0','3,3',6,2,5,1,1,
                3,1,3,64,2,10,10,0);
        40: Fez('Cerussita','PbCO3','Carbonato de chumbo',
                'Austr†lia, GrÇcia, Hungria','Branco',60,60,60,'6,5','3,3',5,2,5,1,1,
                1,1,0,8,2,10,2,0);
        41: Fez('Cianita','Al2SiO5','Silicato de alum°nio',
                'Suiáa, KÇnia','Azul',9,21,63,'3,6','5,9',8,0,7,1,1,
                3,3,0,64,3,4,12,0);
        42: Fez('Cin†brio','HgS','Sulfato de merc£rio',
                'a.Jugosl†via, a.URSS, Peru','Vermelho',40,0,0,'8,1','2,3',2,0,3,1,8,
                1,3,0,64,3,10,2,0);
        43: Fez('Clinozoisita','Ca2Al3(SiO4)(Si2O7)(OH)','Silicato b†sico de c†lcio e alum°nio',
                'It†lia, Suiáa, Austria','Laranja',56,14,0,'3,4','6,4',8,0,6,1,1,
                3,1,0,64,3,14,16,0);
        44: Fez('Cobalto-calcita','CaCO3','Carbonato de c†lcio',
                'Franáa','Roxo',21,0,21,'2,7','3,0',5,2,3,1,1,
                3,3,4,28,4,12,10,0);
        45: Fez('Cobre','Cu','Cobre em estado nativo',
                'MÇxico, Austr†lia, EUA','Castanho',24,12,0,'8,8','2,9',1,0,1,3,6,
                4,1,0,8,1,10,2,1);
        46: Fez('Colemanita','Ca2B6O11.5H2O','Borato b†sico hidratado de c†lcio',
                'a.URSS, Turquia, Chile, Argentina','Transparente',46,46,0,'2,4','4,5',5,0,6,1,1,
                3,1,2,6,1,8,10,0);
        47: Fez('Cor°ndon','Al2O3','Oxido de alum°nio',
                'India, Austr†lia, Brasil','Vermelho',40,0,0,'4,0','9,0',4,2,3,3,1,
                1,3,0,64,3,2,6,0);
        48: Fez('Creedita','Ca3Al2(SO4)(F,OH)10.2H2O','Sulfato hidratado de c†lcio e alum°nio',
                'EUA','Transparente',0,42,42,'2,8','4,0',3,0,6,1,1,
                3,1,4,28,1,10,16,0);
        49: Fez('Crisocola','CuSiO3.nH2O','Silicato hidratado de cobre',
                'Chile, EUA, MÇxico','Azul',9,21,63,'2,1','3,1',8,0,6,3,7,
                3,3,2,4,3,10,2,0);
        50: Fez('Crisotila','Mg6Si4O10(OH)8','Silicato hidratado de magnÇsio',
                'Canad†, EUA, a.URSS','Branco',60,60,60,'2,4','2,7',8,0,6,3,1,
                7,3,0,28,4,4,10,0);
        51: Fez('Croco°ta','PbCrO4','Cromato de chumbo',
                'EUA, Brasil, Filipinas','Laranja',56,14,0,'6,0','2,8',6,0,6,2,4,
                1,1,0,28,1,10,16,1);
        52: Fez('Cronstedtita','Fe''''4Fe''''''4 Si2O10(OH)','Silicato b†sico de ferro',
                'Inglaterra, Tchecoslov†quia','Preto',8,8,8,'3,3','3,5',8,0,6,1,2,
                3,1,0,4,1,10,16,0);
        53: Fez('Cuprita','Cu2O','Oxido cuproso',
                'a.URSS, Brasil, Franáa','Vermelho',40,0,0,'6,1','3,8',4,0,1,2,8,
                1,1,2,28,2,10,2,1);
        54: Fez('Damburyta','CaB2Si2O8','Borossilicato de c†lcio',
                'EUA, JapÑo, MÇxico','Branco',60,60,60,'3,0','7,0',8,0,5,2,1,
                3,1,2,64,2,14,16,0);
        55: Fez('Diamante','C','Carbono puro',
                'Austr†lia, Brasil, Africa','Transparente',0,46,46,'3,6','10,0',1,2,1,1,1,
                1,3,0,64,1,10,4,0);
        56: Fez('Diops°dio','CaMgSi2O6','Silicato de c†lcio e magnÇsio',
                'SuÇcia, a.URSS, It†lia','Transparente',0,46,46,'3,3','5,8',8,0,6,1,1,
                3,2,0,64,4,6,4,0);
        57: Fez('Diopt†sio','Cu6(SiO3).H2O','Silicato hidratado de cobre',
                'Argentina, EUA, Zaire, Peru','Verde',10,32,10,'3,3','5,0',8,0,3,1,5,
                3,3,0,12,2,10,4,0);
        58: Fez('Dolomita','CaMg(CO3)2','Carbonato de c†lcio e magnÇsio',
                'Suiáa, Alemanha, Espanha, Inglaterra','Transparente',0,46,46,'2,8','3,8',5,0,3,1,1,
                3,3,6,28,4,12,2,0);
        59: Fez('Dolomita rosada','CaMg(CO3)2','Carbonato de c†lcio e magnÇsio',
                'EUA, It†lia, Suiáa, Brasil','Laranja',56,14,0,'2,8','3,8',5,0,3,1,1,
                3,3,6,28,2,12,16,0);
        60: Fez('Enargita','Cu3AsS4','Sulfoarseniato de cobre',
                'a.Jugosl†via, Filipinas, Peru','Cinzento',40,40,40,'4,5','3,3',2,0,5,1,2,
                4,1,2,8,2,10,2,1);
        61: Fez('Enxofre','S-‡','Enxofre',
                'EUA, JapÑo, It†lia','Amarelo',63,51,0,'2,1','1,8',1,0,5,2,1,
                8,1,0,64,2,10,8,0);
        62: Fez('Epidoto','Ca2 (Al,Fe'''''')Al2O - (SiO4)(Si2O7)(OH)','Silicato b†sico de ferro fÇrrico, c†lcio e alum°nio',
                'Noruega, Suiáa, a.URSS, It†lia','Amarelo',63,51,0,'3,4','6,8',8,0,6,1,2,
                3,1,0,64,3,6,16,0);
        63: Fez('Escolecita','CaAl2Si3O10.3H2O','Aluminossilicato hidratado de c†lcio',
                'Austria, India, Suiáa','Branco',60,60,60,'2,3','5,2',8,2,6,1,1,
                3,1,4,4,3,14,16,0);
        64: Fez('Esfalerita','ZnS','Sulfato de zinco',
                'Canad†, Brasil, EUA, Peru, MÇxico','Cinzento',40,40,40,'4,0','3,7',2,2,1,1,4,
                1,3,0,4,4,10,2,0);
        65: Fez('EsfÇnio','CaTiOSiO4','Silicato de c†lcio e titÉnio',
                'Suiáa, Franáa, Austria, It†lia','Transparente',0,46,46,'3,6','5,3',8,0,6,1,1,
                1,1,0,20,2,6,6,0);
        66: Fez('Espessartita','Mn3Al2(SiO4)3','Silicato de manganàs e alum°nio',
                'Madag†scar, Brasil, EUA','Laranja',56,14,0,'4,2','7,1',8,0,1,3,1,
                2,3,0,64,2,6,4,0);
        67: Fez('Estaurolita','Fe2Al9O7(SiO4)4(OH)','Silicato de ferro e alum°nio',
                'Alemanha, Suiáa, Franáa','Castanho',24,12,0,'3,8','7,2',8,0,5,2,1,
                3,3,0,16,3,4,16,0);
        68: Fez('Estibinita','Sb2S3','Sulfato de antim¢nio',
                'Hungria, Alemanha, JapÑo, China, MÇxico','Cinzento',40,40,40,'4,6','2,0',2,0,5,1,2,
                4,1,0,12,2,10,10,1);
        69: Fez('Estilbita','CaAl2Si7O18.7H2O','Aluminossilicato hidratado de c†lcio',
                'Canad†, EUA, Suiáa, Esc¢cia','Laranja',56,14,0,'2,2','3,8',8,0,6,1,1,
                3,1,0,4,3,10,16,0);
        70: Fez('Estroncianita','SrCO3','Carbonato de estrìncio',
                'Alemanha, Austria, Espanha','Branco',60,60,60,'3,7','3,5',5,2,5,1,1,
                3,2,5,4,1,10,10,0);
        71: Fez('Ferro mete¢rico','Fe,Ni','Ferro-n°quel',
                'Canad†, EUA, Pol¢nia','Cinzento',40,40,40,'7,4','4,2',1,0,1,3,2,
                4,3,0,28,1,2,16,1);
        72: Fez('Fluorita','CaF2','Flureto de c†lcio',
                'Brasil, Espanha, Franáa','Roxo',21,0,21,'3,2','4,0',3,2,1,1,1,
                3,1,6,16,4,14,8,0);
        73: Fez('Fosgenita','Pb2Cl2CO3','Cloro-carbonato de chumbo',
                'EUA, Pol¢nia, Inglaterra','Branco',60,60,60,'6,1','2,9',5,2,4,1,1,
                2,1,0,10,1,10,16,0);
        74: Fez('Galena','PbS','Sulfato de chumbo',
                'a.URSS, India, It†lia','Cinzento',40,40,40,'7,4','2,5',2,0,1,1,2,
                4,1,0,12,4,14,2,1);
        75: Fez('Gipsita','CaSO4.2H2O','Sulfato hidratado de c†lcio',
                'Espanha, Egipto, Brasil','Transparente',0,46,46,'2,4','2,0',6,2,6,1,1,
                3,1,4,6,4,8,10,0);
        76: Fez('Girolita','Ca2Si3O7(OH)2.H2O','Silicato hidratado de c†lcio',
                'IslÉndia, EUA, Canad†','Verde',10,32,10,'2,4','3,6',8,0,3,1,1,
                3,2,0,64,1,10,16,0);
        77: Fez('Gmelinita','(Na2,Ca)Al2Si4O12.6H2O','Aluminossilicato hidratado de s¢dio e c†lcio',
                'Canad†, Esc¢cia, a.URSS','Laranja',56,14,0,'2,2','4,5',8,0,2,1,1,
                3,1,6,4,2,10,16,0);
        78: Fez('Goethita','FeO(OH)','Hidr¢xido de ferro',
                'Canad†, Tchecoslov†quia, EUA','Preto',8,8,8,'4,3','5,3',4,0,5,1,4,
                2,2,0,12,3,8,10,0);
        79: Fez('Greenockita','CdS','Sulfato de c†dmio',
                'Austria, Esc¢cia, GrÇcia','Amarelo',63,51,0,'4,9','3,5',2,2,2,1,4,
                8,3,0,2,1,10,16,0);
        80: Fez('Grossul†ria','Ca3Al2(SiO4)3','Cilicato de c†lcio e alum°nio',
                'Canad†, Brasil, EUA, Suiáa','Vermelho',40,0,0,'3,4','7,1',8,2,1,3,1,
                3,3,0,64,3,6,4,0);
        81: Fez('Harmotomo','Ba(Al2,Si6O16).6H2O','Aluminossilicato hidratado de b†rio',
                'FinlÉndia, Noruega, Alemanha, Esc¢cia','Transparente',0,46,46,'2,4','4,5',8,0,6,1,1,
                3,2,2,4,2,10,16,0);
        82: Fez('Hedenberguita','CaFeSi2O6','Silicato de c†lcio e ferro',
                'Austr†lia, NigÇria, a.URSS','Verde',10,32,10,'3,6','5,8',8,0,6,1,5,
                3,1,0,64,2,4,16,0);
        83: Fez('Hematita','Fe2O3','Oxido de ferro',
                'a.URSS, Espanha, Brasil','Cinzento',40,40,40,'5,2','6,5',4,0,3,3,8,
                4,3,0,4,4,10,2,0);
        84: Fez('Hemimorfita','Zn4Si2O7(OH)2.H2O','Silicato b†sico hidratado de zinco',
                'EUA, Alemanha, BÇlgica','Transparente',0,46,46,'3,8','4,6',8,0,5,1,1,
                3,2,2,28,2,10,2,0);
        85: Fez('Hemimorfita azul','Zn4Si2O7(OH)2.H2O','Silicato b†sico hidratado de zinco',
                'EUA, Pol¢nia, SibÇria','Azul',9,21,63,'3,4','4,6',8,0,5,1,1,
                3,2,2,28,2,10,2,0);
        86: Fez('Heulandita','CaAl2Si7O18.6H2O','Aluminossilicato hidratado de c†lcio',
                'India, Irlanda, Canad†, It†lia','Vermelho',40,0,0,'2,2','3,8',8,0,6,1,1,
                3,1,0,4,3,14,16,0);
        87: Fez('Hidromagnesita','Mg4(OH)2(CO3)3.3H2O','Hidroxi-carbonato hidratado de magnÇsio',
                'Brasil','Branco',60,60,60,'2,2','3,5',5,0,6,1,1,
                3,3,0,28,1,12,16,1);
        88: Fez('Hornblenda','(Ca,Na,K)2-3(Mg,Fe'''',Fe'''''',Al)5(OH,F)2(Si,Al)2Si6O22','Aluminossilicato complexo',
                'FinlÉndia, EUA, JapÑo','Preto',8,8,8,'3,3','5,6',8,0,6,1,2,
                3,2,0,64,4,6,16,0);
        89: Fez('Huebnerita','MnWO4','Tungstato de manganàs',
                'Peru, EUA, MÇxico','Preto',8,8,8,'7,2','4,2',4,0,6,1,3,
                5,2,0,64,2,2,2,0);
        90: Fez('Ilmenita','FeTiO3','Oxido de titÉnio e ferro',
                'Noruega, SuÇcia','Cinzento',40,40,40,'4,7','5,6',4,0,3,3,3,
                5,3,0,4,3,6,2,0);
        91: Fez('Ilva°ta','CaFe2''''Fe''''''(SiO4)2(OH)','Silicato b†sico de ferro e c†lcio',
                'a.URSS, GrÇcia, a.Jugosl†via','Preto',8,8,8,'4,1','5,8',8,0,5,1,3,
                3,1,0,28,1,4,16,0);
        92: Fez('Inesita','Ca2Mn7Si10O28(OH)2.5H2O','Silicato b†sico hidratado de c†lcio e manganàs',
                'JapÑo, Austr†lia, EUA','Roxo',21,0,21,'3,1','6,0',8,0,7,1,1,
                3,2,4,28,2,6,16,0);
        93: Fez('Kemmererita','Mg3(Mg,Cr)3AlSi3O10(OH)8','Aluminossilicato b†sico de magnÇsio e cromo',
                'Austria, a.URSS, EUA','Vermelho',40,0,0,'2,8','2,2',8,0,6,1,10,
                3,2,0,20,2,6,16,0);
        94: Fez('Lazulita','(Mg,Fe'''')Al2(PO4)2(OH)2','Fosfato b†sico de alum°nio, ferro e magnÇsio',
                'Bol°via, Canad†, EUA','Azul',9,21,63,'3,1','5,6',7,0,6,2,1,
                3,3,0,64,1,6,4,0);
        95: Fez('Leonita','K2Mg(SO4)2.4H2O','Sulfato hidratado de pot†ssio e magnÇsio',
                'Alemanha, EUA','Branco',60,60,60,'2,3','2,7',6,0,6,3,1,
                3,1,5,2,1,8,16,1);
        96: Fez('Leucita','KAlSi2O6','Aluminossilicato de pot†ssio',
                'Asia, Congo, Austr†lia','Branco',60,60,60,'2,5','5,5',8,0,4,3,1,
                3,3,0,28,4,2,16,0);
        97: Fez('Linarita','PbCu(SO4)(OH)2','Sulfato b†sico de cobre e chumbo',
                'Argentina, Inglaterra, Nam°bia','Azul',9,21,63,'5,4','2,5',6,0,6,1,7,
                1,1,0,8,2,10,16,0);
        98: Fez('Ludlamita','(Fe'''',Mg,Mn)3(PO4)2.4H2O','Fosfato hidratado de manganàs, magnÇsio e ferro',
                'Inglaterra, Alemanha','Verde',10,32,10,'3,1','3,5',7,0,6,1,5,
                3,3,2,28,1,10,16,0);
        99: Fez('Ludwiguita','(Mg,Fe'''')2Fe''''''(BO5)','Borato de ferro e magnÇsio',
                'RomÇnia, SuÇcia, EUA','Preto',8,8,8,'4,0','5,0',5,0,5,1,5,
                3,2,0,4,2,4,16,1);
       100: Fez('Magnesita','MgCO3','Carbonato de magnÇsio',
                'a.URSS, China, EUA, Austria','Branco',60,60,60,'3,0','4,2',5,2,3,1,1,
                3,3,0,28,3,12,10,0);
       101: Fez('Magnetita','FeO.Fe2O3','Oxido de ferro',
                'EUA, Austria, Hungria, Brasil, It†lia','Cinzento',40,40,40,'5,3','5,5',4,0,1,3,3,
                4,3,0,4,4,14,2,0);
       102: Fez('Malaquita','Cu2CO3(OH)2','Carbonato b†sico de cobre',
                'Brasil, Chile, MÇxico','Verde',10,32,10,'4,0','4,0',5,0,6,1,5,
                3,1,2,28,2,10,6,0);
       103: Fez('Manganita','MnO(OH)','Oxido b†sico de manganàs',
                'a.URSS, EUA, Alemanha','Cinzento',40,40,40,'4,4','4,0',4,0,6,1,6,
                5,3,0,4,2,10,16,1);
       104: Fez('Mercassita','FeS2','Sulfato de ferro',
                'Franáa, It†lia, Inglaterra','Amarelo',63,51,0,'4,8','6,2',2,0,5,2,3,
                4,1,0,8,1,10,6,1);
       105: Fez('Meionita','Ca4Al3(Al,Si)3Si6O24(Cl,CO3,SO4)','Aluminossilicato complexo de c†lcio',
                'Suiáa','Transparente',0,46,46,'2,8','6,0',8,0,4,1,1,
                3,1,0,4,2,6,16,0);
       106: Fez('Melilita','(Ca,Na)2(Al,Mg)(Si,Al)2O7','Aluminossilicato de c†lcio, s¢dio e magnÇsio',
                'a.URSS, EUA, It†lia','Castanho',24,12,0,'3,0','5,1',8,0,4,1,1,
                3,2,6,28,2,2,16,0);
       107: Fez('Meneghinita','CuPb13(SbS3)7S3','Sulfoantimoniato de cobre e chumbo',
                'Alemanha, SuÇcia, Austr†lia','Cinzento',40,40,40,'6,4','2,5',2,0,5,1,2,
                4,1,0,8,2,2,16,1);
       108: Fez('Mesolita','Na2Ca2(Al2Si3O10)3.8H2O','Aluminossilicato hidratado de s¢dio e c†lcio',
                'IslÉndia, Esc¢cia','Branco',60,60,60,'2,3','5,2',8,0,6,1,1,
                3,1,6,4,3,10,16,0);
       109: Fez('Microcl°nio','KAlSi3O8','Aluminossilicato de pot†ssio',
                'It†lia, Noruega, India, Canad†','Castanho',24,12,0,'2,6','6,0',8,0,7,1,1,
                3,3,0,32,4,6,4,0);
       110: Fez('Milarita','K2Ca4Al2Be4(Si24O60).H2O','Silicato hidr. de pot†ssio, c†lcio, alum°nio e ber°lio',
                'Suiáa, Nam°bia, a.URSS','Verde',10,32,10,'2,6','6,0',8,0,2,1,1,
                9,1,0,64,1,8,20,0);
       111: Fez('Millerita','NiS','Sulfato de n°quel',
                'Alemanha, It†lia, Inglaterra','Amarelo',63,51,0,'5,4','3,3',2,0,2,1,3,
                4,1,0,64,1,10,16,1);
       112: Fez('Molibdenita','MoS2','Sulfato de molibdÇnio',
                'a.URSS, EUA','Cinzento',40,40,40,'5,7','1,2',2,0,2,1,2,
                4,3,0,64,2,6,2,0);
       113: Fez('Muscovita','KAl2AlSi3O10-(OH,F)2','Aluminossilicato b†sico de pot†ssio com fl£or',
                'a.URSS, Brasil','Transparente',0,46,46,'2,9','2,4',8,0,6,1,1,
                6,2,0,64,4,6,8,0);
       114: Fez('Natrolita','Na2AlSi3O10.2H2O','Aluminossilicato hidratado de s¢dio',
                'Franáa, Esc¢cia, Tchecoslov†quia','Branco',60,60,60,'2,3','5,3',8,2,5,1,1,
                3,1,1,28,3,10,16,0);
       115: Fez('Netunita','(Na,K)2(Fe,Mn)TiSi4O12','Titanossilicato de s¢dio, pot†ssio, ferro e manganàs',
                'a.URSS, GroenlÉndia','Preto',8,8,8,'3,2','5,5',8,0,6,1,8,
                3,1,0,64,1,2,16,0);
       116: Fez('Okenita','CaSi2O4(OH)2.H2O','Silicato b†sico hidratado de c†lcio',
                'Chile, GroelÉndia, IslÉndia','Branco',60,60,60,'2,3','4,8',8,0,7,1,1,
                6,1,4,4,1,10,16,0);
       117: Fez('Olivina','(Mg,Fe)2SiO4','Silicato de magnÇsio e ferro',
                'Brasil, Escandin†via, Austr†lia','Verde',10,32,10,'3,6','6,7',7,0,5,3,1,
                3,3,0,20,4,2,6,0);
       118: Fez('Opala','SiO2.nH2O','Oxido hidratado de s°licio',
                'MÇxico, Honduras, EUA','Azul',9,21,63,'2,2','6,0',4,2,6,3,1,
                9,3,0,32,1,8,4,0);
       119: Fez('Ortocl†sio','KAlSi3O8','Aluminossilicato de pot†ssio',
                'Espanha, It†lia, a.URSS','Castanho',24,12,0,'2,6','6,0',8,0,6,1,1,
                3,2,5,32,3,2,12,0);
       120: Fez('Ouro','Au','Ouro nativo',
                'Africa do Sul, EUA, Canad†, Brasil','Amarelo',63,51,0,'19,3','2,9',1,0,1,3,4,
                4,1,0,64,1,2,4,0);
       121: Fez('Ouro-pigmento','As2S3','Sulfato de arsÇnio',
                'Turquia, GrÇcia, RomÇnia','Laranja',56,14,0,'3,4','1,7',2,0,6,1,4,
                1,1,0,10,1,2,10,0);
       122: Fez('Pargasita','NaCa2Mg4(Al,Fe'''''')(OH,F)2AlSi6O22','Aluminossilicato complexo',
                'It†lia, Pennsylvania, Venezuela, Pol¢nia','Preto',8,8,8,'3,1','4,8',8,0,6,1,1,
                3,2,0,64,2,6,16,0);
       123: Fez('Perovskita','CaTiO3','Oxido de c†lcio e titÉnio',
                'SuÇcia, a.URSS, Canad†','Castanho',24,12,0,'4,0','5,5',4,0,6,3,4,
                1,3,0,16,2,6,16,0);
       124: Fez('Pirita','FeS2','Sulfato de ferro',
                'Portugal, Espanha, Noruega','Amarelo',63,51,0,'5,1','6,3',2,0,1,2,5,
                4,1,0,8,4,14,10,1);
       125: Fez('Piromorfita','Pb5Cl(PO4)3','Clorofosfato de chumbo',
                'Alemanha, MÇxico, Inglaterra','Verde',10,32,10,'6,9','3,7',7,0,2,3,1,
                1,1,0,28,3,10,16,0);
       126: Fez('Pirrotita','Fe11S12','Sulfato de ferro',
                'Alemanha, Bol°via, It†lia','Amarelo',63,51,0,'4,6','3,0',2,0,2,1,2,
                4,1,0,12,3,2,2,1);
       127: Fez('Prata','Ag','Prata nativa',
                'Argentina, Brasil, EUA, Chile','Cinzento',40,40,40,'10,5','2,8',1,0,1,3,2,
                4,1,0,8,1,10,20,1);
       128: Fez('Prehnita','Ca2Al2Si3O10(OH)2','Silicato hidratado de c†lcio e alum°nio',
                'India, EUA','Branco',60,60,60,'2,8','6,2',8,0,5,1,1,
                3,1,0,28,3,14,16,0);
       129: Fez('Quartzo geminado','‡-SiO2','Oxido de sil°cio',
                'Brasil, JapÑo','Transparente',0,46,46,'2,7','7,0',4,0,3,3,1,
                3,3,0,32,4,14,12,0);
       130: Fez('Quartzo hialino','‡-SiO2','Oxido de sil°cio',
                'JapÑo','Transparente',0,46,46,'2,7','7,0',4,0,3,3,1,
                3,3,0,32,4,14,12,0);
       131: Fez('Quartzo pr†sio','‡-SiO2','Oxido de sil°cio',
                'Brasil, Uruguai, a.URSS, Suiáa','Verde',10,32,10,'2,7','7,0',4,0,3,3,1,
                3,3,0,32,4,14,12,0);
       132: Fez('Quermesita','Sb2S2O','Oxissulfeto de antim¢nio',
                'Canad†, EUA, Alemanha','Vermelho',40,0,0,'4,5','1,2',2,0,6,1,8,
                1,3,0,12,2,8,16,0);
       133: Fez('Quiolita','Na5Al3F14','Fluoreto de s¢dio e alum°nio',
                'a.URSS','Transparente',0,46,46,'3,0','3,7',3,0,4,1,1,
                10,1,1,18,1,2,8,0);
       134: Fez('Rodocrosita','MnCO3','Carbonato de manganàs',
                'EUA, a.URSS, Argentina, Brasil','Vermelho',40,0,0,'3,5','4,0',5,0,3,1,1,
                3,3,0,4,2,10,6,1);
       135: Fez('Rodonita','CaMn4Si5O15','Silicato de c†lcio e manganàs',
                'India, Nova ZelÉndia, Austr†lia','Vermelho',40,0,0,'3,5','6,1',8,0,7,1,1,
                3,1,0,64,2,4,4,0);
       136: Fez('Rutilo','‡-TiO2','Di¢xido de titÉnio',
                'Brasil, Austria, It†lia','Castanho',24,12,0,'4,2','6,3',4,0,4,1,6,
                1,3,0,64,2,6,2,0);
       137: Fez('Sal-gema','NaCl','Cloreto de s¢dio',
                'ArmÇnia, TurquestÑo, Pol¢nia','Branco',60,60,60,'2,2','2,0',3,0,1,1,1,
                3,1,1,18,4,8,8,1);
       138: Fez('Scheelita','CaWO4','Tungstato de c†lcio',
                'Bol°via, JapÑo, China, EUA','Castanho',24,12,0,'6,0','4,8',6,2,4,1,1,
                1,2,4,28,2,6,2,0);
       139: Fez('Siderita','FeCO3','Carbonato de ferro',
                'Austria, Inglaterra, Franáa','Castanho',24,12,0,'3,9','4,2',5,0,3,1,1,
                3,3,0,4,4,10,2,0);
       140: Fez('Siegenita','(Co,Ni)3S4','Sulfato de n°quel e cobalto',
                'Canad†','Amarelo',63,51,0,'5,0','4,8',2,0,1,2,2,
                4,1,0,8,1,10,16,1);
       141: Fez('Smithsonita','ZnCO3','Carbonato de zinco',
                'EUA, MÇxico, Turquia, Espanha','Verde',10,32,10,'4,4','5,0',5,2,3,1,1,
                3,3,0,4,3,10,6,0);
       142: Fez('Talco','Mg3Si4O10(OH)2','Silicato hidratado de magnÇsio',
                'Brasil, a.URSS, Canad†','Branco',60,60,60,'2,8','1,3',8,0,6,1,1,
                6,3,0,64,4,4,8,0);
       143: Fez('Tennantita','(Cu,Fe)12 As4S13','Sulfoarseniato de cobre e ferro',
                'Europa, EUA, Peru','Cinzento',40,40,40,'4,9','3,6',2,0,1,3,3,
                4,1,0,8,2,10,2,1);
       144: Fez('Tetraedrita','(Cu,Fe)12Sb4S13','Sulfoantimoniato de cobre e ferro',
                'Hungria, RomÇnia','Cinzento',40,40,40,'4,9','3,6',2,0,1,3,2,
                4,1,2,8,3,10,2,1);
       145: Fez('Top†zio','Al2SiO4(F,OH)2','Fluorsilicato b†sico de alum°nio',
                'a.URSS, Brasil','Laranja',56,14,0,'3,5','8,0',8,0,5,1,1,
                3,3,0,64,3,2,4,0);
       146: Fez('Torbernita','Cu(UO2)2(PO4)2.8-12H2O','Fosfato hidratado de cober e urÉnio',
                'Zaire, Austr†lia','Verde',10,32,10,'3,3','2,2',7,4,4,1,5,
                6,1,0,28,2,10,2,1);
       147: Fez('Tremolita','Ca2Mg5Si8O22(OH,F)2','Silicato b†sico de c†lcio e magnÇsio',
                'Brasil, Suiáa','Branco',60,60,60,'3,1','5,6',8,0,6,1,1,
                3,2,0,64,4,4,16,0);
       148: Fez('Turmalina','(Na,Ca)(Mg,Fe'''',Fe'''''',Al,Li)3 Al6(BO3)3Si6O18(OH)4','Borossilicato complexo',
                'Africa, Brasil','Verde',10,32,10,'3,2','7,0',8,0,3,3,1,
                3,1,0,64,3,6,4,0);
       149: Fez('Turquesa','CuAl6(PO4)4(OH)8.4H2O','Fosfato hidratado de alum°nio e cobre',
                'a.URSS, EUA, Ar†bia Saudita','Azul',9,21,63,'2,7','5,5',7,0,7,1,1,
                9,3,2,4,1,8,4,0);
       150: Fez('Vanadinita','Pb5Cl(VO4)3','Clorovanadato de chumbo',
                'Austria, Argentina, Africa do Sul','Vermelho',40,0,0,'7,0','3,0',7,0,2,3,1,
                1,1,0,28,2,10,10,0);
       151: Fez('Vesuvianita','Ca10(Mg,Fe)2Al4 (SiO4)5(Si2O7)2(OH)4','Silicato b†sico de c†lcio, alum°nio, ferro e magnÇsio',
                'Suiáa, It†lia, Franáa','Verde',10,32,10,'3,3','6,5',8,0,4,2,1,
                3,1,0,64,2,4,4,0);
       152: Fez('Vivianita','Fe''''3(PO4)2.8H2O','Fosfato hidratado de ferro',
                'Bol°via, a.Jugosl†via, EUA','Verde',10,32,10,'2,7','2,5',7,0,6,1,1,
                3,1,0,28,1,10,16,1);
       153: Fez('Volframita','(Mn,Fe)(WO4)','Tungstato de manganàs e ferro',
                'Portugal, EUA, China, Espanha','Preto',8,8,8,'7,4','5,3',4,0,6,1,3,
                5,2,0,64,3,10,2,0);
       154: Fez('Witherita','BaCO3','Carbonato de b†rio',
                'Canad†, It†lia, Inglaterra','Branco',60,60,60,'4,3','3,5',5,2,5,1,1,
                3,1,7,12,1,10,8,0);
       155: Fez('Wulffenita','PbMoO4','Molibdato de chumbo',
                'EUA, MÇxico, a.Jugosl†via','Vermelho',40,0,0,'6,8','3,0',6,0,4,1,1,
                1,1,0,28,2,10,2,0);
       156: Fez('ZircÑo','ZrSiO4','Silicato de zirc¢nio',
                'Brasil, Europa','Castanho',24,12,0,'4,5','7,5',7,0,4,2,1,
                1,3,0,64,3,2,6,0);
  end;
end;

end.