
                          /* SHOCK Ver 1.0 */
                     /* Ficheiro de configura‡Æo */


#define TRUE     1        /*   Verdadeiro Boleano                              */
#define FALSE    0        /*   Falso Boleano                                   */
#define ERR_ESC  -1       /*   Erro de Escrita                                 */

#define BUFSIZE  25600    /* Tamanho dos buffers                               */
#define NML      13

#define NAOEXIST -1       /* Indica que n„o existem mais ficheiros a comp.     */
#define EXIST    0        /* Indica que existem mais ficheiros a comp.         */

#define NONE     0           /* Nenhum m‚todo dos 6 a seguir ser  utilizado    */
#define COMPFIL  1           /* Ser  utilizado o m‚todo secund rio COMPFIL     */
#define COMPDIAT 2           /* Ser  utilizado o m‚todo secund rio COMPDIAT    */
#define COMPBYTE 3           /* Ser  utilizado o m‚todo secund rio COMPBYTE    */
#define COMPMAP  4           /* Ser  utilizado o m‚todo secund rio COMPMAP     */
#define COMPSETE 5           /* Ser  utilizado o m‚todo secund rio COMPSETE    */
#define COMPHUFF 6           /* Ser  utilizado o m‚todo COMPSHUFF              */

#define ASSINATURA "\230\127\156\049\048"  /*   Cabe‡alho (Header) do          */
                                          /*     ficheiro comprimido           */

#define SEPARADOR "\243"            /* Separador de informa‡Æo                 */

#define INFODAT   "\232\169"        /*   Delimitada a informa‡Æo sobre         */
                                    /*   o conjunto de dados em seguida        */