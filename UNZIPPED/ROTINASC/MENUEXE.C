/*   MenuExe.c - Exemplo - Rotinas para Menu Pop up.  */

#include<conio.h>
#include<stdlib.h>
#include "menus.h"

void sair(void) /* procedimento de sa¡da */
 {
   textattr(7);
   clrscr();
   exit(1);
 } /*  sair  */

void proc01(void) { mensagem("Op‡„o - Vendedores"); }
void proc02(void) { mensagem("Op‡„o - Descontos"); }
void proc03(void) { mensagem("Op‡„o - Artigos"); }
void proc04(void) { mensagem("Op‡„o - Novas Tabelas"); }
void proc05(void) { mensagem("Op‡„o - Reconstruir tabelas"); }
void proc06(void) { mensagem("Op‡„o - Sair do Programa"); }

void proc07(void) { mensagem("Op‡„o - Inserir Clientes"); }
void proc08(void) { mensagem("Op‡„o - Alterar Clientes"); }
void proc09(void) { mensagem("Op‡„o - Remover Clientes"); }
void proc10(void) { mensagem("Op‡„o - Listar Clientes"); }

void proc11(void) { mensagem("Op‡„o - Inserir Fornecedores"); }
void proc12(void) { mensagem("Op‡„o - Alterar Fornecedores"); }
void proc13(void) { mensagem("Op‡„o - Remover Fornecedores"); }
void proc14(void) { mensagem("Op‡„o - Listar Fornecedores"); }

void proc15(void) { mensagem("Op‡„o - Inserir Documentos"); }
void proc16(void) { mensagem("Op‡„o - Alterar Documentos"); }
void proc17(void) { mensagem("Op‡„o - Anular Documentos"); }
void proc18(void) { mensagem("Op‡„o - Listar Documentos"); }
void proc19(void) { mensagem("Op‡„o - Imprimir Documentos"); }

void proc20(void) { mensagem("Op‡„o - Inserir Movimentos"); }
void proc21(void) { mensagem("Op‡„o - Alterar Movimentos"); }
void proc22(void) { mensagem("Op‡„o - Listar Movimentos"); }
void proc23(void) { mensagem("Op‡„o - Imprimir Movimentos"); }

main()
 {
  MENU tab1[6], tab2[4], tab3[4], tab4[5], tab5[4];  /* menus */
  BARRA barra[5];   /* barra de menus para 5 menus */

    /*  Barra de Menus   */

  menubarra(barra,0,tab1, 4,2," TABELAS ","Manuten‡„o de Tabelas",6,4,3,26,10);
  menubarra(barra,1,tab2,17,2," CLIENTES ","Manuten‡„o de Clientes",4,17,3,27,8);
  menubarra(barra,2,tab3,31,2," FORNECEDORES ","Manuten‡„o de Fornecedores",4,31,3,44,8);
  menubarra(barra,3,tab4,49,2," DOCUMENTOS ","Emiss„o/Altera‡„o/Remo‡„o/Impress„o/Listagem de Documentos",5,49,3,60,9);
  menubarra(barra,4,tab5,64,2," MOVIMENTOS ","Movimentos de Artigos",4,64,3,75,8);

	/*  Menus  */

  menuop(tab1,0,5,4," Vendedores          ","Vendedores - Insers„o/Altera‡„o/Remo‡„o",proc01);
  menuop(tab1,1,5,5," Descontos           ","Descontos - Insers„o/Altera‡„o/Remo‡„o",proc02);
  menuop(tab1,2,5,6," Artigos             ","Artigos - Insers„o/Altera‡„o/Remo‡„o",proc03);
  menuop(tab1,3,5,7," Novas Tabelas       ","Cria‡„o de Novas Tabelas",proc04);
  menuop(tab1,4,5,8," Reconstruir Tabelas ","Reconstruir Tabelas Danificadas",proc05);
  menuop(tab1,5,5,9," Sair do Programa    ","Abandonar o Programa",sair);

  menuop(tab2,0,18,4," Inserir ","Inserir Clientes",proc07);
  menuop(tab2,1,18,5," Alterar ","Alterar Clientes",proc08);
  menuop(tab2,2,18,6," Remover ","Remover Clientes",proc09);
  menuop(tab2,3,18,7," Listar  ","Listagem de Clientes",proc10);

  menuop(tab3,0,32,4,"  Inserir   ","Inserir Fornecedores",proc11);
  menuop(tab3,1,32,5,"  Alterar   ","Alterar Fornecedores",proc12);
  menuop(tab3,2,32,6,"  Remover   ","Remover Fornecedores",proc13);
  menuop(tab3,3,32,7,"  Listar    ","Listagem de Fornecedores",proc14);

  menuop(tab4,0,50,4," Inserir  ","Inserir Documentos",proc15);
  menuop(tab4,1,50,5," Alterar  ","Alterar Documentos",proc16);
  menuop(tab4,2,50,6," Anular   ","Anular Documentos",proc17);
  menuop(tab4,3,50,7," Listar   ","Listagem de Documentos",proc18);
  menuop(tab4,4,50,8," Imprimir ","Impress„o de Documentos",proc19);

  menuop(tab5,0,65,4," Inserir  ","Inserir Movimentos de Artigos",proc20);
  menuop(tab5,1,65,5," Anular   ","Anular Movimentos de Artigos",proc21);
  menuop(tab5,2,65,6," Listar   ","Listagem de Movimentos de Artigos",proc22);
  menuop(tab5,3,65,7," Imprimir ","Impress„o de Movimentos de Artigos",proc23);

  menuprincipal(barra,5); /* barra com 5 op‡”es */

 }

 /* --------  Ficheiro Exemplo Menus Pop Up     ------------ */
