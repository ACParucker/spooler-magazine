Program Clube_de_Video;
Uses crt,dos,graph,utilites,pfa,unitclub;

{ *********************** PROCEDIMENTOS DO PROGRAMA ************************* }
{ ***************************** ENTRA SOCIO ********************************* }

Procedure Entra_socio;

Function verifica_ex_soc(n:string):boolean;
Var f:file of socio;
    aux:socio;
    flag:boolean;
Begin
     flag:=false;
     if existe('SOCIOS.SOC') then
                              begin
                               Assign(f,'SOCIOS.SOC');Reset(f);
                               While (not eof(f)) and (not flag) do
                                begin
                                 read(f,aux);
                                 if aux.nome=n then flag:=true
                                end;
                               Close(f);
                              end;
     verifica_ex_soc:=flag
end;

Function NSAG:longint;
Var f:file of socio;
    aux:socio;
    aux2:longint;
    flag:boolean;
Begin
     flag:=false;
     if existe('SOCIOS.SOC') then
                              begin
                               aux2:=1;
                               Assign(f,'SOCIOS.SOC');Reset(f);
                               While (not eof(f)) and (not flag) do
                                begin
                                 Read(f,aux);
                                 if aux.numero<>aux2 then
                                                      begin
                                                       NSAG:=aux2;
                                                       flag:=true
                                                      end;
                                 inc(aux2)
                                end;
                               Close(f);
                               if not flag then NSAG:=conta_socios
                              end
                             else
                              NSAG:=conta_socios;
end;

Label errado,salto;

Var dados,aux:socio;
    c:char;
    f,f2:file of socio;
    x:integer;
    flag:boolean;
    errada:word;
Begin
     escrato;
     REPEAT
     inc(conta_socios);flag:=false;
     dados.numero:=NSAG;
     dados.cadastro:=0;
     dados.cfa:=0;
     For x:=1 to 20 do
      dados.f_alug[x]:=0;
     cartao(20,140,600,320,10,'   ENTRADA DE SOCIO');
     Escreve2(40,160,12,'NOME : ');
     dados.nome:=Lerl(95,160,60,15,0,8,'Û');REF(dados);
     if verifica_ex_soc(dados.nome) then
                                     begin
                                      dec(conta_socios);
                                      erros(14);
                                      goto salto
                                     end;
     Escreve2(40,180,12,'MORADA : ');
     dados.morada:=Lerl(110,180,60,15,0,8,'Û');
     Escreve2(40,200,12,'BI : ');
     dados.bi:=Lerl(80,200,10,15,0,8,'Û');
     Escreve2(40,220,12,'TELEFONE : ');
     dados.telefone:=Lerl(130,220,10,15,0,8,'Û');
     Escreve2(40,240,12,'NUMERO DE SOCIO : '+npl(dados.numero));
     Escreve2(40,260,12,'CADASTRO : LIMPO ');
     Escreve2(135,300,11,'OS DADOS INTRODUZIDOS ESTAO CORRECTOS (S/N) ?');
     Repeat
      c:=readkey;c:=Upcase(c)
     until c in ['S','N'];
     if c='N' then
               begin
                limpa_parte(134,299,500,311,15);
                Tecla(25,158,35,168,false);
                Tecla(25,178,35,188,false);
                Tecla(25,198,35,208,false);
                Tecla(25,218,35,228,false);
                Tecla(25,289,35,301,false);
                Escreve2(40,292,11,'SAIR');
                Repeat
                 rato;
                 Repeat until ratotec=1;
                 escrato;
                 if detecta(25,158,35,168) then
                                            begin
                                             Marca(25,158,35,168,true);
                                             Limpa_parte(99,159,580,171,15);
                                             dados.nome:=Lerl(100,160,60,15,0,8,'Û');REF(dados)
                                            end
                                           else
                 if detecta(25,178,35,188) then
                                            begin
                                             Marca(25,178,35,188,true);
                                             Limpa_parte(109,179,550,191,15);
                                             dados.morada:=Lerl(110,180,55,15,0,8,'Û')
                                            end
                                           else
                 if detecta(25,198,35,208) then
                                            begin
                                             Marca(25,198,35,208,true);
                                             Limpa_parte(79,199,160,211,15);
                                             dados.bi:=Lerl(80,200,10,15,0,8,'Û')
                                            end
                                           else
                 if detecta(25,218,35,228) then
                                            begin
                                             Marca(25,218,35,228,true);
                                             Limpa_parte(129,219,210,231,15);
                                             dados.telefone:=Lerl(130,220,10,15,0,8,'Û')
                                            end;
                until detecta(25,289,35,301);
                Marca(25,289,35,301,true)
               end;
     { * GRAVAR SOCIOS * }

     Assign(f,'SOCIOS.SOC');
     if existe('SOCIOS.SOC') then
                              begin
                               Assign(f2,'AUXILIAR');
                               {$I-} Rewrite(f2); {$I+}
                               errada:=IOresult;
                               erros_de_leitura(errada);
                               if errada<>0 then begin
                                                  c:='N';
                                                  dec(conta_socios);
                                                  goto errado
                                                 end;
                               Reset(f);
                               While not eof(f) do
                                begin
                                  read(f,aux);
                                  if (dados.numero=1)
                                    and (not flag) then
                                                     begin
                                                      Write(f2,dados);
                                                      Write(f2,aux);
                                                      flag:=true
                                                     end
                                                    else
                                  if aux.numero=dados.numero-1 then
                                                                begin
                                                                 Write(f2,aux);
                                                                 Write(f2,dados);
                                                                 flag:=true
                                                                end
                                                               else
                                                                Write(f2,aux)
                                end;
                               if not flag then Write(f2,dados);
                               Close(f2);Close(f);
                               Erase(f);Rename(f2,'SOCIOS.SOC')
                              end
                             else
                              begin
                               {$I-} Rewrite(f); {$I+}
                               errada:=IOresult;
                               erros_de_leitura(errada);
                               if errada<>0 then begin
                                                  c:='N';
                                                  dec(conta_socios);
                                                  goto errado
                                                 end;
                               Write(f,dados);
                               Close(f)
                              end;
     salto:
     mensagem(1);
     c:=readkey;c:=Upcase(c);
     errado:
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ ***************************** MODIFICAR SOCIO ***************************** }

