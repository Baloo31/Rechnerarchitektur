; exercitiul 29
;Se citesc de la tastatura trei numere a, m şi n (a: word, 0 <= m, n <= 15, m > n). 
;Sa se izoleze bitii de la m-n ai lui a şi sa se afiseze numărul intreg reprezentat de acesti bitii in baza 10
bits 32 
global  start 
extern  exit, scanf, printf 
import exit msvcrt.dll 
import scanf msvcrt.dll
import printf msvcrt.dll                        
segment data use32 class=data                   
        a dw 0                                  
        format1 db "%d",0                       
        m dd 0                                  
        format2 db "%d",0                       
        n dd 0                                  
        format3 db "%d",0 
        format4 db "%d",0                       
segment code use32 class=code                                 
start:                                         
       push dword a                             
       push dword format1
       call [scanf]
       add esp, 4 * 2
       ; am citit numarul a
       push dword m
       push dword format2
       call [scanf]
       add esp, 4 * 2
       ; am citit  numarul m
       push dword n
       push dword format3
       call [scanf]
       add esp, 4 * 2
       ; am citit numarul n
       
       mov CL, 15 
       sub CL, byte [m] ; efectuam 15 - m
       mov eax, [a] ; punem in ax valoarea de la adresa a
       shl ax, cl ; deplasam bitii din ax cu 15-m pozitii spre stanga
       
       mov cl, 15 
       sub cl, byte [m]
       add cl, byte [n] ; efectuam 15-m+n
       shr ax, cl ; deplasam cu atatea pozitii spre dreapta pentru a aduce ultimul bit izolat pe pozitia 
       ;bitului cel mai putin semnificativ
       
       push eax
       push dword format4
       call [printf]   ; Afisarea rezultatului 
       add esp, 4*2
push dword 0
call [exit]