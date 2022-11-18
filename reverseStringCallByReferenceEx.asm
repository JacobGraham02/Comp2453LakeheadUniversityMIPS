# Example function to demonstrate call by reference. 
# Function reads in a string, reverses it and print out the reverse. 
# File: reverseStringCallByReferenceEx.asm

# -----------------------------------------------------------------------------
# Data Declarations
           .data
inStr:     .asciiz "!3542PMOC ot emocleW"

outStr:    .space 100

# -----------------------------------------------------------------------------
# Main routine.
           .text
           .globl main
           .ent main
main:

           la $a0, inStr         # pass arg's to function
           la $a1, outStr
           jal reverse
           
           la $a0, outStr        # display the result
           li $v0, 4
           syscall
            
           li $v0, 10
           syscall               # terminate
           .end main

# -----------------------------------------------------------------------------
# Function to reverse

          .globl reverse
          .ent reverse
reverse:
          move $t0, $a0          # point $t0 to string

findend:  lbu  $t3, ($t0)        # read through the input string to find the
          add  $t0, 1            # end, signified by a zero byte.
          bne  $t3, 0, findend             
          
          sub  $t0, 1            # $t0 would store the string size.          
          b    c_cond
          
copy:     lbu  $t3, ($t0)
          sb   $t3, ($a1)
          add  $a1, 1
          
c_cond:   sub  $t0, 1
          bgeu $t0, $a0, copy
          
          sb   $zero, ($a1)       # add terminating zero byte

          jr $ra
.end reverse
