//---------------------------------------------------------------------------------------------
//                                       G L O B A L . H
//
//                        Constantes e vari veis globais do jogo Sob-Gelo
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                                                   Constantes
//---------------------------------------------------------------------------------------------
#define VIDEO           0xA000                           // Segmento (segment) da mem¢ria video
#define BYTE            unsigned char
#define WORD            unsigned int
#define BOOLEAN         int
#define TRUE            1
#define FALSE           0


//---------------------------------------------------------------------------------------------
//                                                                          Constantes Sob-Gelo
//---------------------------------------------------------------------------------------------
#define MAX_DELAY        8        // Valor m ximo do delay do jogo (se maior = jogo mais lento)
#define SYN             30                                   // Synchronous Idle - comunica‡”es
#define BALL_LOSTED     40              // Byte a enviar quando perde um jogador - comunica‡”es


//---------------------------------------------------------------------------------------------
//                                                                                       Macros
//---------------------------------------------------------------------------------------------

// ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
// º Nome: ODD                    ³ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) º
// ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
// º Objectivo:    Esta fun‡„o ‚ uma macro que verifica se um n£mero ‚ par ou ¡mpar.          º
// º                                                                                          º
// º Parƒmeteros:  nNr ‚ o n£mero a testar.                                                   º
// º                                                                                          º
// º Retorna:      TRUE se nNr ‚ ¡mpar;                                                       º
// º               FASLE se nNr ‚ par.                                                        º
// ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
#define ODD( nNr )                                   ( nNr % 2 )


//---------------------------------------------------------------------------------------------
//                                                    Apontadores para todas as imagens do jogo
//---------------------------------------------------------------------------------------------
BYTE *ptrName;                         // Apontador para a imagem logotipo do jogo - "SOB-GELO"
BYTE *ptrLetters;                         // Apontador para o in¡cio das imagens dos caracteres
BYTE *ptrMenu;   // Apontador p/ in¡cio das imagens das teclas do menu + "MENU" + "Advers rio:"
BYTE *ptrScores;       // Apontador para a imagem da tabela dos scores - "OS MELHORES SOB-GELO"
BYTE *ptrNewScore;                 // Apontador para a imagem do quadro "PARABNS" (novo score)
BYTE *ptrDifiBox;                            // Apontador para a imagem do quadro "Dificuldade"
BYTE *ptrVeloBox;                             // Apontador para a imagem do quadro "Velocidade"
BYTE *ptrDifiCurs;    // Apontador p/ imagem do cursor do potenci¢metro do quadro "Dificuldade"
BYTE *ptrVeloCurs;     // Apontador p/ imagem do cursor do potenci¢metro do quadro "Velocidade"


//---------------------------------------------------------------------------------------------
//                             Estrutura de informa‡„o dos objectos animados do jogo "Sob-Gelo"
//---------------------------------------------------------------------------------------------
// Estrutura de informa‡„o da bola
struct { WORD adr;                                 // Endere‡o da bola no ecran (mem¢ria video)
	 int dir;                         // Direc‡„o (setido) em que a bola se est  a deslocar
	 int plan;           // Plano da bola - existem 6 bolas, logo existem 6 planos - [0..5]
	 int line;                              // Contador para as linhas dentro de cada plano
       } Ball;

// Estrutura de informa‡„o do paddle grande (paddle inferior)
struct { BYTE *ptr;                             // Apontador para a imagem do paddle em mem¢ria
	 WORD adr;                               // Endere‡o do paddle no ecran (mem¢ria video)
       } BigPaddle;

// Estrutura de informa‡„o do paddle pequeno (paddle superior)
struct { BYTE *ptr;                             // Apontador para a imagem do paddle em mem¢ria
	 WORD adr;                               // Endere‡o do paddle no ecran (mem¢ria video)
       } LitPaddle;


//---------------------------------------------------------------------------------------------
//                                                         Outras estruturas do jogo "Sob-Gelo"
//---------------------------------------------------------------------------------------------
// Estrutura de informa‡„o do status do jogo
struct { int balls;                                               // N£mero de bolas para jogar
	 int player1;                            // N£mero de golos conseguidos pelo "player 1"
	 int player2;                            // N£mero de golos conseguidos pelo "player 2"
       } Status;


//---------------------------------------------------------------------------------------------
//                                                                            Vari veis globais
//---------------------------------------------------------------------------------------------
BYTE nOpponent = 0;              // Advers rio: 0 = Computador; 1 = Jogador2; 2 = Jogador2(PC2)

