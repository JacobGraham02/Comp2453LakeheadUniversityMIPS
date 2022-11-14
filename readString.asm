# Data declarations
	.data
hdr:	.ascii	"Reading characters example\n\n"
		.asciiz	"Enter your name: "
hiMsg:	.asciiz	"\nHello, "
userAns: 	.space	52


# Text/code section
	.text
	.globl main
	.ent main
main:
	li $v0, 4		# call code and print the string
	la $a0, hdr	# address of string
	syscall		

	li $v0, 8		# call code and read string
	la $a0, userAns	# address where to put the chars
	li $a1, 52		# max characters for a string
	syscall

	li $v0, 4		# call code and print the string
	la $a0, hiMsg	# address for the string
	syscall

	li $v0, 4		# call code and print the string
	la $a0, userAns	# address of the string	
	syscall

	li $v0, 10		# call code for termination of the program
	syscall		
	.end main