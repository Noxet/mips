nop
nop
nop
nop
nop
addiu 0 1 0 ; $1 = 0 (i)
nop
nop
nop
nop
nop
addiu 0 2 10 ; $2 = 5 (n)
nop
nop
nop
nop
nop
addiu 0 3 0 ; $3 = 0 (a)
nop
nop
nop
nop
nop
addiu 0 4 1 ; $4 = 1 (b)
nop
nop
nop
nop
nop
addu 3 4 5  ; $5 = a + b (c)    LOOP
nop
nop
nop
nop
nop
addu 0 4 3  ; $3 = $4 (a = b)
nop
nop
nop
nop
nop
addu 0 5 4  ; $4 = $5 (b = c)
nop
nop
nop
nop
nop
addiu 1 1 1 ; $1++ (i++)
nop
nop
nop
nop
nop
slt 1 2 6   ; $6 = 1 if i < n
nop
nop
nop
nop
nop
bne 6 0 -32  ; jump to LOOP
nop
nop
nop
nop
nop
nop
beq 0 0 -2  ; inf loop
nop
nop
nop
nop
nop
nop
