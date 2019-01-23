/*

      JOYSTICK.C

      Exemplo de como utilizar as fun‡”es do ficheiro JOYSTICK.H

      Este c¢digo ou partes do mesmo pode ser distribuido ou
      integrado livremente em programas para qualquer tipo de uso,
      desde que na sua distribui‡„o os coment rios sejam divulgados
      intactos.

      Para quaisquer coment rios ou d£vidas contactar o autor:

	Pedro Sinogas
	Rua A - Lote 6A
	Madorna
	2775 Parede

      Novembro 93
*/


#include <Joystick.h>
#include <Stdio.h>
#include <Conio.h>

void main(void)
{
 clrscr();
 gotoxy(1,1); printf("Joystick 1");
 gotoxy(1,4); printf("Joystick 2");
 do
 {
  gotoxy(2,2); printf("%i  ", Stick(0));
  gotoxy(16,2); printf("%i  ", Stick(1));
  gotoxy(30,2); printf("%i  ", Strig(0));
  gotoxy(44,2); printf("%i  ", Strig(1));
  gotoxy(2,5); printf("%i  ", Stick(2));
  gotoxy(16,5); printf("%i  ", Stick(3));
  gotoxy(30,5); printf("%i  ", Strig(2));
  gotoxy(44,5); printf("%i  ", Strig(3));
 }
 while (!kbhit());
}