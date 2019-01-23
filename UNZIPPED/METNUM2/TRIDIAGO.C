/*
	Exemplo (n=4)

	Sistema tridiagonal
	5*x1 + 4*x2,                 = 25
	4*x1 - 3*x2 + 7*x3           =  3
		 x2 - 6*x3 + 4*x4    = 17
		     12*x3 + 2*x4    = 36

	Solu‡”es:
	     x1 = 1
	     x2 = 5
	     x3 = 2
	     x4 = 6
*/

#include <conio.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>


#define  MAX_N		10		/* m xima dimens„o da matriz	*/

int n;					/* matriz de n por n+1		*/
float matriz[MAX_N][MAX_N+1];		/* matriz com equa‡”es		*/
float res[MAX_N];			/* resultados do sistema	*/





/*
	ler valores para a matriz
*/
void ler_valores(void)
{
    int i, j, m, k, d;
    char s[] = {"ldu"};

    d=0;
    for(i=0; i!=n; i++){
	 if(i==0){
	      m = 2;
	      k = 1;
	 }
	 else{
	      if(i==n-1){
		   m = 2;
		   k = 0;
	      }
	      else{
		   m = 3;
		   k = 0;
	      }
	 }
	 if(i>=2)
	      d++;
	 for(j=0; j!=m; j++){
	      printf("%c%d x%d  ? ", s[k++], i+1, j+1+d);
	      scanf("%f", &matriz[i][j+d]);
	 }

	 printf("b%d ? ", i+1);
	 scanf("%f", &matriz[i][n]);
    }
}



/*
	escrever a matriz
*/
void escrever_matriz(void)
{
    int i, j, m, d;

    d=0;
    cprintf("\n\r");
    for(j=0; j!=n; j++){
	 if(j==0 || j==n-1)
	      m = 2;
	 else
	      m = 3;
	 if(j>=2)
	      d++;
	 for(i=0; i!=m; i++){
	      cprintf("%8.2f", matriz[j][i+d]);
	      if(i<m-1)
		   cprintf(" * x%d +", i+1+d);
	      else
		   if(i==m-1)
			cprintf(" * x%d =", i+1+d);
	 }
	 cprintf("%6.2f\n\r", matriz[j][n]);
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



void tridiagonal(void)
{
    int i;
    float mul;

    escrever_matriz();
    /* tapa 1	*/
    for(i=0; i!=n-1; i++){
	 mul = -matriz[i+1][i] / matriz[i][i];	/* multiplicador	*/
	 matriz[i+1][i+1] += (mul * matriz[i][i+1]);
	 matriz[i+1][n] += (mul * matriz[i][n]);
         escrever_matriz();
    }

    /* tapa 2	*/
    res[n-1] = matriz[n-1][n] / matriz[n-1][n-1];

    /* tapa 3	*/
    for(i=n-2; i>=0; i--)
	 res[i] = (matriz[i][n] - matriz[i][i+1] * res[i+1]) / matriz[i][i];

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
    cprintf("\n\rSistemas tridiagonais\r\n");
    cprintf("d1x1 + u1x2                                               = b1\r\n");
    cprintf("l2x1 + d2x2 + u2x3                                        = b2\r\n");
    cprintf("       l3x2 + d3x3 + u3x4                                 = b3\r\n");
    cprintf("......\r\n");
    cprintf("              l(n-1)x(n-2) + d(n-1)x(n-1) + u(n-1)x(n)    = b(n-1)\r\n");
    cprintf("                     l(n)x(n-1) + d(n)x(n)                = b(n)\r\n");

    do{						/* ler n		*/
	 cprintf("2 <= n <= 10       n = ? ");
	 scanf("%d", &n);
    }while(n<2 || n>10);

    ler_valores();				/* ler matriz		*/
    signal(SIGFPE, divisao_por_zero);		/* armadilhar sinal	*/
    tridiagonal();				/* resolver sistema	*/

    return 0;
}