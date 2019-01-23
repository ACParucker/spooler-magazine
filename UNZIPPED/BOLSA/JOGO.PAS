{$M 64000,0,200000}
{$V-}
Unit Jogo;

Interface
Uses Crt, Dos, Efeitos, Jogo1;

const
     versao= 2.1; { versÑo do jogo }
type
    r= record
        nome: string[10];
        bens: longint;
       end;

Var
   Jogador: Array[1..30] Of String[10];
   Nome_Accoes,Nome_R: Array[1..10] Of String[63];
   Variacao:Array[1..10] Of Real;
   VariacaoS: Array[1..10] Of String[4];
   N_Accoes,P_Accoes : Array[1..10] Of Longint;
   N_Accoes_j: Array[1..20,1..10] Of Longint;
   Melhore: array[1..10] of real;
   Saldo: Array[1..20] Of Longint;
   NJogadas, loop4,Code, Njogadores,Loopjogador, Loopjogada: Integer;
   Loop2, Loop3: Real;
   Ch: Char;
   Textoo, Texto: String[80];
   ponto,ponto1: pointer;
   xponto,yponto: integer;
   melhorj: array[1..30] of longint;
   bens: array[1..30] of longint;
   mj,m: longint;
   ficha: array[1..10] of r;
   fich: file of r;


Procedure Jogadores_Jogadas;

Procedure Jogar;

Procedure Logo;

procedure ecran;

Implementation

Procedure Teclado;

Var
   Xinicial: Integer;

