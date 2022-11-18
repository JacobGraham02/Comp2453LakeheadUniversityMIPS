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

; .data
; Arr: .word 97, 1610612834, 90465, 340481, 155904  # Array of words Arr[5]
; length: .word 5          #length of array
; z: .byte 'a'
; newline: .asciiz "\n"        #to print newline

; .text
; main:
         
;        la $t0,Arr      	# $t0=base address of A
;        lw $t1,length    # $t1=length of array
;        lb $t2,z         # $t2=the byte to be searched

; getnextnum:

;        lw $t3,0($t0)    # load next word in array into $t3
;        move $t4,$t3     # $t4=$t3

; repeat:
       
;        and $t5,$t4,0x000000FF   #get the LSB in $t4 into $t5
;        bne $t5,$t2,getnextbyte  #if $t5!=$t2, goto getnextbyte
     
;        li $v0,1             #if $t5=$t2(byte present in $t3), print $t3
;        move $a0,$t3         #move number in $t3 to $a0
;        syscall              #print number using syscall 1

;        li $v0,4              #print string newline using syscall 4
;        la $a0,newline        #a0=address of string to be printed
;        syscall
;        b next                #then goto next
        

; getnextbyte:

;        srl $t4,$t4,8         #shift $t4 right 8 time(to get next byte in word)
;        bne $t4,0,repeat      #if $t4!=0, goto repeat
; next:
;        addi $t0,$t0,4        #increment $t0 by 4 to get next word in array
;        addi $t1,$t1,-1       #decrement $t1 by 1 (length of array)
;        bne $t1,0,getnextnum  #if $t1 !=0, goto getnextnum

; exit:           
;         li $v0, 10          # to terminate using syscall 10
;         syscall  