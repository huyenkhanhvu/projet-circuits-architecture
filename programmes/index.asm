.ORIG x3000

LEA R1, TEST_CHAINE
LD R2, TEST_TROUVER_CHAINE
; Trouve la premiere occurrence de R2 dans R1
; Entrees: R1 (Adresse chaine), R2 (Caractere)
; Sortie: R0 (Adresse trouvee ou 0)

    AND R0, R0, #0      ; R0=0
    NOT R2, R2
    ADD R2, R2, #1      ; R2=-R2 (pour comparer)

LOOP
    LDR R3, R1, #0
    BRz FIN             ; Si 0 c'est fin de chaine

    ADD R4, R3, R2
    BRz TROUVE          ; Si resultat 0, on a trouve

    ADD R1, R1, #1      ; Avancer adresse
    BRnzp LOOP

TROUVE
    ADD R0, R1, #0      ; R0 = Adresse actuelle (R1)

FIN
    HALT

TEST_CHAINE : .STRINGZ	"string Test 123"
TEST_TROUVER_CHAINE : .STRINGZ	"2"

.END