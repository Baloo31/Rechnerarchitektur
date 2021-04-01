;17.Se da un nume de fisier (definit in segmentul de date). Sa se creeze un fisier cu numele dat, apoi sa se citeasca de la tastatura numere si sa se scrie din
;valorile citite in fisier numerele divizibile cu 7, pana cand se citeste de la tastatura valoarea 0.
bits 32
global start
extern exit
extern scanf
extern fopen
extern fprintf
extern fclose
import scanf msvcrt.dll
import exit msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
numeFisier db "lab10_4.txt", 0
modAcces db "w", 0
formatCitire db "%d", 0 
formatScriere db "%d ", 0
a dd 0
descriptor dd 0
segment code use32 class=code
start:
    ;deschidem fisierul pentru scriere
    push dword modAcces ; punem pe stiva modul de acces
    push dword numeFisier ; punem pe stiva numele fisierului
    call [fopen] ; apelam functia fopen
    add esp, 4*2 ; aducem esp la valoarea initiala
    cmp eax, 0 ; comparam eax cu 0 pentru a vedea daca s-a deschis corect fisierul
    je Sfarsit
    mov [descriptor], eax ; salvam descriptorul fisierului
    
    ;citim numere pana cand se citeste 0
    Repeta:
        push a ; punem pe stiva adresa lui a
        push formatCitire ; punem pe stiva formatul pentru citire
        call [scanf] ; apelam functia scanf
        add esp, 4*2 ; aducem esp la valoarea initiala
        cmp dword [a], 0 ; comparam numarul citit cu 0
        je Close
        mov ax, [a] 
        mov dx, [a+2] ; mutam in dx:ax numarul a
        mov bx, 7 ; bx = 7
        idiv bx ; impartim dx:ax la 7
        cmp dx, 0 ; comparam restul impartirii cu 0
        jne SfarsitRepeta
        push dword [a] ; punem pe stiva numarul a
        push dword formatScriere ; punem pe stiva formatul de scriere
        push dword [descriptor] ; punem pe stiva descriptorul
        call [fprintf] ; apelam functia fprintf
        add esp, 4*3 ; aducem esp la valoarea initiala
        SfarsitRepeta:
        jmp Repeta
    Close:
    ;inchidem fisierul
    push dword [descriptor] ; punem pe stiva descriptorul
    call [fclose] ; apelam functia fclose
    add esp, 4 ; aducem esp la valoarea initiala
    
    Sfarsit:
    push dword 0
    call [exit]