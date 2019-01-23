{$M 64000,0,200000 }
{$V-}
Unit Jogo1;

Interface
Uses Crt, Dos,Efeitos;
Var
   Ciclo: Integer;

   Texxto: String;
   Ch: Char;

Procedure Listar;

Procedure Terminar(Jogador: String);

Procedure Suspender;

Implementation


(****************************)
{ Escreve uma string como se fosse uma m quina de escrever. }

Procedure Maquinaa(Var TExxto2: String; Atraso :Integer);
Var
   Ciclo1: Integer;

Begin
  For Ciclo1:= 1 To Length(Texxto2) Do
             Begin
               Delay(Atraso);
               Write(Copy(Texxto2,Ciclo1,1));
             End; { do Ciclo1 }

End;
(****************************)
{ Mostra as empresas do jogo. }

Procedure Listar;
Var
      Nome: Array[1..10] Of String[61] ;
Begin
    Nome[1]:= 'AEROPORT  SA - Transportes areos portugueses';
    Nome[2]:= 'PETROIL SA - Companhia industrial de derivados do Petrขleo';
    Nome[3]:= 'N'+'.'+'F'+'.-'+' S'+'.I. - Inform ti'+'ca e novas tecnologias';
    Nome[4]:= 'TRIUNFUS  LDA - Soc. Industrial de produtos alimentares';
    Nome[5]:='B.T.A. SA - Banco Tran'+#39+'s Atlntico';
    Nome[6]:= 'B.C.I. SA - Banco Comunit rio Internacional';
    Nome[7]:= 'TRANSPOR LDA - Transportes Portugueses Rodovi rios';
    Nome[8]:= 'CONFIAN€A  SA - Companhia de seguros';
    Nome[9]:= 'CELULOSE-P - Soc. Industrial de produtos derivados da Madeira';
    Nome[10]:= 'T.V.P. SA  - Televiso Privada SA';

  Memoria('g','a');
  Quadro(8,5,72,18,13);
  Quadro1(8,5,72,18,15);
  Textcolor(0);
  For Ciclo:= 1 To 10 Do
             Begin
               Gotoxy(10,6+ Ciclo);
               Maquinaa(Nome[Ciclo],25);
             End;
  Textcolor(15);
  Gotoxy(60,Wherey+1);
  Write('QQ tecla...');
  Repeat Until Keypressed;
  Memoria('l','f');
End; { fim do procedimento listar }


(****************************)
{ Opo suspender do menu. }

Procedure Suspender;
Begin
  Memoria('g','a');
  Textcolor(7);
  Textbackground(0);
  Gotoxy(1,1);
  For Ciclo:= 1 To 25 Do
             Begin
               Delline;
               Delay(20);
             End;
  Window(30,23,80,25);
  Writeln('ษออออออออออออออออออออ BOL$A อออออออออออออออออออป');
  Write('บ PARA REGRESSAR AO JOGO, ESCREVA ');
  tEXTCOLOR(14+BLINK);
  wRITE('EXIT ');
  tEXTCOLOR(7);
  wRITEln('(ENTER) บ');
  Write('ศออออออออออออออออออออออออออออออออออออออออออออออผ');
  Window(1,1,80,25);

  { Faz o exit.}

  Exec('c:\command.com','');

  Writeln;
  Writeln('# BOL$A');
  Writeln('AINDA BEM QUE SE LEMBROU DE MIM !');
  dELAY(2000);

  Memoria('l','f');
End; { do procedimento suspender }
(****************************)
{ Procedimento para terminar o programa. }

Procedure Terminar;
var
   ter: integer;
Begin
  ter:= 1;
  Memoria('g','a');
  Window(1,1,80,16);
  Gotoxy(1,1);
  For Ciclo:= 1 To 15 Do
             Begin
                Delay(60);
                Insline;
             End;
 Textcolor(15+Blink);
 Textbackground(4);
 Window(1,1,80,25);
 Gotoxy(9,20);
 Write(JOgador);
 Gotoxy(1,1);
 Textcolor(12);
 Textbackground(0);
 Texxto:='O qu ??!!...';
 Maquinaa(Texxto,30);
 Delay(1500);
 Gotoxy(1,Wherey+1);
 Texxto:='Terminar ??!!...';
  Maquinaa(Texxto,30);
  Delay(1500);
  Gotoxy(1,Wherey+1);
  Texxto:= 'Tem a certeza (S/N) ??!!...';
 Maquinaa(Texxto,100);
 Gotoxy(18,Wherey);
 Textcolor(12+Blink);
 Write('N');
 Gotoxy(30,23);
 Ch:=' ';
 Repeat Until Keypressed;
   Ch:= Readkey;
   Ch:= Upcase(Ch);
   If Ch='S' Then
      Begin
        Window(1,16,80,25);
        Gotoxy(1,1);
        For loop:= 1 To 10 Do
                   Begin
                     Delay(150);
                     dELline;
                   End;
        Window(1,1,80,25);
        tEXTCOLOR(7);
        Clrscr;
        Writeln('* BOL$A *');
        Writeln(' PENA QUE NO TENHA GOSTADO DO JOGO . . .');
        writeln;
        writeln;

        { Termina o programa }

        Halt;
      End;
  Window(1,1,80,25);
  Clrscr;
  Textcolor(7);
  Writeln('OBRIGADO !');
  dELAY(2000);
  Memoria('l','f');

End; { procedimento terminar }




End.