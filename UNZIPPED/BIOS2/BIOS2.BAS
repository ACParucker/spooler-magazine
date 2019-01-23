DECLARE SUB Equip (impressoras%, serie%, joystick%, drives%, cop%, membase%, memtext&, memexp&)
DECLARE SUB ResetCold ()
DECLARE SUB ResetWarm ()

TYPE RegType
        AX AS INTEGER
        BX AS INTEGER
        CX AS INTEGER
        DX AS INTEGER
        BP AS INTEGER
        SI AS INTEGER
        DI AS INTEGER
        FLAGS AS INTEGER
END TYPE


TYPE RegTypeX
        AX AS INTEGER
        BX AS INTEGER
        CX AS INTEGER
        DX AS INTEGER
        BP AS INTEGER
        SI AS INTEGER
        DI AS INTEGER
        FLAGS AS INTEGER
        DS AS INTEGER
        ES AS INTEGER
END TYPE

DIM SHARED regs AS RegType
DIM SHARED regx  AS RegTypeX



SUB Equip (impressoras%, serie%, joystick%, drives%, cop%, membase%, memtext&, memexp&)
'devolve a lista de equipamento reconhecido pela BIOS
'devolve os seguintes parƒmetros:
'impressoras%=n£mero de portas paralelas
'serie%=n£mero de portas s‚rie
'joystick%=existˆncia(valor 1) ou n„o (valor 0) de adaptador para jogos
'drives%=n£mero de drives
'cop%=existˆncia(valor 1) ou n„o(valor 0) de coprocessador
'membase%=quantidade de mem¢ria convencional
'memext&=quantidade de mem¢ria extendida
'memexp&=quantidade de mem¢ria expandida


   CALL interrupt(&H11, regs, regs)
   impressoras = regs.AX \ 16384   'Portas paralelas - bits 14 e 15
   serie = (regs.AX AND &HFFF) \ 512 'Portas s‚rie - bits 9 a 11
   joystick = (regs.AX AND &H1FFF) \ 4096  'porta joystick - bit 12
   drives = (((regs.AX AND &HEF) AND &HFF8) \ 64) + 1  'n£mero de drives - bits 6 e 7
   cop = (regs.AX AND 3) \ 2  'coprocessador - bit 1
   IF (regs.AX AND 1) = 0 THEN drives = 0  'inexistˆncia de drives - bit 0

   regs.AX = &H1800
   CALL interrupt(&H12, regs, regs)  'int 12h, fun‡„o 18h - mem¢ria convencional
   membase = regs.AX

   regs.AX = &H88
   CALL interrupt(&H15, regs, regs)  'int 15h, fun‡„o 15h - mem¢ria extendida
   IF (regs.FLAGS AND 1) = 0 THEN
   memext = regs.AX
   ELSE memext = 0   'em caso de erro - carry flag est  activa
   END IF

   regx.AX = &H3567
   CALL interruptx(&H21, regs, regs)
   DEF SEG = regx.ES
   FOR f = 1 TO 8
     emm$ = emm$ + CHR$(PEEK(&HA + f - 1))
   NEXT f
   IF emm$ = "EMMXXXX0" THEN
     regs.AX = &H4200
     CALL interrupt(&H67, regs, regs)  'int 67h, fun‡„o 42h - mem¢ria expandida
     IF (regs.AX AND &HFF00) = 0 THEN
     memexp = regs.DX
     memexp = memexp * 16384
      ELSE memexp = 0  'em caso de erro - AH cont‚m o c¢digo de erro
     END IF
     ELSE memexp = 0
   END IF


END SUB

SUB ResetCold
'Faz um reset a frio ao sistema

 regx.AX = &H2519                    'Fun‡„o 25h, interrup‡„o 19h
 regx.DS = &HF000                    'Segmento do novo endere‡o
 regx.DX = &HFFF0                    'Offset do novo endere‡o
 CALL interruptx(&H21, regx, regx)   'Fun‡”es do DOS
 CALL interrupt(&H19, regs, regs)    'Chama interrupt 19h
                                     'Note-se que este interrupt n„o vai usar
                                     'os registos - eles s¢ fazem parte da
                                     'sintaxe do comando.

END SUB

SUB ResetWarm
'Faz um reset a quente ao sistema

 regx.AX = &H2519                    'Fun‡„o 25h, interrup‡„o 19h
 regx.DS = &HF000                    'Segmento do novo endere‡o
 regx.DX = &HFFF0                    'Offset do novo endere‡o
 DEF SEG = &H0                       'Permite activar o reboot a quente
 POKE &H472, &H34                    'insere a palavra 1234h no endere‡o
 POKE &H473, &H12                    '0000:472h
 CALL interruptx(&H21, regx, regx)   'Fun‡”es do DOS
 CALL interrupt(&H19, regs, regs)    'Chama interrupt 19h
                                     'Note-se que este interrupt n„o vai usar
                                     'os registos - eles s¢ fazem parte da
                                     'sintaxe do comando.


END SUB

