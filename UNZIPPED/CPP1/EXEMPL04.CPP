/*********************************************************************/
/*                     E X E M P L 0 4 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 1             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a utiliza‡„o de streams em ficheiros */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>
#include <fstream.h>
#include <process.h>

main()
{
	ifstream entrada;
	ofstream saida;
	ofstream impressora;
	char nome_fich[20];

	cout << "Introduza o nome do ficheiro a copiar ----> ";
	cin >> nome_fich;

	entrada.open(nome_fich, ios::nocreate);
	if (!entrada) {
		cout << "N„o consegui abrir o ficheiro pretendido.\n";
		return 1;
	}

	saida.open("copia");
	if (!saida) {
		cout << "Incapaz de abrir o ficheiro de saida.\n";
		return 1;
	}

	impressora.open("PRN");
	if (!impressora) {
		cout << "A impressora n„o est  OK, verifique e tente novamente.\n";
		return 1;
	}

	cout << "Todos os trˆs ficheiros foram abertos.\n";

	char um_char;

	impressora << "Isto ‚ o inicio da c¢pia impressa.\n\n";

	while (entrada.get(um_char)) {
		saida.put(um_char);
		impressora.put(um_char);
	}

	impressora << "\n\nIsto ‚ o fim da c¢pia impressa.\n";

	entrada.close();
	saida.close();
	impressora.close();

	return 0;
}

