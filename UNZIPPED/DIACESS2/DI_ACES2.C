#include "di_aces1.c"
#include <time.h>
#include <alloc.h>
#include <bios.h>
#include <conio.h>
#include <dos.h>
#include <stdlib.h>

int _drive_;

char far *Vid_Mem = NULL;
#define  __XY__(x, y)          (Vid_Mem + y*160 + (x<<1))


#define DISCOS  5

struct d{
    char ref[80];
    float tt, tp, pp;
}discos[DISCOS] = {
    "Maxtor      345 MB  (64Kb)",  901.0,  14.0,  4.7,
    "W.Digital   345 MB (256Kb)",  999.3,  10.2,  1.1,
    "Seagate     341 MB (256Kb)", 1118.0,   9.2,  3.9,
    "Quantum     320 MB (256Kb)", 1023.0,   9.7,  2.8,
    "MiniScribe   81 MB        ",  550.0,  19.1,  6.1
};


void CursorOn(void)
{
    _AX = 0x0100;
    _CX = 0x0506;
    geninterrupt(0x10);
}



void CursorOff(void)
{
    _AX = 0x0100;
    _CX = 0x2000;
    geninterrupt(0x10);
}

void BkColors(void)
{
    _AX = 0x1003;
    _BX = 0x00;
    geninterrupt(0x10);
}


int GetVideoMode(void)
{
    _AX = 0xF00;
    geninterrupt(0x10);
    return _AL;
}


void InitScreen(void)
{
    int mode;

    mode = GetVideoMode();

    if(mode!=3 && mode!=7 && mode!=2){
	 cprintf("\n\rPara correr este programa o ‚cran deve estar em 80x25");
	 exit(-1);
    }

    if(mode==7)
	 Vid_Mem = (char far *)MK_FP(0xB000, 0x0000);
    else
	 Vid_Mem = (char far *)MK_FP(0xB800, 0x0000);

}


void WriteChar(int x, int y, char ch, int attr)
{
    char far *v;

    v = __XY__(x,y);
    *v++ = ch;
    *v++ = attr;
}

void WriteStr(int x, int y, char *str, int attr)
{
    char far *v;

    v = __XY__(x,y);
    for(; *str ;*v++ = *str++, *v++ = attr);
}



void ReadStr(int x, int y, int size, char *str)
{
    char far *v;

    v = __XY__(x,y);
    for(; size-- ; *v++, *str++ = *v++);
    *str = '\0';
}



int ReadAttr(int x, int y)
{
    char far *v;

    v = __XY__(x,y);
    *v++;
    return(*v);
}



unsigned char ReadChar(int x, int y)
{
    char far *v;

    v = __XY__(x,y);
    return(*v);
}


void Shadow(int x1, int y1, int x2, int y2)
{
    int x, attr;

    for(x = x1 + 1; x <= x2 + 1; x++){
	 attr = (ReadAttr(x, y2 + 1) & 0x77);
	 WriteChar(x, y2 + 1, ReadChar(x, y2 + 1), attr);
    }
    for(x = y1 + 1; x<= y2; x++){
	 attr = ((ReadAttr(x2 + 1, x) & 0x77));
	 WriteChar(x2 + 1, x, ReadChar(x2 + 1, x), attr);
    }
}



#define SHADOW_ON 1
#define SHADOW_OFF 0
#define CLEAR_ON 1
#define CLEAR_OFF 0
#define SINGLE 0
#define  DOUBLE 6

void CharCopy(char *s, int q, int ch)
{
    int x;

    for(x = 0; q-- ;s[x++] = ch);
    s[x] = '\0';
}

void Cls(int x1, int y1, int x2, int y2,int attr)
{
    int y;
    char e[80];

    CharCopy(e, x2 - x1 - 1, ' ');
    for(y = y1 + 1; y < y2 ; y++)
	 WriteStr(x1 + 1, y, e, attr);
}

void Box(int x1, int  y1, int x2, int y2, int style,
	 char *str, int shadow, int clear, int attr)
{
    int   x;
    char  c[]="Ú¿ÀÙ³ÄÉ»È¼ºÍ", e[80];

    if(shadow==SHADOW_ON)
	 Shadow(x1+1, y1, x2, y2);

    CharCopy(e, x2 - x1 - 1, c[5+style]);

    WriteStr(x1 + 1, y1, e, attr);
    WriteStr(x1 + 1, y2, e, attr);

    for(x=y1+1;x<y2;x++){
	 WriteChar(x1, x, c[4+style], attr);
	 WriteChar(x2, x, c[4+style], attr);
    }

    if(clear == CLEAR_ON)
	 Cls(x1, y1, x2, y2, attr);

    for(x=0; str[x]!='\0'; x++);
    if(x)
	 WriteStr(((x2 + x1 - x) >> 1), y1, str, attr);

    WriteChar(x1, y1, c[0+style], attr);
    WriteChar(x2, y1, c[1+style], attr);
    WriteChar(x1, y2, c[2+style], attr);
    WriteChar(x2, y2, c[3+style], attr);
}


void WriteP(int p)
{
    char str[80];

    sprintf(str, "%4d", p);
    WriteStr(71, 9, str, 240);
}

