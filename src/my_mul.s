.globl my_mul

.text
my_mul:
    blt a1, a2, loop # if a1 < a2, jump to loop
    mv t0, a2 # t0 = a2
    mv a2, a1 # a2 = a1
    mv a1, t0 # a1 = t2
loop:
    beqz a1, exit # if a2 == 0, jump to exit
    andi t0, a1, 0x1 # t0 = t0 & 0x1; bitwise AND of t2 and 0x1
    beqz t0, last_step # if t0 == 0, jump to last_step
    add a0, a0, a2
last_step:
    srli a1, a1, 1 # a1 = a1 >> 1; right shift 1 by 1
    slli a2, a2, 1 # a2 = a2 << 1; left shift a2 by 1
    j loop
exit:
    jr ra
    