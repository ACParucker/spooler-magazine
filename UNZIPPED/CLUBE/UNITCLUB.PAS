Unit unitclub;

Interface

Uses crt,dos,graph,utilites,pfa;

Type filme=record
            numero:longint;
            nome,realizador:string[60];
            genero,duracao:string[40];
            protagonistas:array[1..3] of string[55];
            horas:datetime;
            estado:boolean;
            categoria:char;
           end;
     socio=record
            numero:longint;
            nome,morada:string[60];
            telefone,bi:string[10];
            cadastro,cfa:integer;
            f_alug:array[1..20] of longint;
           end;
     preco=record
            ft,fe,fa:longint
           end;

{ þ VARIAVEIS GLOBAIS þ }

Var conta_socios,
    conta_filmes,
    acumula_lucro,
    ent_sai_filme:longint;
    precos_cass:preco;
    errada:word;

Procedure inicia;
Procedure cenario;
Procedure requerimentos;
Procedure limpa_ecran;
Procedure cartao(x,y,xf,yf,cor:integer;s:string);
Procedure Erros(x:integer);
Procedure erros_de_leitura(er:word);
Procedure Mensagem(x:integer);
Procedure limpa_parte(x,y,xf,yf,cor:integer);
Function Le_cadastro(v:socio):string;
Function ver_existe_socio(nn:string;var d:socio;var xx:longint):boolean;
Function ver_existe_filme(nn:string;var d:filme;var xx:longint):boolean;
Procedure REF(var d:socio);
Procedure REF2(var d:filme);
Procedure ajuda;
Procedure Relatorio;
Procedure tabela_de_precos;
Procedure Listar_socios;

Implementation

{ *** INICIA AS VARI†VEIS MAIS IMPORTANTES DO PROGRAMA *** }

Procedure inicia;
Var aux:socio;
    aux2:filme;
    f:file of socio;
    f2:file of filme;
    f3:file of preco;
Begin
     conta_socios:=0;
     If existe('SOCIOS.SOC') then
                              begin
                               Assign(f,'SOCIOS.SOC');Reset(f);
                               While not eof(f) do
                                begin
                                 read(f,aux);inc(conta_socios)
                                end;
                              end;
     conta_filmes:=0;
     If existe('FILMES.FIL') then
                              begin
                               Assign(f2,'FILMES.FIL');Reset(f2);
                               While not eof(f2) do
                                begin
                                 read(f2,aux2);inc(conta_filmes)
                                end;
                              end;
     If existe('PRECOS.PRE') then
                              begin
                               Assign(f3,'PRECOS.PRE');Reset(f3);
                               read(f3,precos_cass);
                               Close(f3)
                              end
                             else
                              begin
                               precos_cass.ft:=0;
                               precos_cass.fe:=0;
                               precos_cass.fa:=0
                              end;
     acumula_lucro:=0;
     ent_sai_filme:=0
end;

{ *** DESENHA O CENARIO DO PROGRAMA *** }

Procedure cenario;
Var aux:integer;
    c:char;
