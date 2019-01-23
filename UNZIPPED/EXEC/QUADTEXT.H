#include <conio.h>
#include <alloc.h>

int _cursor_back=BLUE;        /* C“r do cursor */
int _normal_back=CYAN;        /* C“r normal de fundo */
int _letter_color=WHITE;      /* C“r normal das letras */
struct text_info _old_data;   /* Dados sobre configura‡Æo inicial */

/* Muda as cores de escrita para INK=_letter_color  /                *
 * BACKGROUND=_normal_back e guarda os dados da configura‡Æo inicial */

void set_window_colors(void)
{
	gettextinfo(&_old_data);
	textcolor(_letter_color);
	textbackground(_normal_back);
}

/* Recoloca as cores do ecrÆ nos valores inicialmente guardados a quando *
 * da chamada de set_window_colors */

void reset_colors(void)
{
	textattr(_old_data.attribute);
}

/* Coloca a cor usada pelo cursor igual a color */

void cursor_color(int color)
{
	_cursor_back=color;
}

/* Coloca as cores usada no desnhar da janela iguais a : *
 * INK=letter_c  /  BACKGROUND=back_c */

void window_color(int letter_c,int back_c)
{
	_letter_color=letter_c;
	_normal_back=back_c;
}

/* Desenha quadro de texto com c“r de base _normal_back e com bordos em c“r *
 * _letter_color.O quadro ‚ colocado com o canto superior esquerdo em       *
 * (left,top) e com o canto inferior direito em (right,bottom).No final no  *
 * apontador destin estÆo os dados dos caracteres que estavam na posi‡Æo de *
 * ecrÆ agora ocupada pelo quadro (a subrotina que chama esta rotina deve   *
 * alocar mem¢ria suficiente - 2 vezes o n£mero de caract‚res).No final fica*
 * estabelecido uma janela de texto com o canto superior esquerdo           *
 * (left+1,top+1) e o canto inferior direito (right,bottom)   */

void quadro_texto(int left,int top,int right,int bottom,void *destin)
{
	int aux1,aux2;
	int largura=right-left+1;
	int altura=bottom-top+1;

	gettext(left,top,right,bottom,destin);
	window(left,top,right,bottom+1);
	gotoxy(1,1);
	putch('É');
	for(aux1=2;aux1<largura;aux1++)
		putch('Í');
	cputs("»\r");
	for(aux1=2;aux1<altura;aux1++)
	{
		putch('º');
		for(aux2=2;aux2<largura;aux2++)
			putch(' ');
		cputs("º\r");
	}
	putch('È');
	for(aux1=2;aux1<largura;aux1++)
		putch('Í');
	putch('¼');
	window(left+1,top+1,right,bottom);
	gotoxy(1,1);
}

int cursor_lenght;  /* Comprimento do cursor */
int linha_cursor;   /* Linha do quadro onde est  o cursor */

/* Subrotina de uso interno - coloca o cursor na linha linha_curso ,sobre a *
 * a expressÆo frase */

void coloca_cursor(char *frase)
{
	int aux;

	textbackground(_cursor_back);
	gotoxy(1,linha_cursor);
	putch(' ');
	cputs((const char *)(frase));
	for(aux=0;frase[aux]!='\0';aux++);
	while (aux<cursor_lenght)
	{
		putch(' ');
		aux++;
	}
	textcolor(_cursor_back);
	putch(' ');
	putch(8);
	textcolor(_letter_color);
	textbackground(_normal_back);
}

/* Subrotina de uso interno - retira o cursor que est  na linha linha_cursor*
 * sobre a expressÆo frase */

void tira_cursor (char *frase)
{
	int aux;

	gotoxy(1,linha_cursor);
	putch(' ');
	cputs((const char *)(frase));
	for(aux=0;frase[aux]!='\0';aux++);
	while (aux<=cursor_lenght)
	{
		putch(' ');
		aux++;
	}
}

/* Subrotina de uso interno - trata da movimenta‡Æo do cursor e tratamento *
 * dos sinais enviados pelo teclado durante a escolha de uma op‡Æo num     *
 * quadro com num_ops op‡äes */

int escolhe_op(int num_ops,char *ops[])
{
	int end=-1;

	coloca_cursor(ops[linha_cursor-1]);
	while (end==-1)
		switch (getch())
		{
			case 72:tira_cursor(ops[linha_cursor-1]);
					if (linha_cursor!=1)
						linha_cursor--;
					else
						linha_cursor=num_ops;
					coloca_cursor(ops[linha_cursor-1]);
					break;
			case 80:tira_cursor(ops[linha_cursor-1]);
					if (linha_cursor!=num_ops)
						linha_cursor++;
					else
						linha_cursor=1;
					coloca_cursor(ops[linha_cursor-1]);
					break;
			case 13:end=linha_cursor;
					break;
			case 27:end=0;
		}
	return(end);
}

/* Desenha quadro com canto superior esquerdo em (left,top) e com tamanho   *
 * suficiente para conter a maior das op‡äes de entre as num_ops op‡äes     *
 * a serem mostradas.Trata de "tudo" e retorna o n£mero da op‡Æo escolhida  *
 * (1 a num_ops) ou o valor zero caso o utilizador tenha desistido usando a *
 * tecla <ESC>.Guarda o estado de cores escolhidas iniciais, que repäe no   *
 * final e tambem guarda durante a escolha das op‡äes repondo no final      *
 * (livrando-se dos "restos") os caract‚res sobre os quais a janela de      *
 * op‡äes foi colocada.As op‡äes sÆo passadas atrav‚s de um array de        *
 * apontadores para linhas de caract‚res ,com num_ops linhas ,sendo cada    *
 * linha uma op‡ao */

int show_ops(int left,int top,int num_ops,char *ops[])
{
	int aux1,aux2;
		void *destino;

	set_window_colors();
	cursor_lenght=0;
	for(aux1=0;aux1<num_ops;aux1++)
	{
		for(aux2=0;ops[aux1][aux2]!='\0';aux2++);
		if (aux2>cursor_lenght) cursor_lenght=aux2;
	}
	destino=malloc((size_t)((cursor_lenght+4)*(num_ops+2)+1));
	quadro_texto(left,top,left+cursor_lenght+3,top+num_ops+1,destino);
	for(aux1=0;aux1<num_ops;aux1++)
	{
		putch(' ');
		cputs((const char *)(ops[aux1]));
		if (aux1<num_ops-1) cputs("\r\n");
	}
	linha_cursor=1;
	aux1=escolhe_op(num_ops,ops);
	puttext(left,top,left+cursor_lenght+3,top+num_ops+1,destino);
	free(destino);
	reset_colors();
	return(aux1);
}

/* Faz quadro de texto com canto superior esquerdo em (left,top) e com o    *
 * tamanho adequado ,onde coloca a linha de texto mensagem.Guarda o estado  *
 * inicial de cores ,guarda os carcteres sobre os quais o quadro ‚ colocado *
 * ,mostra o quadro com a mensagem ,e quando o utilizador carrega em alguma *
 * tecla repäe a imagem no ecrÆ e as cores no estado inicial */

void quadro_mensagem(int left,int top,char *mensagem)
{
		void *store;
				int aux;

		set_window_colors();
		for(aux=0;mensagem[aux]!='\0';aux++);
		store=malloc((aux+4)*6);
		quadro_texto(left,top,left+aux+3,top+2,store);
		putch(' ');
		cputs(mensagem);
		gotoxy(aux+2,1);
		textcolor(_normal_back);
		putch(' ');
		putch(8);
		reset_colors();
		getch();
		puttext(left,top,left+aux+3,top+2,store);
		free(store);

}