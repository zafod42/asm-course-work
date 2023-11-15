	
	pause macro		; prints PAUSE string and waiting
		push 	dx	; for any key to continue
		push 	ax
		lea	dx, pause_msg
		println		; WHEN YOU ARE LITTERALY ANYKEY
		mov 	ah, 1
		int 	21h 
		pop 	ax
		pop 	dx
	endm

	exit macro
		pusha

		mov ax, 4c00h
		int 21h		

		popa
	endm
		
	top_left_corner equ 0C9h
	top_right_corner equ 0BBh
	bot_left_corner equ 0C8h
	bot_right_corner equ 0BCh

	horizontal_line equ 0CDh
	vertical_line equ 0BAh
	

	debug_box macro
		push dx
		
		mov 	dl, top_left_corner
		putchar
		mov	dl, horizontal_line
		putchar
		mov 	dl, top_right_corner
		putchar
		newline
		
		mov	dl, bot_left_corner
		putchar
		mov 	dl, horizontal_line
		putchar
		mov 	dl, bot_right_corner
		putchar
		newline

		pop dx	
	endm

	number_len equ	2
	surname_len equ 20
	credit_id_len equ 9
	credit_len equ 7
	date_len equ 10

	draw_top macro
		pusha	
		mov 	dl, top_left_corner
		putchar
		mov 	cx, number_len
number:		mov 	dl, horizontal_line
		putchar	
		loop number
		
		mov 	dl, "*"
		putchar
		
		mov 	cx, surname_len
surname:	mov	dl, horizontal_line
		putchar
		loop surname
	
		mov	dl, "*"	
		putchar	
		mov 	cx, credit_id_len
credit_id:	mov	dl, horizontal_line
		putchar
		loop credit_id

		mov dl, "*"
		putchar
		
		mov 	cx, credit_len
credit:		mov	dl, horizontal_line
		putchar
		loop credit	
	 
   		mov 	dl, "*"
		putchar

		mov 	cx, date_len
date:		mov	dl, horizontal_line
		putchar
		loop date

		mov 	dl, top_right_corner
		putchar
		popa
	endm

	space 	db 	" 1", "$"
	MyName	db	"Pavel Kalabin$"

	draw_cell proc		;CX - len of cell DX - string in cell
		pusha
		mov 	di, dx
		
str_len_check:  mov 	bl, [di]
		cmp	bl, "$"
		je	cell_drawer
		dec 	cx
		inc 	di
		jmp 	str_len_check		
cell_drawer:	print_str
		cmp	cx, 0
		je	draw_cell_exit
		mov 	dl, " "
spaces_drawer:	putchar
		loop spaces_drawer	
draw_cell_exit:	mov 	dl, vertical_line
		putchar
		popa
		ret
	draw_cell endp
	
	draw_table macro	;TODO: Write docs for it
		draw_top
		newline
		mov 	dl, vertical_line
		putchar
		mov	cx, number_len
		lea 	dx, space
		call draw_cell
		mov	cx, surname_len
		lea 	dx, MyName
		call draw_cell
	endm


