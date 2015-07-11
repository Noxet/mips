nop
addiu 1 1 2
addiu 1 2 3
addu 1 2 3
addu 2 3 4
subu 4 1 5
sll 4 7 2
srl 7 8 1
sltu 8 7 9
sltu 7 8 10
multu 7 8
mfhi 13
mflo 14
multu 14 14
mfhi 13
mflo 14
addiu 0 11 4000 ; $11 = 10 + 0
multu 11 14 ; $ 4000 * 1327104 = 4 * 1327104000
mfhi 13
mflo 14
lui 15 1
addiu 15 15 2
sw 0 15 1337
nop
lw 0 16 1337
lw 0 16 1337
nop
addiu 16 17 1
#bajs
#comment