BOOLEAN KEYPRESSED = FALSE,                     // Vari vel booleana: alguma tecla pressionada?
	KEY_RIGHT  = FALSE,                     // Vari vel booleana: arrow-key up   (direita)
	KEY_LEFT   = FALSE,                     // Vari vel booleana: arrow-key left (esquerda)
	KEY_UP     = FALSE,                     // Vari vel booleana: arrow-key up   (cima)
	KEY_DOWN   = FALSE,                     // Vari vel booleana: arrow-key down (baixo)
	KEY_ENTER  = FALSE,                     // Vari vel booleana: tecla <ENTER>
	KEY_ESCAPE = FALSE,                     // Vari vel booleana: tecla <ESCAPE>
	KEY_SPACE  = FALSE,                     // Vari vel booleana: tecla <SPACE>
	KEY_PAUSE  = FALSE,                     // Vari vel booleana: tecla <P>
	KEY_Z      = FALSE,                     // Vari vel booleana: tecla <Z>
	KEY_C      = FALSE;                     // Vari vel booleana: tecla <C>

BOOLEAN SENDER;        // Indica se este PC ‚ ou n„o o emissor - utilizada para as comunica‡”es
BOOLEAN UserAborted;                // Indica se a comunica‡„o foi interrompida pelo utilizador
BOOLEAN TimeOut;                    // Indica se acabou o tempo de espera por dados do outro PC


//---------------------------------------------------------------------------------------------
//                                                                                      Palette
//---------------------------------------------------------------------------------------------
static char palette[ 768 ] =
   {  0,  0,  0,  0,  0, 42,  0, 42,  0,  0, 42, 42, 63, 10, 10, 42,  0, 42, 42, 21,  0, 42, 42, 42,
     30, 30, 30, 21, 21, 63, 21, 63, 21, 21, 63, 63, 63,  0,  0, 63,  0, 63, 63, 63, 18, 63, 63, 63,

     60, 60, 60, 57, 57, 57, 54, 54, 54, 51, 51, 51, 48, 48, 48, 45, 45, 45, 42, 42, 42, 39, 39, 39,
     36, 36, 36, 33, 33, 33, 30, 30, 30, 27, 27, 27, 24, 24, 24, 21, 21, 21, 18, 18, 18, 15, 15, 15,

      0,  0, 18,  5,  5, 10,  7,  7, 24, 10, 11, 27, 14, 14, 30, 17, 18, 33, 21, 21, 36, 24, 25, 39,
     28, 28, 42, 31, 32, 45, 35, 35, 48, 38, 39, 51, 42, 42, 54, 45, 46, 57, 49, 49, 60, 52, 53, 63,

     45, 63, 63, 42, 60, 60, 39, 57, 57, 36, 54, 54, 33, 51, 51, 30, 48, 48, 27, 45, 45, 24, 42, 42,
     21, 39, 39, 18, 36, 36, 15, 33, 33, 12, 31, 31,  9, 28, 28,  6, 25, 25,  3, 22, 22,  0, 19, 19,

      0, 26,  0,  3, 28,  1,  7, 30,  3, 10, 32,  4, 14, 34,  6, 17, 36,  7, 21, 38,  9, 24, 40, 10,
     28, 42, 12, 31, 44, 13, 35, 46, 15, 38, 48, 16, 42, 50, 18, 45, 52, 19, 49, 54, 21, 52, 56, 22,

     63, 60, 45, 60, 57, 42, 57, 54, 39, 54, 51, 36, 51, 48, 33, 48, 45, 30, 45, 42, 27, 42, 39, 24,
     39, 36, 21, 36, 33, 18, 33, 30, 15, 30, 27, 12, 27, 24,  9, 24, 21,  6, 21, 18,  3, 18, 15,  0,

     32,  3,  0, 34,  7,  3, 36, 11,  6, 38, 15,  9, 40, 19, 12, 42, 23, 15, 44, 27, 18, 46, 31, 21,
     48, 35, 24, 50, 39, 27, 52, 43, 30, 54, 47, 33, 56, 51, 36, 58, 55, 39, 60, 59, 42, 62, 63, 45,

     63, 56, 60, 60, 53, 56, 57, 50, 52, 54, 47, 48, 51, 44, 44, 49, 41, 40, 46, 38, 36, 43, 35, 32,
     40, 32, 28, 37, 29, 24, 34, 26, 20, 31, 23, 16, 28, 20, 12, 25, 17,  8, 22, 14,  4, 19, 11,  0,

     48,  3,  0, 49,  7,  2, 50, 11,  4, 51, 15,  6, 52, 19,  8, 53, 23, 10, 54, 27, 12, 55, 31, 14,
     56, 35, 16, 57, 39, 18, 58, 43, 20, 59, 47, 22, 60, 51, 24, 61, 55, 26, 62, 59, 28, 63, 63, 30,

     61, 63, 44, 59, 60, 45, 57, 57, 46, 55, 54, 47, 53, 51, 48, 51, 48, 49, 49, 45, 50, 47, 42, 51,
     45, 39, 52, 43, 36, 53, 41, 33, 54, 39, 30, 55, 37, 27, 56, 35, 24, 57, 33, 21, 58, 31, 18, 59,

     63, 63,  0, 63, 48, 18, 63, 63, 63, 51, 50, 60, 52, 50, 59, 53, 50, 58, 54, 50, 57, 55, 50, 56,
     56, 50, 55, 57, 50, 54, 58, 50, 53, 59, 50, 52, 60, 50, 51, 61, 50, 50, 62, 50, 49, 63, 50, 48,

     60, 49, 47, 56, 47, 44, 52, 45, 41, 48, 43, 38, 44, 41, 35, 40, 39, 32, 36, 37, 29, 32, 35, 26,
     28, 33, 23, 24, 31, 20, 20, 29, 17, 16, 27, 14, 12, 25, 11,  8, 23,  8,  4, 21,  5,  0, 19,  2,

     18, 33, 18, 21, 35, 20, 24, 37, 22, 27, 39, 24, 30, 41, 26, 33, 43, 28, 36, 45, 30, 39, 47, 32,
     42, 49, 34, 45, 51, 36, 48, 53, 38, 51, 55, 40, 54, 57, 42, 57, 59, 44, 60, 61, 46, 63, 63, 48,

     62, 60, 43, 62, 56, 44, 61, 52, 45, 61, 48, 46, 60, 44, 47, 60, 40, 48, 59, 36, 49, 59, 32, 50,
     58, 28, 51, 58, 24, 52, 57, 20, 53, 57, 16, 54, 56, 12, 55, 56,  8, 56, 55,  4, 57, 55,  0, 58,

     28, 18, 29, 30, 20, 31, 32, 22, 33, 34, 24, 35, 36, 26, 37, 38, 28, 39, 40, 30, 41, 42, 32, 43,
     44, 34, 45, 46, 36, 47, 48, 38, 49, 50, 40, 51, 52, 42, 53, 54, 44, 55, 56, 46, 57, 58, 48, 59,

     63, 48, 60, 63, 45, 57, 63, 42, 54, 63, 39, 51, 63, 36, 48, 63, 33, 45, 63, 30, 42, 63, 27, 39,
     63, 24, 36, 63, 21, 33, 63, 18, 30, 63, 15, 27, 63, 12, 24, 63,  9, 21, 63, 6, 18, 63,  3,  15
   };


