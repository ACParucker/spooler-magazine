//  |          __  __
//  |   |  |  |_  |__|
//  |__ |__|  __| |  |
//  ------------------
//  Gestor de Erros

// Referˆncia aos erros

#define err_mem     0
#define err_idndef  1
#define err_iddef   2
#define err_cmdesp  3
#define err_varesp  4
#define err_identesp 5
#define err_pvesp   6
#define err_pvvesp  7
#define err_fimfich 8
#define err_iniesp  9
#define err_under   10
#define err_over    11
#define err_fimciclo 12
#define err_entao   13
#define err_fimrot  14
#define err_rotndef 15
#define err_entaonesp 16
#define err_fimciclonesp 17
#define err_cmdnesp 18
#define err_vesp  19
#define err_atrib 20
#define err_coresp 21


// Mensagens de erro

char *msg_erro[]={
     "Falta de memoria",
     "Ident. n„o definido",
     "Ident. j  definido",
     "Comando esperado",
     "Variavel esperada",
     "Identificador esperado",
     "; esperado",
     ", ou ; esperado",
     "Fim de ficheiro n„o esperado",
     "INICIO esperado",
     "UNDERFLOW de pilha",
     "OVERFLOW de pilha",
     "Falta um fecho de ciclo",
     "Falta um ENTAO",
     "Final de rotina n„o esperado",
     "Rotina n„o definida",
     "ENTAO n„o esperado",
     "Fim de ciclo n„o esperado",
     "Comando n„o esperado",
     ", esperada",
     "Atribui‡„o esperada",
     "Cor esperada"
  };

void fatal(int cod)
{
  printf("\nERRO FATAL: cod: %d \nLinha: %d -> %s\n"
	 ,cod,numlin,msg_erro[cod]);
  exit(cod);
}


