'*****************************************************************************
'*			       Agenda v 2.3				     *
'*       Programa para armazenar nomes,moradas,localidades e telefones       *
'*                   Suporte Multi-Utilizador e Mouse			     *
'*                           Por Tiago Gra‡a 1993        		     *
'*****************************************************************************
on error goto erro

   $STACK 30000
   $include "rotinas1.bas"
   $include "rotinas2.bas"
   $include "rotinas3.bas"
   OPTION BASE 1

   call linha.comando (command$)

   open "i",#4,"fichlist.ddt"
        do while not eof(4)
            input #4,jg1$,hg1$,jh1$,jhhg1$
            fichlist=fichlist+1
        loop
   close #4
'*****************************************************************************
'* 	                        Inicio                                       *
'*****************************************************************************

   CALL LIMPAR.ECRAN
   CLS

45 color 0,9
   for i=1 to 23
       locate i,2:print string$(78,176)
   next
   color 0,3:locate 2,2:print space$(78)

   call linhacomando.utilizador (command$,utilizador$,ficheiro$,numreg,fichlist)

   call mouse
   call area.operacao (8,628,8,176)
   call posiciona.seta (0,0)
   call mostra.seta

   P2=1
   L2=2
   C2=6
   INTOPC2=12
   TOTOPC2=6
   A2$(1)=" Utilizador "
   A2$(2)=" Inserir "
   A2$(3)=" Consultar "
   A2$(4)=" Apagar "
   A2$(5)=" Utilit rios "
   A2$(6)=" Terminar "
   LOCATE L2,C2:COLOR 3,0:PRINT A2$(1)
   FOR IA=1 to totopc2
       LOCATE L2,C2+INTOPC2*IA:COLOR 0,3:PRINT A2$(IA+1)
   NEXT

130 DO
        call esconde.seta
        if fichlist=0 then
           color 4,11:call janela.simples (13,20,40,1)
           locate 14,26:print "N„o h  utilizadores criados"
        elseif utilizador$<>"" then
           color 4,11:call janela.simples (12,16,48,2)
           locate 13,18:print "Utilizador Actual: ";utilizador$
           locate 14,18:print "         Ficheiro: ";ficheiro$
           call janela.simples (17,16,48,1)
           if numreg=500 then
               locate 18,32:print "Ficheiro Cheio"
           elseif numreg=0 then
               locate 18,32:print "Ficheiro Vazio"
           else
               locate 18,27:print "Registos Introduzidos:";numreg
            end if
        else
           color 4,11:call janela.simples (13,20,40,1)
           locate 14,26:print "Nenhum utilizador est  aberto"
        end if

        color 0,11:call janela.simples (21,2,78,1)
        locate 22,4:print "Utilize  ";chr$(27);chr$(24);chr$(25);chr$(26);", Esc, Home, End, Pg Up, Pg Dn, ENTER, Mouse para seleccionar"
        call mostra.seta

        call barra (p2,+l,+l2,+c,+c2,+intopc,+intopc2,+totopc,+totopc2,totopc,+menudown,flagficha,fl,a$(),a2$())

140     color 0,3
        SELECT CASE P2
        CASE=1
            LIN=3
            COL=3
            LARGMENU=21
            COMPMENU=4
            call janela.sombra (3,3,21,4)

        CASE=2
            LIN=3
            COL=16
            LARGMENU=19
            COMPMENU=2
            call janela.sombra (3,16,19,2)
        CASE=3
            LIN=3
            COL=27
            LARGMENU=29
            COMPMENU=6
            call janela.sombra (3,27,29,6)
       CASE=4
            LIN=3
            COL=38
            LARGMENU=25
            COMPMENU=3
            call janela.sombra (3,38,25,3)
       CASE=5
            LIN=3
            COL=50
            LARGMENU=19
            COMPMENU=5
            call janela.sombra (3,50,19,5)
        CASE=6
            LIN=3
            COL=56
            LARGMENU=22
            COMPMENU=2
            call janela.sombra (3,56,22,2)
        END SELECT


        menudown=1

        ON P2 GOSUB 1000,2000,3000,4000,5000,6000

        CALL APAGA.JTRAB(.045,21)

        menudown=0

    LOOP




