/*********************************************************************/
/*                     E X E M P L 1 3 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 3             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a utiliz. de ponteiros para fun‡”es  */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

void PrintDec(int val);				// prot¢tipo da fun‡„o PrintDec
void PrintHex(int val);				// prot¢tipo da fun‡„o PrintHex
void PrintOct(int val);             // prot¢tipo da fun‡„o PrintOct

main()
{
	void (*Print)(int) = NULL;		// declara e inicializa o ponteiro para
									// fun‡„o com o valor NULL

	// loop para garantir que o utilizador introduz o input pretendido
	do {
		cout << "Base de n£mera‡„o: (D)ecimal, (H)exadecimal ou (O)ctal ? ";
		char c;						// declara um char
		cin >> c;					// lˆ um char da stream cin

		// de acordo com o input fornecido pelo utilizador, afecta o
		// ponteiro para fun‡„o de modo a reflectir a escolha do utilizador
		// claro, se o utilizador introduzir um input inv lido este ponteiro
		// continuar  com o valor NULL, obrigando o utilizador a introduzir
		// um valor correcto
		switch (c) {
			case 'D': case 'd': Print = PrintDec; break;
			case 'H': case 'h': Print = PrintHex; break;
			case 'O': case 'o': Print = PrintOct; break;
		}
	} while (Print == NULL);	// i.e. enquanto o input for inv lido

	// escreve varios valores na base de numera‡„o escolhida, utilizando
	// um ponteiro para fun‡„o
	Print(123);
	Print(23);
	Print(30123);
	Print(16);

	return 0;			// retoma 0 para o SO
}

void PrintDec(int val)			// escreve o parƒmetro val em decimal
{
	cout.setf(ios::dec);		// for‡a o output de n£meros em decimal
	cout << val << "\n";		// escreve o valor e muda de linha
}

void PrintHex(int val)          // escreve o parƒmetro val em hexadecimal
{
	cout.setf(ios::hex);        // for‡a o output de n£meros em hexadecimal
	cout << "0x" << val << "\n";// escreve o valor e muda de linha
}

void PrintOct(int val)          // escreve o parƒmetro val em octal
{
	cout.setf(ios::oct);		// for‡a o output de n£meros em octal
	cout << "0" << val << "\n"; // escreve o valor e muda de linha
}
