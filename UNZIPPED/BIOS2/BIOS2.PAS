  Unit BiosDos1;
  Interface
  Uses DOS;

  Var regs: Registers;

     Procedure reset_cold;
     Procedure reset_warm;
     Procedure equip (var impressoras, serie, joystick, drives, cop, membase:integer;
                   var memext, memexp:longint);










  Implementation


     Procedure reset_cold;
     {Faz um reset a frio ao sistema}

       begin
         regs.ah:=$25;   {fun��o 25h do DOS}
         regs.al:=$19;   {muda o vector da interrup��o 19h}
         regs.ds:=$ffff; {valor do segmento do novo endere�o}
         regs.dx:=0;     {valor do offset do novo endere�o}
         msdos (regs);   {ou Intr ($21, regs)}
         intr ($19, regs){neste caso os regs n�o servem para nada}
       End; {fim de proc Reset_cold}




     Procedure reset_warm;
     {Faz um reset a quente ao sistema}

       begin
         regs.ah:=$25;   {fun��o 25h do DOS}
         regs.al:=$19;   {muda o vector da interrup��o 19h}
         regs.ds:=$ffff; {valor do segmento do novo endere�o}
         regs.dx:=0;     {valor do offset do novo endere�o}
         memw[0:$472]:=$1234; {permite o warm reboot}
         msdos (regs);   {ou Intr ($21, regs)}
         intr ($19, regs){neste caso os regs n�o servem para nada}
       end; {fim de Reset_warm}




     Procedure equip;
     {Devolve a lista de equipamento reconhecido pelo BIOS}

        Var emm: string[8];
            f: integer;

        Begin
	  intr ($11, regs);  {chama interrup��o 11h}
          impressoras:=regs.ax div 16384;  {portas paralelas - bits 15 e 14}
          serie:=(regs.ax and $0fff ) div 512; {portas s�rie - bits 9 a 11}
          joystick:=(regs.ax and $1fff) div 4096;  {porta de joystick - bit 12}
          drives:=((regs.ax and $ff) div 64)+1;  {n�mero de drives - bits 6 e 7}
          cop:=(regs.ax and $3) div 2;   {coprocessador - bit 1}
          if (regs.ax and 1) = 0 then drives:=0;  {exist�ncia de drives - bit 0}

          regs.ah:=$18;
          intr ($12, regs);  {int 12h, fun��o 18h - mem�ria base}
          membase:=regs.ax;

          regs.ah:=$88;
          intr ($15, regs);  {int 15h, fun��o 15h - mem�ria extendida}
          if (regs.flags and 1)=0 then memext:=regs.ax
           else memext:=0;   {se houver erro - a carry flag est� activa}

          emm:='        ';
          regs.ax:=$3567;
          intr ($21, regs);
          for f:=0 to 8  do
             emm[f+1]:=chr(mem[regs.es:($0a+f)]);
          if emm='EMMXXXX0' then
            begin
              regs.ah:=$42;
              intr($67, regs);   {int 67h, fun��o 42h - mem�ria expandida}
              if regs.ah=0 then memexp:=regs.dx
               else memexp:=0;    {se houver erro - ah cont�m c�digo erro}
              memexp:=memexp*16384;
            end
            else memexp:=0;

        End; {fim de proc Equip}









  END. {FIM DA UNIT BIOSDOS1}                                                                                                                                                                                                                                                                                                                                                                             		PROGRAM XXX;
