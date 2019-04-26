;trescadenasinc.asm
;Pedro Muñoz
;6/Marzo/17

%include 'funciones.asm'

section .data
	msj DB 'Hola Mundo!',0x0	;mensaje a imprimir
	msj2 DB 'Mi Nombre Es Pedro Muñoz', 0x0
	msj3 DB 'Ahora tiene Include Mejorado', 0x0

section .text
	GLOBAL _start 	;punto de entrada
_start:
;Imprimir 1er mensaje
	mov EAX, msj 	;direccion mensaje msj
	call sprintLF 	;imprimir cadena
;Imprimir 2do mensaje
	mov EAX, msj2 	;direccion mensaje msj2
	call sprintLF 	;imprimir cadena
;Imprimir 3er mensaje
	mov EAX, msj3 	;direccion mensaje msj3
	call sprintLF 	;imprimir cadena

	jmp quit 	;salida
