{

      WJOYSTPU.PAS

      Turbo Pascal Unit com as defini��es das fun��es contidas na
       biblioteca JOYSDLL.DLL (Criada apartir do do ficheiro JOYSDLL.PAS)
       para utilizar o Joystick em TURBO PASCAL FOR WINDOWS.

      Este c�digo ou partes do mesmo pode ser distribuido ou
      integrado livremente em programas para qualquer tipo de uso,
      desde que na sua distribui��o os coment�rios sejam divulgados
      intactos.

      Para quaisquer coment�rios ou d�vidas contactar o autor:

	Pedro Sinogas
	Rua A - Lote 6A
	Madorna
	2775 Parede

      Novembro 93
}
Unit WJoysTPU;

INTERFACE

function Stick(NCoor:integer):integer;
function Strig(NBotao:integer):integer;

IMPLEMENTATION

function Stick; external 'JOYSDLL';
function Strig; external 'JOYSDLL';

end.