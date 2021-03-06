//---------------------------------------------------------------------------------------------
//                                     K E Y B O A R D . C
//
//                         Todas as fun��es relacionadas com o teclado
//---------------------------------------------------------------------------------------------

#pragma inline                  // Avisa o compilador que esta fonte cont�m c�digo em assembler

void interrupt( *oldint )();   // Interrupt handler p/ salvar vector da rotina do interrupt 09H


//---------------------------------------------------------------------------------------------
//                                                           Fun��es locais da fonte KEYBOARD.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: k_sob_gelo             � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Esta � a nova rotina que se instala na interrup��o 09H. Esta fun��o produz �
// �               o processamento de teclado ideal ao jogo Sob-Gelo, isto �, todo o tipo de  �
// �               redund�ncias de teclado - teclas nunca utilizadas, etc. - foram            �
// �               simplesmente eliminadas.                                                   �
// �               Para mais explica��es e informa��es sobre a necessidade desta nova rotina, �
// �               consulte o manual do programador.                                          �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
static void interrupt k_sob_gelo( void )
{
   BYTE tecla;

   asm {
      in al, 0x60                                               // L� o c�digo da tecla premida
      mov tecla, al                                           // Devolve o c�digo lido em tecla
      in al, 0x61                                              // Sinaliza a leitura do teclado
      or al, 0x80                                                         // Keyboard acknolege
      out 0x61, al
      and al, 0x7f                                                           // Keyboard enable
      out 0x61, al
      mov al, 0x20                                                   // End of interrupt ao PIC
      out 0x20, al
   }

   KEYPRESSED = ( tecla > 0x80 ) ? FALSE : TRUE;   // Verifica se alguma tecla est� pressionada

   switch( tecla )
   {
      case  0x4D         : KEY_RIGHT  = TRUE;  break;   // Make code da tecla "arrow-key right"
      case( 0x4D + 0x80 ): KEY_RIGHT  = FALSE; break;  // Break code da tecla "arrow-key right"

      case  0x4B         : KEY_LEFT   = TRUE;  break;    // Make code da tecla "arrow-key left"
      case( 0x4B + 0x80 ): KEY_LEFT   = FALSE; break;   // Break code da tecla "arrow-key left"

      case  0x2C         : KEY_Z      = TRUE;  break;                 // Make code da tecla <Z>
      case( 0x2C + 0x80 ): KEY_Z      = FALSE; break;                // Break code da tecla <Z>

      case  0x2E         : KEY_C      = TRUE;  break;                 // Make code da tecla <C>
      case( 0x2E + 0x80 ): KEY_C      = FALSE; break;                // Break code da tecla <C>

      case  0x1          : KEY_ESCAPE = TRUE;  break;            // Make code da tecla <ESCAPE>
      case( 0x1 + 0x80 ) : KEY_ESCAPE = FALSE; break;           // Break code da tecla <ESCAPE>

      case  0x19         : KEY_PAUSE  = TRUE;  break;                 // Make code da tecla <P>
      case( 0x19 + 0x80 ): KEY_PAUSE  = FALSE; break;                // Break code da tecla <P>

      case  0x39         : KEY_SPACE  = TRUE;  break;             // Make code da tecla <SPACE>
      case( 0x39 + 0x80 ): KEY_SPACE  = FALSE; break;            // Break code da tecla <SPACE>

      case  0x48         : KEY_UP     = TRUE;  break;      // Make code da tecla "arrow-key up"
      case( 0x48 + 0x80 ): KEY_UP     = FALSE; break;     // Break code da tecla "arrow-key up"

      case  0x50         : KEY_DOWN   = TRUE;  break;    // Make code da tecla "arrow-key down"
      case( 0x50 + 0x80 ): KEY_DOWN   = FALSE; break;   // Break code da tecla "arrow-key down"

      case  0x4E         :                                        // Make code da tecla <ENTER>
      case  0x1C         : KEY_ENTER  = TRUE;  break;            // Make code da tecla <RETURN>
      case( 0x4E + 0x80 ):                                       // Break code da tecla <ENTER>
      case( 0x1C + 0x80 ): KEY_ENTER  = FALSE; break;           // Break code da tecla <RETURN>

      default:
	 break;
   }
}


//---------------------------------------------------------------------------------------------
//                                                         Fun��es externas da fonte KEYBOARD.C
//---------------------------------------------------------------------------------------------

// ������������������������������������������������������������������������������������������ͻ
// � Nome: k_set                  � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Salva a rotina de atendimento de teclado do PC, e instala uma nova rotina  �
// �               na interrup��o 09H.                                                        �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void k_set( void )
{
   oldint = getvect( 0x09 );                                  // Guarda rotina do interrupt 09h
   setvect( 0x09, k_sob_gelo );                         // Instala nova rotina no interrupt 90h
}


// ������������������������������������������������������������������������������������������ͻ
// � Nome: k_reset                � Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) �
// ������������������������������������������������������������������������������������������Ķ
// � Objectivo:    Rep�e a rotina original da interrup��o 09H. O vector (4 bytes) da rotina   �
// �               original, haviam sido guardados na fun��o *odlint() definida como          �
// �               interrupt, o que garante que o compilador a terminar� com uma instru��o    �
// �               IRET (regresso de rotina de interrupt).                                    �
// �                                                                                          �
// � Par�metros:   Nenhum                                                                     �
// ������������������������������������������������������������������������������������������ͼ
void k_reset( void )
{
   setvect( 0x09, oldint );                         // Rep�e a rotina original no interrupt 09h
}
