addiu 0 2 1
addiu 0 3 4 ; n
addiu 0 6 1 ; b
addu 0 0 4 ; i
addu 0 0 5 ; a
slt 4 3 8 ; if $4 < $3
addu 5 6 7 ; $7 = a + b
beq 8 0 8 ; jump to inf loop, "end"
nop
addu 0 4 9 ; $9 = $4
sw 9 4 0
nop
addu 0 6 5 ; $5 = $6, "a = b"
addu 0 7 6 ; $6 = $7, "b = c"
addu 4 2 4 ; $4 = $4 + 1, "i++"
beq 0 0 -10
nop
beq 0 0 -2 ; inf loop
nop
