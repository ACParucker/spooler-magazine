#include "quadtext.h"
#include <io.h>
#include <fcntl.h>
#include <process.h> 
#include <dir.h>
#include <stdio.h>
#include <sys\stat.h>
#include <string.h>
#include <errno.h>
                                            
#define NORM_COLOR BLUE  /* C“r normal das letras do menu principal */
#define HIGH_COLOR WHITE /* C“r das letras "Highlighted do menu principal */
#define START_BACK CYAN  /* C“r de fundo do menu principal */

#define EDIT_TEXT_COLOR WHITE /* C“r  de texto da edi‡„o dos nomes e *
							   * descri‡”es de programas */
#define EDIT_TEXT_BACK  BLACK /* C“r de fundo na edi‡„o dos nomes e *
							   * descri‡”es de programas */

#define MAX_PATH 40  /* N£mero m ximo de caract‚res no nome de programa */
#define MAX_DESC 40  /* N£mero m ximo de caract‚res na descri‡„o do programa */
#define MAX_PROG 20  /* N£mero m ximo de programas armazen veis */

struct text_info st_data; /* Estrutura para guardar configura‡„o inicial do *
													 * ecr„ */
void *old_text_keep; /* Ponteiro para guardar imagem inicial do ecr„ */

/* Recolocar configura‡”es do ecr„ no estado inicial */

void reset_windows(void)
{
	textattr(st_data.attribute);
	window(st_data.winleft,st_data.wintop,st_data.winright,st_data.winbottom);
	gotoxy(st_data.curx,st_data.cury);
}

/* Esconder cursor de texto na linha do menu principal */

void hide_cursor(void)
{
	window(1,1,80,25);
	gotoxy(80,1);
}

/* Mostra mensagem do autor em janela de texto ,espera por uma tecla e     *
 * repäe o estado inicial */

void show_about(void)
{
	void *store=malloc(40*6+1);

	set_window_colors();
	quadro_texto(28,9,47,15,store);
	cputs("    O EXECUTOR    \n\r");
	cputs("       v1.1       \n\r");
	cputs("\n\r");
	cputs(" Ricardo Vinagre  \n\r");
	cputs("       1993      ");
	textcolor(CYAN);
	putch(' ');
	putch(8);
	getch();
	puttext(28,9,47,15,store);
	free(store);
	reset_colors();
}

/* Obtem do ficheiro com handle fl_handle uma lista de descri‡”es de       *
 * programas que coloca em lista (alocando da mem¢ria o espa‡o necess rio  *
 * usando a fun‡„o MALLOC).Devolve o n£mero de elementos da lista */

int obtem_lista(int fl_handle,char *(lista[MAX_PROG]))
{
	char buffer[1];
	int aux2,aux1=0;

	buffer[0]='a';
	while (buffer[0]!='õ')
	{
		lista[aux1]=(char *)(malloc(MAX_DESC*2+2));
		while (buffer[0]!=' ')
			_read(fl_handle,buffer,1);
		_read(fl_handle,buffer,1);
		for(aux2=0;buffer[0]!='\n';aux2++)
		{
			lista[aux1][aux2]=buffer[0];
			_read(fl_handle,buffer,1);
		}
		if (lista[aux1][aux2-1]=='\r')
			lista[aux1][aux2-1]='\0';
		else
			lista[aux1][aux2]='\0';
		aux1++;
		_read(fl_handle,buffer,1);
	}
	return(aux1);
}

/* Controla a subrotina de execu‡„o do programa incluindo dar … escolha    *
 * qual o programa a executar.Pode-se abortar a execu‡„o carregando na     *
 * tecla <ESC> */

