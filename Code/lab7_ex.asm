bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
sirS dd 44332211h, 88776655h, 87654321h, 12345678h
lung equ ($-sirS)/4
sirD times lung db 0
sirD2 times lung dd 0

segment code use32 class=code
start:
; elementele sirului se acceseaza prin [sirS + k*4] cu k de la 0 la 3
mov esi, sirS
mov ecx, lung
mov edi, sirD
jecxz Sfarsit1
cld
Repeta1:
    lodsd
    shr eax, 16
    stosb
    loop Repeta1
Sfarsit1:

mov esi, sirS + 4*(lung-1)
mov ecx, lung
mov edi, sirD2
Repeta2:
    std
    lodsd
    cld
    stosd
    loop Repeta2
    
mov esi, sirS + 4*lung - 1
mov ecx, lung
mov edi, sirD + lung - 1
jecxz Sfarsit3
std
Repeta3:
lodsb
lodsb
stosb
lodsw
loop Repeta3
Sfarsit3:

    push dword 0
    call [exit]