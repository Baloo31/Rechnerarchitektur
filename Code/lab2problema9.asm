; 3*[20*(b-a+2)-10*c]+2*(d-3) ; a,b,c - byte, d - word ; fara semn
bits 32
global  start 
extern  exit 
import  exit msvcrt.dll; 
segment  data use32 class=data 
    a db 100
    b db 150
    c db 50
    d dw 1003
segment  code use32 class=code
start:  
        mov al, [b]
        mov ah, 0
        mov dl, [a] 
        mov dh, 0
        sub al, dl  
        sbb ah, dh ; AX contine (b-a)
        add AX, 2
        
        mov bl, 20
        mul bl ; AX contine 20*(b-a+2)
        mov bx, ax ; BX contine 20*(b-a+2)
        mov al, [c]
        mov cl, 10
        mul cl
        neg ax ; AX contine -10*c
        add ax, bx
        mov dx, 0
        adc dx, 0 ; DX:AX contine [20*(b-a+2)-10*c]
        push dx
        push ax
        pop eax ; EAX contine [20*(b-a+2)-10*c]
        mov ebx, 0
        mov bl, 3 ; EBX contine 3
        mul ebx ; EDX:EAX contine 3*[20*(b-a+2)-10*c]
        mov ebx, eax
        mov ecx, edx ; ECX:EBX contine 3*[20*(b-a+2)-10*c]
        mov ax, [d]
        sub ax, 3
        mov dx, 2
        mul dx ; DX:AX contine 2*(d-3)
        push dx
        push ax
        pop eax ; EAX contine 2*(d-3)
        mov EDX, 0 ; EDX:EAX contine 2*(d-3)
        add eax, ebx
        adc edx, ecx ; EDX:EAX contine rezultatul final
push dword 0
call [exit]