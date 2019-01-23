Program Master_Mind (input,output,f,g);

Uses Graph,Crt,Drivers,Apresent,BgiFont,BgiDriv;

Const Cores : ARRAY [1..7] of Integer = (9,2,11,12,13,14,6);

      {$I mao.pas}
      {$I stare.pas}

type
     Ponto       = RECORD
                        Ponto1 : Pointtype;
                        Ponto2 : Pointtype;
                   END;


     Verificacao = RECORD
                        num       : integer;
                        detectado : boolean;
                   END;

     Op          = RECORD
                        njogs,njogad,dific   : integer;
                        Comput,CoresSN       : boolean;
                   END;

     Pontuac     = RECORD
                         Nom : String [13];
                         Num : integer;
                   END;

     Segredo     = ARRAY [1..4] of Verificacao;

     Numeros     = ARRAY [1..4] of Verificacao;

     Limit       = ARRAY [1..10] of Ponto;

     Apelidos    = ARRAY [1..2] of String[13];

     Pontuacao   = ARRAY [1..2] of Integer;

     FichPontuac = ARRAY [1..11] of Pontuac;

Var
   gd,gm,h,jogcor       : integer;
   tab                  : Segredo;
   jogada               : Numeros;
   opc                  : Op;
   Limite               : Limit;
   f                    : File of op;
   g                    : Text;
   Nome                 : Apelidos;
   Pontos12             : Pontuacao;
   TabPontos            : FichPontuac;
   Pos,PosAnt, Size     : integer;
   P                    : Pointer;


 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *******************   Rotina CARREGA_ARRAY  ****************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

 Procedure CARREGA_ARRAY;

 Var indice : integer;

 Begin
      for indice:=1 to 10 do
          with TabPontos[indice] do
              begin
                   readln (g,nom);
                   readln (g,num);
              end;

 End;






 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *******************   Rotina FAZER BOTOES   ****************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}




 Procedure BOTOES (x,y,x1,y1 : integer);

 Begin
      SetLineStyle (0,0,3);
      SetFillStyle(solidfill, 7);
      Bar(x, y, x1, y1);
      SetColor(15);
      Line(x, y, x1, y); Line(x, y, x, y1);
      SetColor(8);
      Line(x1, y, x1, y1); Line(x, y1, x1, y1);
      SetColor (red);
 End;





 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *******************   Rotina ESCREVE_MENSAGEM   **************  ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}





 Procedure ESCREVE_MENSAGEM (x,y,c : integer; Mensagem : String);

 Begin
      SetTextStyle (0,0,0);
      SetTextJustify (CenterText,CenterText);
      SetColor (c);
      OutTextxy (x,y,Mensagem);
 End;





 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ ************************    Rotina MENU  *********************  ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}




 Procedure MENU;

 Var
     I, Z, Inc, a : Integer;

 Begin
      for a := 1 to 5 do
         begin
              Limite [a].Ponto1.X := 240;
              Limite [a].Ponto1.Y := 100+a*50;     { Inicializacao dos }
              Limite [a].Ponto2.X := 370;          { limites do rato por }
              Limite [a].Ponto2.Y := 120+a*50;     { cada opcao }
         end;
      SetFillStyle (solidfill,red);
      Bar (213,90,390,390);
      SetLineStyle (0,0,3);
      SetColor (15);
      Rectangle (213,90,390,390);
      for a:=1 to 5 do
         BOTOES(240, 100+a*50, 370, 120+a*50);
      SetTextJustify (CenterText , CenterText);
      SetColor(0);
      SetTextStyle (Titulo,HorizDir,0);
      SetUserCharSize(2, 5, 2, 5);
      OutTextxy (302,159,'JOGAR');
      OutTextxy (305,209,'INSTRU€™ES');
      OutTextxy (305,259,'OP€™ES');
      OutTextxy (305,309,'TOP-TEN');
      OutTextxy (305,359,'SAIR');
      SetColor(0);
      SetTextStyle (TriplexFont,0,1);
      OutTextxy (302,111,'MENU');
      Z := 270; Inc := 1;
      Repeat
        For I := 105 to 123 do
           If GetPixel(Z, I) <> 4 then
              PutPixel(Z, I, 0);
        For I := 105 to 123 do
           If GetPixel(Z - (1 * Inc), I) <> 4 then
              PutPixel(Z - (1 * Inc), I, 8);
        For I := 105 to 123 do
           If GetPixel(Z - (3 * Inc), I) <> 4 then
              PutPixel(Z - (3 * Inc), I, 7);
        For I := 105 to 123 do
           If GetPixel(Z - (5 * Inc), I) <> 4 then
              PutPixel(Z - (5 * Inc), I, 15);
        For I := 105 to 123 do
           If GetPixel(Z - (8 * Inc), I) <> 4 then
              PutPixel(Z - (8 * Inc), I, 7);
        For I := 105 to 123 do
           If GetPixel(Z - (11 * Inc), I) <> 4 then
              PutPixel(Z - (11 * Inc), I, 8);
        For I := 105 to 123 do
           If GetPixel(Z - (14 * Inc), I) <> 4 then
              PutPixel(Z - (14 * Inc), I, 0);

        Z := Z + Inc;
        If (Z < 255) or (Z > 345) then Inc := Inc * (-1);
      until (Inc > 0) and (Z < 255);

