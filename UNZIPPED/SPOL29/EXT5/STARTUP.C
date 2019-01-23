/*
///////////////////////////////////////////////////////////////

Programa:.... VIRT86.EXE
	      Programa demonstrativo de execu‡„o em
	      Modo Virtual 86.

M¢dulo:...... STARTUP.C
Autor:....... Jos‚ P scoa

Compilado com: Borland C++ 3.1
Modelo: "COMPACT" com C0C.OBJ modificado.

Produzido em Dezembro 1993 para a revista SPOOLER.

Nota: S¢ ‚ execut vel em computadores com processador >= 386SX

*//////////////////////////////////////////////////////////////

#include <stdio.h>
#include <conio.h>
#include <dos.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "real.h"
#include "startup.h"

#pragma argsused

void main(int argc, char *argv[])
{
unsigned long extmem;
int cachenum;

/* Primeiro ver se temos as condi‡”es reunidas para iniciar o teste. */

	if(OldDos())
	{
	printf("\n\7Necess rio DOS de vers„o superior a 3.3.");
	return;
	}
	extmem = (unsigned long) ExtMem();
	if(extmem <= 0x400)    // M¡nimo 1 MegaByte de mem¢ria "extended"
	{
	printf("\n\7Mem¢ria extendida insuficiente para o teste."
		 "\nDetectados apenas %d KB de mem¢ria extendida.", extmem);
	return;
	}
	extmem *= 0x0400;       // Converte Megabytes para Bytes.
	CalcVirtMem(extmem);

	cachenum=Is_Cache();
	if(cachenum)           // Aten‡„o: Este teste n„o ‚ exaustivo a todos os modelos
			       // de "cache". N„o utilizar "cache" de disco com o Virt86.exe !
			       // Nota: Contudo como a maior parte dos programas de "cache"
			       // necessitam de mem¢ria "extended" ou "expanded" tamb‚m n„o
			       // executariam na configura‡„o requerida pelo Virt86.exe.
			       // Trata-se de uma medida cautelar.
	{
	printf("\n\7Detectado 'cache' de disco: %s."
		 "\nN„o deve utilizar 'cache' de disco durante a execu‡„o do VIRT86.EXE."
		 "\nPerigo de corrup‡„o dos 'buffers' internos quando do regresso ao"
		 "\nModo Real e eventual danifica‡„o de ficheiros.\n", diskcache[cachenum-1]);
	return;
	}

	if (!check386())      // Necess rio um 386SX pelo menos.
	{
	printf("\n\7Este programa foi preparado para um computador 386 SX ou superior.\n");
	return;
	}
	if (IsProtectedMode())  // Temos mesmo de ser donos e senhores do sistema.
				// Vamos trabalhar em 'ring 0' e n„o pode
				// haver sociedades.
	{
	printf("\n\7Este programa n„o pode iniciado se o computador se encontrar"
		  "\nem MODO VIRTUAL 86."
		 "\nRetire do seu CONFIG.SYS, caso l  se encontrem, 'device drivers'"
		 "\ncomo o EMM386, QEMM386 e 386MAX."
		 "\nFa‡a o rearranque do sistema e tente de novo.\n");
	return;
	}
	if (Is_DPMI())
	{
	printf("\n\7Este programa n„o pode ser executado em ambiente DPMI."
		 "\nRetire o 'driver' DPMI do seu CONFIG.SYS rearranque o"
		 "\nsistema e tente de novo.\n");
	return;
	}

	if (Is_Himem())
	{
	printf("\n\7Foi detectado HIMEM.SYS ou outro 'device driver' XMS."
		 "\nA execu‡„o do VIRT86.EXE n„o permite a existˆncia de "
		 "\nquaisquer outros programas que possam intervir tamb‚m "
		 "\nna utiliza‡„o da mem¢ria 'extended'.");
	return;
	}
	CheckVideoType();
	clrscr();
	if(argv[1]!=NULL) CommdLine(argv);
	protectentry();        // Neste ponto damos a vez ao m¢dulo
			       // em Assembly VMONITOR.ASM para a
			       // actua‡„o em Modo Protegido.
	if(virtualbox)
	{
	clrscr();          // Quando for para entrar em Modo Virtual 86
	fakemem();
	exit(0);           // a sa¡da ‚ por aqui.
	}

	CheckVideoType();     // Agora trata-se apenas de garantir modo texto
			      // de 80 colunas.

	if(erro) ReportError();

	SayHelloRealWorld();
	gotoxy(1,24);
	exit(0);
}

