/*
Programa................EMS.C
Objectivo...............Testar a mem¢ria expandida
Autor...................Ruben Romano Borges Barbosa

Leituras recomendadas...®C¯ Avan‡ado, Edi‡”es GRAFICRIA
*/














#include "ems.h"
#include <dos.h>


int EMM_Installed(void)
{
    unsigned int Offset, Installed;
    char *EMM_DeviceName = "EMMXXXX0";
    unsigned int EMM_INT_CS = *(unsigned int far *)MK_FP(0, (EMM_INT << 2) + 2);

    Offset = 0x0;
    Installed = 0x1;
    while(Offset != 0x8 && Installed){
	 Installed = (*(char far *)MK_FP(EMM_INT_CS,0xA+Offset) == *EMM_DeviceName);
	 Offset++;
	 EMM_DeviceName++;
    }

    return Installed;
}




int GetManagerStatus(void)
{
    union REGS r;

    r.h.ah = 0x40;
    int86(EMM_INT, &r, &r);
    return r.h.ah;
}




int GetPageFrameSegment(int *Segment_PageFrame)
{
    union REGS r;

    r.h.ah = 0x41;
    int86(EMM_INT, &r, &r);
    *Segment_PageFrame = r.x.bx;
    return r.h.ah;
}




int GetNumber_Pages(int *Number_UnallocatedPages, int *TotalNumber_Pages)
{
    union REGS r;

    r.h.ah = 0x42;
    int86(EMM_INT, &r, &r);
    *Number_UnallocatedPages = r.x.bx;
    *TotalNumber_Pages = r.x.dx;
    return r.h.ah;
}




int AllocateMemory(int Number_LogicalPages, int *Handle)
{
    union REGS r;

    r.h.ah = 0x43;
    r.x.bx = Number_LogicalPages;
    int86(EMM_INT, &r, &r);
    *Handle = r.x.dx;
    return r.h.ah;
}




int MapMemory(int PhisicalPageNumber, int LogicalPageNumber, int Handle)
{
    union REGS r;

    r.h.ah = 0x44;
    r.h.al = PhisicalPageNumber;
    r.x.bx = LogicalPageNumber;
    r.x.dx = Handle;
    int86(EMM_INT, &r, &r);
    return r.h.ah;
}




int ReleaseMemory(int Handle)
{
    union REGS r;

    r.h.ah = 0x45;
    r.x.dx = Handle;
    int86(EMM_INT, &r, &r);
    return r.h.ah;
}




int GetEMMVersion(int *Version)
{
    union REGS r;

    r.h.ah = 0x46;
    int86(EMM_INT, &r, &r);
    *Version = r.h.al;
    return r.h.ah;
}




int SaveMappingContext(int Handle)
{
    union REGS r;

    r.h.ah = 0x47;
    r.x.dx = Handle;
    int86(EMM_INT, &r, &r);
    return r.h.ah;
}




int RestoreMappingContext(int Handle)
{
    union REGS r;

    r.h.ah = 0x48;
    r.x.dx = Handle;
    int86(EMM_INT, &r, &r);
    return r.h.ah;
}




int GetNumber_EMMHandles(int *Number_EMMHandles)
{
    union REGS r;

    r.h.ah = 0x4B;
    int86(EMM_INT, &r, &r);
    *Number_EMMHandles = r.x.bx;
    return r.h.ah;
}




int GetPagesOwnedByHandle(int EMMHandle, int *Number_LogicalPages)
{
    union REGS r;

    r.h.ah = 0x4C;
    r.x.dx = EMMHandle;
    int86(EMM_INT, &r, &r);
    *Number_LogicalPages = r.x.bx;
    return r.h.ah;
}




int GetPageMap(unsigned *Handles, Page *Pag)
{
    unsigned bx;

    _ES = FP_SEG(Pag);
    _DI = FP_OFF(Pag);
    _AH = 0x4D;
    geninterrupt(EMM_INT);
    bx = _BX;
    *Handles = bx;
    return _AH;
}
