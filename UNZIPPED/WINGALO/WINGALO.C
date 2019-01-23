/************************************************************************
*                                                                       *
* WINGALO.C --> Rotinas de controle geral do jogo. WinMain. Procedure   *
*	   da janela principal	            								*
*																		*
*        Ultima revisão por Ricardo Vinagre em 22/08/94                 *
*                                                                       *
************************************************************************/                                                      
#include <windows.h>
#include <stdlib.h>
#include "wingalo.h"
#include "about.h"
#include "logic.h"
#include "child.h"

char szChildClass[]="PosClass"; 
UINT nFase;
UINT nNivel;
HINSTANCE hInst;
char szStringBuffer[MAXSTRING];

long FAR PASCAL _export WndProc(HWND,UINT,UINT,LONG);

/* Mudar o cursor para indicar o estado do jogo */
void SetGameCursor(char *nome,HWND hwnd)
{
	HWND hChild;
	RECT rect;
	POINT pt;
    HCURSOR hCur;

/* Mudar o cursor da janela pai */
	hCur=LoadCursor(hInst,nome);
	SetClassWord(hwnd,GCW_HCURSOR,(WORD)hCur);
/* Mudar o cursor das janelas filhas */
	hChild=GetWindow(hwnd,GW_CHILD);
	while(hChild)
	{
		SetClassWord(hChild,GCW_HCURSOR,(WORD)hCur);
		do
		{
			hChild=GetWindow(hChild,GW_HWNDNEXT);
		}
		while(hChild && GetParent(hChild)!=hwnd);
	}
/* Se o cursor esta na area da janela de jogo, actualizar cursor no ecrã  */
	GetWindowRect(hwnd,&rect);
	GetCursorPos(&pt);
	if(PtInRect(&rect,pt))
		SetCursor(hCur);
}

/* Obter dados sobre a posição da janela principal do ficheiro de
* inicialização */
POINT GetPositionData(void)
{
	POINT location;
	location.x=GetPrivateProfileInt("Inicialization","xpos",0,
								INI_FILE);
	location.y=GetPrivateProfileInt("Inicialization","ypos",0,
								INI_FILE);
	return location;
}

/* Colocar dados sobre a posição da janela principal no ficheiro de
* inicialização */
void WritePositionData(HWND hwnd)
{
	RECT rect;
	char buffer[MAX_BUFFER];

	GetWindowRect(hwnd,&rect);
	WritePrivateProfileString("Inicialization","xpos",
			itoa(rect.left,buffer,10),INI_FILE);
	WritePrivateProfileString("Inicialization","ypos",
			itoa(rect.top,buffer,10),INI_FILE);
	WritePrivateProfileString(NULL,NULL,NULL,INI_FILE);
}

