;Se citesc de la tastatura doua numere a şi b. Sa se calculeze valoarea expresiei (a-b)*k, k fiind o constanta definita in 
;segmentul de date. 
;Afisati valoarea expresiei (in baza 16). 
bits 32
global start        
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    a db 0
    format1 db '%d', 0
    b db 0
    format2 db '%d', 0
    hex db '%x', 0
    k db 112
segment code use32 class=code       
start:
    ; Citire a
    push dword a
    push dword format1
    call [scanf] 
    add esp, 4*2
    
    ; Citire b
    push dword b
    push dword format2
    call [scanf]
    add esp, 4*2
    xor eax, eax
    xor ebx, ebx
    ; Interschimbarea valorilor in cazul in care e nevoie
    mov al, [a]
    cmp al, [b]
    jge continua
        mov bl, [b]
        mov [a], bl
        mov [b], al
    continua:
    
    ; Calcularea expresiei
    mov al, [a]
    sub al, [b]
    mov bl, [k]
    mul bl
    
    push dword eax
    push dword hex
    call [printf] ; Afisarea rezultatului 
    add esp, 4*2
    
push dword 0
call [exit]
    