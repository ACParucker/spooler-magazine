//---------------------------------------------------------------------------------------------
//                                       L E V E L S . C
//
//             Todas as fun”es relacionadas com os nกveis de dificuldade do jogo
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                             Fun”es locais da fonte LEVELS.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dificulty_box          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta  a funo que processa o quadro da "Dificuldade". Este quadro       บ
// บ               exibido no inกcio de cada jogo, mas somente quando o advers rio escolhido  บ
// บ                o computador.  nesta fase que o utilizador poder  definir o Q.I. do     บ
// บ               computador, isto , se ele deve ser bom ou mau a apanhar as bolas.         บ
// บ                                                                                          บ
// บ Parmetros:   *ptrDificulty  um apontador para endereo de memขria que contm o actual  บ
// บ               valor de QI. O facto de utilizarmos um apontador, prende-se com a          บ
// บ               necessidade de retornar (re-actualizar) o valor apontado.                  บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dificulty_box( BYTE *ptrDificulty )
{
   if( KEY_UP && *ptrDificulty > 0 )                                            // Arrow-key up
      (*ptrDificulty)--;
   else if( KEY_DOWN && *ptrDificulty < 47 )                                  // Arrow-key down
      (*ptrDificulty)++;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: velocity_box           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta  a funo que processa o quadro da "Velocidade". Este quadro        บ
// บ               exibido no inกcio de cada jogo.  aqui que o utilizador poder  definir a   บ
// บ               velocidade do jogo.                                                        บ
// บ                                                                                          บ
// บ Parmetros:   *ptrVelocity  um apontador para endereo de memขria que contm o actual   บ
// บ               valor da velocidade. O facto de utilizarmos um apontador, prende-se com a  บ
// บ               necessidade de retornar (re-actualizar) o valor apontado.                  บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void velocity_box( BYTE *ptrVelocity )
{
   if( *ptrVelocity > 0 && ( KEY_LEFT || ( KEY_Z && nOpponent == 1 ) ) )      // Arrow-key left
      (*ptrVelocity)--;
   else if( *ptrVelocity < 73 && ( KEY_RIGHT || ( KEY_C && nOpponent == 1 ) ) ) // Arrkey right
      (*ptrVelocity)++;
}


//---------------------------------------------------------------------------------------------
//                                                           Fun”es externas da fonte LEVELS.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: load_levels            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inicializa os apontador para a imagem dos quadros "Velocidade" e           บ
// บ               "Dificuldade". Estas imagens so utilizadas quando um novo jogo vai        บ
// บ               comear - aก o utilizador deve escolher a dificuldade do jogo (caso tenha  บ
// บ               como advers rio o computador), e escolher a velocidade do jogo.            บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void load_levels( void )
{
   ptrDifiBox  = getfile( "LEVELS.BIN", O_BINARY );   // Carrega e aponta p/ imagem dos quadros
   ptrVeloBox  = ptrDifiBox + 8856;           // Aponta para a imagem do quadro da "Velocidade"
   ptrDifiCurs = ptrDifiBox + 12420;         // Aponta para o cursor do quadro da "Dificuldade"
   ptrVeloCurs = ptrDifiBox + 12490;          // Aponta para o cursor do quadro da "Velocidade"
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: define_level           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Definir o nกvel de dificuldade do jogo.  nesta funo que se define os    บ
// บ               parmeteros para o nกvel de dificuldade e para a velocidade do jogo.       บ
// บ                                                                                          บ
// บ Parmetros:   *ptrVelo  um apontador para a velocidade (o valor contido neste endereo  บ
// บ               ser  retornado);                                                           บ
// บ               *ptrDifi  um apontador para o nกvel de dificuldade do computador, isto , บ
// บ               um valor que determina se o computador joga melhor ou pior (o valor        บ
// บ               contido neste endereo ser  retornado).                                    บ
// บ                                                                                          บ
// บ Retorna:      A funo retorna um valor booleano que tem o seguinte significado:         บ
// บ               TRUE  = significa que tudo se precessou normalmente - jogo deve continuar  บ
// บ               FALSE = significa que o utilizador abandonou a funo com <ESCAPE>         บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
BOOLEAN define_level( BYTE *ptrVelo, BYTE *ptrDifi )
{
   int nVeloY = ( !nOpponent ) ? 130 : 84;            // Coordenada Y do quadro da "Velocidade"
   static BYTE nDifi = 24;                // Parmetero para o nกvel da dificuldade - [ 0, 47 ]
   static BYTE nVelo = 37;                          // Parmetero para a velocidade - [ 0, 73 ]

   while( KEYPRESSED );                              // Aguarda qua qualquer tecla seja liberta

   if( !nOpponent )                                         // Se o advers rio for o computador
   {
      v_putimage( 106,  40, 108, 82, ptrDifiBox );              // Exibe o quadro "Dificuldade"
      v_putimage( 192, 56 + nDifi, 10, 7, ptrDifiCurs );       // Exibe cursor do potenciขmetro
   }

   v_putimage( 106, nVeloY, 108, 33, ptrVeloBox );               // Exibe o quadro "Velocidade"
   v_putimage( 119 + nVelo, nVeloY + 14,  8, 9, ptrVeloCurs ); // Exibe cursor do potenciขmetro

   do
   {
      if( KEYPRESSED )                                     // Se alguma tecla foi pressionda...
      {
	 if( KEY_ESCAPE )                                                 // Se teclou <ESCAPE>
	    return( FALSE );                                            // Abandona agora mesmo

	 if( !nOpponent )                                   // Se o advers rio for o computador
	 {
	    dificulty_box( &nDifi );                          // Escolher a dificuldade do jogo
	    v_putimage( 192, 56 + nDifi, 10, 7, ptrDifiCurs ); // Cursor potenciขmetro Dificul.
	 }

	 velocity_box( &nVelo );                               // Escolher a velocidade do jogo
	 v_putimage( 119 + nVelo, nVeloY + 14,  8, 9, ptrVeloCurs ); // Cursor potenciขm. Velo.

	 delay( 3 );                          // Atrasa pois a rotina de teclado  muito r pida
      }
   }
   while( !KEY_ENTER );                       // Ciclo at que seja pressionada a tecla <ENTER>

   cls_game_area();                                      // Limpa o ecran antes de se ir embora

   *ptrVelo = MAX_DELAY - nVelo / 10;                    // Define a velocidade (delay) do jogo
   *ptrDifi = -nDifi / 2 + 85;                           // Define a inteligncia do computador

   return( TRUE );                              // Retorna TRUE - tudo se precessou normalmente
}