Procedure modifica_socio;

Procedure modificar(var d:socio);

Label errado;

Var f,f2:file of socio;
    aux:socio;
    errada:word;
Begin
     rato;
     Tecla(25,158,35,168,false);
     Tecla(25,178,35,188,false);
     Tecla(25,198,35,208,false);
     Tecla(25,218,35,228,false);
     Tecla(25,258,35,268,false);
     Tecla(25,289,35,301,false);
     Escreve2(40,292,11,'SAIR');
     Repeat
      Repeat until ratotec=1;
      if detecta(25,158,35,168) then
                                 begin
                                  Marca(25,158,35,168,true);escrato;
                                  Limpa_parte(99,159,580,171,15);
                                  d.nome:=Lerl(100,160,60,15,0,8,'Û');REF(d);
                                  rato
                                 end
                                else
      if detecta(25,178,35,188) then
                                 begin
                                  Marca(25,178,35,188,true);escrato;
                                  Limpa_parte(109,179,550,191,15);
                                  d.morada:=Lerl(110,180,55,15,0,8,'Û');
                                  rato
                                 end
                                else
      if detecta(25,198,35,208) then
                                 begin
                                  Marca(25,198,35,208,true);escrato;
                                  Limpa_parte(79,199,160,211,15);
                                  d.bi:=Lerl(80,200,10,15,0,8,'Û');
                                  rato
                                 end
                                else
      if detecta(25,218,35,228) then
                                 begin
                                  Marca(25,218,35,228,true);escrato;
                                  Limpa_parte(129,219,210,231,15);
                                  d.telefone:=Lerl(130,220,10,15,0,8,'Û');
                                  rato
                                 end
                                else
      if detecta(25,258,35,268) then
                                 begin
                                  Marca(25,258,35,268,true);escrato;
                                  Limpa_parte(129,259,515,271,15);
                                  inc(d.cadastro);Setcolor(0);
                                  if d.cadastro>5 then d.cadastro:=0;
                                  Outtextxy(130,260,Le_cadastro(d));
                                  rato
                                 end;
     until detecta(25,289,35,301);
     Marca(25,289,35,301,true);

     { þ GRAVAR þ }

     Assign(f,'SOCIOS.SOC');Reset(f);
     Assign(f2,'AUXILIAR');
     {$I-} Rewrite(f2); {$I+}
     errada:=IOresult;
     erros_de_leitura(errada);
     if errada<>0 then
                   begin
                    Close(f);
                    goto errado
                   end;
     While not eof(f) do
      begin
       Read(f,aux);
       if aux.numero=d.numero then write(f2,d)
                              else write(f2,aux)
      end;
     Close(f);Close(f2);
     Erase(f);Rename(f2,'SOCIOS.SOC');

     errado:
     escrato
end;

Var xx:longint;
    d:socio;
    flag:boolean;
    c:char;
Begin
     escrato;
     REPEAT
     cartao(20,140,600,320,10,'  MODIFICA SOCIO');
     Escreve2(40,160,12,'Indique nome ou numero do');
     Escreve2(40,180,12,'socio : ');
     d.nome:=Lerl(100,180,60,15,0,8,'Û');REF(d);
     Limpa_parte(39,159,590,191,15);
     if existe('SOCIOS.SOC') then
                              begin
                               flag:=Ver_existe_socio(d.nome,d,xx);
                               if flag then
                                        begin
                                         Escreve2(40,160,12,'NOME : ');
                                         Setcolor(0);
                                         Outtextxy(100,160,d.nome);
                                         Escreve2(40,180,12,'MORADA : ');
                                         Setcolor(0);
                                         Outtextxy(115,180,d.morada);
                                         Escreve2(40,200,12,'BI : ');
                                         Setcolor(0);
                                         Outtextxy(80,200,d.bi);
                                         Escreve2(40,220,12,'TELEFONE : ');
                                         Setcolor(0);
                                         Outtextxy(130,220,d.telefone);
                                         Escreve2(40,240,12,'NUMERO DE SOCIO : ');
                                         Setcolor(0);
                                         Outtextxy(185,240,npl(d.numero));
                                         Escreve2(40,260,12,'CADASTRO : ');
                                         Setcolor(0);
                                         Outtextxy(130,260,Le_cadastro(d));
                                         modificar(d);
                                        end
                                       else
                                        erros(4)
                              end
                             else
                              erros(4);
     mensagem(2);
     c:=readkey;c:=Upcase(c);
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ ******************************* EXCLUI SOCIO ****************************** }

Procedure Exclui_socio;

Function deseja_apagar(nn:string):boolean;
Var px,px2:integer;
    saux:string;
    c:char;
