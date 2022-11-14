# Example to compute the sum and integer average for an array of integer values

#Data declarations
	.data
array:	.word	1,3,5,7,9,11,13,15,17,19
	.word	21, 23, 25, 27, 29, 31, 33, 35, 37, 39
	.word	41, 43, 45, 47, 49, 51, 53, 55, 57, 59
length:	.word	30
sum:	.word	0
average:	.word	0
nowln:	.asciiz	"\n"

#-------------------------------------------------------------------------------------------------------
#Basic approach: Loop through the array, access each value, update sum, and calculate the average
.text
.globl main
.ent main
main:
	la $t0, array	# array starting address
	li $t1, 0		# loop index i = 0
	lw $t2, length	# length
	li $t3, 0		# initialize sum = 0

sumLoop:
	lw $t4, ($t0)	# get array[i]
	add $t3, $t3, $t4	# sum = sum + array[i]
	add $t1, $t1, 1	# i = i + 1
	add $t0, $t0, 4	# update array address
	blt $t1, $t4, sumLoop	# if i < length, continue
	sw $t3, sum	# save sum

	# Calculate average. Note, sum, and length set in section above. 
	div $t5, $t3, $t2	# average = sum / length
	sw $t5, average

	# added
	lw $a0, sum	# load integer sum
	li $v0, l
	syscall

	la $a0, newln	# load address
	li $v0, 4
	syscall

	lw $a0, average	# load integer sum
	li $v0, l
	syscall