/*********************************************************************/
/*                     E X E M P L 1 7 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 4             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a util. de parƒmetros por ¢miss„o    */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>


void iva(int valor, int percentagem = 17);

int main()
{
	iva(100);
	iva(200, 8);
	iva(50, 35);

	return 0;
}

void iva(int valor, int percentagem)
{
	int pvp = (valor * percentagem) / 100 + valor;

	cout << "Pre‡o base = " << valor << "$00";
	cout << "\tP.V.P. = " << pvp << "$00";
	cout << "   \tIVA = " << percentagem << "%";
	cout << "\n";
}
