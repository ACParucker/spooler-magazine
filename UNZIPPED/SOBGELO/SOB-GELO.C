//---------------------------------------------------------------------------------------------
//                                       S O B - G E L O
//
//                  Mขdulo principal -  aqui que tudo comea e tudo acaba...
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                                 Livraias utilizadas (header)
//---------------------------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <dos.h>
#include <fcntl.h>
#include <sys\stat.h>
#include <io.h>
#include <string.h>
#include <time.h>


//---------------------------------------------------------------------------------------------
//                                                                                    Interface
//---------------------------------------------------------------------------------------------
#include "global.h"                                      // Arquivo header de vari veis globais
#include "execute.c"                                    // Procedimentos principais do programa
#include "video.c"                                         // Rotinas de video para o modo MCGA
#include "sound.c"                                                    // Rotinas de som do jogo
#include "keyboard.c"                                                     // Rotinas de teclado
#include "error.c"                                             // Rotina de tratamento de erros
#include "miscelan.c"                                      // V rias fun”es com v rias tarefas
#include "menu.c"                                      // Menu: JOGAR, Advers rio, TABELA, SAIR
#include "scores.c"                                            // Tudo sobre a tabela de scores
#include "play.c"                                           // Inกcio do jogo propriamente dito
#include "levels.c"                 // Fun”es relacionadas com o nกvel de dificuladade do jogo
#include "rs232.c"                                          // Rotinas relacionadas com a RS232
#include "syncronz.c"                                  // Rotinas para sincronizar os dois PC's
#include "ball.c"                                  // Rotinas da bola (movimento, choque, etc.)
#include "ballpc2.c"                 // Rotinas da bola mas para comunicao entre os dois PC's
#include "bigpadle.c"                               // Fun”es relacionadas com o paddle grande
#include "litpadle.c"                              // Fun”es relacionadas com o paddle pequeno
#include "computer.c"           // Fun”es do paddle pequeno quando o advers rio  o computador
#include "player2.c"  // Fun”es do paddle pequeno quando advers rio  outra pessoa no mesmo PC


//---------------------------------------------------------------------------------------------
//                                                                                  Funo main
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: main (Sob-Gelo)        ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Funo principal (main) do jogo Sob-Gelo.                                  บ
// บ                aqui que tudo comea e acaba.                                            บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void main( void )
{
   init_sob_gelo();                                                        // Inicializa o jogo
   menu_sob_gelo();                                                 // Menu principal de op”es
   exit_sob_gelo();                                                // Termina e regressa ao DOS
}
