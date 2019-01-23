{

      WJOYSTPU.PAS

      Turbo Pascal Unit com as definições das funções contidas na
       biblioteca JOYSDLL.DLL (Criada apartir do do ficheiro JOYSDLL.PAS)
       para utilizar o Joystick em TURBO PASCAL FOR WINDOWS.

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
Unit WJoysTPU;

INTERFACE

function Stick(NCoor:integer):integer;
function Strig(NBotao:integer):integer;

IMPLEMENTATION

function Stick; external 'JOYSDLL';
function Strig; external 'JOYSDLL';

end.