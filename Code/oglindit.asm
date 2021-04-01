bits 32
global start
extern exit               
import exit msvcrt.dll    
segment data use32 class=data
    A db "Andrei"
    L equ $-A
    Rez times 2*L db 0
segment code use32 class=code
    start:
        Mov ecx,L
        Mov esi,A+L-1
        Mov edi,Rez
        Jecxz Final
        Repeta:
            STD
            LODSB
            CLD
            STOSB
        Loop Repeta
        Final:
Push dword 0
Call[exit]   
