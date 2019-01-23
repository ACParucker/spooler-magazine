/*
Programa......SPCALC.EXE
	      Calculadora para Windows +3.1.	
M¢dulo........PREF.CPP 
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

extern PrivIniData IniData;
extern void updatePos(HWND); 

LPCSTR PrefBox::getDialogName()
{
	return "Prefer";
}

BOOL PrefBox::dispatch(HWND hDlg, UINT msg, WPARAM wParam, LPARAM lParam)
{
static int ctopclicked=0;
static int cposclicked=0;
static int ccliclicked=0;
static int ccolclicked=0;
static int checked1, checked2, checked3, checked4;
static HBRUSH CyanBrush;


	switch (msg)
	{
	case WM_INITDIALOG:

		::changeSysMenu(hDlg, 2, FALSE);

		CyanBrush=CreateSolidBrush(RGB(0,255,255));

		if(IniData.topposition)
			Button_SetCheck(GetDlgItem(hDlg, CTRL_TOP), TRUE);
		else
			Button_SetCheck(GetDlgItem(hDlg, CTRL_TOP), FALSE);
		if(IniData.position)
			Button_SetCheck(GetDlgItem(hDlg, CTRL_POS), TRUE);
		else
			Button_SetCheck(GetDlgItem(hDlg, CTRL_POS), FALSE);
		if(IniData.clique)
			Button_SetCheck(GetDlgItem(hDlg, CTRL_CLI), TRUE);
		else
			Button_SetCheck(GetDlgItem(hDlg, CTRL_CLI), FALSE);


		Button_SetCheck(GetDlgItem(hDlg, IniData.pattern),TRUE);
		return TRUE;

	case WM_CTLCOLOR:

			SetBkColor((HDC) wParam, RGB(0,255,255));
			SetTextColor((HDC) wParam, RGB(255,0,0));
			return (BOOL) (LRESULT) CyanBrush;


	case WM_COMMAND:

		if(wParam == IDOK)
		{
			if(ctopclicked)
			{
				IniData.topposition = (checked1==1) ? TRUE : FALSE;
				ctopclicked=0;
			}
			if(cposclicked)
			{
				IniData.position = (checked2==1) ? TRUE : FALSE;
				cposclicked=0;
			}
			if(ccliclicked)
			{
				IniData.clique = (checked3==1) ? TRUE : FALSE;
				ccliclicked=0;
			}
			if(ccolclicked)
			{
				IniData.pattern=checked4;
				ccolclicked=0;
			}
			::updatePosOnTop (GetParent(hDlg));
			DeleteBrush(CyanBrush);
			EndDialog(hDlg, TRUE);
			return TRUE;
	        }
		else if(wParam == IDCANCEL)
		{
			ctopclicked=cposclicked=ccolclicked=ccliclicked=0;
		        DeleteBrush(CyanBrush);
			EndDialog(hDlg, TRUE);
			return TRUE;
		}
		else if(wParam == CTRL_TOP)
		{
			ctopclicked=1;
			checked1=!(Button_GetCheck(GetDlgItem(hDlg, CTRL_TOP)));
			Button_SetCheck(GetDlgItem(hDlg, CTRL_TOP), checked1);
			return TRUE;
		}
		else if(wParam == CTRL_POS)
		{
			cposclicked=1;
		        checked2=!(Button_GetCheck(GetDlgItem(hDlg, CTRL_POS)));
			Button_SetCheck(GetDlgItem(hDlg, CTRL_POS), checked2);
		        return TRUE;
		}
		else if(wParam == CTRL_CLI)
		{
			ccliclicked=1;
		        checked3=!(Button_GetCheck(GetDlgItem(hDlg, CTRL_CLI)));
			Button_SetCheck(GetDlgItem(hDlg, CTRL_CLI), checked3);
		        return TRUE;
		}

		else if(wParam >= CTRL_P1 && wParam <= CTRL_P5)
		{
			ccolclicked=1;
			CheckRadioButton(hDlg, CTRL_P1, CTRL_P5, wParam);
			checked4=wParam;
			Button_SetCheck(GetDlgItem(hDlg, checked4), TRUE);
		        return TRUE;
		}

	}
	return ModalDialog::dispatch(hDlg,msg,wParam,lParam);
}
