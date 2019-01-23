/*********************************************************************/
/*                     E X E M P L 1 2 . C P P                       */
/*-------------------------------------------------------------------*/
/*            Curso de C++ da Spooler Magazine - PARTE 3             */
/*-------------------------------------------------------------------*/
/*    Fun‡„o        : Demonstra a utiliza‡„o dos op. new e delete    */
/*-------------------------------------------------------------------*/
/*    Autor         : Carlos Ladeira                                 */
/*    Compilador    : Borland C++ 3.1                                */
/*********************************************************************/

#include "iostream.h"

struct date {
	int month;
	int day;
	int year;
};

main()
{
	int a, * ip1, * ip2;		// declara uma variavel e dois ponteiros
	ip1 = &a;					// coloca "ip1" a apontar para a var. "a"
	*ip1 = 77;                  // i.e. "a = 77;"
	ip2 = new int;				// aloca espa‡o para um int
	*ip2 = 173;					// coloca o val 173 no espa‡o alocado atr s
	cout << "a=" << a << " *ip1=" << *ip1 << " *ip2=" << *ip2 << "\n";
	ip1 = new int;				// aloca espa‡o para mais um int
	ip2 = ip1;					// "ip2" aponta para o novo espa‡o alocado
								// NOTA: o espa‡o de mem¢ria que "ip2"
								// apontava, ®perdeu-se¯ n„o podendo ser
								// desalocado durante a execu‡„o do programa
	*ip1 = 999;					// coloca 999 no espa‡o alocado para "ip1"
	cout << "a=" << a << " *ip1=" << *ip1 << " *ip2=" << *ip2 << "\n";
	delete ip1;					// desaloca o espa‡o alocado previamente para "ip1"
								// o espa‡o alocado para "ip2" n„o pode ser
								// desalocado, pois n„o sabemos onde ‚ que
								// ele est  !!!


	float * fp1, * fp2 = new float;	// declara dois ponteiros para float
									// alocando logo espa‡o para "fp2"
	fp1 = new float;			// aloca espa‡o para "fp1"
	*fp2 = 3.14159;				// af‚cta o espa‡o alocado para "fp2"
	*fp1 = 2.4 * (*fp2);		// af‚cta o espa‡o alocado para "fp1"
	delete fp2;					// desaloca o espa‡o previamente alocado
	delete fp1;					// desaloca o espa‡o previamente alocado


	date * datep;               // declara um ponteiro para a estrutura "date"
	datep = new date;			// aloca espa‡o para a estrutura "date"
	datep->month = 10;			// af‚cta o conteudo de "datep"
	datep->day = 18;            // af‚cta o conteudo de "datep"
	datep->year = 1938;         // af‚cta o conteudo de "datep"
	cout << datep->month << "/" << datep->day << "/" << datep->year << "\n";
	delete datep;               // desaloca o espa‡o alocado para "datep"


	char *cp;					// declara um ponteiro para car cter
	cp = new char[37];			// aloca um array de 37 char's para "cp"
	delete cp;					// desaloca o array atr s alocado
	cp = new char[sizeof(date) + 133];	// outra forma de aloca‡„o de mem¢ria
	delete cp;					// desaloca

	return 0;					// retoma 0 para o SO
}
