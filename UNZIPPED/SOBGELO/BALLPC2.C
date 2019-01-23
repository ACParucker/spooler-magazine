//---------------------------------------------------------------------------------------------
//                                      B A L L P C 2 . C
//
//        Fun”es de comunicao entre os dois PC's para processar o movimento da bola
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Fun”es locais da fonte BALLPC2.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: process_data           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Processa os dados enviados pelo PC 2, isto , avalia o BYTE recebido e     บ
// บ               executa uma determinada tarefa (ou no) de acordo com o seu valor.         บ
// บ                                                                                          บ
// บ Parmetros:   cData  o BYTE recebido do PC2.                                            บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void process_data( BYTE cData )
{
   switch( cData )
   {
      case 0:                                               // Se recebeu um valor entre 0 e 5,
      case 1:                                               // significa que o PC 2 est  a
      case 2:                                               // informar a direco que a bola
      case 3:                                               // vai tomar. Este PC deve ento
      case 4:                                               // transformar este valor visto que
      case 5:                                               // a bola vai descer e no subir
      {
	 BOOLEAN dirOddity = ODD( Ball.dir );  // Salva se a direco anterior era กmpar ou par

	 Ball.dir = cData + ( ODD( cData ) ? 5 : 7 );            // Transforma direco da bola

	 if( dirOddity && !ODD( Ball.dir ) )   // Se direco anterior era กmpar e a actual no
	    Ball.dir++;                                                  // Soma 1 e fica กmpar
	 else if( !dirOddity && ODD( Ball.dir ) )  // Se direco anterior par e actual  กmpar
	    Ball.dir--;                                                 // Subtrai 1 e fica par

	 break;
      }

      case BALL_LOSTED:                      // Recebeu BALL_LOSTED significa que o PC 2 perdeu
	 v_putball(Ball.adr, PutDimX[MAX_PLANS-1], ImgDimY[MAX_PLANS-1], adrBall[MAX_PLANS-1]);
	 s_lost_ball();                                            // Emite som - perdeu a bola

	 Status.player1++;             // Atribui mais um ponto para o jogado 1 (paddle grande)
	 Status.balls--;                                           // Menos uma bola para jogar

	 game_status();     // Actualiza o status do jogo (nง de bolas para jogar e pontua”es)

	 if( Status.balls )                                // Se ainda existem bolas para jogar
	 {
	    cls_game_area();                             // Limpa o ecran antes de se ir embora
	    start_lpad();           // Re-inicializa as vari veis da bola para o paddle pequeno
	    init_paddles();                         // Coloca os paddles nas posi”es correctas
	 }

	 break;

      case 21:                                          // Se recebeu um valor entre 21 e 28
      case 22:                                          // quer dizer que recebeu um valor
      case 23:                                          // correspondente … velocidade (delay).
      case 24:                                          // Isto significa que o utilizador no
      case 25:                                          // PC2, abortou o seu jogo e voltou a
      case 26:                                          // entrar, ou seja, neste momento o PC2
      case 27:                                          // est  "desesperadamente" a tentar
      case 28:                                          // sincronozar a velocidade do jogo.
	 UserAborted = TRUE;        // Aborta - tem de voltar ao menu pois no devia estar aqui
	 Status.balls = 0;        // 0 bolas para jogar - uma das condi”es para voltar ao menu
	 break;

      default:
	 break;
   }
}


