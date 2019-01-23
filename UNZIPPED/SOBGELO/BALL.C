//---------------------------------------------------------------------------------------------
//                                         B A L L . C
//
//                 Todas as fun”es relacionadas com a bola e o seu movimento
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                                                   Constantes
//---------------------------------------------------------------------------------------------
#define MAX_PLANS       6                                 // Nฃmero m ximo de planos existentes
#define MAX_DIRS        12                                        // Nฃmero m ximo de direc”es
#define MAX_LPP         27        // Nฃmero m ximo de linhas que cada bola se desloca por plano
#define MAX_LPP_FAST    14     // Nง m x. de linhas por plano nas direc”es r pidas (4,5,10,11)


//---------------------------------------------------------------------------------------------
//                                                            Vari veis globais da fonte BALL.C
//---------------------------------------------------------------------------------------------
// Deslocamentos (offsets) das 6 bolas dentro do ficheiro BALL.BIN (veja Manual do Programador)
static BYTE *adrBall[ MAX_PLANS ];

// Dimenso X das 6 bolas para utilizar como parmetero quando chamamos a funo v_putball()
static int PutDimX[ MAX_PLANS ] = {  9,  8,  7,  6,  5, 4 };

// Dimenso X e Y (em pixels) das 6 bolas
static int ImgDimX[ MAX_PLANS ] = { 18, 16, 14, 12, 10, 8 };
static int ImgDimY[ MAX_PLANS ] = {  7,  7,  7,  7,  7, 6 };

// Valores a somar para limpar as 1ฆ e 2ง linhas por baixo da bola quando esta vai para cima
static int Cls1BtLin[ MAX_PLANS ] = { 1920, 1920, 1920, 1920, 1600, 1280 };
static int Cls2BtLin[ MAX_PLANS ] = { 1600, 1600, 1600, 1600, 1280,  960 };

// Valores a somar para limpar 1ฆ e 2ง colunas … direita da bola quando esta vai para esquerda
static int Cls1RtLin[ MAX_PLANS ] = { 17, 15, 13, 11,  9, 7 };
static int Cls2RtLin[ MAX_PLANS ] = { 16, 14, 12, 10,  8, 6 };

// Nฃmero de pixels a avanar para ver se bola a vai bater na bancada direita
static int ReadPxlRt[ MAX_PLANS ] = { 20, 18, 16, 14, 12, 10 };

//  necess rio somar estes valores devido a um bug dos deslocamentos 7 e 9
static int Cls2RtDir[ MAX_DIRS ] = { 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0 };