//---------------------------------------------------------------------------------------------
//                             Prot¢tipos das fun‡”es externas implementadas na fonte EXECUTE.C
//---------------------------------------------------------------------------------------------
void init_sob_gelo( void );
void menu_sob_gelo( void );
void exit_sob_gelo( void );


//---------------------------------------------------------------------------------------------
//                               Prot¢tipos das fun‡”es externas implementadas na fonte VIDEO.C
//---------------------------------------------------------------------------------------------
void v_fadein  ( int, int, WORD, char *, int *);                  // Autor: Jorge A. C. Morgado
void v_imgup   ( int, int, int, int, int, BYTE *, BYTE );
void v_winup   ( int, int, int, int, int, BYTE );
void v_clswin  ( int, int, int, int, BYTE );
void v_curtain ( int, int, int, int, BYTE, int );
void v_putbigpad  ( WORD, BYTE * );                                    // Fun‡”es espec¡ficas
void v_vlinebigpad( WORD );                                            // para o paddle grande
void v_putlitpad  ( WORD, BYTE * );                                    // Fun‡”es espec¡ficas
void v_vlinelitpad( WORD );                                            // para o paddle pequeno
void v_putball  ( WORD, int, int, BYTE * );                            // Fun‡”es
void v_hlineball( WORD, int );                                         // espec¡ficas
void v_vlineball( WORD, int );                                         // para a bola
void v_mode     ( char );
void v_putpal   ( char *, int , int );
void v_getpal   ( char *, int , int );
void v_paloff   ( BYTE );
void v_palon    ( BYTE );
void v_putimage ( int, int, int, int, BYTE * );
void v_hline    ( int, int, int, BYTE );
void v_vline    ( int, int, int, BYTE );
void v_box      ( int, int, int, int, BYTE );
void v_pixel    ( int, int, char );
void v_getwin   ( int, int, int, int, char * );


