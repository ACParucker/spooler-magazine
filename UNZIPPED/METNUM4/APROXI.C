#include <alloc.h>
#include <stdio.h>

int pontos;		/* n£mero de pontos	*/
float decimais;		/* casas decimais	*/
int dec;
float *x;		/* valores de x		*/
float *fx;		/* valores de f(x)	*/


FILE *fp = NULL;

/*
M‚todo de aproxima‡„o Newton. Diferen‡as divididas.
*/
void newton(void)
{
    float tam_dd, *fxx, *dd;
    int i, h, g, p;

    printf("\nM‚todo de Newton");
    printf("\n-------------------------------------------------------------------------------");
    printf("\nf(x) = f(x0) + (x-x0)[x0, x1] + (x-x0)(x-x1)[x0, x1, x2] + ... + (x-x0)...(x-x(n-1))[x0, x1,...xn] + Rn(x)\n");
    p = pontos - 1;
    fxx = malloc(sizeof(float) * pontos);

    tam_dd = (float)p * (1.0 + p) / 2.0;
    dd = malloc(sizeof(float) * (int)tam_dd);

    fxx[0] = fx[0];
    for(h=g=0; g!=p; g++){
	 for(i=0; i!=p-g; i++){
	      dd[h] = (fx[i] - fx[i+1]) / (x[i] - x[i+1+g]);
	      fx[i] = dd[h++];
	 }
	 fxx[g+1] = dd[h-i];
    }


    printf("\nf(x) = %.*f +", dec, fxx[0]);
    for(g=0; g!=p; g++){
	 for(i=0; i!=g+1; i++){
	      printf(" (x - %.*f) *", dec, x[i]);
	      fprintf(fp, "(x-%.*f)*", dec, x[i]);
	 }
	 printf(" %.*f +", dec, fxx[g+1]);
	 fprintf(fp, "%.*f+", dec, fxx[g+1]);
    }
    fprintf(fp, "%.*f\n", dec, fxx[0]);

    printf(" R(x)");

    free((float *)dd);
    free((float *)fxx);
}



/*
Polin¢mio de Lagrange.
*/
void lagrange(void)
{
    int i, j;
    float *prod;

    printf("\nM‚todo de Lagrange");
    printf("\n-------------------------------------------------------------------------------");
    printf("\nPn(x) = L0(x) * f(x0) + L1(x) * f(x1) + ... + Ln(x) * f(xn)\n");
    prod = malloc(sizeof(float) * (pontos + 1));
    for(i=0; i!=pontos; i++){
	 printf("\nL%d = ", i);
	 for(j=0; j!=pontos; j++)
	      if(j!=i){
		   printf("(x - %.*f)", dec, x[j]);
		   fprintf(fp, "(x-%.*f)*", dec, x[j]);
	      }

	 prod[i] = 1.0;
	 for(j=0; j!=pontos; j++)
	      if(j!=i)
		   prod[i] = prod[i] * (x[i] - x[j]);
	 fprintf(fp, "%.*f+", dec, fx[i] / prod[i]);

    }

    fprintf(fp, "0\n");

    printf("\n\nP%d(x) = ", pontos-1);
    for(i=0; i!=pontos; i++){
	 printf("L%d * ", i);
	 printf("(%.*f)", dec, fx[i] / prod[i]);
	 if(i!=pontos-1)
	      printf(" + ");
    }

    free((float *)prod);

    for(i=0; i!=pontos; i++)
	 fprintf(fp, "%f\t%f\n", x[i], fx[i]);
}




/*
Fun‡„o auxiliar.
*/
void ler_valores(void)
{
    int i;

    printf("\nIntrodu‡„o de valores:\n");
    for(i=0; i!=pontos; i++){
	 printf("x[%d] = ", i);
	 scanf("%f", &x[i]);
	 printf("fx[%d] = ", i);
	 scanf("%f", &fx[i]);
    }
}



/*
Fun‡„o principal.
*/
int main(void)
{
    printf("\nAproxima‡„o num‚rica de fun‡”es\n");

    do{
	 printf("Quantos pontos [2...] ? ");
	 scanf("%d", &pontos);
    }while(pontos < 2);

    x  = malloc(sizeof(float) * pontos);
    fx = malloc(sizeof(float) * pontos);

    ler_valores();

    printf("\n");

    do{
	 printf("N£mero de casas decimais … sa¡da [1-15] ? ");
	 scanf("%f", &decimais);
    }while(decimais < 1 || decimais > 15);

    dec = decimais;
    printf("\n");

    fp = fopen("RESUL.DAT", "wt");

    lagrange();

    printf("\n\n\n");

    newton();

    fclose(fp);

    return 0;
}