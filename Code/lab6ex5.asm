; 5. Es werden zwei Strings of Bytes s1 und s2 angegeben. 
; Bilden Sie den String von Bytes d, die für jedes Byte von s2 seine Position in s1 enthält, oder andernfalls 0. 
; Beispiel: 
; pos: 1, 2, 3, 4, 5 
; s1: 7, 33, 55, 19, 46 
; s2: 33, 21, 7, 13, 27, 19, 55, 1, 46 
; d: 2, 0, 1, 0, 0, 4, 3, 0, 5 
bits 32
global  start
extern  exit
import  exit msvcrt.dll;
segment  data use32 class=data
    pos db 1, 2, 3, 4, 5
    s1 db 7, 33, 55, 19, 46
    len1 equ $-s1; constanta ce are ca valoare lungimea sirurilor s1 si pos
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46
    len2 equ $-s2; constanta ce are ca valoare lungimea sirurilor s2 si d
    d db 0, 0, 0, 0, 0, 0, 0, 0, 0
segment  code use32 class=code
start:
    mov EDI, 0
    cld ; DF este gol(valoarea 0),deci parcurgem sirul de la stanga la dreapta
    mov ECX, 1 
    loop1:
        MOV AL,[EDI+s2] ; In AL am un element din S2
        MOV ESI, 0 ; Initializare ESI
        ADD ECX, 1
        loop2: ; Compar fiecare element din S2 cu fiecare din S1
            MOV BL, [ESI+s1] ; In BL am un element din S1
            cmp AL, BL ; scadere fictiva intre un element din s2 si unul din s1
            jz egal
            egal:
                MOV [EDI+d], [ESI+pos] ; in destinatia d adaug ca element pozitia la care am gasit elementele egale
            INC ESI
            ; stabilesc daca ies sau nu din loop 
            cmp esi, len1 
            jnz continue
            continue:
                ADD ECX, 1
        loop loop2
        INC EDI
        ; stabilesc daca parasesc si acest loop
        cmp EDI, len2 
        jnz eg
        eg:
            ADD ECX, 1
    loop loop1
push dword 0
call [exit]