unit misc;

interface

 uses crt,graph;

 function lerbyte(pergunta: string;musica:boolean):byte;

 procedure shadowwin(x,y,largura,altura,cordefundo,cordetexto:integer);

 procedure closewin1(largura,altura,cordefundo:integer;musica:boolean);

 procedure closewin2(largura,altura,cordefundo:integer;musica:boolean);

 function maiusculas(entrada:string):string;

 procedure linhahoriz1(n:integer);   {------------------------------------}

 procedure linhahoriz2(n:integer);

 procedure linhavert1(n:integer);

 procedure linhavert2(n:integer);

 procedure linhavert3(n:integer);    {Procedimentos Para desenhar a tabela}

 procedure linhavert4(n:integer);

 procedure linhavert5(n:integer);

 procedure desenharsimb;

 procedure desenharnum;

 procedure desenhargrupos;

 procedure desenharlegenda;

 procedure desenhartitulo;  {final dos procedimentos para desenhar a tabela}


implementation


 function lerbyte;

  var
   temp: longint;
   bom: boolean;
   x,y:byte;

   begin
    repeat
     x:=wherex;
     y:=wherey;

     write(pergunta);

     {$I-}
      readln(temp);
     {$I+}

     bom:=(ioresult=0) and (temp>=0)
                 and (temp<=255);

     if not bom then
      begin
       if musica=true then begin
                            sound(150);
                            delay(100);
                            nosound;
                           end;
       gotoxy(x,y);
       clreol
      end

  until bom;
  lerbyte:=temp
 end;    {lerbyte}



 procedure shadowwin;

  var contador:byte;

     begin
      textcolor(black);
      window(1,1,80,25);
      for contador:=(x+2) to (x+largura+1) do begin
                                                gotoxy(contador,y+altura);
                                                write('Û');
                                              end;
      for contador:=(y+1) to (y+altura) do begin
                                               gotoxy(x+largura,contador);
                                               write('ÛÛ');
                                           end;
      textbackground(cordefundo);
      window(x,y,x+largura-1,y+altura-1);
      clrscr;
      textcolor(cordetexto);
      for contador:=3 to (largura-2) do begin
                                            gotoxy(contador,1);
                                            write('Í');
                                        end;
      for contador:=3 to (largura-2) do begin
                                            gotoxy(contador,altura);
                                            write('Í');
                                        end;
      for contador:=2 to (altura-1) do begin
                                           gotoxy(2,contador);
                                           write('º');
                                       end;
      for contador:=2 to (altura-1) do begin
                                           gotoxy(largura-1,contador);
                                           write('º');
                                       end;
      gotoxy(2,1);write('É');
      gotoxy(largura-1,1);write('»');
      gotoxy(2,altura);write('È');
      gotoxy(largura-1,altura);write('¼');

  end; {shadowwin}

 procedure closewin1;

 var x,y:integer;

   begin
     textcolor(cordefundo);
     for x:=1 to largura do
          begin
             for y:=1 to altura do
                begin
                  gotoxy(x,y);write('Û')
                end;
           if musica=true then begin
                               sound(x*15);
                               delay(6);
                               nosound;
                               end
                          else delay(7);

           end;

   end;   {closewin}

 procedure closewin2;

 var x,y:integer;

   begin
     textcolor(cordefundo);
     for x:=(largura-1) downto 1 do
          begin
             for y:=1 to altura do
                begin
                  gotoxy(x,y);write('Û')
                end;
           if musica=true then begin
                               sound(x*15);
                               delay(6);
                               nosound;
                               end
                          else delay(7);

           end;

   end;   {closewin}


 function maiusculas;

   var x:integer;
       saida:string;

   begin
      saida:='';
      for x:=1 to length(entrada) do
          begin
            saida:=saida+upcase(entrada[x]);
          end;
      maiusculas:=saida;
   end; {maiusculas}


 procedure linhahoriz1;
 begin
  line(4,(n+2)*35+12,635,(n+2)*35+12);
 end; {linhahoriz1}


 procedure linhahoriz2;
 begin
  line(110,257+n*35,600,257+n*35);
 end; {linhahoriz2}


 procedure linhavert1;
 begin
  line(n*35+73,117,n*35+73,257);
 end; {linhavert1}


 procedure linhavert2;
 begin
  line(n*35+213,117,n*35+213,222);
 end; {linhavert2}


 procedure linhavert3;
 begin
  line((n-1)*35+423,47,(n-1)*35+423,222);
 end; {linhavert3}


 procedure linhavert4;
 begin
  line(n*35+601,12,n*35+601,222);
 end; {linhavert4}


 procedure linhavert5;
 begin
  line(n*35+110,292,n*35+110,362);
 end; {linhavert5}


 procedure desenharsimb;

 var j:array[1..17] of string[2];
     n:byte;
     x:integer;
     k:string[3];

 begin
 settextjustify(righttext,toptext);
 settextstyle(6,0,1);
 setcolor(blue);
 outtextxy(36,21,'H');outtextxy(636,21,'He');
 outtextxy(36,56,'Li');outtextxy(71,56,'Be');outtextxy(36,91,'Na');
 outtextxy(71,91,'Mg');outtextxy(456,56,'B');outtextxy(491,56,'C');
 outtextxy(526,56,'N');outtextxy(561,56,'O');outtextxy(596,56,'F');
 outtextxy(635,56,'Ne');outtextxy(456,91,'Al');outtextxy(491,91,'Si');
 outtextxy(526,91,'P');outtextxy(561,91,'S');outtextxy(596,91,'Cl');
 outtextxy(635,91,'Ar');
 j[1]:='K';j[2]:='Ca';j[3]:='Sc';j[4]:='Ti';j[5]:='V';j[6]:='Cr';j[7]:='Mn';
 j[8]:='Fe';j[9]:='Co';j[10]:='Ni';j[11]:='Cu';j[12]:='Zn';j[13]:='Ga';
 j[14]:='Ge';j[15]:='As';j[16]:='Se';j[17]:='Br';
 for n:=1 to 17 do
  begin
   x:=35*n+2;
   outtextxy(x,126,j[n]);
  end; {ciclo for}
 outtextxy(635,126,'Kr');
 j[1]:='Rb';j[2]:='Sr';j[3]:='Y';j[4]:='Zr';j[5]:='Nb';j[6]:='Mo';j[7]:='Tc';
 j[8]:='Ru';j[9]:='Rh';j[10]:='Pd';j[11]:='Ag';j[12]:='Cd';j[13]:='In';
 j[14]:='Sn';j[15]:='Sb';j[16]:='Te';j[17]:='I';
 for n:=1 to 17 do
   begin
   x:=35*n+2;
   outtextxy(x,161,j[n]);
  end; {ciclo}
 outtextxy(635,161,'Xe');
 j[1]:='Cs';j[2]:='Ba';j[3]:='La';j[4]:='Hf';j[5]:='Ta';j[6]:='W';j[7]:='Re';
 j[8]:='Os';j[9]:='Ir';j[10]:='Pt';j[11]:='Au';j[12]:='Hg';j[13]:='Tl';
 j[14]:='Pb';j[15]:='Bi';j[16]:='Po';j[17]:='At';
 for n:=1 to 17 do
   begin
    x:=35*n+2;
    outtextxy(x,196,j[n]);
   end; {ciclo}
 outtextxy(635,196,'Rn');
 j[1]:='Fr';j[2]:='Ra';j[3]:='Ac';j[4]:='Rf';j[5]:='Ha';
 for n:=1 to 5 do
   begin
    x:=35*n+2;
    outtextxy(x,231,j[n]);
   end; {ciclo}
 k:='Unh';outtextxy(214,231,k);
 k:='Uns';outtextxy(249,231,k);
 k:='Uno';outtextxy(284,231,k);
 k:='Une';outtextxy(318,231,k);
 j[1]:='Ce';j[2]:='Pr';j[3]:='Nd';j[4]:='Pm';j[5]:='Sm';j[6]:='Eu';
 j[7]:='Gd';j[8]:='Tb';j[9]:='Dy';j[10]:='Ho';j[11]:='Er';j[12]:='Tm';
 j[13]:='Yb';j[14]:='Lu';
 for n:=1 to 14 do
   begin
    x:=35*n+109;
    outtextxy(x,301,j[n]);
   end;
 j[1]:='Th';j[2]:='Pa';j[3]:='U';j[4]:='Np';j[5]:='Pu';j[6]:='Am';
 j[7]:='Cm';j[8]:='Bk';j[9]:='Cf';j[10]:='Es';j[11]:='Fm';j[12]:='Md';
 j[13]:='No';j[14]:='Lr';
 for n:=1 to 14 do
   begin
    x:=35*n+109;
    outtextxy(x,336,j[n]);
   end;
 end; {final do procedimento para desenhar os simbolos}

 procedure desenharnum;

 var a:integer;

 begin
 settextjustify(lefttext,toptext);
 settextstyle(0,0,1);
 setcolor(green);{linha 1}
 outtextxy(6,16,'1');
 setcolor(lightmagenta);
 outtextxy(604,16,'2');
 setcolor(lightred);{linha 2}
 outtextxy(6,50,'3');
 outtextxy(41,50,'4');
 outtextxy(426,50,'5');
 outtextxy(461,50,'6');
 setcolor(green);
 outtextxy(496,50,'7');
 outtextxy(531,50,'8');
 outtextxy(566,50,'9');
 setcolor(lightmagenta);
 outtextxy(603,50,'10');
 setcolor(lightred);{linha 3}
 outtextxy(6,85,'11');
 outtextxy(41,85,'12');
 outtextxy(426,85,'13');
 outtextxy(461,85,'14');
 outtextxy(496,85,'15');
 outtextxy(531,85,'16');
 setcolor(green);
 outtextxy(566,85,'17');
 setcolor(lightmagenta);
 outtextxy(603,85,'18');
 setcolor(lightred);{linha 4}
 outtextxy(6,120,'19');
 outtextxy(41,120,'20');
 outtextxy(76,120,'21');
 outtextxy(111,120,'22');
 outtextxy(146,120,'23');
 outtextxy(181,120,'24');
 outtextxy(216,120,'25');
 outtextxy(251,120,'26');
 outtextxy(286,120,'27');
 outtextxy(321,120,'28');
 outtextxy(356,120,'29');
 outtextxy(391,120,'30');
 setcolor(darkgray);
 outtextxy(426,120,'31');
 setcolor(lightred);
 outtextxy(461,120,'32');
 outtextxy(496,120,'33');
 outtextxy(531,120,'34');
 setcolor(darkgray);
 outtextxy(566,120,'35');
 setcolor(lightmagenta);
 outtextxy(603,120,'36');
 setcolor(lightred);{linha 5}
 outtextxy(6,155,'37');
 outtextxy(41,155,'38');
 outtextxy(76,155,'39');
 outtextxy(111,155,'40');
 outtextxy(146,155,'41');
 outtextxy(181,155,'42');
 setcolor(lightgray);
 outtextxy(216,155,'43');
 setcolor(lightred);
 outtextxy(251,155,'44');
 outtextxy(286,155,'45');
 outtextxy(321,155,'46');
 outtextxy(356,155,'47');
 outtextxy(391,155,'48');
 outtextxy(426,155,'49');
 outtextxy(461,155,'50');
 outtextxy(496,155,'51');
 outtextxy(531,155,'52');
 outtextxy(566,155,'53');
 setcolor(lightmagenta);
 outtextxy(603,155,'54');
 setcolor(darkgray);{linha 6}
 outtextxy(6,190,'55');
 setcolor(lightred);
 outtextxy(41,190,'56');
 outtextxy(76,190,'57 *');
 outtextxy(111,190,'72');
 outtextxy(146,190,'73');
 outtextxy(181,190,'74');
 outtextxy(216,190,'75');
 outtextxy(251,190,'76');
 outtextxy(286,190,'77');
 outtextxy(321,190,'78');
 outtextxy(356,190,'79');
 setcolor(darkgray);
 outtextxy(391,190,'80');
 setcolor(lightred);
 outtextxy(426,190,'81');
 outtextxy(461,190,'82');
 outtextxy(496,190,'83');
 outtextxy(531,190,'84');
 outtextxy(566,190,'85');
 setcolor(lightmagenta);
 outtextxy(603,190,'86');
 setcolor(darkgray);{linha 7}
 outtextxy(6,225,'87');
 setcolor(lightred);
 outtextxy(41,225,'88');
 outtextxy(76,225,'89**');
 setcolor(lightgray);
 outtextxy(111,225,'104');
 outtextxy(146,225,'105');
 outtextxy(181,225,'106');
 outtextxy(216,225,'107');
 outtextxy(251,225,'108');
 outtextxy(286,225,'109');
 setcolor(lightred);{linha 8}
 outtextxy(7,295,'Lantan¡deos *58');
 outtextxy(147,295,'59');
 outtextxy(182,295,'60');
 setcolor(lightgray);
 outtextxy(217,295,'61');
 setcolor(lightred);
 outtextxy(252,295,'62');
 outtextxy(287,295,'63');
 outtextxy(322,295,'64');
 outtextxy(357,295,'65');
 outtextxy(392,295,'66');
 outtextxy(427,295,'67');
 outtextxy(462,295,'68');
 outtextxy(497,295,'69');
 outtextxy(532,295,'70');
 outtextxy(567,295,'71');
 outtextxy(7,330,'Actin¡deos **90');{linha 9}
 outtextxy(147,330,'91');
 outtextxy(182,330,'92');
 setcolor(lightgray);
 outtextxy(217,330,'93');
 outtextxy(252,330,'94');
 outtextxy(287,330,'95');
 outtextxy(322,330,'96');
 outtextxy(357,330,'97');
 outtextxy(392,330,'98');
 outtextxy(427,330,'99');
 outtextxy(462,330,'100');
 outtextxy(497,330,'101');
 outtextxy(532,330,'102');
 outtextxy(567,330,'103');
