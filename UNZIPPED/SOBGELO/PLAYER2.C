//---------------------------------------------------------------------------------------------
//                                   P L A Y E R 2 . C
//
// Fun”es relacionadas com o paddle pequeno quando o advers rio  o outra pessoa no mesmo PC
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                          Fun”es externas da fonte PLAYER2.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: player_2               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Processa o movimento do paddle pequeno quando este  controlado por        บ
// บ               outra pessoa a jogar no mesmo PC.                                          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void player_2( void )
{
   if( KEY_C && LitPaddle.adr < 3092 )   // Se est  carregar na tecla <C> e o paddle pode andar
      move_lpad( 0 );                                   // Move o paddle pequeno para a direita
   else if( KEY_Z && LitPaddle.adr > 2970 )// Se est  carregar na tecla <Z> e paddle pode andar
      move_lpad( 1 );                                  // Move o paddle pequeno para a esquerda
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: player_2_pc2           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    No faz absolutamente nada. Lembre-se que quando o advers rio  outra      บ
// บ               pessoa noutro PC no  exibido o paddle pequeno. A funo  necess ria     บ
// บ               apenas porque  chamada pela funo start_game() na fonte PLAY.C.          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void player_2_pc2( void )
{
}
