; holamundo.asm
; imprime "Hola Mundo!"
; autor: mi nombre
; fecha: 13/septiembre/2016

section .data
	msj DB 'Hola Mundo!',0xA,0x0	;mensaje a imprimir
	lon EQU $ - msj 				;longitud de mensaje

section .text
	GLOBAL _start 					; punto de entrada
_start:
	mov EDX, lon 					;longitud del mensaje
	mov ECX, msj 					;el mensaje a escribir
	mov EBX, 1 						;descriptor del archivo (stdout)
	mov EAX, 4 						;llamada al system call number (sys_write)
	int 0x80 						;llamada al kernel
	mov EAX, 1 						;system call number (sys_exit)
	int 0x80 						;llamada al kernel