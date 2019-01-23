Program Imagem;           {Ä->  Este utilit rio visa proteger o monitor.  <Ä-}
Uses Crt,Dos;

Var Cr,T,L,P:Integer;                      {Ä->  Defini‡„o de vari veis.  <Ä-}
    R:Registers;
    Op:String;

Procedure Escrever(Cr:Integer); {Ä->    Coloca-se na coluna 1 da linha L  <Ä-}
Begin                           {Ä->  e escreve uma linha no ecr„.        <Ä-}
     R.Ah:=02;
     R.Dh:=L-1;
     R.Dl:=0;
     R.Bh:=0;
     Intr($10,R);
     Textcolor(Cr);
     Writeln('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ')
End;

Procedure Ajuda;       {Ä->  Apresenta um quadro de ajuda ao utilizador.  <Ä-}
Begin
     Writeln('Este utilit rio mostra uma linha horizontal em movimento na vertical.           ');
     Writeln('Modo de utiliza‡„o: Imagem N [/?]');
     Writeln;
     Writeln('                    N -> Torna o movimento da linha mais r pido ou mais lento.  '+
             '                         O valor vai de 0 (mais r pido) at‚ 9 (mais lento).     '+
             '                         Inicialmente, N ‚ igual a 4 (valor por defeito);');
     Writeln('                    /? -> Apresenta este mesmo ecr„ de ajuda.');
     Halt
End;

Begin
     Writeln('Imagem 1.01 -  (c), 1993  Ant¢nio Jos‚ Monteiro Pereira');
     P:=Paramcount;
     Op:=Paramstr(1);
     If (P=1) And (Op='/?') Then Ajuda;
     If (P=1) And ((Op>='0') And (Op<='9')) Then Val(Op,T,L)
     Else If P=0 Then T:=4
     Else
     Begin
          Writeln('Modo de utiliza‡„o errado. Imagem/? para poder ser ajudado.');
          Halt
     End;
     Delay(500);
     Cr:=1;
     L:=1;
     Inc(T);
     T:=T*25;
     R.Ah:=01;
     R.Ch:=40;                                   {Ä->  Desliga o cursor.  <Ä-}
     R.Cl:=0;
     Intr($10,R);
     Repeat
           Escrever(Cr);
           Delay(T);
           Escrever(0);    {Ä->  Movimento vertical da linha horizontal.  <Ä-}
           Inc(Cr);
           Inc(L);
           If Cr=16 Then Cr:=1;
           If L=26 Then L:=1
     Until Keypressed;      {Ä->  Repete at‚ que seja premida uma tecla.  <Ä-}
     Textcolor(7);
     Clrscr;
     R.Ah:=01;                                      {Ä->  Liga o cursor.  <Ä-}
     R.Ch:=3;
     R.Cl:=4;
     Intr($10,R)
End.
