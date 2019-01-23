'*****************************************************************************
'*                      Fun‡„o de controlo de Inputs                         *
'*****************************************************************************
sub controlo.input (linha,colinicial,colfinal,pc,cad$)

     shared w$
     local c

     c=COLINICIAL+pc
     if c>=colfinal then c=colfinal
     w$=cad$

     LOCATE LINHA,c:PRINT "_ "

     DO
         DO
             TECLA$=INKEY$
         LOOP WHILE TECLA$="" or TECLA$=CHR$(9)

         A=ASC(TECLA$)

         IF TECLA$=CHR$(0)+"M" THEN TECLA$=" "

         IF A=8 OR TECLA$=CHR$(0)+"K" THEN
            IF c=COLINICIAL THEN EXIT IF
            c=c-1
            LOCATE LINHA,c:PRINT "_  "
            W$=LEFT$(W$,c-COLINICIAL)
         ELSEIF A=13 THEN
            LOCATE LINHA,COLINICIAL+LEN (LEFT$ (W$,COLFINAL-COLINICIAL))
            PRINT SPACE$(2)
            exit sub
         ELSE
            IF c=COLFINAL THEN EXIT IF
            W$=W$+TECLA$
            LOCATE LINHA,c:PRINT TECLA$;"_"
            c=c+1
         END IF

     LOOP

end sub
'*****************************************************************************
'*                 Introduzir Password - Acesso ao sistema                   *
'*****************************************************************************
sub password.acesso (s$)

     pass$=s$
     shared z$,acesso
     local d

     z$=""
     acesso=0

     call apaga.jtrab (.003,10)

     color 0,3:call janela.sombra (6,25,30,7)

     LOCATE 8,30:PRINT "Introduza Password:"

     call password (10,19)

     z$=z$+SPACE$(12-LEN (z$))

     IF z$=pass$ THEN
        COLOR 23,4:LOCATE 12,31:PRINT " Acesso Concedido "
        DELAY (1)
        acesso=1
     else
        COLOR 23,4:LOCATE 12,33:PRINT " Acesso Negado "
        delay (2.5)
        acesso=0
     end if


     call apagar.caixa (6,25,30,8)

end sub

'*****************************************************************************
'*                       SUB-ROTINA-INTRODUZA PASSWORD                       *
'*****************************************************************************
sub password (lin,col)

     FOR I=10 TO 32 STEP 2
       color 4,7:LOCATE LIN,COL+I:PRINT CHR$ (176)
     NEXT

     shared z$
     local d
     z$=""


     DO

         DO
             TECLA$=INKEY$
         LOOP WHILE (TECLA$="" OR TECLA$=CHR$(0)+"H" OR TECLA$=CHR$(0)+"P")

         A=ASC (TECLA$)

         IF A=13 THEN
            exit sub
         ELSEIF A=8 OR TECLA$=CHR$(0)+"K" THEN
            IF D=0 THEN EXIT IF
            z$=LEFT$ (z$,D-1)
            D=D-1
            COLOR 4,7:LOCATE LIN,COL+10+(D*2):PRINT CHR$(176)
         ELSEIF D=12 THEN
            EXIT IF
         else
            z$=z$+TECLA$
            D=D+1
            LOCATE LIN,COL+8+(D*2):COLOR 7,4:PRINT SPACE$(1)
         END IF

     LOOP

end sub
'*****************************************************************************
'*                          Encripta Password                                *
'*****************************************************************************
sub encripta (p$)

      shared z$

      z$=p$

      z$=z$+space$(12-len (z$))

      FOR GH=1 TO 12
      IF GH MOD 2=0 THEN
         MID$(z$,GH,GH)=CHR$((ASC(MID$(z$,GH,GH))+GH*2))
      ELSE
         MID$(z$,GH,GH)=CHR$((ASC(MID$(z$,GH,GH))+GH*3))
      END IF
      NEXT

end sub
'*****************************************************************************
'*                         Desencripta Password                              *
'*****************************************************************************
sub desencripta (p$)

      shared z$

      z$=p$

      FOR GH=1 TO 12
      IF GH MOD 2=0 THEN
         MID$(z$,GH,GH)=CHR$((ASC(MID$(z$,GH,GH))-GH*2))
      ELSE
         MID$(z$,GH,GH)=CHR$((ASC(MID$(z$,GH,GH))-GH*3))
      END IF
      NEXT

