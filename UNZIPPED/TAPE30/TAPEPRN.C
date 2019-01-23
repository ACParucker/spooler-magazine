/*

	Ficheiro: TAPEPRN.C
	Descri‡„o: Rotinas de manipula‡„o da impressora
	Programa‡„o por: Carlos Ladeira     23/03/1994

*/

#include <bios.h>
#include <dos.h>
#include "tape.h"

extern struct tape *info;

/* linha de mira */
char line[] = "+  -  -  -  -  -  -  -  -  -  -  -  -  - +\n";

int porta = LPT1;
byte PrnX=0, i;

void PrintTape()	/* imprime a etiqueta corrente */
{
  char ok;

  CursorSmall();
  message(" Qual o tipo da sua impressora: EPSON / IBM / HP-LASER ? ");
  XYCh(32, 24, 0x1E, 'E');
  XYCh(40, 24, 0x1E, 'I');
  XYCh(46, 24, 0x1E, 'H');

  for (;;) {
	switch (GetKey()) {
	  case 'e': case 'E':       /* foi escolhido o modo EPSON */
		message(" Imprimindo em modo EPSON ...");
		EPSON_print();
		return;
	  case 'i': case 'I':       /* foi escolhido o modo IBM */
		message(" Imprimindo em modo IBM ...");
		IBM_print();
		return;
	  case 'h': case 'H':       /* foi escolhido o modo HP */
		message(" Imprimindo em modo HP-LASER ...");
		HP_print();
		return;
	  case ESC: return;         /* foi premido ESCAPE */
	  }
	}
}

void EPSON_print()  /* imprime a etiqueta em modo EPSON */
{
  print(ESC); print(64);         /* reset */
  print(ESC); print(116); print(1);  /* select character table 1 */
  print(ESC); print(120); print(1);      /* set NLQ */
  printstr(line, PrnX);

  print(ESC); print(33); print(41);  /* double-width + emphasized + elite */
  printstr(info->data.message, 1);
  printstr(info->data.len, 21);
  printstr("\n\n", PrnX);

  print(ESC); print(33); print(8);   /* emphasized */
  printstr("Fonte:", 3);

  print(ESC); print(33); print(72);  /* italic + emphasized */
  printstr(info->data.source, 10);
  printstr("\n", PrnX);

  print(ESC); print(33); print(0);   /* normal */
  printstr(line, PrnX);

  print(ESC); print(33); print(41);  /* double-width + emphasized + elite  */
  printstr("A", 1);
  printstr(info->data.Aauthor, 3);
  printstr("\n", PrnX);
  printstr("B", 1);
  printstr(info->data.Bauthor, 3);
  printstr("\n", PrnX);

  print(ESC); print(33); print(0);   /* normal */
  printstr(line, PrnX);

  print(ESC); print(33); print(41);  /* double-width + emphasized + elite */
  printstr("A", 1);

  print(ESC); print(33); print(72);  /* italic + emphasized */
  printstr(info->data.Aalbum, 4);
  printstr("\n", PrnX);

  print(ESC); print(33); print(4);   /* condensed */
  for (i=0; i<6; i++) {
	printstr(info->data.Amusic[i], 2);
	printstr(info->data.Amusic[i+6], 35);
	printstr("\n", PrnX);
	}
  printstr("\n", PrnX);

  print(ESC); print(33); print(41);  /* double-width + emphasized + elite */
  printstr("B", 1);

  print(ESC); print(33); print(72);  /* italic + emphasized */
  printstr(info->data.Balbum, 4);
  printstr("\n", PrnX);

  print(ESC); print(33); print(4);       /* condensed */
  for (i=0; i<6; i++) {
	printstr(info->data.Bmusic[i], 2);
	printstr(info->data.Bmusic[i+6], 35);
	printstr("\n", PrnX);
	}

  print(ESC); print(33); print(0);   /* normal */
  printstr(line, PrnX);
  printstr("\n", PrnX);

  print(ESC); print(120); print(0);  /* set DRAFT */
}

void IBM_print()	/* imprime a etiqueta em modo IBM */
{
  print(24);				/* clear buffer */
  print(ESC); print(73); print(3);   /* select font :NLQ */
  printstr("\n\n", PrnX);
  printstr(line, PrnX);

  print(14);				/* set double-width for 1 line */
  print(ESC); print(69);         /* set emphasized */
  print(ESC); print(58);         /* set elite */
  printstr(info->data.message, 1);
  printstr(info->data.len, 21);
  printstr("\n\n", PrnX);

  print(18);				/* set pica */
  printstr("Fonte:", 3);
  printstr(info->data.source, 10);
  printstr("\n", PrnX);

  print(ESC); print(70);         /* clear emphasized */
  printstr(line, PrnX);

  print(14);				/* set double-width for 1 line */
  print(ESC); print(69);         /* set emphasized */
  print(ESC); print(58);         /* set elite */
  printstr("A", 1);
  printstr(info->data.Aauthor, 3);
  printstr("\n", PrnX);

  print(14);				/* set double-width for 1 line */
  printstr("B", 1);
  printstr(info->data.Bauthor, 3);
  printstr("\n", PrnX);

  print(18);				/* set pica */
  print(ESC); print(70);         /* clear emphasized */
  printstr(line, PrnX);

  print(14);				/* set double-width for 1 line */
  print(ESC); print(69);         /* set emphasized */
  print(ESC); print(58);         /* set elite */
  printstr("A", 1);

  print(18);				/* set pica */
  print(20);				/* clear double-width */
  printstr(info->data.Aalbum, 4);
  printstr("\n", PrnX);

  print(ESC); print(73); print(0);   /* select font: DRAFT */
  print(ESC); print(70);         /* clear emphasized */
  print(15);				/* set condensed */
  for (i=0; i<6; i++) {
	printstr(info->data.Amusic[i], 2);
	printstr(info->data.Amusic[i+6], 35);
	printstr("\n", PrnX);
	}
  printstr("\n", PrnX);

  print(ESC); print(73); print(3);   /* select font: NLQ */
  print(14);            		/* set double-width for 1 line */
  print(ESC); print(69);         /* set emphasized */
  print(ESC); print(58);         /* set elite */
  printstr("B", 1);

  print(18);				/* set pica */
  print(20);				/* clear double-width */
  printstr(info->data.Balbum, 4);
  printstr("\n", PrnX);

  print(ESC); print(73); print(0);       /* select font: DRAFT */
  print(ESC); print(70);         /* clear emphasized */
  print(15);				/* set condensed */
  for (i=0; i<6; i++) {
	printstr(info->data.Bmusic[i], 2);
	printstr(info->data.Bmusic[i+6], 35);
	printstr("\n", PrnX);
	}

  print(18);				/* set pica */
  print(ESC); print(73); print(3);       /* select font: NLQ */
  printstr(line, PrnX);
  printstr("\n", PrnX);

  print(ESC); print(73); print(0);   /* select font: DRAFT */
}

