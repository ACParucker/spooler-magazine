
(****************************************************************************)
(*                                                                          *)
(*    Nome        :   video.pas                                             *)
(*    Vers„o      :   1.0                                                   *)
(*    Data        :   16/03/1994                                            *)
(*    Compilador  :   Turbo Pascal 6.0                                      *)
(*    Autor       :   Carlos Ladeira                                        *)
(*    Descri‡„o   :   UNIT para rotinas de video em TSR'a em Turbo Pascal   *)
(*                                                                          *)
(****************************************************************************)

{$V-,I-,R-,F+}

unit video;

interface

type
	cell = record			{ cada posi‡„o do ecr„ ‚ composta por um }
		ch, attr : byte;	{ car cter e por um atributo }
	end;

    scr_type = array [1..25, 1..80] of cell;	{ o ecr„ tem 80 colunas }
												{ e 25 linhas }
var
   mono  : byte absolute $B000:$0000;	{ ptr para o buffer monocrom tico }
   color : byte absolute $B800:$0000;	{ ptr para o buffer a cores }
   scr_ptr : ^scr_type;					{ ponteiro para o ecr„ }


procedure xy_str(x, y, attr : byte; s : string; var scr : scr_type);
procedure box(x1, y1, x2, y2, attr : byte; var scr : scr_type);
procedure block(x1, y1, x2, y2, attr, ch : byte; var scr : scr_type);

implementation

(*----------------------------------------------*)
{ escreve uma string }
procedure xy_str(x, y, attr : byte; s : string; var scr : scr_type);
var i : byte;
begin
	for i := 1 to length(s) do
		begin
		scr[y, x+i].ch := ord(s[i]);
		scr[y, x+i].attr := attr;
		end;
End;

(*----------------------------------------------*)
{ desenha uma caixa }
procedure box(x1, y1, x2, y2, attr : byte; var scr : scr_type);
var	i : byte;
begin
	scr[y1, x1].ch := 218;
	scr[y1, x1].attr := attr;

	scr[y1, x2].ch := 191;
	scr[y1, x2].attr := attr;

	scr[y2, x2].ch := 217;
	scr[y2, x2].attr := attr;

	scr[y2, x1].ch := 192;
	scr[y2, x1].attr := attr;

	for i := x1 + 1 to x2 - 1 do
		begin
		scr[y1, i].ch := 196;
		scr[y1, i].attr := attr;
		scr[y2, i].ch := 196;
		scr[y2, i].attr := attr;
		end;

	for i := y1 + 1 to y2 - 1 do
		begin
		scr[i, x1].ch := 179;
		scr[i, x1].attr := attr;
		scr[i, x2].ch := 179;
		scr[i, x2].attr := attr;
		end;

end;

(*----------------------------------------------*)
{ desenha um bloco a cheio }
procedure block(x1, y1, x2, y2, attr, ch : byte; var scr : scr_type);
var	i, j : byte;
begin
	for i := y1 to y2 do
		for j := x1 to x2 do
			begin
         	scr[i, j].ch := ch;
			scr[i, j].attr := attr;
			end;
end;

end.
