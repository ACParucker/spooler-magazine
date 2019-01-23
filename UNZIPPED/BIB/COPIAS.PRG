* * * * * * * * * * * * * * *
* PROGRAMA COPIAS.PRG
* C¢pias de Seguran‡a
* Fevereiro de 1994
* * * * * * * * * * * * * * *

r := savescreen(0,0,24,79)
sal=1
set color to w+/b,n/w
@5,27 clear to 21,78
SET SAFE OFF
SET COLOR TO GR+/B,n/w
@7,28 to 12,77 double
SOMBRA(7,28,12,77)
SET COLOR TO W+/B,n/w
@  8,30 SAY " Se foram feitas altera‡”es aos ficheiros de "
@  9,30 SAY " quer por inser‡„o, anula‡„o  ou modifica‡„o "
@ 10,30 SAY " registos   devem   executar-se   c¢pias  de "
@ 11,30 SAY " seguran‡a para disquete."
DO WHILE .T.
  SET CURSOR ON
  ? CHR(7)
  set color to w+/r,w+/b
  @15,40 clear to 19,64
  @15,40 to 19,64
  SOMBRA(15,40,19,64)
  @ 16,41 SAY " Deseja fazer c¢pias? " 
  @ 18,47 prompt "Sim"
  @ 18,54 prompt "N„o"
  menu to isi
  do case
    case isi=1
      do while .t.
        set color to gr+/b,n/w
        @5,27 clear to 21,78
        @21,36 say " Pressione ENTER para Desistir. "
        @7,29 to 15,75 
        sombra(7,29,15,76)
        dr = " "
        @9,31 SAY "Digite a letra da drive que vai utilizar: "
        @9,73 GET dr PICT "!"	VALID dr="A" .or. dr="B" .or. dr=" "
        READ
        if dr=space(1)
          set cursor off
          restscreen(0,0,24,79,r)
          set color to n/w,bg+/b
          return
        endif
        exit
      ENDDO
	  dr=dr+":"
      @8,31 clear to 14,74
      @ 9,38 SAY "Coloque a disqueta na drive " + dr
      @11,38 SAY "  Pressione qualquer tecla..."
      inkey(0)
      SET CONS OFF
      copy file livros.dbf   to &dr\livros.dbf
      copy file bibautor.dbf to &dr\bibautor.dbf
      copy file bibedito.dbf to &dr\bibedito.dbf
      copy file bibtema.dbf  to &dr\bibtema.dbf
      copy file bibamigo.dbf to &dr\bibamigo.dbf
      copy file bibempre.dbf to &dr\bibempre.dbf
      SET CONS ON
      exit
    case isi=2
      exit
    otherwise
      exit
  ENDCASE
ENDDO    
set cursor off
set color to n/w,bg+/b
restscreen(0,0,24,79,r)
return

*****************************

