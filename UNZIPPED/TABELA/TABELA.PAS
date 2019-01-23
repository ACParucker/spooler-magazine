{TABELA PERIüDICA - Feito em Turbo Pascal 7, para a revista SPOOLER, por:

                          BRUNO MARQUES
                          Av. Dos Bons Amigos, nß 29, 5ß A
                          2735 CACêM}


{$M 32768,32768,65536}
program tabelaperiodica(input,output);

uses printer,dos,graph,crt,misc;

const nel=109;  {especifica o nß de elementos qu°micos}

var    x,y,z,back:byte;                        {x,y e z sÑo contadores}
       som:boolean;                            {som: ON ou OFF}
       opcao:char;                             {opcÑo escolhida}
       Desc:array [1..nel] of string[33];      {descoberta}
       Sim:array [1..nel] of string[3];        {simbolo}
       No:array [1..nel] of string[13];        {nome}
       NP:array [1..nel] of string[12];        {nome portuguàs}
       Artificial:array [1..nel] of boolean;   {artificial ? sim ou nÑo}
       FusK:array [1..nel] of string[6];       {ponto de fusao (kelvin)}
       EbK:array [1..nel] of string[6];        {ponto de ebuliáÑo (kelvin)}
       Cnf:array [1..nel,1..2] of string[17];  {configuraáÑo electr¢nica}
       MAr:array [1..nel] of string[9];        {massa at¢mica relativa mÇdia}
       Dns:array [1..nel] of string[6];        {densidade (a 300 Kelvin)}
       PIon:array [1..nel] of string[6];       {potencial de 1¶ ionizaáÑo (V)}
       RAt:array [1..nel] of string[4];        {raio at¢mico (Angstrom)}
       ElNeg:array [1..nel] of string[4];      {electronegatividade (Pauling)}
       periodo:array[1..nel] of byte;          {per°odo a que pertence}
       Grp:array [1..nel] of string[5];        {grupo a que pertence}
       es:array [1..nel] of string[12];        {estado f°sico Ö temp. ambiente}
       Aparn:array[1..nel] of string[14];      {Aparància: metal,nÑo-metal...}


          {--------------OPCOES DO MENU INICIAL---------------}

procedure desenhartabela;                         {OPCAO T DO MENU INICIAL}

var y,graphdriver,graphmode:integer;
    tecla:char;

begin      {desenhartabela}
detectgraph(graphdriver,graphmode);
initgraph(graphdriver,graphmode,'');
if graphresult<>grOk then
                        begin
                          write(grapherrormsg(graphresult));
                          halt;
                        end;

setbkcolor(white);                 {escolhe as cores da tabela}
setcolor(blue);
line(4,12,38,12);
line(601,12,635,12);
line(4,47,73,47);
line(424,47,635,47);
line(4,82,73,82);
line(424,82,635,82);
for y:=1 to 4 do linhahoriz1(y);
line(4,257,318,257);
for y:=1 to 3 do linhahoriz2(y);
line(4,12,4,257);
line(38,12,38,257);
line(73,47,73,257);
for y:=1 to 7 do linhavert1(y);
for y:=1 to 5 do linhavert2(y);
for y:=1 to 5 do linhavert3(y);
linhavert4(0);linhavert4(1);
for y:=0 to 14 do linhavert5(y);
desenharsimb;   {procedimento da unit MISC}
desenharnum;    {idem}
desenhargrupos;  {idem}
desenharlegenda;  {idem}
desenhartitulo;   {idem}
repeat
 tecla:=readkey;
until tecla<>' ';
closegraph;
end; {desenhartabela}


procedure abandonar;         {OPCAO A - ABANDONAR}
var x,y:byte;
begin
textcolor(yellow);
writeln;
write('Estou com a ');textcolor(white);write('SPOOLER');
textcolor(yellow);write(' e todos os seus estimados leitores!');
for x:=1 to 15 do
               begin
         write('                                                       ');
         if som=true then
         begin
         sound(x*40);delay(35);sound(x*80);delay(35);
         end
         else
         delay(80);
         end; {ciclo for}
textcolor(lightgreen);
write('                    ATê ë PRüXIMA !');
if som=true then sound(260);
delay(800);
if som=true then nosound;
window(1,1,80,25);
gotoxy(80,25);
textcolor(lightgray);
textbackground(black);
write('€');
gotoxy(1,24);
end;     {abandonar}


procedure consultar(b:byte);         {OPCAO C - CONSULTAR}
var x,y:byte;
    z,numero:integer;
    tecla:char;
    smb,sbm:string;

procedure imprimir(n:integer);  {sub-procedimento de 'consultar'}
var z:byte;
begin
{$I-}
writeln(lst,'');
if ioresult<>0 then begin
                      shadowwin(14,19,32,3,random(3)+1,lightcyan); {De MISC}
                      gotoxy(3,2);
                      write(' IMPRESSORA NéO PREPARADA! ');
                      if som=true then sound(100);
                      delay(1500);
                      if som=true then nosound;
                    end
                else
begin
write(lst,'ELEMENTO: ');write(lst,NP[n]);write(lst,' (');
write(lst,No[n]);writeln(lst,')');
write(lst,'SIMBOLO: ');writeln(lst,Sim[n]);
if artificial[n]=true then
writeln(lst,'- ESTE ELEMENTO E PRODUZIDO ARTIFICIALMENTE EM LABORATORIO -');
write(lst,'Nß ATOMICO: ');writeln(lst,n);
write(lst,'PONTO DE FUSAO (kelvin): ');writeln(lst,fusk[n]);
write(lst,'PONTO DE EBULIÄAO (kelvin): ');writeln(lst,EbK[n]);
write(lst,'MASSA ATOMICA (relativamente ao C12): ');writeln(lst,MAr[n]);
write(lst,'E UM ELEMENTO DO ');write(lst,periodo[n]);
writeln(lst,' ß PERIODO.');
if n<>1 then begin
             write(lst,'PERTENCE AO GRUPO ');
             write(lst,Grp[n]);
             writeln(lst,' DA T.P. .');
             end
        else begin
             writeln(lst,'NAO SE INTEGRA EM NENHUM GRUPO DA T.P.');
             writeln(lst,'DADAS AS SUAS PROPRIEDADES ESPECIAIS.');
             end;
write(lst,'ESTADO FISICO A TEMPERATURA AMBIENTE: ');writeln(lst,es[n]);
write(lst,'ESTE ELEMENTO POSSUI CARACTERISTICAS ');writeln(lst,aparn[n]);
write(lst,'PRIMEIRO POTENCIAL DE IONIZACAO: ');
write(lst,pion[n]);writeln(lst,' V');
write(lst,'RAIO ATOMICO (Angstrom): ');writeln(lst,RAt[n]);
write(lst,'DENSIDADE (A 300 Kelvin): ');write(lst,dns[n]);
if n in [1,2,7..10,17,18,36,54,86] then writeln(lst,' g/l')
                                   else writeln(lst,' g/cm3');
write(lst,'ELECTRONEGATIVIDADE (Escala de Pauling): ');writeln(lst,elneg[n]);
write(lst,'DESCOBERTA: ');
write(lst,Desc[n]);
writeln(lst,'.');
write(lst,'                          ');writeln(lst,Cnf[n,1]);
write(lst,'CONFIGURACAO ELECTRONICA: ');writeln(lst,Cnf[n,2]);
end;
{$I+}
end; {imprimir}


procedure consultarporsimbolo(var nc:integer); {consultarporsimbolo}
                                   {nc=Ænumero correspondente ao simboloØ}
var x,y,z:integer;
begin
window(1,1,80,25);
x:=random(40);y:=random(19);
textcolor(black);
gotoxy(x+3,y+6);write('€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€');
for z:=y+2 to y+6 do begin
                      gotoxy(x+40,z);
                      write('€€');
                     end;
