;Se citeste o propozitie de la tastatura. 
;Sa se numere literele din fiecare cuvant si sa se afişeze aceste numere pe ecran.

bits 32
global start
extern exit, printf, scanf
import scanf msvcrt.dll
import exit msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data
    sir db 'salut dimas andrei balu', 0
    len equ $-sir
    format db '%s', 0
    format2 db '%u ', 0
    nr dd 0, 0
segment code use32 class=code
start:

    mov ecx, len 
    mov esi, sir
    cld
    repet:
        push ecx
        lodsb ;al = caractere
        cmp al , ' '
        je skip
            cmp al, 'a'
            jb sari 
            cmp al, 'z'
            ja sari 
            inc dword [nr]
            cmp esi, sir + len -1
            je skip
            jmp sari 

        skip:

        push dword [nr]
        push dword format2
        call[printf]
        add esp, 8

        mov dword [nr], 0
        sari:
        pop ecx


    loop repet

push dword 0
call [exit]