1000'*************************************************************************
    '*									     *
    '*									     *
    '*				UTILIZADOR				     *
    '*									     *
    '*									     *
    '*************************************************************************
     L=4
     C=4
     TOTOPC=4
     INTOPC=1
     A$(1)=" Criar  Utilizador "
     A$(2)=" Abrir  Utilizador "
     A$(3)=" Apagar Utilizador "
     A$(4)=" Alterar  Password "

     call scrool.cima (1,l,c,1,totopc,a$())

     call barra (p2,4,l2,4,c2,1,+intopc2,4,totopc2,4,menudown,0,0,a$(),A2$())

     call apagar.caixa (+lin,+col,+largmenu,+compmenu)

     CALL APAGA.JTRAB(.025,21)

     ON P GOSUB 1100,1500,1700,1900
RETURN

1100 '************************************************************************
     '*                   	CRIAR NOVO UTILIZADOR                        *
     '************************************************************************

    flagdata=0

    DO
        over=0

        if fichlist=200 then
           call nao_cria.utilizador

           exit loop
        end if

        color 1,10:call janela.simples (4,15,51,10)
        call janela.simples (5,20,41,1)
        locate 6,25:print "Introduza os seguintes dados:"


        DO
            p=2
            call esconde.seta
	    color 1,10:locate 8,17:print "Nome do Utilizador:"
            locate 10,27:print "Password:"
            locate 12,19:print "Nome do Ficheiro:"
            locate 14,32:print "Ext:"
            color 7,4:locate 8,36:print space$(28)
            color 4,7
            FOR I=10 TO 32 STEP 2
                LOCATE 10,26+I:PRINT CHR$ (176)
            NEXT
            color 7,4
            locate 12,36:print space$(11)
            locate 14,36:print " dat "
            call mostra.seta
            do
                call controlo.input (8,37,62,0,"")
                utiliz$=ucase$(w$)
            loop while utiliz$=""

            do
                call password (10,26)
            loop while z$=""

            call encripta (z$)
            pword$=z$

            DO
               flst=0
               color 7,4:locate 12,36:print space$(11)
               call controlo.input (12,37,45,0,"")
               fich$=w$
               if w$="" then w$="   "
               for o=1 to len (w$)
                   if mid$(w$,o,o)<chr$(48) or mid$(w$,o,o)>chr$(167) then flst=1
               next

            LOOP while flst=1


            fich$=ucase$(fich$)+".DAT"

            call carrega.ficheiro (+fichlist,"fichlist.ddt",4)

            for i=1 to fichlist
                if fich$=ta$(i,3) then
                   color 0,14:call janela.simples (17,20,41,1)
                   locate 18,22:print " Ficheiro criado por outro utilizador "
                   call enter.cont
                   p=1
                   call apagar.caixa (17,2,77,4)
                   exit for
                end if
            next

            erase ta$

        LOOP while p=1

        call confirma

        if p=2 then
           flagdata=1
           open "o",#3,fich$
           close #3
           fichlist=fichlist+1
           open "a",#4,"fichlist.ddt"
                write #4,utiliz$,pword$,fich$,"0"
           close #4
        end if

        color 0,11:call janela.simples (19,10,31,2)
        locate 20,15:print "    Deseja criar    "
        locate 21,15:print " outro utilizador ? "
        call nao.sim
        call apagar.caixa (19,10,31,2)

        if p=1 then exit loop

    LOOP

    if flagdata<>0 then
       call apaga.jtrab (.045,21)
       call carrega.ficheiro (+fichlist,"fichlist.ddt",4)
       call ordenacao (ta$(),+fichlist)
       call escreve.disco (ta$(),+fichlist,"fichlist.ddt",4)
       erase ta$
    end if
return

1500 '************************************************************************
     '*                        ABRIR UTILIZADOR                              *
     '************************************************************************
     if fichlist=0 then
        call naoabrir.utilizador
        return
     end if

     call abrir.utilizador (p2,l2,c2,intopc2,totopc2,a2$(),ficheiro$,+fichlist,+numreg)

     call desencripta (ta$(p,2))
     call password.acesso (z$)

     if acesso=1 then
         utilizador$=ta$(p,1)
         password$=z$
         ficheiro$=ta$(p,3)
         numreg=val(ta$(p,4))
     end if

     erase ta$
     acesso=0

