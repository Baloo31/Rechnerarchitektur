bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    cod db 'V565'
    mesaj_vizitator db 'Va rugam folositi usa numarul 7'
    mesaj_ db 'Accesul a fost realizat'
    mesaj2 db 'Nu s-a putut realiza accesul'
segment code use32 class=code
start:
        ;comparam fiecare caracter, daca nu este valid sarim la eticheta sfarsit
        mov esi, cod ;punem la in esi adresa lui cod 
        cmp esi, 'A'
        je sari 
        cmp esi, 'G' ;comparam primul element din esi cu A,G,J,V
        je sari 
        cmp esi, 'J'
        je sari 
        cmp esi, 'V'
        jne sfarsit 

        push dword mesaj_vizitator 
        call [printf]  ;afisamn pe ecran mesajul 'va rugam folositi usa numarul 7'
        add esp, 4

        sari:

        inc esi ;trecem la urmatorul caracter 

        cmp esi, '5'
        jb sfarsit 
        cmp esi, '7'
        ja sfarsit

        inc esi ;trecem la urmatorul caracter

        cmp esi, '2'
        jb sfarsit 
        cmp esi, '8'
        ja sfarsit
 
        inc esi ;trecem la urmatorul caracter

        cmp esi, '1'
        jb sfarsit 
        cmp esi, '5'
        ja sfarsit
 
        push dword mesaj_acces ;afisam pe ecran mesajul accesului permis
        call [printf]
        add esp, 4

        jmp peste;sarim peste eticheta sa nu afisam si mesajul 2

        sfarsit:

        puish dword mesaj_eroare ; afisam eroarea in validarea codului
        call [printf]
        add esp, 4

        peste:

push dword 0
call [exit]