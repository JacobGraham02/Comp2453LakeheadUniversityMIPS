# a subroutine with a variable-size stack frame
# -----------------------------------------------------
# Data Declarations
           .data
prompt:    .asciiz "How many # to add?"
result:    .asciiz "\nSum ="
# ------------------------------------
# Main routine.
           .text
           .globl main
           .ent main
main:
           la    $a0, prompt
           li    $v0, 4
           syscall
           
           li    $v0, 5
           syscall
           
           move  $t0, $v0          # $t0 controls input loop
           move  $a0, $v0          # $a0 is para. for subroutine
           
           b get_c
           
get:       li    $v0, 5            # get next number and push it to stack
           syscallr
           
           sub   $sp, 4
           sw    $v0, ($sp)
           sub   $t0, 1
get_c:     bgtz  $t0, get

           jal   addem
           
           move  $t0, $v0          # preserve the result
           la    $a0, result
           li    $v0, 4
           syscall
           
           move  $a0, $t0          # print the result.
           li    $v0, 1
           syscall
           
           li    $v0, 10
           syscall                 # terminate
           .end main
# ------------------------------------

           .globl addem
           .ent addem
addem:
           li    $v0, 0            # initialise the sum
           b     cond
loop:      lw    $t0, ($sp)
           add   $v0, $v0, $t0     # add next number and pop it off stack
           add   $sp, 4            # decrement count and loop if positve. 
           sub   $a0, 1
cond:      bgtz  $a0, loop         # loop if positive
           jr    $ra
           
           .end  addem
