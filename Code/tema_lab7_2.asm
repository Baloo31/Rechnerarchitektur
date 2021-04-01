bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
s1 db '+', '4', '2', 'a', '8', '4', 'X', '5'
l1 equ $-s1
s2 db 'a', '4', '5'
l2 equ $-s2
d times l1 db 0

segment code use32 class=code
start:
  mov esi, 0 ; esi = 0
  mov edi, 0 ; edi = 0
  mov ecx, l1 ; ecx = 8
  Repeta:
    mov al, [s1 + esi] ; al = '+', '4', '2', 'a', '8', '4', 'X', '5'
    push ecx ; pastram valoarea lui ecx pe stiva
    push edi ; pastram valoarea lui edi pe stiva
    mov ecx, l2 ; ecx = 3
    mov edi, 0 ; edi = 0
    RepetaSecund:
        mov bl, [s2 + edi] ; bl = 'a', '4', '5'
        cmp al, bl ; se face fictiv al - bl si se seteaza flag-urile
        jz Iesire ; Daca al = bl atunci se sare la tag-ul Iesire
        inc edi ; edi = edi + 1
        loop RepetaSecund ; se sare la tag-ul RepetaSecund ; ecx = ecx - 1
    Iesire:
    pop edi ; se scoate edi de pe stiva
    cmp ecx, 0 ; se face fictiv ecx - 0 si se seteaza flag-urile
    jnz ApareInSir ; daca ecx <> 0 atunci se sare la tag-ul ApareInSir
    mov [d + edi], al ; se salveaza in variabila d registrul al
    inc edi ; edi = edi + 1
    ApareInSir:
    pop ecx ; se scoate ecx de pe stiva
    inc esi ; esi = esi + 1
  loop Repeta
    push dword 0
    call [exit]