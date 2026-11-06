.ORIG x3000

LEA R1, TEST

; Copie la chaine R1 vers R2
; Entrees: R1 (source), R2 (destination)

LOOP
    LDR R3, R1, #0      ; Lire le source
    STR R3, R2, #0      ; Ecrire vers destination
    
    BRz FIN             ; Si char = 0, on a fini de copier

    ADD R1, R1, #1      ; Incremente le source
    ADD R2, R2, #1      ; Incremente le dest
    BRnzp LOOP          ; Si c'est negatif, zero ou positif, on fais une boucle

FIN
    HALT

TEST : .STRINGZ	 "test"
.END