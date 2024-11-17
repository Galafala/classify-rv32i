.import my_mul.s
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
    
    li t0, 0 # result of multiplication
    li t1, 0 # counter for loop
    li t5, 1

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation
    addi t1, t1, 1
    lw t2, 0(a0) # load arr0[i]
    lw t3, 0(a1) # load arr1[i]

arr0_stride:
    mv t4, a3 # counter for arr0
# loop for arr0 stride
arr0_loop:  
    addi a0, a0, 4
    addi t4, t4, -1
    bge t4, t5, arr0_loop

# loop for arr1 stride
arr1_stride:
    mv t4, a4 # counter for arr1
arr1_loop:
    addi a1, a1, 4
    addi t4, t4, -1
    bge t4, t5, arr1_loop

loop_last:
    addi sp, sp, -32
    sw ra, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    sw a2, 12(sp)
    sw a3, 16(sp)
    sw a4, 20(sp)
    sw t1, 24(sp)
    sw t5, 28(sp)

    mv a0, t0
    mv a1, t2
    mv a2, t3
    jal ra, my_mul
    mv t0, a0

    lw ra, 0(sp)
    lw a0, 4(sp)
    lw a1, 8(sp)
    lw a2, 12(sp)
    lw a3, 16(sp)
    lw a4, 20(sp)
    lw t1, 24(sp)
    lw t5, 28(sp)
    addi sp, sp, 32
    j loop_start

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit