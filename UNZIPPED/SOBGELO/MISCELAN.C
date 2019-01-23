//---------------------------------------------------------------------------------------------
//                                     M I S C E L A N . C
//
//                     Miscelanea de fun”es utilizadas no jogo "SUB-GELO"
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                         Fun”es externas da fonte MISCELAN.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: load_letters           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inicializa o apontador para a imagem das letras, nฃmeros, etc. (enfim,     บ
// บ               todos os caracters necess rios e utilizados no jogo).                      บ
// บ               Consulte o manual do programador.                                          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void load_letters( void )
{
   ptrLetters = getfile( "CHARS.BIN", O_BINARY );           // Carrega as letras, nฃmeros, etc.
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: load_name              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inicializa o apontador para a imagem do nome do jogo.                      บ
// บ               Consulte o manual do programador.                                          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void load_name( void )
{
   ptrName = getfile( "SOB-GELO.BIN", O_BINARY );     // Carrega a imagem "SOB-GELO" na memขria
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: back_letters           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Processa o rodap no inกcio do jogo. Esta funo  chamada de v rios       บ
// บ               locais, como por exemplo da fonte MENU.C ou ainda da fonte SCORES.C        บ
// บ               Daก que ela possui vari veis est cticas (que conservam os seus valores),   บ
// บ               para que o rodap seja exibido contกnuamente.                              บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void back_letters( void )
{
   static int i, j, nIdx = 0, k = 0;                                              // Contadores
   static BYTE far *ptrX, far *ptrY;                // Apontadores para o ecran (memขria video)
   static BYTE *text = "SPOOLER^SOB=GELO?^AUTOR:^JORGE^ALEXANDRE^CABRITA^MORGADO^>>>>^SOB=GELO\
^=^MADE^IN^BARREIRO^=^PORTUGAL^>>>>>^";

   ptrX = ( BYTE far * )MK_FP( VIDEO, 61440 );   // Define apontador para ฃltima linha do ecran

   for( j = 0; j < 319; j++, ptrX++ )                                         // Este pedao de
   {                                                                          // cขdigo copia a
      ptrY = ptrX;                                                            // ฃltima linha
									      // do ecran, e
      for( i = 0; i < 8; i++, ptrY += 320 )                                   // desloca-a um
	 *ptrY = *( ptrY + 1 );                                               // pixel para a
   }                                                                          // esquerda

   for( i = 0; i < 8; i++ )                          // Escreve nova coluna de pixels do rodap
      v_pixel( 319, 192 + i, *( ptrLetters + ( ( *( text + nIdx ) - 48 ) * 64 ) + i * 8 + k ));

   if( ++k > 7 )
   {
      k = 0;

      if( ++nIdx > 106 )              // 106  o nฃmero de caracteres do rodap - quando chegar
	 nIdx = 0;                    // ao final, volta a zero, e recomea tudo outra vez
   }

   delay( 5 );                                                       // At os miฃdos podem ler
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: cls_game_area          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Limpa a  rea do jogo, isto , toda a zona de movimento quer da bola, quer  บ
// บ               dos paddles grande e pequeno.                                              บ
// บ               Esta funo  chamada, fundamentalmente quando inicia ou termina um jogo,  บ
// บ               ou quando uma bola no  defendida e ainda existem bolas para jogar.       บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
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


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: cls_bottom_line        ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Limpa a ฃltima linha do ecran. Note que  nesta linha que aparecem a maior บ
// บ               parte das mensagens do jogo.                                               บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void cls_bottom_line( void )
{
   v_clswin( 0, 192, 319, 199, 0 );               // Limpa toda a zona do rodap (ฃltima linha)
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: write_str              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Escreve a partir da posio (nX,nY) a frase apontada por ptrStr.           บ
// บ                                                                                          บ
// บ Parmetros:   nX e nY so as cooredenadas (em pixels) da frase a escrever;               บ
// บ               ptrStr  a frase a escrever - como se saber, em linguagem C, as strings    บ
// บ               so definidas por um apontador para um conjunto de caracteres.             บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void write_str( int nX, int nY, char *ptrStr )
{
   while( *ptrStr )              // Enquanto no apanhar o caracter fim de string ('\0' = NULL)
   {
      v_putimage( nX, nY, 8, 8, ptrLetters + ( *ptrStr - 48 ) * 64 );      // Escreve uma letra
      ptrStr++;                                              // Avana para o prขximo caractere
      nX += 8;                                       // Avana 8 pixels (largura de cada letra)
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: getfile                ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Abre e carrega na memขria um ficheiro do tipo nType. Em caso de erro exibe บ
// บ               a respectiva mensagem.                                                     บ
// บ                                                                                          บ
// บ Parmetros:   ptrFileName  o nome do ficheiro a abrir e carregar em memขria;            บ
// บ               nType  o tipo do ficheiro a abrir. Por exemplo, se deseja abrir um        บ
// บ               ficheiro do tipo bin rio ento nType deve ser igual a O_BINARY; do mesmo   บ
// บ               modo se deseja abrir um ficheiro de texto nType deve ser O_TEXT (veja      บ
// บ               a livraria FCNTL.H para mais informa”es).                                 บ
// บ                                                                                          บ
// บ Retorna:      A funo retorna um apontador para o inกcio da informao do ficheiro      บ
// บ               carregado em memขria.                                                      บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
BYTE *getfile( char *ptrFileName, const int nType )
{
   int nHandle;                                                           // Handle do ficheiro
   WORD nFlen;                                                       // Comprimento do ficheiro
   BYTE *ptrBuf;                            // Apontador para o conteฃdo do ficheiro em memขria

   if( ( nHandle = open( ptrFileName, nType ) ) < 0 )         // Se ocorreu um erro na abertura
      exit_with_error( ptrFileName );                       // Informa o erro e regressa ao DOS

   nFlen = filelength( nHandle );                            // Obtm o comprimento do ficheiro

   if( ( ptrBuf = ( BYTE * )malloc( nFlen ) ) == NULL ) // Se houve erro na alocao de memขria
      exit_with_error( "Memขria" );                         // Informa o erro e regressa ao DOS

   read( nHandle, ptrBuf, nFlen );           // L o ficheiro para a memขria (apontador ptrBuf)
   close( nHandle );                                                        // Fecha o ficheiro

   return ( ptrBuf );           // Retorna um apontador para o inกcio da informao do ficheiro
}
