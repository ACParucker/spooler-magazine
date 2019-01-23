'*****************************************************************************
'*                        Deseja alterar ? (s/n)                             *
'*****************************************************************************
sub deseja.alterar

      color 0,11:call janela.simples (19,10,30,2)

      locate 20,15:print "Deseja fazer alguma"
      locate 21,15:print "     altera‡„o ?   "

      call nao.sim

      call apagar.caixa (19,10,30,2)

end sub
'*****************************************************************************
'*                       Janela NAO/SIM					     *
'*****************************************************************************
sub nao.sim

      shared opc2

      color 0,3:call janela.simples (19,59,13,2)

      l=20
      c=60
      a$(1)="    N„o    "
      a$(2)="    Sim    "

      call scrool.cima (1,l,c,1,2,a$())
      opc2=3
      call barra (+p2,20,+l2,60,+c2,1,+intopc2,2,+totopc2,2,1,1,0,a$(),A2$())

      call apagar.caixa (19,59,13,2)

end sub
'*****************************************************************************
'*     		                Ficheiro Cheio 				     *
'*****************************************************************************
sub ficheiro.cheio

    call apaga.jtrab (0,21)

    color 7,10:call janela.simples (10,21,39,1)
    color 31,10:locate 11,22:print " O ficheiro n„o aceita mais registos "
    call enter.cont

end sub
'*****************************************************************************
'*                       Ver mais registos       			     *
'*****************************************************************************
sub mais.registos (l,c,a$(1))

      color 0,11:call janela.simples (19,10,30,2)
      locate 20,15:print " Deseja visualizar "
      locate 21,15:print "  mais registos ?  "
      call janela.simples (18,59,12,4)
      call scrool.cima (1,l,c,1,4,a$())

end sub
'*****************************************************************************
'*                       	Registo Inexistente                          *
'*****************************************************************************
sub registo.inexistente

       color 7,10:call janela.simples (10,29,23,1)
       color 31,10:locate 11,30:print " Registo inexistente "
       call enter.cont

end sub
'*****************************************************************************
'*                    Nao h  registos no ficheiro                            *
'*****************************************************************************
sub nao.reg

    call apaga.jtrab(0,21)
    color 7,10:call janela.simples (10,25,33,1)
    color 31,10:locate 11,27:print " N„o h  registos no ficheiro "
    call enter.cont
    call apaga.jtrab (0,21)

end sub
'*****************************************************************************
'*                            Confirma Opera‡ao 		 	     *
'*****************************************************************************
sub confirma

          shared p
          color 0,11:call janela.simples (19,10,30,2)
          locate 20,15:print "    Confirma a  "
          locate 21,15:print "    opera‡„o ?  "
          call nao.sim
          call apagar.caixa (19,10,30,2)

end sub
'*****************************************************************************
'*                     Nao h  utilizadores abertos                           *
'*****************************************************************************
sub utilizador.aberto

    color 7,10:call janela.simples (10,25,34,1)
    color 31,10:locate 11,26:print " Nenhum utilizador est  aberto "
    call enter.cont
    call apaga.jtrab (0,21)

end sub
'*****************************************************************************
'*                 Nao se podem criar mais utilizadores                      *
'*****************************************************************************
sub nao_cria.utilizador

    call apaga.jtrab (0,21)
    color 7,10:call janela.simples (10,21,42,1)
    color 31,10:locate 11,23:print " N„o se podem criar mais utilizadores"
    call enter.cont
    call apaga.jtrab (0,21)

end sub
'*****************************************************************************
'*                 Nao foram criados utilizadores                            *
'*****************************************************************************
sub naoabrir.utilizador

    call apaga.jtrab (0,21)
    color 7,10:call janela.simples (10,25,34,1)
    color 31,10:locate 11,26:print " N„o foram criados utilizadores "
    call enter.cont
    call apaga.jtrab (0,21)

end sub
'*****************************************************************************
'* 			    Teclas de Utiliza‡„o			     *
'*****************************************************************************
sub teclas

   color 0,2:call janela.sombra (8,61,17,8)
   call esconde.seta
   locate 9,62:print " -  Teclas:  -"
   locate 10,63:print "Seta p/ cima"
   locate 11,63:print "Seta p/ baixo"
   locate 12,66:print "Page Up"
   locate 13,65:print "Page Down"
   locate 14,68:print "Home"
   locate 15,68:print "End"
   locate 16,67:print "ENTER"
   call mostra.seta

end sub
'*****************************************************************************
'*                 Mensagem de imprimir outra vez em caso de erro 	     *
'*****************************************************************************
sub imprime.novamente

      shared p

      color 0,11:call janela.simples (19,10,30,2)
      locate 20,13:print " Deseja tentar imprimir "
      locate 21,13:print "       novamente ?      "
      call nao.sim
      call apagar.caixa (19,10,30,2)

end sub