bits 32
global start
extern exit,printf, scanf, fopen, fread ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll

segment data use32 class=data
    ; n resw 1
    ;a dw 5
    ;b dw 1,2,3,4,5,6,7,8,9,10
    ;c db 1,2,3,4,5,6,7,8
    ;d dd 1,2,3,4,5
    A db "abcdef" ;   "a","b", "c","d","e","f" ; sau a db "abcdef"
    L equ $ - A; $ = contor de locatii
    B TIMES L db 0
segment code use32 class=code
start:
    Mov esi,0

    Transforma:
        Mov al, [A+ESI]
        Sub al, "a" - "A"
        Mov [B+ESI], al 
        INC ESI
        CMP ESI, L
    JB Transforma

    ;Mov ax, [a]
    ;Mov bx, [b]
    ;Mov bx, [b+2]
    ;Mov bx, [b+4]

    ; A dd 12345678h
    ; B dq 1122334455667788h 

    ;A                       B
    ;|                       |
    ;| 78h | 56h | 34h | 12h | 88h | 77h | 66h | 55h | 44h | 33h | 22h | 11h |
    ;   A    A+1   A+2   A+3   B     B+1   B+2   B+3   B+4   B+5   B+6    B+7 
    ;                          A+4    A+5   A+6   A+7   A+8   A+9   A+10   A+11


    ; mov EAX, BX ; NU MERGE !!!
    
    ; mov [n], word 12345678h
    ; mov AL, [n+1] ; In AL se pune 56

;mov EAX, [n]
;push EAX ; FFFF FFF4
;pop AX ; FFF4 in AX ; XYZQ FFFF
;pop DX ; FFFF in DX ; XYZQ ABCD

;push DX ; ABCD FFFF
;push AX ; FFFF FFF4
;pop EAX

; Citire a  ; format1:  format1 db '%d', 0
; push dword a
; push dword format1 
; call [scanf] 
; add esp, 4*2

push dword 0 ; push the parameter for exit onto the stack
call [exit] ; call exit to terminate the program