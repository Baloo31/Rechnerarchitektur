; a - byte, b - word, c - double word, d - qword
; d+c-b+(a-c)
bits 32 ;asamblare si compilare pentru arhitectura de 32 biți
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului că exit există, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o funcție care încheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll conține exit, printf si toate celelalte funcții C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a db 7Dh ; 125
	b dw 0EA60h ; -5536
	c dd 0ABCDA4h ; 11259300
	d dq 0BDBDEFDCBBh ; 814935432379
segment  code use32 class=code ; segmentul de cod
start: 	
        MOV AL, [a] ; AL contine pe a
        CBW ; AX contine pe a
        CWDE ; EAX contine pe a
        
        MOV EBX, [c]
        SUB EAX, EBX  ; EAX contine (a-c)
        MOV EBX, EAX ; EBX contine (a-c) ; -11.259.175
        MOV AX, [b]
        CWDE ; EAX contine b
        MOV ECX, [c] ; ECX contine pe c
        SUB ECX, EAX ; ECX contine pe c-b 
        MOV EAX, ECX ; EAX contine pe c-b ; 11.264.836
        ADD EAX, EBX ; EAX contine pe c-b+(a-c) 
        CDQ ; EDX:EAX contine pe c-b+(a-c) ; 5661
        
        MOV EBX, [d]
        MOV ECX, [d+4] ; ECX:EBX contine d
        
        ADD EAX, EBX
        ADC EDX, ECX  ; EDX:EAX contine d+c-b+(a-c) => EDX: 000000BD ; EAX: BDEFF2D8
        
	push dword 0
	call [exit] 	