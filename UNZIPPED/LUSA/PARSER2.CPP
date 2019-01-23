//  |          __  __
//  |   |  |  |_  |__|
//  |__ |__|  __| |  |
//  ------------------
//  Analisador de express”es
//

#define _DELIMITER  1
#define _VARIABLE   2
#define _NUMBER     3

char  *pt;
char  elem[80];
char  tipo;

void eval_exp1(double *answer);
void eval_exp2(double *answer);
void eval_exp3(double *answer);
void eval_exp4(double *answer);
void eval_exp5(double *answer);
void eval_exp6(double *answer);
void eval_exp7(double *answer);
void eval_exp8(double *answer);
void atom(double *answer);
void _put_back(void);
void serror(int error);
void _get_token(void);
int  _isdelim(char c);


/* Ponto de entrada */

void eval_exp1(double *answer)
{
 _get_token();
 if (!*elem) {
  serror(2);
  return;
 }
 eval_exp2(answer);
}

void eval_exp2(double *answer)
{
 register char op;
 double temp;

 eval_exp3(answer);
 op=*elem;
 while ((op=*elem)=='&' || op=='|') {
    _get_token();
    eval_exp3(&temp);
    switch (op) {
       case '&': *answer=(*answer && temp);   break;
       case '|': *answer=(*answer || temp);   break;
      }
   }
}

void eval_exp3(double *answer)
{
 register char op,op1;
 double temp;

 eval_exp4(answer);
 op=*elem;
 op1=*(elem+1);
 while ((op=*elem)=='>' || op =='<' || op =='='|| op =='#' ) {
    _get_token();
    eval_exp4(&temp);

    switch (op) {
       case '<': if (op1=='=') *answer=*answer <= temp;
		 else *answer=*answer < temp;  break;
       case '>': if (op1=='=') *answer=(*answer >= temp);
		 else *answer=(*answer > temp);    break;
       case '=': *answer=(*answer == temp);    break;
       case '#': *answer=(*answer != temp); break;
      }
   }
}

void eval_exp4(double *answer)
{
 register char op;
 double temp;

 eval_exp5(answer);
 op=*elem;
 while ((op=*elem)=='+' || op=='-') {
    _get_token();
    eval_exp5(&temp);
    switch (op) {
       case '+': *answer=(*answer + temp);   break;
       case '-': *answer=(*answer - temp);   break;
      }
   }
}

void eval_exp5(double *answer)
{
 register char op;
 double temp;

 eval_exp6(answer);
 op=*elem;
 while ((op=*elem)=='*' || op=='/'|| op=='%'|| op=='$'|| op=='@') {
    _get_token();
    eval_exp6(&temp);
    switch (op) {
       case '*': *answer=(*answer * temp);   break;
       case '/': *answer=(*answer / temp);   break;
       case '%': *answer=(*answer * (temp/100.0));   break;
       case '$': *answer=fmod(*answer,temp);   break;
       case '@': *answer=((int)*answer / (int)temp);   break;
      }
   }
}

void eval_exp6(double *answer)
{
 register char op;
 double temp;

 eval_exp7(answer);
 op=*elem;
 while ((op=*elem)=='^') {
    _get_token();
    eval_exp6(&temp);
    *answer=pow(*answer,temp);
   }
}

void eval_exp7(double *answer)
{
 register char op;

 op=0;
 if ((tipo==_DELIMITER) && ( *elem=='+' || *elem=='-' || *elem=='!')) {
    op=*elem;
    _get_token();
  }
  eval_exp8(answer);
  if (op=='-') *answer= -(*answer);
  if (op=='!') *answer=! (*answer);
}

void eval_exp8(double *answer)
{
 if (*elem=='(') {
    _get_token();
    eval_exp2(answer);
    if (*elem!=')') serror(1);
    _get_token();
   }
   else atom(answer);
}

void atom(double *answer)
{
 if (tipo==_NUMBER) {
   *answer=atof(elem);
   _get_token();
   return;
   }
 if (tipo==_VARIABLE) {
   switch (id.proc_tipo(elem)) {
      case 'I':  int i;
		 memcpy(&i, id.lista->pt ,sizeof(int));
		 *answer=(double)i;
		 break;

      case 'R':  memcpy(answer, id.lista->pt ,sizeof(double));
		 break;

      case 'C':  char c;
		 memcpy(&c, id.lista->pt ,sizeof(char));
		 *answer=(double)c;
		 break;

      case 0:    serror(3);
    }
   _get_token();
   return;
   }
  serror(0);
}

void _put_back(void)
{
  char *t;
  t=elem;
  for (;*t;t++) pt--;
}

void serror(int error)
{ static char *e[]={
    "Erro de sintaxe",
    "Parenteses incorretos",
    "Erro na express„o",
    "Variavel nao existe"
    };
  printf("\nERRO EXPRESSŽO: %s\nlinha: %d",e[error],numlin);
  exit(1);
}

void _get_token(void)
{
  register char *temp;
  int n;

  tipo=0;
  temp=elem;
  *temp='\0';

  if (!*pt)  return;
  while (*pt=='\t' || *pt==' ' || *pt==13) {
   if (*pt==13) numlin++;
   pt++;  }

  if (strchr("&|<>=#*/%$@^+-()!",*pt)) {
     tipo=_DELIMITER;
     *temp++=*pt;
     switch (*pt++) {
	case '>':if (*pt=='=') { *temp++='='; pt++; } break;
	case '<':if (*pt=='=') { *temp++='='; pt++; } break;
	}
     *temp='\0';
     return;
    }
  if (isalpha(*pt)) {
     while (!_isdelim(*pt)) *temp++=*pt++;
     *temp='\0';
     tipo=_VARIABLE;
     return;
   }
  if (isdigit(*pt)) {
      while (!_isdelim(*pt)) *temp++=*pt++;
      tipo=_NUMBER;
      *temp=0;
   }
}

int _isdelim(char c)
{
  if (strchr(" &|<>=#*/%$@^+-()!",c) || c==13 || c=='\t' || c==0 )
    return 1;
  return 0;
}







