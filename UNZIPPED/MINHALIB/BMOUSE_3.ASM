
;* Syntax.......: memvar = M_SET_ON()
;*              : memvar = M_SET_OFF()
;*
;* Return values: M_SET_ON() - .T. if everything is O.K. and .F. if
;*                              something is wrong (i.e. mouse driver
;*                              not installed)
;*                M_SET_OFF() - always returns .T. and return value can
;*                              pretty much be ignored
;*
;*
;* BMOUSE is a set of assembly language routines designed to
;* allow the usage of the Microsoft Mouse or any compatible
;* mouse with Clipper.  This allows the programmers to take
;* advantage of the @ ... PROMPT/MENU TO, and other "wait" states,
;* to make pretty decent user interfaces for their programs.
;*
    public M_SET_ON
    public M_SET_OFF


;*** declare Clipper's procedures for returning variables as FAR
;
    extrn          __RETL:far      ; returns logical type


;*** define keys to insert based on mouse conditions.
;
    LB             equ 1C0Dh      ; set LEFT button to RETURN key
    CB             equ 3B00h      ; set CENTER button to F1 key
    RB             equ 011Bh      ; set RIGHT button to ESC key


;*** dDefine keyboard buffer area.
;
BIOS_DATA segment at 40h
    org            1ah
    BUFFER_HEAD    dw   ?         ;pointer to the keybord buffer head
    BUFFER_TAIL    dw   ?         ;pointer to the keyboard buffer tail
    org            80h
    BUFFER_START   dw   ?         ;starting keyboard buffer address
    BUFFER_END     dw   ?         ;ending keyboard buffer address
BIOS_DATA ends
;
;
CODE segment 'CODE'               ; declare code segment of class PROG
    assume cs:CODE,ds:BIOS_DATA

    VCOUNT         db   4         ; vertical delay counter
    HCOUNT         db   4         ; horizontal delay counter
    HFLAG          dw   ?         ; horizontal count sign flag
    VFLAG          dw   ?         ; vertical count sign flag
    KEYCODE        db   4Dh,4Bh,50h,48h     ;keycodes for cursor keys

MOUSE proc far
;
; determine which event occured, and branch accordingly
;
    test ax,2                ; left button pressed?
    jnz  LEFT                ; if yes, then go insert 'LB' into buffer
    test ax,8                ; right button pressed?
    jnz  RIGHT               ; if yes, then go insert 'RB' into buffer
    test ax,32               ; center button pressed? (PC MOUSE)
    jnz  CENTER              ; if yes, then go insert 'CB' into buffer
    test ax,1                ; Cursor position changes.
    jz MAINEXIT              ; Nothing to do with us.

MOUSE0:
    mov  ax,11               ; use mouse driver's function 11
    int  33h                 ; read mouse motion counters
    mov  HFLAG,0             ; initialize sign flags
    mov  VFLAG,2             ;
    xor  al,al               ; zero AL for extended keycode
    cmp  cx,0                ; horizontal count positive?
    jge  MOUSE1              ; yes, then branch
    inc  HFLAG               ; record negative condition
    neg  cx                  ; convert negative to positive

MOUSE1:
    cmp  dx,0                ; vertical count positive
    jge  MOUSE2              ; yes, then branch
    inc  VFLAG               ; record negative condition
    neg  dx                  ; convert negative to positive

MOUSE2:
    mov  bx,HFLAG            ; assume motion was horizontal
    cmp  cx,dx               ; was assumption correct?
    jae  HORIZMOVE           ; yes, then branch
    mov  bx,VFLAG            ; no, then correct it
    mov  HCOUNT,4            ; reset horizontal delay counter
    dec  VCOUNT              ; decrement vertical delay count
    jz   MOUSE3              ; continue if count is zero
MAINEXIT:
    ret                      ; exit if it's not


HORIZMOVE:

    mov VCOUNT,4            ; motion was horizontal. Reset vertical delay counter
    dec HCOUNT              ; decrement horizontal delay counter
    jnz MAINEXIT
    mov HCOUNT,4            ; reset horizontal delay counter

