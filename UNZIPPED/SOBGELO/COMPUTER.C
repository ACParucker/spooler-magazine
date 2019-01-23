//---------------------------------------------------------------------------------------------
//                                  C O M P U T E R . C
//
//        Fun‡”es relacionadas com o paddle pequeno quando o advers rio ‚ o computador
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                         Fun‡”es externas da fonte COMPUTER.C
//---------------------------------------------------------------------------------------------

// ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
// º Nome: computer_1             ³ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) º
// ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
// º Objectivo:    Processa o movimento do paddle pequeno quando este ‚ controlado pelo       º
// º               computador. A fun‡„o processa tando a defesa como o ataque e em alguns     º
// º               casos insere um factor aleat¢rio.                                          º
// º                                                                                          º
// º Parƒmetros:   Nenhum                                                                     º
// º                                                                                          º
// º NOTA: Neste n¡vel o computador falha a maioria das bolas com deslocamento 1.             º
// ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
void computer( void )
{
   if( Ball.dir > 5 )
   // Se a bola vai para baixo move o paddle pequeno para o meio
   {
      if( LitPaddle.adr > 3032 )
      // Se o paddle est  do lado direito do ecran
	 move_lpad( ( LitPaddle.adr > 2970 ) ? 1 : 2 );
      else if( LitPaddle.adr < 3032 )
      // Se o paddle est  do lado esquerdo do ecran
	 move_lpad( ( LitPaddle.adr < 3092 ) ? 0 : 2 );
   }
   else if( Ball.dir == 0 && Ball.adr / 320 > nComputerQI )
   // Supostamente a bola vai para o lado esquerdo do ecran
      move_lpad( ( LitPaddle.adr > 2970 ) ? 1 : 2 );
   else if( Ball.dir == 1 && Ball.adr / 320 > 100 )
   // Supostamente a bola vai para o lado direito do ecran
      move_lpad( ( LitPaddle.adr < 3092 ) ? 0 : 2 );
   else if( Ball.adr % 320 > ( LitPaddle.adr - 2 + random( 3 ) * 4 ) % 320 )
   // Acompanha a bola e introduz um factor aleat¢rio no ataque: 5=meio; -2=esquerda; 8=direita
      move_lpad( ( LitPaddle.adr < 3092 ) ? 0 : 2 );
   else
   // Acompanha a bola e simplesmente defende-a
      move_lpad( ( LitPaddle.adr > 2970 ) ? 1 : 2 );
}
