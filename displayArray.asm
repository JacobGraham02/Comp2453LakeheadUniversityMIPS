# Example program to display an array.
# Filename: displayArray.asm
# Demonstrates use of QtSpim system service calls.
# -----------------------------------------------------
# Data Declarations
            .data
hdr:        .ascii "Array Values\n"
            .asciiz  "------------------------\n\n"
spaces:     .asciiz " "
newLine:    .asciiz "\n"
array:      .word 11, 13, 15, 17, 19
            .word 21, 23, 25, 27, 29
            .word 31, 33, 35, 37, 39
            .word 41, 43, 45, 47
length:     .word 19
# -----------------------------------------------------
# text/code section
            .text
            .globl main
            .ent main
main:
            li $v0, 4               # print header string
            la $a0, hdr
            syscall

            la $s0, array
            li $s1, 0
            lw $s2, length
printLoop:
            li $v0, 1               # call code for print int
            lw $a0, ($s0)           # get array[i]
            syscall                 # system call

            li $v0, 4               # print spaces
            la $a0, spaces
            syscall
            addu $s0, $s0, 4        # update addr (next word)
            add $s1, $s1, 1         # increment counter
            rem $t0, $s1, 5
            bnez $t0, skipNewLine
            li $v0, 4               # print new line
            la $a0, newLine
            syscall
skipNewLine:
            bne $s1, $s2, printLoop # if cnter<len -> loop
# -----
# Done, terminate program.
            li $v0, 10              # terminate
            syscall                 # system call
            .end main
