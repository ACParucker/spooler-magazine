/*
Estrutura duma matriz.
*/
typedef struct{
    int		rows;			/* n£mero de linhas	  */
    int		cols;			/* n£mero de colunas	  */
    float	**matrix;		/* coeficientes da matriz */
}Matrix;





Matrix *	new_matrix		(int m, int n);
void		init_matrix		(Matrix *m, float value);

void		del_matrix		(Matrix *m);

Matrix *	tran_matrix		(Matrix *m);
Matrix *	mul_matrix		(Matrix *a, Matrix *b, Matrix *m);

Matrix *	kmul_matrix		(Matrix *m, float val);
Matrix *	add_matrix		(Matrix *m1, Matrix *m2);
Matrix *	sub_matrix		(Matrix *m1, Matrix *m2);

int		deter_matrix		(Matrix *m, float *deter);

Matrix *	dup_matrix		(Matrix *m);
