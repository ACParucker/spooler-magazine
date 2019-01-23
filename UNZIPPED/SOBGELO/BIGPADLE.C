//---------------------------------------------------------------------------------------------
//                                     B I G P A D L E . C
//
//                     Fun”es relacionadas com o movimento do paddle grande
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                           Fun”es locais da fonte BIGPADLE.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: move_bigpaddle         ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Movimenta do paddle grande dependendo do valor de nDir.                    บ
// บ               Se nDir = 0 ento o paddle grande desloca-se para a direita.               บ
// บ               Se nDir = 1 ento o paddle grande desloca-se para a esquerda.              บ
// บ                                                                                          บ
// บ Parmetros:   nDir  o sentido do paddle grande: se 0 ento o paddle ser  deslocado para บ
// บ               a direita; se 1 ser  deslocado para a esquerda.                            บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void move_bpad( int nDir )
{
   switch( nDir )
   {
      case 0:                                               // Move o big paddle para a DIREITA
	 v_putbigpad( BigPaddle.adr += 2, BigPaddle.ptr );  // Desloca dois pixels para direita
	 v_vlinebigpad( BigPaddle.adr + 319 );                                 // Limpa o rasto
	 v_vlinebigpad( BigPaddle.adr + 318 );                                 // Limpa o rasto
	 break;
      case 1:                                              // Move o big paddle para a ESQUERDA
	 v_putbigpad( BigPaddle.adr -= 2, BigPaddle.ptr ); // Desloca dois pixels para esquerda
	 v_vlinebigpad( BigPaddle.adr + 350 );                                 // Limpa o rasto
	 v_vlinebigpad( BigPaddle.adr + 351 );                                 // Limpa o rasto
	 break;
   }
}


//---------------------------------------------------------------------------------------------
//                                                         Fun”es externas da fonte BIGPADLE.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: palyer_1               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Processa o movimento do paddle grande atrvs do teclado.  esta funo que บ
// บ               verifica se o big paddle pode andar (isto , se ainda no bateu nas        บ
// บ               bancadas esquerda ou direita), e depois desloca o paddle se o utilizador   บ
// บ               estiver a carregar nas teclas "arrow-key left" ou "arrow-key right".       บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ NOTA: O paddle sข ser  deslocado se o utilizador estiver a carregar nas teclas. Se tal   บ
// บ       no suceder o paddle grande permanecer  est tico (daก o nome desta funo ser      บ
// บ       easy - f cil).                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void player_1( void )
{
   if( KEY_RIGHT && BigPaddle.adr < 58205 )
      move_bpad( 0 );                                           // Move o paddle para a DIREITA
   else if( KEY_LEFT && BigPaddle.adr > 57925 )
      move_bpad( 1 );                                          // Move o paddle para a ESQUERDA
}
