#include <windows.h>
#include "debug.h"

void DebugMessage(int valor,char *formato)
{
	char buffer[250];

    wsprintf((LPSTR)buffer,(LPSTR)formato,valor);
	MessageBox(NULL,buffer,"Mensagem de Debug",MB_OK | MB_ICONEXCLAMATION);
}