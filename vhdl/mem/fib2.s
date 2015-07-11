addiu 0 1 0 ; $1 = 0 (i)
addiu 0 2 5 ; $2 = 5 (n)
addiu 0 3 0 ; $3 = 0 (a)
addiu 0 4 1 ; $4 = 1 (b)
addu 3 4 5  ; $5 = a + b (c)    LOOP
addu 0 4 3  ; $3 = $4 (a = b)
addu 0 5 4  ; $4 = $5 (b = c)
addiu 1 1 1 ; $1++ (i++)
slt 1 2 6   ; $6 = 1 if i < n
bne 6 0 -7  ; jump to LOOP
nop
beq 0 0 -2  ; inf loop
nop
