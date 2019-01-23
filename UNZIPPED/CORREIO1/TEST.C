/* Esta rotina serve para testar a livraria printer.c */

#include <printer.c>
#include <stdio.h>
void main()
{
/*--------------- Modo 1 ----------------*/
preset;
pprintxy(12,12,"Oi!");
pprintxy(12,13,"Como v„o as coisas?");
pprintxy(40,30,"Ÿptimo!!! E que tal o pardal?");
pprintxy(12,20,"Est  bem desenhado, talvez n„o!");
pprintxy(20,42,"Para a revista Spooler");
pprintxy(1,43,"Em resposta … proposta da revista 34 no Correio dos Leitores");
pprintxy(2,45,"Jos‚ Tom s apresenta a sua solu‡„o em C e Pascal");
ptopage;

/*--------------- Modo 2 ----------------*/
preset;
pxy(40,4);
pprint("Experiˆncia");
pprint("In¡cio\n");
pprint("In¡cio-Fim (Experiˆncia)");
}
