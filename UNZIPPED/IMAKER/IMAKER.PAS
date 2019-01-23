{ Este programa permite criar desenhos ate 64X43 pixels que poderam
  ser utilizados em programas para animar as op‡”es de trabalho (icons)
  , em jogos feitos pelo utilizador ou para fazer anima‡„o }

Program IMAKER;
Uses crt,graph,grf,dos;

Var csex,csey,cidx,cidy:integer;
    existe_desenho:boolean;

{ *** VERIFICA SE O SISTEMA TEM OS COMPONENTES NECESS†RIOS *** }

Function verresult:boolean;
Var r:integer;
Begin
     verresult:=true;
     {$I-}
     ig(VGA,VGAHI);
     r:=graphresult;
     {$I+}
     if (not verrato) and (r<>0) then verresult:=false
end;

{ *** VERIFICA A EXISTENCIA DE UMA FICHEIRO NA CORRENTE DIRECTORIA *** }

Function existe(s:string):boolean;
Begin
     existe:=false;
     if fsearch(s,getenv('PATH'))<>'' then existe:=true
end;

{ **************** SIMPLIFICA O PROCEDIMENTO 'STR' ************************** }
{ **************** CONVERTE NUMEROS EM CARACTERES  ************************** }

Function npl(i:longint):string;
Var aux:string;
Begin str(i,aux);npl:=aux end;

{ ************ EQUIVALENTE AO READKEY MAS NAO PROVOCA UMA PAUSA ************* }

Function premir:char;
Var c:char;
Begin if keypressed then c:=readkey else c:=#255;premir:=c end;

{ ********************** DESENHA O MENU PRINCIPAL ************************* }

Procedure cenario;
Var y:integer;
Begin
     y:=50;csex:=getmaxx-68;csey:=3;cidx:=getmaxx-5;cidy:=45;
     definir(0,0,getmaxx-3,getmaxy-3);
     jan2(0,0,getmaxx,49,15,8,7,2);
     jan2(getmaxx-70,1,getmaxx-3,47,8,8,0,1);
     jan2(140,5,160,45,15,8,15,2);
     tecla(5,25,60,45,false);tecla(70,25,125,45,false);
     tecla(170,5,250,20,false);tecla(260,5,340,20,false);
     tecla(350,5,440,20,false);tecla(450,5,530,20,false);
     tecla(170,30,210,45,false);
     escreve(5,10,10,'Regulador de cor');
     escreve(187,9,11,'Gravar');escreve(187,9,14,'G');
     escreve(270,9,11,'Carregar');escreve(270,9,14,'C');
     escreve(375,9,11,'Apagar');escreve(375,9,14,'A');
     escreve(475,9,12,'Sair');
     escreve(179,34,11,' PC');escreve(179,34,14,'O');
     escreve(220,35,12,'Nome do ficheiro : ');
     escreve(30,32,12,'+');escreve(95,32,12,'-');
     setcolor(11);
     repeat
      line(0,y,getmaxx,y);y:=y+10;
     until y>getmaxy;
     y:=10;
     Repeat
      line(y,50,y,getmaxy);y:=y+10;
     until y>getmaxx;
    rectangle(0,50,getmaxx,getmaxy)
end;

{ ------------------------ PROCEDIMENTOS DE USO GERAL ---------------------- }
{ ******************************* PAUSA ************************************ }

Procedure pausa;
Var tec:integer;
    c:char;
