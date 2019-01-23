/***
*  Sombra( <nTop>, <nLeft>, <nBottom>, <nRight> ) --> NIL
*  Draw a box shadow with see through
*
*/
FUNCTION Sombra( nTop, nLeft, nBottom, nRight )
   LOCAL nShadTop, nShadLeft, nShadBottom, nShadRight
   
   nShadTop   := nShadBottom := MIN(nBottom + 1, MAXROW())
   nShadLeft  := nLeft + 1
   nShadRight := MIN(nRight + 1, MAXCOL())

   RESTSCREEN( nShadTop, nShadLeft, nShadBottom, nShadRight,;
       TRANSFORM( SAVESCREEN(nShadTop, nShadLeft, nShadBottom, nShadRight),;
       REPLICATE("x", nShadRight - nShadLeft + 1 ) ) )
				  
   nShadTop    := nTop + 1
   nShadLeft   := nShadRight := MIN(nRight + 1, MAXCOL())
   nShadBottom := nBottom

   RESTSCREEN( nShadTop, nShadLeft, nShadBottom, nShadRight,;
       TRANSFORM( SAVESCREEN(nShadTop,  nShadLeft , nShadBottom,  nShadRight),;
       REPLICATE("X", nShadBottom - nShadTop + 1 ) ) )

   RETURN NIL
