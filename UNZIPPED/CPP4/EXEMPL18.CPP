/*********************************************************************/
/*                     E X E M P L 1 8 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 4             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra o "overload" de fun‡”es              */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

void Print(int val);
void Print(double val);
void Print(char ch);

int main()
{
	Print(1234);
	Print(13.345);
	Print('A');

	return 0;
}


void Print(int val)
{
	cout << "O valor do inteiro ‚: " << val << "\n";
}

void Print(double val)
{
	cout << "O valor do double ‚: " << val << "\n";
}

void Print(char ch)
{
	cout << "O valor ASCII do car cter '" << ch << "' ‚: " << (int)ch << "\n";
}