return

1700 '************************************************************************
     '*                        APAGAR UTILIZADOR                             *
     '************************************************************************

     if fichlist=0 then
        call naoabrir.utilizador
        return
     end if

     call abrir.utilizador (p2,l2,c2,intopc2,totopc2,a2$(),ficheiro$,+fichlist,+numreg)
     call apaga.jtrab (.045,21)
     color 1,10:call janela.simples (13,14,52,1)
     locate 14,16:print " Utilizador a apagar: ";ta$(p,1)

     aux$=ta$(p,1)
     fichapagar$=ta$(p,3)

     aux=p

     call confirma

     if p=1 then
        erase ta$
     	return
     end if

     p=aux

     call apaga.jtrab (.026,21)

     call desencripta (ta$(p,2))

     call password.acesso (z$)

     erase ta$

     if acesso=0 then
        return
     else
        call apagar.caixa (13,14,52,1)
        call apaga.reg (+fichlist,+p,+p,"fichlist.ddt",4)
        kill fichapagar$
        fichlist=fichlist-1
        if utilizador$=aux$ then
           utilizador$=""
           ficheiro$=""
           password$=""
           numreg=0
        end if
     end if

     acesso=0

return

1900 '************************************************************************
     '*                        Alterar Password                              *
     '************************************************************************

    if utilizador$="" then
       call utilizador.aberto
       return
    end if

    call carrega.ficheiro (+fichlist,"fichlist.ddt",4)

    color 0,3:call janela.simples (6,25,31,7)

    locate 8,28:print "Introduza Password Actual:"

    call password (10,19)

    z$=z$+space$(12-len (z$))

    if z$<>password$ or z$="" then
       color 23,12:locate 12,31:print " Password Inv lida "
       delay (2.5)
       call apagar.caixa (6,25,32,7)
    else
       do
           call apagar.caixa (6,25,33,7)
           color 0,3:call janela.simples (6,25,31,6)
           locate 8,28:print "Introduza Nova Password:"
           call password (10,19)
       loop until z$<>""

       call confirma
       if p=1 then
          erase ta$
          return
       end if

       call encripta (z$)

       for w=1 to fichlist
           if ficheiro$=ta$(w,3) then ta$(w,2)=z$
       next
       call escreve.disco (ta$(),fichlist,"fichlist.ddt",4)
    end if

    erase ta$

    CALL APAGA.JTRAB(.045,21)

RETURN





2000 '************************************************************************
     '*									     *
     '*									     *
     '*                             INSERIR                                  *
     '*									     *
     '*									     *
     '************************************************************************
     L=4
     C=17
     TOTOPC=2
     INTOPC=1
     A$(1)="   Acrescentar   "
     A$(2)="     Alterar     "

     call scrool.cima (1,l,c,1,totopc,a$())

     call barra (p2,4,l2,17,c2,1,+intopc2,2,totopc2,2,menudown,0,0,a$(),A2$())

     CALL APAGA.JTRAB(.025,21)

     if utilizador$="" then
        call utilizador.aberto
        return
     end if

     call apagar.caixa (+lin,+col,+largmenu,+compmenu)

     menudown=0

     ON P GOSUB 2100,2500
RETURN

2100 '************************************************************************
     '*                            ACRESCENTAR                               *
     '************************************************************************
    open "a",#2,ficheiro$

    if numreg=500 then
       call ficheiro.cheio
       close #2
       return
    end if

    DO
          if numreg=500 then
             call ficheiro.cheio
             return
          end if

          nome$=""
          morada$=""
          localidade$=""
          telefone$=""
          numreg=numreg+1
          call desenha.ficha (+numreg)

          DO
              color 7,4
              call controlo.input (8,14,72,len (nome$),nome$)
              nome$=w$

              call controlo.input (10,16,72,len (morada$),morada$)
              morada$=w$

              call controlo.input (12,20,72,len (localidade$),localidade$)
              localidade$=w$

              call controlo.input (14,18,72,len (telefone$),telefone$)
              telefone$=w$

              call deseja.alterar
              w$=""
              if p=1 then exit loop
          LOOP

          write #2,nome$,morada$,localidade$,telefone$

          color 0,11:call janela.simples (19,10,30,2)
          locate 20,15:print " Deseja introduzir "
          locate 21,15:print "  mais registos ?  "
          call nao.sim
          call apagar.caixa (19,10,30,2)

          if p=1 then exit loop
    LOOP

    close #2

    call apaga.jtrab (0,21)
    call carrega.ficheiro (+numreg,ficheiro$,2)
    call ordenacao (ta$(),+numreg)
    call escreve.disco (ta$(),+numreg,ficheiro$,2)
    erase ta$

