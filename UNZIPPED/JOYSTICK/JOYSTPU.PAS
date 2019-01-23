{

      JOYSTPU.PAS

      Turbo Pascal Unit com as fun‡”es para utilizar o Joystick em PASCAL

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
Unit JoysTPU;

INTERFACE

function Stick(NCoor:integer):integer;
function Strig(NBotao:integer):integer;

IMPLEMENTATION

uses
 Dos;

Const
 JINT    = $15;      { Interrupt para aceder ao Joystick        }
 JAH     = $84;      { Fun‡„o que acede ao Joystick             }
 JBotoes = $0000;    { Subfun‡„o que retorna o valor dos bot”es }
 JCoor   = $0001;    { Subfun‡„o que retorna as coordenadas     }

var
 regs : Registers;

function Stick(NCoor:integer):integer; { NCoor contem o n£mero correspondente }
begin                                  { … coordenada desejada                }
 regs.ah := JAH;
 regs.dx := JCoor;
 intr(JINT, regs);
 case NCoor of
  0:  Stick:=regs.ax;  { Coor X do Joystick 1 }
  1:  Stick:=regs.bx;  { Coor Y do Joystick 1 }
  2:  Stick:=regs.cx;  { Coor X do Joystick 2 }
  3:  Stick:=regs.dx;  { Coor Y do Joystick 2 }
  else Stick:=0;
  end
end;

function Strig(NBotao:integer):integer; { NBotao contem o n£mero            }
begin                                   { correspondente ao bot„o desejado  }
 regs.ah := JAH;
 regs.dx := JBotoes;
 intr(JINT,regs);
 if (NOT(regs.al) AND Trunc(exp((nbotao+4)*ln(2)))) > 0 then
  Strig:=-1
 else
  Strig:=0;
end;

end.