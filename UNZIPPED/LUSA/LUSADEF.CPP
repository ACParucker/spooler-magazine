//  |          __  __
//  |   |  |  |_  |__|
//  |__ |__|  __| |  |
//  ------------------
//  Comandos

// Referˆncia aos comandos

#define cmd_PROGRAMA  1
#define cmd_VARIAVEL  2
#define cmd_INTEIRO   3
#define cmd_REAL      4
#define cmd_CARACTER  5
#define cmd_ROTINA    6
#define cmd_FIMROTINA 7
#define cmd_INICIO    8
#define cmd_FIM       9
#define cmd_ESCREVE  10
#define cmd_LIMPA_ECR 11
#define cmd_LE       12
#define cmd_EXECUTA  13
#define cmd_REPETE   14
#define cmd_ATE      15
#define cmd_SE       16
#define cmd_ENTAO    17
#define cmd_SENAO    18
#define cmd_FIMSE    19
#define cmd_ENQUANTO 20
#define cmd_FIMENQUANTO  21
#define cmd_FAZ   22
#define cmd_EMXY  23
#define cmd_SOM   24
#define cmd_DSOM  25

// COMANDOS

struct comando { char *nome; int id; } comandos[]=
      { "PROGRAMA",1,
	"VARIAVEL",2,
	"INTEIRO",3,
	"REAL",4,
	"CARACTER",5,
	"ROTINA",6,
	"FIMROTINA",7,
	"INICIO",8,
	"FIM",9,
	"ESCREVE",10,
	"LIMPA_ECR",11,
	"LE",12,
	"EXECUTA",13,
	"REPETE",14,
	"ATE",15,
	"SE",16,
	"ENTAO",17,
	"SENAO",18,
	"FIMSE",19,
	"ENQUANTO",20,
	"FIMENQUANTO",21,
	"FAZ",22,
	"EMXY",23,
	"SOM",24,
	"DSOM",25 };

char  comandoid;
int   ncomandos=sizeof(comandos)/sizeof(struct comando);

int e_comando(char *s)
// Saida: comandoid  se ‚ um comando
//        0 se nao ‚
{
 int c;
 for (c=0; c<ncomandos; c++)
   if (!strcmp(comandos[c].nome,s)) return comandos[c].id;
 return 0;
}

