; doscadenas.asm
; imprime "Hola Mundo!"
; autor: Pedro Muñoz
; fecha: 27/febrero/2017

section .data
	msj DB 'Hola Mundo!',0xA,0x0			;mensaje a imprimir
	lon EQU $ - msj 				;longitud de mensaje
	msj2 DB 'Mi Nombre Es Pedro Muñoz', 0xA, 0x0
	lon2 EQU $ - msj2

section .text
	GLOBAL _start 			;punto de entrada
_start:
	mov EDX, lon 			;longitud del mensaje
	mov ECX, msj 			;el mensaje a escribir
	mov EBX, 1 			;descriptor del archivo (stdout)
	mov EAX, 4 			;llamada al system call number (sys_write)
	int 0x80 			;llamada al kernel
	;imprimimos segundo mensaje
	mov EDX, lon2
	mov ECX, msj2
	mov EBX, 1
	mov EAX, 4
	int 0x80
	
	mov EAX, 1 			;system call number (sys_exit)
	int 0x80 			;llamada al kernel
