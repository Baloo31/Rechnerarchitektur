bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
sir DD 12345678h, 1256ABCDh, 12AB4344h, 1234FFFFh
lung equ ($-sir)/4
segment code use32 class=code
start:
    cld
    mov eax, 0
    mov ecx, lung - 1
    mov esi, sir
    mov ebx, lung
    Repeta:
        lodsw ; ax = 5678h, ABCDh, 4344h, FFFFh
        sub esi, 2
        push ecx
        dec ebx
        mov ecx, ebx
        mov edi, esi
        add edi, 4
        Repeta2:
            scasw
            ja MaiMare
            sub edi, 2
            mov dx, [edi]
            mov [edi], ax
            mov ax, dx
            mov [esi], dx
            add edi, 2
            MaiMare:
            add edi, 2
        loop Repeta2
        add esi, 4
        pop ecx
    loop Repeta

    push dword 0
    call [exit]