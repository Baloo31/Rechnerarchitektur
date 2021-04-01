; Es werden zwei Strings of Bytes A und B angegeben. BIlden Sie die Zeichenfolge R,
; die nur die ungeraden und positiven Elemente der beiden Zeilen enthält.
bits 32
global  start 
extern  exit 
import  exit msvcrt.dll; 
segment  data use32 class=data 
    A db 2, 1, 3, -3
    lena equ $-A ; constanta ce are drept valoare lungimea sirului A
    B db 4, 5, -5, 7
    lenb equ $-B ; constanta ce are drept valoare lungimea sirului B
    R db 0, 0, 0, 0, 0, 0, 0, 0
segment  code use32 class=code
start:
    MOV ESI, A
    MOV EDI, R
    MOV ECX, lena
    CLD ; DF = 0 => crescator
    JECXZ final ; in caz ca sirul are lungime 0, deci ECX =0
    loop1:
        LODSB ; In AL am [ESI+A] ; INC ESI
        CMP AL, 0
        JB compar1
        compar1:
            TEST AL, 1
            JNZ compar2
            compar2:
                STOSB ; In [EDI+B] am valoarea din AL ; INC EDI
    loop loop1
    
    MOV ESI, B
    MOV ECX, lenb
    loop2:
        LODSB ; In AL am [ESI+B] ; INC ESI
        CMP AL, 0
        JB compar3
        compar3:
            TEST AL, 1
            JNZ compar4
            compar4:
                STOSB ; In [EDI+B] am valoarea din AL ; INC EDI
    loop loop2
    final:
push dword 0
call [exit]