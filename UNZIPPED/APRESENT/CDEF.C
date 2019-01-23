#pragma inline

#include <dos.h>
#include <conio.h>
#include <stdlib.h>

typedef unsigned char byte;
typedef unsigned int word;


void PrintChar(word ch, byte far *arr, byte aa)
{
    char st[9], aux[7], ap[80], entrou;
    byte far *base, i, c, j;

    base = &arr[ch * aa];
    cprintf("\n\r%c  %d\r\n", ch, ch);
    strcpy(ap, "");
    ap[0]='\0';
    aux[0]='\0';
    cprintf("\n\r  Bits  76543210");
    cprintf("\n\r        ³ ³ ³ ³ ");
    cprintf("\n\r       ÚÁÄÁÄÁÄÁÄ¿");
    for(i=0; i < aa; i++){
	 entrou = 0;
	 ap[0] = '\0';
	 c = base[i];
	 for(j=0; j < 8; j++, c <<= 1){
	      st[j] = (c & 128) ? '#' : ' ';
	      if(st[j] == '#'){
		   if(entrou)
			sprintf(aux, "+ 2^%d ", 7-j);
		   else
			sprintf(aux, " 2^%d ", 7-j);
		   strcat(ap, aux);
		   entrou = 1;
	      }
	 }
	 st[8] = '\0';
	 cprintf("\n\r       ³%s³ ", st);
	 cprintf("%s = %d", ap, base[i]);
    }
    cprintf("\n\r       ÀÄÄÄÄÄÄÄÄÙ");
}



int main(int argc, char *argv[])
{
    word off, seg;
    byte far *chs;
    byte t, dcl;

    asm       push bp;
    asm       mov  ah, 0x11;	/* Sub-fun‡„o		*/
    asm       mov  al, 0x30;	/* Servi‡o: obter fonte */
    asm       mov  bh, 0x02;	/* ROM 8 x 14		*/
    asm       int  0x10;
    asm       pop  bp;
    asm       mov  dcl, cl;
    if(dcl==0x10)
	 dcl = 0x06;
    else
	 dcl = 0x02;
    asm       push bp;
    asm       mov  ah, 0x11;
    asm       mov  al, 0x30;
    asm       mov  bh, dcl;
    asm       int  0x10;
    asm       mov  ax, bp;
    asm       pop  bp;

    asm       mov  seg, es;	/* Apontador para a tabela */
    asm       mov  off, ax;
    asm       mov  dcl, cl;

    chs = (byte far *)MK_FP(seg, off);

    if(argc > 1){
	 while(argc>1){
	      clrscr();
	      cprintf("R.R.B.B.   Informa‡„o de caracteres   v 1.0\r\n");
	      PrintChar(atoi(argv[--argc]), chs, dcl);
	      getch();
	 }
    }
    else{
	 for(off=0; off < 256; off++){
	      clrscr();
	      cprintf("R.R.B.B.   Informa‡„o de caracteres   v 1.0\r\n");
	      PrintChar(off, chs, dcl);
	      t = getch();
	      if(t==27)
		   break;
	 }
    }
    return 0;
}
