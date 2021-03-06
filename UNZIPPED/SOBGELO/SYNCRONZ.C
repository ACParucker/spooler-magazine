//---------------------------------------------------------------------------------------------
//                                     S Y N C R O N Z . C
//
//       V�rias fun��es utilizadas antes do in�cio do jogo para sincronizar os dois PC's
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                        Vari�veis globais da fonte SYNCRONZ.C
//---------------------------------------------------------------------------------------------
static BYTE nDelayPC2;                                   // Guarda a velocidade definida no PC2
static BYTE nRnd, nRndPC2;                 // N�meros aleat�rios gerados por este PC e pelo PC2


//---------------------------------------------------------------------------------------------
//                                                           Fun��es locais da fonte SYNCRONZ.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: diff_delay             � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Compara as velocidades definidas em ambos os PC's e retorna TRUE ou FALSE  �
// �               dependendo do resultado do teste. No entanto, a fun��o tamb�m retorna      �
// �               FALSE caso o utilizador aborte a comunica��o (teclando <ESCAPE>).          �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// �                                                                                          �
// � Retorna:      TRUE se o valor das velocidades definidas nos dois PC's � diferente;       �
// �               FALSE se o valor das velocidades � igual ou se o utilizador simplesmente   �
// �               abortou teclando <ESCAPE>.                                                 �
// ������������������������������������������������������������������������������������������ͼ
static BOOLEAN diff_delay( void )
{
   do
   {
      write_RS232( nDelay + 20 );                     // Envia para o PC2 a velocidade definida
      wait_for_data();                              // Aguarda que o PC2 envie a sua velocidade
   }
   while( !UserAborted && TimeOut );   // Repete outra vez se ainda n�o abortou ou fim de tempo

   if( UserAborted )                                         // Se o utilizador teclou <ESCAPE>
      return( FALSE );                                    // Aborta a sincroniza��o agora mesmo

   nDelayPC2 = read_RS232() - 20;                  // L� o valor da velocidade enviada pelo PC2

   return( nDelay != nDelayPC2 );    // Compara as velocidades - retorna TRUE se s�o diferentes
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: set_delay              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Acerta a velocidade do jogo. Como se sabe o delay definido no outro PC     �
// �               foi guardado na vari�vel nDelayPC2. Por outro lado, se esta fun��o foi     �
// �               chamada ent�o as velocidades definidas em ambos os s�o diferentes          �
// �               (lembre-se que a compara��o das velocidades foi efectuada na fun��o        �
// �               diff_delay(). Assim, neste momento a tarefa � muito simplesmente aceitar a �
// �               maior das velocidades definidas, mas apenas se a velocidade definida no    �
// �               PC2 estiver entro os valores permitidos para o delay (intervalo [1,8]) -   �
// �               - isto � necess�rio porque podemos ter recebido do outro PC uma velocidade �
// �               errada devido a um qualquer erro de transmiss�o.                           �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void set_delay( void )
{
   // Verifica se valor recebido est� entre os valores permitidos para a velocidade do jogo,
   // e se o valor da velocidade � maior que a velocidade definida pelo utilizador neste PC
   if( nDelayPC2 >= 1 && nDelayPC2 <= 8 && nDelayPC2 > nDelay )
      nDelay = nDelayPC2;                                      // Se sim actualiza a velocidade
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: same_beginner          � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    A fun��o gera um n�mero aleat�rio e compara-o com o n�mero gerado pelo     �
// �               PC2. Se por acaso os n�meros forem iguais (s� por muito azar), ser�o       �
// �               gerados novos n�meros. Esta tarefa repetir-se-� at� que os n�meros seja    �
// �               diferentes, ou at� que o utilizador perca a paci�ncia e pressione a tecla  �
// �               <ESCAPE>. Neste �ltimo caso, a vari�vel UserAborted ser� colocada a TRUE,  �
// �               o que significa que o programa vai retornar ao menu principal.             �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void same_beginner( void )
{
   do
   {
      nRnd = ( BYTE )random( 49 ) + 1;                 // Gera um n�mero aleat�rio entre 1 e 49

      do
      {
	 write_RS232( nRnd + 50 );                          // Envia o n�mero gerado para o PC2
	 wait_for_data();                         // Aguarda que o PC2 envie o n�mero que gerou
      }
      while( !UserAborted && TimeOut );          // Repete se ainda n�o abortou ou fim de tempo

      if( UserAborted )                                      // Se o utilizador teclou <ESCAPE>
	 return;                                          // Aborta a sincroniza��o agora mesmo

      nRndPC2 = read_RS232() - 50;                     // L� o n�mero aleat�rio gerado pelo PC2
   }
   while( nRnd == nRndPC2 );                  // Ciclo enquanto os n�meros gerados forem iguais
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: set_beginner           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Se o jogo j� chegou a este ponto significa que j� temos dois n�meros       �
// �               aleat�rios diferentes - um gerado por este mesmo PC, e o outro gerado pelo �
// �               PC2. Agora basta-nos comparar estes dois n�meros e determinar de quem sai  �
// �               a bola, isto �, a bola sair� do computador que gerou o n�mero maior.       �
// �               Depois � s� atribuir o resultado do teste � vari�vel SENDER.               �
// �               Esta vari�vel determina qual o PC emissor (SENDER=TRUE) e qual o PC        �
// �               receptor (SENDER=FALSE): por uma quest�o de facilidade lembre-se que o PC  �
// �               emissor � sempre aquele que det�m a bola; quando esta atingir o paddle do  �
// �               advers�rio o esquema ser� invertido, isto �, o emissor passar� a receptor  �
// �               e vice-versa.                                                              �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void set_beginner( void )
{
   SENDER = ( nRndPC2 > nRnd );       // Ser� TRUE se o PC2 gerou um n�mero maior; FALSE se n�o
}


//---------------------------------------------------------------------------------------------
//                                                         Fun��es externas da fonte SYNCRONZ.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: sincronize             � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta fun��o � chamada exactamente ap�s a inicializa��o da RS232 e o seu    �
// �               principal objectivo � tornar simult�neos os movimentos dos 2 PC's que      �
// �               est�o a comunicar. Isto �, definir qual a verdadeira velocidade do jogo,   �
// �               assim como, determinar de quem sai a bola: se do jogador localizado no     �
// �               PC1, ou do jogador localizado no PC 2.                                     �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// �                                                                                          �
// � Retorna:      TRUE se a sincroniza��o decorreu sem problemas (o jogo j� pode come�ar);   �
// �               FALSE se o utilizador teclou <ESCAPE> e como tal abortou a sincroniza��o.  �
// ������������������������������������������������������������������������������������������ͼ
BOOLEAN sincronize( void )
{
   cls_bottom_line();                             // Limpa toda a zona do rodap� (�ltima linha)
   write_str( 7, 192, "SINCRONIZANDO^>^AGUARDE^>^ESC^TERMINAR" );

   /***
   * Sincroniza��o da velocidade (delay)
   */
   while( !UserAborted && diff_delay() )       // Enquanto n�o abortar e velocidades diferentes
      set_delay();                                 // Acerta a velocidade do jogo entre os PC's

   /***
   *    Defini��o de quem sai a bola
   */
   if( !UserAborted )                                      // Enquanto o utilizador n�o abortar
      same_beginner();                        // Gera um n�mero aleat�rio e compara-o com o PC2

   if( !UserAborted )                                      // Enquanto o utilizador n�o abortar
      set_beginner();                         // Acerta os PC's para definir de quem sai a bola

   /***
   * Finalmente terminou a sincroniza��o
   */
   return( !UserAborted );                             // Se o utilizador abortou retorna FALSE
}
