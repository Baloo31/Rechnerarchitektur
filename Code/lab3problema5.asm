;(a+b/c-1)/(b+2)-x
; a-doubleword
; b-byte
; c-word
; x-qword
bits 32 ;asamblare si compilare pentru arhitectura de 32 biți
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului că exit există, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o funcție care încheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll conține exit, printf si toate celelalte funcții C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele
    a dd 216
    b db 183
    c dw 100
    x dq 70
    unu EQU 1
    doi EQU 2
segment  code use32 class=code ; segmentul de cod
start:

    MOV EAX, 0
    ADD AL, [b] ; AX retine acum valoarea variabilei b
    MOV DX, 0 ; Umplere DX cu 0
    MOV CX, [c] ; CX retine c
    DIV CX ; In AX se va retine (b/c) 
    SUB AX, unu 
    MOV EDX, [a]
    ADD EAX, EDX; EAX contine (a+b/c-1)
    
push dword 0
call [exit] 