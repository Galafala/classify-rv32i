.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error # check if the array length >= 1

    lw t0, 0(a0) # load the first value to t0

    li t1, 0 # current index
    li t2, 0 # greatest index

loop_start:
    # TODO: Add your own implementation
    addi t1, t1, 1 # i++
    bge t1, a1, done # check if i < the array length
    addi a0, a0, 4 # move array pointer forward
    lw t3, 0(a0) # load the next number into t3
    bge t3, t0, greater
    j loop_start

greater:
    mv t2, t1 # assign greatest index to t2
    mv t0, t3 # assign greatest value to t0
    j loop_start

done:
    mv a0, t2
    jr ra # return

handle_error:
    li a0, 36
    j exit
