COMMENT %

Programa:.... VIRT86.EXE
	      Programa demonstrativo de execu‡„o em
	      Modo Virtual 86.

Ficheiro de inclus„o nos m¢dulos VMONITOR.ASM e PREPROT.ASM
Imp”e uma ordena‡„o para os segmentos de programa.
 
Autor:....... Jos‚ P scoa

Produzido em Dezembro 1993 para a revista SPOOLER.

%

_TEXT           SEGMENT BYTE PUBLIC 'CODE' USE16
				ENDS
_FARDATA        SEGMENT PARA PUBLIC 'FAR_DATA'
				ENDS
_FARBSS         SEGMENT PARA PUBLIC 'FAR_BSS'
				ENDS
_OVERLAY_       SEGMENT PARA PUBLIC 'OVRINFO'
				ENDS
_1STUB_         SEGMENT PARA PUBLIC 'STUBSEG'
				ENDS
_DATA           SEGMENT PARA PUBLIC 'DATA'
				ENDS
_INIT_          SEGMENT WORD PUBLIC 'INITDATA'
				ENDS
_INITEND_       SEGMENT BYTE PUBLIC 'INITDATA'
				ENDS
_EXIT_          SEGMENT WORD PUBLIC 'EXITDATA'
				ENDS
_EXITEND_       SEGMENT BYTE PUBLIC 'EXITDATA'
				ENDS
_CVTSEG         SEGMENT WORD PUBLIC 'DATA'
				ENDS
_SCNSEG         SEGMENT WORD PUBLIC 'DATA'
				ENDS
_BSS          SEGMENT WORD PUBLIC 'BSS'
				ENDS
_BSSEND       SEGMENT BYTE PUBLIC 'BSSEND'
				ENDS

