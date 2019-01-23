//---------------------------------------------------------------------------------------------
//                                         P L A Y . C
//
//                   Inกcio da jogo propriamente dito - agora vamos ter aco
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Vari veis globais da fonte PLAY.C
//---------------------------------------------------------------------------------------------
static BYTE nComputerQI;   // Inteligncia do computador - define o nกvel de jogo do computador
static BYTE nDelay;                   // Velocidade - quanto mais pequeno, mais r pido  o jogo


//---------------------------------------------------------------------------------------------
//                                                               Fun”es locais da fonte PLAY.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: init_status_line       ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inicializa a linha de status do jogo, ou seja, o nฃmero de bolas a jogar,  บ
// บ               o atraso (delay), jogadores, etc.                                          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void init_status_line( void )
{
   Status.balls   = 7;                               // Inicialmente existem 7 bolas para jogar
   Status.player1 = 0;                             // Pontuao do "player 1" no inกcio do jogo
   Status.player2 = 0;                             // Pontuao do "player 2" no inกcio do jogo

   cls_bottom_line();                             // Limpa toda a zona do rodap (ฃltima linha)
   write_str( 132, 192, "BOLAS:" );

   if( !nOpponent )                                           // Se o advers rio  o computador
   {
      write_str(   8, 192, ":COMPUTADOR" );
      write_str( 248, 192, "JOGADOR:" );
   }
   else                                             // Seno, ento o advers rio  outra pessoa
   {
      write_str(   8, 192, ":JOGADOR^2" );
      write_str( 232, 192, "JOGADOR^1:" );
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: game_paused            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta  a funo que interrompe o jogo em caso de "pausa" (tecla <P>).      บ
// บ               O jogo permanecer  interrompido at que a tecla <P> seja novamente         บ
// บ               pressionada.                                                               บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void game_paused( void )
{
   v_paloff( 1 );                             // Escurece as cores da palette apenas at metade

   while(  KEY_PAUSE );                           // Aguarda at que a tecla <P> esteja liberta
   while( !KEY_PAUSE );                       // Aguarda at que <P> seja novamente pressionado
   while(  KEY_PAUSE );                           // Aguarda at que a tecla <P> esteja liberta

   v_palon( 1 );      // Rep”e as cores originais da palette (o ecran estava metade escurecido)
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: start_game             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inกcio do jogo. BOA SORTE!!!                                               บ
// บ                                                                                          บ
// บ Parmetros:   (*player_1)()  um apontador para a funo que processa o movimento do     บ
// บ               paddles grande. Por exemplo, as hipขteses podem ser:                       บ
// บ                 - se (*player_1)() aponta para a funo easy_player_1() ento o paddle   บ
// บ                   grande sข se movimentar  quando enquanto o jogador carregar nas teclas;บ
// บ               (*opponente)()  um apontador para a funo que processa o movimento do    บ
// บ               paddles do advers rio (paddle pequeno). Assim, algumas hipขteses so:      บ
// บ                 - se (*opponent)() aponta para a funo computer_1() ento o advers rio  บ
// บ                    o computador no nกvel de dificuldade 1;                              บ
// บ                 - se (*opponent)() aponta para a funo player_2() ento o advers rio    บ
// บ                   escolhido  o jogador 2 no mesmo computador do jogador 1;              บ
// บ               (*move_ball)()  um apontador para a funo que processa o movimento da    บ
// บ               bola. As hipขteses podem ser:                                              บ
// บ                 - se (*move_ball)() aponta para a funo move_ball_01() ento a          บ
// บ                   vari vel nOpponent  0 ou 1, isto , o advers rio  o computador ou    บ
// บ                   outro jogador no mesmo PC;                                             บ
// บ                 - se (*move_ball)() aponta para a funo move_ball_2() significa que a   บ
// บ                   vari vel nOpponent  igual a 2, ou seja, que o advers rio  outro      บ
// บ                   jogador localizado noutro PC.                                          บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void start_game( void (*player_1)(void), void (*opponent)(void), void(*move_ball)(void))
{
   if( ( nOpponent != 2 ) || ( nOpponent == 2 && SENDER ) )
      wait_for_SPACE();                         // Aguarda que seja pressionada a tecla <SPACE>

   while( Status.balls )           // Loop at final do jogo - enquanto houver bolas para jogar
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: choose_player          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta  a funo que inicia o realmente o jogo, dependendo do advers rio    บ
// บ               prviamente escolhido pelo utilizador.                                     บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void choose_player( void )
{
   void player_1( void );              // Funo que processa o movimento o paddle do jogador 1
   void computer( void );             // Funo que processa o movimento o paddle do computador
   void player_2( void );              // Funo que processa o movimento o paddle do jogador 2
   void player_2_pc2( void );  // Funo que processa o movimento do paddle do jogador 2 no PC2
   void move_ball_01( void );          // Funo que movimenta a bola quando nOppenent  0 ou 1
   void move_ball_2( void );                // Funo que movimenta a bola quando nOppenent  2

   if( !define_level( &nDelay, &nComputerQI ) )                         // Define nกvel do jogo
      return;                                      // Retorna pois o utilizador teclou <ESCAPE>

   if( nOpponent == 2 )                       // Se o advers rio  um jogador noutro computador
   {
      init_RS232();                                                       // Inicializa a RS232

      if( !sincronize() )                                              // Sincronizao com PC2
	 return;                    // Ocorreu um erro durante a sincronizao com PC2 - aborta
   }

   if( ( nOpponent != 2 && random( 2 ) ) || ( nOpponent == 2 && SENDER ) )
      start_bpad();                           // Comea o paddle grande - exibe a bola em baixo
   else
      start_lpad();                           // Comea o paddle pequeno - exibe a bola em cima

   init_paddles();             // Coloca os paddles nas posi”es correctas e actualiza o status
   init_status_line();                                 // Informao inicial da linha de status
   game_status();           // Actualiza o status do jogo (nง de bolas para jogar e pontua”es)

   switch( nOpponent )                  // Verifica quem  o advers rio antes de comear o jogo
   {
      case 0:                                                    // O advers rio  o computador
	 start_game( player_1, computer, move_ball_01 );                      // Inกcio do jogo

	 if( !Status.balls && Status.player1 > Status.player2 ) // jogo acabou E jogador ganhou
	    get_a_highscore( Status.player1 * (MAX_DELAY-nDelay+1) * nComputerQI );    // Score

	 break;
      case 1:                                        // O advers rio  outra pessoa no mesmo PC
	 start_game( player_1, player_2, move_ball_01 );                      // Inกcio do jogo
	 break;
      case 2:                                          // O advers rio  outra pessoa noutro PC
	 if( SENDER )                                                    // Se a bola sai minha
	    report_pc2( Ball.dir );            // Informa o PC2 qual a direco inicial da bola
	 else                                   // Seno, ento a bola sai do advers rio no PC2
	    receive_pc2();                        // Recebe a direco da bola enviada pelo PC2

	 start_game( player_1, player_2_pc2, move_ball_2 );                   // Inกcio do jogo
	 break;
   }
}


//---------------------------------------------------------------------------------------------
//                                                             Fun”es externas da fonte PLAY.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: load_play              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Carrega as imagens dos paddles grande (big) e pequeno (little).            บ
// บ               As imagens so carregadas em memขria e podem ser acedidas atravs dos      บ
// บ               apontadores ptrBigPaddle para o paddle grande e ptrLitPaddle para o paddle บ
// บ               pequeno.                                                                   บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void load_play( void )
{
   randomize();       // Inicializa o gerador de nฃmeros (o jogo possui parmeteros aleatขrios)

   BigPaddle.ptr = getfile( "PADDLES.BIN", O_BINARY );         // Carrega os paddles em memขria
   LitPaddle.ptr = BigPaddle.ptr + 240;                         // Aponta para o paddle pequeno
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: play_sob_gelo          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Prepara o กnicio do jogo propriamente dito. Antes do jogo comear, esta    บ
// บ               funo executa v rias tarefas, como por exemplo limpar o ecran, limpar o   บ
// บ               rodap, etc.                                                               บ
// บ               Chamo a ateno para o facto de a funo antes de limpar o rodap, salvar  บ
// บ               o seu estado actual, para que quando regresse ao menu reponha o rodap no  บ
// บ               ponto onde tinha deixado.                                                  บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void play_sob_gelo( void )
{
   BYTE *ptrBuf;                             // Apontador para salvar a imagem actual do rodap

   if( ( ptrBuf = ( BYTE * )malloc( 2560 ) ) == NULL )  // Se houve erro na alocao de memขria
      exit_with_error( "Memขria" );                     // Informa o erro e regressa para o DOS

   v_getwin( 0, 192, 319, 199, ptrBuf );                     // Salva a imagem actual do rodap

   v_curtain( 100, 0, 219, 177, 0, 15 );  // Limpa a zona central do ecran com efeito "cortina"
   v_clswin( 0, 192, 319, 199, 0 );               // Limpa toda a zona do rodap (ฃltima linha)

   choose_player();                       // Inicia o jogo de acordo com o advers rio escolhido

   v_putimage( 0, 192, 320, 8, ptrBuf );          // O jogo terminou - rep”e a imagem do rodap
   free( ptrBuf );                 // Liberta o espao alocado para a imagem anterior do rodap
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: wait_for_SPACE         ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Espera que o utilizador pressione a tecla <SPACE>.  utilizada para dar    บ
// บ               inกcio ao jogo. No entanto, a funo aceita tambm a tecla <ESCAPE>, de    บ
// บ               modo que se esta tecla for pressionada o jogo abortar  depois de comear.  บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void wait_for_SPACE( void )
{
   while( KEY_SPACE );                  // Aguarda - enquanto no for libertada a tecla <SPACE>
   while( !( KEY_ESCAPE || KEY_SPACE ) );   // Enquanto no premidas teclas <SPACE> ou <ESCAPE>
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: init_paddles           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta funo  chamada antes de se comear a jogar uma bola, ou seja,       บ
// บ               quando um novo jogo comea, ou quando se perde uma bola mas ainda existem  บ
// บ               bolas para jogar. A funo coloca os paddles grande e pequeno nas posi”es บ
// บ               iniciais.                                                                  บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void init_paddles( void )
{
   BigPaddle.adr = 58065;                      // O big paddle comea em baixo no meio do ecran
   v_putbigpad( BigPaddle.adr, BigPaddle.ptr );                           // Exibe o big paddle

   if( nOpponent != 2 )             // Sข exibe o little paddle se o advers rio no est  no PC2
   {
      LitPaddle.adr = 3031;                  // O little paddle comea em cima no meio do ecran
      v_putlitpad( LitPaddle.adr, LitPaddle.ptr );                     // Exibe o little paddle
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: game_status            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Actualiza o status do jogo, isto , pontua”es dos jogadores e nฃmero de   บ
// บ               bolas ainda para jogar.                                                    บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void game_status( void )
{
   char cNrBalls[ 2 ];        // Array do tipo char que aponta o valor da vari vel Status.balls
   char cScorePl1[ 2 ];     // Array do tipo char que aponta o valor da vari vel Status.player1
   char cScorePl2[ 2 ];     // Array do tipo char que aponta o valor da vari vel Status.player2

   itoa( Status.balls,   cNrBalls,  10 );               // Converte Status.balls para caractere
   itoa( Status.player1, cScorePl1, 10 );             // Converte Status.player1 para caractere
   itoa( Status.player2, cScorePl2, 10 );             // Converte Status.player2 para caractere

   write_str( 180, 192, cNrBalls );               // Escreve o nฃmero de bolas ainda para jogar
   write_str( 312, 192, cScorePl1 );                        // Escreve a pontuao do jogador 1
   write_str(   0, 192, cScorePl2 );                        // Escreve a pontuao do jogador 2
}
