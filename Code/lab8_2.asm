bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
sir DD 12345678h, 1256ABCDh, 12AB4344h, 1234FFFFh
lung equ ($-sir)/4
segment code use32 class=code
start:
    std
    mov eax, 0
    mov ecx, lung - 1
    mov esi, sir + (lung - 1)*4 
    mov ebx, lung
    Repeta:
        lodsw ; ax = FFFFh, 4344h, ABCDh, 5678h
        add esi, 2
        push ecx
        dec ebx
        mov ecx, ebx
        mov edi, esi
        sub edi, 4
        Repeta2:
            scasw
            jb MaiMare
            add edi, 2
            mov dx, [edi]
            mov [edi], ax
            mov ax, dx
            mov [esi], dx
            sub edi, 2
            MaiMare:
            sub edi, 2
        loop Repeta2
        sub esi, 4
        pop ecx
    loop Repeta

    push dword 0
    call [exit]