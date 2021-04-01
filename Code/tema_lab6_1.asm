bits 32
global start


extern exit
import exit msvcrt.dll

segment data use32 class=data
a dw 1111001001100011b ; = 62051 = F263h
b db 01110010b ; = 114 = 72h

segment code use32 class=code
start:

mov eax, 0 ; eax = 0
mov al, 0Fh ; eax = 00 00 00 01h = 15 ; Punem pe bitii 0-3 valoarea 1
mov ebx, 0 ; ebx = 0
mov bx, [a] ; bx = 62051 = F263h
mov ecx, 0 ; ecx = 0
mov cl, [b] ; cl = 114 = 72h
mov edx, 0 ; edx = 0
mov dx, bx ; dx = bx = 62051 = F263h
and dx, 000Fh ; dx = 0003h ; Izolam bitii 0-3 ai lui a 
shl dx, byte 4 ; dx = 0030h ; Mutam bitii 0-3 ai lui a pe pozitiile 4-7
or ax, dx ; ax = 0000003Fh ; Punem pe bitii 4-7 ai lui c, bitii 0-3 ai lui a
mov dx, bx ; dx = bx = 62051 = F263h
and dx, 3FF0h ; dx = 3260h ; Izolam bitii 4-13 ai lui a
shl edx, byte 10 ; edx = 00C98000h ; Mutam bitii 4-13 ai lui a pe pozitiile 14-23
or eax, edx ; eax = 00C9803Fh ; Punem pe bitii 14-23 ai lui c, bitii 4-13 ai lui a
mov edx, 0 ; edx = 0
mov dl, [b] ; dl = 114 = 72h
and dl, 0FCh ; dl = 70h ; Izolam bitii 2-7 ai lui b 
shl edx, byte 22 ; edx = 1C000000h ; Punem bitii 2-7 ai lui b pe pozitiile 24-29
or eax, edx ; eax = 1CC9803h ; Punem pe bitii 24-29 ai lui c, bitii 2-7 ai lui b
or eax, 0C0000000h ; eax = DCC9803Fh ; Punem pe bitii 30-31 ai lui c valoarea 1

    push dword 0
    call [exit]