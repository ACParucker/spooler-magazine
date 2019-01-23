/*********************************************************************/
/*                     E X E M P L 0 3 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 1             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a utiliza‡„o das streams cin e cout  */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>
#include <string.h>

main()
{
	int indice;
	float distancia;
	char letra;
	char nome[25];

	indice = -23;
	distancia = 12.345;
	letra = 'X';
	strcpy(nome,"Spooler Magazine");

	cout << "O valor de indice ‚ "    << indice    << "\n";
	cout << "O valor de distancia ‚ " << distancia << "\n";
	cout << "O valor de letra ‚ "     << letra     << "\n";
	cout << "O valor de nome ‚ "      << nome      << "\n";

	indice = 31;
	cout << "O valor decimal de indice ‚ " << dec << indice << "\n";
	cout << "O valor octal de indice ‚ " << oct << indice << "\n";
	cout << "O valor hexadecimal de indice ‚ " << hex << indice << "\n";
	cout << "O valor de letra ‚ o car cter " << (char)letra << "\n";
	cout << "O valor de distancia ‚ " << distancia << "\n";
	cout << "Viva, isto ‚ C++" << "\n";

	cout << "Agora introduza um valor decimal --> ";
	cin  >> indice;
	cout << "O valor introduzido em hexadecimal ‚ " << indice << "\n";

	return 0;
}

