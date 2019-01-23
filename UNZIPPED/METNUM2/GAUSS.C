#include <signal.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

#define  MAX_N		10		/* m xima dimens„o da matriz	*/

int n;					/* matriz de n por n+1		*/
float matriz[MAX_N][MAX_N+1];		/* matriz com equa‡”es		*/
float res[MAX_N];			/* resultados do sistema	*/



/*
	calcular o valor absoluto de 'v'
*/
float _abs_(float v)
{
    return ((v >= 0) ? v : -v);
}



/*
	ler valores para a matriz
*/
void ler_valores(void)
{
    int i, j;

    for(i=0; i!=n; i++){
	 for(j=0; j!=n+1; j++){
	      printf("%d : %c  ? ", i+1, ((j!=n) ? (j+97) : ('y')));
	      scanf("%f", &matriz[i][j]);
	 }
    }
}



/*
	escrever a matriz
*/
void escrever_matriz(void)
{
    int i, j;

    cprintf("\n\r");
    for(j=0; j!=n; j++){
	 for(i=0; i!=n+1; i++){
	      cprintf("%8.2f", matriz[j][i]);
	      if(i<n-1)
		   cprintf(" * x%d +", i+1);
	      else
		   if(i==n-1)
			cprintf(" * x%d =", i+1);
	 }
	 cprintf("\n\r");
    }
    getch();
}



void escrever_resultados(void)
{
    int i;

    cprintf("\n\rSolu‡”es\r\n");
    for(i=0; i!=n; i++)
	 cprintf("x%d = %-9.2f", i+1, res[i]);
}



/*
    Elimina‡„o de Gauss com pivotagem total.
*/
void Gauss(void)
{
    int g, i, k, c;
    float mul, maximo, temp;
    int indice;


    escrever_matriz();
    for(g=0; g!=n-1; g++){
	 indice = g;
	 maximo = _abs_(matriz[g][g]);
	 for(i=g+1; i!=n; i++){
	      if(_abs_(matriz[i][g]) > maximo){
		   maximo = _abs_(matriz[i][g]);
		   indice = i;
	      }
	 }

	 /* trocar linha 'indice' com linha 'g'*/
	 if(indice!=g){
	      for(c=0; c!=n+1; c++){
		   temp = matriz[g][c];
		   matriz[g][c] = matriz[indice][c];
		   matriz[indice][c] = temp;
	      }
	 }

	 /* calcular os multiplicadores */
	 for(i=1; i!=n-g; i++){
	      mul = -matriz[i+g][g] / matriz[g][g];
	      for(k=g; k!=n+1; k++)
		   matriz[g+i][k] = mul * matriz[g][k] + matriz[g+i][k];
	 }
         escrever_matriz();
    }

    /* obter as solu‡”es e guardar em 'r'*/
    for(i=0; i!=n; i++){
	 temp = matriz[n-i-1][n];
	 for(k=0; k!=i; k++)
	      temp = temp - matriz[n-i-1][n-k-1] * res[n-k-1];
	 res[n-i-1] = temp / matriz[n-i-1][n-i-1];
    }

    escrever_resultados();
}



/*
	caso seja detectada uma divis„o por zero o programa salta para esta rotina
*/
void divisao_por_zero(int subcode)
{
    cprintf("\n\rFoi detectada uma divis„o por zero. . .");
    cprintf("\n\r   ; o sistema ‚ imposs¡vel ou indeterminado");
    exit(subcode);
}



int main(void)
{
    cprintf("\n\rElimina‡„o de Gauss com pivotagem total\r\n");
    cprintf("ax1 + bx2 + cx3 + ... = y\r\n");

    do{						/* ler n		*/
	 cprintf("2 <= n <= 10       n = ? ");
	 scanf("%d", &n);
    }while(n<2 || n>10);

    ler_valores();				/* ler matriz		*/
    signal(SIGFPE, divisao_por_zero);		/* armadilhar sinal	*/
    Gauss();					/* resolver		*/

    return 0;
}
