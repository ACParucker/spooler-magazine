/* Livraria de rotinas para simular a impressao postscript em */
/* impressoras matriciais comuns.                             */
/*                                                            */
/* PRINTER.C - Conjunto de rotinas para trabalhar com         */
/*             impressora do tipo matricial (Proprinter)      */
/*             elaboradas por Jos‚ Fortunato H. Tom s         */
/*                                                            */
/* Pequena Explicac„o: O leitor Hugo Flipe Cruz pedia uma     */
/*     rotina ou um truque que fizesse o mesmo que o gotoxy   */
/*     no ecr„  mas s¢ que desta vez na impressora.           */
/*     Para os mais leigos as comunica‡”es com a impressora   */
/*     fazem-se na maioria das vezes por meio de sequˆncias   */
/*     de caracteres, caracteres esses que correspondem a     */
/*     ordens, sendo por esse meio que tentei dar uma         */
/*     resposta poss¡vel ao pedido feito!                     */
/*                                                            */
/*                                                            */
/* Nota: Estas rotinas foram feitas em TURBO C++ e de seguida */
/*       convertidas para TURBO PASCAL                        */
/*                                                            */


#include <stdio.h>
/* ++++++++ Rotina para limpar buffer da impressora ++++++++ */
void preset(void)
{
FILE *fprn;
fprn = fopen("prn","wb");
fprintf(fprn,"%c@",27);
fclose(fprn);}

/* ++++++++ Rotina para localizar a impressora ++++++++ */
/* ++++++++ no topo da p gina                  ++++++++ */
void ptopage()
{
FILE *fprnxy;
fprnxy = fopen("prn","wb");
fprintf(fprnxy,"%c%c",27,12);
fclose(fprnxy);}

/* ++++++++ Rotina equivalente a printf para escrever ++++++++ */
/* ++++++++ na impressora tal como no ecr„            ++++++++ */
void pprint(char *str)
{
FILE *fprn;
fprn = fopen("prn","w");
fprintf(fprn,"%s%c",str);
fclose(fprn);}

/* ++++++++ Rotina equivalente a gotoxy para localizar ++++++++ */
/* ++++++++ o cursor na impressora tal como no ecr„    ++++++++ */
void pxy(int x, int y)
{
FILE *fprnxy;
int i;i=0;
fprnxy = fopen("prn","wb");
fprintf(fprnxy,"%c%c",27,12);
while (i!=y) { fprintf(fprnxy,"\n"); i++; } i=0;
while (i!=x) { fprintf(fprnxy," "); i++; } i=0;
fclose(fprnxy);}

/* ++++++++ Rotina para escrever uma string na impressora ++++++++ */
/* ++++++++ em posicao (x,y) a definir                    ++++++++ */
void pprintxy(int x, int y, char *str)
{
FILE *fprnxy;
int i;i=0;
fprnxy = fopen("prn","w");
fprintf(fprnxy,"%c%c",27,12);
while (i!=y) { fprintf(fprnxy,"\n"); i++; } i=0;
while (i!=x) { fprintf(fprnxy," "); i++; } i=0;
fprintf(fprnxy,"%s%c",str,13);
fclose(fprnxy);
}