end;



 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ **********************   Rotina RATO  ************************* ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}



Function Rato (d,car,u : integer) : integer;


   var
      EventoR,EventoK   : Tevent;
      opcaov            : boolean;
      i                 : integer;

   begin
        opcaov := False;
        Repeat
          SetFillStyle(SolidFill, u);
          SetColor (car);
          Bar(Limite[PosAnt].Ponto1.X - 25, Limite[PosAnt].Ponto1.Y ,
              Limite[PosAnt].Ponto1.X - 2, Limite[PosAnt].Ponto1.Y + 20);
          PutImage(Limite[Pos].Ponto1.X - 25, Limite[Pos].Ponto1.Y + 5, mao,XORPUT);
          Sound (70);
          Delay (80);
          Nosound;
          InitEvents;
        Repeat
          GetMouseEvent (EventoR);
          GetKeyEvent (EventoK);
        until (EventoR.What = evMouseDown) or (EventoK.What = evKeyDown);
        DoneEvents;
        if EventoR.What = evMouseDown then
          begin
               i := 1;
               While (i < d) and (not opcaov) do
                    begin
                         if (EventoR.Where.X * 8 > Limite [i].Ponto1.X) and
                            (EventoR.Where.X * 8 < Limite [i].Ponto2.X) and
                            (EventoR.Where.Y * 8 > Limite [i].Ponto1.Y) and
                            (EventoR.Where.Y * 8 < Limite [i].Ponto2.Y) then
                            opcaov := True;
                            i := i + 1;
                    end
          end
            else If (EventoK.What = evKeyDown) then
                begin
                 PosAnt := Pos;
                 Case EventoK.ScanCode of
                 28 : begin
                        i := Pos + 1;
                        Opcaov := True;
                      end;

                 72 : begin
                           pos := pos - 1;
                           if pos < 1 then pos := d - 1;
                      end;

                 80 : begin
                           pos := pos + 1;
                           if pos > (d - 1) then pos := 1;
                      end;

                 1  : begin
                           Rewrite(g);
                           for h := 1 to 10 do
                              begin
                                   with TabPontos[h] do
                                       begin
                                            writeln(g, Nom);
                                            writeln(g, Num);
                                       end;
                              end;
                           ClearViewPort;
                           Closegraph;
                           Halt(1);
                      end;
                 end;


           end;
        until (opcaov = True);
        Rato := i - 1;
  end;


 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *******************    Rotina INSTRUCOES    ****************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

 Procedure INSTRUCOES;

 var d : integer;

 Begin
      pos := 1;
      PosAnt := 1;
      Limite [1].Ponto1.X := 200;
      Limite [1].Ponto1.Y := 370;             { Inicializacao dos }
      Limite [1].Ponto2.X := 400;             { limites do rato por}
      Limite [1].Ponto2.Y := 390;             { cada opcao }
      ClearViewPort;
      SetFillStyle (SolidFill,brown);
      Bar (50,30,590,400);
      SetColor (15);
      Rectangle (50,30,590,400);
      SetTextStyle (Titulo,0,2);
      OutTextxy (320,50,'I N S T R U € ™ E S');
      SetTextStyle (Titulo,0,1);
      SetUserCharSize(2, 5, 2, 5);
      SetTextJustify (LeftText,CenterText);
      SetColor(0);
      OutTextxy (150,85,'Este jogo assemelha-se ao verdadeiro jogo do MASTER MIND.');
      OutTextxy (120,100,'Joga-se da seguinte maneira: No MENU encontra-se um parƒmetro');
      OutTextxy (118,115,'chamado  OP€™ES ,  depois de seleccionado com o rato ou teclas de ');
      OutTextxy (118,130,'cursor, visualiza-se um quadro com as op‡”es d¡sponiveis. Depois de');
      OutTextxy (118,145,'feita a configura‡„o desejada, e j  no MENU, escolher JOGAR .');
      OutTextxy (118,160,'No jogo existe um tabuleiro ,  e um quadro com as cores possiveis');
      OutTextxy (118,175,'de escolher.');
      OutTextxy (118,190,'O objectivo ser  tentar adivinhar  qual a combina‡„o de cores que');
      OutTextxy (118,205,'se encontra escondida na barra preta pela ordem certa .');
      OutTextxy (118,220,'Para o ajudar na descoberta das cores existe no tabuleiro uns qua-');
      OutTextxy (118,235,'drados que lhe v„o indicar quais as cores que se encontram na po-');
      OutTextxy (118,250,'si‡„o correcta ou no lugar trocado .');
      OutTextxy (120,265,'     Sendo assim temos:                                             ');
      OutTextxy (120,290,'                   Cor certa no lugar certo.                   ');
      OutTextxy (120,305,'                   Cor certa no lugar trocado.                  ');
      SetTextStyle (8,0,1);
      OutTextxy (125,330,'         Boa Sorte e divirta-se !!!     ');
      SetColor (0);
      Circle (200,292,2);
      SetColor (15);
      Circle (200,307,2);
      BOTOES(200, 370, 440, 390);
      SetTextStyle (0,0,0);
      SetColor(red);
      SetTextJustify (CenterText,CenterText);
      OutTextxy (320,380,'Prima <ENTER> para continuar');
      d := RATO(2,Brown,Brown);
      SetColor (0);
      Rectangle (200,370,440,390);
      delay (500);
 end;





 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *********************    Rotina OPCOES    ******************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}




 Procedure OPCOES;

 Var
    k,a   : integer;
    s     : string;





              { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
                ³ *******    Rotina ESCREVE_OPCOES *****    ³
                ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}




 Procedure ESCREVE_OPCOES ( o : integer);


 Begin
      SetFillStyle (SolidFill,7);
      case o of
      1 :  begin
             opc.njogs := 1;
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+5,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x,Limite[o].Ponto2.y);
             BOTOES(380, 105, 400, 125);
             OutTextxy (390,114,'2');
           end;
       2 : begin
             opc.njogs := 2;
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+5,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x,Limite[o].Ponto2.y);
             BOTOES(305, 105, 325, 125);
             OutTextxy (315,114,'1');
           end;
       3 : begin
             str(opc.njogad,s);
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+5,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x,Limite[o].Ponto2.y+4);
             SetColor (7);
             Bar (310,150,320,160);
             SetColor (red);
             OutTextxy (315,154,s);
           end;
       4 : begin
             opc.Comput := True;
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+5,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x+5,Limite[o].Ponto2.y);
             BOTOES(380, 185, 415, 205);
             SetTextStyle (Titulo,0,1);
             SetUserCharSize(2, 5, 2, 5);
             OutTextxy (397,194,'NO');
           end;
       5 : begin
             opc.Comput := False;
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+5,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x+5,Limite[o].Ponto2.y);
             BOTOES(305, 185, 340, 205);
             SetTextStyle (Titulo,0,1);
             SetUserCharSize(2, 5, 2, 5);
             OutTextxy (322,194,'SIM');
           end;
       6 : begin
             opc.CoresSN := True;
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+10,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x+5,Limite[o].Ponto2.y);
             BOTOES(380, 225, 415, 245);
             SetTextStyle (Titulo,0,1);
             SetUserCharSize(2, 5, 2, 5);
             OutTextxy (397,234,'NO');
           end;
       7 : begin
             opc.CoresSN := False;
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+10,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x+5,Limite[o].Ponto2.y);
             BOTOES(305, 225, 340, 245);
             SetTextStyle (Titulo,0,1);
             SetUserCharSize(2, 5, 2, 5);
             OutTextxy (322,234,'SIM');
           end;
       8 : begin
             str(opc.Dific,s);
             SetColor (0);
             Rectangle (Limite[o].Ponto1.x+10,Limite[o].Ponto1.y+5,Limite[o].Ponto2.x,Limite[o].Ponto2.y);
             SetColor (7);
             Bar (310,270,320,283);
             SetColor (red);
             OutTextxy (315,274,s);
           end;
       end;
