//---------------------------------------------------------------------------------------------
//                                     M I S C E L A N . C
//
//                     Miscelanea de fun��es utilizadas no jogo "SUB-GELO"
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                         Fun��es externas da fonte MISCELAN.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: load_letters           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Inicializa o apontador para a imagem das letras, n�meros, etc. (enfim,     �
// �               todos os caracters necess�rios e utilizados no jogo).                      �
// �               Consulte o manual do programador.                                          �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void load_letters( void )
{
   ptrLetters = getfile( "CHARS.BIN", O_BINARY );           // Carrega as letras, n�meros, etc.
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: load_name              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Inicializa o apontador para a imagem do nome do jogo.                      �
// �               Consulte o manual do programador.                                          �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void load_name( void )
{
   ptrName = getfile( "SOB-GELO.BIN", O_BINARY );     // Carrega a imagem "SOB-GELO" na mem�ria
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: back_letters           � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Processa o rodap� no in�cio do jogo. Esta fun��o � chamada de v�rios       �
// �               locais, como por exemplo da fonte MENU.C ou ainda da fonte SCORES.C        �
// �               Da� que ela possui vari�veis est�cticas (que conservam os seus valores),   �
// �               para que o rodap� seja exibido cont�nuamente.                              �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void back_letters( void )
{
   static int i, j, nIdx = 0, k = 0;                                              // Contadores
   static BYTE far *ptrX, far *ptrY;                // Apontadores para o ecran (mem�ria video)
   static BYTE *text = "SPOOLER^SOB=GELO?^AUTOR:^JORGE^ALEXANDRE^CABRITA^MORGADO^>>>>^SOB=GELO\
^=^MADE^IN^BARREIRO^=^PORTUGAL^>>>>>^";

   ptrX = ( BYTE far * )MK_FP( VIDEO, 61440 );   // Define apontador para �ltima linha do ecran

   for( j = 0; j < 319; j++, ptrX++ )                                         // Este peda�o de
   {                                                                          // c�digo copia a
      ptrY = ptrX;                                                            // �ltima linha
									      // do ecran, e
      for( i = 0; i < 8; i++, ptrY += 320 )                                   // desloca-a um
	 *ptrY = *( ptrY + 1 );                                               // pixel para a
   }                                                                          // esquerda

   for( i = 0; i < 8; i++ )                          // Escreve nova coluna de pixels do rodap�
      v_pixel( 319, 192 + i, *( ptrLetters + ( ( *( text + nIdx ) - 48 ) * 64 ) + i * 8 + k ));

   if( ++k > 7 )
   {
      k = 0;

      if( ++nIdx > 106 )              // 106 � o n�mero de caracteres do rodap� - quando chegar
	 nIdx = 0;                    // ao final, volta a zero, e recome�a tudo outra vez
   }

   delay( 5 );                                                       // At� os mi�dos podem ler
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: cls_game_area          � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Limpa a �rea do jogo, isto �, toda a zona de movimento quer da bola, quer  �
// �               dos paddles grande e pequeno.                                              �
// �               Esta fun��o � chamada, fundamentalmente quando inicia ou termina um jogo,  �
// �               ou quando uma bola n�o � defendida e ainda existem bolas para jogar.       �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void cls_game_area( void )
{
   int nX, nY, nSize;

   for( nY = 0; nY < 11; nY++ )
      v_hline( 89, nY, 230, 0 );

   for( nX = 89, nSize = 142; nY < 190; nX--, nY++, nSize += 2 )
   {
      v_hline( nX,   nY, nX + nSize, 0 );
      v_hline( nX, ++nY, nX + nSize, 0 );
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: cls_bottom_line        � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Limpa a �ltima linha do ecran. Note que � nesta linha que aparecem a maior �
// �               parte das mensagens do jogo.                                               �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void cls_bottom_line( void )
{
   v_clswin( 0, 192, 319, 199, 0 );               // Limpa toda a zona do rodap� (�ltima linha)
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: write_str              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Escreve a partir da posi��o (nX,nY) a frase apontada por ptrStr.           �
// �                                                                                          �
// � Par�metros:   nX e nY s�o as cooredenadas (em pixels) da frase a escrever;               �
// �               ptrStr � a frase a escrever - como se saber, em linguagem C, as strings    �
// �               s�o definidas por um apontador para um conjunto de caracteres.             �
// ������������������������������������������������������������������������������������������ͼ
void write_str( int nX, int nY, char *ptrStr )
{
   while( *ptrStr )              // Enquanto n�o apanhar o caracter fim de string ('\0' = NULL)
   {
      v_putimage( nX, nY, 8, 8, ptrLetters + ( *ptrStr - 48 ) * 64 );      // Escreve uma letra
      ptrStr++;                                              // Avan�a para o pr�ximo caractere
      nX += 8;                                       // Avan�a 8 pixels (largura de cada letra)
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: getfile                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Abre e carrega na mem�ria um ficheiro do tipo nType. Em caso de erro exibe �
// �               a respectiva mensagem.                                                     �
// �                                                                                          �
// � Par�metros:   ptrFileName � o nome do ficheiro a abrir e carregar em mem�ria;            �
// �               nType � o tipo do ficheiro a abrir. Por exemplo, se deseja abrir um        �
// �               ficheiro do tipo bin�rio ent�o nType deve ser igual a O_BINARY; do mesmo   �
// �               modo se deseja abrir um ficheiro de texto nType deve ser O_TEXT (veja      �
// �               a livraria FCNTL.H para mais informa��es).                                 �
// �                                                                                          �
// � Retorna:      A fun��o retorna um apontador para o in�cio da informa��o do ficheiro      �
// �               carregado em mem�ria.                                                      �
// ������������������������������������������������������������������������������������������ͼ
BYTE *getfile( char *ptrFileName, const int nType )
{
   int nHandle;                                                           // Handle do ficheiro
   WORD nFlen;                                                       // Comprimento do ficheiro
   BYTE *ptrBuf;                            // Apontador para o conte�do do ficheiro em mem�ria

   if( ( nHandle = open( ptrFileName, nType ) ) < 0 )         // Se ocorreu um erro na abertura
      exit_with_error( ptrFileName );                       // Informa o erro e regressa ao DOS

   nFlen = filelength( nHandle );                            // Obt�m o comprimento do ficheiro

   if( ( ptrBuf = ( BYTE * )malloc( nFlen ) ) == NULL ) // Se houve erro na aloca��o de mem�ria
      exit_with_error( "Mem�ria" );                         // Informa o erro e regressa ao DOS

   read( nHandle, ptrBuf, nFlen );           // L� o ficheiro para a mem�ria (apontador ptrBuf)
   close( nHandle );                                                        // Fecha o ficheiro

   return ( ptrBuf );           // Retorna um apontador para o in�cio da informa��o do ficheiro
}
