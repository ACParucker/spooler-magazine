
;       gif.asm
;       rotinas para descodifica‡„o de gif's

;       Copyright (C) 1995, Carlos Ladeira


                include instala.inc

                jumps
                locals
                .286
                .model  small

                .data?
code_table      DB      16384 dup(?)
code_size       DW      ?
clear_code      DW      ?
eof_code        DW      ?
first_free      DW      ?
bit_offset      DW      ?
byte_offset     DW      ?
bits_left       DW      ?
max_code        DW      ?
free_code       DW      ?
old_code        DW      ?
input_code      DW      ?
code            DW      ?
suffix_char     DW      ?
final_char      DW      ?
bytes_unread    DW      ?
code_buffer     DB      64 dup(?)

                .data
msk_            DW      0001h, 0003h, 0007h, 000Fh
                DW      001Fh, 003Fh, 007Fh, 00FFh
                DW      01FFh, 03FFh, 07FFh, 0FFFh

                .code
                EXTRN   GetByte:NEAR, PutByte:NEAR
                PUBLIC  ExpandGIF

;    void init_table( short  min_code_size )
init_table      proc
	push	bp
	mov	bp,sp

        mov     cx,word ptr [bp+4]
        mov     bx,cx
        inc     bx
        mov     word ptr code_size,bx

        mov     ax,1
	shl	ax,cl
        mov     word ptr clear_code,ax

	inc	ax
        mov     word ptr eof_code,ax

        mov     ax,word ptr clear_code
	add	ax,2
        mov     word ptr first_free,ax

        mov     word ptr free_code,ax

	mov	ax,1
        mov     cl,bl
	shl	ax,cl
        mov     word ptr max_code,ax

	pop	bp
	ret	
init_table      endp



;    short read_code(void)
read_code       proc
        push    si di

        mov     ax,word ptr bit_offset
        mov     bx, ax
	and	ax,7
        mov     word ptr bits_left,ax

        mov     ax,bx
	sar	ax,3
        mov     word ptr byte_offset,ax

        cmp     ax,61
	jl	short @4@394

        cld
        mov     cx,64
        sub     cx,ax
        push    cx
        mov     si, OFFSET code_buffer
        add     si, ax
        mov     di, OFFSET code_buffer
        rep     movsb
        pop     si

@4@226: cmp     word ptr bytes_unread,0
	jne	short @4@310

        call    GetByte
        mov     word ptr bytes_unread,ax

        cmp     word ptr bytes_unread,0
	je	short @4@366

@4@310: call    GetByte

        mov     byte ptr code_buffer[si],al
	inc	si
        dec     word ptr bytes_unread

@4@338: cmp     si,64
	jl	short @4@226

@4@366: mov     ax,word ptr bits_left
        mov     word ptr bit_offset,ax
        mov     word ptr byte_offset,0

@4@394: mov     ax,word ptr code_size
        add     word ptr bit_offset,ax

        cld
        mov     si, OFFSET code_buffer
        add     si, byte_offset
        lodsw
        mov     dx, ax
        lodsb
        xor     ah, ah
        xchg    ax, dx

        mov     cl,byte ptr bits_left
        or      cl, cl
        jz      short @4@450
        cmp     cl,16
        jae     rsh@small
        mov     bx,dx                   ; save the high bits
        shr     ax,cl                   ; now shift each half
        sar     dx,cl
        neg     cl
        add     cl,16
        shl     bx,cl
        or      ax,bx
        jmp     @4@450
rsh@small:
        sub     cl,16                   ; for shifts more than 15, do this
                                        ; short sequence.
        xchg    ax,dx                   ;
        cwd                             ; We have now done a shift by 16.
        sar     ax,cl                   ; Now shift the remainder.

@4@450: mov     bx,word ptr code_size
	shl	bx,1
        and     ax,word ptr msk_[bx-2]

        pop     di si
	ret	
read_code       endp

;    void ExpandGif()
ExpandGIF       proc
	push	bp
	mov	bp,sp
	sub	sp,2
	push	si
	push	di

        call    GetByte
	mov	word ptr [bp-2],ax

	push	ax
        call    init_table
	add	sp,2

	xor	si,si

        mov     word ptr bit_offset,512

        mov     word ptr bytes_unread,0
	jmp	@5@478

@5@58:  mov     ax,word ptr code
        cmp     ax,word ptr clear_code
	jne	short @5@114

	push	word ptr [bp-2]
        call    init_table
	add	sp,2

        call    read_code
        mov     word ptr code,ax
        mov     word ptr old_code,ax
        mov     word ptr suffix_char,ax
        mov     word ptr final_char,ax

        mov     al,byte ptr suffix_char
        call    PutByte
        jmp     @5@478

@5@114: mov     ax,word ptr code
        mov     word ptr input_code,ax
        cmp     ax,word ptr free_code
	jl	short @5@170

        mov     ax,word ptr old_code
        mov     word ptr code,ax

	mov	bx,si
	shl	bx,2
        mov     al,byte ptr final_char
        mov     byte ptr code_table[bx+3],al
	inc	si

@5@170: mov     di,si
	shl	di,2
        add     di,offset code_table+3
	jmp	short @5@282

@5@198: mov     bx,word ptr code
	shl	bx,2
        mov     al,byte ptr code_table[bx+2]
	mov	byte ptr [di],al
	add	di,4
	inc	si

        mov     ax,word ptr code_table[bx]
        mov     word ptr code,ax

@5@282: mov     ax,word ptr code
        cmp     ax,word ptr first_free
	jge	short @5@198

        mov     word ptr final_char,ax
        mov     word ptr suffix_char,ax

	mov	bx,si
	shl	bx,2
        mov     al,byte ptr final_char
        mov     byte ptr code_table[bx+3],al
	inc	si
	jmp	short @5@366

@5@338: dec     si
	mov	bx,si
	shl	bx,2
        mov     al,byte ptr code_table[bx+3]
        call    PutByte

@5@366: or      si,si
	jg	short @5@338

        mov     bx,word ptr free_code
	shl	bx,2
        mov     al,byte ptr suffix_char
        mov     byte ptr code_table[bx+2],al

        mov     ax,word ptr old_code
        mov     word ptr code_table[bx],ax

        inc     word ptr free_code

        mov     ax,word ptr input_code
        mov     word ptr old_code,ax

        mov     ax,word ptr free_code
        cmp     ax,word ptr max_code
	jl	short @5@478
        cmp     word ptr code_size,12
	jge	short @5@478

        inc     word ptr code_size
        shl     word ptr max_code,1

@5@478: call    read_code
        mov     word ptr code,ax
        cmp     ax,word ptr eof_code
	je	@@0
	jmp	@5@58

@@0:    pop     di
	pop	si
	leave	
	ret	
ExpandGIF       endp

                end

