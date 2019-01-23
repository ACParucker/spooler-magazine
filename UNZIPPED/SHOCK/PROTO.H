                           /* SHOCK Ver 1.0 */
                 /* PROTO.H ú Declara‡„o de prot¢tipos */

/* shock.c */

void main(int argc, char *argv[]);
int cria_SHK(unsigned char filename[]);
void esc_pass(int out_stream,unsigned char password[]);
void esc_header(int out_stream,unsigned char filename[]);
void estatistica(int fprocessed,long percents,int min,int sec);
int cbreak();
void halt();


/* opcoes.c */

void ajuda(char *msg);
void erro(char *msg);
int ver_param(int param_cont, char *param[]);
void mostra_inf(void);
void som();


/* esc_shk.c */

long comprime(int datasize,unsigned char *nofp,long unsigned double proc);
void esc_infodat(int out_stream,unsigned char *nofp,int metodo,int tamdat);
void esc_data_hora(int out_stream);
void esc_compdat(int out_stream, int tam_compdat);
void armazena(int out_stream,unsigned char *filename);


/* analdata.c */

int analdata(int datasize);


/* compdiat.c */

unsigned compdiat(unsigned char *filename);


/* compfil.c */

unsigned compfil(unsigned char *filename);


/* compmap.c */

unsigned compmap(unsigned char *filename);


/* compbyte.c */

unsigned compbyte(unsigned char *filename);


/* comphuff.c */

void sortlist();
void maketree();
unsigned decode();
unsigned comphuff();


/* compsete.c */

unsigned compsete(unsigned char *filename);