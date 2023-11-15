	.286
	.model tiny
	.stack 100h
	.data
		msg db "Hello, World!", "$"
		pause_msg db "Press any key to continue...", "$"
		

		left_top EQU


		max_len		EQU 21
		buffer 		db max_len
		buffer_size	db ?
		buffer_str	db max_len + 1 dup("$")

include d:\macro.asm	
include d:\print.asm

	.code
start:	mov 	ax, @data
	mov 	ds, ax

	lea 	dx, buffer
	get_str
	newline

	lea	dx, buffer_str
	println

	pause
	exit

	end start 
