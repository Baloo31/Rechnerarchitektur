bits 32
global start        
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    n dd 32
    format db '%d', 0

segment code use32 class=code       ;Read numbers (in base 10) in a loop until the digit '0' is read from the keyboard.
    start:                          ;Determine and display the smallest number from those that have been read.
                
        mov EBX, 0          ; I store in EBX the minimum value
    
        push dword n
        push dword format
        call [scanf]        ;scanf("%d", &n)
        add esp, 4*2        ;clearing the stack
        
        mov EBX, [n]        ; EBX = first read number
        
        cmp [n], EBX        ;if EBX = 0 jump to exitloop
        jz exitloop
        
    
        myloop:
            ;scanf("%d", &n)
            push dword n
            push dword format
            call [scanf]    ;scanf("%d", &n)
            add esp, 4*2    ;clearing the stack
            
            cmp byte [n], 0 ;if n = 0 jump to exitloop
            jz exitloop
            cmp [n], EBX    ; if n < min value (EBX) EBX = n
            jge fin
            mov EBX, [n]
            fin:
        
        ;cmp byte [n], 0
        jmp myloop
        exitloop:
        
        push EBX
        push dword format
        call [printf]       ;printf("%d", EBX)
        add esp, 4*2        ;clearing the stack
        
 

        push    dword 0
        call    [exit]