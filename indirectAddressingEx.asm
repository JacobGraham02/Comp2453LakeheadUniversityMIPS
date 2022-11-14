# Illustrates relative addressing
# -----------------------------------------------------------------------------
         # Data Declarations
         .data
         
values:  .word 3, 7, 1, -5, 9, 8, 5, 10, -1, 6, -5, 0
end:
maxmsg:  .asciiz "Max element is: "
minmsg:  .asciiz "\nMin element is: "

         .text
         .globl main
         .ent main

main:    la   $t0, values       # $t0 points to the array "values"
         la   $t1, end          # $t1 points to the end of the array
         
         lw   $t2, ($t0)        # $t2 contains current Max
         move $t3, $t2,         # $t3 contains current Min
         b    next              # branch into loop

loop:    lw   $t4, ($t0)        # $t4 stores next element
         ble  $t4, $t2, testmin # if next element > current max
         move $t2, $t4          # reset curren tmax and
         b    next              # get next element

testmin: bge  $t4, $t3, next    # if next element < current min
         move $t3, $t4          # reset current min

next:    addi $t0, $t0, 4       # move pointer to the next element
         bne  $t0, $t1, loop    # repeat if not at the end of the array
         
         
         la   $a0, maxmsg       # print max
         li   $v0, 4
         syscall
         move $a0, $t2
         li $v0, 1
         syscall
         
         
         la   $a0, minmsg       # print min
         li   $v0, 4
         syscall
         move $a0, $t3
         li $v0, 1
         syscall
         
         li $v0, 10             # terminate
         syscall    
         .end main

