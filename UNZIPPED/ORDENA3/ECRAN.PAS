unit ecran;
{esta unit cont‚m os procedimentos gen‚ricos, que servem para controlar }
{situa‡”es n„o espec¡ficas(guardar ecran, mudar atributo), ou seja, que }
{podem ser utilizados noutros programas que n„o o SAFEMENU              }

{Este ficheiro pode ser utilizado livremente por todos                  }
{Por favor comuniquem-me as altera‡”es que lhe fizerem, no intento de o }
{melhorar                                                               }
{Escrevam para: Pedro Andrade                                           }
{               Rua Ramiro Correia, lte-18                              }
{               St§ Ant¢nio                                             }
{               2830 BARREIRO                                           }


  (**************************) INTERFACE (***************************)

type tela=record
                car:char;
                atributo:byte;
     end;{array da mem¢ria de video}

     mm_arr=array[1..25,1..80] of tela;{array na mem¢ria de video}

     cars=set of char;

(****************************)

var mem_screen:mm_arr absolute $B800:00;{variavel na mem¢ria de video}

(****************************************)

procedure savescr(var mv:mm_arr);{permite guardar o ecran corrente}
procedure restscr(var mv:mm_arr);{permite restaurar um ecran previamente guardado}
procedure limpa_scr(linha,coluna,altura,comprimento,cores:word;apaga:boolean);
Procedure leop(var car:char;var ex:boolean);
Procedure Botao(x,y:byte;op:string);{desenha um bot„o}
Procedure default(x,y:byte;op:string;desc:string);
Procedure janela(x,y,x1,y1:byte;tipo:integer);{escreve uma janela sem titulo}
Procedure desligacur;{faz desaparecer o cursor}
procedure ligacur(valor:byte);{faz aparecer o cursor}
function ler(x,y,tamanho,cor,bkcor:word;validos:cars;num:boolean;
             inicio:string;moldura:integer):string;

  (****************************) IMPLEMENTATION (**********************)

uses crt,dos;

procedure savescr(var mv:mm_arr);{permite guardar o ecran corrente}
begin
     move(mem_screen,mv,sizeof(mem_screen));
end;


procedure restscr(var mv:mm_arr);{permite restaurar um ecran previamente guardado}
begin
     move(mv,mem_screen,sizeof(mv));
end;

procedure limpa_scr(linha,coluna,altura,comprimento,cores:word;apaga:boolean);
var x,y:word;
begin
  for y:=linha to linha + altura -1 do
     for x:= coluna to coluna + comprimento -1 do
         begin
          mem_screen[y,x].atributo :=cores;
          if apaga then mem_screen[y,x].car :=' ';
         end;
end;{muda os atributos dos caracteres}


Procedure leop(var car:char;var ex:boolean);
begin
  ex :=false;{inicializa ex como falso para impedir que retorne true sem que}
	     {o c¢digo seja extendido                                       }

  car :=readkey;{car ‚ igual ao codigo ASCII da tecla}

  if car=#0 then{se car=0 significa que a tecla ‚ uma tecla estendida}
  begin
       ex := true;{o c¢digo ‚ extendido}

       car:=readkey;{ao fazer de novo readkey, o codigo extendido}
			 {da tecla passa para car.}
  end;

end;{Este procedimento retorna em car dois valores possiveis:            }
    {Ou o c¢digo ASCII da tecla premida ou, se tiver sido premida        }
    {uma tecla extendida, o seu Scan Code.                               }
    {Se EX=TRUE, ent„o o codigo ‚ extendido, caso contrario ‚ um caracter}


Procedure Botao(x,y:byte;op:string);{desenha um bot„o}
var z:byte;
begin
     gotoxy(x,y);
     textattr:=16*3+15;
     write(' '+op+' ');
     textattr:=16;
     gotoxy(x+1+length(op)+1,y);
     write('Ü');
     for z:=x+1 to x+1+length(op)+1 do
     begin
          gotoxy(z,y+1);
          write('ß');
     end;
end;