textbackground(b+1);
textcolor(yellow);
window(x+1,y+1,x+39,y+5);
clrscr;
write(' …ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª ');
write(' ∫                                   ∫ ');
write(' ∫');
textcolor(lightcyan);
write(' Qual o seu simbolo qu°mico ? ');
textcolor(yellow);write('     ∫ ');
write(' ∫                                   ∫ ');
write(' »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
textcolor(white);
window(x+34,y+3,x+37,y+3);
clrscr;
repeat

readln(smb);
sbm:=maiusculas(smb);           {funcao da unit MISC}
if som=true then begin
                  sound(150);
                  delay(100);
                  nosound;
                 end;

until (sbm='H') or (sbm='HE') or (sbm='LI')
or (sbm='BE') or (sbm='B') or (sbm='C')
or (sbm='N') or (sbm='O') or (sbm='F')
or (sbm='NE') or (sbm='NA') or (sbm='MG')
or (sbm='AL') or (sbm='SI') or (sbm='P')
or (sbm='S') or (sbm='CL') or (sbm='AR')
or (sbm='K') or (sbm='CA') or (sbm='SC')
or (sbm='TI') or (sbm='V') or (sbm='CR')
or (sbm='MN') or (sbm='FE') or (sbm='CO')
or (sbm='NI') or (sbm='CU') or (sbm='ZN')
or (sbm='GA') or (sbm='GE') or (sbm='AS')
or (sbm='SE') or (sbm='BR') or (sbm='KR')
or (sbm='RB') or (sbm='SR') or (sbm='Y')
or (sbm='ZR') or (sbm='NB') or (sbm='MO')
or (sbm='TC') or (sbm='RU') or (sbm='RH')
or (sbm='PD') or (sbm='AG') or (sbm='CD')
or (sbm='IN') or (sbm='SN') or (sbm='SB')
or (sbm='TE') or (sbm='I') or (sbm='XE')
or (sbm='CS') or (sbm='BA') or (sbm='LA')
or (sbm='CE') or (sbm='PR') or (sbm='ND')
or (sbm='PM') or (sbm='SM') or (sbm='EU')
or (sbm='GD') or (sbm='TB') or (sbm='DY')
or (sbm='HO') or (sbm='ER') or (sbm='TM')
or (sbm='YB') or (sbm='LU') or (sbm='HF')
or (sbm='TA') or (sbm='W') or (sbm='RE')
or (sbm='OS') or (sbm='IR') or (sbm='PT')
or (sbm='AU') or (sbm='HG') or (sbm='TL')
or (sbm='PB') or (sbm='BI') or (sbm='PO')
or (sbm='AT') or (sbm='RN') or (sbm='FR')
or (sbm='RA') or (sbm='AC') or (sbm='TH')
or (sbm='PA') or (sbm='U') or (sbm='NP')
or (sbm='PU') or (sbm='AM') or (sbm='CM')
or (sbm='BK') or (sbm='CF') or (sbm='ES')
or (sbm='FM') or (sbm='MD') or (sbm='NO')
or (sbm='LR') or (sbm='RF') or (sbm='HA')
or (sbm='UNH') or (sbm='UNS') or (sbm='UNO')
or (sbm='UNE') or (sbm='');

                if sbm='H' then nc:=1;
                if sbm='HE' then nc:=2;
                if sbm='LI' then nc:=3;
                if sbm='BE' then nc:=4;
                if sbm='B' then nc:=5;
                if sbm='C' then nc:=6;
                if sbm='N' then nc:=7;
                if sbm='O' then nc:=8;
                if sbm='F' then nc:=9;
                if sbm='NE' then nc:=10;
                if sbm='NA' then nc:=11;
                if sbm='MG' then nc:=12;
                if sbm='AL' then nc:=13;
                if sbm='SI' then nc:=14;
                if sbm='P' then nc:=15;
                if sbm='S' then nc:=16;
                if sbm='CL' then nc:=17;
                if sbm='AR' then nc:=18;
                if sbm='K' then nc:=19;
                if sbm='CA' then nc:=20;
                if sbm='SC' then nc:=21;
                if sbm='TI' then nc:=22;
                if sbm='V' then nc:=23;
                if sbm='CR' then nc:=24;
                if sbm='MN' then nc:=25;
                if sbm='FE' then nc:=26;
                if sbm='CO' then nc:=27;
                if sbm='NI' then nc:=28;
                if sbm='CU' then nc:=29;
                if sbm='ZN' then nc:=30;
                if sbm='GA' then nc:=31;
                if sbm='GE' then nc:=32;
                if sbm='AS' then nc:=33;
                if sbm='SE' then nc:=34;
                if sbm='BR' then nc:=35;
                if sbm='KR' then nc:=36;
                if sbm='RB' then nc:=37;
                if sbm='SR' then nc:=38;
                if sbm='Y' then nc:=39;
                if sbm='ZR' then nc:=40;
                if sbm='NB' then nc:=41;
                if sbm='MO' then nc:=42;
                if sbm='TC' then nc:=43;
                if sbm='RU' then nc:=44;
                if sbm='RH' then nc:=45;
                if sbm='PD' then nc:=46;
                if sbm='AG' then nc:=47;
                if sbm='CD' then nc:=48;
                if sbm='IN' then nc:=49;
                if sbm='SN' then nc:=50;
                if sbm='SB' then nc:=51;
                if sbm='TE' then nc:=52;
                if sbm='I' then nc:=53;
                if sbm='XE' then nc:=54;
                if sbm='CS' then nc:=55;
                if sbm='BA' then nc:=56;
                if sbm='LA' then nc:=57;
                if sbm='CE' then nc:=58;
                if sbm='PR' then nc:=59;
                if sbm='ND' then nc:=60;
                if sbm='PM' then nc:=61;
                if sbm='SM' then nc:=62;
                if sbm='EU' then nc:=63;
                if sbm='GD' then nc:=64;
                if sbm='TB' then nc:=65;
                if sbm='DY' then nc:=66;
                if sbm='HO' then nc:=67;
                if sbm='ER' then nc:=68;
                if sbm='TM' then nc:=69;
                if sbm='YB' then nc:=70;
                if sbm='LU' then nc:=71;
                if sbm='HF' then nc:=72;
                if sbm='TA' then nc:=73;
                if sbm='W' then nc:=74;
                if sbm='RE' then nc:=75;
                if sbm='OS' then nc:=76;
                if sbm='IR' then nc:=77;
                if sbm='PT' then nc:=78;
                if sbm='AU' then nc:=79;
                if sbm='HG' then nc:=80;
                if sbm='TL' then nc:=81;
                if sbm='PB' then nc:=82;
                if sbm='BI' then nc:=83;
                if sbm='PO' then nc:=84;
                if sbm='AT' then nc:=85;
                if sbm='RN' then nc:=86;
                if sbm='FR' then nc:=87;
                if sbm='RA' then nc:=88;
                if sbm='AC' then nc:=89;
                if sbm='TH' then nc:=90;
                if sbm='PA' then nc:=91;
                if sbm='U' then nc:=92;
                if sbm='NP' then nc:=93;
                if sbm='PU' then nc:=94;
                if sbm='AM' then nc:=95;
                if sbm='CM' then nc:=96;
                if sbm='BK' then nc:=97;
                if sbm='CF' then nc:=98;
                if sbm='ES' then nc:=99;
                if sbm='FM' then nc:=100;
                if sbm='MD' then nc:=101;
                if sbm='NO' then nc:=102;
                if sbm='LR' then nc:=103;
                if sbm='RF' then nc:=104;
                if sbm='HA' then nc:=105;
                if sbm='UNH' then nc:=106;
                if sbm='UNS' then nc:=107;
                if sbm='UNO' then nc:=108;
                if sbm='UNE' then nc:=109;
                if sbm='' then nc:=0;         {---FINAL DA PARTE EM QUE SE
                                                VERIFICA SE A CADEIA DE CA-
                                                RACTERES INTRODUZIDA CORRES-
                                                PONDE A UM SIMBOLO QUIMICO---}

end; {consultarporsimbolo}


procedure consultarpornumero;      {consultarpornumero}
var z:integer;
begin
window(1,1,80,25);
x:=random(42);y:=random(19);
textcolor(black);
gotoxy(x+3,y+6);write('€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€');
for z:=y+2 to y+6 do begin
                      gotoxy(x+38,z);
                      write('€€');
                     end;
textbackground(b+1);
textcolor(yellow);
window(x+1,y+1,x+37,y+5);
clrscr;
write(' …ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª ');
write(' ∫                                 ∫ ');
write(' ∫');
textcolor(lightcyan);
write(' Qual o seu n£mero at¢mico ?');
textcolor(yellow);write('     ∫ ');
write(' ∫                                 ∫ ');
write(' »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº'); {JANELA 1}
textcolor(white);
window(x+32,y+3,x+35,y+3);
clrscr;
repeat

numero:=lerbyte('',som);   {procedimento inclu°do na UNIT MISC}
if ((som=true) and (numero<>0)) then begin
                                      sound(150);
                                      delay(100);
                                      nosound;
                                     end;

until numero in [0..nel]; {----FINAL DA PARTE EM QUE SE PEDE PARA
                         INTRODUZIR O NUMERO ATOMICO DO ELEMENTO----}
end; {consultarpornumero}



begin    {-INICIO DO PROCEDIMENTO CONSULTAR-}

repeat
z:=random(6)+1;
until ((z<>b) and (z<>(b+1)));
x:=random(27);y:=random(21);
shadowwin(x+1,y+1,51,3,z,yellow);
textcolor(white);
gotoxy(4,2);write('Consulta por NñMERO (N) ou por SãMBOLO (S) ? ');
window(1,1,80,25);
window(x+1,y+1,x+1,y+1);
textbackground(z);
textcolor(z);
write(' ');
clreol;
window(1,1,80,25);
window(x+1,y+1,x+51,y+3);
repeat
tecla:=readkey;
until tecla in ['n','N','s','S'];

  case tecla of
              'n','N': consultarpornumero;
              's','S': consultarporsimbolo(numero);
             end; {case}


if numero<>0 then Begin
window(1,1,80,25);      {--APRESENTAR INFORMACAO SOBRE O ELEMENTO ESCOLHIDO-}
x:=random(18);y:=random(2);
textcolor(black);
gotoxy(x+3,y+23);
write('€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€');
for z:=y+2 to y+22 do begin
                      gotoxy(x+61,z);
                      write('€€');
                     end;
z:=random(5);
 case z of
          0: back:=blue;
          1: back:=green;
          2: back:=red;
          3: back:=magenta;
          4: back:=brown;

 end; {case}
textbackground(back);
window(x+1,y+1,x+60,y+22);
textcolor(white);
clrscr;
write(' …ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª ');

for z:=1 to 20 do
write(' ∫                                                        ∫ ');
write(' »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
textcolor(yellow);
gotoxy(5,2);
write('Elemento: ');
textcolor(white);
write(No[numero]);
textcolor(yellow);
write(' ;em portuguàs, ');
textcolor(white);
write(NP[numero]);
textcolor(yellow);
gotoxy(9,4);
if numero in [47,78] then write('A ') else write('O ');
write(NP[numero]);
write('(');write(Sim[numero]);write(')');
if numero<>1 then
                 begin
                   write(' pertence ao ');
                   textcolor(white);
                   write('grupo ');write(Grp[numero]);
                   textcolor(yellow);
                   writeln(' da T.P.,');
                 end
              else
                 begin
                 textcolor(white);
                 write(' nÑo se integra num grupo ');
                 textcolor(yellow);
                 write('da T.P.,');
                 end;

gotoxy(4,5);write('e situa-se no ');
textcolor(white);
write(periodo[numero]);write('ß per°odo. ');
textcolor(yellow);
write('Este elemento apresenta ca-');
gotoxy(4,6);write('racter°sticas ');
textcolor(white);
write(aparn[numero]);
textcolor(yellow);
write(', e o seu estado f°sico Ö');
gotoxy(4,7);write('temperatura ambiente Ç ');
textcolor(white);
write(es[numero]);
textcolor(yellow);
write('.');
gotoxy(10,9);
textcolor(lightcyan);
write('Outras informaáîes acerca ');
if numero in [47,78] then write ('da ') else write('do ');
write(NP[numero]);write(':');
gotoxy(4,19);
textcolor(yellow);
if artificial[numero]=true then
                write('Trata-se de um elemento preparado artificialmente.');
gotoxy(4,11);
write('Pontos de:');
textcolor(white);
write(' fusÑo ');
textcolor(yellow);
write('(Kelvin)  ');
textcolor(white);
write(FusK[numero]);
textcolor(lightcyan);
write(' ;');
textcolor(white);
write(' ebuliáÑo');
textcolor(yellow);
write('  ');
textcolor(white);
write(EbK[numero]);
textcolor(yellow);
gotoxy(4,12);
write('Potencial necess†rio Ö 1¶ ionizaáÑo (Volt)  ');
textcolor(white);
write(PIon[numero]);
textcolor(yellow);
gotoxy(4,13);
write('Massa at¢mica (relativamente ao Carbono 12)  ');
textcolor(white);
write(MAr[numero]);
gotoxy(4,14);
textcolor(yellow);
write('Electronegatividade (Na escala de Pauling)  ');
textcolor(white);
write(ElNeg[numero]);
gotoxy(4,15);
textcolor(yellow);
write('Raio at¢mico (Angstrom)  ');
textcolor(white);
write(RAt[numero]);
gotoxy(34,16);
write(Cnf[numero,1]);
gotoxy(34,17);
write(Cnf[numero,2]);
textcolor(yellow);
gotoxy(4,17);
write('ConfiguraáÑo electr¢nica: ');
gotoxy(4,16);
write('Densidade a 300 K  ');
textcolor(white);
write(dns[numero]);
if numero in [1,2,7..10,17,18,36,54,86] then write(' g/l')
                                        else write(' g/dm3');
textcolor(yellow);
gotoxy(4,18);
write('Ano de Descoberta  ');
textcolor(white);
write(Desc[numero],'.');
textcolor(white);
gotoxy(9,21);
write('[I]  IMPRIMIR     [ESC]  VOLTAR AO MENU');
window(x+1,y+1,x+1,y+1);
textbackground(back);
textcolor(back);
write(' ');
clreol;
window(1,1,80,25);
window(x+1,y+1,x+60,y+22);
repeat
tecla:=readkey;
until ((tecla=chr(27)) or (tecla in ['I','i']));
   case tecla of
           chr(27): begin
                    x:=random(2);
                    if x=0 then closewin1(60,22,back,som)
                           else closewin2(60,22,back,som);
                    end;

           'I','i': begin
                    if som=true then sound(450);
                    delay(250);
                    if som=true then nosound;
                    imprimir(numero);
                    end;
          end; {CASE}

   end;{if numero<>0 ...}

end;                          {FINAL DO PROCEDIMENTO C - CONSULTAR}


procedure shellpdos;         {OPCAO S - Shell P/ DOS}
begin
 textcolor(lightgray);textbackground(black);
 window(1,1,80,25);
 clrscr;
 Writeln('Escreva EXIT para voltar Ö TABELA PERIüDICA...');
 writeln;
 exec(getenv('COMSPEC'),'');
 end;                            {shell p/ DOS}


procedure glossario;     {OPCAO G - GLOSSÜRIO}
begin
 z:=random(5);
 case z of
          0: back:=1;    {escolher cor de fundo da janela aleat¢riamente}
          1: back:=2;
          2: back:=4;
          3: back:=5;
          4: back:=6
        end; {CASE}

 shadowwin(2,2,76,22,back,yellow);   {INCLUIDO NA UNIT MISC}
 gotoxy(16,2);
 textcolor(lightcyan);
 write('Significados de algumas grandezas referidas:');
 textcolor(white);
 gotoxy(4,4);
 write('ÆKelvinØ  ');
 textcolor(yellow);
 write('Escala de temperaturas que comeáa no ZERO ABSOLUTO');
 gotoxy(15,5);
 write('(-273.15 graus Celsius). Assim, 300.15 Kelvin = 27 Celsius.');
 gotoxy(4,7);
 textcolor(white);
 write('ÆGrupoØ  ');
 textcolor(yellow);
 write('Linha vertical da Tabela Peri¢dica que engloba um conjunto');
 gotoxy(14,8);
 write('de elementos com caracter°sticas similares (ex: Grupo IA).');
 textcolor(white);
 gotoxy(4,10);
 write('ÆPer°odoØ  ');
 textcolor(yellow);
 write('Linha horizontal da Tabela Peri¢dica (Exs: O Rub°dio 37');
 gotoxy(16,11);
 write('pertence ao 5ß per°odo; O Sam†rio 62 pertence ao 6ß).');
 gotoxy(4,13);
 textcolor(white);
 write('ÆAngstromØ  ');
 textcolor(yellow);
 write('Unidade equivalente a 1/10000000000 metro (dez zeros).');
 textcolor(white);
 gotoxy(4,15);
 write('ÆElectronegatividadeØ  ');
 textcolor(yellow);
 write('Mede a tendància para captar electrîes.');
 textcolor(white);
 gotoxy(4,17);
 write('Æ1ß potencial de ionizaáÑoØ  ');
 textcolor(yellow);
 write('Potencial elÇctrico que Ç necess†rio p/');
 gotoxy(34,18);
 write('arrancar um electrÑo ao †tomo.');
 textcolor(white);
 gotoxy(4,20);
 write('ÆMassa at¢mica relativaØ  ');
 textcolor(yellow);
 write('ê a razÑo entre a massa mÇdia de um †tomo');
 gotoxy(31,21);
 write('do elemento e 1/12 da massa do Carbono 12.');
 window(2,2,2,2);
textbackground(back);
textcolor(back);
write(' ');
clreol;

   repeat
     opcao:=readkey;
   until opcao<>' ';

end;  {gloss†rio}



{-----------INICIALIZAÄéO DOS QUADROS COM OS VALORES-----------}

procedure Inicializa1;

begin

som:=true;

No[1]:='Hydrogen';No[2]:='Helium';No[3]:='Lithium';No[4]:='Beryllium';
No[5]:='Boron';No[6]:='Carbon';No[7]:='Nitrogen';No[8]:='Oxygen';
No[9]:='Fluorine';No[10]:='Neon';No[11]:='Sodium';No[12]:='Magnesium';
No[13]:='Aluminium';No[14]:='Silicon';No[15]:='Phosphorus';
No[16]:='Sulfur';No[17]:='Chlorine';No[18]:='Argon';
No[19]:='Potassium';No[20]:='Calcium';No[21]:='Scandium';
No[22]:='Titanium';No[23]:='Vanadium';No[24]:='Chromuim';
No[25]:='Manganese';No[26]:='Iron';No[27]:='Cobalt';No[28]:='Nickel';
No[29]:='Copper';No[30]:='Zinc';No[31]:='Gallium';No[32]:='Germanium';
No[33]:='Arsenic';No[34]:='Selenium';No[35]:='Bromine';
No[36]:='Krypton';No[37]:='Rubidium';No[38]:='Strontium';
No[39]:='Yttrium';No[40]:='Zirconium';No[41]:='Niobium';
No[42]:='Molybdenum';No[43]:='Technetium';No[44]:='Ruthenium';
No[45]:='Rhodium';No[46]:='Palladium';No[47]:='Silver';
No[48]:='Cadmium';No[49]:='Indium';No[50]:='Tin';No[51]:='Antimony';
No[52]:='Tellurium';No[53]:='Iodine';No[54]:='Xenon';No[55]:='Cesium';
No[56]:='Barium';No[57]:='Lanthanum';No[58]:='Cerium';
No[59]:='Praseodymium';No[60]:='Neodymium';No[61]:='Promethium';
No[62]:='Samarium';No[63]:='Europium';No[64]:='Gadolinium';
No[65]:='Terbium';No[66]:='Dysprosium';No[67]:='Holmium';
No[68]:='Erbium';No[69]:='Thulium';No[70]:='Ytterbium';
No[71]:='Lutetium';No[72]:='Hafnium';No[73]:='Tantalum';
No[74]:='Tungsten';No[75]:='Rhenium';No[76]:='Osmium';
No[77]:='Iridium';No[78]:='Platinum';No[79]:='Gold';No[80]:='Mercury';
No[81]:='Thallium';No[82]:='Lead';No[83]:='Bismuth';
No[84]:='Polonium';No[85]:='Astatine';No[86]:='Radon';
No[87]:='Francium';No[88]:='Radium';No[89]:='Actinium';
No[90]:='Thorium';No[91]:='Protactinium';No[92]:='Uranium';
No[93]:='Neptunium';No[94]:='Plutonium';No[95]:='Americium';
No[96]:='Curium';No[97]:='Berkelium';No[98]:='Californium';
No[99]:='Einsteinium';No[100]:='Fermium';No[101]:='Fermium';
No[102]:='Nobelium';No[103]:='Lawrencium';No[104]:='Rutherfordium';
No[105]:='Hahnium';No[106]:='Unnilhexium';No[107]:='Unnilseptium';
No[108]:='Unniloctium';No[109]:='Unillenium';

NP[1]:='HidrogÇnio';NP[2]:='HÇlio';NP[3]:='L°tio';
NP[4]:='Ber°lio';NP[5]:='Boro';NP[6]:='Carbono';
NP[7]:='NitrogÇnio';NP[8]:='OxigÇnio';NP[9]:='Fl£or';
NP[10]:='NÇon';NP[11]:='S¢dio';NP[12]:='MagnÇsio';
NP[13]:='Alum°nio';NP[14]:='Sil°cio';NP[15]:='F¢sforo';
NP[16]:='Enxofre';NP[17]:='Cloro';NP[18]:='Ürgon';
NP[19]:='Pot†ssio';NP[20]:='C†lcio';NP[21]:='EscÉndio';
NP[22]:='TitÉnio';NP[23]:='Van†dio';NP[24]:='Cr¢mio';
NP[25]:='Manganàs';NP[26]:='Ferro';NP[27]:='Cobalto';
NP[28]:='N°quel';NP[29]:='Cobre';NP[30]:='Zinco';NP[31]:='G†lio';
NP[32]:='GermÉnio';NP[33]:='ArsÇnio';NP[34]:='SelÇnio';
NP[35]:='Bromo';NP[36]:='Cr°pton';NP[37]:='Rub°dio';
NP[38]:='Estrìncio';NP[39]:='ãtrio';NP[40]:='Zirc¢nio';
NP[41]:='Ni¢bio';NP[42]:='MolibdÇnio';NP[43]:='TecnÇcio';
NP[44]:='RutÇnio';NP[45]:='R¢dio';NP[46]:='Pal†dio';
NP[47]:='Prata';NP[48]:='C†dmio';NP[50]:='Estanho';
NP[51]:='Antim¢nio';NP[52]:='Tel£rio';NP[53]:='Iodo';
NP[54]:='XÇnon';NP[55]:='CÇsio';NP[56]:='B†rio';
NP[57]:='LantÉnio';NP[58]:='CÇrio';NP[59]:='Praseod°mio';
NP[60]:='Neod°mio';NP[61]:='PromÇcio';NP[62]:='Sam†rio';
NP[63]:='Eur¢pio';NP[64]:='Gadol°nio';NP[65]:='TÇrbio';
NP[66]:='Dispr¢sio';NP[67]:='H¢lmio';NP[68]:='êrbio';
NP[69]:='T£lio';NP[70]:='ItÇrbio';NP[71]:='LutÇcio';
NP[72]:='H†fnio';NP[73]:='TÉntalo';NP[74]:='TungstÇnio';
NP[75]:='RÇnio';NP[76]:='üsmio';NP[77]:='Ir°dio';
NP[78]:='Platina';NP[79]:='Ouro';NP[80]:='Merc£rio';
NP[81]:='T†lio';NP[82]:='Chumbo';NP[83]:='Bismuto';
NP[84]:='Pol¢nio';NP[85]:='Astato';NP[86]:='R†don';
NP[87]:='FrÉncio';NP[88]:='R†dio';NP[89]:='Act°nio';
NP[90]:='T¢rio';NP[91]:='Protact°nio';NP[92]:='UrÉnio';
NP[93]:='Nept£nio';NP[94]:='Plut¢nio';NP[95]:='Amer°cio';
NP[96]:='C£rio';NP[97]:='BerquÇlio';NP[98]:='Calif¢rnio';
NP[99]:='Einsteinio';NP[100]:='FÇrmio';NP[101]:='MendelÇvio';
NP[102]:='NobÇlio';NP[103]:='Lawràncio';NP[104]:='Rutherf¢rdio';
NP[105]:='H†hnio';NP[106]:='UnilhÇxio';NP[107]:='UnilsÇptio';
NP[108]:='Unil¢ctio';NP[109]:='UnilÇnio';
end;  {inicializa1}

procedure Inicializa2;
begin

for x:=1 to 92 do artificial[x]:=false;
for x:=93 to nel do artificial[x]:=true;
artificial[43]:=true;
artificial[61]:=true;

Sim[1]:='H';Sim[2]:='He';Sim[3]:='Li';Sim[4]:='Be';
Sim[5]:='B';Sim[6]:='C';Sim[7]:='N';Sim[8]:='O';
Sim[9]:='F';Sim[10]:='Ne';Sim[11]:='Na';Sim[12]:='Mg';
Sim[13]:='Al';Sim[14]:='Si';Sim[15]:='P';Sim[16]:='S';
Sim[17]:='Cl';Sim[18]:='Ar';Sim[19]:='K';Sim[20]:='Ca';
Sim[21]:='Sc';Sim[22]:='Ti';Sim[23]:='V';Sim[24]:='Cr';
Sim[25]:='Mn';Sim[26]:='Fe';Sim[27]:='Co';Sim[28]:='Ni';
Sim[29]:='Cu';Sim[30]:='Zn';Sim[31]:='Ga';Sim[32]:='Ge';
Sim[33]:='As';Sim[34]:='Se';Sim[35]:='Br';Sim[36]:='Kr';
Sim[37]:='Rb';Sim[38]:='Sr';Sim[39]:='Y';Sim[40]:='Zr';
Sim[41]:='Nb';Sim[42]:='Mo';Sim[43]:='Tc';Sim[44]:='Ru';
Sim[45]:='Rh';Sim[46]:='Pd';Sim[47]:='Ag';Sim[48]:='Cd';
Sim[49]:='In';Sim[50]:='Sn';Sim[51]:='Sb';Sim[52]:='Te';
Sim[53]:='I';Sim[54]:='Xe';Sim[55]:='Cs';Sim[56]:='Ba';
Sim[57]:='La';Sim[58]:='Ce';Sim[59]:='Pr';Sim[60]:='Nd';
Sim[61]:='Pm';Sim[62]:='Sm';Sim[63]:='Eu';Sim[64]:='Gd';
Sim[65]:='Tb';Sim[66]:='Dy';Sim[67]:='Ho';Sim[68]:='Er';
Sim[69]:='Tm';Sim[70]:='Yb';Sim[71]:='Lu';Sim[72]:='Hf';
Sim[73]:='Ta';Sim[74]:='W';Sim[75]:='Re';Sim[76]:='Os';
Sim[77]:='Ir';Sim[78]:='Pt';Sim[79]:='Au';Sim[80]:='Hg';
Sim[81]:='Tl';Sim[82]:='Pb';Sim[83]:='Bi';Sim[84]:='Po';
Sim[85]:='At';Sim[86]:='Rn';Sim[87]:='Fr';Sim[88]:='Ra';
Sim[89]:='Ac';Sim[90]:='Th';Sim[91]:='Pa';Sim[92]:='U';
Sim[93]:='Np';Sim[94]:='Pu';Sim[95]:='Am';Sim[96]:='Cm';
Sim[97]:='Bk';Sim[98]:='Cf';Sim[99]:='Es';Sim[100]:='Fm';
Sim[101]:='Md';Sim[102]:='No';Sim[103]:='Lr';Sim[104]:='Rf';
Sim[105]:='Ha';Sim[106]:='Unh';Sim[107]:='Uns';
Sim[108]:='Uno';Sim[109]:='Une';

FusK[1]:='14.025';FusK[2]:='0.95';FusK[3]:='453.7';FusK[4]:='1560';
FusK[5]:='2300';FusK[6]:='Ò4100';FusK[7]:='63.14';FusK[8]:='50.35';
FusK[9]:='53.48';FusK[10]:='24.553';FusK[11]:='371.0';FusK[12]:='922';
FusK[13]:='933.25';FusK[14]:='1685';FusK[15]:='317.30';FusK[16]:='388.36';
FusK[17]:='172.16';FusK[18]:='83.81';FusK[19]:='336.35';FusK[20]:='1112';
FusK[21]:='1812';FusK[22]:='1943';FusK[23]:='2175';FusK[24]:='2130';
FusK[25]:='1517';FusK[26]:='1809';FusK[27]:='1768';FusK[28]:='1726';
FusK[29]:='1357.6';FusK[30]:='692.73';FusK[31]:='302.90';FusK[32]:='1210.4';
FusK[33]:='???';FusK[34]:='494';FusK[35]:='265.90';FusK[36]:='115.78';
FusK[37]:='312.64';FusK[38]:='1041';FusK[39]:='1799';FusK[40]:='2125';
FusK[41]:='2740';FusK[42]:='2890';FusK[43]:='2473';FusK[44]:='2523';
FusK[45]:='2236';FusK[46]:='1825';FusK[47]:='1234';FusK[48]:='594.18';
FusK[49]:='429.76';FusK[50]:='505.06';FusK[51]:='904';FusK[52]:='722.65';
FusK[53]:='386.7';FusK[54]:='161.36';FusK[55]:='301.55';FusK[56]:='1002';
FusK[57]:='1193';FusK[58]:='1071';FusK[59]:='1204';FusK[60]:='1289';
FusK[61]:='1204';FusK[62]:='1345';FusK[63]:='1090';FusK[64]:='1585';
FusK[65]:='1630';FusK[66]:='1682';FusK[67]:='1743';FusK[68]:='1795';
FusK[69]:='1818';FusK[70]:='1097';FusK[71]:='1936';FusK[72]:='2500';
FusK[73]:='3287';FusK[74]:='3680';FusK[75]:='3453';FusK[76]:='3300';
FusK[77]:='2716';FusK[78]:='2045';FusK[79]:='1337.58';FusK[80]:='234.28';
FusK[81]:='577';FusK[82]:='600.6';FusK[83]:='544.52';FusK[84]:='527';
FusK[85]:='575';FusK[86]:='202';FusK[87]:='300';FusK[88]:='973';
FusK[89]:='1323';FusK[90]:='2028';FusK[91]:='???';FusK[92]:='1405';
FusK[93]:='910';FusK[94]:='913';FusK[95]:='1268';FusK[96]:='1340';
for x:=97 to 109 do FusK[x]:='???';

EbK[1]:='20.268';EbK[2]:='4.215';EbK[3]:='1615';EbK[4]:='2745';
EbK[5]:='4275';EbK[6]:='Ò4470';EbK[7]:='77.35';EbK[8]:='90.18';
EbK[9]:='84.95';EbK[10]:='27.096';EbK[11]:='1156';EbK[12]:='1363';
EbK[13]:='2793';EbK[14]:='3540';EbK[15]:='550';EbK[16]:='717.75';
EbK[17]:='239.1';EbK[18]:='87.30';EbK[19]:='1032';EbK[20]:='1757';
EbK[21]:='3104';EbK[22]:='3562';EbK[23]:='3682';EbK[24]:='2945';
EbK[25]:='2335';EbK[26]:='3135';EbK[27]:='3201';EbK[28]:='3187';
EbK[29]:='2836';EbK[30]:='1180';EbK[31]:='2478';EbK[32]:='3107';
EbK[33]:='???';EbK[34]:='958';EbK[35]:='332.25';EbK[36]:='119.80';
EbK[37]:='961';EbK[38]:='87.62';EbK[39]:='88.9059';EbK[40]:='4682';
EbK[41]:='5017';EbK[42]:='4912';EbK[43]:='4538';EbK[44]:='4423';
EbK[45]:='3970';EbK[46]:='3237';EbK[47]:='2436';EbK[48]:='1040';
EbK[49]:='2346';EbK[50]:='2876';EbK[51]:='1860';EbK[52]:='1261';
EbK[53]:='458.4';EbK[54]:='165.03';EbK[55]:='944';EbK[56]:='2171';
EbK[57]:='3730';EbK[58]:='3699';EbK[59]:='3785';EbK[60]:='3341';
EbK[61]:='3785';EbK[62]:='2064';EbK[63]:='1870';EbK[64]:='3539';
EbK[65]:='3496';EbK[66]:='2835';EbK[67]:='2968';EbK[68]:='3136';
EbK[69]:='2220';EbK[70]:='1467';EbK[71]:='3668';EbK[72]:='4876';
EbK[73]:='5731';EbK[74]:='5828';EbK[75]:='5869';EbK[76]:='5285';
EbK[77]:='4701';EbK[78]:='4100';EbK[79]:='3130';EbK[80]:='630';
EbK[81]:='1746';EbK[82]:='2023';EbK[83]:='1837';EbK[84]:='1235';
EbK[85]:='610';EbK[86]:='211';EbK[87]:='950';EbK[88]:='1809';
EbK[89]:='3473';EbK[90]:='5061';EbK[91]:='???';EbK[92]:='4407';
EbK[93]:='???';EbK[94]:='3503';EbK[95]:='2880';
for x:=96 to nel do EbK[x]:='???';
end;   {inicializa2}

procedure inicializa3;
begin
es[1]:='GASOSO';es[2]:='GASOSO';
for x:=3 to 6 do es[x]:='SüLIDO';
for x:=7 to 10 do es[x]:='GASOSO';
for x:=11 to 16 do es[x]:='SüLIDO';
es[17]:='GASOSO';es[18]:='GASOSO';
for x:=19 to 34 do es[x]:='SüLIDO';
es[31]:='LãQUIDO';es[35]:='LãQUIDO';es[36]:='GASOSO';
for x:=37 to 53 do es[x]:='SüLIDO';
es[54]:='GASOSO';
es[55]:='LãQUIDO';
for x:=56 to 85 do es[x]:='SüLIDO';
es[80]:='LãQUIDO';es[86]:='GASOSO';es[87]:='LãQUIDO';
for x:=88 to 96 do es[x]:='SüLIDO';
es[97]:='desconhecido';es[98]:='SüLIDO';
for x:=99 to nel do es[x]:='DESCONHECIDO';

for x:=1 to 2 do periodo[x]:=1;
for x:=3 to 10 do periodo[x]:=2;
for x:=11 to 18 do periodo[x]:=3;
for x:=19 to 36 do periodo[x]:=4;
for x:=37 to 54 do periodo[x]:=5;
for x:=55 to 86 do periodo[x]:=6;
for x:=87 to nel do periodo[x]:=7;

Aparn[1]:='NéO-METÜLICAS';Aparn[2]:='NéO-METÜLICAS';
Aparn[3]:='METÜLICAS';Aparn[4]:='METÜLICAS';
Aparn[5]:='SEMI-METÜLICAS';
for x:=6 to 10 do Aparn[x]:='NéO-METÜLICAS';
Aparn[11]:='METÜLICAS';Aparn[12]:='METÜLICAS';Aparn[13]:='METÜLICAS';
Aparn[14]:=Aparn[5];
for x:=15 to 18 do Aparn[x]:='NéO-METÜLICAS';
for x:=19 to 31 do Aparn[x]:='METÜLICAS';
Aparn[32]:='SEMI-METÜLICAS';Aparn[33]:=Aparn[32];
for x:=34 to 36 do Aparn[x]:='NéO-METÜLICAS';
for x:=37 to 50 do Aparn[x]:='METÜLICAS';
Aparn[51]:='SEMI-METÜLICAS';Aparn[52]:=Aparn[51];
Aparn[53]:='NéO-METÜLICAS';Aparn[54]:=Aparn[53];
for x:=55 to 83 do Aparn[x]:='METÜLICAS';
Aparn[84]:='SEMI-METÜLICAS';
Aparn[85]:='NéO-METÜLICAS';Aparn[86]:=Aparn[85];
for x:=87 to nel do Aparn[x]:='METÜLICAS';

MAr[1]:='1.0079';MAr[2]:='4.215';MAr[3]:='6.941';MAr[4]:='9.01218';
MAr[5]:='10.81';MAr[6]:='12.011';MAr[7]:='14.0067';MAr[8]:='15.9994';
MAr[9]:='18.998403';MAr[10]:='20.179';MAr[11]:='22.98977';MAr[12]:='24.305';
MAr[13]:='26.98154';MAr[14]:='28.0855';MAr[15]:='30.97376';MAr[16]:='32.06';
MAr[17]:='35.453';MAr[18]:='39.948';MAr[19]:='39.0983';MAr[20]:='40.08';
MAr[21]:='44.9559';MAr[22]:='47.90';MAr[23]:='50.9415';MAr[24]:='51.996';
MAr[25]:='54.9332';MAr[26]:='55.847';MAr[27]:='58.9332';MAr[28]:='58.70';
MAr[29]:='63.546';MAr[30]:='65.38';MAr[31]:='69.72';MAr[32]:='72.59';
MAr[33]:='74.9216';MAr[34]:='78.96';MAr[35]:='79.904';MAr[36]:='83.30';
MAr[37]:='85.4678';MAr[38]:='87.62';MAr[39]:='88.9059';MAr[40]:='91.22';
MAr[41]:='92.9064';MAr[42]:='95.94';MAr[43]:='Ò98';MAr[44]:='101.07';
MAr[45]:='102.9055';MAr[46]:='106.4';MAr[47]:='107.868';MAr[48]:='112.41';
MAr[49]:='114.82';MAr[50]:='118.69';MAr[51]:='121.75';MAr[52]:='127.60';
MAr[53]:='126.9045';MAr[54]:='131.30';MAr[55]:='132.9054';MAr[56]:='137.33';
MAr[57]:='138.9055';MAr[58]:='140.12';MAr[59]:='140.9077';MAr[60]:='144.24';
MAr[61]:='Ò145';MAr[62]:='150.4';MAr[63]:='151.96';MAr[64]:='157.25';
MAr[65]:='158.9254';MAr[66]:='162.50';MAr[67]:='164.9304';MAr[68]:='167.26';
MAr[69]:='168.9342';MAr[70]:='173.04';MAr[71]:='174.967';MAr[72]:='178.49';
MAr[73]:='180.9479';MAr[74]:='183.85';MAr[75]:='186.207';MAr[76]:='190.2';
MAr[77]:='192.22';MAr[78]:='195.09';MAr[79]:='196.9665';MAr[80]:='200.59';
MAr[81]:='204.37';MAr[82]:='207.2';MAr[83]:='208.9804';MAr[84]:='Ò209';
MAr[85]:='Ò210';MAr[86]:='Ò222';MAr[87]:='Ò223';MAr[88]:='226.0254';
MAr[89]:='227.0278';MAr[90]:='232.0381';MAr[91]:='231.0359';
MAr[92]:='238.029';MAr[93]:='237.0482';MAr[94]:='Ò239.1';MAr[95]:='Ò243.1';
MAr[96]:='Ò247.1';MAr[97]:='Ò247.1';MAr[98]:='Ò252.1';MAr[99]:='Ò252.1';
MAr[100]:='Ò257.1';MAr[101]:='Ò256.1';MAr[102]:='Ò259.1';MAr[103]:='Ò260.1';
MAr[104]:='Ò261';MAr[105]:='Ò262';MAr[106]:='Ò263';MAr[107]:='Ò262';
MAr[108]:='Ò265';MAr[109]:='Ò266';

RAt[1]:='0.79';RAt[2]:='0.49';RAt[3]:='2.05';RAt[4]:='1.40';
RAt[5]:='1.17';RAt[6]:='0.91';RAt[7]:='0.75';RAt[8]:='0.65';
RAt[9]:='0.57';RAt[10]:='0.51';RAt[11]:='2.23';RAt[12]:='1.72';
RAt[13]:='1.82';RAt[14]:='1.46';RAt[15]:='1.23';RAt[16]:='1.09';
RAt[17]:='0.97';RAt[18]:='0.88';RAt[19]:='2.77';RAt[20]:='2.23';
RAt[21]:='2.09';RAt[22]:='2.00';RAt[23]:='1.92';RAt[24]:='1.85';
RAt[25]:='1.79';RAt[26]:='1.72';RAt[27]:='1.67';RAt[28]:='1.62';
RAt[29]:='1.57';RAt[30]:='1.53';RAt[31]:='1.81';RAt[32]:='1.52';
RAt[33]:='1.33';RAt[34]:='1.22';RAt[35]:='1.12';RAt[36]:='1.03';
RAt[37]:='2.98';RAt[38]:='2.45';RAt[39]:='2.27';RAt[40]:='2.16';
RAt[41]:='2.08';RAt[42]:='2.01';RAt[43]:='1.95';RAt[44]:='1.89';
RAt[45]:='1.83';RAt[46]:='1.79';RAt[47]:='1.75';RAt[48]:='1.71';
RAt[49]:='2.00';RAt[50]:='1.72';RAt[51]:='1.53';RAt[52]:='1.42';
RAt[53]:='1.32';RAt[54]:='1.24';RAt[55]:='3.34';RAt[56]:='2.78';
RAt[57]:='2.74';RAt[58]:='2.70';RAt[59]:='2.67';RAt[60]:='2.64';
RAt[61]:='2.62';RAt[62]:='2.59';RAt[63]:='2.56';RAt[64]:='2.54';
RAt[65]:='2.51';RAt[66]:='2.49';RAt[67]:='2.47';RAt[68]:='2.45';
RAt[69]:='2.42';RAt[70]:='2.40';RAt[71]:='2.25';RAt[72]:='2.16';
RAt[73]:='2.09';RAt[74]:='2.02';RAt[75]:='1.97';RAt[76]:='1.87';
RAt[77]:='1.87';RAt[78]:='1.83';RAt[79]:='1.79';RAt[80]:='1.76';
RAt[81]:='2.08';RAt[82]:='1.81';RAt[83]:='1.63';RAt[84]:='1.53';
RAt[85]:='1.43';RAt[86]:='1.34';
for x:=87 to nel do RAt[x]:='???';

ElNeg[1]:='2.20';ElNeg[2]:='-';ElNeg[3]:='0.98';ElNeg[4]:='1.57';
ElNeg[5]:='2.04';ElNeg[6]:='2.55';ElNeg[7]:='3.04';ElNeg[8]:='3.44';
ElNeg[9]:='3.98';ElNeg[10]:='-';ElNeg[11]:='0.93';ElNeg[12]:='1.31';
ElNeg[13]:='1.61';ElNeg[14]:='1.90';ElNeg[15]:='2.19';ElNeg[16]:='2.58';
ElNeg[17]:='3.16';ElNeg[18]:='-';ElNeg[19]:='0.82';ElNeg[20]:='1.00';
ElNeg[21]:='1.36';ElNeg[22]:='1.54';ElNeg[23]:='1.63';ElNeg[24]:='1.66';
ElNeg[25]:='1.55';ElNeg[26]:='1.83';ElNeg[27]:='1.88';ElNeg[28]:='1.91';
ElNeg[29]:='1.90';ElNeg[30]:='1.65';ElNeg[31]:='1.81';ElNeg[32]:='2.01';
ElNeg[33]:='2.18';ElNeg[34]:='2.55';ElNeg[35]:='2.96';ElNeg[36]:='-';
ElNeg[37]:='0.82';ElNeg[38]:='0.95';ElNeg[39]:='1.22';ElNeg[40]:='1.33';
ElNeg[41]:='1.6';ElNeg[42]:='2.16';ElNeg[43]:='1.9';ElNeg[44]:='2.2';
ElNeg[45]:='2.28';ElNeg[46]:='2.20';ElNeg[47]:='1.93';ElNeg[48]:='1.93';
ElNeg[49]:='1.78';ElNeg[50]:='1.96';ElNeg[51]:='2.05';ElNeg[52]:='2.1';
ElNeg[53]:='2.66';ElNeg[54]:='-';ElNeg[55]:='0.79';ElNeg[56]:='0.89';
ElNeg[57]:='1.10';ElNeg[58]:='1.12';ElNeg[59]:='1.13';ElNeg[60]:='1.14';
ElNeg[61]:='1.13';ElNeg[62]:='1.17';ElNeg[63]:='1.2';ElNeg[64]:='1.20';
ElNeg[65]:='1.2';ElNeg[66]:='1.22';ElNeg[67]:='1.23';ElNeg[68]:='1.24';
ElNeg[69]:='1.25';ElNeg[70]:='1.1';ElNeg[71]:='1.27';ElNeg[72]:='1.3';
ElNeg[73]:='1.5';ElNeg[74]:='2.36';ElNeg[75]:='1.9';ElNeg[76]:='2.2';
ElNeg[77]:='2.20';ElNeg[78]:='2.28';ElNeg[79]:='2.54';ElNeg[80]:='2.00';
ElNeg[81]:='2.04';ElNeg[82]:='2.33';ElNeg[83]:='2.02';ElNeg[84]:='2.0';
ElNeg[85]:='2.2';ElNeg[86]:='-';ElNeg[87]:='0.7';ElNeg[88]:='0.9';
ElNeg[89]:='1.1';ElNeg[90]:='1.3';ElNeg[91]:='1.5';ElNeg[92]:='1.38';
ElNeg[93]:='1.36';ElNeg[94]:='1.28';
for x:=95 to 102 do ElNeg[x]:='1.3';
for x:=103 to nel do ElNeg[x]:='???';
end; {inicializa3}

procedure inicializa4;
begin
PIon[1]:='13.598';PIon[2]:='24.587';PIon[3]:='5.392';PIon[4]:='9.322';
PIon[5]:='8.298';PIon[6]:='11.260';PIon[7]:='14.534';PIon[8]:='13.618';
PIon[9]:='17.422';PIon[10]:='21.564';PIon[11]:='5.139';PIon[12]:='7.646';
PIon[13]:='5.986';PIon[14]:='8.151';PIon[15]:='10.486';
PIon[16]:='10.360';PIon[17]:='12.967';PIon[18]:='15.759';PIon[19]:='4.341';
PIon[20]:='6.113';PIon[21]:='6.54';PIon[22]:='6.82';PIon[23]:='6.74';
PIon[24]:='6.766';PIon[25]:='7.435';PIon[26]:='7.870';PIon[27]:='7.86';
PIon[28]:='7.635';PIon[29]:='7.726';PIon[30]:='9.394';PIon[31]:='5.999';
PIon[32]:='7.899';PIon[33]:='9.81';PIon[34]:='9.752';PIon[35]:='11.814';
PIon[36]:='13.999';PIon[37]:='4.177';PIon[38]:='5.695';PIon[39]:='6.38';
PIon[40]:='6.84';PIon[41]:='6.88';PIon[42]:='7.099';PIon[43]:='7.28';
PIon[44]:='7.37';PIon[45]:='7.46';PIon[46]:='8.74';PIon[47]:='7.576';
PIon[48]:='8.993';PIon[49]:='5.786';PIon[50]:='7.334';PIon[51]:='8.641';
PIon[52]:='9.009';PIon[53]:='10.451';PIon[54]:='12.130';PIon[55]:='3.894';
PIon[56]:='5.212';PIon[57]:='5.58';PIon[58]:='5.54';PIon[59]:='5.46';
PIon[60]:='5.53';PIon[61]:='5.554';PIon[62]:='5.64';PIon[63]:='5.67';
PIon[64]:='6.15';PIon[65]:='5.86';PIon[66]:='5.94';PIon[67]:='6.018';
PIon[68]:='6.101';PIon[69]:='6.184';PIon[70]:='6.254';PIon[71]:='5.43';
PIon[72]:='6.65';PIon[73]:='7.89';PIon[74]:='7.98';PIon[75]:='7.88';
PIon[76]:='8.7';PIon[77]:='9.1';PIon[78]:='9.0';PIon[79]:='9.225';
PIon[80]:='10.437';PIon[81]:='6.108';PIon[82]:='7.416';PIon[83]:='7.289';
PIon[84]:='8.42';PIon[85]:='???';PIon[86]:='10.748';PIon[87]:='???';
PIon[88]:='5.279';PIon[89]:='5.17';PIon[90]:='6.08';PIon[91]:='5.89';
PIon[92]:='6.05';PIon[93]:='6.19';PIon[94]:='6.06';PIon[95]:='5.993';
PIon[96]:='6.02';PIon[97]:='6.23';PIon[98]:='6.30';PIon[99]:='6.42';
PIon[100]:='6.50';PIon[101]:='6.58';PIon[102]:='6.65';
for x:=103 to nel do PIon[x]:='???';

Grp[1]:='N/tem';
Grp[2]:='VIII';
Grp[3]:='IA';
Grp[4]:='IIA';
Grp[5]:='IIIB';Grp[6]:='IVB';Grp[7]:='VB';Grp[8]:='VIB';
Grp[9]:='VIIB';Grp[10]:='VIII';Grp[11]:='IA';Grp[12]:='IIA';
Grp[13]:='IIIB';Grp[14]:='IVB';Grp[15]:='VB';Grp[16]:='VIB';
Grp[17]:='VIIB';Grp[18]:='VIII';Grp[19]:='IA';Grp[20]:='IIA';
Grp[21]:='IIIA';Grp[22]:='IVA';Grp[23]:='VA';Grp[24]:='VIA';
Grp[25]:='VIIA';Grp[26]:='VIIIA';Grp[27]:='VIIIA';Grp[28]:='VIIIA';
Grp[29]:='IB';Grp[30]:='IIB';Grp[31]:='IIIB';Grp[32]:='IVB';
Grp[33]:='VB';Grp[34]:='VIB';Grp[35]:='VIIB';Grp[36]:='VIII';
Grp[37]:='IA';Grp[38]:='IIA';Grp[39]:='IIIA';Grp[40]:='IVA';
Grp[41]:='VA';Grp[42]:='VIA';Grp[43]:='VIIA';Grp[44]:='VIIIA';
Grp[45]:='VIIIA';Grp[46]:='VIIIA';Grp[47]:='IB';Grp[48]:='IIB';
Grp[49]:='IIIB';Grp[50]:='IVB';Grp[51]:='VB';Grp[52]:='VIB';
Grp[53]:='VIIB';Grp[54]:='VIII';Grp[55]:='IA';Grp[56]:='IIA';
Grp[57]:='IIIA';

for x:=58 to 71 do Grp[x]:='IIIA';    {?}

Grp[72]:='IVA';Grp[73]:='VA';Grp[74]:='VIA';Grp[75]:='VIIA';
Grp[76]:='VIIIA';Grp[77]:='VIIIA';Grp[78]:='VIIIA';Grp[79]:='IB';
Grp[80]:='IIB';Grp[81]:='IIIB';Grp[82]:='IVB';Grp[83]:='VB';
Grp[84]:='VIB';Grp[85]:='VIIB';Grp[86]:='VIII';Grp[87]:='IA';
Grp[88]:='IIA';Grp[89]:='IIIA';

for x:=90 to 103 do Grp[x]:='IIIA';   {?}

Grp[104]:='IVA';Grp[105]:='VA';Grp[106]:='VIA';
Grp[107]:='VIIA';Grp[108]:='VIIIA';Grp[109]:='VIIIA';

end; {inicializa4}

procedure inicializa5;
begin
Cnf[1,1]:='  1';
Cnf[1,2]:='1s';
Cnf[2,1]:='  2';
Cnf[2,2]:='1s';
Cnf[3,1]:='  2  1';
Cnf[3,2]:='1s 2s';
Cnf[4,1]:='  2  2';
Cnf[4,2]:='1s 2s';
Cnf[5,1]:='  2  2 1';
Cnf[5,2]:='1s 2s p';
Cnf[6,1]:='  2  2 2';
Cnf[6,2]:='1s 2s p';
Cnf[7,1]:='  2  2 3';
Cnf[7,2]:='1s 2s p';
Cnf[8,1]:='  2  2 4';
Cnf[8,2]:='1s 2s p';
Cnf[9,1]:='  2  2 5';
Cnf[9,2]:='1s 2s p';
Cnf[10,1]:='  2  2 6';
Cnf[10,2]:='1s 2s p';
Cnf[11,1]:='      1';
Cnf[11,2]:='[Ne]3s';
Cnf[12,1]:='      2';
Cnf[12,2]:='[Ne]3s';
Cnf[13,1]:='      2 1';
Cnf[13,2]:='[Ne]3s p';
Cnf[14,1]:='      2 2';
Cnf[14,2]:='[Ne]3s p';
Cnf[15,1]:='      2 3';
Cnf[15,2]:='[Ne]3s p';
Cnf[16,1]:='      2 4';
Cnf[16,2]:='[Ne]3s p';
Cnf[17,1]:='      2 5';
Cnf[17,2]:='[Ne]3s p';
Cnf[18,1]:='      2 6';
Cnf[18,2]:='[Ne]3s p';
Cnf[19,1]:='      1';
Cnf[19,2]:='[Ar]4s';
Cnf[20,1]:='      2';
Cnf[20,2]:='[Ar]4s';
Cnf[21,1]:='      1  2';
Cnf[21,2]:='[Ar]3d 4s';
Cnf[22,1]:='      2  2';
Cnf[22,2]:='[Ar]3d 4s';
Cnf[23,1]:='      3  2';
Cnf[23,2]:='[Ar]3d 4s';
Cnf[24,1]:='      5  1';
Cnf[24,2]:='[Ar]3d 4s';
Cnf[25,1]:='      5  2';
Cnf[25,2]:='[Ar]3d 4s';
Cnf[26,1]:='      6  2';
Cnf[26,2]:='[Ar]3d 4s';
Cnf[27,1]:='      7  2';
Cnf[27,2]:='[Ar]3d 4s';
Cnf[28,1]:='      8  2';
Cnf[28,2]:='[Ar]3d 4s';
Cnf[29,1]:='      10  1';
Cnf[29,2]:='[Ar]3d  4s';
Cnf[30,1]:='      10  2';
Cnf[30,2]:='[Ar]3d  4s';
Cnf[31,1]:='      10  2 1';
Cnf[31,2]:='[Ar]3d  4s p';
Cnf[32,1]:='      10  2 2';
Cnf[32,2]:='[Ar]3d  4s p';
Cnf[33,1]:='      10  2 3';
Cnf[33,2]:='[Ar]3d  4s p';
Cnf[34,1]:='      10  2 4';
Cnf[34,2]:='[Ar]3d  4s p';
Cnf[35,1]:='      10  2 5';
Cnf[35,2]:='[Ar]3d  4s p';
Cnf[36,1]:='      10  2 6';
Cnf[36,2]:='[Ar]3d  4s p';
Cnf[37,1]:='      1';
Cnf[37,2]:='[Kr]5s';
Cnf[38,1]:='      2';
Cnf[38,2]:='[Kr]5s';
Cnf[39,1]:='      1  2';
Cnf[39,2]:='[Kr]4d 5s';
Cnf[40,1]:='      2  2';
Cnf[40,2]:='[Kr]4d 5s';
Cnf[41,1]:='      4  1';
Cnf[41,2]:='[Kr]4d 5s';
Cnf[42,1]:='      5  1';
Cnf[42,2]:='[Kr]4d 5s';
Cnf[43,1]:='      5  2';
Cnf[43,2]:='[Kr]4d 5s';
Cnf[44,1]:='      7  1';
Cnf[44,2]:='[Kr]4d 5s';
Cnf[45,1]:='      8  1';
Cnf[45,2]:='[Kr]4d 5s';
Cnf[46,1]:='      10';
Cnf[46,2]:='[Kr]4d';
Cnf[47,1]:='      10  1';
Cnf[47,2]:='[Kr]4d  5s';
Cnf[48,1]:='      10  2';
Cnf[48,2]:='[Kr]4d  5s';
Cnf[49,1]:='      10  2 1';
Cnf[49,2]:='[Kr]4d  5s p';
Cnf[50,1]:='      10  2 2';
Cnf[50,2]:='[Kr]4d  5s p';
Cnf[51,1]:='      10  2 3';
Cnf[51,2]:='[Kr]4d  5s p';
Cnf[52,1]:='      10  2 4';
Cnf[52,2]:='[Kr]4d  5s p';
Cnf[53,1]:='      10  2 5';
Cnf[53,2]:='[Kr]4d  5s p';
Cnf[54,1]:='      10  2 6';
Cnf[54,2]:='[Kr]4d  5s p';
Cnf[55,1]:='      1';
Cnf[55,2]:='[Xe]6s';
Cnf[56,1]:='      2';
Cnf[56,2]:='[Xe]6s';
Cnf[57,1]:='      1  2';
Cnf[57,2]:='[Xe]5d 6s';
Cnf[58,1]:='      1  1  2';
Cnf[58,2]:='[Xe]4f 5d 6s';
Cnf[59,1]:='      3  2';
Cnf[59,2]:='[Xe]4f 6s';
Cnf[60,1]:='      4  2';
Cnf[60,2]:='[Xe]4f 6s';
Cnf[61,1]:='      5  2';
Cnf[61,2]:='[Xe]4f 6s';
Cnf[62,1]:='      6  2';
Cnf[62,2]:='[Xe]4f 6s';
Cnf[63,1]:='      7  2';
Cnf[63,2]:='[Xe]4f 6s';
Cnf[64,1]:='      7  1  2';
Cnf[64,2]:='[Xe]4f 5d 6s';
Cnf[65,1]:='      9  2';
Cnf[65,2]:='[Xe]4f 6s';
Cnf[66,1]:='      10  2';
Cnf[66,2]:='[Xe]4f  6s';
Cnf[67,1]:='      11  2';
Cnf[67,2]:='[Xe]4f  6s';
Cnf[68,1]:='      12  2';
Cnf[68,2]:='[Xe]4f  6s';
Cnf[69,1]:='      13  2';
Cnf[69,2]:='[Xe]4f  6s';
Cnf[70,1]:='      14  2';
Cnf[70,2]:='[Xe]4f  6s';
Cnf[71,1]:='      14  1  2';
Cnf[71,2]:='[Xe]4f  5d 6s';
Cnf[72,1]:='      14  2  2';
Cnf[72,2]:='[Xe]4f  5d 6s';
Cnf[73,1]:='      14  3  2';
Cnf[73,2]:='[Xe]4f  5d 6s';
Cnf[74,1]:='      14  4  2';
Cnf[74,2]:='[Xe]4f  5d 6s';
Cnf[75,1]:='      14  5  2';
Cnf[75,2]:='[Xe]4f  5d 6s';
Cnf[76,1]:='      14  6  2';
Cnf[76,2]:='[Xe]4f  5d 6s';
Cnf[77,1]:='      14  7  2';
Cnf[77,2]:='[Xe]4f  5d 6s';
Cnf[78,1]:='      14  9  1';
Cnf[78,2]:='[Xe]4f  5d 6s';
Cnf[79,1]:='      14  10  1';
Cnf[79,2]:='[Xe]4f  5d  6s';
Cnf[80,1]:='      14  10  2';
Cnf[80,2]:='[Xe]4f  5d  6s';
Cnf[81,1]:='      14  10  2 1';
Cnf[81,2]:='[Xe]4f  5d  6s p';
Cnf[82,1]:='      14  10  2 2';
Cnf[82,2]:='[Xe]4f  5d  6s p';
Cnf[83,1]:='      14  10  2 3';
Cnf[83,2]:='[Xe]4f  5d  6s p';
Cnf[84,1]:='      14  10  2 4';
Cnf[84,2]:='[Xe]4f  5d  6s p';
Cnf[85,1]:='      14  10  2 5';
Cnf[85,2]:='[Xe]4f  5d  6s p';
Cnf[86,1]:='      14  10  2 6';
Cnf[86,2]:='[Xe]4f  5d  6s p';
Cnf[87,1]:='      1';
Cnf[87,2]:='[Rn]7s';
Cnf[88,1]:='      2';
Cnf[88,2]:='[Rn]7s';
Cnf[89,1]:='      1  2';
Cnf[89,2]:='[Rn]6d 7s';
Cnf[90,1]:='      2  2';
Cnf[90,2]:='[Rn]6d 7s';
Cnf[91,1]:='      2  1  2';
Cnf[91,2]:='[Rn]5f 6d 7s';
Cnf[92,1]:='      3  1  2';
Cnf[92,2]:='[Rn]5f 6d 7s';
Cnf[93,1]:='      4  1  2';
Cnf[93,2]:='[Rn]5f 6d 7s';
Cnf[94,1]:='      6  2';
Cnf[94,2]:='[Rn]5f 7s';
Cnf[95,1]:='      7  2';
Cnf[95,2]:='[Rn]5f 7s';
Cnf[96,1]:='      7  1  2';
Cnf[96,2]:='[Rn]5f 6d 7s';
Cnf[97,1]:='      9  2';
Cnf[97,2]:='[Rn]5f 7s';
Cnf[98,1]:='      10  2';
Cnf[98,2]:='[Rn]5f  7s';
Cnf[99,1]:='      11  2';
Cnf[99,2]:='[Rn]5f  7s';
Cnf[100,1]:='      12  2';
Cnf[100,2]:='[Rn]5f  7s';
Cnf[101,1]:='      13  2';
Cnf[101,2]:='[Rn]5f  7s';
Cnf[102,1]:='      14  2';
Cnf[102,2]:='[Rn]5f  7s';
Cnf[103,1]:='      14  1  2';
Cnf[103,2]:='[Rn]5f  6d 7s';
Cnf[104,1]:='      14  2  2';
Cnf[104,2]:='[Rn]5f  6d 7s';
Cnf[105,1]:='      14  3  2';
Cnf[105,2]:='[Rn]5f  6d 7s';
Cnf[106,1]:='      14  4  2';
Cnf[106,2]:='[Rn]5f  6d 7s';
Cnf[107,1]:='      14  5  2';
Cnf[107,2]:='[Rn]5f  6d 7s';
Cnf[108,1]:='      14  6  2';
Cnf[108,2]:='[Rn]5f  6d 7s';
Cnf[109,1]:='      14  7  2';
Cnf[109,2]:='[Rn]5f  6d 7s';
end; {inicializa5}

procedure inicializa6;
begin
dns[1]:='0.0899';dns[2]:='0.1787';dns[3]:='0.53';
dns[4]:='1.85';dns[5]:='2.34';dns[6]:='2.62';
dns[7]:='1.251';dns[8]:='1.429';dns[9]:='1.696';
dns[10]:='0.901';dns[11]:='0.97';dns[12]:='1.74';
dns[13]:='2.70';dns[14]:='2.33';dns[15]:='1.82';
dns[16]:='2.07';dns[17]:='3.17';dns[18]:='1.784';
dns[19]:='0.86';dns[20]:='1.55';dns[21]:='3.0';
dns[22]:='4.50';dns[23]:='5.8';dns[24]:='7.19';
dns[25]:='7.43';dns[26]:='7.86';dns[27]:='8.90';
dns[28]:='8.90';dns[29]:='8.96';dns[30]:='7.14';
dns[31]:='5.91';dns[32]:='5.32';dns[33]:='5.72';
dns[34]:='4.80';dns[35]:='3.12';dns[36]:='3.74';
dns[37]:='1.53';dns[38]:='2.6';dns[39]:='4.5';
dns[40]:='6.49';dns[41]:='8.55';dns[42]:='10.2';
dns[43]:='11.5';dns[44]:='12.2';dns[45]:='12.4';
dns[46]:='12.0';dns[47]:='10.5';dns[48]:='8.65';
dns[49]:='7.31';dns[50]:='7.30';dns[51]:='6.68';
dns[52]:='6.24';dns[53]:='4.92';dns[54]:='5.89';
dns[55]:='1.87';dns[56]:='3.5';dns[57]:='6.7';
dns[58]:='6.78';dns[59]:='6.77';dns[60]:='7.00';
dns[61]:='6.475';dns[62]:='7.54';dns[63]:='5.26';
dns[64]:='7.89';dns[65]:='8.27';dns[66]:='8.54';
dns[67]:='8.80';dns[68]:='9.05';dns[69]:='9.33';
dns[70]:='6.98';dns[71]:='9.84';dns[72]:='13.1';
dns[73]:='16.6';dns[74]:='19.3';dns[75]:='21.0';
dns[76]:='22.4';dns[77]:='22.5';dns[78]:='21.4';
dns[79]:='19.3';dns[80]:='13.53';dns[81]:='11.85';
dns[82]:='11.4';dns[83]:='9.8';dns[84]:='9.4';
dns[85]:='???';dns[86]:='9.91';dns[87]:='???';
dns[88]:='5';dns[89]:='10.07';dns[90]:='11.7';
dns[91]:='15.4';dns[92]:='18.90';dns[93]:='20.4';
dns[94]:='19.8';dns[95]:='13.6';dns[96]:='13.511';
for x:=97 to nel do dns[x]:='???';

Desc[1]:='1766, por Henry Cavendish';
Desc[2]:='1895, por Ramsey';
Desc[3]:='1817';
Desc[4]:='1798, por Vauquelin';
Desc[5]:='1808, Gay-Lussac, Thenard e Davy';
Desc[6]:='Conhecido desde a prÇ-hist¢ria';
Desc[7]:='1772, por D. Rutherford';
Desc[8]:='1774, por Priestley e Scheele';
Desc[9]:='1771';
Desc[10]:='1898, por Ramsey e Travers';
Desc[11]:='1807, por Humphrey Davy';
Desc[12]:='1775';
Desc[13]:='1827, por Wohler';
Desc[14]:='1823, por Berzelius';
Desc[15]:='1669';
Desc[16]:='Conhecido desde a Antiguidade';
Desc[17]:='1774, por Scheele';
Desc[18]:='1894, por Ramsey';
Desc[19]:='1807, por Humphrey Davy';
Desc[20]:='1808, por Humphrey Davy';
Desc[21]:='1879';
Desc[22]:='1791';
Desc[23]:='1830';
Desc[24]:='1797';
Desc[25]:='1774';
Desc[26]:='Utilizado desde a prÇ-hist¢ria';
Desc[27]:='1735';
Desc[28]:='1751';
Desc[29]:='Conhecido desde a Antiguidade';
Desc[30]:='SÇc. XVI, por Paracelsus';
Desc[31]:='1875, por Lecoq de Boisbaudran';
Desc[32]:='1886, por Winkler';
Desc[33]:='Ò1250';
Desc[34]:='1807, por Berzelius';
Desc[35]:='1826, por Balard';
Desc[36]:='1898, por Ramsey e Travers';
Desc[37]:='1861, por Kirchoff e Bunsen';
Desc[38]:='1790, na Esc¢cia';
Desc[39]:='1794, por Gadolin';
Desc[40]:='1789';
Desc[41]:='1801';
Desc[42]:='1778, por Scheele';
Desc[43]:='1937';
Desc[44]:='1844';
Desc[45]:='1803, por W. H. Wollston';
Desc[46]:='1803, por W. H. Wollston';
Desc[47]:='Conhecida desde a prÇ-hist¢ria';
Desc[48]:='1817';
Desc[49]:='1863';
Desc[50]:='Conhecido desde a prÇ-hist¢ria';
Desc[51]:='Ò1450';
Desc[52]:='1782';
Desc[53]:='1811, por Courtois';
Desc[54]:='1898, por Ramsey e Travers';
Desc[55]:='1860';
Desc[56]:='1808';
Desc[57]:='1839, por C. G. Mosander';
Desc[58]:='1803';
Desc[59]:='1885, por Auer von Welsbach';
Desc[60]:='1885, por Auer von Welsbach';
Desc[61]:='1947';
Desc[62]:='1879';
Desc[63]:='1896';
Desc[64]:='1880';
Desc[65]:='1843, por C. G. Mosander';
Desc[66]:='1886';
Desc[67]:='1879, por P.T. Cleve';
Desc[68]:='1843, na SuÇcia';
Desc[69]:='1879, por Cleve';
Desc[70]:='1907';
Desc[71]:='1907, por G. Urbain';
Desc[72]:='1923';
Desc[73]:='1802';
Desc[74]:='1783';
Desc[75]:='1925';
Desc[76]:='1804, por Tennant';
Desc[77]:='1804, por Tennant';
Desc[78]:='Ò1550, pelos Espanh¢is';
Desc[79]:='Conhecido desde a Antiguidade';
Desc[80]:='Conhecido desde a Antiguidade';
Desc[81]:='1861';
Desc[82]:='Conhecido desde a Antiguidade';
Desc[83]:='1450';
Desc[84]:='1898, por Marie e Pierre Curie';
Desc[85]:='1940, por D. R. Corson';
Desc[86]:='1900, por Rutherford';
Desc[87]:='1939, por Marguerite Perey';
Desc[88]:='1898, por Marie e Pierre Curie';
Desc[89]:='1899, por Debierne';
Desc[90]:='1828, por Berzelius';
Desc[91]:='1917';
Desc[92]:='1789';
Desc[93]:='1940';
Desc[94]:='1940, por Seaborg e colaboradores';
Desc[95]:='1944';
Desc[96]:='1944';
Desc[97]:='1949';
Desc[98]:='1950, por Seaborg e colaboradores';
Desc[99]:='1952';
Desc[100]:='1953';
Desc[101]:='1955';
Desc[102]:='1958';
Desc[103]:='1961, Lawrence Radiation Labs';
Desc[104]:='1969, Lawrence Radiation Labs';
Desc[105]:='1970';
Desc[106]:='1975,em simultÉneo por URSS e EUA';
Desc[107]:='1979';
Desc[108]:='1984, por cientistas da ex-RFA';
Desc[109]:='1982, por cientistas da ex-RFA';
end; {inicializa6}


BEGIN       {AQUI COMECA A PARTE PRINCIPAL DO PROGRAMA, QUE GERE TODOS OS
             PROCEDIMENTOS DECLARADOS ANTERIORMENTE}

checkbreak:=false;
textbackground(black);
clrscr;

inicializa1;
inicializa2;
inicializa3;
inicializa4;
inicializa5;
inicializa6;

REPEAT   {menuinicial}
window(1,1,80,25);
textbackground(lightgray);
textcolor(black);
clrscr;
for x:=1 to 111 do write('e  Spooler Magazin');
write('e');
randomize;
x:=random(23);y:=random(7)+1;
textcolor(black);
gotoxy(x+3,y+18);
write('€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€');
for z:=y+2 to y+18 do begin
                      gotoxy(x+56,z);
                      write('€€');
                     end;
window(x+1,y+1,x+55,y+17);
back:=(random(5)+1);
textbackground(back);
textcolor(yellow);
clrscr;
gotoxy(2,2);writeln('…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª');
for z:=1 to 13 do
           writeln(' ∫                                                   ∫');
             write(' »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº');
textcolor(11);
gotoxy(5,2);writeln(' TABELA PERIüDICA ');
textcolor(white);
gotoxy(5,4);write('Escrito por ');
textcolor(yellow);write('Bruno Marques');
textcolor(white);write(' para a revista ');
textcolor(yellow);write('Spooler');
textcolor(lightcyan);
gotoxy(20,6);writeln('O P Ä ô E S :');
textcolor(white);gotoxy(8,8);write('T');
textcolor(yellow);writeln(' - Ver a tabela peri¢dica dos elementos');
textcolor(white);gotoxy(8,9);write('C');
textcolor(yellow);writeln(' - Consultar dados sobre um elemento');
textcolor(white);gotoxy(8,10);write('A');
textcolor(yellow);writeln(' - Abandonar este programa, voltando ao DOS');
textcolor(white);gotoxy(8,11);write('S');
textcolor(yellow);writeln(' - Shell P/ DOS');
textcolor(white);gotoxy(8,12);write('G');
textcolor(yellow);writeln(' - Gloss†rio');
textcolor(white);gotoxy(8,13);write('N');
textcolor(yellow);write(' - Som: ');
textcolor(white);if som=true then write('LIGADO   ')
                               else write('DESLIGADO');
gotoxy(8,15);
textcolor(lightcyan);
write('Qual a opáÑo escolhida ? [ ]');
gotoxy(34,15);
repeat
opcao:=readkey;
until opcao in ['a','A','t','T','s','S','c','C','g','G','n','N'];
     case opcao of
        'a','A': begin
                   write(opcao);
                   if som=true then begin
                                      sound(800);delay(100);nosound;
                                      end;
                   abandonar;
                   end;
        't','T': begin
                   write(opcao);
                   if som=true then begin
                                      sound(800);delay(100);nosound;
                                      end;
                   begin
                    x:=random(2);
                    if x=0 then closewin1(55,17,back,som)
                           else closewin2(55,17,back,som);
                   end;
                   desenhartabela;
                   if som=true then begin

                                      sound(150);delay(100);nosound;
                                      end;
                   end;
        's','S': begin
                   write(opcao);
                   if som=true then begin
                                      sound(800);delay(100);nosound;
                                      end;
                   begin
                    x:=random(2);
                    if x=0 then closewin1(55,17,back,som)
                           else closewin2(55,17,back,som);
                   end;
                   shellpdos;
                   if som=true then begin
                                      sound(150);delay(100);nosound;
                                      end;
                   end;
        'c','C': begin
                   write(opcao);
                   if som=true then begin
                                      sound(800);delay(100);nosound;
                                      end;
                   consultar(back);
                   if som=true then begin
                                      sound(150);delay(100);nosound;
                                      end;
                   end;
        'g','G': begin
                   write(opcao);
                   if som=true then begin
                                      sound(800);delay(100);nosound;
                                      end;
                   begin
                    x:=random(2);
                    if x=0 then closewin1(55,17,back,som)
                           else closewin2(55,17,back,som);
                   end;
                   glossario;
                   if som=true then begin
                                      sound(150);delay(100);nosound;
                                      end;
                   end;
        'n','N': begin
                  write(opcao);
                  som:=not som;
                 end;

       end;{CASE}

UNTIL opcao in ['a','A'];   {menuinicial}
end.