//---------------------------------------------------------------------------------------------
//                               Prot¢tipos das fun‡”es externas implementadas na fonte SOUND.C
//---------------------------------------------------------------------------------------------
void s_ball_hit_wall  ( void );
void s_ball_hit_paddle( void );
void s_lost_ball      ( void );
void s_out_of_range   ( void );


//---------------------------------------------------------------------------------------------
//                            Prot¢tipos das fun‡”es externas implementadas na fonte KEYBOARD.C
//---------------------------------------------------------------------------------------------
void           k_set     ( void );
void           k_reset   ( void );
void interrupt k_sob_gelo( void );


//---------------------------------------------------------------------------------------------
//                               Prot¢tipos das fun‡”es externas implementadas na fonte ERROR.C
//---------------------------------------------------------------------------------------------
void exit_with_error( char * );


//---------------------------------------------------------------------------------------------
//                            Prot¢tipos das fun‡”es externas implementadas na fonte MISCELAN.C
//---------------------------------------------------------------------------------------------
void load_letters ( void );
void load_name    ( void );
void back_letters ( void );
void cls_game_area( void );
void write_str    ( int, int, char * );
BYTE *getfile     ( char *, const int );


//---------------------------------------------------------------------------------------------
//                                Prot¢tipos das fun‡”es externas implementadas na fonte MENU.C
//---------------------------------------------------------------------------------------------
void load_menu   ( void );
BYTE menu_process( BYTE );


//---------------------------------------------------------------------------------------------
//                              Prot¢tipos das fun‡”es externas implementadas na fonte SCORES.C
//---------------------------------------------------------------------------------------------
void load_scores    ( void );
void scores_display ( void );
void get_a_highscore( int );


//---------------------------------------------------------------------------------------------
//                                Prot¢tipos das fun‡”es externas implementadas na fonte PLAY.C
//---------------------------------------------------------------------------------------------
void load_play     ( void );
void play_sob_gelo ( void );
void wait_for_SPACE( void );
void init_paddles  ( void );
void game_status   ( void );


//---------------------------------------------------------------------------------------------
//                              Prot¢tipos das fun‡”es externas implementadas na fonte LEVELS.C
//---------------------------------------------------------------------------------------------
void    load_levels ( void );
BOOLEAN define_level( BYTE *, BYTE * );


//---------------------------------------------------------------------------------------------
//                               Prot¢tipos das fun‡”es externas implementadas na fonte RS232.C
//---------------------------------------------------------------------------------------------
void    init_RS232   ( void );
void    wait_for_data( void );
void    write_RS232  ( BYTE );
BYTE    read_RS232   ( void );
BOOLEAN data_ready   ( void );


//---------------------------------------------------------------------------------------------
//                            Prot¢tipos das fun‡”es externas implementadas na fonte SYNCRONZ.C
//---------------------------------------------------------------------------------------------
BOOLEAN sincronize( void );


//---------------------------------------------------------------------------------------------
//                                Prot¢tipos das fun‡”es externas implementadas na fonte BALL.C
//---------------------------------------------------------------------------------------------
void ball_goes_dn ( void );
void bp_hitball   ( void );
void load_ball    ( void );
void start_bpad   ( void );
void start_lpad   ( void );
void eval_balldir ( void );
void ball_hit_wall( void );
void move_ball_01 ( void );


//---------------------------------------------------------------------------------------------
//                             Prot¢tipos das fun‡”es externas implementadas na fonte BALLPC2.C
//---------------------------------------------------------------------------------------------
void report_pc2 ( BYTE );
void receive_pc2( void );
void move_ball_2( void );


//---------------------------------------------------------------------------------------------
//                            Prot¢tipos das fun‡”es externas implementadas na fonte BIGPADLE.C
//---------------------------------------------------------------------------------------------
void player_1( void );


//---------------------------------------------------------------------------------------------
//                            Prot¢tipos das fun‡”es externas implementadas na fonte LITPADLE.C
//---------------------------------------------------------------------------------------------
void move_lpad( int );


//---------------------------------------------------------------------------------------------
//                            Prot¢tipos das fun‡”es externas implementadas na fonte COMPUTER.C
//---------------------------------------------------------------------------------------------
void computer( void );


//---------------------------------------------------------------------------------------------
//                             Prot¢tipos das fun‡”es externas implementadas na fonte PLAYER2.C
//---------------------------------------------------------------------------------------------
void player_2    ( void );
void player_2_pc2( void );


