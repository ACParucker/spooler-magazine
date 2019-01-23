/*********************************************************************/
/*                     E X E M P L 0 9 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 2             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra o uso de uni”es ®livres¯ em C++.     */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

main()
{
	// declara a uni„o ®livre¯
	union {
		unsigned int w;
		unsigned char b[2];
	};

	cout << "Introduza um n£mero inteiro de 16 bits (0..65535): ";
	cin >> w;

	cout << "\n\n";
	cout << "O n£mero introduzido foi: " << w << "\n";
	cout << "A sua parte menos significativa ‚: " << (int)b[0] << "\n";
	cout << "A sua parte mais significativa ‚ : " << (int)b[1] << "\n";

	return 0;
}
