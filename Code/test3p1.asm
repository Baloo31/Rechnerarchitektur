bits 32
global start       
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data	public
    n db 0
    m db 0 
    k db 0
    formatn db '%u', 0
    formatm db '%u', 0
    formatk db '%u', 0
    format_afisare db 'A ramas copilul cu numarul %u ', 0
    mesajinvalid db 'Va rugam introduceti un numar natural mai mic sau egal cu 255'
segment code use32 class=code   public   
joc: 
    xor ax, ax ; dorim sa obtinem rezultatul in AH
    xor cx, cx
    mov al, [esp + 4] ; n
    mov bl, [esp + 8] ; m
    mov cl, [esp + 12] ; k
    add ax, cx
    add ax, 1
    div bl ; Rezultatul in AH
    ; Afisarea rezultatului	
	push dword ah
	push dword format_afisare
	call [printf]    
	add esp, 4*2 


    ret 

start: 
    ; In acest loop s-au citit valorile si s-a facut validarea pentru fiecare
    ; Validarea va determina intoarcerea la instructiunea repeta 
    ; si recitirea valorilor pana acestea sunt valide
    repeta:
        
        ; Citire numarul n
        push dword n
        push dword formatn
        call [scanf]    
        add esp, 4*2
        
        cmp byte [n], 0
        jb invalid
        cmp byte [n], 255
        ja invalid
        
        ; Citire numarul m
        push dword m
        push dword formatm
        call [scanf]    
        add esp, 4*2  
        
        cmp byte [m], 0
        jb invalid
        cmp byte [m], 255
        ja invalid
        
        ; Citire numarul k
        push dword k
        push dword formatk
        call [scanf]    
        add esp, 4*2 
        
        cmp byte [k], 0
        jb invalid
        cmp byte [k], 255
        ja invalid

        jmp valid
        invalid:
        ; Se afiseaza mesajul corespunzator
        push dword [n]
        push dword mesajinvalid
        call [printf] 
        
    jmp repeta   
    valid:   
    
    ; punerea pe stiva a celor 3 parametrii
    push dword [k]
    push dword [m]
    push dword [n]
    call joc ; Apelam functia care determina rezultatul
     
push dword 0
call [exit]