end;


                    { Fim do procedimento ESCREVE_OPCOES }




 { Principal OPCOES }


 Begin
      pos := 1;
      PosAnt := 1;
      for a := 1 to 2 do
           begin
                Limite [a].Ponto1.X := 300+(a - 1)*75;
                Limite [a].Ponto1.Y := 100;             { Inicializacao dos }
                Limite [a].Ponto2.X := 325+(a - 1)*75;  { limites do rato por}
                Limite [a].Ponto2.Y := 125;             { cada opcao }
           end;
      Limite [3].Ponto1.X := 300;
      Limite [3].Ponto1.Y := 140;                       { Inicializacao dos }
      Limite [3].Ponto2.X := 325;                       { limites do rato por }
      Limite [3].Ponto2.Y := 161;                       { cada opcao }
      for a := 4 to 5 do
         begin
              Limite [a].Ponto1.X := 300+(a - 4)*75;
              Limite [a].Ponto1.Y := 180;               { Inicializacao dos }
              Limite [a].Ponto2.X := 335+(a - 4)*75;    { limites do rato por }
              Limite [a].Ponto2.Y := 205;               { cada opcao }
         end;
      for a := 6 to 7 do
         begin
              Limite [a].Ponto1.X := 295+(a - 6)*75;
              Limite [a].Ponto1.Y := 220;              { Inicializacao dos }
              Limite [a].Ponto2.X := 335+(a - 6)*75;   { limites do rato por}
              Limite [a].Ponto2.Y := 245;              { cada opcao }
         end;
      Limite [8].Ponto1.X := 295;
      Limite [8].Ponto1.Y := 260;                      { Inicializacao dos }
      Limite [8].Ponto2.X := 325;                      { limites do rato por }
      Limite [8].Ponto2.Y := 285;                      { cada opcao }

      Limite [9].Ponto1.X := 300;
      Limite [9].Ponto1.Y := 350;                      { Inicializacao dos }
      Limite [9].Ponto2.X := 355;                      { limites do rato por }
      Limite [9].Ponto2.Y := 370;                      { cada opcao }
      ClearViewPort;
      SetFillStyle (SolidFill,brown);
      Bar (50,30,590,400);
      SetColor (15);
      Rectangle (50,30,590,400);
      SetTextStyle (Titulo,0,2);
      OutTextxy (320,50,'O P € ™ E S');
      SetTextStyle (0,0,1);
      SetTextJustify (CenterText,LeftText);
      OutTextxy (195,120,'N£mero de Jogadores');
      OutTextxy (187,160,'N£mero de jogadas');
      OutTextxy (175,200,'Computador ?');
      OutTextxy (195,240,'Cores Repetidas ?');
      OutTextxy (195,280,'N¡vel Dificuldade');
      SetTextJustify (CenterText , CenterText);
      SetTextStyle (Titulo,0,1);
      SetUserCharSize(2, 5, 2, 5);
      BOTOES(305, 105, 325, 125);
      OutTextxy (315,114,'1');
      BOTOES(380, 105, 400, 125);
      OutTextxy (390,114,'2');
      BOTOES(305, 145, 325, 165);
      OutTextxy (315,154,'1');
      BOTOES(305, 185, 340, 205);
      OutTextxy (322,194,'SIM');
      BOTOES(380, 185, 415, 205);
      OutTextxy (397,194,'NO');
      BOTOES(305, 225, 340, 245);
      OutTextxy (322,234,'SIM');
      BOTOES(380, 225, 415, 245);
      OutTextxy (397,234,'NO');
      BOTOES(305, 265, 325, 285);
      OutTextxy (315,274,'1');
      BOTOES(305,350,355,370);
      OutTextxy (333,359,'  SAIR   ');
      reset (f);
      read (f,opc);                              { Leitura do ficheiro  }
      ESCREVE_OPCOES (opc.njogs);                { com as op‡”es e sua  }
      ESCREVE_OPCOES (3);                        { escrita para o ecran }
      if opc.Comput then ESCREVE_OPCOES (4)
        else ESCREVE_OPCOES (5);
      if opc.CoresSN then ESCREVE_OPCOES (6)
        else ESCREVE_OPCOES (7);
      ESCREVE_OPCOES (8);
      repeat
      k := RATO (10,0,brown);
      if k <> 9 then
        begin
             if k = 3 then
               begin
                    opc.njogad := opc.njogad + 1;
                    if opc.njogad > 6 then opc.njogad := 1;
               end
             else
                 if k = 8 then
                   begin
                        opc.Dific := opc.Dific + 1;
                        if opc.Dific > 5 then opc.Dific := 1;
                   end
                 else
                     if ((k<>6) and (k<>7)) then
                     if (NOT opc.Comput) and (opc.njogs = 2) then
                        ESCREVE_OPCOES (4)
                     else
                         if (opc.njogs = 1) and (k = 5) then
                           begin
                                sound (100);
                                delay (100);
                                nosound;
                                k := 1;
                           end;
         ESCREVE_OPCOES (k);
         end;
      until k = 9;
      rewrite (f);                             { Escrita no ficheiro }
      write (f,opc);                           { das novas op‡”es e  }
      close (f);                               { fechar ficheiro}
      SetColor (0);
      Rectangle (Limite[k].Ponto1.x+5,Limite[k].Ponto1.y,Limite[k].Ponto2.x,Limite[k].Ponto2.y);
      Delay (400);
 end;






 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *******************    Rotina ECRAN JOGO    ****************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}




 Procedure ECRANJOGO;

 Var
    b,c : integer;

 Begin
      ClearViewPort;
      SetLineStyle (0,0,0);
      SetColor (15);
      SetFillStyle (SolidFill, Brown);
      Bar3D (200,10,400,30,5,True);
      SetColor (brown);
      Line (204,8,400,8);
      SetFillStyle (9, brown);
      FloodFill (402,13,15);
      SetTextStyle (0,0,0);
      SetColor (15);
      OutTextxy (300,21,'MASTER MIND');
      SetFillStyle (SolidFill, Brown);
      Bar3D (170,60,450,440,5,True);
      SetFillStyle (9,brown);
      FloodFill (451,70,15);
      FloodFill (180,58,15);
      SetFillStyle (9, brown);
      Bar3D (480,20,625,220,10,True);
      SetFillStyle (SolidFill, 8);
      FloodFill (630,60,15);
      FloodFill (540,15,15);
      SetFillStyle (SolidFill, 0);
      for b:=0 to 5 do
         begin
            Bar (485,33+b*30,615,53+b*30);
            Rectangle (510,33+b*30,615,53+b*30);
         end;
      SetTextJustify (LeftText , TopText);
      Setcolor (9);
      OutTextxy (515,40,'1 - Azul');
      Setcolor (10);
      OutTextxy (515,70,'2 - Verde');
      Setcolor (11);
      OutTextxy (515,100,'3 - Ciano');
      Setcolor (12);
      OutTextxy (515,130,'4 - Vermelho');
      Setcolor (13);
      OutTextxy (515,160,'5 - Magenta');
      Setcolor (14);
      OutTextxy (515,190,'6 - Amarelo');
 end;





   { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
     ³ ************** Rotina ECRAN_JOGO_JOGADORES ****************** ³
     ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}




 Procedure ECRAN_JOGO_JOGADORES (j : integer);

 var a,b : integer;

   begin
        if j = 1 then
          begin
               SetFillStyle (SolidFill, Brown);
               Bar (180,65,440,430);
               SetFillStyle (SolidFill, 7);
               Bar (205,79,357,107);
               SetFillStyle (SolidFill, 0);
               Bar (200,75,355,105);                   { quadro do primeiro }
               for a:=0 to 5 do                        {      jogador       }
                  BOTOES (400,120+(a*50),437,150+(a*50));
               for a:=0 to 5 do
                  for b:=0 to 3 do
                     begin
                          SetColor (0);
                          Circle (220+b*40,135+a*50,4);
                     end;
         end
        else
          begin
               SetFillStyle (SolidFill, Brown);
               Bar (180,65,440,430);
               SetFillStyle (SolidFill, 7);
               Bar (205,372,357,402);
               SetFillStyle (SolidFill, 0);
               Bar (200,370,355,400);                  { quadro do segundo }
               for a:=0 to 5 do                        {      jogador      }
                  BOTOES (400,70+(a*50),437,100+(a*50));
               for a:=0 to 5 do
                  for b:=0 to 3 do
                     begin
                          SetColor (0);
                          Circle (220+(b*40),85+(a*50),4);
                     end;
          end;
   end;



 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ ****************    Rotina ESCREVER_RESULTADO  ***************  ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}





 Procedure ESCREVER_RESULTADO (jc : integer);

 var
     a : integer;


 begin
      if jc = 1 then
      for a:=1 to 4 do
         begin
              SetFillStyle (SolidFill,Cores[tab[a].num]);
              Bar (170+a*40,80,190+a*40,100);
         end
      else
          begin
               for a:=1 to 4 do
                  begin
                       SetFillStyle (SolidFill,Cores[tab[a].num]);
                       Bar (170+a*40,375,190+a*40,395);
                  end
          end;

 end;





 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ ****************    Rotina ESCREVE_JOGADA     ****************  ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}





 Procedure ESCREVE_JOGADA (a,b,c,jc:integer);


 begin
              if jc = 2 then
                begin
                     SetFillStyle (SolidFill,Cores[a]);
                     Bar (170+b*40,26+c*50,190+b*40,46+c*50);
                end
              else
                begin
                     SetFillStyle (SolidFill,Cores[a]);
                     Bar (170+b*40,76+c*50,190+b*40,96+c*50);
                end;
