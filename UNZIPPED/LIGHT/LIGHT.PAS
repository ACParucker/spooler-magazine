{
旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
�                                                                         �
�                   LIGHTSPEED   (c) Radioactive Design                   �
�                                                                         �
� Programado por Pedro Cardoso                 Musica por Silverio Freire �
�                                                                         �
쳐컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
� Quem estiver interessado em escrever-me, a minha morada �:              �
�                                                                         �
� Pedro Cardoso                                                           �
� Rua Ant줻io Sardinha, 43                                                �
� Gafanha da Nazar�                                                       �
� 3830 Ilhavo                                                             �
�                                                                         �
� Como este programa n꼘 foi testado intensivamente, � muito poss죞el que �
� encontre alguns bugs. Se assim for, escreva-me.                         �
읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
}
PROGRAM LIGHT_SPEED;
                 
{$M 2048, 100000, 110000}

USES DOS,CRT,GRAPH,GOLDPLAY;

VAR
X1,Y1,X2,Y2,RAIO,X,Y                                 :INTEGER;
GD,GM                                                :INTEGER;
r                                                    :registers;
LEFT1,RIGHT1,UP1,DOWN1                               :BOOLEAN;
LEFT2,RIGHT2,UP2,DOWN2                               :BOOLEAN;
THE_END                                              :BOOLEAN;
OLDINT                                               :POINTER;
DIR1,DIR2,N                                          :INTEGER;
XLINE,YLINE                                          :INTEGER;
NUM_DE_VEZES                                         :INTEGER;
DIE                                                  :BOOLEAN;
FACTOR                                               :INTEGER;
WIN1,WIN2                                            :INTEGER;
STOP                                                 :BOOLEAN;
ANSWER                                               :STRING;
space,nao,mais,menos,enter                           :boolean;
quer_musica                                          :boolean;
v                                                    :char;

{袴袴袴袴袴袴袴袴袴袴袴袴 PROCEDIMENTOS 袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴}


    procedure Cursor(On:boolean);
    {liga/desliga o Cursor}
    begin
    if On then
    begin
    r.ah:=01;
    r.ch:=3;
    r.cl:=4;
    intr($10,r);
    end
    else
    begin
    r.ah:=01;
    r.ch:=40;
    r.cl:=0;
    intr($10,r);
    end;
    end;


