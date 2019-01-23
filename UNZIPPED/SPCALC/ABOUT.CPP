/*
Programa......SPCALC.EXE
	      Calculadora para Windows +3.1.	
M¢dulo........ABOUT.CPP
Autor.........Jos‚ P scoa

Compilador....Borland C++ 3.1
Modelo........SMALL

Produzido em Janeiro 1994 para a revista Spooler.
*/

#define STRICT
#define WIN31

#if !defined (__SPCINIT_H)
#include "SpCInit.h"
#endif

int TAboutWindow::prevreg=0;
			      
TAboutWindow::TAboutWindow(HWND AParent, LPCSTR ABitmapName):
		Window(AParent)
{
	if (!prevreg)
	{
	 prevreg++;              // S¢ registar a classe uma vez.
    	 registerClass ();
	}
	inCreate = this;         // Assegura que a mensagem seja tratada
				 // pelo m‚todo TAboutWindow::dispatch.
	createWindow(AParent);
	inCreate = 0;
	Bitmap=LoadBitmap(hInstance, ABitmapName);
	if (!Bitmap) return;
	GetObject(Bitmap, sizeof(BitSize), &BitSize);

	// AutoRedimensionamento da janela para o tamanho do Bitmap.
	  
	SetWindowPos((HWND) hWnd(), 0,0,0,BitSize.bmWidth, BitSize.bmHeight,
			SWP_NOMOVE | SWP_NOZORDER| SWP_NOACTIVATE | SWP_NOREDRAW);
}

// M‚todo chamado a partir da classe AboutBox.

void TAboutWindow::DrawBitmap(HDC hdc, int xStart, int yStart, HBITMAP hBitmap)
{
BITMAP bm;
HDC hMemDC;
POINT pt;
	hMemDC=CreateCompatibleDC(hdc);
	SelectBitmap(hMemDC, hBitmap);
	GetObject(hBitmap, sizeof(BITMAP), (LPSTR) &bm);
	pt.x=bm.bmWidth;
	pt.y=bm.bmHeight;
	BitBlt(hdc, xStart,yStart,pt.x, pt.y, hMemDC,0,0,SRCCOPY);
	DeleteDC(hMemDC);
}


void TAboutWindow::registerClass()
{
	ClassAttr.style	        = CS_BYTEALIGNWINDOW;
	ClassAttr.lpfnWndProc   = Window::wndProc;
	ClassAttr.cbClsExtra    = 0;
	ClassAttr.cbWndExtra    = 0;
	ClassAttr.hInstance     = hInstance;
	ClassAttr.hIcon         = NULL;
	ClassAttr.hCursor       = LoadCursor(NULL, IDC_ARROW);
	ClassAttr.hbrBackground = (HBRUSH) (COLOR_WINDOW + 1);
	ClassAttr.lpszMenuName  = NULL;
	ClassAttr.lpszClassName = lpszNameChild;

	Window::registerClass();
}

void TAboutWindow::createWindow(HWND AParent)
{
	WinAttr.lpszClassName=lpszNameChild;
	WinAttr.lpszWindowName=NULL;
	WinAttr.dwStyle=WS_CHILD | WS_VISIBLE;
	WinAttr.x=WinAttr.y=WinAttr.dx=WinAttr.dy=0;
	WinAttr.Menu=NULL;
	WinAttr.hinstance=hInstance;
	WinAttr.lpvParam=NULL;

	Window::createWindow(AParent);
}

LONG TAboutWindow::dispatch(UINT msg, WPARAM wParam, LPARAM lParam)
{
 return Window::dispatch(msg, wParam, lParam);
}

LPCSTR AboutBox::getDialogName()
{
	return "About";
}


BOOL AboutBox::dispatch(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{

static HBRUSH BlackBrush;
RECT RDialog, R, RBitWnd, ROk, rect;
PAINTSTRUCT ps;

	switch (msg)
	{
	case WM_INITDIALOG:

		InitAboutWindow(hDlg,"AboutLogo");
		BlackBrush=CreateSolidBrush(RGB(0,0,0));
		GetWindowRect(GetDesktopWindow(), &rect);
		GetClientRect(GetDlgItem(hDlg,IDOK),&ROk);
		GetClientRect(AboutWindow->hWnd(),&RBitWnd);
		GetWindowRect(hDlg,&RDialog);
		GetClientRect(hDlg,&R);
		RDialog.right=RDialog.right-RDialog.left - R.right;
		RDialog.bottom=RDialog.bottom-RDialog.top - R.bottom;
		RDialog.right += RBitWnd.right ;
		RDialog.bottom += RBitWnd.bottom + ROk.bottom;

// Reposicionamento e redimensionamento da caixa de di logo aberta
// pela op‡„o "Acerca de..."

		SetWindowPos(hDlg, 0, rect.right/2 - RDialog.right/2, rect.bottom/2 - RDialog.bottom/2,
			     RDialog.right, RDialog.bottom,
			     SWP_NOACTIVATE | SWP_NOZORDER);
		SetWindowPos(AboutWindow->hWnd(), 0, RBitWnd.left , RBitWnd.top ,
			     0, 0,
			     SWP_NOACTIVATE |SWP_NOSIZE | SWP_NOZORDER);
		GetClientRect(hDlg, &R);

		SetWindowPos(GetDlgItem(hDlg,IDOK), 0, R.left+1,
			     RBitWnd.bottom+1 ,R.right-1,R.bottom-RBitWnd.bottom-1,
			     SWP_NOACTIVATE | SWP_NOZORDER);
		return TRUE;

	case WM_CTLCOLOR:

		if(HIWORD (lParam) == CTLCOLOR_DLG)
		{
		SetBkMode((HDC) wParam, OPAQUE);
		return (BOOL)BlackBrush;
		}
		break;

	case WM_PAINT:

		BeginPaint(AboutWindow->hWnd(),&ps);

		// A classe AboutWindow ‚ "friend"

		AboutWindow->DrawBitmap(ps.hdc,0,0,AboutWindow->Bitmap);
		EndPaint(AboutWindow->hWnd(),&ps);
		return TRUE;

	case WM_COMMAND:

		if(wParam == IDOK)
		{
		HWND hwndchild;

		hwndchild=GetWindow(hDlg,GW_CHILD);
		DestroyWindow(hwndchild);
		delete AboutWindow;
		DeleteBrush(BlackBrush);
		EndDialog(hDlg, TRUE);
		return TRUE;

		}
       }
	return ModalDialog::dispatch(hDlg,msg,wParam,lParam);
}

void AboutBox::InitAboutWindow(HWND hDlg,LPCSTR AbitmapName)
{
	AboutWindow = new TAboutWindow(hDlg, AbitmapName);
}