void execution(void)
{
	int fl_handle=_open("c:\\programs.exc",O_RDONLY);
	char buffer[1];
	int aux1,aux2,option,num_ops;
	char *list[MAX_PROG+1];
	char path[MAX_PATH+1];
	char prog[13];

	hide_cursor();
	if (fl_handle==-1)
	{
		window(1,1,80,25);
		clrscr();
		cputs("Erro na abertura do ficheiro C:\\PROGRAMS.EXC \n\r");
		perror(" ");
		exit(-1);
	}
	_read(fl_handle,buffer,1);
	if (buffer[0]=='õ')
	{
		puttext(1,1,80,1,old_text_keep);
		quadro_mensagem(12,11,"Sem programas definidos para executar-Use op‡„o Edit");
		_close(fl_handle);
		return;
	}
	num_ops=obtem_lista(fl_handle,list);
	option=show_ops(2,1,num_ops,list);
	for(aux1=num_ops-1;aux1>=0;aux1--)
		free(list[aux1]);
	hide_cursor();
	lseek(fl_handle,0,SEEK_SET);
	if (option==0)
	{
		_close(fl_handle);
		return;
	}
	for(aux1=1;aux1!=option;aux1++)
		do
			_read(fl_handle,buffer,1);
		while (buffer[0]!='\n');
	_read(fl_handle,buffer,1);
	for(aux1=0;buffer[0]!=' ';aux1++)
	{
		path[aux1]=buffer[0];
		_read(fl_handle,buffer,1);
	}
	path[aux1]='\0';
	if (access(path,0)!=0)
	{
		quadro_mensagem(20,11,"Ficheiro especificado n„o existe");
		_close(fl_handle);
		return;
	}
	for(aux1=0;path[aux1]!='.';aux1++);
	while(path[aux1]!='\\')
		aux1--;
	path[aux1]='\0';
	aux1++;
	aux2=0;
	while(path[aux1]!='\0')
	{
		prog[aux2]=path[aux1];
		aux2++;
		aux1++;
	}
	prog[aux2]='\0';
	_close(fl_handle);
	puttext(1,1,80,1,old_text_keep);
	reset_windows();                           
	free(old_text_keep);
	chdir(path); /* Mudar para a directoria do programa */
	setdisk(path[0]-'A'); /* Mudar para a drive do programa */
	for(aux1=0;prog[aux1]!='.';aux1++);
	if (prog[aux1+1]=='B')
	{
		system(prog); /* Chamar a Shell e executar um ficheiro tipo BAT */
		exit(0);
	}
	if (execl(prog,NULL)==-1) /* Executar um programa tipo EXE ou COM */
	{
		quadro_mensagem(23,11,"Incapaz de correr programa");
		quadro_mensagem(15,11,strerror(errno));
		reset_windows();
		perror(" ");
		exit(-1);
	}
}

/* Trata do apagar do item n£mero escolha (escolha>=1) da lista de *
 * programas */

void op_del(int escolha)
{
	int old_fich,fich;
	int aux;
	char data[1];

	hide_cursor();
	if (access("C:\\PROGRAMS.BAK",0)==0)
		remove("C:\\PROGRAMS.BAK");
	if (rename("C:\\PROGRAMS.EXC","C:\\PROGRAMS.BAK")!=0)
	{
		quadro_mensagem(22,11,"Apaga-Impossivel operar (1)");
		quadro_mensagem(15,11,strerror(errno));
		return;
	}
	if ((fich=creat("C:\\PROGRAMS.EXC",S_IWRITE))==-1)
	{
		quadro_mensagem(22,11,"Apaga-Impossivel operar (2)");
		quadro_mensagem(15,11,strerror(errno));
		exit(-1);
	}
	if ((old_fich=_open("C:\\PROGRAMS.BAK",O_RDONLY))==-1)
	{
		quadro_mensagem(22,11,"Apaga-Impossivel operar (3)");
		quadro_mensagem(15,11,strerror(errno));
		_close(fich);
		exit(-1);
	}
	for(aux=1;aux<escolha;aux++)
	{
		_read(old_fich,data,1);
		while(data[0]!='\n')
		{
			_write(fich,data,1);
			_read(old_fich,data,1);
		}
		_write(fich,data,1);
	}
	_read(old_fich,data,1);
	while(data[0]!='\n')
		_read(old_fich,data,1);
	while(!eof(old_fich))
	{
		_read(old_fich,data,1);
		_write(fich,data,1);
	}
	_close(old_fich);
	_close(fich);
}

/* Edita numa janela de texto uma string data de max_size caracteres   *
 * identificada na janela pela frase mensagem.Retorna 0 caso tenha sido*
 * abortada a edi‡„o (tecla <ESC>) ou 1 caso contr rio */

