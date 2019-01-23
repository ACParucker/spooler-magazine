#include "weird2.h"

extern void interrupt _ResClock(void);
extern void interrupt (*_OldHandler) (void);
extern long _TimeCounter;
extern  int _ClockActivo,
			_ClockRow,
			_ClockCol,
			_ClockAttr,
			_ClockOn;

/////////////
// For‡a (leia-se 'f¢r‡a') um Print-Screen. D  o mesmo efeito se carregarem
// em Shift+Prt Sc.
//
// Retorna 00   se f“r efectuado com sucesso
//		   FF   se houve algum erro pelo meio
/////////////////////
byte x_PrintScr(void)
{
 geninterrupt(INT_PRINTSCR);

 return(peekb(0x0000, 0x0500));
}

/////////////
// Desliga o motor de uma drive ap¢s 'ticks' ticks -> (18.2 ticks / seg)
/////////////////////
void x_MotorOff(byte ticks)
{
 _AH = 0x35;                   // Procura o endere‡o do
 _AL = 0x1E;                   //   interrupt handler
 geninterrupt(INT_DOSCALL);    //

 pokeb( _ES, (_BX+2), ticks); // Altera o n§ de 'ticks'
}

/////////////
// Liga/Desliga CapsLock, NumLock, ScrollLock ou Insert
/////////////////////
int x_KeyLights(int whatkeys)
{
 int OldValue;

 OldValue = peek(0, 0x417);

 poke(0, 0x417, whatkeys);

 return(OldValue);
}

/////////////
// Determina se est  activo um monitor policrom tico
/////////////////////
byte x_IsColor(void)
{
 return (peek(0, 0x463)==0x3D4);
}

/////////////
// Determina o n§ de drives existentes
/////////////////////
byte x_NumDrives(void)
{
 geninterrupt(INT_EQUIPMENT);
 _AX >>= 6;                      // Isola s¢ os
 _AX &= 0x3;                     //   bits necess rios

 return(_AX+1);
}

/////////////
// Determina se est  presente um coprocessador matem tico
/////////////////////
byte x_Coprocessor(void)
{
 geninterrupt(INT_EQUIPMENT);
 _AX >>= 1;                      // Isola s¢ os
 _AX &= 0x1;                     //   bits necess rios

 return(_AX);
}

/////////////
// Inicializa o rel¢gio e mostra-o no ecran, nas coordenadas
//   e cores desejadas.
/////////////////////
void x_StartClock(int x, int y, int corfore, int corback)
{
 struct time tempo;
 unsigned long h, m, s;

 gettime(&tempo);                       // Inicializa o tempo corrente
 h = ((long)tempo.ti_hour * 3600);
 m = ((long)tempo.ti_min * 60);
 s = ((long)tempo.ti_sec);
 _TimeCounter = (h+m+s) * 18.2;

 _OldHandler = getvect(INT_TICKS);     // Captura o endere‡o da intr. antiga
 setvect(INT_TICKS, _ResClock);        // Instala uma nova interrup‡„o

 _ClockActivo = 1;                         // The Clock Is On !!!!!

 x_ClockPos(y, x);
 x_ClockColor(corfore, corback);

 x_ShowClock();                              // Mostra o rel¢gio
}

/////////////
// Desactiva o rel¢gio, repondo a interrup‡„o antiga
/////////////////////
void x_StopClock(void)
{
 if (_ClockActivo)
 {
  setvect(INT_TICKS, _OldHandler);         // Devolve a interrup‡„o antiga
  _TimeCounter = 0;
  _ClockActivo = 0;
 }
}

/////////////
// Esta ‚ a rotina que implementa o rel¢gio digital residente (dito assim at‚
//    parece boa, n„o ?)
/////////////////////
void interrupt _ResClock(void)
{
 char
  display[8] = {"00:00:00"};     // Display do 'nosso' rel¢gio
 long
  Clock,
  resto;
 unsigned char
  hours,
  minutes,
  seconds;
 unsigned int
  (far *screen)[80];

 if (_ClockActivo)
 {
  _OldHandler();        // Executa a interrup‡„o antiga

  if (_ClockOn)
  {
   // Calcula as horas, minutos e segundos correntes
   Clock   = _TimeCounter / 18.2;
   hours   = Clock / 3600;
   resto   = Clock % 3600;

   minutes = resto / 60;
   resto   = resto % 60;

   seconds = resto;

   // Preenche o display
   display[0] = '0' + (hours / 10);
   display[1] = '0' + (hours % 10);
   display[3] = '0' + (minutes / 10);
   display[4] = '0' + (minutes % 10);
   display[6] = '0' + (seconds / 10);
   display[7] = '0' + (seconds % 10);

   // Escreve directamente para o ecran
   screen = MK_FP(0xB800,0);
   screen[_ClockRow][_ClockCol]   = display[0] + _ClockAttr;
   screen[_ClockRow][_ClockCol+1] = display[1] + _ClockAttr;
   screen[_ClockRow][_ClockCol+2] = display[2] + _ClockAttr;
   screen[_ClockRow][_ClockCol+3] = display[3] + _ClockAttr;
   screen[_ClockRow][_ClockCol+4] = display[4] + _ClockAttr;
   screen[_ClockRow][_ClockCol+5] = display[5] + _ClockAttr;
   screen[_ClockRow][_ClockCol+6] = display[6] + _ClockAttr;
   screen[_ClockRow][_ClockCol+7] = display[7] + _ClockAttr;
  }
  _TimeCounter++;     // Incrementa o contador
 }
}

/////////////
// P ra o rel¢gio (apenas no ecran, pois continua activo)
/////////////////////
void x_HideClock(void)
{
 _ClockOn = 0;
}

/////////////
// Reactiva o rel¢gio (faz o inverso da fun‡„o 'HideClock')
/////////////////////
void x_ShowClock(void)
{
 _ClockOn = 1;
}

/////////////
// Altera as cores de foreground e background do rel¢gio
/////////////////////
void x_ClockColor( int fore, int back )
{
 _ClockAttr = ((back << 4) + fore) << 8;
}

/////////////
// Altera a posi‡„o do rel¢gio no ecran
/////////////////////
void x_ClockPos( int col, int row )
{
 _ClockRow = row;
 _ClockCol = col;
}
