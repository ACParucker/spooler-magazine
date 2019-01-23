     /********************************************************************
      *                                                                  *
      *   Fonte:	WinInfo.cpp  		                         *
      *                                                                  *
      ********************************************************************/

#include <owl.h>
#include <dialog.h>
#include <commdlg.h>
#include <string.h>
#include <stdio.h>
#include "WinInfID.h"

long oldfree;
BOOL firsttime;

class TWinInfo : public TApplication
{
public:
  TWinInfo(LPSTR AName, HANDLE hInstance, HANDLE hPrevInstance,
                   LPSTR lpCmdLine, int nCmdShow)
    : TApplication(AName, hInstance, hPrevInstance, lpCmdLine, nCmdShow) {};
    virtual void InitMainWindow();
    virtual void InitInstance();
};

void TWinInfo::InitInstance()
{
   TApplication::InitInstance();
   HAccTable = LoadAccelerators(hInstance, "WinInfo");
}
class TMainWindow : public TWindow
{
public:
   TMainWindow(PTWindowsObject AParent, LPSTR ATitle);
   ~TMainWindow();
   virtual void GRAVARINFORMACAOCOMO(RTMessage Msg) = [CM_FIRST + IDM_GRAVARINFORMACAOCOMO];
   virtual void SAIR(RTMessage Msg) = [CM_FIRST + IDM_SAIR];
   virtual void SOBRE(RTMessage Msg) = [CM_FIRST + IDM_SOBRE];
   virtual void SetupWindow();
   virtual void WMClose(RTMessage Msg) = [WM_FIRST + WM_CLOSE];
   virtual void WMTimer(RTMessage Msg) = [WM_FIRST + WM_TIMER];
   virtual void WMSize(RTMessage Msg) = [WM_FIRST + WM_SIZE];
   virtual void Paint (HDC PaintDC, PAINTSTRUCT _FAR &PaintInfo);

protected:
   virtual void GetWindowClass(WNDCLASS _FAR & AWndClass);
   virtual LPSTR GetClassName();
};

TMainWindow::TMainWindow(PTWindowsObject AParent, LPSTR ATitle)
                         : TWindow(AParent, ATitle)
{
   AssignMenu("WinInfo");
   Attr.Style |= WS_VSCROLL;
   Scroller = new TScroller (this, 1, 5, 0, 170);
}

TMainWindow::~TMainWindow()
{
}

LPSTR TMainWindow::GetClassName()
{
   return "WinInfoWindow";
}

void TMainWindow::GetWindowClass(WNDCLASS _FAR & AWndClass)
{
   TWindow::GetWindowClass(AWndClass);
   AWndClass.hIcon = LoadIcon(AWndClass.hInstance, "WININFO");
}

