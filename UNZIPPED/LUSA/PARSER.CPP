//  |          __  __
//  |   |  |  |_  |__|
//  |__ |__|  __| |  |
//  ------------------
//  Analisador de expressoes


/* Expression Parser */

#define DELIMITER  1
#define VARIABLE   2
#define NUMBER     3
#define COMMAND    4
#define FIM        10

int isdelim(char c);

char  *prog;
char  token[80];
char  tok_type;


void put_back(void)
{
  char *t;
  t=token;
  for (;*t;t++) prog--;
}

void get_token(void)
{
  register char *temp;

  tok_type=0;
  temp=token;
  *temp='\0';

  if (!*prog)  { tok_type=FIM; return; }
  while (*prog=='\t' || *prog==' ' || *prog==13)
    { if (*prog==13) numlin++; prog++; }

  if (strchr("+!-*/^#$@%=()\\;\",\'",*prog)) {
     tok_type=DELIMITER;
     *temp++=*prog++;
    }
  else if (isalpha(*prog))
       { int n;

	 while (!isdelim(*prog)) *temp++=*prog++;
	 *temp='\0';

	 comandoid=e_comando(token);
	 if (comandoid) {
	   tok_type=COMMAND;
	   return ;
	   }
      if (tok_type==0) tok_type=VARIABLE;
   }
  else if (isdigit(*prog)) {
      while (!isdelim(*prog)) *temp++=*prog++;
      tok_type=NUMBER;
   }
   *temp='\0';
   if (tok_type==0) prog++;
}

int isdelim(char c)
{
  if (strchr(" !+-/*^%#$@=();\"\\,\'",c) || c==9 || c=='\r' || c==0)
    return 1;
  return 0;
}