PROCEDURE QUIT;
    BEGIN
    if quer_musica then begin
                   stopplaying;
                   dealloc;
                   removeovl;
                   end;

    setintvec($09,oldint);
    CLOSEGRAPH;
    cursor(true);
    textcolor(7);
    clrscr;
    writeln('Light Speed por Radioactive Design.');
    HALT(0);
    END;



    procedure keyboardH; interrupt;
    var tecla:byte;
    begin
      asm
        in  al,60h
        mov tecla,al
        in  al,61h      
        or  al,80h      
        out 61h,al
        and al,7fh      
        out 61h,al
        mov al,20h      
        out 20h,al
      end;
{
      DIR
      X=1 == UP
      X=2 == LEFT
      X=3 == RIGHT
      X=4 == DOWN
}
        IF TECLA=$1 THEN the_end:=true;                 { ESCAPE }
        if tecla=$39 then space:=true;                  { SPACE }
        if tecla=$4e then mais:=true;                   { + }
        if tecla=$4a then menos:=true;                  { - }
        if tecla=$1c then enter:=true;                  { enter }
        if tecla=$31 then nao:=true;                    { nao }


        IF ((TECLA=$4B) AND (DIR1<>3)) THEN DIR1:=2;
        IF ((TECLA=$4D) AND (DIR1<>2)) THEN DIR1:=3;
        IF ((TECLA=$48) AND (DIR1<>4)) THEN DIR1:=1;
        IF ((TECLA=$50) AND (DIR1<>1)) THEN DIR1:=4;

    {\\\\ TECLAS DO SEGUNDO JOGADOR \\\\\}

        IF ((TECLA=$11) AND (DIR2<>4)) THEN DIR2:=1;
        IF ((TECLA=$1F) AND (DIR2<>1)) THEN DIR2:=4;
        IF ((TECLA=$20) AND (DIR2<>2)) THEN DIR2:=3;
        IF ((TECLA=$1E) AND (DIR2<>3)) THEN DIR2:=2;
        end;




    procedure init2;
    begin
    UP1:=FALSE;
    DOWN1:=FALSE;
    RIGHT1:=FALSE;
    LEFT1:=FALSE;
    UP2:=FALSE;
    DOWN2:=FALSE;
    RIGHT2:=FALSE;
    LEFT2:=FALSE;
    THE_END:=FALSE;
    X1:=145;
    Y1:=145;
    X2:=495;
    Y2:=335;
    DIR1:=0;
    DIR2:=0;
    end;


    PROCEDURE INICIALIZA;
    bEGIN
    closegraph;
    NUM_DE_VEZES:=0;
    WIN1:=0;
    WIN2:=0;
    ENTER:=FALSE;
    MAIS:=FALSE;
    MENOS:=FALSE;
    factor:=3;          { default }
    TEXTCOLOR(LIGHTRED);
    CLRSCR;
    GOTOXY(0,0);
    TEXTCOLOR(1);
    WRITELN(' �                                       旼컴커                          (TM)');
    TEXTCOLOR(9);
    WRITELN(' �                         컴탠컴        �');
    TEXTCOLOR(3);
    WRITELN(' �       o  旼컴커  �    �   �           �       旼컴커 旼컴커 旼컴커       �');
    TEXTCOLOR(green);
    WRITELN(' �       �  �       �    �   �           읕컴커  �    � �      �            �');
    TEXTCOLOR(yeLLOW);
    WRITELN(' �       �  �  旼�  쳐컴캑   �                �  쳐컴켸 쳐�    쳐�     旼컴캑');
    TEXTCOLOR(12);
    WRITELN(' �       �  �    �  �    �   �                �  �      �      �       �    �');
    TEXTCOLOR(4);
    WRITELN(' 읕컴켸  �  읕컴켸  �    �   읕�--       읕컴켸  �      읕컴켸 읕컴켸  읕컴컨');
    TEXTCOLOR(YELLOW);
    WRITELN('-------------------------------------------------------------------------------');
    WRITELN('');
    WRITELN('');
    WRITELN('');
    WRITELN('');
    WRITELN('');
    TEXTCOLOR(YELLOW);
    TEXTCOLOR(9);
    WRITELN('� Qual o factor de atraso ?  ( Use +/- ) : ');
    WRITELN('NOTA: Valores baixos aceleram e valores altos abrandam o jogo. Recomendado = � 3');
    WRITELN('    ');
    TEXTCOLOR(5);
    WRITELN('Teclas:');
    WRITELN('');
    WRITELN('� Jogador 1 ( Amarelo  ):    = Cima ;   = Baixo ;  = Esquerda ;  = Direita ');
    WRITELN('� Jogador 2 ( Vermelho ):   W = Cima ;  S = Baixo ; A = Esquerda ; D = Direita ');
    WRITELN('');
    TEXTCOLOR(8);
    gotoxy(0,25);
    WRITELN('  컴袴袴袴袴袴袴攷[[[        (C) Radioactive Design        ]]]勁袴袴袴袴袴袴컴  ');
    GOTOXY(43,14);
    TEXTCOLOR(GREEN);
    cursor(false);
    REPEAT
    SETINTVEC($09,ADDR(keyboardH));
    IF MAIS THEN inc(FACTOR);
    IF MENOS THEN dec(FACTOR);
    IF FACTOR<0 THEN FACTOR:=0;
    IF FACTOR>30 THEN FACTOR:=30;
    GOTOXY(43,14);
    WRITE(FACTOR,'');
    MAIS:=FALSE;
    MENOS:=FALSE;
    UNTIL ENTER;

    GD:=9;
    GM:=2;
    INITGRAPH(GD,GM,'');
    END;



    PROCEDURE ECRAN;            { DESENHA ECRAN COM LINHAS }
    BEGIN
    YLINE:=0;
    XLINE:=0;
    SETBKCOLOR(BLUE);
    CLEARVIEWPORT;
    SETCOLOR(LIGHTBLUE);
    REPEAT
    XLINE:=XLINE+40;
    LINE(XLINE,0,XLINE,480);
    UNTIL XLINE=640;
    REPEAT
    YLINE:=YLINE+40;
    LINE(0,YLINE,640,YLINE);
    UNTIL YLINE=480;
    SETCOLOR(WHITE);
    LINE(0,0,0,479);
    LINE(0,0,640,0);
    LINE(639,0,639,479);
    LINE(0,479,640,479);
    END;





    PROCEDURE EXPLOSAO;
    BEGIN
    RAIO:=0;
    REPEAT
    SETCOLOR(red);
    CIRCLE(X,Y,RAIO);
    RAIO:=RAIO+1;
    UNTIL RAIO=100;
    REPEAT
    SETCOLOR(BLUE);
    CIRCLE(X,Y,RAIO);
    RAIO:=RAIO-1;
    UNTIL RAIO=0;
    REPEAT
    SETCOLOR(DARKGRAY);
    CIRCLE(X,Y,RAIO);
    RAIO:=RAIO+1;
    UNTIL RAIO=18;
    DELAY(factor*100);
    REPEAT
    SETCOLOR(BLUE);
    CIRCLE(X,Y,RAIO);
    RAIO:=RAIO-1;
    UNTIL RAIO=0;
    END;



               PROCEDURE DIE1;
               BEGIN
               space:=false;
               X:=X1;
               Y:=Y1;
               EXPLOSAO;
               SETCOLOR(LightMagenta);
               SETTEXTSTYLE(TRIPLEXFONT,HORIZDIR,2);
               OUTTEXTXY(Succ(GetMaxX) div 2,230,'Morreu o jogador amarelo.');
               setcolor(white);
               SETTEXTSTYLE(smallFONT,HORIZDIR,10);
               OUTTEXTXY(Succ(GetMaxX) div 2,400,' Prima SPACE para continuar');
               REPEAT
               UNTIL space;
               CLEARVIEWPORT;
               ECRAN;
               NUM_DE_VEZES:=NUM_DE_VEZES+1;
               DIE:=TRUE;
               WIN1:=WIN1+1;
               init2;
               END;



               PROCEDURE DIE2;
               BEGIN
               space:=false;
               X:=X2;
               Y:=Y2;
               EXPLOSAO;
               SETCOLOR(LightMagenta);
               SETTEXTSTYLE(TRIPLEXFONT,HORIZDIR,2);
               OUTTEXTXY(Succ(GetMaxX) div 2,230,'Morreu o jogador vermelho.');
               setcolor(white);
               SETTEXTSTYLE(smallFONT,HORIZDIR,10);
               OUTTEXTXY(Succ(GetMaxX) div 2,400,' Prima SPACE para continuar');
               REPEAT
               UNTIL space;
               CLEARVIEWPORT;
               ECRAN;
               NUM_DE_VEZES:=NUM_DE_VEZES+1;
               WIN2:=WIN2+1;
               DIE:=TRUE;
               init2;
               END;




