{
	Programa "IFS.PAS".
	Auxiliar para o estudo dos IFS's (I.F.S. - Iterated Functions ...)
	Iteradas de Aplica‡”es Afins em R2.
}
program IFS_principal;
{$E+,N+}
uses
	crt,       { biblioteca de fun‡oes v rias do Turbo Pascal }
	graph;     { biblioteca de fun‡oes gr ficas do Turbo Pascal }

type        { defini‡ao de novos "tipos" }
	str40=string[40];      { tipo "string" }
	str100=string[100];
	vect2str40=array[1..2] of str40;        { tipo matriz de "string" }
	mat80x2str40=array[1..80] of vect2str40;

	vect0_20b=array[0..20] of byte;   { tipo matriz de "byte" }
	vect20b=array[1..20] of byte;
	mat80x0_20b=array[1..80] of vect0_20b;

	vect6s=array[1..6] of single;    { tipo matriz de "single" }
	vect8s=array[1..8] of single;
	vect20s=array[1..20] of single;
	vect300s=array[1..300] of single;
	mat20x8s=array[1..20] of vect8s;
	mat300x6s=array[1..300] of vect6s;
	vel10=array[0..9] of longint;
const
	caminho_bgi:str100=''; { "path" dos ficheiros "BGI"... }
	caminho_aux:str100=''; { "path" dos ficheiros auxiliares... }
	fich_apl:str40='ifs_apl.dat';   { nome do ficheiro das aplica‡oes }
	fich_list:str40='ifs_list.dat'; { nome do ficheiro com a lista dos IFS }
	numero_de_iteradas:vel10=(5000,10000,20000,40000,60000,
	80000,100000,130000,160000,200000); { n§ de iteradas }
	pausa=0;  { tempo de pausa em mili-segundos }

var
	tecla: char;
	rand, fesc, j: byte;
	gd, gm: integer;
	iteradas,n: longint;
	x, y:double;
	esc: vect0_20b;
	prob: vect20s;
	a: mat300x6s;
	lista: mat80x0_20b;
	nome:	mat80x2str40;
	num_apl, num_ifs, figura: word;
	numstr: str40;

procedure ler_fich_apl(var max_apl: word); { leitura do ficheiro "IFS_APL.DAT" }
var
	f_apl: text;
	fich: str100;
	nomefich, astr: str40;
	code: integer;
	n, k, apl: word;
	ch: char;
