program enforcado (input,output);
uses crt,graph,enfounit,dos;

const max =  20;  { Maximo de palavras que um tema pode ter }

      maxw=  23;  { Maximo de letras que o jogador pode escolher quando joga,
      dependendo do numero de letras que constituem a palavra
      ex: 9 erros(letras) a palavra tem 14 letras logo 23 letras }

      maxex= 14;  { Maximo de letras que uma palavra pode ter,
                     e numero maximo de temas }

type
         encontra = record
                          let:char
                    end;

         palavra  = string[maxex];
         tema     = record
                          pala  :array[0..max] of palavra;
                          na    :0..max
                    end;

var  nomes_temas : array[1..maxex] of string;  { Serve para escolher o Tema pelo nome ou pelo numero }
     ex          : array[1..maxex] of encontra; {Tem as letras j  pedidas que compoem a palavra a adevilhar }
     w           : array[1..maxw] of encontra; { Serve para ver as letras j  escolhidas}
     i           : word;
     b           : boolean;
     st          : string;
     ch          : char;
     tab         : tema;
     f           : file of palavra;


{ Inicializa o array de palavras }
procedure zero;
var r:integer;
begin
     tab.na:=0;
     for r:=1 to max do
        tab.pala[r]:=' '
end;


{ Verifica se o ficheiro existe se n„o existe ‚ criado }
function  existe(y:string):boolean;
begin
     {$i-}
     assign(f,concat(y));
     reset (f);
     close(f);
     {$I+}
     existe:=(ioresult=0) and ( y<>'')
end;


{ Apaga o ficheiro, como o comamdo delete do Dos }
procedure apaga_ficheiro;
begin
     {$I-}
      erase(f);
     {$I+}
     if (ioresult=150) then erros
end;


{ Carrega a informa‡„o de um ficheiro(tema) para um array(tema)
e verifica se o ficheiro foi criado pelo programa }
procedure carrega(y:string;var falha:boolean;var c:char);
var i:integer;
    p:pointer;
    w:word;
begin
     falha:=false;
     {$I-}
     assign (f,concat(y));
     reset(f);
     i:=0;
     while not eof (f) do
     begin
          i:=succ(i);
          read(f,tab.pala[i]);
          {$I+}
          if ioresult<>0
          then begin
                     falha:=true;
                     jan(100,200,getmaxx-100,250,15,4,12,2,p,w);
                     escreve2(145,210,14,'** FICHEIRO NŽO COMPATIVEL OU CORRUMPIDO **');
                     escreve2(106,230,14,'DESEJA REMOVELO ? (');
                     escreve2(260,230,15,'S');
                     escreve2(268,230,14,')  OU QUALQUER OUTRA TECLA P/SAIR');
                     repeat c:=premir; until (ratotec=1) or (ratotec=2) or ((ord(c)>=0) and (ord(c)<=122));
                     if (c in['S','s'])
                     then begin
                               c:='S';
                               putimage(100,200,p^,normalPut);
                               freemem(p,w);
                               apaga_ficheiro;
                               zero;
                               exit
                          end;
                     putimage(100,200,p^,normalput);
                     freemem(p,w);
                     zero;
                     exit
               end
     end;
     tab.na:=i; close(f)
end;



{ Guarda as palavras inserida nos temas, para um ficheiro, verifica
 se existe algum erro que n„o permita a grava‡„o, chama o procedimento erros }
procedure grava(y:string;var falha:boolean);
var i:integer;
begin
     falha:=false;
     {$I-}
     assign(f,concat(y));
     rewrite(f);
     for i:=1 to tab.na do
        write(f,tab.pala[i]);
     close(f);
     {$I+}
     if ioresult<>0 then begin
                              falha:=true;
                              erros
                         end
end;


{ Mostra no ecran as palavras pertencentes do tema escolhido }
procedure listar;
var r,e:integer;
    aux:string;
