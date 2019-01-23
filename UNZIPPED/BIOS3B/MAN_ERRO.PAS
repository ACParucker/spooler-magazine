program erro_critico;
{Instala um handler/manipulador de erro cr¡tico, substituindo o standard}

{                             ATEN€ŽO                                  }
{Este programa s¢ pode ser compilado com uma vers„o do Turbo Pascal, igual}
{ou superior a 6}

uses dos, crt;

var x: char;
    manipseg, manipofs: word;
    regs:registers;
    espacot, espacol: longint;
    erro: boolean;


        procedure termina; forward;





        procedure manip; interrupt;

          begin
            writeln;
            write ('Erro! ');
            write ('Deseja (T)entar novamente, (I)gnorar ou (S)uspender ?');
            x:=readkey;
            writeln;
            while (x='s') or (x='S') or (x='i') or (x='I') or (x='t') or (x='T') do
              begin
                if (x='S') or (x='s') then {suspende programa}
                  begin
                    termina;
                    writeln ('Programa interrompido!');
                    halt (1); {sai para DOS, com c¢digo de erro}
                  end;
                if (x='t') or (x='T') then
                  begin
                    asm
                     pop bp  {Este peda‡o de assembly, permite simular}
                     pop es  {aquilo que o Turbo Pascal faz, quando}
                     pop ds  {chega ao fim do procedimento - isto ‚:}
                     pop di  {Preserva os valores dos registos e}
                     pop si  {faz um iret, um retorno de interrup‡„o.}
                     pop dx
                     pop cx
                     pop bx
                     pop ax
                     mov al, 1 {Esta linha permite enviar ao DOS a resposta}
                               {que o utilizador escolheu - neste caso, }
                               {tentar outra vez.}
                     iret
                    end;
                  end;
                if (x= 'i') or (x='I') then
                  begin
                    erro:=true; {informa o programa, que houve um erro}
                    asm
                      pop bp {o mesmo c¢digo que anteriormente - ver coment rios}
                      pop es
                      pop ds
                      pop di
                      pop si
                      pop dx
                      pop cx
                      pop bx
                      pop ax
                      mov al, 0 {Diz ao DOS para ignorar o erro.}
                      iret
                    end;
                  end;
              end; {while}
          end; {fim do proc}




        procedure inst_erro_critico;

          begin
            regs.ah:=$35;
            regs.al:=$24;
            msdos(regs);
            manipseg:=regs.es;  {guarda segmento do endere‡o original}
            manipofs:=regs.bx;  {guarda ofset do endere‡o original}

            regs.ah:=$25;
            regs.al:=$24;
            regs.ds:=seg(manip); {segmento do novo manipulador}
            regs.dx:=ofs(manip); {offset do novo manipulador}
            msdos(regs);   {substitui endere‡o original pelo manip. de erro}
          end;




        procedure termina;
        {Rep”e o valor original do vector de interrup‡„o 24H}

          begin

            regs.ah:=$25;
            regs.al:=$24;
            regs.ds:=manipseg;
            regs.dx:=manipofs;
            msdos(regs);

          end; {fim proc termina}





  begin

    erro:=false;
    inst_erro_critico;
    writeln;
    writeln ('Lendo a disquete na drive A: ...');
    espacot:=disksize (1); {espa‡o total em disquete}
    if erro then
      begin
        write ('N„o existe uma disquete na drive, neste momento,');
        writeln (' ou disquete danificada');
        halt (2); {Sai para o DOS, com c¢digo de erro}
      end;
    espacol:=diskfree (1); {espa‡o livre em disquete}
    writeln;
    writeln ('A disquete tem um total de ',espacot, ' Bytes');
    writeln ('e ',espacol,' Bytes est„o livres');
    termina;
  end.



