bits 32
; Wir exportieren die Addition -Funktion, um sie im Hauptmodul zu
; verwenden
; exportăm funcţia addition pentru a fi utilizată în modulul principal
global addition
segment code use32 class=code public
; Das Codesegment enthält nur die Additionsfunktion
; segmentul de cod conţine numai funcţia de adunare
concatenare:
    mov esi, [esp+12] ; pointer pe s1
    mov edi, [esp+4] ; pointer pe s3
    mov ecx, [esp+20] ; len1
    cld 
    rep movsb
    
    mov esi, [esp+8] ; pointer pe s2
    mov ecx, [esp+16] ; len2
    cld
    rep movsb
    ret