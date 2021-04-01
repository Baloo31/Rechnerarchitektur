; 28. Se citesc de la tastatura numere (in baza 10) pana cand se introduce cifra 0. 
; Determinaţi şi afişaţi cel mai mare număr dintre cele citite. 
bits 32
global start        
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    n dd 0
    format db '%d', 0
segment code use32 class=code       
start:                                  
    mov eax, 0 ; in eax dorim sa obtinem valoarea rezultat 
    push eax
    push dword n
    push dword format
    call [scanf]  ; citim prima valoare in exteriorul struturii repetitive
    add esp, 4*2  ; golim parametrii de pe stiva
    pop eax
    mov eax, [n]  ; punem valoarea citita in eax presupunand ca aceasta este maximul
    cmp eax, 0  ; verificam daca prima valoare citita este 0 iar in acest caz sarim peste loop  
    jz nurepeta
    repeta:
        push eax ; punem valoarea maximului pe stiva pentru a nu o pierde dupa executia functiei scanf
        push dword n
        push dword format
        call [scanf]    
        add esp, 4*2  
        ; citim un alt numar din sir
        pop eax ; readucem valoarea in eax
            
        cmp dword [n], 0 ; daca acesta este 0 iesim din loop  
        jz nurepeta
        cmp [n], eax ; daca a fost orice alta valoare decat 0, o comparam cu maximul actual
        jle continua ; daca este mai mare, maximul se va actualiza; altfel se vor citi urmatoarele valori din sir pana se atinge valoarea 0
        mov eax, [n]
        continua:
    jmp repeta
    nurepeta: 
    push eax
    push dword format
    call [printf]   ; Afisarea rezultatului 
    add esp, 4*2  ; golirea stivei    
push dword 0
call [exit]