int editor(int max_size,char data[],const char *mensagem)
{
	int aux,total_size,mens_size,pos;
	char key;
	void *store;

	for(aux=0;mensagem[aux]!='\0';aux++);
	mens_size=aux;
	total_size=mens_size+max_size;
	store=malloc((total_size+4)*6);
	set_window_colors();
	quadro_texto(38-total_size/2,11,38+total_size-total_size/2+4,13,store);
	putch(' ');
	cputs(mensagem);
	textcolor(EDIT_TEXT_COLOR);
	textbackground(EDIT_TEXT_BACK);
	for(aux=0;aux<max_size;aux++)
		putch(' ');
	gotoxy(mens_size+2,1);
	if (data[0]!='\0')
		cputs(data);
	gotoxy(total_size+2,1);
	textcolor(_normal_back);
	textbackground(_normal_back);
	putch(' ');
	textcolor(EDIT_TEXT_COLOR);
	textbackground(EDIT_TEXT_BACK);
	for(aux=0;data[aux]!='\0';aux++);
	pos=aux;
	if (aux!=max_size)
		gotoxy(mens_size+2+aux,1);
	else
		gotoxy(mens_size+1+aux,1);
	while(1)
	{
		key=getch();
		if (!key)
			getch();
		switch (key)
		{
			case 27:puttext(38-total_size/2,11,42-total_size/2+total_size,13,store);
					free(store);
					return(0);
			case 13:data[pos]='\0';
					puttext(38-total_size/2,11,42-total_size/2+total_size,13,store);
					free(store);
					return(1);
			case  8:if (pos>0)
					{
						data[--pos]=' ';
						if (pos!=max_size-1)
							putch(8);
						putch(' ');
						putch(8);
					}
			case  0:break;
			default:if (pos==max_size)
					{
						data[pos-1]=key;
						putch(key);
						putch(8);
					}
					else
					{
						data[pos]=key;
						putch(key);
						if ((++pos)==max_size)
							putch(8);
					}
		}
	}
}

/* Trata da edi‡„o de um item da lista de programas */

void op_edit(int escolha)
{
	int aux;
	char path[MAX_PATH+1],desc[MAX_DESC+1];
	int fich,old_fich;
	char buffer[1];

	hide_cursor();
	if (access("C:\\PROGRAMS.BAK",0)==0)
		remove("C:\\PROGRAMS.BAK");
	if (rename("C:\\PROGRAMS.EXC","C:\\PROGRAMS.BAK")!=0)
	{
		quadro_mensagem(24,11,"Edita-Impossivel operar (1)");
		quadro_mensagem(15,11,strerror(errno));
		return;
	}
	if ((fich=creat("C:\\PROGRAMS.EXC",S_IWRITE))==-1)
	{
		quadro_mensagem(24,11,"Edita-Impossivel operar (2)");
		quadro_mensagem(15,11,strerror(errno));
		exit(-1);
	}
	if ((old_fich=_open("C:\\PROGRAMS.BAK",O_RDONLY))==-1)
	{
		quadro_mensagem(24,11,"Edita-Impossivel operar (3)");
		quadro_mensagem(15,11,strerror(errno));
		_close(fich);
		exit(-1);
	}
	for(aux=1;aux<escolha;aux++)
	{
		_read(old_fich,buffer,1);
		while(buffer[0]!='\n')
		{
			_write(fich,buffer,1);
			_read(old_fich,buffer,1);
		}
		_write(fich,buffer,1);
	}
	_read(old_fich,buffer,1);
	for(aux=0;buffer[0]!=' ';aux++)
	{
		path[aux]=buffer[0];
		_read(old_fich,buffer,1);
	}
	path[aux]='\0';
	_read(old_fich,buffer,1);
	for(aux=0;buffer[0]!='\n';aux++)
	{
		desc[aux]=buffer[0];
		_read(old_fich,buffer,1);
	}
	if (desc[aux-1]=='\r')
		desc[aux-1]='\0';
	else
		desc[aux]='\0';
	aux=1;
	while (aux)
	{
		if(!editor(MAX_PATH,path,"Path & Programa:"))
		{
			_close(old_fich);
			_close(fich);
			return;
		}
		strupr(path);
		hide_cursor();
		if (access(path,0)!=0)
			quadro_mensagem(24,11,"O programa n„o existe");
		else
			aux=0;
	}
	if(!editor(MAX_DESC,desc,"Descri‡„o do Programa:"))
	{
		_close(fich);
		_close(old_fich);
		return;
	}
	hide_cursor();
	for(aux=0;path[aux]!='\0';aux++)
	{
		buffer[0]=path[aux];
		_write(fich,buffer,1);
	}
	buffer[0]=' ';
	_write(fich,buffer,1);
	for(aux=0;desc[aux]!='\0';aux++)
	{
		buffer[0]=desc[aux];
		_write(fich,buffer,1);
	}
	buffer[0]='\n';
	_write(fich,buffer,1);
	_read(old_fich,buffer,1);
	while(buffer[0]!='õ')
	{
		_write(fich,buffer,1);
		_read(old_fich,buffer,1);
	}
	buffer[0]='õ';
	_write(fich,buffer,1);
	_close(fich);
	_close(old_fich);
}

