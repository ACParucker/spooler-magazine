//---------------------------------------------------------------------------------------------
//                                         M E N U . C
//
//                 Menu inicial do jogo: "JOGAR", Advers�rio, "TABELA" e "SAIR"
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                               Fun��es locais da fonte MENU.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: menu_display           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Exibe o menu inicial, utilizando o apontador ptrMenu. Este apontador foi   �
// �               inicializado acima e aponta para a imagem do menu. O �nico promenor a      �
// �               referir, trata-se de que a tecla com o nome do advers�rio � exibida        �
// �               dependendo do oponente escolhido pelo utilizador. Os oponentes poss�veis   �
// �               s�o o COMPUTADOR, um JOGADOR 2, ou finalmente um JOGADOR 2 (PC2); cada um  �
// �               destes advers�rios possui respectivamente o valor 0, 1 e 2, o qual �       �
// �               guardado na vari�vel nOpponent (definida no m�dulo GLOBAL.C).              �
// �                                                                                          �
// � Par�metros:   nChoice � a op��o seleccionada (imagem da tecla pressionada) quando esta   �
// �               fun��o � chamada.                                                          �
// ������������������������������������������������������������������������������������������ͼ
static void menu_display( int nChoice )
{
   int nKeyUp[] = { 0, 2340, 9360, 11700 };    // Posi��o das teclas libertas (somar a ptrMenu)

   nKeyUp[ nChoice - 1 ] += 1170;

   v_putimage( 139,  85,  42, 13, ptrMenu + 14040 );                  // Exibe a palavra "MENU"
   v_putimage( 115, 122,  58,  7, ptrMenu + 14586 );           // Exibe a palavra "Advers�rio:"

   v_putimage( 115, 105, 90, 13, ptrMenu + nKeyUp[ 0 ]  );                     // Tecla "JOGAR"
   v_putimage( 115, 131, 90, 13, ptrMenu + nKeyUp[ 1 ] + nOpponent * 2340 );// Tecla advers�rio
   v_putimage( 115, 148, 90, 13, ptrMenu + nKeyUp[ 2 ] );                     // Tecla "TABELA"
   v_putimage( 115, 165, 90, 13, ptrMenu + nKeyUp[ 3 ] );                       // Tecla "SAIR"
}