begin
     if (tab.na>0)
     then begin
               settextstyle(0,0,1);
               e:=0;
               r:=0;
               limpa_parte(90,113,246,400,15);
               repeat
                     e:=e+14;
                     delay(40);
                     r:=succ(r);
                     str(r,aux);
                     escreve2(100,110+e,14,aux);
                     escreve2(130,110+e,15,tab.pala[r])
               until  (r=tab.na)
          end
end;


{ zero2,zero3 s„o procedimentos que inicializ„o dois arrays auxeliares
 utelizados dentro de outro procedimento, para verificar as letras que j 
   foram pedidas e as que pode ainda pedir }
procedure zero2;
var o:integer;
begin
     for o:=1 to maxex do
        ex[o].let:=' '
end;

procedure zero3;
var o:integer;
begin
     for o:=1 to maxw do
         w[o].let:=' '
end;


{ Devolve a posi‡„o da palavra no array para o jogador acertar }
procedure sorte(var posicao,erros,n,nn:word);
var e,r:integer;
begin
     zero2;
     zero3;
     n:=0;
     nn:=0;
     erros:=0;
     randomize;
     posicao:=succ(random(tab.na));
     settextstyle(1,0,4);
     limpa_parte(19,200,600,300,3);
     r:=0;
     e:=0;
     repeat
           r:=succ(r);
           e:=e+40;
           escreve2(12+e,360,9,'_')
     until (r=length(tab.pala[posicao]));
     settextstyle(1,0,1);
     escreve2(50,180,12,'LETRAS J† PEDIDAS:')
end;


{ Aceita as letras, do teclado examina array auxeliar para ver se a letra
 j  tinha sido pedida, se tiver sido pedida, ‚ escrita uma informa‡„o
 no ecran, examina tambem se a letra introduzida pertence   palavra para
 acertar se n„o pertencer devolve o n§de erros+1 }
procedure executa(var letra:string;i:word;var erros,n,nn:word);
var e,o:integer;
    b:boolean;
    auxeliar:char;
    label 88,fim;
    { label fim ‚ usada na possiblidade de n„o se contar como erro a letra
     pedida mais de uma vez  n„o pertencendo   palavra }
begin
     b:=false;
     settextstyle(0,0,1);
     limpa_parte(30,420,150,440,3);
     escreve2(50,430,10,'LETRA:');
     repeat
           auxeliar:=premir;
           auxeliar:=upcase(auxeliar);
     until (auxeliar in['A','B','C','D','E','F','G','H','I','J','K','L',
     'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']);
     limpa_parte(220,428,550,456,3);
     letra:=auxeliar;
     escreve2(110,430,14,letra);
     delay(200);
     begin
          for e:=1 to maxw do
            begin
                 if (w[e].let<>letra[1])
                 then  o:=e
                 else begin
                           sound(60);
                           settextstyle(1,0,1);
                           escreve2(230,430,12,'O');
                           escreve2(260,430,14,letra[1]);
                           escreve2(290,430,12,'J† TINHA SIDO PEDIDO !');
                           delay(50);
                           nosound;
                           goto fim
                      end
            end
     end;
     n:=n+1;
     if (o=maxw) then w[n].let:=letra[1];
     nn:=nn+14;
     settextstyle(1,0,1);
     escreve2(30+nn,220,14,letra);
     88:
     for e:=1 to length(tab.pala[i]) do
     begin
          settextstyle(1,0,3);
          if (letra=tab.pala[i][e]) { Verifica se a letra pedida e igual  }
          then begin                { letra da tab.pala[i][e], i=posi‡„o}
                    ex[e].let:=tab.pala[i][e]; {no array das palavras, }
                    o:=e*40;                    { e=posi‡„o da letra na palavra}
                    escreve2(13+o,370,12,ex[e].let);
                    b:=true
               end
          else begin  if (e=length(tab.pala[i])) and  (not (b))
                      then begin
                                erros:=erros+1;      {conta os erros}
                                settextstyle(0,0,1);
                                str(erros,st);
                                limpa_parte(570,174,600,194,3);
                                escreve2(520,180,13,'ERROS:');
                                escreve2(580,180,10,st)
                           end
               end
       end;
       fim:
