# Square root test program written for the single cycle non-pipelined
# version of the Mini_MIPS microprocessor.

# FUNCTION: int_sqrt(x), int_sqrt_remainder(x)
#
# INPUT PARAMETERS:  
#   R4 = x
# 
# OUTPUT: 
#   R2 = int_sqrt(x)
#   R3 = int_sqrt_remainder(x)
#
# ALGORITHM:
#   uneven = - 1
#   repeat
#   uneven = uneven + 2
#   x      = x - uneven
#   until (x < 0)
#   sqrt_remainder = x + uneven
#   sqrt = uneven DIV 2
#
# EXPLANATION: 
#   After iteration n, x will have the value X - 1+3+5+... = X - n**2
#   where X is the initial value of x.  When the loop terminates in
#   iteration N+1, we have that X - (N+1)**2 < 0 for the first time, so N
#   is our integer approximation to SQRT(X). To find N, we note that
#   'uneven' has just been subtracted from the value X - (N)**2 from the
#   previous iteration, so that
# 
#   X - (N+1)**2 = X - N**2 - uneven => 
#   uneven = 2N + 1 =>
#   N = (uneven - 1) / 2 =>
#   int_sqrt(X) = N = uneven DIV 2
# 
#   as 'uneven' is uneven! The square root remainder is the difference
#   between X and N**2. As x has the value X - N**2 - uneven after the last
#   iteration, we have:
#
#   int_sqrt_remainder = x + uneven
# 

        .sdata
x:      .word 0x00000005
sqrt_d: .word 0
rem_d:  .word 0

        .text
        .globl main

main:
        lw    $4, x
        jal   sqrt
        sw    $2, sqrt_d
        sw    $3, rem_d
loop:
        beq   $0, $0, loop

sqrt:   addiu $6, $0, -1	# uneven

top:    addiu $6, $6, 2
        subu  $4, $4, $6
        slt   $5, $4, $0
        addu  $3, $4, $6
        beq   $5, $0, top
        srl   $2, $6, 1
        jr    $31