//---------------------------------------------------------------------------------------------
//                                                             Fun��es externas da fonte MENU.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: load_menu              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Inicializa o apontador para a imagem do menu. A imagem do menu cont�m as   �
// �               v�rias teclas ON/OFF do menu, assim com, as palavras "MENU" e              �
// �               "Advers�rio:". Consulte o manual do programador.                           �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void load_menu( void )
{
   ptrMenu = getfile( "MENU.BIN", O_BINARY );            // Carrega a imagem do menu na mem�ria
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: menu_process           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta fun��o est� encarregue de gerir o menu inicial. A fun��o faz o        �
// �               processamento do teclado e retorna a op��o seleccionada. As teclas v�lidas �
// �               s�o: arrow keys up/down, <ENTER> e <ESCAPE>.                               �
// �               Como se sabe o menu do jogo foi pensado para simular as teclas no ecran.   �
// �               Quando o utilizador de movimenta dentro do menu essas teclas v�o sendo ora �
// �               pressionadas, ora libertadas. Por exemplo, se o utilizador pretende ver a  �
// �               tabela dos high-scores, ele deve colocar-se sobre a tecla "TABELA", e a�   �
// �               carregar na tecla �-> (<ENTER>) do seu keyboard. Neste caso, � �bvio que   �
// �               devem existir duas imagens de cada uma das teclas do menu - a imagem da    �
// �               tecla pressionada e outra imagem da mesma tecla, mas liberta.              �
// �               Por outro lado, como j� foi referido acima, as imagens das teclas do menu  �
// �               podem ser f�cilmente acedidas atrav�s do apontador ptrMenu (veja no manual �
// �               do programador como est�o organizadas as imagens das teclas dentro do      �
// �               ficheiro MENU.000).                                                        �
// �               Assim, basta-nos definir um array com as 4 posi��es das 4 teclas libertas, �
// �               e somar cada uma dessas posi��es com ptrMenu para obter a imagem da tecla  �
// �               liberta correspondente � posi��o somada. Por exemplo, se adicionarmos a    �
// �               ptrMenu o valor da 4� posi��o do array vamos obter a imagem da tecla       �
// �               "SAIR" (liberta). Depois para obter a imagem da mesma tecla, mas           �
// �               pressionada teremos ainda de somar 1170, que � a dimens�o de cada uma das  �
// �               teclas (90 pixels de largura x 13 pixels de altura = 1170).                �
// �               Deste modo, embora as imagem da teclas ocupem mais espa�o do que           �
// �               desejariamos, conseguimos um c�digo bastante mais r�pido e compacto.       �
// �               Apesar de tudo , o ideal seria uma rotina de processamento de menus o mais �
// �               gen�rica poss�vel. No entanto, tal n�o foi poss�vel, por tr�s simples      �
// �               raz�es. A primeira prende-se com a falta de tempo de que dispunha para     �
// �               terminar este programa, onde o menu n�o � de certeza o mais importante.    �
// �               Quanto � segunda raz�o tem a ver com o facto de o menu a implementar ser   �
// �               pouco vers�til, ou seja, s� trabalha com imagens pr�viamente carregadas em �
// �               mem�ria, e para al�m disso possui uma tecla est�ctica (a tecla que indica  �
// �               o tipo de advers�rio). Finalmente a terceira raz�o est� directamente       �
// �               relacionada com o teclado. Como se sabe este programa utiliza uma rotina   �
// �               de atendimento de teclado elaboraba por mim e adequada ao tipo de jogo que �
// �               se trata. Assim como o menu tamb�m deve ser controlado atrav�s do teclado, �
// �               se por acaso existisse uma rotina de processamento de menus gen�rica, ela  �
// �               teria de contar com a rotina de teclado (que nem sempre estaria activa, e  �
// �               como tal a rotina deixava de ser gen�rica).                                �
// �                                                                                          �
// � Par�metros:   nChoice � a op��o (tecla) do menu actualmente pressionada. Por exemplo, se �
// �               a fun��o recebe nChoice = 3 o menu ser� exibido com a tecla "TABELA" em    �
// �               baixo. Isto �-nos bastante vantajoso uma vez que sempre que o menu �       �
// �               exibido a tecla pressionada � a �ltima op��o seleccionada pelo utilizador. �
// �                                                                                          �
// � Retorna:      Retorna a op��o seleccionada, que depois ser� novamente enviada para esta  �
// �               fun��o atrav�s do par�metero nChoice. Os valores retornados pode ser:      �
// �               1 = escolheu a op��o "JOGAR" (o jogo vai come�ar);                         �
// �               3 = escolheu a op��o "TABELA" (exibir o quadro dos high-scores);           �
// �               4 = escolheu a op��o "SAIR" (abandonar a regressar ao DOS).                �
// �               Note-se que a op��o 2 nunca � retornada uma vez que corresponde ao tipo de �
// �               advers�rio com que se pretende jogar. A pr�pria fun��o est� encarregue de  �
// �               definir a vari�vel nOpponent de acordo com o tipo de advers�rio escolhido. �
// ������������������������������������������������������������������������������������������ͼ
BYTE menu_process( BYTE nChoice )
{
   int nY[]     = {  105,  131,   148,   165 };           // Coordenadas Y das 4 teclas do menu
   int nKeyUp[] = {    0, 2340,  9360, 11700 };// Posi��o das teclas libertas (somar a ptrMenu)
   BYTE bExitMenu = FALSE;              // Vari�vel booleana que indica quando abandonar o menu

   menu_display( nChoice );            // Exibe o menu (teclas e frases "MENU" e "Advers�rio:")

   while( KEYPRESSED )               // Espera enquanto estiver a pressionar uma tecla qualquer
      back_letters();                                // As letras em rodap� n�o param de passar

   do
   {
      if( KEYPRESSED )                                          // Se foi pressionada uma tecla
      {
	 v_putimage( 115, nY[ nChoice - 1 ], 90, 13,                   // Rep�e a tecla liberta
		     ptrMenu + nKeyUp[ nChoice - 1 ] +
		     ( ( nChoice == 2 ) ? nOpponent * 2340 : 0 ) );

	 if( KEY_ESCAPE )                                        // Pressionou a tecla <ESCAPE>
	    nChoice = 4;                             // Avan�a directamente para a tecla "SAIR"
	 else if( KEY_ENTER )                                     // Pressionou a tecla <ENTER>
	 {
	    if( nChoice != 2 )    // Pressionou <ENTER> sobre uma tecla que n�o a "Advers�rio:"
	       bExitMenu = 1;          // Vai abandonar o ciclo e retornar a op��o seleccionada
	    else if( nOpponent++ == 2 )       // Pressionou <ENTER> sobre a tecla "Advers�rio:"
	       nOpponent = 0;                                    // Define o tipo de advers�rio
	 }
	 else if( KEY_UP && nChoice-- == 1 )                         // Pressionou arrow-key up
	    nChoice = 4;
	 else if( KEY_DOWN && nChoice++ == 4 )                     // Pressionou arrow-key down
	    nChoice = 1;

	 v_putimage( 115, nY[ nChoice - 1 ], 90, 13,              // Exibe a nova tecla do menu
		     ptrMenu + nKeyUp[ nChoice - 1 ] + 1170 +
		     ( ( nChoice == 2 ) ? nOpponent * 2340 : 0 ) );

	 do
	    back_letters();                          // As letras em rodap� n�o param de passar
	 while( KEYPRESSED );        // Repete enquanto estiver a pressionar uma tecla qualquer
      }

      back_letters();                                // As letras em rodap� n�o param de passar
   }
   while( !bExitMenu );       // Ciclo at� que op��o do menu seja seleccionada (exepto op��o 2)

   return( nChoice );                                           // Retorna a op��o seleccionada
}
