#include "matrix.h"
#include <alloc.h>
#include <mem.h>


/*
Criar uma matriz de dimens„o (m, n).
*/
Matrix *new_matrix(int m, int n)
{
    Matrix *mat;
    int i;

    mat = (Matrix *)malloc(sizeof(Matrix));
    if(mat==NULL)
	 return NULL;

    mat->rows = m;
    mat->cols = n;
    mat->matrix = malloc(m * sizeof(char *));
    if(mat->matrix==NULL)
	 return NULL;

    for(i=0; i!=m; i++){
	 mat->matrix[i] = malloc(sizeof(float) * n);
	 if(mat->matrix[i]==NULL)
	      return NULL;
    }

    return mat;
}



/*
Libertar o espa‡o ocupado por uma matriz.
*/
void del_matrix(Matrix *m)
{
    free(m->matrix);
    free((Matrix *)m);
}



/*
Inicializar a todos os termos da matriz com um valor espec¡fico.
*/
void init_matrix(Matrix *m, float value)
{
    int c, r;

    for(r=0; r!=m->rows; r++)
	 for(c=0; c!=m->cols; c++)
	      m->matrix[r][c] = value;
}


/*
Transposta duma matriz
Exemplo:
Ú        ¿t   Ú             ¿
³a11  a12³  = ³a11  a21  a31³
³a21  a22³    ³a12  a22  a32³
³a31  a32³    À             Ù
À        Ù
(3, 2)        (2, 3)
A transposta duma matriz (n, m) ‚ da forma (m, n).
*/
Matrix *tran_matrix(Matrix *m)
{
    Matrix *t;
    int c, r;

    t = new_matrix(m->cols, m->rows);
    if(t==NULL)
	 return NULL;

    for(c=0; c!=m->cols; c++)
	 for(r=0; r!=m->rows; r++)
	      t->matrix[c][r] = m->matrix[r][c];

    return t;
}



/*
Multiplica‡„o de matrizes
Exemplo:
Ú        ¿   Ú        ¿   Ú	                           ¿
³a11  a12³ * ³b11  b12³ = ³a11*b11+a12*b21  a11*b12+a12*b22³
³a21  a22³   ³b21  b22³   ³a21*b11+a22*b21  a21*b12+a22*b22³
³a31  a32³   À        Ù   ³a31*b11+a32*b21  a31*b12+a32*b22³
À        Ù                À                                Ù
(3, 2)       (2, 2)      (3, 2)
(ma, na)     (mb, nb)    (ma, nb) se na = mb, isto ‚, a matriz resultante
tem dimens„o (ma, nb) e a multiplica‡„o s¢ ‚ poss¡vel se na = mb.
O resultado da multiplica‡„o ‚ somado ao valor da matriz 'm'. Caso n„o seja
o desejado podemos trocar a linha de c¢digo da fun‡„o que est  sob a forma de
coment rio com a imediantamente acima.
*/
Matrix *mul_matrix(Matrix *a, Matrix *b, Matrix *m)
{
    int c, r, i;
    float sum;

    for(r=0; r!=a->rows; r++){
	 for(c=0; c!=b->cols; c++){
	      sum = m->matrix[r][c];
/*	      sum = 0;*/
	      for(i=0; i!=a->cols; i++)
		   sum += (a->matrix[r][i] * b->matrix[i][c]);

	      m->matrix[r][c] = sum;
	 }
    }

    return m;
}



/*
Multiplicar todos os coeficientes duma matrix por uma constante.
*/
Matrix *kmul_matrix(Matrix *m, float val)
{
    int c, r;

    for(c=0; c!=m->cols; c++)
	 for(r=0; r!=m->rows; r++)
	      m->matrix[c][r] = m->matrix[c][r] * val;

    return m;
}



/*
Duplicar uma matriz.
*/
Matrix *dup_matrix(Matrix *m)
{
    Matrix *new;
    int r, c;

    new = new_matrix(m->rows, m->cols);
    for(r=0; r!=m->rows; r++)
	 for(c=0; c!=m->cols; c++)
	      new->matrix[r][c] = m->matrix[r][c];

    return new;
}



/*
Somar duas matrizes. S¢ pode ser feito se as matrizes tiverem a mesma dimens„o.
*/
Matrix *add_matrix(Matrix *m1, Matrix *m2)
{
    Matrix *new;
    int r, c;

    if(m1->cols != m2->cols || m1->rows != m2->rows)
	 return NULL;

    new = new_matrix(m1->rows, m1->cols);
    for(r=0; r!=m1->rows; r++)
	 for(c=0; c!=m1->cols; c++)
	      new->matrix[r][c] = m1->matrix[r][c] + m2->matrix[r][c];

    return new;
}



/*
Subtrair duas matrizes (m1 - m2). S¢ pode ser feito se as matrizes tiverem a
mesma dimens„o.
*/
Matrix *sub_matrix(Matrix *m1, Matrix *m2)
{
    Matrix *new;
    int r, c;

    if(m1->cols != m2->cols || m1->rows != m2->rows)
	 return NULL;

    new = new_matrix(m1->rows, m1->cols);
    for(r=0; r!=m1->rows; r++)
	 for(c=0; c!=m1->cols; c++)
	      new->matrix[r][c] = m1->matrix[r][c] - m2->matrix[r][c];

    return new;
}



/*
Calcular o determinate duma matriz.
O determinante s¢ pode ser calculado em matrizes quadradas (m, n) em que m = n.
O c lculo consiste em reduzir a matriz pelo m‚todo de Gauss e seguidamente
aplicar a f¢rmula: Deter = -1^(n£mero de trocas de linhas) * produt¢rio dos
coeficientes diagonais (m[i, i]).
Para isso vamos adaptar o algoritmo anterior da elimina‡„o de Gauss por forma
a retornar o n£mero de trocas de linhas e receber como parƒmetro uma matriz e
o 'n'.
*/
float _abs_(float v)
{
    return ((v >= 0) ? v : -v);
}



int Gauss(Matrix *m, int n)
{
    int g, i, k, c;
    float mul, maximo, temp;
    int indice, ch;


    ch = 0;
    for(g=0; g!=n-1; g++){
	 indice = g;
	 maximo = _abs_(m->matrix[g][g]);
	 for(i=g+1; i!=n; i++){
	      if(_abs_(m->matrix[i][g]) > maximo){
		   maximo = _abs_(m->matrix[i][g]);
		   indice = i;
	      }
	 }

	 if(indice!=g){
	      ch++;
	      for(c=0; c!=n+1; c++){
		   temp = m->matrix[g][c];
		   m->matrix[g][c] = m->matrix[indice][c];
		   m->matrix[indice][c] = temp;
	      }
	 }

	 for(i=1; i!=n-g; i++){
	      mul = -m->matrix[i+g][g] / m->matrix[g][g];
	      for(k=g; k!=n+1; k++)
		   m->matrix[g+i][k] = mul * m->matrix[g][k] + m->matrix[g+i][k];
	 }
    }

    return ch;
}



int deter_matrix(Matrix *m, float *deter)
{
    Matrix *aux;
    int ch, c;

    if(m->cols != m->rows)
	 return -1;

    aux = dup_matrix(m);
    ch = Gauss(aux, aux->cols);

    if(ch%2)
	 *deter = -1;
    else
	 *deter = 1;

    for(c=0; c!=aux->cols; c++)
	 *deter = *deter * aux->matrix[c][c];

    del_matrix(aux);

    return 0;
}
