/*********************************************************************/
/*                     E X E M P L 0 2 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 1             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a utiliza‡„o do operador :: (scope)  */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

int indice = 13;                // variavel global

main()
{
	float indice = 3.1415;      // variavel local

	cout << "O valor de indice (local) ‚ " << indice << "\n";
	cout << "O valor de indice (global) ‚ " << ::indice << "\n";

	::indice = indice + 7;      // (int) 3.1415 + 7 = 10

	cout << "O valor de indice (local) ‚ " << indice << "\n";
	cout << "O valor de indice (global) ‚ " << ::indice << "\n";

	return 0;
}

