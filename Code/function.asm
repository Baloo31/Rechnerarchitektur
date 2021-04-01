bits 32 
global myFunction




segment code use32 class=code public
myFunction:

mov eax,[esp+8]
mov esi,[esp+4]
mov cx,9
mov ebx,0

push eax
pop ax
pop dx

myloop:

div cx;dx=avem restul,catul=ax
mov [esi+ebx],dl
add byte [esi+ebx],48;convertim cifra in caracter ca sa o afisam(sir de cifre(caractere))
inc ebx
mov dx,0
cmp ax,0
je final
jmp myloop

final:



ret
