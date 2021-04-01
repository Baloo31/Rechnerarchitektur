bits 32
global start


extern exit
import exit msvcrt.dll

segment data use32 class=data
a db 11010011b ; = 211 = D3h
b db 10100110b ; = 166 = A6h
c db 10001110b ; = 142 = 8Eh
d db 00110111b ; = 55 = 37h

segment code use32 class=code
start:
mov bl, [a] ; bl = 211 = D3h
and bl, 70h ; bl = 50h ; Mascam bitii 4-6 ai lui a
shr bl, byte 4 ; bl = 05h ; Mutam bitii 4-6 ai lui a pe pozitiile 0-3
mov ax, 0 ; ax = 0
add al, bl ; al += bl = 05h
mov bl, [b] ; bl = 166 = A6h
and bl, 70h ; bl = 20h ; Mascam bitii 4-6 ai lui b
shr bl, byte 4 ; bl = 02h ; Mutam bitii 4-6 ai lui b pe pozitiile 0-3
add al, bl ; al += bl = 05h + 02h = 07h
mov bl, [c] ; bl = 142 = 8Eh
and bl, 70h ; bl = 00h ; Mascam bitii 4-6 ai lui c
shr bl, byte 4 ; bl = 00h ; Mutam bitii 4-6 ai lui c pe pozitiile 0-3
add al, bl ; al += bl = 07h + 00h = 07h
mov bl, [d] ; bl = 55 = 37h
and bl, 70h ; bl = 30h ; Mascam bitii 4-6 ai lui d
shr bl, byte 4 ; bl = 03h ; Mutam bitii 4-6 ai lui d pe pozitiile 0-3
add al, bl ; al += bl = 07h + 03h = 0Ah
    push dword 0
    call [exit]