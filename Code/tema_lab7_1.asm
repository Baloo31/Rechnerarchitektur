bits 32
global start


extern exit
import exit msvcrt.dll

segment data use32 class=data
s1 db 1, 3, 6, 2, 3, 7
l equ $-s1
s2 db 6, 3, 8, 1, 2, 5
d times l db 0

segment code use32 class=code
start:
mov esi, 0 ; esi = 0
mov ecx, l ; ecx = 6
Repeta:
    mov al, [s1 + esi] ; al = 1, 3, 6, 2, 3, 7
    mov bl, [s1 + esi + l] ; bl = 6, 3, 8, 1, 2, 5
    cmp al, bl ; se face fictiv al - bl si se seteaza flag-urile
    jle Mic ; daca al <= bl se sare la tag-ul Mic
    mov [d + esi], al ; daca al > bl atunci se adauga in sirul d elementul curent din s1
    jmp NuMic
    Mic:
    mov [d + esi], bl ; daca bl >= al atunci se adauga in sirul d elementul curent din s2
    NuMic:
    inc esi ; esi = esi + 1
loop Repeta ; ecx = ecx - 1

    push dword 0
    call [exit]