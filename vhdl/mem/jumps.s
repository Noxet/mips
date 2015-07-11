nop
addiu 0 1 12 ; load reg 1 with 12
addiu 1 2 3  ; reg2 = reg1 + 3  (15)
bne 1 2 -2
addiu 2 3 4 ; $3 = $2 + 4 (19)
