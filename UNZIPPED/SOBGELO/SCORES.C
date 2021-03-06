//---------------------------------------------------------------------------------------------
//                                       S C O R E S . C
//
//                  Tudo sobre a tabela de scores - exibir, alterar, gravar...
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                                                   Constantes
//---------------------------------------------------------------------------------------------
#define BOX_COLOR          241        // Cor da caixa que rodeia as letras no quadro "PARAB�NS"


//---------------------------------------------------------------------------------------------
//                                                          Vari�veis globais da fonte SCORES.C
//---------------------------------------------------------------------------------------------
// Player � um array de 10 estruturas. Isto �, s�o 10 posi��es (pois "OS MELHORES SOB-GELO" �
// um top 10), em que cada uma possui um campo name para o nome do jogador, e um campo score
// para a respectiva pontua��o
static struct { char *name;                                 // Apontador para o nome do jogador
		int score;                                 // Vari�vel inteira para a pontua��o
	      } Player[ 10 ];                                   // M�ximo = 10 jogadores no top


//---------------------------------------------------------------------------------------------
//                                                             Fun��es locais da fonte SCORES.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: insert_your_name       � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Rotina utilizada para inserir o nome do jogador caso tenha sido alcan�ado  �
// �               um novo high-score. A fun��o exibe o quadro das letras no ecran e executa  �
// �               o processamento de teclado. Ser� exibida uma caixa magenta (cor 241) em    �
// �               volta da letra actualmente seleccionada. O utilizador poder� ent�o mover   �
// �               essa mesma caixa (isto �, seleccionar outra letra) utilizando as quatro    �
// �               arrow-keys. Pode ainda, abandonar a introdu��o teclando <ESCAPE> ou        �
// �               seleccionado a palavra "FIM" - no primeiro caso a fun��o retornar� o       �
// �               �ltimo nome introduzido pelo jogador; no segundo caso a fun��o n�o retorna �
// �               nome nenhum (retorna um string vazia - "" ou '\0').                        �
// �               Tome especial aten��o �s teclas <RETURN>, <ENTER>) ou <SPACE>: elas s�o    �
// �               utilizada para seleccionar o actual conte�do da caixa, e tem algumas       �
// �               particulariedades, especialmente quando esse conte�do � " " (SPACE),       �
// �               "<-" (BACKSPACE), "FIM", ou ainda a tentativa de introduzir uma letra que  �
// �               j� n�o cabe na range (cujo m�ximo � de 12 caracteres).                     �
// �                                                                                          �
// � Par�metros:   ptrName � o endere�o de in�cio do nome introduzido (e que ser� retornado). �
// �                                                                                          �
// � Retorna:      A fun��o retorna um apontador para o in�cio nome introduzido pelo jogador. �
// ������������������������������������������������������������������������������������������ͼ
static char *insert_your_name( char *ptrName )
{
   BOOLEAN bExitInsert = FALSE;               // Controla o final (saida) da introdu��o do nome
   static char oldName[ 13 ] = "";                     // Buffer para o �ltimo nome introduzido
   char bufName[ 13 ] = "";                                  // Buffer para o nome a introduzir
   int n = 0;                                              // Contador para o apontador bufName
   int nX = 0, nY = 0;                  // Posi��o (nX,nY) nas matrizes de coordenadas da caixa
   int nLeft[ 5 ][ 6 ]  = { { 113, 129, 145, 161, 177, 193 },                    // Coordenadas
			    { 113, 129, 145, 161, 177, 193 },                    // X do canto
			    { 113, 129, 145, 161, 177, 193 },                    // esquerdo da
			    { 113, 129, 145, 161, 177, 193 },                    // caixa.
			    { 113, 129, 145, 161, 177, 177 }
			  };
   int nRight[ 5 ][ 6 ] = { { 125, 141, 157, 173, 189, 205 },                    // Coordenadas
			    { 125, 141, 157, 173, 189, 205 },                    // X do canto
			    { 125, 141, 157, 173, 189, 205 },                    // direito da
			    { 125, 141, 157, 173, 189, 205 },                    // caixa.
			    { 125, 141, 157, 173, 205, 205 }
			  };
   int nTop[ 5 ]        = { 50, 66, 82,  98, 114 };           // Coordenadas Y do topo da caixa
   int nBottom[ 5 ] = { 62, 78, 94, 110, 126 };              // Coordenadas Y do fundo da caixa

   v_putimage( 97, 35, 126, 122, ptrNewScore );  // Exibe a imagem do quadro "PARAB�NS"

   write_str( 112, 139, "????????????" );             // Exibe a range para o nome a introduzir

   v_box( nLeft[ nY ][ nX ], nTop[ nY ], nRight[ nY ][ nX ], nBottom[ nY ], BOX_COLOR );  // Cx

   while( KEYPRESSED );                           // Aguarda que todas as teclas estejam soltas

   do
   {
      if( KEYPRESSED )                                       // Se alguma tecla foi pressionada
      {
	 v_box( nLeft[ nY ][ nX ], nTop[ nY ], nRight[ nY ][ nX ], nBottom[ nY ], 0 ); // Caixa

	 if( KEY_ESCAPE )                                                     // Tecla <ESCAPE>
	 {
	    bExitInsert = TRUE;                                    // Abandona no pr�ximo ciclo
	    strcpy( bufName, oldName);                      // Assume o �ltimo nome introduzido
	 }
	 else if( KEY_ENTER || KEY_SPACE )            // Se pressionou a tecla <ENTER> sobre...
	 {
	    if( nY == 4 && nX >= 4 && nX <= 5 )                       // Se <ENTER> sobre "FIM"
	       bExitInsert = TRUE;
	    else if( n > 0 && nX == 3 && nY == 4 )                     // Se <ENTER> sobre "<-"
	       write_str( 112 + 8 * --n, 139, "?" );           // Apaga a letra e recua valor n
	    else if( n > 11 || ( n == 0 && nX==3 && nY==4 ) )    // Se exedeu range para + ou -
	       s_out_of_range();                              // Som - tentou agir fora a range
	    else if( nX == 2 && nY == 4 )                               // Se <ENTER> sobre " "
	       *(bufName + n++) = '^';                              // Insere um espa�o no nome
	    else                                                  // Se <ENTER> sobre uma letra
	       *(bufName + n++) = 'A' + nX + nY * 6;                // Insere a letra escolhida

	    *(bufName + n) = '\0';                                    // Insere final de string
	    write_str( 112, 139, bufName );                      // Exibe o nome j� introduzido
	 }
	 else if( KEY_RIGHT && ( ( nX == 4 && nY == 4 ) || ++nX > 5 ) )      // Arrow-key right
	    nX = 0;
	 else if( KEY_LEFT  && nX == 5 && nY == 4 )               // Arrow-key left sobre "FIM"
	    nX -= 2;
	 else if( KEY_LEFT  && --nX < 0 )                     // Arrow-key left sobre uma letra
	    nX = 5;
	 else if( KEY_DOWN  && ++nY > 4 )                                     // Arrow-key down
	    nY = 0;
	 else if( KEY_UP    && --nY < 0 )                                       // Arrow-key up
	    nY = 4;

	 v_box( nLeft[ nY ][ nX ], nTop[ nY ], nRight[ nY ][ nX ], nBottom[ nY ], BOX_COLOR );

	 while( KEYPRESSED );                             // Aguarda que a tecla seja libertada
      }
   }
   while( !bExitInsert );                               // Ciclo - enquanto a "saida" for FALSE

   if( ( ptrName = ( char * )realloc( ptrName, strlen( bufName ) + 1 ) ) == NULL )  // Re-aloca
      exit_with_error( "Re-aloca��o de mem�ria" );          // Informa o erro e regressa ao DOS

   strcpy( ptrName, bufName );                   // Copia o conte�do do buffer para o apontador
   strcpy( oldName, bufName );                           // Actualiza o �ltimo nome introduzido

   cls_game_area();                                        // Limpa o ecran de jogo (tabuleiro)

   return( ptrName );                       // Retorna o endere�o de in�cio do nome introduzido
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: scores_quicksort       � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Ordena as pontu��es decrescentemente, bem como, os respectivos nomes.      �
// �               Para efectuar esta ordena��o eu recorri ao m�todo QUICKSORT, da� que n�o   �
// �               vale a pena perder tempo com explica��es, pois parto do princ�pio que voc� �
// �               conhece este algoritmo.                                                    �
// �               No entanto, s� uma nota: a ordena��o � decrescente uma vez que quem tem    �
// �               maior pontua��o deve surgir em primeiro lugar na tabela.                   �
// �                                                                                          �
// � Par�metros:   left e right s�o os limites do segmento a ordenar.                         �
// ������������������������������������������������������������������������������������������ͼ
static void scores_quicksort( int left, int right )
{
   int media, ndx1, ndx2, i;
   int troca;                                    // Vari�vel tempor�ria para a troca dos scores
   char *temp;                                    // Vari�vel tempor�ria para a troca dos names

   media = Player[ ( left + right ) / 2 ].score;
   ndx1 = left;
   ndx2 = right;

   do
   {
      while( Player[ ndx1 ].score > media )
	 ndx1++;                                              // Aproxima-se da m�dia por baixo

      while( media > Player[ ndx2 ].score )
	 ndx2--;                                               // Aproxima-se da m�dia por cima

      if( ndx1 <= ndx2 )                                          // Neste caso vai haver troca
      {
	 temp = Player[ ndx1 ].name;                                                   // Troca
	 Player[ ndx1 ].name = Player[ ndx2 ].name;                                    // os
	 Player[ ndx2 ].name = temp;                                                   // names

	 troca = Player[ ndx1 ].score;                                                // Troca
	 Player[ ndx1++ ].score = Player[ ndx2 ].score;                               // os
	 Player[ ndx2-- ].score = troca;                                              // scores
      }
   }
   while( ndx1 <= ndx2 );

   if( left < ndx2 ) scores_quicksort( left, ndx2 );                       // Recursividade com
   if( ndx1 < right ) scores_quicksort( ndx1, right );                     // um novo segmento
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: save_scores            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Grava a tabela d' "OS MELHORES SOB-GELO" no ficheiro SCORES.SG.            �
// �               Veja no manual do programador como est� organizada a informa��o da tabela  �
// �               dentro do ficheiro SCORES.SG.                                              �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void save_scores( void )
{
   char tmpScore[ 5 ];                                 // Apontador tempor�rio para a pontua��o
   int nTotal;                       // Total de nomes existentes na tabela dos scores (max.10)
   int nHandle;                                              // Handle do ficheiro "SCORES.TXT"

   if( (nHandle = open("SCORES.SG", O_WRONLY | O_CREAT | O_TRUNC, S_IREAD | S_IWRITE) ) == -1 )
   // Se ocorreu um erro na abertura do ficheiro "SCORES.SG"
      exit_with_error( "Erro na abertura de SCORES.SG:" );   // Exibe a mensagem e volta ao DOS

   for( nTotal = 0; nTotal < 10 && Player[ nTotal ].score; nTotal++ ) // Ciclo - corre a tabela
      if( write( nHandle, Player[ nTotal ].name, strlen( Player[ nTotal ].name ) + 1 ) == -1 )
      // Se ocorreu um erro na escrita dos nomes no ficheiro "SCORES.SG"
	 exit_with_error( "Erro escrevendo em SCORES.SG:" ); // Exibe a mensagem e volta ao DOS

   if( write( nHandle, "\n", 1 ) == -1 )
   // Se ocorreu um erro escrevendo o caracter nova-linha no ficheiro "SCORES.SG"
      exit_with_error( "Erro escrevendo em SCORES.SG:" );    // Exibe a mensagem e volta ao DOS

   for( nTotal = 0; nTotal < 10 && Player[ nTotal ].score; nTotal++ ) // Ciclo - corre a tabela
   {
      itoa( Player[ nTotal ].score, tmpScore, 10 );           // Converte os scores para string

      if( write( nHandle, tmpScore, strlen( tmpScore ) + 1 ) == -1 )
      // Se ocorreu um erro naescrita dos scores no ficheiro "SCORES.SG"
	 exit_with_error( "Erro escrevendo em SCORES.SG:" ); // Exibe a mensagem e volta ao DOS
   }
}


//---------------------------------------------------------------------------------------------
//                                                           Fun��es externas da fonte SCORES.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: load_scores            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Inicializa ptrScores (apontador para a imagem da tabela dos scores).       �
// �               A fun��o est� ainda encarregue de inicializar as 10 estruturas de Player.  �
// �               Isso � feito abrindo o ficheiro SCORES.SG que cont�m a tabela desde a      �
// �               a �ltima vez que o jogo foi carregado e algum record foi alcan�ado.        �
// �               Se por exemplo s� existirem 5 nomes e respectivas pontua��es no ficheiro   �
// �               SCORES.SG, somente as 5 primeiras estruturas de Player[ 10 ] ser�o         �
// �               inicializadas.                                                             �
// �               Veja no manual do programador com est� organizada a informa��o da tabela   �
// �               dentro do ficheiro SCORES.SG.                                              �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void load_scores( void )
{
   char *ptrFile;                                      // Apontador para o ficheiro "SCORES.SG"
   int nTotal;                       // Total de nomes existentes na tabela dos scores (max.10)
   int i;                                                            // Contador para ciclo for

   ptrScores   = getfile( "SCORES.BIN",   O_BINARY );    // Carrega imagem da tabela na mem�ria
   ptrNewScore = getfile( "NEWSCORE.BIN", O_BINARY );  // Carrega a imagem do quadro "PARAB�NS"
   ptrFile     = getfile( "SCORES.SG",   O_TEXT );    // Carrega os scores da tabela na mem�ria

   for( nTotal = 0; nTotal < 10 && *ptrFile != '\n'; nTotal++ )
   {
      Player[ nTotal ].name = ( char * )calloc( strlen( ptrFile ) + 1, sizeof( char ) );
      strcpy( Player[ nTotal ].name, ptrFile );                   // Apontadores para cada nome
      ptrFile += strlen( Player[ nTotal ].name ) + 1;             // Avan�a para o pr�ximo nome
   }

   ptrFile++;   // Salta o caracter '\n' que indica o final dos nomes - agora v�m as pontua��es

   for( i = 0; i < nTotal; i++ )
   {
      Player[ i ].score = atoi( ptrFile );                     // Apontador para cada pontua��o
      ptrFile += strlen( ptrFile ) + 1;                      // Avan�a para a pr�xima pontua��o
   }

   for( ; nTotal < 10; nTotal++ )              // Se a tabela dos scores ainda n�o tem 10 nomes
   {
      Player[ nTotal ].name = NULL;          // Coloca o resto dos pointers a apontar para nada
      Player[ nTotal ].score = 0;                       // Coloca o resto das pontua��es a zero
   }

   scores_quicksort( 0, 9 );           // Ordena a tabela pois o ficheiro pode estar corrompido
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: scores_display         � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Exibe a tabela dos high-scores no ecran.                                   �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void scores_display( void )
{
   char tmpScore[ 5 ];                                 // Apontador tempor�rio para a pontua��o
   int i;                                                            // Contador para ciclo for

   v_putimage( 70, 76, 180, 114, ptrScores );                       // Exibe a imagem da tabela

   for( i = 0; i < 10 && Player[ i ].score; i++ )  // Enquanto houver scores (maiores que zero)
   {
      write_str( 93, 99 + i * 8, Player[ i ].name );                   // Exibe nome do jogador

      itoa( Player[ i ].score, tmpScore, 10 );                    // Converte score para string
      write_str( 237 - strlen( tmpScore ) * 8, 99 + i * 8, tmpScore );       // Escreve o score
   }

   while( KEY_ENTER )             // Espera enquanto n�o libertar a tecla <ENTER> (ou <RETURN>)
      back_letters();                                    // Enquanto isso vai correndo o rodap�

   while( !KEYPRESSED )               // Espera enquanto n�o for pressionada uma tecla qualquer
      back_letters();                                    // Enquanto isso vai correndo o rodap�

   v_clswin( 70, 76, 250, 190, 0 );                                   // Limpa a zona da tabela
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: get_a_highscore        � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Verifica se o jogador merece entrar na tabela "OS MELHORES SOB-GELO".      �
// �               Se sim, substitui o �ltimo da tabela pelo actual jogador, bem como, a sua  �
// �               pontua��o. No final re-ordena todos os elementos da tabela.                �
// �                                                                                          �
// � Par�metros:   nHighScore � a pontua��o alcan�ada pelo jogador candidato a um lugar na    �
// �               tabela.                                                                    �
// ������������������������������������������������������������������������������������������ͼ
void get_a_highscore( int nHighScore )
{
   if( nHighScore > Player[ 9 ].score )  // Se o score alcan�ado � superior ao �ltimo da tabela
   {
      Player[ 9 ].name = insert_your_name( Player[ 9 ].name ); // Introdu��o do nome do jogador
      Player[ 9 ].score = nHighScore;                          // Coloca o novo score na tabela

      scores_quicksort( 0, 9 );                   // Re-ordena os scores e os respectivos nomes
      save_scores();                                // Salva a tabela d' "OS MELHORES SOB-GELO"
   }
}
