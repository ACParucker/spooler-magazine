{

      JOYSDLL.PAS

      Dinamic Linked Library com as fun��es para utilizar o Joystick
                                                            no Windows

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
Library JoysDll;

uses
 WinDos;

Const
 JINT    = $15;      { Interrupt para aceder ao Joystick        }
 JAH     = $84;      { Fun��o que acede ao Joystick             }
 JBotoes = $0000;    { Subfun��o que retorna o valor dos bot�es }
 JCoor   = $0001;    { Subfun��o que retorna as coordenadas     }

var
 regs : Tregisters;

function Stick(NCoor:integer):integer;export; { NCoor contem o n�mero   }
begin                                     { correspondente � coordenada }
 regs.dx := JCoor;                        {desejada                     }
 regs.ah := JAH;
 intr(JINT, regs);
 case NCoor of
  0:  Stick:=regs.ax;  { Coor X do Joystick 1 }
  1:  Stick:=regs.bx;  { Coor Y do Joystick 1 }
  2:  Stick:=regs.cx;  { Coor X do Joystick 2 }
  3:  Stick:=regs.dx;  { Coor Y do Joystick 2 }
  else Stick:=0;
  end
end;

function Strig(NBotao:integer):integer; export; { NBotao contem o n�mero   }
begin                                   { correspondente ao bot�o desejado }
 regs.ah := JAH;
 regs.dx := JBotoes;
 intr(JINT,regs);
 if (NOT(regs.al) AND Trunc(exp((nbotao+4)*ln(2)))) > 0 then
  Strig:=-1
 else
  Strig:=0;
end;

exports
 Stick      index 1,
 Strig      index 2;

begin    
end.