end;





 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ ****************    Rotina ESCREVE_CERTO_ERRADO  *************  ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}



 Procedure ESCREVE_CERTO_ERRADO (numjog,cor,troc,jc:integer);

 Var
    i,x,y : integer;

 begin
      SetLineStyle (0,0,3);
      if jc = 1 then y := 128 + ((numjog-1) * 50)
        else y := 78 + ((numjog-1) * 50);
      x := 412;
      for i:=1 to cor do
         begin
              SetColor (0);
              circle (x,y,2);
              x := x + 12;
              if x > 424 then
                begin
                     x := x - 24;
                     y := y + 12;
                end;
         end;
       for i:=1 to troc do
          begin
               SetColor (15);
               circle (x,y,2);
               x := x + 12;
               if x > 424 then
                 begin
                      x := x - 24;
                      y := y + 12;
                 end;
           end;
 end;



 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ ********************** ESCREVER_PONTUACAO  *****************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}




 Procedure ESCREVER_PONTUACAO (jr : integer);

 Var
     indic : integer;
     Temp  : Pontuac;

 Begin
      TabPontos[11].Nom := Nome[jr];
      TabPontos[11].Num := Pontos12[jr];
      indic := 11;
      while (indic > 1) and (TabPontos[indic].num > TabPontos[indic - 1].num) do
        begin
          Temp.Nom := TabPontos[indic].Nom; Temp.Num := TabPontos[indic].Num;

          TabPontos[indic].Nom := TabPontos[indic - 1].Nom;
          TabPontos[indic].Num := TabPontos[indic - 1].Num;

          TabPontos[indic - 1].Nom := Temp.Nom;   { Ordena‡„o da tabela }
          TabPontos[indic - 1].Num := Temp.Num;   {    de pontua‡”es    }
          Indic := Indic - 1;
       end;
 end;







 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ **********************    Rotina JOGO      *****************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}






 Procedure JOGO;

 Var
    a,m,Correcto,Trocado,b,i,z,nj,w,q : integer;
    opcao : char;
    repetido : boolean;







           { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
             ³  *********   Rotina CORES/SIM/NAO *********    ³
             ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}






 Procedure CORES_S_N (njg : integer);

 Var
    z,m,y : integer;

 Begin
      if (opc.njogs = 2) and (Not opc.Comput) then
        begin
             if njg = 2 then
                begin
                    njg:=1;
                    y :=375;
                end
             else
                begin
                    njg:=2;
                    y:=80;
                end;
             ESCREVE_MENSAGEM (70,220,15,Nome[njg]);
             ESCREVE_MENSAGEM (80,250,15,'Introduza as Cores');
             for m := 1 to 4 do
                begin
                     tab[m].detectado := false;
                     b := rato (7,yellow,0);
                     tab[m].num := b;
                     SetFillStyle (SolidFill,15);
                     Bar (170+m*40,y,190+m*40,y+20);
                end;
             Delay (100);
             SetFillStyle (SolidFill,0);
             Bar (210,y,350,y+20);            { Apaga cores introduzidas }
             Bar (2,200,153,270);             { Apaga mensagem           }
        end
      else
        begin
             i := 1;
             if opc.CoresSN then
               for m := 1 to 4 do
                  begin
                      tab[m].num := 1 + Random (6);
                      tab[m].detectado := false;
                  end
             else
                while i < 5 do
                    begin
                        Repetido := False;
                        tab[i].num := 1 + Random (6);
                        for m := 1 to (i - 1) do
                           if tab[m].num = tab[i].num then Repetido := True;
                           if Not Repetido then i := i + 1;
                    end;
        end;
 end;






           { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
             ³  *********   Rotina NUMERO_JOGADORES ******    ³
             ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}





 Procedure NUMERO_JOGADORES;

 Var i,a : integer;
     tecla : char;
     t : string;

 Begin
      for a := 0 to opc.njogs - 1 do
        begin
             str (a+1,t);
             SetFillStyle (solidfill,7);
             Bar (1,60+a*250,130,190+a*250);
             SetFillStyle (solidfill,0);
             Bar (10,120+a*250,120,178+a*250);
             SetLineStyle (0,1,2);
             SetColor (15);
             Rectangle (1, 60+(a*250),130,190+(a*250));
             Rectangle (10, 120+(a*250),120,178+(a*250));
             SetTextStyle (0,0,0);
             SetColor (yellow);
             SetTextJustify (CenterText, CenterText);
             OutTextxy (65,85+a*250,'NOME DO');
             OutTextxy (65,100+a*250,t+'§ JOGADOR');
         end;
         SetTextStyle (0,0,1);
         Sound (300);
         Delay (100);
         Nosound;
         ESCREVE_MENSAGEM (80,250,14,'Escreva o seu nome !');
         for a:=0 to opc.njogs-1 do
           begin
              i := 1;
              Nome[a+1] :='';
              Pontos12 [a+1] := 0;
              repeat
                Outtextxy (15+(i*8),156+a*250,'_');
                SetTextStyle (0,0,0);
                tecla:=readkey;
                SetColor (0);
                Outtextxy (15+(i*8),156+a*250,'_');
                SetColor (15);
                if ord(tecla)=13 then
                  i := 13
                else
                    if tecla = #008 then
                       begin
                           i := 1;
                           Nome[a+1]:='';
                           SetFillStyle (SolidFill,0);
                           Bar (13,145+a*250,111,156+a*250);
                       end
                    else
                       begin
                           Outtextxy (15+(i*8),154+a*250,tecla);
                           Nome[a+1] := Nome[a+1] + tecla;
                           i := i + 1;
                       end;
              until i=13;
           end;
