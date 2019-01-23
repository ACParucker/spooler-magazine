/*********************************************************************/
/*                     E X E M P L 1 6 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 4             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a passagem de parƒmetros por         */
/*                    referˆncia para fun‡”es.                       */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

void Troca(int &a, int &b);

int main()
{
	int a = 7, b = 12;

	cout << "Os valores de A e B s„o: " << a << " e " << b << "\n";

	Troca(a, b);			// 	Troca(&a, &b);

	cout << "Os novos valores de A e B s„o: " << a << " e " << b << "\n";

	return 0;
}

void Troca(int &a, int &b)	// 	void Troca(int *a, int *b)
{							// 	{
	int c = a;              // 		int c = *a;
	a = b;                  //		*a = *b;
	b = c;                  //		*b = c;
}                           //	}