end sub
'******************************************************************************
'*      Fun‡„o de Menus Complexos-Barra Oscilante-Scrool das op‡”es-Mouse     *
'******************************************************************************
sub barra (p2,l,l2,c,c2,intopc,intopc2,totopc,totopc2,totmat,menudown,flagficha,fl,a$(1),a2$(1))

      shared p,pm,pr,consultar,x,y,mouse

      pm=1
      mouse=0
      if consultar=0 then P=1

      DO
          call posicao.mouse
          TECLA$=INKEY$
          color 0,3

          IF TECLA$=CHR$ (0)+"H" or ((pr=1 and menudown=1) and (y>(l-2)*8 and y<(l+totopc-1)*8) and (x>(c-2)*8 and x<((c-1)+len (a$(1)))*8)) THEN
             call barra.cima (p,pm,+l,+c,+intopc,+totopc,+totmat,+menudown,fl,a$())
          ELSEIF TECLA$=CHR$ (0)+"P" THEN
             call barra.baixo (p,pm,+l,+c,+intopc,+totopc,+totmat,+menudown,fl,a$())
          ELSEIF TECLA$=CHR$ (0)+"G" and menudown=1 THEN
             call imp.ver (p,pm,+l,+c,+intopc,a$())
             pm=1:p=1
             call scrool.cima (+pm,+l,+c,+intopc,+totopc,a$())
          ELSEIF TECLA$=CHR$ (0)+"O" and menudown=1 THEN
             call imp.ver (p,pm,l,c,intopc,a$())
             pm=totmat:p=totopc
             call scrool.baixo (pm,l,c,intopc,totopc,a$())
          ELSEIF TECLA$=CHR$ (0)+"I" and menudown=1 THEN
             call barra.cima (p,pm,l,c,intopc,totopc,totmat,+menudown,2,a$())
          ELSEIF TECLA$=CHR$ (0)+"Q" THEN
             call barra.baixo (p,pm,l,c,intopc,totopc,totmat,+menudown,2,a$())
          ELSEIF pr=1 and x=440 and fl=1 and menudown=1 and (y>63 and y<105) THEN
             call barra.cima (p,pm,l,c,intopc,totopc,totmat,+menudown,1,a$())
          ELSEIF pr=1 and x=440 and fl=1 and menudown=1 and (y>109 and y<153) THEN
             call barra.baixo (p,pm,l,c,intopc,totopc,totmat,+menudown,1,a$())
          ELSEIF TECLA$=CHR$ (0)+"K" or (pr=1 and y=8 and ((x>39 and x<129) or (x>135 and x<201) or (x>231 and x<313) or (x>327 and x <385) or (x>423 and x<513) or (x>527 and x<593))) THEN
             call barra.esquerda (p2,+l2,+c2,+intopc2,+totopc,+totopc2,+menudown,flagficha,a2$())
          ELSEIF TECLA$=CHR$ (0)+"M" THEN
             call barra.direita  (p2,+l2,+c2,+intopc2,+totopc,+totopc2,+menudown,flagficha,a2$())
          ELSEIF TECLA$=CHR$(13) or mouse=1 THEN
             if fl=1 or fl=2 then p=pm
             exit sub
          ELSEIF (TECLA$=CHR$(27) or pr=2 or (pr=1 and ((x<(c-2)*8 or y>1) and (x>(c+len (a$(1)))*8 or y>1)))) and flagficha<>1 THEN
             call apaga.jtrab(0,totopc+3)
             menudown=0
             GOTO 130
          END IF
      LOOP

end sub

