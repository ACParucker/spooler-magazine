//---------------------------------------------------------------------------------------------
//                                     S Y N C R O N Z . C
//
//       V rias fun”es utilizadas antes do inกcio do jogo para sincronizar os dois PC's
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                        Vari veis globais da fonte SYNCRONZ.C
//---------------------------------------------------------------------------------------------
static BYTE nDelayPC2;                                   // Guarda a velocidade definida no PC2
static BYTE nRnd, nRndPC2;                 // Nฃmeros aleatขrios gerados por este PC e pelo PC2


//---------------------------------------------------------------------------------------------
//                                                           Fun”es locais da fonte SYNCRONZ.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: diff_delay             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Compara as velocidades definidas em ambos os PC's e retorna TRUE ou FALSE  บ
// บ               dependendo do resultado do teste. No entanto, a funo tambm retorna      บ
// บ               FALSE caso o utilizador aborte a comunicao (teclando <ESCAPE>).          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ Retorna:      TRUE se o valor das velocidades definidas nos dois PC's  diferente;       บ
// บ               FALSE se o valor das velocidades  igual ou se o utilizador simplesmente   บ
// บ               abortou teclando <ESCAPE>.                                                 บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static BOOLEAN diff_delay( void )
{
   do
   {
      write_RS232( nDelay + 20 );                     // Envia para o PC2 a velocidade definida
      wait_for_data();                              // Aguarda que o PC2 envie a sua velocidade
   }
   while( !UserAborted && TimeOut );   // Repete outra vez se ainda no abortou ou fim de tempo

   if( UserAborted )                                         // Se o utilizador teclou <ESCAPE>
      return( FALSE );                                    // Aborta a sincronizao agora mesmo

   nDelayPC2 = read_RS232() - 20;                  // L o valor da velocidade enviada pelo PC2

   return( nDelay != nDelayPC2 );    // Compara as velocidades - retorna TRUE se so diferentes
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: set_delay              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Acerta a velocidade do jogo. Como se sabe o delay definido no outro PC     บ
// บ               foi guardado na vari vel nDelayPC2. Por outro lado, se esta funo foi     บ
// บ               chamada ento as velocidades definidas em ambos os so diferentes          บ
// บ               (lembre-se que a comparao das velocidades foi efectuada na funo        บ
// บ               diff_delay(). Assim, neste momento a tarefa  muito simplesmente aceitar a บ
// บ               maior das velocidades definidas, mas apenas se a velocidade definida no    บ
// บ               PC2 estiver entro os valores permitidos para o delay (intervalo [1,8]) -   บ
// บ               - isto  necess rio porque podemos ter recebido do outro PC uma velocidade บ
// บ               errada devido a um qualquer erro de transmisso.                           บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void set_delay( void )
{
   // Verifica se valor recebido est  entre os valores permitidos para a velocidade do jogo,
   // e se o valor da velocidade  maior que a velocidade definida pelo utilizador neste PC
   if( nDelayPC2 >= 1 && nDelayPC2 <= 8 && nDelayPC2 > nDelay )
      nDelay = nDelayPC2;                                      // Se sim actualiza a velocidade
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: same_beginner          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    A funo gera um nฃmero aleatขrio e compara-o com o nฃmero gerado pelo     บ
// บ               PC2. Se por acaso os nฃmeros forem iguais (sข por muito azar), sero       บ
// บ               gerados novos nฃmeros. Esta tarefa repetir-se-  at que os nฃmeros seja    บ
// บ               diferentes, ou at que o utilizador perca a pacincia e pressione a tecla  บ
// บ               <ESCAPE>. Neste ฃltimo caso, a vari vel UserAborted ser  colocada a TRUE,  บ
// บ               o que significa que o programa vai retornar ao menu principal.             บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void same_beginner( void )
{
   do
   {
      nRnd = ( BYTE )random( 49 ) + 1;                 // Gera um nฃmero aleatขrio entre 1 e 49

      do
      {
	 write_RS232( nRnd + 50 );                          // Envia o nฃmero gerado para o PC2
	 wait_for_data();                         // Aguarda que o PC2 envie o nฃmero que gerou
      }
      while( !UserAborted && TimeOut );          // Repete se ainda no abortou ou fim de tempo

      if( UserAborted )                                      // Se o utilizador teclou <ESCAPE>
	 return;                                          // Aborta a sincronizao agora mesmo

      nRndPC2 = read_RS232() - 50;                     // L o nฃmero aleatขrio gerado pelo PC2
   }
   while( nRnd == nRndPC2 );                  // Ciclo enquanto os nฃmeros gerados forem iguais
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: set_beginner           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Se o jogo j  chegou a este ponto significa que j  temos dois nฃmeros       บ
// บ               aleatขrios diferentes - um gerado por este mesmo PC, e o outro gerado pelo บ
// บ               PC2. Agora basta-nos comparar estes dois nฃmeros e determinar de quem sai  บ
// บ               a bola, isto , a bola sair  do computador que gerou o nฃmero maior.       บ
// บ               Depois  sข atribuir o resultado do teste … vari vel SENDER.               บ
// บ               Esta vari vel determina qual o PC emissor (SENDER=TRUE) e qual o PC        บ
// บ               receptor (SENDER=FALSE): por uma questo de facilidade lembre-se que o PC  บ
// บ               emissor  sempre aquele que detm a bola; quando esta atingir o paddle do  บ
// บ               advers rio o esquema ser  invertido, isto , o emissor passar  a receptor  บ
// บ               e vice-versa.                                                              บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void set_beginner( void )
{
   SENDER = ( nRndPC2 > nRnd );       // Ser  TRUE se o PC2 gerou um nฃmero maior; FALSE se no
}


//---------------------------------------------------------------------------------------------
//                                                         Fun”es externas da fonte SYNCRONZ.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: sincronize             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta funo  chamada exactamente apขs a inicializao da RS232 e o seu    บ
// บ               principal objectivo  tornar simultneos os movimentos dos 2 PC's que      บ
// บ               esto a comunicar. Isto , definir qual a verdadeira velocidade do jogo,   บ
// บ               assim como, determinar de quem sai a bola: se do jogador localizado no     บ
// บ               PC1, ou do jogador localizado no PC 2.                                     บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ Retorna:      TRUE se a sincronizao decorreu sem problemas (o jogo j  pode comear);   บ
// บ               FALSE se o utilizador teclou <ESCAPE> e como tal abortou a sincronizao.  บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
BOOLEAN sincronize( void )
{
   cls_bottom_line();                             // Limpa toda a zona do rodap (ฃltima linha)
   write_str( 7, 192, "SINCRONIZANDO^>^AGUARDE^>^ESC^TERMINAR" );

   /***
   * Sincronizao da velocidade (delay)
   */
   while( !UserAborted && diff_delay() )       // Enquanto no abortar e velocidades diferentes
      set_delay();                                 // Acerta a velocidade do jogo entre os PC's

   /***
   *    Definio de quem sai a bola
   */
   if( !UserAborted )                                      // Enquanto o utilizador no abortar
      same_beginner();                        // Gera um nฃmero aleatขrio e compara-o com o PC2

   if( !UserAborted )                                      // Enquanto o utilizador no abortar
      set_beginner();                         // Acerta os PC's para definir de quem sai a bola

   /***
   * Finalmente terminou a sincronizao
   */
   return( !UserAborted );                             // Se o utilizador abortou retorna FALSE
}
