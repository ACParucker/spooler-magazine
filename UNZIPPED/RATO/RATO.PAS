uses dos, crt;                  { para a fun‡„o INTR, DELAY, SOUND e NOSOUND }
const	                        { constantes referentes aos eventos }
	MouseMove  = $01;
	LeftDown   = $02; LeftUp   = $04;
	RightDown  = $08; RightUp  = $10;
	eventMask  = LeftDown or LeftUp or RightDown or RightUp or MouseMove;
var
	x, y : word;	        { posi‡„o X e Y do rato }
	left, right : boolean;	{ estado dos bot”es: =true se premido }
                                {                    =false se liberto}
	moved : boolean;	{ =trua se o rato foi movimentado }
	regs : registers;	{ para a fun‡„o INTR }

{$F+}	                        { esta fun‡„o tem de ser FAR }
procedure mouseHandler; assembler;
asm
	push ds	                { guarda o reg. DS }
	mov  bx, seg @data	{ DS = segmento de dados }
	mov  ds, bx	        { das variaveis deste programa }

	mov  x, cx	        { coordenada X do rato }
	mov  y, dx	        { coordenada Y do rato }

	test ax, LeftDown	{ bot„o esquerdo premido }
	jz   @mh1
	mov  left, 1            { left := true }
@mh1:
	test ax, LeftUp	        { bot„o esquerdo libertado }
	jz   @mh2
	mov  left, 0            { left := false }
@mh2:
	test ax, RightDown	{ bot„o direito premido }
	jz   @mh3
	mov  right, 1           { right := true }
@mh3:
	test ax, RightUp	{ bot„o direito libertado }
	jz   @mh4
	mov  right, 0           { right := false }
@mh4:
	test ax, MouseMove	{ Rato movimentado }
	jz   @mh5
	mov  moved, 1           { moved := true }
@mh5:
	pop  ds	                { restaura o reg. DS }
end;
{$F-}	                        { ®desliga¯ a directiva FAR }

begin
	{ inicializa o rato, e se este n„o existir, sai }
	regs.ax := 0; intr($33, regs);
	if regs.ax = 0 then exit;

	{ torna o cursor do rato visivel }
	regs.ax := 1; intr($33, regs);

	{ define o handler de eventos do rato }
	regs.es := seg(mouseHandler);
	regs.dx := ofs(mouseHandler);
	regs.cx := EventMask;
	regs.ax := 12; intr($33, regs);

	{ inicializa as variaveis }
	right:=false; left:=false; moved:=false;
	writeln('Pressione o bot„o direito do rato para sair');

	{ faz o loop enquanto o bot„o direito n„o for premido }
	while not right do
              begin
	      { se o rato foi movimentado ... }
	      if moved then
	         begin
		 { mostra as novas coordenadas do rato }
		 write('X=', x:3, ' Y=', y:3, chr(13));
		 { sinaliza a leitura da flag de movimento }
		 moved := false;
		 end;
              { se o bot„o esquerdo do rato estiver premido ... }
              if left then
                 begin
                 sound(1000);
                 delay(1);
                 nosound;
                 end;
              end;

	{ desactiva o rato e termina }
	regs.ax := 0; intr($33, regs);
end.
