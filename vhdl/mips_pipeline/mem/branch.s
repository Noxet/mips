addiu 0 1 1 ; $1 = 1, i = 1
addiu 0 2 9 ; $2 = 5, n = 10
addu 0 0 3  ; $3 = 0, sum = 0
slt 2 1 4   ; $4 = 1 if i >= n
addu 3 1 3  ; sum += i
addiu 1 1 1 ; $1++, i++
beq 4 0 -5  ; jump to line 4
nop
nop
addu 3 0 7 ; store sum to reg 7
