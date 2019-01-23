//---------------------------------------------------------------------------------------------
//                                        S O U N D . C
//
//                  Todas as fun”es relacionadas o som do jogo Sob-Gelo
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Fun”es externas da fonte SOUND.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: s_ball_hit_wall        ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Este  o som que se  houve quando a bola bate numa bancada.                บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void s_ball_hit_wall( void )
{
   sound( 500 );                                         // Emite um som de frequncia = 400 Hz
   delay( 10 );                                                       // Durante 7 milisegundos
   nosound();                                                                 // Cala o speaker
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: s_ball_hit_paddle      ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Este  o som que se houve quando a bola bate num dos paddles.              บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void s_ball_hit_paddle( void )
{
   sound( 400 );                                         // Emite um som de frequncia = 400 Hz
   delay( 7 );                                                        // Durante 7 milisegundos
   nosound();                                                                 // Cala o speaker
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: s_lost_ball            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Este  o som que houve quando a bola no  defendida por um dos paddles.   บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void s_lost_ball( void )
{
   int i;

   for( i = 60; i > 0; i-- )                                  // Ciclo - sound effect … maneira
   {
      sound( 200 * i );                                  // Emite um som de frequncia = 400 Hz
      delay( 7 );                                                     // Durante 7 milisegundos
      nosound();                                                              // Cala o speaker
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: s_out_of_range         ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Este  o som que houve quando o utilizador ultrapassa os limites da string บ
// บ               a introduzir. Por exemplo, quando est  a inserir o seu nome no scores e    บ
// บ               tenta introduzir ou apagar para alm dos limites do espao para o nome.    บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void s_out_of_range( void )
{
   sound( 500 );                                         // Emite um som de frequncia = 500 Hz
   delay( 30 );                                                      // Durante 30 milisegundos
   nosound();                                                                 // Cala o speaker
}
