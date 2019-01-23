/*********************************************************************/
/*                     E X E M P L 0 5 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 1             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a defeni‡„o de variaveis.            */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

int indice;

main()
{
	int i;
	int &i_sinon = i; 		// um sinonimo de i

	i = indice + 14;      	// indice foi inicializado a zero
	cout << "O valor de i ‚ " << i << "\n";
	i = 17;
	cout << "O valor de i_sinon ‚ " << i_sinon << "\n";

	int j = 13;        		// n„o ‚ autom ticamente inicializada a zero

	cout << "O valor de j ‚ " << j << "\n";

	for (int cont = 3; cont < 8; cont++) {
		cout << "O valor de count ‚ " << cont << "\n";
		char cont2 = cont + 65;
		cout << "O valor de count2 ‚ " << cont2 << "\n";
	}

	static unsigned k;    	// autom ticamente inicializada a zero

	cout << "O valor de k ‚ " << k << "\n";

	return 0;
}

