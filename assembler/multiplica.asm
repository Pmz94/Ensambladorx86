;multiplica.asm
;27/Mar/2017
;Pedro Muñoz
%include 'funciones.asm'

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start: 				;le dice al linker entry point
	pop ECX 			;sacamos num argumentos
	cmp ECX, 3 			;compara contra 3
	jl fin 				;jum if less
	pop EAX 			;sacamos nombre del prog
	pop EAX 			;primer argumento
	call atoi 			;convertimos el primer argumento
	mov EBX, EAX 		;lo salvamos
	pop EAX 			;sacamos 2do arg
	call atoi 			;convertimos 2do arg
	imul EAX, EBX 		;multiplicamos
	call iprintLF 		;imprimimos resultado
fin:
	jmp quit 			;salimos