end;




           { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
             ³  *********   Rotina CORES_CORRECTAS  ******    ³
             ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}



 Procedure CORES_CORRECTAS (jc : integer);

 Var
    indice,mudanca,y : integer;
    Tecla              : char;


 Begin
      repeat
      SetFillStyle (SolidFill, 8);
      Bar (480,300,630,370);
      SetLineStyle (0,0,3);
      SetColor (7);
      Rectangle (480,300,630,370);
      SetLineStyle (0,0,0);
      SetColor (15);
      Rectangle (478,298,632,372);
      SetTextStyle (0,0,1);
      SetTextStyle (Titulo,0,1);
      SetUserCharSize(2, 5, 2, 5);
      OutTextxy (555,315,'As Cores');
      OutTextxy (563,330,'est„o Correctas ?');
      OutTextxy (555,350,'(S/N)');
      repeat
      Tecla := ReadKey;
      until Tecla in ['s','S','N','n'];
      if Tecla in ['n','N'] then
         begin
             if jc = 1 then
                y := 135
             else
                y := 85;
             SetFillStyle (SolidFill, 8);
             Bar (480,300,630,370);
             OutTextxy (555,315,'Qual a cor');
             OutTextxy (563,330,'que quer mudar ?');
             OutTextxy (560,350,'1, 2, 3, ou 4');
             repeat
             Tecla := ReadKey;
             until Tecla in ['1','2','3','4'];
             indice := ord (tecla)-48;
             ESCREVE_JOGADA (7,indice,nj,jogcor);
             SetColor (0);
             SetLineStyle (0,0,3);
             Circle (220+(indice-1)*40,y+(nj-1)*50,4);
             mudanca := rato(7,yellow,0);
             jogada[indice].num := mudanca;
             ESCREVE_JOGADA (mudanca,indice,nj,jogcor);
         end;
        until Tecla in ['s','S'];
        SetFillStyle (SolidFill ,0);
        Bar (475,290,640,380);
 end;



           { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
             ³  ***************   Rotina FIM *************    ³
             ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

 Procedure FIM (correct: integer);

 Var a,faz : integer;
     ENTER : char;

 Begin
      faz := 1;
      SetTextStyle (0,0,0);
      if correct = 4 then
         begin
            Repeat
              For a := 1 to 7 do
                  begin
                      SetColor (random (7));
                      SetLineStyle (0,0,3);
                      Rectangle (465+(a*6),250+(a*6),640-(a*6),370-(a*6));
                      SetColor (a);
                      OutTextxy (555,310,'PARABNS');
                      Delay (150);
                      Sound (100 + Random (200)+a-(faz*5));
                  end;
              faz := faz + 1;
             until faz = 3;
         end;
       NoSound;
       BOTOES (465,420,638,440);
       OutTextxy (550,430,'ENTER para Continuar');
       Repeat
       ENTER := ReadKey;
       until ENTER = #13;
       SetFillStyle (SolidFill, 0);
       Bar (463,250,640,470);

 End;

                          { Fim da Rotina FIM }




    { Principal JOGO}





Begin
      pos := 1;
      PosAnt := 1;
      for q := 1 to 6 do
           begin
                Limite [q].Ponto1.X := 510;
                Limite [q].Ponto1.Y := 33+(q-1)*30;    { Inicializacao dos }
                Limite [q].Ponto2.X := 615;            { limites do rato por}
                Limite [q].Ponto2.Y := 53+(q-1)*30;    { cada opcao }
           end;
      jogcor:=1;
      reset (f);
      read (f,opc);
      ECRAN_JOGO_JOGADORES (jogcor);
      NUMERO_JOGADORES;
      for w := 1 to opc.njogad do
         begin
             SetFillStyle (SolidFill, 0);
             Bar (1,220,163,270);
             CORES_S_N (jogcor);
             ESCREVE_MENSAGEM (75,230,15,Nome[jogcor]);
             ESCREVE_MENSAGEM (75,260,15,' a sua vez !');
             Sound (100);
             Delay (100);
             NoSound;
             nj := 0;
             Correcto := 0;
             while (nj <= opc.Dific ) and (Correcto <> 4) do
                  begin
                      nj := nj + 1;
                      Correcto := 0;
                      Trocado := 0;
                      for m := 1 to 4 do
                         begin
                             tab[m].detectado := false;
                             jogada[m].detectado := false;
                             b := RATO (7,yellow,0);
                             jogada[m].num := b;
                             ESCREVE_JOGADA (b,m,nj,jogcor);
                         end;
                      CORES_CORRECTAS (jogcor);
                      for m := 1 to 4 do
                      if tab[m].num = jogada[m].num then
                         begin
                             tab[m].detectado := true;
                             jogada[m].detectado := true;
                             correcto := correcto + 1;
                         end;
                      for a := 1 to 4 do
                         for m := 1 to 4 do
                            if (jogada[a].num = tab[m].num) and
                               (Not tab[m].detectado)       and
                               (Not jogada[a].detectado)   then
                               begin
                                   tab[m].detectado := true;
                                   jogada [a].detectado := true;
                                   trocado := trocado + 1;
                               end;
                      ESCREVE_CERTO_ERRADO(nj,correcto,trocado,jogcor);
                  end;
             ESCREVER_RESULTADO (jogcor);
             FIM (correcto);
             if correcto = 4 then
                  Pontos12[jogcor]:=Pontos12[jogcor]+70-(10*nj);
             if opc.njogs = 2 then
                  jogcor := (w mod 2) + 1;
             if w < opc.njogad then
                  ECRAN_JOGO_JOGADORES (jogcor);
         end;
    if Pontos12[1] <> 0 then
       ESCREVER_PONTUACAO (1);
    if Pontos12[2] <> 0 then
       ESCREVER_PONTUACAO (2);
 end;





 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *******************    Rotina TOP_TEN    *******************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}





