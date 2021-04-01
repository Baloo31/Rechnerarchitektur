bits 32 
; x - (a*a+b) / (a+c/a); 
; a,c-byte; b-doubleword; x-qword
; fara semn
global  start 
extern  exit 
import  exit msvcrt.dll; 
segment  data use32 class=data 
    a db 100
    c db 200
    b dd 190000
    x dq 10000000000
segment  code use32 class=code
start:
        MOV al, [a] 
        MUL al ; AX contine a*a
        MOV dx, 0 ; DX:AX contine a*a
        MOV bx, [b]
        mov cx, [b+2] ; CX:BX contine b
        ADD BX, AX
        ADC CX, DX ; CX:BX contine (a*a+b)
        mov al, [c]
        mov ah, 0 ; AX contine c
        mov dl, [a]
        div dl ; AL contine c/a
        add dl, al
        adc dh, 0 ; DX contine (a+c/a)
        push cx
        push bx
        pop eax ; EAX contine (a*a+b)
        mov cx, dx ; CX contine (a+c/a)
        push eax
        pop ax
        pop dx ; DX:AX contine (a*a+b)
        DIV cx ; AX contine (a*a+b)/(a+c/a)
        MOV ECX, 0
        MOV EBX, 0
        MOV BX, AX ; ECX:EBX contine (a*a+b)/(a+c/a)
        MOV EAX, [x]
        MOV EDX, [x+4] ; EDX:EAX contine x
        SUB EAX, EBX
        SBB EDX, ECX ; EDX:EAX contine rezultatul           
push dword 0
call [exit]