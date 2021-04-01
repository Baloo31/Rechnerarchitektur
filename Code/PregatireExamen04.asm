; Problema examen info romana rezolvata si verificata
bits 32
global start
extern exit, printf, scanf
import scanf msvcrt.dll
import exit msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    sir dq 1010101010101010b, 110010b, 101010101010101010b, 11111110b
    len equ ($-sir)/8
    max dd 0 
    nrmax dq 0
    cont dd 0 
    c dd 0
    nr dq 0
    format db "Numarul %x%x in care 10 apare de %u de ori", 0
segment code use32 class=code
start:
    cld
    mov ecx, len
    mov esi, sir
    repeta:
        lodsd ; in al aduc partea low
        push EAX ; o pun pe stiva
        lodsd ; aduc in eax partea high
        mov edx, eax ; o duc in edx
        pop eax ; aduc partea low inapoi
        push ecx
        mov ecx, 32
        
        mov dword[nr+4], edx
        mov dword[nr], eax
        
        ; aflu primul bit din EAX
        mov ebx, eax
        shr ebx, 31
        test ebx, 01h
        jz skip
        inc dword [c]
        skip:
        repeta2:
            rcr eax, 1  
            jc continua
            ;verifici daca ultima cifra din eax este 1 si daca da, aduni la contor
            test eax, 01h ; verificam daca ultima cifra e 1
            jz continua
                inc dword [cont] ; ajungem aici doar daca ultima cifra e 1 si crestem contorul
            continua:
        loop repeta2
        cmp dword [c], 0
        jnz skip2
        test edx, 01h
        jz skip2
            inc dword [cont]
        skip2:
        mov ecx, 32
        repeta3:
            rcr edx, 1 
            jc continua2
            ;verifici daca ultima cifra din eax este 1 si daca da, aduni la contor
            test edx, 01h ; verificam daca ultima cifra e 1
            jz continua2
                inc dword [cont] ; ajungem aici doar daca ultima cifra e 1 si crestem contorul
            continua2:
        loop repeta3
        mov ebx, dword [cont]
        cmp ebx, dword [max]
        jng peste
        ; Actualizare aparitii maxime
        mov dword [max], ebx
        ; Actualizare numar
        mov edx, dword [nr+4]
        mov eax, dword [nr]
        mov dword [nrmax+4], edx
        mov dword [nrmax], eax
        peste:
        mov dword [cont], 0
        pop ecx
        dec ecx
    jnz repeta
    ; Afisare
    push dword [max]
    push dword [nrmax]
    push dword [nrmax+4]
    push dword format
    call [printf]
    add esp, 4 * 4
push dword 0
call [exit]