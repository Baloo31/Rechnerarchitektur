bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    sir db '12345'
    len equ $-sir
    rez dw 0, 0 ; 
    format db 'Numarul este: %u', 0
segment code use32 class=code
start:
    mov esi, sir
    mov ecx, len
    cld
    xor ebx, ebx
    xor eax, eax
    repeta:
        mov ax, word [rez]
        cmp ax, 0
        jz skip
        shl ax, 2 ; rez * 4
        add ax, word [rez] ; rez * 5
        shl ax, 1 ; rez * 10
        mov word [rez], ax
        skip:
        xor ax, ax
        lodsb ; in al avem 1,2,3,4
        sub al, 48
        add byte [rez], al
    loop repeta
    push dword [rez]
    push dword format
    call[printf]
    add esp, 4*2
push dword 0
call [exit]