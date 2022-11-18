# -----------------------------------------------------------------------------
# File: doubleValue.asm
# subroutine to check if the input is non-negative. If valid input is doubled
# in its value in the subroutine dValue
# return 1 for incorrect input.
# demonstrated returned values of $v0, and $v1 for a subroutine. 
# Data Declarations

              .data
msg1:         .asciiz "\nEnter a nonnegative/valid integer:"; 
msg2:         .asciiz "\nInput valid, which is doubled: "; 
errorMeg:     .asciiz "\nInput is negative!";
# -----------------------------------------------------------------------------
# Main routine.

           .text
           .globl main
           .ent main
main:

           la $a0, msg1             # ask to read in a >=0 integer.
           li $v0, 4
           syscall 

           li $v0, 5                # read the integer
           syscall
           
           move $a0, $v0            # input is stored in $a0, for the dValue
           jal  dValue 
           
           beq $v1, 1, printErr     # input if negative
           move $s0, $v0
           la $a0, msg2
           li $v0, 4
           syscall 
                     
           move $v0, $s0            # restore the input value in $v0
           move $a0, $v0            # display the input.
           li $v0, 1
           syscall
           b end
           
printErr:  la $a0, errorMeg
           li $v0, 4
           syscall
           b  main                  # ask for another input.

end:       li $v0, 10
           syscall                  # terminate
           .end main
           
# -----------------------------------------------------------------------------
# routine dValue
          .text
dValue:   srl $v1, $a0, 31          # shift right logical for 31 bits.
          bgez $a0, continue
          jr $ra
continue: mul $a0 $a0, 2            # doubled. 
          move $v0 $a0
          jr $ra