/* Trata da coloca‡„o de um novo item na lista de programas */

void op_new(void)
{
	int res_edit,aux;
	char buffer[1];
	char path[MAX_PATH+1],desc[MAX_DESC+1];
	int fich,old_fich;

	if ((fich=_open("C:\\PROGRAMS.EXC",O_RDONLY))==-1)
	{
		quadro_mensagem(21,11,"Impossivel abrir C:\\PROGRAMS.EXC");
		quadro_mensagem(15,11,strerror(errno));
		exit(-1);
	}
	aux=0;
	_read(fich,buffer,1);
	while(buffer[0]!='õ')
	{
		while(buffer[0]!='\n')
			_read(fich,buffer,1);
		aux++;
		_read(fich,buffer,1);
	}
	_close(fich);
	if (aux>=MAX_PROG)
	{
		quadro_mensagem(18,11,"Nenhum novo item permitido-j  m ximo");
		return;
	}
	for(aux=1;aux<MAX_PATH;aux++)
		path[aux]=' ';
	path[0]='\0';
	for(aux=1;aux<MAX_DESC;aux++)
		desc[aux]=' ';
	desc[0]='\0';
	aux=1;
	while (aux)
	{
		if(!editor(MAX_PATH,path,"Path & Programa:"))
			return;
		strupr(path);
		hide_cursor();
		if (access(path,0)!=0)
			quadro_mensagem(24,11,"O programa n„o existe");
		else
			aux=0;
	}
	if(!editor(MAX_DESC,desc,"Descri‡„o do programa:"))
		return;
	hide_cursor();
	if (access("C:\\PROGRAMS.BAK",0)==0)
		remove("C:\\PROGRAMS.BAK");
	if (rename("C:\\PROGRAMS.EXC","C:\\PROGRAMS.BAK")!=0)
	{
		quadro_mensagem(25,11,"Novo-Impossivel operar (1)");
		quadro_mensagem(15,11,strerror(errno));
		return;
	}
	if ((fich=creat("C:\\PROGRAMS.EXC",S_IWRITE))==-1)
	{
		quadro_mensagem(25,11,"Novo-Impossivel operar (2)");
		quadro_mensagem(15,11,strerror(errno));
		exit(-1);
	}
	if ((old_fich=_open("C:\\PROGRAMS.BAK",O_RDONLY))==-1)
	{
		quadro_mensagem(25,11,"Novo-Impossivel operar (3)");
		quadro_mensagem(15,11,strerror(errno));
		_close(fich);
		exit(-1);
	}
	for(aux=0;path[aux]!='\0';aux++)
	{
		buffer[0]=path[aux];
		_write(fich,buffer,1);
	}
	buffer[0]=' ';
	_write(fich,buffer,1);
	for(aux=0;desc[aux]!='\0';aux++)
	{
		buffer[0]=desc[aux];
		_write(fich,buffer,1);
	}
	buffer[0]='\n';
	_write(fich,buffer,1);
	_read(old_fich,buffer,1);
	while(buffer[0]!='õ')
	{
		_write(fich,buffer,1);
		_read(old_fich,buffer,1);
	}
	buffer[0]='õ';
	_write(fich,buffer,1);
	_close(fich);
	_close(old_fich);
}

/* Trata do menu de edi‡„o, elimina‡„o e adi‡„o de items na lista de *
 * programas */

void edition_mode(void)
{
	char *lista_ops[3]={"Novo","Edita","Apaga"};
	int opcao_accao,opcao_prog,num_ops,aux;
	int fich=_open("c:\\programs.exc",O_RDWR);
	char *lista[MAX_PROG+1];
	char buffer[1];

	if (fich==-1)
	{
		window(1,1,80,25);
		textattr(st_data.attribute);
		clrscr();
		cputs("Erro na abertura de C:\\PROGRAMS.EXC \n\r");
		perror(" ");
		exit(-1);
	}
	_read(fich,buffer,1);
	opcao_accao=show_ops(11,1,3,lista_ops);
	while((buffer[0]=='õ') && (opcao_accao!=1) && (opcao_accao!=0))
	{
		quadro_mensagem(21,11,"Unica op‡„o disponivel-Novo");
		opcao_accao=show_ops(11,1,3,lista_ops);
	}
	hide_cursor();
	if (!opcao_accao)
	{
		_close(fich);
		return;
	}
	if (opcao_accao!=1)
	{
		num_ops=obtem_lista(fich,lista);
		opcao_prog=show_ops(11,1,num_ops,lista);
		for(aux=num_ops-1;aux>=0;aux--)
			free(lista[aux]);
		_close(fich);
		if (!opcao_prog)
			return;
		if (opcao_accao==3)
			op_del(opcao_prog);
		else
			op_edit(opcao_prog);
	}
	else
	{
		_close(fich);
		op_new();
	}
}

