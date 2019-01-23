/************************************************************************
*                                                                       *
* LOGIC.C --> Rotinas para implementação do algoritmo de jogo do        *
*	   computador e para verificar se o jogo ja terminou	            *
*																		*
*        Ultima revisão por Ricardo Vinagre em 22/08/94                 *
*                                                                       *
************************************************************************/                                                      

#include <stdlib.h>
#include <time.h>
#include <windows.h>
#include "logic.h"
#include "wingalo.h"


/* Existe a peça wPeca na posição nPos do jogo? */
BOOL Existe(int nPos,UINT wPeca,UINT pwTabela[9])
{
	return(pwTabela[nPos-1]==wPeca);
}

/* Qual o tipo das peças do lado adversário */
UINT PecaInimigo(void)
{
	return((nFase==GF_PLAYBALL)?CWS_CROSS:CWS_BALL);
}

/* Posição por "Cima" de nPos
*	NOTA:A peça por cima da posição mais superior é a que está na
*	posição mais inferior */
int Cima(int nPos)
{
	nPos-=3;
	if(nPos<1)
		return(nPos+9);
	else
		return(nPos);
}

/* Posição por "Baixo" de nPos (com regras similares à função Cima) */
int Baixo(int nPos)
{
	nPos+=3;
	if(nPos>9)
		return(nPos-9);
	else
		return(nPos);
}

/* Posição à "Direita" de nPos (idem) */
int Direita(int nPos)
{
	nPos++;
	if(nPos%3==1)
		return(nPos-3);
	else
		return(nPos);
}

/* Posição à "Esquerda" de nPos (idem) */
int Esquerda(int nPos)
{
	nPos--;
	if(nPos%3==0)
		return(nPos+3);
	else
		return(nPos);
}

/* nPos e um canto? */
BOOL ECanto(int pos)
{
	return(pos%2 && pos!=5);
}

/* Ponto diametralmente oposto a nPos */
int PontoOposto(int pos)
{
	return(10-pos);
}

/* Um dos cantos do lado onde esta a posição nPos */
int CantoDoLado(int pos)
{
	if(pos==2 || pos==8)
		return(pos-1);
	if(pos==4 || pos==6)
		return(pos-3);
	else
		return(pos);
}

/* Um dos cantos do lado oposto ao lado onde esta a posição nPos */
int CantoOposto(int pos)
{
	return(CantoDoLado(PontoOposto(pos)));
}

/* Acha a peça do tipo wPeca no jogo (utilizável para quando só ha uma
*	peça do tipo wPeca) */
int AchaPeca(UINT pwTabela[9],UINT wPeca)
{
	int aux;

	for(aux=1;aux<=9;aux++)
		if(Existe(aux,wPeca,pwTabela))
			return(aux);
    return(1);
}

/* Determina se o jogador com as pecas do tipo wPeca esta quase a ganhar.
* Em caso positivo retorna a posição que falta jogar para ganhar o jogo*/
int Quase_Ganhou(UINT wPeca,UINT pwTabela[9])
{
	int aux;

	for(aux=1;aux<=9;aux++)
	{
		if(!Existe(aux,CWS_NULL,pwTabela))
			continue;
		if(Existe(Cima(aux),wPeca,pwTabela) && Existe(Baixo(aux),
												wPeca,pwTabela))
			return(aux);
		if(Existe(Direita(aux),wPeca,pwTabela) && Existe(Esquerda(aux),
												wPeca,pwTabela))
			return(aux);
		if(aux==1 || aux==5 || aux==9)
			if(Existe(Cima(Esquerda(aux)),wPeca,pwTabela) &&
						Existe(Baixo(Direita(aux)),wPeca,pwTabela))
				return(aux);
		if(aux==7 || aux==5 || aux==3)
			if(Existe(Cima(Direita(aux)),wPeca,pwTabela) &&
						Existe(Baixo(Esquerda(aux)),wPeca,pwTabela))
				return(aux);
	}
	return 0;
}

/* Determina se o jogador com as peças do tipo wPeca ganhou o jogo */
BOOL Ganhou(UINT wPeca,UINT pwTabela[9])
{
	int aux;

	for(aux=1;aux<4;aux++)
		if(Existe(aux,wPeca,pwTabela) && Existe(Cima(aux),wPeca,pwTabela) &&
							Existe(Baixo(aux),wPeca,pwTabela))
			return(TRUE);
  for(aux=1;aux<8;aux+=3)
		if(Existe(aux,wPeca,pwTabela) && Existe(Direita(aux),wPeca,pwTabela) &&
							Existe(Esquerda(aux),wPeca,pwTabela))
			return(TRUE);
	if(Existe(5,wPeca,pwTabela))
	{
		if(Existe(1,wPeca,pwTabela) && Existe(9,wPeca,pwTabela))
			return(TRUE);
		else if(Existe(3,wPeca,pwTabela) && Existe(7,wPeca,pwTabela))
			return(TRUE);
	}
	return(FALSE);
}

/* Determina se o jogo acabou por vitória de um dos jogadores, retornando 
* nesse caso o tipo das peças desse jogador */
UINT FimDeJogo(UINT pwTabela[9])
{
	if(Ganhou(CWS_BALL,pwTabela))
		return(CWS_BALL);
	else if(Ganhou(CWS_CROSS,pwTabela))
		return(CWS_CROSS);
	else
		return(FALSE);
}  

/* Limpa a estrutura do jogo em memória (deixando o tabuleiro com o
* mesmo aspecto) */
void LimpaJogo(UINT *pwJogo)
{
	int aux;

	for(aux=0;aux<9;aux++)
		pwJogo[aux]=CWS_NULL;
}

/* Jogada aleatoria */
#ifdef __BORLANDC__
#pragma argsused
#endif
int RandomPlay(UINT *pwGame,UINT nJogada)
{
	int aux;

	randomize();
	do
	{
		aux=random(9);
	}
	while(pwGame[aux]!=CWS_NULL);
	return(aux+1);
}

/* Jogada tendo em conta as possibilidades de quase-victoria e
* quase-derrota */
int SimplePlay(UINT *pwGame,UINT nJogada)
{
	int spot;

	if((spot=Quase_Ganhou(nFase,pwGame))!=0)
		return(spot);
	if((spot=Quase_Ganhou(PecaInimigo(),pwGame))!=0)
		return(spot);
	return(RandomPlay(pwGame,nJogada));
}

/* Jogada com alguma estrategia no inicio do jogo */
int GoodPlay(UINT *pwGame,UINT nJogada)
{
	int aux;

/* A parte estrategica */
	if(Existe(5,PecaInimigo(),pwGame) && nJogada==2)
		return(3);
	if(nJogada==2 && ECanto(AchaPeca(pwGame,PecaInimigo())))
		return(5);
	if(nJogada==2)
		return(CantoOposto(AchaPeca(pwGame,PecaInimigo())));
	if(nJogada==1)
		return(5);
/* O resto  */
	return(SimplePlay(pwGame,nJogada));
}

/* O tipo de jogada que realmente se vai fazer (depende do nivel de 
*  jogo escolhido pelo utilizador) */
#ifdef __BORLANDC__
#pragma argsused
#endif
int JogaComputador(UINT *pwGame,UINT nJogada)
{
	switch(nNivel)
	{
		case 1:
			return(RandomPlay(pwGame,nJogada)-1);
		case 2:
			return(SimplePlay(pwGame,nJogada)-1);
		case 3:
			return(GoodPlay(pwGame,nJogada)-1);

	}
    return(5);
}
