//
// �                ��    ��                             �             ��
//  ��            ��    ��  ���    �  ��   ��           �            �� �
//    �          �     �������     �   ����  ��   ���� �               �
//     ��   �  ��     �       �     �  �        ��    ��              �
//       ��� ��        �������    ��    �       �     ��             �
//                                                                                           �����  ��         �����
//
//                                                por Tiago Ribeiro - '94


#include "weird1.h"
/////////////////////////////////////////////
// 'Arranca' com o computador
//
// Boot a 'frio'  : tipo=COLD_BOOT
// Boot a 'quente': tipo=WARM_BOOT
//
// N�o se esque�am de fechar TODOS os ficheiros que tenham abertos
//  ou arriscam-se a perder informa��o (que pena, n�o � ?).
//////////////////////////////////////////////
void x_reboot(int tipo)
{
 unsigned int far * Indicador;
 void (far * PtrReboot) (void);

 Indicador   = MK_FP(0x0000,0x0472);
 PtrReboot   = MK_FP(0xFFFF,0x0000);  //Inicio do POST (Power-On Self Test)

 if( tipo==COLD_BOOT)
   *Indicador = 0x0000;
 else
   *Indicador = 0x1234;

 (*PtrReboot) ();                     // Arrivederci !
}

/////////////////////////////////////////////
// Usa a fun��o do DOS 2E
//
// Leva como par�metro a vari�vel e o correspondente valor
// Ex.:
//          x_set("PATH=C:\SPOOLER")
//
// N�o esquecer que � preciso 'linkar' com INT2E.OBJ
//////////////////////////////////////////////
void x_set(char *string)
{
 char comando[129];

 if (sizeof(char *) == sizeof(int)) //Verifica se estamos no modelo small
 {
  comando[0] = strlen(string) + 5;   //O 1� byte tem o tamanho da instru��o
  strcpy(&comando[1],"SET ");
  strcat(comando,string);
  comando[comando[0]+1]=0x0d;        //Termina com um <CR>

  INT_2E(comando);
 }
}

/////////////////////////////////////////////
// Obt�m um c�digo 'mais ou menos' �nico do CPU onde se encontra
//////////////////////////////////////////////
unsigned long x_romcode(void)
{
 unsigned long checksum = 0;
 unsigned int offset;
 unsigned char far *ptr;

 ptr = ((unsigned char far *) (0xFE00L << 16));
 for(offset = 0; offset <= 0x1FFF; offset++)
  checksum += *(ptr + offset);

 return(checksum);
}

/////////////////////////////////////////////
// Ser� que o Windows est� por a� ?
// Estar� o Task Switcher activo (e ser� que ista ainda leva um 'c' ?)
// Estas e outras perguntas ser�o respondidas ap�s usar esta fun��o ...
//////////////////////////////////////////////
int x_shell(void)
{
 auto   struct SREGS Seg;
 static union REGS Reg;

 segread(&Seg);           //Inicializa

 Reg.x.ax = 0x1600;                                             // Estar� em 386 enhanced mode ?
 int86x(INT_MULTIPLEX, &Reg, &Reg, &Seg);
 switch (Reg.h.al)
 {
  case 0x00:                                            // N�o est� em
  case 0x80:  break;                                    //             modo enhanced

  case 0x01:
  case 0xFF:  return(MODE_WIN3X_2X);        // Windows 386 ver 2x

  // Se o Windows est� a correr em modo enhanced ent�o
  // AL (Reg.h.al) cont�m a parte inteira do n�mero da vers�o (ex.: 3.) e
  // AH (Reg.h.ah) cont�m a parte decimal do n�mero da vers�o (ex.: 1)
  default  : return(MODE_WINX_386E);            // Windows modo enhanced
 }

 Reg.x.ax = 0x4680;                                                     // Ser� que afinal estamos s�s ?
 int86x(INT_MULTIPLEX, &Reg, &Reg, &Seg);

 if(Reg.h.al == 0x80)                       // � n�o � que estamo memo (???)
  return(MODE_DOS);

 if(getenv("windir") || getenv("WINDIR"))   // Windows modo Real ou Standard
  return(MODE_WIN3X_STD);

 // Se cheg�mos aqui estamos dentro do Task Switcher (Heeeeeeeeelp !!!)
 return(MODE_DOS_TS);
}

/////////////////////////////////////////////
// Altera o modo de video
//
// Obviamente, e como ainda n�o existe nenhum computador vidente,
// conv�m (leia-se, � obrigat�rio) passar como par�metro o modo desejado
//////////////////////////////////////////////
void x_modo_video(char modo)
{
 _AX = modo;
 geninterrupt(0x10);
}

/////////////////////////////////////////////
// Altera o modo de video para MCGA (como diria a outra: UAAUUUU !! )
//
// Devolve o modo em que estava
//////////////////////////////////////////////
char x_mcga(void)
{
 char modo;

 _AH = 0x0F;               //   \
 geninterrupt(0x10);       //    >  Guarda o modo antigo
 modo = _AL;               //   /

 x_modo_video(0x13);

 return(modo);
}

/////////////////////////////////////////////
// P�e um pixel no ecran
//
// "Bela porcaria", dizem voc�s.                             ����������Ŀ
// Mas eis que surge a novidade, p�e um pixel no modo MCGA   � APLAUDIR �
//                                                           ������������
//                                                                ��
//                                                                ��
// Recuso-me a explicar os par�metros pois mais evidente que isto s�
// com um desenho !!!
//////////////////////////////////////////////
void x_pixel (int x, int y, int cor)
{
 unsigned char far *pplaca;

 pplaca=ZERO;                           // Aponta para o inicio do ecran
 pplaca+=(y*320)+x;
 *pplaca=cor;
}