Begin
     deseja_apagar:=false;
     if nn='*' then
                begin
                 nn:='Todos os socios seram removidos';
                 saux:='Deseja mesmo apagar todos os socios (S/N) ?'
                end
               else
                saux:='Deseja mesmo apagar este socio (S/N) ?';
     px:=100+((((getmaxx-100)-100) div 2)-((length(saux)*8) div 2));
     px2:=100+((((getmaxx-100)-100) div 2)-((length(nn)*8) div 2));
     Jan2(50,150,getmaxx-50,200,15,4,12,2);
     Escreve2(px2,170,14,nn);Escreve2(px,180,14,saux);
     repeat c:=readkey;c:=Upcase(c) until c in ['S','N',#27];
     if c='S' then deseja_apagar:=true
end;

Label errado;

Var flag:boolean;
    f,f2:file of socio;
    d:socio;
    xx:longint;
    c:char;
    errada:word;
Begin
     escrato;
     REPEAT
     cartao(20,140,600,210,10,'   REMOVER SOCIO');
     Escreve2(40,160,12,'Indique nome ou numero do');
     Escreve2(40,180,12,'socio : ');
     d.nome:=Lerl(100,180,60,15,0,8,'Û');REF(d);
     Limpa_parte(39,159,590,191,15);
     if existe('SOCIOS.SOC') then
                              begin
                               if d.nome='*' then
                                              begin
                                               if deseja_apagar(d.nome) then
                                               BEGIN
                                               Assign(f,'SOCIOS.SOC');
                                               {$I-} Erase(f); {$I+}
                                               errada:=IOresult;
                                               erros_de_leitura(errada);
                                               if errada<>0 then goto errado
                                                            else
                                                             begin
                                                              conta_socios:=1;
                                                              c:='N';
                                                              erros(16);
                                                              goto errado
                                                             end
                                               END
                                              end
                                             else
                              BEGIN
                               flag:=Ver_existe_socio(d.nome,d,xx);
                               if flag then
                                        begin
                                         if deseja_apagar(d.nome) then
                                                            begin

                                                            { þ APAGAR þ }

                                                            dec(conta_socios);
                                                            Assign(f,'SOCIOS.SOC');Reset(f);
                                                            Assign(f2,'AUXILIAR');
                                                            {$I-} Rewrite(f2); {$I+}
                                                            errada:=IOresult;
                                                            erros_de_leitura(errada);
                                                            if errada<>0 then
                                                                          begin
                                                                           c:='N';
                                                                           Close(f);
                                                                           goto errado
                                                                          end;
                                                            While not eof(f) do
                                                             begin
                                                              Read(f,d);
                                                              if d.numero<>xx then write(f2,d);
                                                             end;
                                                             Close(f);
                                                             Erase(f);
                                                             if filesize(f2)=0 then erase(f2)
                                                                               else
                                                                                begin
                                                                                 Close(f2);
                                                                                 Rename(f2,'SOCIOS.SOC')
                                                                                end;
                                                            end
                                        end
                                       else
                                        erros(4);
                               END
                              end
                             else
                              erros(4);
     if existe('SOCIOS.SOC') then
                              begin
                               mensagem(3);
                               c:=readkey;c:=Upcase(c)
                              end
                             else
                              c:='N';
     errado:
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ ***************************** PROCURA UM SOCIO *************************** }

Procedure Procura_so;
Var d:socio;
    xx:longint;
    c:char;
Begin
     escrato;
     REPEAT
     cartao(20,140,600,210,10,'   PROCURA SOCIO');
     Escreve2(40,160,12,'Indique nome ou numero do');
     Escreve2(40,180,12,'socio : ');
     d.nome:=Lerl(100,180,60,15,0,8,'Û');REF(d);
     Limpa_parte(39,159,590,191,15);
     if ver_existe_socio(d.nome,d,xx) then
                                       erros(5)
                                      else
                                       erros(4);
     mensagem(4);
     c:=readkey;c:=Upcase(c);
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ ******************** PROCURA E MOSTRA OS DADOS DO PROCURADO *************** }

Procedure Procura_mostra;

Procedure Filmes_alugados(d:socio);
Var x,py:integer;
    f:file of filme;
    aux:filme;
Begin
     Limpa_parte(25,145,595,295,15);py:=180;
     Escreve2(40,160,12,'Filmes Alugados pelo socio : '+npl(d.cfa));
     Assign(f,'FILMES.FIL');
     Setcolor(0);
     For x:=1 to d.cfa do
      begin
       Reset(f);
       While not eof(f) do
        begin
         read(f,aux);
         if aux.numero=d.f_alug[x] then
                                    begin
                                     Outtextxy(40,py,aux.nome);
                                     py:=py+10
                                    end;
        end;
      end;
     Close(f)
end;

Var d:socio;
    xx:longint;
    c:char;
Begin
     escrato;
     REPEAT
     cartao(20,140,600,320,10,'   PESQUISA SOCIO');
     Escreve2(40,160,12,'Indique nome ou numero do');
     Escreve2(40,180,12,'socio : ');
     d.nome:=Lerl(100,180,60,15,0,8,'Û');REF(d);
     Limpa_parte(39,159,590,191,15);
     if ver_existe_socio(d.nome,d,xx) then
                                       Begin
                                        Escreve2(40,160,12,'NOME : ');
                                        Setcolor(0);
                                        Outtextxy(100,160,d.nome);
                                        Escreve2(40,180,12,'MORADA : ');
                                        Setcolor(0);
                                        Outtextxy(115,180,d.morada);
                                        Escreve2(40,200,12,'BI : ');
                                        Setcolor(0);
                                        Outtextxy(80,200,d.bi);
                                        Escreve2(40,220,12,'TELEFONE : ');
                                        Setcolor(0);
                                        Outtextxy(130,220,d.telefone);
                                        Escreve2(40,240,12,'NUMERO DE SOCIO : ');
                                        Setcolor(0);
                                        Outtextxy(185,240,npl(d.numero));
                                        Escreve2(40,260,12,'CADASTRO : ');
                                        Setcolor(0);
                                        Outtextxy(130,260,Le_cadastro(d));
                                        Escreve2(145,300,11,
                                               'Prima uma tecla qualquer ou uma tecla do rato');
                                        Repeat
                                         c:=premir
                                        until (ratotec=1) or
                                              (ratotec=2) or
                                              (ord(c)>=0) and (ord(c)<=122);

                                        if d.cfa=0 then
                                                    erros(7)
                                                   else
                                                    Filmes_alugados(d);

                                        Repeat
                                         c:=premir
                                        until (ratotec=1) or
                                              (ratotec=2) or
                                              (ord(c)>=0) and (ord(c)<=122)
                                       end
                                      else
                                       erros(4);
     mensagem(5);
     c:=readkey;c:=Upcase(c);
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ **************************** SAIDA DE FILME ******************************* }