/* Subrotina de entrada no programa */
#ifdef __BORLANDC__
#pragma argsused
#endif
int PASCAL WinMain(HINSTANCE hInstance,HINSTANCE hPrevInstance,
					LPSTR lpszCmdLine,int nCmdShow)
{
	char szAppName[]="WinGalo";
	WNDCLASS wndclass;
	MSG msg;
	HWND hwnd;
    POINT MainWindowPos;

/* Se o programa ja esta activo na memória, avisar utilizador e sair */
	if(hPrevInstance)
	{
		LoadString(hInstance,SSID_NOMORE,szStringBuffer,MAXSTRING);
		MessageBox(NULL,szStringBuffer,szAppName,MB_OK | MB_ICONEXCLAMATION);
		return 0;
	}
/* Registar classe da janela pai */
	wndclass.style=CS_HREDRAW | CS_VREDRAW;
	wndclass.lpfnWndProc=WndProc;
	wndclass.cbClsExtra=0;
	wndclass.cbWndExtra=0;
	wndclass.hInstance=hInstance;
	wndclass.hIcon=LoadIcon(hInstance,szAppName);
	wndclass.hCursor=LoadCursor(hInstance,"Proibido");
  	wndclass.hbrBackground=(HBRUSH)GetStockObject(WHITE_BRUSH);
	wndclass.lpszMenuName=szAppName;
	wndclass.lpszClassName=szAppName;

  	RegisterClass(&wndclass);

/* Registar classe das janelas filhas */
	wndclass.lpfnWndProc=PosProc;
	wndclass.cbWndExtra=sizeof(WORD);
	wndclass.hIcon=NULL;
	wndclass.lpszMenuName=NULL;
	wndclass.lpszClassName=szChildClass;

	RegisterClass(&wndclass);

	hInst=hInstance;

/* Criar janela principal */
    MainWindowPos=GetPositionData();
	hwnd=CreateWindow(szAppName,"WinGalo",WS_CAPTION |
				WS_SYSMENU | WS_MINIMIZEBOX,MainWindowPos.x,
				MainWindowPos.y,MWS_WIDTH,MWS_HEIGHT,NULL,
				NULL,hInstance,NULL);
	ShowWindow(hwnd,nCmdShow);
	UpdateWindow(hwnd);
/* Ciclo de processamento das mensagens */
	while(GetMessage(&msg,NULL,0,0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}
	return msg.wParam;
}


/* Procedure da janela pai */
long FAR PASCAL _export WndProc(HWND hwnd,UINT message,
					UINT wParam,LONG lParam)
{
	static DLGPROC lpfnAboutDlgProc;
	static UINT nSide;
	static UINT nOps;
	static UINT pwJogo[9];
	static UINT nJogada;
	static int cxChar,cyChar;
	static int cxClient,cyClient;
	static HWND phChild[9];
	HMENU hMenu;
	TEXTMETRIC tm;
  	PAINTSTRUCT ps;
	HDC hdc;
  	RECT rect;
	int x,y,cxChild,cyChild,cxLine,cyLine;
	int aux,wEndResult;

	switch(message)
	{
/* Criação da janela */
		case WM_CREATE:
			lpfnAboutDlgProc=(DLGPROC)MakeProcInstance((FARPROC)AboutDlgProc
										,hInst);
/* Obter dimensões da janela */
			hdc=GetDC(hwnd);
			GetTextMetrics(hdc,&tm);
			cxChar=tm.tmAveCharWidth;
			cyChar=tm.tmHeight+tm.tmExternalLeading;
			ReleaseDC(hwnd,hdc);
/* Inicializar variaveis de jogo */
			nFase=GF_NOPLAY; /* Fase do jogo = Nenhum jogo a ser jogado */
			nSide=SP_BALL; /* Lado do jogador humano = circulos */
			nOps=OPS_1PLAYER; /* Tipo de jogo = humano vs computador */
			nJogada=0; /* Número da jogada = 0 */
            nNivel=1; /* Nivel de jogo = 1 (O mais facil) */
/* Criar as janelas filhas */
			for(aux=0;aux<9;aux++)
				phChild[aux]=CreateWindow(szChildClass,NULL,
						WS_CHILDWINDOW | WS_VISIBLE,0,0,0,0,
						hwnd,(HMENU)aux,hInst,NULL);
			return 0;
/* Destribuição da vez de jogo (joga o computador ou espera que o
* utilizador jogue) */
		case WM_PLAYGAME:
/* E a vez do computador jogar? */
			if(nFase==nSide || nFase==GF_NOPLAY || nOps==OPS_2PLAYER)
				return 0;
/* Joga o computador... */
			aux=JogaComputador(pwJogo,nJogada);
/* Se tudo correu bem actualiza o tabuleiro de jogo */
			if(aux!=-1)
			{
				SendMessage(phChild[aux],WM_COMMANDCHILD,PM_SET,
									(LONG)nFase);
				nJogada++;
				pwJogo[aux]=nFase;
			}
/* Se acabou o jogo, avisar utilizador e parar o jogo  */
			if((wEndResult=FimDeJogo(pwJogo))!=0 || aux==-1 || nJogada==10)
			{
				nJogada=0;
				nFase=GF_NOPLAY;
				switch(wEndResult)
				{
/* Victória dos circulos */	
					case CWS_BALL:
						LoadString(hInst,ITID_WINBALL,szStringBuffer,MAXSTRING);
						break;
/* Victória das cruzes */
					case CWS_CROSS:
						LoadString(hInst,ITID_WINCROSS,szStringBuffer,MAXSTRING);
						break;
/* Empate */
					default:
						LoadString(hInst,ITID_EMPATE,szStringBuffer,MAXSTRING);
				}
						SetGameCursor("Proibido",hwnd);
						MessageBox(hwnd,szStringBuffer,"WinGalo",MB_OK |
													MB_ICONEXCLAMATION);
			}
/* Caso nao tenha acabado o jogo, mudar o lado a jogar e actualizar cursor */
			else
			{
				nFase=nSide;
				if(nFase==GF_PLAYBALL)
					SetGameCursor("Mao_e_bola",hwnd);
		      	else
					SetGameCursor("Mao_e_cruz",hwnd);
            }
			return 0;
/* Aviso de uma das janelas filhas que o utilizador jogou */
		case WM_WARNFATHER:
/* Actualizar estrutura de jogo em memória */
			pwJogo[LOWORD(lParam)]=wParam;
			nJogada++;
/* Se e fim de jogo, parar o jogo e avisar o user */
			if((wEndResult=FimDeJogo(pwJogo))!=0 || nJogada==10)
			{
				nJogada=0;
				nFase=GF_NOPLAY;
				switch(wEndResult)
				{
					case CWS_BALL:
						LoadString(hInst,ITID_WINBALL,szStringBuffer,MAXSTRING);
						break;
					case CWS_CROSS:
						LoadString(hInst,ITID_WINCROSS,szStringBuffer,MAXSTRING);
						break;
					default:
						LoadString(hInst,ITID_EMPATE,szStringBuffer,MAXSTRING);
				}
						SetGameCursor("Proibido",hwnd);
						MessageBox(hwnd,szStringBuffer,"WinGalo",MB_OK |
													MB_ICONEXCLAMATION);
			}
/* Se não e fim de jogo, mudar o cursor e o lado a jogar */
			else
			{
				if(nFase==GF_PLAYBALL)
				{
                	nFase=GF_PLAYCROSS;
					SetGameCursor("Mao_e_cruz",hwnd);
                }
				else
				{
                	nFase=GF_PLAYBALL;
					SetGameCursor("Mao_e_bola",hwnd);
                }
            }
/* "Dar" ao computador a vez de jogar */
			PostMessage(hwnd,WM_PLAYGAME,0,0L);
			return 0;
/* Aparecimento da janela */
		case WM_SIZE:
			cxClient=LOWORD(lParam);
			cyClient=HIWORD(lParam);
/* Posicionar as janelas filhas  */
			for(x=0,cxChild=cxClient/2-9*cyChar/4-3;x<3;x++,
							cxChild+=3*cyChar/2+3)
				for(y=0,cyChild=cyClient/2-9*cyChar/4-3;y<3;y++,
								cyChild+=3*cyChar/2+3)
					MoveWindow(phChild[x+y*3],cxChild,cyChild,3*cyChar/2,
										3*cyChar/2,TRUE);
			return 0;
/* "Pintar" a janela pai */
		case WM_PAINT:
			hdc=BeginPaint(hwnd,&ps);
			for(aux=0,cxLine=cxClient/2-3*cyChar/4-2;aux<2;aux++,
								cxLine+=3*cyChar/2+3)
			{
				MoveTo(hdc,cxLine,cyClient/2-9*cyChar/4-3);
				LineTo(hdc,cxLine,cyClient/2+9*cyChar/4+3+3*cyChar/2%2);
			}
			for(y=0,cyLine=cyClient/2-3*cyChar/4-2;y<2;y++,
								cyLine+=3*cyChar/2+3)
			{
				MoveTo(hdc,cxClient/2-9*cyChar/4-3,cyLine);
				LineTo(hdc,cxClient/2+9*cyChar/4+3+3*cyChar/2%2,cyLine);
			}
			EndPaint(hwnd,&ps);
			return 0;
/* Comando do menu */
		case WM_COMMAND:
			hMenu=GetMenu(hwnd);
			switch(wParam)
			{
/* Iniciar novo jogo */
				case IDM_INICIAR:
					LimpaJogo(pwJogo);
					nJogada=1;
/* Limpar janelas filhas */
					for(aux=0;aux<9;aux++)
						SendMessage(phChild[aux],WM_COMMANDCHILD,
										PM_RESET,0L);
/* Actualizar o resto... */
					nFase=GF_PLAYBALL;
					PostMessage(hwnd,WM_PLAYGAME,0,0L);
					SetGameCursor("Mao_e_bola",hwnd);
					return 0;
/* Sair do programa  */
				case IDM_SAIR:
					SendMessage(hwnd,WM_CLOSE,0,0L);
					return 0;
/* Opcão - 1 Jogador */
				case IDM_1JOGADOR:
/* Se estiver na opção de 2 Jogadores, actualizar opção */
					if(nOps==OPS_2PLAYER)
					{
						nOps=OPS_1PLAYER;
						EnableMenuItem(hMenu,IDM_BOLAS,MF_ENABLED);
						EnableMenuItem(hMenu,IDM_CRUZES,MF_ENABLED);
						EnableMenuItem(hMenu,IDM_NIVEL1,MF_ENABLED);
						EnableMenuItem(hMenu,IDM_NIVEL2,MF_ENABLED);
						EnableMenuItem(hMenu,IDM_NIVEL3,MF_ENABLED);
						CheckMenuItem(hMenu,IDM_2JOGADORES,MF_UNCHECKED);
						CheckMenuItem(hMenu,IDM_1JOGADOR,MF_CHECKED);
						PostMessage(hwnd,WM_PLAYGAME,0,0L);
					}
					return 0;
/* Opção - 2 Jogadores  */
				case IDM_2JOGADORES:
					if(nOps==OPS_1PLAYER)
					{
						nOps=OPS_2PLAYER;
						EnableMenuItem(hMenu,IDM_BOLAS,MF_GRAYED);
						EnableMenuItem(hMenu,IDM_CRUZES,MF_GRAYED);
						EnableMenuItem(hMenu,IDM_NIVEL1,MF_GRAYED);
						EnableMenuItem(hMenu,IDM_NIVEL2,MF_GRAYED);
						EnableMenuItem(hMenu,IDM_NIVEL3,MF_GRAYED);
						CheckMenuItem(hMenu,IDM_1JOGADOR,MF_UNCHECKED);
						CheckMenuItem(hMenu,IDM_2JOGADORES,MF_CHECKED);
					}
					return 0;
/* Mudar lado do jogador humano (modo de 1 jogador) */
				case IDM_BOLAS:
				case IDM_CRUZES:
					CheckMenuItem(hMenu,nSide,MF_UNCHECKED);
					nSide=wParam;
					CheckMenuItem(hMenu,nSide,MF_CHECKED);
					PostMessage(hwnd,WM_PLAYGAME,0,0L);
					return 0;
/* Mudar nivel de jogo do computador */
				case IDM_NIVEL1:
				case IDM_NIVEL2:
				case IDM_NIVEL3:
					CheckMenuItem(hMenu,nNivel+IDM_NIVEL1-1,MF_UNCHECKED);
					nNivel=wParam-IDM_NIVEL1+1;
					CheckMenuItem(hMenu,wParam,MF_CHECKED);
                    return 0;
/* Obter ajuda */
				case IDM_INDEX:
					if(!WinHelp(hwnd,"wingalo.hlp",HELP_CONTENTS,0L))
						MessageBox(hwnd,"Impossivel fornecer ajuda",
									"WinGalo",MB_OK | MB_ICONEXCLAMATION);
					return 0; 
/* Sobre o jogo...  */
				case IDM_SOBRE:
					DialogBox(hInst,"AboutDlg",hwnd,lpfnAboutDlgProc);
					return 0;
			}
/* Sair do programa (limpar tudo...) */
		case WM_DESTROY:
        	WinHelp(hwnd,"wingalo.hlp",HELP_QUIT,0L);
			FreeProcInstance((FARPROC)lpfnAboutDlgProc);
			WritePositionData(hwnd);
			PostQuitMessage(1);
			return 0;
	}
	return(DefWindowProc(hwnd,message,wParam,lParam));
}
