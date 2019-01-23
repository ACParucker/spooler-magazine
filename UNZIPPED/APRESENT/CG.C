#pragma inline
/*
Avisa o complilador que o programa cont‚m blocos asm de forma a evitar
segunda compila‡„o.
*/

#include <dos.h>
#include <conio.h>


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
    asm  mov  bx, 0x1600;
    asm  mov  bp, ax;
    asm  mov  ax, 0x1100;
    asm  int  0x10;
    asm  pop  bp;
}



int main(void)
{
    byte newc[4][16]={
      /* € */
      0, 0, 60, 102, 194, 192, 192, 192, 192, 194, 102, 60, 16, 48, 224, 0,
      /* ‡ */
      0, 0, 0, 0, 0, 124, 198, 192, 192, 192, 198, 124, 24, 112, 0, 0,
      /*a~*/
      0, 0, 118, 220, 0, 120, 12, 124, 204, 204, 204, 118, 0, 0, 0, 0,
      /* o~ */
      0, 0, 118, 220, 0, 124, 198, 198, 198, 198, 198, 124, 0, 0, 0, 0
    };

    cprintf("\n\rR.R.B.Barbosa\n\rRedefini‡„o dos caracteres [‡  €  „   ”]   V 1.0\r\n");

    DefChar(128, newc[0]);
    DefChar(135, newc[1]);
    DefChar(132, newc[2]);
    DefChar(148, newc[3]);


    return 0;
}
