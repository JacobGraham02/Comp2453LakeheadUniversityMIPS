
# Example function to demonstrate calling conventions.
# Simple function to sum six arguments.
# ------------------------------------
# Data Declarations
            .data
num1:       .word 3
num2:       .word 5
num3:       .word 3
num4:       .word 5
num5:       .word 3
num6:       .word 5
sum:        .word 0
# ------------------------------------
# Main routine.
# Call function to add six numbers. First 4 arguments are passed in $a0-$a3.
# Next 2 arguments are passed on the stack.
             .text
            .globl main
            .ent main
main:
	    lw $a0, num1 # pass arg's
            lw $a1, num2
	    lw $a2, num3
	    lw $a3, num4
	    lw $t0, num5
	    lw $t1, num6
	    subu $sp, $sp, 8
	    sw $t0, ($sp)
	    sw $t1, 4($sp)
	    jal addem
	    sw $v0, sum
	    addu $sp, $sp, 8 # clear stack
	    li $v0,10
	    syscall # terminate
            .end main

# ------------------------------------
# Example function to add 6 numbers
# -----
# Arguments
# $a0 - num1
# $a1 - num2
# $a2 - num3
# $a3 - num4
# ($fp) - num5
# 4($fp) - num6
# Returns
# $v0 – num1+num2+num3+num4+num5+num6
            .globl addem
            .ent addem
addem:
	    subu $sp, $sp, 4 # preserve registers
	    sw $fp, ($sp)
	    addu $fp, $sp, 4 # set frame pointer
# ----- Perform additions.
	    li $v0, 0
	    add $v0, $v0, $a0 # num1
	    add $v0, $v0, $a1 # num2
	    add $v0, $v0, $a2 # num3
            add $v0, $v0, $a3 # num4
	    lw $t0, ($fp) # num5
	    add $v0, $v0, $t0
	    lw $t0, 4($fp) # num6
	    add $v0, $v0, $t0
# -----  Restore registers.
	    lw $fp, ($sp)
	    addu $sp, $sp, 4
	    jr $ra
            .end addem
