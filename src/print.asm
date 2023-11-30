	
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
	

dec_string db "00$"
	
	convert_dec proc	; recieves byte operand to print
		push	bp
		mov	bp, sp
		sub	sp, 8	
		push	ax
		push	bx	
		push	di
		push 	cx
		mov	ax, [bp + 4]	
		mov	bl, 10
		lea	di, dec_string
		mov	cx, 2
		add	di, 1
_convert_dec_loop:
		div 	bl	
		mov	bh, ah
		xor 	ah, ah
		add	bh, "0"
		mov	[di], bh
		dec	di
		loop  	_convert_dec_loop
_convert_dec_end:
		pop 	cx
		pop 	di
		pop	bx
		pop	ax
		mov	sp, bp
		pop	bp
		ret
	endp


