{****************************************************************************}
{*                                                                          *}
{*      TITULO        : AGENDA V.2.5                                        *}
{*                                                                          *}
{*      AUTOR         : Vasco Nascimento                                    *}
{*                                                                          *}
{*      PARA          : SPOOLER Magazine dos utilizadores PC                *}
{*                                                                          *}
{*      PROGRAMADO EM : TURBO PASCAL 6.0                                    *}
{*                                                                          *}
{*      FICHEIRO      : AGENDA.PAS                                          *}
{*                                                                          *}
{*      FUN€¶O        : Programa Principal                                  *}
{*                                                                          *}
{****************************************************************************}



PROGRAM Agenda_V_2_5;

  USES graph,crt,dos,tpmouse,ageintro,gtext,printer;





CONST defele='                             '+chr(13);
      inexist='---------------------------- '+chr(13);




{/////////////////////////////Tipos Declarados///////////////////////////////}



TYPE agenda=record
            nome:elementos;
            morada:elementos;
            loc:elementos;
            codpost:longint;
            dia:longint;
            mes:longint;
            ano:longint;
            tel:longint;
            idade:integer;
         end;

     pessoas = array[1..500] of agenda;
     tit = array[1..6] of string;



{//////////////////////////////Vari veis Globais/////////////////////////////}



  VAR gd,gm,contad,indice,auxindice,i,impy,coor1,coor2,x,y:integer;
      enc,ver,azu:word;
      year,month,day,dow:word;
      hora,minuto,segundo:word;
      d:char;
      errografico:integer;
      idade:integer;
      idadestr:string;
      titulo:string;
      bool,f,naoexiste,existe:boolean;
      mouse:mouseobj;
      agefile:file of agenda;
      age:agenda;
      Inventario:pessoas;
      titulos:tit;



{//////////////////////Procedures declaradas +   frente//////////////////////}



    Procedure Menuprin;forward;

    Procedure Ageprin;forward;

    Procedure Opcoes;forward;



{/////////////////////Procedure de ®Trashing¯ do teclado/////////////////////}



   Procedure LimpTec;
     var xpto:integer;
     begin
       xpto:=kb;
     end;



{///////////////////////////////////Som//////////////////////////////////////}



   Procedure Som;
     begin
       sound(200);
       delay(100);
       nosound;
     end;



{Fun‡Æo que Testa se 1 ano ‚ Bissexto.Retorna TRUE se f“r ou FALSE se nÆo f“r}



   Function Bissexto(ano:integer):boolean;
     begin
       if ((ano mod 400)=0) or (((ano mod 4)=0) and ((ano mod 100)<>0)) then
         bissexto:=true
       else
         bissexto:=false;
     end;



{////////////Imprime a VersÆo a data e o autor nos cantos do ecran///////////}



   Procedure versao;
     var dia,mes,ano,diasem,hund:word;
     begin
       settextstyle(0,0,1);
       setcolor(9);
       settextjustify(0,2);
       gettime(hora,minuto,segundo,hund);
       getdate(ano,mes,dia,diasem);
       outtextxy(576,10,intostr(hora,2)+':'+intostr(minuto,2)+':'+intostr(segundo,2));
       outtextxy(10,10,intostr(dia,2)+'/'+intostr(mes,2)+'/'+intostr(ano,4));
       outtextxy(10,470,'AGENDA Ver 2.5                                                Vasco Nascimento');
     end;



{////////////////////////Imprime e actualiza a hora//////////////////////////}



   Procedure horas;
     var h,m,s,hund,oldh,oldm,olds:word;
     begin
       settextstyle(0,0,1);
       settextjustify(0,2);
       setfillstyle(1,0);
       setcolor(9);
       oldh:=hora;
       oldm:=minuto;
       olds:=segundo;
       repeat
         gettime(h,m,s,hund);
         if (h>oldh) or (m>oldm) or (s>olds) then begin
           setcolor(0);
           mouse.hide;
           bar(576,10,640,16);
           oldh:=h;
           oldm:=m;
           olds:=s;
           setcolor(9);
           outtextxy(576,10,intostr(h,2)+':'+intostr(m,2)+':'+intostr(s,2));
           mouse.show;
         end;
       until keypressed or mouse.buttonpressed(leftbutton);
     end;



{/////////////////////////EcrÆ de altera‡Æo da data//////////////////////////}



   procedure alterdata;
     var dia,mes,ano,code1,code2,code3:word;
         s,s1,s2,s3:string;
         ok:boolean;

     begin
       setfillstyle(1,0);
       bar(0,0,640,480);
       settextstyle(1,0,5);
       settextjustify(1,2);
       setcolor(14);
       outtextxy(320,20,'ALTERAR DATA');
       setcolor(9);
       settextstyle(2,0,6);
       outtextxy(320,200,'Introduza uma nova data     (actual '+intostr(day,2)
                         +'/'+intostr(month,2)+'/'+intostr(year+1900,4)+')');
       settextjustify(0,2);
       setcolor(14);
       rectangle(258,295,377,324);
       repeat
         ok:=true;
         setfillstyle(1,15);
         bar(260,297,375,322);
         moveto(265,300);
         setcolor(9);
         readstr(s,10,15);
         s1:=s[1]+s[2];
         s2:=s[4]+s[5];
         s3:=s[7]+s[8]+s[9]+s[10];
         val(s1,dia,code1);
         val(s2,mes,code2);
         val(s3,ano,code3);
         if (code1<>0) or (code2<>0) or (code3<>0) or (s[3]<>'/') or (s[6]<>'/')
            or (s[0]<chr(10)) then ok:=false;
         if (not bissexto(ano)) and (mes=2) and (dia>28) then ok:=false;
         if (mes=2) and (dia>29) then ok:=false;
         if (odd(mes)) and (dia>30) then ok:=false;
         if (mes>12) or (mes<1) then ok:=false;
         if (dia>31) or (dia<1) then ok:=false;
         if ok=false then begin
           setcolor(4);
           settextjustify(1,1);
           outtextxy(320,350,'Data Inv lida : sintaxe correcta DD/MM/AAAA');
           delay(2000);
           setcolor(0);
           outtextxy(320,350,'Data Inv lida : sintaxe correcta DD/MM/AAAA');
           settextjustify(0,2);
         end;
       until ok;
       day:=dia;
       month:=mes;
       year:=ano-1900;
       setdate(ano,mes,dia);
     end;



{/////////////////////////EcrÆ de altera‡Æo da hora//////////////////////////}



   procedure alterhora;
     var h,m,code1,code2:word;
         s,s1,s2:string;
         ok:boolean;

     begin
       setfillstyle(1,0);
       bar(0,0,640,480);
       settextstyle(1,0,5);
       settextjustify(1,2);
       setcolor(14);
       outtextxy(320,20,'ALTERAR HORA');
       setcolor(9);
       settextstyle(2,0,6);
       outtextxy(320,200,'Introduza uma nova hora     (actual '+intostr(hora,2)+':'+intostr(minuto,2)+')');
       settextjustify(0,2);
       setcolor(14);
       rectangle(283,295,352,324);
       setcolor(9);
       repeat
         ok:=true;
         setfillstyle(1,15);
         bar(285,297,350,322);
         moveto(290,300);
         readstr(s,5,15);
         s1:=s[1]+s[2];
         s2:=s[4]+s[5];
         val(s1,h,code1);
         val(s2,m,code2);
         if (code1<>0) or (code2<>0) or (h>24) or (h<0) or (m>59) or (m<0)
           or (s[3]<>':') or (s[0]<chr(5)) then ok:=false;
       until ok;
       settime(h,m,0,0);
     end;




{//////////////////////BotÆo sem aur‚ola de actividade///////////////////////}



   Procedure BotaoXY(coor1,tam,larg:integer;cor1,cor2,cor3,cor4,letr1:word);
     begin
       setlinestyle(0,0,3);
       setfillstyle(1,cor1);
       bar(coor1,larg,coor1+tam,larg+30);
       setcolor(cor2);
       line(coor1,larg+30,coor1+tam,larg+30);
       line(coor1+tam,larg,coor1+tam,larg+30);
       setcolor(cor3);
       line(coor1,larg,coor1+tam,larg);
       line(coor1,larg,coor1,larg+30);
       putpixel(coor1+1,larg+30,cor2);
       putpixel(coor1+tam,larg+1,cor2);
       setlinestyle(0,0,1);
     end;



{//////////////////////////////////BotÆo OK//////////////////////////////////}


   Procedure OkButton;
     var c:integer;

     begin
       settextjustify(0,2);
       botaoxy(220,200,430,9,1,3,1,2);
       settextstyle(1,0,3);
       setcolor(14);
       outtextxy(250,430,'Enter - OK');
       repeat
         mouse.show;
         c:=mouse.waitforinput(leftbutton);
         mouse.hide;
         if c < 0 then begin
           mouse.getcoords(x,y);
           if mouse.inbox(220,430,420,460,x,y) then c:=13;
         end;
       until c=13;
       botaoxy(220,200,430,9,3,1,1,2);
       settextstyle(1,0,3);
       setcolor(14);
       outtextxy(250,430,'Enter - OK');
       som;
       delay(500);
     end;



{///////////////////////////Ecran de inexistˆncia////////////////////////////}



   Procedure Inexistente;
     var c:integer;

     begin
       setfillstyle(1,0);
       bar(0,100,640,480);
       setrgbpalette(5,0,0,20);
       setcolor(5);
       settextstyle(1,0,9);
       outtextxy(10,70,'?????????????');
       outtextxy(10,160,'?????????????');
       outtextxy(10,250,'?????????????');
       outtextxy(10,340,'?????????????');
       settextjustify(1,1);
       settextstyle(1,0,3);
       setcolor(4);
       outtextxy(320,240,'Pessoa nao encontrada na agenda');
       outtextxy(223,240,'~');
       settextjustify(1,2);
       botaoxy(220,200,400,9,1,3,1,2);
       settextstyle(1,0,3);
       setcolor(14);
       outtextxy(320,400,'Enter - OK');
       azu:=20;
       repeat
         repeat
           repeat
             setrgbpalette(5,0,0,azu);
             delay(20);
             azu:=azu+1;
           until (azu=63) or (keypressed);
           repeat
             setrgbpalette(5,0,0,azu);
             delay(20);
             azu:=azu-1;
           until (azu=20) or (keypressed);
         until (keypressed);
         c:=mouse.waitforinput(leftbutton);
       until c=13;
       botaoxy(220,200,400,9,3,1,1,2);
       settextstyle(1,0,3);
       setcolor(14);
       outtextxy(320,400,'Enter - OK');
       som;
       delay(500);
       setrgbpalette(5,20,20,50);
     end;



{//Fun‡Æo de inser‡Æo de dados.Retorna TRUE se Bem Sucedida ou FALSE se NÆo//}



   Function IntrPessoa:boolean;
     var c,contador,x,y:integer;
         boll:boolean;




     Procedure InputDia;
       begin
         with age do
           repeat
             moveto(240,220);
             setfillstyle(1,0);
             bar(240,220,257,233);
             readint(dia,2,0);
           until (dia>0) and (dia<=31);
       end;




     Procedure InputMes;
       begin
         with age do begin
           repeat
             moveto(270,220);
             setfillstyle(1,0);
             bar(270,220,287,233);
             readint(mes,2,0);
           until (mes>0) and (mes<=12);
           if (odd(mes)) and (dia>30) then begin
             repeat
               moveto(240,220);
               setfillstyle(1,0);
               bar(240,220,257,233);
               readint(dia,2,0);
             until (dia>0) and (dia<=30);
           end;
           if (mes=2) and (dia>29) then begin
             repeat
               moveto(240,220);
               setfillstyle(1,0);
               bar(240,220,257,233);
               readint(dia,2,0);
             until (dia>0) and (dia<=29);
           end;
         end;
       end;
           


     Procedure InputAno;
       begin
         with age do begin
           repeat
             moveto(300,220);
             setfillstyle(1,0);
             bar(300,220,317,233);
             readint(ano,2,0);
             if ano=0 then ano:=year+1;
           until ((year-ano)>=0);
           if not bissexto(ano) and (mes=2) and (dia>28) then begin
             repeat
               moveto(240,220);
               setfillstyle(1,0);
               bar(240,220,257,233);
               readint(dia,2,0);
             until (dia>0) and (dia<=28);
           end;
           if (ano>=year) and (mes>=month) and (dia>day) then begin
             ano:=year;
             mes:=month;
             dia:=day;
             bar(240,220,257,233);
             outtextxy(240,220,intostr(dia,2));
             bar(270,220,287,233);
             outtextxy(270,220,intostr(mes,2));
             bar(300,220,317,233);
             outtextxy(300,220,intostr(ano,2));
           end;
         end;
       end;





     begin
       with age do
       while c<>27 do begin
         mouse.show;
         c:=mouse.waitforinput(leftbutton);
         mouse.hide;
         if c < 0 then begin
           mouse.getcoords(x,y);
           if mouse.inbox(100,430,300,460,x,y) then c:=27;
           if mouse.inbox(320,430,520,460,x,y) then c:=13;
           if mouse.inbox(14,98,36,115,x,y) then c:=59;
           if mouse.inbox(14,128,36,145,x,y) then c:=60;
           if mouse.inbox(14,158,36,175,x,y) then c:=61;
           if mouse.inbox(14,188,36,205,x,y) then c:=62;
           if mouse.inbox(14,218,36,235,x,y) then c:=63;
           if mouse.inbox(14,248,36,275,x,y) then c:=64;
         end;
         case c of
           13:begin
                botaoxy(320,200,430,9,3,1,1,2);
                setcolor(14);
                settextstyle(1,0,3);
                outtextxy(355,430,'Enter - OK');
                som;
                delay(500);
                intrpessoa:=true;
                exit;
              end;
           27:begin
                botaoxy(100,200,430,9,3,1,1,2);
                setcolor(14);
                settextstyle(1,0,3);
                outtextxy(117,430,'Esc - Cancelar');
                som;
                delay(500);
                intrpessoa:=false;
                exit;
              end;
            59:begin
                 settextstyle(3,0,1);
                 setcolor(3);
                 outtextxy(50,93,'Nome:');
                 settextstyle(2,0,5);
                 setfillstyle(1,0);
                 repeat
                   boll:=true;
                   bar(116,98,600,112);
                   setcolor(9);
                   moveto(118,100);
                   readele(nome,29,0);
                   for contador:=1 to auxindice do
                     if inventario[contador].nome=nome then begin
                       boll:=false;
                       setcolor(4);
                       settextjustify(1,1);
                       outtextxy(320,370,'J  existe uma pessoa com esse nome na agenda,');
                       outtextxy(320,384,'Por favor repita');
                       settextjustify(0,2);
                       delay(2000);
                       bar(0,367,640,392);
                     end;
                 until boll=true;
                 settextstyle(3,0,1);
                 outtextxy(50,93,'Nome:');
               end;
            60:begin
                 settextstyle(3,0,1);
                 setcolor(3);
                 outtextxy(50,123,'Morada:');
                 settextstyle(2,0,5);
                 setfillstyle(1,0);
                 bar(128,128,640,142);
                 setcolor(9);
                 moveto(130,130);
                 readele(morada,29,0);
                 settextstyle(3,0,1);
                 outtextxy(50,123,'Morada:');
               end;
            61:begin
                 settextstyle(3,0,1);
                 setcolor(3);
                 outtextxy(50,153,'Localidade:');
                 settextstyle(2,0,5);
                 setfillstyle(1,0);
                 bar(153,158,640,172);
                 setcolor(9);
                 moveto(155,160);
                 readele(loc,10,0);
                 settextstyle(3,0,1);
                 outtextxy(50,153,'Localidade:');
               end;
            62:begin
                 settextstyle(3,0,1);
                 setcolor(3);
                 outtextxy(50,183,'Codigo Postal:');
                 settextstyle(2,0,5);
                 setfillstyle(1,0);
                 repeat
                   bar(178,188,640,202);
                   setcolor(9);
                   moveto(180,190);
                   readint(codpost,6,0);
                 until codpost>0;
                 settextstyle(3,0,1);
                 outtextxy(50,183,'Codigo Postal:');
               end;
            63:begin
                 settextstyle(3,0,1);
                 setcolor(3);
                 outtextxy(50,213,'Data de Nascimento:');
                 settextstyle(2,0,5);
                 outtextxy(260,220,'/');
                 outtextxy(290,220,'/');
                 setcolor(9);
                 inputdia;
                 inputmes;
                 inputano;
                 settextstyle(3,0,1);
                 outtextxy(50,213,'Data de Nascimento:');
               end;
            64:begin
                 settextstyle(3,0,1);
                 setcolor(3);
                 outtextxy(50,243,'N§ de Telefone:');
                 settextstyle(2,0,5);
                 setfillstyle(1,0);
                 repeat
                   repeat
                     bar(193,248,640,262);
                     setcolor(9);
                     moveto(195,250);
                     readint(tel,8,0);
                   until tel>0;
                   boll:=true;
                   for contador:=1 to auxindice do
                     if inventario[contador].tel=tel then begin
                       boll:=false;
                       setcolor(4);
                       settextjustify(1,1);
                       outtextxy(320,370,'J  existe uma pessoa com esse n§ de telefone na agenda,');
                       outtextxy(320,384,'Por favor repita');
                       settextjustify(0,2);
                       delay(2000);
                       bar(0,367,640,392);
                     end;
                 until boll=true;
                 settextstyle(3,0,1);
                 outtextxy(50,243,'N§ de Telefone:');
               end;
         end;
         if ano=year then idade:=0;
         if ano=0 then idade:=0;
         if (ano<>year) and (ano<>0) then
           begin
             Idade:=year-ano-1;
             if mes < month then idade:=idade+1;
             if (mes=month) and (dia <= day) then idade:=idade+1;
           end;
       end;
     end;



{////////////////////////Desenha as letras no botao//////////////////////////}



   Procedure Letras(cont:integer;letr:word);
     begin
       settextstyle(1,0,2);
       coor1:=320;
       case cont of
         3:titulo:=titulos[cont-2];
         4:titulo:=titulos[cont-2];
         5:titulo:=titulos[cont-2];
         6:titulo:=titulos[cont-2];
         7:titulo:=titulos[cont-2];
         8:titulo:=titulos[cont-2];
       end;
       settextjustify(1,2);
       setcolor(letr);
       outtextxy(coor1,coor2+3,titulo);
       settextjustify(0,2);
     end;



{///////////////////////////Activa|Desactiva botÆo///////////////////////////}



   Procedure Activimp(cor:word);
     begin
       setlinestyle(0,0,1);
       setcolor(cor);
       rectangle(112,impy-3,518,33+impy);
     end;



{/////////////////////////////Desenha um BotÆo///////////////////////////////}



   Procedure Botao(coor2:integer;cor1,cor2,cor3,cor4,letr:word);
     begin
       setlinestyle(0,0,3);
       setfillstyle(1,cor1);
       bar(115,coor2,515,30+coor2);
       setcolor(cor2);
       line(115,30+coor2,515,30+coor2);
       line(515,coor2,515,30+coor2);
       setcolor(cor3);
       line(115,coor2,515,coor2);
       line(115,coor2,115,30+coor2);
       putpixel(116,30+coor2,cor2);
       putpixel(515,coor2+1,cor2);
       i:=coor2 div 40;
       letras(i,letr);
       setlinestyle(0,0,1);
       setcolor(cor4);
       rectangle(112,coor2-3,518,33+coor2);
     end;



{////////////////////////Desce uma op‡Æo nos menus///////////////////////////}



   Procedure Avanca(cor:word);
     begin
       activimp(cor);
       impy:=impy-40;
       activimp(1);
       impy:=impy+40;
       sound(30);
       delay(100);
       nosound;
     end;



{////////////////////////Transforma o n§ do mˆs em nome//////////////////////}


    Function Meses(mes:integer):string;
      begin
        case mes of
          1:meses:='Janeiro';
          2:meses:='Fevereiro';
          3:meses:='Mar‡o';
          4:meses:='Abril';
          5:meses:='Maio';
          6:meses:='Junho';
          7:meses:='Julho';
          8:meses:='Agosto';
          9:meses:='Setembro';
         10:meses:='Outubro';
         11:meses:='Novembro';
         12:meses:='Dezembro';
       end;
     end;



{/////////////////////////Sobe uma op‡Æo nos menus///////////////////////////}



   Procedure Atrasa(cor:word);
     begin
       activimp(cor);
       impy:=impy+40;
       activimp(1);
       impy:=impy-40;
       sound(30);
       delay(100);
       nosound;
     end;



{////////////////////////////Ecran de Anivers rio////////////////////////////}



   Procedure Ver_Anos(indice:integer);
     var anostr,diastr,s:string;
     begin
       while keypressed do limptec;
       With Inventario[indice] do begin
         if (dia=day) and (mes=month) and (nome<>inexist) then begin
           settextjustify(1,2);
           setcolor(14);
           settextstyle(1,0,5);
           outtextxy(320,20,'ANIVERSARIOS');
           outtextxy(375,-15,',');
           setcolor(9);
           settextjustify(1,1);
           settextstyle(1,0,3);
           str(dia,diastr);
           str(ano,anostr);
           outtextxy(320,200,'Hoje dia '+diastr+' de '+meses(mes)+' faz anos...');
           s:=nome;
           setcolor(3);
           dec(s[0]);
           while s[length(s)]=chr(32) do dec(s[0]);
           outtextxy(320,300,s);
           okbutton;
           cleardevice;
         end;
       end;
     end;



{/////////////////////////////Ecran de Inser‡Æo//////////////////////////////}



    Procedure InsEcran;
      begin
       settextstyle(3,0,1);
       setcolor(9);
       setfillstyle(1,1);
       y:=98;
       repeat
         bar(14,y,36,y+17);
         rectangle(14,y,36,y+17);
         y:=y+30
       until y=278;
       setcolor(7);
       outtextxy(17,93,'F1');
       outtextxy(16,123,'F2');
       outtextxy(16,153,'F3');
       outtextxy(16,183,'F');
       outtextxy(24,183,'4');
       outtextxy(16,213,'F5');
       outtextxy(16,243,'F6');
       setcolor(9);
       bar(48,98,100,115);
       rectangle(48,98,100,115);
       outtextxy(50,93,'Nome:');
       bar(48,128,114,145);
       rectangle(48,128,114,145);
       outtextxy(50,123,'Morada:');
       bar(48,158,140,175);
       rectangle(48,158,140,175);
       outtextxy(50,153,'Localidade:');
       bar(48,188,167,207);
       rectangle(48,188,167,207);
       outtextxy(50,183,'Codigo Postal:');
       bar(48,218,226,235);
       rectangle(48,218,226,235);
       outtextxy(50,213,'Data de Nascimento:');
       bar(48,248,182,265);
       rectangle(48,248,182,265);
       outtextxy(50,243,'N§ de Telefone:');
       settextstyle(2,0,5);
       outtextxy(260,220,'/');
       outtextxy(290,220,'/');
       outtextxy(350,220,'DD/MM/AA');
       settextstyle(1,0,3);
       botaoxy(100,200,430,9,1,3,1,2);
       setcolor(14);
       outtextxy(117,430,'Esc - Cancelar');
       botaoxy(320,200,430,9,1,3,1,2);
       setcolor(14);
       outtextxy(355,430,'Enter - OK');
      end;



{///////////////////////Vˆ se a disquete est  protegida//////////////////////}



  function writeprotec:boolean;
    var valido,ok:boolean;
        ch:char;

    begin
      valido:=true;
      repeat
        ok:=true;
        {$I-}
          rewrite(agefile);
        {$I+}
        if ioresult=150 then begin
          setlinestyle(0,0,1);
          setfillstyle(1,15);
          bar(180,380,460,430);
          setcolor(12);
          rectangle(180,380,460,430);
          setcolor(4);
          rectangle(181,381,459,429);
          rectangle(181,381,459,430);
          settextstyle(0,0,1);
          setcolor(12);
          settextjustify(1,2);
          ok:=false;
          outtextxy(320,390,'Erro de protec‡ao contra grava‡ao');
          outtextxy(320,389,'               ~               ~ ');
          settextjustify(0,2);
          setcolor(1);
          outtextxy(253,410,'Repetir');
          outtextxy(253,412,'_');
          setcolor(4);
          outtextxy(324,410,'Cancelar');
          outtextxy(324,412,'_');
          repeat
            horas;
            ch:=readkey;
            ch:=upcase(ch);
          until (ch='C') or (ch='R');
          if ch='R' then begin
            ok:=false;
            valido:=true;
          end;
          if ch='C' then begin
            ok:=true;
            valido:=false;
          end;
        end;
      until ok;
      setfillstyle(1,0);
      bar(180,380,460,430);
      writeprotec:=valido;
    end;



{/////////////////////////////Procura por Nome///////////////////////////////}



   Procedure ProcNome(titulo:string);
      var nomes:elementos;
          x:integer;

      begin
        setfillstyle(1,0);
        bar(0,10,640,16);
        bar(0,100,640,480);
        setcolor(19);
        settextstyle(1,0,3);
        settextjustify(1,1);
        outtextxy(320,200,titulo);
        settextjustify(0,2);
        settextstyle(2,0,5);
        x:=(textwidth('M')*29)+215;
        setfillstyle(1,15);
        bar(195,320,x,345);
        setcolor(14);
        rectangle(195,320,x,345);
        setcolor(0);
        rectangle(196,321,x-1,344);
        setcolor(9);
        moveto(205,327);
        existe:=false;
        readele(nomes,29,15);
        contad:=0;
        repeat
          contad:=contad+1;
          if (inventario[contad].nome=nomes) then begin
            existe:=true;
          end;
        until (existe=true) or (contad=auxindice);
      end;



{///////////////////////////Procura por Telefone/////////////////////////////}



    Procedure ProcTel(titulo:string);
      var tels:longint;
          x:integer;

      begin
        setfillstyle(1,0);
        bar(0,10,640,16);
        bar(0,100,640,480);
        settextstyle(1,0,3);
        setcolor(9);
        settextjustify(1,1);
        outtextxy(320,200,titulo);
        settextjustify(0,2);
        settextstyle(2,0,5);
        x:=(textwidth('M')*8)+292;
        setfillstyle(1,15);
        bar(275,320,x,345);
        setcolor(14);
        rectangle(275,320,x,345);
        setcolor(0);
        rectangle(276,321,x-1,344);
        setcolor(9);
        existe:=false;
        repeat
          bar(283,325,x-2,340);
          setcolor(9);
          moveto(285,327);
          readint(tels,8,15);
          if tels=0 then begin
            setcolor(4);
            settextjustify(1,2);
            outtextxy(320,400,'Numero incorrecto por favor repita');
            delay(2000);
            setcolor(0);
            outtextxy(320,400,'Numero incorrecto por favor repita');
            settextjustify(0,2);
          end;
        until tels>0;
        contad:=0;
        repeat
          contad:=contad+1;
          if (inventario[contad].tel=tels) then begin
            existe:=true;
          end;
        until (existe=true) or (contad=auxindice);
      end;



{////////////////////////////Procura por Numero//////////////////////////////}



    Procedure ProcNum(titulo:string);
      var num:longint;
          x:integer;

      begin
        setfillstyle(1,0);
        bar(0,10,640,16);
        bar(0,100,640,480);
        settextstyle(1,0,3);
        settextjustify(1,1);
        setcolor(3);
        outtextxy(320,200,titulo);
        settextjustify(0,2);
        settextstyle(2,0,5);
        x:=(textwidth('M')*3)+312;
        setfillstyle(1,15);
        bar(295,320,x,345);
        setcolor(14);
        rectangle(295,320,x,345);
        setcolor(0);
        rectangle(296,321,x-1,344);
        setcolor(9);
        existe:=true;
        repeat
          bar(303,325,x-2,340);
          setcolor(9);
          moveto(305,327);
          readint(num,3,15);
          if num=0 then begin
            setcolor(4);
            settextjustify(1,2);
            outtextxy(320,400,'Numero incorrecto por favor repita');
            delay(2000);
            setcolor(0);
            outtextxy(320,400,'Numero incorrecto por favor repita');
            settextjustify(0,2);
          end;
        until num>0;
        if (num>auxindice-1) then existe := false;
        contad:=num;
      end;



{//////////////////////////////Menu de Inser‡Æo//////////////////////////////}



   Procedure Inserir;
     var contad,c,x,y:integer;
         bool:boolean;

     begin
       indice:=auxindice;
       setfillstyle(1,0);
       bar(0,0,640,480);
       settextstyle(1,0,5);
       settextjustify(1,2);
       setcolor(14);
       outtextxy(320,20,'INSERIR PESSOA');
       settextjustify(0,2);
       if indice=501 then begin
         settextjustify(1,1);
         settextstyle(1,0,1);
         setcolor(4);
         outtextxy(320,240,'Vocˆ atingiu o m ximo de 500 pessoas na agenda.');
         outtextxy(320,260,'Ter  que retirar alguma para poder inserir uma nova.');
         okbutton;
         exit;
       end;
       insecran;
       setcolor(9);
       moveto(118,100);
       with age do
         begin
           nome:=inexist;
           morada:='-----------------------------'+chr(13);
           loc:='----------                   '+chr(13);
           codpost:=0;
           tel:=0;
           dia:=0;
           mes:=0;
           ano:=0;
         end;
       bool:=intrpessoa;
       if bool then begin
         inventario[indice]:=age;
         auxindice:=auxindice+1;
       end;
     end;



{////////////////////////////Menu de Modifica‡Æo/////////////////////////////}



   Procedure Modificar;
     var x,y,c:integer;
         bool:boolean;
         ch:char;
         telstr,diastr,mestr,anostr,codpostr,sex2,elem:string;

     begin
       titulos[1]:='Por Nome';
       titulos[2]:='Por N§ de Telefone';
       titulos[3]:='Por N§ da Agenda';
       titulos[4]:='Sair';
       setfillstyle(1,0);
       bar(0,0,640,480);
       versao;
       settextstyle(1,0,5);
       setcolor(14);
       settextjustify(1,1);
       outtextxy(320,50,'MODIFICAR PESSOA');
       settextjustify(0,2);
       coor2:=140;
       impy:=140;
       repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
       until coor2=300;
       impy:=140;
       activimp(7);
       while c <> 251 do
         begin
           mouse.show;
           horas;
           c:=mouse.waitforinput(leftbutton);
           mouse.hide;
           if c < 0 then begin
              mouse.getcoords(x,y);
              activimp(7);
              if mouse.inbox (115,140,515,170,x,y) then begin
                activimp(1);
                impy:=140;
                c:=13;
              end;
              if mouse.inbox (115,180,515,210,x,y) then begin
                activimp(1);
                impy:=180;
                c:=13;
              end;
              if mouse.inbox (115,220,515,250,x,y) then begin
                activimp(1);
                impy:=220;
                c:=13;
              end;
              if mouse.inbox (115,260,515,290,x,y) then begin
                activimp(1);
                impy:=260;
                c:=13;
              end;
           end;
           if c= 27 then begin
             activimp(1);
             impy:=260;
             c:=13;
           end;
           if c = 80 then begin
             impy:=impy+40;
             if impy = 300 then begin
                impy:=impy-40;
                activimp(1);
                impy:=140;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
               avanca(7);
           end;
           if c = 72 then begin
             impy:=impy-40;
             if impy=100 then begin
                impy:=impy+40;
                activimp(1);
                impy:=260;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
                atrasa(7);
           end;
           if c = 13 then begin
              case impy of

                140:begin
                      som;
                      coor2:=140;
                      botao(140,9,3,1,7,14);
                      delay(500);
                      botao(140,9,1,3,9,14);
                      procnome('Qual o nome da pessoa que deseja modificar ?');
                      c:=251;
                    end;

                180:begin
                      som;
                      coor2:=180;
                      botao(180,9,3,1,7,14);
                      delay(500);
                      botao(180,9,1,3,7,14);
                      proctel('Qual o telefone da pessoa que deseja modificar ?');
                      c:=251;
                    end;

                220:begin
                      som;
                      coor2:=220;
                      botao(220,9,3,1,7,14);
                      delay(500);
                      botao(220,9,1,3,1,14);
                      procnum('Qual o N§ da pessoa que deseja modificar ?');
                      c:=251;
                    end;

                260:begin
                      som;
                      coor2:=260;
                      botao(260,9,3,1,7,14);
                      delay(500);
                      botao(260,9,1,3,1,14);
                      ageprin;
                      closegraph;
                      halt(1);
                    end;
              end;
              impy:=140;
           end;
       end;
       c:=0;
       if not existe then inexistente;
       if existe then begin
       age:=inventario[contad];
       setfillstyle(1,0);
       bar(0,0,640,480);
       setcolor(14);
       settextjustify(1,1);
       settextstyle(1,0,5);
       outtextxy(320,20,'MODIFICAR PESSOA');
       settextjustify(0,2);
       insecran;
       setcolor(9);
       with age do begin
          settextstyle(2,0,5);
          str(codpost,codpostr);
          str(mes,mestr);
          if length(mestr)=1 then mestr:='0'+mestr;
          str(ano,anostr);
          if length(anostr)=1 then anostr:='0'+anostr;
          str(dia,diastr);
          if length(diastr)=1 then diastr:='0'+diastr;
          str(tel,telstr);
          if codpostr='0' then codpostr:='------';
          if mestr='00' then mestr:='--';
          if anostr='00' then anostr:='--';
          if diastr='00' then diastr:='--';
          if telstr='0' then telstr:='--------';
          outtextxy(118,100,nome);
          outtextxy(130,130,morada);
          outtextxy(155,160,loc);
          outtextxy(180,190,codpostr);
          outtextxy(240,220,diastr);
          outtextxy(270,220,mestr);
          outtextxy(300,220,anostr);
          outtextxy(195,250,telstr);
       end;
       bool:=intrpessoa;
       if bool then inventario[contad]:=age;
      end;
     end;



{//////////////////////////////Menu de Remo‡Æo///////////////////////////////}



   Procedure Remover;
     var c,x,y,remove:integer;
         nomes:elementos;
         ch:char;

     begin
       titulos[1]:='Por Nome';
       titulos[2]:='Por N§ de Telefone';
       titulos[3]:='Por N§ da Agenda';
       titulos[4]:='Sair';
       setfillstyle(1,0);
       bar(0,0,640,480);
       versao;
       settextstyle(1,0,5);
       settextjustify(1,2);
       setcolor(14);
       outtextxy(320,20,'REMOVER PESSOA');
       settextjustify(0,2);
       coor2:=140;
       impy:=140;
       repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
       until coor2=300;
       impy:=140;
       activimp(7);
       while c <> 251 do
         begin
           mouse.show;
           horas;
           c:=mouse.waitforinput(leftbutton);
           mouse.hide;
           if c < 0 then begin
              mouse.getcoords(x,y);
              activimp(7);
              if mouse.inbox (115,140,515,170,x,y) then begin
                activimp(1);
                impy:=140;
                c:=13;
              end;
              if mouse.inbox (115,180,515,210,x,y) then begin
                activimp(1);
                impy:=180;
                c:=13;
              end;
              if mouse.inbox (115,220,515,250,x,y) then begin
                activimp(1);
                impy:=220;
                c:=13;
              end;
              if mouse.inbox (115,260,515,290,x,y) then begin
                activimp(1);
                impy:=260;
                c:=13;
              end;
           end;
           if c=27 then begin
             activimp(1);
             impy:=260;
             c:=13;
           end;
           if c = 80 then begin
             impy:=impy+40;
             if impy = 300 then begin
                impy:=impy-40;
                activimp(1);
                impy:=140;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
               avanca(7);
           end;
           if c = 72 then begin
             impy:=impy-40;
             if impy=100 then begin
                impy:=impy+40;
                activimp(1);
                impy:=260;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
                atrasa(7);
           end;
           if c = 13 then begin
              case impy of

                140:begin
                      som;
                      coor2:=140;
                      botao(140,9,3,1,7,14);
                      delay(500);
                      botao(140,9,1,3,9,14);
                      procnome('Qual o nome da pessoa que deseja remover ?');
                      c:=251;
                    end;

                180:begin
                      som;
                      coor2:=180;
                      botao(180,9,3,1,7,14);
                      delay(500);
                      botao(180,9,1,3,1,14);
                      proctel('Qual o telefone da pessoa que deseja remover ?');
                      c:=251;
                    end;

                220:begin
                      som;
                      coor2:=220;
                      botao(220,9,3,1,7,14);
                      delay(500);
                      botao(220,9,1,3,1,14);
                      procnum('Qual o N§ da pessoa que deseja remover ?');
                      c:=251;
                    end;

                260:begin
                      som;
                      coor2:=260;
                      botao(260,9,3,1,7,14);
                      delay(500);
                      botao(260,9,1,3,1,14);
                      ageprin;
                      closegraph;
                      halt(1);
                    end;
              end;
              impy:=140;
           end;
       end;
       c:=0;
           if existe then begin
             for remove:=contad to auxindice do
               begin
                 inventario[remove]:=inventario[remove+1];
               end;
             auxindice:=auxindice-1;
             settextstyle(1,0,3);
             setcolor(4);
             setfillstyle(1,0);
             bar(0,100,640,480);
             settextjustify(1,1);
             outtextxy(320,240,'A pessoa foi apagada da agenda');
             okbutton;
           end;
           if not existe then inexistente;
         end;



{//////////////////////////////Menu de Procura///////////////////////////////}



   Procedure Procurar;
     var c,x,y,dia1,mes1,ano1,idade1:integer;
       codpost1,tel1,cabecalho,diastr,mestr,anostr,nasc1:string;
       nomes,nome1,morada1,sex1,loc1:elementos;
       ch:char;

     begin
       titulos[1]:='Por Nome';
       titulos[2]:='Por N§ de Telefone';
       titulos[3]:='Por N§ da Agenda';
       titulos[4]:='Sair';
       setfillstyle(1,0);
       bar(0,0,640,480);
       versao;
       settextstyle(1,0,5);
       setcolor(14);
       settextjustify(1,2);
       outtextxy(320,20,'PROCURAR PESSOA');
       settextjustify(0,2);
       coor2:=140;
       impy:=140;
       repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
       until coor2=300;
       impy:=140;
       activimp(7);
       while c <> 251 do
         begin
           mouse.show;
           horas;
           c:=mouse.waitforinput(leftbutton);
           mouse.hide;
           if c < 0 then begin
              mouse.getcoords(x,y);
              activimp(7);
              if mouse.inbox (115,140,515,170,x,y) then begin
                activimp(1);
                impy:=140;
                c:=13;
              end;
              if mouse.inbox (115,180,515,210,x,y) then begin
                activimp(1);
                impy:=180;
                c:=13;
              end;
              if mouse.inbox (115,220,515,250,x,y) then begin
                activimp(1);
                impy:=220;
                c:=13;
              end;
              if mouse.inbox (115,260,515,290,x,y) then begin
                activimp(1);
                impy:=260;
                c:=13;
              end;
           end;
           if c=27 then begin
             activimp(1);
             impy:=260;
             c:=13;
           end;
           if c = 80 then begin
             impy:=impy+40;
             if impy = 300 then begin
                impy:=impy-40;
                activimp(1);
                impy:=140;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
               avanca(7);
           end;
           if c = 72 then begin
             impy:=impy-40;
             if impy=100 then begin
                impy:=impy+40;
                activimp(1);
                impy:=260;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
                atrasa(7);
           end;
           if c = 13 then begin
              case impy of

                140:begin
                      som;
                      coor2:=140;
                      botao(140,9,3,1,7,14);
                      delay(500);
                      botao(140,9,1,3,9,14);
                      procnome('Qual o nome da pessoa que deseja procurar ?');
                      c:=251;
                    end;

                180:begin
                      som;
                      coor2:=180;
                      botao(180,9,3,1,7,14);
                      delay(500);
                      botao(180,9,1,3,1,14);
                      proctel('Qual o telefone da pessoa que deseja procurar ?');
                      c:=251;
                    end;

                220:begin
                      som;
                      coor2:=220;
                      botao(220,9,3,1,7,14);
                      delay(500);
                      botao(220,9,1,3,1,14);
                      procnum('Qual o N§ da pessoa que deseja procurar ?');
                      c:=251;
                    end;

                260:begin
                      som;
                      coor2:=260;
                      botao(260,9,3,1,7,14);
                      delay(500);
                      botao(260,9,1,3,1,14);
                      ageprin;
                      closegraph;
                      halt(1);
                    end;
              end;
              impy:=140;
           end;
       end;
       c:=0;
       if existe then begin
         with inventario[contad] do
           begin
             nome1:=nome;
             morada1:=morada;
             loc1:=loc;
             dia1:=dia;
             mes1:=mes;
             ano1:=ano;
             idade1:=idade;
             str(codpost,codpost1);
             str(tel,tel1);
           end;
         if tel1='0' then tel1:='---------';
         if codpost1='0' then codpost1:='------';
         if idade1=0 then begin
           idadestr:='--';
           nasc1:='--/--/--';
         end
         else begin
           str(idade1,idadestr);
           str(dia1,diastr);
           str(mes1,mestr);
           str(ano1+1900,anostr);
           nasc1:=diastr+'/'+mestr+'/'+anostr;
         end;
         setfillstyle(1,0);
         bar(0,70,640,480);
         setcolor(3);
         rectangle(50,183,590,287);
         rectangle(53,180,587,290);
         setfillstyle(1,3);
         floodfill(56,181,3);
         floodfill(51,190,3);
         floodfill(56,288,3);
         floodfill(588,285,3);
         pieslice(53,287,180,270,3);
         pieslice(587,287,270,360,3);
         pieslice(587,183,0,90,3);
         setfillstyle(1,15);
         floodfill(300,230,3);
         setcolor(3);
         line(53,207,587,207);
         line(53,219,587,219);
         line(53,231,587,231);
         line(53,243,587,243);
         line(53,255,587,255);
         line(53,267,587,267);
         line(53,279,587,279);
         setcolor(4);
         line(75,184,75,286);
         line(580,184,580,286);
         settextstyle(1,0,1);
         str(contad,cabecalho);
         cabecalho:='N§ '+cabecalho;
         x:=textwidth(cabecalho)+73;
         setcolor(3);
         rectangle(50,155,x+3,183);
         rectangle(53,152,x,183);
         setfillstyle(1,3);
         floodfill(51,170,3);
         floodfill(x+1,170,3);
         floodfill(60,153,3);
         pieslice(53,155,90,180,3);
         pieslice(x,155,0,90,3);
         putpixel(x+4,179,3);
         setfillstyle(1,15);
         floodfill(54,158,3);
         setcolor(1);
         outtextxy(65,156,cabecalho);
         settextstyle(0,0,1);
         setcolor(1);
         nome1[30]:=' ';
         outtextxy(80,211,'Nome : '+nome1);
         morada1[30]:=' ';
         loc1[30]:=' ';
         outtextxy(80,223,'Morada : '+morada1+' '+codpost1+' '+loc1);
         outtextxy(80,235,'Data de Nascimento : '+nasc1);
         outtextxy(80,247,'Idade : '+idadestr);
         outtextxy(80,259,'Telefone : '+tel1);
         settextjustify(1,2);
         setcolor(15);
         okbutton;
       end;
       if not existe then inexistente;
     end;



{//////////////////////////////Lista da Agenda///////////////////////////////}



    Procedure AgeForm;

      var z,count,contador,page,m,x1,y1:integer;
          loc1:elementos;
          bottom,top:boolean;
          nomes,marg2,marg1,tel1,contstr,codstr:string;

      Procedure LimpAge;
        var y:integer;

        begin
          y:=97;
          setfillstyle(1,5);
          repeat
            bar(34,y,62,y+22);
            bar(68,y,256,y+10);
            bar(68,y+12,256,y+22);
            bar(262,y,470,y+10);
            bar(262,y+12,470,y+22);
            bar(476,y,551,y+22);
            bar(557,y,605,y+22);
            y:=y+25;
          until y>=400;
        end;
                 

      Procedure Paginar;
        begin
         if auxindice=1 then exit;
         repeat
          settextjustify(2,2);
          settextstyle(0,0,1);
          setcolor(0);
          str(contador,contstr);
          outtextxy(62,y,contstr);
          with inventario[contador] do begin
            str(tel,tel1);
            if tel1='0' then tel1:='---------';
            outtextxy(551,y,tel1);
            str(idade,idadestr);
            if idade=0 then idadestr:='--';
            outtextxy(590,y,idadestr);
            str(codpost,codstr);
            if codstr='0' then codstr:='------';
            settextjustify(0,2);
            marg2:=copy(nome,23,7);
            marg1:=copy(nome,1,22)+'-';
            outtextxy(70,y-5,marg1);
            outtextxy(70,y+7,marg2);
            loc1:=loc;
            loc1[30]:=' ';
            marg2:=copy(morada,26,4)+' '+codstr+' '+loc1;
            marg1:=copy(morada,1,25)+'-';
            outtextxy(264,y-5,marg1);
            outtextxy(264,y+7,marg2);
          end;
          y:=y+25;
          page:=page+1;
          contador:=contador+1;
         until (page=14) or (contador=auxindice);
        end;



      begin
        bottom:=true;
        setrgbpalette(5,55,55,55);
        setfillstyle(1,5);
        bar(33,60,608,430);
        setcolor(3);
        rectangle(28,55,613,435);
        rectangle(33,60,608,430);
        setfillstyle(1,3);
        floodfill(30,58,3);
        bar(33,80,608,84);
        z:=95;
        repeat
          rectangle(33,z,608,z+1);
          z:=z+13;
          line(67,z,471,z);
          z:=z+12;
        until z >396;
        rectangle(33,z,608,z+1);
        bar(63,60,67,430);
        bar(257,60,261,430);
        bar(471,60,475,430);
        bar(552,60,556,430);
        setcolor(1);
        settextstyle(1,0,1);
        outtextxy(37,58,'N§');
        outtextxy(139,58,'Nome');
        outtextxy(338,58,'Morada');
        outtextxy(479,58,'Telefone');
        outtextxy(560,58,'Idade');
        botaoxy(8,198,445,9,1,3,1,2);
        botaoxy(221,198,445,9,1,3,1,2);
        botaoxy(434,198,445,9,1,3,1,2);
        setcolor(14);
        settextstyle(1,0,3);
        outtextxy(80,443,'PgUp');
        outtextxy(506,443,'PgDn');
        outtextxy(263,445,'Esc - Sair');
        settextstyle(0,0,1);
        setcolor(0);
        y:=105;
        page:=1;
        contador:=1;
        bottom:=false;
        paginar;
        repeat
         settextstyle(1,0,3);
         if (contador=auxindice) then begin
           if bottom=false then begin
             setcolor(3);
             outtextxy(506,443,'PgDn');
           end;
           bottom:=true;
         end;
         if contador<auxindice then begin
           bottom:=false;
           setcolor(14);
           outtextxy(506,443,'PgDn');
         end;
         if (contador<=14) then begin
           setcolor(3);
           outtextxy(80,443,'PgUp');
           top:=true;
         end;
         if contador>14 then begin
           setcolor(14);
           outtextxy(80,443,'PgUp');
           top:=false;
         end;
         repeat
           mouse.show;
           m:=mouse.waitforinput(leftbutton);
           mouse.hide;
           if m < 0 then begin
             mouse.getcoords(x1,y1);
             if mouse.inbox(8,445,206,475,x1,y1) then m:=073;
             if mouse.inbox(221,445,419,475,x1,y1) then m:=27;
             if mouse.inbox(434,445,632,475,x1,y1) then m:=081;
           end;
           case m of
             27:begin
                  botaoxy(221,198,445,9,3,1,1,2);
                  setcolor(14);
                  settextstyle(1,0,3);
                  outtextxy(263,445,'Esc - Sair');
                  som;
                  delay(500);
                  botaoxy(221,198,445,9,1,3,1,2);
                  exit;
                end;
            073:begin
                  if not top then begin
                    botaoxy(8,198,445,9,3,1,1,2);
                    setcolor(14);
                    settextstyle(1,0,3);
                    outtextxy(80,443,'PgUp');
                    som;
                    delay(500);
                    botaoxy(8,198,445,9,1,3,1,2);
                    if contador>14 then begin
                      setcolor(14);
                      outtextxy(80,443,'PgUp');
                      top:=false;
                    end;
                    limpage;
                    if bottom then contador:=contador-(12+page)
                    else contador:=contador-(13+page);
                    if contador<1 then contador:=1;
                    y:=105;
                    page:=1;
                    paginar;
                  end;
                end;
            081:begin
                  if not bottom then begin
                    botaoxy(434,198,445,9,3,1,1,2);
                    setcolor(14);
                    settextstyle(1,0,3);
                    outtextxy(506,443,'PgDn');
                    som;
                    delay(500);
                    botaoxy(434,198,445,9,1,3,1,2);
                    if contador<auxindice then begin
                      bottom:=false;
                      setcolor(14);
                      outtextxy(506,443,'PgDn');
                    end;
                    limpage;
                    if contador=auxindice then contador:=contador-(page-1);
                    y:=105;
                    page:=1;
                    paginar;
                  end;
                end;
           end;
         until (m=27) or (m=073) or (m=081);
        until m=27;
     end;



{/////////////////////////////Ordena‡Æo por nome/////////////////////////////}



    Procedure OrdeNome;
      var ch:char;


        procedure quicksort(continic, contfin: integer; var ordnom: pessoas);
          var
            auxcont1,auxcont2:integer;
            item1,item2: agenda;

          begin
            auxcont1:=continic;
            auxcont2 := contfin;
            item1:=ordnom[(continic+contfin) div 2];
            repeat
              while ordnom[auxcont1].nome < item1.nome do auxcont1:=auxcont1+1;
                while item1.nome < ordnom[auxcont2].nome do auxcont2:=auxcont2-1;
                  if auxcont1<=auxcont2 then
                    begin
                      item2:=ordnom[auxcont1];
                      ordnom[auxcont1]:=ordnom[auxcont2];
                      ordnom[auxcont2]:=item2;
                      auxcont1:=auxcont1+1;
                      auxcont2:=auxcont2-1;
                    end;
            until auxcont1>auxcont2;
            if continic<auxcont2 then quicksort(continic,auxcont2,ordnom);
            if continic<contfin then quicksort(auxcont1,contfin, ordnom)
          end;


       begin
         setfillstyle(1,0);
         bar(0,0,640,480);
         settextstyle(1,0,5);
         setcolor(14);
         settextjustify(1,1);
         outtextxy(320,20,'Organizacao Alfab‚tica');
         settextstyle(1,0,3);
         outtextxy(276,33,',');
         outtextxy(288,20,'~');
         setcolor(4);
         if auxindice > 200 then outtextxy(320,200,'Espere um Momento S.F.F.');
         settextjustify(0,2);
         quicksort(1,auxindice-1,inventario);
         ageform;
       end;



{///////////////////////////Ordena‡Æo por Idade//////////////////////////////}



     Procedure OrdIdade;
        var ch:char;

        procedure quicksort(continic, contfin: integer; var ordid: pessoas);
          var
            auxcont1,auxcont2:integer;
            item1,item2: agenda;
          begin
            auxcont1:=continic;
            auxcont2 := contfin;
            item1:=ordid[(continic+contfin) div 2];
            repeat
              while ordid[auxcont1].idade < item1.idade do auxcont1:=auxcont1+1;
                while item1.idade < ordid[auxcont2].idade do auxcont2:=auxcont2-1;
                  if auxcont1<=auxcont2 then
                    begin
                      item2:=ordid[auxcont1];
                      ordid[auxcont1]:=ordid[auxcont2];
                      ordid[auxcont2]:=item2;
                      auxcont1:=auxcont1+1;
                      auxcont2:=auxcont2-1;
                    end;
            until auxcont1>auxcont2;
            if continic<auxcont2 then quicksort(continic,auxcont2,ordid);
            if continic<contfin then quicksort(auxcont1,contfin, ordid)
          end;

       begin
         setfillstyle(1,0);
         bar(0,0,640,480);
         settextstyle(1,0,5);
         setcolor(14);
         settextjustify(1,1);
         outtextxy(320,20,'Organizacao Cronol¢gica');
         settextstyle(1,0,3);
         outtextxy(276,33,',');
         outtextxy(288,20,'~');
         setcolor(4);
         if auxindice > 30 then outtextxy(320,200,'Espere um Momento S.F.F.');
         settextjustify(0,2);
         quicksort(1,auxindice-1,inventario);
         ageform;
       end;



{////////////////////////////Menu de Listar//////////////////////////////////}



  Procedure Listar;

    var  i,y,car,x: integer;

     begin
       titulos[2]:='Por ordem alfab‚tica';
       titulos[3]:='Por idade';
       titulos[4]:='Sair';
       setfillstyle(1,0);
       bar(0,0,640,480);
       versao;
       settextstyle(1,0,5);
       setcolor(14);
       settextjustify(1,2);
       outtextxy(320,20,'LISTAR PESSOAS');
       settextjustify(0,2);
       coor2:=180;
       impy:=180;
       repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
       until coor2=300;
       impy:=180;
       activimp(7);
       while car <> 27 do
         begin
           mouse.show;
           horas;
           car:=mouse.waitforinput(leftbutton);
           if car < 0 then begin
              mouse.getcoords(x,y);
              mouse.hide;
              activimp(7);
              if mouse.inbox (115,180,515,210,x,y) then begin
                activimp(1);
                impy:=180;
                car:=13;
              end;
              if mouse.inbox (115,220,515,250,x,y) then begin
                activimp(1);
                impy:=220;
                car:=13;
              end;
              if mouse.inbox (115,260,515,290,x,y) then begin
                activimp(1);
                impy:=260;
                car:=13;
              end;
              mouse.show;
           end;
           if car = 80 then begin
             impy:=impy+40;
             mouse.hide;
             if impy = 300 then begin
                impy:=impy-40;
                activimp(1);
                impy:=180;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
               avanca(7);
               mouse.show;
           end;
           if car = 72 then begin
             impy:=impy-40;
             mouse.hide;
             if impy=140 then begin
                impy:=impy+40;
                activimp(1);
                impy:=260;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
                atrasa(7);
                mouse.show;
           end;
           if car = 13 then begin
              case impy of
                180:begin
                      mouse.hide;;
                      som;
                      coor2:=180;
                      botao(180,9,3,1,7,14);
                      delay(500);
                      botao(180,9,1,3,9,14);
                      ordenome;
                      listar;
                      closegraph;
                      halt(1);
                    end;

                220:begin
                      mouse.hide;
                      som;
                      coor2:=220;
                      botao(220,9,3,1,7,14);
                      delay(500);
                      botao(220,9,1,3,1,14);
                      ordidade;
                      listar;
                      closegraph;
                      halt(1);
                    end;

                260:begin
                      mouse.hide;
                      som;
                      coor2:=260;
                      botao(260,9,3,1,7,14);
                      delay(500);
                      botao(260,9,1,3,1,14);
                      ageprin;
                      closegraph;
                      halt(1);
                    end;
              end;
              impy:=180;
              activimp(7);
           end;
         end;
         mouse.hide;
         activimp(1);
         som;
         coor2:=260;
         botao(260,9,3,1,7,14);
         delay(500);
         botao(260,9,1,3,1,14);
         ageprin;
         closegraph;
         halt(1);
      end;



{/////////////////////////////Menu da Agenda/////////////////////////////////}



  Procedure Ageprin;
    var  i,y,car,x: integer;

    begin
      titulos[1]:='Inserir Pessoa';
      titulos[2]:='Remover Pessoa';
      titulos[3]:='Procurar Pessoa';
      titulos[4]:='Modificar Pessoa';
      titulos[5]:='Listar Pessoas';
      titulos[6]:='Sair';
      if keypressed then limptec;
      cleardevice;
      impy:=140;
      setrgbpalette(3,20,30,52);
      setfillstyle(1,0);
      bar(0,0,640,480);
      versao;
      settextstyle(1,0,5);
      setcolor(14);
      settextjustify(1,2);
      outtextxy(320,20,'AGENDA');
      settextjustify(0,2);
      coor2:=140;
      setlinestyle(0,0,3);
      settextstyle(1,0,2);
      repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
      until coor2=380;
      activimp(7);
      if keypressed then limptec;
      while car <> 27 do begin
        mouse.show;
        horas;
        car:=mouse.waitforinput(leftbutton);
        if car < 0 then begin
           mouse.getcoords(x,y);
           mouse.hide;
           activimp(7);
           if mouse.inbox (115,140,515,170,x,y) then begin
              activimp(1);
              impy:=140;
              car:=13;
           end;
           if mouse.inbox (115,180,515,210,x,y) then begin
              activimp(1);
              impy:=180;
              car:=13;
           end;
           if mouse.inbox (115,220,515,250,x,y) then begin
              activimp(1);
              impy:=220;
              car:=13;
           end;
           if mouse.inbox (115,260,515,290,x,y) then begin
              activimp(1);
              impy:=260;
              car:=13;
           end;
           if mouse.inbox (115,300,515,330,x,y) then begin
              activimp(1);
              impy:=300;
              car:=13;
           end;
           if mouse.inbox (115,340,515,370,x,y) then begin
              activimp(1);
              impy:=340;
              car:=13;
           end;
           mouse.show;
        end;
        if car = 80 then begin
           mouse.hide;
           impy:=impy+40;
           if impy = 380 then begin
              impy:=impy-40;
              activimp(1);
              impy:=140;
              activimp(7);
              sound(30);
              delay(100);
              nosound;
           end
           else
             avanca(7);
             mouse.show;
        end;
       if car = 72 then begin
          mouse.hide;
          impy:=impy-40;
          if impy=100 then begin
             impy:=impy+40;
             activimp(1);
             impy:=340;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 13 then begin
          case impy of
             140:begin
                   som;
                   coor2:=140;
                   mouse.hide;
                   botao(140,9,3,1,7,14);
                   delay(500);
                   botao(140,9,1,3,9,14);
                   inserir;
                   ageprin;
                   closegraph;
                   halt(1);
                 end;

             180:begin
                   som;
                   coor2:=180;
                   mouse.hide;
                   botao(180,9,3,1,7,14);
                   delay(500);
                   botao(180,9,1,3,1,14);
                   remover;
                   ageprin;
                   closegraph;
                   halt(1);
                 end;

             220:begin
                   som;
                   coor2:=220;
                   mouse.hide;
                   botao(220,9,3,1,7,14);
                   delay(500);
                   botao(220,9,1,3,1,14);
                   procurar;
                   ageprin;
                   closegraph;
                   halt(1);
                 end;
            260:begin
                  som;
                  mouse.hide;
                  coor2:=260;
                  botao(260,9,3,1,7,14);
                  delay(500);
                  botao(260,9,1,3,1,14);
                  modificar;
                  ageprin;
                  closegraph;
                  halt(1);
                end;
            300:begin
                  som;
                  mouse.hide;
                  coor2:=300;
                  botao(300,9,3,1,7,14);
                  delay(500);
                  botao(300,9,1,3,1,14);
                  listar;
                  ageprin;
                  closegraph;
                  halt(1);
                end;
            340:begin
                  som;
                  mouse.hide;
                  coor2:=340;
                  botao(340,9,3,1,7,14);
                  delay(500);
                  botao(340,9,1,3,1,14);
                  menuprin;
                  closegraph;
                  halt(1);
                end;
          end;
          impy:=140;
          activimp(7);
       end;
     end;
     mouse.hide;
     activimp(1);
     impy:=340;
     som;
     activimp(7);
     coor2:=340;
     botao(340,9,3,1,7,14);
     delay(500);
     menuprin;
     closegraph;
     halt(1);
  end;



  Procedure impmensagem;
    begin
      setfillstyle(1,15);
      bar(221,431,419,469);
      setcolor(9);
      rectangle(221,431,419,469);
      rectangle(222,432,418,468);
      setcolor(0);
      rectangle(223,433,417,467);
      setcolor(1);
      settextstyle(0,0,1);
      outtextxy(280,440,'Imprimindo');
      outtextxy(253,455,'Espere um momento');
    end;



     Procedure imprime(cont:integer);
       var nome1,morada1,loc1,codpost1,tel1,idadestr,diastr,mestr,anostr,nasc1:string;
           dia1,mes1,ano1,idade1:integer;
       begin
         with inventario[cont] do
           begin
             nome1:=nome;
             morada1:=morada;
             loc1:=loc;
             dia1:=dia;
             mes1:=mes;
             ano1:=ano;
             idade1:=idade;
             str(codpost,codpost1);
             str(tel,tel1);
           end;
         if tel1='0' then tel1:='---------';
         if codpost1='0' then codpost1:='------';
         if idade1=0 then begin
           idadestr:='--';
           nasc1:='--/--/--';
         end
         else begin
           str(idade1,idadestr);
           str(dia1,diastr);
           str(mes1,mestr);
           str(ano1,anostr);
           nasc1:=diastr+'/'+mestr+'/'+anostr;
         end;
         {$I-}
         if nome1[length(nome1)]=chr(13) then dec(nome1[0]);
         if morada1[length(morada1)]=chr(13) then dec(morada1[0]);
         codpost1:=pad(codpost1,' ',6);
         if loc1[length(loc1)]=chr(13) then dec(loc1[0]);
         nasc1:=pad(nasc1,' ',8);
         idadestr:=pad(idadestr,' ',2);
         tel1:=pad(tel1,' ',9);
         writeln(lst,'ÉËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËË»');
         writeln(lst,'ÌÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊ¹');
         writeln(lst,'º NOME: ',Nome1,'      º');
         writeln(lst,'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹');
         writeln(lst,'º MORADA: ',morada1,'    º');
         writeln(lst,'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹');
         writeln(lst,'º CàDIGO POSTAL: ',codpost1,'                    º');
         writeln(lst,'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹');
         writeln(lst,'º LOCALIDADE: ',loc1,'º');
         writeln(lst,'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹');
         writeln(lst,'º DATA DE NASCIMENTO: ',nasc1,'             º');
         writeln(lst,'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹');
         writeln(lst,'º IDADE: ',Idadestr,'                                º');
         writeln(lst,'ÌÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹');
         writeln(lst,'º TELEFONE: ',tel1,'                      º');
         writeln(lst,'ÌËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËËË¹');
         writeln(lst,'ÈÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊÊ¼');
         writeln(lst);
         {$I+}
       end;





{//////////////////////////ImpressÆo de Pessoa///////////////////////////////}



   Procedure ImpPessoa;
      var c,x,y:integer;
          ch:char;

     begin
       titulos[1]:='Por Nome';
       titulos[2]:='Por N§ de Telefone';
       titulos[3]:='Por N§ da Agenda';
       titulos[4]:='Sair';
       setfillstyle(1,0);
       bar(0,0,640,480);
       versao;
       settextstyle(1,0,5);
       setcolor(14);
       settextjustify(1,2);
       outtextxy(320,20,'IMPRIMIR PESSOA');
       settextjustify(0,2);
       coor2:=140;
       impy:=140;
       repeat
         botao(coor2,9,1,3,1,14);
         coor2:=coor2+40;
       until coor2=300;
       impy:=140;
       activimp(7);
       while c <> 251 do
         begin
           mouse.show;
           horas;
           c:=mouse.waitforinput(leftbutton);
           mouse.hide;
           if c < 0 then begin
              mouse.getcoords(x,y);
              activimp(7);
              if mouse.inbox (115,140,515,170,x,y) then begin
                activimp(1);
                impy:=140;
                c:=13;
              end;
              if mouse.inbox (115,180,515,210,x,y) then begin
                activimp(1);
                impy:=180;
                c:=13;
              end;
              if mouse.inbox (115,220,515,250,x,y) then begin
                activimp(1);
                impy:=220;
                c:=13;
              end;
              if mouse.inbox (115,260,515,290,x,y) then begin
                activimp(1);
                impy:=260;
                c:=13;
              end;
           end;
           if c=27 then begin
             activimp(1);
             impy:=260;
             c:=13;
           end;
           if c = 80 then begin
             impy:=impy+40;
             if impy = 300 then begin
                impy:=impy-40;
                activimp(1);
                impy:=140;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
               avanca(7);
           end;
           if c = 72 then begin
             impy:=impy-40;

             if impy=100 then begin
                impy:=impy+40;
                activimp(1);
                impy:=260;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
                atrasa(7);
           end;
           if c = 13 then begin
              case impy of

                140:begin
                      som;
                      coor2:=140;
                      botao(140,9,3,1,7,14);
                      delay(500);
                      botao(140,9,1,3,9,14);
                      procnome('Qual o nome da pessoa que deseja imprimir ?');
                      c:=251;
                    end;

                180:begin
                      som;
                      coor2:=180;
                      botao(180,9,3,1,7,14);
                      delay(500);
                      botao(180,9,1,3,1,14);
                      proctel('Qual o telefone da pessoa que deseja imprimir ?');
                      c:=251;
                    end;

                220:begin
                      som;
                      coor2:=220;
                      botao(220,9,3,1,7,14);
                      delay(500);
                      botao(220,9,1,3,1,14);
                      procnum('Qual o N§ da pessoa que deseja imprimir ?');
                      c:=251;
                    end;

                260:begin
                      som;
                      coor2:=260;
                      botao(260,9,3,1,7,14);
                      delay(500);
                      botao(260,9,1,3,1,14);
                      ageprin;
                      closegraph;
                      halt(1);
                    end;
              end;
              impy:=140;
           end;
       end;
       c:=0;
       if existe then begin
         impmensagem;
         imprime(contad);
         if ioresult <> 0 then begin;
            setfillstyle(1,15);
            bar(221,431,419,469);
            setcolor(12);
            rectangle(219,429,421,471);
            rectangle(219,429,421,472);
            settextstyle(0,0,1);
            setcolor(4);
            outtextxy(280,440,'Impressora');
            outtextxy(270,455,'n„o preparada');
            delay(2000);
            setfillstyle(1,0);
            bar(220,430,420,470);
            exit;
         end;
       end;
       if not existe then inexistente;
     end;



{//////////////////////////ImpressÆo da Agenda///////////////////////////////}



   Procedure ImpAgenda;
      begin
        contad:=0;
        impmensagem;
        repeat
          contad:=contad+1;
          imprime(contad);
          if ioresult <> 0 then begin;
            setfillstyle(1,15);
            bar(221,431,419,469);
            setcolor(12);
            rectangle(219,429,421,471);
            rectangle(219,429,421,472);
            settextstyle(0,0,1);
            setcolor(4);
            outtextxy(280,440,'Impressora');
            outtextxy(270,455,'n„o preparada');
            delay(2000);
            setfillstyle(1,0);
            bar(219,429,421,472);
            exit;
          end;
        until contad=auxindice-1;
      end;



{//////////////////////////////Menu de Opcäes////////////////////////////////}



  Procedure Opcoes;
    var c,x,y:integer;
        valid:boolean;

     begin
       titulos[1]:='Gravar modifica‡”es';
       titulos[2]:='Imprimir Pessoa';
       titulos[3]:='Imprimir Agenda';
       titulos[4]:='Alterar Hora';
       titulos[5]:='Alterar Data';
       titulos[6]:='Sair';
       if keypressed then limptec;
       setfillstyle(1,0);
       bar(0,0,640,480);
       versao;
       settextstyle(1,0,5);
       setcolor(14);
       settextjustify(1,2);
       outtextxy(320,20,'OP€™ES DISPONIVEIS');
       settextjustify(0,2);
       coor2:=140;
       impy:=140;
       repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
       until coor2=380;
       impy:=140;
       activimp(7);
       while c <> 27 do
         begin
           mouse.show;
           horas;
           c:=mouse.waitforinput(leftbutton);
           mouse.hide;
           if c < 0 then begin
              mouse.getcoords(x,y);
              activimp(7);
              if mouse.inbox (115,140,515,170,x,y) then begin
                activimp(1);
                impy:=140;
                c:=13;
              end;
              if mouse.inbox (115,180,515,210,x,y) then begin
                activimp(1);
                impy:=180;
                c:=13;
              end;
              if mouse.inbox (115,220,515,250,x,y) then begin
                activimp(1);
                impy:=220;
                c:=13;
              end;
              if mouse.inbox (115,260,515,290,x,y) then begin
                activimp(1);
                impy:=260;
                c:=13;
              end;
              if mouse.inbox (115,300,515,330,x,y) then begin
                activimp(1);
                impy:=300;
                c:=13;
              end;
              if mouse.inbox (115,340,515,370,x,y) then begin
                activimp(1);
                impy:=340;
                c:=13;
              end;
           end;
           if c = 80 then begin
             impy:=impy+40;
             if impy = 380 then begin
                impy:=impy-40;
                activimp(1);
                impy:=140;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
               avanca(7);
           end;
           if c = 72 then begin
             impy:=impy-40;

             if impy=100 then begin
                impy:=impy+40;
                activimp(1);
                impy:=340;
                activimp(7);
                sound(30);
                delay(100);
                nosound;
             end
             else
                atrasa(7);
           end;
           if c = 13 then begin
              case impy of

                140:begin
                      som;
                      coor2:=140;
                      botao(140,9,3,1,7,14);
                      delay(500);
                      botao(140,9,1,3,7,14);
                      setlinestyle(0,0,1);
                      valid:=writeprotec;
                      if valid then begin
                        setcolor(9);
                        rectangle(231,401,411,431);
                        setfillstyle(1,15);
                        bar(232,402,410,430);
                        setcolor(3);
                        rectangle(232,402,410,429);
                        rectangle(232,402,410,430);
                        settextstyle(0,0,1);
                        outtextxy(254,405,'Gravando ficheiro');
                        setcolor(1);
                        outtextxy(285,418,'Dados.dat');
                        indice:=1;
                        repeat
                          write(agefile,inventario[indice]);
                          indice:=indice+1;
                        until indice>=auxindice;
                        close(agefile);
                        setfillstyle(1,0);
                        bar(230,400,411,431);
                        setcolor(7);
                      end;
                    end;

                180:begin
                      som;
                      coor2:=180;
                      botao(180,9,3,1,7,14);
                      delay(500);
                      botao(180,9,1,3,1,14);
                      imppessoa;
                      opcoes;
                      closegraph;
                      halt(1);
                    end;

                220:begin
                      som;
                      coor2:=220;
                      botao(220,9,3,1,7,14);
                      delay(500);
                      botao(220,9,1,3,1,14);
                      impagenda;
                      impy:=140;
                      activimp(7);
                    end;

                260:begin
                      som;
                      coor2:=260;
                      botao(260,9,3,1,7,14);
                      delay(500);
                      botao(260,9,1,3,1,14);
                      alterhora;
                      opcoes;
                      closegraph;
                      halt(1);
                    end;

                300:begin
                      som;
                      coor2:=300;
                      botao(300,9,3,1,7,14);
                      delay(500);
                      botao(300,9,1,3,1,14);
                      alterdata;
                      opcoes;
                      closegraph;
                      halt(1);
                    end;

                340:begin
                      som;
                      coor2:=340;
                      botao(340,9,3,1,7,14);
                      delay(500);
                      botao(340,9,1,3,1,14);
                      menuprin;
                      closegraph;
                      halt(1);
                    end;
              end;
              impy:=140;
           end;
       end;
       activimp(1);
       som;
       coor2:=340;
       botao(340,9,3,1,7,14);
       delay(500);
       botao(340,9,1,3,1,14);
       menuprin;
       closegraph;
       halt(1);
     end;



{//////////////////////////////Menu Principal////////////////////////////////}



  Procedure Menuprin;

    var  i,y,car,x: integer;


   Procedure Sair;
      var opc:char;
      begin
        nosound;
        setlinestyle(0,0,1);
        setcolor(12);
        rectangle(231,401,411,431);
        setfillstyle(1,15);
        bar(232,402,410,430);
        setcolor(4);
        rectangle(232,402,410,429);
        rectangle(232,402,410,430);
        settextstyle(0,0,1);
        setcolor(12);
        settextjustify(1,2);
        outtextxy(320,407,'Sair para o Dos');
        setcolor(4);
        outtextxy(320,419,'S/N');
        settextjustify(0,2);
        repeat
          horas;
          opc:=readkey;
          if (opc='S') or (opc='s') then begin
            sound(1000);
            delay(100);
            nosound;
            delay(500);
            closegraph;
            halt(1);
          end;
          if (opc='N') or (opc='n') then begin
            sound(1000);
            delay(100);
            nosound;
            delay(500);
            setfillstyle(1,0);
            bar(231,401,411,431);
          end;
        until opc in['s','n','S','N'];
      end;

    
    begin
      titulos[2]:='AGENDA';
      titulos[3]:='OP€™ES';
      titulos[4]:='Sair para o Dos';
      if keypressed then
        while keypressed do
          limptec;
      cleardevice;
      impy:=180;
      versao;
      setfillstyle(1,0);
      settextstyle(1,0,5);
      setcolor(14);
      settextjustify(1,2);
      outtextxy(320,10,'MENU PRINCIPAL');
      settextjustify(0,2);
      coor2:=180;
      setlinestyle(0,0,3);
      settextstyle(1,0,2);
      repeat
        botao(coor2,9,1,3,1,14);
        coor2:=coor2+40;
      until coor2=300;
      activimp(7);
      if keypressed then limptec;
      while car <> 255 do begin
        mouse.show;
        horas;
        car:=mouse.waitforinput(leftbutton);
        if car < 0 then begin
           mouse.getcoords(x,y);
           mouse.hide;
           activimp(7);
           if mouse.inbox (115,180,515,210,x,y) then begin
              activimp(1);
              impy:=180;
              car:=13;
           end;
           if mouse.inbox (115,220,515,250,x,y) then begin
              activimp(1);
              impy:=220;
              car:=13;
           end;
           if mouse.inbox (115,260,515,290,x,y) then begin
              activimp(1);
              impy:=260;
              car:=13;
           end;
           mouse.show;
        end;
        if car = 80 then begin
           mouse.hide;
           impy:=impy+40;
           if impy = 300 then begin
              impy:=impy-40;
              activimp(1);
              impy:=180;
              activimp(7);
              sound(30);
              delay(100);
              nosound;
           end
           else
             avanca(7);
             mouse.show;
        end;
       if car = 72 then begin
          mouse.hide;
          impy:=impy-40;
          if impy=140 then begin
             impy:=impy+40;
             activimp(1);
             impy:=260;
             activimp(7);
             sound(30);
             delay(100);
             nosound;
          end
          else
            atrasa(7);
            mouse.show;
       end;
       if car = 27 then begin
         activimp(1);
         car:=13;
         impy:=260;
       end;
       if car = 13 then begin
          case impy of
             180:begin
                   som;
                   coor2:=180;
                   mouse.hide;
                   botao(180,9,3,1,7,14);
                   delay(500);
                   botao(180,9,1,3,1,14);
                   ageprin;
                   closegraph;
                   halt(1);
                 end;

             220:begin
                   som;
                   coor2:=220;
                   mouse.hide;
                   botao(220,9,3,1,7,14);
                   delay(500);
                   botao(220,9,1,3,1,14);
                   opcoes;
                   closegraph;
                   halt(1);
                 end;
            260:begin
                  som;
                  mouse.hide;
                  coor2:=260;
                  botao(260,9,3,1,7,14);
                  delay(500);
                  botao(260,9,1,3,1,14);
                  Sair;
                  activimp(1);
                end;
          end;
          impy:=180;
          activimp(7);
       end;
     end;
     closegraph;
     halt(1);
  end;



{//////////////////////////Corpo do Programa/////////////////////////////////}



BEGIN
  checkbreak:=false;
  setcbreak(checkbreak);
  gd:=9;
  gm:=2;
  if RegisterBGIdriver(@EGAVGADriverProc) < 0 then
  Abort('EGA/VGA');
  if RegisterBGIfont(@TripProc) < 0 then
  Abort('Triplex');
  if RegisterBGIfont(@littProc) < 0 then
  Abort('Little');
  if RegisterBGIfont(@sansProc) < 0 then
  Abort('Sans Serif');
  initgraph(gd,gm,'');
  if grok<>0 then begin
    writeln('Necessita de placa VGA');
    halt(1);
  end;
  intro;
  cleardevice;
  setrgbpalette(2,$24,$fc,$24);
  setrgbpalette(3,$00,$fc,$fc);
  setrgbpalette(4,$fc,$14,$14);
  naoexiste:=false;
  for indice:=1 to 300 do
    with inventario[indice] do begin
      nome:=defele;
      morada:='                             '+chr(13);
      loc:='                             '+chr(13);
      codpost:=0;
      tel:=0;
      dia:=0;
      mes:=0;
      ano:=0;
      idade:=0;
    end;
  indice:=1;
  {$I-}
  assign(agefile,'dados.dat');
  reset(agefile);
  {$I+}
  if ioresult <> 0 then begin
     bool:=writeprotec;
     if bool=false then begin
       closegraph;
       writeln('Adeus');
       halt(1);
     end;
     naoexiste:=true;
  end;
  if naoexiste = false then begin
  while not eof(agefile) do begin
    {$I-}
    read(agefile,inventario[indice]);
    {$I+}
    if ioresult<>0 then begin
      close(agefile);
      closegraph;
      writeln('Ficheiro Dados.dat incompat¡vel');
      halt(1);
    end;
    if inventario[indice].nome='                             '+chr(13) then indice:=indice-1;
    indice:=indice+1;
  end;
  end;
  close(agefile);
  auxindice:=indice;
  getdate(year,month,day,dow);
  year:=year-1900;
  setrgbpalette(5,42,20,42);
  setrgbpalette(3,20,30,52);
  mouse.init;
  f:=mouse.setup;
  mouse.hide;
  for indice:=1 to auxindice do
    ver_anos(indice);
  menuprin;
  mouse.show;
END.
