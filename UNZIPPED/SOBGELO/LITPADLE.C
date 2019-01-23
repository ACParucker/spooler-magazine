//---------------------------------------------------------------------------------------------
//                                     L I T P A D L E . C
//
//                     Fun”es relacionadas com o movimento do paddle pequeno
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                         Fun”es externas da fonte LITPADLE.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: move_lpad              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Movimenta do paddle pequeno dependendo do valor de nDir.                   บ
// บ               Se nDir = 0 ento o paddle pequeno desloca-se para a direita.              บ
// บ               Se nDir = 1 ento o paddle pequeno desloca-se para a esquerda.             บ
// บ                                                                                          บ
// บ Parmetros:   nDir  o sentido do paddle pequeno: se 0 ento o paddle ser  deslocado     บ
// บ               para a direita; se 1 ser  deslocado para a esquerda.                       บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void move_lpad( int nDir )
{
   switch( nDir )
   {
      case 0:                                            // Move o little paddle para a DIREITA
	 v_putlitpad( ++LitPaddle.adr, LitPaddle.ptr );      // Desloca um pixel para a direita
	 v_vlinelitpad( LitPaddle.adr + 319 );                                 // Limpa o rasto
	 break;
      case 1:                                           // Move o little paddle para a ESQUERDA
	 v_putlitpad( --LitPaddle.adr, LitPaddle.ptr );     // Desloca um pixel para a esquerda
	 v_vlinelitpad( LitPaddle.adr + 338 );                                 // Limpa o rasto
	 break;
   }
}
