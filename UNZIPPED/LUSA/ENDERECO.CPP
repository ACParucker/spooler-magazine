//  |          __  __
//  |   |  |  |_  |__|
//  |__ |__|  __| |  |
//  ------------------
//  Gestor de enderecos
//
// Simula‡„o de uma pilha de ponteiros para char (char *)
//  Objecto: Pilha


class Pilha {
  struct elem {
    char *endereco;
    char tipo;
   } *ini, *fim, *actual;
public:
       Pilha() { ini=fim=actual=NULL; }
       ~Pilha() { free(ini); }
  char define(int tam);
  char Pilha::poe(char *end,char tip);
  char tira();
  char tipo();
  char *end();
};

char Pilha::define(int tam)
// Saida: 0 se Pilha bem definida
//        1 se falta de mem.
{
  if (ini!=NULL) free(ini);

  ini=(struct elem *)malloc(tam*sizeof(struct elem));
  if (ini==NULL) return 1;
  actual=ini;
  fim=ini+tam;
  return 0;
}

char Pilha::poe(char *end,char tip)
// Saida: 0 se ok ,1 se OverFlow
{
  if (actual<fim)
  {  actual->endereco=end;
     actual->tipo=tip;
     actual++;
     return 0; }
  return 1;
}

char Pilha::tira()
// Saida: 0 se ok ,1 se Underflow
{
  if (actual>ini)
  { actual--; return 0; }
  return 1;
}


char Pilha::tipo()
// Saida: 0 se ok ,1 se Underflow
{
  if (actual>ini)
  { char tmp;
    actual--;
    tmp=actual->tipo;
    actual++;
    return tmp; }
  return '\0';
}

char * Pilha::end()
// Saida: 0 se ok ,1 se Underflow
{
  if (actual>ini)
  { char *tmp;
    actual--;
    tmp=actual->endereco;
    actual++;
    return tmp; }
  return '\0';
}

class Pilha endereco;
