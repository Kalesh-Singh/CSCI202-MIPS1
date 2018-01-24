.data
	prompt1: .asciiz "Please enter an integer: "
	prompt2: .asciiz "Please enter an operator (+, -, *, /): "

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
		
		Exit:												# Exits the program
			li $v0, 10
			syscall

	do_math:
		
		jr $ra
	
	do_add:

		jr $ra

	do_subtract:

		jr $ra

	do_multiply:

		jr $ra

	do_divide:

		jr $ra
		
