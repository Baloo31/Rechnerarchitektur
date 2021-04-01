global start
; Se citeste de la tastatura un sir de numere in baza 10 fara semn. 
; Sa se determine valoarea minima din sir si sa se afiseze in fisierul min.txt (fisierul va fi creat) 
; valoarea minima, in baza 16
extern exit, scanf, fclose, fopen, fprintf
import exit msvcrt.dll
import scanf msvcrt.dll
import fclose mscvrt.dll
import fopen mscvrt.dll
import fprintf mscvrt.dll

extern compara
segment data use32 class=data public
    n equ 5  ; Numar de elemente
    sir dd 0 ; Un element
    format  dd '%d', 0 
    file_name db 'min.txt', 0
    access_mode db 'w', 0
    min dd 0
    file_descriptor dd -1
segment code use32 class=code public
start:
    push dword sir ; adresa unui element din sir, nu valoarea
    push dword format
    call [scanf]     ; apelam functia scanf pentru citire
    add esp, 4 * 2
    mov eax, [sir] ; Aflu minimul in EAX,  am iitializat cu primul el din sir
 
    MOV ECX, [n] ; Citim n elemente din sir
    jecxz final
    
    dec ecx
    jecxz endloop
    
    repeta:
        ; citim cate un element din sir
        push dword sir ; adresa unui element din sir, nu valoarea
        push dword format
        call [scanf]    ; apelam functia scanf pentru citire
        add esp, 4 * 2  ; eliberam parametrii de pe stiva
        
        mov ebx, [sir]
        call compara
        
    loop repeta
    
    endloop:
    MOV [min], eax ; Punem elementul minim din sir in rezultat
    
    ; Deschidem fisierul
    push dword access_mode
    push dword file_name
    call [fopen] ; deschidere fisier 
    ADD ESP, 4*2 ; eliberam parametrii de pe stiva
    
    mov [file_descriptor], EAX ; In EAX avem descriptorul fisierului si il punem in variabila

    cmp eax, 0 ; Cazul in care a intervenit o eroare in deschidere
    je final ; salt direct la finalul programului

    push dword min
    push dword [file_descriptor]
    call [fprintf] ; scriem in fisier
    ADD ESP, 4*2 ; eliberam parametrii de pe stiva
    
    push dword [file_descriptor]
    call [fclose] ; inchidem fisierul
    ADD ESP, 4 ; eiberam param de pe stiva
    
    final:
 push dword 0
 call [exit]