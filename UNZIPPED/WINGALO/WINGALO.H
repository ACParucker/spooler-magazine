#ifndef __WINGALO_H
#define __WINGALO_H

#include "wgmenudf.h"

// Ficheiro de inicializacao
#define INI_FILE   	"wingalo.ini"

// Tamanho máximo do buffer para carregar resources do tipo string
#define MAXSTRING	50

// Tamanho da janela pai
#define MWS_WIDTH  	130
#define MWS_HEIGHT 	170

// Códigos para a mensagem a enviar aos filhos pela janela pai
#define PM_SET	 	0
#define PM_RESET 	1

// Status das janelas filhas
#define CWS_NULL  	0
#define CWS_CROSS 	IDM_CRUZES
#define CWS_BALL  	IDM_BOLAS

// Códigos para a mensagen enviada à janela pai indicando mudança de
// status das janelas filhas
#define CSM_CROSS 	CWS_CROSS
#define CSM_BALL  	CWS_BALL

// Fases de jogo para o user
#define GF_NOPLAY    	0
#define GF_PLAYCROSS 	CSM_CROSS
#define GF_PLAYBALL  	CSM_BALL

// Macros
#define wStatus(hwnd) 	GetWindowWord(hwnd,0)

//Opções de jogo
#define OPS_1PLAYER 	IDM_1JOGADOR
#define OPS_2PLAYER 	IDM_2JOGADORES

// Lado de jogo do user (para modo 1 jogador)
#define SP_BALL	 	GF_PLAYBALL
#define SP_CROSS 	GF_PLAYCROSS

// Mensagem de jogada para a janela pai
#define WM_PLAYGAME 	(WM_USER+1)

// Mensagem enviada à janela filha para ela alterar o seu status
#define WM_COMMANDCHILD WM_USER

// Mensagem enviada à janela pai indicando que uma janela filha mudou
// de status
#define WM_WARNFATHER   WM_USER

// Tamanho máximo do buffer para converter a posição da
// janela numa string de dígitos
#define MAX_BUFFER 	6

extern UINT nFase;
extern UINT nNivel;
extern HINSTANCE hInst;
extern char szStringBuffer[MAXSTRING];


#endif //wingalo.h