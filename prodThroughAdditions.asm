# File name: prodThroughAdditions.asm#
# Computers the product of two positive integers by repeated additions.

        .text
        .globl main
        .ent main
        
main:   la   $a0, prpt_m       # prompt for first operand, m        
        li   $v0, 4            # call code 4: print String
        syscall
        
        li   $v0, 5            # read integer m
        syscall
        blez $v0, main         # if m <= 0, try again
        bgtu $v0, 0xffff, main # if m > 65535 try again
        move $t1 $v0           # otherwise put m in $t1
        
getn:   la   $a0, prpt_n
        li   $v0, 4
        syscall
        li   $v0, 5
        syscall
        blez $v0, getn         # if n <= 0, try again
        bgtu $v0, 0xffff, getn # if n > 65535, try again
        
        li   $t0, 0
        
loop:   addu $t0, $t0, $t1     # add m to the product
        sub  $v0, $v0, 1       # decrement n
        bnez $v0, loop         # repeat if n not zero
        
        la   $a0, msg
        li   $v0, 4
        syscall
        move $a0, $t0          # output the product.
        li   $v0, 1
        syscall
       
        li $v0, 10             # call code 10: terminate
        syscall
        .end main
        
        .data
prpt_m: .asciiz "Enter 1ST +ve integer (<=65535): "
prpt_n: .asciiz "\nEnter 2ND +ve integer (<=65535): "
msg:    .asciiz "\nProduct is: "
