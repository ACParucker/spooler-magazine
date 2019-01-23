/*
Programa................EMS.H
Objectivo...............Testar a mem¢ria expandida
Autor...................Ruben Romano Borges Barbosa

Leituras recomendadas...®C¯ Avan‡ado, Edi‡”es GRAFICRIA
*/














#ifndef __EMS.H__
#define __EMS.H__

#define  EMM_OK						(0x00)
#define  EMM_INT					(0x67)

#define  SUCCESSFUL					(0x00)

#define  INTERNAL_ERROR					(0x80)
#define  HARDWARE_MALFUNCTION				(0x81)
#define  INVALID_HANDLER				(0x83)
#define  UNDEFINED_FUNCTION_REQUESTED			(0x84)
#define  NO_MORE_HANDLES_AVAILABLE			(0x85)
#define  ERROR_IN_SAVE_OR_RESTORE_OF_MAPPING_CONTEXT	(0x86)
#define  MORE_PAGES_REQUESTED_THAN_PHYSICALLY_EXIST	(0x87)
#define  MORE_PAGES_REQUESTED_THAN_CURRENTLY_AVAILABLE	(0x88)
#define	 ZERO_PAGES_REQUESTED				(0x89)
#define  INVALID_LOGICAL_PAGE_NUMBER			(0x8A)
#define  ILLEGAL_PHISICAL_PAGE_NUMBER			(0x8B)
#define	 PAGE_MAPPING_HARDWARE_STATE_SAVE_AREA_IS_FULL	(0x8C)
#define	 SAVE_OF_MAPPING_CONTEXT_FAILED			(0x8D)


typedef struct{
    unsigned handle;
    unsigned n_pages;
}Page;


int     EMM_Installed		(void);
int 	GetManagerStatus	(void);
int 	GetPageFrameSegment	(int *Segment_PageFrame);
int 	GetNumber_Pages		(int *Number_UnallocatedPages, int *Total_Pages);
int 	AllocateMemory		(int Number_LogicalPages, int *Handle);
int 	MapMemory		(int PhisicalPageNumber, int LogicalPageNumber, int Handle);
int 	ReleaseMemory		(int Handle);
int 	GetEMMVersion		(int *Version);
int 	SaveMappingContext	(int Handle);
int 	RestoreMappingContext	(int Handle);
int 	GetNumber_EMMHandles	(int *Number_EMMHandles);
int 	GetPagesOwnedByHandle	(int EMMHandle, int *Number_LogicalPages);
int	GetPageMap		(unsigned *Handles, Page *Pag);

#endif