Begin
     Jan2(0,0,getmaxx,40,11,1,3,2);
     Jan2(0,getmaxy-40,getmaxx,getmaxy,11,1,3,2);
     aux:=0;
     Repeat
      Tecla(aux,40,40+aux,80,false);
      aux:=aux+40;
     until aux>getmaxx;
     Imagem(5,45,'OP-SAIDA.IMG');
     Imagem(45,45,'OP-INSOC.IMG');
     Imagem(85,45,'OP-MOSOC.IMG');
     Imagem(125,45,'OP-EXSOC.IMG');
     Imagem(165,45,'OP-LSOCS.IMG');
     Imagem(205,45,'OP-PRSOC.IMG');
     Imagem(245,45,'OP-PVSOC.IMG');
     Imagem(285,45,'OP-AJUDA.IMG');
     Imagem(325,45,'OP-PRECO.IMG');
     Imagem(365,45,'OP-SAFIL.IMG');
     Imagem(405,45,'OP-ENFIL.IMG');
     Imagem(445,45,'OP-CPFIL.IMG');
     Imagem(485,45,'OP-MOFIL.IMG');
     Imagem(525,45,'OP-LIFIL.IMG');
     Imagem(565,45,'OP-EXFIL.IMG');
     Imagem(605,45,'OP-RELAT.IMG');
     Settextstyle(triplexfont,0,0);
     Escreve4(210,2,12,'CLUBE DE VIDEO');
     Escreve4(50,getmaxy-40,12,'1993 (c) Luis Bruno Software LBS');
     Settextstyle(0,0,0);
     disco(200,150,400,350,15,7,8,3,3);
     Escreve3(240,250,12,4,'CLUBE DE VIDEO');
     Escreve3(260,260,12,4,'Vers„o 1.0');
     imagem(280,280,'LBS.IMG');
     Repeat c:=premir until (ratotec=1) or (ratotec=2) or ((ord(c)>=0) and (ord(c)<=122));
     Setviewport(200,150,400,350,Clipon);Clearviewport;Setviewport(0,0,getmaxx,getmaxy,Clipon)
end;

{ *** VERIFICA TODOS OS REQUERIMENTOS DO PROGRAMA *** }

Procedure requerimentos;

Var flag:boolean;
    x:integer;
    driver:string;

Procedure Vrf(x,y:integer;s:string;von:boolean);
Var aux:integer;
Begin
     if von then aux:=14 else aux:=132;
     Textcolor(aux);flag:=von;
     Gotoxy(x,y);Writeln(s);
     delay(200)
end;

