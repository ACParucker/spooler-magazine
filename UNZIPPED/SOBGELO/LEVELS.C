//---------------------------------------------------------------------------------------------
//                                       L E V E L S . C
//
//             Todas as fun��es relacionadas com os n�veis de dificuldade do jogo
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                             Fun��es locais da fonte LEVELS.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: dificulty_box          � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta � a fun��o que processa o quadro da "Dificuldade". Este quadro �      �
// �               exibido no in�cio de cada jogo, mas somente quando o advers�rio escolhido  �
// �               � o computador. � nesta fase que o utilizador poder� definir o Q.I. do     �
// �               computador, isto �, se ele deve ser bom ou mau a apanhar as bolas.         �
// �                                                                                          �
// � Par�metros:   *ptrDificulty � um apontador para endere�o de mem�ria que cont�m o actual  �
// �               valor de QI. O facto de utilizarmos um apontador, prende-se com a          �
// �               necessidade de retornar (re-actualizar) o valor apontado.                  �
// ������������������������������������������������������������������������������������������ͼ
static void dificulty_box( BYTE *ptrDificulty )
{
   if( KEY_UP && *ptrDificulty > 0 )                                            // Arrow-key up
      (*ptrDificulty)--;
   else if( KEY_DOWN && *ptrDificulty < 47 )                                  // Arrow-key down
      (*ptrDificulty)++;
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: velocity_box           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta � a fun��o que processa o quadro da "Velocidade". Este quadro �       �
// �               exibido no in�cio de cada jogo. � aqui que o utilizador poder� definir a   �
// �               velocidade do jogo.                                                        �
// �                                                                                          �
// � Par�metros:   *ptrVelocity � um apontador para endere�o de mem�ria que cont�m o actual   �
// �               valor da velocidade. O facto de utilizarmos um apontador, prende-se com a  �
// �               necessidade de retornar (re-actualizar) o valor apontado.                  �
// ������������������������������������������������������������������������������������������ͼ
static void velocity_box( BYTE *ptrVelocity )
{
   if( *ptrVelocity > 0 && ( KEY_LEFT || ( KEY_Z && nOpponent == 1 ) ) )      // Arrow-key left
      (*ptrVelocity)--;
   else if( *ptrVelocity < 73 && ( KEY_RIGHT || ( KEY_C && nOpponent == 1 ) ) ) // Arrkey right
      (*ptrVelocity)++;
}


//---------------------------------------------------------------------------------------------
//                                                           Fun��es externas da fonte LEVELS.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: load_levels            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Inicializa os apontador para a imagem dos quadros "Velocidade" e           �
// �               "Dificuldade". Estas imagens s�o utilizadas quando um novo jogo vai        �
// �               come�ar - a� o utilizador deve escolher a dificuldade do jogo (caso tenha  �
// �               como advers�rio o computador), e escolher a velocidade do jogo.            �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void load_levels( void )
{
   ptrDifiBox  = getfile( "LEVELS.BIN", O_BINARY );   // Carrega e aponta p/ imagem dos quadros
   ptrVeloBox  = ptrDifiBox + 8856;           // Aponta para a imagem do quadro da "Velocidade"
   ptrDifiCurs = ptrDifiBox + 12420;         // Aponta para o cursor do quadro da "Dificuldade"
   ptrVeloCurs = ptrDifiBox + 12490;          // Aponta para o cursor do quadro da "Velocidade"
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: define_level           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Definir o n�vel de dificuldade do jogo. � nesta fun��o que se define os    �
// �               par�meteros para o n�vel de dificuldade e para a velocidade do jogo.       �
// �                                                                                          �
// � Par�metros:   *ptrVelo � um apontador para a velocidade (o valor contido neste endere�o  �
// �               ser� retornado);                                                           �
// �               *ptrDifi � um apontador para o n�vel de dificuldade do computador, isto �, �
// �               um valor que determina se o computador joga melhor ou pior (o valor        �
// �               contido neste endere�o ser� retornado).                                    �
// �                                                                                          �
// � Retorna:      A fun��o retorna um valor booleano que tem o seguinte significado:         �
// �               TRUE  = significa que tudo se precessou normalmente - jogo deve continuar  �
// �               FALSE = significa que o utilizador abandonou a fun��o com <ESCAPE>         �
// ������������������������������������������������������������������������������������������ͼ
BOOLEAN define_level( BYTE *ptrVelo, BYTE *ptrDifi )
{
   int nVeloY = ( !nOpponent ) ? 130 : 84;            // Coordenada Y do quadro da "Velocidade"
   static BYTE nDifi = 24;                // Par�metero para o n�vel da dificuldade - [ 0, 47 ]
   static BYTE nVelo = 37;                          // Par�metero para a velocidade - [ 0, 73 ]

   while( KEYPRESSED );                              // Aguarda qua qualquer tecla seja liberta

   if( !nOpponent )                                         // Se o advers�rio for o computador
   {
      v_putimage( 106,  40, 108, 82, ptrDifiBox );              // Exibe o quadro "Dificuldade"
      v_putimage( 192, 56 + nDifi, 10, 7, ptrDifiCurs );       // Exibe cursor do potenci�metro
   }

   v_putimage( 106, nVeloY, 108, 33, ptrVeloBox );               // Exibe o quadro "Velocidade"
   v_putimage( 119 + nVelo, nVeloY + 14,  8, 9, ptrVeloCurs ); // Exibe cursor do potenci�metro

   do
   {
      if( KEYPRESSED )                                     // Se alguma tecla foi pressionda...
      {
	 if( KEY_ESCAPE )                                                 // Se teclou <ESCAPE>
	    return( FALSE );                                            // Abandona agora mesmo

	 if( !nOpponent )                                   // Se o advers�rio for o computador
	 {
	    dificulty_box( &nDifi );                          // Escolher a dificuldade do jogo
	    v_putimage( 192, 56 + nDifi, 10, 7, ptrDifiCurs ); // Cursor potenci�metro Dificul.
	 }

	 velocity_box( &nVelo );                               // Escolher a velocidade do jogo
	 v_putimage( 119 + nVelo, nVeloY + 14,  8, 9, ptrVeloCurs ); // Cursor potenci�m. Velo.

	 delay( 3 );                          // Atrasa pois a rotina de teclado � muito r�pida
      }
   }
   while( !KEY_ENTER );                       // Ciclo at� que seja pressionada a tecla <ENTER>

   cls_game_area();                                      // Limpa o ecran antes de se ir embora

   *ptrVelo = MAX_DELAY - nVelo / 10;                    // Define a velocidade (delay) do jogo
   *ptrDifi = -nDifi / 2 + 85;                           // Define a intelig�ncia do computador

   return( TRUE );                              // Retorna TRUE - tudo se precessou normalmente
}
