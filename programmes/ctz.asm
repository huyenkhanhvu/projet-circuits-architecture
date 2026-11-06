.ORIG x3000

LD R1, TEST_CONTENU

ctz:
    ; entree R1=x (x!=0)
    ; sortie R0=ctz(x) (nb de zero a droite)

    ; prologue: sauver les registres temporaires qu'on va modifier
    ADD R6, R6, #-3 ; réserve 3 mots sur la pile
    STR R1, R6, #0  ;save R1
    STR R2, R6, #1 
    STR R3, R6, #2
    ; ctz(x) = POPCNT(x XOR (x − 1)) − 1
    ADD R2, R1, #-1 ; R2=x-1
    
    ; XOR (Opcode 1001)
    ; Syntaxe supposée : XOR DR, SR1, SR2
    XOR R3, R1, R2  ; R3 = x XOR (x - 1)
    
    ; POPCNT (Opcode 1101)
    POPCNT R0, R3   ; R0 = POPCNT(R3) ou R0=POPCNT(x XOR (x − 1))
    ADD R0, R0, #-1 ; resultat = R0-1

    ; epilogue: restaurer
    LDR R1, R6, #0  ; restore R1
    LDR R2, R6, #1     
    LDR R3, R6, #2      
    ADD R6, R6, #3  ; libère la pile
    RET

TEST_CONTENU: .FILL 64
.END