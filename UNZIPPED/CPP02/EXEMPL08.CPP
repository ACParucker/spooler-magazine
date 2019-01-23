/*********************************************************************/
/*                     E X E M P L 0 8 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 2             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra o uso de classes em C++.             */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

// declara‡„o de uma classe, como se pode ver,
// muito semelhante … de uma estrutura
class animal {
public:
	int peso;
	int altura;
};

main()
{
	// algumas das formas de declarar objectos deste tipo de classe
	animal cao1, cao2, gato;
	animal rato1;
	class animal rato2;

	cao1.peso = 15;
	cao2.peso = 37;
	gato.peso = 3;
	cao1.altura = 40;
	cao2.altura = 60;
	gato.altura = 25;

	cout << "O peso do cao1 ‚ " << cao1.peso << "\n";
	cout << "O peso do cao2 ‚ " << cao2.peso << "\n";
	cout << "O peso do gato ‚ " << gato.peso << "\n";

	return 0;
}
