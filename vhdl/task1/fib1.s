# Fibonaci number generation program written for the single cycle non-pipelined
# version of the Mini_MIPS microprocessor.

# FUNCTION: 
#  Fibonaci returns generates 'n' Fibonaci numbers, starting from
#  fib(2). The n'th Fibonaci number can be recursivly defined as 
#    fib(n) = if(n < 2) then (n) else (fib(n-1) + fib(n-2))
#  so the sequence of Fibonaci numbers is
#    0, 1, 1, 2, 3, 5, 8, 13, ...
#
# INPUT PARAMETERS:  
#   mem[ubound] = n 
# 
# OUTPUT: 
#   mem[fib_array:fib_array+n-1] = fib(2) .. fib(n+1)
#
# AFFECTED VARIABLES:
#   R1..R7
#
# ALGORITHM:
#   i = 0
#   a = 0
#   b = 1
#   while(i < n)
#     c = a + b
#     fib_array[i] = c
#     a = b
#     b = c
#     i = i + 1 
#   end while
#
# NOTE:
#   The function never returns...


	
	.sdata
ubound:		 .word 0x00000004
one:		   .word 0x00000001
fib_array: .word 0

	.text
	.globl main

main:
	lw   $2, one			# number '1'
	lw   $3, ubound		# n
	lw   $6, one			# b
	addu $4, $0, $0		# i
	addu $5, $0, $0		# a
	
top:
	slt  $8, $4, $3
	addu $7, $5, $6		# $7 = c
	beq  $8, $0, loop
	addu $9, $0, $4
	sll  $9, $9, 2		# calculate index to fib_array
	sw   $7, fib_array($9)
	addu $5, $0, $6 
	addu $6, $0, $7 
	addu $4, $4, $2
	beq  $0, $0, top

loop:	
	beq $0, $0, loop
