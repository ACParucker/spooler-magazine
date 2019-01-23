/*
Programa......SPCALC.EXE
	      Calculadora para Windows +3.1.	
M¢dulo........SPCALC.CPP 
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


const char lpszIniType[]="Padrao da Caixa";
const char lpszIniPlace[]="Posicao Relativa";
const char lpszIniFile[]="SPCALC.INI";

BOOL PatternChanged=FALSE;

PrivIniData IniData;

Window *Window::inCreate = 0;

void trap_alloc(void)
{

	::bigProblem(NULL, "Falha de Aloca‡„o de Mem¢ria !");
	exit(1);
}

MainWindow::MainWindow	(HINSTANCE hWbInstance,
		   	 HINSTANCE hWbPrevInstance,
			 LPSTR lpszWbCmdLine, 
			 int nWbCmdShow )
			:Window (hWbInstance,hWbPrevInstance,
				 lpszWbCmdLine, nWbCmdShow)
            
{
	set_new_handler(trap_alloc);
	if (!hPrevInstance)
		 registerClass ();
	readIniFile();
	inCreate = this;
	createDlg();
	inCreate = 0;
	::updatePos(hWnd());
	ShowWindow((HWND) hWnd(), nCmdShow);
	MainSysMenu();
	initAll();
}


void MainWindow::registerClass()
{

	ClassAttr.style	       = NULL;
	ClassAttr.lpfnWndProc   = Window::wndProc;
	ClassAttr.cbClsExtra    = 0;
	ClassAttr.cbWndExtra    = DLGWINDOWEXTRA;
	ClassAttr.hInstance     = hInstance;
	ClassAttr.hIcon         = LoadIcon(hInstance, "Spico");
	ClassAttr.hCursor       = LoadCursor(NULL, IDC_ARROW);
	ClassAttr.hbrBackground = (HBRUSH) (COLOR_WINDOW + 1);
	ClassAttr.lpszMenuName  = NULL;
	ClassAttr.lpszClassName = lpszName;

        Window::registerClass();
}


void MainWindow::createDlg()
{
	hWindow = CreateDialog(hInstance, lpszName, 0, NULL);
	if(hWnd()==0) exit(FALSE);
	insert();
}


LONG MainWindow::dispatch(UINT msg, WPARAM wParam, LPARAM lParam)
{
PAINTSTRUCT ps;
RECT rect;
HDC hdc;
static HBRUSH hbrush, BlackBrush;
HBITMAP hbm;

static	HFONT hfont1, hfont2;
static	LOGFONT lf;
TEXTMETRIC tm;


UINT ctrls []={48,49,50,51,52,53,54,55,56,57,46,95,37,8,67,61,77,78,79,80,43,
	       45,120,47,76,0};


	switch(msg)
		{

		case WM_CREATE:

                	hdc=BeginPaint(hWnd(),&ps);
			GetTextMetrics(hdc, &tm);
                        EndPaint(hWnd(),&ps);
			memset(&lf,0,sizeof(LOGFONT));
			lf.lfHeight=tm.tmHeight-1;
			lf.lfQuality=PROOF_QUALITY;
			lf.lfWeight=FW_SEMIBOLD;
			lf.lfOutPrecision=OUT_TT_PRECIS;
                        lf.lfStrikeOut;
                        lf.lfPitchAndFamily=FF_ROMAN | DEFAULT_PITCH;
			lstrcpy(lf.lfFaceName,"Tms Rmn");
			hfont1=CreateFontIndirect(&lf);

			lf.lfQuality=PROOF_QUALITY;
			lf.lfWeight=FW_MEDIUM;
			lf.lfPitchAndFamily=FF_SWISS | DEFAULT_PITCH;
                        lstrcpy(lf.lfFaceName,"Helv");
//                      lf.lfHeight=tm.tmHeight-2;
			lf.lfHeight=tm.tmHeight;
			hfont2=CreateFontIndirect(&lf);

			BlackBrush=CreateSolidBrush(RGB(0,0,0));
			break;

		case WM_SETCURSOR:

			if(((LOWORD (lParam))>=HTLEFT) &&
			   ((LOWORD (lParam))<=HTBORDER))
			   {
        	                SetCursor(ClassAttr.hCursor);
				return TRUE;
                            }
                	break;

		case WM_PAINT:

                	UINT *ptctrls=ctrls;
			while(*ptctrls!=0)
                        {
				SendDlgItemMessage(hWnd(),*ptctrls,WM_SETFONT,(WPARAM)hfont1,0);
                        	ptctrls++;
			}
				SendDlgItemMessage(hWnd(),IDD_VISOR,WM_SETFONT,(WPARAM)hfont2,0);
                
			if(PatternChanged==TRUE)
			{
                        	if(hbrush)
					DeleteBrush(hbrush);
        			hbm=LoadBitmap(hInstance, MAKEINTRESOURCE(IniData.pattern));
				hbrush=CreatePatternBrush(hbm);
				DeleteBitmap(hbm);
                                PatternChanged=FALSE;
                        }

			hdc=BeginPaint(hWnd(), &ps);
			GetClientRect(hWnd(), &rect);
                	SelectBrush(hdc, hbrush);
			Rectangle(hdc,rect.left, rect.top,rect.right,rect.bottom);
			EndPaint(hWnd(),&ps);
                        break;

		case WM_CTLCOLOR:
			if(HIWORD (lParam) == CTLCOLOR_STATIC)
			{
				if((HWND)LOWORD(lParam)==GetDlgItem(hWnd(),IDD_VISOR))
				{
					SetTextColor((HDC) wParam, RGB(255,255,0));
					SetBkMode((HDC) wParam, TRANSPARENT);
					return (LRESULT) BlackBrush;
				}
				else if((HWND)LOWORD(lParam)==GetDlgItem(hWnd(),101))
        	                        return (LRESULT) GetStockBrush(GRAY_BRUSH);

			}
                        break;
		case WM_KEYDOWN:
			if(wParam != VK_LEFT)
				break;
			wParam = VK_BACK;

		case WM_CHAR:
			if((wParam = toupper(wParam)) == VK_RETURN)
				wParam = '=';
		
			if (GetDlgItem((HWND) hWnd(), wParam) != NULL)
			{
				SendDlgItemMessage((HWND) hWnd(),wParam, BM_SETSTATE,1,0L);
				SendDlgItemMessage((HWND) hWnd(),wParam, BM_SETSTATE,0,0L);
			}

		case WM_COMMAND:

			if( processCommand (wParam) == TRUE)
			{
                        	if(IniData.clique)
					MessageBeep(-1);
				return FALSE;
                        }
			break;
		case WM_SYSCOMMAND:

			if(wParam==SC_AUTOR)
			{
				aboutBox();
		        	return TRUE;
			}
			else if(wParam==SC_PREF)
                        {
				prefBox();
				return TRUE;
                        }
			break;

		case WM_CLOSE:

			DeleteBrush(hbrush);
			DeleteBrush(BlackBrush);
			DeleteFont(hfont1);
                        DeleteFont(hfont2);
			DestroyWindow((HWND) hWnd());
			return FALSE;

		case WM_DESTROY:

                	char ach[80];
			if(IniData.topposition)
				WritePrivateProfileString(lpszIniPlace,"NoTopo","Verdade",lpszIniFile);
			else	  
				WritePrivateProfileString(lpszIniPlace,"NoTopo","Falso",lpszIniFile);
			if(IniData.position)
                       	{
				WritePrivateProfileString(lpszIniPlace,"MesmoLugar","Verdade",lpszIniFile);
				GetWindowRect(hWnd(),&rect);
                                wsprintf(ach, "%d", rect.left);
				WritePrivateProfileString(lpszIniPlace,"X",ach,lpszIniFile);
                                wsprintf(ach, "%d", rect.top);
				WritePrivateProfileString(lpszIniPlace,"Y",ach,lpszIniFile);
			}
			else
			{ 
				WritePrivateProfileString(lpszIniPlace,"MesmoLugar","Falso",lpszIniFile);
				WritePrivateProfileString(lpszIniPlace,"X","",lpszIniFile);
				WritePrivateProfileString(lpszIniPlace,"Y","",lpszIniFile);
			}
			if(IniData.clique)
				WritePrivateProfileString(lpszIniPlace,"Clique","Verdade",lpszIniFile);
			else	  
				WritePrivateProfileString(lpszIniPlace,"Clique","Falso",lpszIniFile);

                       	UINT privpat=IniData.pattern - 103;
			wsprintf(ach, "%d", privpat);
			WritePrivateProfileString(lpszIniType,"Padrao",ach,lpszIniFile);
			PostQuitMessage(0);
			break;

        }

return Window::dispatch(msg, wParam, lParam);
}

BOOL MainWindow::processCommand(WPARAM wParam)
{

int Select;

	SetFocus((HWND) hWnd());

// Tratamento da op‡„o de copiar para o Clipboard (Bot„o 'Clip' / tecla  'l' ou 'L').

	if(wParam == 'L')
	{
	HANDLE hData;
        LPSTR lpData;
        char S[32];

		GetDlgItemText((HWND)hWnd(), IDD_VISOR, S, sizeof(S));
		if(!(hData=GlobalAlloc(GMEM_MOVEABLE, sizeof(S))))
		{
			::bigProblem(hWnd(), "Falta de Mem¢ria !");
                        return TRUE;
		}
		if(!(lpData=(LPSTR) GlobalLock(hData)))
		{
			::bigProblem(hWnd(), "Falta de Mem¢ria !");
                        return TRUE;
                }   
		lstrcpy(lpData, S);
		GlobalUnlock(hData);
		if(OpenClipboard(hWnd()))
		{
			EmptyClipboard();
			SetClipboardData(CF_TEXT, hData);
			CloseClipboard();
		}
                hData=NULL;
        	return TRUE;
	}

// Opera‡„o 'CLEAR' ‚ necess ria ap¢s mensagem de ERRO 'E'na calculadora (Bot„o 'C' / teclas 'c' ou 'C').

	if((ovFlow==TRUE) && (wParam !='C'))
		wParam=' ';

// Opera‡„o 'Memory clear' ‚ necess ria ap¢s mensagem de ERRO 'ME' na calculadora (Bot„o 'Mc' / teclas 'p' ou 'P').

	if((ovMemFlow==TRUE) && (wParam != 'P'))
        {
		putNumbers(npstrMemNumber);
		wParam=' ';
        }

// Bot„o / teclas 0 a 9

	if(wParam>= '0' && wParam<= '9')
	{
		if(bDispFull==TRUE)
                {
			bNewNumber=TRUE;
                        bDispFull=FALSE;
                }
		firstFigure();
		if(strcmp(npstrNumber,"0")==0)
			npstrNumber[0]='\0';
		insertKey(wParam);
		putNumbers(npstrNumber);
        	return TRUE;             
        }

// Acessos  s Mem¢rias:
// Bot„o M+ / teclas m ou M
// Bot„o M- / teclas n ou N
// Bot„o Mr / teclas o ou O
// Bot„o Mc / teclas p ou P

	switch (wParam)
	{
	case 'M':
		{
		bDispFull=TRUE;
		double dfAuxMemory=atof((const char *) npstrNumber);
		if(bNegative) dfAuxMemory = -dfAuxMemory;
		double dfMemory=atof((const char *) npstrMemNumber);
                if(bMemNegative) dfMemory = -dfMemory;
		bMemNegative=calcNumber( npstrMemNumber, FALSE, dfMemory + dfAuxMemory);
                }
		goto LabelofGoto;    // Nota: Os 'goto' s„o expeditos, embora
				     //       os puristas n„o gostem.
	case 'N':
		{
		bDispFull=TRUE;
		double dfAuxMemory=atof((const char *) npstrNumber);
		if(bNegative) dfAuxMemory = -dfAuxMemory;
		double dfMemory=atof((const char *) npstrMemNumber);
		if(bMemNegative) dfMemory = -dfMemory;
		bMemNegative=calcNumber( npstrMemNumber, FALSE, dfMemory - dfAuxMemory);
                }
		goto LabelofGoto;

	case 'O':
		{
		bNewNumber=TRUE;
		firstFigure();
		if(strcmp(npstrNumber,"0")==0)
			npstrNumber[0]='\0';
		strcpy(npstrNumber, npstrMemNumber);
                bDispFull=TRUE;
		bNegative=bMemNegative;
		}
		goto LabelofGoto;

	case 'P':
        	npstrMemNumber[0]='\0';
		strcpy(npstrMemNumber,"0");
		bMemNegative=FALSE;
                ovMemFlow=FALSE;
		goto LabelofGoto;
	}
                        
	Select=(int) validOp(wParam);	 // Tratar-se-  de uma das 4 aritm‚ticas,
       				      	 // de '=' ou de '%' ?		
	if(Select)
	{
	   if((bNewNumber==FALSE) || (bDispFull==TRUE))
	   {
		   bNewNumber=TRUE;
                   bDispFull=FALSE;
		   putNumbers(calcHandler(npstrNumber, Select));
           }
	   nOperation=Select;
	   firstOperand=atof(npstrNumber);
	   if(bNegative) firstOperand = -firstOperand;

	   return TRUE;
        }

	switch (wParam)
		{
		case VK_BACK:
			firstFigure();
			if(strlen(npstrNumber)==1)
				{  
					strcpy(npstrNumber,"0");
                                        bNegative=FALSE;
                                }

			else npstrNumber[strlen(npstrNumber)-1]='\0';
			break;
		case VK_ESCAPE:
		case 'C':
			allClear();
			break;
		case '_':
			bNegative = !bNegative;

			break;
		case '.':
			firstFigure();
			if(strchr(npstrNumber,'.')==NULL)
				insertKey(wParam);
                        break;
                                
		default:
			return FALSE;
		}
LabelofGoto:
		if(ovMemFlow==FALSE)
			putNumbers(npstrNumber);
                return TRUE;

}

void MainWindow::putNumbers(NPSTR npstrNber)
{
char npstrAux[DIGITS + 2];

	npstrAux[0]='\0';
	if((bNegative) && (!ovMemFlow)) strcpy(npstrAux,"-");
        strcat(npstrAux, npstrNber);
        SetDlgItemText((HWND)hWnd(), IDD_VISOR, npstrAux);
}                                                          

void MainWindow::firstFigure()
{
	if(bNewNumber==TRUE)
	{
		bNewNumber=FALSE;
		strcpy(npstrNumber,"0");
		bNegative=FALSE;
        }
}


void MainWindow::initAll()
{
	bDispFull=FALSE;
	strcpy(npstrMemNumber,"0");
	bMemNegative=FALSE;
        ovMemFlow=FALSE;
	allClear();
}

void MainWindow::allClear()
{
	bNewNumber=TRUE;
	strcpy(npstrNumber, "0");
	bNegative=FALSE;
	nOperation='=';
        ovFlow=FALSE;
}

WPARAM MainWindow::validOp(WPARAM wp)
{
	switch(wp)
	{
        case '%':
	case '+':
	case '-':
		break;
	case 'x':
	case 'X':
	case '*':
		wp='*';
                break;
	case '/': 		// Nota: A utiliza‡„o da tecla 'ö' ‚ pouco pr tica.
		wp='/';
                break;
	case '=':
        case 0x0D:
		wp='=';
                break;
	default:
		return 0;
        }
		return wp;
}

NPSTR MainWindow::calcHandler(NPSTR npstrNb, int cKey)
{
double dNumber;

	dNumber=atof(npstrNb);
	if(bNegative) dNumber = -dNumber;

	if(cKey=='%')
		if(nOperation=='+' || nOperation=='-')
			dNumber=firstOperand*dNumber/100;
		else if(nOperation=='*' || nOperation == '/')
                	dNumber /= 100;

	switch(nOperation) {
		case '+':
			bNegative=calcNumber(npstrNb, TRUE, firstOperand + dNumber);
			break;
		case '-':
			bNegative=calcNumber(npstrNb, TRUE, firstOperand - dNumber);
			break;
		case '*':
			bNegative=calcNumber(npstrNb, TRUE, firstOperand * dNumber);
			break;
		case '/':
                	if (dNumber==0) repError(npstrNb, TRUE);
			else bNegative=calcNumber(npstrNb, TRUE, firstOperand / dNumber);
			break; 
	}
	return npstrNb;
}


BOOL MainWindow::calcNumber(char npstrNb[], BOOL bDisp, double op)
{
NPSTR First, Last;
int CharsToCopy;
char S[64];
BOOL neg;
double opaux;
int counter=10;
int i;

	opaux=op;

	while (opaux>=1)
	{
		opaux=opaux/10;
		counter--;
	}

	opaux=op;

	for(i=1;i<=counter;i++)
		opaux=opaux*10;

	opaux=opaux+0.5;

	for(i=1;i<=counter;i++)
		opaux=opaux/10;

	op=opaux;

	sprintf(S, "%0.6f", op);
	First=S;
	neg=FALSE;
	if(S[0]=='-')
	{
		++First;
		neg=TRUE;
	}
	if(strlen(First) > DIGITS + 1 + 6) neg=repError(npstrNb, bDisp);
	else
	{
		Last=strchr(First, 0);
	while (Last[-1] == '0')
		--Last;
	if(Last[-1]=='.')
		--Last;
	CharsToCopy = min(DIGITS , (int) (Last - First));
	strncpy (npstrNb, First, CharsToCopy);
	npstrNb[CharsToCopy] = '\0';
	}
return neg;
}
            
BOOL MainWindow::repError(char npstrNber[], BOOL bDisp)
{

	npstrNber[0]='\0';
	if(bDisp==TRUE)
        {
		ovFlow=TRUE;
		strcpy(npstrNber,"E");
		bNegative=FALSE;
	}
	else
	{
		ovMemFlow=TRUE;
		strcpy(npstrNber,"ME");
		bMemNegative=FALSE;
	}
	putNumbers(npstrNber);

        return 0;
}


void MainWindow::insertKey(WPARAM wP)
{
int lenght;
		lenght=strlen(npstrNumber);
		if(lenght < DIGITS)
		{
			npstrNumber[lenght]=wP;
			npstrNumber[lenght + 1]='\0';
		}
}

void MainWindow::aboutBox()
{
	AboutBox ab((HWND)hWnd());
	ab.run();
}

void MainWindow::prefBox()
{
	PrefBox pref((HWND)hWnd());
	pref.run();
}


void MainWindow::readIniFile()
{
char szBuffer[30];

IniData.topposition=1;
IniData.position=0;
IniData.clique=1;

	GetPrivateProfileString(lpszIniPlace, "NoTopo" , "", szBuffer, sizeof(szBuffer),lpszIniFile);
	if(!(_fstricmp("Falso",szBuffer)))
		IniData.topposition=0;
		 
	GetPrivateProfileString(lpszIniPlace, "MesmoLugar" , "", szBuffer, sizeof(szBuffer),lpszIniFile);
	if(!(_fstricmp("Verdade",szBuffer)))
        {
		IniData.position=1;
		IniData.xpos=GetPrivateProfileInt(lpszIniPlace,"X", 0, lpszIniFile);
                IniData.ypos=GetPrivateProfileInt(lpszIniPlace,"Y", 0, lpszIniFile);
	}	 

	GetPrivateProfileString(lpszIniPlace, "Clique" , "", szBuffer, sizeof(szBuffer),lpszIniFile);
	if(!(_fstricmp("Falso",szBuffer)))
		IniData.clique=0;

	IniData.pattern=GetPrivateProfileInt(lpszIniType, "Padrao" , 1, lpszIniFile) + 103;
}

void updatePos(HWND hwnd)
{
	       if(IniData.position)
			SetWindowPos(hwnd,(HWND) NULL,
				     IniData.xpos,IniData.ypos,0,0,SWP_NOSIZE | SWP_NOZORDER);
	       ::updatePosOnTop(hwnd);

}
void updatePosOnTop(HWND hwnd)
{
		if(IniData.topposition)
			SetWindowPos(hwnd,HWND_TOPMOST,
				     0,0,0,0,SWP_NOMOVE | SWP_NOSIZE);
		else		     	
			SetWindowPos(hwnd,HWND_NOTOPMOST,
				     0,0,0,0,SWP_NOMOVE | SWP_NOSIZE);


                PatternChanged=TRUE;
                InvalidateRect(hwnd,NULL,TRUE);
}


void bigProblem(HWND parent, LPCSTR problem)
{
	MessageBeep(MB_ICONEXCLAMATION);
	MessageBox(parent, problem, "Problema:", MB_OK | MB_ICONEXCLAMATION | MB_SYSTEMMODAL);
	return;
}


//------------------------------------------------------
// int PASCAL WinMain (HINSTANCE, HINSTANCE, LPSTR, int);
// Entrada inicial do programa.
//------------------------------------------------------


int PASCAL WinMain (HINSTANCE hInstance,
		    HINSTANCE hPrevInstance,
		    LPSTR     lpszCmdLine,
		    int	  nCmdShow)
{
	MainWindow SPCalcWindow (hInstance,
				 hPrevInstance,
				 lpszCmdLine,
				 nCmdShow);

	return SPCalcWindow.run();
}