return

2500 '************************************************************************
     '*                              ALTERAR                                 *
     '************************************************************************

     if numreg=0 then
        call nao.reg
        return
     end if

    call carrega.ficheiro (+numreg,ficheiro$,2)

    DO
        call numero.registo(+numreg)

        call desenha.ficha (+num)
        call esconde.seta
        color 7,4
        locate 8,14:print ta$(num,1)
        locate 10,16:print ta$(num,2)
        locate 12,20:print ta$(num,3)
        locate 14,18:print ta$(num,4)
        call mostra.seta
        DO
            color 7,4
            call controlo.input (8,14,72,len (ta$(num,1)),ta$(num,1))
            ta$(num,1)=w$

            call controlo.input (10,16,72,len (ta$(num,2)),ta$(num,2))
            ta$(num,2)=w$

            call controlo.input (12,20,72,len (ta$(num,3)),ta$(num,3))
            ta$(num,3)=w$

            call controlo.input (14,18,72,len (ta$(num,4)),ta$(num,4))
            ta$(num,4)=w$

            call deseja.alterar

            if p=1 then exit loop
        LOOP

        color 0,11:call janela.simples (19,10,30,2)
        locate 20,15:print "  Deseja alterar   "
        locate 21,15:print "  mais registos ?  "
        call nao.sim
        call apagar.caixa (19,10,30,2)

        call apaga.jtrab (.045,21)

        if p=1 then exit loop
    LOOP

    call ordenacao (ta$(),+numreg)
    call escreve.disco (ta$(),+numreg,ficheiro$,2)
    erase ta$

RETURN
3000 '************************************************************************
     '*									     *
     '*									     *
     '*          		  CONSULTAR				     *
     '*									     *
     '*									     *
     '************************************************************************
     L=4
     C=28
     INTOPC=1
     TOTOPC=6
     A$(1)=" Consultar pelo n§ registo "
     A$(2)="    Consultar pelo nome    "
     A$(3)="   Consultar pela morada   "
     A$(4)=" Consultar pela localidade "
     A$(5)="  Consultar pelo telefone  "
     A$(6)="    Ver todo o ficheiro    "

     call scrool.cima (1,l,c,1,totopc,a$())

     call barra (p2,4,+l2,28,+c2,1,+intopc2,6,+totopc2,6,menudown,0,0,a$(),A2$())

     call apagar.caixa (+lin,+col,+largmenu,+compmenu)

     menudown=0

     CALL APAGA.JTRAB(.025,21)

     if utilizador$="" then
        call utilizador.aberto
        return
     elseif numreg=0 then
        call nao.reg
        return
     end if

     ON P GOSUB 3100,3200,3300,3500,3700,3800

RETURN
3100 '************************************************************************
     '* 		  CONSULTAR PELO N§ REGISTO                          *
     '************************************************************************

     call carrega.ficheiro (+numreg,ficheiro$,2)

     do
         call numero.registo(+numreg)
         call desenha.ficha (+num)
         call esconde.seta
         color 7,4
         locate 8,14:print ta$(num,1)
         locate 10,16:print ta$(num,2)
         locate 12,20:print ta$(num,3)
         locate 14,18:print ta$(num,4)
         call mostra.seta
         color 0,11:call janela.simples (19,10,30,2)
         locate 20,15:print " Deseja  consultar "
         locate 21,15:print "  mais registos ?  "
         call nao.sim
         call apaga.jtrab (.045,21)
     loop until p=1

     erase ta$