Begin
     ig(detect,0);driver:=getdrivername;Closegraph;
     flag:=true;Inicrato;cores(7,0);Clrscr;cursor(desligado);
     Textcolor(3);enchearea(22,2,57,24,'Û');
     caixa(22,2,57,24,1,3,2);
     tabular(22,57,3,'CLUBE VIDEO - versao 1.0');
     caixa(24,5,39,23,1,3,2);
     Gotoxy(26,6);Writeln('OP-SAIDA.IMG');
     Gotoxy(26,7);Writeln('OP-INSOC.IMG');
     Gotoxy(26,8);Writeln('OP-EXSOC.IMG');
     Gotoxy(26,9);Writeln('OP-MOSOC.IMG');
     Gotoxy(26,10);Writeln('OP-LSOCS.IMG');
     Gotoxy(26,11);Writeln('OP-PRSOC.IMG');
     Gotoxy(26,12);Writeln('OP-PVSOC.IMG');
     Gotoxy(26,13);Writeln('OP-SAFIL.IMG');
     Gotoxy(26,14);Writeln('OP-ENFIL.IMG');
     Gotoxy(26,15);Writeln('OP-PRECO.IMG');
     Gotoxy(26,16);Writeln('OP-CPFIL.IMG');
     Gotoxy(26,17);Writeln('OP-LIFIL.IMG');
     Gotoxy(26,18);Writeln('OP-EXFIL.IMG');
     Gotoxy(26,19);Writeln('OP-MOFIL.IMG');
     Gotoxy(26,20);Writeln('OP-RELAT.IMG');
     Gotoxy(26,21);Writeln('OP-AJUDA.IMG');
     Gotoxy(26,22);Writeln('LBS     .IMG');
     caixa(42,5,55,8,1,3,2);
     Gotoxy(44,6);Writeln('EGAVGA.BGI');
     Gotoxy(44,7);Writeln(' TRIP.CHR ');
     caixa(42,9,47,11,1,3,2);
     caixa(49,9,55,11,1,3,2);
     Gotoxy(43,10);Writeln('RATO');
     Gotoxy(50,10);Writeln('PLACA');
     Gotoxy(42,12);Writeln('±±±±±±±±±±±±±±');
     Gotoxy(42,13);Writeln('±±ÛÛ±±±±±±±±±±');
     Gotoxy(42,14);Writeln('±±ÛÛ±±ÛÛÛÛÛ±±±');
     Gotoxy(42,15);Writeln('±±ÛÛ±±ÛÛ±±ÛÛ±±');
     Gotoxy(42,16);Writeln('±±ÛÛ±±±±±±ÛÛ±±');
     Gotoxy(42,17);Writeln('±±ÛÛÛÛÛÛÛÛÛ±±±');
     Gotoxy(42,18);Writeln('±±±±±±±±±±ÛÛ±±');
     Gotoxy(42,19);Writeln('±±±±±±ÛÛ±±ÛÛ±±');
     Gotoxy(42,20);Writeln('±±±±±±ÛÛÛÛÛ±±±');
     Gotoxy(42,21);Writeln('±±±±±±±±±±±±±±');
     Gotoxy(42,22);Writeln('     SOFT     ');

     { * COMECAR VERIFICACAO * }

     If verrato then vrf(43,10,'RATO',true)
                else vrf(43,10,'RATO',false);

     If driver='EGAVGA' then vrf(50,10,'PLACA',true)
                         else vrf(50,10,'PLACA',false);

     If existe('EGAVGA.BGI') then vrf(44,6,'EGAVGA.BGI',true)
                             else vrf(44,6,'EGAVGA.BGI',false);

     If existe('TRIP.CHR') then vrf(44,7,' TRIP.CHR ',true)
                           else vrf(44,7,' TRIP.CHR ',false);

     If existe('OP-SAIDA.IMG') then vrf(26,6,'OP-SAIDA.IMG',true)
                               else vrf(26,6,'OP-SAIDA.IMG',false);

     If existe('OP-INSOC.IMG') then vrf(26,7,'OP-INSOC.IMG',true)
                               else vrf(26,7,'OP-INSOC.IMG',false);

     If existe('OP-EXSOC.IMG') then vrf(26,8,'OP-EXSOC.IMG',true)
                               else vrf(26,8,'OP-EXSOC.IMG',false);

     If existe('OP-MOSOC.IMG') then vrf(26,9,'OP-MOSOC.IMG',true)
                               else vrf(26,9,'OP-MOSOC.IMG',false);

     If existe('OP-LSOCS.IMG') then vrf(26,10,'OP-LSOCS.IMG',true)
                               else vrf(26,10,'OP-LSOCS.IMG',false);

     If existe('OP-PRSOC.IMG') then vrf(26,11,'OP-PRSOC.IMG',true)
                               else vrf(26,11,'OP-PRSOC.IMG',false);

     If existe('OP-PVSOC.IMG') then vrf(26,12,'OP-PVSOC.IMG',true)
                               else vrf(26,12,'OP-PVSOC.IMG',false);

     If existe('OP-SAFIL.IMG') then vrf(26,13,'OP-SAFIL.IMG',true)
                               else vrf(26,13,'OP-SAFIL.IMG',false);

     If existe('OP-ENFIL.IMG') then vrf(26,14,'OP-ENFIL.IMG',true)
                               else vrf(26,14,'OP-ENFIL.IMG',false);

     If existe('OP-PRECO.IMG') then vrf(26,15,'OP-PRECO.IMG',true)
                               else vrf(26,15,'OP-PRECO.IMG',false);

     If existe('OP-CPFIL.IMG') then vrf(26,16,'OP-CPFIL.IMG',true)
                               else vrf(26,16,'OP-CPFIL.IMG',false);

     If existe('OP-LIFIL.IMG') then vrf(26,17,'OP-LIFIL.IMG',true)
                               else vrf(26,17,'OP-LIFIL.IMG',false);

     If existe('OP-EXFIL.IMG') then vrf(26,18,'OP-EXFIL.IMG',true)
                               else vrf(26,18,'OP-EXFIL.IMG',false);

     If existe('OP-MOFIL.IMG') then vrf(26,19,'OP-MOFIL.IMG',true)
                               else vrf(26,19,'OP-MOFIL.IMG',false);

     If existe('OP-RELAT.IMG') then vrf(26,20,'OP-RELAT.IMG',true)
                               else vrf(26,20,'OP-RELAT.IMG',false);

     If existe('OP-AJUDA.IMG') then vrf(26,21,'OP-AJUDA.IMG',true)
                               else vrf(26,21,'OP-AJUDA.IMG',false);

     If existe('LBS.IMG') then vrf(26,22,'LBS     .IMG',true)
                          else vrf(26,22,'LBS     .IMG',false);

     If not flag then
                  begin
                   cores(7,0);
                   Clrscr;
                   textcolor(4);
                   enchearea(17,8,61,12,'Û');
                   caixa(17,8,61,12,9,4,2);
                   tabular(17,61,9,'- IMPOSSIBILIDADE DE CORRER O PROGRAMA -');
                   tabular(17,61,10,'Por favor verifique se possui todos');
                   tabular(17,61,11,'os requerimentos necess rios .');
                   Writeln;Writeln;
                   cores(7,0);cursor(ligado);Halt(1)
                  end
                 else
                  begin
                   Inicrato;ig(detect,0);
                   Definir(0,0,getmaxx-16,getmaxy-16)
                  end;
