/*********************************************************************/
/*                     E X E M P L 1 4 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 4             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a utilizal„o de prot¢tipos - I       */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

void Escreve(char *nome, int idade, float altura);

int main()
{
	char * nome = "Z‚ Manel";
	int idade = 25;
	float altura = 1.74;

	Escreve("Xico", 27, 1.82);
	Escreve(nome, idade, altura);

	return 0;
}

void Escreve(char *nome, int idade, float altura)
{
	cout << "O " << nome;
	cout << " tem " << idade << " anos";
	cout << " e mede " << altura << " metros.\n";
}
