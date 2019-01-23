//---------------------------------------------------------------------------------------------
//                                      E X E C U T E . C
//
//            Principais procedimentos do programa: Inicializar, Executar e Terminar
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                          Fun”es externas da fonte EXECUTE.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: init_sob_gelo          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inicializao do programa. Aqui so executadas algumas tarefas que se      บ
// บ               mantm inalter veis ao longo de todo o programa. Por exemplo, definir o    บ
// บ               modo gr fico, carregar as imagens (desenho) na memขria, etc.               บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void init_sob_gelo( void )
{
   BYTE *ptrScreen;                  // Apontador para a imagem das bancadas esquerda e direita
   int FadeSeq[] = {  42, 51, 17,  35, 28,  88,  66, 111,   8,  77,  25, 108,  58, 104,  9,
		      97, 45, 82,  69, 71,  21,  76,  26,  55,  99,   1,  68,  41, 114,  5,
		     103, 60, 95,  19, 87,  31,  83, 119,  16,  64,  93,  75,  15,  89, 39,
		      54, 86, 18, 118, 24, 109,  46, 117,   4, 116,  57,  70,  92,   7, 59,
		      43, 84, 94,   0, 36,  33, 112,  61, 102,  14,  78, 105,  30,  50, 65,
		      22, 53, 63,  11, 79,  90,  27,  32, 107,   3, 115,  49,  96,  74,  6,
		      81, 98, 44,  37, 47, 100,  67,   2,  48,  40,  56,  12,  85,  62, 73,
		     106, 23, 91,  20, 38, 101,  29,  52,  10, 110,  34,  72, 113,  13, 80 };

   textbackground( 0 );                                 // Selecciona o preto para cor de fundo
   clrscr();                                                      // Limpa o ecran (todo preto)

   v_mode( 0x13 );             // Inicializa modo MCGA (Multi Color Graphics Adapter - 320x200)
   v_putpal( palette, 0, 256 );                                   // Define as cores da palette
   k_set();                                                   // Inicializa a rotina de teclado

   load_name();                                       // Carrega a imagem "SOB-GELO" na memขria
   v_fadein( 120, 73, 20260, ptrName, FadeSeq );           // Exibe "SUB-GELO" no meio do ecran

   load_levels();                   // Carrega as imagens dos quadros dos nกveis de dificuldade
   load_play();                                               // Carrega as imagens dos paddles
   load_ball();                                        // Carrega as imagens das 7 (sete) bolas
   load_menu();                                      // Carrega a imagem do menu (teclas, etc.)
   load_scores();                                                  // Carrega tabela dos scores
   load_letters();                                          // Carrega as letras, nฃmeros, etc.

   ptrScreen = getfile( "SCREEN.BIN", O_BINARY );                // Carrega imagem das bancadas

   while( !KEYPRESSED );                    // Aguarda - enquanto no for pressionada uma tecla

   v_imgup( 100, 63, 120, 73, 63, ptrName, 0 );                    // Move "SOB-GELO" para cima

   v_putimage(   0, 0, 90, 189, ptrScreen );                        // Exibe a bancada esquerda
   v_putimage( 230, 0, 90, 189, ptrScreen + 17010 );                 // Exibe a bancada direita
   free( ptrScreen );                                // Liberta o espao da imagem das bancadas
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: menu_sob_gelo          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Define, exibee processa o menu inicial do jogo. Esta funo est  ainda     บ
// บ               encarregue de enviar o controle do programa para um determinado ponto,     บ
// บ               dependendo da opo do menu, seleccionadapeo utilizador.                   บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ NOTA: Na realidade quem exibe e processa o menu so respectivamente as fun”es           บ
// บ       menu_display() e menu_process(), definidas na fonte MENU.C                         บ
// บ       Consulte o manual do programador e/ou a fonte referido.                            บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void menu_sob_gelo( void )
{
   BYTE nMenuChoice = 1;                          // Guarda a ฃltima opo do menu seleccionada

   while( ( nMenuChoice = menu_process( nMenuChoice ) ) != 4 )
   {
      if( nMenuChoice == 1 )
      {
	 play_sob_gelo();                                                // Comear um joguinho
	 cls_game_area();                    // Limpa a  rea do jogo porque acabou esta partida
	 v_putimage( 100, 0, 120, 73, ptrName );           // Rep”e "SOB-GELO" no topo do ecran
      }
      else if( nMenuChoice == 3 )
	 scores_display();                                    // Exibe a tabela dos high-scores
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: exit_sob_gelo          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Abandona o jogo (que pena!!) e volta ao DOS.                               บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void exit_sob_gelo( void )
{
   k_reset();                                             // Rep”e a rotina de teclado original
   v_paloff( 0 );                                                   // Faz um fade-out do ecran
   v_mode( 0x03 );                                           // Rep”e o modo de texto - 80 x 25
   exit( EXIT_SUCCESS );                            // Regressa ao DOS - abandona sem problemas
}
