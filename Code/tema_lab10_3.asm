;13.Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si caractere speciale. Sa se transforme toate 
;literele mici din textul dat in litere mari. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.
bits 32
global start
extern exit
extern fopen
extern fprintf
extern fclose
import exit msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
numeFisier db "lab10_3.txt", 0
modAcces db "w", 0
text db "Salut sunt Rares @5432", 0
lungime db $-text-1
diferenta equ "a"-"A"
descriptor dd 0
segment code use32 class=code
start:
    ;transformam toate literele mici in litere mari
    mov ecx, [lungime] ; mutam in ecx numarul de caractere din text
    mov esi, text ; mutam in esi adresa textului
    Repeta:
        ;compara caracterele din text cu a si z pentru a vedea daca sunt litere
        cmp byte [esi], "a" 
        jb NuEste
        cmp byte [esi], "z"
        ja NuEste
        ;in cazul in care caracterele sunt litere, le transforma in caractere mari
        sub byte [esi], byte diferenta
        NuEste:
        add esi, 1 ; esi = esi + 1
    loop Repeta

    ;deschidem fisierul pentru scriere
    push dword modAcces ; punem pe stiva modul de acces
    push dword numeFisier ; punem pe stiva numele fisierului
    call [fopen] ; apelam functia fopen
    add esp, 4*2 ; aducem esp la valoarea initiala
    cmp eax, 0 ; compara eax cu 0 pentru a vedea daca s-a deschis corect fisierul
    je Sfarsit
    mov [descriptor], eax ; salveaza eax in variabila descriptor
    
    ;scriem in fisier textul
    push dword text ; punem pe stiva textul
    push dword [descriptor] ; punem pe stiva descriptorul fisierului
    call [fprintf] ; apelam functia fprintf
    add esp, 4*2 ; aducem esp la valoarea initiala
    
    ;inchidem fisierul
    push dword [descriptor] ; punem pe stiva descriptorul fisierului
    call [fclose] ; apelam functia fclose
    add esp, 4 ; aducem esp la valoarea initiala
    
    Sfarsit:
    push dword 0
    call [exit]