/* Coloca frase em formato normal */

void normal_put(char *frase)
{
	textcolor(NORM_COLOR);
	cputs(frase);
}

/* Coloca letra em formato Highlighted */

void high_put(char letra)
{
	textcolor(HIGH_COLOR);
	putch(letra);
}

/* Coloca no ecr„ o menu principal (ATEN€ÇO:N„o guarda o estado inicial do *
 * ecr„) */

void show_start(void)
{
	window(1,1,80,25);
	gotoxy(1,1);
	textbackground(START_BACK);
	normal_put(" E");
	high_put('x');
	normal_put("ecuta  ");
	high_put('E');
	normal_put("dita  ");
	high_put('S');
	normal_put("obre  S");
	high_put('a');
	normal_put("ir        ");
	textcolor(BLACK);
	cputs("         O Executor-Ricardo Vinagre 1993   ");
	textcolor(START_BACK);
	putch(' ');
	gotoxy(80,1);
}

/* Parte principal:   																				 *
 * -Mostrar menu principal 																		 *
 * -Escolha de op‡”es do menu principal 											 *
 * -Controle de fluxo do programa       											 *
 * -Saida do programa																					 *
 * -Vigia a inicializa‡„o (se necess rio) do ficheiro de dados */

main()
{
	int ficheiro;

	old_text_keep=malloc(80*2);
	gettextinfo(&st_data);
	if (st_data.currmode!=C80)
	{
		clrscr();
		cputs("O Executor-Ricardo Vinagre 1993         \n\r");
		cputs("Este programa s¢ trabalha no modo CO80! \n\r");
		cputs("                                        \n\r");
		return(-1);
	}
	if (access("c:\\programs.exc",0)==-1)
	{
		char data[1];

		if ((ficheiro=creat("C:\\PROGRAMS.EXC",S_IWRITE))==-1)
		{
			clrscr();
			cputs(" O Executor-Ricardo Vinagre 1993     \n\r");
			cputs(" Nao consigo criar C:\\PROGRAMS.EXC  \n\r");
			cputs("                                     \n\r");
			perror("");
			return(-1);
		}
		data[0]='õ';
		_write(ficheiro,data,1);
		_close(ficheiro);
	}
	gettext(1,1,80,1,old_text_keep);
	while (1)
	{
		show_start();
		switch (getch())
		{
			case 'x':
			case 'X':	execution();
								break;
			case 's':
			case 'S': puttext(1,1,80,1,old_text_keep);
								show_about();
								gettext(1,1,80,1,old_text_keep);
								break;
			case 'e':
			case 'E':	edition_mode();
								break;
			case 'a':
			case 'A':
			case 27 :	puttext(1,1,80,1,old_text_keep);
								textattr(st_data.attribute);
								window(st_data.winleft,st_data.wintop,st_data.winright,st_data.winbottom);
								gotoxy(st_data.curx,st_data.cury);
								return(0);
		}
	}
}

/* Nota Final (Sobre o formato do ficheiro de dados):                      *
 * O ficheiro de dados consiste muito simplesmente num conjunto de no      *
 * m ximo MAX_PROG linhas de caract‚res ASCII e uma linha final contendo   *
 * apenas o caract‚re õ.Cada linha ‚ constituida por duas partes:          *
 * 1)Primeira parte contendo em mai£sculas o nome completo do programa     *
 *  (com drive e path completo incluidos) num m ximo de MAX_PATH caract‚res*                               *
 * 2)Segunda parte contendo uma descri‡„o do programa com um m ximo de     *
 *  MAX_DESC caract‚res       																						 *
 * As duas partes est„o separadas por um caract‚re espa‡o.								 *
 * Cada linha ‚ terminada por RETURN & NEWLINE ou s¢ NEWLINE (O Editor de  *
 * items do programa termina as linhas s¢ com NEWLINE, mas um editor de    *
 * texto ASCII como por exemplo o EDITOR do MS-DOS termina as linhas com   *
 * RETURN & NEWLINE) */
