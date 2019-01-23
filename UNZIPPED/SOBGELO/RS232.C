//---------------------------------------------------------------------------------------------
//                                        R S 2 3 2 . C
//
//   Fun”es relacionadas com a porta srie RS232 (fun”es de escrita, leitura, ststus, etc.)
//---------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------
//                                                                                   Constantes
//---------------------------------------------------------------------------------------------
#define COMPORT           1                                              // Porto RS232 - COM 2
#define WAITING_TIME      0.1                              // Tempo de espera por dados do PC 2


//---------------------------------------------------------------------------------------------
//                                                              Fun”es locais da fonte RS232.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: status_RS232           ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Verifica o status do porto de comunica”es RS232.                          บ
// บ                                                                                          บ
// บ Parmetros:   R  o registador AH (acomulator high) retornado depois de efectuada a      บ
// บ               inicializao da RS232. Cada um dos 8 bits tem o seguinte significado:     บ
// บ                 bit 7 = Timed-out                                                        บ
// บ                 bit 6 = Transmission shift register empty                                บ
// บ                 bit 5 = Transmission hold register empty                                 บ
// บ                 bit 4 = Break detected                                                   บ
// บ                 bit 3 = Framing error                                                    บ
// บ                 bit 2 = Parity error                                                     บ
// บ                 bit 1 = Overrun error                                                    บ
// บ                 bit 0 = Data ready                                                       บ
// บ                                                                                          บ
// บ Retorna:      TRUE se os bits 7, 4, 3, 2 e 1 estiverem a 0 (zero);                       บ
// บ               FALSE se qualquer um bits 7, 4, 3, 2 ou 1 estiver a 1 (um). Se algum       บ
// บ               destes bits estiver a 1 (on), significa que existe "lixo" na porta srie.  บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
static BOOLEAN status_RS232( BYTE R )
{
   return( !( (R & 0x80) || (R & 0x10) || (R & 0x08) || (R & 0x04) || (R & 0x02) ) );
}


//---------------------------------------------------------------------------------------------
//                                                            Fun”es externas da fonte RS232.C
//---------------------------------------------------------------------------------------------

// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: init_RS232             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Inicializa a RS232. A funo executa um ciclo (inicializando a RS232)      บ
// บ               enquanto houver "lixo" no porto, ou enquanto o utilizador no pressionar   บ
// บ               a tecla <ESCAPE>.                                                          บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void init_RS232( void )
{
   union REGS regs;

   do
   {
      regs.h.ah = 0x00;
      regs.h.al = 0xEB;                                       // 9600 Baud, Odd, 1 Stop, 8 Bits
      regs.x.dx = COMPORT;
      int86( 0x14, &regs, &regs );
   }
   while( !( KEY_ESCAPE || status_RS232( regs.h.ah ) ) ); // At pressionar ESCAPE ou status OK

   UserAborted = FALSE;                 // No inกcio o utilizador ainda abortou nenhum processo
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: wait_for_data          ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Esta funo aguarda por dados na RS232 durante o tempo de espera, o qual  บ
// บ               definido pela constante WAITING_TIME. Depois de atingido este tempo        บ
// บ               significa que durante a espera no foram recebidos nenhuns dados pela      บ
// บ               RS232. Assim, a funo terminar , colocando a vari vel TimeOut a TRUE.     บ
// บ               No entanto, a espera de dados pode tambm ser interrompida pressionado a   บ
// บ               tecla <ESCAPE>, e neste caso a vari vel UserAborted ser  actualizada para  บ
// บ               TRUE.                                                                      บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void wait_for_data( void )
{
   clock_t start = clock();                                         // Guarda o tempo de inกcio

   TimeOut = FALSE;                        // Inicialmente ainda no terminou o tempo de espera

   while( !(UserAborted || data_ready() || TimeOut) )  // Espera: <ESCAPE>, dados, fim de tempo
      if( KEY_ESCAPE )                                       // O utilizador perdeu a pacincia
	 UserAborted = TRUE;                                        // Vai sair no prขximo loop
      else if( ( clock() - start ) / CLK_TCK > WAITING_TIME )     // Verifica se acabou o tempo
	 TimeOut = TRUE;                                            // Vai sair no prขximo loop
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: write_RS232            ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Escreve um byte na RS232.                                                  บ
// บ                                                                                          บ
// บ Parmetros:   Ch  o byte a esctever no porto I/O RS232.                                 บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
void write_RS232( BYTE Ch )
{
   union REGS regs;

   regs.h.ah = 0x01;
   regs.h.al = Ch;
   regs.x.dx = COMPORT;
   int86( 0x14, &regs, &regs );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: read_RS232             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    L um byte do porto i/o RS232.                                             บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ Retorna:      A funo retorna o byte lido.                                              บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
BYTE read_RS232( void )
{
   union REGS regs;

   regs.h.ah = 0x02;
   regs.x.dx = COMPORT;
   int86( 0x14, &regs, &regs );

   return( ( regs.h.ah & 0x80 ) ? 32 : regs.h.al );
}


// ษออออออออออออออออออออออออออออออัอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
// บ Nome: data_ready             ณ Autor: Jorge Alexandre Cabrita Morgado (Fev/Mar/Abr 1994) บ
// วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
// บ Objectivo:    Verifica se existem dados a ler na RS232.                                  บ
// บ                                                                                          บ
// บ Parmetros:   Nenhum                                                                     บ
// บ                                                                                          บ
// บ Retorna:      TRUE se existem dados a ler na RS232;                                      บ
// บ               FALSE se a RS232 no tem nada para ser lido.                               บ
// ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
BOOLEAN data_ready( void )
{
   union REGS regs;

   regs.h.ah = 0x03;
   regs.x.dx = COMPORT;
   int86( 0x14, &regs, &regs );

   return( ( regs.h.ah & 0x01 ) ? TRUE : FALSE );
}
