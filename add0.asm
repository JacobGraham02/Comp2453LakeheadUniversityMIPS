# 
# An example illustraing structure of MIPS assembly language program.
#---------------------- text segment ------------------------------------------
        .text                # indicates start of code segment
        .globl main         # defines start of program
        .ent   main
 
        # load word B from into Saved register 1: $s1
main:   lw $s1, B            # 7 

        lw $s2, C            # 9
        lw $s3, D            # 4
        lw $s4, E            # 2
        
        # do the arithematic B+C, save result to Temporary register 0: $t0
        add $t0, $s1, $s2    # 7+9 = 16
        
        add $t1, $s3, $s4    # 4+2 = 6
        sub $a1, $t0, $t1    # 16-6 = 10
        
        # load address of memory location "message" into Argument 
        # register 0: $a0
        la  $a0, message 
        
        # load immediate value 4 into register $v0
        li  $v0, 4
        syscall              # system call to print it out
        
        # copy contents of interger soruce register $a1 into integer 
        # destination register
        move $a0, $a1
        
        # system call 1, print integer, and $a0 = integer to print
        li   $v0, 1
        syscall


        # system call 10, exits. 
        li $v0,10
        syscall

        .end main

#---------------------- text segment ------------------------------------------
        .data                # indicates start of data segment
               #32-bit variable
B:             .word   7
C:             .word   9
D:             .word   4
E:             .word   2
              #NULL terminated ASCII string
message:      .asciiz  "Answer ="
        
        
