	
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

	horizontal_border_line equ 0CDh
	vertical_border_line equ 0BAh
		
	t_top_border_line equ 0D1h
	t_bot_border_line equ 0CFh

	vertical_line equ 0B3h	

	debug_box macro
		push dx
		
		mov 	dl, top_left_corner
		putchar
		mov	dl, horizontal_border_line
		putchar
		mov 	dl, top_right_corner
		putchar
		newline
		
		mov	dl, bot_left_corner
		putchar
		mov 	dl, horizontal_border_line
		putchar
		mov 	dl, bot_right_corner
		putchar
		newline

		pop dx	
	endm

	number_len equ	4
	surname_len equ 20
	student_id_len equ 9
	credit_len equ 9
	date_len equ 10

	draw_top proc
		pusha	
		mov 	dl, top_left_corner
		putchar
		mov 	cx, number_len
number:		mov 	dl, horizontal_border_line
		putchar	
		loop number
		
		mov 	dl, t_top_border_line
		putchar
		
		mov 	cx, surname_len
surname:	mov	dl, horizontal_border_line
		putchar
		loop surname
	
		mov	dl, t_top_border_line

		putchar	
		mov 	cx, student_id_len
credit_id:	mov	dl, horizontal_border_line
		putchar
		loop credit_id

		mov dl, t_top_border_line
		putchar
		
		mov 	cx, credit_len
credit:		mov	dl, horizontal_border_line
		putchar
		loop credit	
	 
   		mov 	dl, t_top_border_line
		putchar

		mov 	cx, date_len
date:		mov	dl, horizontal_border_line
		putchar
		loop date

		mov 	dl, top_right_corner
		putchar
		popa
		ret
	endp

	draw_bot proc
	pusha	
		mov 	dl, bot_left_corner
		putchar
		mov 	cx, number_len
botnumber:	mov 	dl, horizontal_border_line
		putchar	
		loop botnumber
		
		mov 	dl, t_bot_border_line
		putchar
		
		mov 	cx, surname_len
botsurname:	mov	dl, horizontal_border_line
		putchar
		loop botsurname
	
		mov	dl, t_bot_border_line

		putchar	
		mov 	cx, student_id_len
botcredit_id:	mov	dl, horizontal_border_line
		putchar
		loop botcredit_id

		mov dl, t_bot_border_line
		putchar
		
		mov 	cx, credit_len
botcredit:	mov	dl, horizontal_border_line
		putchar
		loop botcredit	
	 
   		mov 	dl, t_bot_border_line
		putchar

		mov 	cx, date_len
