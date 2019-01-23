#include <dos.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INT_MULTIPLEX	0x2F
#define INT_VIDEO       0x10
#define MODE_DOS		0      // DOS
#define MODE_DOS_TS		1      // DOS Task Switcher
#define MODE_WIN3X_STD	2      // WINDOWS ver 3x modo Standard
#define MODE_WIN3X_2X	3      // WINDOWS 386 ver 2x
#define MODE_WINX_386E	4      // WINDOWS ver 3x modo Enhanced
#define ZERO 			MK_FP(0xA000,0);
#define COLD_BOOT		0x99
#define WARM_BOOT		0x98
#define RED				0x00
#define GREEN           0x01
#define BLUE            0x02
#define MCGAPALSIZE		768     // 256 cores * 3 cores prim rias

void			x_reboot(int);
void			x_set(char *);
unsigned long	x_romcode(void);
int 			x_shell(void);
extern void 	INT_2E(char *);

void 			x_setrgb(int, int, int, int);
int 			x_getrgb(int, int);
void 			x_getpal(char *);
void 			x_setpal(char *);
void 			x_fadeout(int);
void 			x_fadein(int, char *);
void 			x_voff(void);
void 			x_von(void);