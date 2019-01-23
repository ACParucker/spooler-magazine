/*
O grau do polin¢mio dever  ser 2, 3 ou 4.
O n£mero de casas decimais dever  ser alto: 9, 10.
O erro estabiliza quando o polin¢mio ‚ quase ¢ptimo.
*/
#include "parser.h"
#include <signal.h>
#include <alloc.h>
#include <stdio.h>
#include <conio.h>
#include <string.h>
#include <stdlib.h>

int pr = 0;
FILE *fp = NULL;
float *x=NULL, *fx=NULL;
float *a, *b, *c, *d;
char **p;


void le_valores(int pontos)
{
    int i;

    x  = (float *)malloc(sizeof(float) * pontos);
    fx = (float *)malloc(sizeof(float) * pontos);

    a = (float *)malloc(sizeof(float) * pontos);
    b = (float *)malloc(sizeof(float) * pontos);
    c = (float *)malloc(sizeof(float) * pontos);
    d = (float *)malloc(sizeof(float) * pontos);

    for(i=0; i!=pontos; i++){
	 printf("x[%d] = ", i);
	 scanf("%f", &x[i]);
	 printf("fx[%d] = ", i);
	 scanf("%f", &fx[i]);
    }
}



void po(int pontos, int grau, int dec)
{
    int i, j;
    float numer, denom, v, a_denom=0, erro;
    char str[600], pol[600];

    clrscr();
    printf("\nPolin¢mios Ortogonais\n");
    printf("P(x) = d[0]*P[0](x) + d[1]*P[1](x) + ... +  d[k]*P[k](x)\n");

    if(pr)
	 printf("\nP[-1](x) = 0\n");

    p = malloc(200);
    p[0] = strdup("1");
    if(pr)
	 printf("\nP[0](x) = %s", p[0]);

    for(i=0; ; i++){
/* d */
	 if(pr){
	      printf("\nd[%d] = < fx * P[%d](x), P[%d](x) > / < P[%d](x), P[%d](x) >", i, i, i, i, i);
	      printf("\nd[%d] = < fx * %s, %s > / < %s, %s >", i, p[i], p[i], p[i], p[i]);
	 }
	 numer = denom = 0;
	 for(j=0; j!=pontos; j++){
	      v = parse(p[i], x[j]);
	      numer = numer + (fx[j] * v);
	      denom = denom + (v * v);
	 }
	 d[i] = numer / denom;
         if(pr)
	      printf("\nd[%d] = %.*f", i, dec, d[i]);
/* P(x) */
	 j = 0;
         if(pr)
	      printf("\nP(x) = ");
	 pol[0] = '\0';
	 while(j!=i+1){
              if(pr)
		   printf("%.*f*%s", dec, d[j], p[j]);
	      sprintf(str, "%.*f*%s", dec, d[j], p[j]);
	      strcat(pol, str);
	      if(j!=i){
                   if(pr)
			printf("+");
		   strcat(pol, "+");
	      }
	      j++;
	 }
	 erro = 0;
	 for(j=0; j!=pontos; j++){
	      v = parse(pol, x[j]);
	      erro = erro + fx[j] - v;
	 }
         if(pr)
	      printf("\nErro: %.*f*10^-6", dec, erro*1000000L);
	 getch();
	 if(i==grau)
	      break;
/* a */
	 a[i] = 1;
         if(pr)
	      printf("\na[%d] = %.1f", i, a[i]);
/* b */
	 if(pr){
	      printf("\nb[%d] = < x * P[%d](x), P[%d](x) > / < P[%d](x), P[%d](x) >", i, i, i, i, i);
	      printf("\nb[%d] = < x * %s, %s > / < %s, %s >", i, p[i], p[i], p[i], p[i]);
	 }
	 numer = denom = 0;
	 for(j=0; j!=pontos; j++){
	      v = parse(p[i], x[j]);
	      numer = numer + (x[j] * v * v);
	      denom = denom + (v * v);
	 }
	 b[i] = numer / denom;
         if(pr)
	      printf("\nb[%d] = %.*f", i, dec, b[i]);
/* c */
	 if(!i)
	      c[0] = 0;
	 else{
	      numer = a[i] * denom;
	      denom = a_denom * a[i-1];
	      c[i] = numer / denom;
	 }
	 a_denom = denom;
         if(pr)
	      printf("\nc[%d] = %.*f", i, dec, c[i]);
/* p */
	 if(!i){
	      /* simplificando */
	      sprintf(str, "(x-%.*f)", dec, b[i]);
	 }
	 else{
	      /* simplificando */
	      sprintf(str, "((x-%.*f)*%s-%.*f*", dec, b[i], p[i], dec, c[i]);
/*	      sprintf(str, "(%.0f*(x-%f)*%s-%f*", a[i], b[i], p[i], c[i]);*/
	      strcat(str, p[i-1]);
	      strcat(str, ")");
	 }
	 p[i+1] = strdup(str);
	 printf("\n");
	 printf("\nP[%d](x) = %s", i+1, p[i+1]);
    }

    fprintf(fp, "%s\n", pol);
    for(i=0; i!=pontos; i++)
	 fprintf(fp, "%f\t%f\n", x[i], fx[i]);
}




void fim()
{
    printf("\nOcorreu um erro durante o programa...");
    fclose(fp);
    exit(-1);
}



int main(int argc, char *argv[])
{
    int pontos;
    int grau;
    int dec;

    if(argc>1)
	 pr = 1;
    do{
	 printf("N£mero de pontos [2..]: ");
	 scanf("%d", &pontos);
    }while(pontos < 2);

    do{
	 printf("Grau do polin¢mio ortogonal [1..]: ");
	 scanf("%d", &grau);
    }while(grau < 1);

    printf("N£mero de casas decimais[0..]: ");
    scanf("%d", &dec);

    le_valores(pontos);

    signal(SIGFPE, fim);

    fp = fopen("RESUL.DAT", "wt");
    po(pontos, grau, dec);
    fclose(fp);

    return 0;
}
