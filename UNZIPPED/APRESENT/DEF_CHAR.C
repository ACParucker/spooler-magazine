#pragma inline

#include <dos.h>


typedef unsigned char byte;
typedef unsigned int word;

void DefChar(int code, char *s)
{
    word off, seg;

    off = FP_OFF(s);
    seg = FP_SEG(s);
    asm  push bp;
    asm  mov  es, seg;
    asm  mov  ax, off;
    asm  mov  cx, 1;
    asm  mov  dx, code;
    asm  mov  bx, 0x1600;       /*  BH bytes por caracter: 16		*/
				/*  BL bloco de fonte a chamar: 0	*/
				/*  ES:BP apontador para a tabela		*/
    asm  mov  bp, ax;           /*  CX n£mero de caracteres: 1		*/
    asm  mov  ax, 0x1100;	/*  AH sub-fun‡„o: 11h			*/
				/*  AL Fun‡„o Load user-define font	*/
    asm  int  0x10;
    asm  pop  bp;
}