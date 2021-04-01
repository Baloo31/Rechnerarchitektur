; programul calculeaza factorialul unui numar si afiseaza in consola rezultatul
; procedura factorial este definita in fisierul factorial.asm
bits 32

global start

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit

; codul definit in factorial.asm va fi copiat aici
%include "factorial.asm"

segment data use32 class=data
	format_string db "factorial=%d", 10, 13, 0
    


segment code use32 class=code
start:
	push dword 6
	call factorial

	push eax
	push format_string
	call [printf]
	add esp, 2*4

	push 0
	call [exit]
    
    
%ifndef _FACTORIAL_ASM_ ; continuăm dacă _FACTORIAL_ASM_ este nedefinit
%define _FACTORIAL_ASM_ ; și ne asigurăm că devine definit
                        ; astfel, %include permite doar o singură includere

;definire procedura
factorial: ; int _stdcall factorial(int n)
	mov eax, 1
	mov ecx, [esp + 4]
	
	repet: 
		mul ecx
	loop repet ; atentie, cazul ecx = 0 nu e tratat!

	ret 4 ; in acest caz 4 reprezinta numarul de octeti ce trebuie eliberati de pe stiva (parametrul pasat procedurii)

%endif