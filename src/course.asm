	.286
	.model tiny
	.stack 100h
	.data
		msg db "Hello, World!", "$"
		pause_msg db "Press any key to continue...", "$"
		wellcome db ">>> $"	

		left_top EQU


		max_len		EQU 21
		buffer 		db max_len
		buffer_size	db ?
		buffer_str	db max_len + 1 dup("$")
		number_buff	db 3
		number_size	db ?
		number_str	db ?, ?, ? 
include d:\print.asm


include d:\table.asm
puts proc	; char from stack
	mov 	ah, 9
	int 21h
	newline
	ret
puts endp

get_table_addr proc	; ax - address
	push	bp
	mov	bp, sp
	sub	sp, 10
	push 	cx
	push	bx	
	mov	cx, [bp + 4]
	mov	ax, [bp + 6]
	lea	bx, mytable
	dec 	cx
calc:	add	bx, 8	
	loop 	calc
	add	bx, ax
	xchg	bx, ax
	pop	bx
	pop	cx
	mov	sp, bp
	pop	bp
	ret
endp

get_number proc		;ax - number that we get
	push	bp
	mov	bp, sp
	sub	sp, 30h
	push	dx
	push	cx
	push 	bx

	mov	ah, 0ah
	lea	dx, number_buff 
	int 	21h	
	xor	cx, cx
	mov	cl, [number_size]
	lea	bx, number_str
	xor	ax, ax
	xor	dx, dx
	mov	dh, 10
_get_number_loop:
	mul	dh
	add	al, [bx]
	sub	al, "0"
	inc	bx	
	loop 	_get_number_loop
	pop 	bx
	pop	cx
	pop	dx
	mov	sp, bp
	pop	bp
	ret
endp 

;TODO: You need to write docs. What if you will forget about something?...

line	dw	0 

	.code

start:	mov 	ax, @data
	mov 	ds, ax
	mov	es, ax

	call draw_table
	lea	dx, wellcome
	print_str
	call	get_number
	newline	
	
	push 	ax
	call 	print_hex
	newline
	
	xor	dx, dx	
	mov	dl, [buffer_str]
	sub	dx, "0"
	lea	bx, line
	mov	[bx], dx		
		
	lea	dx, wellcome
	print_str

	mov	ah, 0ah
	lea	dx, buffer
	int	21h
	newline
	xor 	dx, dx
	mov	dl, [buffer_size]
	mov	si, dx 
	lea	bx, buffer_str
	mov	byte [bx + si], "$"

; -----------
	push	4
	
	push	[line]
	call 	get_table_addr
	mov	bx, ax
	mov	di, [bx]
	
	xor	cx, cx	
	mov	cl, dl
	add	sp, 2
	lea	si, buffer_str
	rep 	movsb
; ----------

	mov	ah, 02h
	mov 	bh, 0
	mov	dx, 0
	int 	10h
	call 	draw_table
	newline
	pause
	exit

include d:\ph.asm

end start

