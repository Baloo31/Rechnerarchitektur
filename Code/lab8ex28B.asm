;28. Se da un nume de fişier (definit in segmentul de date). Sa se creeze un fişier cu numele dat, apoi sa se citeasca de la ;tastatura cuvinte pana cand se citeste de la tastatura caracterul '$'. Sa se scrie in fişier doar cuvintele care contin cel putin o litera mica (lowercase).
bits 32
global start        
extern exit, fopen, fprintf, fclose, scanf             
import exit msvcrt.dll    
import fopen msvcrt.dll  
import fprintf msvcrt.dll
import fclose msvcrt.dll  
import scanf msvcrt.dll                        
segment data use32 class=data
    fisier db "output.txt", 0  ; numele fisierului care va fi creat
    acces db "w", 0          ; modul de deschidere a fisierului 
    descriptor dd -1
    cuv db 0
    format db '%s', 0
    len db 10
segment code use32 class=code
start:
    push dword acces     
    push dword fisier
    call [fopen] ; Deschidem fisierul output.txt, iar in cazul in care acesta nu exista, se va creea
    add esp, 4*2 ; eliminam parametrii de pe stiva
    mov [descriptor], eax ; salvam valoarea returnata de fopen in variabila descriptor pentru verificare  
    ; verificam daca functia fopen a creat cu succes fisierul, iar in cazul in care s-a produs o eroare (eax=0) sare la final
    cmp eax, 0
    je final
    push dword cuv
    push dword format
    call [scanf]  ; citim prima valoare in exteriorul struturii repetitive
    add esp, 4*2
    cmp byte [cuv], 36  ; verificam daca prima valoare citita este $ (in ascii, $ are codul 36 in zecimal) iar in acest caz sarim peste loop  
    jz nurepeta
    repeta:
        cld ; df = 0
        mov esi, cuv
        mov ecx, [len]
        myloop:
            lodsb ; aduc cate o litera in AL
            cmp al, 97 ; 97 este codul pt caracterul "a"
            jb continua
            cmp al, 122 ; 122 este codul pt caracterul "z"
            ja continua
            ;ajung aici doar daca am gasit o litera mica (a-z)
            jmp literamica:
            continua:
        loop myloop:
        ; Daca nu am litere mici iese din loop prin conditia ecx = 0 deci am doar litere mari
        jmp nuliteramica ; sare in acest caz peste scrierea in fisier a cuvantului
        
        literamica: ; ajung aici doar daca am gasit o litera mica in cuvant
            push dword cuv ; Daca loop-ul a fost parcurs complet 
            push dword [descriptor]
            call [fprintf] ; printeaza in fisier cuvantul
            add esp, 4*2
        nuliteramica:
        ; Citesc urmatorul cuvant
        push dword cuv
        push dword format
        call [scanf] 
        add esp, 4*2  
        cmp byte [cuv], 36 ; daca acesta este 0 iesim din loop  
        jz nurepeta
    jmp repeta
    
    nurepeta:
    push dword [descriptor]
    call [fclose] ; inchidem fisierul dupa punerea rezultatului
    add esp, 4 ; golim parametrii de pe stiva
    final:
push dword 0      
call [exit]       
