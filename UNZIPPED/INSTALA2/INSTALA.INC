
;       instala.inc
;       declara‡”es v rias para o programa instala

;       Copyright (C) 1995, Carlos Ladeira


STACK_SIZE      equ     1024

VIDEO           equ     10h
KEYBOARD        equ     16h
DOS             equ     21h
MOUSE           equ     33h

MISC_OUTPUT     equ     3C2h            ;Miscellaneous Output register
SC_INDEX        equ     3C4h            ;Sequence Controller Index
GC_INDEX        equ     3CEh            ;Graphics Controller Index register
CRTC_INDEX      equ     3D4h            ;CRT Controller Index
MODE_CTRL       equ     3D8h            ;Mode control I/O port 
STATUS_PORT     equ     3DAh            ;Status port

FADE_STEP       equ     4               ; step fade
DARKNESS_LEVEL  equ     30              ; darkness level

SCREEN_SEG      equ     0A000h          ;segment of display memory in mode X
SCAN_LINE       equ     90              ;comprimento de uma linha em bytes

MAXX            equ     360
MAXY            equ     480
CHAR_SZ         equ     16

LOADBUF_SZ      equ     10240

MAXCOLORS       equ     256
TERMINATOR      equ     000h
TRAILER         equ     03Bh            ; ";"
SEPARATOR       equ     02Ch            ; ","
EXTENSION       equ     021h            ; "!"

HEADER_SZ       equ     13
PALETTE_SZ      equ     768
IMGDESC_SZ      equ     9

MAX_ITEMS       equ     100
ITEM_SZ         equ     59 + 81 + 13 + 2 + 1

k_BKSP          equ     08
k_TAB           equ     09
k_ENTER         equ     13
k_ESC           equ     27
k_SPACE         equ     32

k_HOME          equ     04700h
k_UP            equ     04800h
k_PGUP          equ     04900h
k_LEFT          equ     04B00h
k_RIGHT         equ     04D00h
k_END           equ     04F00h
k_DOWN          equ     05000h
k_PGDN          equ     05100h
k_INSERT        equ     05200h
k_DEL           equ     05300h

NO_EVENT        equ     0
KBD_EVENT       equ     1
MOUSE_EVENT     equ     2

INPUT_TARGET_SZ equ     1+1+1+1+1+2+2+2+2
N_IDS           equ     5
LAST_GLOBAL_ID  equ     4

NO_ID           equ     0
ITEMS_BOX_ID    equ     1
BASE_DIR_ID     equ     2
INSTALL_BUT_ID  equ     3
CANCEL_BUT_ID   equ     4
;------------------------
TARGET_DIR_ID   equ     5

EditData        STRUC
String          DW      ?               ; ptr to string
StrSize         DW      ?               ; max. size of string
WinPos          DW      ?               ; cursor pos. in string (x edit windows x)
WinSize         DW      ?               ; size of edit window
FstWinChar      DW      ?               ; ptr to 1st char in the window
WinXY           DW      ?               ; X,Y position of window
EditData        ENDS

Colors          STRUC
Titles          DB      ?
StatLn          DB      ?
Text            DB      ?
TextHi          DB      ?
CurrentText     DB      ?
Frames          DB      ?
ScroolBar       DB      ?
ScroolBarHi     DB      ?
Itemc           DB      ?
ItemHi          DB      ?
Colors          ENDS

Item            STRUC
Description     DB      59 dup(?)
Directory       DB      81 dup(?)
ZipFile         DB      13 dup(?)
SizeKB          DW      ?
Active          DB      ?
Item            ENDS

InputEvent      STRUC
EventType       DB      ?         ; 0-none, 1-keyboard, 2-mouse
Event           DW      ?         ; 0-none, 1-moved, 2-left, 4-right, ??-key pressed
TargetID        DB      ?         ; 0-none, ??-ID
InputEvent      ENDS

InputTarget     STRUC
ID              DB      ?
X1              DB      ?
Y1              DB      ?
X2              DB      ?
Y2              DB      ?
ShortCut        DW      ?
StartRtn        DW      ?
ProcessRtn      DW      ?
EndRtn          DW      ?
InputTarget     ENDS

Header          STRUC
Signature       DB      3 dup (?)
Ver             DB      3 dup (?)
SWidth          DW      ?
SHeight         DW      ?
flags1          DB      ?
BgColor         DB      ?
AspRatio        DB      ?
Header          ENDS

ImgDesc         STRUC
XPos            DW      ?
YPos            DW      ?
ImgWidth        DW      ?
ImgHeight       DW      ?
flags2          DB      ?
ImgDesc         ENDS