void TMainWindow::Paint(HDC PaintDC, PAINTSTRUCT _FAR &)
{
	int nXText, nYText, nHeight;
	short x;
	DWORD dwExt;
	char textbuf [256];
        char textbufn [256];
        int counter = 0;
        int textsize;
	dwExt = GetTextExtent (PaintDC, "S", 1);
	nHeight = HIWORD (dwExt);
	nYText = nHeight;
	nXText = LOWORD (dwExt);

	DWORD dwVersion;
	dwVersion = GetVersion();

	sprintf(textbuf, "Windows versão %d.%d",
	    LOBYTE(LOWORD(dwVersion)),
	    HIBYTE(LOWORD(dwVersion)));
        TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;
	    	
	sprintf(textbuf, "MS-DOS versão %d.%d",
	    HIBYTE(HIWORD(dwVersion)),
	    LOBYTE(HIWORD(dwVersion)));
        TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	DWORD SysFlags;
	SysFlags=GetWinFlags();
        strcpy (textbuf, "CPU: ");
	if (SysFlags & WF_CPU286) strcat (textbuf, "80286");
        else
		if (SysFlags & WF_CPU386) strcat (textbuf, "80386");
        	else
			if (SysFlags & WF_CPU486) strcat (textbuf, "80486");
			else
                        	strcat (textbuf, "Desconhecido");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;
	strcpy (textbuf, "FPU: ");
	if (SysFlags & WF_80x87) strcat (textbuf, "Presente");
		else strcat (textbuf, "Ausente");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;
        strcpy (textbuf, "Modo Windows:");
	if (SysFlags & WF_ENHANCED) strcat (textbuf, " 386 Enhanced");
	if (SysFlags & WF_STANDARD) strcat (textbuf, " Standard");
	if (SysFlags & WF_WLO) strcat (textbuf, " OS/2");
	if (SysFlags & WF_PMODE) strcat (textbuf, ", Protegido");
	if (SysFlags & WF_PAGING) strcat (textbuf, ", com Memória Paginada");
        TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	TextOut (PaintDC, nXText, nYText, "Drives:", 7);
	nYText+=nHeight;
	do
	        {
		sprintf(textbuf, "    Drive %c", counter + 'A');
		strcat (textbuf, " - ");
		if (GetDriveType (counter) != 0)
			{
			switch (GetDriveType (counter))
				{ 
				case DRIVE_FIXED: strcat (textbuf, "Fixa"); break;
				case DRIVE_REMOTE: strcat (textbuf, "Remota (rede) ou CD-ROM"); break;
				case DRIVE_REMOVABLE: strcat (textbuf, "Removível"); break;
                                }
			if (GetTempDrive (0) == 'A' + counter) strcat (textbuf, " (Melhor Drive Temporária)");
			TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
			nYText+=nHeight;
			}
		counter++;
		}
	while (counter < 25);

	nYText+=nHeight;

	strcpy (textbuf, "Memória Livre: ");
	gcvt (GetFreeSpace (256), 10, textbufn);
        strcat (textbuf, textbufn);
	strcat (textbuf, " bytes");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	strcpy (textbuf, "Recursos de Sistema Livres: ");
	gcvt (GetFreeSystemResources (0), 3, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, "%");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	strcpy (textbuf, "Recursos do GDI Livres: ");
	gcvt (GetFreeSystemResources (1), 3, textbufn);
	strcat (textbuf, textbufn);
        strcat (textbuf, "%");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	strcpy (textbuf, "Recursos do USER Livres: ");
	gcvt (GetFreeSystemResources (2), 3, textbufn);
	strcat (textbuf, textbufn);
        strcat (textbuf, "%");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

        char dirwin [144]; 
	GetWindowsDirectory (dirwin, 144);
        strcat (dirwin, "\\system.ini");

	GetPrivateProfileString ("boot.description", "display.drv", "Desconhecido", textbufn, sizeof (textbufn), dirwin);
	strcpy (textbuf, "Tipo de Placa Gráfica: ");
	strcat (textbuf, textbufn); 
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	GetPrivateProfileString ("boot.description", "mouse.drv", "Não Instalado ou Desconhecido", textbufn, sizeof (textbufn), dirwin);
	strcpy (textbuf, "Tipo de Rato: ");
	strcat (textbuf, textbufn); 
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	strcpy (textbuf, "Tipo de Teclado: ");
	switch (GetKeyboardType (0))
		{ 
		case 1: strcat (textbuf, "IBM PC/XT ou compatível (83 teclas)"); break;
		case 2: strcat (textbuf, "Olivetti «ICO» (102 teclas)"); break;
		case 3: strcat (textbuf, "IBM AT ou compatível (84 teclas)"); break;
		case 4: strcat (textbuf, "IBM «enhanced» ou semelhante (101 ou 102 teclas)"); break;
		case 5: strcat (textbuf, "Nokia 1050 ou semelhante"); break;
		case 6: strcat (textbuf, "Nokia 9140 ou semelhante"); break;
		case 7: strcat (textbuf, "Japonês"); break;
		default: strcat (textbuf, "Desconhecido");
        	}
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	int qq;
        strcpy (textbuf, "Página de Código Carregada (DOS): ");
	GetPrivateProfileString ("boot.description", "codepage", "", textbufn, sizeof (textbufn), dirwin);
	qq=atof (textbufn);
	switch (qq)
		{ 
		case 437: strcat (textbuf, "EUA (437) - Default"); break;
		case 850: strcat (textbuf, "Internacional (850)"); break;
		case 860: strcat (textbuf, "Portugal (860)"); break;
		case 861: strcat (textbuf, "Islândia (861)"); break;
		case 863: strcat (textbuf, "Francês Canadiano (862)"); break;
		case 865: strcat (textbuf, "Noruega / Dinamarca (865)"); break;
                default: strcat (textbuf, "Desconhecida"); break; 
        	}
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	strcpy (textbuf, "Directoria do Windows: ");
	GetWindowsDirectory (textbufn, 256);
        strcat (textbuf, textbufn);
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

        strcpy (textbuf, "Directoria de Sistema: ");
	GetSystemDirectory (textbufn, 256);
        strcat (textbuf, textbufn);
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*3;

	strcpy (textbuf, "Parâmetros do Windows:");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	strcpy (textbuf, "    País: ");
	GetProfileString ("Intl", "sCountry", "1", textbufn, sizeof (textbufn));
	strcat (textbuf, textbufn);
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	strcpy (textbuf, "    Código do País (Indicativo Telefónico): ");
	GetProfileString ("Intl", "iCountry", "1", textbufn, sizeof (textbufn));
	strcat (textbuf, textbufn);
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	strcpy (textbuf, "    Língua: ");
	GetProfileString ("Intl", "sLanguage", "1", textbufn, 4);
        strcpy (textbufn, strupr (textbufn));
	if (!(strcmp (textbufn,"DAN"))) strcat (textbuf, "Dinamarquês");
	else if (!(strcmp (textbufn,"DEU"))) strcat (textbuf, "Alemão");
	else if (!(strcmp (textbufn,"ENG"))) strcat (textbuf, "Inglês (Reino Unido)");
	else if (!(strcmp (textbufn,"ENU"))) strcat (textbuf, "Inglês (EUA)");
	else if (!(strcmp (textbufn,"ESN"))) strcat (textbuf, "Espanhol Moderno");
	else if (!(strcmp (textbufn,"ESP"))) strcat (textbuf, "Castelhano");
	else if (!(strcmp (textbufn,"FIN"))) strcat (textbuf, "Finlandês");
	else if (!(strcmp (textbufn,"FRA"))) strcat (textbuf, "Francês");
	else if (!(strcmp (textbufn,"FRC"))) strcat (textbuf, "Francês do Canadá");
	else if (!(strcmp (textbufn,"ISL"))) strcat (textbuf, "Islandês");
	else if (!(strcmp (textbufn,"ITA"))) strcat (textbuf, "Italiano");
	else if (!(strcmp (textbufn,"NLD"))) strcat (textbuf, "Holandês");
	else if (!(strcmp (textbufn,"NOR"))) strcat (textbuf, "Norueguês");
	else if (!(strcmp (textbufn,"PTG"))) strcat (textbuf, "Português");
	else if (!(strcmp (textbufn,"SVE"))) strcat (textbuf, "Sueco");
	else strcat (textbuf, textbufn);
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	BOOL HBeep;
	SystemParametersInfo (SPI_GETBEEP, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    Beep de Aviso: "); 
	if (HBeep) strcat (textbuf, "Ligado");
        else strcat (textbuf, "Desligado"); 
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

        int ibuf;
	SystemParametersInfo (SPI_GETBORDER, 0, &ibuf, 0);
        strcpy (textbuf, "    Largura da Borda das Janelas: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	SystemParametersInfo (SPI_GETGRIDGRANULARITY, 0, &ibuf, 0);
        strcpy (textbuf, "    Grão da Grelha de Regulação do Tamanho das Janelas: "); 
	gcvt (ibuf*8, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	SystemParametersInfo (SPI_GETICONTITLEWRAP, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    «Wrap» Automático dos Títulos dos Ícones: "); 
	if (HBeep) strcat (textbuf, "Ligado");
        else strcat (textbuf, "Desligado"); 
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;
        
	SystemParametersInfo (SPI_ICONHORIZONTALSPACING, 0, &ibuf, 0);
        strcpy (textbuf, "    Espaçamento Horizontal entre Ícones: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	SystemParametersInfo (SPI_ICONVERTICALSPACING, 0, &ibuf, 0);
        strcpy (textbuf, "    Espaçamento Vertical entre Ícones: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	SystemParametersInfo (SPI_GETFASTTASKSWITCH, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    Troca de Tarefas Rápida (Alt+Tab): "); 
	if (HBeep) strcat (textbuf, "Ligada");
        else strcat (textbuf, "Desligada"); 
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;


	SystemParametersInfo (SPI_GETKEYBOARDDELAY, 0, &ibuf, 0);
        strcpy (textbuf, "    Atraso de Repetição Automática do Teclado: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " segundos");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	WORD wbuf;
	SystemParametersInfo (SPI_GETKEYBOARDSPEED, 0, &wbuf, 0);
        strcpy (textbuf, "    Velocidade de Repetição do Teclado: "); 
	gcvt (wbuf, 10, textbufn);
	strcat (textbuf, textbufn);
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;

	SystemParametersInfo (SPI_GETSCREENSAVEACTIVE, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    «Screen Saver»: "); 
	if (HBeep) strcat (textbuf, "Ligado");
        else strcat (textbuf, "Desligado"); 
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight;

	SystemParametersInfo (SPI_GETSCREENSAVETIMEOUT, 0, &ibuf, 0);
        strcpy (textbuf, "    Tempo de Espera do «Screen Saver»: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " segundos");
	TextOut (PaintDC, nXText, nYText, textbuf, strlen (textbuf));
	nYText+=nHeight*2;
}


_CLASSDEF(TSobreDlg)

class TSobreDlg : public TDialog 
{
public:

   TSobreDlg(PTWindowsObject AParent, LPSTR AName);
   ~TSobreDlg();
};

TSobreDlg::TSobreDlg(PTWindowsObject AParent, LPSTR AName)
               :TDialog(AParent, AName)
{
}

TSobreDlg::~TSobreDlg()
{
}

void TMainWindow::GRAVARINFORMACAOCOMO(RTMessage)
{
OPENFILENAME ofn;
char szFile[256] = "*.txt";
char szFileTitle[256] = "*.txt";
char szDirName[256] = "";

memset(&ofn, 0, sizeof(OPENFILENAME));

ofn.lStructSize = sizeof(OPENFILENAME);
ofn.hwndOwner = HWindow;
ofn.lpstrFilter = "Texto (*.txt)\0*.txt\0Global (*.*)\0*.*\0";
ofn.lpstrFile= szFile;
ofn.nMaxFile = sizeof(szFile);
ofn.lpstrFileTitle = szFileTitle;
ofn.nMaxFileTitle = sizeof(szFileTitle);
ofn.lpstrInitialDir = szDirName;

ofn.Flags = OFN_OVERWRITEPROMPT | OFN_HIDEREADONLY;

if (GetSaveFileName(&ofn))
	{
	ofstream Ini(ofn.lpstrFile);
	char textbuf [256];
	char textbufn [256];
        int counter = 0;

	DWORD dwVersion;
	dwVersion = GetVersion();

	sprintf(textbuf, "Windows versão %d.%d",
	    LOBYTE(LOWORD(dwVersion)),
	    HIBYTE(LOWORD(dwVersion)));
	Ini << textbuf << "\n";
	
	sprintf(textbuf, "MS-DOS versão %d.%d",
	    HIBYTE(HIWORD(dwVersion)),
	    LOBYTE(HIWORD(dwVersion)));
	Ini << textbuf << "\n\n";

	DWORD SysFlags;
	SysFlags=GetWinFlags();
        strcpy (textbuf, "CPU: ");
	if (SysFlags & WF_CPU286) strcat (textbuf, "80286");
        else
		if (SysFlags & WF_CPU386) strcat (textbuf, "80386");
        	else
			if (SysFlags & WF_CPU486) strcat (textbuf, "80486");
			else
                        	strcat (textbuf, "Desconhecido");
	Ini << textbuf << "\n";

	strcpy (textbuf, "FPU: ");
        if (SysFlags & WF_80x87) strcat (textbuf, "Presente");
		else strcat (textbuf, "Ausente");
	Ini << textbuf << "\n\n";

        strcpy (textbuf, "Modo Windows:");
	if (SysFlags & WF_ENHANCED) strcat (textbuf, " 386 Enhanced");
	if (SysFlags & WF_STANDARD) strcat (textbuf, " Standard");
	if (SysFlags & WF_WLO) strcat (textbuf, " OS/2");
	if (SysFlags & WF_PMODE) strcat (textbuf, ", Protegido");
	if (SysFlags & WF_PAGING) strcat (textbuf, ", com Memória Paginada");
	Ini << textbuf << "\n\n";

	Ini << "Drives: " << "\n";
	do
	        {
		sprintf(textbuf, "    Drive %c", counter + 'A');
		strcat (textbuf, " - ");
		if (GetDriveType (counter) != 0)
			{
			switch (GetDriveType (counter))
				{ 
				case DRIVE_FIXED: strcat (textbuf, "Fixa"); break;
				case DRIVE_REMOTE: strcat (textbuf, "Remota (rede) ou CD-ROM"); break;
				case DRIVE_REMOVABLE: strcat (textbuf, "Removível"); break;
                                }
			if (GetTempDrive (0) == 'A' + counter) strcat (textbuf, " (Melhor Drive Temporária)");
			Ini << textbuf << "\n";			}
		counter++;
		}
	while (counter < 25);

	Ini << "\n";
	strcpy (textbuf, "Memória Livre: ");
	gcvt (GetFreeSpace (256), 10, textbufn);
        strcat (textbuf, textbufn);
	strcat (textbuf, " bytes");
	Ini << textbuf << "\n";


	strcpy (textbuf, "Recursos de Sistema Livres: ");
	gcvt (GetFreeSystemResources (0), 3, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, "%");
	Ini << textbuf << "\n";


	strcpy (textbuf, "Recursos do GDI Livres: ");
	gcvt (GetFreeSystemResources (1), 3, textbufn);
	strcat (textbuf, textbufn);
        strcat (textbuf, "%");
	Ini << textbuf << "\n";


	strcpy (textbuf, "Recursos do USER Livres: ");
	gcvt (GetFreeSystemResources (2), 3, textbufn);
	strcat (textbuf, textbufn);
        strcat (textbuf, "%");
	Ini << textbuf << "\n\n";
	
	char dirwin [144];
	GetWindowsDirectory (dirwin, 144);
	strcat (dirwin, "\\system.ini");

	GetPrivateProfileString ("boot.description", "display.drv", "Desconhecido", textbufn, sizeof (textbufn), dirwin);
	strcpy (textbuf, "Tipo de Placa Gráfica: ");
	strcat (textbuf, textbufn); 
	Ini << textbuf << "\n";

	GetPrivateProfileString ("boot.description", "mouse.drv", "Não Instalado ou Desconhecido", textbufn, sizeof (textbufn), dirwin);
	strcpy (textbuf, "Tipo de Rato: ");
	strcat (textbuf, textbufn); 
	Ini << textbuf << "\n";

	strcpy (textbuf, "Tipo de Teclado: ");
	switch (GetKeyboardType (0))
		{ 
		case 1: strcat (textbuf, "IBM PC/XT ou compatível (83 teclas)"); break;
		case 2: strcat (textbuf, "Olivetti «ICO» (102 teclas)"); break;
		case 3: strcat (textbuf, "IBM AT ou compatível (84 teclas)"); break;
		case 4: strcat (textbuf, "IBM «enhanced» ou semelhante (101 ou 102 teclas)"); break;
		case 5: strcat (textbuf, "Nokia 1050 ou semelhante"); break;
		case 6: strcat (textbuf, "Nokia 9140 ou semelhante"); break;
		case 7: strcat (textbuf, "Japonês"); break;
		default: strcat (textbuf, "Desconhecido");
        	}
	Ini << textbuf << "\n";

	int qq;
        strcpy (textbuf, "Página de Código Carregada (DOS): ");
	GetPrivateProfileString ("boot.description", "codepage", "", textbufn, sizeof (textbufn), dirwin);
	qq=atof (textbufn);
	switch (qq)
		{ 
		case 437: strcat (textbuf, "EUA (437) - Default"); break;
		case 850: strcat (textbuf, "Internacional (850)"); break;
		case 860: strcat (textbuf, "Portugal (860)"); break;
		case 861: strcat (textbuf, "Islândia (861)"); break;
		case 863: strcat (textbuf, "Francês Canadiano (862)"); break;
		case 865: strcat (textbuf, "Noruega / Dinamarca (865)"); break;
                default: strcat (textbuf, "Desconhecida"); break; 
        	}
	Ini << textbuf << "\n\n";


	strcpy (textbuf, "Directoria do Windows: ");
	GetWindowsDirectory (textbufn, 256);
        strcat (textbuf, textbufn);
	Ini << textbuf << "\n";


        strcpy (textbuf, "Directoria de Sistema: ");
	GetSystemDirectory (textbufn, 256);
        strcat (textbuf, textbufn);
	Ini << textbuf << "\n\n\n";


	strcpy (textbuf, "Parâmetros do Windows:");
	Ini << textbuf << "\n\n";


	strcpy (textbuf, "    País: ");
	GetProfileString ("Intl", "sCountry", "1", textbufn, sizeof (textbufn));
	strcat (textbuf, textbufn);
	Ini << textbuf << "\n";


	strcpy (textbuf, "    Código do País (Indicativo Telefónico): ");
	GetProfileString ("Intl", "iCountry", "1", textbufn, sizeof (textbufn));
	strcat (textbuf, textbufn);
	Ini << textbuf << "\n";


	strcpy (textbuf, "    Língua: ");
	GetProfileString ("Intl", "sLanguage", "1", textbufn, 4);
        strcpy (textbufn, strupr (textbufn));
	if (!(strcmp (textbufn,"DAN"))) strcat (textbuf, "Dinamarquês");
	else if (!(strcmp (textbufn,"DEU"))) strcat (textbuf, "Alemão");
	else if (!(strcmp (textbufn,"ENG"))) strcat (textbuf, "Inglês (Reino Unido)");
	else if (!(strcmp (textbufn,"ENU"))) strcat (textbuf, "Inglês (EUA)");
	else if (!(strcmp (textbufn,"ESN"))) strcat (textbuf, "Espanhol Moderno");
	else if (!(strcmp (textbufn,"ESP"))) strcat (textbuf, "Castelhano");
	else if (!(strcmp (textbufn,"FIN"))) strcat (textbuf, "Finlandês");
	else if (!(strcmp (textbufn,"FRA"))) strcat (textbuf, "Francês");
	else if (!(strcmp (textbufn,"FRC"))) strcat (textbuf, "Francês do Canadá");
	else if (!(strcmp (textbufn,"ISL"))) strcat (textbuf, "Islandês");
	else if (!(strcmp (textbufn,"ITA"))) strcat (textbuf, "Italiano");
	else if (!(strcmp (textbufn,"NLD"))) strcat (textbuf, "Holandês");
	else if (!(strcmp (textbufn,"NOR"))) strcat (textbuf, "Norueguês");
	else if (!(strcmp (textbufn,"PTG"))) strcat (textbuf, "Português");
	else if (!(strcmp (textbufn,"SVE"))) strcat (textbuf, "Sueco");
	else strcat (textbuf, textbufn);
	Ini << textbuf << "\n\n";


	BOOL HBeep;
	SystemParametersInfo (SPI_GETBEEP, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    Beep de Aviso: "); 
	if (HBeep) strcat (textbuf, "Ligado");
        else strcat (textbuf, "Desligado"); 
	Ini << textbuf << "\n\n";


	int ibuf;
	SystemParametersInfo (SPI_GETBORDER, 0, &ibuf, 0);
        strcpy (textbuf, "    Largura da Borda das Janelas: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	Ini << textbuf << "\n";


	SystemParametersInfo (SPI_GETGRIDGRANULARITY, 0, &ibuf, 0);
        strcpy (textbuf, "    Grão da Grelha de Regulação do Tamanho das Janelas: "); 
	gcvt (ibuf*8, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	Ini << textbuf << "\n\n";

	SystemParametersInfo (SPI_GETICONTITLEWRAP, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    «Wrap» Automático dos Títulos dos Ícones: "); 
	if (HBeep) strcat (textbuf, "Ligado");
        else strcat (textbuf, "Desligado"); 
	Ini << textbuf << "\n";

        
	SystemParametersInfo (SPI_ICONHORIZONTALSPACING, 0, &ibuf, 0);
        strcpy (textbuf, "    Espaçamento Horizontal entre Ícones: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	Ini << textbuf << "\n";


	SystemParametersInfo (SPI_ICONVERTICALSPACING, 0, &ibuf, 0);
        strcpy (textbuf, "    Espaçamento Vertical entre Ícones: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " pixels");
	Ini << textbuf << "\n\n";


	SystemParametersInfo (SPI_GETFASTTASKSWITCH, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    Troca de Tarefas Rápida (Alt+Tab): "); 
	if (HBeep) strcat (textbuf, "Ligada");
        else strcat (textbuf, "Desligada"); 
	Ini << textbuf << "\n\n";



	SystemParametersInfo (SPI_GETKEYBOARDDELAY, 0, &ibuf, 0);
        strcpy (textbuf, "    Atraso de Repetição Automática do Teclado: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " segundos");
	Ini << textbuf << "\n";


	WORD wbuf;
	SystemParametersInfo (SPI_GETKEYBOARDSPEED, 0, &wbuf, 0);
        strcpy (textbuf, "    Velocidade de Repetição do Teclado: "); 
	gcvt (wbuf, 10, textbufn);
	strcat (textbuf, textbufn);
	Ini << textbuf << "\n\n";


	SystemParametersInfo (SPI_GETSCREENSAVEACTIVE, 0, (LPSTR) HBeep, 0);
        strcpy (textbuf, "    «Screen Saver»: "); 
	if (HBeep) strcat (textbuf, "Ligado");
        else strcat (textbuf, "Desligado"); 
	Ini << textbuf << "\n";


	SystemParametersInfo (SPI_GETSCREENSAVETIMEOUT, 0, &ibuf, 0);
        strcpy (textbuf, "    Tempo de Espera do «Screen Saver»: "); 
	gcvt (ibuf, 10, textbufn);
	strcat (textbuf, textbufn);
	strcat (textbuf, " segundos");
	Ini << textbuf << "\n";
	}
}

void TMainWindow::SAIR(RTMessage)
{
if (MessageBox(HWindow, "Tem a certeza que quer sair do WinInfo?", "Sair",
            MB_ICONQUESTION | MB_YESNO) == IDYES)
	{
	KillTimer (HWindow, 2);
	DestroyWindow (HWindow);
	}

}

void TMainWindow::WMClose(RTMessage Msg)
{
TMainWindow::SAIR(Msg);
}

void TMainWindow::SetupWindow()
{
SetTimer (HWindow, 2, 1000, NULL);
}

void TMainWindow::WMSize(RTMessage Msg)
{

if ((Msg.WParam)==SIZE_MINIMIZED)
	{
        firsttime=1;
	TMainWindow::WMTimer(Msg);
	}
else
	if (((Msg.WParam)==SIZE_RESTORED)||((Msg.WParam)==SIZE_MAXIMIZED))
		SetWindowText (HWindow, "WinInfo");
}


void TMainWindow::WMTimer(RTMessage)
{
if (IsIconic (HWindow))
	{
	char textbuf [50];
        char textbufn [10];
	long newfree = GetFreeSpace (256)/1024;
 	if ((newfree!=oldfree) || firsttime)
		{
		strcpy (textbuf, "WinInfo - ");
		gcvt (newfree, 10, textbufn);
	        strcat (textbuf, textbufn);
		strcat (textbuf, " kb livres");
		SetWindowText (HWindow, textbuf);
		oldfree=newfree;
                firsttime=0;
		} 
	}
}




void TMainWindow::SOBRE(RTMessage)
{
GetModule()->ExecDialog(new TSobreDlg(this, "Sobre"));
}

void TWinInfo::InitMainWindow()
{
   MainWindow = new TMainWindow(NULL, Name);
}

int PASCAL WinMain(HANDLE hInstance,
                   HANDLE hPrevInstance,
                   LPSTR lpCmdLine,
                   int nCmdShow)
{

if (hPrevInstance!=NULL)
	{
	HWND hWndPrev = FindWindow("WinInfoWindow", NULL);
	BringWindowToTop (hWndPrev);
	ShowWindow (hWndPrev, SW_RESTORE);
	return FALSE;
	}


   TWinInfo WinInfo ("WinInfo", hInstance, hPrevInstance,
      lpCmdLine, nCmdShow);

   WinInfo.Run();

   return WinInfo.Status;
}

