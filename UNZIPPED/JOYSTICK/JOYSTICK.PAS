{

      JOYSTICK.PAS

      Exemplo de como utilizar as fun‡”es do ficheiro JOYSTPU.TPU
                                (Gerado apartir do ficheiro JOYSTPU.PAS)

      Este c¢digo ou partes do mesmo pode ser distribuido ou
      integrado livremente em programas para qualquer tipo de uso,
      desde que na sua distribui‡„o os coment rios sejam divulgados
      intactos.

      Para quaisquer coment rios ou d£vidas contactar o autor:

	Pedro Sinogas
	Rua A - Lote 6A
	Madorna
	2775 Parede

      Novembro 93
}
Program Joystick;

uses
 JoysTPU, Crt;

begin
 clrscr;
 gotoxy(1,1); write('Joystick 1');
 gotoxy(1,4); write('Joystick 2');

 repeat

  gotoxy(2,2); write(Stick(0),'  ');
  gotoxy(16,2); write(Stick(1),'  ');
  gotoxy(30,2); write(Strig(0),'  ');
  gotoxy(44,2); write(Strig(1),'  ');
  gotoxy(2,5); write(Stick(2),'  ');
  gotoxy(16,5); write(Stick(3),'  ');
  gotoxy(30,5); write(Strig(2),'  ');
  gotoxy(44,5); write(Strig(3),'  ');

 until keypressed;

end.