'********** Barra p/ cima *************
sub barra.cima (p,pm,l,c,intopc,totopc,totmat,menudown,fl,a$(1))

      shared pr,x,y,mouse,opc2

      mouse=0

      IF MENUDOWN=0 THEN
         exit sub
      end if

      if fl=2 then
         p=p-totopc
         pm=pm-totopc
         if pm<1 then p=0:pm=1
         exit if
      else
         if pr=1 and x<>440 then                      'Menu normal-selec‡„o
            pp=p				      '      pelo mouse	
            call imp.ver (+p,+p,+l,+c,+intopc,a$())
            call coordenadas (1)
            mouse=1
            if fl=1 then
               pm=pm-pp+p
            else
               pm=p
            end if
         else
            if fl=0 and pr<>1 then 			'Menu normal-selec‡„o
               call imp.ver (+p,+p,+l,+c,+intopc,a$())  '     por teclas
               p=p-1
               if p<1 then p=totopc
               color 3,0
               call imp.ver (+p,+p,+l,+c,+intopc,a$())
               exit sub
            elseif fl=1 and pr=0 then           	'Menu com scrool-selec.
               call imp.ver (+p,+pm,+l,+c,+intopc,a$()) '      por teclas
               p=p-1:pm=pm-1
               if pm<1 then pm=1:p=0
            elseif fl=1 and x=440 and pr=1 then         'Menu com scrool-selec.
               call imp.ver (+p,+pm,+l,+c,+intopc,a$()) '       pelo mouse
               pp=p
               opc2=4
               call coordenadas (1)
               pm=pm-pp+p:opc2=2
               if pm<1 then pm=1:p=0
               mouse=0
            end if
         end if
      end if

      if p<1 then
         p=1
         call scrool.cima (+pm,+l,+c,+intopc,+totopc,a$())
         exit sub
      else
         color 3,0
         call imp.ver (+p,+pm,+l,+c,+intopc,a$())
      end if

end sub
'********** Barra p/ baixo *************
sub barra.baixo  (p,pm,l,c,intopc,totopc,totmat,menudown,fl,a$(1))

      shared x,y,pr,opc2

      if flagficha=1 then
         exit if
      elseif menudown=0 then
         exit sub
      end if

      if fl=2 then
         P=P+TOTOPC
         PM=PM+TOTOPC
         if pm>totmat then p=totopc+1:pm=totmat
         exit if
      else
         if fl=0 then                                 'Menu normal-selec‡„o
            call imp.ver (+p,+p,+l,+c,+intopc,a$())   '     por teclas
            p=p+1
            if p>totopc then p=1
            color 3,0
            call imp.ver (+p,+p,+l,+c,+intopc,a$())
 	    exit sub
         end if
         if fl=1 and x=440 and pr=1 then              'Menu com scrool-selec.
            call imp.ver (+p,+pm,+l,+c,+intopc,a$())  '       pelo mouse
            pp=p:opc2=4
            call coordenadas (1)
            mouse=0:opc2=2
            pm=pm-pp+p
            if pm>totmat then pm=totmat:p=totopc+1
         end if
         if fl=1 and pr=0 then             	      'Menu com scrool-selec.
            call imp.ver (+p,+pm,+l,+c,+intopc,a$())  '       por teclas
            p=p+1:pm=pm+1
            if pm>totmat then pm=totmat:p=totopc
         end if
      end if

      if p>totopc then
         p=totopc
         call scrool.baixo (+pm,+l,+c,+intopc,+totopc,a$())
         exit sub
      else
         color 3,0
         call imp.ver (+p,+pm,+l,+c,+intopc,a$())
      end if

end sub
'********** Impressao vertical ************
sub imp.ver  (p,pm,l,c,intopc,a$(1))

      call esconde.seta
      LOCATE L+(INTOPC*(P-1)),C:PRINT A$(PM)
      call mostra.seta

end sub

'******** Barra p/ esquerda ************
sub barra.esquerda (p2,l2,c2,intopc2,totopc,totopc2,menudown,flagficha,a2$(1))

      shared pr,x,y,mouse

      mouse=0
      	
      IF FLAGFICHA=1 then exit sub

      call imp.hor (+p2,+l2,+c2,+intopc2,a2$())

      if pr=1 then
         call coordenadas(2)
         mouse=1
      else
         P2=P2-1
         IF P2<1 THEN P2=TOTOPC2
      end if

      color 3,0
      call imp.hor (+p2,+l2,+c2,+intopc2,a2$())

      IF MENUDOWN=1 THEN
         call apaga.jtrab(0,totopc+3)
         GOTO 140
      END IF

end sub

