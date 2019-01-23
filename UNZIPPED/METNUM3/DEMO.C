#include "matrix.h"
#include <ctype.h>
#include <stdio.h>


void escrever_matriz(Matrix *m)
{
    int r, c;

    printf("\nMatriz [%2d, %2d]", m->rows, m->cols);
    for(r=0; r!=m->rows; r++){
	 printf("\n");
	 for(c=0; c!=m->cols; c++)
	      printf("%9.4f", m->matrix[r][c]);
    }
}


void ler_matriz(Matrix *m)
{
    int r, c;

    printf("\nIntroduza a matriz\n");
    for(r=0; r!=m->rows; r++)
	 for(c=0; c!=m->cols; c++){
	      printf("m[%2d,%2d]: ", r, c);
	      scanf("%f", &m->matrix[r][c]);
	 }
}



int main(void)
{
    Matrix *a=NULL, *b=NULL, *c=NULL;
    float v;
    char opcao;
    int m, n, erro;

    printf("\nOpera‡”es com matrizes\nH- para ajuda");
    do{
	 printf("\n\nA, B, *, +, -, T, K, D, Q, H > ");
	 fflush(stdin);
	 scanf("%c", &opcao);
	 opcao = toupper(opcao);
	 switch(opcao){
	      case 'A' :
		   if(a!=NULL)
			del_matrix(a);
		   printf("\nMatriz A[m, n]\nm = ");
		   scanf("%d", &m);
		   printf("n = ");
		   scanf("%d", &n);
		   a = new_matrix(m, n);
		   ler_matriz(a);
		   break;
	      case 'B' :
		   if(b!=NULL)
			del_matrix(b);
		   printf("\nMatriz B[m, n]\nm = ");
		   scanf("%d", &m);
		   printf("n = ");
		   scanf("%d", &n);
		   b = new_matrix(m, n);
		   ler_matriz(b);
		   break;
	      case '*' :
		   if(a->rows != b->cols){
			printf("\nImposs¡vel");
			break;
		   }
		   c = new_matrix(a->rows, b->cols);
		   init_matrix(c, 0);
		   mul_matrix(a, b, c);
		   escrever_matriz(c);
		   del_matrix(c);
		   break;
	      case '+' :
		   if(a->rows != b->cols){
			printf("\nImposs¡vel");
			break;
		   }
		   c = add_matrix(a, b);
		   if(c==NULL){
			printf("\nImposs¡vel");
			break;
		   }
		   escrever_matriz(c);
		   del_matrix(c);
		   break;
	      case '-' :
		   if(a->rows != b->cols){
			printf("\nImposs¡vel");
			break;
		   }
		   c = sub_matrix(a, b);
		   if(c==NULL){
			printf("\nImposs¡vel");
			break;
		   }
		   escrever_matriz(c);
		   del_matrix(c);
		   break;
	      case 'T' :
		   c = tran_matrix(a);
		   if(c==NULL){
			printf("\nImposs¡vel");
			break;
		   }
		   escrever_matriz(c);
		   del_matrix(c);
		   break;
	      case 'K' :
		   printf("\nMultiplicar A por: ");
		   scanf("%f", &v);
		   kmul_matrix(a, v);
		   escrever_matriz(a);
		   break;
	      case 'D' :
		   printf("\nDeterminante A = ");
		   erro = deter_matrix(a, &v);
		   if(erro){
			printf("\nImposs¡vel");
			break;
		   }
		   printf("%f", v);
		   break;
	      case 'H' :
		   printf("\nA >>¯  definir matriz A");
		   printf("\nB >>¯  definir matriz B");
		   printf("\n* >>¯  A * B");
		   printf("\n+ >>¯  A + B");
		   printf("\n- >>¯  A - B");
		   printf("\nT >>¯  transposta de A");
		   printf("\nK >>¯  multiplicar A por uma constante");
		   printf("\nD >>¯  determinante de A");
		   printf("\nQ >>¯  sair do programa");
	 }
    }while(opcao!='Q');

    return 0;
}