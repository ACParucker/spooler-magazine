#include <dos.h>

#define byte			unsigned char
#define PRINT_COMPLETE  0x00
#define PRINT_PROGRESS  0x01
#define PRINT_ERROR	 	0xFF

#define KEY_SCROLLLOCK  0x10
#define KEY_NUMLOCK     0x20
#define KEY_CAPSLOCK    0x40
#define KEY_INSERT      0x80

#define INT_PRINTSCR	0x05
#define INT_EQUIPMENT   0x11
#define INT_EXTENDED    0x15
#define INT_DOSCALL		0x21
#define INT_TICKS       0x08

byte	x_PrintScr   ( void );
void	x_MotorOff   ( byte );
int 	x_KeyLights  ( int  );
byte 	x_IsColor    ( void );
byte    x_NumDrives  ( void );
byte 	x_Coprocessor( void );
void 	x_StartClock ( int, int, int, int );
void 	x_StopClock  ( void );
void 	x_HideClock  ( void );
void 	x_ShowClock  ( void );
void    x_ClockColor ( int, int );
void    x_ClockPos   ( int, int );