'***************************************************************************
' Criado     : Em 21/8/93 para Spooler Magazine por M.Nogueira
' Objectivo  : Ao final de x de tempo se o computador n„o estiver a ser
'	     : utilizado, este programa acciona-se, dando assim mais
'            : durabilidade ao ecr„.
' Programado : Em Power Basic Vers„o 3 para funcionar s¢ em modo texto  80x25
' Observa‡”es: N„o serve para funcionar em modo Gr fico
'***************************************************************************

$COMPILE EXE                  ' Compila para executavel
$LIB IPRINT OFF		      ' desliga livraria
$OPTION CNTLBREAK OFF	      ' contol break n„o activo

x& = SETMEM(-700000)          ' realiza mem¢ria
dim posx%(1:6)
dim posy%(1:6)
genio$=" (c) M. "+chr$(78,111,103,117,101,105,114,97,32)

if VerWin%=>3 then end 'Fora com o Windows
'por usar um dos interrupt 2F torna-se incompativel com o Windows

POPUP KEY CHR$(8,30,247)      ' ALT-A tecla para o activar

POPUP MULTIPLEX &HC000, 254   ' colocamos uma palete em AX e DX
REG 1, &HC000 : REG 4, 254    ' para identifica‡„o posterior
CALL INTERRUPT &H2F           ' se ele j  est  instalado ou n„o
IF REG(1)<>&HC000 AND REG(4)<>254 THEN END

File$ = LEFT$(CURDIR$,2)+"\TSRPB3.MEM"  'ficheiro alternativo
cls
color 15,1
 PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
 PRINT "³ Precione ALT-A para activar o TSR ³"
 PRINT "³ ";genio$;"  Agosto 1993    ³"
 PRINT "³  Elaborado para Spooler Magazine  ³"
 PRINT "³     Funciona s¢ em modo texto     ³"
 PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
color 7,0
REG 1, &HC001 : REG 4, 252  ' coloca de novo a palete
POPUP SLEEP USING EMS, File$       ' usa EMS se tiver possibilidade se n„o
				   ' um ficheiro alternativo s¢ usa 5k de
				   ' mem¢ria convencional
do

  IF REG(1)=&HC000 AND REG(4)=254 THEN
    Ox% = POS : Oy% = CSRLIN :call guardaecra(E1$)
    color 15,1
    LOCATE 12,20 :  PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿";
    LOCATE 13,20 :  PRINT "³ TSR j  est  em mem¢ria [ALT A] activa-o ³";
    LOCATE 14,20 :  PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ";
    delay 1.5:color 7,0
    call restauraecra(E1$): LOCATE Oy%, Ox%
  ELSE
    Ox% = POS : Oy% = CSRLIN :call guardaecra(E1$)
    '-------------------------------------------
     if pausa% then A$=efeito$:If ascii(mid$(a$,2))<>30 then exit if else temp%=0
 color 15,1
 LOCATE 11,20 :  PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿";
 LOCATE 12,20 :  PRINT "³ [Esc] Adormecer aplica‡„o               ³";
 LOCATE 13,20 :  PRINT "³ [D]   Desinstalar aplica‡„o (s¢ ALT-A)  ³";
 LOCATE 14,20 :  PRINT "³ [+-]  Aumentar ou diminuir Tempo        ³";
 LOCATE 15,20 :  PRINT "³       de sono da aplica‡„o              ³";
 LOCATE 16,20 :  PRINT "³       Tempo de sono [    ] minutos      ³";
 LOCATE 17,20 :  PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ";
do
temp%=abs(temp%)
pausa%=int(temp%*60*18.2)
POPUP quiet pausa%              ' tempo para que n„o entre em funcionamento
locate 16,43:PRINT (pausa%/1092)

select case ucase$(INPUT$(1))
case chr$(27),chr$(13) :exit loop
case chr$(68) :
	IF POPUP(1) THEN
	call restauraecra(E1$): color 7,0:LOCATE Oy%, Ox%
	print:print:print:oy%=csrlin
	color 15,4 :
	locate oy%-3,1:	PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
	locate oy%-2,1:	PRINT "³ TSR desinstalado sem problemas ³"
	locate oy%-1,1:	PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
	color 7,0
			END
	else
	call guardaecra(E2$)
	color 15,4
	LOCATE 12,20 :  PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿";
	LOCATE 13,20 :  PRINT "³ TSR est  com conflitos de memoria ³";
	LOCATE 14,20 :  PRINT "³ por agora n„o pode desinstalar.   ³";
	LOCATE 15,20 :  PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ";
	delay 1.5:color 15,1
	call restauraecra(E2$):
	end if
case "+":incr temp%: if temp%>10 then temp%=1
case "-":decr temp%
End select

LOOP
color 7,0


    '-------------------------------------------
    call restauraecra(E1$): color 7,0:LOCATE Oy%, Ox%   'restaura ecra
  END IF

REG 1, &HC001 : REG 4, 252  ' alterar AX,DX para reconhecimento posterior
POPUP SLEEP                 ' o programa vai dormir
loop
end

' **********************************************************************
' ®®®®®®®®®®®®®®®®®®®®®®®®®®®®[SUB e FUNCTION]¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

Sub GuardaEcra(vari$)   'capta um ecr„ para uma variavel
  DEF SEG = &hB800
  Vari$= PEEK$(0,4000) ' guarda ecra modo texto
  DEF SEG
End sub

Sub RestauraEcra(vari$) 'restaura a variavel em um ecr„
  DEF SEG = &hB800
  POKE$ 0, vari$
  DEF SEG
End sub

Function VerWin%   'verifica se o windows est  a funcionar
local adl%
    ASM mov ax,&H1600
    ASM int &H2f
    ASM mov adl%,al
    verwin%=adl%
END FUnction

function efeito$
shared posx%(),posy%(),genio$
local h$,escrita$,apaga$,passoy%,passox%
Local sx%,sy%,var%,apg%,x,escrita1$,escrita2$,E3$,oex%,oey%
Call guardaecra(E3$): Oex% = POS : Oey% = CSRLIN:cls
apaga$=string$(15,32)
escrita1$=" Spooler Magazine "
escrita2$=genio$+chr$(32)
apaga$=string$(len(escrita1$),32)
for x=1 to 6:posy%(x)=1:posx%(x)=1:next x
do :sy%=int(rnd(.2)*24):loop until (sy%>1 and sy%<24)
do :sx%=int(rnd(.2)*80):loop until (sx%>1 and sx%<(79-len(escrita$)))
passoy%=1       :passox%=5       :var%=6:apg%=1
do
incr sy%,passoy%  :incr sx%,passox%
if (sy%<=0 or sy%=>26) then
	passoy%=passoy%*-1 :incr sy%,passoy%
end if
if sx%=>82-len(escrita$) or sx%<=0 then
	passox%=passox%*-1:incr sx%,passox%
end if
posx%(var%)=sx%:posy%(var%)=sy%
color 15,0   ' 15,1
if (passoy% < 1) then escrita$=escrita2$ else escrita$=escrita1$
locate posy%(var%),posx%(var%): print escrita$;
locate posy%(apg%),posx%(apg%): print apaga$;
incr var%,1:if var%=7 then var%=1
incr apg%,1:if apg%=7 then apg%=1
delay .03
h$=inkey$
loop until h$<>""
efeito$=h$
Call restauraecra(E3$):color 7,0:LOCATE Oey%, Oex%
end function


