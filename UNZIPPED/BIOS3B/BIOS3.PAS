  Unit BiosDos1;
  Interface
  Uses DOS;

  Var regs: Registers;
      brkseg, brkofs: word;


      procedure inst_break;
      procedure inst_erro_critico;






  Implementation



       procedure inst_break;
       {instala um manipulador para a interrup‡„o activada pelas teclas
        Ctrl-Break}

         begin

           regs.ah:=$35;
           regs.al:=$1b;
           msdos(regs);      {obt‚m vector de interrup‡„o}
           brkseg:=regs.es;  {guarda segmento do vector original}
           brkofs:=regs.bx;  {guarda ofset do vector original}

           regs.ah:=$25;
           regs.al:=$1b;
           regs.ds:=seg(proc); {proc = procedimento que ir  substituir}
           regs.dx:=ofs(proc); {o manipulador standard}
           msdos(regs);   {Substitui endere‡o original pelo manip. de break}

         end;




     procedure inst_erro_critico;

     begin
       regs.ah:=$35;
       regs.al:=$24;
       msdos(regs);
       manipseg:=regs.es;  {guarda segmento do endere‡o original}
       manipofs:=regs.bx;  {guarda ofset do endere‡o original}

       regs.ah:=$25;
       regs.al:=$24;
       regs.ds:=seg(manip);
       regs.dx:=ofs(manip);
       msdos(regs);   {substitui endere‡o original pelo manip. de erro}
     end;







End. {fim de unit BiosDos2}