Procedure TOP_TEN;

Var
   ind,Ang,AngInv : integer;
   conver : String;
   Tecla : char;



           { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
             ³  *************   Rotina XROTACAO  ***********  ³
             ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}





 Function XRotacao (x1,y1,ang : integer) : integer;

 Var
    ArcCoords: ArcCoordsType;



 begin
      SetColor(0);
      SetLinestyle(0,0,0);
      Arc (x1,y1,0,ang,20);
      GetArcCoords(ArcCoords);
      with ArcCoords do
          XRotacao := Xend;
 end;




           { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
             ³  *************   Rotina YROTACAO  ***********  ³
             ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}





 Function YRotacao (x1,y1,ang : integer) : integer;

 Var
    ArcCoords: ArcCoordsType;


 begin
      SetColor(0);
      SetLinestyle(0,0,0);
      Arc (x1,y1,0,ang,20);
      GetArcCoords(ArcCoords);
      with ArcCoords do
          YRotacao := Yend;
 end;




{ Principal TOP-TEN }



Begin
     ClearViewPort;
     SetFillStyle (SolidFill,red);
     SetColor (yellow);
     SetLineStyle (0,0,0);
     FillEllipse (310,100,130,30);
     SetColor (0);
     SetTextStyle (0,0,2);
     SetTextJustify (CenterText, CenterText);
     OutTextxy (318,100,'T O P 10');
     SetTextStyle (TriplexFont,0,1);
     SetColor (15);
     for ind := 1 to 10 do
        begin
             str (TabPontos[ind].num,conver);
             SetTextJustify (LeftText, CenterText);
             OutTextxy (120,170+ind*20,TabPontos[ind].nom);
             SetTextJustify (CenterText, CenterText);
             OutTextxy (360,170+ind*20,'. . . . . . . . . . . . . .');
             SetTextJustify (RightText, CenterText);
             OutTextxy (500,170+ind*20,conver);
        end;
     BOTOES (200,410,420,430);
     ESCREVE_MENSAGEM (310,420,red,'Prima ENTER para continuar');
     PutImage (175,413,mao,0);
     Ang := 1;
     AngInv := 360;
     Repeat
           PutImage (XRotacao(100,70,Ang),YRotacao(100,70,Ang),stare,0);
           PutImage (XRotacao(500,70,AngInv),YRotacao(500,70,AngInv),stare,0);
           Ang := Ang + 5;
           AngInv := AngInv - 5;
           if Ang > 360 then Ang := 5;
           if AngInv < 5 then AngInv := 360;
     until KeyPressed;
     Tecla := ReadKey;
