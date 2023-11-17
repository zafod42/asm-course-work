	
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

	number_len equ	2
	surname_len equ 20
	student_id_len equ 9
	credit_len equ 7
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
	g1	db "���॥� �.�.$"
	g2	db "�ࡠ��� �.�.$"
	g3	db "���⮢� �.�.$"
	g4	db "���客 �.�.$"
	g5	db "���뤥��� �.�.$"
	g6	db "����� �.�.$"
	g7	db "�㡮� �.�.$"
	g8	db "���祭�� �.�.$"
	g9	db "������� �.�.$"
	g10	db "���ᥢ �.�.$"
	g11	db "��஡��뭠 �.�.$"
	g12	db "����� �.�.$"
	g13	db "���ﭮ� �.�.$"
	g14	db "�����订� �.�.$"
	g15	db "����⮢ �.�.$"
	g16	db "������ �.�.$"
	g17	db "���䨫�� �.�.$"
	g18	db "���类� �.�.$"
	g19	db "���� �.�.$"
	g20	db "���୮� �.�.$"
	g21	db "����稭� �.�.$"
	g22	db "��த�楢� �.�.$"
	g23	db "�ॣ㡮�� �.�.$"
	g24	db "�������� �.�.$"
	g25	db "���殢 �.�.$"
	g26	db "��㭥��� �.�.$"


	table_size equ 10
	mytable label word
		dw	offset g1
		dw	offset g2
		dw	offset g3
		dw	offset g4
		dw	offset g5
		dw	offset g6
		dw	offset g7
		dw	offset g8
		dw	offset g9
		dw	offset g10
		dw	offset g11
		dw	offset g12
		dw	offset g13
		dw	offset g14
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
draw_cell_exit:	popa
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
		
	draw_line proc
		push dx
		push cx
		draw_vert_border
		mov	cx, number_len
		lea 	dx, num
		call draw_cell
		draw_vert_line	
		mov	cx, surname_len
		mov 	dx, [di]  
		call draw_cell
		draw_vert_line
		mov 	cx, student_id_len
		lea 	dx, cred
		call draw_cell
		draw_vert_line
		mov 	cx, credit_len
		lea	dx, space
		call draw_cell
		draw_vert_line
		mov	cx, date_len
		lea	dx, space
		call draw_cell
		draw_vert_border
		pop cx
		pop dx	
		ret
	endp

	draw_table proc		;TODO: Write docs for it
		pusha
		call draw_top
		newline
	 	mov cx, table_size 
		lea di, mytable 
draw_my_table:	call draw_line	
		add di, 2
		newline
		loop draw_my_table
		call draw_bot
		newline
		popa
		ret
	endp