void BackGround(void)
{
    int i;
    char str[80];
    int cyli;
    int sect;
    int heads;
    int fixed_disks;
    int cylinder;
    int error;
    long cap;

    Box(0, 0, 79, 24, SINGLE, "[ Disk_ACESS ]", SHADOW_OFF, CLEAR_ON, 159);
    WriteStr(1,1,"  R. R. B. Barbosa      ------       Vers„o  2.0       ------         1994    ", 240);
    WriteStr(1,2,"         Tempo m‚dio de acesso ao disco calculado em todo o disco             ", 31);
    WriteStr(1,3,"          Taxa de transferˆncia calculada num CPU 80386 a 33 MHz              ", 63);

    Box(2, 5, 34, 12, SINGLE, "[ Caracteristicas ]", SHADOW_ON, CLEAR_ON, 241);

    error = GetCurrentDriveParameters(_drive_, &cyli, &sect, &heads, &fixed_disks);
    if(error==-1){
	 clrscr();
	 printf("Erro na obten‡„o dos parƒmetros do disco...\n");
	 CursorOn();
	 exit (-1);
    }

    cylinder = cyli+((sect >> 6) << 8) + 1;
    sect = (unsigned)(sect << 10) >> 10;

    sprintf(str, "N£mero de cilindros......%4d", cylinder);
    WriteStr(4, 7, str, 241);

    sprintf(str, "N£mero de sectores.......%4d", sect);
    WriteStr(4, 8, str, 241);

    sprintf(str, "N£mero de cabe‡as........%4d", heads + 1);
    WriteStr(4, 9, str, 241);

    sprintf(str, "Bytes por sector.........%4d", 512);
    WriteStr(4, 10, str, 241);

    cap = 512L * cylinder * (heads + 1) * sect / 1000L / 1000L;
    sprintf(str, "Capacidade (MBytes)......%4d", (int)cap);
    WriteStr(4, 11, str, 241);


    Box(37, 5, 76, 12, SINGLE, "[ Performance ]", SHADOW_ON, CLEAR_ON, 241);
    WriteStr(39, 7,  "* Leituras.....................", 240);
    WriteStr(39, 8,  "Taxa de transferˆncia (Kb/seg).", 241);
    WriteStr(39, 9,  "* Posicionamentos..............", 240);
    WriteStr(39, 10, "Pista por Pista (ms)...........",241);
    WriteStr(39, 11, "Tempo m‚dio de acesso (ms).....", 241);

    WriteStr(6, 15, "                *  Compara‡”es com outros discos  *                 ", 63);
    WriteStr(6, 16, "Nome do disco        Cache     Taxa T.(i386)  T.Acesso   PistaxPista", 31);
    WriteStr(6, 17, "--------------------------------------------------------------------", 159);
    for(i=0; i!=DISCOS; i++){
	 sprintf(str, "%29s %12.1f %12.1f %12.1f",
			   discos[i].ref, discos[i].tt,
			   discos[i].tp, discos[i].pp);
	 WriteStr(4, i + 18, str, 159);
    }

    WriteStr(6, i+18, "--------------------------------------------------------------------", 159);
}





void Bench(void)
{
    int i, e;
    clock_t start, end;
    unsigned char *buffer;
    char str[80];
    int cyli;
    int sect;
    int heads;
    int cylinder;
    int fixed_disks;

    buffer = (unsigned char *)farmalloc(64*1024L);
    if(buffer==NULL){
	 clrscr();
	 printf("Falta de mem¢ria\n");
	 CursorOn();
	 exit(-1);
    }

    start = clock();
    for(i=0; i!=30; i++){
	e = biosdisk(2, _drive_, 1, 0, 1, 127, buffer);
	sprintf(str, "%4d", 29-i);
	WriteStr(71, 7, str, 240);
	if(e!=0){
		clrscr();
		printf("\nErro na leitura %d", i);
                CursorOn();
		exit(-1);
	}
    }
    end = clock();

    free((unsigned char *)buffer);

    sprintf(str, "%5.0f", 30*63.5*18.2/(end - start));
    WriteStr(70, 8, str, 241);

    WriteP(200);
    e = GetCurrentDriveParameters(_drive_, &cyli, &sect, &heads, &fixed_disks);

    cylinder = cyli+((sect >> 6) << 8) + 1;
    sect = (unsigned)(sect << 10) >> 10;


    e = SeekToCylinder(0, heads, _drive_);
    if(e==-1){
	 clrscr();
	 printf("Erro no posicionamento no cilindro 0...\n");
         CursorOn();
	 exit (-1);
    }
    start = clock();
    for(i=0; i!=cylinder; i++){
	 e = SeekToCylinder(i, heads, _drive_);
	 WriteP(cylinder-i-1);
	 if(e==-1){
	      clrscr();
	      printf("Erro no posicionamento no cilindro %d...\n", i);
              CursorOn();
	      exit (-1);
	 }
    }
    end = clock();

    sprintf(str, "%4.1f", TIME(cylinder));
    WriteStr(71, 10, str, 241);

    randomize();
    e = SeekToCylinder(0, heads, _drive_);
    if(e==-1){
	   clrscr();
	   printf("Erro no posicionamento no cilindro 0...\n");
           CursorOn();
	   exit (-1);
    }
    WriteP(200);
    start = clock();
    for(i=0; i!=TIMES; i++){
	 cyli = random(cylinder);
	 SeekToCylinder(cyli, heads, _drive_);
	 WriteP(TIMES-i-1);
    }
    end = clock();

    sprintf(str, "%4.1f", TIME(TIMES));
    WriteStr(71, 11, str, 241);

}





int main(int argc, char *argv[])
{
    if(argc != 2){
	printf("Uso: DI_ACES2 [drive:], onde drive refere-se a discos fixos\n");
	return 0;
    }
    else
	_drive_ = argv[1][0] + 0x1D;

    InitScreen();
    BkColors();
    CursorOff();
    BackGround();
    Bench();

    getch();
    clrscr();

    CursorOn();
    return 0;
}
