Program MANAGER;
    { Alfredo Santos & Miguel Ros rio  Copyright(c)   1993 }
    uses crt,dos;
    label prin,jogo,pro;

    type items=array [1..12] of string[15] ;
         informacao=array [1..12] of string[40] ;
         adversario=array[1..6] of string[10];
         equipa=record
             nomej:string[15];
             posicao:char;
             end;
         mercado=record
             nomejog:string[15];
             posicaojog:char;
             niveljog:integer;
             precojog:real;
             end;
         status=record
             name:string[15];
             tempo:integer;
             end;

    const opcao:items =(' Jogar         ',
                        ' Copyright     ',
                        ' Sair          ','','','','','','','','','');
          opcao1:items=(' Pr¢ximo Jogo  ',
                        ' Dinheiro      ',
                        ' Contratos     ',
                        ' Obras         ',
                        ' Plantel       ',
                        ' Acabar        ','','','','','','');
          opcao2:items=(' Jogo          ',
                        ' Antevis„o     ',
                        ' Constitui‡„o  ',
                        ' Pr‚mios       ',
                        ' Transmiss„o   ','','','','','','','');
          opcao3:items=(' Mercado       ',
                        ' Contrato      ',
                        ' Men£ Anterior ','','','','','','','','','');
          opcao4:items=(' 5 000          ',
                        ' 10 000         ',
                        ' 15 000         ',
                        ' 20 000         ',
                        ' Instala‡”es    ', '','','','','','','');
          opcao5:items=(' 7500 contos     ',
                        ' 15000 contos    ',
                        ' 35000 contos    ','','','','','','','','','');
          opcao6:items=(' Vender         ',
                        ' Cancelar       ','','','','','','','','','','');
          opcao7:items=(' 1 000          ',
                        ' 2 000          ',
                        ' 3 000          ','','','','','','','','','');
          opcao8:items=(' Transmitir     ',
                        ' Cancelar       ','','','','','','','','','','');
          opcao9:items=('  1 ',
                        '  2 ',
                        '  3 ',
                        '  4 ',
                        '  5 ',
                        '  6 ',
                        '  7 ',
                        '  8 ',
                        '  9 ',
                        ' 10 ',
                        ' 11 ',
                        'Sair');
          opcao10:items=(' 12 ',
                         ' 13 ',
                         ' 14 ',
                         ' 15 ',
                         ' 16 ','','','','','','','');
          opcao11:items=('  1 ',
                        '  2 ',
                        '  3 ',
                        '  4 ',
                        '  5 ',
                        '  6 ',
                        '  7 ',
                        '  8 ',
                        '  9 ',
                        ' 10 ',
                        ' 11 ','');
          opcao12:items=(' 12 ',
                         ' 13 ',
                         ' 14 ',
                         ' 15 ',
                         ' 16 ','','','','','','','');
          eliminatorias:items=('1¦ eliminat¢ria',
                               '2¦ eliminat¢ria',
                               '1/8 de final   ',
                               '1/4 de final   ',
                               'meias finais   ',
                               '       final   ','','','','','','');
          info:informacao=('Permite jogar o Football Manager    ',
                           'Informa‡„o sobre o programa         ',
                           'Permite abandonar o Football Manager','','','','','','','','','');
          info1:informacao=('Entrada no men£ de jogo            ',
                            'Apresenta‡„o da situa‡„o financeira',
                            'Compra/Venda de jogadores          ',
                            'Permite efectuar obras no est dio  ',
                            'Apresenta‡„o do plantel            ',
                            'Permite terminar o jogo            ', '','','','','','');
          info2:informacao=('Come‡ar o jogo                     ',
                            'Informa‡”es sobre o jogo           ',
                            'Constitui‡„o da equipa             ',
                            'Decis„o sobre pr‚mios de jogo      ',
                            'Transmiss„o televisa               ','','','','','','','');
          info3:informacao=('Lista de jogadores para comprar    ',
                            'Permite efectuar o contrato        ',
                            'Permite voltar ao men£ anterior    ','','','','','','','','','');
          info4:informacao=('Bancada de 5000 espectadores         ',
                            'Bancada de 10000 espectadores        ',
                            'Bancada de 15000 espectadores        ',
                            'Bancada de 20000 espectadores        ',
                            'Melhorar as instala‡”es do est dio   ', '','','','','','','');
          info5:informacao=('7500 contos em melhoria das instala‡”es',
                            '15000 contos em melhoria das instala‡”es',
                            '35000 contos em melhoria das instala‡”es','','','','','','','','','');
          info6:informacao=('Vender o jogador escolhido            ',
                            'Cancelar a opera‡„o                   ','','','','','','','','','','');
          info7:informacao=(' 1 000 contos por cada jogador        ',
                            ' 2 000 contos por cada jogador        ',
                            ' 3 000 contos por cada jogador        ','','','','','','','','','');
          info8:informacao=('Transmitir o jogo pela televis„o      ',
                            'Cancelar a opera‡„o                   ','','','','','','','','','','');
          info9:informacao=('','','','','','','','','','','','');
          info10:informacao=('','','','','','','','','','','','');
          info11:informacao=('','','','','','','','','','','','');
          info12:informacao=('','','','','','','','','','','','');

    var opc:items;
        tacben,tacadv,tacjuve,tacporto,tacarse,tacbarca,tacsport,taccaldas,ntbenfica,conins:string[10];
        jogadortec,esp,posven:char;
        z,l,c2,jog,numven,niven,numcom,nivadv,nivjuve,nivarse,nivporto,nivbarca,nivsport,nivcaldas,numsai,nument:integer;
        rlevel,gol,goladv,minuto,contsubs,golmartot,golsoftot:integer;
        advteam,juve,porto,arse,barca,sport,caldas:array [1..16] of equipa;
        nbenfica,njuve,nporto,narse,nbarca,nsport,ncaldas,ntjuve,ntporto,ntarse,ntbarca,ntsport,ntcaldas,ntadv:string[15];
        adv,jogven,passa:string[15];
        benfica:array [1..16] of string[15];
        posben:array [1..16] of char;
        nivben:array [1..16] of integer;
        preben:array [1..16] of real;
        taclev,lota,assistencia,level,oferta,dinheiro,dinfed,dinpre,dinoba,dinins,dinven,dincom,dinrei,dintv,premi:real;
        elimlev,prelev,jogpre,dinpub,bilhete:real;
        elim:items;
        mer1: array[1..16] of mercado;
        mer2: array[1..16] of mercado;
        mer3: array[1..16] of mercado;
        mer4: array[1..16] of mercado;
        mer5: array[1..16] of mercado;
        meruti:array[1..16] of mercado;
        marca:array[1..7] of status;
        marcadv:array[1..7] of status;
        temperatura,mersor,escolha,esc,cont:byte;
        adver:adversario;

  procedure  data(x,y:byte);   { Rotina que retorna a data do sistema }

   const semana:array[0..6] of string=('Domingo',
                                       'Segunda',
                                       'Ter‡a',
                                       'Quarta',
                                       'Quinta',
                                       'Sexta',
                                       'S bado');

   var ano,mes,dia,sem:word;

 begin
    gotoxy(x,y);
    getdate(ano,mes,dia,sem);
    write(semana[sem]);
    if sem in [1..5] then write('-feira ');
    write(' ',dia,'/',mes,'/',ano);
 end;

  procedure  hora(x,y:byte);  { Rotina que retorna a hora do sistema }
  
   var horas,minu,seg,cen:word;

 begin
    gotoxy(x,y);
    gettime(horas,minu,seg,cen);
    write(' ',horas,'h:',minu,'m:',seg,'s');
 end;

 procedure som_erro;  { Som emitido na ocorrencia de erros }

   begin
      sound(60);
      delay(800);
      nosound;
   end;

 procedure entry; { Entrada do Programa }

   var x,y:integer;

 begin
  textbackground(black);
  clrscr;
  repeat
      textcolor(random(12));
      gotoxy(30,10);write('   Alfredo Santos');
      gotoxy(30,11);write('         &       ');
      gotoxy(30,12);write('   Miguel Ros rio');
      gotoxy(35,14);write('Apresentam');
      delay(400);
  until keypressed;
  textcolor(white);
  textbackground(black);
  clrscr;
  gotoxy(4,4);write(chr(218));
  gotoxy(77,4);write(chr(191));
  gotoxy(4,21);write(chr(192));
  gotoxy(77,21);write(chr(217));
    for x:=5 to 20 do begin
        gotoxy(4,x);write(chr(179));
        gotoxy(77,x);write(chr(179));
    end;
    for y:=5 to 76 do begin
        gotoxy(y,4);write(chr(196));
        gotoxy(y,21);write(chr(196));
    end;
    gotoxy(12,6);write('ÚÂÄÄÄÄÄ');
    gotoxy(12,7);write('³³     ');
    gotoxy(12,8);write('³ÃÄÄ   ');
    gotoxy(12,9);write('³³     ');
    gotoxy(12,10);write('³³     ');
    gotoxy(12,11);write('ÀÙ     ');
    delay(700);
    gotoxy(19,8);write(' ÚÂÄÄÄÂ¿');
    gotoxy(19,9); write(' ³³   ³³');
    gotoxy(19,10); write(' ³³   ³³');
    gotoxy(19,11); write(' ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(27,8); write(' ÚÂÄÄÄÂ¿');
    gotoxy(27,9); write(' ³³   ³³');
    gotoxy(27,10); write(' ³³   ³³');
    gotoxy(27,11); write(' ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(35,7);write('  Ú¿');
    gotoxy(35,8); write(' Ä´ÃÄ');
    gotoxy(35,9); write('  ³³');
    gotoxy(35,10); write('  ³³ ');
    gotoxy(35,11); write('  ÀÙ');
    delay(700);
    gotoxy(41,7);write('Ú¿');
    gotoxy(41,8); write('³ÃÄÄÄÂ¿');
    gotoxy(41,9); write('³³   ³³');
    gotoxy(41,10); write('³³   ³³');
    gotoxy(41,11); write('ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(49,8); write('ÄÄÄÄÄÂ¿');
    gotoxy(49,9); write('ÚÂÄÄÄ´³');
    gotoxy(49,10); write('³³   ³³');
    gotoxy(49,11); write('ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(57,7);write('¿¿');
    gotoxy(57,8); write('³³');
    gotoxy(57,9); write('³³');
    gotoxy(57,10); write('³³ ');
    gotoxy(57,11); write('ÀÙ');
    delay(700);
    gotoxy(60,7);write('¿¿');
    gotoxy(60,8); write('³³');
    gotoxy(60,9); write('³³');
    gotoxy(60,10); write('³³ ');
    gotoxy(60,11); write('ÀÙ');
    delay(700);
    gotoxy(15,13);write('ÚÂ¿  ÚÂ¿');
    gotoxy(15,14);write('³³³  ³³³');
    gotoxy(15,15);write('³³À¿ÚÙ³³');
    gotoxy(15,16);write('³³ ÀÙ ³³');
    gotoxy(15,17);write('³³    ³³');
    gotoxy(15,18);write('ÀÙ    ÀÙ ');
    delay(700);
    gotoxy(23,15); write(' ÄÄÄÄÄÂ¿');
    gotoxy(23,16); write(' ÚÂÄÄÄ´³');
    gotoxy(23,17); write(' ³³   ³³');
    gotoxy(23,18); write(' ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(31,15); write(' ÃÂÄÄÄÂ¿');
    gotoxy(31,16); write(' ³³   ³³');
    gotoxy(31,17); write(' ³³   ³³');
    gotoxy(31,18); write(' ÀÙ   ÀÙ');
    delay(700);
    gotoxy(39,15); write(' ÄÄÄÄÄÂ¿');
    gotoxy(39,16); write(' ÚÂÄÄÄ´³');
    gotoxy(39,17); write(' ³³   ³³');
    gotoxy(39,18); write(' ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(47,15); write(' ÚÂÄÄÄÂ¿');
    gotoxy(47,16); write(' ³³   ³³');
    gotoxy(47,17); write(' ÀÁÄÄÄ´³');
    gotoxy(47,18); write(' Ú¿   ³³');
    gotoxy(47,19); write(' ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(55,15); write(' ÚÂÄÄÄÂ¿');
    gotoxy(55,16); write(' ³ÃÄÄÄÁÙ');
    gotoxy(55,17); write(' ³³   Ú¿');
    gotoxy(55,18); write(' ÀÁÄÄÄÁÙ');
    delay(700);
    gotoxy(63,15); write(' ÚÂÂ¿ R ');
    gotoxy(63,16); write(' ³³ÀÙ   ');
    gotoxy(63,17); write(' ³³  ');
    gotoxy(63,18); write(' ÀÙ  ');
    delay(1200);
   end;

   procedure ecran;             { Desenho do ecran de fundo }

     var c1,c2,c3:integer;

    begin;
      textcolor(white);
      for c1:=1 to 80 do begin
          for c2:=1 to 24 do begin
              gotoxy(c1,c2);
              write('Û');
           end;
      end;
      textcolor(yellow);
      textbackground(blue);
      for c3:=1 to 80 do begin
          gotoxy(c3,1);
          write(' ');
          gotoxy(c3,24);
          write(' ');
          gotoxy(30,1);
          write('Football Manager v1.1');
          gotoxy(1,24);
          write('  Alfredo & Miguel     |  ');
      end;
      end;

    procedure botao(col,lin,comp:integer;cor_barra,cor_sombra,cor_text,cor_back:word;script:string);  { Bot„o dos menus }

     var c1,col_2,col_3:integer;

        begin;
          textcolor(cor_barra);
          col_2:=col-1;
          for c1:=0 to comp-1 do begin;
                    col_2:=col_2+1;
                    gotoxy(col_2,lin);
                    write('Û')
          end;
          gotoxy(col+1,lin);
          textbackground(cor_barra);
          textcolor(cor_text);
          write(script);
          textcolor(cor_sombra);
          textbackground(cor_back);
          col_3:=col;
          for c1:=0 to comp-1 do begin;
                    col_3:=col_3+1;
                    gotoxy(col_3,lin+1);
                    write('Ü');
          end;
          gotoxy(col+comp,lin);
          write('ß');
        end;

    { Click dos bot”es dos menus }
    procedure click(col,lin,comp:integer;cor_barra,cor_sombra,cor_text,cor_back:word;script:string);

        var c1,col_2,col_3,col_4,col_5:integer;

       begin;
          textcolor(cor_sombra);
          col_4:=col-1;
          col_5:=col-1;
          for c1:=0 to comp do begin
                    col_4:=col_4+1;
                    gotoxy(col_4,lin);
                    write('Û');
          end;
          for c1:=0 to comp do begin
                    col_5:=col_5+1;
                    gotoxy(col_5,lin+1);
                    write('Û');
          end;
          textbackground(cor_barra);
          textcolor(cor_text);
          col_2:=col;
          for c1:=0 to comp-1 do begin;
                    col_2:=col_2+1;
                    gotoxy(col_2,lin);
                    write(' ');
          end;
          gotoxy(col+1,lin);write(script);
          delay(150);
          botao(col,lin,comp,cor_barra,cor_sombra,cor_text,cor_back,script);
        end;

    procedure win(x,y,x1,y1:integer;logic:boolean;cor1,cor2,cor3,cor4:word;mens:string); { Rotina para o desenho das caixas }

         var c1,c2,c3,c4,c5,c6,c7,z,z1,z2,z3,z4:integer;

     begin;
       z:=x;
       z1:=x1;
       z2:=y;
       z3:=x1-x;
       textcolor(cor1);
         for c1:=y to y1 do begin
             for c2:=x to x1 do begin
                 gotoxy(c2,c1);write('Û');
             end;
         end;
       c4:=0;
       c3:=y1-y;
       textcolor(cor2);
       while c4<>c3+1 do begin
           c4:=c4+1;
           y:=y+1;
           gotoxy(x1+1,y);
           write('ÛÛ');
       end;
       c5:=0;
       c6:=x1-x;
       while c5<>c6+1 do begin
           c5:=c5+1;
           x:=x+1;
           gotoxy(x+1,y1+1);
           write('Û');
       end;
       if logic=true then begin
          z4:=z3-length(mens);
          textbackground(cor3);
          textcolor(cor4);
          for c7:=z to z1 do begin
             gotoxy(c7,z2);write(' ');
          end;
          gotoxy(z+z4 div 2,z2);write(mens);
       end;
       delay(1000);
     end;

     procedure menu(flin,col,esp,n,item:integer;corl,corfun,corfun1:word); { Rotina do menu de barras }

       var c1,lin,linha,sn:integer;
           tec,tec1:char;
           infor:informacao;

          begin
             if item=1 then
               begin
                 opc:=opcao;
                 infor:=info;
               end;
             if item=2 then
               begin
                 opc:=opcao1;
                 infor:=info1
               end;
             if item=3 then
                begin
                  opc:=opcao2;
                  infor:=info2;
                end;
             if item=4 then
                begin
                  opc:=opcao3;
                  infor:=info3;
                end;
             if item=5 then
                begin
                  opc:=opcao4;
                  infor:=info4;
                end;
             if item=6 then
                begin
                  opc:=opcao5;
                  infor:=info5;
                end;
             if item=7 then
                begin
                  opc:=opcao6;
                  infor:=info6;
                end;
             if item=8 then
                begin
                  opc:=opcao7;
                  infor:=info7;
                end;
             if item=9 then
                begin
                  opc:=opcao8;
                  infor:=info8;
                end;
             if item=10 then
                begin
                  opc:=opcao9;
                  infor:=info9;
                end;
             if item=11 then
                begin
                  opc:=opcao10;
                  infor:=info10;
                end;
             if item=12 then
                begin
                  opc:=opcao11;
                  infor:=info11;
                end;
             if item=13 then
                begin
                  opc:=opcao12;
                  infor:=info12;
                end;
             lin:=flin;
             c1:=0;
             c2:=1;
             linha:=flin+n+(n-1)*(esp-1)-1;
             textcolor(corl);
             textbackground(corfun);
             for c1:=1 to n do begin
                if c1= 1 then
                  begin
                    textbackground(corfun1);
                  end
                else
                  begin
                    textbackground(corfun);
                end;
                  gotoxy(col,lin);
                  writeln(opc[c1]);
                  lin:=lin+esp;
                  textcolor(corl);
                  textbackground(corfun);
                  gotoxy(37,24);write(infor[1]);
             end;
             lin:=flin;
             tec:=readkey;
             while tec<>#13 do
               begin
                 while tec<>#13 do
                   begin
                     tec:=readkey;
                     if (tec=#72) or (tec=#75) then
                       begin
                          gotoxy(col,lin);
                          textbackground(corfun);
                          write(opc[c2]);
                          if c2=1 then
                            begin
                              c2:=n+1;
                              lin:=linha+esp;
                          end;
                          c2:=c2-1;
                          lin:=lin-esp;
                          gotoxy(37,24);write(infor[c2]);
                          textbackground(corfun1);
                          gotoxy(col,lin);
                          write(opc[c2]);
                          gotoxy(col+16,lin);
                       end;
                      if (tec=#80) or (tec=#77) then
                       begin
                         gotoxy(col,lin);
                         textbackground(corfun);
                         write(opc[c2]);
                         if c2=n then
                            begin
                              c2:=0;
                              lin:=flin-esp;
                         end;
                         c2:=c2+1;
                         lin:=lin+esp;
                         gotoxy(37,24);write(infor[c2]);
                         textbackground(corfun1);
                         gotoxy(col,lin);
                         write(opc[c2]);
                         gotoxy(col+16,lin);
                       end;
                      if (tec=#71) then
                         begin
                           gotoxy(col,lin);
                           textbackground(corfun);
                           write(opc[c2]);
                           c2:=1;
                           lin:=flin;
                           gotoxy(37,24);write(infor[c2]);
                           textbackground(corfun1);
                           gotoxy(col,lin);
                           write(opc[c2]);
                           gotoxy(col+16,lin);
                         end;
                      if (tec=#79) then
                         begin
                           gotoxy(col,lin);
                           textbackground(corfun);
                           write(opc[c2]);
                           c2:=n;
                           lin:=linha;
                           gotoxy(37,24);write(infor[c2]);
                           textbackground(corfun1);
                           gotoxy(col,lin);
                           write(opc[c2]);
                           gotoxy(col+16,lin);
                         end;
                 end;
               end;
               if (item=10) or (item=11) or (item=12) or (item=13) then begin
                    write;
                    end
                  else
                    begin
                      if (item=4) or (item=6) or (item=7) or (item=8) or (item=9) then begin
                         click(col,lin,15,red,lightgray,yellow,black,opc[c2]);
                      end
                    else
                      begin
                         click(col,lin,15,lightgray,white,yellow,black,opc[c2]);
                     end;
                   end;
           end;

     procedure escolhemer; { Escolha do mercado de jogadores }

        var cont:integer;

      begin;
        mersor := Random(5);
        case mersor of
             0:begin
               for cont:=1 to 16 do begin
                   meruti[cont].nomejog:=mer1[cont].nomejog;
                   meruti[cont].posicaojog:=mer1[cont].posicaojog;
                   meruti[cont].precojog:=mer1[cont].precojog;
                   meruti[cont].niveljog:=mer1[cont].niveljog;
                   end;
               end;
             1:begin
               for cont:=1 to 16 do begin
                   meruti[cont].nomejog:=mer2[cont].nomejog;
                   meruti[cont].posicaojog:=mer2[cont].posicaojog;
                   meruti[cont].precojog:=mer2[cont].precojog;
                   meruti[cont].niveljog:=mer2[cont].niveljog;
                   end;
               end;
             2:begin
               for cont:=1 to 16 do begin
                   meruti[cont].nomejog:=mer3[cont].nomejog;
                   meruti[cont].posicaojog:=mer3[cont].posicaojog;
                   meruti[cont].precojog:=mer3[cont].precojog;
                   meruti[cont].niveljog:=mer3[cont].niveljog;
                   end;
               end;
             3:begin
               for cont:=1 to 16 do begin
                   meruti[cont].nomejog:=mer4[cont].nomejog;
                   meruti[cont].posicaojog:=mer4[cont].posicaojog;
                   meruti[cont].precojog:=mer4[cont].precojog;
                   meruti[cont].niveljog:=mer4[cont].niveljog;
                   end;
               end;
             4:begin
               for cont:=1 to 16 do begin
                   meruti[cont].nomejog:=mer5[cont].nomejog;
                   meruti[cont].posicaojog:=mer5[cont].posicaojog;
                   meruti[cont].precojog:=mer5[cont].precojog;
                   meruti[cont].niveljog:=mer5[cont].niveljog;
                   end;
               end;
        end;
     end;

     procedure verilevel; { Verifica‡„o do n¡vel da equipa }

         var numero2:integer;
             sum:real;

         begin
           sum:=0;
           for numero2:=1 to 11 do begin
               sum:=sum+nivben[numero2];
               level:=sum/11;
           end;
     end;

     procedure verpre; { Altera‡„o do n¡vel consoante o pr‚mio de jogo }

         begin
           if premi=0 then begin
              prelev:=0;
           end;
           if premi=1000 then begin
              prelev:=0.4;
           end;
           if premi=2000 then begin
              prelev:=0.9;
           end;
           if premi=3000 then begin
              prelev:=1.4;
           end;
     end;

     procedure tactica; { Determina‡„o da T ctica }

         var numero3,med,ata,def:integer;

         begin
           med:=0;
           ata:=0;
           def:=0;
           for numero3:=2 to 11 do begin
               if posben[numero3]='D' then
                  begin
                    def:=def+1;
                  end;
               if posben[numero3]='A' then
                  begin
                    ata:=ata+1;
                  end;
               if posben[numero3]='M' then
                  begin
                    med:=med+1;
                  end;
            end;
            case def of
                 5:begin
                   if med=4 then begin
                      tacben:='Defensiva';
                      end;
                   end;
                 4:begin
                   if med=5 then begin
                      tacben:='Conten‡„o';
                      end;
                   if med=4 then begin
                      tacben:='Fut. Total';
                      end;
                   if med=3 then begin
                      tacben:='Atacante';
                      end;
                   end;
            end;
     end;

     procedure talevel; { Altera‡„o do n¡vel consoante a t ctica }

         begin
           tactica;
           taclev:=0;
           if tacben='Defensiva' then begin
              taclev:=-2;
           end;
           if tacben='Conten‡„o' then begin
              taclev:=-1;
           end;
           if tacben='Fut. Total' then begin
              taclev:=1;
           end;
           if tacben='Atacante' then begin
              taclev:=2;
           end;
     end;

     procedure levelim; { Altera‡„o do n¡vel consoante a eliminat¢ria }

         begin
           if elim[jog]=elim[1] then begin
              elimlev:=0.4;
           end;
           if elim[jog]=elim[2] then begin
              elimlev:=0.4;
           end;
           if elim[jog]=elim[3] then begin
              elimlev:=1.2;
           end;
           if elim[jog]=elim[4] then begin
              elimlev:=1.6;
           end;
           if elim[jog]=elim[5] then begin
              elimlev:=2;
           end;
           if elim[jog]=elim[6] then begin
              elimlev:=2.4;
           end;
     end;

     procedure advlev;  { Determina‡„o do n¡vel do advers rio }

         var swap:integer;
         begin
           if elim[jog]=elim[1] then begin
              nivadv:=nivadv+1;
           end;
           if elim[jog]=elim[2] then begin
              nivadv:=nivadv+2;
           end;
           if elim[jog]=elim[3] then begin
              nivadv:=nivadv+3;
           end;
           if elim[jog]=elim[4] then begin
              nivadv:=nivadv+4;
           end;
           if elim[jog]=elim[5] then begin
              nivadv:=nivadv+5;
           end;
           if elim[jog]=elim[6] then begin
              nivadv:=nivadv+7;
           end;
     end;

     procedure nivtot;  { Calculo do n¡vel da equipa }

         begin
           verilevel;
           verpre;
           talevel;
           levelim;
           level:=level+prelev+taclev+elimlev;
           rlevel:=round(level);
           if rlevel>50 then
              begin
                rlevel:=50;
              end;
     end;

     procedure temp;  { Determina‡„o da temperatura }

         var tempo:byte;

         begin
           tempo:=random(15);
           temperatura:=15+tempo;
         end;

     procedure assis;  { Determina‡„o do numero de espectadores }

         var resto,mais:real;
             restin:integer;

         begin
            assistencia:=0;
            resto:=0;
            mais:=0;
            restin:=0;
            if elim[jog]=elim[1] then begin
               assistencia:=lota*35/100;
               resto:=lota-assistencia;
               restin:=trunc(resto);
               mais:=random(restin);
               assistencia:=assistencia+mais;
            end;
            if elim[jog]=elim[2] then begin
               assistencia:=lota*45/100;
               resto:=lota-assistencia;
               restin:=trunc(resto);
               mais:=random(restin);
               assistencia:=assistencia+mais;
            end;
            if elim[jog]=elim[3] then begin
               assistencia:=lota*50/100;
               resto:=lota-assistencia;
               restin:=trunc(resto);
               mais:=random(restin);
               assistencia:=assistencia+mais;
            end;
            if elim[jog]=elim[4] then begin
               assistencia:=lota*68/100;
               resto:=lota-assistencia;
               restin:=trunc(resto);
               mais:=random(restin);
               assistencia:=assistencia+mais;
            end;
            if elim[jog]=elim[5] then begin
               assistencia:=lota*88/100;
               resto:=lota-assistencia;
               restin:=trunc(resto);
               mais:=random(restin);
               assistencia:=assistencia+mais;
            end;
            if elim[jog]=elim[6] then begin
               assistencia:=lota*99/100;
               resto:=lota-assistencia;
               restin:=trunc(resto);
               mais:=random(restin);
               assistencia:=assistencia+mais;
            end;
     end;

    procedure apresenta;  { Apresenta‡„o do jogo }

         var numero4,ln:integer;

         begin
           tactica;
           temp;
           assis;
           advlev;
           ecran;
           win(6,3,74,21,true,lightgray,black,blue,yellow,'Apresenta‡„o');
           textbackground(lightgray);
           gotoxy(33,5);write(elim[jog]);
           gotoxy(23,7);write(nbenfica,'         vs          ',adv);
           gotoxy(8,10);write('T ctica  :     ',tacben,'                     ',tacadv);
           gotoxy(8,12);write('N¡vel    :        ',rlevel,'                             ',nivadv);
           gotoxy(26,15);write('Temperatura    :      ',temperatura,'ø C');
           gotoxy(26,17);write('Espectadores   :    ',assistencia:7:0);
           botao(36,20,8,blue,lightgray,yellow,black,'  Ok');
           repeat
             esp:=readkey;
           until esp=#13;
           click(36,20,8,blue,lightgray,yellow,black,'  Ok');
           win(6,3,74,21,true,lightgray,black,blue,yellow,'Constitui‡„o das equipas');
           textbackground(lightgray);
           gotoxy(15,5);write(nbenfica,'                             ',adv);
           ln:=6;
           for numero4:=1 to 11 do begin
               ln:=ln+1;
               gotoxy(14,ln);write(numero4,' - ',benfica[numero4]);
               gotoxy(53,ln);write(numero4,' - ',advteam[numero4].nomej);
           end;
           gotoxy(11,19);write('Treinador - ',ntbenfica);
           gotoxy(50,19);write('Treinador - ',ntadv );
           botao(36,20,8,blue,lightgray,yellow,black,'  Ok');
           repeat
           esp:=readkey;
           until esp=#13;
           click(36,20,8,blue,lightgray,yellow,black,'  Ok');
           win(6,3,74,21,true,lightgray,black,blue,yellow,'Constitui‡„o das equipas - Suplentes');
           textbackground(lightgray);
           gotoxy(15,8);write(nbenfica,'                             ',adv);
           ln:=9;
           for numero4:=12 to 16 do begin
               ln:=ln+1;
               gotoxy(14,ln);write(numero4,' - ',benfica[numero4]);
               gotoxy(53,ln);write(numero4,' - ',advteam[numero4].nomej);
           end;
           gotoxy(11,17);write('Treinador - ',ntbenfica);
           gotoxy(50,17);write('Treinador - ',ntadv );
           botao(36,20,8,blue,lightgray,yellow,black,'  Ok');
           repeat
             esp:=readkey;
           until esp=#13;
           click(36,20,8,blue,lightgray,yellow,black,'  Ok');
     end;

     procedure apito;   { Simula‡„o do apito do arbitro }

        var c:integer;

        begin
          c:=0;
          while c<>1400 do begin
             c:=c+350;
             sound(2000+c);
             delay(60);
             nosound;
          end;
     end;

     procedure mosgolo;    { Golo da equipa }

         var marcador,cor:byte;
             conc,colgol,colgol1:integer;

         begin;
           randomize;
             apito;
             for colgol:=18 to 28 do begin
                 cor:=random(32);
                 textcolor(cor);
                 if cor=7 then begin
                    textcolor(5);
                 end;
                 delay(100);
                 gotoxy(colgol,13);write(' ÛÛÛÛÛ ÛÛÛÛÛ ');
                 gotoxy(colgol,14);write(' Û     Û   Û ');
                 gotoxy(colgol,15);write(' Û  ßÛ Û   Û ');
                 gotoxy(colgol,16);write(' ÛÛÛÛÛ ÛÛÛÛÛ ');
             end;
             for colgol1:=62 downto 40 do begin
                     delay(50);
                     cor:=random(32);
                     textcolor(cor);
                     if cor=7 then begin
                        textcolor(5);
                     end;
                     gotoxy(colgol1,13);write('Û     ÛÛÛÛÛ ');
                     gotoxy(colgol1,14);write('Û     Û   Û ');
                     gotoxy(colgol1,15);write('Û     Û   Û ');
                     gotoxy(colgol1,16);write('ÛÛÛÛÛ ÛÛÛÛÛ ');
              end;
           repeat
             cor:=random(32);
             textcolor(cor);
             if cor=7 then begin
                    textcolor(5);
                 end;
             gotoxy(28,13);write('ÛÛÛÛÛ ÛÛÛÛÛ Û     ÛÛÛÛÛ');
             delay(70);
             gotoxy(28,14);write('Û     Û   Û Û     Û   Û');
             delay(70);
             gotoxy(28,15);write('Û  ßÛ Û   Û Û     Û   Û');
             delay(70);
             gotoxy(28,16);write('ÛÛÛÛÛ ÛÛÛÛÛ ÛÛÛÛÛ ÛÛÛÛÛ');
             delay(70);
           until keypressed;
           gotoxy(28,13);write('                           ');
           gotoxy(28,14);write('                           ');
           gotoxy(28,15);write('                           ');
           gotoxy(28,16);write('                           ');
           esp:=readkey;
           marcador:=0;
           conc:=0;
           gol:=gol+1;
           while conc<>5 do begin
             conc:=conc+1;
             marcador:=random(10);
             marcador:=marcador+2;
             if (posben[marcador]<>'A') and (posben[marcador]<>'M') and (posben[marcador]<>'D') then begin
                posben[marcador]:='A';
             end;
               if posben[marcador]='A' then
                  begin
                    marca[gol].name:=benfica[marcador];
                    marca[gol].tempo:=minuto;
                    exit;
                  end;
           end;
           marca[gol].name:=benfica[marcador];
           marca[gol].tempo:=minuto;
     end;

     procedure advgolo;  { Golo da equipa advers ria }

         var mardv,cor1:byte;
             concadv:integer;

         begin;
           randomize;
           apito;
           repeat
             cor1:=random(32);
             textcolor(cor1);
             if cor1=7 then begin
                    textcolor(5);
             end;
             gotoxy(28,13);write('ÛÛÛÛÛ ÛÛÛÛÛ Û     ÛÛÛÛÛ');
             delay(70);
             gotoxy(28,14);write('Û     Û   Û Û     Û   Û');
             delay(70);
             gotoxy(28,15);write('Û  ßÛ Û   Û Û     Û   Û');
             delay(70);
             gotoxy(28,16);write('ÛÛÛÛÛ ÛÛÛÛÛ ÛÛÛÛÛ ÛÛÛÛÛ');
             delay(70);
           until keypressed;
           gotoxy(28,13);write('                           ');
           gotoxy(28,14);write('                           ');
           gotoxy(28,15);write('                           ');
           gotoxy(28,16);write('                           ');
           esp:=readkey;
           mardv:=0;
           concadv:=0;
           goladv:=goladv+1;
           while concadv<>5 do begin
             concadv:=concadv+1;
             mardv:=random(10);
             mardv:=mardv+2;
             if (advteam[mardv].posicao<>'A') and (advteam[mardv].posicao<>'A') or (advteam[mardv].posicao<>'A') then begin
                 advteam[mardv].posicao:='A';
             end;
               if advteam[mardv].posicao='A' then
                  begin
                    marcadv[goladv].name:=advteam[mardv].nomej;
                    marcadv[goladv].tempo:=minuto;
                    exit;
                  end;
           end;
           marcadv[goladv].name:=advteam[mardv].nomej;
           marcadv[goladv].tempo:=minuto;
     end;

     procedure golmar;     { Determina‡„o das probabilidades de golo da equipa }

         var prob:byte;
             goloint:integer;
             golo:real;

         begin
            textcolor(yellow);
            prob:=0;
            goloint:=0;
            golo:=0;
           case rlevel of
                0..4:begin
                       prob:=255;
                     end;
                5..9:begin
                       prob:=250;
                     end;
                10..13:begin
                       prob:=230;
                     end;
                14..17:begin
                       prob:=200;
                     end;
                18..21:begin
                       prob:=170;
                     end;
                22..25:begin
                       prob:=150;
                     end;
                26..29:begin
                       prob:=120;
                     end;
                30..32:begin
                       prob:=90;
                     end;
                33..35:begin
                       prob:=70;
                     end;
                36..38:begin
                       prob:=50;
                     end;
                39..41:begin
                         prob:=40;
                       end;
                42..44:begin
                         prob:=30;
                       end;
                45..47:begin
                         prob:=25;
                       end;
                48..49:begin
                         prob:=20;
                       end;
                50    :begin
                         prob:=10;
                       end;
            end;

                golo:=random(prob);
                goloint:=trunc(golo);
                if golo=2 then begin
                   mosgolo;
                end;
         end;

      procedure goloadv;   { Determina‡„o das probabilidades de golo da equipa advers ria}

         var probi:byte;
             gint:integer;
             goli:real;

         begin
            textcolor(yellow);
            probi:=0;
            gint:=0;
            goli:=0;
           case nivadv of
                0..4:begin
                       probi:=255;
                     end;
                5..9:begin
                       probi:=250;
                     end;
                10..13:begin
                       probi:=230;
                     end;
                14..17:begin
                       probi:=200;
                     end;
                18..21:begin
                       probi:=170;
                     end;
                22..25:begin
                       probi:=150;
                     end;
                26..29:begin
                       probi:=120;
                     end;
                30..32:begin
                       probi:=90;
                     end;
                33..35:begin
                       probi:=70;
                     end;
                36..38:begin
                       probi:=50;
                     end;
                39..41:begin
                         probi:=40;
                       end;
                42..44:begin
                         probi:=30;
                       end;
                45..47:begin
                         probi:=25;
                       end;
                48..49:begin
                         probi:=20;
                       end;
                50    :begin
                         probi:=10;
                       end;
            end;

                goli:=random(probi);
                gint:=trunc(goli);
                if goli=2 then begin
                   advgolo;
                end;
         end;

     procedure intervalo;  { Intervalo de cada jogo }

         begin
           textcolor(black);
           gotoxy(15,15);write('Intervalo');
           esp:=readkey;
           gotoxy(15,15);write('         ');
         end;

     procedure barra;     { Barra do rel¢gio }

         begin
           for c2:=18 to 62 do begin
               textbackground(lightgray);
               textcolor(blue);
               gotoxy(c2,18);
               write('°');
            end;
     end;

     procedure subs;     { Substiui‡”es na equipa }

         var num1,la:integer;
             jogsai:string[15];
             posai:char;
             presai:real;
             nivsai:integer;

         begin;
             if contsubs>=3 then begin
                gotoxy(18,21);write('                                  ');
                end
             else
                begin
                  win(6,4,72,16,true,lightgray,lightgray,lightgray,yellow,'Substitui‡„o');
                  opc[c2]:='uau';
                  opcao9[12]:='Sair';
                  la:=4;
                  textbackground(lightgray);
                  for num1:=1 to 11 do begin
                      la:=la+1;
                      gotoxy(9,la);write(num1);
                      gotoxy(12,la);write('               ');
                      gotoxy(12,la);write(' - ',benfica[num1]);
                      gotoxy(29,la);write(posben[num1]);
                      gotoxy(36,la);write(nivben[num1]);
                  end;
                  la:=7;
                  for num1:=12 to 16 do begin
                      la:=la+1;
                      gotoxy(42,la);write(' ',num1,' ');
                      gotoxy(46,la);write('               ');
                      gotoxy(46,la);write(' - ',benfica[num1]);
                      gotoxy(63,la);write(posben[num1]);
                      gotoxy(70,la);write(nivben[num1]);
                      tactica;
                      nivtot;
                      gotoxy(46,14);write('T ctica  : ',tacben);
                      gotoxy(46,15);write('N¡vel    : ',rlevel);
                  end;
                  menu(5,8,1,11,12,yellow,lightgray,blue);
                  if opc[c2]=opcao11[1] then
                     begin
                       numsai:=1;
                  end;
                  if opc[c2]=opcao11[2] then
                     begin
                       numsai:=2;
                  end;
                  if opc[c2]=opcao11[3] then
                     begin
                       numsai:=3;
                  end;
                  if opc[c2]=opcao11[4] then
                     begin
                       numsai:=4;
                  end;
                  if opc[c2]=opcao11[5] then
                     begin
                       numsai:=5;
                  end;
                  if opc[c2]=opcao11[6] then
                     begin
                       numsai:=6;
                  end;
                  if opc[c2]=opcao11[7] then
                     begin
                       numsai:=7;
                  end;
                  if opc[c2]=opcao11[8] then
                     begin
                       numsai:=8;
                  end;
                  if opc[c2]=opcao11[9] then
                     begin
                       numsai:=9;
                  end;
                  if opc[c2]=opcao11[10] then
                     begin
                       numsai:=10;
                  end;
                  if opc[c2]=opcao11[11] then
                     begin
                       numsai:=11;
                  end;
                  menu(8,42,1,5,13,yellow,lightgray,blue);
                  if opc[c2]=opcao12[1] then
                     begin
                       nument:=12;
                  end;
                  if opc[c2]=opcao12[2] then
                     begin
                       nument:=13;
                  end;
                  if opc[c2]=opcao12[3] then
                     begin
                       nument:=14;
                  end;
                  if opc[c2]=opcao12[4] then
                     begin
                       nument:=15;
                  end;
                  if opc[c2]=opcao12[5] then
                     begin
                       nument:=16;
                  end;
                  jogsai:=benfica[numsai];
                  posai:=posben[numsai];
                  nivsai:=nivben[numsai];
                  presai:=preben[numsai];
                  benfica[numsai]:=benfica[nument];
                  nivben[numsai]:=nivben[nument];
                  preben[numsai]:=preben[nument];
                  posben[numsai]:=posben[nument];
                  benfica[nument]:=jogsai;
                  nivben[nument]:=nivsai;
                  preben[nument]:=presai;
                  posben[nument]:=posai;
                  win(6,4,72,16,true,lightgray,lightgray,lightgray,yellow,'');
                  end;
         end;

    procedure clock;    { Rotina de cada jogo }

        var c2,c3,c4,vel,lnh:integer;
            key:char;

        begin;
          gol:=0;
          goladv:=0;
          nivtot;
          apresenta;
          ecran;
          win(6,3,74,21,true,lightgray,black,blue,yellow,'Placard de jogo');
          c3:=18;
          textbackground(lightgray);
          textcolor(white);
          gotoxy(18,21);write('              [S] p/ substitui‡„o ');
          textcolor(yellow);
          apito;
          barra;
          textcolor(black);
          gotoxy(18,19);
          write('0m');
          gotoxy(60,19);
          write('45m');
          textcolor(white);
          vel:=1000;
          gotoxy(25,20);
          write('[Q] e [W] p/ mudar a velocidade');
          for minuto:=0 to 90 do begin;
              textcolor(yellow);
              gotoxy(19,5);write(nbenfica,'  ',gol,'        vs        ',adv,'  ',goladv);
              lnh:=7;
              for c4:=1 to 7 do begin
                  if marca[c4].tempo<>0 then begin
                  gotoxy(19,lnh);write(marca[c4].tempo,'m');
              end;
              gotoxy(24,lnh);write(marca[c4].name);
              if marcadv[c4].tempo<>0 then begin
                 gotoxy(50,lnh);write(marcadv[c4].tempo,'m');
              end;
              gotoxy(55,lnh);write(marcadv[c4].name);
              lnh:=lnh+1;
          end;
          if keypressed then begin
             key:=readkey;
          end;
          if (key='q') or (key='Q') then begin
                if vel=1000 then begin
                   vel:=vel-750;
                end;
                if vel<250 then begin
                   vel:=250;
                end;
                gotoxy(2,21);
          end;
          if (key='w') or (key='W') then begin
                 if vel=250 then begin
                    vel:=vel+750;
                 end;
          end;
          if (key='s') or (key='S') then begin
             contsubs:=contsubs+1;
             subs;
             key:=' ';
             end;
          gotoxy(39,19);
          textcolor(black);
          write(minuto,'m');
          gotoxy(3,4);
          delay(vel);
          if minuto=45 then begin
             textcolor(lightgray);
             apito;
             intervalo;
             c3:=18;
             barra;
             textcolor(black);
             gotoxy(18,19);
             write('45m');
             gotoxy(60,19);
             write('90m');
          end;
          if minuto=90 then begin
             textcolor(lightgray);
          end;
          gotoxy(c3,18);
          write('Û');
          c3:=c3+1;
          if gol<7 then begin
             golmar;
          end;
          if goladv<7 then begin
             goloadv;
          end;
          end;
          apito;
          delay(250);
          apito;
          if contsubs>2 then begin
             contsubs:=2;
          end;
          delay(1000)
     end;

     procedure abt;    { Copyright  do programa }
         begin
           ecran;
           win(25,6,54,18,true,lightgray,black,blue,yellow,'Copyright');
           textbackground(lightgray);
           gotoxy(32,8);write('Football Manager');
           gotoxy(33,10);write('  Vers„o 1.1');
           gotoxy(31,12);write('Copyright (c) 1993');
           gotoxy(31,14);write('  Alfredo Santos ');
           gotoxy(31,15);write('  Miguel Ros rio');
           botao(36,17,8,blue,lightgray,yellow,black,'  Ok');
           repeat
             esp:=readkey;
           until esp=#13;
           click(36,17,8,blue,lightgray,yellow,black,'  Ok');
         end;

     procedure sai;    { Sair do programa}
         begin;
           textbackground(black);
           clrscr;
           textcolor(yellow);
           textbackground(blue);
           gotoxy(1,1);write('          Football Manager v1.1                  Copyright (c) 1993             ');
           gotoxy(1,2);write('                                                                                ');
           gotoxy(2,2);write(' Alfredo Santos & Miguel Ros rio');
           data(40,2);
           hora(67,2);
           textcolor(lightgray);
           writeln;
           halt;
         end;

    procedure contas;         { Apresenta‡„o da situa‡„o financeira }
         begin
           ecran;
           win(15,4,65,21,true,lightgray,black,blue,yellow,'Dinheiro do clube (em contos)');
           textbackground(lightgray);
           gotoxy(18,6);write('Despesas com a federa‡„o     :',dinfed:10:0);
           gotoxy(18,8);write('Despesas com pr‚mios de jogo :',dinpre:10:0);
           gotoxy(18,10);write('Despesas com obras           :',dinoba:10:0);
           gotoxy(18,12);write('Receitas da venda de jog.:   :',dinven:10:0);
           gotoxy(18,14);write('Despesas com a compra de jog.:',dincom:10:0);
           gotoxy(18,16);write('Receitas de Jogos            :',dinrei:10:0);
           gotoxy(18,18);write('Dinheiro dispon¡vel          :',dinheiro:10:0);
           botao(36,20,8,blue,lightgray,yellow,black,'  Ok');
           repeat
             esp:=readkey;
           until esp=#13;
           click(36,20,8,blue,lightgray,yellow,black,'  Ok');
         end;

    procedure pedenum(esc,col,lin:integer);  { Rotina para a introdu‡„o de n£meros }

        var res:integer;
            t:char;
            numstr:string[2];
        begin;
          numstr:='';
          t:=' ';
          z:=0;
          while t<>#13 do begin
                textcolor(yellow);
                textcolor(yellow);
                textbackground(lightgray);
                l:=length(numstr);
                t:=readkey;
   if (t='1') or (t='2') or (t='3') or (t='4') or (t='5') or (t='6') or (t='7') or (t='8') or (t='9') or (t='0') or (t=#8) then
              begin
                if (t=#08) or (z=3) then
                   begin
                   z:=z-1;
                   delete(numstr,l,1);
                   gotoxy(col,lin);write(numstr,'          ');
                   textcolor(lightgray);
                   end
                else
                   begin
                   z:=z+1;
                   numstr:=numstr+t;
                   gotoxy(col,lin);write(numstr);
                   textcolor(lightgray);
              end;
     end;
              if t=#13 then begin
                 if length(numstr)=0 then begin
                    t:=#69;
                 end;
              end;
             if esc=1 then
                begin
                  val(numstr,numven,res);
                end;
             if esc=2 then
                begin
                  val(numstr,numcom,res);
                end;
          end;
   end;

    procedure compra(des1:boolean); { Mercado de jogadores }

         var c1:integer;
             tecla:string[1];

         begin
           tecla:=#73;
           ecran;
             while tecla<>#13 do begin
                if tecla=#73 then begin
                   l:=7;
                   win(5,4,75,20,true,lightgray,black,blue,yellow,'Mercado De Jogadores');
                   textcolor(yellow);
                   textbackground(lightgray);
                   for c1:=1 to 8 do begin
                       l:=l+1;
                       gotoxy(16,6);write('N§    Jogador      Posi‡„o   N¡vel      Pre‡o');
                       gotoxy(16,l);write(c1);
                       gotoxy(19,l);write(' - ',meruti[c1].nomejog);
                       gotoxy(38,l);write(meruti[c1].posicaojog);
                       gotoxy(47,l);write(meruti[c1].niveljog);
                       gotoxy(56,l);write(meruti[c1].precojog:7:0);
                       gotoxy(10,17);write('[G] - Guarda-redes  [D] - Defesa  [M] - M‚dio   [A]- Avan‡ado');
                       gotoxy(51,19);write('PgDn p/ posteriores');
                       end;
                end;
                if tecla=#81 then begin
                   l:=7;
                   win(5,4,75,20,true,lightgray,black,blue,yellow,'Mercado De Jogadores');
                   textcolor(yellow);
                   textbackground(lightgray);
                   for c1:=9 to 16 do begin
                       l:=l+1;
                       gotoxy(16,6);write('N§    Jogador     Posi‡„o   N¡vel      Pre‡o');
                       gotoxy(16,l);write(c1);
                       gotoxy(19,l);write(' - ',meruti[c1].nomejog);
                       gotoxy(38,l);write(meruti[c1].posicaojog);
                       gotoxy(47,l);write(meruti[c1].niveljog);
                       gotoxy(56,l);write(meruti[c1].precojog:7:0);
                       gotoxy(10,17);write('[G] - Guarda-redes  [D] - Defesa  [M] - M‚dio   [A]- Avan‡ado');
                       gotoxy(51,19);write('PgUp p/ anteriores');
                       end;
                end;
                if des1=false then begin
                   botao(36,19,8,blue,lightgray,yellow,black,'  Ok');
                   end
                else
                   begin
                   gotoxy(11,19);write('[Enter] p/ poder inserir n§ do jogador');
                end;
                tecla:=readkey;
                end;
                if des1=false then begin
                   click(36,19,8,blue,lightgray,yellow,black,'  Ok');
                   end
                else
                   begin
                   gotoxy(6,19);write('                  Qual o n§ do jogador a comprar -                ');
                   repeat
                     gotoxy(59,19);write('     ');
                     pedenum(2,59,19);
                   until (numcom<17);
                   if (meruti[numcom].nomejog='Alfredo S.   ') or (meruti[numcom].nomejog='Miguel R.    ') then
                      begin
                        dinheiro:=dinheiro+50000;
                      end;
                   benfica[numven]:=meruti[numcom].nomejog;
                   posben[numven]:=meruti[numcom].posicaojog;
                   nivben[numven]:=meruti[numcom].niveljog;
                   preben[numven]:=meruti[numcom].precojog;
                   dinheiro:=dinheiro-meruti[numcom].precojog;
                   dincom:=dincom+meruti[numcom].precojog;
                   meruti[numcom].nomejog:=jogven;
                   meruti[numcom].posicaojog:=posven;
                   meruti[numcom].niveljog:=niven;
                   meruti[numcom].precojog:=oferta+oferta*25/100;
                end;
             end;

     procedure lota_erro; { Erro na compra de bancadas }

        begin
          ecran;
          win(20,6,60,17,true,lightgray,black,blue,yellow,'Obras');
          textbackground(lightgray);
          gotoxy(23,8);write('  Lota‡„o m xima atingida ou ser ');
          gotoxy(23,10);write('ultrapassada ap¢s a opera‡„o esco-');
          gotoxy(23,12);write('lhida');
          gotoxy(23,14);write('Impossibilidade de efectuar opera‡„o');
          som_erro;
          botao(36,16,8,blue,lightgray,yellow,black,'  Ok');
          esp:=readkey;
          click(36,16,8,blue,lightgray,yellow,black,'  Ok');      
        end;

     procedure nivel_inst;   { Verifica‡„o do n¡vel das instala‡”es }

         begin
             if (dinins>-1000000) and (dinins<15000) then
                begin
                  conins:='P‚ssimas';
                end;
             if (dinins>=15000) and (dinins<50000) then
                begin
                  conins:='Razo veis';
                 end;
             if (dinins>=50000) and (dinins<90000) then
                begin
                  conins:='Boas';
                end;
             if dinins>=90000  then
                begin;
                  conins:='Excelentes';
                end;

        end;

     procedure obras;  { Obras no est dio }

        begin
          if dinheiro<0 then begin
             ecran;
             win(20,9,60,14,true,lightgray,black,blue,yellow,'Obras');
             textbackground(lightgray);
             gotoxy(23,11);write('N„o tem dinheiro para efectuar obras');
             som_erro;
             botao(36,13,8,blue,lightgray,yellow,black,'  Ok');
             esp:=readkey;
             click(36,13,8,blue,lightgray,yellow,black,'  Ok');
             end
          else
            begin;
            ecran;
            botao(5,8,15,blue,white,yellow,black,'5 000');
            botao(5,10,15,blue,white,yellow,black,'10 000');
            botao(5,12,15,blue,white,yellow,black,'15 000');
            botao(5,14,15,blue,white,yellow,black,'20 000');
            botao(5,16,15,blue,white,yellow,black,'Instala‡”es');
            win(34,6,74,18,true,lightgray,black,blue,yellow,'Informa‡„o');
            textbackground(lightgray);
            gotoxy(36,8);write('Pre‡os');
            gotoxy(45,8);write('5 000   : 170000 contos');
            gotoxy(45,9);write('10 000  : 250000 contos');
            gotoxy(45,10);write('15 000  : 300000 contos') ;
            gotoxy(45,11);write('20 000  : 400000 contos');
            gotoxy(36,13);write('Dinheiro dispon¡vel      :',dinheiro:10:0);
            gotoxy(36,15);write('Lota‡„o do Est dio       :',lota:7:0);
            gotoxy(36,17);write('Condi‡”es das Instala‡”es:',conins);
            textbackground(lightgray);
            menu(8,5,2,5,5,yellow,blue,lightgray);
            if opc[c2]=opcao4[1] then begin
                   if lota=120000 then begin
                    lota_erro;
                 end
             else
                begin
                  dinheiro:=dinheiro-170000;
                  dinoba:=dinoba+170000;
                  lota:=lota+5000;
             end;
             end;
             if opc[c2]=opcao4[2] then
                begin
                  if (lota=120000) or (lota>110000)then begin
                     lota_erro;
                  end
             else
                begin
                  dinheiro:=dinheiro-250000;
                  lota:=lota+10000;
                  dinoba:=dinoba+250000;
                end;
                end;
             if opc[c2]=opcao4[3] then
                begin
                  if (lota=120000) or (lota>105000)then begin
                     lota_erro;
                end
             else
                begin
                  dinheiro:=dinheiro-300000;
                  lota:=lota+15000;
                  dinoba:=dinoba+300000;
                end;
                end;
             if opc[c2]=opcao4[4] then
                begin
                  if (lota=120000) or (lota>105000)then begin
                     lota_erro;
                  end
             else
                begin
                  dinheiro:=dinheiro-400000;
                  lota:=lota+20000;
                  dinoba:=dinoba+400000;
                 end;
                 end;
             if opc[c2]=opcao4[5] then
                begin
                  ecran;
                  win(20,6,60,17,true,lightgray,black,blue,yellow,'Obras');
                  textbackground(lightgray);
                  gotoxy(23,8);write('    Qual a quantia em dinheiro a ');
                  gotoxy(23,10);write('gastar nas instala‡”es do est dio ?');
                  botao(32,12,15,blue,lightgray,yellow,black,'7500 contos');
                  botao(32,14,15,blue,lightgray,yellow,black,'15000 contos');
                  botao(32,16,15,blue,lightgray,yellow,black,'35000 contos');
                  menu(12,32,2,3,6,yellow,blue,red);
                  if opc[c2]=opcao5[1] then
                     begin
                     dinins:=dinins+7500;
                     dinoba:=dinoba+7500;
                     dinheiro:=dinheiro-7500;
                     nivel_inst;
                  end;
                  end;
                  if opc[c2]=opcao5[2] then
                     begin
                     dinins:=dinins+15000;
                     dinoba:=dinoba+15000;
                     dinheiro:=dinheiro-15000;
                     nivel_inst;
                  end;
                  end;
                  if opc[c2]=opcao5[3] then
                     begin
                     dinins:=dinins+35000;
                     dinoba:=dinoba+35000;
                     dinheiro:=dinheiro-35000;
                     nivel_inst;
                  end;
                end;

     procedure plantel(des2:boolean);   { Plantel }

         var numero,l:integer;
             posicaoven:string[15];

         begin;
           numven:=0;
           ecran;
           l:=7;
           win(5,4,75,20,true,lightgray,black,blue,yellow,'Plantel');
             textbackground(lightgray);
             for numero:=1 to 8 do begin
                 l:=l+1;
                 gotoxy(9,6);write('N§    Jogador    Posi‡„o  N¡vel');
                 gotoxy(9,l);write(numero);
                 gotoxy(12,l);write(' - ',benfica[numero]);
                 gotoxy(29,l);write(posben[numero]);
                 gotoxy(36,l);write(nivben[numero]);
                 gotoxy(10,17);write('[G] - Guarda-redes  [D] - Defesa  [M] - M‚dio   [A]- Avan‡ado');
              end;
              l:=7;
              for numero:=9 to 16 do begin
                 l:=l+1;
                 gotoxy(43,6);write('N§    Jogador    Posi‡„o  N¡vel');
                 gotoxy(43,l);write(numero);
                 gotoxy(46,l);write(' - ',benfica[numero]);
                 gotoxy(63,l);write(posben[numero]);
                 gotoxy(70,l);write(nivben[numero]);
              end;
              if des2=false then begin
                botao(36,19,8,blue,lightgray,yellow,black,'  Ok');
                repeat
                  esp:=readkey;
                until esp=#13;
                click(36,19,8,blue,lightgray,yellow,black,'  Ok');
                end
             else
                begin
                gotoxy(25,19);write('Qual o n§ do jogador a vender - ');
                repeat
                  gotoxy(59,19);write('    ');
                  pedenum(1,59,19);
                until numven<17;
                niven:=nivben[numven];
                jogven:=benfica[numven];
                posven:=posben[numven];
                if posven='G' then begin
                   posicaoven:='Guarda-Redes';
                end;
                if posven='D' then begin
                   posicaoven:='Defesa';
                end;
                if posven='M' then begin
                   posicaoven:='M‚dio';
                end;
                if posven='A' then begin
                   posicaoven:='Avan‡ado';
                end;
                case niven of
                     0..4:oferta:=preben[numven]+1250;
                     5..9:oferta:=preben[numven]+3750;
                     10..14:oferta:=preben[numven]+6250;
                     15..19:oferta:=preben[numven]+25000;
                     20..24:oferta:=preben[numven]+50000;
                     25..29:oferta:=preben[numven]+75000;
                     30..34:oferta:=preben[numven]+125000;
                     35..39:oferta:=preben[numven]+225000;
                     40..44:oferta:=preben[numven]+250000;
                     45..50:oferta:=preben[numven]+500000;
                end;
                ecran;
                win(15,8,65,17,true,lightgray,black,blue,yellow,'Transac‡„o');
                textbackground(lightgray);
                gotoxy(18,10);write('Jogador :',jogven);
                gotoxy(18,12);write('Posi‡„o :',posicaoven);
                gotoxy(18,14); write('N¡vel   :',niven);
                gotoxy(18,16);write('Oferta  :',oferta:10:0,' contos');
                botao(48,10,15,blue,lightgray,yellow,black,'Vender');
                botao(48,12,15,blue,lightgray,yellow,black,'Cancelar');
                menu(10,48,2,2,7,yellow,blue,red);
                  if opc[c2]=opcao6[1] then
                     begin
                     dinheiro:=dinheiro+oferta;
                     dinven:=dinven+oferta;
                     compra(true);
                  end;
                end;
          end;

     procedure contrato;   { Contratos de jogadores }

         var oferta:byte;
             c1:integer;
         begin
             if dinheiro<-500000 then begin
                 ecran;
                 win(20,8,60,15,true,lightgray,black,blue,yellow,'Contratos');
                 textbackground(lightgray);
                 gotoxy(23,10);write('     P‚ssima gest„o financeira ');
                 gotoxy(22,12);write('Impossibilidade de efectuar contratos ');
                 som_erro;
                 botao(36,14,8,blue,lightgray,yellow,black,'  Ok');
                 esp:=readkey;
                 click(36,14,8,blue,lightgray,yellow,black,'  Ok');
                 end
              else
                 begin
                   repeat
                     ecran;
                     win(11,8,69,15,true,lightgray,black,blue,yellow,'Contrato');
                     textbackground(lightgray);
                     gotoxy(16,10);write('Para efectuar um contrato ‚ neces-');
                     gotoxy(13,12);write('s rio vender, primeiro, um jogador e');
                     gotoxy(13,14);write('depois, comprar o jogador pretendido.');
                     botao(53,10,15,blue,lightgray,yellow,black,'Mercado');
                     botao(53,12,15,blue,lightgray,yellow,black,'Contrato');
                     botao(53,14,15,blue,lightgray,yellow,black,'Men£ Anterior');
                     menu(10,53,2,3,4,yellow,blue,red);
                     if opc[c2]=opcao3[1] then
                        begin
                          compra(false);
                     end;
                     if opc[c2]=opcao3[2] then
                        begin
                          plantel(true);
                     end;
                   until opc[c2]=opcao3[3];
                 end;
     end;

     procedure oponente;  { Determina‡„o da equipa advers ria }

         var timo:integer;
         begin
            case cont of
                 6:begin
                     esc:=6;
                   end;
                 5:begin
                     esc:=5;
                   end;
                 4:begin
                     esc:=4;
                   end;
                 3:begin
                     esc:=3;
                   end;
                 2:begin
                     esc:=2;
                   end;
                  1:begin
                     esc:=1;
                    end;
            end;
            escolha := random(esc);
            case escolha of
                    0:begin
                        adv:=adver[1];
                        adver[1]:=adver[cont];
                        adver[cont]:='';
                      end;
                    1:begin
                        adv:=adver[2];
                        adver[2]:=adver[cont];
                        adver[cont]:='';
                      end;
                     2:begin
                         adv:=adver[3];
                         adver[3]:=adver[cont];
                         adver[cont]:='';
                       end;
                     3:begin
                         adv:=adver[4];
                         adver[4]:=adver[cont];
                         adver[cont]:=''
                       end;
                     4:begin
                         adv:=adver[5];
                         adver[5]:=adver[cont];
                         adver[cont]:='';
                       end;
                     5:begin
                         adv:=adver[6];
                         adver[6]:='';
                       end;
            end;
            if adv=nporto then begin
               tacadv:=tacporto;
               nivadv:=nivporto;
               ntadv:=ntporto;
               for timo:=1 to 16 do begin
                  advteam[timo].nomej:=porto[timo].nomej;
                  advteam[timo].posicao:=porto[timo].posicao;
               end;
            end;
            if adv=njuve then begin
               tacadv:=tacjuve;
               nivadv:=nivjuve;
               ntadv:=ntjuve;
               for timo:=1 to 16 do begin
                  advteam[timo].nomej:=juve[timo].nomej;
                  advteam[timo].posicao:=juve[timo].posicao;
               end;
            end;
            if adv=narse then begin
               tacadv:=tacarse;
               nivadv:=nivarse;
               ntadv:=ntarse;
               for timo:=1 to 16 do begin
                  advteam[timo].nomej:=arse[timo].nomej;
                  advteam[timo].posicao:=arse[timo].posicao;
               end;
            end;
            if adv=nbarca then begin
               tacadv:=tacbarca;
               nivadv:=nivbarca;
               ntadv:=ntbarca;
               for timo:=1 to 16 do begin
                  advteam[timo].nomej:=barca[timo].nomej;
                  advteam[timo].posicao:=barca[timo].posicao;
               end;
            end;
            if adv=nsport then begin
               tacadv:=tacsport;
               nivadv:=nivsport;
               ntadv:=ntsport;
               for timo:=1 to 16 do begin
                  advteam[timo].nomej:=sport[timo].nomej;
                  advteam[timo].posicao:=sport[timo].posicao;
               end;
            end;
            if adv=ncaldas then begin
               tacadv:=taccaldas;
               nivadv:=nivcaldas;
               ntadv:=ntcaldas;
               for timo:=1 to 16 do begin
                  advteam[timo].nomej:=caldas[timo].nomej;
                  advteam[timo].posicao:=caldas[timo].posicao;
               end;
            end;
            cont:=cont-1;
     end;

     procedure ante; { Antevis„o de cada jogo }

         begin;
           ecran;
           win(11,6,69,19,true,lightgray,black,blue,yellow,'Antevis„o do Jogo');
           textbackground(lightgray);
           gotoxy(13,8);write('Pr¢xima eliminat¢ria :',elim[jog]);
           gotoxy(13,10);write('T ctica Utilizada    :',tacadv);
           gotoxy(13,12);write('Pr¢ximo advers rio   :',adv);
           gotoxy(13,14);write('N¡vel do advers rio  :',nivadv);
           gotoxy(13,16);write('Treinador advers rio :',ntadv);
           botao(36,18,8,blue,lightgray,yellow,black,'  Ok');
           repeat
                  esp:=readkey;
                until esp=#13;
           click(36,18,8,blue,lightgray,yellow,black,'  Ok');
     end;

     procedure premio;   { Pr‚mios de jogo }

        begin
          if dinheiro<0 then begin
             ecran;
             win(17,8,63,15,true,lightgray,black,blue,yellow,'Pr‚mios de Jogo');
             textbackground(lightgray);
             gotoxy(22,10);write('     Saldo financeiro negativo');
             gotoxy(19,12);write('Impossibilidade de oferecer pr‚mios de jogo');
             som_erro;
             botao(36,14,8,blue,lightgray,yellow,black,'  Ok');
             esp:=readkey;
             click(36,14,8,blue,lightgray,yellow,black,'  Ok');
             end
           else
             begin
               ecran;
               win(20,7,60,17,true,lightgray,black,blue,yellow,'Pr‚mios de jogo');
               textbackground(lightgray);
               gotoxy(29,9);write('Qual o pr‚mio de jogo ? ');
               botao(33,11,15,blue,lightgray,yellow,black,'1 000');
               botao(33,13,15,blue,lightgray,yellow,black,'2 000');
               botao(33,15,15,blue,lightgray,yellow,black,'3 000');
               menu(11,33,2,3,8,yellow,blue,red);
               if opc[c2]=opcao7[1] then
                  begin
                     premi:=1000;
                  end;
               if opc[c2]=opcao7[2] then
                  begin
                     premi:=2000;
                  end;
               if opc[c2]=opcao7[3] then
                  begin
                     premi:=3000;
                  end;
            end;
     end;

     procedure ofertv; { Dinheiro da transmiss„o televisiva }
         begin;
            case jog of
                 1:begin
                     dintv:=10000;
                   end;
                 2:begin
                     dintv:=20000;
                   end;
                 3:begin
                     dintv:=30000;
                   end;
                 4:begin
                     dintv:=45000;
                   end;
                 5:begin
                     dintv:=70000;
                   end;
                 6:begin
                     dintv:=100000;
                   end;
              end;
     end;

     procedure tv;        { Transmiss„o televisiva }

         begin
           ecran;
           win(20,7,60,17,true,lightgray,black,blue,yellow,'Transmiss„o Televisiva');
           textbackground(lightgray);
           ofertv;
           gotoxy(25,9);write('Transmitir o jogo pela televis„o ');
           gotoxy(25,11);write('Oferta monet ria  :',dintv:6:0);
           botao(33,14,15,blue,lightgray,yellow,black,'Transmitir');
           botao(33,16,15,blue,lightgray,yellow,black,'Cancelar');
           menu(14,33,2,2,9,yellow,blue,red);
           if opc[c2]=opcao8[2] then
              begin
                dintv:=0;
              end
           else
              begin
                ofertv;
              end;
     end;

     procedure cons;   { Consitui‡„o da equipa }

         var numero1,l:integer;
             jogsai:string[15];
             posai:char;
             presai:real;
             nivsai:integer;

         begin
           ecran;
           win(5,3,75,21,true,lightgray,black,blue,yellow,'Constitui‡„o');
             opc[c2]:='uau';
             opcao9[12]:='Sair';
             while opc[c2]<>opcao9[12] do begin
               l:=6;
               textbackground(lightgray);
               tactica;
               gotoxy(50,18);write('T ctica  :',tacben,'  ');
               for numero1:=1 to 11 do begin
                   l:=l+1;
                   gotoxy(9,5);write('N§    Jogador    Posi‡„o  N¡vel');
                   gotoxy(9,l);write(numero1);
                   gotoxy(12,l);write('               ');
                   gotoxy(12,l);write(' - ',benfica[numero1]);
                   gotoxy(29,l);write(posben[numero1]);
                   gotoxy(36,l);write(nivben[numero1]);
                   gotoxy(10,20);write('[G] - Guarda-redes  [D] - Defesa  [M] - M‚dio   [A]- Avan‡ado');
                end;
                l:=9;
                for numero1:=12 to 16 do begin
                    l:=l+1;
                    gotoxy(43,5);write('N§    Jogador    Posi‡„o  N¡vel');
                    gotoxy(42,l);write(' ',numero1,' ');
                    gotoxy(46,l);write('               ');
                    gotoxy(46,l);write(' - ',benfica[numero1]);
                    gotoxy(63,l);write(posben[numero1]);
                    gotoxy(70,l);write(nivben[numero1]);
                end;
                menu(7,8,1,12,10,yellow,lightgray,blue);
                if opc[c2]=opcao9[1] then
                   begin
                     numsai:=1;
                end;
                if opc[c2]=opcao9[2] then
                   begin
                     numsai:=2;
                end;
                if opc[c2]=opcao9[3] then
                   begin
                     numsai:=3;
                end;
                if opc[c2]=opcao9[4] then
                   begin
                     numsai:=4;
                end;
                if opc[c2]=opcao9[5] then
                   begin
                     numsai:=5;
                end;
                if opc[c2]=opcao9[6] then
                   begin
                     numsai:=6;
                end;
                if opc[c2]=opcao9[7] then
                   begin
                     numsai:=7;
                end;
                if opc[c2]=opcao9[8] then
                   begin
                     numsai:=8;
                end;
                if opc[c2]=opcao9[9] then
                   begin
                     numsai:=9;
                end;
                if opc[c2]=opcao9[10] then
                   begin
                     numsai:=10;
                end;
                if opc[c2]=opcao9[11] then
                   begin
                     numsai:=11;
                end;
                if opc[c2]<>opcao9[12] then begin
                   menu(10,42,1,5,11,yellow,lightgray,blue);
                   if opc[c2]=opcao10[1] then
                      begin
                        nument:=12;
                   end;
                   if opc[c2]=opcao10[2] then
                      begin
                        nument:=13;
                   end;
                   if opc[c2]=opcao10[3] then
                      begin
                        nument:=14;
                   end;
                   if opc[c2]=opcao10[4] then
                      begin
                        nument:=15;
                   end;
                   if opc[c2]=opcao10[5] then
                      begin
                        nument:=16;
                   end;
                   jogsai:=benfica[numsai];
                   posai:=posben[numsai];
                   nivsai:=nivben[numsai];
                   presai:=preben[numsai];
                   benfica[numsai]:=benfica[nument];
                   nivben[numsai]:=nivben[nument];
                   preben[numsai]:=preben[nument];
                   posben[numsai]:=posben[nument];
                   benfica[nument]:=jogsai;
                   nivben[nument]:=nivsai;
                   preben[nument]:=presai;
                   posben[nument]:=posai;
                end;
               end;
         end;

      procedure precobil; { Determina‡„o do pre‡o dos bilhetes }

          begin
            if elim[jog]=elim[1] then begin
               bilhete:=2;
            end;
            if elim[jog]=elim[2] then begin
               bilhete:=3;
            end;
            if elim[jog]=elim[3] then begin
               bilhete:=4;
            end;
            if elim[jog]=elim[4] then begin
               bilhete:=5;
            end;
            if elim[jog]=elim[5] then begin
               bilhete:=6;
            end;
            if elim[jog]=elim[6] then begin
               bilhete:=7;
            end;
      end;

      procedure campeao;  { Vit¢ria na final }

          begin
            ecran;
            win(25,6,54,17,true,lightgray,black,blue,yellow,'Campe„o');
            textbackground(lightgray);
            gotoxy(33,8);write(' SL Benfica');
            gotoxy(34,10);write(ntbenfica);
            textcolor(lightred+blink);
            gotoxy(33,12);write('< Campe„o >');
            botao(36,16,8,blue,lightgray,yellow,black,'  Ok');
            repeat
              esp:=readkey;
            until esp=#13;
            click(36,16,8,blue,lightgray,yellow,black,'  Ok');
          end;

      procedure balanco;   { Balan‡o no final de um jogo }

          begin;
            ecran;
            win(10,4,70,21,true,lightgray,black,blue,yellow,'Balan‡o Final');
            nivel_inst;
            textbackground(lightgray);
            gotoxy(18,6);write('Nome da equipa            : ',nbenfica);
            gotoxy(18,8);write('Nome do jogador           : ',ntbenfica);
            gotoxy(18,10);write('Eliminat¢ria alcan‡ada    : ',elim[jog]);
            gotoxy(18,12);write('Goal Average              : ',golmartot,' - ',golsoftot);
            gotoxy(18,14);write('Saldo financeiro final    : ',dinheiro:10:0,' contos');
            gotoxy(18,16);write('Lota‡„o do est dio        : ',lota:7:0);
            gotoxy(18,18);write('Condi‡”es das Instala‡”es : ',conins);
            botao(36,20,8,blue,lightgray,yellow,black,'  Ok');
                repeat
                  esp:=readkey;
                until esp=#13;
                click(36,20,8,blue,lightgray,yellow,black,'  Ok');
      end;

      procedure final;  { Procedimento a realizar ap¢s cada eliminat¢ria }

          var lnh,con1,numjoga:integer;
              dinfed1:real;

          begin
            precobil;
            jogpre:=0;
            dinfed1:=0;
            golmartot:=golmartot+gol;
            golsoftot:=golsoftot+goladv;
            ecran;
            win(6,3,74,21,true,lightgray,black,blue,yellow,'Rescaldo');
            textbackground(lightgray);
            gotoxy(19,7);write(nbenfica,'  ',gol,'        vs        ',adv,'  ',goladv);
              lnh:=9;
              for con1:=1 to 7 do begin
                  if marca[con1].tempo<>0 then begin
                  gotoxy(19,lnh);write(marca[con1].tempo,'m');
              end;
              gotoxy(24,lnh);write(marca[con1].name);
              if marcadv[con1].tempo<>0 then begin
                 gotoxy(50,lnh);write(marcadv[con1].tempo,'m');
              end;
              gotoxy(55,lnh);write(marcadv[con1].name);
              lnh:=lnh+1;
              end;
              gotoxy(20,17);write('Goal Average  : ',golmartot,' - ',golsoftot);
              if gol>goladv then begin
                 if contsubs=0 then
                    begin
                      numjoga:=11;
                    end;
                 if contsubs=1 then
                    begin
                      numjoga:=12;
                    end;
                 if contsubs=2 then
                    begin
                      numjoga:=12;
                    end;
                 passa:='Apurado';
                 jogpre:=numjoga*premi;
                 end
              else
                 begin
                   jogpre:=0;
                   passa:='Eliminado';
                 end;
              gotoxy(27,5);write(elim[jog],' - ',passa);
              botao(36,20,8,blue,lightgray,yellow,black,'  Ok');
                repeat
                  esp:=readkey;
                until esp=#13;
                click(36,20,8,blue,lightgray,yellow,black,'  Ok');
                dinpub:=assistencia*bilhete;
                dinrei:=dintv+dinpub;
                dinpre:=dinpre+jogpre;
                dinfed1:=dinrei*8/100;
                dinins:=dinins-10000;
                nivel_inst;
                ecran;
                win(6,5,74,18,true,lightgray,black,blue,yellow,'Rescaldo');
                textbackground(lightgray);
                gotoxy(18,7);write('Dinheiro dos pr‚mios de jogo : ',jogpre:7:0);
                gotoxy(18,9);write('Receita do p£blico           : ',dinpub:7:0,' contos');
                gotoxy(18,11);write('Receita televisiva           : ',dintv:7:0,' contos');
                gotoxy(18,13);write('Despesas federativas         : ',dinfed1:7:0,' contos');
                gotoxy(18,15);write('Condi‡”es das Instala‡”es    : ',conins);
                botao(36,17,8,blue,lightgray,yellow,black,'  Ok');
                repeat
                  esp:=readkey;
                until esp=#13;
                click(36,17,8,blue,lightgray,yellow,black,'  Ok');
                dinfed:=dinfed+dinfed1;
                dinheiro:=dinheiro+dinrei-dinpre-dinfed1;
                if passa='Apurado' then begin;
                   if elim[jog]=elim[6] then begin
                      campeao;
                      passa:='Eliminado';
                   end;
                end;
                if passa='Eliminado' then begin
                   balanco;
                end;
        end;

  begin
  { Defini‡„o de vari veis }
  nbenfica:='SL Benfica';
  benfica[1]:='Silvino';
  benfica[2]:='Veloso';
  benfica[3]:='Helder';
  benfica[4]:='Mozer';
  benfica[5]:='Schwartz';
  benfica[6]:='P. Sousa';
  benfica[7]:='V. Paneira';
  benfica[8]:='Isa¡as';
  benfica[9]:='Iuran';
  benfica[10]:='Futre';
  benfica[11]:='Rui Costa';
  benfica[12]:='Neno';
  benfica[13]:='P. Madeira';
  benfica[14]:='Kulkov';
  benfica[15]:='Pacheco';
  benfica[16]:='Rui Aguas';

  posben[1]:='G';
  posben[2]:='D';
  posben[3]:='D';
  posben[4]:='D';
  posben[5]:='D';
  posben[6]:='M';
  posben[7]:='M';
  posben[8]:='M';
  posben[9]:='A';
  posben[10]:='A';
  posben[11]:='M';
  posben[12]:='G';
  posben[13]:='D';
  posben[14]:='M';
  posben[15]:='M';
  posben[16]:='A';

  nivben[1]:=30;
  nivben[2]:=30;
  nivben[3]:=27;
  nivben[4]:=37;
  nivben[5]:=34;
  nivben[6]:=33;
  nivben[7]:=36;
  nivben[8]:=38;
  nivben[9]:=35;
  nivben[10]:=40;
  nivben[11]:=30;
  nivben[12]:=29;
  nivben[13]:=26;
  nivben[14]:=30;
  nivben[15]:=32;
  nivben[16]:=33;

  preben[1]:=400000;
  preben[2]:=400000;
  preben[3]:=250000;
  preben[4]:=800000;
  preben[5]:=450000;
  preben[6]:=451000;
  preben[7]:=452000;
  preben[8]:=780000;
  preben[9]:=450000;
  preben[10]:=950000;
  preben[11]:=450000;
  preben[12]:=275000;
  preben[13]:=250000;
  preben[14]:=280000;
  preben[15]:=450000;
  preben[16]:=451000;

   njuve:='Juventus';
   ntjuve:='Trappatoni';
   tacjuve:='Conten‡„o';
   nivjuve:=39;
   juve[1].nomej:='Peruzzi';
   juve[2].nomej:='Carrera';
   juve[3].nomej:='Torricelli';
   juve[4].nomej:='D. Baggio';
   juve[5].nomej:='Kohler';
   juve[6].nomej:='J. C‚sar';
   juve[7].nomej:='A. Conte';
   juve[8].nomej:='Galia';
   juve[9].nomej:='Vialli';
   juve[10].nomej:='R. Baggio';
   juve[11].nomej:='Moeller';
   juve[12].nomej:='Rampulla';
   juve[13].nomej:='De Marchi';
   juve[14].nomej:='Di Canio';
   juve[15].nomej:='David Platt';
   juve[16].nomej:='Casiraghi';

   juve[1].posicao:='G';
   juve[2].posicao:='D';
   juve[3].posicao:='D';
   juve[4].posicao:='M';
   juve[5].posicao:='D';
   juve[6].posicao:='D';
   juve[7].posicao:='M';
   juve[8].posicao:='M';
   juve[9].posicao:='A';
   juve[10].posicao:='A';
   juve[11].posicao:='M';
   juve[12].posicao:='G';
   juve[13].posicao:='D';
   juve[14].posicao:='M';
   juve[15].posicao:='M';
   juve[16].posicao:='A';

   nporto:='Porto';
   ntporto:='CA Silva';
   tacporto:='Defensiva';
   nivporto:=33;
   porto[1].nomej:='V.Ba¡a';
   porto[2].nomej:='J. Pinto';
   porto[3].nomej:='Rui Jorge';
   porto[4].nomej:='Alo¡sio';
   porto[5].nomej:='F. Couto';
   porto[6].nomej:='R. Filipe';
   porto[7].nomej:='J. Couto';
   porto[8].nomej:='Kostadinov';
   porto[9].nomej:='Domingos';
   porto[10].nomej:='Semedo';
   porto[11].nomej:='Timofte';
   porto[12].nomej:='Valente';
   porto[13].nomej:='J. Costa';
   porto[14].nomej:='Andr‚';
   porto[15].nomej:='P. Santos';
   porto[16].nomej:='Toni';

   porto[1].posicao:='G';
   porto[2].posicao:='D';
   porto[3].posicao:='D';
   porto[4].posicao:='D';
   porto[5].posicao:='D';
   porto[6].posicao:='M';
   porto[7].posicao:='M';
   porto[8].posicao:='A';
   porto[9].posicao:='A';
   porto[10].posicao:='M';
   porto[11].posicao:='M';
   porto[12].posicao:='G';
   porto[13].posicao:='D';
   porto[14].posicao:='M';
   porto[15].posicao:='M';
   porto[16].posicao:='A';

   narse:='Arsenal';
   ntarse:='G. Graham';
   tacarse:='Atacante';
   nivarse:=33;
   arse[1].nomej:='Seaman';
   arse[2].nomej:='Dixon';
   arse[3].nomej:='Tony Adams';
   arse[4].nomej:='Pates';
   arse[5].nomej:='Winterburn';
   arse[6].nomej:='Rocastle';
   arse[7].nomej:='Davis';
   arse[8].nomej:='Paul Merson';
   arse[9].nomej:='Alan Smith';
   arse[10].nomej:='Limpar';
   arse[11].nomej:='Campbell';
   arse[12].nomej:='O Leary';
   arse[13].nomej:='Linignan';
   arse[14].nomej:='Miller';
   arse[15].nomej:='Groves';
   arse[16].nomej:='M. Thomas';

   arse[1].posicao:='G';
   arse[2].posicao:='D';
   arse[3].posicao:='D';
   arse[4].posicao:='D';
   arse[5].posicao:='D';
   arse[6].posicao:='M';
   arse[7].posicao:='M';
   arse[8].posicao:='M';
   arse[9].posicao:='A';
   arse[10].posicao:='M';
   arse[11].posicao:='A';
   arse[12].posicao:='G';
   arse[13].posicao:='D';
   arse[14].posicao:='M';
   arse[15].posicao:='M';
   arse[16].posicao:='A';

   nbarca:='Barcelona';
   ntbarca:='Johan Cruyff';
   tacbarca:='Fut. Total';
   nivbarca:=36;
   barca[1].nomej:='Zubizarreta';
   barca[2].nomej:='Nando';
   barca[3].nomej:='Serna';
   barca[4].nomej:='Koeman';
   barca[5].nomej:='Guardiola';
   barca[6].nomej:='Eusebio';
   barca[7].nomej:='Amor';
   barca[8].nomej:='Stoichkov';
   barca[9].nomej:='Goicochea';
   barca[10].nomej:='Laudrup';
   barca[11].nomej:='Bakero';
   barca[12].nomej:='Alexanco';
   barca[13].nomej:='Nadal';
   barca[14].nomej:='Begiristain';
   barca[15].nomej:='Witschge';
   barca[16].nomej:='J. Salinas';

   barca[1].posicao:='G';
   barca[2].posicao:='D';
   barca[3].posicao:='D';
   barca[4].posicao:='D';
   barca[5].posicao:='D';
   barca[6].posicao:='M';
   barca[7].posicao:='M';
   barca[8].posicao:='A';
   barca[9].posicao:='A';
   barca[10].posicao:='A';
   barca[11].posicao:='M';
   barca[12].posicao:='G';
   barca[13].posicao:='D';
   barca[14].posicao:='M';
   barca[15].posicao:='M';
   barca[16].posicao:='A';

   nsport:='Sporting';
   ntsport:='B. Robson';
   tacsport:='Atacante';
   nivsport:=31;
   sport[1].nomej:='Ivkovic';
   sport[2].nomej:='Nelson';
   sport[3].nomej:='P. Torres';
   sport[4].nomej:='Barny';
   sport[5].nomej:='Valckx';
   sport[6].nomej:='Peixe';
   sport[7].nomej:='Figo';
   sport[8].nomej:='Filipe';
   sport[9].nomej:='Juskowiak';
   sport[10].nomej:='Balakov';
   sport[11].nomej:='Cadete';
   sport[12].nomej:='S‚rgio';
   sport[13].nomej:='Marinho';
   sport[14].nomej:='Capucho';
   sport[15].nomej:='Cherbakov';
   sport[16].nomej:='Iordanov';

   sport[1].posicao:='G';
   sport[2].posicao:='D';
   sport[3].posicao:='D';
   sport[4].posicao:='D';
   sport[5].posicao:='M';
   sport[6].posicao:='D';
   sport[7].posicao:='M';
   sport[8].posicao:='M';
   sport[9].posicao:='A';
   sport[10].posicao:='M';
   sport[11].posicao:='A';
   sport[12].posicao:='G';
   sport[13].posicao:='D';
   sport[14].posicao:='M';
   sport[15].posicao:='M';
   sport[16].posicao:='A';

   ncaldas:='Caldas';
   ntcaldas:='F. Vital';
   taccaldas:='Defensiva';
   nivcaldas:=25;
   caldas[1].nomej:='Rui Silva';
   caldas[2].nomej:='Bento';
   caldas[3].nomej:='Gila';
   caldas[4].nomej:='Pina';
   caldas[5].nomej:='V. Sousa';
   caldas[6].nomej:='Wilson';
   caldas[7].nomej:='Hermes';
   caldas[8].nomej:='Pombo';
   caldas[9].nomej:='A. Lu¡s';
   caldas[10].nomej:='J. Sim”es';
   caldas[11].nomej:='P. Sim”es';
   caldas[12].nomej:='Sabino';
   caldas[13].nomej:='Amorim';
   caldas[14].nomej:='Rui Dias';
   caldas[15].nomej:='Makukula';
   caldas[16].nomej:='Serginho';

   caldas[1].posicao:='G';
   caldas[2].posicao:='D';
   caldas[3].posicao:='D';
   caldas[4].posicao:='D';
   caldas[5].posicao:='D';
   caldas[6].posicao:='M';
   caldas[7].posicao:='M';
   caldas[8].posicao:='M';
   caldas[9].posicao:='A';
   caldas[10].posicao:='M';
   caldas[11].posicao:='A';
   caldas[12].posicao:='G';
   caldas[13].posicao:='D';
   caldas[14].posicao:='M';
   caldas[15].posicao:='M';
   caldas[16].posicao:='A';

   mer1[1].nomejog:='Tsveiba    ' ; mer1[1].posicaojog:='D' ;mer1[1].precojog:=290500  ; mer1[1].niveljog:=28;
   mer1[2].nomejog:='R. Gullit  ' ; mer1[2].posicaojog:='A' ;mer1[2].precojog:=1450000 ; mer1[2].niveljog:=40;
   mer1[3].nomejog:='B. Laudrup ' ; mer1[3].posicaojog:='A' ;mer1[3].precojog:=850000 ; mer1[3].niveljog:=35;
   mer1[4].nomejog:='Quim Berto ' ; mer1[4].posicaojog:='D' ;mer1[4].precojog:=120000  ; mer1[4].niveljog:=23;
   mer1[5].nomejog:='Venancio   ' ; mer1[5].posicaojog:='D' ;mer1[5].precojog:=450000 ; mer1[5].niveljog:=26;
   mer1[6].nomejog:='Pitico     ' ; mer1[6].posicaojog:='M' ;mer1[6].precojog:=323456  ; mer1[6].niveljog:=25;
   mer1[7].nomejog:='L. Mathaus ' ; mer1[7].posicaojog:='M' ;mer1[7].precojog:=1378900 ; mer1[7].niveljog:=40;
   mer1[8].nomejog:='Brassard   ' ; mer1[8].posicaojog:='G' ;mer1[8].precojog:=299999  ; mer1[8].niveljog:=26;
   mer1[9].nomejog:='Prosinecki ' ; mer1[9].posicaojog:='M' ;mer1[9].precojog:=546790 ; mer1[9].niveljog:=30;
   mer1[10].nomejog:='Chris Woods'; mer1[10].posicaojog:='G';mer1[10].precojog:=458900; mer1[10].niveljog:=30;
   mer1[11].nomejog:='F. Baresi  '; mer1[11].posicaojog:='D';mer1[11].precojog:=957000; mer1[11].niveljog:=39;
   mer1[12].nomejog:='Higuita    '; mer1[12].posicaojog:='G';mer1[12].precojog:=600000; mer1[12].niveljog:=32;
   mer1[13].nomejog:='C. Palmer  '; mer1[13].posicaojog:='D';mer1[13].precojog:=432000; mer1[13].niveljog:=28;
   mer1[14].nomejog:='Signori    '; mer1[14].posicaojog:='A';mer1[14].precojog:=1000000; mer1[14].niveljog:=37;
   mer1[15].nomejog:='Solazabal  '; mer1[15].posicaojog:='M';mer1[15].precojog:=234000; mer1[15].niveljog:=27;
   mer1[16].nomejog:='Felismino  '; mer1[16].posicaojog:='A';mer1[16].precojog:=45000 ; mer1[16].niveljog:=15;

   mer2[1].nomejog:='R. Rocha    '; mer2[1].posicaojog:='D' ;mer2[1].precojog:=500237  ; mer2[1].niveljog:=34;
   mer2[2].nomejog:='R. Gullit   '; mer2[2].posicaojog:='A' ;mer2[2].precojog:=1234000  ; mer2[2].niveljog:=40;
   mer2[3].nomejog:='Tanta       '; mer2[3].posicaojog:='D' ;mer2[3].precojog:=54000    ; mer2[3].niveljog:=23;
   mer2[4].nomejog:='Ricardo     '; mer2[4].posicaojog:='D' ;mer2[4].precojog:=1200000  ; mer2[4].niveljog:=37;
   mer2[5].nomejog:='Venancio    '; mer2[5].posicaojog:='D' ;mer2[5].precojog:=548900   ; mer2[5].niveljog:=26;
   mer2[6].nomejog:='R. Soza     '; mer2[6].posicaojog:='A' ;mer2[6].precojog:=984000  ; mer2[6].niveljog:=36;
   mer2[7].nomejog:='M. Sammer   '; mer2[7].posicaojog:='M' ;mer2[7].precojog:=479000  ; mer2[7].niveljog:=34;
   mer2[8].nomejog:='Brassard    '; mer2[8].posicaojog:='G' ;mer2[8].precojog:=320000   ; mer2[8].niveljog:=26;
   mer2[9].nomejog:='Prosinecki  '; mer2[9].posicaojog:='M' ;mer2[9].precojog:=537000  ; mer2[9].niveljog:=32;
   mer2[10].nomejog:='Taffarel   '; mer2[10].posicaojog:='G';mer2[10].precojog:=600000 ; mer2[10].niveljog:=30;
   mer2[11].nomejog:='F. Baresi  '; mer2[11].posicaojog:='D';mer2[11].precojog:=956000 ; mer2[11].niveljog:=35;
   mer2[12].nomejog:='Milu       '; mer2[12].posicaojog:='D';mer2[12].precojog:=9999    ; mer2[12].niveljog:=5;
   mer2[13].nomejog:='K. Riedle  '; mer2[13].posicaojog:='D';mer2[13].precojog:=977000 ; mer2[13].niveljog:=35;
   mer2[14].nomejog:='Jan Kocian '; mer2[14].posicaojog:='D';mer2[14].precojog:=345000 ; mer2[14].niveljog:=29;
   mer2[15].nomejog:='Rui Bento  '; mer2[15].posicaojog:='D';mer2[15].precojog:=250000  ; mer2[15].niveljog:=25;
   mer2[16].nomejog:='P. Maldini '; mer2[16].posicaojog:='D';mer2[16].precojog:=980000 ; mer2[16].niveljog:=35;

   mer3[1].nomejog:='Kiriakov    '; mer3[1].posicaojog:='A' ;mer3[1].precojog:=340000   ; mer3[1].niveljog:=25;
   mer3[2].nomejog:='Weah        '; mer3[2].posicaojog:='A' ;mer3[2].precojog:=700000  ; mer3[2].niveljog:=33;
   mer3[3].nomejog:='F. Rijkaard '; mer3[3].posicaojog:='D' ;mer3[3].precojog:=1500000  ; mer3[3].niveljog:=39;
   mer3[4].nomejog:='Ricardo     '; mer3[4].posicaojog:='D' ;mer3[4].precojog:=1200000 ; mer3[4].niveljog:=36;
   mer3[5].nomejog:='Van Basten  '; mer3[5].posicaojog:='A' ;mer3[5].precojog:=1759569 ; mer3[5].niveljog:=42;
   mer3[6].nomejog:='R. Soza     '; mer3[6].posicaojog:='A' ;mer3[6].precojog:=1000000  ; mer3[6].niveljog:=34;
   mer3[7].nomejog:='G. Lineker  '; mer3[7].posicaojog:='A' ;mer3[7].precojog:=1100000  ; mer3[7].niveljog:=35;
   mer3[8].nomejog:='Mancini     '; mer3[8].posicaojog:='A' ;mer3[8].precojog:=1345000 ; mer3[8].niveljog:=37;
   mer3[9].nomejog:='Prosinecki  '; mer3[9].posicaojog:='M' ;mer3[9].precojog:=678999  ; mer3[9].niveljog:=32;
   mer3[10].nomejog:='Preud Home '; mer3[10].posicaojog:='G';mer3[10].precojog:=1023400 ; mer3[10].niveljog:=37;
   mer3[11].nomejog:='M. De Gryse'; mer3[11].posicaojog:='A';mer3[11].precojog:=500000 ; mer3[11].niveljog:=33;
   mer3[12].nomejog:='Barnab‚    '; mer3[12].posicaojog:='A';mer3[12].precojog:=8000     ; mer3[12].niveljog:=10;
   mer3[13].nomejog:='Mendoza    '; mer3[13].posicaojog:='M';mer3[13].precojog:=200400 ; mer3[13].niveljog:=24;
   mer3[14].nomejog:='Jan Kocian '; mer3[14].posicaojog:='D';mer3[14].precojog:=234500 ; mer3[14].niveljog:=23;
   mer3[15].nomejog:='Katanec    '; mer3[15].posicaojog:='M';mer3[15].precojog:=420200  ; mer3[15].niveljog:=27;
   mer3[16].nomejog:='T. Hassler '; mer3[16].posicaojog:='M';mer3[16].precojog:=1000000 ; mer3[16].niveljog:=37;

   mer4[1].nomejog:='Valdo       '; mer4[1].posicaojog:='M' ;mer4[1].precojog:=950000   ; mer4[1].niveljog:=37;
   mer4[2].nomejog:='J. Barnes   '; mer4[2].posicaojog:='A' ;mer4[2].precojog:=850000  ; mer4[2].niveljog:=35;
   mer4[3].nomejog:='F. Rijkaard '; mer4[3].posicaojog:='D' ;mer4[3].precojog:=867900  ; mer4[3].niveljog:=36;
   mer4[4].nomejog:='R. Gullit   '; mer4[4].posicaojog:='A' ;mer4[4].precojog:=790000   ; mer4[4].niveljog:=35;
   mer4[5].nomejog:='Lentini     '; mer4[5].posicaojog:='M' ;mer4[5].precojog:=3789760 ; mer4[5].niveljog:=45;
   mer4[6].nomejog:='Chovanec    '; mer4[6].posicaojog:='M' ;mer4[6].precojog:=600000  ; mer4[6].niveljog:=32;
   mer4[7].nomejog:='Burruchaga  '; mer4[7].posicaojog:='M' ;mer4[7].precojog:=600000  ; mer4[7].niveljog:=30;
   mer4[8].nomejog:='Kuznetsov   '; mer4[8].posicaojog:='D' ;mer4[8].precojog:=578900  ; mer4[8].niveljog:=30;
   mer4[9].nomejog:='Bizarro     '; mer4[9].posicaojog:='G' ;mer4[9].precojog:=120000     ; mer4[9].niveljog:=25;
   mer4[10].nomejog:='Schmeichel  '; mer4[10].posicaojog:='G';mer4[10].precojog:=2034000 ; mer4[10].niveljog:=38;
   mer4[11].nomejog:='Darko Pancev'; mer4[11].posicaojog:='A';mer4[11].precojog:=999000 ; mer4[11].niveljog:=35;
   mer4[12].nomejog:='Gascoigne   '; mer4[12].posicaojog:='M';mer4[12].precojog:=1345000 ; mer4[12].niveljog:=36;
   mer4[13].nomejog:='Mendoza     '; mer4[13].posicaojog:='M';mer4[13].precojog:=245000 ; mer4[13].niveljog:=25;
   mer4[14].nomejog:='Des Walker  '; mer4[14].posicaojog:='D';mer4[14].precojog:=659000; mer4[14].niveljog:=33;
   mer4[15].nomejog:='Venceslau   '; mer4[15].posicaojog:='M';mer4[15].precojog:=123000  ; mer4[15].niveljog:=14;
   mer4[16].nomejog:='G. Lineker  '; mer4[16].posicaojog:='A';mer4[16].precojog:=500000 ; mer4[16].niveljog:=35;

   mer5[1].nomejog:='F. Mendes    '; mer5[1].posicaojog:='D' ;mer5[1].precojog:=700000   ; mer5[1].niveljog:=26;
   mer5[2].nomejog:='M. Bruno     '; mer5[2].posicaojog:='A' ;mer5[2].precojog:=590000  ; mer5[2].niveljog:=25;
   mer5[3].nomejog:='Angus Young  '; mer5[3].posicaojog:='A' ;mer5[3].precojog:=598000  ; mer5[3].niveljog:=25;
   mer5[4].nomejog:='Alfredo S.   '; mer5[4].posicaojog:='A' ;mer5[4].precojog:=1756749   ; mer5[4].niveljog:=25;
   mer5[5].nomejog:='Tarqu¡nio    '; mer5[5].posicaojog:='M' ;mer5[5].precojog:=256700 ; mer5[5].niveljog:=3;
   mer5[6].nomejog:='Papin        '; mer5[6].posicaojog:='A' ;mer5[6].precojog:=2100050  ; mer5[6].niveljog:=42;
   mer5[7].nomejog:='Francis Black'; mer5[7].posicaojog:='M' ;mer5[7].precojog:=580000  ; mer5[7].niveljog:=25;
   mer5[8].nomejog:='B. Dickinson '; mer5[8].posicaojog:='D' ;mer5[8].precojog:=600000  ; mer5[8].niveljog:=25;
   mer5[9].nomejog:='Barnab‚      '; mer5[9].posicaojog:='A' ;mer5[9].precojog:=978000   ; mer5[9].niveljog:=12;
   mer5[10].nomejog:='M. Vasquez   '; mer5[10].posicaojog:='M';mer5[10].precojog:=999000 ; mer5[10].niveljog:=35;
   mer5[11].nomejog:='Jonas Thern  '; mer5[11].posicaojog:='M';mer5[11].precojog:=1256700 ; mer5[11].niveljog:=35;
   mer5[12].nomejog:='Herm¡nio     '; mer5[12].posicaojog:='G';mer5[12].precojog:=5000 ; mer5[12].niveljog:=11;
   mer5[13].nomejog:='Miguel R.    '; mer5[13].posicaojog:='A';mer5[13].precojog:=1756749 ; mer5[13].niveljog:=25;
   mer5[14].nomejog:='Nicolau      '; mer5[14].posicaojog:='G';mer5[14].precojog:=450000 ; mer5[14].niveljog:=19;
   mer5[15].nomejog:='Venceslau    '; mer5[15].posicaojog:='M';mer5[15].precojog:=911200  ; mer5[15].niveljog:=13;
   mer5[16].nomejog:='Armindo      '; mer5[16].posicaojog:='D';mer5[16].precojog:=427000 ; mer5[16].niveljog:=14;

   entry;
   esp:=readkey;
   taclev:=0;
   randomize;
   { Introdu‡„o do nome do jogador }
   ecran;
   win(25,9,55,15,true,lightgray,black,blue,yellow,'Nome');
   ntbenfica:='';
   jogadortec:=' ';
   while jogadortec<>#13 do begin
      textcolor(yellow);
      textcolor(yellow);
      textbackground(lightgray);
      l:=length(ntbenfica);
      if l=0 then begin
         gotoxy(28,11);write('Introduza nome do jogador ');
      end;
      jogadortec:=readkey;
      if (jogadortec=#08) or (z=11) then
         begin
           z:=z-1;
           delete(ntbenfica,l,1);
           gotoxy(35,13);write(ntbenfica,'          ');
           textcolor(lightgray);
         end
        else
           begin
           z:=z+1;
           ntbenfica:=ntbenfica+jogadortec;
           gotoxy(35,13);write(ntbenfica);
           textcolor(lightgray);
        end;
   end;

prin:{ Men£ principal }
  Randomize;
  nbenfica:='SL Benfica';
  benfica[1]:='Silvino';
  benfica[2]:='Veloso';
  benfica[3]:='Helder';
  benfica[4]:='Mozer';
  benfica[5]:='Schwartz';
  benfica[6]:='P. Sousa';
  benfica[7]:='V. Paneira';
  benfica[8]:='Isa¡as';
  benfica[9]:='Iuran';
  benfica[10]:='Futre';
  benfica[11]:='Rui Costa';
  benfica[12]:='Neno';
  benfica[13]:='P. Madeira';
  benfica[14]:='Kulkov';
  benfica[15]:='Pacheco';
  benfica[16]:='Rui Aguas';

  posben[1]:='G';
  posben[2]:='D';
  posben[3]:='D';
  posben[4]:='D';
  posben[5]:='D';
  posben[6]:='M';
  posben[7]:='M';
  posben[8]:='M';
  posben[9]:='A';
  posben[10]:='A';
  posben[11]:='M';
  posben[12]:='G';
  posben[13]:='D';
  posben[14]:='M';
  posben[15]:='M';
  posben[16]:='A';

  nivben[1]:=30;
  nivben[2]:=30;
  nivben[3]:=27;
  nivben[4]:=37;
  nivben[5]:=34;
  nivben[6]:=33;
  nivben[7]:=36;
  nivben[8]:=38;
  nivben[9]:=35;
  nivben[10]:=40;
  nivben[11]:=30;
  nivben[12]:=29;
  nivben[13]:=26;
  nivben[14]:=30;
  nivben[15]:=32;
  nivben[16]:=33;

  preben[1]:=400000;
  preben[2]:=400000;
  preben[3]:=250000;
  preben[4]:=800000;
  preben[5]:=450000;
  preben[6]:=451000;
  preben[7]:=452000;
  preben[8]:=780000;
  preben[9]:=450000;
  preben[10]:=950000;
  preben[11]:=450000;
  preben[12]:=275000;
  preben[13]:=250000;
  preben[14]:=280000;
  preben[15]:=450000;
  preben[16]:=451000;

  adver[1]:='Juventus';
  adver[2]:='Porto';
  adver[3]:='Arsenal';
  adver[4]:='Barcelona';
  adver[5]:='Sporting';
  adver[6]:='Caldas';
  cont:=6;
  rlevel:=0;
  level:=0;
  lota:=15000;
  dinfed:=0;
  dinpre:=0;
  dinoba:=0;
  dinven:=0;
  dincom:=0;
  dinrei:=0;
  dinheiro:=2000000;
  dinins:=20000;
  golmartot:=0;
  golsoftot:=0;
  jog:=1;
  elim:=eliminatorias;
  escolhemer;
  nivel_inst;
  ecran;
  botao(5,9,15,blue,white,yellow,black,'Jogar');
  botao(5,12,15,blue,white,yellow,black,'Copyright');
  botao(5,15,15,blue,white,yellow,black,'Sair');
  win(34,8,74,16,true,lightgray,black,blue,yellow,'Informa‡„o');
  textbackground(lightgray);
  gotoxy(38,10);write('Data : ');
  data(45,10);
  gotoxy(38,12);write('Hora : ');
  hora(44,12);
  gotoxy(38,14);write('Jogo : Por iniciar');
  menu(9,5,3,3,1,yellow,blue,lightgray);
  if opc[c2]=opcao[1] then
     begin
       goto jogo;
     end;
  if opc[c2]=opcao[2] then
     begin
       abt;
     end;
  if opc[c2]=opcao[3] then
     begin
       sai;
     end;
  goto prin;

jogo: { Men£ de jogo }
  dintv:=0;
  ecran;
  premi:=0;
  verilevel;
  nivtot;
  botao(5,7,15,blue,white,yellow,black,'Pr¢ximo Jogo');
  botao(5,9,15,blue,white,yellow,black,'Dinheiro');
  botao(5,11,15,blue,white,yellow,black,'Contratos');
  botao(5,13,15,blue,white,yellow,black,'Obras');
  botao(5,15,15,blue,white,yellow,black,'Plantel');
  botao(5,17,15,blue,white,yellow,black,'Acabar');
  win(34,6,74,18,true,lightgray,black,blue,yellow,'Informa‡„o');
  textbackground(lightgray);
  gotoxy(38,9);write('Pr¢ximo Jogo       : ',elim[jog]);
  gotoxy(38,11);write('Dinheiro           : ',dinheiro:10:0);
  gotoxy(38,13);write('Lota‡„o do Est dio : ',lota:7:0);
  gotoxy(38,15);write('N¡vel da Equipa    : ',rlevel);
  menu(7,5,2,6,2,yellow,blue,lightgray);
  if opc[c2]=opcao1[1] then
     begin
       oponente;
       goto pro;
     end;
  if opc[c2]=opcao1[2] then
     begin
       contas;
     end;
  if opc[c2]=opcao1[3] then
     begin
       contrato;
     end;
  if opc[c2]=opcao1[4] then
     begin
       obras;
     end;
  if opc[c2]=opcao1[5] then
     begin
       plantel(false);
     end;
  if opc[c2]=opcao1[6] then
     begin
       goto prin;
     end;
  goto jogo;

pro: { Men£ da eliminat¢ria }
  nivtot;
  passa:='';
  dinpub:=0;
  bilhete:=0;
  marca[1].name:='';
  marca[2].name:='';
  marca[3].name:='';
  marca[4].name:='';
  marca[5].name:='';
  marca[6].name:='';
  marca[7].name:='';
  marca[1].tempo:=0;
  marca[2].tempo:=0;
  marca[3].tempo:=0;
  marca[4].tempo:=0;
  marca[5].tempo:=0;
  marca[6].tempo:=0;
  marca[7].tempo:=0;
  marcadv[1].name:='';
  marcadv[2].name:='';
  marcadv[3].name:='';
  marcadv[4].name:='';
  marcadv[5].name:='';
  marcadv[6].name:='';
  marcadv[7].name:='';
  marcadv[1].tempo:=0;
  marcadv[2].tempo:=0;
  marcadv[3].tempo:=0;
  marcadv[4].tempo:=0;
  marcadv[5].tempo:=0;
  marcadv[6].tempo:=0;
  marcadv[7].tempo:=0;
  contsubs:=0;
  ecran;
  botao(5,8,15,blue,white,yellow,black,'Jogo');
  botao(5,10,15,blue,white,yellow,black,'Antevis„o');
  botao(5,12,15,blue,white,yellow,black,'Constitui‡„o');
  botao(5,14,15,blue,white,yellow,black,'Pr‚mios');
  botao(5,16,15,blue,white,yellow,black,'Transmiss„o');
  win(34,6,74,18,true,lightgray,black,blue,yellow,'Informa‡„o');
  textbackground(lightgray);
  gotoxy(38,8);write('Pr¢ximo Jogo       : ',elim[jog]);
  gotoxy(38,10);write('Advers rio         : ',adv);
  gotoxy(38,12);write('Dinheiro           : ',dinheiro:10:0);
  gotoxy(38,14);write('Lota‡„o do Est dio : ',lota:7:0);
  gotoxy(38,16);write('N¡vel da Equipa    : ',rlevel);
  menu(8,5,2,5,3,yellow,blue,lightgray);
  if opc[c2]=opcao2[1] then
     begin
       clock;
       final;
       if passa='Apurado' then
          begin
            jog:=jog+1;
            goto jogo;
          end
       else
          begin
            goto prin;
       end;
     end;
  if opc[c2]=opcao2[2] then
     begin
       ante;
       goto pro;
     end;
  if opc[c2]=opcao2[3] then
     begin
       cons;
       goto pro;
     end;
  if opc[c2]=opcao2[4] then
     begin
       premio;
       goto pro;
     end;
  if opc[c2]=opcao2[5] then
     begin
       tv;
       goto pro;
     end;
 goto jogo;
end.
