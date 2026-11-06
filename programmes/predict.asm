.ORIG x3000

    LD R1, TEST_A
    LD R2, TEST_B
    JSR predict_overflow
    HALT


predict_overflow:
    ; entrees R1=a,R2=b (unsigned 16bits)
    ; sortie R0 ( '=0' -> risque, '<0'-> pas overflow, '>0'-> overflow
    
    ; avec a==0 ou b==0 -> produit=0 => pas overflow
    ADD R0, R1, #0
    BRz no_overflow
    ADD R0, R2, #0
    BRz no_overflow

    ; sauvegarde les adresses de retour
    ST R1, SAVE_R1
    ST R2, SAVE_R2
    ST R7, SAVE_R7      

    ; calcul clz(a) -> R3
    JSR clz_sub ; appel sous routine clz
    ADD R3, R0, #0  ; R3 = CLZ(R1) ou R3=za
    
    ; calcul clz(b) -> R4
    LD R1, SAVE_R2  ; charger R2 dans R1 pour appel clz
    JSR clz_sub ; appel sous routine clz
    ADD R4, R0, #0  ; R4 = CLZ(R2) ou R4=zb
    
    ; somme S=za+zb
    ADD R5, R3, R4  ; R5 = S
    
    ; si S>=16 -> pas overflow
    ADD R0, R5, #-16
    BRzp no_ovf

    ; si S==15 -> risque
    ADD R0, R5, #-15
    BRz risk    ; si S-15=0 -> risque
    ; sinon (S<=14) -> overflow sure
overflow_sure:
    LD R0, val_pos  ; charge val positif dans R0
    BRnzp fin_pred

no_ovf:
    LD R0, val_neg  ; charge val negatif dans R0
    BRnzp fin_pred

risk:
    AND R0, R0, #0  ; charge 0 dans R0
    BRnzp fin_pred

fin_pred:
    LD R1, SAVE_R1
    LD R2, SAVE_R2
    LD R7, SAVE_R7
    RET

no_overflow:
    LD R0, val_neg  ; charge val negatif dans R0
    RET

val_neg .FILL #-1
val_pos .FILL #1
SAVE_R1 .BLKW 1
SAVE_R2 .BLKW 1
SAVE_R7 .BLKW 1
TEST_A .FILL x00FF
TEST_B .FILL x0100

; clz locale: entree R1(x!=0), sortie R0
clz_sub:
    AND R0, R0, #0
loop_cs:
    ADD R1, R1, #0
    BRn ret_cs
    ADD R0, R0, #1
    ADD R1, R1, R1
    BRnzp loop_cs
ret_cs:
    RET
.END