Begin
  Textoo:='' ;
  Xinicial:= Wherex;
  Repeat
   Ch:= Readkey;
  IF Ch<> #0 Then
  Begin
    If (Ch= #08) And (Wherex>= Xinicial) Then
           Begin
             Textoo:= Copy(textoo,1,Length(textoo)-1);
             Gotoxy(Wherex-1,Wherey);
             Write(' ');
             Gotoxy(Wherex-1,Wherey);
           End; { do If }
    If (Ch= #08) And (Wherex< Xinicial) Then
               Begin
                 Gotoxy(Wherex+1,Wherey);
                 textoo:= '';
               End;

    If  (Ch<> #08) Then
           Begin
              Textoo:= Textoo + Upcase(Ch);
              Write(Ch);
           End;
   End; { do ch<> #0}

    If Ch= #0 Then
              Ch:= Readkey;

  Until  (Ch= #13) Or (Ch= #61) Or (Ch= #27) Or (Wherex= Xinicial+10); { #58 = F10 }
  Sound(800);
  Delay(100);
  Nosound;
  Textoo:= Copy(Textoo,1,Length(Textoo) -1);

End;  { do procedimento teclado }

(****************************)
{ Sou EU. }

procedure nf;
begin
  write(' N');
  gotoxy(wherex,wherey);
  write('F,');
end;

(****************************)

Procedure Maquina(Var TExto2: String; Atraso, Numero,x,y: Integer);

Begin
If Numero= 1 Then
  For Loop:= 1 To Length(Texto2) Do
             Begin
               sound(100);
               Delay(Atraso);
               nosound;
               Write(Copy(Texto2,Loop,1));
               sound(200);
               delay(7);
               nosound;
             End { do Loop }
 Else
   Begin
     For Loop:= Length(Texto2) Downto 1 Do
                Begin
                  Gotoxy(x,y);
                  Delay(Atraso);
                  Write(Copy(Texto2,Loop,Length(Texto2)));
                End;
     Gotoxy(x+1,y);
     Textbackground(4);
     Textcolor(15);
     Write(Copy(Texto2,2,Length(Texto2)));
     Delay(Length(Texto2)*60);
     Gotoxy(x,y);
     Textcolor(7);
     Textbackground(0);
     Write(Texto2);

     Textbackground(0);
     For Loop:= 1 To Length(Texto2)  Do
                Begin
                  Gotoxy(x+Loop,y);
                  Delay(Atraso);
                  Write(Copy(Texto2,1,Length(Texto2)-Loop));
                  If Njogadores=20 then
                                   Begin
                                     If (x+Loop>= 40) And (x+Loop<= 64) Then
                                        Begin
                                          Gotoxy(x+Loop-1,y);
                                          Textcolor(8);
                                          Write(#176);
                                          Textcolor(7);
                                        End;
                                    End;
                End; { do For }

   End; { do else }

End; { do procedimento maquina }

(****************************)
{ Là o n£mero de jogadores e de jogadas. }

Procedure Jogadores_Jogadas;

Var
   NjogadoresS: String[8];
   Texto: String[80];
   loop, loop1: Integer;


Begin
  Textbackground(0);
  Textcolor(7);
 Repeat
  Clrscr;
  Gotoxy(1,25);
  Write('<F3> para sair.');
  Quadro1(20,14,60,16,7);
  Texto:='Quantos jogadores ? ';
  Gotoxy(22,15);
  Maquina(Texto,100,1,0,0);
  Gotoxy(Wherex,15);

  Teclado;
  If (Ch= #61) Or (Ch= #27) Then Begin Clrscr;
  textcolor(14);
       textbackground(4);
       writeln(' NF ');
       writeln;
       textcolor(7);
       textbackground(0);Halt; End;

  Njogadoress:= Textoo;
  Gotoxy(20,16);
  If NjogadoresS='' Then Njogadoress:= '0';
  Val(NjogadoresS,Njogadores,Code);
  If Code<> 0 Then
            Begin
              Sound(300);
              Delay(1000);
              Nosound;
              Texto:= ' O n£mero de jogadores est† incorrecto, tente outra vez ...';
              Maquina(Texto,40,2,10,23);
            End; { do if }
  If (Code= 0) And (Njogadores<2) Then
            Begin
              Code:= 1;
              Sound(300);
              Delay(1000);
              Nosound;
              Texto:= ' O n£mero de jogadores tem que ser maior ou igual a dois.';
              Maquina(Texto,40,2,12,23);
              Texto:= ' Dez jogadores ser† o m†ximo aconselh†vel para se poder jogar.';
              Maquina(Texto,40,2,8,23);
            End; { Do If }
  If (Code= 0) And (Njogadores> 15) Then
            Begin
              Code:= 1;
              Texto:=' O n£mero m†ximo de jogadores admitido Ç de quinze ( 15 ).';
              Maquina(Texto,40,2,12,23);
            End;
 Until Code= 0;
 Gotoxy(42,15);
 Textcolor(7+blink);
 Write(Njogadores);
 Delay(1500);
  Textcolor(7);
  Textbackground(0);
  Clrscr;
  Encher(#176);

  Gotoxy(66,1);
  Textcolor(7+Blink);
  Write('<F3> para sair.');
  Textcolor(0);
  For Loop:= 1 To Njogadores Do
             Begin
              Repeat
               Quadro((Loop*2+1),Loop,(Loop*2)+25,Loop+4,1);
               Textcolor(15);
               Quadro1((Loop*2+1),Loop,(Loop*2)+25,Loop+4,15);
               Gotoxy(Loop*2+1+1,Loop+1);
               Writeln(#01);
               Gotoxy(Loop*2+2+1,Loop+1);
               Write(' Nome do ',Loop,'ß jogador ?');
               Gotoxy(Loop*2+1+1+1,Loop+2);
               Teclado;
               If (Ch= #61) Then Begin Textbackground(0);Clrscr; Halt; End;
              Until Textoo<>'';
               Jogador[Loop]:= Textoo;
             End;

  Loop:= 40;
  Loop1:= 40;
  Loop2:= 15;
  Loop3:= 15;
  Repeat
    Quadro(Loop,Round(Loop2),Loop1,Round(Loop3),1);
    Delay(100);
    Loop:= Loop-2;
    Loop1:= Loop1+2;
    Loop2:= Loop2-0.2;
    Loop3:= Loop3+0.2;
  Until Loop2<= 13;
 Repeat
  Quadro1(20,13,60,17,15);
  Gotoxy(23,15);
  Texto:='Quantas jogadas ? ';
  Maquina(Texto,100,1,0,0);
  Gotoxy(Wherex,15);
  Memoria('g','a');

  Teclado;
  If (Ch= #61) Or (Ch= #27) Then Begin Textbackground(0); Clrscr;
  textcolor(14);
       textbackground(4);
       writeln(' NF ');
       writeln;
       textcolor(7);
       textbackground(0);Halt; End;

  Njogadoress:= Textoo;
  Gotoxy(20,16);
  If NjogadoresS='' Then Njogadoress:= '0';
  Val(NjogadoresS,Njogadas,Code);
  Textbackground(0);
  TExtcolor(7);
  If Code<> 0 Then
            Begin
              Sound(300);
              Delay(1000);
              Nosound;
              Textcolor(7);
              Textbackground(0);
              Texto:= '∞O n£mero de jogadas est† incorrecto, tente outra vez ...';
              If Njogadores<17 Then
                   Maquina(Texto,40,2,10,23)
                Else
                   Maquina(Texto,40,2,10,25);
              Memoria('l','a');
            End; { do if }
  If (Code= 0) And (Njogadas<1) Then
            Begin
              Code:= 1;
              Sound(300);
              Delay(1000);
              Nosound;
              Texto:= '∞O n£mero de jogadas tem que ser maior ou igual a um.';
               If Njogadores<17 Then
                   Maquina(Texto,40,2,14,23)
                Else
                    Maquina(Texto,40,2,14,25);
              Memoria('l','a');
              Texto:= '∞Cinquenta jogadas ser† o m†ximo aconselh†vel para se poder jogar. ';
              If Njogadores<17 Then
                   Maquina(Texto,40,2,8,23)
                Else
                    Maquina(Texto,40,2,8,25);
              Memoria('l','a');
            End; { Do If }
  If (Code= 0) And (Njogadas> 200) Then
            Begin
              Code:= 1;
              Texto:='∞O n£mero m†ximo de jogadas admitido Ç de duzentas ( 200 ).';
              If Njogadores< 17 Then
                      Maquina(Texto,40,2,12,23)
                  Else
                      Maquina(Texto,40,2,12,25);
              Memoria('l','a');
            End;
   Textcolor(15);
   Textbackground(1);
 Until Code= 0;
  Gotoxy(41,15);
  Textcolor(15+blink);
  Write(Njogadas);
  Delay(1500);
  Textcolor(7);
  Textbackground(0);
  Clrscr;
  Quadro1(1,1,80,24,7);
  Gotoxy(3,24);
  Write('<F3> para sair.');
  Gotoxy(31,24);
  Write('<ESC> para recomeáar.');
  textcolor(7+blink);
  Gotoxy(60,24);
  Write('<ENTER> para jogar.');
  textcolor(7);
  Window(2,2,79,23);
  For Loop1:= 1 To Njogadores Do
             Begin
               Gotoxy(2,Wherey);
               Write('Jogador Nß:',Loop1);
               Gotoxy(30,Wherey);
               Write('Nome:');
               Texto:= Jogador[Loop1];
               Maquina(Texto,40,1,Wherex,Wherey);
               Gotoxy(2,Wherey+1);
             End;
    Gotoxy(60,Wherey);
    Textbackground(3);
    Textcolor(0);
    Write('Nß jogadas = ',Njogadas);
    Window(1,1,80,25);
    Textcolor(7);
    Repeat
      Ch:= Readkey;
      If Ch= #0 Then Ch:= Readkey;
    Until (Ch=#61) Or (Ch=#27) Or (Ch=#13);
    If Ch= #61 Then Begin Textbackground(0); Clrscr;
       textcolor(14);
       textbackground(4);
       writeln(' NF ');
       writeln;
       textcolor(7);
       textbackground(0);Halt; End;
    If Ch= #27 Then Begin Exec('bolsa.exe',''); halt; End;
    Textbackground(0);
    Clrscr;

End; { do procedimento jogadores_Jogadas }

(****************************)

Procedure Logo;

var
   ch: char;
   i: integer;

Begin
   textcolor(14);
   textbackground(7);
   clrscr;
   delay(100);
   textbackground(0);
   clrscr;
   gotoxy(2,5);
   write('                                                     €€');
   gotoxy(2,6);
   write('€€€€€€€€€€€€       €€€€€€     €€€€€€€€            €€€€€€€€         €€€€   ');
   gotoxy(2,7);
   write('∞∞€€€€∞∞∞∞€€€€   €€€€∞∞€€€€   ∞∞€€€€∞∞          €€€€∞€€∞€€€€     €€€€€€€€');
   gotoxy(2,8);
   write('  €€€€    €€€€   €€€€  €€€€     €€€€            €€€€ €€ ∞∞∞∞   €€€€∞∞∞∞€€€€');
   gotoxy(2,9);
   write('  €€€€€€€€€€∞∞   €€€€  €€€€     €€€€            ∞∞€€€€€€€€     €€€€    €€€€');
   gotoxy(2,10);
   write('  €€€€∞∞∞∞€€€€   €€€€  €€€€     €€€€       €€     ∞∞∞€€∞€€€€   €€€€€€€€€€€€');
   gotoxy(2,11);
   write('  €€€€    €€€€   €€€€  €€€€     €€€€     €€€€   €€€€ €€ €€€€   €€€€∞∞∞∞€€€€');
   gotoxy(2,12);
   write('€€€€€€€€€€€€∞∞   ∞∞€€€€€€∞∞   €€€€€€€€€€€€€€€   ∞∞€€€€€€€€∞∞   €€€€    €€€€');
   gotoxy(2,13);
   write('∞∞∞∞∞∞∞∞∞∞∞∞       ∞∞∞∞∞∞     ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞     ∞∞∞€€∞∞∞     ∞∞∞∞    ∞∞∞∞');
   gotoxy(2,14);
   write('                                                     ∞∞ v',versao:1:1);
   gotoxy(2,17);
   write('                                               Por Nuno Funico, 199'+'1');
   textcolor(7);
   gotoxy(2,20);
   write('     Para a SPOOLER Magazine');
   textcolor(15+blink);
   gotoxy(50,24);
   write(' << DIZ NéO ëS DROGAS ! >> ');
   gotoxy(76,12);
   delay(1000);
   i:= 0;
   textcolor(7);
   repeat

    i:= i +1;
    if i= 15000 then
       begin
         gotoxy(2,20);
         write('     Para a SPOOLER Magazine');
         gotoxy(76,12);
       end
    else if i= 30000 then
         begin
          i:= 0;
          gotoxy(2,20);
          write('     Para a spooler MAGAZINE');
          gotoxy(76,12);
         end;

   until keypressed;
   ch:= readkey;
End; { do procedimento logo }

(****************************)
{ Desenha o ecran principal. }


procedure Ecran;


Var
   Loop, loop1: Integer;
Begin
  Textbackground(7);
  Clrscr;
  If Lo(Lastmode)= 7 Then
                   Quadro2(1,1,80,25,7)
    Else
  Quadro4(1,1,80,25);

  Quadro2(12,4,53,15,0);
  Gotoxy(2,5);
  Textcolor(14);
  Write('AEROPORT  ');
  gOTOXY(2,6);
  Write('PETROIL SA');
  Gotoxy(2,7);
  Write('N.'+'F'+'.'+'- S'+'.I.');
  Gotoxy(2,8);
  Write('TRIUNFUS  ');
  Gotoxy(2,9);
  Write('B.T.A. SA ');
  Gotoxy(2,10);
  Write('B.C.I. SA ');
  Gotoxy(2,11);
  Write('TRANSPOR L');
  Gotoxy(2,12);
  Write('CONFIANÄA ');
  Gotoxy(2,13);
  Write('CELULOSE-P');
  Gotoxy(2,14);
  Write('T.V.P. SA ');
  Textcolor(0);
  Gotoxy(22,4);
  Write('≈');
  Gotoxy(32,4);
  Write('≈');
  Gotoxy(42,4);
  Write('≈');
  Gotoxy(22,15);
  Write('≈');
  Gotoxy(32,15);
  Write('≈');
  Gotoxy(42,15);
  Write('≈');
  Gotoxy(12,3);
  Write('0');
  Gotoxy(12,16);
  Write('0');
  Gotoxy(22,3);
  Write('5');
  Gotoxy(22,16);
  Write('5');
  Gotoxy(32,3);
  Write('10');
  Gotoxy(32,16);
  Write('10');
  Gotoxy(42,3);
  Write('15');
  Gotoxy(42,16);
  Write('15');
  Gotoxy(51,3);
  Write('20');
  Gotoxy(51,16);
  Write('20');
  Gotoxy(12,4);
  Write('√');
  Gotoxy(12,15);
  Write('√');
  Gotoxy(52,4);
  Write('≈');
  Gotoxy(52,15);
  Write('≈');
  Textbackground(2);
  Textcolor(0);
  For Loop:= 1 To 10 Do
      Begin
        Gotoxy(13,4+Loop);
        For Loop1:= 1 To 40 Do
                    Write('.');
      End;
   Textcolor(0);
   Textbackground(7);
   Gotoxy(2,2);
   Write('*EMPRESA*');
   Gotoxy(27,2);
   Write('* COTAÄéO *');
   Gotoxy(56,2);
   Write('VAR.');
   Textbackground(3);
   Textcolor(0);
   For Loop:= 1 To 10 Do
              Begin
                Gotoxy(56,4+Loop);
                Write('Ò0.0');
                Gotoxy(65,4+Loop);
                Write('    ');
                Gotoxy(74,4+Loop);
                Write('    ');
              End;

   quadro4(55,4,60,15);
   quadro4(64,4,69,15);
   quadro4(73,4,78,15);
   Textcolor(0);
   Textbackground(7);
   Gotoxy(64,2);
   Write('ACÄôES');
   Gotoxy(63,3);
   Write('      ');
   Gotoxy(73,2);
   Write('ACÄôES');
   Gotoxy(73,3);
   Write('JOGAD.');
   Gotoxy(60,16);
   Write('JOGADA:');
   textcolor(15);
   Gotoxy(4,23);
   Write('SALDO:');
   {Quadro2(2,17,79,24,7);}
   quadro4(2,17,79,24);
   Gotoxy(4,18);
   Write('JOGADOR');
   Gotoxy(4,19);
   Write('ﬂﬂﬂﬂﬂﬂﬂ');
   textcolor(15);
   Gotoxy(4,20);
   Write('NOME:');
   Gotoxy(4,21);
   Write('Nß:');
   textcolor(0);
   For Loop:= 18 To 23 Do
              Begin
                 Gotoxy(20,Loop);
                 Write('∫');
              End;

   {Gotoxy(20,17);
   Write(#196);
   gotoxy(20,24);
   Write(#196);   }

   Quadro4(22,18,44,23);
   Gotoxy(30,19);
   textcolor(0);
   Write(' MENU ');
   textcolor(15);
   Gotoxy(24,20);
   Write('C)omprar');
   Gotoxy(24,22);
   Write('V)ender');
   Gotoxy(34,20);
   Write('P)assar');
   Gotoxy(34,22);
   Write('E)voluáÑo');
   if lo(lastmode)<> 7 then
   begin
   Textbackground(7);
   textcolor(0);
   end
    else
      begin
        textbackground(1);
        textcolor(0);
        end;
   Gotoxy(24,20);
   Write('C');
   Gotoxy(24,22);
   Write('V');
   Gotoxy(34,20);
   Write('P');
   Gotoxy(34,22);
   Write('E');
   Textcolor(0);
   Textbackground(7);
   Quadro1(46,18,78,23,1);
   Gotoxy(58,18);
   Textcolor(0);
   Write(' MERCADO ');
   Gotoxy(60,25);
   Write('<F3 para terminar>');
   Gotoxy(33,25);
   Write('<F2 para suspender>');
   Gotoxy(3,25);
   Write('<F1 para ver empresas>');


End;
(****************************)
{ Inicia vari†veis. }


Procedure Iniciar;
var
   loop, loop1: integer;
Begin
  For Loop:= 1 To Njogadores Do
            Begin
             Saldo[Loop]:= 100000; { Escudos }
             For Loop1:= 1 To 10 Do
                         Begin
                         N_Accoes_J[Loop,Loop1]:= 0;
                         Variacao[loop1]:= 0.0;
                         VariacaoS[Loop1]:='Ò0.0';
                         melhore[loop1]:= 0.0;
                         End;

            End;
    Nome_Accoes[1]:= 'AEROPORT  SA - Transportes aÇreos portugueses';
    Nome_R[1]:= 'TRANSPORTES';
    N_Accoes[1]:= 1500; P_Accoes[1]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[2]:= 'PETROIL SA - Companhia industrial de derivados do Petr¢leo';
    Nome_R[2]:= 'INDUSTRIA PETROLIFERA';
    N_Accoes[2]:= 1500; P_Accoes[2]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[3]:= 'N.F.- S.I. - Inform†tica e novas tecnologias';
    Nome_R[3]:= 'PRESTAÄéO DE SERVIÄOS';
    N_Accoes[3]:= 500; P_Accoes[3]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[4]:= 'TRIUNFUS  LDA - Soc. Industrial de produtos alimentares';
    Nome_R[4]:='INDUSTRIA ALIMENTAR';
    N_Accoes[4]:= 500; P_Accoes[4]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[5]:='B.T.A. SA - Banco Tran'+#39+'s AtlÉntico';
    Nome_R[5]:= 'BANCO';
    N_Accoes[5]:= 1000; P_Accoes[5]:= ((random(13) +1)* 1000) + 2000;;
    nOME_Accoes[6]:= 'B.C.I. SA - Banco Comunit†rio Internacional';
    Nome_R[6]:='BANCO';
    N_Accoes[6]:= 1000; P_Accoes[6]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[7]:= 'TRANSPOR LDA - Transportes Portugueses Rodovi†rios';
    Nome_R[7]:= 'TRANSPORTES';
    N_Accoes[7]:= 900; P_Accoes[7]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[8]:= 'CONFIANÄA  SA - Companhia de seguros';
    Nome_R[8]:= 'SEGUROS';
    N_Accoes[8]:= 600; P_Accoes[8]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[9]:= 'CELULOSE-P - Soc. Industrial de produtos derivados da Madeira';
    Nome_R[9]:= 'INDUSTRIA MADEIREIRA';
    N_Accoes[9]:= 1200; P_Accoes[9]:= ((random(13) +1)* 1000) + 2000;;
    Nome_Accoes[10]:= 'T.V.P. SA  - TelevisÑo Privada SA';
    Nome_R[10]:= 'COMUNICAÄôES';
    N_Accoes[10]:= 1300; P_Accoes[10]:= ((random(13) +1)* 1000) + 2000;


End; { do procedimento iniciar }
(****************************)

Procedure Jogar;

Var
   Menuf: File;
   MenuP: Pointer;
   Rand1,Cont: Integer;
   Rand: Longint;
   Prim: Boolean;
   Grafico: Real;

(****************************)
{ Para escolher uma empresa com a barra }


Procedure Escolher;
Begin
  Cont:= 1;
  Textcolor(15+blink);
  TextBackground(0);
  Gotoxy(2,5);
  Write(Copy(Nome_Accoes[1],1,10));
  Repeat

  Textcolor(14);
  Textbackground(7);
  Repeat
  Ch:= ReadKey;
  Until (Ch=#27) Or (ch=#13) Or (Ch= #0);
  If Ch= #0 Then
         Begin
           Ch:= Readkey;
           If Ch=#80 Then
                     Begin
                       Cont:= Cont+1;
                       If Cont> 10 Then
                                Begin
                                  Cont:= 1;
                                  Gotoxy(2,14);
                                  Write(Copy(Nome_Accoes[10],1,10));
                                  Textcolor(15+blink);
                                  Textbackground(0);
                                  Gotoxy(2,4+Cont);
                                  Write(Copy(Nome_Accoes[Cont],1,10));
                                End
                       Else
                           Begin
                             Gotoxy(2,4+Cont-1);
                             Write(Copy(Nome_Accoes[Cont-1],1,10));
                             Textcolor(15+blink);
                             TExtbackground(0);
                             Gotoxy(2,4+Cont);
                             Write(Copy(Nome_Accoes[Cont],1,10));
                           End;
                     End; { do If }

           If Ch=#72 Then
               Begin
                 Cont:= Cont-1;
                 If Cont<1 Then
                           Begin
                             Cont:= 10;
                             Gotoxy(2,5);
                             Write(Copy(Nome_Accoes[1],1,10));
                             Textcolor(15+blink);
                             Textbackground(0);
                             Gotoxy(2,4+Cont);
                             Write(Copy(Nome_Accoes[Cont],1,10));
                           End
                 Else
                 Begin
                   Gotoxy(2,4+Cont+1);
                   Write(Copy(Nome_Accoes[Cont+1],1,10));
                   TExtcolor(15+blink);
                   Textbackground(0);
                   Gotoxy(2,4+Cont);
                   Write(Copy(Nome_Accoes[Cont],1,10));
                 End;
              End; { do Else }
       End;

  Until (Ch= #13) Or (Ch=#27);

End; { do procedimento escolher }

(****************************)
{ Para comprar acáîes. }


Procedure Comprar;
Var
   Naccoes: Integer;
   NaccoesS: String[10];
   Pode: Real;

Begin
  If Saldo[Loopjogador]<= 0 Then
                    Begin
                      Memoria('g','a');
                      Quadro(28,11,58,14,4);
                      Quadro1(28,11,58,14,14);
                      Textcolor(7);
                      Gotoxy(30,12);
                      Write('O SEU SALDO NéO ê POSITIVO.');
                      Sound(300);
                      Delay(100);
                      Nosound;
                      Delay(3500);
                      Memoria('l','f');
                      EXIT;
                   End;
  Memoria('g','a');
  Quadro(20,8,60,16,1);
  Quadro1(20,8,60,16,8);
  Gotoxy(37,8);
  Textcolor(15+blink);
  Write('COMPRAR');
  Textbackground(1);
  Textcolor(11);
  Gotoxy(21,15);
   Write('<ESC>                < ',#24,' ',#25,' ',' e Enter',#17+#217,' >');
  Textcolor(15);
  Gotoxy(22,10);
  Write('Escolha a empresa . . .');
  Escolher;
  If Ch<> #27 Then
  Begin
  Repeat
  Textcolor(11);
  Window(21,9,59,15);
  Textbackground(1);
  Clrscr;
  Window(1,1,80,25);
  Gotoxy(55,15);
  Write('<ESC>');
  Textcolor(15);
  Gotoxy(21,10);
  Write('Tipo:');
  Textbackground(0);
  Write(Nome_R[Cont]);
    Textbackground(1);
  Gotoxy(21,11);
  Write('N£mero de acáîes:');
  Textbackground(0);
  Write(N_Accoes[Cont]);
  Textbackground(1);
  Gotoxy(21,12);
  Write('Preáo:');
  Textbackground(0);
  Write(P_Accoes[Cont],'$00');
  Gotoxy(21,13);
    Textbackground(1);
  Write('Pode comprar ');
  Textbackground(0);
  Pode:= Saldo[Loopjogador] Div P_Accoes[Cont];
  If Frac(Pode)<> 0 Then
  Begin
    Pode:= Pode- (Frac(Pode) + 0.1);
  End;
  if Pode> N_Accoes[cont] then pode:= N_Accoes[cont];

  Write(Int(Pode):0:0);
  Textbackground(1);
  Write(' acáîes.');
  Gotoxy(21,14);
  Write('Quantas acáîes deseja ? ');
  Textbackground(0);
  Teclado;
  NaccoesS:= Textoo;
  If (Ch=#27) Or (NaccoesS='0') Or (NaccoesS='') Then Begin Memoria('l','f');Exit; End;

  Val(NaccoesS, Naccoes,Code);
  Until (Code=0) And (Naccoes<= Int(Pode)) And
                 (Naccoes> 0);
  N_Accoes[Cont]:= N_Accoes[Cont] - Naccoes;
  N_Accoes_J[Loopjogador, Cont]:= N_Accoes_J[Loopjogador, Cont] + Naccoes;
  Saldo[Loopjogador]:= Saldo[Loopjogador] -  (NAccoes* P_Accoes[Cont]);
  Window(1,1,80,25);
  End;
  Memoria('l','f');

End; { do procedimento comprar }

(****************************)


{ Para vender acáîes. }
Procedure Vender;
Var
   Naccoes: Integer;
   NaccoesS: String[10];

Begin
  Memoria('g','a');
  Quadro(20,8,60,16,1);
  Quadro1(20,8,60,16,8);
  Gotoxy(38,8);
  Textcolor(15+blink);
  Write('VENDER');
  Textbackground(1);
  Textcolor(11);
  Gotoxy(21,15);
   Write('<ESC>                < ',#24,' ',#25,' ',' e Enter',#17+#217,' >');
  Textcolor(15);
  Gotoxy(22,10);
  Write('Escolha a empresa . . .');
  Escolher;
  If Ch<> #27 Then
  Begin
  Repeat
  Textcolor(11);
  Window(21,9,59,15);
  Textbackground(1);
  Clrscr;
   Window(1,1,80,25);
  If N_Accoes_J[Loopjogador,Cont]= 0 Then
                    Begin
                      Memoria('l','f');
                      Memoria('g','a');
                      Quadro(28,11,55,14,4);
                      Quadro1(28,11,55,14,14);
                      Textcolor(7);
                      Gotoxy(30,12);
                      Write('NéO POSSUI NENHUMA ACÄéO');
                      Gotoxy(30,13);
                      Write('DA EMPRESA ',Copy(Nome_Accoes[Cont],1,10));
                      Sound(300);
                      Delay(100);
                      Nosound;
                      Delay(3500);
                      Memoria('l','f');
                      EXIT;
                   End;

  Gotoxy(55,15);
  Write('<ESC>');
  Textcolor(15);
  Gotoxy(21,10);
  Write('Tipo:');
  Textbackground(0);
  Write(Nome_R[Cont]);
    Textbackground(1);
  Gotoxy(21,11);
  Write('N£mero de acáîes (J):');
  Textbackground(0);
  Write(N_Accoes_J[Loopjogador,Cont]);
  Textbackground(1);
  Gotoxy(21,12);
  Write('Preáo:');
  Textbackground(0);
  Write(P_Accoes[Cont],'$00');
  Gotoxy(21,13);
    Textbackground(1);
  Write('Pode vender ');
  Textbackground(0);
  Write(N_Accoes_J[Loopjogador,Cont]);
  Textbackground(1);
  Write(' acáîes.');
  Gotoxy(21,14);
  Write('Quantas acáîes deseja ? ');
  Textbackground(0);
  Teclado;
  NaccoesS:= Textoo;
 If   (Ch=#27) Or (NaccoesS='0') Or (NaccoesS='') Then Begin Memoria('l','f');Exit; End;
  Val(NaccoesS, Naccoes,Code);
  Until (Code=0) And (Naccoes<= N_Accoes_J[Loopjogador,Cont])
        And (Naccoes> 0);
  N_Accoes[Cont]:= N_Accoes[Cont] + Naccoes;
  N_Accoes_J[Loopjogador, Cont]:= N_Accoes_J[Loopjogador, Cont] - Naccoes;
  Saldo[Loopjogador]:= Saldo[Loopjogador] +  (Naccoes* P_Accoes[Cont]);
  Window(1,1,80,25);
  End;
  Memoria('l','f');

End; { do procedimento vender }

(****************************)
{ Procedimento com as variaáîes do mercado. }


Procedure Mercado;

Var
   Bom, Mau: Array[1..20] Of String[50];
   Sorte,Sorte1: Integer;
   Tex: String[100];
   loop, loop1:integer;
Begin
   Sorte:= Random(6)+1;
   Window(47,19,77,22);
   Textcolor(15);
   Textbackground(7);
   Clrscr;
   If Sorte= 3 Then       { d† qualquer coisa }
              Begin
                Sorte:= Random(6)+1;
                Case Sorte Of
                     1:    Begin
                             sORTE:= Random(10)+1;
                             Tex:='A empresa '+cOPY(nOME_aCCOES[sORTE],1,10)+
                             ' deu 1 acáÑo por cada 4, aos seus accionistas.';
                             Maquina(Tex,40,1,0,0);
                             if n_accoes[Sorte]> 0 then
                             begin
                             For Loop:= 1 To Njogadores Do
                             Begin
                             if N_Accoes_J[Loop,Sorte]<> 0 Then
                                Begin
                             N_Accoes[Sorte]:= N_Accoes[Sorte] -
                                                    ( N_Accoes_J[Loop,Sorte] Div 4);
                                N_Accoes_J[Loop,Sorte]:= N_Accoes_J[Loop,Sorte]+ (N_Accoes_J[Loop,Sorte] Div 4);
                                End;
                             End;
                             end;
                             if n_accoes[sorte]< 0 then
                                n_accoes[sorte]:= 0;
                           End; { de 1 }
                       2:   Begin
                             sORTE:= Random(10)+1;
                             Tex:='A empresa '+cOPY(nOME_aCCOES[sORTE],1,10)+
                             ' deu-lhe 1 acáÑo, por cada 6 que possuir.';
                             Maquina(Tex,40,1,0,0);
                             if N_Accoes_J[Loopjogador,Sorte]<> 0 Then
                                Begin
                             N_Accoes[Sorte]:= N_Accoes[Sorte] -
                                                    ( N_Accoes_J[Loopjogador,Sorte] Div 6);
                                N_Accoes_J[Loopjogador,Sorte]:= N_Accoes_J[Loopjogador,Sorte]+
                                 (N_Accoes_J[Loopjogador,Sorte] Div 6);
                                End;
                            if n_accoes[sorte]<0 then
                               n_accoes[sorte]:= 0;
                           End; { de 2 }
                         3: Begin
                             sORTE:= Random(10)+1;
                             Sorte1:= Random(25)+1;
                             Tex:='Devido Ö boa fase que atravessa o mercado, o seu saldo aumenta ';

                             Maquina(Tex,40,1,0,0);
                             Write(Sorte1);
                             Tex:=' % .';
                             Maquina(Tex,40,1,0,0);
                             Saldo[Loopjogador]:= Saldo[Loopjogador] +
                             (abs(Saldo[Loopjogador]) * Sorte1  ) Div 100;
                           End; { de 3 }
                         4: Begin
                             sORTE:= Random(10)+1;
                             Sorte1:= Random(15)+1;
                             Tex:='Vai receber ';

                             Maquina(Tex,40,1,0,0);
                             Write(Sorte1);
                             Tex:=' %  sobre o valor das acáîes, da empresa '+
                             cOPY(nOME_aCCOES[sORTE],1,10)+', que possuir.';
                             Maquina(Tex,40,1,0,0);
                             Saldo[Loopjogador]:= Saldo[Loopjogador] +
                             ((N_Accoes_J[LOopjogador,Sorte]*P_Accoes[Sorte]) * Sorte1  ) Div 100;
                           End; { de 4 }
                         5: Begin
                             sORTE:= Random(10)+1;
                             Sorte1:= Random(15)+1;
                             Tex:='Devido a um erro inform†tico, vai receber ';

                             Maquina(Tex,40,1,0,0);
                             Write(Sorte1);
                             Tex:=' acáîes da empresa '+
                             cOPY(nOME_aCCOES[sORTE],1,10)+'.';
                             Maquina(Tex,40,1,0,0);
                             N_Accoes_J[Loopjogador,Sorte]:= N_Accoes_j[Loopjogador,Sorte] + sorte1;
                           End; { de 5 }
                         6: Begin
                             sorte1:= random(5) +1;
                             Tex:='Vair receber ';

                             Maquina(Tex,40,1,0,0);
                             Write(Sorte1);
                             Tex:=' acáîes de cada uma das empresas que possui.';
                             Maquina(Tex,40,1,0,0);
                             for loop:= 1 to 10 do
                             begin
                             if n_accoes_j[loopjogador,loop]> 0 then
                                     N_Accoes_J[Loopjogador,loop]:= N_Accoes_j[Loopjogador,loop] + sorte1;
                             end;
                           End; { de 6 }

                     End; { Do case }
              End
   Else
    If (Sorte=5) or (Sorte= 1) Then
         Begin
           Sorte:= Random(8)+1;
             Case Sorte Of
                     1:    Begin
                             sORTE:= Random(10)+1;
                             Tex:='* A empresa '+cOPY(nOME_aCCOES[sORTE],1,10)+
                             ' tirou 1 acáÑo por cada 4, aos seus accionistas.';
                             Maquina(Tex,40,1,0,0);
                             For Loop:= 1 To Njogadores Do
                             Begin
                                N_Accoes_J[Loop,Sorte]:= N_Accoes_J[Loop,Sorte]- (N_Accoes_J[Loop,Sorte] Div 4);
                                if n_accoes_j[loop,sorte]<0 then
                                   n_accoes_j[loop,sorte]:= 0;
                             End;
                           End;
                       2:   Begin
                             sORTE:= Random(10)+1;
                             Tex:='* A empresa '+cOPY(nOME_aCCOES[sORTE],1,10)+
                             ' tirou-lhe 1 acáÑo por cada 6.';
                             Maquina(Tex,40,1,0,0);
                                N_Accoes_J[Loopjogador,Sorte]:= N_Accoes_J[Loopjogador,Sorte]-
                                 (N_Accoes_J[Loopjogador,Sorte] Div 6);
                                if n_accoes_j[loopjogador,sorte]<0 then
                                   n_accoes_j[loopjogador,sorte]:= 0;
                           End;
                         3: Begin
                             sORTE:= Random(10)+1;
                             Sorte1:= Random(30)+1;
                             Tex:='* Devido Ö crise mundial o seu saldo diminui ';

                             Maquina(Tex,40,1,0,0);
                             Write(Sorte1);
                             Tex:=' % .';
                             Maquina(Tex,40,1,0,0);
                             Saldo[Loopjogador]:= Saldo[Loopjogador] -
                             (abs(Saldo[Loopjogador]) * Sorte1  ) Div 100;
                           End; { de 3 }
                         4: Begin
                             sORTE:= Random(10)+1;
                             Sorte1:= Random(20)+1;
                             Tex:='* Vai perder ';

                             Maquina(Tex,40,1,0,0);
                             Write(Sorte1);
                             Tex:=' %  sobre o valor das acáîes, da empresa '+
                             cOPY(nOME_aCCOES[sORTE],1,10)+', que possuir, devido a um rumor de falància.';
                             Maquina(Tex,40,1,0,0);
                             Saldo[Loopjogador]:= Saldo[Loopjogador] -
                             ((N_Accoes_J[LOopjogador,Sorte]*P_Accoes[Sorte]) * Sorte1  ) Div 100;
                           End; { de 4 }
                         5: begin
                              tex:='* Um especulador obriga as acáîes a descerem dr†sticamente. ';
                              maquina(tex,40,1,0,0);
                              for loop:= 1 to 10 do
                                  begin
                                    sorte:= random(8) +1;
                                    sorte:= sorte* 1000;
                                    p_accoes[loop]:= p_accoes[loop] -sorte;
                                    if p_accoes[loop]< 500 then
                                       p_accoes[loop]:= 500;
                                  end;
                              textcolor(0);
                              textbackground(2);
                              Window(13,5,52,14);
        Clrscr;
        Window(1,1,80,25);
                     For Loop:= 1 To 10 Do
                        Begin
                          Gotoxy(13,4+LOop);
                          Write('........................................');
                        End;

        For lOop:= 1 To 10 Do
              Begin
                    Grafico:= (P_Accoes[Loop] / 1000)*2;
                    For Loop1:= 1 To Trunc(Grafico) Do
                      Begin
                         Gotoxy(12+Loop1 ,4+Loop);
                         Write(#254);
                      End;
               End;
                            end; { de 5}
                     6: begin
                              tex:='* Devido Ö instabilidade no Leste, descem as cotaáîes. ';
                              maquina(tex,40,1,0,0);
                              for loop:= 1 to 10 do
                                  begin
                                    sorte:= random(3) +1;
                                    sorte:= sorte* 1000;
                                    p_accoes[loop]:= p_accoes[loop] -sorte;
                                    if p_accoes[loop]< 500 then
                                       p_accoes[loop]:= 500;
                                  end;
                              textcolor(0);
                              textbackground(2);
                              Window(13,5,52,14);
        Clrscr;
        Window(1,1,80,25);
                     For Loop:= 1 To 10 Do
                        Begin
                          Gotoxy(13,4+LOop);
                          Write('........................................');
                        End;

        For lOop:= 1 To 10 Do
              Begin
                    Grafico:= (P_Accoes[Loop] / 1000)*2;
                    For Loop1:= 1 To Trunc(Grafico) Do
                      Begin
                         Gotoxy(12+Loop1 ,4+Loop);
                         Write(#254);
                      End;
               End;
                            end; { de 6}
                      7:begin
                          sorte:= random(50) +1;
                          sorte1:= random(10) +1;
                          tex:= '* Uma fraude no sistema inform†tico, fez-lhe perder ';
                          maquina(tex,40,1,0,0);
                          write(sorte);
                          tex:= '$00 por cada acáÑo da empresa ' +
                          cOPY(nOME_aCCOES[sORTE1],1,10)+', que possuir.';
                          maquina(tex,40,1,0,0);
                          if n_accoes_j[loopjogador,sorte1]> 0 then
                             begin
                               saldo[loopjogador]:= saldo[loopjogador] - sorte* n_accoes_j[loopjogador,sorte1];
                             end;
                        end; {de 7}
                     End; { Do case }
         End;

  Window(1,1,80,25);

End; { do procedimento mercado }
(****************************)
{ Para passar a jogada. }


Procedure Passar;
Var
   Empresa: Array[1..5] Of String[10];
   VariS: Array[1..5] Of String[4];
   VariacaoSS: String[4];
   Numeros: Array[1..5] Of Integer;
   Numero, LOop2: Integer;
   NUm: Array[1..5] Of Integer;
   Vari: Array[1..5] Of Real;
   Sort: Boolean;
   Cha: Char;
   Varia:  Integer;
   loop,loop1: integer;

Begin
  if saldo[loopjogador]<= 0 then
     begin
                     Memoria('g','a');
                      Quadro(22,10,61,14,4);
                      Quadro1(22,10,61,14,14);
                      Textcolor(7);
                      Gotoxy(24,11);
                      Write('     O SALDO NéO ê POSITIVO.   ');
                      Gotoxy(24,12);
                      Write('PERDE O DIREITO A ALTERAR AS ACÄôES');
                      Gotoxy(24,13);
                      Write('                   QQ tecla ....   ');
                      cha:= readkey;
                      Memoria('l','f');
                      EXIT;
     end;
  Sort:= False;
  Memoria('g','a');
  Textbackground(0);
  Textcolor(7);
  Clrscr;
  Encher('∞');
  Textbackground(3);
  Textcolor(15+blink);
  Quadro(37,2,42,2,3);
  Gotoxy(37,2);
  Write('PASSAR');

  Loop:=1;
    Loop2:= 0;
  While Sort<> True Do
        Begin
          Numero:= Random(10)+1;
          Num[Loop]:= Numero;

          For LOop1:= 1 To Loop-1 Do

                     Begin
                       If Num[Loop]<> Num[Loop1] Then
                           Loop2:= LOop2+1;
                     End;
            If Loop2= Loop-1 Then
                      begin
                        Loop2:= 0;
                        Loop:= Loop+1;
                      End
               Else
                   Loop2:= 0;
           If Loop= 6 Then Sort:= True;
        End; { do While }
      For LOop:= 1 To 5 Do

                 Empresa[Loop]:= Copy(Nome_Accoes[Num[Loop]],1,10);

      Quadro(3,8,15,12,1);
      Quadro(19,8,31,12,1);
      Quadro(35,8,47,12,1);
      Quadro(51,8,63,12,1);
      Quadro(67,8,79,12,1);

      Quadro2(3,8,15,12,14);
      Quadro2(19,8,31,12,14);
      Quadro2(35,8,47,12,14);
      Quadro2(51,8,63,12,14);
      Quadro2(67,8,79,12,14);
      Textcolor(0);
      Gotoxy(4,9);
      WRite(Empresa[1]);
      Gotoxy(20,9);
      Write(Empresa[2]);
      Gotoxy(36,9);
      Write(Empresa[3]);
      Gotoxy(52,9);
      Write(Empresa[4]);
      Gotoxy(68,9);
      Write(Empresa[5]);

      For Loop:= 1 To 5 Do
          Begin
            Vari[Loop]:= Random(4)+0.5;
            If Vari[Loop]= 2.5 Then Vari[Loop]:= 1.0
               else
                   if vari[loop]=3.5 then vari[loop]:= 2.0;
            Loop2:=Random(10)+1;
            If Loop2>= 5 Then
               Vari[Loop]:= Vari[Loop] * (-1);
            Str(Vari[Loop]:0:1,VariS[Loop]);
            If VAri[LOop]> 0 Then
               VariS[Loop]:= '+'+VariS[Loop];
            melhore[num[loop]]:= melhore[num[loop]] + vari[loop];
          End;

      Gotoxy(6,11);
      WRite(VariS[1]);
      Gotoxy(22,11);
      Write(VariS[2]);
      Gotoxy(38,11);
      Write(VariS[3]);
      Gotoxy(54,11);
      Write(VariS[4]);
      Gotoxy(70,11);
      Write(VariS[5]);
      Textbackground(3);
      Quadro(4,24,14,24,3);
      Gotoxy(4,24);
      Write('Jogada:',Loopjogada);
      Quadro(68,24,78,24,3);
      Gotoxy(68,24);
      Write(#27+#26,' e ENTER',#17+#217);
      Quadro3(3,8,15,12,0);
      Loop2:= 1;
      Cha:= ' ';
      Repeat
      Repeat
        Gotoxy(80,25);
        Cha:= Readkey;
      Until (Cha=#13) Or (Cha=#0);
      If Cha= #0 Then
         Begin
           Cha:= Readkey;
           If Cha=#77 Then
                     Begin
                       Loop2:= Loop2+1;
                       If Loop2> 5 Then
                                Begin
                                  Loop2:= 1;
                                  Textbackground(3);
                                  Quadro3(3,8,15,12,0);
                                  Textbackground(1);
                                  Quadro2(67,8,79,12,14);
                                End
                       Else
                           Begin
                           Textbackground(3);
                             If Loop2= 2 Then
                                Quadro3(19,8,31,12,0);
                             If Loop2= 3 Then
                                Quadro3(35,8,47,12,0);
                             If Loop2= 4 Then
                                Quadro3(51,8,63,12,0);
                             If Loop2= 5 Then
                                Quadro3(67,8,79,12,0);
                             Textbackground(1);
                             If Loop2= 2 Then
                                Quadro2(3,8,15,12,14);
                             If Loop2= 3 Then
                                Quadro2(19,8,31,12,14);
                             If Loop2= 4 Then
                                Quadro2(35,8,47,12,14);
                             If Loop2= 5 Then
                                Quadro2(51,8,63,12,14);

                           End;
                     End; { do If }

           If Cha=#75 Then
               Begin
                 Loop2:= Loop2-1;
                 If Loop2<1 Then
                           Begin
                             Loop2:= 5;
                                  Textbackground(1);
                                  Quadro2(3,8,15,12,14);
                                  Textbackground(3);
                                  Quadro3(67,8,79,12,0);
                           End
                 Else
                 Begin
                   Textbackground(1);
                             If Loop2= 1 Then
                                Quadro2(19,8,31,12,14);
                             If Loop2= 2 Then
                                Quadro2(35,8,47,12,14);
                             If Loop2= 3 Then
                                Quadro2(51,8,63,12,14);
                             If Loop2= 4 Then
                                Quadro2(67,8,79,12,14);
                             Textbackground(3);
                             If Loop2= 1 Then
                                Quadro3(3,8,15,12,0);
                             If Loop2= 2 Then
                                Quadro3(19,8,31,12,0);
                             If Loop2= 3 Then
                                Quadro3(35,8,47,12,0);
                             If Loop2= 4 Then
                                Quadro3(51,8,63,12,0);
                 End;
              End; { do Else }
       End;

     Until Cha=#13;
     Sound(300);
     Delay(40);
     Nosound;
     For LOop:=1 To 10 Do
         Begin
           VariacaoS[Loop]:='Ò0.0';
         End;
     VariacaoS[Num[Loop2]]:= Varis[Loop2];
     VariacaoSS:= Copy(VariS[Loop2],2,1) +
                             Copy(VariS[Loop2],4,1);
     If VariacaoSS='05' Then VariacaoSS:='5';
     Val(VariacaoSS,Varia,Code);
     If Copy(Varis[Loop2],1,1)= '-' Then Varia:= Varia * -1;
     P_Accoes[Num[Loop2]]:= P_Accoes[Num[Loop2]] + (Varia * 100);
     If P_Accoes[Num[Loop2]]< 500 Then P_Accoes[NUm[Loop2]]:= 500
        else
            if p_accoes[num[loop2]]> 20000 then p_accoes[num[loop2]]:= 20000;
     Delay(1000);
  Memoria('l','f');
End; { do procedimento passar }
(****************************)
{ Para ver a evoluáÑo do jogo. }


Procedure evolucao;
var
   ch: char;
   loop,loop1: integer;
   me: real;
   mv: longint;
   me1: integer;
   valor: array[1..20] of longint;
begin
  memoria('g','a');
  textcolor(0);
  for loop:= 1 to 24 do
      begin
        if (loop mod 2)= 0 then
           begin
           textbackground(7);
           textcolor(0);
           end
           else
              begin
               textbackground(2);
               textcolor(0);
               end;
        gotoxy(1,loop);
        insline;
        gotoxy(1,loop);
        write('˛                                                                              ˛');
        delay(10);
      end;
  gotoxy(1,25);
  textbackground(2);
  clreol;
  gotoxy(1,25);
  textcolor(0);
  write('˛');
  If Lo(Lastmode)= 7 Then
                   begin
                   Fillchar(Ptr($B000,3998)^,1,#254);
                   fillchar(ptr($B800,3999)^,1,$20);
                   end
             Else
                 begin
                 Fillchar(Ptr($B800,3998)^,1,#254);
                 fillchar(ptr($B800,3999)^,1,$20);
                 end;
  gotoxy(32,1);
  write('* EVOLUÄéO *');
  gotoxy(3,3);
  write('Empresa com melhores perspectivas de crescimento:');
  me:= melhore[1];
  me1:= 1;
  for loop:= 1 to 10 do
      begin
        if melhore[loop]> me then
          begin
           me:= melhore[loop];
           me1:= loop;
          end;
      end;
   textbackground(2);
   gotoxy(4,5);
   write('NOME: ',nome_accoes[me1]);
   textbackground(7);
   gotoxy(4,6);
   write('TIPO: ',nome_r[me1]);
   textbackground(2);
   gotoxy(4,7);
   write('Nß DE ACÄôES PARA VENDER: ',n_accoes[me1],'  PREÄO POR ACÄéO: ', p_accoes[me1],'$00');
   me1:= 1;
   mv:= 0;
   for loop:= 1 to njogadores do
       begin
         valor[loop]:= saldo[loop];
           for loop1:= 1 to 10 do
               begin
                 if n_accoes_j[loop,loop1] <> 0 then
                    valor[loop]:= valor[loop] + n_accoes_j[loop,loop1]* p_accoes[loop1];
               end;
         if valor[loop]> mv then
            begin
              mv:= valor[loop];
              me1:= loop;
            end;
       end;
  textcolor(0);
  textbackground(2);
  gotoxy(3,9);
  if mv= 0 then mv:= 500;
  write('Valor dos bens dos jogadores :');
  for loop:= 1 to njogadores do
      begin
        if (10 +loop) mod 2 = 0 then
           begin
            textbackground(7);
           end
           else
               begin
                textbackground(2);
               end;
         gotoxy(3,10 + loop);
         write(jogador[loop]);
         if valor[loop]<= 0 then valor[loop]:= 1;
         for loop1:= 1 to ((valor[loop]*60) div mv) do
             begin
               gotoxy(15+ loop1,10+loop);
               write('˛');
             end;
      end;
  textbackground(2);
  gotoxy(65,25);
  write('QQ tecla...');
  gotoxy(80,25);
  ch:= readkey;
  memoria('l','f');
end; { evolucao }





(****************************)
{ Parte principal do jogo. }
var
   loop, loop1:integer;
   prim1: boolean;
   a,mes,dia,dow: word;

Begin
  Randomize;
  Prim:= true;
  ecran;
   (******)

   Iniciar; { definir var†veis }

   For LoopJogada:=  Njogadas DownTo 0  Do { FOR para o n£mero de jogadas. }

      Begin

        Gotoxy(67,16);
        Textbackground(4);
        Textcolor(15+blink);
        Write(Loopjogada:3);
        Textcolor(0);
        Textbackground(2);

   If Prim= True Then { Se for a primeira vez.}
     Begin
        { Gr†fico }
        Window(13,5,52,14);
        Clrscr;
        Window(1,1,80,25);
                     For Loop:= 1 To 10 Do
                        Begin
                          Gotoxy(13,4+LOop);
                          Write('........................................');
                        End;

        For lOop:= 1 To 10 Do
              Begin
                    Grafico:= (P_Accoes[Loop] / 1000)*2;
                    For Loop1:= 1 To Trunc(Grafico) Do
                      Begin
                         Gotoxy(12+Loop1 ,4+Loop);
                         Write(#254);
                      End;
               End;
     End; { Do if }


      prim1:= false;

      For LoopJogador:= 1 To Njogadores Do { FOR para os jogadores. }
        Begin

       Repeat

          { Dados do jogador. }

          Textbackground(4);
          Textcolor(0);
          Gotoxy(10,23);
          Write(Saldo[Loopjogador]:9,'$');
          Gotoxy(7,21);
          Write(Loopjogador:2);
          Gotoxy(9,20);
          Textbackground(7);
          Write('          ');
          Textbackground(4);
          Gotoxy(9,20);
          Write(Jogador[Loopjogador]);
          Textbackground(3);
          Textcolor(0);


          For Loop:= 1 To 10 Do
                     Begin
                       Gotoxy(74,4 +Loop);
                       Write(N_Accoes_J[LoopJogador,Loop]:4);
                     End;


           Textcolor(0);
           Textbackground(3);
        For Loop:= 1 To 10 Do
                 Begin
                   Gotoxy(65,4+ LOop);
                   Write(N_Accoes[Loop]:4);
                 End;
          

       if (Prim= false) and (prim1= true) then
           begin
            Mercado; { Faz aparecer as mensagens de varioaáÑo do mercado. }
            prim1:= false;
           end
       else
           begin
            Window(47,19,77,22);
            Textcolor(15);
            Textbackground(7);
            Clrscr;
            window(1,1,80,25);
           end;

       Textbackground(4);
       Textcolor(0);
       Gotoxy(10,23);
       Write(Saldo[Loopjogador]:9,'$');

       Textbackground(3);
          Textcolor(0);
          For Loop:= 1 To 10 Do
                     Begin
                       Gotoxy(74,4 +Loop);
                       Write(N_Accoes_J[LoopJogador,Loop]:4);
                     End;
           Textcolor(0);
            Textbackground(3);
      For Loop:= 1 To 10 Do
                 Begin
                   Gotoxy(65,4+ LOop);
                   Write(N_Accoes[Loop]:4);
                 End;

       Textcolor(7);
       Textbackground(0);

           If Prim= True Then
                    Begin
                      Memoria('g','a');
                      For Loop:= 1 To 50 Do
                                 Begin
                                   Quadro(Loop,12,Loop+2,12,1);
                                   Delay(20);
                                   Memoria('l','a');
                                 End;
                      Quadro(48,12,54,13,1);
                      Delay(200);
                      Quadro(45,12,54,14,1);
                      Delay(200);
                      Quadro(38,11,55,14,1);
                      Delay(200);
                      Quadro(36,11,56,14,1);
                      Delay(200);
                      Quadro(30,11,56,14,1);
                      Quadro1(30,11,56,14,15+blink);
                      Textcolor(15);
                      Gotoxy(40,12);
                      Write('AVISO');
                      Gotoxy(32,13);
                      Write('A *COTAÄéO* Ç em contos');
                      Gotoxy(39,23);
                      Textcolor(7);
                      Delay(5000);
                      Memoria('l','f');
                    End;

            Ch:=' ';
            Gotoxy(69,16);
          Repeat

          Repeat
            Rand:= Random(65000)+1;
            Rand1:= Random(30000)+1;
            If (Rand1<> 20093) Then Rand:= Rand* -1;
            If (Rand= Loopjogada) or (Prim= True)
            Then
                      Begin
                        prim:= false;
                        Memoria('g','a');
                        Rand:= Random(55)+3;
                        Rand1:= Random(18)+3;
                        Quadro(Rand,Rand1,Rand+19,Rand1+3,5);
                        Quadro2(Rand,Rand1,Rand+19,Rand1+3,0);
                        Gotoxy(Rand+2,Rand1+1);
                        Write('   BOL$A v',versao:1:1);
                        Gotoxy(Rand+1,Rand1+2);
                        Write('   Spooler');
                        {nf}
                        gotoxy(wherex,wherey);
                        write(' 19');
                        write('9');
                        gotoxy(wherex,wherey);
                        write('4');
                        Delay(8000);
                        Memoria('l','f');
                        Gotoxy(69,16);
                      End;

            Until Keypressed;


            { MENù }

            Ch:= Readkey;
            If Ch=#0 Then Begin
                          Ch:= Readkey;
                          If Ch=#80 Then Ch:=' ';
                          End
            Else Ch:= Upcase(Ch);
          Until (Ch='C') Or (Ch='V') Or (Ch='P') Or
                (Ch='E') Or (Ch=#59) Or (Ch=#60) Or (Ch=#61);

          Sound(1600);
          Delay(20);
          Nosound;
          Case Ch Of
               'C': Comprar; { Comprar acáîes. }
               'V': Vender;  { Vender acáîes. }
               'P': begin
                    Passar;  { Passar a jogada. }
                    prim1:= true;
                    end;
               'E': begin
                    if loopjogada<> 0 then
                    evolucao; { EvoluáÑo do jogo. }
                    end;
               #59: Listar;  { Lista as empresas. }
               #60: Suspender; { Suspende o jogo. }
               #61: Terminar(Jogador[LoopJogador]); { Termina o jogo!!! }
              End; { do case }

      Until Ch='P';

       { Foi passada a jogada. }

        Window(1,1,80,25);
         Textcolor(0);
         Textbackground(3);
         For Loop:= 1 To 10 Do
                    Begin
                      Gotoxy(56,4+Loop);
                      Write(VariacaoS[loop]);
                    End;
         Window(13,5,52,14);
         Textbackground(2);
         textcolor(0);
        Clrscr;
        Window(1,1,80,25);
                     For Loop:= 1 To 10 Do
                        Begin
                          Gotoxy(13,4+LOop);
                          Write('........................................');
                        End;

        For lOop:= 1 To 10 Do
              Begin
                    Grafico:= (P_Accoes[Loop] / 1000)*2;
                    For Loop1:= 1 To Trunc(Grafico) Do
                      Begin
                         Gotoxy(12+Loop1 ,4+Loop);
                         Write(#254);
                      End;
               End;
        End; { do Loopjogador }




      End; { do LoopJogada }

      textbackground(0);
      getmem(ponto,160);
      getmem(ponto1,160);
       for yponto:= 1 to 24 do
        begin
          if lo(lastmode)= 7 then
               begin
                    move(ptr($B000,1+  (160*(yponto-1)))^,ponto^,160);
                    move(ptr($B000,1+  (160*(yponto)))^,ponto1^,160);
               end
    else
       begin
      move(ptr($B800,1+ (160*(yponto-1)))^,ponto^,160);
      move(ptr($B800, 1+(160*(yponto)))^,ponto1^,160);
      end;


  gotoxy(1,yponto);
  clreol;
  for loop:= yponto+1 to 25 do
      begin
         if loop + 1<= 25 then
            begin
              if lo(lastmode)= 7 then
                begin
                move(ptr($B000,1+  (160*(loop-1)))^,ponto1^,160);
                move(ponto^,ptr($B000, 1+ (160*(loop-1)))^,160);
                delay(50);
                move(ponto1^,ptr($B000, 1+(160*(loop-1)))^,160);
                end
                   else
                   begin
                 move(ptr($B800,  1+ (160*(loop-1)))^,ponto1^,160);
                 move(ponto^,ptr($B800, 1+(160 * (loop-1)))^,160);
                 delay(50);
                 move(ponto1^,ptr($B800, 1+(160*(loop-1)))^,160);
                 end;
            end;


      end;
   end;
  freemem(ponto,160);
  freemem(ponto1,160);
  gotoxy(1,25);
  clreol;




  { ************** ORDENAR OS JOGADORES *************}
  for loop:= 1 to njogadores do
      bens[loop]:= 0;
  for loop:= 1 to njogadores do
  begin
     bens[loop]:= saldo[loop];
           for loop1:= 1 to 10 do
               begin
                 if n_accoes_j[loop,loop1] <> 0 then
                    bens[loop]:= bens[loop] + n_accoes_j[loop,loop1]* p_accoes[loop1];
               end;
  end;
  for loop:= 1 to njogadores do
      melhorj[loop]:= loop;

  loop:= 1;
  repeat
    loop1:= loop+1;
    repeat
      if bens[melhorj[loop1]] > bens[melhorj[loop]] then
         begin
           mj:= melhorj[loop];
           melhorj[loop]:= melhorj[loop1];
           melhorj[loop1]:= mj;
           loop:= 1;
           loop1:= -1;
         end
        else
            loop1:= loop1+1;
    until (loop1>= njogadores) or (loop1= -1);
   if (loop1<> -1 ) then
      loop:= loop +1;
  until (loop>= njogadores);

  textbackground(7);
  quadro2(10,5,30,15,0);
  window(11,8,29,14);
  clrscr;
  window(1,1,80,25);
  gotoxy(11,6);
  write(' Jornal Financeiro ');
  gotoxy(10,7);
  write('√ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥');
  textcolor(3);
  textbackground(0);
  for loop:= 6 to 15 do
      begin
        gotoxy(31,loop);
        write('≤≤');
      end;
  gotoxy(12,16);
  write('≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤');
  gotoxy(18,10);
  textbackground(7);
  textcolor(0);
  write('$');
  gotoxy(12,13);
  write(' $           $');
  gotoxy(12,14);
  write('       $$');
  gotoxy(12,8);
  write('BOL$A');
  gotoxy(12,9);
  textcolor(0+blink);
  write('Melhor jogador:');
  textcolor(0);
  gotoxy(14, 11);
  textcolor(14);
  write(jogador[melhorj[1]]);
  gotoxy(14,12);
  write(bens[melhorj[1]]:10,'$00');
  textcolor(7);
  textbackground(0);
  gotoxy(40,2);
  write('Restantes jogadores ...');
  gotoxy(40,4);
  write('Pos Nome       Valor dos Bens');
   for loop:= 2 to njogadores do
      begin
        gotoxy(40,4+loop);
        writeln(loop:3,' ',jogador[melhorj[loop]]);
        gotoxy(54,4+loop);
        write(bens[melhorj[loop]]:10,'$00');

      end;



  gotoxy(65,25);
  write('QQ tecla...');
  ch:= readkey;

  gotoxy(1,25);
  clreol;
  gotoxy(40,25);
       top;
       textcolor(0);
       textbackground(3);
       assign(fich,'BOLSA.TOP');
       {$I-}
       reset(fich);
       {$I+}
       if ioresult<> 0 then
                     begin
                       gotoxy(36,5);
                       write('BOL$A - TOP 10');
                       {$I-}
                       rewrite(fich);
                       {$I+}
                       if ioresult= 0 then
                       begin
                       for loop:= 1 to njogadores do
                           begin
                             if loop<= 10 then
                             begin
                             ficha[loop].nome:=jogador[melhorj[loop]];
                             ficha[loop].bens:=bens[melhorj[loop]];
                             write(fich,ficha[loop]);
                             gotoxy(28,8+loop);
                             write(jogador[melhorj[loop]]:10,'  ',bens[melhorj[loop]]:10,'$00');
                             end;

                           end;
                           close(fich);
                       end;
                     end
                 else
                     begin
                      loop4:= 1;
                      read(fich,ficha[loop4]);
                      while not(eof(fich)) do
                      begin
                       loop4:= loop4+1;
                       read(fich,ficha[loop4]);
                       
                      end;
                      {loop4:= loop4-1;}
                      close(fich);

                      for loop1:= njogadores + 1 to njogadores+ loop4 do
                      begin
                            bens[loop1]:= ficha[loop1- njogadores].bens;
                            jogador[loop1]:= ficha[loop1- njogadores].nome;
                          end;
                         for loop:= 1 to njogadores+loop4 do
                             melhorj[loop]:= loop;

  loop:= 1;
  repeat
    loop1:= loop+1;
    repeat
      if bens[melhorj[loop1]] > bens[melhorj[loop]] then
         begin
           mj:= melhorj[loop];
           melhorj[loop]:= melhorj[loop1];
           melhorj[loop1]:= mj;
           loop:= 1;
           loop1:= -1;
         end
        else
            loop1:= loop1+1;
    until (loop1>= njogadores+loop4) or (loop1= -1);
   if (loop1<> -1 ) then
      loop:= loop +1;
  until (loop>= njogadores+loop4);
                      gotoxy(35,5);
                      write('BOL$A- TOP 10');
                      for loop1:= 1 to njogadores+loop4 do
                          begin
                           if loop1<= 10 then
                           begin
                            gotoxy(28,8+loop1);
                            writeln(jogador[melhorj[loop1]]:10,'  ',bens[melhorj[loop1]]:10,'$00');
                            end;
                          end;
                      {$I-}
                      rewrite(fich);
                      {$I+}
                      if ioresult= 0 then
                      begin
                      for loop:= 1 to njogadores+loop4 do
                          begin
                          if loop<= 10 then
                          begin
                            ficha[loop].nome:= jogador[melhorj[loop]];
                            ficha[loop].bens:= bens[melhorj[loop]];
                            write(fich,ficha[loop]);
                            end;
                          end;
                      close(fich);
                      end
                      else
                          begin
                           writeln('Disquete protegida contra escrita !!');
                          end;

                     end;
       gotoxy(50,22);
       write('QQ tecla...');
       ch:= readkey;

  textbackground(0);
  textcolor(7);
  clrscr;

  quadro3(1,1,80,24,7);
  delay(150);
  quadro3(1,1,80,24 ,0);

  quadro3(5,2,75,24,7);
  delay(150);
  quadro3(5,2,75,24 ,0);

  quadro3(10,3,70,22 ,7);
  delay(150);
  quadro3(10,3,70,22 ,0);

  quadro3(15,4,65,21 ,7);
  delay(150);
  quadro3(15,4,65,21 ,0);

  quadro3(20,6,60,19 ,7);
  delay(150);
  quadro3(20,6,60,19 ,0);

  quadro3(25,7,55,18 ,7);
  delay(150);
  quadro3(25,7,55,18 ,0);

  quadro3(30,9,50,16 ,7);
  delay(150);
  quadro3(30,9,50,16 ,0);

  quadro3(35,13,45,14 ,7);
  delay(150);
  quadro3(35,13,45,14 ,0);
  delay(150);
  textcolor(7);
  textbackground(0);
  clrscr;

       textcolor(14);
       textbackground(4);
       gotoxy(1,1);
       write(' NF ');
       textcolor(7);
       textbackground(0);
       writeln('  ');
       writeln;
       halt;
End; { do procedimento jogar }


End. { da Unit Jogo }