Procedure Sai_filme;

Procedure Regista_filme(fl,sc:longint);

Label errado;

Var f,aux:file of filme;
    s,aux2:file of socio;
    ff:filme;
    ss:socio;
    errada:word;
Begin
     Assign(f,'FILMES.FIL');Reset(f);
     Assign(aux,'AUXILIAR');
     {$I-} Rewrite(aux); {$I+}
     errada:=IOresult;
     erros_de_leitura(errada);
     if errada<>0 then
                   begin
                    Close(f);
                    goto errado
                   end;
     While not eof(f) do
      begin
       Read(f,ff);
       if ff.numero=fl then
                        begin
                         ff.estado:=true;
                         Getdate(ff.horas.year,ff.horas.month,
                                 ff.horas.day,ff.horas.hour)
                        end;
       Write(aux,ff)
      end;
     Close(f);Close(aux);Erase(f);Rename(aux,'FILMES.FIL');
     Assign(s,'SOCIOS.SOC');Reset(s);
     Assign(aux2,'AUXILIAR');
     {$I-} Rewrite(aux2); {$I+}
     errada:=IOresult;
     erros_de_leitura(errada);
     if errada<>0 then
                   begin
                    Close(s);
                    goto errado
                   end;
     While not eof(s) do
      begin
       Read(s,ss);
       if ss.numero=sc then
                        begin
                         inc(ss.cfa);if ss.cfa>20 then ss.cfa:=20;
                         ss.f_alug[ss.cfa]:=fl
                        end;
       Write(aux2,ss)
      end;
     Close(s);Close(aux2);Erase(s);
     Rename(aux2,'SOCIOS.SOC');erros(8);
     errado:
end;

Var fil:filme;
    soc:socio;
    aux,aux2:longint;
    c:char;
Begin
     escrato;
     REPEAT
     cartao(20,130,getmaxx-20,getmaxy-200,9,' SAIDA DE FILME');
     Escreve2(40,140,12,'Nome ou numero do');
     Escreve2(40,155,12,'filme : ');
     fil.nome:=Lerl(105,155,60,15,0,8,'Û');REF2(fil);
     if not ver_existe_filme(fil.nome,fil,aux) then
                                                erros(6)
                                               else
                                                begin
                                                 if fil.estado then
                                                                erros(10)
                                                               else
                                                                begin
                                                                 Escreve2(40,180,12,'Nome ou numero do');
                                                                 Escreve2(40,195,12,'socio : ');
                                                                 soc.nome:=Lerl(105,195,60,15,0,8,'Û');REF(soc);
                                                                 if not ver_existe_socio(soc.nome,soc,aux2)
                                                                    then
                                                                     erros(4)
                                                                    else
                                                                     Regista_filme(aux,aux2)
                                                               end;
                                                end;
     mensagem(6);
     c:=readkey;c:=Upcase(c);
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ *************************** ENTRADA DE FILME ****************************** }

Procedure Entra_filme;

Function cass_danificada:boolean;
Var p:pointer;
    t:word;
Begin
     Jan(30,170,getmaxx-30,220,11,9,3,2,p,t);cass_danificada:=false;
     Escreve2(180,180,14,'Verifica se a cassete esta danificada .');
     Escreve2(180,190,14,'Tecla esquerda do rato : Danificada');
     Escreve2(180,200,14,'Tecla direita do rato : N„o danificada');
     Repeat until (ratotec=1) or (ratotec=2);
     if ratotec=1 then cass_danificada:=true;
     Putimage(30,170,p^,normalput);Freemem(p,t)
end;

Procedure DesRegista_filme(nfil:longint;cass:boolean);

Label errado;

Var f,aux:file of filme;
    s,aux2:file of socio;
    ff:filme;
    ss:socio;
    xx,xxx,aux5:integer;
    aux3:datetime;
    aux4:longint;
    errada:word;
Begin
     Assign(f,'FILMES.FIL');Reset(f);
     Assign(aux,'AUXILIAR');
     {$I-} Rewrite(aux); {$I+}
     errada:=IOresult;
     erros_de_leitura(errada);
     if errada<>0 then
                   begin
                    Close(f);
                    goto errado
                   end;
     While not eof(f) do
      begin
       Read(f,ff);
       if ff.numero=nfil then
                          begin
                           case ff.categoria of
                            'T':aux5:=precos_cass.ft;
                            'E':aux5:=precos_cass.fe;
                            'A':aux5:=precos_cass.fa
                           end;
                           Getdate(aux3.year,aux3.month,aux3.day,aux3.hour);
                           ff.estado:=false;
                           aux4:=((abs(ff.horas.month-aux3.month)*30)+abs(ff.horas.day-aux3.day))*aux5;
                           if aux4=0 then aux4:=aux5;
                           acumula_lucro:=acumula_lucro+aux4
                          end;
       Write(aux,ff)
      end;
     Close(f);Close(aux);Erase(f);Rename(aux,'FILMES.FIL');
     Assign(s,'SOCIOS.SOC');Reset(s);
     Assign(aux2,'AUXILIAR');
     {$I-} Rewrite(aux2); {$I+}
     errada:=IOresult;
     erros_de_leitura(errada);
     if errada<>0 then
                   begin
                    Close(s);
                    goto errado
                   end;
     While not eof(s) do
      begin
       Read(s,ss);
       For xx:=1 to ss.cfa do
        if ss.f_alug[xx]=nfil then
                               begin
                                if cass then
                                         begin
                                          inc(ss.cadastro);
                                          if ss.cadastro>5 then ss.cadastro:=5
                                         end;
                                ss.f_alug[xx]:=0;
                                For xxx:=xx to ss.cfa-1 do
                                  ss.f_alug[xxx]:=ss.f_alug[xxx]+1;
                                ss.f_alug[ss.cfa]:=0;dec(ss.cfa)
                               end;
       Write(aux2,ss)
      end;
     Close(s);Close(aux2);Erase(s);Rename(aux2,'SOCIOS.SOC');erros(9);
     errado:
