;nasm.exe -fobj main.asm
;nasm.exe -fobj function.asm
;alink.exe -oPE -susbsys console -entry start main.obj function.obj
bits 32
global start 
extern myFunction       
extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
segment data use32 class=data	public
    n dd 0
    format db '%d', 0
	format_Afisare db '%s',13,10,0
	rez times 100 db 0
	s times 100 db 0
segment code use32 class=code   public    
start:                                  
    repeta:
        
        push dword n
        push dword format
        call [scanf]    
        add esp, 4*2  
        ; citim un alt numar din sir
            
        cmp dword [n], +1 ; daca acesta este 0 iesim din loop  
        jz nurepeta
		
		
		push dword [n]
		push dword  rez
		call myFunction
		add esp,8
		
		mov ecx,0
		loop2:
		cmp byte [rez+ecx],0
		
		je final
		inc ecx
		jmp loop2
		
		
		final:
		mov esi,rez
		add esi,ebx
		dec esi
		std
		mov edi,s
		loop3:
		std
		lodsb
		cld
		stosb
		loop loop3
		
		
		push dword s
		push dword format_Afisare
		call [printf]   ; Afisarea rezultatului 
		add esp, 4*2 
		
		
		
        continua:
    jmp repeta
    nurepeta: 
push dword 0
call [exit]