end;

{ ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ }
{ ÛÛ                       PROCEDIMENTOS GLOBAIS                           ÛÛ }
{ ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ }

{ *** VERIFICA A EXISTENCIA DE NUMEROS, LETRAS OU AMBOS *** }

Procedure numlet(s:string;var fnum,flet:boolean);
Var x:integer;
Begin
     fnum:=false;flet:=false;
     For x:=1 to length(s) do
      begin
       if (s[x]='0') or
          (s[x]='1') or
          (s[x]='2') or
          (s[x]='3') or
          (s[x]='5') or
          (s[x]='6') or
          (s[x]='7') or
          (s[x]='8') or
          (s[x]='9') or
          (s[x]='0') then fnum:=true
                     else flet:=true;
      end;
end;

{ *** LIMPA O ECRAN DE TRABALHO *** }

Procedure limpa_ecran;
Begin
     Setviewport(0,80,getmaxx,getmaxy-40,true);
     Clearviewport;
     Setviewport(0,0,getmaxx,getmaxy,true)
end;

{ *** DESENHA O CARTAO *** }

Procedure cartao(x,y,xf,yf,cor:integer;s:string);
Begin
     Setcolor(8);
     rectangle(x,y,xf,yf);
     Line(x,y,x+10,y-20);Line(x+10,y-20,x+200,y-20);Line(x+200,y-20,x+210,y);
     Pintar(x+2,y+2,15,8);Pintar(x+5,y-3,15,8);
     Escreve2(x+15,y-15,cor,s)
end;

{ *** MOSTRA UM DETERMINADO ERRO *** }

Procedure Erros(x:integer);
Var px:integer;
    saux:string;
    c:char;
Begin
     Jan2(100,150,getmaxx-100,200,15,4,12,2);
     Case x of
       1:saux:=' --- ERRO NA GRAVA€ŽO --- ';
       2:saux:=' --- ERRO NA LEITURA --- ';
       3:saux:=' --- ESPA€O INSUFICIENTE --- ';
       4:saux:=' --- SOCIO NAO ENCONTRADO --- ';
       5:saux:=' >>> SOCIO ARQUIVADO EM DISCO <<< ';
       6:saux:=' --- FILME NAO ENCONTRADO --- ';
       7:saux:=' -- NAO ALUGOU NENHUM FILME -- ';
       8:saux:=' ------- FILME ALUGADO ------- ';
       9:saux:=' ------- FILME ENTREGUE ------- ';
       10:saux:='-- ESTE FILME ENCONTRA-SE FORA --';
       11:saux:='-- ESTE FILME ENCONTRA-SE DENTRO --';
       12:saux:='-- DISCO PROTEGIDO --';
       13:saux:='-- ERRO NA ESCRITA --';
       14:saux:='-- ESTE SOCIO JA SE ENCONTRA ARQUIVADO EM DISCO --';
       15:saux:='-- ESTE FILME JA SE ENCONTRA ARQUIVADO EM DISCO --';
       16:saux:='---- TODOS OS SOCIOS FORAM REMOVIDOS ----';
       17:saux:='---- TODOS OS FILMES FORAM REMOVIDOS ----'
      end;
     px:=100+((((getmaxx-100)-100) div 2)-((length(saux)*8) div 2));
     Escreve2(px,170,14,saux);
     Repeat c:=premir until (ratotec=1) or (ratotec=2) or ((ord(c)>=0) and (ord(c)<=122))
