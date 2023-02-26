#################################################################
# CDA3100 - Assignment 1			       						#
#						       									#
# The following code is provided by the professor.     			#
# DO NOT MODIFY any code above the STUDENT_CODE label. 			#
#						       									#
# The professor will not troubleshoot any changes to this code. #
#################################################################

	.data
	.align 0

	# Define strings used in each of the printf statements
msg1:	.asciiz "Welcome to Prime Tester\n\n"
msg2:	.asciiz "Enter a number between 0 and 100: "
msg3:	.asciiz "Error: Invalid input for Prime Tester\n"
msg4:	.asciiz "The entered number is prime\n"
msg5:	.asciiz "The entered number is not prime\n"
ec_msg:	.asciiz " is prime\n" 		# Reserved for use in extra credit

	.align 2	
	.text
	.globl main

	# The following macros are provided to simplify the program code
	# A macro can be thought of as a cross between a function and a constant
	# The assembler will copy the macro's code to each use in the program code
	
	# Display the %integer to the user
	# Reserved for extra credit
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
	
	# Compute the square root of the %value
	# Result stored in the floating-point register $f2
	.macro calc_sqrt (%value)
		mtc1.d %value, $f2	# Copy integer %value to floating-point processor
		cvt.d.w $f2, $f2	# Convert integer %value to double
		sqrt.d $f2, $f2		# Calculate the square root of the %value
	.end_macro 
	
	# Determine if the %value is less-than or equal-to the current square root value in register $f2
	# Result stored in the register $v1
	.macro slt_sqrt (%value)
		mtc1.d %value, $f4	# Copy integer %value to floating-point processor
		cvt.d.w $f4, $f4	# Convert integer %value to double
		c.lt.d $f4, $f2		# Test if %value is less-than square root
		bc1t less_than_or_equal	# If less-than, go to less_than_or_equal label
		c.eq.d $f4, $f2		# Test if %value is equal-to square root
		bc1t less_than_or_equal	# If equal-to, go to less_than_or_equal label
		li $v1, 0		# Store a 0 in register $v1 to indicate greater-than condition
		j end_macro		# Go to the end_macro label
less_than_or_equal: 	
		li $v1, 1		# Store a 1 in register $v1 to indicate less-than or equal-to condition
end_macro: 
	.end_macro

main:
	# This series of instructions
	# 1. Displays the welcome message
	# 2. Displays the input prompt
	# 3. Reads input from the user
	display_string msg1	# Display welcome message
	display_string msg2	# Display input prompt
	li $v0, 5		# Prepare the system for keyboard input
	syscall			# System reads user input from keyboard
	move $a1, $v0		# Store the user input in register $a0
	j student_code 		# Go to the student_code label

error:	
	display_string msg3	# Display error message
	j exit
isprime:
	display_string msg4	# Display is prime message
	j exit
notprime:
	display_string msg5	# Display not prime message
exit:
	li $v0, 10	# Prepare to terminate the program
	syscall		# Terminate the program
	
#################################################################
# The code above is provided by the professor.     		#
# DO NOT MODIFY any code above the STUDENT_CODE label. 		#
#						       		#
# The professor will not troubleshoot any changes to this code. #
#################################################################

# Place all your code below the student_code label
student_code:

slt $t1, $a1, $zero		#Check if input ($a1) is less than zero. Result stored in $t1

sgt $t2, $a1, 100 		#Check if input ($a1) is greater than 100. Result stored in $t2

beq $t1, 1, error		#Jump to error label if $t1 = 1 (true)

beq $t2, 1, error 		#Jump to error label if $t2 = 1 (true)

addi $t3, $zero, 2		#Set value of $t3 to 2

slt $t4, $a1, $t3		#Check if input is less than 2 ($t3). Result stored in $t4

beq $t4, 1, notprime 		#Jump to notprime if $t4 = 1 (true)

beq $a1, $t3, isprime		#Jump to isprime if input = 2.

div $a1, $t3			#Divide input ($a1) by 2 ($t3) to see if it is even. Remainder stored in hi.

mfhi $t5			#Move hi to $t5

beq $t5, $zero, notprime	#Jump to notprime if remainder (hi) is equal to 0 (input is even).

addi $t6, $zero, 3		#Set x ($t6) equal to 3 for the for loop.

calc_sqrt $a1			#Calculate the square root of the input ($a1). Result stored in $f2

for_loop:			#Start of for loop

slt_sqrt $t6			#Check if x ($t6) is less than / equal to sqrt of input. Result stored in $v1

beq $v1, 0, loop_exit 		#Exits the loop if slt_sqrt is false (0)

div $a1, $t6			#Divide input ($a1) by x ($t6). Remainder stored in hi.

mfhi $t7			#Move hi to

beq $t7, $zero, notprime	#Jump to not prime if remainder of input / x = 0

addi $t6, $t6, 2		#Increment x ($t6) by 2

j for_loop			#Jump back to the top of the loop

loop_exit:			#If loop exits successfully, input is prime

j isprime			#Jump to isprime

#END OF PROGRAM