RETURN
3200 '************************************************************************
     '* 			CONSULTAR PELO NOME                          *
     '************************************************************************
      w$=""
      color 1,10:call janela.simples (10,6,70,1)
      locate 11,8:print "Nome:"
      color 7,4:locate 11,13:print space$(61)
      DO
          call controlo.input (11,14,72,0,w$)
          if w$<>"" then exit loop
      LOOP
      call consultar (+numreg,1,w$,ficheiro$,2)
return

3300 '************************************************************************
     '* 			CONSULTAR PELA MORADA                        *
     '************************************************************************
      w$=""
      color 1,10:call janela.simples (10,6,70,1)
      locate 11,8:print "Morada:"
      color 7,4:locate 11,15:print space$ (59)
      DO
          call controlo.input (11,16,72,0,w$)
          if w$<>"" then exit loop
      LOOP
      call consultar (+numreg,2,w$,ficheiro$,2)
return

3500 '************************************************************************
     '* 			CONSULTAR PELA LOCALIDADE                    *
     '************************************************************************
      w$=""
      color 1,10:call janela.simples (10,6,70,1)
      locate 11,8:print "Localidade:"
      color 7,4:locate 11,19:print space$ (55)
      DO
          call controlo.input (11,20,72,0,w$)
          if w$<>"" then exit loop
      LOOP
      call consultar (+numreg,3,w$,ficheiro$,2)
return
3700 '************************************************************************
     '* 			CONSULTAR PELO TELEFONE                      *
     '************************************************************************
      w$=""
      color 1,10:call janela.simples (10,6,70,1)
      locate 11,8:print "Telefone:"
      color 7,4:locate 11,17:print space$(57)
      DO
          call controlo.input (11,18,72,0,w$)
          if w$<>"" then exit loop
      LOOP
      call consultar (+numreg,4,w$,ficheiro$,2)
return

3800 '************************************************************************
     '*                      CONSULTAR TODO O FICHEIRO    		     *
     '************************************************************************
      call carrega.ficheiro (+numreg,ficheiro$,2)
      call proximo.anterior (ta$(),+numreg,1,lkl())
      erase ta$,lkl
return









4000 '************************************************************************
     '*									     *
     '*									     *
     '*                        APAGAR REGISTOS                               *
     '*									     *
     '*									     *
     '************************************************************************

    l=4
    c=39
    totopc=3
    intopc=1
    a$(1)="      Um registo       "
    a$(2)=" Intervalo de registos "
    a$(3)="   Todos os registos   "

    call scrool.cima (1,l,c,1,totopc,a$())

    call barra (p2,4,l2,39,c2,1,+intopc2,3,totopc2,3,menudown,0,0,a$(),A2$())

    call apagar.caixa (+lin,+col,+largmenu,+compmenu)

    menudown=0

    CALL APAGA.JTRAB(.025,21)

     if utilizador$="" then
        call utilizador.aberto
        return
     elseif numreg=0 then
        call nao.reg
        return
     end if

    on p gosub 4100,4400,4800
return

4100 '************************************************************************
     '*                           Apagar um Registo                          *
     '************************************************************************
    call numero.registo(+numreg)

    call carrega.ficheiro (+numreg,ficheiro$,2)

    call desenha.ficha (+num)
    call esconde.seta
    color 7,4
    locate 8,14:print ta$(num,1)
    locate 10,16:print ta$(num,2)
    locate 12,20:print ta$(num,3)
    locate 14,18:print ta$(num,4)
    erase ta$
    call mostra.seta
    call confirma
    if p=1 then return

    call apaga.jtrab (0,19)
    call apaga.reg (+numreg,num,num,ficheiro$,2)
    numreg=numreg-1
return

4400 '***********************************************************************
     '*                   Apagar um Intervalo de Registos                   *
     '***********************************************************************

    DO
        w$=""
        color 1,10:call janela.simples (8,20,48,1)
        locate 9,22:print "Introduza n§ do registo inicial: "
        color 7,4:locate 9,55:print space$(9)
        call controlo.input (9,56,62,len (w$),w$)
        num1=val (w$)
        call verificar (w$,+num1,501,+numreg)
        w$=""
        color 1,10:call janela.simples (12,20,48,1)
        locate 13,22:print "Introduza n§ do registo final: "
        color 7,4:locate 13,55:print space$(9)
        call controlo.input (13,56,62,len (w$),w$)
        num2=val (w$)
        call verificar (w$,+num1,+num2,+numreg)
    loop while flst=1

    call confirma
    if p=1 then return

    call apaga.jtrab (0,15)
    call apaga.reg (+numreg,num1,num2,ficheiro$,2)

    numreg=numreg-(num2-num1+1)
