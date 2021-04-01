;Se dau un sir care contine n reprezentari binare pe 8 biti date ca sir de caractere. 
;Sa se afiseze pe ecran numerele corespunzatoare reprezentarilor zecimale. 
;Exemplu: 
;Se da: '10100111b', '01100011b', '110b', '101011b' 
;Se stocheaza:  
bits 32
global start
extern exit, printf
import printf msvcrt.dll 
import exit msvcrt.dll
segment data use32 class=data
    sir db '10100111b', '01100011b', '110b', '101011b'
    len equ $-sir
    format db '%d ', 0
    numar db 0
segment code use32 class=code
start:
    xor ebx, ebx
    xor edx, edx
    mov bl, 1
    std 
    mov esi, sir + len-2
    mov ecx, len-1
    repeta:
        lodsb
        cmp al, 'b'
        je salt
            cmp al, '1'
            jnz skip
            add edx, ebx
            skip:
            add bl, bl
            cmp esi, sir-1
            je salt
            jmp next
        salt:
        mov [numar], edx
        push ecx
        push dword [numar]
        push dword format
        call [printf]
        add esp, 8
        pop ecx
        
        mov edx, 0 
        mov bl, 1
        next:
    loop repeta 
push dword 0
call [exit]