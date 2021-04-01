; Se citesc din fisierul numere.txt mai multe numere pozitive si negative sa se doua siruri n, p si sa se afiseze pe ecran sirurile
bits 32 
global start        
extern exit, fopen, fread, printf, fclose               
import exit msvcrt.dll    
import fopen msvcrt.dll 
import printf msvcrt.dll 
import fclose msvcrt.dll
import fread msvcrt.dll 
segment data use32 class=data
    n db 0
    p db 0 
    len db 100
    mod_acces db 'r', 0
    nume_fisier db "data.txt", 0 
    descriptor dd -1
    text db 0 
segment code use32 class=code
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor], eax
        cmp eax, 0 
        je sfarsit
        
        push dword [descriptor]
        push dword len 
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        mov esi, text
        mov ecx, eax
        
        push dword [descriptor]
        call [fclose]
        add esp, 4

push dword 0      
call [exit]       
