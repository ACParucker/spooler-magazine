/*
Programa......SPCALC.EXE
	      Calculadora para Windows +3.1.	
M¢dulo........SPCINIT.CPP 
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

char lpszWbClassName[]="SPCalc";
char lpszWbClassNameChild[]="SPCalcChild";

Window *Window::winList  = 0;


HINSTANCE WinBase::hInstance=0;
HINSTANCE WinBase::hPrevInstance=0;
int       WinBase::nCmdShow=0;
LPSTR	  WinBase::lpszCmdLine;	
LPSTR	  WinBase::lpszName;
LPSTR	  WinBase::lpszNameChild;


WinBase::WinBase(HINSTANCE hWbInstance,
		HINSTANCE hWbPrevInstance,
		LPSTR	  lpszWbCmdLine,
		int	  nWbCmdShow)
{
	hInstance     = hWbInstance;
	hPrevInstance = hWbPrevInstance;
	lpszCmdLine   = lpszWbCmdLine;
	nCmdShow      = nWbCmdShow;
	lpszName      =	lpszWbClassName;
        lpszNameChild = lpszWbClassNameChild;
}

Window::Window(HINSTANCE hWbInstance,
	       HINSTANCE hWbPrevInstance,
	       LPSTR lpszWbCmdLine, 
	       int nWbCmdShow):
	       		WinBase (hWbInstance, hWbPrevInstance,
				 lpszWbCmdLine, nWbCmdShow)
{
}

void Window::createWindow(HWND AParent)
{
WinAttr.hwndParent=AParent;

		      hWindow=  CreateWindow(
		      		WinAttr.lpszClassName,
				WinAttr.lpszWindowName,
				WinAttr.dwStyle,
				WinAttr.x,
				WinAttr.y,
				WinAttr.dx,
				WinAttr.dy,
				WinAttr.hwndParent,
				WinAttr.Menu,
				WinAttr.hinstance,
                                WinAttr.lpvParam);
                   
	if(hWnd()==0) exit(FALSE);
	insert();
}


void Window::MainSysMenu()
{
	::changeSysMenu(hWnd(), 4, TRUE);
}


Window::~Window()
{
Window *cur0=0;

	Window *cur = Window::winList;
	    while (cur !=0 && cur->hWnd() != hWnd())
            {
                 cur0 = cur;
		 cur = cur -> nextWin;
	    }

	if(cur){
         cur-> winList = cur-> nextWin;
	 cur-> nextWin = cur0;
        }
}

LRESULT CALLBACK Window::wndProc(HWND hWnd,
				 UINT msg,
				 WPARAM wParam,
				 LPARAM lParam
								 )
{
	Window *cur = Window::winList;
	    while (cur !=0 && cur->hWnd() != hWnd)
		 cur = cur -> nextWin;
	if(cur) return cur->dispatch(msg, wParam, lParam);

	if(inCreate)
	{
		inCreate->hWindow = hWnd;
	        return inCreate -> dispatch(msg, wParam, lParam); 
	}

	return ::DefWindowProc(hWnd, msg, wParam,lParam);
}

WORD Window::run()
{
	MSG msg;
	assert (hWnd() !=0);
		while(GetMessage(&msg, NULL, NULL, NULL))
		{
				TranslateMessage (&msg);
				DispatchMessage  (&msg);
		}
		return (WORD) msg.wParam;
}


ModalDialog *ModalDialog::curDlg=0;

WORD ModalDialog::run()
{
	FARPROC dlgProc = MakeProcInstance((FARPROC) ModalDialog::dlgProc,
					   (HINSTANCE) hInstance);

	DialogBox((HINSTANCE)hInstance, (LPCSTR) getDialogName(),
		  (HWND) hWnd(), (DLGPROC)dlgProc);
		   
	FreeProcInstance(dlgProc);
        return result;
}

BOOL CALLBACK _export ModalDialog::dlgProc(HWND hDlg,
					   UINT msg,
					   WPARAM wParam,
					   LPARAM lParam)
{
	return curDlg->dispatch(hDlg, msg, wParam, lParam);

}					   	


void changeSysMenu(HWND hwnd, UINT nToChange, BOOL addItems)
{
HMENU	hmenuSys;
UINT	nCount;
UINT	nItem; 
UINT	nId;
UINT    nStatCount = nToChange;
UINT	wAux;

static STATUSDATA sd[]=
	{
		{SC_CLOSE,		"&Sai\tAlt+F4"},
		{SC_MOVE,		"&Move"},
		{SC_RESTORE,		"&Restaura"},
                {SC_MINIMIZE,		"Ico&niza"}
	};


	hmenuSys = GetSystemMenu(hwnd, 0);

	nCount = GetMenuItemCount (hmenuSys);
	for(nItem=0; nItem < nCount; nItem ++)
	{
	nId = GetMenuItemID (hmenuSys, nItem);
	if (nId==0) continue;

		 for(wAux=0; wAux< nStatCount; wAux++)
		 {
			 if (nId == sd[wAux].wCode)
			{
			 
			 ModifyMenu (hmenuSys, nId, MF_BYCOMMAND,
				     nId, sd[wAux].achMsg);
			 break;
        	         }
		 }
		 if(wAux == nStatCount)
                 {
			  DeleteMenu (hmenuSys, nId, MF_BYCOMMAND);
			  nItem--;
                          nCount--;
                 }

	}
	if(addItems)
        {
		nCount = GetMenuItemCount (hmenuSys);
		nCount--;
		nId = GetMenuItemID (hmenuSys, nCount);
		if(nId!=0)AppendMenu(hmenuSys, MF_SEPARATOR, 0,0);
		AppendMenu(hmenuSys, MF_STRING, SC_PREF,"Preferˆncias...");
		AppendMenu(hmenuSys, MF_STRING, SC_AUTOR,"Acerca de...");
        }
 }