LABEL 1,2,3;
{--------------------------- BLOCO PRINCIPAL ---------------------------}
BEGIN

Getintvec($09,oldint);

cursor(false);
{[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[  SB STUFF ]]]]]]]]]]]]]]]]]]]]]]]]]]]]}
TEXTCOLOR(14);
WRITELN('Quer m즧ica ? (S/N)');
textcolor(0);

if upcase(readkey)='S' then quer_musica:=true;
if upcase(readkey)='N' then quer_musica:=false;



        if quer_musica then begin
                       loadovl('goldplay.ovl');
                       TEXTCOLOR(9);
                       WRITELN('Escolha o dispositivo de som.                          (C) Radioactive Design');
                       TEXTCOLOR(white);
                       askinit;
                       initialize;
                       loadmodule('lightspd.mod');
                       startplaying;
                       goto 1;
                       end;

1:INICIALIZA;

settextjustify(centertext,centertext);

UP1:=FALSE;
DOWN1:=FALSE;
RIGHT1:=FALSE;
LEFT1:=FALSE;
UP2:=FALSE;
DOWN2:=FALSE;
RIGHT2:=FALSE;
LEFT2:=FALSE;
THE_END:=FALSE;
X1:=145;
Y1:=145;
X2:=495;
Y2:=335;
DIR1:=0;
DIR2:=0;
XLINE:=0;
YLINE:=0;
ECRAN;

