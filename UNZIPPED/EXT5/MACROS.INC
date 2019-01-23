COMMENT %

Programa:.... VIRT86.EXE
              Programa demonstrativo de execu‡„o em
              Modo Virtual 86.

MACROS utilizadas no m¢dulo VMONITOR.ASM

Autor:....... Jos‚ P scoa

Compilado com: Borland C++ 3.1

Produzido em Dezembro 1993 para a revista SPOOLER.

%


; EQUATES para os macros

; Tipos de "System Segment" e "Gates" para modo protegido de 32 bits.

LDT         equ 2      ; "Local Descriptor Table"
TASK_GATE   equ 5      ; "task gate"
TSS_AV      equ 9      ; TSS de 32 bits dispon¡vel.
TSS_BUSY    equ 11     ; TSS de 32 bits indisp¡vel.
CALL_GATE   equ 12     ; "call gate" de 32 bits.
INT_GATE    equ 14     ; "interrupt gate" de 32 bits.
TRAP_GATE   equ 15     ; "trap gate" de 32 bits.


; MACROS

MEMORYSEG MACRO name, type, priv, uso

name SEGMENT PARA PUBLIC uso
EVEN
zero = $
&name&_start = $
&name&_ar = 90h OR (priv SHL 5) OR (type SHL 1)

ENDM


SYSTEMSEG MACRO name, type, priv

name SEGMENT PARA PUBLIC USE32
EVEN
zero = $
&name&_start = $
&name&_ar = 80h OR (priv SHL 5) OR type

ENDM


ENDSEG MACRO name

&name&_limit = $ - &name&_start -1
name ENDS

ENDM


DSCRP MACRO export, name

        IFDIF <export>, <>
export LABEL WORD
        ENDIF
        dw &name&_limit
        dw name
        db 0
        db &name&_ar
        db      01000000b
        db 0

ENDM

DSCRPTSS MACRO export, name

        IFDIF <export>, <>
export LABEL WORD
        ENDIF
        dw &name&_limit
        dw name
        db 0
        db &name&_ar
        db      0
        db 0

ENDM



GATE MACRO export, _offset, select, wc, type, priv

        IFDIF <export>, <>
export LABEL WORD
        ENDIF
        dw _offset
        dw select
        db wc
        db 80h OR (priv SHL 5) + type
        dw 0

ENDM

CALL_FAR3232 MACRO sel, _offset, rpl

        db 9ah
        dd offset _offset
        dw offset sel + rpl

ENDM

JMP_FAR3216 MACRO sel, _offset, rpl

        db 66h
        db 0eah
        dw offset _offset
        dw offset sel + rpl

ENDM

JMP_FAR1632 MACRO sel, _offset, rpl

        db 66h
        db 0eah
        dd offset _offset
        dw offset sel + rpl

ENDM

JMP_FAR3232 MACRO sel, _offset, rpl

        db 0eah
        dd offset _offset
        dw offset sel + rpl

ENDM

JMP_FAR1616 MACRO sel, _offset, rpl

        db 0eah
        dw offset _offset
        dw sel + rpl

ENDM

JMP_FAR_REAL MACRO segmnt, _offset

        db 0eah
        dw offset _offset
        dw segmnt

ENDM

_POPAD MACRO

        popad          ; popad  'bug fix' para alguns computadores 386.
        db 90h

ENDM

GDT_SEL MACRO sel, priv
        dw sel + priv
ENDM

LDT_SEL MACRO sel, priv
        dw sel + 4 + priv
ENDM

