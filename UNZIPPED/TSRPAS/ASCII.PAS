(****************************************************************************)
(*                                                                          *)
(*    Nome        :   ascii.pas                                             *)
(*    Vers„o      :   1.0                                                   *)
(*    Data        :   16/03/1994                                            *)
(*    Compilador  :   Turbo Pascal 6.0                                      *)
(*    Autor       :   Carlos Ladeira                                        *)
(*    Descri‡„o   :   Tabela ASCII residente em mem¢ria em Turbo Pascal     *)
(*                                                                          *)
(****************************************************************************)

{$M 2048, 0, 0}		{ 2K stack e 0 de heap }
{$V-,I-,R-,F+}

uses tsr, crt, dos, video;	{ inclui UNIT's }

const ascii_index : byte = 0;	{ primeiro car cter ASCII da tabela }

var
	save_scr, scr : scr_type;	{ 2 ecr„s }
	ch : char;

{ rotina de activa‡„o do TSR }
procedure pop;
var
	r : registers;		{ para a fun‡„o intr }
	save_cur : word;	{ para gravar a posi‡„o do cursor }
    i : byte;			{ contador }
    st : string[10];
    ok_to_quit : boolean;	{ flag para terminar o TSR }

begin
	case mem[$40:$49] of	{ verifica o modo de video actual }
		2, 3: scr_ptr := addr(color);	{ 80 col. cor }
		   7: scr_ptr := addr(mono);	{ 80 col. MDA e HGC }
	else								{ outro }
		begin				{ s¢ deixa o TSR se activar se o modo de }
	  	sound(1000);		{ video corrente for texto de 80 colunas }
  		delay(100);
	  	nosound;
        exit;
		end;
	end;

	r.ah := 3;			{ grava a posi‡„o corrente do cursor }
	r.bh := 0;
	intr($10, r);
    save_cur := r.dx;

    r.ah := 2;			{ esconde o cursor, colocando-o fora do ecr„ }
    r.bh := 0;
    r.dx := $5050;
    intr($10, r);

	save_scr := scr_ptr^;	{ grava o ecr„ actual }
    scr := scr_ptr^;		{ af‚cta scr com o ecr„ actual }

    { desenha as caixas e escreve as mensagens }
    block(50, 1, 80, 12, $11, 32, scr);
    box(70, 1, 80, 12, $1E, scr);
	xy_str(54, 3, $12, 'TABELA ASCII', scr);
	xy_str(53, 5, $19, '-ÄÄÄÄÄÄÄÄÄÄÄÄ-', scr);
	xy_str(53, 7, $1C, #24+#25, scr);
	xy_str(56, 7, $17, 'movimentar', scr);
	xy_str(54, 8, $1C, 'D', scr);
	xy_str(55, 8, $17, 'esinstalar', scr);
	xy_str(58, 9, $1C, 'S', scr);
	xy_str(59, 9, $17, 'air', scr);

    ok_to_quit := false;	{ por enquanto n„o sai }

	repeat

    	{ desenha o conteudo da tabela ASCII }
  		for i := 0 to 9 do
			begin
      		str(byte((ascii_index+i)):3, st);
      		st := st + ' ³ ' + chr(ascii_index+i) + ' ';
            xy_str(71, 2+i, $1F, st, scr);
      		end;

        { escreve tudo no ecr„ }
    	scr_ptr^ := scr;

    	ch := readkey;					{ lˆ uma tecla }
        if ch = #0 then ch := readkey;	{ se for especial lˆ novamente }

		case ch of
        	'd', 'D':					{ desinstala }
            	if tsrexit then ok_to_quit := true
				else
                	begin				{ se n„o puder, avisa }
                    sound(1000);
                    delay(100);
                    nosound;
                    end;
            #27, 's', 'S': ok_to_quit := true;	{ termina e sai }
            #72: inc(ascii_index);				{ cursor acima }
            #80: dec(ascii_index);				{ cursor abaixo }
        end;

    until ok_to_quit;

	scr_ptr^ := save_scr;				{ restaura o ecr„ gravado }

    r.ah := 2;             { restaura a posi‡„o do cursor gravada }
    r.bh := 0;
    r.dx := save_cur;
    intr($10, r);

end;

begin

	{ mensagem inicial do programa }
	writeln('ASCII 1.0 - Tabela ASCII residente por Carlos Ladeira');

    { af‚cta a string de ID para o nome do programa }
    id_str := 'ASCII 1.0';

	if resident then		{ se j  estiver residente, avisa }
  		begin
	    writeln('O programa j  se encontra residente!!!');
    	writeln('ALT+F6 para activar.');
	    exit;
    	end;

    { d  a mensagem das teclas de activa‡„o }
	writeln('ALT+F6 para activar');

    { deixa o programa residente em mem¢ria }
	go_tsr(@pop, SC_F6, KM_ALT);
end.
