;17.Sa se citeasca de la tastatura un numar in baza 10 si sa se afiseze valoarea acelui numar in baza 16
bits 32
global start
extern exit
extern printf
extern scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
mesaj db "n = ", 0
n dd 0
format1 db "%d", 0
format2 db "Numarul %d este %x in baza 16", 0
segment code use32 class=code
start:
    ;citim numarul n
    push dword mesaj ; punem pe stiva mesajul "n = "
    call [printf] ; apelam functia printf
    add esp, 4 ; aducem esp la valoarea initiala
    push dword n ; punem pe stiva adresa lui n
    push dword format1 ; punem pe stiva format1
    call [scanf] ; apelam functia scanf
    add esp, 4*2 ; aducem esp la valoarea initiala
    
    ;afisam pe n si valoarea acestuia in hexa
    push dword [n] ; punem pe stiva numarul n
    push dword [n] ; punem pe stiva numarul n
    push dword format2 ; punem pe stiva format2
    call [printf] ; apelam functia printf
    add esp, 4*3 ; aducem esp la valoarea initiala
    
    push dword 0
    call [exit]