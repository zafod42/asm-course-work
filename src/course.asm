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

include d:\print.asm


include d:\table.asm
puts proc	; char from stack
	mov 	ah, 9
	int 21h
	newline
	ret
puts endp

;TODO: You need to write docs. What if you will forget about something?...

	.code

start:	mov 	ax, @data
	mov 	ds, ax


	call draw_table
	pause
	exit

	end start 


