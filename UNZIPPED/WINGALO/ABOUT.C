/************************************************************************
*                                                                       *
* ABOUT.C --> Rotinas para implementa��o da About DialogBox             *
*																		*
*        Ultima revis�o por Ricardo Vinagre em 21/08/94                 *
*                                                                       *
************************************************************************/                                                      

#include <windows.h>                                                    
#include "about.h"

/* DialogBox procedure para a About DialogBox */
#ifdef __BORLANDC__
#pragma argsused
#endif
BOOL FAR PASCAL _export AboutDlgProc(HWND hDlg,UINT message,WPARAM wParam,
				LPARAM lParam)
{
	switch(message)
	{
		case WM_INITDIALOG:
			return TRUE;
		case WM_COMMAND:
			switch(wParam)
			{
/* Caso carregue no bot�o de OK sair da DialogBox   */
				case IDOK:
					EndDialog(hDlg,0);
					return TRUE;
			}
	}
	return FALSE;
}
