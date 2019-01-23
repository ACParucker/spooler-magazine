{

      TPWJOYS.PAS

      Exemplo de como utilizar as funções a Turbo Pascal Unit WJOYSTPU.TPU
       (Gerado apartir do ficheiro WJOYSTPU.PAS), o que permite utilizar o
       Joystick no Windows.

      Este código ou partes do mesmo pode ser distribuido ou
      integrado livremente em programas para qualquer tipo de uso,
      desde que na sua distribuição os comentários sejam divulgados
      intactos.

      Para quaisquer comentários ou dúvidas contactar o autor:

	Pedro Sinogas
	Rua A - Lote 6A
	Madorna
	2775 Parede

      Novembro 93
}
Program TPWJoys;

uses
 WJoysTPU, WinCrt, Strings;

begin

 screensize.x:=46;  {número de caracteres}
 screensize.y:=5;
 windoworg.x:=100; {Posição da Janela no ecran}
 windoworg.y:=100;
 windowsize.x:=400; {tamanho da janela}
 windowsize.y:=200;
 StrCopy(WindowTitle, 'Joystick no Turbo Pascal for Windows');

 gotoxy(1,1); write('Joystick 1');
 gotoxy(1,4); write('Joystick 2');

 repeat

  gotoxy(2,2); write(Stick(0),'  ');
  gotoxy(16,2); write(Stick(1),'  ');
  gotoxy(30,2); write(Strig(0),' ');
  gotoxy(44,2); write(Strig(1),' ');
  gotoxy(2,5); write(Stick(2),'  ');
  gotoxy(16,5); write(Stick(3),'  ');
  gotoxy(30,5); write(Strig(2),' ');
  gotoxy(44,5); write(Strig(3),' ');

 until keypressed;
 DoneWinCrt;

end.
