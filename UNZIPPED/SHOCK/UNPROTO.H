                           /* SHOCK Ver 1.0 */
                 /* PROTO.H ú Declara‡Æo de prot¢tipos */

/* unshock.c */

void main(int argc, char *argv[]);
int cria_outfile(unsigned char filename[]);
void ver_password(char pass[]);
void le_header(int in_stream);
void estatistica(int fprocessed);
void coloca_data_hora(int stream,unsigned char filename[]);
int cbreak();
void halt();


/* unopcoes.c */

void ajuda(char *msg);
void erro(char *msg);
void ver_param(int param_cont, char *param[]);
void mostra_inf(unsigned char compfiles[]);
void som();


/* le_shk.c */

void descomprime(int stream,int metodo,unsigned char nofp[]);
int le_ID(int stream);
void le_data_hora(char aux[],int i);
void repoe(int stream,unsigned char nofp[],int tamdat);
void erro_fileSHK();


/* descdiat.c */

unsigned descdiat(unsigned char filename[]);


/* descfil.c */

unsigned descfil(unsigned char filename[]);


/* descmap.c */

unsigned descmap(unsigned char filename[]);


/* descbyte.c */

unsigned descbyte(unsigned char filename[]);


/* deschuff.c */

void sortlist();
void maketree();
unsigned decode();
unsigned deschuff(unsigned char filename[]);


/* descsete.c */

unsigned descsete(unsigned char filename[]);