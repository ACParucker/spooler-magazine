/*
Programa................EMSTEST.C
Objectivo...............Testar a mem¢ria expandida
Autor...................Ruben Romano Borges Barbosa

Leituras recomendadas...®C¯ Avan‡ado, Edi‡”es GRAFICRIA
*/














#include "ems.c"
#include <alloc.h>
#include <conio.h>
#include <stdlib.h>
#include <stdio.h>


/* vari veis de mem¢ria expandida */
int		EmmHandle;
int		PageFrameBaseAddress;
int		PagesNeeded;
int		PhysicalPage;
int		LogicalPage;
int		Offset;
int		ErrorCode;
int		TotalPages;
int		AvailablePages;
int		VersionNumber;
int		Number_EMMHandles;
int		FreePages;
int		TotalPages;
unsigned	Handles;
Page		*Pag = NULL;

char		Verify;


/* vari veis auxiliares */
int i;
char str[80];
int Y, X;


/* vari veis de ecr„ */
char far *Vid_Mem = NULL;
#define  __XY__(x, y)          (Vid_Mem + y*160 + (x<<1))



/***************************************************************************/
/* Fun‡”es de ecr„.                                                        */
/***************************************************************************/

void CursorOn(void)
{
    _AX = 0x100;
    _CX = 0x506;
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
	 cprintf("\n\rPara correr este programa o ecr„ deve estar em 80x25");
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



#define SHADOW_ON	1
#define SHADOW_OFF	0
#define CLEAR_ON	1
#define CLEAR_OFF	0
#define SINGLE		0
#define DOUBLE		6

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



void WriteT(char *msg, int attr)
{
    WriteStr(X, Y++, msg, attr);
}



void le_tecla(void)
{
    char t;

    WriteStr(2, 3, ">>: Barra de espa‡os para continuar. . .", 62);
    do{
	 t = getch();
    }while(t!=32);
}



/***************************************************************************/
/* Fun‡”es de mem¢ria expandida.                                           */
/***************************************************************************/

void Error(int ErrorCode)
{
    char *errors[]={
	 "Erro: o LIM Gestor de Mem¢ria Expandida n„o est  instalado                ",
	 "Erro no pedido de reserva de mem¢ria                                      ",
	 "Erro na obten‡„o da vers„o do EMS                                         ",
	 "Erro na determina‡„o do n£mero de p ginas livres                          ",
	 "Erro na obten‡„o do endere‡o base                                         ",
	 "Erro na determina‡„o das entradas livres                                  ",
	 "Erro na reserva de uma p gina para uso                                    ",
	 "Erro na tentativa de mapear p ginas l¢gicas                               ",
	 "Erro: o que foi escrito na mem¢ria EMS n„o foi encontrado na verifica‡„o  ",
	 "Erro: impossibilidade de libertar p ginas reservadas                      ",
	 "Erro: o n£mero de p ginas necess rias ‚ superior …s que est„o livres      "
    };

    sprintf(str, ">> %s", errors[ErrorCode]);
    if(ErrorCode==2 || ErrorCode==1 || ErrorCode==3 || ErrorCode==4 ||
       ErrorCode==10 || ErrorCode==5 || ErrorCode==0)
	 printf("\n%s\n", str);
    else
	 WriteStr(1, 3, str, 207);

    CursorOn();
    exit(-ErrorCode);
}



void Mapa_de_Memoria(char *titulo)
{
    GetPageMap(&Handles, Pag);
    GetNumber_Pages(&FreePages, &TotalPages);
    sprintf(str, "Blocos em uso: %d", Handles);

    if(Handles >= 10)
	 Handles = 9;
    Box(46, 5, 76, 5+2+2+2+Handles+2, SINGLE, "[ Mapa de Mem¢ria ]", SHADOW_ON, CLEAR_ON, 241);
    WriteStr(48, 7, titulo, 241);
    WriteStr(48, 8,  str, 240);

    for(i=0; i!=Handles; i++){
	 sprintf(str, "Bloco[%*d]...........%5ld Kb", 1, i, 16L * Pag[i].n_pages);
	 WriteStr(48, 7+i+2 , str, 240);
    }
    i++;
    sprintf(str, "Bytes Livres.......%5ld Kb", 16L * FreePages);
    WriteStr(48, 7+2+i++ , str, 240);
    sprintf(str, "Total de Bytes.....%5ld Kb", 16L * TotalPages);
    WriteStr(48, 7+i+2 , str, 241);
}



void Informacao(void)
{
    sprintf(str, "N£mero total de p ginas...........%4d",  TotalPages);
    WriteStr(4, 6, str, 241);
    sprintf(str, "P ginas livres....................%4d",  AvailablePages);
    WriteStr(4, 7, str, 241);
    sprintf(str, "Total Kbytes......................%4ld", (long)TotalPages*16);
    WriteStr(4, 8, str, 241);
    sprintf(str, "Kbytes livres.....................%4ld", (long)AvailablePages*16);
    WriteStr(4, 9, str, 241);
    sprintf(str, "Entradas activas..................%4d", Number_EMMHandles);
    WriteStr(4, 10, str, 241);
    sprintf(str, "Endere‡o base (Hexadecimal).......%04X", PageFrameBaseAddress);
    WriteStr(4, 11, str, 241);
}



void BackGround(void)
{
    Box(0, 0, 79, 24, SINGLE, "[ Mem¢ria Expandida ]", SHADOW_OFF, CLEAR_ON, 159);
    WriteStr(1,1,"  Ruben Romano Borges Barbosa                           Vers„o 1.0  //  1994  ", 240);
    sprintf(str, "  LIM Expanded Memory Manager, V %d.%d  (1 p gina ð 16 par grafos ð 16 Kbytes)  ", VersionNumber >> 4, VersionNumber & 0x0F);
    WriteStr(1, 2, str, 31);
    WriteStr(1,3,"                                                                              ", 63);
    Box(2, 5, 43, 12, SINGLE, "[ Informa‡„o ]", SHADOW_ON, CLEAR_ON, 241);
    Y = 16;
    X = 4;
    Box(X-2, Y-1, 43, 22, SINGLE, "[ Testando. . . ]", SHADOW_ON, CLEAR_ON, 63);
}






int main(void)
{

    Pag = malloc(0x100 * 4);
    if(Pag==NULL)
	 Error(1);

    if(!EMM_Installed())
	 Error(0);

    InitScreen();
    BkColors();
    CursorOff();


    ErrorCode =  GetEMMVersion(&VersionNumber);
    if(ErrorCode != EMM_OK)
	 Error(2);
    PagesNeeded = 1;

    GetNumber_Pages(&AvailablePages, &TotalPages);
    if(ErrorCode != EMM_OK)
	 Error(3);

    if(PagesNeeded > AvailablePages)
	 Error(10);

    ErrorCode = GetNumber_EMMHandles(&Number_EMMHandles);
    if(ErrorCode != EMM_OK)
	 Error(5);

    ErrorCode =  GetPageFrameSegment(&PageFrameBaseAddress);
    if(ErrorCode != EMM_OK)
	 Error(4);


    BackGround();
    Informacao();
    Mapa_de_Memoria("(no in¡cio)");

    ErrorCode =  AllocateMemory(PagesNeeded, &EmmHandle);
    if(ErrorCode != EMM_OK)
	 Error(6);

    WriteT("-Reservando uma p gina EMS para teste.", 63);
    le_tecla();

    LogicalPage  = 0;
    PhysicalPage = 0;
    ErrorCode = MapMemory(PhysicalPage, LogicalPage, EmmHandle);
    if(ErrorCode != EMM_OK)
	 Error(7);

    sprintf(str,"-P.l¢gica %d mapeada para a P.f¡sica %d.", LogicalPage, PhysicalPage);
    WriteT(str, 63);
    le_tecla();

    for(Offset = 0; Offset != 16382; Offset++)
	 pokeb(PageFrameBaseAddress, Offset, Offset % 256);

    WriteT("* Testando. . .", 63);
    le_tecla();

    for(Offset = 0, Verify = 1; Offset != 16*1024-2 && Verify; Offset++)
	 Verify = ((unsigned char)peekb(PageFrameBaseAddress, Offset) == (Offset % 256));

    if(!Verify)
	 Error(8);

    WriteT("-Teste com sucesso. Novo mapa.", 63);
    le_tecla();

    Mapa_de_Memoria("(durante o teste)");

    ErrorCode = ReleaseMemory(EmmHandle);
    if(ErrorCode != EMM_OK)
	Error(9);

    le_tecla();
    WriteT("-Liberta‡„o da p gina EMS em uso.", 63);
    WriteT("-Teste completo.", 62);

    le_tecla();
    clrscr();

    CursorOn();

    return 0;
}
