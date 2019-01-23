'*****************************************************************************
'*			Sub-Rotina Enter para Continuar			     *
'*****************************************************************************
sub enter.cont

         shared pr

         color 13,7:call janela.simples (21,2,37,1)

         DO
             color 5,7
             LOCATE 22,3:PRINT " Tecle 'ENTER' para continuar...   "
             delay (.005)
             call posicao.mouse
	     TECLA$=INKEY$
             IF TECLA$=CHR$(13) or pr=1 THEN
                exit loop
             ELSEIF TECLA$<>"" THEN
                LOCATE 22,36
                PRINT TECLA$
                DELAY (.25)
                color 13,7:call janela.simples (21,40,40,1)
                for lk=1 to 100
                    locate 22,41:print space$(38)
        	    color 5,7
	            LOCATE 22,41:PRINT " Evite situa‡”es de erro, por favor ! "
         	    delay (.005)
	        next
             END IF
        LOOP

end sub
'*****************************************************************************
'*               Ficha para altera‡ao/introducao,etc dos dados               *
'*****************************************************************************
sub desenha.ficha (numreg)

          color 1,10:call janela.simples (5,6,70,10)
          call esconde.seta
          color 15,13:locate 6,29:print " Registo n§: ";space$(4)
          locate 6,41:print numreg
          color 4,10:locate 8,8:print "Nome:"
          color 7,4:locate 8,13:print space$(61)
          color 4,10:locate 10,8:print "Morada:"
          color 7,4:locate 10,15:print space$ (59)
          color 4,10:locate 12,8:print "Localidade:"
          color 7,4:locate 12,19:print space$ (55)
          color 4,10:locate 14,8:print "Telefone:"
          color 7,4:locate 14,17:print space$(57)
          call mostra.seta

end sub
'*****************************************************************************
'*                         Pede numero do registo                            *
'*****************************************************************************
sub numero.registo (numreg)

    shared num,w$
    w$=""
    color 1,10:call janela.simples (10,20,40,1)

        locate 11,22:print "Introduza n§ do registo: "
        color 7,4:locate 11,48:print space$(9)
    DO
        flst=0
        call controlo.input (11,49,55,len (w$),w$)
        num=val (w$)
        if w$="" or num>numreg or num<1 then flst=1
    LOOP while flst=1

    call apagar.caixa (10,20,40,1)

end sub
'*****************************************************************************
'*                Carrega para TA$ o conteudo do ficheiro                    *
'*****************************************************************************
sub carrega.ficheiro (numreg,ficheiro$,nf)

    shared ta$()
    dim ta$(numreg,4)
    open "i",#nf,ficheiro$
    color 0,2:call janela.simples (16,30,18+len (str$(numreg*2)),1)
    for i%=1 to numreg
            input #nf,ta$(i%,1),ta$(i%,2),ta$(i%,3),ta$(i%,4)
        color 5,2:locate 17,31:print " Registo:";i%;"/";numreg
    next i%
    close #nf
    call apagar.caixa (16,30,18+len (str$(numreg*2)),1)

end sub
'*****************************************************************************
'*                         Ordena a matriz TA$                               *
'*****************************************************************************
sub ordenacao (ta$(2),numreg)

    call apaga.jtrab (0,21)
    color 0,2:call janela.simples (10,23,36,1)
    color 5,2:locate 11,24:print " Em ordena‡„o. Aguarde, por favor "
    color 0,2:call janela.simples (14,30,18+len (str$(numreg*2)),1)

    for h%=1 to numreg-1
        color 5,2:locate 15,31:print " Registo:";h%+1;"/";numreg
        for g%=h%+1 to numreg
            if ucase$(ta$(h%,1))>ucase$(ta$(g%,1)) then
               for t%=1 to 4
                   swap ta$(h%,t%),ta$(g%,t%)
               next t%
             end if
         next g%
    next h%

    call apaga.jtrab (0,21)
    color 0,2:call janela.simples (10,29,23,1)
    color 31,2:locate 11,30:print " Ordena‡„o Efectuada "

end sub
'*****************************************************************************
'*                      Escreve no disco o conteudo de ta$                   *
'*****************************************************************************
sub escreve.disco (ta$(2),numreg,ficheiro$,nf)

    open "o",#nf,ficheiro$
    color 0,2:call janela.simples (16,30,18+len (str$(numreg*2)),1)
    for i%=1 to numreg
        write#nf,ta$(i%,1),ta$(i%,2),ta$(i%,3),ta$(i%,4)
        color 5,2:locate 17,31:print " Registo:";i%;"/";numreg
    next
    close #nf
    call apagar.caixa (16,30,18+len (str$(numreg*2)),1)

