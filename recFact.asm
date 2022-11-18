# Example program to demonstrate recursion.
# -----------------------------------------------------
# Data Declarations
          .data
prompt:   .ascii "Factorial Example Program\n\n"
          .asciiz "Enter N value: "
results:  .asciiz "\nFactorial of N = "
n:        .word 0
answer: .word 0
# -----------------------------------------------------
# Text/code section
.text
.globl main
.ent main
main:
# -----
# Read n value from user
          li $v0, 4                # print prompt string
          la $a0, prompt
          syscall
          li $v0, 5                # read N (as integer)

          syscall
          sw $v0, n
# -----
# Call factorial function.
          lw $a0, n
          jal fact
          sw $v0, answer
# -----
# Display result
          li $v0, 4                # print prompt string
          la $a0, results
          syscall
          li $v0, 1                # print integer
          lw $a0, answer
          syscall
# -----
# Done, terminate program.
          li $v0, 10               # call code for terminate
          syscall                  # system call
          .end main
# -----------------------------------------------------
# Factorial function
# Recursive definition:
# = 1 if n = 0
# = n * fact(n-1) if n >= 1
# -----
# Arguments
# $a0 - n
# Returns
# $v0 set to n!
          .globl fact
          .ent fact
fact:

          subu $sp, $sp, 8
          sw $ra, ($sp)
          sw $s0, 4($sp)
          li $v0, 1                # check base case
          beq $a0, 0, factDone
          move $s0, $a0            # fact(n-1)
          sub $a0, $a0, 1
          jal fact
          mul $v0, $s0, $v0        # n * fact(n-1)
factDone:
          lw $ra, ($sp)
          lw $s0, 4($sp)
          addu $sp, $sp, 8
          jr $ra
          .end fact
