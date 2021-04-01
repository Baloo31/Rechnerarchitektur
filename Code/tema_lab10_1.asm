;13.Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze: (a+b) * (a-b). Rezultatul inmultirii se va salva in memorie in variabila
;"rezultat" (definita in segmentul de date).
bits 32
global start
extern scanf
extern printf
extern exit
import scanf msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll

segment data use32 class=data
mesaj1 db "a = ", 0
mesaj2 db "b = ", 0
format db "%d", 0
a dd 0
b dd 0
rezultat dd 0

segment code use32 class=code
start:
    ;citim numarul a
    push dword mesaj1 ; punem mesaj1 pe stiva
    call [printf] ; apelam functia printf
    add esp, 4*1 ; aducem esp la valoarea initiala
    push dword a ; punem adresa lui a pe stiva
    push dword format ; punem format pe stiva
    call [scanf] ; apelam functia scanf
    add esp, 4*2 ; aducem esp la valoarea initiala
    
    ;citim numarul b
    push dword mesaj2 ; punem mesaj2 pe stiva
    call [printf] ; apelam functia printf
    add esp, 4*1 ; aducem esp la valoarea initiala
    push dword b ; punem adresa lui b pe stiva
    push dword format ; punem format pe stiva
    call [scanf] ; apelam functia scanf
    add esp, 4*2 ; aducem esp la valoarea initiala
    
    ;calculam (a+b) * (a-b)
    mov eax, [a] ; eax = a
    mov ebx, [b] ; ebx = b
    add eax, ebx ; eax = a + b
    mov ecx, [a] ; ecx = a
    sub ecx, ebx ; ecx = a - b
    imul ecx ; edx:eax = (a+b) * (a-b)
    mov [rezultat], eax ; rezultat = partea low din (a+b) * (a-b)
    mov [rezultat + 4], edx ; rezulat = (a+b) * (a-b)
    
    push dword 0
    call [exit]