'********* Barra p/ direita **********
sub barra.direita (p2,l2,c2,intopc2,totopc,totopc2,menudown,flagficha,a2$(1))

      shared pr,x,y,mouse

      IF FLAGFICHA=1 then exit sub

      call imp.hor (+p2,+l2,+c2,+intopc2,a2$())

      P2=P2+1
      IF P2>TOTOPC2 THEN P2=1

      color 3,0
      call imp.hor (+p2,+l2,+c2,+intopc2,a2$())

      IF MENUDOWN=1 THEN
         call apaga.jtrab(0,totopc+3)
         GOTO 140
      END IF

end sub
'******* Impressao horizontal ********
sub imp.hor (p2,l2,c2,intopc2,a2$(1))

      call esconde.seta
      LOCATE L2,C2+(INTOPC2*(P2-1)):PRINT A2$(P2)
      call mostra.seta

end sub
'***********************   Scroll p/ cima ***************************
sub scrool.cima (pm,l,c,intopc,totopc,a$(1))

    call esconde.seta
    color 0,3
    FOR I=1 TO TOTOPC-1
        LOCATE L+INTOPC*I,C:PRINT A$(PM+I)
    NEXT
    color 3,0:LOCATE L,C:PRINT A$(PM)
    P=1
    call mostra.seta

end sub
'********************* Scroll p/ baixo ******************************
sub scrool.baixo (pm,l,c,intopc,totopc,a$(1))

    call esconde.seta
    color 0,3
    FOR I=1 TO TOTOPC-1
        LOCATE L+INTOPC*I-INTOPC,C:PRINT A$(PM-TOTOPC+I)
    NEXT
    color 3,0:LOCATE L+INTOPC*TOTOPC-INTOPC,C:PRINT A$(PM)
    P=TOTOPC
    call mostra.seta

end sub
'*****************************************************************************
'*			      Rotinas do Mouse				     *
'*****************************************************************************
'***** Activa o Mouse *****
sub mouse
    reg 1,0
    call interrupt &h33
end sub
'*****    Posiciona Seta   *****
sub posiciona.seta(X,Y)
    reg 1,4
    reg 3,x
    reg 4,y
    call interrupt &h33
end sub
'*****   Mostra Seta do Mouse   ******
sub mostra.seta
    reg 1,1
    call interrupt &h33
end sub
'***** 	 Esconde Seta do Mouse   ******
sub esconde.seta
    reg 1,2
    call interrupt &h33
end sub
'*****   Determina Area de Opera‡„o  ******
sub area.operacao (x1,x2,y1,y2)
    reg 1,7
    reg 3,x2
    reg 4,x1
    call interrupt &h33
    reg 1,8
    reg 3,y1
    reg 4,y2
    call interrupt &h33
end sub
'*******  Posi‡„o actual do mouse  *******
sub posicao.mouse
    shared x,y,pr
    reg 1,3
    call interrupt &h33
    pr=reg (2)
    x=reg (3)
    y=reg (4)
    if pr=1 then delay (.25)
end sub
'********  Coordenadas para a selec‡„o por barras  ******
sub coordenadas (opc)

    shared p,p2,x,y,opc2

    if opc=1 then
       if opc2=0 then
          select case y
          case =24
               p=1
          case =32
               p=2
          case =40
               p=3
          case =48
               p=4
          case =56
               p=5
          case =64
               p=6
          end select
       elseif opc2=1 then
          select case y
          case =144
               p=1
          case =152
               p=2
          case =160
               p=3
          case =168
               p=4
          end select
       elseif opc2=2 then
          select case y
          case =64
               p=1
          case =72
               p=2
          case =80
               p=3
          case =88
               p=4
          case =96
               p=5
          case =104
               p=6
          case =112
               p=7
          case =120
               p=8
          case =128
               p=9
          case =136
               p=10
          case =144
               p=11
          case =152
               p=12
          end select
       elseif opc2=3 then
          select case y
          case =152
               p=1
          case =160
               p=2
          end select
       elseif opc2=4 then
          select case y
          case =64
               p=p-1
          case 72 to 104
               p=p-3
          case 110 to 144
               p=p+3
          case =152
               p=p+1
          end select
       end if
    elseif opc=2 then
       select case x
       case 40 to 128
           p2=1
       case 144 to 200
           p2=2
       case 240 to 312
           p2=3
       case 336 to 384
           p2=4
       case 432 to 512
           p2=5
       case 528 to 592
           p2=6
       end select
    end if

    opc2=0

