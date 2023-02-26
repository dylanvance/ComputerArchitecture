##########################
# CDA3100 - Assignment 3 #
##########################

	.data
	.align 0
msg0:	.asciiz "Assignment 3\n"
msg1:	.asciiz "------------\n"
msg2:	.asciiz "Result:   "
msg3:	.asciiz "\n"

	.align 2
data0:	.word 35,-34,82,-95,-2,22,-17,80,-67,-39,64,94,-96,95,-70,-63,69,-3,75,-10
data1:	.space 40
data2:	.space 40
size0:	.word 20
size12:	.word 10

	.text
	.globl main

#######################################################################################
# Students DO NOT need to implement the code in the section below in their C program. #
#######################################################################################

	# Display the %integer value to the user
	.macro display_integer (%integer)
		li $v0, 1			# Prepare the system for output
		add $a0, $zero, %integer	# Set the integer to display
		syscall				# System displays the specified integer
	.end_macro
	
	# Display the %string to the user
	.macro display_string (%string)
		li $v0, 4		# Prepare the system for output
		la $a0, %string		# Set the string to display
		syscall			# System displays the specified string
	.end_macro
	
	j main
	
exit:	li $v0, 10		# Prepare to terminate the program
	syscall			# Terminate the program

#######################################################################################
# Students DO NOT need to implement the code in the section above in their C program. #
#######################################################################################
	
main:
	la $s0, data0
	la $s1, data1
	la $s2, data2
	lw $s3, size0
	lw $s4, size12
	
	add $a0, $s0, $zero
	add $a1, $s1, $zero
	add $a2, $s2, $zero
	add $a3, $s3, $zero
	jal prepareData
	
	add $a0, $s1, $zero
	add $a1, $s4, $zero
	jal processData
	add $s5, $v0, $zero
	
	add $a0, $s2, $zero
	add $a1, $s4, $zero
	jal processData
	add $s6, $v0, $zero
	
	add $a0, $s5, $zero
	add $a1, $s6, $zero
	jal displayResult
	j exit

#######################################################################################

displayResult:
	add $t0, $a0, $a1
	display_string msg0
	display_string msg1
	display_string msg2
	display_integer $t0
	display_string msg3
	jr $ra

#######################################################################################

prepareData:
	add $t0, $zero, $zero 
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	addi $t9, $zero, 2
	
label1:
	slt $t3, $t0, $a3
	beq $t3, $zero, label4
	sll $t3, $t0, 2
	add $t3, $t3, $a0
	lw $t4, 0($t3)
	div $t4, $t9	#t9 == 2
	mfhi $t3
	bne $t3, $zero, label2
	sll $t3, $t2, 2		#if statement
	add $t3, $t3, $a2
	sw $t4, 0($t3)
	addi $t2, $t2, 1
	j label3
label2:	
	sll $t3, $t1, 2		#else statement
	add $t3, $t3, $a1
	sw $t4, 0($t3)
	addi $t1, $t1, 1
label3:
	addi $t0, $t0, 1
	j label1
label4:
	jr $ra

#######################################################################################

processData:
	add $t0, $zero, $zero 
	addi $t1, $zero, 100
	addi $t9, $zero, 2
	
label5:
	slt $t3, $t0, $a1
	beq $t3, $zero, label8
	sll $t3, $t0, 2
	add $t3, $t3, $a0
	lw $t4, 0($t3)
	div $t0, $t9
	mfhi $t3
	bne $t3, $zero, label6
	add $t1, $t1, $t4
	j label7
label6:	
	sub $t1, $t1, $t4
label7:
	addi $t0, $t0, 1
	j label5
label8:
	add $v0, $t1, $zero
	jr $ra
