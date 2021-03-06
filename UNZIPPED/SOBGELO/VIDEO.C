//---------------------------------------------------------------------------------------------
//                                        V I D E O . C
//
//V�rias rotinas para uso do video no modo MCGA (Multi Color Graphics Adapter - 320x200 pixels)
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Fun��es externas da fonte VIDEO.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_fadein               � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Faz o fade in de uma imagem de (nH x nV) para o ecran. O fade da imagem �  �
// �               feito pixel por pixel, numa sequ�ncia definida pelo array FadeSeq.         �
// �                                                                                          �
// � Par�metros:   nH e nV s�o as dimens�es da imagem (largura x altura);                     �
// �               adr � o endere�o da mem�ria video (ecran) onde colocar a imagem;           �
// �               ptrImg � o apontador para a imagem;                                        �
// �               FadeSeq � um array de nH valores e � utilizado para exibir a imagem no     �
// �               ecran. Por exemplo, se FadeSeq � { 0, 1, 2, ..., nH-1, nH } ent�o a imagem �
// �               ser� exibida com um efeito de "abertura". Outra possibilidade, ser� por    �
// �               exemplo, FadeSeq ser um array de valores aleat�rios, isto �, { 0, 4, 1, 6, �
// �               nH, 12, 5, ... }: neste caso a imagem ser� exibida com um efeito aleat�rio.�
// ������������������������������������������������������������������������������������������ͼ
void v_fadein( int nH, int nV, WORD adr, char *ptrImg, int *FadeSeq )
{
   BYTE far *pointer;
   char x, y, j, t;

   pointer = ( BYTE far * )MK_FP( VIDEO, adr );

   for( x = 0; x < nH; x++ )
   {
      y = FadeSeq[ x ];

      for( j = 0; j < nV; j++, y = ++y % nH )
      {
	 *( pointer + j * 320 + FadeSeq[ y ] ) = *( ptrImg + j * nH + FadeSeq[ y ] );

	 for( t = 0; t < 100; t++ );                                       // Provoca uma pausa
      }
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_imgup                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Move uma imagem apontada por ptrImg, com tamanho (nH,nV), colocada em      �
// �               (nX,nY), nMoves para cima, deixando a cor bColor.                          �
// �                                                                                          �
// � Par�metros:   nX e nY s�o as coordenadas do ecran onde est� colocada a imagem a mover;   �
// �               nH e nV s�o as dimens�es da imagem (largura x altura);                     �
// �               nMoves � o n�mero de pixels que a imagem deve ser deslocada para cima;     �
// �               ptrImg � o apontador para a imagem;                                        �
// �               bColor � a cor do rasto deixado pela imagem quando est� a subir.           �
// �                                                                                          �
// � NOTA: Poderiamos ter utilizado a fun��o v_winup() para obter o mesmo efeito. No entanto, �
// �       como possuimos a imagem que pretendemos deslocar est� carregada em mem�ria, �      �
// �       prefer�vel utilizar esta fun��o uma vez que o deslocamento ser� bastante mais      �
// �       r�pido.                                                                            �
// ������������������������������������������������������������������������������������������ͼ
void v_imgup( int nX, int nY, int nH, int nV, int nMoves, BYTE *ptrImg, BYTE bColor )
{
   while( nMoves-- > 0 )
   {
      v_hline( nX, nY + nV, nX + nH, bColor );
      v_putimage( nX, --nY, nH, nV, ptrImg );
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_winup                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Move uma janela com tamanho (nH,nV), colocada em (nX,nY), nMoves para      �
// �               cima, deixando a cor bColor.                                               �
// �                                                                                          �
// � Par�metros:   nX e nY s�o as coordenadas do ecran onde est� colocada a janela a mover;   �
// �               nH e nV s�o as dimens�es da janela (largura x altura);                     �
// �               nMoves � o n�mero de pixels que a janela deve ser deslocada para cima;     �
// �               ptrImg � o apontador para a imagem;                                        �
// �               bColor � a cor do rasto deixado pela janela quando est� a subir.           �
// ������������������������������������������������������������������������������������������ͼ
void v_winup( int nX, int nY, int nH, int nV, int nMoves, BYTE bColor )
{
   BYTE far *ptrVideo;
   int i, j;

   while( nMoves-- > 0 )
   {
      ptrVideo = ( BYTE far * )MK_FP( VIDEO, nX + 320 * --nY );

      for( j = 0; j < nV; j++, ptrVideo += 320 )
	 for( i = 0; i < nH; i++ )
	    *( ptrVideo + i ) = *( ptrVideo + i + 320 );

      v_hline( nX, nY + nV, nX + nH, bColor );
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_clswin               � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Limpa uma janela definida por (nH1,nV1,nH2,nV2) na cor bColor.             �
// �                                                                                          �
// � Par�metros:   nH1 � a coordenada X do canto superior esquerdo da janela;                 �
// �               nV1 � a coordenada Y do canto superior esquerdo da janela;                 �
// �               nH2 � a coordenada X do canto inferior direito da janela;                  �
// �               nV2 � a coordenada Y do canto inferior direito da janela;                  �
// �               bColor � a cor em que a janela deve ser limpa.                             �
// �                                                                                          �
// � NOTA: Esta fun��o pode servir tamb�m para pintar uma caixa no ecran numa determinada cor.�
// ������������������������������������������������������������������������������������������ͼ
void v_clswin( int nH1, int nV1, int nH2, int nV2, BYTE bColor )
{
   for( ; nV1 <= nV2; nV1++ )
      v_hline( nH1, nV1, nH2, bColor );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_curtain              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Limpa com efeito de cortina, uma janela definida por (nH1,nV1,nH2,nV2) na  �
// �               cor bColor.                                                                �
// �                                                                                          �
// � Par�metros:   nH1 � a coordenada X do canto superior esquerdo da janela;                 �
// �               nV1 � a coordenada Y do canto superior esquerdo da janela;                 �
// �               nH2 � a coordenada X do canto inferior direito da janela;                  �
// �               nV2 � a coordenada Y do canto inferior direito da janela;                  �
// �               bColor � a cor em que a janela deve ser limpa.                             �
// �               nSeg � o n�mero de cortinas a correr quando � a fun��o executada.          �
// ������������������������������������������������������������������������������������������ͼ
void v_curtain( int nH1, int nV1, int nH2, int nV2, BYTE bColor, int nSeg )
{
   int nDist = ( nH2 - nH1 + 1 ) / nSeg;
   int i, j;

   for( i = 0; i < nDist; i++ )
      for( j = 0; j < nSeg; j++ )
      {
	 v_vline( nH1 + j * nDist + i, nV1, nV2, bColor );
	 delay( 2 );
      }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_putbigpad            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Coloca na posi��o adr do ecran (mem�ria video) a imagem do paddle grande.  �
// �               Lembra-se que a dimens�o do paddle grande � de 30x8 pixels.                �
// �                                                                                          �
// � Par�metros:   adr � o endere�o da mem�ria video (ecran) onde colocar a imagem do paddle; �
// �               ptrImg � o apontador para a imagem do paddle grande.                       �
// ������������������������������������������������������������������������������������������ͼ
void v_putbigpad( WORD adr, BYTE *ptrImg )
{
   __emit__( 0x1E );
   _ES = VIDEO;
   _DS = FP_SEG( ptrImg );
   _DI = adr;
   _SI = FP_OFF( ptrImg );
   _DX = 15;
   _BX = 8;
   __emit__( 0x89, 0xD1, 0xF3, 0xA5, 0x81, 0xC7, 0x40, 0x01, 0x29, 0xD7, 0x29, 0xD7, 0x4B,
	     0x75, 0xF1, 0x1F );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_vlinebigpad          � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Desenha uma linha vertical de 6 pixels em preto. � utilizada para limpar o �
// �               rasto deixado do paddle grande quando este vai para a esquerda ou direita. �
// �                                                                                          �
// � Par�metros:   adr � o endere�o da mem�ria video (ecran) onde colocar a imagem do paddle. �
// ������������������������������������������������������������������������������������������ͼ
void v_vlinebigpad( WORD adr )
{
   _ES = VIDEO;
   _DI = adr;
   _BX = 6;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_putlitpad            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Coloca na posi��o adr do ecran (mem�ria video) a imagem do paddle pequeno. �
// �               Lembra-se que a dimens�o do paddle pequeno � de 16x4 pixels.               �
// �                                                                                          �
// � Par�metros:   adr � o endere�o da mem�ria video (ecran) onde colocar a imagem do paddle; �
// �               ptrImg � o apontador para a imagem do paddle pequeno.                      �
// ������������������������������������������������������������������������������������������ͼ
void v_putlitpad( WORD adr, BYTE *ptrImg )
{
   __emit__( 0x1E );
   _ES = VIDEO;
   _DS = FP_SEG( ptrImg );
   _DI = adr;
   _SI = FP_OFF( ptrImg );
   _DX = 9;
   _BX = 4;
   __emit__( 0x89, 0xD1, 0xF3, 0xA5, 0x81, 0xC7, 0x40, 0x01, 0x29, 0xD7, 0x29, 0xD7, 0x4B,
	     0x75, 0xF1, 0x1F );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_vlinelitpad          � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Desenha uma linha vertical de 2 pixels em preto. � utilizada para limpar o �
// �               rasto deixado do paddle pequeno quando este vai para a esquerda ou direita.�
// �                                                                                          �
// � Par�metros:   adr � o endere�o da mem�ria video (ecran) onde colocar a imagem do paddle. �
// ������������������������������������������������������������������������������������������ͼ
void v_vlinelitpad( WORD adr )
{
   _ES = VIDEO;
   _DI = adr;
   _BX = 2;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_putball              � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Coloca no endere�o adr do ecran (mem�ria video) uma bola de dimens�es      �
// �               ((2*nX) x nY), apontada por ptrBuf.                                        �
// �                                                                                          �
// � Par�metros:   adr � o endere�o da mem�ria video (ecran) onde colocar o desenho da bola;  �
// �               nX � metade da largura da bola, ou seja, se por exemplo a bola tem 16      �
// �               pixels de largura, ent�o nX deve ser igual a 8;                            �
// �               ptrBuf � o apontador para a imagem da bola.                                �
// ������������������������������������������������������������������������������������������ͼ
void v_putball( WORD adr, int nX, int nY, BYTE *ptrBuf )
{
   __emit__( 0x1E );
   _ES = VIDEO;
   _DS = FP_SEG( ptrBuf );
   _DI = adr;
   _SI = FP_OFF( ptrBuf );
   _DX = nX;
   _BX = nY;
   __emit__( 0x89, 0xD1, 0xF3, 0xA5, 0x81, 0xC7, 0x40, 0x01, 0x29, 0xD7, 0x29,
	     0xD7, 0x4B, 0x75, 0xF1, 0x1F);
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_hlineball            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Desenha uma linha horizontal em preto. � utilzada para limpar o rasto      �
// �               deixado pela bola quando esta vai para cima ou para baixo.                 �
// �                                                                                          �
// � Par�metros:   adr � o endere�o da mem�ria video (ecran) onde colocar a linha horizontal; �
// �               dim � o tamanho da linha em pixels.                                        �
// ������������������������������������������������������������������������������������������ͼ
void v_hlineball( WORD adr, int dim )
{
   _ES = VIDEO;
   _DI = adr;
   _CX = dim;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0xF3, 0xAA );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_vlineball            � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Desenha uma linha vertical em preto. � utilizada para limpar o rasto       �
// �               deixado pela bola quando esta vai para a esquerda ou para a direita.       �
// �                                                                                          �
// � Par�metros:   adr � o endere�o da mem�ria video (ecran) onde colocar a linha vertical;   �
// �               dim � o tamanho da linha em pixels.                                        �
// ������������������������������������������������������������������������������������������ͼ
void v_vlineball( WORD adr, int dim )
{
   _ES = VIDEO;
   _DI = adr;
   _BX = dim;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_mode                 � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Activa o modo de video especificado em Mode.                               �
// �                                                                                          �
// � Par�metros:   Mode � o modo de video a activar (para maiores detalhes consulte o manual  �
// �               do seu computador ou um livro de interrup��es IBMPC ou compat�vel).        �
// ������������������������������������������������������������������������������������������ͼ
void v_mode( char Mode )
{
   _AH = 0;
   _AL = Mode;
   __int__( 0x10 );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_putpal               � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Escreve na palette os valores de um buffer fornecido como par�metero.      �
// �                                                                                          �
// � Par�metros:   ptrBuf � um apontador para o buffer onde que cont�m as cores da palette;   �
// �               nStart o n�mero da primeira cor da palette a ser escrita;                  �
// �               nLen � o comprimento a escrever a partir de nStart.                        �
// ������������������������������������������������������������������������������������������ͼ
void v_putpal( char *ptrBuf, int nStart, int nLen )
{
   __emit__( 0x1E, 0xFA );
   _DS = FP_SEG( ptrBuf );
   _SI = FP_OFF( ptrBuf );
   _CX = nLen;
   __emit__( 0xBA, 0xC8, 0x03 );
   _AL = nStart;
   __emit__( 0xEE, 0x42, 0xAC, 0xEE, 0xAC, 0xEE, 0xAC, 0xEE, 0xE2, 0xF8, 0xFB, 0x1F );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_getpal               � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    L� a palette de 256 cores para um buffer fornecido como par�metero.        �
// �                                                                                          �
// � Par�metros:   ptrBuf � um apontador para o buffer onde colocar os valores da palette;    �
// �               nStart o n�mero da primeira cor a guardar;                                 �
// �               nLen � o comprimento a guardar a partir de nStart.                         �
// ������������������������������������������������������������������������������������������ͼ
void v_getpal( char *ptrBuf, int nStart, int nLen )
{
   __emit__( 0x06 );
   _ES = FP_SEG( ptrBuf );
   _BX = nStart;
   _CX = nLen;
   _DX = FP_OFF( ptrBuf );
   _AX = 0x1017;
   __int__( 0x10 );
   __emit__( 0x07 );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_paloff               � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Apaga os valores da palette, ou seja, produz um efeito como que a          �
// �               escurecer o ecran.                                                         �
// �                                                                                          �
// � Par�metros:   bHalf � uma vari�vel booleana qua indica quando o ecran deve ser           �
// �               escurecido integralmente, ou apenas uma parte (mais ou menu metade).       �
// �               Assim temos:  se bHalf = 0 o ecran ser� totalmente escurecido;             �
// �                             se bHalf = 1 apenas "metade" do efeito ser� realizado.       �
// �                                                                                          �
// �               Um bom exemplo de como isto funciona � o jogo Sob-Gelo onde a op��o "Sair" �
// �               realiza um fade off total (bHalf = 0), e a tecla de pausa <P> realiza      �
// �               metade do fade off.                                                        �
// �                                                                                          �
// � NOTA: Esta fun��o n�o funciona convenientemente com qualquer palette, mas apenas com a   �
// �       palette definida, por exemplo no jogo Sob-Gelo.                                    �
// ������������������������������������������������������������������������������������������ͼ
void v_paloff( BYTE bHalf )
{
   int i;
   char k = 1, buf[ 768 ];

   v_getpal( buf, 0, 256 );

   while( ( !bHalf && k ) || ( bHalf && k < 10 ) )
   {
      if( !bHalf )
	 k = 0;

      for( i = 0; i < 768; i++ )
      {
	 if( !buf[ i ] )
	 ;
	 else if( buf[ i ] > 48 )
	 {
	    buf[ i ] -= 3;
	    k++;
	 }
	 else if( buf[ i ] < 24 )
	 {
	    buf[ i ]--;
	    k++;
	 }
	 else
	 {
	    buf[ i ] -= 2;
	    k++;
	 }
      }

      v_putpal( buf, 0, 256 );
      delay( 25 );
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_palon                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Acende os valores da palette, ou seja, produz um efeito como que a         �
// �               iluminar o ecran.                                                          �
// �                                                                                          �
// � Par�metros:   bHalf � uma vari�vel booleana qua indica quando o ecran deve ser           �
// �               iluminado integralmente, ou apenas uma parte (mais ou menu metade).        �
// �               Assim temos:  se bHalf = 0 o ecran ser� totalmente iluminado;              �
// �                             se bHalf = 1 apenas "metade" do efeito ser� realizado.       �
// �                                                                                          �
// �               Um bom exemplo de como isto funciona � o jogo Sob-Gelo onde a tecla de     �
// �               <P> realiza metade do fade on.                                             �
// �                                                                                          �
// � NOTA: Esta fun��o n�o funciona convenientemente com qualquer palette, mas apenas com a   �
// �       palette definida, por exemplo no jogo Sob-Gelo.                                    �
// ������������������������������������������������������������������������������������������ͼ
void v_palon( BYTE bHalf )
{
   int i;
   char k = 1, buf[ 768 ];

   if( bHalf )
      v_getpal( buf, 0, 256 );
   else
      for( i = 0; i < 768; i++ )
	 buf[ i ] = 0;

   while( ( !bHalf && k ) || ( bHalf && k < 10 ) )
   {
      if( !bHalf )
	 k = 0;

      for( i = 0; i < 768; i++ )
      {
	 if( buf[ i ] < palette[ i ] )
	 {
	    buf[ i ] += ( palette[ i ] / 12 + 1 );
	    k++;

	    if( buf[ i ] > palette[ i ] )
	       buf[ i ] = palette[ i ];
	 }
      }

      v_putpal( buf, 0, 256 );
      delay( 25 );
   }
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_putimage             � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Coloca uma imagem de dimens�o (nH x nV), apontada por ptrBuf, nas          �
// �               coordenadas (nX,nY) do ecran.                                              �
// �                                                                                          �
// � Par�metros:   nX e nY s�o as coordenadas do ecran onde a imagem deve ser colocada;       �
// �               nH e nV s�o as dimens�es da imagem em pixels (largura x altura);           �
// �               ptrImg � o apontador para a imagem;                                        �
// ������������������������������������������������������������������������������������������ͼ
void v_putimage( int nX, int nY, int nH, int nV, BYTE *ptrBuf )
{
   __emit__( 0x1E );
   nH /= 2;
   _ES = VIDEO;
   _DS = FP_SEG( ptrBuf );
   _DI = nY * 320 + nX;
   _SI = FP_OFF( ptrBuf );
   _DX = nH;
   _BX = nV;
   __emit__( 0x89, 0xD1, 0xF3, 0xA5, 0x81, 0xC7, 0x40, 0x01, 0x29, 0xD7, 0x29, 0xD7, 0x4B,
	     0x75, 0xF1, 0x1F);
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_hline                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Desenha uma linha horizontal na cor bCorlor.                               �
// �                                                                                          �
// � Par�metros:   nH1 � a coordenada inicial X da linha a desenhar;                          �
// �               nV � a coordenada Y da linha a desenhar;                                   �
// �               nH2 � a coordenada final X da linha a desenhar;                            �
// �               bColor � a cor da linha.                                                   �
// ������������������������������������������������������������������������������������������ͼ
void v_hline( int nH1, int nV, int nH2, BYTE bColor )
{
   _ES = VIDEO;
   _DI = nV * 320 + nH1;
   _CX = nH2 - nH1 + 1;
   _AL = bColor;
   __emit__( 0xF3, 0xAA );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_vline                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Desenha uma linha vertical na cor bColor.                                  �
// �                                                                                          �
// � Par�metros:   nH � a coordenada X da linha a desenhar;                                   �
// �               nV1 � a coordenada inicial Y da linha a desenhar;                          �
// �               nV2 � a coordenada final Y da linha a desenhar;                            �
// �               bColor � a cor da linha.                                                   �
// ������������������������������������������������������������������������������������������ͼ
void v_vline( int nH, int nV1, int nV2, BYTE bColor )
{
   _ES = VIDEO;
   _DI = nV1 * 320 + nH;
   _BX = nV2 - nV1 + 1;
   _AL = bColor;
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_box                  � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Desenha um rect�ngulo vazio no ecran na cor bColor.                        �
// �                                                                                          �
// � Par�metros:   nH1 � a coordenada X do canto superior esquerdo do rect�ngulo;             �
// �               nV1 � a coordenada Y do canto superior esquerdo do rect�ngulo;             �
// �               nH2 � a coordenada X do canto inferior direito do rect�ngulo;              �
// �               nV2 � a coordenada Y do canto inferior direito do rect�ngulo;              �
// �               bColor � a cor das linhas do rect�ngulo.                                   �
// �                                                                                          �
// � NOTA: Esta fun��o n�o pinta o rect�ngulo desenhado - para isso utilize antes a fun��o    �
// �       v_clswin().                                                                        �
// ������������������������������������������������������������������������������������������ͼ
void v_box( int nH1, int nV1, int nH2, int nV2, BYTE bColor )
{
   v_hline( nH1, nV1, nH2, bColor );
   v_hline( nH1, nV2, nH2, bColor );
   v_vline( nH1, nV1, nV2, bColor );
   v_vline( nH2, nV1, nV2, bColor );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_pixel                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Coloca um ponto na posi��o (nX,nY) no ecran, na cor bColor.                �
// �                                                                                          �
// � Par�metros:   nX � a coordenada X do ponto a exibir;                                     �
// �               nY � a coordenada Y do ponto a exibir;                                     �
// �               bColor � acor do ponto a exibir.                                           �
// ������������������������������������������������������������������������������������������ͼ
void v_pixel( int nX, int nY, char bColor )
{
   __emit__( 0xBF, 0x00, 0xA0, 0x8E, 0xC7 );
   _DI = nY * 320 + nX;
   _AL = bColor;
   __emit__( 0x26, 0x88, 0x05 );
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: v_getwin               � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Move um bloco de imagem do ecran para um buffer.                           �
// �                                                                                          �
// � Par�metros:   nH1 � a coordenada X do canto superior esquerdo da imagem a guardar;       �
// �               nV1 � a coordenada Y do canto superior esquerdo da imagem a guardar;       �
// �               nH2 � a coordenada X do canto inferior direito da imagem a guardar;        �
// �               nV2 � a coordenada Y do canto inferior direito da imagem a guardar;        �
// �               ptrBuf � um apontador para a zona de mem�ria (buffer) onde a imagem ser�   �
// �               guardada.                                                                  �
// ������������������������������������������������������������������������������������������ͼ
void v_getwin( int nH1, int nV1, int nH2, int nV2, char *ptrBuf )
{
   __emit__( 0x1E );
   _ES = FP_SEG( ptrBuf );
   _DS = VIDEO;
   _SI = nV1 * 320 + nH1;
   _DI = FP_OFF( ptrBuf );
   _DX = nH2 - nH1 + 1;
   _BX = nV2 - nV1 + 1;
   __emit__( 0x89, 0xD1, 0xF3, 0xA4, 0x81, 0xC6, 0x40, 0x01, 0x29, 0xD6, 0x4B, 0x75, 0xF3,
	     0x1F );
}
