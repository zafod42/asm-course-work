	.286
	.model tiny
	.stack 100h
	.data
		msg db "Hello, World!",13, 10, "$"
		pause_msg db "Press any key to continue...", "$"

	print_str macro		; prints string from DX
		mov 	ah, 9	; 
		int 	21h
	endm

	pause macro		; prints PAUSE string and waiting
		push 	dx	; for any key to continue
		push 	ax
		lea	dx, pause_msg
		print_str		; WHEN YOU ARE LITTERALY ANYKEY
		mov 	ah, 1
		int 	21h 
	endm

	.code
start:	mov 	ax, @data
	mov 	ds, ax

	lea 	dx, msg
	print_str
	

	pause

	mov 	ax, 4c00h
	int 	21h


	end start 