end;

Var fil:filme;
    soc:socio;
    aux,aux2:longint;
    cass:boolean;
    c:char;
Begin
     escrato;
     REPEAT
     cartao(20,130,getmaxx-20,getmaxy-200,9,' ENTRADA DE FILME');
     Escreve2(40,140,12,'Nome ou numero do');
     Escreve2(40,155,12,'filme : ');
     fil.nome:=Lerl(105,155,60,15,0,8,'Û');REF2(fil);
     if not ver_existe_filme(fil.nome,fil,aux) then
                                                erros(6)
                                               else
                                                begin
                                                 if fil.estado then
                                                                begin
                                                                 cass:=cass_danificada;
                                                                 DesRegista_filme(aux,cass)
                                                                end
                                                               else erros(11);
                                                end;
     mensagem(7);
     c:=readkey;c:=Upcase(c);
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ *************************** COMPRA DE FILME ******************************* }

Procedure Compra_filme;

Function verifica_ex_fil(n:string):boolean;
Var f:file of filme;
    aux:filme;
    flag:boolean;
Begin
     flag:=false;
     if existe('FILMES.FIL') then
                              begin
                               Assign(f,'FILMES.FIL');Reset(f);
                               While (not eof(f)) and (not flag) do
                                begin
                                 read(f,aux);
                                 if aux.nome=n then flag:=true
                                end;
                               Close(f);
                              end;
     verifica_ex_fil:=flag
end;

Function NFAG:longint;
Var f:file of filme;
    aux:filme;
    aux2:longint;
    flag:boolean;
Begin
     flag:=false;
     if existe('FILMES.FIL') then
                              begin
                               aux2:=1;
                               Assign(f,'FILMES.FIL');Reset(f);
                               While (not eof(f)) and (not flag) do
                                begin
                                 Read(f,aux);
                                 if aux.numero<>aux2 then
                                                      begin
                                                       NFAG:=aux2;
                                                       flag:=true
                                                      end;
                                 inc(aux2)
                                end;
                               Close(f);
                               if not flag then NFAG:=conta_filmes
                              end
                             else
                              NFAG:=conta_filmes
end;

Label errado,salto;

Var flm,aux:filme;
    f,f2:file of filme;
    c:char;
    flag:boolean;
    errada:word;
