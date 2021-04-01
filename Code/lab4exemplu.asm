; Calculeaza cel mai mic divizor comun
bits 32 ;asamblare si compilare pentru arhitectura de 32 biți
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului că exit există, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o funcție care încheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll conține exit, printf si toate celelalte funcții C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele
    a db 216
    b db 183
segment  code use32 class=code ; segmentul de cod
start:

    MOV AL, [a]
    MOV BL, [b] ; BL retine b
    
myloop:
    MOV AH, 0 ; AX retine valoarea lui a
    DIV BL ; Acum avem catul in AL si restul in AH
    MOV CX, AX ; Copie a catului si restului in cx
    MOV AL, BL
    MOV BL, CH ; BL retine restul
    CMP BL, 0 ; comparam bl cu 0
    JE end_program ; Jump equal
jmp myloop  

end_program:  

push dword 0 ;se pune pe stiva codul de retur al funcției exitcall [exit] ;apelul funcției sistem exit pentru terminarea execuției programului