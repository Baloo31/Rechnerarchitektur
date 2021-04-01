;ab-(100-c)/(bb)+e+x; a-word; b,c-byte; e-doubleword; x-qword cu semn
bits 32 ;asamblare si compilare pentru arhitectura de 32 biți
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului că exit există, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o funcție care încheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll conține exit, printf si toate celelalte funcții C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
    a dw 125 
    b db 2
    c db 50
    e dd 8000
    x dq 30000000
segment  code use32 class=code ; segmentul de cod
start:
    mov bx, [a]
    mov al, [b]
    cbw ; ax il contine pe b
    imul bx ; dx:ax avem ab
    push dx
    push ax
    pop ebx ; ebx contine ab
    mov al, 100
    sub al, [c] ; al avem 100-c
    cbw
    cwde 
    mov ecx, eax ; in ecx avem 100-c
    mov al, [b]
    imul byte [b] ; acum ax avem bb
    push ecx
    mov cx, ax ; avem in cx bb
    pop ax
    pop dx ; dx:ax avem 100 -c 
    idiv cx ; avem in ax (100-c)/(bb)
    cwd
    push ebx
    pop bx
    pop cx ; in cx:bx avem ab
    sub bx, ax
    sbb cx, dx ;  in cx:bx avem ab-(100-c)/(bb)
    mov ax, [e]
    mov dx, [e+2]; avem in dx:ax val[e]
    add ax, bx
    adc dx, cx ; in dx:ax avem ab-(100-c)/(bb)+e
    push dx
    push ax
    pop eax
    cdq ; in edx:eax avem ab-(100-c)/(bb)+e
    add eax, [x]
    adc edx, [x+4] ; in edx:eax ab-(100-c)/(bb)+e+x
    ; trebuie sa avem 1c9e3ae


push dword 0 ;se pune pe stiva codul de retur al funcției exit
call [exit]