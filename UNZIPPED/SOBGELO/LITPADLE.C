//---------------------------------------------------------------------------------------------
//                                     L I T P A D L E . C
//
//                     Fun��es relacionadas com o movimento do paddle pequeno
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                         Fun��es externas da fonte LITPADLE.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: move_lpad              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Movimenta do paddle pequeno dependendo do valor de nDir.                   �
// �               Se nDir = 0 ent�o o paddle pequeno desloca-se para a direita.              �
// �               Se nDir = 1 ent�o o paddle pequeno desloca-se para a esquerda.             �
// �                                                                                          �
// � Par�metros:   nDir � o sentido do paddle pequeno: se 0 ent�o o paddle ser� deslocado     �
// �               para a direita; se 1 ser� deslocado para a esquerda.                       �
// ������������������������������������������������������������������������������������������ͼ
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