Procedure default(x,y:byte;op:string;desc:string);{desenha um bot„o}
var z:byte;
begin
     gotoxy(x,y);
     textattr:=16*green+15;
     write(' '+op+' ');
     textattr:=16;
     gotoxy(x+1+length(op)+1,y);
     write('Ü');
     for z:=x+1 to x+1+length(op)+1 do
     begin
          gotoxy(z,y+1);
          write('ß');
     end;
     gotoxy(2,25);
     textcolor(red);
     textbackground(7);
     clreol;
     write(desc);
end;


Procedure janela(x,y,x1,y1:byte;tipo:integer);{escreve uma janela sem titulo}

const double:string[6]=('ÉÍ»ºÈ¼');
      single:string[6]=('ÚÄ¿³ÀÙ');

var z:byte;
    curr:string[6];

begin
     if tipo=1 then curr:=single else
     if tipo=2 then curr:=double else
                    curr:='      ';
     window(x,y,x1,y1);
     clrscr;
     window(1,1,80,25);
     gotoxy(x,y);
     write(curr[1]);
     gotoxy(x,y1);
     write(curr[5]);
     gotoxy(x1,y);
     write(curr[3]);
     gotoxy(x1,y1);
     write(curr[6]);
     for z:= x+1 to x1-1 do
     begin
          gotoxy(z,y);
          write(curr[2]);
          gotoxy(z,y1);
          write(curr[2]);
     end;
     for z:= y+1 to y1-1 do
     begin
          gotoxy(x,z);
          write(curr[4]);
          gotoxy(x1,z);
          write(curr[4]);
     end; 
end;


Procedure desligacur;{faz desaparecer o cursor}
begin
	asm
    	mov ah,$01;
        mov cl,$00;
        mov ch,$38;
        int $10;
    end;
end;

procedure ligacur(valor:byte);
begin
	asm
    	mov ah,$01;
        mov cl,$08;
        mov ch,valor;
        int $10;
    end;
end;


Function Ler (x,y,tamanho,cor,bkcor:word;validos:cars;num:boolean;
              inicio:string;moldura:integer):string;

var texto:string;
    pos,pontos:word;
    letra:char;
    ex,ins:boolean;

begin
     texto:='';
     if length(inicio)<80 then texto:=inicio else
        texto:=copy(inicio,1,79);
     if tamanho>80 then tamanho:=79;
     pos:=length(texto);
     pontos:=0;
     ins:=true;
     if moldura in [1,2] then janela(x-1,y-1,x+tamanho+1,y+1,moldura);
     window(x,y,x+tamanho,y);
     textcolor(cor);
     textbackground(bkcor);
     ligacur(8);
     repeat
           gotoxy(1,1);
           clreol;
           write(texto);
           gotoxy(pos+1,1);
           leop(letra,ex);
           if not(ex) then
           begin
                if (letra in validos) then
                begin
                if not((letra='-') and (pos<>0) and num) then
                begin
                     if ins then
                     begin
                     if length(texto)<tamanho then
                     begin
                          if not((letra='.') and (pontos<>0) and num) then
                          begin
                               inc(pos);
                               insert(letra,texto,pos);
                               if letra='.' then pontos:=pos;
                          end
                     end
                     end
                     else
                     begin
                     if pos<tamanho then
                     begin
                          if not((letra='.') and (pontos<>0) and num) then
                          begin
                               inc(pos);
                               delete(texto,pos,1);
                               insert(letra,texto,pos);
                               if letra='.' then pontos:=pos;
                          end
                     end
                     end
                end
                end
                else
                if (letra=#8) and (pos>=1) then
                begin
                     if pos=pontos then pontos:=0;
                     delete(texto,pos,1);
                     dec(pos);
                end;
           end
           else
           if ex then
           begin
                if letra=#83 then delete(texto,pos+1,1)
                else
                if letra=#71 then pos:=0
                else
                if letra=#79 then pos:=length(texto)
                else
                if letra=#82 then
                begin
                     if ins then
                     begin
                          ins:=false;
                          ligacur(9);
                     end
                     else
                     begin
                          ins:=true;
                          ligacur(8);
                     end;
                end
                else
                if (letra=#75) and (pos>=1) then dec(pos)
                else
                if (letra=#77) and (pos<tamanho) then inc(pos);
           end;
     until letra=#13;
     ler:=texto;
     window(1,1,80,25);
     ligacur(8);
end;


begin
end.