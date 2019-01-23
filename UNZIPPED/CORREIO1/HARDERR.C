#include <stdio.h>
#include <conio.h>
#include <dos.h>

#define IGNORE  0
#define RETRY   1
#define ABORT   2

int buf[500];

/* define mensagens de erro - foram itencionalmente deixadas em Inglês */
static char *err_msg[] = {
	"write protect",
	"unknown unit",
	"drive not ready",
	"unknown command",
	"data error (CRC)",
	"bad request",
	"seek error",
	"unknown media type",
	"sector not found",
	"printer out of paper",
	"write fault",
	"read fault",
	"general failure",
	"reserved",
	"reserved",
	"invalid disk change"
};

error_win(char *msg)
{
	int retval;

	cputs(msg);

	/* loop até que o utilizador pressione A, R ou I */
	while (1) {
		retval = getch();
		if (retval == 'a' || retval == 'A') { retval = ABORT;  break; }
		if (retval == 'r' || retval == 'R') { retval = RETRY;  break; }
		if (retval == 'i' || retval == 'I') { retval = IGNORE; break; }
	}

	return(retval);
}

#pragma warn -par	/* desliga o warning para parâmetros não utilizados */

int handler(int errval,int ax,int bp,int si)
{
	static char msg[80];
	unsigned di;
	int drive;
	int errorno;

	di= _DI;

	/* se não for um erro de disco */
	if (ax < 0) {
		error_win("Device error");	/* mostra o erro */
		hardretn(ABORT);		/* e sai directamente para o programa */
	}

	/* caso contrario, foi um erro de disco */
	drive = ax & 0x00FF;
	errorno = di & 0x00FF;

	/* escreve a mensagem relativa ao erro */
	sprintf(msg, "Erro: %s na drive %c\r\nA)borta, R)etenta, I)gnora: ",
		err_msg[errorno], 'A' + drive);

	/* retoma para o programa com a opção escolhida pelo utilizador */
	hardresume(error_win(msg));
	return ABORT;
}

#pragma warn +par

int main(void)
{
	harderr(handler);		/* instala o handler */
	clrscr();
	printf("Certifique-se que não existe nehuma disqueta na drive A:\n");
	printf("Pressione uma tecla ....\n");
	getch();
	printf("Tentando aceder à drive A:\n");
	printf("fopen retornou %p\n", fopen("A:temp.dat", "w"));
	return 0;
}
