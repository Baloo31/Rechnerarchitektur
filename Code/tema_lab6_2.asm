bits 32
global start


extern exit
import exit msvcrt.dll

segment data use32 class=data
a dw 1010011110010101b ; = 42901 = A795h
b db 10011101b ; = 157 = 9Dh

segment code use32 class=code
start:
mov ax, [a] ; ax = 42901 = A795h
and ax, 0F00h ; ax = 0700h ; Mascam bitii 8-11 ai lui a
mov bl, [b] ; bl = 157 = 9Dh
and bl, 0F0h ; bl = 90h ; Bitii 0-3 ai lui b vor fi 0
shr ax, byte 8 ; ax = 0007h ; Mutam bitii 8-11 ai lui a pe pozitiile 0-3
or bl, al ; bl = 97h

    push dword 0
    call [exit]