/*

    Ficheiro: TAPEKBD.C
	Descri‡„o: Rotinas de manipula‡„o do teclado
    Programa‡„o por: Carlos Ladeira     23/03/1994

*/

#include <bios.h>
#include <conio.h>
#include "tape.h"

int GetKey(void)
{
  int key, lo, hi;

  key=bioskey(0);
  lo=key & 0x00FF;
  hi=(key & 0xFF00)>>8;

  return((lo==0) ? 256+hi : lo);
}

void ResetKbd(void)
{
  while (kbhit()) GetKey();
}

