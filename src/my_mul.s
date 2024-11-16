.globl my_mul

.text
my_mul:
    li t1, 0 # counter for loop
    li t2, 31 # 32-bit integer
loop:
    beq t1, t2, exit # if t1 >= t2, jump to mul_exit
    srl t0, a1, t1 # t0 = a0 >> t1; right shift t1 by t1
    beqz t0, exit # if t0 != 0, jump to mul_exit
    andi t0, t0, 0x1 # t0 = t0 & 0x1; bitwise AND of t2 and 0x1
    beqz t0, last_step # if t0 != 0, run sum
sum:
    sll t0, a2, t1 
    add a0, a0, t0 
last_step:
    addi t1, t1, 1
    j loop
exit:
    jr ra
