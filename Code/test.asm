bits 32
global start        
extern exit
import exit msvcrt.dll
segment data use32 class=data
    sir_sursa DQ 12345678h, 0FFFFFh, 6AAADh
    l equ $-sir_sursa
    sir_dest times l db 0
    SUM DQ 0
    cont resb 1
    nr resb 1  
segment code use32 class=code
    start:

        mov ESI, sir_sursa
        mov EDI, sir_dest
        mov ECX, l
        
        myloop:
        LODSD
        mov EBX, EAX
        LODSD           ;EAX = low dword, EBX = high dword
        
        mov byte [cont], 0
        
        mov byte [nr], 32
        count:
            cmp EAX, 1b
            jnz fin
            inc byte [cont]
            fin:
                dec byte [nr]
                
            cmp byte [nr], 0
        ja count
            
        mov byte [nr], 32
        count2:
            cmp EBX, 1b
            jnz fin2
            inc byte [cont]
            fin2:
                dec byte [nr]
                
            cmp byte [nr], 0
        ja count2
        
        mov AL, [cont]
        STOSB
            
        add [SUM], AL
        
        loop myloop
push    dword 0
call    [exit]