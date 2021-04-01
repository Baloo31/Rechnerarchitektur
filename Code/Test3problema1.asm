;Se da un fişier text. 
;Sa se citeasca continutul fişierului, sa se contorizeze numărul de vocale şi sa se afiseze aceasta valoare. 
;Numele fişierului text este definit in segmentul de date.
bits 32
global start
extern exit
extern scanf
extern fopen
extern fprintf
extern fclose
extern printf
extern fread
import printf msvcrt.dll 
import scanf msvcrt.dll
import exit msvcrt.dll
import fprintf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll

segment data use32 class=data
    fisier db 'data.txt', 0
    mod_acces db 'r', 0 
    descriptor dd -1
    len equ 100 
    text times len db 0
    contor dd 0
    format db 'Fisierul are %d vocale', 0


segment code use32 class=code
start:
    push dword mod_acces ;deschidem fisierul 
    push dword fisier
    call[fopen]
    add esp, 8 

    mov [descriptor], eax 

    cmp dword [descriptor], 0
    je sfarsit

    push dword [descriptor]
    push dword len 
    push dword 1
    push dword text
    call [fread]
    add esp, 16

    mov esi, text 
    mov ecx, eax
    cld
    repeta:
        lodsb ;al este egal cu elementele din sir,creste esi 
        cmp al, 97
        je salt
        cmp al, 117
        je salt
        cmp al, 101
        je salt
        cmp al, 105
        je salt
        cmp al, 111
        je salt
        jmp salt2
        salt:
        inc dword [contor]
        salt2:
    loop repeta ;se repeta, ecx se scade automat 

    push dword [contor]
    push dword format
    call [printf] 
    add esp, 8


    sfarsit:
    push dword [descriptor]
    call[fclose]
    add esp, 4

push dword 0
call [exit]