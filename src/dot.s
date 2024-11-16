# .import my_mul.s
.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================

dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate
    blt a4, t0, error_terminate  
      
    li t1, 0 # counter for loop
    li t4, 0 # result of multiplication

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    lw t2, 0(a0) # load arr0[i]
    lw t3, 0(a1) # load arr1[i]
    mv t5, a3 # counter for arr0
arr0_loop:  
    addi a0, a0, 4
    addi t5, t5, -1
    bge t5, t0, arr0_loop
    mv t5, a4 # counter for arr1
arr1_loop:
    addi a1, a1, 4
    addi t5, t5, -1
    bge t5, t0, arr1_loop
loop_last:
    addi t1, t1, 1

# multiplication
#   mul t4, t2, t3
# t4: result of multiplication
my_mul:
    addi sp, sp, -8
    sw t2, 0(sp)
    sw t3, 4(sp)
    li t5, 0 # counter for loop
    li t6, 31 # 32-bit integer
mul_loop:
    lw t2, 0(sp)
    srl t3, t2, t5 # t6 = t2 >> t5; right shift t2 by t5
    beqz t3, mul_exit # if t6 != 0, jump to mul_exit
    andi t3, t3, 0x1 # t6 = t6 & 0x1; bitwise AND of t6 and 0x1
    beqz t3, mul_last # if t6 != 0, jump to sum_add
sum_add:
    lw t3, 4(sp)
    sll t3, t3, t5 
    add t4, t4, t3
mul_last:
    addi t5, t5, 1
    bge t5, t6, mul_exit # if t5 >= t6, jump to mul_exit
    j mul_loop
mul_exit:
    addi sp, sp, 8
    j loop_start

loop_end:
    mv a0, t4
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit