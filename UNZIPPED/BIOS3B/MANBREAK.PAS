  program breakoff;
  uses dos, crt;


  var regs: registers;
      c:char;
      hor, min, sec, sec2, msec, brkseg, brkofs: word;
      x, y: byte;



       Procedure Termina;
       {rep”e o valor do vector de interrup‡„o}

       begin
         regs.ah:=$25;
         regs.al:=$1B;
         regs.ds:=brkseg;   {segmento do valor original}
         regs.dx:=brkofs;   {ofset do valor original}
         msdos(regs);     {rep”e o valor inicial da int 1BH}
       end;





       procedure manipulador; interrupt;
       {prepara o procedimento para ser chamado por uma interrup‡„o}

       begin
         x:=wherex; y:=wherey; {guarda as coordenadas do cursor}
         gotoxy (20,20);
         write ('Deseja parar a opera‡„o(S/N) ?');
         c:=readkey;
         if (c='S') or (c='s') then halt(0)  {Volta ao DOS}
         else
           begin
             delline;        {apaga linha da mensagem}
             gotoxy (x, y);  {coloca o cursor no s¡tio original}
           end;
        end;






       procedure inst_break;
       {instala um handler/manipulador para a interrup‡„o activada pelas
        teclas Ctrl-Break - int 1Bh}

         begin

           regs.ah:=$35;
           regs.al:=$1B;
           msdos(regs);      {obt‚m vector de interrup‡„o}
           brkseg:=regs.es;  {guarda segmento do vector original}
           brkofs:=regs.bx;  {guarda ofset do vector original}

           regs.ah:=$25;
           regs.al:=$1B;
           regs.ds:=seg(manipulador); {proc = procedimento que ir  substituir}
           regs.dx:=ofs(manipulador); {o manipulador standard}
           msdos(regs);   {Substitui endere‡o original pelo manip. de break}

         end;






   begin

     clrscr;
     inst_break;
     gotoxy (10, 12);
     write ('Break para interromper');
     while TRUE do
       begin
         gettime (hor, min, sec, msec);
         if sec2 <> sec then  {se a hora mudou...}
           begin
             gotoxy (10,10);
             write (hor:2,': ',min:2, ': ', sec:2);
             sec2:=sec
           end;

       end;

   end.

