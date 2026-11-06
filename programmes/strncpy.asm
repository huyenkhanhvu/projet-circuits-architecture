.ORIG x3000

LEA R0, PREND
LEA R1,TEST

; Copie max R0 caracteres de R1 vers R2
; Entrees: R1 (source), R2 (dest), R0 (nombre de N)

    ADD R0, R0, #0      ; Test si N=0
    BRnz FIN            ; Si N<=0, on arrete

LOOP
    LDR R3, R1, #0      ; Lire char
    STR R3, R2, #0      ; Ecrire char

    BRz FIN             ; Si fin de chaine, on arrete

    ADD R1, R1, #1      ; Incremente le source
    ADD R2, R2, #1      ; Incremente le dest
    ADD R0, R0, #-1     ; Decremente le compteur N
    BRp LOOP            ; Si N > 0, on continuer

TEST : .STRINGZ	"test"
PREND : .FILL 3
FIN
    HALT
.END