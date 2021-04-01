;Problema  3. Se  dau  două  şiruri  de  ,p  BYTE sir1 şi sir2,  
;de  aceeaşi  lungime, interpretate ca fiind numere fără semn. 
;Putem nota elementele şirurilor sir1 şi sir2 cu elem1 şi respec,v elem2. 
;Să se genereze şirul sir3, de aceeaşi lungime, ale cărui elemente le putem nota cu elem3, as@el:  -elem3 de pe poziţia 0 = 1 -elem3 de pe poziţia 1 = 1 -elem3 de pe poziţia m = elem2 de pe poziţia (m-2) - 4*elem1 de pe poziţia (m-1) de pe poziţia m, unde m ≥ 2.  Ce ,p de date vor avea elementele şirului sir3? Explicați!

bits 32
global  start 
extern  exit 
import  exit msvcrt.dll; 
segment  data use32 class=data 
    sir1 db 1, 2, 3, 4
    sir2 db 5, 6, 7, 8
    p equ $-sir2
    sir3 times p db 0
segment  code use32 class=code
start:
    MOV ECX, [p] ; pun in ecx lubgimea (loop de p ori)
    sub ecx, 2 ; incep de la al treilea element
    jecxz gata
    MOV [sir3], 1 ; Initializez primul el din dest
    MOV [sir3 + 1], 1 ; Initializez al doilea el din dest
    MOV ESI,2 ; incep de la al treilea
    CLD ; DF = 0 => parcurg de la tanga la dreapta sirurile 1 si 2
    repeta:
        MOV AL, [sir1 + ESI-1]
        MOV BL, [sir2 + ESI-2]
        shl AL, 2 ; Al = 4*AL
        sub Bl, AL ; BL = BL - 4*AL
        MOV [sir3 + ESI], BL ; Pun rezultatul in sirul destinatie
        inc ESI
    loop repeta
    gata:
push dword 0
call [exit]
; Explicatie: Primele doua siruri avand elemente de tip byte vom obtine si in al treilea sir tot elemente de tip byte