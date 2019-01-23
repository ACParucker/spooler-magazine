/************************************************************************
*                                                                       *
* CHILD.C --> Rotinas para implementação do sistema de janelas filhas   *
*		para usar como casas de jogo                                    *
*																		*
*        Ultima revisão por Ricardo Vinagre em 22/08/94                 *
*                                                                       *
************************************************************************/                                                      
#include <windows.h>
#include "wingalo.h"
#include "logic.h"
#include "child.h"

/* Determinar simbolo a usar para "pintar" a janela  */
char SetSymbol(WORD wStatus)
{
	char cSymbol;

	switch(wStatus)
	{
		case CWS_NULL:
			cSymbol=' ';
			break;
		case CWS_CROSS:
			cSymbol='X';
			break;
		case CWS_BALL:
			cSymbol='O';
			break;
	}
	return(cSymbol);
}

/* Procedure das janelas filhas  */
long FAR PASCAL _export PosProc(HWND hwnd,UINT message,WPARAM wParam,
				LPARAM lParam)
{
	char cSymbol;
	HDC hdc;
	RECT rect;
	PAINTSTRUCT ps;

	switch(message)
	{
		case WM_CREATE:
			SetWindowWord(hwnd,0,CWS_NULL); /* Limpa casa de jogo  */
			return 0;
/* Comandos enviados pela janela pai */
		case WM_COMMANDCHILD:
			switch(wParam)
			{
/* Marcar casa de jogo */
				case PM_SET:
					SetWindowWord(hwnd,0,LOWORD(lParam));
					break;
/* Limpar casa de jogo  */
				case PM_RESET:
					SetWindowWord(hwnd,0,CWS_NULL);
					break;
			}
			InvalidateRect(hwnd,NULL,TRUE); /* Mandar actualizar imagem */
			return 0;
/* A janela ganhou o foco */
		case WM_SETFOCUS:
			SetFocus(GetParent(hwnd)); /* Dar o foco à janela pai */
			return 0;
/* Parte de actualização da imagem  */
		case WM_PAINT:
			hdc=BeginPaint(hwnd,&ps);
			cSymbol=SetSymbol(wStatus(hwnd));
			GetClientRect(hwnd,&rect);
			DrawText(hdc,&cSymbol,1,&rect,DT_SINGLELINE |
				DT_CENTER | DT_VCENTER);
			EndPaint(hwnd,&ps);
			return 0;
/* O Botão esquerdo do mouse foi pressionado */
		case WM_LBUTTONDOWN:
			if(wStatus(hwnd)!=CWS_NULL) /* A janela esta limpa? */
				break;
			if(nFase==GF_NOPLAY) /* Esta-se a jogar? */
				break;
			SetWindowWord(hwnd,0,nFase); /* Marcar a casa. */
			PostMessage(GetParent(hwnd),WM_WARNFATHER,nFase,
				(LONG)GetWindowWord(hwnd,GWW_ID)); /* Avisar o "papá"! */
			InvalidateRect(hwnd,NULL,TRUE); /* Mandar actualizar imagem */
			return 0;
	}
	return(DefWindowProc(hwnd,message,wParam,lParam));
}