end;


{ Faz a comuta‡„o entre MUSICA ON/OFF }
procedure som_on_off(var som_off:boolean);
begin
     if (som_off) then som_off:=false
     else if not (som_off) then som_off:=true
end;


{Realiza a musica funebre ou de vitoria}
procedure som(som_off:boolean;numero,demora,amp:integer);
var cons:real;
    freq,loop:integer;
begin
      if  (som_off) then exit;
      cons:=exp(ln(2)/12);
      freq:=round(amp*exp(ln(cons)*numero));
      for loop:=trunc(freq/2) to freq do
          sound(loop);
      delay(demora);
      nosound
end;

procedure executa_funebre(som_on:boolean);
begin
      som(som_on,9,600,100);
      som(som_on,9,600,100);
      som(som_on,8,250,100);
      som(som_on,9,600,100);
      som(som_on,12,600,100);
      som(som_on,11,250,100);
      som(som_on,11,600,100);
      som(som_on,9,250,100);
      som(som_on,9,600,100);
      som(som_on,8,250,100);
      som(som_on,9,600,100)
end;

procedure executa_vitoria(som_on:boolean);
var n1,n2,n3:integer;
begin
     n1:=0;
     n2:=0;
     for n3:=1 to 90 do
       begin
            n1:=n1+1;
            n2:=n2+1;
            som(som_on,n1,50,n2);
       end
end;


procedure informacao_nao_existe;
var c:char;
    p:pointer;
    w:word;
begin
     jan(100,200,getmaxx-100,250,15,4,12,2,p,w);
     escreve2(210,220,14,'***  TEMA ENEXISTENTE  ***') ;
     repeat c:=premir until (ratotec=1) or (ratotec=2) or ((ord(c)>=0) and (ord(c)<=122));
     putimage(100,200,p^,normalPut);
     freemem(p,w)
end;



{ Informa‡„o de que acertou na palavra }
procedure ganhou(musica:boolean);
var p:pointer;
    t:word;
    u:integer;
    ch:char;
