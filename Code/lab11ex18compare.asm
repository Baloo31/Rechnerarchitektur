bits 32
global compara
segment code use32 class=code public
compara:
; parametrii sunt în: EBX si EAX
; vom returna rezultatul în EAX
CMP ebx, eax ; Scadere fictiva un element din sir citit si minimul actual
JAE next
    MOV eax, ebx ; Daca gasim un element mai mic decat         
                         ;minimul actual
next:
 ; revenirea din funcţie
ret