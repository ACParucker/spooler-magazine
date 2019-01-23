/*********************************************************************/
/*                     E X E M P L 0 7 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 2             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra o uso de estruturas em C++.          */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

// declara‡„o da estrutura animal
struct animal {
	int peso;
	int altura;
};

main()
{
	// algumas das formas de declarar variaveis deste tipo
	animal cao1, gato;
	animal rato = {3, 5};
	struct animal cao2;

	cao1.peso = 15;
	cao2.peso = 37;
	gato.peso = 5;
	cao1.altura = 40;
	cao2.altura = 60;
	gato.altura = 25;

	cout << "O peso do cao1 ‚ " << cao1.peso << "\n";
	cout << "O peso do cao2 ‚ " << cao2.peso << "\n";
	cout << "O peso do gato ‚ " << gato.peso << "\n";
	cout << "O peso do rato ‚ " << rato.peso << "\n";

	return 0;
}
