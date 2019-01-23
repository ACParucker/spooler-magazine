Program Calendarios;

uses crt,ecran,printer;

type cal=record
               verso:string[45];
               empresa:string[30];
               ano:word;
               estado:byte;
               copias:string[2];
               activo:boolean;{apagado ou activo}
         end;{estrutura de dados para cada calend rio}

     ndx=record
               ano:longint;
               pos:longint;
               repete:boolean;
         end;

     rep=record
               pos:array[1..20] of longint;
               outro:longint;
         end;

     bd=array[1..500] of ndx;

     fndx=file of ndx;


var arquivo,temp:file of cal;
    index:fndx;
    repete:file of rep;
    cals:bd;

Procedure shellsort(var lista:bd;count:word);
var gap,ndx1,ndx2,ndx3:word;
    troca:ndx;

begin
     gap:=count div 2;

     while(gap>0) do
     begin
     for ndx1:=(gap+1) to count do
     begin
          ndx2:=ndx1-gap;
          while(ndx2>0) do
          begin
               ndx3:=ndx2+gap;
               if (lista[ndx2].ano<=lista[ndx3].ano) then
                  ndx2:=0
               else
               begin
                    troca:=lista[ndx2];
                    lista[ndx2]:=lista[ndx3];
                    lista[ndx3]:=troca;
                    ndx2:=ndx2-gap;
               end;
          end;
     end;
     gap:=gap div 2;
     end;

end;{shellsort adaptado}


function binario(elemento:word; var lista:fndx):integer;
var meio,inicio,fim:integer;
    n:ndx;
begin
     binario:=-1;
     inicio:=0;
     fim:=filesize(lista);
     repeat
           meio:=(inicio+fim) div 2;
           seek(lista,meio);
           read(lista,n);
           if elemento>n.ano then
              inicio:=meio
           else
           if elemento<n.ano then
              fim:=meio;
     until (elemento=n.ano) or (inicio=meio) or ((fim-inicio)<=0);
     if elemento=n.ano then binario:=meio;
end;{posicao do elemento procurado}



Procedure screen(s:string);
begin
     textbackground(1);
     clrscr;
     limpa_scr(1,1,1,80,16*7,false);
     limpa_scr(25,1,1,80,16*7,false);
     textbackground(7);
     textcolor(red);
     gotoxy(40-(length(s) div 2),1);
     write(s);
end;


Function menu:byte;
var ch:char;
    ex:boolean;
    bot:byte;
