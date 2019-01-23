
#include "parser.h"
/*
Vari veis utilizadas:
'e'	representa o valor a ser utilizado no crit‚rio de paragem.
'f'	‚ um apontador para a fun‡„o que calcula o valor da express„o.
'f_d'	‚ um apontador para a fun‡„o derivada de 'f'.
'i'	acumula o n£mero de itera‡”es.
*/


#include <math.h>

#define  PI  M_PI



double _abs(double x)
{
    return ((x>=0.0) ? x : -x);
}




double bisseccao(double x1, double x2, double e, int *i, char *expr)
{
    double a, b, ym, y;

    *i = 0;
    a = parse(expr, x1);
    b = parse(expr, x2);
    if(a * b > 0)
	 return a-1;

    while(x2 - x1 > e){
	 ym = (x1 + x2) / 2;
	 y = parse(expr, ym);
	 if(
	     (y <= 0 && parse(expr, x1) < 0 && parse(expr, x2) > 0) ||
	     (y > 0 && parse(expr, x1) > 0 && parse(expr, x2) < 0)
	 )
	      x1 = ym;
	 else
	      x2 = ym;
	 (*i)++;
    }

    return ym;
}




double secante(double x1, double x2, double e, int *i, char *expr)
{
    double a, b, x3, x4, tmp;

    *i = 0;
    x3 = 0;
    do{
	 a = parse(expr, x1);
	 b = parse(expr, x2);
	 x4 = x3;
	 x3 = x2 - ((x1 - x2) * b / a) / (1 - b / a);
	 if(b < a){
	      tmp = x1;
	      x1 = x2;
	      x2 = tmp;
	 }

	 x1 = x2;
	 x2 = x3;
	 tmp = _abs(x3 - x4);
	 (*i)++;
    }while(tmp > e);

    return x3;
}




double newton(double x, double e, int *i, char *expr, char *expr_d)
{
    double a, b, tmp;

    *i = 0;
    do{
	 tmp = x;
	 a = parse(expr, x);
	 b = parse(expr_d, x);
	 x = x - a / b;
	 tmp = _abs((x - tmp) / x);
	 (*i)++;
    }while(tmp > e);

    return x;
}




double muller(double x1, double x3, double x2, double e, int *i, char *expr)
{
    double x11, x22, x33, l, d, g, c, t, r, d1, d2, x4, t1, t2, n;

    *i = 0;
    x4 = x3;
    for(;;){
	 x11 = parse(expr, x1);
	 x33 = parse(expr, x3);
	 if(_abs(x33) < e)
	      return x4;
	 x22 = parse(expr, x2);
	 l = (x3 - x2) / (x2 - x1);
	 d = (x3 - x1) / (x2 - x1);
	 g = l * l * x11 - d * d * x22 + (l + d) * x33;
	 c = l * (l * x11 - d * x22 + x33);

	 n = (-2 * d * x33);			/* numerador		*/
	 r = sqrt(g*g - 4 * d * c * x33);	/* raiz			*/
	 d1 = g + r;				/* denominador 1	*/
	 d2 = g - r;				/* denominador 2	*/
	 t1 = _abs(n / d1);			/* valor absoluto 1	*/
	 t2 = _abs(n / d2);			/* valor absoluto 2	*/
	 t = ((t1 >= t2) ? n / d2 : n / d1);	/* escolher o menor	*/
	 x4 = x3 + t * (x3 - x2);		/* utiliz -lo para x4	*/
	 x1 = x2;
	 x2 = x3;
	 x3 = x4;
	 (*i)++;
    }
}




#include <ctype.h>
#include <stdio.h>


void main(void)
{
    int i, a, b;
    double r;
    float erro;
    char m, expr[100], expr_d[100], te[2];

    printf("\nDetermina‡„o de zeros de fun‡”es n„o lineares\n");
    do{
	 printf("M‚todo ([B]issec‡„o, [S]ecante, [M]uller, [N]ewton) = ");
	 scanf("%s", &te);
	 m = toupper(te[0]);
    }while(m!='B' && m!='N' && m!='M' && m!='S');

    fflush(stdin);
    printf("f(x) = ");
    gets(expr);
    if(m=='N'){
	 printf("f'(x) = ");
	 gets(expr_d);
    }

    switch(m){
	 case 'B':
	      printf("a = ");
	      scanf("%d", &a);
	      printf("b = ");
	      scanf("%d", &b);
	      printf("erro < ");
	      scanf("%f", &erro);
	      r = bisseccao(a, b, erro, &i, expr);
	      break;
	 case 'S':
	      printf("a = ");
	      scanf("%d", &a);
	      printf("b = ");
	      scanf("%d", &b);
	      printf("erro < ");
	      scanf("%f", &erro);
	      r = secante(a, b, erro, &i, expr);
	      break;
	case 'N':
	      printf("a = ");
	      scanf("%d", &a);
	      printf("erro < ");
	      scanf("%f", &erro);
	      r = newton(a, erro, &i, expr, expr_d);
	      break;
	case 'M':
	      printf("a = ");
	      scanf("%d", &a);
	      printf("b = ");
	      scanf("%d", &b);
	      printf("erro < ");
	      scanf("%f", &erro);
	      r = muller(a, (b + a) / 2, b, erro, &i, expr);
    }

    if(parse(expr, r) == 0)
	 printf("\nf(%f) = 0,  em %d itera‡”es", r, i);
    else
	 printf("\nAo fim de %d itera‡”es, o zero n„o foi encontrado...", i);
}
