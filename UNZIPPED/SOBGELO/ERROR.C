//---------------------------------------------------------------------------------------------
//                                        E R R O R . C
//
//                       Funo de tratamento de erros do jogo Sob-Gelo
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Fun”es externas da fonte ERROR.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: exit_with_error        ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Abandonar o jogo Spb-Gelo e retornar ao DOS devido … ocorrncia de um erro บ
// บ               fatal. A funo rep”e o modo de video e de teclado originais, exibe a      บ
// บ               respectiva mensagem de erro e finalmente regressa ao DOS.                  บ
// บ                                                                                          บ
// บ Parmetros:   nErrorCode  o cขdigo do erro que ocorreu. Consulte no manual do           บ
// บ               utilizador a lista completa dos cขdigos de erro.                           บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void exit_with_error( char *msgError )
{
   k_reset();                                             // Rep”e a rotina de teclado original
   v_mode( 0x03 );                                           // Rep”e o modo de texto - 80 x 25

   perror( msgError );                                   // Exibe a respectiva mensagem de erro
   exit( EXIT_FAILURE );                                 // Regressa ao DOS - abandona com erro
}
