//---------------------------------------------------------------------------------------------
//                                        V I D E O . C
//
//V rias rotinas para uso do video no modo MCGA (Multi Color Graphics Adapter - 320x200 pixels)
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                            Fun”es externas da fonte VIDEO.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_fadein               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Faz o fade in de uma imagem de (nH x nV) para o ecran. O fade da imagem   บ
// บ               feito pixel por pixel, numa sequncia definida pelo array FadeSeq.         บ
// บ                                                                                          บ
// บ Parmetros:   nH e nV so as dimens”es da imagem (largura x altura);                     บ
// บ               adr  o endereo da memขria video (ecran) onde colocar a imagem;           บ
// บ               ptrImg  o apontador para a imagem;                                        บ
// บ               FadeSeq  um array de nH valores e  utilizado para exibir a imagem no     บ
// บ               ecran. Por exemplo, se FadeSeq  { 0, 1, 2, ..., nH-1, nH } ento a imagem บ
// บ               ser  exibida com um efeito de "abertura". Outra possibilidade, ser  por    บ
// บ               exemplo, FadeSeq ser um array de valores aleatขrios, isto , { 0, 4, 1, 6, บ
// บ               nH, 12, 5, ... }: neste caso a imagem ser  exibida com um efeito aleatขrio.บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_imgup                ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Move uma imagem apontada por ptrImg, com tamanho (nH,nV), colocada em      บ
// บ               (nX,nY), nMoves para cima, deixando a cor bColor.                          บ
// บ                                                                                          บ
// บ Parmetros:   nX e nY so as coordenadas do ecran onde est  colocada a imagem a mover;   บ
// บ               nH e nV so as dimens”es da imagem (largura x altura);                     บ
// บ               nMoves  o nฃmero de pixels que a imagem deve ser deslocada para cima;     บ
// บ               ptrImg  o apontador para a imagem;                                        บ
// บ               bColor  a cor do rasto deixado pela imagem quando est  a subir.           บ
// บ                                                                                          บ
// บ NOTA: Poderiamos ter utilizado a funo v_winup() para obter o mesmo efeito. No entanto, บ
// บ       como possuimos a imagem que pretendemos deslocar est  carregada em memขria,       บ
// บ       preferกvel utilizar esta funo uma vez que o deslocamento ser  bastante mais      บ
// บ       r pido.                                                                            บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_imgup( int nX, int nY, int nH, int nV, int nMoves, BYTE *ptrImg, BYTE bColor )
{
   while( nMoves-- > 0 )
   {
      v_hline( nX, nY + nV, nX + nH, bColor );
      v_putimage( nX, --nY, nH, nV, ptrImg );
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_winup                ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Move uma janela com tamanho (nH,nV), colocada em (nX,nY), nMoves para      บ
// บ               cima, deixando a cor bColor.                                               บ
// บ                                                                                          บ
// บ Parmetros:   nX e nY so as coordenadas do ecran onde est  colocada a janela a mover;   บ
// บ               nH e nV so as dimens”es da janela (largura x altura);                     บ
// บ               nMoves  o nฃmero de pixels que a janela deve ser deslocada para cima;     บ
// บ               ptrImg  o apontador para a imagem;                                        บ
// บ               bColor  a cor do rasto deixado pela janela quando est  a subir.           บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_clswin               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Limpa uma janela definida por (nH1,nV1,nH2,nV2) na cor bColor.             บ
// บ                                                                                          บ
// บ Parmetros:   nH1  a coordenada X do canto superior esquerdo da janela;                 บ
// บ               nV1  a coordenada Y do canto superior esquerdo da janela;                 บ
// บ               nH2  a coordenada X do canto inferior direito da janela;                  บ
// บ               nV2  a coordenada Y do canto inferior direito da janela;                  บ
// บ               bColor  a cor em que a janela deve ser limpa.                             บ
// บ                                                                                          บ
// บ NOTA: Esta funo pode servir tambm para pintar uma caixa no ecran numa determinada cor.บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_clswin( int nH1, int nV1, int nH2, int nV2, BYTE bColor )
{
   for( ; nV1 <= nV2; nV1++ )
      v_hline( nH1, nV1, nH2, bColor );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_curtain              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Limpa com efeito de cortina, uma janela definida por (nH1,nV1,nH2,nV2) na  บ
// บ               cor bColor.                                                                บ
// บ                                                                                          บ
// บ Parmetros:   nH1  a coordenada X do canto superior esquerdo da janela;                 บ
// บ               nV1  a coordenada Y do canto superior esquerdo da janela;                 บ
// บ               nH2  a coordenada X do canto inferior direito da janela;                  บ
// บ               nV2  a coordenada Y do canto inferior direito da janela;                  บ
// บ               bColor  a cor em que a janela deve ser limpa.                             บ
// บ               nSeg  o nฃmero de cortinas a correr quando  a funo executada.          บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_putbigpad            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Coloca na posio adr do ecran (memขria video) a imagem do paddle grande.  บ
// บ               Lembra-se que a dimenso do paddle grande  de 30x8 pixels.                บ
// บ                                                                                          บ
// บ Parmetros:   adr  o endereo da memขria video (ecran) onde colocar a imagem do paddle; บ
// บ               ptrImg  o apontador para a imagem do paddle grande.                       บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_vlinebigpad          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Desenha uma linha vertical de 6 pixels em preto.  utilizada para limpar o บ
// บ               rasto deixado do paddle grande quando este vai para a esquerda ou direita. บ
// บ                                                                                          บ
// บ Parmetros:   adr  o endereo da memขria video (ecran) onde colocar a imagem do paddle. บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_vlinebigpad( WORD adr )
{
   _ES = VIDEO;
   _DI = adr;
   _BX = 6;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_putlitpad            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Coloca na posio adr do ecran (memขria video) a imagem do paddle pequeno. บ
// บ               Lembra-se que a dimenso do paddle pequeno  de 16x4 pixels.               บ
// บ                                                                                          บ
// บ Parmetros:   adr  o endereo da memขria video (ecran) onde colocar a imagem do paddle; บ
// บ               ptrImg  o apontador para a imagem do paddle pequeno.                      บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_vlinelitpad          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Desenha uma linha vertical de 2 pixels em preto.  utilizada para limpar o บ
// บ               rasto deixado do paddle pequeno quando este vai para a esquerda ou direita.บ
// บ                                                                                          บ
// บ Parmetros:   adr  o endereo da memขria video (ecran) onde colocar a imagem do paddle. บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_vlinelitpad( WORD adr )
{
   _ES = VIDEO;
   _DI = adr;
   _BX = 2;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_putball              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Coloca no endereo adr do ecran (memขria video) uma bola de dimens”es      บ
// บ               ((2*nX) x nY), apontada por ptrBuf.                                        บ
// บ                                                                                          บ
// บ Parmetros:   adr  o endereo da memขria video (ecran) onde colocar o desenho da bola;  บ
// บ               nX  metade da largura da bola, ou seja, se por exemplo a bola tem 16      บ
// บ               pixels de largura, ento nX deve ser igual a 8;                            บ
// บ               ptrBuf  o apontador para a imagem da bola.                                บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_hlineball            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Desenha uma linha horizontal em preto.  utilzada para limpar o rasto      บ
// บ               deixado pela bola quando esta vai para cima ou para baixo.                 บ
// บ                                                                                          บ
// บ Parmetros:   adr  o endereo da memขria video (ecran) onde colocar a linha horizontal; บ
// บ               dim  o tamanho da linha em pixels.                                        บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_hlineball( WORD adr, int dim )
{
   _ES = VIDEO;
   _DI = adr;
   _CX = dim;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0xF3, 0xAA );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_vlineball            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Desenha uma linha vertical em preto.  utilizada para limpar o rasto       บ
// บ               deixado pela bola quando esta vai para a esquerda ou para a direita.       บ
// บ                                                                                          บ
// บ Parmetros:   adr  o endereo da memขria video (ecran) onde colocar a linha vertical;   บ
// บ               dim  o tamanho da linha em pixels.                                        บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_vlineball( WORD adr, int dim )
{
   _ES = VIDEO;
   _DI = adr;
   _BX = dim;
   _AL = 0;                                                    // Define a cor 0 (zero = preto)
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_mode                 ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Activa o modo de video especificado em Mode.                               บ
// บ                                                                                          บ
// บ Parmetros:   Mode  o modo de video a activar (para maiores detalhes consulte o manual  บ
// บ               do seu computador ou um livro de interrup”es IBMPC ou compatกvel).        บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_mode( char Mode )
{
   _AH = 0;
   _AL = Mode;
   __int__( 0x10 );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_putpal               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Escreve na palette os valores de um buffer fornecido como parmetero.      บ
// บ                                                                                          บ
// บ Parmetros:   ptrBuf  um apontador para o buffer onde que contm as cores da palette;   บ
// บ               nStart o nฃmero da primeira cor da palette a ser escrita;                  บ
// บ               nLen  o comprimento a escrever a partir de nStart.                        บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_getpal               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    L a palette de 256 cores para um buffer fornecido como parmetero.        บ
// บ                                                                                          บ
// บ Parmetros:   ptrBuf  um apontador para o buffer onde colocar os valores da palette;    บ
// บ               nStart o nฃmero da primeira cor a guardar;                                 บ
// บ               nLen  o comprimento a guardar a partir de nStart.                         บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_paloff               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Apaga os valores da palette, ou seja, produz um efeito como que a          บ
// บ               escurecer o ecran.                                                         บ
// บ                                                                                          บ
// บ Parmetros:   bHalf  uma vari vel booleana qua indica quando o ecran deve ser           บ
// บ               escurecido integralmente, ou apenas uma parte (mais ou menu metade).       บ
// บ               Assim temos:  se bHalf = 0 o ecran ser  totalmente escurecido;             บ
// บ                             se bHalf = 1 apenas "metade" do efeito ser  realizado.       บ
// บ                                                                                          บ
// บ               Um bom exemplo de como isto funciona  o jogo Sob-Gelo onde a opo "Sair" บ
// บ               realiza um fade off total (bHalf = 0), e a tecla de pausa <P> realiza      บ
// บ               metade do fade off.                                                        บ
// บ                                                                                          บ
// บ NOTA: Esta funo no funciona convenientemente com qualquer palette, mas apenas com a   บ
// บ       palette definida, por exemplo no jogo Sob-Gelo.                                    บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_palon                ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Acende os valores da palette, ou seja, produz um efeito como que a         บ
// บ               iluminar o ecran.                                                          บ
// บ                                                                                          บ
// บ Parmetros:   bHalf  uma vari vel booleana qua indica quando o ecran deve ser           บ
// บ               iluminado integralmente, ou apenas uma parte (mais ou menu metade).        บ
// บ               Assim temos:  se bHalf = 0 o ecran ser  totalmente iluminado;              บ
// บ                             se bHalf = 1 apenas "metade" do efeito ser  realizado.       บ
// บ                                                                                          บ
// บ               Um bom exemplo de como isto funciona  o jogo Sob-Gelo onde a tecla de     บ
// บ               <P> realiza metade do fade on.                                             บ
// บ                                                                                          บ
// บ NOTA: Esta funo no funciona convenientemente com qualquer palette, mas apenas com a   บ
// บ       palette definida, por exemplo no jogo Sob-Gelo.                                    บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_putimage             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Coloca uma imagem de dimenso (nH x nV), apontada por ptrBuf, nas          บ
// บ               coordenadas (nX,nY) do ecran.                                              บ
// บ                                                                                          บ
// บ Parmetros:   nX e nY so as coordenadas do ecran onde a imagem deve ser colocada;       บ
// บ               nH e nV so as dimens”es da imagem em pixels (largura x altura);           บ
// บ               ptrImg  o apontador para a imagem;                                        บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_hline                ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Desenha uma linha horizontal na cor bCorlor.                               บ
// บ                                                                                          บ
// บ Parmetros:   nH1  a coordenada inicial X da linha a desenhar;                          บ
// บ               nV  a coordenada Y da linha a desenhar;                                   บ
// บ               nH2  a coordenada final X da linha a desenhar;                            บ
// บ               bColor  a cor da linha.                                                   บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_hline( int nH1, int nV, int nH2, BYTE bColor )
{
   _ES = VIDEO;
   _DI = nV * 320 + nH1;
   _CX = nH2 - nH1 + 1;
   _AL = bColor;
   __emit__( 0xF3, 0xAA );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_vline                ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Desenha uma linha vertical na cor bColor.                                  บ
// บ                                                                                          บ
// บ Parmetros:   nH  a coordenada X da linha a desenhar;                                   บ
// บ               nV1  a coordenada inicial Y da linha a desenhar;                          บ
// บ               nV2  a coordenada final Y da linha a desenhar;                            บ
// บ               bColor  a cor da linha.                                                   บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_vline( int nH, int nV1, int nV2, BYTE bColor )
{
   _ES = VIDEO;
   _DI = nV1 * 320 + nH;
   _BX = nV2 - nV1 + 1;
   _AL = bColor;
   __emit__( 0x26, 0x88, 0x05, 0x81, 0xC7, 0x40, 0x01, 0x4B, 0x75, 0xF6 );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_box                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Desenha um rectngulo vazio no ecran na cor bColor.                        บ
// บ                                                                                          บ
// บ Parmetros:   nH1  a coordenada X do canto superior esquerdo do rectngulo;             บ
// บ               nV1  a coordenada Y do canto superior esquerdo do rectngulo;             บ
// บ               nH2  a coordenada X do canto inferior direito do rectngulo;              บ
// บ               nV2  a coordenada Y do canto inferior direito do rectngulo;              บ
// บ               bColor  a cor das linhas do rectngulo.                                   บ
// บ                                                                                          บ
// บ NOTA: Esta funo no pinta o rectngulo desenhado - para isso utilize antes a funo    บ
// บ       v_clswin().                                                                        บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_box( int nH1, int nV1, int nH2, int nV2, BYTE bColor )
{
   v_hline( nH1, nV1, nH2, bColor );
   v_hline( nH1, nV2, nH2, bColor );
   v_vline( nH1, nV1, nV2, bColor );
   v_vline( nH2, nV1, nV2, bColor );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_pixel                ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Coloca um ponto na posio (nX,nY) no ecran, na cor bColor.                บ
// บ                                                                                          บ
// บ Parmetros:   nX  a coordenada X do ponto a exibir;                                     บ
// บ               nY  a coordenada Y do ponto a exibir;                                     บ
// บ               bColor  acor do ponto a exibir.                                           บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void v_pixel( int nX, int nY, char bColor )
{
   __emit__( 0xBF, 0x00, 0xA0, 0x8E, 0xC7 );
   _DI = nY * 320 + nX;
   _AL = bColor;
   __emit__( 0x26, 0x88, 0x05 );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: v_getwin               ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Move um bloco de imagem do ecran para um buffer.                           บ
// บ                                                                                          บ
// บ Parmetros:   nH1  a coordenada X do canto superior esquerdo da imagem a guardar;       บ
// บ               nV1  a coordenada Y do canto superior esquerdo da imagem a guardar;       บ
// บ               nH2  a coordenada X do canto inferior direito da imagem a guardar;        บ
// บ               nV2  a coordenada Y do canto inferior direito da imagem a guardar;        บ
// บ               ptrBuf  um apontador para a zona de memขria (buffer) onde a imagem ser    บ
// บ               guardada.                                                                  บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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
