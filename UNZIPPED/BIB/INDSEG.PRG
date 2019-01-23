**********************************************************************
* INDSEG.PRG
* Rotina que faz a indexa‡„o dos ficheiros e as c¢pias de seguran‡a.
* 25/10/93
* Isildo Mendes
* UTILSOFT - Software
***********************************************************************

LOCAL hGauge, nPercent

w := savescreen(0,0,24,79)
set color to n/w

@10,3 clear to 20,77
@10,3 to 20,77 double
sombra(10,3,20,77)


hGauge := BarraNova( 12, 5, 7, MAXCOL() - 5, "W/B", "W+/B" )
BarraDisplay( hGauge )

set color to n/w
@17,22 say "O programa est  a reindexar os ficheiros."
@18,22 say "         Aguarde um momento..."

nPercent := 0

use bibamigo
index on codamigo to bibamigo
index on nome to nom_ami
nPercent +=	.1
BarraUpdate( hGauge, nPercent )

use bibempre
index on codlivro to bibempre
index on codamigo to emp_ami
nPercent += .1
BarraUpdate ( hGauge, nPercent )

use bibautor
index on codautor to bibautor
index on descric to aut_desc
nPercent += .2
BarraUpdate( hGauge, nPercent)

use bibtema
index on codtema to bibtema
index on descric to tem_desc
nPercent += .2
BarraUpdate( hGauge, nPercent)

nPercent += .2
use bibedito
index on codedito to bibedito
index on descric to edi_desc
BarraUpdate(hGauge, nPercent)

nPercent += .1
use livros
index on codlivro to livros
index on titulo to li_titul
index on codautor to li_autor
BarraUpdate(hGauge, nPercent)

nPercent += .1
index on codedito to li_editor
index on codtema to li_tema
BarraUpdate(hGauge, nPercent)
    
@17,22 clear to 19,74
@18,32 say "Opera‡„o Terminada."
inkey(.05)

close databases
close all
restscreen(0,0,24,79,w)

***************************************************

