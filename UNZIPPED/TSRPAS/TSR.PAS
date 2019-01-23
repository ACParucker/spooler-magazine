
(****************************************************************************)
(*                                                                          *)
(*    Nome        :   tsr.pas                                               *)
(*    Vers„o      :   1.0                                                   *)
(*    Data        :   16/03/1994                                            *)
(*    Compilador  :   Turbo Pascal 6.0                                      *)
(*    Autor       :   Carlos Ladeira                                        *)
(*    Descri‡„o   :   UNIT para criar TSR's em Turbo Pascal                 *)
(*                                                                          *)
(****************************************************************************)

{$v-,i-,r-,f+}		{ directivas obrigat¢rias para TSR's }

unit tsr;

interface
uses dos, crt;

const
	{ scan codes para as teclas de A a Z }
	SC_A=30; SC_B=48; SC_C=46; SC_D=32; SC_E=18; SC_F=33;
	SC_G=34; SC_H=35; SC_I=23; SC_J=36; SC_K=37; SC_L=38;
	SC_M=50; SC_N=49; SC_O=24; SC_P=25; SC_Q=16; SC_R=19;
	SC_S=31; SC_T=20; SC_U=22; SC_V=47; SC_W=17; SC_X=45;
	SC_Y=21; SC_Z=44;

    { scan codes para as teclas de F1 a F12 }
	SC_F1=59; SC_F2=60; SC_F3=61; SC_F4=62; SC_F5=63; SC_F6=64;
	SC_F7=65; SC_F8=66; SC_F9=67; SC_F10=68; SC_F11=133; SC_F12=134;

    { scan codes para as teclas de 1 a 0 }
	SC_1=2; SC_2=3; SC_3=4; SC_4=5; SC_5=6; SC_6=7; SC_7=8;
	SC_8=9; SC_9=10; SC_0=11;

    { scan codes para as teclas do teclado num‚rico }
	SC_END=79; SC_DOWN=80; SC_PGDN=81; SC_LEFT=75; SC_NUM_5=76;
	SC_RIGHT=77; SC_HOME=71; SC_UP=72; SC_PGUP=73; SC_INS=82;
	SC_NUM_MAIS=78; SC_NUM_MENOS=74; SC_DEL=83;

    { scan codes para mais algumas teclas }
	SC_ESC=1; SC_SPACE=57; SC_TAB=15; SC_ENTER=28; SC_BACKSPACE=14;
	SC_LSHIFT=42; SC_RSHIFT=54; SC_CTRL=29; SC_ALT=56;

    { m scaras para a hot key das teclas SHIFT, CTRL e ALT }
	KM_RSHIFT=1; KM_LSHIFT=2; KM_CTRL=4; KM_ALT=8;

    { string de identifica‡„o do TSR }
    id_str : string = 'Turbo TSR 1.0';


	{ verifica se o TSR j  se encontra residente, retomando TRUE se j  }
    { ou FALSE se n„o }
function resident : boolean;

	{ deixa o programa residente em mem¢ria passando como parƒmetros a }
    { rotina de activa‡„o (pr), o scan code (sc) e a m scara (km) }
procedure go_tsr (pr : pointer; sc, km : byte);

	{ desinstala o TSR da mem¢ria, retomando TRUE se a fun‡„o foi concluida }
    { com sucesso ou FALSE se n„o ‚ possivel desinstalar o TSR }
    { esta fun‡„o s¢ deve ser chamada pela parte residente do programa }
function tsrexit : boolean;


implementation

{ estado do TSR: inactivo, hot key premida ou activo }
type	TSR_state = (inactive, hot_key_set, running);

const
	state : TSR_state = inactive;		{ estado actual do TSR }
    tsr_vec : byte = 0;					{ vector capturado pelo TSR para }
		{ permitir que este possa ser detectado caso sˆja feita uma tentativa }
		{ de segunda activa‡„o }

var
	oldss : word;  { SS do programa interrompido quando o TSR ‚ activado }
	oldsp : word;  { SP do programa interrompido quando o TSR ‚ activado }
	tsrss : word;  { segmento (SS) da pilha do TSR }
	tsrsp : word;  { offset (SP) da pilha do TSR }

	scancode : byte;	{ scan code da tecla de activa‡„o do TSR }
	keymask  : byte;	{ m scara a ®juntar¯ ao scan code }

    { para gravar os endere‡os da interrup‡”es redireccionadas }
    oldint08, oldint09, oldint28, oldint24 : pointer;
    olddtaseg, olddtaofs : word;	{ grava o DTA do programa interrompido }
    ourdtaseg, ourdtaofs : word;	{ DTA do TSR }

	r : registers;		{ para uso em varias fun‡”es do TSR }
	in_dos : ^byte;		{ ponteiro para uma flag que sinaliza quando o }
						{ DOS est  activo }
    poprtn : pointer;	{ ponteiro para o procedimento de activa‡„o do TSR }
	old_psp, tsr_psp : word;	{ PSP's do programa interrompido e do TSR }


{ esta fun‡„o trata de chamar as rotinas de interrup‡„o que foram }
{ redireccionadas pelo TSR }
procedure calloldint(sub : pointer); assembler;
asm
	pushf					{ simula uma instru‡„o INT }
	call dword ptr [bp+6]
end;

{ esta rotina ‚ executada sempre que ‚ premida uma tecla. tem como fun‡„o }
{ verificar se a(s) tecla(s) premidas correspondem …s de activa‡„o do TSR }
{ e se forem, sinaliza a variavel (state) de forma a que o TSR possa ser }
{ activado pela interrup‡„o $08 ou pela interrup‡„o $28 }
procedure int09(flags,cs,ip,ax,bx,cx,dx,si,di,ds,es,bp : word); interrupt;
var	a : byte; shift : byte absolute $40:$17;
begin
	{ se as teclas de activa‡„o estiverem premidas }
	if (port[$60] = scancode) and ((shift and $F) = keymask) then
    	begin
	    a := port[$61];			{ faz o reset ao teclado de forma a que }
    	port[$61] := a or $80;	{ a tecla premida sˆja ®esquecida¯ }
	    port[$61] := a;
    	port[$20] := $20;      	{ sinaliza ao PIC o fim de interrup‡„o }
	    { se o TSR estiver in ctivo, altera a variavel (state) de forma }
        { a que este possa ser activado pelas interrup‡„oes $08 ou $28 }
	    if state = inactive then state := hot_key_set;
    	end
	else
    	{ se as teclas de activa‡„o n„o estiverem premidas, chama a antiga }
        { rotina de tratamento da interrup‡„o 9 de forma a que a tecla }
        { premida possa ser colocada no buffer do teclado }
		calloldint(oldint09);
end;

{ esta rotina ‚ executada sempre que ocorrer um erro critico, estando activa }
{ s¢ quando o TSR tamb‚m est . o valor 3 colocado em AX faz com que o DOS }
{ ignore o erro }
procedure int24(flags,cs,ip,ax,bx,cx,dx,si,di,ds,es,bp : word); interrupt;
begin
	ax := 3;	{ ignora o erro }
end;

{ esta rotina ‚ a responsavel pela a activa‡„o do TSR. basicamente, grava }
{ o estado do programa em execu‡„o e activa o TSR. quando este terminar, }
{ restaura o estado do programa interrompido }
procedure popup;
begin
    state := running;	{ sinaliza a activa‡„o do TSR }

	asm				{ guarda a pilha actual e activa a do TSR }
    	cli
        mov oldss, ss
        mov oldsp, sp
        mov ss, tsrss
        mov sp, tsrsp
        sti
    end;

	r.ah := $2F;		{ grava o DTA do programa interrompido }
	msdos(r);
	olddtaseg := r.es;
	olddtaofs := r.bx;

	r.ah := $1A;		{ activa o DTA do TSR }
	r.ds := ourdtaseg;
	r.dx := ourdtaofs;
	msdos(r);

	getintvec($24, oldint24);	{ grava o vector da INT 24h }
	setintvec($24, @int24);		{ activa o novo vector da INT 24h }

	r.ah := $51;		{ grava o PSP corrente }
	msdos(r);
	old_psp := r.bx;

	r.ah := $50;		{ activa o PSP do TSR }
	r.bx := tsr_psp;
	msdos(r);

	asm					{ chama a rotina residente }
  		call dword ptr poprtn
	end;

	r.ah := $1A;		{ restaura o DTA do programa interrompido }
	r.ds := olddtaseg;
	r.dx := olddtaofs;
	msdos(r);

	setintvec($24, oldint24);	{ restaura o vector da INT 24h }

	r.ah := $50;		{ restaura o PSP do programa interrompido }
	r.bx := old_psp;
	msdos(r);

    asm					{ restaura a pilha do programa interrompido }
    	cli
        mov ss, oldss
        mov sp, oldsp
        sti
    end;

	state := inactive;		{ sinaliza a desactiva‡„o }
end;

{ esta rotina ‚ executada sempre que o DOS est  numa situa‡„o de espera; }
{ no prompth, por exemplo. tem como fun‡„o activar o TSR quando o DOS }
{ est  simplesmente em espera }
procedure int28(flags,cs,ip,ax,bx,cx,dx,si,di,ds,es,bp : word); interrupt;
begin
	calloldint(oldint28);	{ chama a antiga rotina de tratamento da INT $28 }
	{ se a hot-key foi premida, activa o TSR }
	if state = hot_key_set then popup;
end;

{ esta rotina ‚ a responsavel pela activa‡„o do TSR quando o DOS n„o est  }
{ activo. ‚ executada automaticamente (via hardware) 18,2 vezes por segundo }
procedure int08(flags,cs,ip,ax,bx,cx,dx,si,di,ds,es,bp : word); interrupt;
begin
	calloldint(oldint08);	{ chama a antiga rotina de tratamento da INT 8 }
    { se a hot-key foi premida e o DOS n„o est  activo, activa o TSR }
	if (state = hot_key_set) and (in_dos^ = 0) then popup;
end;

{ esta fun‡„o ‚ a responsavel pela desinstala‡„o da memm¢ria do TSR. }
{ retomando TRUE se a opera‡„o foi concretizada com sucesso ou FALSE se n„o }
function tsrexit : boolean;
var a, b, c, d : pointer;
begin

	{ s¢ permite a desinstala‡„o da mem¢ria se a tentativa for feita }
    { enquanto o TSR estiver activo }
	if state <> running then exit;

	getintvec($08, a);		{ lˆ os endere‡”s actuais das interrup‡”es }
	getintvec($09, b);		{ que foram redireccionadas }
	getintvec($28, c);
	getintvec(tsr_vec, d);

    { se os endere‡os actuais ainda apontarem TODOS para as rotinas do TSR }
    { ent„o o programa pode ser desinstalado da mem¢ria e os vectores de }
    { interrup‡„o restaurados }
	if (a = @int08) and (b = @int09) and (c = @int28) and (d = @id_str) then
		begin
		setintvec($08, oldint08);	{ restaura os vectores utilizados }
		setintvec($09, oldint09);
		setintvec($28, oldint28);
		setintvec(tsr_vec, nil);

		r.ah := $49;			{ liberta a mem¢ria do programa }
		r.es := tsr_psp;
		msdos(r);

		r.ah := $49;			{ liberta o environment block }
		r.es := memw[tsr_psp:$2C];
		msdos(r);

		tsrexit := true;
		end
	else tsrexit := false;
end;

{ esta fun‡„o determina se o TSR j  se encontra residente em mem¢ria, }
{ retomando TRUE em caso afirmativo. caso este n„o estˆja ainda residente, }
{ retoma FALSE e determina qual o vector de interrup‡„o que ficar  }
{ responsavel pela detec‡„o de uma segunda instala‡„o }
function resident : boolean;
var
	vec : byte;
	p : pointer;

begin

	{ percorre todos os vectores entre $60 e $67 }
	for vec := $60 to $67 do
  		begin
		getintvec(vec, p);	{ coloca em p o endere‡o do vector de interrup‡„o }
		if p = nil then		{ se for nulo }
        	begin
            { se ainda n„o foi encontrado o vector para detectar 2¦ instala‡„o }
			if tsr_vec = 0 then tsr_vec := vec;
            end
        else
			begin						{ se o vector n„o for nulo }
            { verifica se este aponta para uma string igual … string de }
            { identifica‡„o do TSR e em caso afirmativo sinaliza que o TSR }
            { j  se encontra residente }
            if id_str = string(p^) then
            	begin
	            resident := true;
    	        exit;
                end;
            end;
  		end;

    { se n„o foi encontrado um vector disponivel para detec‡„o de segunda }
	{ instala‡„o, retuma TRUE }
    resident := (tsr_vec = 0);

end;

{ esta fun‡„o deixa o programa residente em mem¢ria sendo-lhe passando como }
{ parƒmetros a rotina de activa‡„o (pr), o scan code (sc) e a m scara (km) }
procedure go_tsr(pr : pointer; sc, km : byte);
begin

	if resident then exit;	{ n„o instala se o programa j  estiver residente }

	scancode := sc;		{ grava as teclas de activa‡„o e a rotina de pop up }
	keymask := km;
	poprtn := pr;

    swapvectors;	{ restaura os vectores capturados pelo turbo pascal }

	getintvec($08, oldint08);	{ grava vectores a utilizar }
	getintvec($09, oldint09);
	getintvec($28, oldint28);

	setintvec($08, @int08);  	{ redirecciona vectores a utilizar }
	setintvec($09, @int09);
	setintvec($28, @int28);
    setintvec(tsr_vec, @id_str);

	keep(0);					{ sai para o DOS e deixa residente }
end;

{ corpo de inicializa‡„o da UNIT }
begin

    asm					{ grava o endere‡o da pilha do TSR }
    	mov	tsrss, ss
        mov	tsrsp, sp
    end;

	r.ah := $34;		{ grava o endere‡o da flag IN DOS }
	msdos(r);
	in_dos := ptr(r.es, r.bx);

	r.ah := $2F;		{ grava o endere‡o do DTA do TSR }
	msdos(r);
	ourdtaseg := r.es;
	ourdtaofs := r.bx;

	r.ah := $51;		{ grava o endere‡o do PSP do TSR }
	msdos(r);
	tsr_psp := r.bx;

end.