end sub
'*****************************************************************************
'*                       Ver Proximo/Anterior       			     *
'*****************************************************************************
sub proximo.anterior (ta$(2),numreg,flag,ta(1))

      shared p,consultar,opc2

      l=19
      c=60
      a$(1)=" Pr¢ximo  "
      a$(2)=" Anterior "
      a$(3)=" Imprimir "
      a$(4)="   Sair   "

      call mais.registos (l,c,a$())

      i=1
      do
          if flag=1 then
             call desenha.ficha (+i)
          elseif flag=0 then
             call desenha.ficha (ta(i))
          end if
          call esconde.seta
          color 7,4
          locate 8,14:print ta$(i,1)
          locate 10,16:print ta$(i,2)
          locate 12,20:print ta$(i,3)
          locate 14,18:print ta$(i,4)
          call mostra.seta
          opc2=1
          call barra (+p2,19,+l2,60,+c2,1,+intopc2,4,+totopc2,4,1,1,0,a$(),A2$())
          consultar=1
          if p=1 then i=i+1
          if p=2 then i=i-1
          if p=3 then
             call apagar.caixa (18,2,77,3)
             call imprimir (i,ta$())
             call mais.registos (l,c,a$())
             p=1
          end if
          if i>numreg then i=1
          if i<1 then i=numreg
      loop until p=4
      consultar=0

end sub
'*****************************************************************************
'*                   Pesquisa em TA$ aquando de Consultar  	 	     *
'*****************************************************************************
sub consultar (numreg,ta,w$,ficheiro$,nf)

    shared ta$()
    dim ta(numreg),aux$(numreg,4)
    call apagar.caixa (10,6,70,1)
    call carrega.ficheiro(+numreg,ficheiro$,+nf)
    k=0
    for i=1 to numreg
        if ucase$(w$)=ucase$(left$ (ta$(i,ta),len (w$))) then
           k=k+1
           ta(k)=i
           for g=1 to 4
               aux$(k,g)=ta$(i,g)
           next
        end if
    next
    if k=0 then
       call registo.inexistente
       erase ta$,aux$,ta
       exit sub
    end if
    call proximo.anterior (aux$(),+k,0,ta())
    erase ta$,aux$,ta

end sub
'*****************************************************************************
'*                          Apaga os registos 				     *
'*****************************************************************************
sub apaga.reg(numreg,num1,num2,ficheiro$,nf)

    shared ta$()
    call carrega.ficheiro (+numreg,ficheiro$,+nf)
    for r=num1 to num2
        for g=1 to 4
            ta$ (r,g)=string$ (1,255)
        next
    next

    call ordenacao (ta$(),+numreg)
    numreg=numreg-(num2-num1+1)
    call escreve.disco (ta$(),+numreg,ficheiro$,+nf)
    erase ta$

end sub
'*****************************************************************************
'*                    Verificar a introducao do n§ de registo		     *
'*****************************************************************************
sub verificar (w$,num1,num2,numreg)

    shared flst

    flst=0

    if w$="" or num2<num1 or val (w$)>numreg or val (w$)<1 then flst=1

end sub
'*****************************************************************************
'* 	    Desenha no ecran a janela e selecciona o utilizador a abrir      *
'*****************************************************************************
sub abrir.utilizador (p2,l2,c2,intopc2,totopc2,a2$(1),ficheiro$,fichlist,numreg)

     shared ta$(),p,opc2
     dim a$(fichlist)

     call carrega.ficheiro (+fichlist,"fichlist.ddt",4)
     for w=1 to fichlist
         if ficheiro$=ta$(w,3) then ta$(w,4)=str$(numreg)
         a$(w)=ta$(w,1)
         tm=len(a$(w))
         a$(w)="  "+left$(a$(w),tm)+space$(27-tm)
     next

     call escreve.disco (ta$(),fichlist,"fichlist.ddt",4)

     if fichlist>12 then
        totfich=12
     else
        totfich=fichlist
     end if

     color 0,3
     call janela.simples (4,20,39,5+totfich)
     call janela.simples (5,24,30,1)
     call janela.simples (8,22,35,+totfich)
     locate 6,27:print "Seleccione o utilizador:"
     if totfich=12 then
        call esconde.seta
        locate 9,56:print chr$(24)
        for i=1 to 10
            locate 9+i,56:print "±"
        next
        locate 20,56:print chr$(25)
        call mostra.seta
     end if
     L=9
     C=25
     INTOPC=1
     TOTMAT=fichlist

     call teclas

    if fichlist>12 then
       totopc=12
       call scrool.cima (1,9,25,1,totopc,a$())
       opc2=2
       call barra (p2,9,l2,25,c2,1,+intopc2,+totopc,totopc2,+totmat,1,1,1,a$(),A2$())
    else
       totopc=fichlist
       call scrool.cima (1,9,25,1,totopc,a$())
       opc2=2
       call barra (p2,9,l2,25,c2,1,+intopc2,+totopc,totopc2,+totopc,1,1,0,a$(),A2$())
    end if

    erase a$
    call apaga.jtrab (0,21)

