nop
nop
nop
nop
nop
addiu 0 1 0 ; $1 = 0 (i)
addiu 0 2 5 ; $2 = 30 (n)
addiu 0 3 0 ; $3 = 0 (a)
addiu 0 4 1 ; $4 = 1 (b)
addu 3 4 5  ; $5 = a + b (c)    LOOP
addu 0 4 3  ; $3 = $4 (a = b)
addu 0 5 4  ; $4 = $5 (b = c)
addiu 1 1 1 ; $1++ (i++)
slt 1 2 6   ; $6 = 1 if i < n
bne 6 0 -6  ; jump to LOOP
sw 1 4 0
nop                          ; print the results from memory
addiu 0 1 0 ; $1 = 0 (i)
slt 1 2 6   ; loop while i < n
addiu 1 1 1 ; i++
lw 1 10 0   ; get the saved result
nop
bne 6 0 -5
nop
nop
addiu 0 12 32 ; $12 = 32
jr 12         ; jump to reg 12 -> address 32
nop
nop
beq 0 0 -1  ; inf loop
nop
nop
addiu 0 15 1024
addiu 0 14 1
addu 14 14 14 ; $14 += $14
slt 14 15 16  ; 16 = ($14<$15) ? 1 : 0
bne 16 0 -3   ; while $16 != 0
nop
nop
