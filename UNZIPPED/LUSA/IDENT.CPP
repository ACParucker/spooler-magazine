//  |          __  __
//  |   |  |  |_  |__|
//  |__ |__|  __| |  |
//  ------------------
//  Lista de identificadores
//  CLASS: Ident
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct lista_reg {
     char nome[16]; // nome
     char tipo;     // tipo
     void *pt;      // ponteiro para os dados
     struct lista_reg *prox;
    };

class Ident {
     struct lista_reg *inicio,*ultimo;
  public:
     struct lista_reg *lista;

	  Ident() {inicio=ultimo=NULL;}
     char soma(char *,char tipo);
     char proc_tipo(char *nome);
 };


char Ident::soma(char *nome,char tipo)
//-----------------------------------
// Entrada: nome e tipo
// Saida: 0  se elemento somado
//        1  se ja existe
//        2  se falta memoria
{
  if (inicio==NULL) {
     ultimo=inicio=new struct lista_reg;
     if (ultimo==NULL) return 2;
     }
  else {
     lista=inicio;
     while (lista!=NULL) {
       if (!strcmp(lista->nome,nome)) return 1;
       lista=lista->prox;
       }
     ultimo->prox=new struct lista_reg;
     if (ultimo->prox==NULL) return 2;
     ultimo=ultimo->prox;
     }

  ultimo->prox=NULL;
  ultimo->tipo=tipo;
  strcpy(ultimo->nome,nome);
  switch (tipo) {
	case 'I':ultimo->pt =  malloc(sizeof (int));
		 break;
	case 'R':ultimo->pt =  malloc(sizeof (double));
		 break;
	case 'C':ultimo->pt =  malloc(sizeof (char));
		 break;
	}
  lista=ultimo;
  return 0;
}

char Ident::proc_tipo(char *nome)
//----------------------
// Entrada: tipo a procurar
// Saida: I,R,C ou +  se encontrou ; Lista -> reg
//        0 se n„o existe
//
{
  lista=inicio;
  while (lista!=NULL) {
    if (!strcmp(lista->nome,nome)) return lista->tipo;
    lista=lista->prox;
    }
  return 0;
}

