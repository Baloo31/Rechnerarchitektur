bits 32 
global start        
extern exit,printf,scanf
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll
segment data use32 class=data
    output db "%d",0
    format db "%d",0
    numar db 0                 
segment code use32 class=code
    factorial:
        mov ecx, [esp+4] 
        jecxz sf 
        dec ecx; 
        push ecx;   
        call factor; apelam functia cu parametrul curent valoarea de pe stiva
        mul dword [esp+8]; inmultim cu valoarea coresp. pasului actual
        add esp,4; eliberam stiva de parametrul utilizat pentru a ajunge la adresa de revenire a pasului anterior
        jmp return; salt la eticheta return pentru a putea invoca revenirea din subprogram
        
   sf:
        mov eax,1;cum recursivitatea noastra are doua cazuri am ajuns in cazul in care ecx e 0 si returnam 1 – conditia de oprire 
        ;0!=1
        return:
        ret ;ne intoarcem la pasul anterior sau in programul principal
   start:
        push dword numar
        push dword format
        call [scanf]
        add esp,4*2 
        
        mov ecx,0
        mov eax,0;pregatim registrii pentru apelare
        push dword [numar] ; salvam pe stiva valoarea citita
        call factorial

        ;afisarea rezultatului
        push eax
        push output
        call [printf]
push dword 0
call [exit]