# -----------------------------------------------------
# File: logicalshiftDemo.asm
# Data Declarations
              .data
pos3:         .word 3
neg3:         .word -3
tab:          .asciiz "\t"; 
newLine:      .asciiz "\n"; 
# ------------------------------------
# Main routine.
# 
           .text
           .globl main
           .ent main
main:

           lw $s1, pos3            
           lw $s2, neg3


#------ dealing with 3 --------------------------------------------------------           
           move $a0, $s1            # print out 3.
           li $v0, 1
           syscall 
           
           la $a0, tab,             # print out space
           li $v0, 4
           syscall
           
           move $a0, $s1            # restore 3 at $a0
           srl $a0, $a0, 31         # shift 31 bits logically (filled with 0s),
                                    # check the sign bit. 0 is expected. 
           li $v0, 1
           syscall
           
           la $a0, newLine,
           li $v0, 4
           syscall
          
#------ dealing with -3 -------------------------------------------------------           

           move $a0, $s2            # print out -3 at $a0
           li $v0, 1
           syscall 
           
           la $a0, tab,             # print out space
           li $v0, 4
           syscall
           
           move $a0, $s2            # restore -3. 
           srl $a0, $a0, 31         # shift 31 bits logically (filled with 0s),
                                    # check the sign bit. 1 is expected.
           li $v0, 1
           syscall
          
           
           li $v0, 10
           syscall                  # terminate
           .end main