BEGIN

REPEAT
SETINTVEC($09,ADDR(keyboardH));
{ XXXXXXXXXXXXXXXXXXXXX PRIMEIRO JOGADOR XXXXXXXXXXXXXXXXXXXXXXXXXX}
IF (DIR1=1) AND ((GETPIXEL(X1,Y1-1)=12) OR (GETPIXEL(X1,Y1-1)=14)) THEN DIE1;
IF (DIR1=2) AND ((GETPIXEL(X1-1,Y1)=12) OR (GETPIXEL(X1-1,Y1)=14)) THEN DIE1;
IF (DIR1=3) AND ((GETPIXEL(X1+1,Y1)=12) OR (GETPIXEL(X1+1,Y1)=14)) THEN DIE1;
IF (DIR1=4) AND ((GETPIXEL(X1,Y1+1)=12) OR (GETPIXEL(X1,Y1+1)=14)) THEN DIE1;
IF (DIR1=5) AND ((GETPIXEL(X1-1,Y1-1)=12) OR (GETPIXEL(X1-1,Y1-1)=14)) THEN DIE1;
IF (X1<2) OR (X1>639) OR (Y1<2) OR (Y1>479) THEN DIE1;
IF DIR1=1 THEN Y1:=Y1-1;
IF DIR1=2 THEN X1:=X1-1;
IF DIR1=3 THEN X1:=X1+1;
IF DIR1=4 THEN Y1:=Y1+1;
{ XXXXXXXXXXXXXXXXXXXXX SEGUNDO JOGADOR XXXXXXXXXXXXXXXXXXXXXXXXX}
IF (DIR2=1) AND ((GETPIXEL(X2,Y2-1)=12) OR (GETPIXEL(X2,Y2-1)=14))  THEN DIE2;
IF (DIR2=2) AND ((GETPIXEL(X2-1,Y2)=12) OR (GETPIXEL(X2-1,Y2)=14))  THEN DIE2;
IF (DIR2=3) AND ((GETPIXEL(X2+1,Y2)=12) OR (GETPIXEL(X2+1,Y2)=14))  THEN DIE2;
IF (DIR2=4) AND ((GETPIXEL(X2,Y2+1)=12) OR (GETPIXEL(X2,Y2+1)=14))  THEN DIE2;
IF (X2<2) OR (X2>639) OR (Y2<2) OR (Y2>479) THEN DIE2;
IF DIR2=1 THEN Y2:=Y2-1;
IF DIR2=2 THEN X2:=X2-1;
IF DIR2=3 THEN X2:=X2+1;
IF DIR2=4 THEN Y2:=Y2+1;

PUTPIXEL(X1,Y1,14);
PUTPIXEL(X2,Y2,12);

DELAY(FACTOR);
UNTIL ((NUM_DE_VEZES=5) or the_end);
END;

{ Diz o vencedor ; }

         BEGIN
         settextstyle(smallfont,horizdir,8);
         IF WIN1<WIN2 THEN OUTTEXTXY(Succ(GetMaxX) div 2,220,' Ganhou o jogador 1! (amarelo)');
         IF WIN1>WIN2 THEN OUTTEXTXY(Succ(GetMaxX) div 2,220,' Ganhou o jogador 2! (vermelho)');
         IF WIN1=WIN2 THEN OUTTEXTXY(Succ(GetMaxX) div 2,220,' Empate. Ganhei eu !!! (CPU)');

         delay(1000);

         end;




CLEARDEVICE;
ECRAN;
settextstyle(gothicfont,horizdir,5);
OUTTEXTXY(Succ(GetMaxX) div 2,240,' Jogar outra vez ? (S/N)');

nao:=false;

3:repeat
SETINTVEC($09,ADDR(keyboardH));
if dir2=4 then goto 1;
if nao then goto 2;
until ((dir2=2) or (nao));


2:quit;


END.



