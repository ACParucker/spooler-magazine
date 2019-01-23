/*

      JOYSTICK.H

      Fun‡”es para utilizar o Joystick em C

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

#include <dos.h>
#include <math.h>

#define  JINT     0x15      /* Interrupt para aceder ao Joystick        */
#define  JAH      0x84      /* Fun‡„o que acede ao Joystick             */
#define  JBotoes  0x0000    /* Subfun‡„o que retorna o valor dos bot”es */
#define  JCoor    0x0001    /* Subfun‡„o que retorna as coordenadas     */

int Stick(int NCoor)        /* NCoor contem o n£mero correspondente …   */
{                           /*  coordenada desejada                     */
 union REGS regs;
 regs.h.ah = JAH;
 regs.x.dx = JCoor;
 int86(JINT, &regs, &regs);
 switch (NCoor)
 {
  case 0:  return(regs.x.ax);  /* Coor X do Joystick 1 */
  case 1:  return(regs.x.bx);  /* Coor Y do Joystick 1 */
  case 2:  return(regs.x.cx);  /* Coor X do Joystick 2 */
  case 3:  return(regs.x.dx);  /* Coor Y do Joystick 2 */
  default: return(0);
 }
}

int Strig(int NBotao)       /* NBotao contem o n£mero correspondente ao */
{                           /*  bot„o desejado                          */  
 union REGS regs;
 regs.h.ah = JAH;
 regs.x.dx = JBotoes;
 int86(JINT, &regs, &regs);
 if ((~(regs.h.al) & abs(pow(2,(NBotao+4)))) > 0) return(-1); else return(0);
}