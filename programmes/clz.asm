.ORIG x3000

LD R1, TEST_CONTENU

clz:
    ; entree R1=x (x!=0)
    ; sortie R0=clz(x) (nb de zero a gauche)
    ;contraine: ne pas modifier R1,R2... sauf R0. R7 ignore
    ; prologue: sauvegarde des registres temporaires qu'on va utiliser
    ADD R6, R6, #-1 ; reserver 1 mots sur la pile
    STR R1, R6, #0  

    AND R0, R0, #0  ; compteur initialise a 0
loop:
    ADD R1, R1, #0  ; teste le bit de signe
    BRn fin ; si negatif(bit15=1), on arrête car y a plus de 0 en tete
    
    ADD R0, R0, #1  ; sinon on a un zero en tete -> incremente le compteur
    ADD R1, R1, R1  ; decalage a gauche (x << 1)
    BRnzp loop 
fin:
    ; epilogue: restaurer les registres
    LDR R1, R6, #0
    ADD R6, R6, #1  ; libere la pile
    RET

TEST_CONTENU : .FILL 71


.END