botdate:	mov	dl, horizontal_border_line
		putchar
		loop botdate

		mov 	dl, bot_right_corner
		putchar
		popa
		ret
	endp


	num	db	" 1$"
	MyName	db	"Pavel Kalabin$"
	cred	db	"12482$"
	space	db	"$"

		
	mygroup label byte
	g1	db "Андреев В.И.$", 20 dup("$")
	g2	db "Арбаева А.Ф.$", 20 dup("$")
	g3	db "Брютова С.Д.$", 20 dup("$")
	g4	db "Горохов А.В.$", 20 dup("$")
	g5	db "Давыденко Н.П.$", 20 dup("$")
	g6	db "Демин Н.Д.$", 20 dup("$")
	g7	db "Зубов Г.Н.$", 20 dup("$")
	g8	db "Ильченко А.А.$", 20 dup("$")
	g9	db "Калабин П.П.$", 20 dup("$")
	g10	db "Карасев В.И.$", 20 dup("$")
	g11	db "Коробицына О.В.$", 20 dup("$")
	g12	db "Курташ Н.С.$", 20 dup("$")
	g13	db "Лукьянов Р.С.$", 20 dup("$")
	g14	db "Мартюшова Д.Н.$", 20 dup("$")
	g15	db "Молотов К.Д.$", 20 dup("$")
	g16	db "Павлов Е.С.$", 20 dup("$")
	g17	db "Панфилов М.Д.$", 20 dup("$")
	g18	db "Поляков А.Д.$", 20 dup("$")
	g19	db "Резк А.Ф.$", 20 dup("$")
	g20	db "Смирнов А.С.$", 20 dup("$")
	g21	db "Спирчина Я.А.$", 20 dup("$")
	g22	db "Стародубцева К.А.$", 20 dup("$")
	g23	db "Трегубова М.А.$", 20 dup("$")
	g24	db "Халикова М.И.$", 20 dup("$")
	g25	db "Шевцов А.В.$", 20 dup("$")
	g26	db "Яцуненко М.И.$", 20 dup("$")
	
	credit_table label byte
	c1	db	"2919998$"
	c2	db	"4212929$"
	c3	db	"2155199$"
	c4	db	"4366399$"
	c5	db 	"7211299$"
	c6	db 	"8166299$"
	c7	db 	"4981199$"
	c8	db	"8120299$"
	c9	db	"4101399$"
	c10	db	"8199979$"
	c11	db	"9281928$"
	c12	db 	"2819238$"
	c13	db	"2819282$"
	c14	db 	"2818492$"
	
	student_table label byte
	s1	db	" ", credit_len + 5 dup("$")		
	s2	db	" ", credit_len + 5 dup("$")
	s3	db	" ", credit_len + 5 dup("$")
	s4	db	" ", credit_len + 5 dup("$")
	s5	db	" ", credit_len + 5 dup("$")
	s6	db 	" ", credit_len + 5 dup("$")
	s7	db	" ", credit_len + 5 dup("$")
	s8	db	" ", credit_len + 5 dup("$")
	s9	db	" ", credit_len + 5 dup("$")
	s10	db	" ", credit_len + 5 dup("$")
	s11	db	" ", credit_len + 5 dup("$")
	s12	db	" ", credit_len + 5 dup("$")
	s13	db	" ", credit_len + 5 dup("$")
	s14	db	" ", credit_len + 5 dup("$")

	date_table label byte
	d1	db	" ", date_len*2 dup("$")
	d2	db	" ", date_len*2 dup("$")
	d3	db	" ", date_len*2 dup("$")
	d4	db	" ", date_len*2 dup("$")
	d5	db	" ", date_len*2 dup("$")
	d6	db	" ", date_len*2 dup("$")
	d7	db	" ", date_len*2 dup("$")
	d8	db	" ", date_len*2 dup("$")
	d9	db	" ", date_len*2 dup("$")
	d10	db	" ", date_len*2 dup("$")
	d11	db	" ", date_len*2 dup("$")
	d12	db	" ", date_len*2 dup("$")
	d13	db	" ", date_len*2 dup("$")
	d14	db	" ", date_len*2 dup("$")

	

	
	table_size equ 12
	mytable label word
		dw	offset g1, offset c1, offset s1, offset d1
		dw	offset g2, offset c2, offset s2, offset d2
		dw	offset g3, offset c3, offset s3, offset d3
		dw	offset g4, offset c4, offset s4, offset d4
		dw	offset g5, offset c5, offset s5, offset d5
		dw	offset g6, offset c6, offset s6, offset d6
		dw	offset g7, offset c7, offset s7, offset d7
		dw	offset g8, offset c8, offset s8, offset d8
		dw	offset g9, offset c9, offset s9, offset d9
		dw	offset g10, offset c10, offset s10, offset d10
		dw	offset g11, offset c11, offset s11, offset d11
		dw	offset g12, offset c12, offset s12, offset d12
		dw	offset g13, offset c13, offset s13, offset d13
		dw	offset g14, offset c14, offset s14, offset d14
		dw	offset g15
		dw	offset g16
		dw	offset g17
		dw	offset g18
		dw	offset g19
		dw	offset g20
		dw	offset g21
		dw	offset g22
		dw	offset g23
		dw	offset g24
		dw	offset g25
		dw	offset g26
		;dw	offset g27
		;dw	offset g28
		;dw	offset g29
		;dw	offset g30



	draw_cell proc		;CX - len of cell DX - string in cell
		pusha
		push	dx
		mov	dl, " "
		putchar
		pop 	dx
		mov 	di, dx
str_len_check:  mov 	bl, [di]
		cmp	bl, "$"
		je	cell_drawer
		dec	cx
		inc 	di
		jmp 	str_len_check		
cell_drawer:	print_str
		cmp	cx, 0
		je	draw_cell_exit
		mov 	dl, " "
spaces_drawer:	putchar
		loop spaces_drawer	
draw_cell_exit:	popa
		;pause
		ret
	draw_cell endp

	draw_vert_line macro
		push 	dx
		mov	dl, vertical_line
		putchar
		pop 	dx
	endm

	draw_vert_border macro
		push 	dx
		mov 	dl, vertical_border_line
		putchar
		pop 	dx
	endm
	
counter db " 1$" 
	
	draw_line proc
		push dx
		push cx
		draw_vert_border
		mov	cx, number_len  - 1
		lea 	dx, dec_string	; todo: document it
					; it has to be called after
					; generating new dec_string w/
					; convert_dec procedure
		call draw_cell
		;pause
		draw_vert_line	
		mov	cx, surname_len -1
		mov 	dx, [di]  
		call draw_cell
		draw_vert_line
		mov 	cx, student_id_len  -1
		mov	dx, [di + 2]
		call draw_cell
		draw_vert_line
		mov 	cx, credit_len -1
		mov	dx, [di + 4]
		call draw_cell
		draw_vert_line
		mov	cx, date_len - 1
		mov	dx, [di + 6]
		call draw_cell
		draw_vert_border
		pop cx
		pop dx	
		ret
	endp

	draw_table proc		;TODO: Write docs for it
		pusha
		call 	draw_top
		newline
	 	mov 	cx, table_size 
		lea 	di, mytable 
		mov	bx, 1
		cmp	cx, 0
		je	_draw_table_end
draw_my_table:	push 	bx
		call 	convert_dec
		add	sp, 2		; fuck stack cleaning
					; fuck it
		call 	draw_line	
		add 	di, 8
		inc 	bx
		newline
		loop 	draw_my_table

_draw_table_end:
		call 	draw_bot
		newline
		popa
		ret
	endp


