# File name: fact.asm#
# computes the factorial of a nonnegative integer by iterated multiplication.

        .text
        .globl main
        .ent main
main:   
        # load address of memory location "msg1" into $a0 
        la $a0, msg1
        li $v0, 4                   # call code 4: print String, address 
        syscall                     # starting point $a0
        
        # read an integer from console        
        li $v0, 5                   # call code 5: read an integer by user
        syscall                     # stored in $v0.
        
        bge $v0, $zero, cont        # branch to the label "cont" if  v0 >= 0.
        la  $a0, msg3               # otherwise print the error message msg3.
        li  $v0, 4
        syscall
        
        b   main                    # branch to "main", ask for input again
        
cont:   li $t0, 1                   # t0 init. to 1, maintains the product.

loop:   beq $v0, $zero, out         # finish if integer is 0.
        mul $t0, $t0, $v0           # t0 times v0 -> t0
        sub $v0, $v0, 1             # decrement v0
        b   loop


out:    la $a0, msg2                # print result message. 
        li $v0, 4                   # call code 4: print String
        syscall
        
        move $a0, $t0               # move content in t0 into a0.
        li $v0, 1                   # call code 1: print integer
        syscall
        
        la   $a0, line              # new line.        
        li   $v0, 4                 # call code 4: print String
        syscall
        
        li $v0, 10                  # call code 10: terminate
        syscall
        .end main
        
        .data
msg1:   .asciiz "Enter a non-negative interger: "
msg2:   .asciiz " Factorial of given number is: "
line:   .asciiz "\n"
msg3:   .asciiz " Input must be >=0 integer. \n"
