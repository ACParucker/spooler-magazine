{                                                                }
{ PRINTER.PAS - Conjunto de rotinas para trabalhar com           }
{           impressora do tipo matricial (Proprinter)            }
{           elaboradas por Jos‚ Tom s                            }
{                                                                }
{ Pequena Explica‡„o: O leitor Hugo Flipe Cruz pedia uma         }
{   rotina ou um truque que fizesse o mesmo que o gotoxy         }
{   no ecr„  mas s¢ que desta vez na impressora.                 }
{   Para os mais leigos as comunica‡”es com a impressora         }
{   fazem-se na maioria das vezes por meio de sequˆncias         }
{   de caracteres, caracteres esses que correspondem a ordens,   }
{   sendo por esse meio que tentei dar uma resposta poss¡vel     }
{   ao pedido feito!                                             }
{                                                                }
{                                                                }
{ Nota: Estas rotinas foram feitas em TURBO C++ e de seguida     }
{       convertidas para TURBO PASCAL                            }
{                                                                }



{ ++++++++ Rotina para limpar buffer da impressora ++++++++  }
program testroutine(input, output,prn);

procedure preset;
var prn:text;
begin
  Assign(prn, 'prn');
  Rewrite(prn);
  Write(prn, chr(27),'@',chr(0));
  Close(prn);
end;


{  ++++++++ Rotina para localizar a impressora ++++++++  }
{  ++++++++ no topo da p gina                  ++++++++  }
procedure ptopage;
var prn:text;
begin
  Assign(prn, 'prn');
  Rewrite(prn);
  Write(prn, chr(27),chr(12),chr(10),chr(0));
  Close(prn);
end;

{  ++++++++ Rotina equivalente a printf para escrever ++++++++  }
{  ++++++++ na impressora tal como no ecr„            ++++++++  }
procedure pprint(str:string);
var prn:text;
begin
  Assign(prn, 'prn');
  Rewrite(prn);
  Write(prn, str);
  Close(prn);
end;

{  ++++++++ Rotina equivalente a gotoxy para localizar ++++++++  }
{  ++++++++ o cursor na impressora tal como no ecr„    ++++++++  }
procedure pxy(x,y:integer);
var prn:text; i:integer;
begin
  i:=0;
  Assign(prn, 'prn');
  Rewrite(prn);
  Write(prn, chr(27),chr(12));
  while not(i=y) do
   begin
    writeln(prn,''); i:=i+1;                   { \n Line Feed  }
   end;
  i:=0;
  while not(i=x) do
   begin
    write(prn,' '); i:=i+1;
   end;
  Close(prn);
end;



{  ++++++++ Rotina para escrever uma string na impressora ++++++++  }
{  ++++++++ em posi‡„o (x,y) a definir                    ++++++++  }
procedure pprintxy(x,y:integer;str:string);
var prn:text; i:integer;
begin
  i:=0;
  Assign(prn, 'prn');
  Rewrite(prn);
  Write(prn, chr(27),chr(12));
  while not(i=y) do
   begin
    writeln(prn,''); i:=i+1;                   { \n Line Feed  }
   end;
  i:=0;
  while not(i=x) do
   begin
    write(prn,' '); i:=i+1;
   end;
  write(prn,str,chr(13));
  Close(prn);
end;

begin
{ --------------- Modo 1 ---------------- }
preset;
pprintxy(12,12,'Oi!');
pprintxy(12,13,'Como v„o as coisas?');
pprintxy(40,30,'Ÿptimo!!! E que tal o pardal?');
pprintxy(12,20,'Est  bem desenhado, talvez n„o!');
pprintxy(20,42,'Para a revista Spooler');
pprintxy(1,43,'Em resposta … proposta da revista 34 no Correio dos Leitores');
pprintxy(2,45,'Jos‚ Tom s apresenta a sua solu‡„o em C e Pascal ');
ptopage;
{  --------------- Modo 2 ---------------- }
preset;
pxy(40,4);
pprint('Experiˆncia');
pprint('In¡cio');
pprint('In¡cio-Fim (Experiˆncia)');
end.