end;

{ *** VERIFICA OS ERROS DE LEITURA *** }

Procedure erros_de_leitura(er:word);
Begin
     if er<>0 then
               begin
                if er=150 then
                           erros(12)
                          else
                           erros(13)
               end;
end;

{ *** MOSTRA UMA DETERMINADA MENSAGEM *** }

Procedure Mensagem(x:integer);
Var px:integer;
    saux:string;
Begin
     Jan2(100,150,getmaxx-100,200,15,4,12,2);
     Case x of
       1:saux:=' -- DESEJA INSERIR MAIS ALGUM SOCIO (S/N) ? --';
       2:saux:=' -- DESEJA MODIFICAR MAIS ALGUM SOCIO (S/N) ? --';
       3:saux:=' -- DESEJA EXCLUIR MAIS ALGUM SOCIOS (S/N) ? --';
       4:saux:=' -- DESEJA PROCURAR MAIS ALGUM SOCIO (S/N) ? --';
       5:saux:=' -- DESEJA PESQUISAR MAIS ALGUM SOCIO (S/N) ? --';
       6:saux:=' - DESEJA REGISTAR A SAIDA DE OUTRO FILME (S/N) ? -';
       7:saux:=' - DESEJA REGISTAR A ENTRADA DE OUTRO FILME (S/N) ? -';
       8:saux:=' -- DESEJA COMPRAR MAIS ALGUM FILME (S/N) ? --';
       9:saux:=' -- DESEJA MODIFICAR MAIS ALGUM FILME (S/N) ? --';
       10:saux:=' -- DESEJA EXCLUIR MAIS ALGUM FILME (S/N) ? --'
      end;
     px:=100+((((getmaxx-100)-100) div 2)-((length(saux)*8) div 2));
     Escreve2(px,170,14,saux)
end;

{ *** LIMPA UMA PARTE DO ECRAN *** }

Procedure limpa_parte(x,y,xf,yf,cor:integer);
Var aux:integer;
Begin
     Setcolor(cor);
     For aux:=y to yf do
      Line(x,aux,xf,aux)
end;

{ *** LE O CADASTRO DE UM CLIENTE *** }

Function Le_cadastro(v:socio):string;
Begin
     case v.cadastro of
      0:Le_cadastro:='Socio exemplar - nenhuma infrac‡„o';
      1:Le_cadastro:='Cometeu uma infrac‡„o';
      2:Le_cadastro:='Cometeu duas infrac‡”es';
      3:Le_cadastro:='Cometeu tres infrac‡”es';
      4:Le_cadastro:='Cometeu quatro infrac‡”es - Recomenda-se cautela';
      5:Le_cadastro:='Cometeu cinco infrac‡”es - Recomenda-se expuls„o'
     end;
end;

{ *** VERIFICA A EXISTENCIA DE UM SOCIO *** }

Function ver_existe_socio(nn:string;var d:socio;var xx:longint):boolean;
Var f,f2:file of socio;
    flag,fnum,flet:boolean;
    code:integer;
Begin
     flag:=false;numlet(nn,fnum,flet);
     if existe('SOCIOS.SOC') then
     begin
      Assign(f,'SOCIOS.SOC');Reset(f);
      if (not flet)
                  and
                    (fnum) then
                            begin
                             Val(nn,xx,code);
                             While (not eof(f)) and (not(flag)) do
                              begin
                               read(f,d);
                               if d.numero=xx then flag:=true
                              end
                            end
                           else
                            begin
                             While (not eof(f)) and (not(flag)) do
                              begin
                               read(f,d);
                               if d.nome=nn then
                                              begin
                                               flag:=true;
                                               xx:=d.numero
                                              end;
                              end
                            end;
      Close(f);
     end;
     ver_existe_socio:=flag
