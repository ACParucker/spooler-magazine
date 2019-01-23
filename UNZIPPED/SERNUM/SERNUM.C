
// Testado com BORLANDC 3.1
// Compilar em MODEL LARGE


#include <stdio.h>      // 'C' Include File
#include <dos.h>        // 'C' Include File
#include <Extend.api>   // 'Clipper 5.2'Include File


typedef struct DriveInfo {

 int levelInfo;
 long SerialNum;
 char VolLabel[11];
 char FileSys[8];
 char Reserved[64];

} DriveInfo;

unsigned _RealCvtVector;      // Evita 'Warning' na compila‡„o.
                              // Ver coment rio seguinte.

void far abort(void)           // Evita 'Warning' na compli‡„o.
                               // Pode ser chamado pela fun‡„o 'sprintf'.
                               // A fun‡„o '_abort' ‚ tratada por C0L.OBJ
                               // que n„o foi ligado com o programa.
                               // Nota: Talvez n„o seja necess rio com outros
                               // compiladores (contudo n„o foi testado).
{
 asm mov ax, 4c01h
 asm int 21h

}

CLIPPER GETSERIAL (void)
{

 union REGS regs;
 struct SREGS segs;
 DriveInfo info;

 static char buffer[10];

 regs.x.ax = 0x6900;

 regs.h.bl = _parni(1,1);           // O parƒmetro passado pelo Clipper.

 regs.x.dx = FP_OFF (&info);
 segs.ds   = FP_SEG (&info);

 intdosx (&regs, &regs, &segs);
 if(regs.x.cflag) buffer[0]='\0';
 else sprintf (buffer, "%Fp", info.SerialNum);
 _retc (buffer);                    // O que se retorna ao Clipper.

}