begin
     screen('CALENDAR');
     bot:=1;
     repeat
           botao(25,5,'         Criar Registo         ');
           botao(25,8,'       Modificar Registo       ');
           botao(25,11,'       Eliminar Registo        ');
           botao(25,14,'        Listar Registos        ');
           botao(25,17,'       Outras Opera‡”es        ');
           botao(25,20,'             Sair              ');
           case bot of 1: default(25,5,'         Criar Registo         ',
                          'Acrescenta um novo calend rio … base de dados' );
                       2: default(25,8,'       Modificar Registo       ',
                          'Permite modificar um calend rio j  existente');
                       3: default(25,11,'       Eliminar Registo        ',
                          'Elimina um calend rio da base de dados');
                       4: default(25,14,'        Listar Registos        ',
                          'Lista para o ecran ou impressora');
                       5: default(25,17,'       Outras Opera‡”es        ',
                          'Update, Restaurar ou Reindexar');
                       6: default(25,20,'             Sair              ',
                          'Sai do CALENDAR');
           end;
           leop(ch,ex);
           if ex then
           case ch of #72,#75:if bot>1 then bot:=bot-1;
                      #80,#77:if bot<6 then bot:=bot+1;
           end;
     until not(ex) and (ch=#13);
     menu:=bot;
end;{menu principal}

Procedure Erro(mes:string);
begin
     textattr:=16*red+yellow;
     janela(10,10,70,15,2);
     textcolor(yellow+blink);
     gotoxy(37,10);
     write(' ERRO ');
     textcolor(yellow);
     gotoxy(40-(length(mes) div 2),12);
     write(mes);
     gotoxy(22,14);
     textcolor(15);
     write('Pressione qualquer tecla para voltar');
     desligacur;
     while keypressed do readkey;{limpa o buffer do teclado}
     repeat until keypressed;
     readkey;
end;{janela de erro}

Procedure ficha(inicio:cal;p:word);

var x:byte;
    ano:string[4];

begin
     screen('CALENDAR');
     textcolor(0);
     textbackground(7);
     janela(10,5,70,21,2);
     gotoxy(12,13);
     write('Estado   :   ( )Lixo        ( )Bom');
     gotoxy(25,14);
     write('( )Mau         ( )mUito bom');
     gotoxy(25,15);
     write('( )Razo vel    ( )Excelente');
     x:=inicio.estado;
     case x of 1:gotoxy(26,13);
               2:gotoxy(26,14);
               3:gotoxy(26,15);
               4:gotoxy(41,13);
               5:gotoxy(41,14);
               6:gotoxy(41,15);
     end;
     write('þ');
     gotoxy(12,7);
     write('Verso    : ');
     gotoxy(12,9);
     write('Empresa  : ');
     gotoxy(12,11);
     write('Ano      : ');
     gotoxy(12,17);
     write('C¢pias   :');
     textattr:=7;
     gotoxy(23,7);
     write(inicio.verso,' ':46-(length(inicio.verso)));
     gotoxy(23,9);
     write(inicio.empresa,' ':31-(length(inicio.empresa)));
     gotoxy(23,11);
     str(inicio.ano,ano);
     if ano<>'0' then write(inicio.ano,' ':5-(length(ano)))
     else write(' ':5);
     gotoxy(23,17);
     write(inicio.copias,' ':3-(length(inicio.copias)));
     textattr:=16*7;
     gotoxy(52,20);
     write('Registo n§: ',p);
end;{desenha a ficha}

Function estado(inicio:byte):byte;
var op:byte;
    tec:char;
    ex:boolean;
begin
     textcolor(0);
     textbackground(7);
     op:=inicio;
     repeat
           gotoxy(12,13);
           write('Estado   :   ( )Lixo        ( )Bom');
           gotoxy(25,14);
           write('( )Mau         ( )mUito bom');
           gotoxy(25,15);
           write('( )Razo vel    ( )Excelente');
           case op of 1:gotoxy(26,13);
                      2:gotoxy(26,14);
                      3:gotoxy(26,15);
                      4:gotoxy(41,13);
                      5:gotoxy(41,14);
                      6:gotoxy(41,15);
           end;
           write('þ');
           leop(tec,ex);
           if ex then
           case tec of #72:if op>1 then op:=op-1;
                       #75:if op>3 then op:=op-3;
                       #80:if op<6 then op:=op+1;
                       #77:if op<4 then op:=op+3;
           end
           else
           case upcase(tec) of 'L':op:=1;
                               'M':op:=2;
                               'R':op:=3;
                               'B':op:=4;
                               'U':op:=5;
                               'E':op:=6;
           end;
     until not(ex) and (tec=#13);
     estado:=op;
end;{seleccionar o estado do calendario}


Procedure reindex;
var cld:cal;{lido de 'arquivo'}
    pos:word;
    base:bd;{quantidade de calendarios}
    ano,c,d,p:word;
    r:rep;{registo de repeti‡”es}
    n:ndx;{registo de index}

Begin
     rewrite(index);
     rewrite(repete);
     reset(arquivo);
     close(repete);

     for pos:=1 to 500 do base[pos].ano:=-1;

     pos:=1;
     while not(eof(arquivo)) do
     begin
          read(arquivo,cld);
          base[pos].ano:=cld.ano;
          base[pos].pos:=pos-1;
          inc(pos);
     end;
     dec(pos);

     shellsort(base,pos);

     c:=1;
     repeat
           ano:=base[c].ano;{ano corrente}
           d:=c;

           repeat
                 inc(c);
           until (base[c].ano<>ano) or (c=20);{quantos tˆm o mesmo ano}
           dec(c);

           if c>d then{se mais que um}
           begin
                n.ano:=ano;
                reset(repete);
                n.pos:=filesize(repete);
                close(repete);
                n.repete:=true;
           end
           else{sen„o}
           begin
                n.ano:=ano;
                n.pos:=base[c].pos;
                n.repete:=false;
           end;

           write(index,n);{escreve no ficheiro de index}

           if c>d then{se existem repeti‡”es}
           begin
                for p:=1 to 20 do r.pos[p]:=-1;{inicializa o array}
                r.outro:=-1;{outro n„o existe}
                for p:=d to c do r.pos[p-d+1]:=base[p].pos;{repeti‡”es que existem}
                reset(repete);
                seek(repete,filesize(repete));
                if base[c+1].ano=ano then r.outro:=filesize(repete)+1;{se existe outro}
                write(repete,r);{escreve no fich. de repeti‡”es}
                close(repete);
           end;
           inc(c);{pr¢ximo calend rio}
     until c>pos;
     close(index);
     close(arquivo);
end;


Procedure acrescenta;
var sai:char;
    inicio:cal;
    c:integer;
    ano:string[4];

begin
     inicio.verso:='';
     inicio.empresa:='';
     inicio.ano:=0;
     ano:='';
     inicio.estado:=1;
     inicio.copias:='';
     reset(arquivo);
     ficha(inicio,filesize(arquivo));
     if (filesize(arquivo)>=500) then
     begin
          erro('N„o pode exceder os 500 calend rios');
          exit;
     end;
     close(arquivo);
     repeat
           inicio.verso:=ler(23,7,45,7,0,[#32..#255],false,inicio.verso,0);
           inicio.empresa:=ler(23,9,30,7,0,[#32..#255],false,inicio.empresa,0);
           str(inicio.ano,ano);
           repeat
           if ano<>'0' then ano:=ler(23,11,4,7,0,['0'..'9'],false,ano,0)
           else ano:=ler(23,11,4,7,0,['0'..'9'],false,'',0);
           val(ano,inicio.ano,c);
           if inicio.ano=0 then
           begin
                erro('Este campo tem de ser introduzido e diferente de 0');
                reset(arquivo);
                ficha(inicio,filesize(arquivo));
                close(arquivo);
           end;
           until inicio.ano<>0;
           desligacur;
           inicio.estado:=estado(inicio.estado);
           inicio.copias:=ler(23,17,2,7,0,['0'..'9'],false,inicio.copias,0);
           textattr:=16*7+red;
           desligacur;
           gotoxy(19,19);
           write('(G)uardar   /   (M)odificar   /   (C)ancelar');
           repeat sai:=upcase(readkey); until sai in ['G','M','C'];
           gotoxy(19,19);
           textattr:=16*7;
           write(' ':45);
     until sai in ['G','C'];
     if sai='G' then begin
                           {$I-}
                           reset(arquivo);
                           seek(arquivo,filesize(arquivo));
                           inicio.activo:=true;
                           write(arquivo,inicio);
                           close(arquivo);
                           {$I+}
                           if ioresult<>0 then erro('Ocorreu um erro de escrita');
                      end;
end;

Procedure Modifica;
var exit:char;
    pos_str:string[5];
    pos:word;
    c:integer;
    inicio:cal;
    ano:string[4];
begin
     screen('CALENDAR');
     textattr:=16*7;
     janela(20,10,60,15,2);
     gotoxy(22,12);
     write('Qual o n§ do registo a modificar?: ');
     pos_str:=ler(37,13,5,7,0,['0'..'9'],false,'',0);
     val(pos_str,pos,c);
     {$I-}
     reset(arquivo);
     seek(arquivo,pos);
     read(arquivo,inicio);
     close(arquivo);
     {$I+}
     if ioresult<>0 then
        erro('O registo n„o existe ou ocorreu um erro lendo do disco!')
     else
     begin
          if not(inicio.activo) then erro('Este registo est  marcado para apagar.')
          else
          begin
          ficha(inicio,pos);
          repeat
                inicio.verso:=ler(23,7,45,7,0,[#32..#255],false,inicio.verso,0);
                inicio.empresa:=ler(23,9,30,7,0,[#32..#255],false,inicio.empresa,0);
                str(inicio.ano,ano);
                repeat
                ano:=ler(23,11,4,7,0,['0'..'9'],false,ano,0);
                val(ano,inicio.ano,c);
                if (inicio.ano=0) then
                begin
                     erro('Este campo tem de ser introduzido e diferente de 0');
                     reset(arquivo);
                     ficha(inicio,filesize(arquivo));
                     close(arquivo);
                end;
                until inicio.ano<>0;
                desligacur;
                estado(inicio.estado);
                inicio.copias:=ler(23,17,2,7,0,['0'..'9'],false,inicio.copias,0);
                textattr:=16*7+red;
                desligacur;
                gotoxy(19,19);
                write('(G)uardar   /   (M)odificar   /   (C)ancelar');
                repeat exit:=upcase(readkey); until exit in ['G','M','C'];
                gotoxy(19,19);
                write(' ':45);
          until exit in ['G','C'];
          if exit='G' then
          begin
               {$I-}
               reset(arquivo);
               seek(arquivo,pos);
               write(arquivo,inicio);
               close(arquivo);
               {$I-};
               if ioresult<>0 then erro('Ocorreu um erro de escrita no disco');
          end;
     end;
     end;
end;

Procedure apaga;
var exit:char;
    pos_str:string[5];
    pos:word;
    c:integer;
    inicio:cal;
begin
     screen('CALENDAR');
     textattr:=16*7;
     janela(20,10,60,15,2);
     gotoxy(22,12);
     write('Qual o n§ do registo a eliminar?: ');
     pos_str:=ler(37,13,5,7,0,['0'..'9'],false,'',0);
     val(pos_str,pos,c);
     {$I-}
     reset(arquivo);
     seek(arquivo,pos);
     read(arquivo,inicio);
     close(arquivo);
     {$I+}
     if ioresult<>0 then
        erro('O registo n„o existe ou ocorreu um erro lendo do disco!')
     else
     begin
          if not(inicio.activo) then erro('Marcado para apagar. ''Outras Opera‡”es'' para recuperar.')
          else
          begin
          ficha(inicio,pos);
          repeat
                gotoxy(26,19);
                textcolor(red);
                desligacur;
                write('(E)liminar   /   (C)ancelar');
                exit:=upcase(readkey);
          until exit in ['E','C'];
          if exit='E' then
          begin
               {$I-}
               reset(arquivo);
               seek(arquivo,pos);
               inicio.activo:=false;
               write(arquivo,inicio);
               close(arquivo);
               {$I-};
               if ioresult<>0 then erro('Ocorreu um erro de escrita no disco');
          end;
     end;
     end;
end;

Procedure lista;
var tec,op:char;
    proc:string;
    p_ano:word;
    c,pos:integer;
    est:byte;
    cld:cal;
    base:array [1..500] of record
                                 c:cal;
                                 p:longint;
                            end;
    n:ndx;
    list:rep;
    ex:boolean;

Function questao(q:string;n:byte;val:cars):string;
begin
     screen('CALENDAR');
     textattr:=16*7;
     janela(5,10,75,15,2);
     gotoxy(7,12);
     write(q);
     textattr:=7;
     write(' ':n);
     questao:=ler(7+length(q),12,n,15,0,val,false,'',0);
end;

Procedure getcld;
var sai:char;
    ano:string;
    cld,search:cal;
    ver,emp,year,est,cop:boolean;

Function setest(inicio:byte):byte;
var op:byte;
    tec:char;
    ex:boolean;
begin
     textcolor(0);
     textbackground(7);
     op:=inicio;
     textcolor(red);
     gotoxy(58,13);
     write('Esc: ');
     gotoxy(54,14);
     write('Qualquer Estado');
     textcolor(0);
     repeat
           gotoxy(12,13);
           write('Estado   :   ( )Lixo        ( )Bom');
           gotoxy(25,14);
           write('( )Mau         ( )mUito bom');
           gotoxy(25,15);
           write('( )Razo vel    ( )Excelente');
           case op of 1:gotoxy(26,13);
                      2:gotoxy(26,14);
                      3:gotoxy(26,15);
                      4:gotoxy(41,13);
                      5:gotoxy(41,14);
                      6:gotoxy(41,15);
           end;
           write('þ');
           leop(tec,ex);
           if ex then
           case tec of #72:if op>1 then op:=op-1;
                       #75:if op>3 then op:=op-3;
                       #80:if op<6 then op:=op+1;
                       #77:if op<4 then op:=op+3;
           end
           else
           case upcase(tec) of 'L':op:=1;
                               'M':op:=2;
                               'R':op:=3;
                               'B':op:=4;
                               'U':op:=5;
                               'E':op:=6;
                               #27:op:=0;
           end;
     until not(ex) and ((tec=#13) or (tec=#27));
     gotoxy(58,13);
     write('     ');
     gotoxy(54,14);
     write('               ');
     setest:=op;
end;{seleccionar o estado do calendario}



begin
     fillchar(cld,sizeof(cld),0);
     ficha(cld,0);
     gotoxy(52,20);
     write(' ':13);
     gotoxy(12,20);
     write('Nota: Campos em branco = qualquer valor');
     cld.estado:=1;
     repeat
           cld.verso:=ler(23,7,45,7,0,[#32..#255],false,cld.verso,0);
           cld.empresa:=ler(23,9,30,7,0,[#32..#255],false,cld.empresa,0);
           str(cld.ano,ano);
           if cld.ano<>0 then ano:=ler(23,11,4,7,0,['0'..'9'],false,ano,0)
           else ano:=ler(23,11,4,7,0,['0'..'9'],false,'',0);
           val(ano,cld.ano,c);
           desligacur;
           cld.estado:=setest(cld.estado);
           ligacur(2);
           cld.copias:=ler(23,17,2,7,0,['0'..'9'],false,cld.copias,0);
           textattr:=16*7+red;
           desligacur;
           gotoxy(26,19);
           write('(P)rocurar   /   (M)odificar');
           repeat sai:=upcase(readkey); until sai in ['P','M'];
           gotoxy(19,19);
           textattr:=16*7;
           write(' ':45);
     until sai in ['P','C'];
     c:=1;
     reset(arquivo);
     while(not(eof(arquivo))) do
     begin
          read(arquivo,search);
          with cld do
          begin
               if verso<>'' then
               begin
                    if search.verso=verso then
                    ver:=true
                    else
                    ver:=false;
               end
               else
               ver:=true;
               if empresa<>'' then
               begin
                    if search.empresa=empresa then
                    emp:=true
                    else
                    emp:=false;
               end
               else
               emp:=true;
               if ano<>0 then
               begin
                    if search.ano=ano then
                    year:=true
                    else
                    year:=false;
               end
               else
               year:=true;
               if estado<>0 then
               begin
                    if search.estado=estado then
                    est:=true
                    else
                    est:=false;
               end
               else
               est:=true;
               if copias<>'' then
               begin
                    if search.copias=copias then
                    cop:=true
                    else
                    cop:=false;
               end
               else
               cop:=true;
          end;
          if ver and emp and year and est and cop then
          begin
               base[c].c:=search;
               base[c].p:=filepos(arquivo);
               inc(c);
          end;
     end;

     close(arquivo);
end;

begin
     fillchar(base,sizeof(base),0);
     screen('CALENDAR');
     textattr:=16*7;
     janela(20,5,60,20,2);
     gotoxy(22,7);
     write('Como listar os registos?');
     gotoxy(22,10);
     write('1) Pelo Verso');
     gotoxy(22,11);
     write('2) Pela Empresa');
     gotoxy(22,12);
     write('3) Pelo Ano');
     gotoxy(22,13);
     write('4) Pelo Estado');
     gotoxy(22,14);
     write('5) Por mais que um campo');
     gotoxy(22,15);
     write('6) Sair');
     ligacur(0);
     op:='1';
     gotoxy(40,17);
     repeat
           write(op);
           gotoxy(40,17);
           repeat tec:=readkey until tec in ['1'..'6',#13];
           if tec<>#13 then op:=tec;
     until tec=#13;
     desligacur;
     case op of '1':begin
                         c:=1;
                         proc:=questao('Qual o verso?: ',45,[#32..#255]);
                         reset(arquivo);
                         while(not(eof(arquivo))) do
                         begin
                              read(arquivo,cld);
                              if cld.verso=proc then
                              begin
                                   base[c].c:=cld;
                                   base[c].p:=filepos(arquivo);
                                   inc(c);
                              end;
                         end;
                         close(arquivo);
                    end;
                '2':begin
                         c:=1;
                         proc:=questao('Qual a empresa?: ',30,[#32..#255]);
                         reset(arquivo);
                         while(not(eof(arquivo))) do
                         begin
                              read(arquivo,cld);
                              if cld.verso=proc then
                              begin
                                   base[c].c:=cld;
                                   base[c].p:=filepos(arquivo);
                                   inc(c);
                              end;
                         end;
                         close(arquivo);
                    end;
                '3':begin
                         proc:=questao('Qual o ano?: ',4,['0'..'9']);
                         val(proc,p_ano,c);
                         reset(index);
                         pos:=binario(p_ano,index);
                         if pos=-1 then
                         begin
                              erro('Registo n„o encontrado');
                              exit;
                         end;
                         seek(index,pos);
                         read(index,n);
                         close(index);
                         if not(n.repete) then
                         begin
                              reset(arquivo);
                              seek(arquivo,n.pos);
                              read(arquivo,cld);
                              close(arquivo);
                              base[1].c:=cld;
                              base[1].p:=n.pos;
                         end
                         else
                         begin
                              reset(repete);
                              reset(arquivo);
                              c:=1;
                              pos:=n.pos;
                              repeat
                                    seek(repete,pos);
                                    read(repete,list);
                                    pos:=1;
                                    while (list.pos[pos]<>-1) and (pos<=20) do
                                    begin
                                         seek(arquivo,list.pos[pos]);
                                         read(arquivo,cld);
                                         base[c].c:=cld;
                                         base[c].p:=list.pos[pos];
                                         inc(c);
                                         inc(pos);
                                    end;
                                    pos:=list.outro;
                              until pos=-1;
                              close(arquivo);
                              close(repete);
                         end;
                    end;
                '4':begin
                         c:=1;
                         screen('CALENDAR');
                         textattr:=16*7;
                         janela(10,8,70,20,2);
                         gotoxy(15,10);
                         write('Indique o estado:');
                         est:=estado(1);
                         reset(arquivo);
                         while(not(eof(arquivo))) do
                         begin
                              read(arquivo,cld);
                              if cld.estado=est then
                              begin
                                   base[c].c:=cld;
                                   base[c].p:=filepos(arquivo);
                                   inc(c);
                              end;
                         end;
                         close(arquivo);
                    end;
                '5':begin
                         getcld;
                    end;

                '6':exit;
     end;
     screen('CALENDAR');
     textattr:=16*7;
     janela(20,10,60,20,2);
     gotoxy(22,12);
     write('Listar para:');
     gotoxy(25,15);
     write('1) Ecran');
     gotoxy(25,16);
     write('2) Impressora');
     gotoxy(25,17);
     write('3) Sair');
     ligacur(0);
     op:='1';
     gotoxy(40,19);
     repeat
           write(op);
           gotoxy(40,19);
           repeat tec:=readkey until tec in ['1'..'3',#13];
           if tec<>#13 then op:=tec;
     until tec=#13;
     desligacur;
     if op='3' then exit;
     if op='2' then
     begin
          c:=1;
          if base[1].c.ano<>0 then
          while base[c].c.ano<>0 do
          begin
               {$I-}
               writeln(lst,'Registo : ',base[c].p);
               {$I+}
               if ioresult<>0 then
               begin
                    erro('Impressora n„o est  pronta');
                    exit;
               end;
               writeln(lst,'Verso: ',base[c].c.verso);
               write(lst,'Empresa: ',base[c].c.empresa);
               writeln(lst,'   Ano:',base[c].c.ano);
               case base[c].c.estado of 1:write(lst,'Excelente');
                                      2:write(lst,'Mutio Bom');
                                      3:write(lst,'Bom');
                                      4:write(lst,'Razo vel');
                                      5:write(lst,'Mau');
                                      6:write(lst,'Lixo');
               end;
               write(lst,'   C¢pias: ',base[c].c.copias);
               writeln(lst);
               writeln(lst);
               inc(c);
          end
          else
          erro('Registo n„o encontrado');
     end
     else
     if op='1' then
     begin
          textattr:=16*7;
          clrscr;
          c:=1;
          janela(1,1,80,8,2);
          janela(1,9,80,16,2);
          janela(1,17,80,24,2);
          gotoxy(1,25);
          write(#23,#26,' - Movimentar   Esc - Sair');
          if base[1].c.ano<>0 then
          repeat
                with base[c].c do
                begin
                     gotoxy(3,3);
                     write('Registo: ',base[c].p,'  ');
                     gotoxy(3,4);
                     write('Verso: ',verso,' ':45-length(verso));
                     gotoxy(3,5);
                     write('Empresa: ',empresa,' ':30-length(empresa));
                     write('     Ano: ',ano,'    ');
                     gotoxy(3,6);
                     write('Estado: ');
                     case estado of 6:write('Excelente');
                                    5:write('Muito Bom');
                                    4:write('Bom      ');
                                    3:write('Razo vel ');
                                    2:write('Mau      ');
                                    1:write('Lixo     ');
                     end;
                     write('     Copias: ',copias,' ');
                end;
                if base[c+1].c.ano<>0 then
                with base[c+1].c do
                begin
                     gotoxy(3,11);
                     write('Registo: ',base[c+1].p,'  ');
                     gotoxy(3,12);
                     write('Verso: ',verso,' ':45-length(verso));
                     gotoxy(3,13);
                     write('Empresa: ',empresa,' ':30-length(empresa));
                     write('     Ano: ',ano,'    ');
                     gotoxy(3,14);
                     write('Estado: ');
                     case estado of 6:write('Excelente');
                                    5:write('Muito Bom');
                                    4:write('Bom      ');
                                    3:write('Razo vel ');
                                    2:write('Mau      ');
                                    1:write('Lixo     ');
                     end;
                     write('     Copias: ',copias,' ');
                end;
                if base[c+2].c.ano<>0 then
                with base[c+2].c do
                begin
                     gotoxy(3,19);
                     write('Registo: ',base[c+2].p,'  ');
                     gotoxy(3,20);
                     write('Verso: ',verso,' ':45-length(verso));
                     gotoxy(3,21);
                     write('Empresa: ',empresa,' ':30-length(empresa));
                     write('     Ano: ',ano,'    ');
                     gotoxy(3,22);
                     write('Estado: ');
                     case estado of 6:write('Excelente');
                                    5:write('Muito Bom');
                                    4:write('Bom       ');
                                    3:write('Razo vel  ');
                                    2:write('Mau       ');
                                    1:write('Lixo      ');
                     end;
                     write('     Copias: ',copias,' ');
                end;
                leop(tec,ex);
                if ex then
                case tec of #72:if c>1 then dec(c);
                            #80:if base[c+3].c.ano<>0 then inc(c);
                end;
          until not(ex) and (tec=#27)
          else
          erro('N„o foi encontrado nenhum registo');

     end;

end;

Procedure outras;
var op:byte;
    ex:boolean;
    inicio:cal;
    tec,exit:char;
    pos:word;
    pos_str:string[5];
    c:integer;

begin
     screen('CALENDAR');
     op:=1;
     repeat
           botao(15,13,' Update  ');
           botao(34,13,'Recuperar');
           botao(53,13,'Reindexar');
           case op of 1:default(15,13,' Update  ','Apaga fisicamente os registos marcados');
                      2:default(34,13,'Recuperar','Recupera registos marcados para apagar');
                      3:default(53,13,'Reindexar','Reindexa a base de dados');
           end;
           leop(tec,ex);
           if ex then
           case tec of #75:if op=1 then op:=1 else op:=op-1;
                       #77:if op=3 then op:=3 else op:=op+1;
           end;
     until not(ex) and (tec=#13);
     if op=2 then
     begin
          textattr:=16*7;
          janela(20,10,60,16,2);
          gotoxy(22,12);
          write('Qual o n§ do registo a recuperar?: ');
          pos_str:=ler(37,13,5,7,0,['0'..'9'],false,'',0);
          val(pos_str,pos,c);
          {$I-}
          reset(arquivo);
          seek(arquivo,pos);
          read(arquivo,inicio);
          close(arquivo);
          {$I+}
          if ioresult<>0 then
             erro('O registo n„o existe ou ocorreu um erro lendo do disco!')
          else
          begin
               if inicio.activo then erro('N„o marcado para apagar.')
               else
               begin
               ficha(inicio,pos);
               repeat
                     gotoxy(26,19);
                     textcolor(red);
                     write('(R)ecuperar   /   (C)ancelar');
                     exit:=upcase(readkey);
               until exit in ['R','C'];
               if exit='R' then
               begin
                    {$I-}
                    reset(arquivo);
                    seek(arquivo,pos);
                    inicio.activo:=true;
                    write(arquivo,inicio);
                    close(arquivo);
                    {$I-};
                    if ioresult<>0 then erro('Ocorreu um erro de escrita no disco');
               end;
          end;
          end;
     end
     else
     if op=1 then
     begin
          rewrite(temp);
          reset(arquivo);
          while not(eof(arquivo)) do
          begin
               read(arquivo,inicio);
               if inicio.activo then write(temp,inicio);
          end;
          close(arquivo);
          close(temp);
          rewrite(arquivo);
          reset(temp);
          while not(eof(temp)) do
          begin
               read(temp,inicio);
               write(arquivo,inicio);
          end;
          close(arquivo);
          close(temp);
          erase(temp);
     end;
     if op=3 then reindex;
end;


Procedure sai;
var c,d:char;
begin
     gotoxy(1,25);
     textattr:=16*7+red;
     clreol;
     write('Sair do Calendar? (S/N):   N');
     c:='N';
     ligacur(0);
     repeat
           gotoxy(28,25);
           d:=c;
           repeat c:=upcase(readkey) until c in ['S','N',#13];
           if c<>#13 then write(c);
     until c=#13;
     if d='S' then
     begin
          textattr:=7;
          clrscr;
          ligacur(8);
          halt;
     end;
end;


begin
     assign(arquivo,'calendar.dat');
     assign(temp,'calendar.tmp');
     assign(index,'calendar.ndx');
     assign(repete,'calendar.rep');
     repeat
     desligacur;
     case menu of 1:acrescenta;
                  2:modifica;
                  3:apaga;
                  4:lista;
                  5:outras;
                  6:sai;
     end;
     until bw80<>2;
end.