global start

extern exit, printf
extern concatenare

import exit msvcrt.dll
import printf msvcrt.dll
; Wir importieren die Addition funktion aus dem
; Modul "function.asm"
; importăm funcţia addition din modulul
; function.asm
extern concatenare
segment data use32 class=data public

    s1 db 'ala'
    len1 equ $-s1
    s2 db 'bala'
    len2 equ $-s2
    s3 times len1+len2+1 db 0
    format db "%s", 0
    
segment code use32 class=code public
start:
    push dword len1
    push dword len2
    push dword s1 ; Este o adresa
    push dword s2
    push dword s3
    call concatenare
    
    add esp, 4*5
    
    ;printf("%s", s3)
    push dword s3
    push dword format
    call [printf]
    add esp, 4*2
    
 ; call exit(0)
 push dword 0
 call [exit]