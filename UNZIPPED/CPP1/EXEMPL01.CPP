/*********************************************************************/
/*                     E X E M P L 0 1 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 1             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra algumas das novas capacidades do C++ */
/*                    em rela‡„o … linguagem C                       */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>           /* include com a defeni‡„o das streams */

void escreve(const int valor);  // prot¢tipo, obrigat¢rio em C++

main()
{
	const int INICIO = 3;       // const indica que INICIO n„o pode ser alterado
	const int FIM = 9;          // o mesmo se passa com FIM

	int indice;                 /* Esta ‚ uma variavel normal do tipo inteiro */

	for (indice = INICIO; indice < FIM; indice++)       // um ciclo normal
		escreve(indice);

	return 0;
}

void escreve(const int valor)
{
	cout << "O valor de indice ‚  " << valor << "\n";
}
