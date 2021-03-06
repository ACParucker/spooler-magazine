//---------------------------------------------------------------------------------------------
//                                     B I G P A D L E . C
//
//                     Fun��es relacionadas com o movimento do paddle grande
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                           Fun��es locais da fonte BIGPADLE.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: move_bigpaddle         � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Movimenta do paddle grande dependendo do valor de nDir.                    �
// �               Se nDir = 0 ent�o o paddle grande desloca-se para a direita.               �
// �               Se nDir = 1 ent�o o paddle grande desloca-se para a esquerda.              �
// �                                                                                          �
// � Par�metros:   nDir � o sentido do paddle grande: se 0 ent�o o paddle ser� deslocado para �
// �               a direita; se 1 ser� deslocado para a esquerda.                            �
// ������������������������������������������������������������������������������������������ͼ
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
//                                                         Fun��es externas da fonte BIGPADLE.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: palyer_1               � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Processa o movimento do paddle grande atrv�s do teclado. � esta fun��o que �
// �               verifica se o big paddle pode andar (isto �, se ainda n�o bateu nas        �
// �               bancadas esquerda ou direita), e depois desloca o paddle se o utilizador   �
// �               estiver a carregar nas teclas "arrow-key left" ou "arrow-key right".       �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// �                                                                                          �
// � NOTA: O paddle s� ser� deslocado se o utilizador estiver a carregar nas teclas. Se tal   �
// �       n�o suceder o paddle grande permanecer� est�tico (da� o nome desta fun��o ser      �
// �       easy - f�cil).                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void player_1( void )
{
   if( KEY_RIGHT && BigPaddle.adr < 58205 )
      move_bpad( 0 );                                           // Move o paddle para a DIREITA
   else if( KEY_LEFT && BigPaddle.adr > 57925 )
      move_bpad( 1 );                                          // Move o paddle para a ESQUERDA
}
