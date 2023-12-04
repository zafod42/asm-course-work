	.286
	.model tiny
	.stack 100h
	.data
		msg db "Hello, World!", "$"
		pause_msg db "Press any key to continue...", "$"
		wellcome db ">>> $"	
	
		student_wellcome db "Введите номер студента в списке: ", "$"
		credit_wellcome db "Введите отметку зачет//незачет: ", "$"
		
	
		wrong_credit db "Неверно задано поле Зачёт", "$"

		credit_cell_index equ 4
		date_cell_index	equ 6

		
		commands label byte
		first db "зачёт$"
		first_s db "зачет$"
		second db "незачёт$"
		second_s db "незачет$"

		commands_list label byte
		command1 dw first
		command2 dw second
		command3 dw first_s
		command4 dw second_s
			 dw 10 dup(0)

		date_size db 10
		date_string label byte
		day_buffer	db "00"
		dot1		db "."
		mounth_buffer	db "00"
		dot2		db "."
		year_buffer	db "0000"
		date_end 	db "$"
		
		max_len		EQU 21
		buffer 		db max_len
		buffer_size	db ?
		buffer_str	db max_len + 1 dup("$")
		number_buff	db 3
		number_size	db ?
		number_str	db ?, ?, ? 

include d:\print.asm
include d:\table.asm

;TODO: You need to write docs. What if you will forget about something?...

line	dw	0 

	.code

start:	mov 	ax, @data
	mov 	ds, ax
	mov	es, ax

main_loop:
	call draw_table
	
	; getting student id
	lea	dx, student_wellcome
	;lea	dx, wellcome
	print_str
	call	get_number
	newline	
	
	;saving student id
	push 	ax
	mov	[line], ax	
	
	; getting credit	
	lea	dx, credit_wellcome
	;lea	dx, wellcome
	print_str
	lea	dx, buffer
	get_str
	newline

	; reformating buffer_string
	xor 	dx, dx
	mov	dl, [buffer_size]
	mov	si, dx 
	dec 	si
	lea	bx, buffer_str
	mov	byte [bx + si], "$"

	lea	dx, buffer_str
	call	is_in_dict	; AX - 0 --> in dict
	cmp	ax, 0
	je 	ok_command
	lea	dx, wrong_credit
	println
	pause
	jmp 	main_loop
ok_command:
; -----------	moving ╨╖╨░╤З╤С╤В into table

	push	[line]
	push	credit_cell_index
	xor	ax, ax
	mov	al, [buffer_size]
	push	ax
	push	offset buffer_str
	call 	table_write	

; ----------

; ---------- mov date into table

	call 	get_date
	
	push	[line]
	push	date_cell_index
	xor	ax, ax
	mov	al, [date_size]
	push	ax
	push	offset date_string
	call 	table_write	


; ---------- end of moving date into table

	jmp	main_loop
; 	redraw table
	call 	draw_table
	newline
	pause
	exit

include d:\ph.asm

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


strcmp	proc	; compares strings from DS:SI and DS:DI 
		; returnes 0 in ax if equal	
		; and non-0 in ax if not equal
	push	bx
	push	si
	push 	di
	push	dx
	mov 	ax, 0
	dec 	si
	dec 	di
strcmp_loop:	
	inc 	si
	inc 	di
	mov 	bh, [si]
	mov 	dl, bh
	;putchar
	mov 	bl, [di]
	mov 	dl, bl
	;putchar
	;newline
	;pause	
	mov 	dl, bh
	mov 	dl, bl
	cmp 	bl, "$"
	je 	pre_exit_cmp
	cmp	bh, bl
	je	strcmp_loop
	mov	ax, 1

pre_exit_cmp:	
	cmp 	bh, bl
	je	strcmp_exit
	mov 	ax, 1
strcmp_exit:	
	pop	dx
	pop 	di
	pop 	si
	pop 	bx
	ret
endp

is_in_dict proc ; checks if word in dict
		; word in ds:dx
		; al = 1 => not in dict
		; al = 0 => in dict
	push di
	push dx
	push cx
	push si
	push bx
	lea 	bx, commands_list
	mov	cx, 4
	mov	di, dx
check_dict_loop:
	mov	si, [bx]
	call strcmp
	cmp 	ax, 0
	je	check_dict_exit
	add 	bx, 2
	loop check_dict_loop
check_dict_exit:
	;mov	dl, "A"
	;putchar
	pop bx	
	pop si
	pop cx
	pop dx
	pop di
	ret
endp

convert_date proc	
		; [bp + 4] - number to print
		; [bp + 6] - address of buffer to write converted
		push	bp
		mov	bp, sp
		sub	sp, 8	
		push	ax
		push	bx	
		push	di
		push 	cx
		mov	ax, [bp + 4]	; number to convert
		mov	bl, 10
		mov	di, [bp + 6] 	; buffer to write converted num
		;mov	cx, 2	; need to make it more useful
		cmp	ax, 100
		jl	big_loop	
		add	di, 2
big_loop:		
		add	di, 1	; to reverse number_string
_convert_date_loop:
		div 	bl	
		mov	bh, ah
		xor 	ah, ah
		add	bh, "0"
		mov	[di], bh
		dec	di
		cmp	ax, 0
		jne	_convert_date_loop
		;loop  	_convert_dec_loop
_convert_date_end:
		pop 	cx
		pop 	di
		pop	bx
		pop	ax
		mov	sp, bp
		pop	bp
		ret
	endp



get_date proc	; converting DOS-date to buffer in date_string
; BUFFER format:
;	 date_string label byte
;	 day      db "xx"
;	 dot1     db "."
;	 mounth   db "xx"
;	 dot2     db "."
;	 year     db "xxxx"
;	 date_end db "$"
;	---------------
	push	bp		
	mov	bp, sp
	sub	sp, 10

	push	ax
	mov	ah, 2ah
	int	21h	
	; now: cx - year; dh - mounth; dl - day
	push	offset year_buffer
	push	cx
	call	convert_date	
	add	sp, 4
	
	mov	cx, dx
	shr	cx, 8	; mounth now

	push	offset mounth_buffer
	push	cx
	call 	convert_date
	add	sp, 4

	xor	dh, dh
	mov	cx, dx	; day now

	push	offset day_buffer
	push	cx
	call	convert_date
	add	sp, 4


	; date converted!
	mov	sp, bp
	pop 	bp
	ret
endp

table_write proc
	push	bp
	mov	bp, sp
	sub	sp, 20h
	
	push	ax
	push	bx
	push	di
	push	si		
	push	cx

	push	[bp + 8] 
	push	[bp + 10]
	call 	get_table_addr
	add	sp, 4
	
	mov	bx, ax
	mov	di, [bx]
	
	;xor	cx, cx	
	mov	cx, [bp + 6]
	mov	si, [bp + 4]	; already contains address
	rep 	movsb

	pop	cx
	pop	si
	pop	di
	pop	bx
	pop	ax

	mov	sp, bp
	pop	bp	
	ret
endp


end start

