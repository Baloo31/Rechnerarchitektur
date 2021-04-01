; x-(a+b+c*d)/(9-a); a,c,d-byte; b-doubleword; x-qword ; cu semn
bits 32
global  start 
extern  exit 
import  exit msvcrt.dll; 
segment  data use32 class=data 
    a db -100
    c db 120
    d db -120
    b dd 20000
    x dq 1000000
segment  code use32 class=code
start:  
    mov al, [c]
    imul [d] ; ax contine c*d
    mov bx, ax ; bx contine c*d
    mov al, [a]
    cbw ; ax contine a
    add bx, ax ; bx contine a+c*d
    mov al, [b]
    cbw ; ax contine b
    add ax, bx ; ax contine (a+b+c*d)
    mov bl, 9
    sub bl, [a] ; bl contine 9-a
    idiv bl ; AL contine (a+b+c*d)/(9-a)
    cbw
    cwde
    cdq ; EDX:EAX contine (a+b+c*d)/(9-a)
    mov ebx, [x]
    mov ecx, [x+4]
    sub ebx, eax
    sbb ecx, edx ; rezultat final in ECX:EBX  
push dword 0
call [exit]