Begin
     escrato;
     REPEAT
     inc(conta_filmes);flag:=false;
     flm.numero:=NFAG;flm.estado:=false;
     cartao(10,120,getmaxx-10,getmaxy-80,9,' COMPRA DE FILME');
     Escreve2(30,140,12,'Nome :');
     flm.nome:=Lerl(85,140,60,15,0,8,'Û');REF2(flm);
     if verifica_ex_fil(flm.nome) then
                                   begin
                                    dec(conta_filmes);
                                    erros(15);
                                    goto salto
                                   end;
     Escreve2(30,160,12,'Realizador : ');
     flm.realizador:=Lerl(135,160,60,15,0,8,'Û');
     Escreve2(30,180,12,'Genero : ');
     flm.genero:=Lerl(102,180,40,15,0,8,'Û');
     Escreve2(30,200,12,'Duracao (min) : ');
     flm.duracao:=Lerl(158,200,40,15,0,8,'Û');
     Escreve2(165+(length(flm.duracao)*8),200,12,'min');
     Escreve2(30,220,12,'Protagonista 1 : ');
     flm.protagonistas[1]:=Lerl(166,220,55,15,0,8,'Û');
     Escreve2(30,240,12,'Protagonista 2 : ');
     flm.protagonistas[2]:=Lerl(166,240,55,15,0,8,'Û');
     Escreve2(30,260,12,'Protagonista 3 : ');
     flm.protagonistas[3]:=Lerl(166,260,55,15,0,8,'Û');
     Escreve2(30,280,12,'Categoria do filme ( T : Top , E : Expresso , A : Antigo ) : ');
     Repeat flm.categoria:=Upcase(readkey) until flm.categoria in ['T','E','A'];
     Setcolor(0);Outtextxy(520,280,flm.categoria);
     Escreve2(30,300,12,'Filme numero : '+npl(flm.numero));
     Escreve2(150,getmaxy-100,11,'OS DADOS INTRODUZIDOS ESTAO CORRECTOS (S/N) ?');
     Repeat
      c:=readkey;c:=Upcase(c)
     until c in ['S','N'];
     if c='N' then
               begin
                limpa_parte(149,getmaxy-101,510,getmaxy-91,15);
                Tecla(15,138,25,148,false);
                Tecla(15,158,25,168,false);
                Tecla(15,178,25,188,false);
                Tecla(15,198,25,208,false);
                Tecla(15,218,25,228,false);
                Tecla(15,238,25,248,false);
                Tecla(15,258,25,268,false);
                Tecla(15,278,25,288,false);
                Tecla(15,318,25,328,false);
                Escreve2(30,320,11,'SAIR');
                Repeat
                 rato;
                 Repeat until ratotec=1;
                 escrato;
                 if detecta(15,138,25,148) then
                                            begin
                                             Marca(15,138,25,148,true);
                                             Limpa_parte(84,139,565,152,15);
                                             flm.nome:=Lerl(85,140,60,15,0,8,'Û');REF2(flm)
                                            end
                                           else
                 if detecta(15,158,25,168) then
                                            begin
                                             Marca(15,158,25,168,true);
                                             Limpa_parte(134,159,615,171,15);
                                             flm.realizador:=Lerl(135,160,60,15,0,8,'Û')
                                            end
                                           else
                 if detecta(15,178,25,188) then
                                            begin
                                             Marca(15,178,25,188,true);
                                             Limpa_parte(101,179,422,191,15);
                                             flm.genero:=Lerl(102,180,40,15,0,8,'Û')
                                            end
                                           else
                 if detecta(15,198,25,208) then
                                            begin
                                             Marca(15,198,25,208,true);
                                             Limpa_parte(157,199,515,211,15);
                                             flm.duracao:=Lerl(158,200,40,15,0,8,'Û');
                                             Escreve2(165+(length(flm.duracao)*8),200,12,'min')
                                            end
                                           else
                 if detecta(15,218,25,228) then
                                            begin
                                             Marca(15,218,25,228,true);
                                             Limpa_parte(165,219,606,231,15);
                                             flm.protagonistas[1]:=Lerl(166,220,55,15,0,8,'Û')
                                            end
                                           else
                 if detecta(15,238,25,248) then
                                            begin
                                             Marca(15,238,25,248,true);
                                             Limpa_parte(165,239,606,251,15);
                                             flm.protagonistas[2]:=Lerl(166,240,55,15,0,8,'Û')
                                            end
                                           else
                 if detecta(15,258,25,268) then
                                            begin
                                             Marca(15,258,25,268,true);
                                             Limpa_parte(165,259,606,271,15);
                                             flm.protagonistas[3]:=Lerl(166,260,55,15,0,8,'Û')
                                            end
                                           else
                 if detecta(15,278,25,288) then
                                            begin
                                             Marca(15,278,25,288,true);
                                             Limpa_parte(519,279,531,291,15);
                                             Escreve2(30,280,12,
                                             'Categoria do filme ( T : Top , E : Expresso , A : Antigo ) : ');
                                             Repeat flm.categoria:=Upcase(readkey) until flm.categoria in ['T','E','A'];
                                             Setcolor(0);Outtextxy(520,280,flm.categoria)
                                            end;
                until detecta(15,318,25,328);
                Marca(15,318,25,328,true)
               end;
     { * GRAVAR FILME COMPRADO * }

     Assign(f,'FILMES.FIL');
     if existe('FILMES.FIL') then
                              begin
                               Assign(f2,'AUXILIAR');
                               {$I-} Rewrite(f2); {$I+}
                               errada:=IOresult;
                               erros_de_leitura(errada);
                               if errada<>0 then
                                             begin
                                              c:='N';
                                              dec(conta_filmes);
                                              goto errado
                                             end;
                               Reset(f);
                               While not eof(f) do
                                begin
                                 Read(f,aux);
                                 if (flm.numero=1)
                                  and (not flag) then
                                                  begin
                                                   Write(f2,flm);
                                                   Write(f2,aux);
                                                   flag:=true
                                                  end
                                                 else
                                 if aux.numero=flm.numero-1 then
                                                             begin
                                                              Write(f2,aux);
                                                              Write(f2,flm);
                                                              flag:=true
                                                             end
                                                            else
                                                             Write(f2,aux);
                                end;
                               if not flag then Write(f2,flm);
                               Close(f2);Close(f);
                               Erase(f);Rename(f2,'FILMES.FIL')
                              end
                             else
                              begin
                               {$I-} Rewrite(f); {$I+}
                               errada:=IOresult;
                               erros_de_leitura(errada);
                               if errada<>0 then
                                             begin
                                              c:='N';
                                              dec(conta_filmes);
                                              goto errado
                                             end;
                               Write(f,flm);
                               Close(f)
                              end;
     salto:
     mensagem(8);
     c:=readkey;c:=Upcase(c);
     errado:
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ ********************** MODIFICA DADOS DE FILME **************************** }

Procedure Modifica_filme;

Procedure modificar(flm:filme);

Label errado;

Var f,f2:file of filme;
    aux:filme;
    errada:word;
