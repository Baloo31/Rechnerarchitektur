bits 32 
global start
extern exit 
import exit msvcrt.dll 
segment data use32 class=data 

 

a dw 125 ;ax word
b db 20   ;bh byte
c db 15 ;ch
d db 10 ;dh 
e dd 50 ;eax double
x dq 500 ;edx:eax quadword

 

 

;(a*2+b/2+e)/(c-d)+x/a; fara semn

 

segment code use32 class=code 
start:

 

mov ax, word[a]  ;ax avem valoarea a bits 32 ;bits 32 ; assembling for the 32 bits architecture
mov bl, 2
mov bh, 0 ;in bx avem 2
mul bx ;in dx:ax avem a*2 mul face ax*bx si rezultatul este in dx:ax
push dx
push ax
pop ecx ;din dx:ax am facut ecx


mov al, byte[b]
mov ah, 0 ;in ax avem valoarea b
mov bl, 2
div bl ;in al avem rezultatul si ah restul
mov ah, 0
mov ebx, 0
mov bx, ax ; In ebx avem 10

 

add ecx, ebx ;ecx ai a*2+b/2
mov ebx, dword[e]
add ebx, ecx ; ebx ai (a*2+b/2+e)   136h
mov eax, ebx ; eax (a*2+b/2+e)   136h
 

mov ecx, 0
mov cl, byte[c]
sub cl, byte[d]
mov ch, 0 ;in ecx avem c-d
mov edx, 0
div ecx ;rezultatul este in eax
mov ecx, eax ;rezultatul este ecx (a*2+b/2+e)/(c-d) 62

 
;x/a
mov dx, 0
mov al, byte[a]
mov ah, 0 ;in ax am valoarea a
push dx
push ax
pop ebx ; in ebx avem valoarea a
mov eax, dword[x]
mov edx, dword[x+4]
div ebx ;in eax avem rezultatul x/a si in edx restul

 

add ecx, eax ;rezultatul final trebuie sa fie in ecx

 

 


push dword 0 
call [exit] 