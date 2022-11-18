#################################################################################################
#                                                                                               						   #
# File name: occurancesOfByte.asm                                                               					   #
#                                                                                              						   #
# Description: This program searches an array of integers looking for occurances of some byte,  		   #
# and prints each integer in the list that contains the byte. Specifically, we are searching    			   #
# for an integer which contains the byte 'a'.                                                   		 			   #
#                                                                                              						   #
#                                                                                               						   #
#################################################################################################


########################## Data declarations ##########################
.data

word_splitter: .asciiz ", "
program_start_string: .asciiz "The integer values we wish to search for occurances of byte 'a': "

program_end_string: .asciiz "The occurances of byte 'a' in our integer values: "
array: .word 97, 1610612834, 90465, 340481, 155904

array_length: .word 5

target_byte: .byte 'a'

spaces: .asciiz " "

counter: .word 0

########################## Text/code segment ########################## 
.text
.globl main
.ent main

main:  
    ### Display the starting program message ###
    li $v0, 4
    la $a0, program_start_string
    syscall
    
    ### Load all of the values required into defined variables ###
    la $s0, array
    lw $s1, array_length
    lb $s2, target_byte
    lw $s3, counter

printOriginalArray:
    ### Load a pointer to the array data into register $a0. Syscall specific to read integer(s) ###
    li $v0, 1
    lw $a0, ($s0)
    syscall

    ### Update the current address in array by adding 4 bytes ###
    addu $s0, $s0, 4

    ### Increment the array counter by 1 ###
    add $s3, $s3, 1

    ### Put the remainder of dividing $s1 by 5 into $t0
    rem $t0, $s1, 5

    ### ? bnez stands for 'Branch Not Equal Zero'. When contents of $t0 not equal to 0, execute skipNewLine ###
    bnez $t0, skipNewLine

    ### Load system call for printing a string ###
    li $v0, 4
    la $a0, word_splitter
    syscall

getNextByte:
    srl $t4, $t4, 8
    bne $t4, 0, printOriginalArray

skipNewLine:
    ### When the counter does not equal the array length, execute another iteration of the loop ###
    bne $s3, $s1, printOriginalArray

exit:
    ### Terminate the program ###
    li $v0, 10
    syscall
    .end main
