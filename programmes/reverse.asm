.ORIG x3000

LEA R1, TEST

reverve:
    ; entree R1=x (16bits)
    ; sortie R0=reverse(x)
    ST R1, SAVE_R1  ; sauvegarder R1(x)
    AND R0, R0, #0  ; R0=0
    AND R2, R2, #0  ; R2=0
    ADD R2, R2, #15 ; compteur de boucle de 0->15
    ADD R2, R2, #1  ; R2=16

loop:
    ADD R0, R0, R0  ; decalage a gauche le resultat (R0<<=1)
    ADD R1, R1, #0  ; teste le bit de signe de R1(bit15)
    BRzp skip   ; si positif (bit15=0), on fait rien donc skip
    ADD R0, R0, #1  ; si negatif (bit15=1), on ajote 1
skip:
    ADD R1, R1, R1  ; decalage a gauche l'entree (R1<<=1)
    ADD R2, R2, #-1 ; decrementeur le compteur
    BRp loop    ; on continue jusqu'a compteur <= 0

    LD R1, SAVE_R1  ; restaurer R1
    RET

SAVE_R1 .BLKW 1 ; reserver un emplacement mémoire pour sauvegarder R1

TEST: .FILL	20

.END