//---------------------------------------------------------------------------------------------
//                                                               Fun”es locais da fonte BALL.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_0                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 0 - para cima ๑ 30๘.                                บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_0( void )
{
   v_hlineball( Ball.adr + Cls1BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr,                          ImgDimY[ Ball.plan ] );
   v_vlineball( Ball.adr + 1,                      ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      Ball.plan++;
   }

   Ball.adr -= 318;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_1                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 1 - para cima ๑ 120๘.                               บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_1( void )
{
   v_hlineball( Ball.adr + Cls1BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls2RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      Ball.plan++;
      Ball.adr -= 320;
   }
   else
      Ball.adr -=322;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_2                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 2 - para cima ๑ 45๘.                                บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_2( void )
{
   v_hlineball( Ball.adr + Cls1BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr,                          ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );
      Ball.plan++;
   }

   Ball.adr -= 319;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_3                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 3 - para cima ๑ 135๘.                               บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_3( void )
{
   v_hlineball( Ball.adr + Cls1BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      v_vlineball( Ball.adr, ImgDimY[ Ball.plan ] );
      Ball.plan++;
      Ball.adr -= 319;
   }
   else
      Ball.adr -= 321;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_4                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 4 - para cima ๑ 60๘.                                บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_4( void )
{
   v_hlineball( Ball.adr + Cls1BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_hlineball( Ball.adr + Cls2BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr,                          ImgDimY[ Ball.plan ] );

   if( ++Ball.line > MAX_LPP_FAST )   // Nง de linhas por plano (este  um deslocamento r pido)
   {
      Ball.line = 0;
      v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );
      Ball.plan++;
   }

   Ball.adr -= 639;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_5                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 5 - para cima ๑ 150๘.                               บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_5( void )
{
   v_hlineball( Ball.adr + Cls1BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_hlineball( Ball.adr + Cls2BtLin[ Ball.plan ], ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );

   if( ++Ball.line > MAX_LPP_FAST )   // Nง de linhas por plano (este  um deslocamento r pido)
   {
      Ball.line = 0;
      v_vlineball( Ball.adr, ImgDimY[ Ball.plan ] );
      Ball.plan++;
      Ball.adr -= 639;
   }
   else
      Ball.adr -= 641;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_6                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 6 - para baixo ๑ 120๘.                              บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_6( void )
{
   v_hlineball( Ball.adr,     ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr,     ImgDimY[ Ball.plan ] );
   v_vlineball( Ball.adr + 1, ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      Ball.plan--;
   }

   Ball.adr += 322;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_7                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 7 - para baixo ๑ 30๘.                               บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_7( void )
{
   v_hlineball( Ball.adr,                          ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls2RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      Ball.plan--;
      Ball.adr += 316;
   }
   else
      Ball.adr += 318;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_8                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 8 - para baixo ๑ 135๘.                              บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_8( void )
{
   v_hlineball( Ball.adr, ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr, ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      Ball.plan--;
   }

   Ball.adr += 321;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_9                  ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 9 - para baixo ๑ 45๘.                               บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_9( void )
{
   v_hlineball( Ball.adr,                          ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );

   if( ++Ball.line == MAX_LPP )
   {
      Ball.line = 0;
      Ball.plan--;
      Ball.adr += 317;
   }
   else
      Ball.adr += 319;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_10                 ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 10 - para baixo ๑ 150๘.                             บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_10( void )
{
   v_hlineball( Ball.adr,       ImgDimX[ Ball.plan ] );
   v_hlineball( Ball.adr + 320, ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr,       ImgDimY[ Ball.plan ] );

   if( ++Ball.line > MAX_LPP_FAST )   // Nง de linhas por plano (este  um deslocamento r pido)
   {
      Ball.line = 0;
      Ball.plan--;
   }

   Ball.adr += 641;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: dir_11                 ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Executa o deslocamento 11 - para baixo ๑ 60๘.                              บ
// บ               Consulte o manual do programador para mais detalhe.                        บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void dir_11( void )
{
   v_hlineball( Ball.adr,                          ImgDimX[ Ball.plan ] );
   v_hlineball( Ball.adr + 320,                    ImgDimX[ Ball.plan ] );
   v_vlineball( Ball.adr + Cls1RtLin[ Ball.plan ], ImgDimY[ Ball.plan ] );

   if( ++Ball.line > MAX_LPP_FAST )   // Nง de linhas por plano (este  um deslocamento r pido)
   {
      Ball.line = 0;
      Ball.plan--;
      Ball.adr += 637;
   }
   else
      Ball.adr += 639;
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: lost_ball              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta  a funo  chamada sempre que um jogador no consegue defender a    บ
// บ               bola, ou seja, sempre que se perde uma bola. A funo rep”e no ecran a     บ
// บ               bola no defendida e em seguida emite o som correspondente a perder uma    บ
// บ               bola. Depois a funo actualiza o status, ou seja, atribui um ponto ao     บ
// บ               jogador que ganhou a bola e decrementa a vari vel Status.balls que guarda  บ
// บ               o nฃmero de bolas ainda para jogar. Finalmente aguarda por uma tecla.      บ
// บ                                                                                          บ
// บ Parmetros:   adrVideo  o endereo do ecran onde a bola deve ser colocada;              บ
// บ               nPlan  o plano da bola exibida, ou seja, se foi o jogador 1 quem perdeu a บ
// บ               bola, ento o plano deve ser 0. Se o foi o jogador 2 ento o plano deve    บ
// บ               ser o 6.                                                                   บ
// บ               Note ainda que a funo limpa o ecran antes de terminar, visto que se um   บ
// บ               jogador perdeu a bola, ento vai jogar outra bola (se ainda houver bolas   บ
// บ               para jogar), ou vai regressar ao menu (se j  no houver bolas para jogar). บ
// บ                                                                                          บ
// บ Retorna:      A funo retorna um valor booleano:                                        บ
// บ               - 0 se j  no existem mais bolas para jogar;                               บ
// บ               - 1 se ainda existem mais bolas para jogar;                                บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static int lost_ball( WORD adrVideo, int nPlan )
{
   v_putball( adrVideo, PutDimX[ nPlan ], ImgDimY[ nPlan ], adrBall[ nPlan ] );   // Exibe bola
   s_lost_ball();                                                  // Emite som - perdeu a bola

   if( nPlan )                         // Se o plano no  0, ento quem perdeu foi o jogador 2
      Status.player1++;                // Atribui mais um ponto para o jogado 1 (paddle grande)
   else                            // Seno, ento o plano  0 logo quem perdeu foi o jogador 1
      Status.player2++;              // Atribui mais um ponto para o jogador 2 (paddle pequeno)

   Status.balls--;                                                 // Menos uma bola para jogar
   game_status();           // Actualiza o status do jogo (nง de bolas para jogar e pontua”es)

   if( nOpponent == 2 )                                          // Se o advers rio est  no PC2
      report_pc2( BALL_LOSTED );       // Informa o PC2 que a bola no foi defendida deste lado

   if( nOpponent != 2 || Status.balls )               // Caso especial para o advers rio no PC2
   {
      while( KEYPRESSED );                 // Aguarda - enquanto estiver a pressionar uma tecla
      while( !KEYPRESSED );                 // Aguarda - enquanto no for pressionada uma tecla

      cls_game_area();                                   // Limpa o ecran antes de se ir embora
   }

   return( ( Status.balls > 0 ) ? TRUE : FALSE );    // Retorna .T. se existem bolas para jogar
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: ball_goes_up           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta  a funo que re-inicializa as vari veis da bola cada vez que ela    บ
// บ               atinge o big paddle e vai voltar para cima.                                บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void ball_goes_up( void )
{
   Ball.adr  = 55680 + ( Ball.adr % 320 ) + Cls2RtDir[ Ball.dir ];     // Bola na posio certa
   Ball.line = 0;                              // Re-inicializa Ball.line para voltar para cima
   Ball.plan = 0;                                 // A bola vai subir logo Ball.plan deve ser 0

   s_ball_hit_paddle();                                         // Som - a bola bateu no paddle
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: lp_hitball             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Verifica se o little paddle defendeu a bola e age em conformidade. Assim   บ
// บ               se a bola foi defendida a funo verifica com que zona do paddle foi feita บ
// บ               a defesa e determina a direco que a bola ir  todar no regresso. Se o     บ
// บ               little paddle no defendeu a bola  chamada uma outra funo que se        บ
// บ               encarrega de processar a morte do little paddle.                           บ
// บ                ainda nesta funo que se define o movimento da bola em caso de teste.   บ
// บ               Se a directiva (para o compilador) TEST = 1 for definida a bola nunca ser  บ
// บ               perdida mesmo que no seja apanhada pelo little paddle.                    บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ NOTA: No fundo esta funo executa exactamente o mesmo trabalho que a funo bp_hitball, บ
// บ       sข que em relao ao little paddle. Neste caso, vem de baixo e caso seja defendida บ
// บ       ir  voltar para baixo. Como tal, grande parte das verifica”es e atribui”es, so  บ
// บ       executadas ao contr rio.                                                           บ
// บ       Consulte o manual do programador sobre os deslocamentos descendentes da bola.      บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static void lp_hitball( void )
{
#ifndef TEST

   BYTE *ptrBallLf = ( BYTE * )MK_FP( VIDEO, Ball.adr - 320 );          // L um pixel do ecran
   BYTE *ptrBallRt = ( BYTE * )MK_FP( VIDEO, Ball.adr - 313 );          // L um pixel do ecran

   if( *ptrBallLf && *ptrBallRt )
   // A bola bateu no meio do little paddle - retorna com o mesmo ngulo
   {
      ball_goes_dn();                // A bola vai para baixo - re-inicializa as suas vari veis
      Ball.dir += 6;                                // Muda a direco da bola: (MAX_PLANS - 1)
   }
   else if( *ptrBallLf )
   // A bola bateu do lado esquerdo do big paddle
   {
      ball_goes_dn();                // A bola vai para baixo - re-inicializa as suas vari veis

      if( ODD( Ball.dir ) )                                          // A bola vinha da direita
	 Ball.dir += ( Ball.dir == 1 ) ? 10 : 4;                             // Muda a direco
      else                                                          // A bola vinha da esquerda
	 Ball.dir += ( Ball.dir == 4 ) ?  2 : 8;                             // Muda a direco
   }
   else if( *ptrBallRt )
   // A bola bateu do lado direito do big paddle
   {
      ball_goes_dn();                // A bola vai para baixo - re-inicializa as suas vari veis

      if( ODD( Ball.dir ) )                                          // A bola vinha da direita
	 Ball.dir += ( Ball.dir == 5 ) ? 2 : 8;                              // Muda a direco
      else                                                          // A bola vinha da esquerda
	 Ball.dir += ( Ball.dir == 0 ) ? 10 : 4;                             // Muda a direco
   }
   else if( lost_ball( Ball.adr, MAX_PLANS - 1 ) )
   // A bola no bateu no little paddle - o computador/jogador2/jogador2pc2 perdeu
   {
      start_lpad();                 // Re-inicializa as vari veis da bola para o paddle pequeno
      init_paddles();                               // Coloca os paddles nas posi”es correctas
      wait_for_SPACE();               // Aguarda - enquanto no for pressionada a tecla <SPACE>
   }

#else                  // TEST=1  Directiva para o compilador para testar os movimentos da bola

   ball_goes_dn();                   // A bola vai para baixo - re-inicializa as suas vari veis
   Ball.dir = ( ODD( Ball.dir ) ) ? random( 3 ) * 2 + 7 : random( 3 ) * 2 + 6; // Muda direco

#endif
}


//---------------------------------------------------------------------------------------------
//                                                             Fun”es externas da fonte BALL.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: ball_goes_dn           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta  a funo que re-inicializa as vari veis da bola cada vez que ela    บ
// บ               atinge o little paddle e vai voltar para baixo.                            บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void ball_goes_dn( void )
{
   Ball.adr  = 4160 + ( Ball.adr % 320 );                         // Coloca bola na linha certa
   Ball.line = 0;                             // Re-inicializa Ball.line para voltar para baixo
   Ball.plan = MAX_PLANS - 1;                    // A bola vai descer logo Ball.plan deve ser 5

   s_ball_hit_paddle();                                         // Som - a bola bateu no paddle
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: bp_hitball             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Verifica se o big paddle defendeu a bola e age em conformidade. Assim se   บ
// บ               a bola foi defendida a funo verifica com que zona do paddle foi feita a  บ
// บ               defesa e determina a direco que a bola ir  todar no regresso. Se o big   บ
// บ               paddle no defendeu a bola  chamada uma outra funo que se encarrega de  บ
// บ               processar a morte o big paddle.                                            บ
// บ                ainda nesta funo que se define o movimento da bola em caso de teste.   บ
// บ               Se a directiva (para o compilador) TEST = 1 for definida a bola nunca ser  บ
// บ               perdida mesmo que no seja apanhada pelo big paddle.                       บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ NOTA: Neste caso existe um erro, ou seja, quando a bola vem do lado direito com um       บ
// บ       deslocamento igual a 7 ou 9, as suas duas colunas direitas no so apagadas quando บ
// บ       bate no big paddle. Como tal  necess rio apag -las de outra forma - … unha.  O    บ
// บ       mtodo utilizado  pouco vers til mas funciona eficazmente e, acima de tudo foi o  บ
// บ       mais r pido que encontrei.  assim: no inกcio foi definido um array chamado        บ
// บ       Cls2RtDir[ 12 ], que significa "limpa o ecran 2 colunas … direita da bola 	      บ
// บ       dependendo da direco".  Como se pode ver o array tem 12 posi”es, uma vez que,   บ
// บ       existem 12 direc”es (deslocamentos) diferentes.  Apesar de tudo, o ecran no     บ
// บ       limpo no verdadeiro sentido da palavra.  A tcnica utilizada  outra: a prขxima    บ
// บ       bola  colocada 2 colunas mais … direita, de tal forma que ela ir  limpar o rasto  บ
// บ       deixado pela bola anterior.  Ora, para deslocar uma imagem qualquer 2 pixels …     บ
// บ       direita basta somar 2 ao seu endereo de ecran (memขria video).  Como este         บ
// บ       problema sข ocorre nos deslocamentos 7 e 9, vem que tais posi”es no array         บ
// บ       Cls2RtDir[] contm o valor 2 (todas as outras esto a zero).  Deste modo quando a  บ
// บ       bola se deslocar nas direc”es 7 e 9 o seu endereo ser  incrementado de 2 ao      บ
// บ       bater no big paddle; nos outros casos o incremento ser  0 (zero). PERCEBIDO ???    บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void bp_hitball( void )
{
#ifndef TEST

   BYTE *ptrBallLf = ( BYTE * )MK_FP( VIDEO, Ball.adr + 2240 );         // L um pixel do ecran
   BYTE *ptrBallRt = ( BYTE * )MK_FP( VIDEO, Ball.adr + 2258 );         // L um pixel do ecran

   if( *ptrBallLf && *ptrBallRt )
   // A bola bateu no meio do big paddle - retorna com o mesmo ngulo
   {
      ball_goes_up();                 // A bola vai para cima - re-inicializa as suas vari veis
      Ball.dir -= 6;                                // Muda a direco da bola: (MAX_PLANS - 1)
   }
   else if( *ptrBallLf )
   // A bola bateu do lado esquerdo do big paddle
   {
      ball_goes_up();                 // A bola vai para cima - re-inicializa as suas vari veis

      if( ODD( Ball.dir ) )                                       // Se a bola vinha da direita
	 Ball.dir -= ( Ball.dir == 11 ) ? 10 : 4;                            // Muda a direco
      else                                                       // Se a bola vinha da esquerda
	 Ball.dir -= ( Ball.dir ==  6 ) ?  2 : 8;                            // Muda a direco
   }
   else if( *ptrBallRt )
   // A bola bateu do lado direito do big paddle
   {
      ball_goes_up();                 // A bola vai para cima - re-inicializa as suas vari veis

      if( ODD( Ball.dir ) )                                       // Se a bola vinha da direita
	 Ball.dir -= ( Ball.dir ==  7 ) ? 2 :  8;                            // Muda a direco
      else                                                       // Se a bola vinha da esquerda
	 Ball.dir -= ( Ball.dir == 10 ) ? 10 : 4;                            // Muda a direco
   }
   else if( lost_ball( Ball.adr + Cls2RtDir[ Ball.dir ], 0 ) )
   // A bola no bateu no big paddle - o jogador 1 perdeu
   {
      start_bpad();                  // Re-inicializa as vari veis da bola para o paddle grande
      init_paddles();                               // Coloca os paddles nas posi”es correctas
      wait_for_SPACE();               // Aguarda - enquanto no for pressionada a tecla <SPACE>
   }

#else                  // TEST=1  Directiva para o compilador para testar os movimentos da bola

   ball_goes_up();                    // A bola vai para cima - re-inicializa as suas vari veis
   Ball.dir = ( ODD( Ball.dir ) ) ? random( 3 ) * 2 + 1 : random( 3 ) * 2;   // Muda a direco

#endif
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: load_ball              ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inicializa o array adrBall. Este array tem 6 posi”es, sendo que cada uma  บ
// บ                o endereo da imagem de uma bola.                                        บ
// บ               Ou seja, como se sabe existem 6 imagens da bola (desde a maior, at … mais บ
// บ               pequena). Cada uma dessas imagens pode ser acedida atravs de um apontador บ
// บ               para a memขria. Assim, por forma a tornar esse acesso o mais r pido        บ
// บ               possกvel, inicialmente foi definido um array de apontadores com 6 (seis)   บ
// บ               posi”es. Por exemplo, para exibir a imagem da bola 4, basta mandar exibir บ
// บ               a imagem apontada por adrBall[ 3 ] (lembre-se que em linguagem C os arrays บ
// บ               iniciam em zero).                                                          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void load_ball( void )
{
   int i;                                                            // Contador para ciclo for
   int Ball[ MAX_PLANS ] = { 0, 126, 238, 336, 420, 490 };               // Dimens”es das bolas

   adrBall[ 0 ] = getfile( "BALLS.BIN", O_BINARY );                 // Carrega imagem das bolas

   for( i = 1; i < MAX_PLANS; i++ )                               // Define o endereo efectivo
      adrBall[ i ] = adrBall[ 0 ] + Ball[ i ];                    // para cada uma das 7 bolas
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: start_bpad             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta funo inicializa as vari veis da bola.  chamada em duas situa”es:  บ
// บ               - quando um novo jogo vai comear e a bola sai do jogador 1 (big paddle);  บ
// บ               - quando um jogador 1 (big paddle) sofre um golo.                          บ
// บ               J  agora, convm explicar o que  isto de inicalizar as vari veis da bola. บ
// บ               No que refere … bola, existem quatro vari veis que lhe esto directamente  บ
// บ               relacionadas. So elas, Ball.adr (endreo da bola no ecran - memขria       บ
// บ               video), Ball.dir (direco da bola = [0,11]), Ball.plan (plano da bola =   บ
// บ               = [0,6]), e finalmente Ball.line (nฃmero da linha dentro do plano actual). บ
// บ               Quando um jogo comea ou o jogador 1 (big paddle) sofre um golo, a bola    บ
// บ               deve ser colocada sobre o paddle do jogador 1, j  que  dele que a bola    บ
// บ               sai ou foi ele que sofreu um golo. Assim todas estas vari veis devem ser   บ
// บ               reinicializadas (consulte o Manual do Programador para mais informaoes).  บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void start_bpad( void )
{
   Ball.plan = 0;                                                   // O plano inicial  o zero
   Ball.adr  = 55831;                                // A bola comea no meio do ecran em baixo
   Ball.dir  = random( 4 ) + 2;         // A bola comea com uma direco aleatขria (para cima)
   Ball.line = 0;                        // Inicializa vari vel est tica no inกcio de cada bola

   v_putball( Ball.adr, PutDimX[ Ball.plan ], ImgDimY[ Ball.plan ], adrBall[ Ball.plan ] );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: start_lpad             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta funo inicializa as vari veis da bola.  chamada em duas situa”es:  บ
// บ               - quando um novo jogo vai comear e a bola sai do jogador 2 (lit. paddle); บ
// บ               - quando um jogador 2 (little paddle) sofre um golo.                       บ
// บ               J  agora, convm explicar o que  isto de inicalizar as vari veis da bola. บ
// บ               No que refere … bola, existem quatro vari veis que lhe esto directamente  บ
// บ               relacionadas. So elas, Ball.adr (endreo da bola no ecran - memขria       บ
// บ               video), Ball.dir (direco da bola = [0,11]), Ball.plan (plano da bola =   บ
// บ               = [0,6]), e finalmente Ball.line (nฃmero da linha dentro do plano actual). บ
// บ               Quando um jogo comea ou o jogador 2 (little paddle) sofre um golo, a bola บ
// บ               deve ser colocada sobre o paddle do jogador 2, j  que  dele que a bola    บ
// บ               sai ou foi ele que sofreu um golo. Assim todas estas vari veis devem ser   บ
// บ               reinicializadas (consulte o Manual do Programador para mais informaoes).  บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void start_lpad( void )
{
   Ball.plan = MAX_PLANS - 1;                                      // O plano inicial  o cinco
   Ball.adr  = 4316;                                  // A bola comea no meio do ecran em cima
   Ball.dir  = random( 6 ) + 6;        // A bola comea com uma direco aleatขria (para baixo)
   Ball.line = 0;                        // Inicializa vari vel est tica no inกcio de cada bola

   v_putball( Ball.adr, PutDimX[ Ball.plan ], ImgDimY[ Ball.plan ], adrBall[ Ball.plan ] );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: eval_balldir           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Avalia a direo da bola e desloca-a nesse sentido. A bola pode            บ
// บ               deslocar-se em 12 direc”es (sentidos) diferentes.                         บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void eval_balldir( void )
{
   switch( Ball.dir )
   {
      case  0:    dir_0();   break;                      // Deslocamento  0 - para cima  ๑  30๘
      case  1:    dir_1();   break;                      // Deslocamento  1 - para cima  ๑ 120๘
      case  2:    dir_2();   break;                      // Deslocamento  2 - para cima  ๑  45๘
      case  3:    dir_3();   break;                      // Deslocamento  3 - para cima  ๑ 135๘
      case  4:    dir_4();   break;                      // Deslocamento  4 - para cima  ๑  60๘
      case  5:    dir_5();   break;                      // Deslocamento  5 - para cima  ๑ 150๘
      case  6:    dir_6();   break;                      // Deslocamento  6 - para baixo ๑ 120๘
      case  7:    dir_7();   break;                      // Deslocamento  7 - para baixo ๑  30๘
      case  8:    dir_8();   break;                      // Deslocamento  8 - para baixo ๑ 135๘
      case  9:    dir_9();   break;                      // Deslocamento  9 - para baixo ๑  45๘
      case 10:   dir_10();   break;                      // Deslocamento 10 - para baixo ๑ 150๘
      case 11:   dir_11();   break;                      // Deslocamento 11 - para baixo ๑  60๘
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: ball_hit_wall          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Verifica se a bola atingiu alguma das bancadas esquerda ou direita. Se sim บ
// บ               ento a direco da bola ser  alterada de acordo com a direco anterior.  บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void ball_hit_wall( void )
{
   if( ODD( Ball.dir ) )
   // Se Ball.dir  กmpar ento a bola vinha da direita
   {
      if( *( BYTE * )MK_FP( VIDEO, Ball.adr - 3 ) )
      // L um pixel do ecran … esquerda da bola
      {
	 Ball.dir--;                                                        // Muda de direco
	 s_ball_hit_wall();                                        // Bateu na bancada esquerda
      }
   }
   else if( *( BYTE * )MK_FP( VIDEO, Ball.adr + ReadPxlRt[ Ball.plan ] ) )
   // Seno, a bola vinha da esquerda, logo l um pixel do ecran … direita da bola
   {
      Ball.dir++;                                                           // Muda de direco
      s_ball_hit_wall();                                            // Bateu na bancada direita
   }
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: move_ball_01           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Funo que determina o movimento da bola quanado os advers rios so ou o   บ
// บ               computador, ou outro jogador no mesmo. Isto , quando a vari vel nOpponent บ
// บ                igual a 0 ou 1. A funo encarrega-se ainda de verificar se a bola ter   บ
// บ               chegado ao topo ou ao fundo do ecran (pois pode ter sido defendida).       บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void move_ball_01( void )
{
   eval_balldir();                                    // Desloca a bola na direco de Ball.dir

   if( Ball.adr > 56000 )
   // Bateu na base - vamos verificar se o big paddle defende a bola
      bp_hitball();
   else if( Ball.adr < 4160 )
   // Bateu no topo - vamos verificar se o little paddle defende a bola
      lp_hitball();
   else
   // Caso contr rio coloca a bola na sua nova posio
      v_putball( Ball.adr, PutDimX[ Ball.plan ], ImgDimY[ Ball.plan ], adrBall[ Ball.plan ] );

   ball_hit_wall();      // Verifica se a bola bateu numa das bancadas - se sim muda a direco
}
