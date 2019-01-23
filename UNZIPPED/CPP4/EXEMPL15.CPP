/*********************************************************************/
/*                     E X E M P L 1 5 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 4             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a utiliza‡„o de prot¢tipos - II      */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

inline void Escreve(char *, char, float);

int main()
{
	char * nome = "Xpto";
	int idade = 5;
	float altura = 0.94;

	Escreve("Bruce", 67, 1.63);
	Escreve(nome, idade, altura);

	return 0;
}

inline void Escreve(char *nome, char idade, float altura)
{
	cout << "O " << nome;
	cout << " tem " << (int)idade << " anos";
	cout << " e mede " << altura << " metros.\n";
}