begin
	if caminho_aux <> '' then fich:=caminho_aux+'\'+fich_apl
           else fich:=fich_apl;
	assign(f_apl, fich);
	reset(f_apl);
	n:=1;
	apl:=1;
	while (not eof(f_apl)) do
	begin
		k:=1;
		repeat
			read(f_apl, ch);
			if (ch in [#45,#46,#48..#57]) then
			begin
				astr:='';
				repeat
					astr:=astr+ch;
					read(f_apl,ch);
				until (ch=' ');
				val(astr,a[apl,k],code);
				k:=k+1;
			end;
			if (ch='/') then readln(f_apl);
			if (k > 6) then apl:=apl+1;
		until ((k > 6) or (ch='/') or (eoln(f_apl)));
		n:=n+1;
	end;
	close(f_apl);
	max_apl:=apl-1;
end;

procedure ler_fich_list(var max_list: word); { leitura do ficheiro "IFS_LIST.DAT" }
var
	f_list: text;
	fich: str100;
	nomefich, lstr: str40;
	code: integer;
	n, k, ifs, list: word;
	ch: char;
begin
	if caminho_aux <> '' then fich:=caminho_aux+'\'+fich_list
           else fich:=fich_list;
	assign(f_list, fich);
	reset(f_list);
	n:=1;
	ifs:=1;
	while (not eof(f_list)) do
	begin
		k:=1;
		repeat
			read(f_list, ch);
			if (ch='"') then
			begin
				nome[ifs,k]:='';
				read(f_list, ch);
				while (ch<>'"') do
				begin
					nome[ifs,k]:=nome[ifs,k]+ch;
					read(f_list, ch);
				end;
				k:=k+1;
			end;
		until ((k > 2) or (ch='/') or (eoln(f_list)));
		k:=0;
		repeat
			read(f_list, ch);
			if (ch in [#48..#57]) then
			begin
				lstr:='';
				repeat
					lstr:=lstr+ch;
					read(f_list,ch);
				until ((ch=' ') or (ch=':'));
				val(lstr,list,code);
				lista[ifs,k]:=list;
				k:=k+1;
			end;
			if (ch='/') then
			begin
				readln(f_list);
				if (k > lista[ifs,0]) then	ifs:=ifs+1;
			end;
		until ((ch='/') or (eoln(f_list)));
		n:=n+1;
	end;
	close(f_list);
	max_list:=ifs-1;
end;

procedure escolhe_velocidade;
var vel,a:integer;
	 vels:char;
	 vels1:string;
begin { A velocidade ‚ contr ria a perfei‡„o das imagens  }
	repeat
                vels:=' ';
		clrscr;
		writeln('Escolha uma velocidade adequada … sua m quina!');
                writeln;
                writeln('0 - Para m quinas muito lentas');
                writeln;
                writeln('9 - Para m quinas muito r pidas');
		gotoxy (1,10);
		write('Escreva um n£mero entre 0 e 9:  ');readln(vels1);
		if length(vels1)=1 then vels:=vels1[1];
	until vels in ['0'..'9'];
	val(vels,vel,a);
	iteradas:=numero_de_iteradas[vel];
end;

procedure ler_dados(x,y:word;nome:string;var num:word;cor:byte);
var resp:string;
	 rp1:char;
	 code:integer;
begin
	SetTextStyle(Triplexfont, HorizDir,2);
	SetTextJustify(lefttext,centertext);
	Setcolor(cor);
	nome:=nome+'  >>';
	OutTextXY(x, y, nome);
	repeat
		resp := '';
		SetColor(0);
		OutTextXY(x+(length(nome+resp))*12, y, 'ÛÛÛ');
		repeat
			repeat
				rp1 := readkey;
			until (rp1 in [#48..#57,#8,#13,#27]);
			if (rp1 in [#48..#57]) then
				resp := resp + rp1
			else
				if (rp1 = #8) then
					resp := copy(resp,1,length(resp)-1);
			if (length(resp)>2) then
				resp := copy(resp,1,length(resp)-1);
			SetColor(cor);
			OutTextXY(x+(length(nome))*12, y, resp);
			SetColor(0);
			OutTextXY(x+(length(nome+resp))*12, y, 'ÛÛ');
		until (rp1 = #13) or (rp1=#27);
		val(resp, num, code);
	until (num<=num_ifs) or (rp1=#27);
	tecla:=rp1;
	SetColor(0);
	OutTextXY(x, y, 'ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ');
end;

procedure MensagemApresentacao;
begin
	Setcolor(10);
	SetTextJustify(CenterText, CenterText);
	SetTextStyle(TriplexFont, HorizDir, 7);
	outtextxy(95,50,'IFS');
	SetTextStyle(TriplexFont, HorizDir, 2);
	outtextxy(95,95,'Iteradas de');
	outtextxy(95,115,'Aplica‡”es Afins');
	Setcolor(15);
	SetTextStyle(DefaultFont, HorizDir, 1);
	outtextxy(95,395,'Um programa de');
	outtextxy(95,415,'Pedro Sarreira,');
	outtextxy(95,435,'M rio Sarreira e');
	outtextxy(95,455,'Carlos Albuquerque');
end;

function max(a,b:byte):byte;
begin
	max:=a;
	if (a<b) then
		max:=b;
end;

procedure MensagemTitulo(s1,s2:string);
var
	comp,inic,fim: integer;
begin
	setcolor(12);   { vermelho }
	SetTextJustify(CenterText, CenterText);
	SetTextStyle(TriplexFont, HorizDir, 3);
	outtextxy(95,225,s1);
	outtextxy(95,255,s2);
end;

procedure Mensagem_tecla;
begin
	SetTextJustify(LeftText, CenterText);
	SetTextStyle(DefaultFont, HorizDir, 1);
	setcolor(14);
	outtextxy(10,450,'Sair -> ESC');
end;

procedure Mensagem_tecla_1;
begin
	SetTextJustify(LeftText, CenterText);
	SetTextStyle(DefaultFont, HorizDir, 1);
	setcolor(14);
	outtextxy(0,450,'Sair -> ESC e aguardar');
end;

function maximo(a,b:real):real;
begin
	maximo:=a;
	if (a<b) then
		maximo:=b;
end;

procedure probabilidades(e: vect0_20b; var p: vect20s);
var
	k, kmax: byte;
	max: vect20s;
	sum, eaux1, eaux2: real;
begin
	sum := 0;
	kmax := e[0];
	for k:=1 to kmax do
	begin
		eaux1 := abs(a[e[k],1])+abs(a[e[k],2]);
		eaux2 := abs(a[e[k],3])+abs(a[e[k],4]);
		max[k] := maximo(eaux1,eaux2);
		sum := sum + max[k];
	end;
	for k:=1 to kmax do
	begin
		p[k] := max[k]/sum;
	end;
end;

function aleatorio(p: vect20s):byte;
var
	i: byte;
	valor: real;
begin
	valor:=random;
	i:=1;
	while (valor>p[i]) do
	begin
		p[i+1]:=p[i+1]+p[i];
		i:=i+1;
	end;
	aleatorio:=i;
end;

procedure funcao(n: word; var x,y:double);
var
	x1:double;
begin
	x1:=a[n,1]*x+a[n,2]*y+a[n,5];
	y :=a[n,3]*x+a[n,4]*y+a[n,6];
	x :=x1;
end;

procedure apaga_ifs;
begin
	SetFillStyle(1, 0);
	Bar(0, 200, 215, 280);
	bar(200,20,630,460);
end;

procedure escreve_escolhas;
const cor=15;
var tabela,p_i:string;
	 i:byte;
begin
	cleardevice;
	SetTextStyle(DefaultFont, HorizDir,1);
	SetTextJustify(lefttext,centertext);
	SetColor(14);
	outtextxy(10,450,'Sair para o DOS -> ESC');
	SetColor(cor);
	for i:=0 to num_ifs do
	begin
		str(i:2,p_i);
		if (i>0) then
			tabela:=p_i+'- '+nome[i,1]+' '+nome[i,2]
		else
			tabela:=' 0- Sequˆncia de todas as imagens';
		OutTextXY(10+(i div 25)*320,60+(i mod 25)*15,tabela);
	end;
end;

procedure desenha(ifs:word);
begin
	x:=0.5;
	y:=0.5;
	Mensagemtitulo(nome[ifs,1],nome[ifs,2]);
	randomize;
	probabilidades(lista[ifs],prob);
	for n:=1 to iteradas do
	begin
		if (n mod 1000=0) then
			randomize;
		rand:=aleatorio(prob);
		fesc:=lista[ifs,rand];
		funcao(fesc,x,y);
		if n>=100 then
			putpixel(round(215+400*x),round(440-400*y),lista[ifs,lista[ifs,0]+1]);
	end;
	if keypressed then
			tecla:=readkey;
end;

Procedure mostra_todos;
begin
	tecla:=#50;
	j:=1;

	while (j<=num_ifs) and (tecla<>#27) do     { j s„o os diferentes IFS's }
	begin
		apaga_ifs;
		desenha(j);
		Mensagem_tecla_1;
		delay(pausa);
		j:=j+1;
	end;
        tecla:=#50;
end;

begin
	ler_fich_apl(num_apl);
	ler_fich_list(num_ifs);
	escolhe_velocidade;
	gd:=9;gm:=2;
	initgraph(gd,gm,caminho_bgi);
	mensagemapresentacao;
        randomize;
	desenha(random(num_ifs)+1);
	Mensagem_tecla_1;
	While (tecla<>#27) do
	begin
		escreve_escolhas;
		ler_dados(15,25,'Qual a figura ?',figura,14);  { Escolhe o Ifs que vai desenhar }
		if tecla=#27 then
                    begin
                       closegraph;
                       halt
                    end;
		cleardevice;
		if figura=0 then mostra_todos
		else
		begin
			desenha(figura);
			mensagem_tecla;
			repeat tecla:=readkey until tecla=#27;
                        tecla:=#50
		end;
	end;
	closegraph;
end.