end;










 { ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³ *******************    Rotina PRINCIPAL    *****************    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

 BEGIN
      Randomize;
      RegisterBGIdriver(@CGADriverProc);
      RegisterBGIdriver(@EGAVGADriverProc);
      RegisterBGIdriver(@HercDriverProc);
      RegisterBGIdriver(@ATTDriverProc);
      RegisterBGIdriver(@PC3270DriverProc);
      RegisterBGIfont(@SansSerifFontProc);
      RegisterBGIfont(@SmallFontProc);
      RegisterBGIfont(@TriplexFontProc);
      RegisterBGIfont(@LcomFontProc);
      assign (f,'opmaste.dat');
      assign (g,'top10.dat');
{$I-}
      reset (f);
      if ioresult <> 0 then
         begin
           rewrite(f);
           Write(f, opc);
         end;
      reset (g);
{$I+}
      CARREGA_ARRAY;
      gd := Detect;
      InitGraph(gd, gm,'');
      if GraphResult <> grOk then Halt(1);
      PRINCIPAL;
      ClearViewPort;
      EcranMenu;
      Size := ImageSize(1, 1, 253, 420);
      GetMem(P, Size);
      GetImage(1, 1, 253, 420, P^);
      Repeat
           Pos := 1;
           PosAnt := 1;
           MENU;
           h := RATO (6,yellow,red);
           SetColor (0);
           Rectangle (Limite[h].Ponto1.X,Limite[h].Ponto1.Y,Limite[h].Ponto2.X,Limite[h].Ponto2.Y);
           Delay (700);
           Case h of
               1 : begin
                       ECRANJOGO;
                       JOGO;
                   end;
               2 : INSTRUCOES;
               3 : OPCOES;
               4 : TOP_TEN;
           end;
           if h <> 5 then
             begin
                 ClearViewPort;
                 PutImage(1, 1, P^, NormalPut);
                 SetColor(12);
                 SetLineStyle (0,0,0);
                 Line(255, 35, 600, 35); Line(600, 35, 600, 450);
                 SetTextStyle (0,0,1);
                 SetColor (15);
                 OutTextxy (490,450,'(c) Pedro Nunes 1993');
                 SetColor (12);
                 Line (580, 450, 600, 450);
                 Line(34, 450, 400, 450); Line(34, 423, 34, 450);
             end;
      until h = 5;
      Rewrite(g);
      for h := 1 to 10 do
         begin
             with TabPontos[h] do
                 begin
                     writeln(g, Nom);
                     writeln(g, Num);
                 end;
         end;
      Close(g);
      CloseGraph;
 END.
