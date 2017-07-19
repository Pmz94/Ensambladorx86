;entero.asm
;Pedro Muñoz
%include 'funciones.asm'

section .data
	numero		DD 543 	;Numero entero
	cadena 		DB "789", 0x0 	;cadena de numeros

section .text
	GLOBAL _start 		;punto de entrada

_start:
;imrimimos 1er mensaje
	mov EAX, [numero] 	;numero a imprimir
	call iprintLF 		;imprimir numero entero

	mov EAX, cadena 	;cadena de numeros a convertir
	call atoi 			;convertimos el numero
	call iprintLF 		;lo imprmimos

	jmp quit			;salida