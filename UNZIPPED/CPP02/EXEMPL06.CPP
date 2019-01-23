/*********************************************************************/
/*                     E X E M P L 0 6 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 2             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra‡„o de tipos enumerados em C++.       */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

// declara a enumera‡„o e demonstra as 3 formas
// possiveis de declarar uma variavel deste tipo
enum dia_semana {SEG, TER, QUA, QUI, SEX, SAB, DOM} dia;
enum dia_semana a;
dia_semana b;

main()
{
	for (dia = SEG; dia <= DOM; dia++) {
		cout << "\nHoje ‚ ";
		switch (dia) {
			case SEG: cout << "Segunda"; break;
			case TER: cout << "Ter‡a";   break;
			case QUA: cout << "Quarta";  break;
			case QUI: cout << "Quinta";  break;
			case SEX: cout << "Sexta";   break;
			case SAB: cout << "S bado";  break;
			case DOM: cout << "Domingo";
		}
		if ((dia != SAB) && (dia != DOM)) {
			cout << "-Feira";
		}
	}

	return 0;
}