return


4800 '***********************************************************************
     '*                     Apagar Todos os Registos                        *
     '***********************************************************************

    call confirma
    if p=1 then return

    open "o",#2,ficheiro$
    close #2

    color 0,5:call janela.simples (10,24,34,1)
    color 31,5:locate 11,25:print "Todos os registos foram apagados"
    call enter.cont
    numreg=0

    call escreve.terminar (+fichlist,"fichlist.ddt",ficheiro$,+numreg,4)
Return








5000 '************************************************************************
     '*								  	     *
     '*								  	     *
     '*                              UTILITARIOS          		     *
     '*								  	     *
     '*								  	     *
     '************************************************************************
     L=4
     C=51
     TOTOPC=5
     INTOPC=1
     A$(1)=" Ver Hora Actual "
     A$(2)=" Ver Data Actual "
     a$(3)="   Alterar Hora  "
     a$(4)="   Alterar Data  "
     A$(5)="  Ficha T‚cnica  "

     call scrool.cima (1,l,c,1,totopc,a$())

     call barra (p2,4,l2,51,c2,1,+intopc2,5,totopc2,5,menudown,0,0,a$(),A2$())

     call apagar.caixa (+lin,+col,+largmenu,+compmenu)

     CALL APAGA.JTRAB(.025,21)

     ON P GOSUB 5100,5200,5300,5400,5500
RETURN

5100 '************************************************************************
     '*    			Ver Hora Actual                              *
     '************************************************************************

     color 0,3:call janela.simples (12,27,25,1)

     COLOR 0,3
     LOCATE 13,28:PRINT " Hora Actual: ";TIME$;" "
     call enter.cont

RETURN

5200 '************************************************************************
     '* 			Ver Data Actual                              *
     '************************************************************************

     color 0,3:call janela.simples (12,27,27,1)

     COLOR 0,3
     dat$=mid$(date$,4,3)+mid$(date$,1,3)+mid$(date$,7,10)
     LOCATE 13,28:PRINT " Data Actual: ";DAT$;" "
     call enter.cont

RETURN

5300 '************************************************************************
     '*			       	Alterar Hora 	                             *
     '************************************************************************

     color 1,10
     call janela.simples (12,27,26,6)
     call janela.simples (13,28,24,1)

     do
         p=0
         color 4,10:locate 14,31:print "Insira nova hora:"
         color 7,4:locate 17,30:print "      ";
         color 4,7:print ":";
         color 7,4:print "      ";
         color 4,7:print ":";
         color 7,4:print "      "
         call controlo.input(17,32,34,0,""):hora$=w$+":"
         if val (w$)<0 or val(w$)>23 then p=1
         call controlo.input(17,39,41,0,""):hora$=hora$+w$+":"
         if val(w$)<0 or val(w$)>59 then p=1
         call controlo.input(17,46,48,0,""):hora$=hora$+w$
         if val(w$)<0 or val(w$)>59 then p=1
     loop while P=1

     time$=hora$

return

5400 '************************************************************************
     '* 			 Alterar Data	                             *
     '************************************************************************

     color 1,10
     call janela.simples (12,27,28,6)
     call janela.simples (13,28,26,1)

     do
         p=0
         color 4,10:locate 14,33:print "Insira nova data:"
         color 7,4:locate 17,30:print "      ";
         color 4,7:print "-";
         color 7,4:print "      ";
         color 4,7:print "-";
         color 7,4:print "        "
         call controlo.input(17,32,34,0,""):dat$=w$+"-"
         if val (w$)<1 or val(w$)>31 then p=1
         call controlo.input(17,39,41,0,""):dat1$=w$+"-"
         if val(w$)<1 or val(w$)>12 then p=1
         call controlo.input(17,46,50,0,""):dat$=dat$+w$
         if val(w$)<0 then p=1
     loop while P=1

     date$=dat1$+dat$


