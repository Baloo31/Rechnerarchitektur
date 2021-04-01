; Se dau cuvintele A si B. Se cere cuvântul C format astfel:
;- biţii 0-2 ai lui C coincid cu biţii 10-12 ai lui B
;- biţii 3-6 ai lui C au valoarea 1
;- biţii 7-10 ai lui C coincid cu biţii 1-4 ai lui A
;- biţii 11-12 ai valoarea 0
;- biţii 13-15 ai lui C coincid cu inversul biților 9-11 ai lui B

bits 32
global  start 
extern  exit 
import  exit msvcrt.dll; 
segment  data use32 class=data 
    a dw 0111011101010111b
    b dw 1001101110111110b
    c dw 0
segment  code use32 class=code
start:
    mov  bx, 0 ; în registrul BX vom calcula rezultatul
    mov  ax, [b] ; izolăm biții 10-12 ai lui b
    and  ax, 0001110000000000b
    mov  cl, 10
    ror  ax, cl ; rotim 10 poziții spre dreapta
    or   bx, ax ; punem biţii in rezultat

    or   bx, 0000000001111000b ; facem biţi 3-6 din rezultat să aibă valoarea 1
    
    mov  ax, [a] ; izolăm biții 1-4 ai lui a
    and  ax, 0000000000011110b
    mov  cl, 6
    rol  ax, cl ; rotim 6 poziții spre stânga
    or   bx, ax ; punem biții în rezultat

    and  bx, 1110011111111111b ; facem biţi 11-12 din rezultat să aibă valoarea 0

    mov  ax, [b]
    not  ax ; inversăm valoarea lui b
    and  ax, 0000111000000000b ; izolăm biţi 9-11 ai lui b
    mov  cl, 4
    rol  ax, cl ; deplasăm biții 4 poziții spre stânga
    or   bx, ax ; punem biţii în rezultat

    mov  [c], bx ; punem valoarea din registru în variabila rezultat
    
push dword 0
call [exit]