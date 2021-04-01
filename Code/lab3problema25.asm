;(a*a+b+x)/(b+b)+c*c
; a-word
; b-byte
; c-doubleword
; x-qword
bits 32 ;asamblare si compilare pentru arhitectura de 32 biți
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului că exit există, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o funcție care încheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll conține exit, printf si toate celelalte funcții C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele
    a dw -20
    b db -40
    c dd -60
    x dq -80
segment  code use32 class=code ; segmentul de cod
start:

    MOV AX, [a]
    IMUL AX ; DX:AX contine a*a
    ADD AL, [b] ; DX:AX contine a*a+b
    
    PUSH DX
    PUSH AX
    POP EAX ; EAX contine a*a+b
    CDQ
    
    MOV EBX, [x]
    MOV ECX, [x+8] ; ECX:EBX contine pe x
    
    ADD EBX, EAX
    ADC ECX, EDX ; ECX:EBX contine prima paranteza
    
    MOV AL, [b]
    ADD AL, AL ; AL contine b+b
    
    CBW
    CWDE ; EAX contine pe b+b
    
    MOV EDX,ECX
    MOV ECX, EAX; ECX contine b+b
    MOV EAX, EBX; EDX:EAX contine paranteza
    CDQ
    IDIV ECX ; REZULTAT IN EAX
    CDQ
    MOV EBX, EAX
    MOV ECX, EDX ; REZULTAT IN ECX:EBX
    MOV EAX, [c]
    IMUL EAX ; EDX:EAX contine c*c
    
    ADD EAX, EBX
    ADC EDX, ECX
    
push dword 0
call [exit] 