#include <stdio.h>
#include <alloc.h>

#define  ALINHAMENTO	(sizeof(struct {char a; double b;}) - sizeof(double))
#define  MINBLOCK	ALINHAMENTO
#define  sobras		((optimo->tam) - numbytes - sizeof(NODO))
#define  sobras_nodo	((NODO*)((char*)optimo + sizeof(NODO) + numbytes))

typedef struct NO{
    char estado;	/* 'l'->livre ; 'o'->ocupado		*/
    int tam;		/* dimens„o do bloco			*/
    struct NO *next;	/* apontador para o pr¢ximo bloco	*/
}NODO;

NODO* entrada = NULL;	/* nodo global de entrada no bloco	*/


/*
	Lista o conte£do do bloco gerido.
*/
void mapmem(void)
{
    NODO* ex;
    int i;

    if(entrada==NULL)
	 printf("BLOCO vazio\n");
    else{
	 ex = entrada;
	 for(i=0; ex!=NULL; i++){
	      printf("\nEndere‡o do nodo: %p",ex);
	      printf("\tEstado: %c",ex->estado);
	      printf("\tTamanho: %d",ex->tam);
	      printf("\nBloco utilizador: %p",(char*)ex + sizeof(NODO));
	      printf("\tPr¢ximo nodo: %p\n",ex->next);
	      ex = ex->next;
	 }
    }
}


/*
	Alocar mem¢ria. Reserva numbytes e devolve o endere‡o para a zona
pretendida.
*/
char* new(int numbytes)
{
    NODO *optimo, *penultimo, *explorador;

    if(numbytes < MINBLOCK)				/* 1_IF  */
	 numbytes = MINBLOCK;
    else
	 if((numbytes % ALINHAMENTO)!=0)
	      numbytes += ALINHAMENTO - (numbytes % ALINHAMENTO);

    if(entrada==NULL){					/* 2_IF  */
	 entrada = (NODO *)sbrk(sizeof(NODO) + numbytes);
	 if((void*)entrada==(void*)-1)
	      return((char*)(-1));
	 else{
	      ((NODO*)entrada)->estado = 'o';
	      ((NODO*)entrada)->tam = numbytes;
	      ((NODO*)entrada)->next = NULL;
	      return ((char*)((char*)entrada + sizeof(NODO)));
	 }
    }
    else{
	 optimo = NULL;
	 explorador = entrada;
	 while(explorador != NULL){
	      if(explorador->estado=='l'){
		   if(explorador->tam >= numbytes){
			if(optimo==NULL)
			     optimo = explorador;
			else
			     if(optimo->tam > explorador->tam)
				  optimo=explorador;
		   }
	      }
	      penultimo = explorador;
	      explorador = explorador->next;
	 }

	 if(optimo==NULL){				/* 3_IF  */
	      optimo = (NODO*)sbrk(sizeof(NODO)+numbytes);
	      if((void*)optimo==(void*)-1)
		   return((char*)-1);
	      else{
		   penultimo->next = optimo;
		   ((NODO*)optimo)->estado = 'o';
		   ((NODO*)optimo)->tam = numbytes;
		   ((NODO*)optimo)->next = NULL;
		   return((char*)((char*)optimo + sizeof(NODO)));
	      }
	 }
	 else{
	      optimo->estado = 'o';
	      if(sobras >= MINBLOCK){
		   sobras_nodo->estado = 'l';
		   sobras_nodo->tam = sobras;
		   sobras_nodo->next = optimo->next;
		   optimo->next = sobras_nodo;
	      }
	      optimo->tam = numbytes;
	      return((char*)((char*)optimo + sizeof(NODO)));
	 }
    }
}



/*
	Liberta a zona de mem¢ria associada ao ender‡o block.
*/
void dispose(void* block)
{
    NODO *penultimo,*explorador;

    explorador = penultimo = entrada;

    while(explorador!=NULL){
	 if(((char*)explorador + sizeof(NODO))==(char*)block){
	      if(explorador==entrada){				/* 1_IF */
		   explorador->estado = 'l';
		   if(explorador->next!=NULL){
			if((explorador->next)->estado=='l'){
			     explorador->tam += sizeof(NODO)+(explorador->next)->tam;
			     explorador->next = (explorador->next)->next;
			}
		   }
	      }
	      else{
		   if(explorador->next == NULL){		/* 2_IF */
			if(penultimo->estado=='l'){
			     penultimo->tam += sizeof(NODO) + explorador->tam;
			     penultimo->next = NULL;
			}
			else{
			     explorador->estado = 'l';
			}
		   }
		   else{					/* 3_IF */
			if(penultimo->estado=='l'){
			     if((explorador->next)->estado=='l'){
				  penultimo->tam += 2 * sizeof(NODO) + explorador->tam + (explorador->next)->tam;
				  penultimo->next = (explorador->next)->next;
			     }
			     else{
				  penultimo->tam += sizeof(NODO)+explorador->tam;
				  penultimo->next = explorador->next;
			     }
			}
			else{					/* 4_IF */
			     explorador->estado = 'l';
			     if((explorador->next)->estado=='l'){
				  explorador->tam += sizeof(NODO) + (explorador->next)->tam;
				  explorador->next = (explorador->next)->next;
			     }
			}
		   }
	      }
	 explorador = NULL;
	 }
	 else{
	      penultimo = explorador;				/* 5_IF */
	      explorador = explorador->next;
	 }
    }
}



/*
	Um teste …s fun‡”es.
*/
void main(void)
{
    char *s1, *s2, *s3, *s4;


    mapmem();

    printf("\nALOCAR 50 bytes (s1)");
    s1 = new(50);				/* alinhado	*/
    if(s1!=(void *)-1)
	 printf("\nBloco reservado\n");
    else
	 printf("\nERRO\n");

    mapmem();

    printf("\nALOCAR 43 bytes (s2)");
    s2 = new(43);
    if(s2!=(void *)-1)
	 printf("\nBloco reservado\n");
    else
	 printf("\nERRO\n");

    mapmem();

    printf("\nLIBERTAR s2");
    dispose(s2);

    mapmem();

    printf("\nALOCAR 7 bytes (s4)");
    s4 = new(7);
    if(s4!=(void *)-1)
	 printf("\nBloco reservado\n");
    else
	 printf("\nERRO\n");

    mapmem();

    printf("\nALOCAR 71 bytes (s3)");
    s3 = new(71);
    if(s3!=(void *)-1)
	 printf("\nBloco reservado\n");
    else
	 printf("\nERRO\n");

    mapmem();

    printf("\nLIBERTAR s4");
    dispose(s4);

    mapmem();

    printf("\nLIBERTAR s1");
    dispose(s1);

    mapmem();

    printf("\nLIBERTAR s3");
    dispose(s3);

    mapmem();
}

