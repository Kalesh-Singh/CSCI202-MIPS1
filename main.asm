.data
	prompt1: 	.asciiz 	"Please enter an integer: "
	prompt2: 	.asciiz 	"Please enter an operator (+, -, *, /): "
	error_msg:	.asciiz		"Error: invalid arithmetic operation 'OP'." 

.text

	main:
		# Prompt the user to enter the 1st integer
		li $v0, 4
		la $a0, prompt1
		syscall

		# Read the 1st integer
		li $v0, 5
		syscall
		add $a1, $v0, $zero

		# Prompt the user to enter the sign
		li $v0, 4
		la $a0, prompt2
		syscall

		# Read the the sign character
		li $v0, 12
		syscall
		add $a2, $v0, $zero

		# Prompt the user to enter the 2nd integer
		li $v0, 4
		la $a0, prompt1
		syscall	

		# Read the 2nd integer
		li $v0, 5
		syscall
		add $a3, $v0, $zero
	
		# Call do_math
		jal do_math
		
		# FIXME: Return 0 from main using jr (do not use the 'exit' syscall)

		Exit:												# Exits the program
			li $v0, 10
			syscall

	do_math:

		# Store the $ra of do_math to the stack, since it is calling another function
		sw $ra, 0($sp)
		
		addition:
			bne $a2, '+', subtraction
			jal do_add
			j print_result

		subtraction:
			bne $a2, '-', multiplication
			jal do_subtract
			j print_result

		multiplication:
			bne $a2, '*', division
			jal do_multiply
			j print_result

		division:
			bne $a2, '/', error
			jal do_divide
			j print_result

		error:
			li $v0, 4
			la $a0, error_msg
			syscall	
		
		print_result:
			# Get the result returned from the operation
			add $t0, $v0, $zero
			add $t1, $v1, $zero

			# Print the 1st integer
			li $v0, 1
			add $a0, $a1, $zero
			syscall

			# Print a space
			li $v0, 11
			li $a0, 32		# 32 - Is the ASCII decimal value of ' '
			syscall 

			# Print the sign character
			li $v0, 11
			add $a0, $a2, $zero
			syscall

			# Print a space
			li $v0, 11
			li $a0, 32		# 32 - Is the ASCII decimal value of ' '
			syscall 

			# Print the 2nd integer
			li $v0, 1
			add $a0, $a3, $zero
			syscall

			# Print space
			li $v0, 11
			li $a0, 32		# 32 - Is the ASCII decimal value of ' '
			syscall 

			# Print the equal sign charcter
			li $v0, 11
			li $a0, 61 		# 61 - Is the ASCII decimal value of '='
			syscall

			# Print space
			li $v0, 11
			li $a0, 32		# 32 - Is the ASCII decimal value of ' '
			syscall 

			# Print the integer result
			beq $t1, 0, result_32bits

			result_32bits:
				li $v0, 1
				add $a0, $t0, $zero
				syscall
			
		# Retrive the $ra value for do_math from the stack
		lw $ra, 0($sp)

		return:
			jr $ra
	
	do_add:
		# FIXME
		add $v0, $a1, $a3
		add $v1, $zero, 0
		jr $ra

	do_subtract:
		# FIXME
		sub $v0, $a1, $a3
		add $v1, $zero, 0
		jr $ra

	do_multiply:
		# FIXME
		mult $a1, $a3	# Assuming the product is not greater than 32 bits
		mflo $v0
		mfhi $v1
		jr $ra

	do_divide:
		# FIXME
		div $a1, $a3	# Assuming there is no remainder
		mflo $v0
		mfhi $v1
		jr $ra
		
