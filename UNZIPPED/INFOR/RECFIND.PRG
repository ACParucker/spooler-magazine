* RECFIND.PRG

#Include "INKEY.CH"
#Include "SETCURS.CH"

FUNCTION REC_FIND(TOP, LEFT, BOT, RHT, DAT_BLK)
LOCAL CUR_SET, I, NEW_REC, OLD_SCR, KEYPRESS
private b_column
private B_OBCT

B_OBCT := TBROWSEDB(TOP+1, LEFT+1, BOT-1, RHT-1)

B_COLUMN := TBCOLUMNNEW(' ', DAT_BLK)
B_OBCT:ADDCOLUMN(B_COLUMN)

set color to w+/b
@9,23 say "¥Dicion†rio de Termos Inform†ticos√"

b_obct:colorspec := "w/n,bg+/b,w/n,w/n"

DO WHILE .T.

  DO WHILE .NOT. B_OBCT:STABILIZE()
    KEYPRESS := INKEY()
    IF KEYPRESS <> 0
      EXIT
    ENDIF
  ENDDO
  
  IF B_OBCT:STABLE
    IF B_OBCT:HITTOP .OR. B_OBCT:HITBOTTOM
      TONE(200,1)
    ENDIF
    KEYPRESS := INKEY(0)
  ENDIF

  IF KEYPRESS == K_DOWN
    B_OBCT:DOWN()
  ELSEIF KEYPRESS == K_UP
    B_OBCT:UP()
  ELSEIF KEYPRESS == K_PGDN
    B_OBCT:PAGEDOWN()
    B_OBCT:REFRESHALL()
  ELSEIF KEYPRESS == K_PGUP
    B_OBCT:PAGEUP()
    B_OBCT:REFRESHALL()
  ELSEIF KEYPRESS == K_HOME
    B_OBCT:GOTOP()
  ELSEIF KEYPRESS == K_END
    B_OBCT:GOBOTTOM()
  ELSEIF KEYPRESS == K_ESC
    EXIT
  ELSEIF KEYPRESS == K_RETURN
	IF file = space(12)
      LOOP
    ENDIF
    choic()
  ENDIF
ENDDO
RETURN

****************