void  CheckVideoType(void)
{

union REGS inregs, outregs;
unsigned far *crt;

	VideoSegment = 0xB8000L;            // Assume placa Cor como 'default'.
	crt=(unsigned far *) 0x00400063L;
	if(*crt==0x3B4)                     // Mas afinal ‚ Mono.
	{
		VideoSegment = 0xB0000L;
		inregs.h.al=7;
	}
	else inregs.h.al=3;
	inregs.h.ah=0;                       // Aproveita-se para
					     // garantir um modo v¡deo adequado.
	int86(0x10,&inregs,&outregs);        // Modo texto 80 cols.
}

// Mensagem na reentrada em Modo Real.

void SayHelloRealWorld(void)
{

char far *screenaddr;
int i;

	screenaddr = (char far *) (VideoSegment << 12);
	screenaddr += 19 * 160;
	for(i=0; i<REAL_LENGTH; i++)
		screenaddr[i] = Real[i];
	delay(700);
	for(i=1; i<REAL_LENGTH; i+=2)
		screenaddr[i] &= 0x7F;
}

// Determina a mem¢ria "extended" em KBs.

unsigned ExtMem(void)
{
unsigned extmem;

	outportb(0x70, 0x18);           //   Extra¡mos o valor do CMOS
	extmem = inportb(0x71) << 8;    //   para evitar sermos enganados.
	outportb(0x70, 0x17);
	extmem += inportb(0x71);
	return extmem;
}


// Todos os erros ocorridos em Modo Protegido ou Virtual 86 vˆm cair aqui.

void ReportError(void)
{
int i;
char *SayError[]= { "*** INT 0 - DIVIDE ERROR ***",
		    "*** INT 1 - DEBUG EXCEPTION ***",
		    "*** INT 2 - NMI INTERRUPT ***",
		    "*** INT 3 - BREAKPOINT ***",
		    "*** INTO - OVERFLOW EXCEPTION ***",
		    "*** INT 5 - BOUND RANGE EXCEPTION ***",
		    "*** INT 6 - INVALID OPCODE ***",
		    "*** INT 7 - COPROCESSOR NOT AVAILABLE ***",
		    "*** INT 8 - DOUBLE FAULT ***",
		    "*** INT 9 - COPROCESSOR SEGMENT OVERRUN ***",
		    "*** INT 10 - INVALID TSS FAULT ***",
		    "*** INT 11 - SEGMENT NOT PRESENT FAULT ***",
		    "*** INT 12 - STACK FAULT ***",
		    "*** INT 13 - GENERAL PROTECTION FAULT ***",
		    "*** INT 14 - PAGE FAULT ***",
		    "*** INDEFINED FAULT (INTEL RESERVED) ***"
		    "*** INT 16 - COPROCESSOR ERROR ***",
				  };
	clrscr();
	printf("\n\nSa¡da anormal.");
	printf("\n\nErro: %s",SayError[code_erro]);

	if(pageerrorok) {

// O tratamento do c¢digo de erro para "Page Fault" ‚ diferenciado.

	printf("\nErro na pilha: %lx",stackerror);
	if (stackerror & 0x01)
	printf("\n   Processador executava em modo 'USER'.");
	else printf("\n   Processador executava em modo 'SUPERVISOR'.");
	if (stackerror & 0x02)
		printf("\n   O acesso foi de 'escrita'.");
	else printf("\n   O acesso foi de 'leitura'.");
	if (stackerror & 0x04)
		printf("\n   Viola‡„o do sistema de protec‡„o da p gina.");
	else printf("\n   P gina n„o presente em mem¢ria.");
		printf("\nEndere‡o linear de 32 bits: %08lX", pageerror);
	}
	if(stackerrorok) {

// Erros 8, 10, 11, 12 e 13 devolvem c¢digo de erro na pilha.
  
		printf("\nErro na pilha: %lx",stackerror);
		if (! (stackerror & 0x01))
			printf("\n   Erro interno do programa em execu‡„o.");
		else printf("\n   Erro externo ao programa em execu‡„o.");
		if(stackerror & 0xFFFF)
		{
			if (stackerror & 0x02)
				printf("\n   Erro relativo a 'Gate Descriptor' na IDT.");
			else if (stackerror & 0x04)
					printf("\n   Erro relativo a 'Descriptor' na LDT.");
			      else printf("\n   Erro relativo a 'Descriptor' na GDT.");
					stackerror = (stackerror & 0xFFF8) >> 3;
			printf ("\n   Selector = %04X", stackerror);
		}
	}
	printf("\nValor de CS: %04X",stackcs);
	printf("\tValor de EIP: %08lX",stackeip);
	printf("\tValor de EFlags: %08lX",stackflags);
	printf("\nValor de SS: %04X",stackss);
	printf("\tValor de ESP: %08lX",stackesp);
	if(stackvirt)
// Se o erro ocorreu em Modo Virtual 86
	{
		printf("\nValor de DS: %04X",stackds);
		printf("\tValor de ES: %04X",stackes);
		printf("\nValor de FS: %04X",stackfs);
		printf("\tValor de GS: %04X",stackgs);
		if(stackbytesbelow) {
			printf("\nAt‚ 16 bytes antes do erro:\n");
			for(i=0;i<stackbytesbelow;i++)
				printf("%02X ",stackbytes[i]);
		}
		printf("\nByte do erro e 15 bytes seguintes:\n");
		for(i=stackbytesbelow;i<(stackbytesbelow+16);i++)
			printf("%02X ",stackbytes[i]);
		printf("\n16 bytes na pilha do modo virtual 86:\n");
		for(i=0;i<16;i++)
			printf("%02X ",virtstack[i]);
	}
	if(trace_status) {
		printf("\n\nCarregue tecla para nova p gina de informa‡”es.");
		while(kbhit()) getch();
		while(! kbhit());
		clrscr();
		printf("\n\nCS:IP das £ltimas 32 instru‡”es executadas em Modo Virtual 86:\n\n");
		tracecounter --;
		for(i=tracecounter;i<32;i++)
			printf("CS=%04X IP=%04X  |  ",tracebuffer_cs[i], tracebuffer_ip[i]);
		for(i=0;i<tracecounter;i++)
			printf("CS=%04X IP=%04X  |  ",tracebuffer_cs[i], tracebuffer_ip[i]);
		printf("\nTotal de instru‡”es rastreadas: %08lX (hexadecimal) ", no_of_instrs);
	}
}