end;

{ *** VERIFICA A EXISTENCIA DE UM FILME *** }

Function ver_existe_filme(nn:string;var d:filme;var xx:longint):boolean;
Var f,f2:file of filme;
    flag,fnum,flet:boolean;
    code:integer;
Begin
     flag:=false;numlet(nn,fnum,flet);
     if existe('FILMES.FIL') then
     begin
      Assign(f,'FILMES.FIL');Reset(f);
      if (not flet)
                  and
                    (fnum) then
                            begin
                             Val(nn,xx,code);
                             While (not eof(f)) and (not(flag)) do
                              begin
                               read(f,d);
                               if d.numero=xx then flag:=true
                              end
                            end
                           else
                            begin
                             While (not eof(f)) and (not(flag)) do
                              begin
                               read(f,d);
                               if d.nome=nn then
                                              begin
                                               flag:=true;
                                               xx:=d.numero
                                              end;
                              end
                            end;
      Close(f);
     end;
     ver_existe_filme:=flag
end;

{ ***      REFERENCIA UM SOCIO, CASO NAO SE INTRODUZA UM NOME O COMPUTADOR NUMERA        *** }
{ *** O SOCIO POR 'DESCONHECIDO <numero>'. ESTE PROCEDIMENTO CORTA TAMBEM ESPA€OS A MAIS *** }

Procedure REF(var d:socio);
Var aux:integer;
Begin
     if length(d.nome)>0 then
                          begin
                           aux:=length(d.nome)+1;
                           Repeat dec(aux) until d.nome[aux]<>' ';
                           Delete(d.nome,aux+1,(length(d.nome)-aux))
                          end
                         else
                          begin
                           d.nome:='DESCONHECIDO '+npl(d.numero);
                           Setcolor(0);Outtextxy(100,160,d.nome)
                          end;
end;

{ ***      REFERENCIA UM FILME, CASO NAO SE INTRODUZA UM NOME O COMPUTADOR NUMERA        *** }
{ *** O FILME POR 'DESCONHECIDO <numero>'. ESTE PROCEDIMENTO CORTA TAMBEM ESPA€OS A MAIS *** }

Procedure REF2(var d:filme);
Var aux:integer;
Begin
     if length(d.nome)>0 then
                          begin
                           aux:=length(d.nome)+1;
                           Repeat dec(aux) until d.nome[aux]<>' ';
                           Delete(d.nome,aux+1,(length(d.nome)-aux))
                          end
                         else
                          begin
                           d.nome:='FILME DESCONHECIDO '+npl(d.numero);
                           Setcolor(0);Outtextxy(85,140,d.nome)
                          end;
end;

{ **************** PROCEDIMENTOS SECUND†RIOS DO PROGRAMA ******************** }
{ ********************************* AJUDA *********************************** }

Procedure ajuda;
Begin
     escrato;
     Jan2(10,100,getmaxx-10,getmaxy-50,11,3,3,2);
     Escreve2(30,120,12,'- AJUDA -');
     Escreve2(35,150,14,'- Na Listagem de socios e filmes , os socios que tenham filmes em seu');
     Escreve2(35,160,14,'  poder ou os filmes que estao alugados apareceram a vermelho os');
     Escreve2(35,170,14,'  restantes apareceram a preto .');
     Escreve2(35,190,14,'- O Lucro obtido que ‚ mostrado na op‡„o Relat¢rio diz respeito ao total');
     Escreve2(35,200,14,'  facturado desde o momento em que o programa foi activado at‚   sua ');
     Escreve2(35,210,14,'  desactiva‡„o .');
     Escreve2(35,230,14,'- O op‡„o tabela de pre‡os indica-nos o pre‡o por dia dos filmes com uma');
     Escreve2(35,240,14,'  determinada categoria , o valor dos pre‡os por dia pode ser alterado.');
     Escreve2(35,260,14,'- Os filmes assim como os socios est„o ordenados numericamento , por essa');
     Escreve2(35,270,14,'  raz„o quando um socio ou filme ‚ apagado , o n£mero que lhe pertencia');
     Escreve2(35,280,14,'  ir  ser atribuido ao pr¢ximo socio que for entrado ou respectivamento');
     Escreve2(35,290,14,'  ao pr¢ximo filme que for comprado . ');
     Imagem(30,getmaxy-100,'LBS.IMG');
     Imagem(getmaxx-70,getmaxy-100,'LBS.IMG');
     Escreve2(170,getmaxy-70,10,'Prima uma das teclas do rato para sair');
     Repeat until (ratotec=1) or (ratotec=2);
     Limpa_ecran;rato
