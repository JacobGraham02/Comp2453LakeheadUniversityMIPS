#########################################################################################
#                                                                                       #
# File name: absoluteValue.asm                                                          #
#                                                                                       #
# Description: This program finds the absolute value of a number stored in register $a0,#
# and stores the result in the register $a0. The input number should be a word          #
#                                                                                       #
#                                                                                       #
#########################################################################################


########################## Data declarations ##########################
.data
question_message: .asciiz   "Find absolute value of: "
answer_message:   .asciiz   "Absolute value of input: "
user_answer:      .word 0
absolute_value:   .word 0

########################## Text/code segment ##########################
.text
.globl main
.ent main

# https://www.chegg.com/homework-help/questions-and-answers/write-mips-32-function-myabs-accepts-integer-register-a0-returns-absolute-value-v0-also-wr-q19240766
main:  
    ### Prompt the user to enter an integer ###
    li $v0, 4		            # Call the system code to print a string
	la $a0, question_message	# address of string
	syscall		

    ### Read the integer from the console and save in $s0 temporarily ###
    li $v0, 5
    syscall
    move $s0, $v0
    # la $a0, user_answer

    ### Output the text indicating user has entered an integer ### 
    li $v0, 4
    la $a0, answer_message
    syscall

    ### Call the built-in abs function to calculate the absolute value of the value stored at register $s0 ###
    abs $s0, $s0

    ### Output the integer the user has entered ###
    li $v0, 1
    move $a0, $s0
    syscall

    ### Terminate the program ###
    li $v0, 10
    syscall
    .end main