/////////////////////////////////////////////
// Muda as intensidades de Red, Green, Blue (RGB) de uma cor
//
// R, G e B situam-se entre 0 e 63
//////////////////////////////////////////////
void x_setrgb(int cor, int r, int g, int b)
{
 _AX=0x1010;
 _BX=cor;
 _CH=g;
 _CL=b;
 _DH=r;

 geninterrupt(INT_VIDEO);
}

/////////////////////////////////////////////
// L� a intensidade de Red, Green, Blue (RGB) de uma cor
//////////////////////////////////////////////
int x_getrgb(int cor, int r_g_ou_b)
{
 int retorno;

 _AX=0x1015;
 _BL=cor;

 geninterrupt(INT_VIDEO);

 switch(r_g_ou_b)
 {
  case RED  : retorno=_DH; break;
  case GREEN: retorno=_CH; break;
  case BLUE : retorno=_CL; break;
 }

 return(retorno);
}

/////////////////////////////////////////////
// L� a palete corrente para um buffer 256*3
//////////////////////////////////////////////
void x_getpal(char *PalBuffer)
{
 _BX = 0;
 _CX = 256;
 _ES = FP_SEG(PalBuffer);
 _DX = FP_OFF(PalBuffer);

 _AX = 0x1017;
 geninterrupt(INT_VIDEO);
}

/////////////////////////////////////////////
// Escreve a palete a partir de um buffer 256*3
//////////////////////////////////////////////
void x_setpal(char *PalBuffer)
{
 _BX = 0;
 _CX = 256;
 _ES = FP_SEG(PalBuffer);
 _DX = FP_OFF(PalBuffer);

 _AX = 0x1012;
 geninterrupt(INT_VIDEO);
}

/////////////////////////////////////////////
// Faz um fade-out   (YYEESSS !)
//
// � necess�rio passar o 'step'. Step = 10 equivale mais ou menos a 10 segs.
//////////////////////////////////////////////
void x_fadeout(int step)
{
 int  ciclo, ja_esta = 0, count, intervalo;
 char *CurrPal;

 count = 0;
 if (step>=4)
 {
  intervalo = (step/4) * 10000;
 }
 else
  intervalo = step;

 CurrPal = malloc(MCGAPALSIZE);   // L� a palete corrente
 x_getpal (CurrPal);

 while (!ja_esta)
 {
  if( (count % intervalo) == 0 )
  {
   ja_esta = 1;

   for(ciclo=0;ciclo<MCGAPALSIZE;ciclo++)
	if(CurrPal[ciclo]!=0)
	 if( CurrPal[ciclo]<1 )
	  CurrPal[ciclo] = 0;
	 else
	 {
	  ja_esta = 0;
	  CurrPal[ciclo] --;
	 }

   if (!ja_esta)
	x_setpal(CurrPal);
  }
  count ++;
 }

 free(CurrPal);
}

/////////////////////////////////////////////
// Faz um fade-in
//
// � preciso fornecer um valor de 'step', e uma palete pois a fun��o
// precisa de saber at� que valor INCREMENTAR o rgb de cada uma das cores.
// Olhem agora um pouco para a palavra que mais sobressai na linha de cima.
// J� 't� ? Ent�o agora fixem isto: esta fun��o chama-se fade-IN, logo o
// rgb de cada cor ser� incrementado; sendo assim se passarem uma palete
// com alguma cor inferior � corrente, nunca mais sairemos daqui, ok ?
//////////////////////////////////////////////
void x_fadein(int step, char *PalBuffer)
{
 int ciclo, ja_esta=0, count, intervalo;
 char *CurrPal;

 CurrPal = malloc(MCGAPALSIZE);
 for (ciclo = 0;ciclo<MCGAPALSIZE;ciclo++)
  CurrPal[ciclo] = 0;

 count = 0;
 if (step>=4)
 {
  intervalo = (step/4) * 10000;
 }
 else
  intervalo = step;

 while(!ja_esta)
 {
  if( (count % intervalo) == 0 )
  {
   ja_esta=1;

   for(ciclo=0;ciclo<MCGAPALSIZE;ciclo++)
	if(CurrPal[ciclo]<PalBuffer[ciclo])
	{
	 ja_esta = 0;
	 CurrPal[ciclo]++;
	}

   x_setpal(CurrPal);
  }
  count ++;
 }

 free(CurrPal);
}

/////////////////////////////////////////////
// Desliga a imagem
//
// Se isto n�o funcionar sempre podem tentar com um
//             ___
//            / /
//           | (___________.----------------.
//          (   ___________|                 |
//           ) (           `----------------'
//          '---`
//////////////////////////////////////////////
void x_voff(void)
{
 unsigned char valor;

 outportb(0x03C4, 1);
 valor=inportb(0x03C5);
 valor|=32;
 outportb(0x03C5, valor);
}

/////////////////////////////////////////////
// Liga a imagem (e fez-se luz !)
//
// NOTA: � 1� vista o nome desta fun��o (e da anterior) pode parecer um
// pouco estranho (um pouco ?). A letra 'v' que l� est� significa "video".
//////////////////////////////////////////////
void x_von(void)
{
 unsigned char valor;

 outportb(0x03C4, 1);
 valor=inportb(0x03C5);
 valor&=0xDF;
 outportb(0x03C5, valor);
}

