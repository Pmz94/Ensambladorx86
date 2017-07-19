;suma3.asm
;Pedro Muñoz
%include 'funciones.asm'

section .data
	numero1 DD 543 		;Numero entero
	cadena1 DB "789", 0x0 	;cadena de numeros
	numero2 DD 888 		;numero entero

segment .bss
	sum resb 4 	;reservamos 4 bytes

section .text
	GLOBAL _start 	;punto de entrada

_start:
	mov EAX, cadena1 	;cadena a conversion
	call atoi 		;convertimos cadenas a enteros
	mov [sum], EAX 		;guardamos en suma el numero convertido
	mov EBX, [numero1] 	;cargamos el numero1 a EBX
	add EAX, EBX 		;suma EAX y EBX y el resultado en EAX
	mov EBX, [numero2] 	;cargamos el numero2 a EBX
	add EAX, EBX 		;suma EAX y EBX y el resultado en EAX
	call iprintLF 		;imprimimos el resultado
	jmp quit
