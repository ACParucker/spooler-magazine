#include <dos.h>


#define	ENTER		0x1C
#define	BACK_SPACE	0xE

typedef struct{
    int bp;
    int di;
    int si;
    int ds;
    int es;
    int dx;
    int cx;
    int bx;
    int ax;
    int ip;
    int cs;
    int fl;
}IREGS;


/*
antigos vectores de interrupáÑo
*/
void (interrupt *old_timer)(void);
void (interrupt *old_key)(void);
void (interrupt *old_disk)(void);
void (interrupt *old_int28)(void);


void uninstall(void);


/*
vari†veis internas
*/
char far *Vid_Mem;
int disk = 0;
int running = 0;
int hot_key_hit = 0;
int ctrl_break;
unsigned dos_segment, dos_busy;
int ss, sp;
char far *dta, *int_dta, *dos_active;
unsigned int_sp, int_ss, int_psp;

int uninstall_flag = 0;


/*
funáÑo do utilizador
*/
void CALL(void);





/*
funáÑo que invoca a anterior
*/
void popup(void)
{
    running = 1;
    hot_key_hit = 0;

    int_sp = _SP;
    int_ss = _SS;

    ctrl_break = getcbrk();

    int_dta = getdta();
    setdta(dta);

    int_psp = getpsp();
    _BX = _psp;
    _AH = 0x50;
    geninterrupt(0x21);

    enable();

    CALL();    /*************/

    disable();

    _BX = int_psp;
    _AH = 0x50;
    geninterrupt(0x21);

    setdta(int_dta);

    setcbrk(ctrl_break);

    _SP = int_sp;
    _SS = int_ss;

    running = 0;
}



/*
obter o enderáo da In-DOS flag
*/
void GetDosActiveFlag(void)
{
    _AH = 0x34;
    geninterrupt(0x21);
    dos_active = MK_FP(_ES, _BX);
}



/*
nova ISR para interrupáîes do teclado
*/
void interrupt new_key(void)
{
    static unsigned char kbval;

    kbval = inportb(0x60);
    if((kbval == ENTER || kbval == BACK_SPACE) && !hot_key_hit){
	 hot_key_hit = 1;
	 if(kbval == BACK_SPACE)
	      uninstall_flag = 1;
	 kbval = inportb(0x61);
	 outportb(0x61, kbval | 0x80);
	 outportb(0x61, kbval);
    }

    (*old_key)();
}



/*
ISR para interrupáîes de disco
*/
void interrupt new_disk(IREGS r)
{
    disk++;
    (*old_disk)();
    r.ax = _AX;
    r.cx = _CX;
    r.dx = _DX;
    r.es = _ES;
    r.di = _DI;
    r.fl = _FLAGS;
    --disk;
}



/*
controlo do rel¢gio interno
*/
void interrupt new_timer(void)
{
    (*old_timer)();
    if(hot_key_hit && !disk && !dos_active){
	 if(uninstall_flag==1)
	      uninstall();
	 else
	      popup();
    }
}



/*
interrupáÑo DOS-Idle
*/
void interrupt new_int28(void)
{
    (*old_int28)();
    if(hot_key_hit){
	 if(uninstall_flag==1)
	      uninstall();
	 else
	      popup();
    }
}



/*
Verificar se existe algum outro TSR executado posteriormente a este e
que utilize pelo menos um destes vectores de interrupáÑo.
*/
int is_safe_uninstall(void)
{
    return((getvect(0x8) == new_timer && \
	    getvect(0x09) == new_key && \
	    getvect(0x13) == new_disk && \
	    getvect(0x28) == new_int28) ? 1 : 0);
}



/*
Remover o programa de mem¢ria.
*/
void uninstall(void)
{
    uninstall_flag = 0;

    if(!is_safe_uninstall())
	 return;

    setvect(0x09, old_key);
    setvect(0x08, old_timer);
    setvect(0x13, old_disk);
    setvect(0x28, old_int28);
    freemem(_psp);
    freemem(peek(_psp, 0x2C));
}



/*
funáÑo principal
*/
int main(void)
{
    unsigned hm;
    union REGS r;

    r.h.ah = 0xF;
    if((int86(0x10, &r, &r) & 0xFF)==7)
	 Vid_Mem = (char far *)MK_FP(0xB000,0x0000);
    else
	 Vid_Mem = (char far *)MK_FP(0xB800,0x0000);

    GetDosActiveFlag();

    hm = _SS + ((_SP + 256) / 16);

    dta = getdta();
    ss = _SS;
    sp = _SP;

    old_timer = getvect(0x8);
    old_key = getvect(0x9);
    old_disk = getvect(0x13);
    old_int28 = getvect(0x28);

    setvect(0x8, new_timer);
    setvect(0x9, new_key);
    setvect(0x13, new_disk);
    setvect(0x28, new_int28);

    _DX = hm - _psp + 1;
    _AX = 0x3100;
    geninterrupt(0x21);

    return 0;
}









/****************************************************************************/
/*		FUNÄèO(îes) INVOCADA PELO NUCLEO DO TSR		   	    */
/****************************************************************************/

#include <stdio.h>
#include <io.h>
#include <sys/stat.h>

void CALL(void)
{
    int h;

    printf("\nTESTANDO ESCRITA NO êCRAN COM TSR >");

    h = creat("TESTE", S_IWRITE);
    if(h==-1){
	printf("\nERRO: na criaáÑo do ficheiro");
	return;
    }
    if(write(h, "ESCREVENDO...", 13)==-1)
	printf("\nERRO: na escrita em disco");

    printf("\nEscrita realizada com sucesso >");
    close(h);
}