//---------------------------------------------------------------------------------------------
//                                                          Fun”es externas da fonte BALLPC2.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: report_pc2             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Envia um byte para o outro PC, via RS232. Depois de a funo enviar um     บ
// บ               valor para o PC 2, espera que este lhe retorne o mesmo valor e termina.    บ
// บ               Este mtodo  necess rio para que este PC tenha a certeza de o PC 2        บ
// บ               recebeu o dados correctamente.                                             บ
// บ               No entanto, a funo poder  terminar antes de executar o processo referido บ
// บ               acima, caso a vari vel UserAborted seja colocada a TRUE - lembre-se que    บ
// บ               esta vari vel ser  TRUE quando o utilizador interromper a comunicao.     บ
// บ                                                                                          บ
// บ Parmetros:   cData  o byte a enviar para o outro PC.                                   บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void report_pc2( BYTE cData )
{
   do
   {
      do
      {
	 write_RS232( cData );                                   // Envia a direco para o PC2
	 wait_for_data();                               // Agurda que o PC2 envie o que recebeu
      }
      while( !UserAborted && TimeOut );          // Repete se ainda no abortou ou fim de tempo
   }
   while( !UserAborted && read_RS232() != cData );             // Verifica se o PC2 recebeu bem
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: receive_pc2            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Recebe dados do PC 2 e encaminha-os para a funo process_data(), para     บ
// บ               que sejam processados. Depois de recebidos os dados e caso a comunicao   บ
// บ               no tenha sido abortada pelo utilizador, a funo enviar  o que recebeu    บ
// บ               de volta para o PC 2. Este mtodo  necess rio para que o PC 2 tenha a     บ
// บ               certeza de que os dados que enviou foram bem recebidos deste lado.         บ
// บ               Se tudo correu bem, ento o PC 2 comear  a enviar caracteres de SYN e     บ
// บ               a funo termina.                                                          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void receive_pc2( void )
{
   do
   {
      do
	 wait_for_data();                                       // Espera que o PC2 envie dados
      while( !UserAborted && TimeOut );          // Repete se ainda no abortou ou fim de tempo

      if( !UserAborted )                           // Se o utilizador no abortou a comunicao
      {
	 BYTE cData = read_RS232();                                    // L os dados recebidos

	 process_data( cData );                                  // Processa os dados recebidos

	 if( !UserAborted )                                // Se o utilizador ainda no abortou
	 {
	    do
	    {
	       write_RS232( cData );                 // Envia aquilo que rebeceu para confirmar
	       wait_for_data();                            // Espera por uma confirmao de OK!
	    }
	    while( !UserAborted && TimeOut );    // Repete se ainda no abortou ou fim de tempo
	 }
      }
   }
   while( !UserAborted && read_RS232() != SYN );        // Repete se ainda no h  "sincronismo"
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: move_ball_2            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Funo que determina o movimento da bola quanado os advers rios esto em   บ
// บ               PC's separados. Isto , quando a vari vel nOpponent  igual a 2. A funo  บ
// บ               encarrega-se ainda de verificar se a bola ter  chegado ao topo ou ao fundo บ
// บ               do ecran (pois pode ter sido defendida).                                   บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void move_ball_2( void )
{
   eval_balldir();                                    // Desloca a bola na direco de Ball.dir

   if( SENDER )
   // Se sou emissor ento a bola vai para cima
   {
      if( Ball.adr < 4160 )
      // Verifica se a bola atingiu o topo do ecran
      {
	 SENDER = FALSE;                    // Passa a ser o receptor porque vai receber a bola

	 ball_goes_dn();                         // Actualiza as vari veis da bola - vai descer
	 receive_pc2();                                       // Recebe a nova direco da bola
      }
      else
      // Seno, ento a bola ainda vai a subir
      {
	 v_putball( Ball.adr, PutDimX[ Ball.plan ], ImgDimY[ Ball.plan ], adrBall[ Ball.plan]);
	 write_RS232( SYN );                                 // Envia caracteres de sincronismo
      }
   }
   else
   // Seno, ento sou o receptor, logo a bola vem a descer
   {
      if( Ball.adr > 56000 )
      // Verifica se a bola atingiu a base
      {
	 SENDER = TRUE;                        // Passa a ser o receptor pois vai enviar a bola
	 bp_hitball();                              // Verifica se o big paddle defendeu a bola

	 if( Status.balls )        // Se ainda h  bolas para jogar, i.e., se o jogador defendeu
	    report_pc2( Ball.dir );                            // Envia a nova direco da bola
      }
      else
      // Seno, ento a bola ainda vem a descer
	 v_putball( Ball.adr, PutDimX[ Ball.plan ], ImgDimY[ Ball.plan ], adrBall[ Ball.plan]);
   }

   if( Status.balls )
   // Se ainda h  bolas para jogar
      ball_hit_wall();   // Verifica se a bola bateu numa das bancadas - se sim muda a direco
   else
   // Seno, ento o jogo terminou
   {
      if( !UserAborted )                                   // Se o utilizador ainda no abortou
      {
	 while( KEYPRESSED )               // Aguarda - enquanto estiver a pressionar uma tecla
	    if( SENDER )                        // Se sou o emissor (fui eu quem perdeu a bola)
	       write_RS232( SYN );                           // Envia caracteres de sincronismo

	 while( !KEYPRESSED )               // Aguarda - enquanto no for pressionada uma tecla
	    if( SENDER )                          // Se sou emissor (fui eu quem perdeu a bola)
	       write_RS232( SYN );                           // Envia caracteres de sincronismo
      }

      cls_game_area();                                   // Limpa o ecran antes de se ir embora
   }
}
