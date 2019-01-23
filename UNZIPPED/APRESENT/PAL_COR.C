#include <dos.h>


int default_colors[16]={
	0x00, 0x01, 0x02, 0x03,
	0x04, 0x05, 0x14, 0x07,
	0x38, 0x39, 0x3A, 0x3B,
	0x3C, 0x3D, 0x3E, 0x3F
};


void SetPalete(int number, int value)
{
   _AH = 0x10;
   _AL = 0x00;		/* Sub-servi‡o	*/
   _BH = value;         /* Valor	*/
   _BL = number;        /* Registo	*/
   geninterrupt(0x10);
}


void DefaultColors(void)
{
    int i;

    for(i=0; i!=16; i++)
	 SetPalete(i, default_colors[i]);
}



int main(void)
{
    int i;

    ....
    ....
    SetPalete(cor_a_redefinir, azuis[i]);
    ....
}