return
5500 '************************************************************************
     '* 			Ver F. Tecnica                               *
     '************************************************************************

     color 7,12:call janela.sombra (7,20,40,7)

     APR$(1)="            Agenda v 2.3 "
     APR$(2)=""
     APR$(3)="  Agenda Telef¢nica Multi-Utilizador"
     APR$(4)=""
     APR$(5)="        Por Tiago Gra‡a - 1993"
     APR$(6)=""

     DO
         ft=ft+1
         FOR J=1 TO LEN (APR$(ft))
             call posicao.mouse
             TECLA$=INKEY$
             IF TECLA$=CHR$(13) or pr=1 THEN EXIT LOOP
             LOCATE 8+ft,20+J:PRINT MID$(APR$(ft),J,J)
             DELAY (.028)
         NEXT
     LOOP UNTIL ft=6

     call enter.cont
     CALL APAGA.JTRAB(.045,21)
     ERASE APR$
     ft=0


RETURN









6000 '************************************************************************
     '*									     *		
     '*									     *
     '*		               TERMINAR SESSŽO  			     *
     '*									     *
     '*									     *
     '************************************************************************
     L=4
     C=57
     TOTOPC=2
     INTOPC=1
     A$(1)=" Abandonar a sess„o "
     A$(2)="  SHELL para o DOS  "

     call scrool.cima (1,l,c,1,totopc,a$())

     call barra (p2,4,l2,57,c2,1,+intopc2,2,totopc2,2,menudown,0,0,a$(),A2$())

     call apagar.caixa (+lin,+col,+largmenu,+compmenu)

     call apaga.jtrab (.015,21)

     if numreg<>0 then
        call escreve.terminar (+fichlist,"fichlist.ddt",ficheiro$,+numreg,4)
     end if

     ON P GOSUB 6100,6500

6100 '************************************************************************
     '*				Abandonar sessao                             *
     '************************************************************************

     call esconde.seta
     call limpar.ecran

     color 0,3:call janela.simples (1,21,34,7)
     LOCATE 3,23:PRINT "Copyright 1993 por Tiago Gra‡a"
     LOCATE 5,24:PRINT "Ajude a combater a pirataria"
     LOCATE 7,23:PRINT "Prefira os programas originais"
     delay(5)
     screen 0,0,0
     LOCATE 15,1
END

6500 '************************************************************************
     '*				Shell para o DOS                             *
     '************************************************************************

     call esconde.seta
     call limpar.ecran
     screen 0,0,0
     color 7,13:call janela.sombra (5,21,40,1)
     color 31,13:LOCATE 6,23:PRINT "Digite EXIT para voltar ao programa."

     color 0,7
     LOCATE 15,1
     SHELL
     COLOR 7,0
     SHELLCONT=1
     MENUDOWN=0
     CALL LIMPAR.ECRAN
     CLS
GOTO 45




'******************************************************************************
'*	     		   Quando alguma coisa falha ...		      *
'******************************************************************************
ERRO:

    if err=53 then
       open "o",#4,"fichlist.ddt"
       close #4
       resume
    elseif err=24 or err=25 or err=27 then
       call apagar.caixa (18,2,77,3)
       color 7,9:call janela.simples (18,8,66,1)
       locate 19,10:color 31,9:print "A impressora n„o est  operacional! ";
       print "Verifique o seu estado e..."
       call enter.cont
       call apagar.caixa (18,2,77,3)
       p=1
       call imprime.novamente
       if p=1 then
          call apaga.jtrab (.045,21)
          erase ta$,lkl
          consultar=0
          resume 130
       else
          color 13,15:call janela.sombra (19,30,20,1)
          color 31,7:locate 20,33:print "Imprimindo ...":color 0,7
          resume
       end if
    else
       call apaga.jtrab (.045,17)
       call esconde.seta
       call limpar.ecran
       color 0,10:call janela.simples (9,25,30,5)
       locate 11,31:print "Erro Irrecuper vel"
       locate 13,31:print "Programa Terminado"
       locate 15,1
       delay (5)
       screen 0,0,0
       end
    end if