Begin
     while (c<>#255) do
      c:=premir;
     repeat
      tec:=ratotec;
      c:=premir;
     until (c<>#255) or (tec<>0);
     while (ratotec<>0) do ;
end;

{ *************************** INFORMADOR DE ERROS ************************** }

Procedure erro(i:integer);
Var p:pointer;
    t:word;
    c:char;
    mensagem:string;
    pyy:integer;
Begin
     case i of
      0:mensagem:='   !!! Erro na grava‡„o !!!';
      1:mensagem:='!!! Desenho n„o encontrado !!!';
      2:mensagem:='  !!! O ecran est  vazio !!!'
     end;
     jan(200,200,455,220,15,8,7,2,p,t);
     escreve(210,207,12,mensagem);pausa;
     setcolor(7);
     for pyy:=34 to 45 do
      line(370,pyy,480,pyy);
     putimage(200,200,p^,normalput);freemem(p,t)
end;

{* PINTA UM QUADRADO DE QUALQUER COR DEPOIS DE TER SIDO PINTADO A AZUL CLARO *}

Procedure pintar_azul_claro(x,y,cor:integer);
Var aux,mx,my:integer;
Begin
     mx:=4;my:=4;
     x:=round((5-(frac(x*0.1)*10)))+x;
     y:=round((5-(frac(y*0.1)*10)))+y;
     setcolor(cor);
     if y=475 then my:=3;
     if x=635 then mx:=3;
     for aux:=y-4 to y+my do
      line(x-4,aux,x+mx,aux)
end;

{ *** ANALISA PIXELS E TRANSFORMA-OS NUM QUADRADO PINTADO DE 10X10 PIXELS *** }

Procedure zoom(b,p:boolean);
Var pxx,pyy,xx,yy,
    axi,ayi,axf,ayf:integer;
Begin
     if b then
           begin
            axi:=getmaxx-68;
            ayi:=3;
            axf:=getmaxx-5;
            ayf:=45
           end
          else
           begin
            axi:=csex;
            ayi:=csey;
            axf:=cidx;
            ayf:=cidy
           end;
     pxx:=axi;pyy:=ayi;
     xx:=5+((axi-(getmaxx-68))*10);
     yy:=55+((ayi-3)*10);
     repeat
      if p then
            begin
             if getpixel(pxx,pyy)<>0 then
                                      pintar_azul_claro(xx,yy,getpixel(pxx,pyy))
            end
           else
            pintar_azul_claro(xx,yy,getpixel(pxx,pyy));
      pxx:=pxx+1;xx:=xx+10;
      if pxx>axf then
                   begin
                    pxx:=axi;inc(pyy);
                    xx:=5+((axi-(getmaxx-68))*10);
                    yy:=yy+10
                   end;
     until pyy>ayf
end;

{ *********************** APAGA A GRELHA DE DESENHO ************************* }

Procedure grelhador(c:integer);
Var x,y:integer;
Begin
     setcolor(c);y:=50;
     repeat
      line(0,y,getmaxx,y);y:=y+10;
     until y>getmaxy;
     y:=10;
     repeat
      line(y,50,y,getmaxy);y:=y+10;
     until y>getmaxx;
    rectangle(0,50,getmaxx,getmaxy);
    x:=5;y:=55;
    if c=0 then
            begin
             repeat
              if getpixel(x,y)<>0 then
                                   begin
                                    setcolor(getpixel(x,y));
                                    rectangle(x-5,y-5,x+5,y+5);
                                    rectangle(x-5,y-5,x+4,y+4)
                                   end;
              if x>getmaxx then begin x:=-5;y:=y+10 end;
              x:=x+10;
             until y>getmaxy;
            end;
end;

{ ************************ APAGA A AREA DE DESENHO ************************* }

Procedure apaga_area(f:boolean);
Begin
     if f then setviewport(0,50,getmaxx,getmaxy,Clipon)
          else setviewport((csex-(getmaxx-68))*10,
                            50+((csey-3)*10),
                           (10+((cidx-(getmaxx-68))*10))-1,
                           (60+((cidy-3)*10))-1,Clipon);
     clearviewport;
     setviewport(0,0,getmaxx,getmaxy,Clipon)
end;

{ ****************** VERIFICA A EXISTENCIA DE PIXELS *********************** }

Procedure verificador;
Var x,y:integer;
Begin
     x:=getmaxx-68;y:=3;
     repeat
      if getpixel(x,y)<>0 then existe_desenho:=true;
      inc(x);if x>getmaxx-5 then begin x:=getmaxx-68;inc(y) end;
     until (y>45) or (existe_desenho)
end;

{ **************** PERMITE DESENHAR NUMA MATRIZ DE 64 POR 43 *************** }

Procedure desenhar;

{ ********************** APAGA TODO O ECRAN DE DESENHO ********************* }

Procedure apagar;
Var pyy:integer;
Begin
     escrato;
     escreve(375,9,12,'Apagar');
     verificador;
     if existe_desenho then
                        begin
                         jan2(getmaxx-70,1,getmaxx-3,47,8,8,0,1);
                         apaga_area(true);grelhador(11);
                         setcolor(7);
                         for pyy:=34 to 45 do
                          line(370,pyy,480,pyy)
                        end;
     existe_desenho:=false;
     escreve(375,9,11,' pagar');escreve(375,9,14,'A');
     rato
end;

{ ******************** GRAVA UM DESENHO COM UM NOME PRETENDIDO ************** }

Procedure gravar;
var nome:string;
    x:integer;
    c:char;
    p:pointer;
    t:word;
Begin
     nome:='QUALQUER';c:='S';
     escrato;
     escreve(187,9,12,'Gravar');
     setcolor(7);
     for x:=34 to 45 do
      line(370,x,480,x);
     nome:=lerl(370,35,8,7,0,8,'_');
     if nome='' then
                 begin
                  nome:='QUALQUER';
                  outtextxy(370,35,nome)
                 end
                else
                 begin
                  for x:=1 to length(nome) do
                   if (nome[x]=' ') or (nome[x]='.') then nome[x]:='_'
                 end;
     outtextxy(445,35,'.IMG');
     if existe(nome+'.img') then
                             begin
                              jan(170,200,470,240,15,8,7,2,p,t);
                              escreve(210,207,12,'   Copiar por cima (S/N) ?');
                              escreve(180,219,12,'Teclas do Rato ( Esq = S , Dir = N )');
                              repeat
                               c:=upcase(premir);
                              until (c in ['S','N']) or (ratotec<>0);
                              putimage(170,200,p^,normalput)
                             end;
     if (c='S') or (ratotec=1) then
                                begin
                                 for x:=1 to length(nome) do
                                  if (nome[x]=' ') or (nome[x]='.') then nome[x]:='_';
                                 {$I-}
                                 gravarim(csex,csey,cidx,cidy,nome+'.img');
                                 {$I+}
                                 if ioresult<>0 then erro(0)
                                end
                               else
                                begin
                                 setcolor(7);
                                 for x:=34 to 45 do
                                  line(370,x,480,x)
                                end;
     escreve(187,9,11,' ravar');escreve(187,9,14,'G');
     rato
end;

{ *********************** CARREGA UM DESENHO JA FEITO *********************** }

Procedure carregar;

{ ************************ LISTA OS FICHEIROS DE IMAGEM ********************* }

Function listar:string;

{ ********** AVANCA COM A LISTAGEM SEMPRE QUE O UTILIZADOR DESEJE *********** }

Procedure avancar;

{ ********* MOSTRA O NOME DO FICHEIRO E A IMAGEM CORRESPONDENTE ************* }

Function mostrar(nome:string):boolean;
Var c:char;
    aux:integer;
Begin
     setcolor(7);
     outtextxy(257,142,'ÛÛÛÛÛÛÛÛÛÛÛÛ');
     setcolor(1);
     outtextxy(257,142,nome);
     imagem(270,90,nome);aux:=1;
     repeat
      if nome[aux]='.' then delete(nome,aux,(length(nome)-aux)+1);
      inc(aux);
     until aux>length(nome);
     definir(200,60,400,200);
     rato;
     repeat
      c:=upcase(premir);
     until (c in [#27,#13,'C','A','S']) or (ratotec<>0);
     escrato;
     definir(0,0,getmaxx-3,getmaxy-3);
     if (c in ['C',#13]) or
        ((ratotec<>0) and (detecta(340,160,390,190))) then
                                                       begin
                                                        marca(340,160,390,190,true);
                                                        listar:=nome;mostrar:=false
                                                       end
                                                      else
     if (c in ['S',#27]) or
        ((ratotec<>0) and (detecta(270,160,330,190))) then
                                                       begin
                                                        marca(270,160,330,190,true);
                                                        listar:=#255;mostrar:=false
                                                       end
                                                      else
     if (c='A') or
        ((ratotec<>0) and (detecta(210,160,260,190))) then
                                                       begin
                                                        marca(210,160,260,190,true);
                                                        listar:=#255;mostrar:=true
                                                       end;
end;

Var dir:searchrec;
    flag:boolean;
Begin
     findfirst('*.img',archive,dir);flag:=true;
     while (doserror=0) and (flag) do
      begin
       flag:=mostrar(dir.name);
       findnext(dir);
      end;
end;

Var mem:pointer;
    tam:word;
Begin
     Jan(200,60,400,200,15,8,7,1,mem,tam);
     Jan2(270,90,333,133,8,8,8,1);
     setcolor(1);
     rectangle(250,140,353,150);
     tecla(210,160,260,190,false);
     tecla(340,160,390,190,false);
     tecla(270,160,330,190,false);
     escreve(220,65,10,'Seleccao de ficheiro');
     escreve(220,170,12,'Avan');escreve(220,170,14,'A');
     escreve(350,170,12,'Carr');escreve(350,170,14,'C');
     escreve(285,170,12,'Sair');escreve(285,170,14,'S');
     avancar;putimage(200,60,mem^,normalput);freemem(mem,tam)
end;

var nome:string;
    x:integer;
Begin
     escrato;
     escreve(270,9,12,'Carregar');
     setcolor(7);
     for x:=34 to 45 do
      line(370,x,480,x);
     nome:=lerl(370,35,8,7,0,8,'_');
     outtextxy(445,35,'.IMG');
     for x:=1 to length(nome) do
      if (nome[x]=' ') or (nome[x]='.') then nome[x]:='_';
     if nome='*' then
                  begin
                   nome:=listar;
                   setcolor(7);outtextxy(370,35,'Û');
                   setcolor(8);outtextxy(370,35,nome)
                  end;
     if nome<>#255 then
                    begin
                     if existe(nome+'.img') then
                                             begin
                                              jan2(getmaxx-70,1,getmaxx-3,47,8,8,0,1);
                                              imagem(getmaxx-68,3,nome+'.img');
                                              apaga_area(true);grelhador(11);
                                              existe_desenho:=true;zoom(true,true)
                                             end
                                            else
                                             erro(1)
                    end;
     escreve(270,9,11,' arregar');escreve(270,9,14,'C');
     rato
end;

{ ******************** D† ACESSO A OUTRAS OPCOES *************************** }

Procedure opc;

Procedure dividir;
Var x,y,x2,y2,coorr:integer;
Begin
     if existe_desenho then
                        begin
                         apaga_area(true);
                         x:=getmaxx-68;y:=3;x2:=0;y2:=50;
                         repeat
                          coorr:=getpixel(x,y);
                          setcolor(coorr);

                          rectangle(x2,y2,x2+5,y2+5);
                          pintar(x2+1,y2+1,coorr,coorr);

                          rectangle(x2,(getmaxy-y2+50),x2+5,(getmaxy-y2+50)-4);
                          pintar(x2+1,(getmaxy-y2+50)-3,coorr,coorr);

                          rectangle(getmaxx-x2,y2,(getmaxx-x2)-5,y2+5);
                          pintar((getmaxx-x2)-1,y2+1,coorr,coorr);

                          rectangle(getmaxx-x2,(getmaxy-y2+50),(getmaxx-x2)-5,(getmaxy-y2+50)-4);
                          pintar((getmaxx-x2)-1,(getmaxy-y2+50)-3,coorr,coorr);

                          inc(x);x2:=x2+5;
                          if x>getmaxx-5 then begin
                                               x:=getmaxx-68;inc(y);
                                               x2:=0;y2:=y2+5
                                              end;
                         until y>=45;
                         pausa;apaga_area(true);grelhador(11);
                         zoom(true,true)
                        end
                       else
                         erro(2)
end;

Procedure grelha;

Begin
     if existe_desenho then
                        begin
                         grelhador(0);
                         pausa;
                         grelhador(11)
                        end
                       else
                         erro(2)
end;

Procedure inverter;
Var p:pointer;
    t:word;
Begin
     aim(csex,csey,cidx,cidy,p,t);
     putimage(csex,csey,p^,notput);freemem(p,t);zoom(false,false)
end;

Procedure encher;
Var x,y:integer;
    p:pointer;
    t:word;
Begin
     if existe_desenho then
                        begin
                         aim(getmaxx-68,3,getmaxx-5,45,p,t);
                         x:=0;y:=50;
                         repeat
                          putimage(x,y,p^,normalput);
                          x:=x+64;
                          if x>getmaxx then begin x:=0;y:=y+43 end;
                         until y>getmaxy;
                         pausa;
                         apaga_area(true);
                         freemem(p,t);grelhador(11);
                         zoom(true,true)
                        end
                       else
                         erro(2)
end;

Procedure zoomx;

{ *************************** AUMENTAR 20X20 ZOOM *************************** }

Procedure aumentar(px,py,pxl,pyl:integer);
Var xx,yy,x,y,aux,yyy:integer;
Begin
     x:=0;y:=50;xx:=px;yy:=py;
     repeat
      aux:=getpixel(xx,yy);
      if aux<>0 then
                 begin
                  setcolor(aux);
                  for yyy:=y to y+20 do
                   line(x,yyy,x+20,yyy);
                 end;
      xx:=xx+1;x:=x+20;
      if xx>pxl then
                 begin
                  xx:=px;yy:=yy+1;
                  x:=0;y:=y+20
                 end;
     until yy>pyl;
end;

Var p:pointer;
    t:word;
    x,y,xl,yl:integer;
    c:char;
Begin
     if existe_desenho then
                        begin
                         apaga_area(true);aumentar(getmaxx-68,3,getmaxx-36,24);
                         repeat
                         aim(getmaxx-68,3,getmaxx-5,45,p,t);Setcolor(lightgray);
                         line(getmaxx-37,3,getmaxx-37,45);
                         line(getmaxx-68,24,getmaxx-5,24);rato;
                         repeat
                           c:=upcase(premir);
                         until ((ratotec<>0) and
                          ((detecta(getmaxx-68,3,getmaxx-5,45)) or
                          (detecta(450,5,530,20)))) or (c=#27);
                          escrato;putimage(getmaxx-68,3,p^,normalput);freemem(p,t);
                          if (not detecta(450,5,530,20))
                          and (c<>#27) then
                                        begin
                                         if detecta(getmaxx-68,3,getmaxx-37,24) then
                                                                                 begin
                                                                                  x:=getmaxx-68;y:=3;
                                                                                  xl:=getmaxx-36;yl:=24;
                                                                                 end
                                                                                else
                                         if detecta(getmaxx-37,3,getmaxx-5,24) then
                                                                                begin
                                                                                 x:=getmaxx-36;y:=3;
                                                                                 xl:=getmaxx-5;yl:=24;
                                                                                end
                                                                               else
                                         if detecta(getmaxx-68,24,getmaxx-37,45) then
                                                                                  begin
                                                                                   x:=getmaxx-68;y:=24;
                                                                                   xl:=getmaxx-36;yl:=45
                                                                                  end
                                                                                 else
                                         if detecta(getmaxx-37,24,getmaxx-5,45) then
                                                                                 begin
                                                                                  x:=getmaxx-36;y:=24;
                                                                                  xl:=getmaxx-5;yl:=45
                                                                                 end;
                                         apaga_area(true);
                                         aumentar(x,y,xl,yl)
                                        end
                          until (detecta(450,5,530,20)) or (c=#27);
                         apaga_area(true);grelhador(11);zoom(true,true)
                        end
                       else
                         erro(2)
end;

Procedure diversos;

Procedure carrega_desenhos(var p:pointer;var t:word;var oper:boolean);
Var aux:pointer;
    tam:word;
    nome:string;
    x:integer;
Begin
     jan(200,190,425,215,15,8,7,2,aux,tam);oper:=true;
     escreve(205,195,12,'Nome do ficheiro : ');
     nome:=lerl(350,195,8,7,9,8,'_');
     if nome<>'' then
                  begin
                   for x:=1 to length(nome) do
                    if (nome[x]=' ') or (nome[x]='.') then nome[x]:='_';
                   if existe(nome+'.img') then
                                           begin
                                            freemem(p,t);
                                            jan2(getmaxx-70,1,getmaxx-3,47,8,8,0,1);
                                            imagem(getmaxx-68,3,nome+'.img');
                                            aim(getmaxx-68,3,getmaxx-5,45,p,t)
                                           end
                                          else
                                           begin
                                            erro(1);
                                            oper:=false
                                           end;
                  end;
     putimage(200,190,aux^,normalput);freemem(aux,tam)
end;

Var x,y,px,py,auxx,auxy:integer;
    p,mem:pointer;
    t,tam:word;
    oper:boolean;
Begin
     if existe_desenho then
                        begin
                         x:=0;apaga_area(true);
                         aim(getmaxx-68,3,getmaxx-5,45,mem,tam);
                         aim(getmaxx-68,3,getmaxx-5,45,p,t);
                         repeat
                          line(x,50,x,getmaxy);
                          x:=x+64;
                         until x>getmaxx;
                         x:=50;
                         repeat
                          line(0,x,getmaxx,x);
                          x:=x+43;
                         until x>getmaxy;
                         rectangle(0,50,getmaxx,getmaxy);
                         repeat
                         rato;
                         repeat
                          ratopos(x,y);
                         until (ratotec<>0);
                         escrato;
                         if (not detecta(450,5,530,20)) and
                         (detecta(0,50,getmaxx,getmaxy)) then
                                                          begin
                                                           px:=64*(x div 64);py:=43*(y div 43);
                                                           if ratotec=1 then
                                                                         begin
                                                                          putimage(getmaxx-68,3,p^,normalput);
                                                                          putimage(px,py+8,p^,normalput)
                                                                         end
                                                                        else
                                                           if ratotec=2 then
                                                                         begin
                                                                          carrega_desenhos(p,t,oper);
                                                                          if oper then
                                                                                   begin
                                                                                    putimage(getmaxx-68,3,p^,normalput);
                                                                                    putimage(px,py+8,p^,normalput)
                                                                                   end;
                                                                         end;
                                                           setcolor(12);
                                                           if px=576 then auxx:=63 else auxx:=64;
                                                           if py=430 then auxy:=49 else auxy:=50;
                                                           rectangle(px,py+7,px+auxx,py+auxy)
                                                          end;
                         until detecta(450,5,530,20);
                         pausa;
                         putimage(getmaxx-68,3,mem^,normalput);
                         freemem(mem,tam);freemem(p,t);
                         apaga_area(true);grelhador(11);zoom(true,true)
                        end
                        else
                          erro(2)
end;

{ ****************** CRIA A IMAGEM ACTUAL MAS INVERTIDA ******************** }

Procedure espelho;

{ **************** LIMPA A AREA DE TAMANHO REAL DO ECRAN ******************* }

Procedure limpeza;
Var aux:integer;
Begin
     setcolor(0);
     for aux:=csey to cidy do
      line(csex,aux,cidx,aux)
end;

Var px,py,x,y:integer;
Begin
     if existe_desenho then
                        begin
                         apaga_area(false);grelhador(11);
                         px:=cidx;py:=csey;
                         x:=5+((csex-(getmaxx-68))*10);
                         y:=55+((csey-3)*10);
                         repeat
                          if getpixel(px,py)<>0 then pintar_azul_claro(x,y,getpixel(px,py));
                          px:=px-1;x:=x+10;
                          if px<csex then
                                      begin
                                       px:=cidx;
                                       x:=5+((csex-(getmaxx-68))*10);
                                       py:=py+1;y:=y+10
                                      end;
                         until py>cidy;
                         limpeza;
                         px:=csex;py:=csey;
                         x:=5+((csex-(getmaxx-68))*10);
                         y:=55+((csey-3)*10);
                         repeat
                          if getpixel(x,y)<>0 then putpixel(px,py,getpixel(x,y));
                          px:=px+1;x:=x+10;
                          if px>cidx then
                                      begin
                                       px:=csex;
                                       x:=5+((csex-(getmaxx-68))*10);
                                       py:=py+1;y:=y+10
                                      end;
                         until py>cidy;
                        end
                       else
                         erro(2)
end;

{ ************** SUBSITUI UMA COR POR UMA OUTRA DEFENIDA ****************** }

Procedure substituir;

Procedure substituicao(coras,corsub:integer);
Var x,y,px,py:integer;
    nada_a_sub:boolean;
    p:pointer;
    t:word;
    c:char;
Begin
     px:=csex;py:=csey;
     x:=5+((csex-(getmaxx-68))*10);
     y:=55+((csey-3)*10);nada_a_sub:=false;
     Repeat
      if getpixel(px,py)=coras then
                                begin
                                 putpixel(px,py,corsub);
                                 pintar_azul_claro(x,y,corsub);
                                 nada_a_sub:=true
                                end;
      inc(px);x:=x+10;
      if px>cidx then
                  begin
                   px:=csex;inc(py);
                   x:=5+((csex-(getmaxx-68))*10);
                   y:=y+10
                  end;
     until py>cidy;
     if not nada_a_sub then
                        begin
                         jan(200,100,470,120,15,8,7,2,p,t);
                         escreve(210,105,11,'N„o existe nada para substituir');
                         pausa;
                         putimage(200,100,p^,normalput);freemem(p,t)
                        end;
end;

Var coras,corsub:integer;
    p:pointer;
    t:word;
    sai,c:char;
Begin
     coras:=15;corsub:=15;sai:=' ';
     jan(200,100,435,200,15,8,7,2,p,t);
     escreve(210,110,10,'     Cor');
     escreve(210,120,10,'a Substituir');
     jan2(250,140,270,160,15,8,coras,2);
     escreve(340,110,11,'    Cor');
     escreve(340,120,11,'Substituta');
     jan2(370,140,390,160,15,8,corsub,2);

     tecla(205,170,261,190,false);
     tecla(261,170,317,190,false);

     tecla(327,170,378,190,false);
     tecla(378,170,430,190,false);

     tecla(312,120,332,140,false);
     tecla(312,140,332,160,false);

     escreve(230,175,11,'+      -');
     escreve(347,175,11,'+      -');
     escreve(315,145,12,'OK');
     escreve(318,125,12,'S');
     definir(200,100,435,200);
     rato;
     repeat
     repeat
      c:=upcase(premir);
      case c of
       'Q':inc(coras);
       'A':dec(coras);
       'W':inc(corsub);
       'S':dec(corsub);
       #13:sai:='O';
       #27:sai:='E'
      end;

      if coras>15 then coras:=0 else
      if coras<0 then coras:=15;
      if corsub>15 then corsub:=0 else
      if corsub<0 then corsub:=15;

      if c in ['Q','A','W','S'] then
                                 begin
                                  escrato;
                                  jan2(250,140,270,160,15,8,coras,2);
                                  jan2(370,140,390,160,15,8,corsub,2);
                                  rato
                                 end;

     until (ratotec<>0) or (sai<>' ');
     if sai=' ' then
                 begin
                  if detecta(205,170,261,190) then
                                               begin
                                                marca(205,170,261,190,true);
                                                inc(coras)
                                               end
                                              else
                  if detecta(261,170,317,190) then
                                               begin
                                                marca(261,170,317,190,true);
                                                dec(coras)
                                               end
                                              else
                  if detecta(327,170,378,190) then
                                               begin
                                                marca(327,170,378,190,true);
                                                inc(corsub)
                                               end
                                              else
                  if detecta(378,170,430,190) then
                                               begin
                                                marca(378,170,430,190,true);
                                                dec(corsub)
                                               end
                                              else
                  if detecta(312,120,332,140) then
                                               begin
                                                marca(312,120,332,140,true);
                                                sai:='E'
                                               end
                                              else
                  if detecta(312,140,332,160) then
                                               begin
                                                marca(312,140,332,160,true);
                                                sai:='O'
                                               end;
                 end;

     if coras>15 then coras:=0 else
     if coras<0 then coras:=15;
     if corsub>15 then corsub:=0 else
     if corsub<0 then corsub:=15;

     escrato;
     jan2(250,140,270,160,15,8,coras,2);
     jan2(370,140,390,160,15,8,corsub,2);
     rato;

     until sai<>' ';
     escrato;putimage(200,100,p^,normalput);freemem(p,t);
     definir(0,0,getmaxx-3,getmaxy-3);

     if sai='O' then substituicao(coras,corsub)
end;

{ ************************ TAMANHO DE GRAVA€ŽO ***************************** }

Procedure tamanho;

{ ********************** INDICA OS MAXIMOS DE GRAVA€ŽO ******************** }

Procedure indica_pixels(var p:pointer;var t:word;memx,memy:integer);
Var aux,x,y:integer;
Begin
     x:=(cidx-csex);y:=(cidy-csey);
     setcolor(7);
     for aux:=128 to 140 do
      begin
       line(370,aux,400,aux);
       line(360,aux+20,390,aux+20)
      end;
     escreve(377,130,12,npl(x));
     escreve(362,150,10,npl(y));
     putimage(memx,memy,p^,normalput);freemem(p,t);
     aim(csex,csey,cidx,cidy,p,t);
     rectangle(csex,csey,cidx,cidy)
end;

Var p,p2:pointer;
    t,t2:word;
    c:char;
    sai:boolean;
    memx,memy:integer;
Begin
     jan(200,100,435,280,15,8,7,2,p,t);
     aim(csex,csey,cidx,cidy,p2,t2);
     setcolor(10);rectangle(csex,csey,cidx,cidy);
     escreve(230,105,11,'Dimens”es de grava‡„o');
     escreve(210,130,12,'PIXELS HORIZONTAIS - '+npl(cidx-csex));
     escreve(210,150,10,'PIXELS VERTICAIS - '+npl(cidy-csey));

     tecla(210,190,240,210,false);tecla(250,190,280,210,false);
     tecla(300,190,330,210,false);tecla(340,190,370,210,false);

     tecla(210,240,240,260,false);tecla(250,240,280,260,false);
     tecla(300,240,330,260,false);tecla(340,240,370,260,false);

     tecla(400,190,430,210,false);
     escreve(222,195,12,'+');escreve(262,195,12,'-');
     escreve(312,195,10,'+');escreve(352,195,10,'-');

     escreve(222,245,12,'+');escreve(262,245,12,'-');
     escreve(312,245,10,'+');escreve(352,245,10,'-');

     escreve(210,175,9,'Canto Superior Direito');
     escreve(210,225,9,'Canto Inferior Esquerdo');

     escreve(405,195,12,'Sai');
     definir(200,100,435,280);
     rato;
     repeat
     repeat
      c:=upcase(premir);
      memx:=csex;memy:=csey;
      case c of
       #72:begin dec(cidy);if cidy<csey then cidy:=csey end;
       #80:begin inc(cidy);if cidy>45 then cidy:=45 end;
       #75:begin dec(cidx);if cidx<csex then cidx:=csex end;
       #77:begin inc(cidx);if cidx>getmaxx-5 then cidx:=getmaxx-5 end;
       '8':begin dec(csey);if csey<3 then csey:=3 end;
       '2':begin inc(csey);if csey>cidy then csey:=cidy end;
       '4':begin dec(csex);if csex<getmaxx-68 then csex:=getmaxx-68 end;
       '6':begin inc(csex);if csex>cidx then csex:=cidx end
      end;
     if c in [#72,#80,#75,#77,'8','2','4','6'] then indica_pixels(p2,t2,memx,memy);
     until (ratotec<>0) or (c=#27);
     if c<>#27 then
                begin
                 if detecta(210,190,240,210) then
                                              begin
                                               marca(210,190,240,210,true);
                                               inc(cidx);if cidx>getmaxx-5 then cidx:=getmaxx-5
                                              end
                                             else
                 if detecta(250,190,280,210) then
                                              begin
                                               marca(250,190,280,210,true);
                                               dec(cidx);if cidx<csex then cidx:=csex
                                              end
                                             else
                 if detecta(300,190,330,210) then
                                              begin
                                               marca(300,190,330,210,true);
                                               inc(cidy);if cidy>45 then cidy:=45
                                              end
                                             else
                 if detecta(340,190,370,210) then
                                              begin
                                               marca(340,190,370,210,true);
                                               dec(cidy);if cidy<csey then cidy:=csey
                                              end
                                             else
                 if detecta(210,240,240,260) then
                                              begin
                                               marca(210,240,240,260,true);
                                               inc(csex);if csex>cidx then csex:=cidx
                                              end
                                             else
                 if detecta(250,240,280,260) then
                                              begin
                                               marca(250,240,280,260,true);
                                               dec(csex);if csex<getmaxx-68 then csex:=getmaxx-68
                                              end
                                             else
                 if detecta(300,240,330,260) then
                                              begin
                                               marca(300,240,330,260,true);
                                               inc(csey);if csey>cidy then csey:=cidy
                                              end
                                             else
                 if detecta(340,240,370,260) then
                                              begin
                                               marca(340,240,370,260,true);
                                               dec(csey);if csey<3 then csey:=3
                                              end;
                 indica_pixels(p2,t2,memx,memy)
                end;
     until (detecta(400,190,430,210)) or (c=#27);
     escrato;marca(400,190,430,210,true);
     definir(0,0,getmaxx-3,getmaxy-3);
     putimage(200,100,p^,normalput);freemem(p,t);
     putimage(csex,csey,p2^,normalput);freemem(p2,t2)
end;

Var p:pointer;
    t:word;
    c:char;
    op:integer;
Begin
     escrato;c:=' ';op:=0;verificador;
     escreve(179,34,12,'OPC');
     jan(10,60,120,220,15,8,7,2,p,t);
     escreve(33,70,11,' ividir');escreve(33,70,14,'D');
     escreve(33,85,11,' relha');escreve(33,85,14,'G');
     escreve(33,100,11,' nverter');escreve(33,100,14,'I');
     escreve(33,115,11,'Enche');escreve(33,115,14,'     R');
     escreve(33,130,11,' OOM x 4');escreve(33,130,14,'Z');
     escreve(33,145,11,'Di ersos');escreve(33,145,14,'  V');
     escreve(33,160,11,' spelho');escreve(33,160,14,'E');
     escreve(33,175,11,' ubstituir');escreve(33,175,14,'S');
     escreve(33,190,11,' amanho');escreve(33,190,14,'T');
     escreve(33,205,12,'  Sai');
     definir(10,60,120,220);
     rato;
     repeat
     repeat
      c:=upcase(premir);
     until (ratotec=1) or (c in ['D','G','I','R','Z','V','E','S','T',#27]);
     if detecta(32,69,104,81) then op:=1
                              else
     if detecta(32,84,94,96) then op:=2
                             else
     if detecta(32,99,114,111) then op:=3
                               else
     if detecta(32,114,94,126) then op:=4
                               else
     if detecta(32,129,114,141) then op:=5
                                else
     if detecta(32,144,109,156) then op:=6
                                else
     if detecta(32,159,88,171) then op:=7
                               else
     if detecta(32,174,133,186) then op:=8
                                else
     if detecta(32,189,109,201) then op:=9
                               else
     if detecta(32,205,84,217) then op:=10;
     case c of
      'D':op:=1;
      'G':op:=2;
      'I':op:=3;
      'R':op:=4;
      'Z':op:=5;
      'V':op:=6;
      'E':op:=7;
      'S':op:=8;
      'T':op:=9;
      #27:op:=10
     end;
     until op in [1,2,3,4,5,6,7,8,9,10];
     escrato;
     definir(0,0,getmaxx-3,getmaxy-3);
     putimage(10,60,p^,normalput);freemem(p,t);
     case op of
      1:dividir;
      2:grelha;
      3:inverter;
      4:encher;
      5:zoomx;
      6:diversos;
      7:espelho;
      8:substituir;
      9:tamanho;
      10:while (ratotec<>0) do
     end;
     escreve(179,34,11,' PC');escreve(179,34,14,'O');rato
end;

Var x,y,px,py,cor,mem:integer;
    sair:boolean;
    c:char;
Begin
     sair:=false;cor:=15;existe_desenho:=false;
     px:=141;py:=6;rato;
     repeat
     repeat
      ratopos(x,y);
      c:=upcase(premir);
      if ratotec=2 then
                    begin
                     while ratotec=2 do begin end;
                     if cor<>0 then begin mem:=cor;cor:=0 end
                               else cor:=mem;
                     escrato;jan2(140,5,160,45,15,8,cor,2);rato
                    end;
      case c of
       '+':begin
            escrato;inc(cor);
            if cor>15 then cor:=0;
            jan2(140,5,160,45,15,8,cor,2);rato
           end;
       '-':begin
            escrato;dec(cor);
            if cor<0 then cor:=15;
            jan2(140,5,160,45,15,8,cor,2);rato
           end;
       'G':gravar;
       'C':carregar;
       'O':opc;
       'A':apagar;
       'I':begin
            if cor<>0 then begin mem:=cor;cor:=0 end
                      else cor:=mem;
            escrato;jan2(140,5,160,45,15,8,cor,2);rato
           end;
       #27:sair:=true
      end;
     until (ratotec=1) or (c=#27);
     if (ratotec=1) then
                     begin
                        if y>50 then
                               begin
                                escrato;
                                pintar_azul_claro(x,y,cor);
                                px:=round((10-(frac(x*0.1)*10)))+x;
                                py:=round((10-(frac(y*0.1)*10)))+y;
                                px:=px div 10;py:=py div 10;
                                putpixel((getmaxx-69)+px,py-3,cor);
                                rato;
                               end
                              else
                        if detecta(5,25,60,45) then
                                                begin
                                                 marca(5,25,60,45,true);
                                                 inc(cor);
                                                 if cor>15 then cor:=0;
                                                 escrato;
                                                 jan2(140,5,160,45,15,8,cor,2);
                                                 rato
                                                end
                                               else
                        if detecta(70,25,125,45) then
                                                  begin
                                                   marca(70,25,125,45,true);
                                                   dec(cor);
                                                   if cor<0 then cor:=15;
                                                   escrato;
                                                   jan2(140,5,160,45,15,8,cor,2);
                                                   rato
                                                  end;
                        if detecta(170,5,250,20) then
                                                  begin
                                                   marca(170,5,250,20,true);
                                                   gravar
                                                  end
                                                 else
                        if detecta(260,5,340,20) then
                                                  begin
                                                   marca(260,5,340,20,true);
                                                   carregar
                                                  end
                                                 else
                        if detecta(350,5,440,20) then
                                                  begin
                                                   marca(350,5,440,20,true);
                                                   apagar
                                                  end
                                                 else
                        if detecta(170,30,210,45) then
                                                   begin
                                                    marca(170,30,210,45,true);
                                                    opc
                                                   end
                                                  else
                        if detecta(450,5,530,20) then
                                                  begin
                                                   marca(450,5,530,20,true);
                                                   sair:=true
                                                  end;
                     end;
     until sair;
     closegraph;
     writeln('IMAKER - Vers„o 1.0');
     writeln('1992 (c) Luis Bruno Software (LBS)')
end;

{ ***************----------- CORPO DO PROGRAMA -------------**************** }

Begin
     if verresult then
                   begin
                    Inicrato;
                    checkbreak:=false;
                    cenario;
                    desenhar
                   end
                  else
                    writeln(#13,#13,'Erro --- ",#7," Este programa necessita de rato e placa VGA ',#13,#13)
end.