/*********************************************************************/
/*                     E X E M P L 1 1 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 3             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra formas de utiliza‡„o de ponteiros    */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include "iostream.h"

main()
{
	int * ip;							// define um ponteiro para int
	float * fp;							// define um ponteiro para float
	void * p;							// define um ponteiro tipo gen‚rico

	int a = 227, b = -74;				// define dois inteiros
	float x = 5.355, y = 3.14;			// define dois floats

	const char *nome1 = "Spooler";		// a string "Spooler" n„o pode ser alterada
	char *const nome2 = "Spooler";  	// o ponteiro "nome2" n„o pode ser alterado

	ip = &a;							// faz "ip" apontar para a var. "a"
	*ip += b;							// soma a "a" o valor de "b"
	cout << "  a = " << a << "\n";		// mostra o valor de "a"
	cout << "*ip = " << *ip << "\n";	// mostra o valor de "a" via "ip"
	p = ip;								// coloca "p" a apontar tambem para "a"

	fp = &x;							// faz "fp" apontar para a var. "x"
	y += 5 * (*fp);						// i.e. "y += 5 * x"
	cout << "y = " << y << "\n";		// mostra o conteudo de "y"
	p = fp;								// coloca "p" a apontar tambem para "x"

	return 0;							// rotoma o valor 0 para o SO
}