end;

{ *********************** RELATORIO DO CLUBE ******************************** }

Procedure Relatorio;
Begin
     escrato;
     Jan2(20,140,getmaxx-20,getmaxy-150,3,9,1,2);
     Settextstyle(1,0,0);
     Escreve4(250,150,12,'Relatorio');
     Settextstyle(0,0,2);
     Escreve4(60,200,9,'N. de socios : '+npl(conta_socios));
     Escreve4(60,230,9,'N. de filmes : '+npl(conta_filmes));
     Escreve4(60,260,9,'Lucro obtido (hoje) : '+npl(acumula_lucro)+' $');
     Settextstyle(0,0,0);
     Escreve2(180,310,11,'Prima uma das teclas do rato para sair');
     Repeat until (ratotec=1) or (ratotec=2);
     Limpa_ecran;rato
end;

{ ***************************** TABELA DE PRE€OS **************************** }

Procedure tabela_de_precos;

Procedure Indica_preco(ff:preco);
Begin
     Limpa_parte(225,185,getmaxx-250,290,3);
     Settextstyle(0,0,2);
     Escreve(270,190,0,npl(ff.ft)+' $');
     Escreve(270,230,0,npl(ff.fe)+' $');
     Escreve(270,270,0,npl(ff.fa)+' $');
     Settextstyle(0,0,0)
end;

Label errado;

Var aux:integer;
    f:file of preco;
    ff:preco;
    flag:boolean;
