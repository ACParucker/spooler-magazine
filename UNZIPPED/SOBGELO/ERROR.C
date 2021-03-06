//---------------------------------------------------------------------------------------------
//                                        E R R O R . C
//
//                       Fun��o de tratamento de erros do jogo Sob-Gelo
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Fun��es externas da fonte ERROR.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: exit_with_error        � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Abandonar o jogo Spb-Gelo e retornar ao DOS devido � ocorr�ncia de um erro �
// �               fatal. A fun��o rep�e o modo de video e de teclado originais, exibe a      �
// �               respectiva mensagem de erro e finalmente regressa ao DOS.                  �
// �                                                                                          �
// � Par�metros:   nErrorCode � o c�digo do erro que ocorreu. Consulte no manual do           �
// �               utilizador a lista completa dos c�digos de erro.                           �
// ������������������������������������������������������������������������������������������ͼ
void exit_with_error( char *msgError )
{
   k_reset();                                             // Rep�e a rotina de teclado original
   v_mode( 0x03 );                                           // Rep�e o modo de texto - 80 x 25

   perror( msgError );                                   // Exibe a respectiva mensagem de erro
   exit( EXIT_FAILURE );                                 // Regressa ao DOS - abandona com erro
}