MOUSE3:

    mov  VCOUNT,4            ; reset vertical delay counter
    mov  ah,KEYCODE[bx]      ; get keycode from table
    jmp  INSERT              ; insert it into keyboard buffer

LEFT:
    mov  ax,LB               ; load pre-defined 'LB' keycode into buffer
    jmp  INSERT              ; insert it into buffer

RIGHT:
    mov  ax,RB               ; load pre-defined 'RB' keycode into buffer
    jmp  INSERT              ; insert it into buffer

CENTER:
    mov ax,CB                ; load pre-defined 'CB' keycode into buffer
                             ; insert it into buffer

INSERT:
    mov  bx,BIOS_DATA        ; point DS to the BIOS data area
    mov  ds,bx               ;
    assume ds:BIOS_DATA      ;
    cli                      ; disable interrupts
    mov  bx,BUFFER_TAIL      ; get buffer tail address
    mov  dx,bx               ; transfer it to DX
    add  dx,2                ; calculate next buffer position
    cmp  dx,BUFFER_END       ; did we overshoot the end?
    jne  INSERT1             ; no, then continue
    mov  dx,BUFFER_START     ; yes, then wrap to start of buffer

INSERT1:
    cmp  cx,BUFFER_HEAD      ; is the buffer full?
    je   INSERT2             ; yes, then end now
    mov  [bx],ax             ; insert the keycode
    mov  bx,dx               ; advance the tail
    mov  BUFFER_TAIL,bx      ; record its new position

INSERT2:
    sti                      ; enable interrupts
    assume ds:nothing        ;
    ret                      ; exit user sub-routine

MOUSE endp
;
;
;
;****************************************
;** M_SET_ON() : routine to set up a function to be called upon mouse
;**              activity, using the mouse driver's function 12.
;****************************************
M_SET_ON proc far
    push bp                  ; save evrything as documented in
    mov  bp,sp               ; Aut '86 Nantucket News or you
    push ds                  ; will blow up!
    push es                  ;
    mov  ax,0                ; use function 0 of driver to see
    int  33h                 ; if mouse and driver are installed
    or   ax,ax               ; is there a mouse?
    jne  OK                  ; yes, continue
    mov  bx,0                ; return to Clipper a .F. to tell
    push bx                  ; it that M_SET_ON() failed to set
    call __retl               ; up the routine (extended interface)
    jmp  DONE                ; go back to Clipper

OK:
    mov  ax,15               ; use function 15 of mouse driver to
    mov  cx,400              ; set the mouses sensitivity
    mov  dx,800              ;
    int  33h                 ;
    mov  ax,seg MOUSE        ; tell function 12 where to find the
    mov  es,ax               ; the mouse routine
    mov  dx,offset MOUSE     ;
    mov  ax,12               ; use function 12
    mov  cx,0000000000101011b     ; set up the mask for buttons and cursor
    int  33h                 ; set it up!
    mov  bx,1                ; return a .T. to Clipper to tell it
    push bx                  ; that the installation was successful
    call __retl               ; (using Clipper's extended interface)

DONE:
    pop  bx                  ; restore the stack or DIE!!!!
    pop  es                  ;
    pop  ds                  ;
    pop  bp                  ;
    ret                      ; exit and pray!!
M_SET_ON endp
;
;
;
;***********************************************
;** M_SET_OFF() : routine to disable the mouse routine so that
;**               accidentally hitting the mouse won't cause the cursor
;**               keys to be inserted into the keyboard buffer
;***********************************************
M_SET_OFF proc far
    push bp                  ; save these registers as usual
    mov  bp,sp               ;
    push ds                  ; or DIE!!!!!
    push es                  ;
    mov  ax,0                ; use function 0 of the mouse driver
    int  33h                 ; to reset the mouse settings which
    mov  bx,1                ; effectively turns off the mouse routine
    push bx                  ; return a .T. which really has no meaning
    call __retl               ; but needs  to be done to allow the
    pop  bx                  ; routine to be used as a UDF without hanging
    pop  es                  ; restore the stack or hang like a
    pop  ds                  ;
    pop  bp                  ; bleep, bleep !!!!
    ret                      ;
M_SET_OFF endp

CODE ends
     end

