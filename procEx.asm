# Example function to demonstrate calling conventions
# Function computes power (i.e., x to y power).
# File: procedureEx.asm
# Ed Jorgensen 8.11.1
# -----------------------------------------------------
# Data Declarations
           .data
x:         .word 2
y:         .word 10
answer:    .word 0
# ------------------------------------
# Main routine.
# Call simple procedure to add two numbers.
           .text
           .globl main
           .ent main
main:

           lw $a0, x             # pass arg's to function
           lw $a1, y
           jal power
           sw $v0, answer
           
           lw $a0, answer        # display the result
           li $v0, 1
           syscall
            
           li $v0, 10
           syscall               # terminate
           .end main
# ------------------------------------
# Function to find and return x^y
# -----
# Arguments
# $a0 – x
# $a1 – y
# Returns
# $v0 - x^y
          .globl power
          .ent power
power:
          li $v0, 1
          li $t0, 0
powLoop:
          mul $v0, $v0, $a0
          add $t0, $t0, 1
          blt $t0, $a1, powLoop
          jr $ra
.end power