void HP_print()
{
  prints("\x1b""E");            /* reset */
  prints("\x1b""&l0O");         /* portrait mode */
  prints("\x1b""(4S");          /* ISO 16 : Portugˆs - primary font */
  prints("\x1b""(s5T");         /* typeface - TmsRmn */
  prints("\x1b""(s0P");         /* espa‡amento fixo */
  prints("\x1b""(s10H");        /* largura normal 10 CPI */

  printstr(line, PrnX);         /* escreve uma linha de mira */

  prints("\x1b""(s3B");         /* stroke weight = 3 - BOLD */
  printstr(info->data.message, 2);
  printstr(info->data.len, 37);
  printstr("\n\n", PrnX);
  printstr("Fonte:", 3);
  prints("\x1b""(s0B");         /* stroke weight = 0 - NORMAL */
  prints("\x1b""(s1S");         /* impress„o em it lico */
  printstr(info->data.source, 10);
  prints("\x1b""(s0S");         /* cancela it lico */
  printstr("\n", PrnX);

  printstr(line, PrnX);         /* escreve uma linha de mira */

  prints("\x1b""(s3B");         /* stroke weight = 3 - BOLD */
  printstr("A", 1);
  prints("\x1b""(s0B");         /* stroke weight = 0 - NORMAL */
  prints("\x1b""(s1S");         /* impress„o em it lico */
  printstr(info->data.Aauthor, 3);
  prints("\x1b""(s0S");         /* cancela it lico */
  printstr("\n", PrnX);
  prints("\x1b""(s3B");         /* stroke weight = 3 - BOLD */
  printstr("B", 1);
  prints("\x1b""(s0B");         /* stroke weight = 0 - NORMAL */
  prints("\x1b""(s1S");         /* impress„o em it lico */
  printstr(info->data.Bauthor, 3);
  prints("\x1b""(s0S");         /* cancela it lico */
  printstr("\n", PrnX);

  printstr(line, PrnX);         /* escreve uma linha de mira */

  prints("\x1b""(s3B");         /* stroke weight = 3 - BOLD */
  printstr("A", 1);
  printstr(info->data.Aalbum, 4);
  prints("\x1b""(s0B");         /* stroke weight = 0 - NORMAL */
  printstr("\n", PrnX);

  prints("\x1b""(s16.5H");      /* condensado 16.5 CPI */

  for (i=0; i<6; i++) {
	printstr(info->data.Amusic[i], 3);
	printstr(info->data.Amusic[i+6], 36);
	printstr("\n", PrnX);
	}
  printstr("\n", PrnX);

  prints("\x1b""(s3B");         /* stroke weight = 3 - BOLD */
  prints("\x1b""(s10H");        /* largura normal 10 CPI */
  printstr("B", 1);
  printstr(info->data.Balbum, 4);
  prints("\x1b""(s0B");         /* stroke weight = 0 - NORMAL */
  printstr("\n", PrnX);

  prints("\x1b""(s16.5H");      /* condensado 16.5 CPI */
  for (i=0; i<6; i++) {
	printstr(info->data.Bmusic[i], 3);
	printstr(info->data.Bmusic[i+6], 36);
	printstr("\n", PrnX);
	}

  prints("\x1b""(s10H");        /* largura normal 10 CPI */
  printstr(line, PrnX);
  printstr("\n\n", PrnX);
}

void printstr(char *s, unsigned char x)	/* envia uma string para a impressora */
{
  for (;PrnX<x;PrnX++) print(32);	/*  vai at‚ a posi‡„o pretendida */

  while (*s) {
    if (*s=='\n') {
      PrnX=0;
	  print(13);
	  }
    else PrnX++;
    print(*s++);
    }
}

/* envia o byte passado como parƒmetro para a impressora */
/* retoma o estado actual da impressora */
print(int ch)
{
  return biosprint(_PRINTER_WRITE, ch, porta);
}

/* escreve uma string na impressora, sem verificar erros */
void prints(char *s)
{
  while (*s) print(*s++);
}

