/*********************************************************************/
/*                     E X E M P L 1 0 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 2             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a convers„o de tipos em C++.         */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include <iostream.h>

main()
{
	int a = 2;
	float x = 17.1, y = 8.95, z;
	char c;

	// velho e £nico formato reconhecido pelo ANSI-C
	c = (char)a + (char)x;
	c = (char)(a + (int)x);
	c = (char)(a + x);
	c = a + x;
	z = (float)((int)x * (int)y);
	z = (float)((int)x * (int)y);
	z = (float)((int)(x * y));
	z = x * y;

	// nova forma de fazer convers”es em C++
	c = char(a) + char(x);
	c = char(a + int(x));
	c = char(a + x);
	c = a + x;
	z = float(int(x) * int(y));
	z = float(int(x) * int(y));
	z = float(int(x * y));
	z = x * y;

	return 0;
}
