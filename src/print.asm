	
	putchar macro		; puts char from dl
		push ax
		mov 	ah, 2
		int	21h
		pop ax
	endm

	newline macro	; just prints \n
		push ax
		push dx

		mov 	ah, 2
		mov	dl, 13
		int 21h
		mov 	dl, 10
		int 21h

		pop dx
		pop ax
	endm

	println macro	; prints string from DX and puts new line after it
		print_str
		newline
	endm

	print_str macro		; prints string from DX
		push	ax
		mov 	ah, 9	; 
		int 	21h
		pop 	ax
	endm

	get_str macro		; gets string
		push ax
		mov 	ah, 0ah	; and writes it to buffer located in DS:DX
		int 	21h
		pop ax 	
	endm