end sub

'*****************************************************************************
'*     Escreve numreg em fichlist.ddt aquando do apagamento/sa¡da do prog    *
'*****************************************************************************
sub escreve.terminar (fichlist,temp$,ficheiro$,numreg,nf)

        shared ta$()
        call carrega.ficheiro (+fichlist,temp$,nf)
        for w=1 to fichlist
            if ta$(w,3)=ficheiro$ then ta$(w,4)=str$(numreg)
        next
        call escreve.disco (ta$(),fichlist,temp$,nf)
	erase ta$

end sub
'*****************************************************************************
'* 				Linha de comando 			     *
'*****************************************************************************
sub linha.comando(y$)

   if y$="/?" or y$="/h" then
      print
      print " ---------------------------------------------------------------"
      print "                Agenda v 2.3 - Por Tiago Gra‡a 1993"
      print
      print "      Sintaxe:"
      print
      print "      Agenda [nome do utilizador;password]"
      print
      print "      Agenda /? ou /h - Mostra este ‚cran
      print " ---------------------------------------------------------------"
      stop
   end if

end sub
'*****************************************************************************
'* 		Abre utilizador declarado na linha de comando 		     *
'*****************************************************************************
sub linhacomando.utilizador (y$,autil$,bfich$,c,fichlist)

   shared ta$()
   shared z$,utilizador$,password$,ficheiro$,numreg
   utilizador$=autil$
   ficheiro$=bfich$
   numreg=c

   if fichlist=0 or flaginicio=1 then
      exit sub
   elseif y$<>"" then
       flaginicio=1
       call carrega.ficheiro (+fichlist,"fichlist.ddt",4)
       posicao=instr(y$,";")
       utilizador$=ucase$(left$(y$,posicao-1))
       password$=mid$(y$,posicao+1,len (y$))
       call encripta (password$)
       p$=z$

       for w=1 to fichlist
           if utilizador$=ta$(w,1) and p$=ta$(w,2) then
     	      ficheiro$=ta$(w,3)
     	      numreg=val(ta$(w,4))
              password$=password$+space$(12-len(password$))
     	   end if
       next
       erase ta$
   end if
end sub
'*****************************************************************************
'* 			      Imprimir Registos		 		     *
'*****************************************************************************
sub imprimir (numreg,ta$(1))

      color 2,0:call janela.simples (18,20,40,1)
      locate 19,22:print "Verifique o estado da impressora ..."
      call enter.cont
      call apagar.caixa (18,2,77,3)

      color 13,15:call janela.sombra (19,30,20,1)
      color 31,7:locate 20,33:print "Imprimindo ...":color 0,7
      lprint chr$(218);string$(77,196);chr$(191)
      lprint chr$(179);space$(77);chr$(179)
      lprint chr$(179);tab(29);" Registo n§: ";numreg;tab(79);chr$(179)
      lprint chr$(179);space$(77);chr$(179)
      lprint chr$(179);space$(77);chr$(179)
      lprint chr$(179);tab(8);"Nome:";ta$(numreg,1);tab(79);chr$(179)
      lprint chr$(179);space$(77);chr$(179)
      lprint chr$(179);tab(8);"Morada:";ta$(numreg,2);tab(79);chr$(179)
      lprint chr$(179);space$(77);chr$(179)
      lprint chr$(179);tab(8);"Localidade:";ta$(numreg,3);tab(79);chr$(179)
      lprint chr$(179);space$(77);chr$(179)
      lprint chr$(179);tab(8);"Telefone:";ta$(numreg,4);tab(79);chr$(179)
      lprint chr$(179);space$(77);chr$(179)
      lprint chr$(192);string$(77,196);chr$(217)

      call apagar.caixa (19,20,40,1)

end sub