Begin
     Tecla(15,138,25,148,false);
     Tecla(15,158,25,168,false);
     Tecla(15,178,25,188,false);
     Tecla(15,198,25,208,false);
     Tecla(15,218,25,228,false);
     Tecla(15,238,25,248,false);
     Tecla(15,258,25,268,false);
     Tecla(15,278,25,288,false);
     Tecla(15,318,25,328,false);
     Escreve2(30,320,11,'SAIR');
     Repeat
      rato;
      Repeat until ratotec=1;
      escrato;
      if detecta(15,138,25,148) then
                                 begin
                                  Marca(15,138,25,148,true);
                                  Limpa_parte(84,139,565,152,15);
                                  flm.nome:=Lerl(85,140,60,15,0,8,'Û');REF2(flm)
                                 end
                                else
      if detecta(15,158,25,168) then
                                 begin
                                  Marca(15,158,25,168,true);
                                  Limpa_parte(134,159,615,171,15);
                                  flm.realizador:=Lerl(135,160,60,15,0,8,'Û')
                                 end
                                else
      if detecta(15,178,25,188) then
                                 begin
                                  Marca(15,178,25,188,true);
                                  Limpa_parte(101,179,422,191,15);
                                  flm.genero:=Lerl(102,180,40,15,0,8,'Û')
                                 end
                                else
      if detecta(15,198,25,208) then
                                 begin
                                  Marca(15,198,25,208,true);
                                  Limpa_parte(157,199,515,211,15);
                                  flm.duracao:=Lerl(158,200,40,15,0,8,'Û');
                                  Escreve2(165+(length(flm.duracao)*8),200,12,'min')
                                 end
                                else
      if detecta(15,218,25,228) then
                                 begin
                                  Marca(15,218,25,228,true);
                                  Limpa_parte(165,219,606,231,15);
                                  flm.protagonistas[1]:=Lerl(166,220,55,15,0,8,'Û')
                                 end
                                else
      if detecta(15,238,25,248) then
                                 begin
                                  Marca(15,238,25,248,true);
                                  Limpa_parte(165,239,606,251,15);
                                  flm.protagonistas[2]:=Lerl(166,240,55,15,0,8,'Û')
                                 end
                                else
      if detecta(15,258,25,268) then
                                 begin
                                  Marca(15,258,25,268,true);
                                  Limpa_parte(165,259,606,271,15);
                                  flm.protagonistas[3]:=Lerl(166,260,55,15,0,8,'Û')
                                 end
                                else
      if detecta(15,278,25,288) then
                                 begin
                                  Marca(15,278,25,288,true);
                                  Limpa_parte(519,279,531,291,15);
                                  Escreve2(30,280,12,
                                  'Categoria do filme ( T : Top , E : Expresso , A : Antigo ) : ');
                                  Repeat flm.categoria:=Upcase(readkey) until flm.categoria in ['T','E','A'];
                                  Setcolor(0);Outtextxy(520,280,flm.categoria)
                                 end;
     until detecta(15,318,25,328);
     Marca(15,318,25,328,true);

     { þ GRAVAR þ }

     Assign(f,'FILMES.FIL');Reset(f);
     Assign(f2,'AUXILIAR');
     {$I-} Rewrite(f2); {$I+}
     errada:=IOresult;
     erros_de_leitura(errada);
     if errada<>0 then
                   begin
                    Close(f);
                    goto errado
                   end;
     While not eof(f) do
      begin
       Read(f,aux);
       if aux.numero=flm.numero then write(f2,flm)
                                else write(f2,aux)
      end;
     Close(f);Close(f2);
     Erase(f);Rename(f2,'FILMES.FIL');
     errado:
end;

Var flag:boolean;
    flm:filme;
    xx:longint;
    c:char;
Begin
     escrato;
     REPEAT
     cartao(10,120,getmaxx-10,getmaxy-80,9,' MODIFICA FILME');
     Escreve2(30,140,12,'Indique nome ou numero do');
     Escreve2(30,160,12,'filme : ');
     flm.nome:=Lerl(95,160,60,15,0,8,'Û');REF2(flm);
     if existe('FILMES.FIL') then
                              begin
                               flag:=Ver_existe_filme(flm.nome,flm,xx);
                               if flag then
                                        begin
                                         Limpa_parte(29,139,545,171,15);
                                         Escreve2(30,140,12,'Nome : ');
                                         Setcolor(0);Outtextxy(85,140,flm.nome);
                                         Escreve2(30,160,12,'Realizador : ');
                                         Setcolor(0);Outtextxy(135,160,flm.realizador);
                                         Escreve2(30,180,12,'Genero : ');
                                         Setcolor(0);Outtextxy(102,180,flm.genero);
                                         Escreve2(30,200,12,'Duracao (min) : ');
                                         Setcolor(0);Outtextxy(158,200,flm.duracao);
                                         Escreve2(165+(length(flm.duracao)*8),200,12,'min');
                                         Escreve2(30,220,12,'Protagonista 1 : ');
                                         Setcolor(0);Outtextxy(166,220,flm.protagonistas[1]);
                                         Escreve2(30,240,12,'Protagonista 2 : ');
                                         Setcolor(0);Outtextxy(166,240,flm.protagonistas[2]);
                                         Escreve2(30,260,12,'Protagonista 3 : ');
                                         Setcolor(0);Outtextxy(166,260,flm.protagonistas[3]);
                                         Escreve2(30,280,12,'Categoria do filme ( T : Top , E : Expresso , A : Antigo ) : ');
                                         Setcolor(0);Outtextxy(520,280,flm.categoria);
                                         Escreve2(30,300,12,'Filme numero : ');
                                         Setcolor(0);Outtextxy(150,300,npl(flm.numero));
                                         modificar(flm)
                                        end
                                       else
                                        erros(6);
                              end
                             else
                              erros(6);
     mensagem(9);
     c:=readkey;c:=Upcase(c);
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ ********************* LISTAR FILMES EXISTENTES **************************** }

Procedure Listar_filmes;
Var f:file of filme;
    py:integer;
    d:filme;
    c:char;
    flag:boolean;
Begin
     escrato;py:=120;flag:=false;
     cartao(10,110,getmaxx-10,getmaxy-50,10,'   LISTA FILMES');
     if existe('FILMES.FIL') then
                              begin
                               Setcolor(0);
                               Assign(f,'FILMES.FIL');Reset(f);
                               While (not eof(f)) and (not(flag)) do
                                begin
                                 Read(f,d);
                                 if d.estado then Setcolor(12) else Setcolor(0);
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
                              erros(6);
     Limpa_ecran;rato
end;

{ ************************** EXCLUIR FILME ********************************** }

Procedure Exclui_filme;
Function deseja_apagar(nn:string):boolean;
Var px,px2:integer;
    saux:string;
    c:char;
