	.286
	.model tiny
	.stack 100h
	.data
		msg db "Hello, Wordl!",13, 10, "$"
	.code
start:	mov 	ax, @data
	mov 	ds, ax

	lea 	dx, msg
	mov 	ah, 9
	int 	21h
	

	mov 	ax, 4c00h
	int 	21h

	end start 
