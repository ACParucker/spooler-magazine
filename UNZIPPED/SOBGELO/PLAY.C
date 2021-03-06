//---------------------------------------------------------------------------------------------
//                                         P L A Y . C
//
//                   In�cio da jogo propriamente dito - agora vamos ter ac��o
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Vari�veis globais da fonte PLAY.C
//---------------------------------------------------------------------------------------------
static BYTE nComputerQI;   // Intelig�ncia do computador - define o n�vel de jogo do computador
static BYTE nDelay;                   // Velocidade - quanto mais pequeno, mais r�pido � o jogo


//---------------------------------------------------------------------------------------------
//                                                               Fun��es locais da fonte PLAY.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: init_status_line       � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Inicializa a linha de status do jogo, ou seja, o n�mero de bolas a jogar,  �
// �               o atraso (delay), jogadores, etc.                                          �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void init_status_line( void )
{
   Status.balls   = 7;                               // Inicialmente existem 7 bolas para jogar
   Status.player1 = 0;                             // Pontua��o do "player 1" no in�cio do jogo
   Status.player2 = 0;                             // Pontua��o do "player 2" no in�cio do jogo

   cls_bottom_line();                             // Limpa toda a zona do rodap� (�ltima linha)
   write_str( 132, 192, "BOLAS:" );

   if( !nOpponent )                                           // Se o advers�rio � o computador
   {
      write_str(   8, 192, ":COMPUTADOR" );
      write_str( 248, 192, "JOGADOR:" );
   }
   else                                             // Sen�o, ent�o o advers�rio � outra pessoa
   {
      write_str(   8, 192, ":JOGADOR^2" );
      write_str( 232, 192, "JOGADOR^1:" );
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: game_paused            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta � a fun��o que interrompe o jogo em caso de "pausa" (tecla <P>).      �
// �               O jogo permanecer� interrompido at� que a tecla <P> seja novamente         �
// �               pressionada.                                                               �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void game_paused( void )
{
   v_paloff( 1 );                             // Escurece as cores da palette apenas at� metade

   while(  KEY_PAUSE );                           // Aguarda at� que a tecla <P> esteja liberta
   while( !KEY_PAUSE );                       // Aguarda at� que <P> seja novamente pressionado
   while(  KEY_PAUSE );                           // Aguarda at� que a tecla <P> esteja liberta

   v_palon( 1 );      // Rep�e as cores originais da palette (o ecran estava metade escurecido)
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: start_game             � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    In�cio do jogo. BOA SORTE!!!                                               �
// �                                                                                          �
// � Par�metros:   (*player_1)() � um apontador para a fun��o que processa o movimento do     �
// �               paddles grande. Por exemplo, as hip�teses podem ser:                       �
// �                 - se (*player_1)() aponta para a fun��o easy_player_1() ent�o o paddle   �
// �                   grande s� se movimentar� quando enquanto o jogador carregar nas teclas;�
// �               (*opponente)() � um apontador para a fun��o que processa o movimento do    �
// �               paddles do advers�rio (paddle pequeno). Assim, algumas hip�teses s�o:      �
// �                 - se (*opponent)() aponta para a fun��o computer_1() ent�o o advers�rio  �
// �                   � o computador no n�vel de dificuldade 1;                              �
// �                 - se (*opponent)() aponta para a fun��o player_2() ent�o o advers�rio    �
// �                   escolhido � o jogador 2 no mesmo computador do jogador 1;              �
// �               (*move_ball)() � um apontador para a fun��o que processa o movimento da    �
// �               bola. As hip�teses podem ser:                                              �
// �                 - se (*move_ball)() aponta para a fun��o move_ball_01() ent�o a          �
// �                   vari�vel nOpponent � 0 ou 1, isto �, o advers�rio � o computador ou    �
// �                   outro jogador no mesmo PC;                                             �
// �                 - se (*move_ball)() aponta para a fun��o move_ball_2() significa que a   �
// �                   vari�vel nOpponent � igual a 2, ou seja, que o advers�rio � outro      �
// �                   jogador localizado noutro PC.                                          �
// ������������������������������������������������������������������������������������������ͼ
static void start_game( void (*player_1)(void), void (*opponent)(void), void(*move_ball)(void))
{
   if( ( nOpponent != 2 ) || ( nOpponent == 2 && SENDER ) )
      wait_for_SPACE();                         // Aguarda que seja pressionada a tecla <SPACE>

   while( Status.balls )           // Loop at� final do jogo - enquanto houver bolas para jogar
      if( KEY_ESCAPE )                                            // Carregou na tecla <ESCAPE>
	 break;                                                              // Abandona o jogo
      else if( KEY_PAUSE )                                     // Carregou na tecla <P> = PAUSE
	 game_paused();                                         // Rotina que interrompe o jogo
      else
      {
	 delay( nDelay );                                      // Menos delay = mais velocidade

	 (*player_1)();                                 // Rotina que movimenta o paddle grande
	 (*opponent)();                                // Rotina que movimenta o paddle pequeno
	 (*move_ball)();                                         // Rotina que movimenta a bola
      }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: choose_player          � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta � a fun��o que inicia o realmente o jogo, dependendo do advers�rio    �
// �               pr�viamente escolhido pelo utilizador.                                     �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void choose_player( void )
{
   void player_1( void );              // Fun��o que processa o movimento o paddle do jogador 1
   void computer( void );             // Fun��o que processa o movimento o paddle do computador
   void player_2( void );              // Fun��o que processa o movimento o paddle do jogador 2
   void player_2_pc2( void );  // Fun��o que processa o movimento do paddle do jogador 2 no PC2
   void move_ball_01( void );          // Fun��o que movimenta a bola quando nOppenent � 0 ou 1
   void move_ball_2( void );                // Fun��o que movimenta a bola quando nOppenent � 2

   if( !define_level( &nDelay, &nComputerQI ) )                         // Define n�vel do jogo
      return;                                      // Retorna pois o utilizador teclou <ESCAPE>

   if( nOpponent == 2 )                       // Se o advers�rio � um jogador noutro computador
   {
      init_RS232();                                                       // Inicializa a RS232

      if( !sincronize() )                                              // Sincroniza��o com PC2
	 return;                    // Ocorreu um erro durante a sincroniza��o com PC2 - aborta
   }

   if( ( nOpponent != 2 && random( 2 ) ) || ( nOpponent == 2 && SENDER ) )
      start_bpad();                           // Come�a o paddle grande - exibe a bola em baixo
   else
      start_lpad();                           // Come�a o paddle pequeno - exibe a bola em cima

   init_paddles();             // Coloca os paddles nas posi��es correctas e actualiza o status
   init_status_line();                                 // Informa��o inicial da linha de status
   game_status();           // Actualiza o status do jogo (n� de bolas para jogar e pontua��es)

   switch( nOpponent )                  // Verifica quem � o advers�rio antes de come�ar o jogo
   {
      case 0:                                                    // O advers�rio � o computador
	 start_game( player_1, computer, move_ball_01 );                      // In�cio do jogo

	 if( !Status.balls && Status.player1 > Status.player2 ) // jogo acabou E jogador ganhou
	    get_a_highscore( Status.player1 * (MAX_DELAY-nDelay+1) * nComputerQI );    // Score

	 break;
      case 1:                                        // O advers�rio � outra pessoa no mesmo PC
	 start_game( player_1, player_2, move_ball_01 );                      // In�cio do jogo
	 break;
      case 2:                                          // O advers�rio � outra pessoa noutro PC
	 if( SENDER )                                                    // Se a bola sai minha
	    report_pc2( Ball.dir );            // Informa o PC2 qual a direc��o inicial da bola
	 else                                   // Sen�o, ent�o a bola sai do advers�rio no PC2
	    receive_pc2();                        // Recebe a direc��o da bola enviada pelo PC2

	 start_game( player_1, player_2_pc2, move_ball_2 );                   // In�cio do jogo
	 break;
   }
}


//---------------------------------------------------------------------------------------------
//                                                             Fun��es externas da fonte PLAY.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: load_play              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Carrega as imagens dos paddles grande (big) e pequeno (little).            �
// �               As imagens s�o carregadas em mem�ria e podem ser acedidas atrav�s dos      �
// �               apontadores ptrBigPaddle para o paddle grande e ptrLitPaddle para o paddle �
// �               pequeno.                                                                   �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void load_play( void )
{
   randomize();       // Inicializa o gerador de n�meros (o jogo possui par�meteros aleat�rios)

   BigPaddle.ptr = getfile( "PADDLES.BIN", O_BINARY );         // Carrega os paddles em mem�ria
   LitPaddle.ptr = BigPaddle.ptr + 240;                         // Aponta para o paddle pequeno
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: play_sob_gelo          � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Prepara o �nicio do jogo propriamente dito. Antes do jogo come�ar, esta    �
// �               fun��o executa v�rias tarefas, como por exemplo limpar o ecran, limpar o   �
// �               rodap�, etc.                                                               �
// �               Chamo a aten��o para o facto de a fun��o antes de limpar o rodap�, salvar  �
// �               o seu estado actual, para que quando regresse ao menu reponha o rodap� no  �
// �               ponto onde tinha deixado.                                                  �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void play_sob_gelo( void )
{
   BYTE *ptrBuf;                             // Apontador para salvar a imagem actual do rodap�

   if( ( ptrBuf = ( BYTE * )malloc( 2560 ) ) == NULL )  // Se houve erro na aloca��o de mem�ria
      exit_with_error( "Mem�ria" );                     // Informa o erro e regressa para o DOS

   v_getwin( 0, 192, 319, 199, ptrBuf );                     // Salva a imagem actual do rodap�

   v_curtain( 100, 0, 219, 177, 0, 15 );  // Limpa a zona central do ecran com efeito "cortina"
   v_clswin( 0, 192, 319, 199, 0 );               // Limpa toda a zona do rodap� (�ltima linha)

   choose_player();                       // Inicia o jogo de acordo com o advers�rio escolhido

   v_putimage( 0, 192, 320, 8, ptrBuf );          // O jogo terminou - rep�e a imagem do rodap�
   free( ptrBuf );                 // Liberta o espa�o alocado para a imagem anterior do rodap�
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: wait_for_SPACE         � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Espera que o utilizador pressione a tecla <SPACE>. � utilizada para dar    �
// �               in�cio ao jogo. No entanto, a fun��o aceita tamb�m a tecla <ESCAPE>, de    �
// �               modo que se esta tecla for pressionada o jogo abortar� depois de come�ar.  �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void wait_for_SPACE( void )
{
   while( KEY_SPACE );                  // Aguarda - enquanto n�o for libertada a tecla <SPACE>
   while( !( KEY_ESCAPE || KEY_SPACE ) );   // Enquanto n�o premidas teclas <SPACE> ou <ESCAPE>
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: init_paddles           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta fun��o � chamada antes de se come�ar a jogar uma bola, ou seja,       �
// �               quando um novo jogo come�a, ou quando se perde uma bola mas ainda existem  �
// �               bolas para jogar. A fun��o coloca os paddles grande e pequeno nas posi��es �
// �               iniciais.                                                                  �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void init_paddles( void )
{
   BigPaddle.adr = 58065;                      // O big paddle come�a em baixo no meio do ecran
   v_putbigpad( BigPaddle.adr, BigPaddle.ptr );                           // Exibe o big paddle

   if( nOpponent != 2 )             // S� exibe o little paddle se o advers�rio n�o est� no PC2
   {
      LitPaddle.adr = 3031;                  // O little paddle come�a em cima no meio do ecran
      v_putlitpad( LitPaddle.adr, LitPaddle.ptr );                     // Exibe o little paddle
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: game_status            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Actualiza o status do jogo, isto �, pontua��es dos jogadores e n�mero de   �
// �               bolas ainda para jogar.                                                    �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void game_status( void )
{
   char cNrBalls[ 2 ];        // Array do tipo char que aponta o valor da vari�vel Status.balls
   char cScorePl1[ 2 ];     // Array do tipo char que aponta o valor da vari�vel Status.player1
   char cScorePl2[ 2 ];     // Array do tipo char que aponta o valor da vari�vel Status.player2

   itoa( Status.balls,   cNrBalls,  10 );               // Converte Status.balls para caractere
   itoa( Status.player1, cScorePl1, 10 );             // Converte Status.player1 para caractere
   itoa( Status.player2, cScorePl2, 10 );             // Converte Status.player2 para caractere

   write_str( 180, 192, cNrBalls );               // Escreve o n�mero de bolas ainda para jogar
   write_str( 312, 192, cScorePl1 );                        // Escreve a pontua��o do jogador 1
   write_str(   0, 192, cScorePl2 );                        // Escreve a pontua��o do jogador 2
}