end sub
'*****************************************************************************
'*                         Desenha Janela Com Sombra                         *
'*****************************************************************************
sub janela.sombra (lin,col,largmenu,compmenu)

      call esconde.seta
      '* Desenha a parte superior *

      LOCATE LIN,COL:PRINT STRING$ (1,218)
      LOCATE LIN,(COL+1):PRINT STRING$ (LARGMENU-2,196)
      LOCATE LIN,COL+LARGMENU-1:PRINT STRING$ (1,191)

      '* Desenha a parte interm‚dia *

      FOR I=1 TO COMPMENU
      LOCATE LIN+I,COL:PRINT STRING$ (1,179)
      LOCATE LIN+I,COL+1:PRINT SPACE$ (LARGMENU-2)
      LOCATE LIN+I,COL+LARGMENU-1:PRINT STRING$ (1,179)
      LOCATE LIN+I,COL+LARGMENU:PRINT STRING$ (1,178)
      NEXT

      '* Desenha a parte inferior *

      LOCATE LIN+COMPMENU+1,COL:PRINT STRING$ (1,192)
      LOCATE LIN+COMPMENU+1,COL+1:PRINT STRING$ (LARGMENU-2,196)
      LOCATE LIN+COMPMENU+2,COL+1:PRINT STRING$ (LARGMENU,178)
      LOCATE LIN+COMPMENU+1,COL+LARGMENU-1:PRINT STRING$ (1,217)
      LOCATE LIN+COMPMENU+1,COL+LARGMENU:PRINT STRING$ (1,178)
      call mostra.seta

end sub
'*****************************************************************************
'*                     Desenha Janela Sem Sombra                             *
'*****************************************************************************
sub janela.simples (lin,col,largmenu,compmenu)

      call esconde.seta
      '* Desenha a parte superior *

      LOCATE LIN,COL:PRINT STRING$ (1,218)
      LOCATE LIN,(COL+1):PRINT STRING$ (LARGMENU-2,196)
      LOCATE LIN,COL+LARGMENU-1:PRINT STRING$ (1,191)

      '* Desenha a parte interm‚dia *

      FOR I=1 TO COMPMENU
      LOCATE LIN+I,COL:PRINT STRING$ (1,179)
      LOCATE LIN+I,COL+1:PRINT SPACE$ (LARGMENU-2)
      LOCATE LIN+I,COL+LARGMENU-1:PRINT STRING$ (1,179)
      NEXT

      '* Desenha a parte inferior *

      LOCATE LIN+COMPMENU+1,COL:PRINT STRING$ (1,192)
      LOCATE LIN+COMPMENU+1,COL+1:PRINT STRING$ (LARGMENU-2,196)
      LOCATE LIN+COMPMENU+1,COL+LARGMENU-1:PRINT STRING$ (1,217)
      call mostra.seta

end sub
'*****************************************************************************
'*                              Apagar caixa                                 *
'*****************************************************************************
sub apagar.caixa (lin,col,largmenu,compmenu)

      call esconde.seta
      FOR I=1 TO COMPMENU+3
          LOCATE I+(LIN-1),COL:COLOR 0,9:PRINT STRING$ (LARGMENU+1,176)
          delay (.045)
      NEXT I
      call mostra.seta

end sub
'*****************************************************************************
'*                      Sub Apaga janela de trabalho                         *
'*****************************************************************************
SUB APAGA.JTRAB (dy,n)

      call esconde.seta
      FOR I=1 TO n
         DELAY (dy)
         LOCATE I+2,2:COLOR 0,9:PRINT STRING$ (78,176)
      NEXT I
      call mostra.seta

END SUB
'*****************************************************************************
'*                        Sub Limpar todo o ecran                            *
'*****************************************************************************
SUB LIMPAR.ECRAN

     color 0,0
     FOR I=1 TO 25
	 DELAY (.05)
         LOCATE I,1:PRINT SPACE$(80)
     NEXT

END SUB