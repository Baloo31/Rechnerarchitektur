bits 32
global start
extern exit
import exit msvcrt.dll
segment data use32 class=data
msg1 db "seminar"
len equ $-msg1 ;poz curenta in segmentul de date (msg1+7 = final)
;msg2 times len db 0 are lungimea lui msg1 
msg2 db 0,0,0,0,0,0,0
len2 equ $-msg2 ; constanta
;msg3 times 7 db 0
; tema "seminar4"
segment code use32 class=code
start:

MOV EDI, msg2; destinatie
MOV ESI, msg1; sursa
MOV ECX, len
CLD ; DF=0 crescator
JECXZ final ; verif cazul in care ECX =0
myLoop:
    LODSB ; MOV AL,[ESI+msg1] INC ESI 
    MOV BL, 'a'-'A' ; 32
    SUB AL, BL
    STOSB ; MOV [EDI+msg2], AL  INC EDI    (caracter transformat)
LOOP myLoop
final:
push dword 0
call[exit]