Begin
     escrato;flag:=false;
     Jan2(20,100,getmaxx-20,getmaxy-100,11,1,3,2);
     Settextstyle(1,0,0);
     Escreve(170,110,12,'TABELA DE PRECOS');
     Settextstyle(0,0,0);
     Escreve(418,130,12,',');aux:=0;
     Repeat
       Tecla(40,180+aux,185,210+aux,false);
       if aux<120 then Tecla(getmaxx-205,180+aux,getmaxx-60,210+aux,false);
       aux:=aux+40;
     until aux>120;

     Assign(f,'PRECOS.PRE');
     if existe('PRECOS.PRE') then
                              begin
                               Reset(f);
                               Read(f,ff);
                               Close(f)
                              end
                             else
                              begin
                               ff.ft:=0;
                               ff.fe:=0;
                               ff.fa:=0
                              end;
     Settextstyle(0,0,3);
     Escreve(100,150,3,'+');
     Escreve(getmaxx-145,150,3,'-');
     Settextstyle(0,0,0);
     Escreve2(50,190,12,'   Filmes Top');
     Escreve2(53,230,12,'Filmes Expresso');
     Escreve2(50,270,12,' Filmes Antigos');
     Escreve2(47,310,11,'      SAIR');
     Escreve2(getmaxx-195,190,12,'   Filmes Top');
     Escreve2(getmaxx-192,230,12,'Filmes Expresso');
     Escreve2(getmaxx-195,270,12,' Filmes Antigos');
     Indica_preco(ff);

     Repeat
      rato;
      Repeat until ratotec=1;
      escrato;
      If detecta(40,180,185,210) then
                                  begin
                                   Marca(40,180,185,210,true);
                                   ff.ft:=ff.ft+50;flag:=true;
                                   if ff.ft>90000 then ff.ft:=90000;
                                   Indica_preco(ff)
                                  end
                                 else
      if detecta(40,220,185,250) then
                                  begin
                                   Marca(40,220,185,250,true);
                                   ff.fe:=ff.fe+50;flag:=true;
                                   if ff.fe>90000 then ff.fe:=90000;
                                   Indica_preco(ff)
                                  end
                                 else
      if detecta(40,260,185,290) then
                                  begin
                                   Marca(40,260,185,290,true);
                                   ff.fa:=ff.fa+50;flag:=true;
                                   if ff.fa>90000 then ff.fa:=90000;
                                   Indica_preco(ff)
                                  end
                                 else
      if detecta(getmaxx-205,180,getmaxx-60,210) then
                                                  begin
                                                   Marca(getmaxx-205,180,getmaxx-60,210,true);
                                                   ff.ft:=ff.ft-50;flag:=true;
                                                   if ff.ft<0 then ff.ft:=0;
                                                   Indica_preco(ff)
                                                  end
                                                 else
      if detecta(getmaxx-205,220,getmaxx-60,250) then
                                                  begin
                                                   Marca(getmaxx-205,220,getmaxx-60,250,true);
                                                   ff.fe:=ff.fe-50;flag:=true;
                                                   if ff.fe<0 then ff.fe:=0;
                                                   Indica_preco(ff)
                                                  end
                                                 else
      if detecta(getmaxx-205,260,getmaxx-60,290) then
                                                  begin
                                                   Marca(getmaxx-205,260,getmaxx-60,290,true);
                                                   ff.fa:=ff.fa-50;flag:=true;
                                                   if ff.fa<0 then ff.fa:=0;
                                                   Indica_preco(ff)
                                                  end;
     until detecta(40,280,185,330);
     Marca(40,300,185,330,true);

     if flag then begin
                   {$I-} Rewrite(f); {$I+}
                   errada:=IOresult;
                   erros_de_leitura(errada);
                   if errada<>0 then goto errado;
                   Write(f,ff);
                   Close(f);
                   errado:
                   precos_cass:=ff
                  end;
     Limpa_ecran;rato
end;

{ ***************************** LISTAR SOCIOS ******************************* }

Procedure Listar_socios;
Var f:file of socio;
    py:integer;
    d:socio;
    c:char;
    flag:boolean;
Begin
     escrato;py:=120;flag:=false;
     cartao(10,110,getmaxx-10,getmaxy-50,10,' LISTA SOCIOS');
     if existe('SOCIOS.SOC') then
                              begin
                               Setcolor(0);
                               Assign(f,'SOCIOS.SOC');Reset(f);
                               While (not eof(f)) and (not(flag)) do
                                begin
                                 Read(f,d);
                                 if d.cfa>0 then Setcolor(12) else Setcolor(0);
                                 Outtextxy(20,py,d.nome);
                                 Outtextxy(520,py,npl(d.numero));
                                 py:=py+10;
                                 if py>getmaxy-100 then
                                                    begin
                                                     py:=120;
                                                     Escreve2(145,getmaxy-80,10,
                                                     'Prima "C" para continuar e "ESC" para acabar');
                                                     Repeat c:=readkey;c:=Upcase(c) until (c='C') or (c=#27);
                                                     if c=#27 then flag:=true;
                                                     limpa_parte(18,118,getmaxx-12,getmaxy-52,15);
                                                     Setcolor(0)
                                                    end;
                                end;
                               Close(f);
                               if not flag then
                                            begin
                                             Escreve2(145,getmaxy-80,11,
                                             'Prima uma tecla qualquer ou uma tecla do rato');
                                             Repeat
                                              c:=premir
                                             until (ratotec=1) or
                                                   (ratotec=2) or
                                                   (ord(c)>=0) and (ord(c)<=122);
                                            end;
                              end
                             else
                              erros(4);
     Limpa_ecran;rato
end;

Begin
end.