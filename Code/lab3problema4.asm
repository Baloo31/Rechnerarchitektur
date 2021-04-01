; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a-word; b,c,d-byte; e-doubleword; x-qword
; (a*2+b/2+e)/(c-d)+x/a
bits 32 ;asamblare si compilare pentru arhitectura de 32 biți
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului că exit există, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o funcție care încheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll conține exit, printf si toate celelalte funcții C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a dw 125
	b db 8
	c dd 150
	d db 200
    e dd 31
    x dw 130
    doi EQU 2
segment  code use32 class=code ; segmentul de cod
start: 	
        
        MOV EAX, 0
        MOV AL, [b] ; AL contine pe b
        MOV ECX, 0
        MOV CL, doi ; CL contine pe 2
        DIV CL ; prin instructiunea asta am adus in AL valoarea impartirii valorii din AX la cea din CL 
               ; AL contine pe b/2
        
        
        MOV EBX, 0
        MOV BL, AL ; BL contine pe b/2
        MOV AX, [a]
        MUL CX ; DX:AX contine pe 2*a
        
        PUSH DX
        PUSH AX
        POP DX ; EAX contine pe 2*a
        
        MOV EDX, [e]
        ADD EAX, EBX
        ADD EAX, EDX ; EAX contine prima paranteza
        
        NEG EAX ; EAX contine -(prima paranteza)
        CDQ ; converteşte cu semn DWORD-ul din EAX la QWORD-ul EDX:EAX;
            ; EDX:EAX contine prima paranteza
        
        MOV ECX, 0
        MOV CL, [c] ; CL contine pe c
        SUB CL, [d] ; CL contine (c-d)
        NEG CL; CL contine -(c-d)
        IDIV ECX ; EAX contine impartirea primelor doua paranteze
        
        MOV ECX, EAX ; ECX contine impartirea primelor doua paranteze
        MOV EAX, [x]
        MOV EDX, [x+8]
        MOV EBX, 0
        MOV BX, [a]
        DIV EBX ; EAX contine x/a
        ADD EAX, ECX ; EAX contine expresia
        
        
	push dword 0 ;se pune pe stiva codul de retur al funcției exit
	call [exit] ;apelul funcției sistem exit pentru terminarea execuției programului