void CalcVirtMem(unsigned long extmem)
{
unsigned long pages;

	pages = extmem / 0x1000;  // Nunero de p ginas de mem¢ria "extended".

/* Em Modo Virtual 86 a mem¢ria "extended" que ser  informada via
   Int 15h fun‡„o 88h ser  1 Megabyte menos que a verdadeira.
   O Monitor de Modo Protegido ocupar  fisicamente todo o segundo
   Megabyte.
   Este segundo Megabyte ficar  totalmente inv¡sivel a partir da Caixa
   Virtual de DOS.
*/

	ReportVirtExtended = (pages * 0x1000 - 0x100000) / 0x400 ; // Em KB.

}

// Na linha de comando podemos ter declarado zonas de UMB ou ainda a
// ausˆncia de HMA.

void CommdLine(char *args[])
{
int i=1;
int j;
char buffer[20];
char *ptbuf;
char *endptr;
unsigned int lowlim, highlim;
int lenght;
int pages;
int pageinit;

	while(args[i])
	{
		if (! strnicmp ("ram=",args[i],4))
		{
/*

   Os limites s„o em par grafos.
   Ex: RAM=D000-DFFF
   Aten‡„o: Aqui n„o ‚ efectuado qualquer controle   validade das zonas de UMB.
   As seguintes zonas NŽO dever„o normalmente ser inclu¡das pois o sistema
   dever  pendurar.
   A000-AFFF
   F000-FFFF
   Zonas utilizadas por adaptadores de placas de expans„o tamb‚m n„o dever„o
   ser utilizadas. A mais comum ‚ a placa de v¡deo que poder  ocupar a
   zona C000-CFFF.

*/
		ptbuf=&buffer[4];
		strcpy(buffer, args[i]);
		lowlim= (unsigned int) strtoul(ptbuf,&endptr,16);
		lenght=strcspn(ptbuf,"-");
		ptbuf+=lenght+1;
		highlim= (unsigned int) strtoul(ptbuf,&endptr,16);
		highlim++;
		pageinit=(lowlim-0xA000)/256;
		pages=(highlim-lowlim)/256;
		for(j=0;j<pages;j++)
			himap[pageinit + j]=1;
		}
		if (! strnicmp ("nohma",args[i],5)) hmaflag=FALSE;
		i++;
	}
}