end;                   {desenharnum}

procedure desenhargrupos;
begin
 settextstyle(2,0,5);
 settextjustify(0,1);
 setcolor(lightred);
 outtextxy(16,3,'IA');
 outtextxy(48,38,'IIA');
 outtextxy(79,108,'IIIA');
 outtextxy(116,108,'IVA');
 outtextxy(153,108,'VA');
 outtextxy(186,108,'VIA');
 outtextxy(219,108,'VIIA');
 outtextxy(254,108,'----VIIIA----');
 outtextxy(364,108,'IB');
 outtextxy(398,108,'IIB');
 outtextxy(430,38,'IIIB');
 outtextxy(467,38,'IVB');
 outtextxy(504,38,'VB');
 outtextxy(536,38,'VIB');
 outtextxy(570,38,'VIIB');
 outtextxy(608,3,'VIII');
end;             {desenhargrupos}

procedure desenharlegenda; {desenharlegenda}
begin
 settextstyle(5,0,4);
 setcolor(lightred);
 outtextxy(13,400,'ÛÛ S¢lido');
 setcolor(darkgray);
 outtextxy(158,400,'ÛÛ L¡quido');
 setcolor(lightmagenta);
 outtextxy(328,400,'Û');
 setcolor(green);
 outtextxy(344,400,'Û G s');
 setcolor(lightgray);
 outtextxy(458,400,'ÛÛ Artificial');
 end;         {desenharlegenda}

procedure desenhartitulo;          {desenhartitulo}
begin
 settextstyle(8,0,4);
 settextjustify(1,1);
 setcolor(lightred);
 outtextxy(getmaxx div 2,450,'TABELA PERIODICA DOS ELEMENTOS');
end;                             {desenhartitulo}

end. {misc}