begin
      executa_vitoria(musica);
      delay(900);
      limpa_parte(220,428,550,456,3);
      limpa_parte(30,130,600,400,3);
      limpa_parte(30,420,150,440,3);
      jan(100,120,getmaxx-100,getmaxy-80,1,1,15,2,p,t);
      settextstyle(1,0,5);
      escreve3(180,220,7,9,'PARABNS ! ! !');
      Enter_para_continuar;
      repeat ch:=premir until (ch=#32)or ((ratotec=1)or(ratotec=2));
      putImage(100,120,p^,normalPut);
      freeMem(p,t);
      mostra_tecla1;
      mostra_tecla2;
      mostra_tecla3
end;


{ Informa‡„o de derrota, logo n„o acertou na palavra }
procedure morreu(posicao:word;musica:boolean);
var p:pointer;
    t:word;
    u:integer;
    ch:char;
begin
       executa_funebre(musica);
       delay(700);
       limpa_parte(220,428,550,456,3);
       limpa_parte(30,130,600,400,3);
       limpa_parte(30,420,150,440,3);
       jan(100,120,getmaxx-100,getmaxy-80,1,1,15,2,p,t);
       settextstyle(1,0,3);
       escreve3(250,140,7,9,'LAMENTO ! ! !');
       settextstyle(1,0,1);
       escreve3(190,190,7,9,'MAS MORREU ENFORCADO ! ! !');
       escreve2(248,240,14,'A PALAVRA ERA:');
       settextstyle(0,0,1);
       u:=100+((((getmaxx-100)-100) div 2)-((length(tab.pala[posicao])*8) div 2));
       escreve2(u,280,15,tab.pala[posicao]);
       Enter_para_continuar;
       repeat ch:= premir until (ch =#32)or ((ratotec=1)or(ratotec=2));
       putImage(100,120,p^,normalPut);
       freeMem(p,t);
       mostra_tecla1;
       mostra_tecla2;
       mostra_tecla3
end;


{ Desenha boneco enforcado consuante o numero de erros }
procedure boneco_enforcado(erros:word);
begin
     if (erros in[1..4]) then setcolor(14);
     if (erros in[5..10]) then setcolor(9);
     case erros  of
      1: line(350,350,450,350);
      2: line(400,150,400,350);
      3: line(400,150,500,150);
      4: line(500,150,500,200);
      5: circle(500,215,15);
      6: line(500,230,500,270);
      7: line(480,235,500,235);
      8: line(500,235,520,235);
      9: line(500,270,480,300);
      10:line(500,270,520,300)
     end
end;

{ O procedimento jogar, tem todos os procedimentos necessarios para jogar,
 ‚ o "principal" em rela‡„o a op‡„o jogar }
procedure jogar(y,letra:string;posicao,erros,n,nn:word;falha:boolean);
var ch:char;
    e,r,u,int,int2:integer;
    numero,aux:string;
    p:pointer;
    t:word;
    verdade:boolean;
    dirinfo:searchrec;
    label 88,100,99,inicio;
begin
     jan2(10,10,getmaxx-10,getmaxx-170,12,12,3,4);
     mostra_enforcado;
     inicio:
     mostra_tecla1;
     mostra_tecla2;
     rato;
     repeat
           ch:=premir;
           ch:=upcase(ch);
           if ( ch ='T') or ( detecta(40,40,155,70)
           and  ((ratotec=1) or(ratotec=2)))
           then  begin
                      marca(40,40,155,70,true);
                      escrato;
                      99:
                      apaga_tecla1;
                      apaga_tecla2;
                      apaga_tecla3;
                      limpa_parte(248,93,400,120,3);
                      jan(150,100,490,450,9,9,4,2,p,t);
                      settextstyle(1,0,1);
                      escreve2(230,118,14,'TEMAS DISPONIVEIS');
                      settextstyle(0,0,1);
                      e:=0;
                      r:=0;
                      findfirst('*',archive,dirinfo);
                      while (doserror = 0) and (r<=maxex-1)  do
                      begin
                           e:=e+18;
                           r:=succ(r);
                           str(r,numero);
                           delay(20);
                           escreve2(240,140+e,15,numero);
                           escreve2(300,140+e,15,dirinfo.name);
                           nomes_temas[r]:=dirinfo.name;
                           findnext(dirinfo)
                      end;
                      Settextstyle(1,0,1);
                      escreve2(200,400,14,'TEMA: ');
                      Settextstyle(0,0,1);
                      efesp(200,430,10,9,4,'Prima < Enter > para terminar ','_');
                      aux:=lerl(270,410,8,4,15,8,'Û');
                      if(aux='')
                      then begin
                                 PutImage(150,100,p^,normalPut);
                                 FreeMem(p,t);
                                 apaga_tecla3;
                                 goto inicio
                            end;
                      val(aux,int,int2);
                      if(int>r) or (int<1) then y:=aux
                      else y:=nomes_temas[int];
                      PutImage(150,100,p^,normalPut);
                      FreeMem(p,t);
                      zero;
                      if (existe(y)) then carrega(y,falha,ch)
                                     else begin
                                                informacao_nao_existe;
                                                goto 99;
                                           end;
                      if (falha) then goto 99;
                      begin
                          Settextstyle(1,0,1);
                          escreve2(250,95,14,'TEMA: ');
                          escreve2(310,95,12,y);
                          100:
                          apaga_tecla1;
                          apaga_tecla2;
                          apaga_tecla3;
                          sorte(posicao,erros,n,nn);
                          repeat
                               executa(y,posicao,ERROS,n,nn);
                               u:=0;
                               repeat
                                     u:=u+1;
                                     if (  ex[u].let<>' ')
                                     then verdade:=true;
                                     if ( ex[u].let=' ')
                                     then begin verdade:=false;
                                                goto 88;
                                           end;
                               until(u=length(tab.pala[posicao])) ;
                               88:
                               boneco_enforcado(erros)
                          until (verdade) or (erros=10);
                          if (verdade) then ganhou(b);
                          if (erros=10)then morreu(posicao,b);
                          rato;
                          repeat
                                ch:=premir;
                                ch:=upcase(ch);
                          until (ch ='S') or detecta(486,40,601,70)
                          and ((ratotec=1)or(ratotec=2)) or (ch ='C') or
                          detecta(260,420,375,450) and ((ratotec=1)or(ratotec=2))
                          or (ch ='T') or detecta(40,40,155,70)and((ratotec=1) or(ratotec=2));

                          if (ch ='T') or  detecta(40,40,155,70)
                          and((ratotec=1) or(ratotec=2))
                          then begin
                                    marca(40,40,155,70,true);
                                    escrato;
                                    goto 99
                               end;
                          if (ch ='S') or detecta(486,40,601,70)
                          and ((ratotec=1)or(ratotec=2))
                          then begin
                                    marca(486,40,601,70,true);
                                    escrato;
                                    exit
                               end;
                          if (ch ='C') or detecta(260,420,375,450)
                          and  ((ratotec=1)or(ratotec=2))
                          then marca(260,420,375,450,true);
                          escrato;
                          goto 100
                      end
                 end
     until (ch ='S') or  (detecta(486,40,601,70)
    and  ((ratotec=1)or(ratotec=2)));
    escrato
end;


{ Mostra os temas existentes, e pede para o jogador(utilizador) escolher 
um tema este procedimento ‚ utelizado no INSERIR, APAGAR PALAVRAS e 
no APAGAR TEMAS}
procedure pergunta_tema(var y:string;insere,apaga:char;falha:boolean);
var e,int,int2,j:integer;
    dirinfo:searchrec;
    numero,aux:string;
    label inicio;
begin
     settextstyle(1,0,1);
     escreve2(70,70,10,'TEMAS  DISPONIVEIS');
     settextstyle(0,0,1);
     jan2(60,100,getmaxx-370,getmaxx-320,1,1,4,2);
     settextstyle(1,0,1);
     escreve2(310,100,14,'INTRODUZA O NOME OU N§ DO ');
     escreve2(340,140,10,'TEMA: ');
     escreve2(180,370,15,'Prima <');
     escreve2(270,370,14,'Enter');
     escreve2(295,370,15,'    > para terminar');
     settextstyle(0,0,1);
     inicio:
     limpa_parte(400,144,500,160,9);
     e:=0;
     j:=0;
     limpa_parte(109,113,getmaxx-375,getmaxx-330,4);
     findfirst('*',archive,dirinfo);
     while (doserror = 0) and (j<=maxex-1) do
      begin
           e:=e+14;
           j:=succ(j);
           str(j,numero);
           delay(20);
           escreve2(110,100+e,15,numero);
           escreve2(160,100+e,14,dirinfo.name);
           nomes_temas[j]:=dirinfo.name;
           findnext(dirinfo)
      end;
     if (j=14) then
     begin
          repeat
                limpa_parte(400,144,500,160,9);
                aux:=lerl(400,150,8,9,15,8,'Û');
                val(aux,int,int2)
          until (aux ='') or (int in[1..14]) or existe(aux)
     end
     else begin
              repeat
                    aux:=lerl(400,150,8,9,15,8,'Û');
              until(aux<>' ') and (aux<>'  ') and (aux<>'   ')
              and (aux<>'    ') and (aux<>'     ')  and (aux<>'      ')  and
              (aux<>'       ')  and (aux<>'        ');
              val(aux,int,int2)
          end;
     if(aux='')  then begin
                           y:='';
                           exit
                      end;
      if(int>j) or (int<1)
      then y:=aux
      else y:=nomes_temas[int];
      falha:=false;

      if (existe(y)) then carrega(y,falha,apaga);
      if not(existe(y)) and (insere<>'I') and not(falha)
       then begin
                 informacao_nao_existe;
                 goto inicio
            end;
      if (existe(y))and(falha) and (insere='T')  and (apaga='S')
       then begin  {Quando insere=T quer dizer que foi escolhida a op‡„o
                   Apagar Tema  sendo o ficheiro n„o compativel ou corrumpido
                   logo apaga=S quer dizer que o utelizador deu ordem para
                   remover o ficheiro corrumpido }
                 apaga_ficheiro;
                 zero;
                 goto inicio
            end;
      if (existe(y))and(insere='T') and not (falha)
       then begin  { Insere=T logo ‚ op‡„o Apagar Tema como este n„o
                    esta corrumpido ‚ logo apagado sem problema }
                 apaga_ficheiro;
                 zero;
                 goto inicio
            end;
      if (falha) then goto inicio
end;


{ Introdu‡„o de palavras num tema existente se este n„o estiver cheio
 ou ent„o introdu‡„o de palavras num novo tema se o n§ de temas for menor
  que o n§ maximo de temas que ‚ 14  }
procedure introducao( y:string;falha:boolean);
var ch:char;
label escolha_c;
begin
      if (y='') then exit;
      janela_do_titulo;
      titulo_inserir;
      titulo_geral;
      listar;
      escolha_c:
      if (y='') then exit;
      settextstyle(0,0,1);
      escreve2(378,210,14,'TEMA: ');
      escreve2(430,210,10,y);
      rato;
      repeat
            ch:=premir;
            ch:=upcase(ch);
            if (tab.na=max) then begin
                                       settextstyle(1,0,1);
                                       escreve2(350,380,10,'O TEMA EST† CHEIO');
                                       settextstyle(0,0,1);
                                       setcolor(14);
                                       efesp(130,450,10,9,3,'Prima Enter ou uma das teclas do rato para sair','_');
                                       repeat ch:=premir  until(ch=#13)
                                       or (ratotec=1)or(ratotec=2);
                                       escrato;
                                       exit
                                  end;
            if ( ch ='C') and (tab.na<max) or( detecta(405,145,520,175)
            and  ((ratotec=1)or(ratotec=2)))
            then begin
                      settextstyle(0,0,1);
                      escrato;
                      marca(405,145,520,175,true);
                      tab.na:=succ(tab.na);
                      limpa_parte(378,240,555,256,15);
                      repeat
                            tab.pala[tab.na]:=lerl (378,245,14,15,9,8,'Û')
                      until (tab.pala[tab.na]<>'') and (tab.pala[tab.na]<>' ')
                      and   (tab.pala[tab.na]<>'  ') and (tab.pala[tab.na]<>'   ')
                      and   (tab.pala[tab.na]<>'    ') and (tab.pala[tab.na]<>'     ')
                      and   (tab.pala[tab.na]<>'      ') and (tab.pala[tab.na]<>'       ')
                      and   (tab.pala[tab.na]<>'        ') and (tab.pala[tab.na]<>'         ')
                      and   (tab.pala[tab.na]<>'          ') and (tab.pala[tab.na]<>'           ')
                      and   (tab.pala[tab.na]<>'            ') and (tab.pala[tab.na]<>'             ')
                      and   (tab.pala[tab.na]<>'              ');
                      grava(y,falha);
                      if (falha) then begin
                                           tab.na:=pred(tab.na);
                                           goto escolha_c
                                       end;
                      listar;
                      rato
                  end
      until (ch ='S') or( detecta(405,280,520,310)
      and  ((ratotec=1)or(ratotec=2)));
      marca(405,280,520,310,true);
      escrato
end;




procedure apaga_tema( y:string;falha:boolean);
begin
      titulo_apagar_tema;
      pergunta_tema(st,ch,ch,falha);
      if (y='') then  exit

      {O jogador escolhe o tema, e o tema ‚ apagado}
end;

Procedure executa_apagar_palavras(var tab:tema;var i:integer);
var k :integer;
begin
    for k:=i to tab.na-1 do
      tab.pala[k]:=tab.pala[k+1];
    tab.na:=tab.na-1
      { Algoritmo para apagar palavras do array tab}
end;

procedure apagar_palavras(var y:string;falha:boolean);
var int,int2,px:integer;
    c:char;
    aux:string;
label escolha_c;

begin
      titulo_escolher_apagar;
      pergunta_tema(st,ch,ch,falha);
      if (y='') then  exit;
      janela_do_titulo;
      titulo_apagar;
      titulo_geral;
      listar;
      escolha_c:
      if (y='') then  exit;
      settextstyle(0,0,1);
      escreve2(378,210,14,'TEMA: ');
      escreve2(430,210,10,y);
      rato;
      repeat
            c:=premir;
            c:=upcase(c);
            if ( c ='C') or( detecta(405,145,520,175)
            and  ((ratotec=1)or(ratotec=2)))
            then begin
                      settextstyle(0,0,1);
                      escrato;
                      marca(405,145,520,175,true);
                      repeat
                            limpa_parte(378,240,550,256,15);
                            aux:=lerl (378,245,2,15,9,8,'Û');
                            val(aux,int,int2);
                      until (int>=1) and (int<=tab.na);
                      executa_apagar_palavras(tab,int);
                      if (tab.na=0) then begin
                                              apaga_ficheiro;
                                              exit
                                         end;
                      grava(y,falha);
                      if (falha) then begin
                                           carrega(y,falha,ch);
                                           goto escolha_c
                                       end;
                      listar;
                      rato
                  end
      until (c ='S') or (detecta(405,280,520,310)
      and ((ratotec=1) or (ratotec=2)));
      marca(405,280,520,310,true);
      escrato;
end;


{  o menu das op‡”es }
procedure janela_opcoes(var c:char);
var p:pointer;
    w:word;
    label escape;
begin
      jan(340,220,540,440,7,7,15,2,p,w);
      tecla(341,221,360,236,false);
      settextstyle(0,0,1);
      escreve2(346,226,15,'-');
      definir(340,220,530,420);
      tecla(380,260,500,280,false);
      escreve2(399,266,12,'M');
      escreve2(410,266,15,'usica');
      if (b) then begin
                      limpa_parte(459,264,490,276,7);
                      escreve2(460,266,14,'off')
                  end
             else if not(b) then begin
                                      limpa_parte(459,264,490,276,7);
                                      escreve2(460,266,14,'on')
                                 end;

      tecla(380,300,500,320,false);
      escreve2(412,306,12,'I');
      escreve2(423,306,15,'nserir');
      tecla(380,340,500,360,false);
      escreve2(400,346,12,'A');
      escreve2(411,346,15,'pagar Pal.');
      tecla(380,380,500,400,false);
      escreve2(391,386,15,'Apagar');
      escreve2(449,386,12,'T');
      escreve2(458,386,15,'emas');
      escape:
      rato;
      repeat
            c:=premir;
            c:=upcase(c);
            if (c='M') or (detecta(380,260,500,280) and
             ((ratotec=1)or(ratotec=2)))
            then begin
                      escrato;
                      marca(380,260,500,280,true);
                      som_on_off(b);
                      if (b) then begin
                                       limpa_parte(459,264,490,276,7);
                                       escreve2(460,266,14,'off')
                                  end
                             else if not(b)
                             then begin
                                       limpa_parte(459,264,490,276,7);
                                       escreve2(460,266,14,'on')
                                  end;
                      goto escape
                 end
      until(c=#27)or(detecta(341,221,360,236)and((ratotec=1)or(ratotec=2)))
      or (c='I')or(detecta(380,300,500,320))and((ratotec=1)or(ratotec=2))
      or (c='A')or(detecta(380,340,500,360))and((ratotec=1)or(ratotec=2))
      or (c='T')or(detecta(380,380,500,400))and((ratotec=1)or(ratotec=2)) ;

      if(c ='I')or(detecta(380,300,500,320))and((ratotec=1)or(ratotec=2))
      then begin
                 c:='I';
                 escrato;
                 marca(380,300,500,320,true);
                 putImage(340,220,p^,normalPut);
                 freeMem(p,w);
                 zero;
                 titulo_criar_optar;
                 pergunta_tema(st,c,ch,b);
                 introducao(st,b)
           end;
      if(c='A')or(detecta(380,340,500,360))and((ratotec=1)or(ratotec=2))
      then begin
                c:='A';
                escrato;
                marca(380,340,500,360,true);
                putImage(340,220,p^,normalPut);
                freeMem(p,w);
                zero;
                apagar_palavras(st,b)
           end;

      if(c='T')or(detecta(380,380,500,400))and((ratotec=1)or(ratotec=2))
      then begin
                 c:='T';
                 escrato;
                 marca(380,380,500,400,true);
                 putImage(340,220,p^,normalPut);
                 freeMem(p,w);
                 zero;
                 apaga_tema(st,b)
             end;

      if(c=#27)or(detecta(341,221,360,236)
      and((ratotec=1)or(ratotec=2)))
      then  begin
                 marca(341,221,360,236,true);
                 escrato;
                 putImage(340,220,p^,normalPut);
                 freeMem(p,w)
             end
end;


{ Menu principal }
procedure menu(var c:char);
label 99,inicio;
var mm,m:char;
    p:pointer;
    w:word;
begin
     99:
     cleardevice;
     jan2(0,0,getmaxx,getmaxx-160,9,9,3,6);
     settextstyle(1,0,8);
     escreve3(100,10,6,10,'ENFORCADO');
     settextstyle(1,0,2);
     escreve3(20,440,1,12,'(c)  1993 Por Nuno Freitas.');
     letras;
     inicio:
     rato;
     repeat
           definir(6,6,getmaxx-10,getmaxy-20);
           if (c='I') or (c='A') or (c='T') then mm:='O'
           else
           mm:=premir;
           mm:=upcase(mm);
           if ( mm ='J' ) or (detecta(110,170,250,210)
           and ((ratotec=1)or(ratotec=2)))
           then begin
                     zero;
                     marca(110,170,250,210,true);
                     escrato;
                     jogar(st,st,i,i,i,i,b);
                     goto 99
               end;

             if ( mm ='O') or (detecta(370,170,510,210)
             and ((ratotec=1)or(ratotec=2)))
             then begin
                       marca(370,170,510,210,true);
                       escrato;
                       janela_opcoes(c);
                       if(c='I') or (c='A') or (c='T') then goto 99;
                       rato
                end

    until (mm=#27 ) or (detecta(110,270,250,310)
    and ((ratotec=1)or(ratotec=2)));
    escrato;
    marca(110,270,250,310,true);
    jan(100,165,530,340,7,7,15,2,p,w);
    settextstyle(1,0,4);
    escreve2(240,178,12,'Esc / Dos');
    settextstyle(1,0,1);
    escreve2(240,240,15,'Tem a certeza ?');
    tecla(200,290,270,320,false);
    escreve2(216,294,12,'S');
    escreve2(227,294,15,'im');
    tecla(340,290,410,320,false);
    escreve2(358,294,12,'N');
    escreve2(374,292,15,'~');
    escreve2(372,294,15,'ao');
    definir(100,165,520,330);
    rato;
    repeat
           m:=premir;
           m:=upcase(m)
    until (m='S') or (detecta(200,290,270,320)) and ((ratotec=1)or(ratotec=2))
    or (m='N') or (detecta(340,290,410,320))and ((ratotec=1)or(ratotec=2));
    if (m='N') or (detecta(340,290,410,320)) and ((ratotec=1)or(ratotec=2))
    then begin
              escrato;
              putImage(100,165,p^,normalPut);
              freeMem(p,w); goto inicio
         end;
    escrato;
    putImage(100,165,p^,normalPut);
    freeMem(p,w)
end;


begin
    zero;
    ig(0,detect);
    inicrato;
    menu(ch);
    cleardevice;
    CloseGraph;
    textcolor(9);
    gotoxy(1,2);write('ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
    gotoxy(1,3);write('º (c) 1993 Por Nuno  Freitas. º');
    gotoxy(1,4);write('ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');
end.