Begin
     deseja_apagar:=false;
     if nn='*' then
                begin
                 nn:='Todos os filmes seram removidos';
                 saux:='Deseja mesmo apagar todos os filmes (S/N) ?'
                end
               else
                saux:='Deseja mesmo apagar este filme (S/N) ?';
     px:=100+((((getmaxx-100)-100) div 2)-((length(saux)*8) div 2));
     px2:=100+((((getmaxx-100)-100) div 2)-((length(nn)*8) div 2));
     Jan2(50,150,getmaxx-50,200,15,4,12,2);
     Escreve2(px2,170,14,nn);Escreve2(px,180,14,saux);
     repeat c:=readkey;c:=Upcase(c) until c in ['S','N',#27];
     if c='S' then deseja_apagar:=true
end;

Label errado;

Var flag:boolean;
    f,f2:file of filme;
    d:filme;
    xx:longint;
    c:char;
Begin
     escrato;
     REPEAT
     cartao(20,140,600,210,10,'   REMOVER FILME');
     Escreve2(40,160,12,'Indique nome ou numero do');
     Escreve2(40,180,12,'filme : ');
     d.nome:=Lerl(100,180,60,15,0,8,'Û');REF2(d);
     Limpa_parte(39,159,590,191,15);
     if existe('FILMES.FIL') then
                              begin
                               if d.nome='*' then
                                              begin
                                               if deseja_apagar(d.nome) then
                                               Begin
                                                Assign(f,'FILMES.FIL');
                                                {$I-} Erase(f); {$I+}
                                                errada:=IOresult;
                                                erros_de_leitura(errada);
                                                if errada<>0 then goto errado
                                                             else
                                                              begin
                                                               conta_filmes:=1;
                                                               c:='N';
                                                               erros(17);
                                                               goto errado
                                                              end
                                               end;
                                              end
                                             else
                               BEGIN
                               flag:=Ver_existe_filme(d.nome,d,xx);
                               if flag then
                                        begin
                                         if deseja_apagar(d.nome) then
                                                            begin

                                                            { þ APAGAR þ }

                                                            dec(conta_filmes);
                                                            Assign(f,'FILMES.FIL');Reset(f);
                                                            Assign(f2,'AUXILIAR');
                                                            {$I-} Rewrite(f2); {$I+}
                                                            errada:=IOresult;
                                                            erros_de_leitura(errada);
                                                            if errada<>0 then
                                                                          begin
                                                                           c:='N';
                                                                           Close(f);
                                                                           goto errado
                                                                          end;
                                                            While not eof(f) do
                                                             begin
                                                              Read(f,d);
                                                              if d.numero<>xx then write(f2,d);
                                                             end;
                                                             Close(f);
                                                             Erase(f);
                                                             if filesize(f2)=0 then erase(f2)
                                                                               else
                                                                                begin
                                                                                 Close(f2);
                                                                                 Rename(f2,'FILMES.FIL')
                                                                                end;
                                                            end
                                        end
                                       else
                                        erros(6);
                               END
                              end
                             else
                              erros(6);
     if existe('FILMES.FIL') then
                              begin
                               mensagem(10);
                               c:=readkey;c:=Upcase(c)
                              end
                             else
                              c:='N';
     errado:
     Limpa_ecran;
     UNTIL c='N';
     rato
end;

{ þ MENU þ }

Procedure menu;

Begin
     rato;
     Repeat
      While ratotec=1 do begin end;
      Repeat until ratotec=1;
      if detecta(40,40,80,80) then
                               begin
                                Marca(40,40,80,80,true);
                                Entra_socio
                               end
                              else
      if detecta(80,40,120,80) then
                                begin
                                 Marca(80,40,120,80,true);
                                 Modifica_socio
                                end
                               else
      if detecta(120,40,160,80) then
                                 begin
                                  Marca(120,40,160,80,true);
                                  Exclui_socio
                                 end
                                else
      if detecta(160,40,200,80) then
                                 begin
                                  Marca(160,40,200,80,true);
                                  Listar_socios
                                 end
                                else
      if detecta(200,40,240,80) then
                                 begin
                                  Marca(200,40,240,80,true);
                                  Procura_so
                                 end
                                else
      if detecta(240,40,280,80) then
                                 begin
                                  Marca(240,40,280,80,true);
                                  Procura_mostra
                                 end
                                else
      if detecta(280,40,320,80) then
                                 begin
                                  Marca(280,40,320,80,true);
                                  Ajuda
                                 end
                                else
      if detecta(320,40,360,80) then
                                 begin
                                  Marca(320,40,360,80,true);
                                  Tabela_de_precos
                                 end
                                else
      if detecta(360,40,400,80) then
                                 begin
                                  Marca(360,40,400,80,true);
                                  Sai_filme
                                 end
                                else
      if detecta(400,40,440,80) then
                                 begin
                                  Marca(400,40,440,80,true);
                                  Entra_filme
                                 end
                                else
      if detecta(440,40,480,80) then
                                 begin
                                  Marca(440,40,480,80,true);
                                  Compra_filme
                                 end
                                else
      if detecta(480,40,520,80) then
                                 begin
                                  Marca(480,40,520,80,true);
                                  Modifica_filme
                                 end
                                else
      if detecta(520,40,560,80) then
                                 begin
                                  Marca(520,40,560,80,true);
                                  Listar_filmes
                                 end
                                else
      if detecta(560,40,600,80) then
                                 begin
                                  Marca(560,40,600,80,true);
                                  Exclui_filme
                                 end
                                else
      if detecta(600,40,640,80) then
                                 begin
                                  Marca(600,40,640,80,true);
                                  Relatorio
                                 end;
     until detecta(0,40,40,80);
     Marca(0,40,40,80,true);
     Closegraph
end;

Begin
     Inicia;
     Requerimentos;
     Cenario;
     Menu
end.