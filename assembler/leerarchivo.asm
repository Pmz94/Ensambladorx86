;leerarchivo.asm
;25/04/2017
;Pedro Muñoz
%include 'funciones.asm'

segment .bss
	buffer RESB 2048
	len EQU $-buffer

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start:
	pop	ECX		;numero de argumentos
	cmp ECX, 2 		;verificar si existe un argumento
	jl salida
	pop EAX 		;nombre del programa
	dec ECX 		;decrementar en 1 el num. arg

	;abrir archivo
	pop EBX 		;nombre del archivo
	mov EAX, sys_open 	;operacion de lectura
	mov ECX, o_rdonly 	;o_rdonly 0
	int 0x80 		;llamada al sistema
	cmp EAX, 0 		;comparar que EAX sea mayor que 0
	jle error 		;si es menor salta a error

	;leer archivo
	mov EBX, EAX 		;mover apuntador file handle a EBX
	mov EAX, sys_read 	;lectura
	mov ECX, buffer 	;direccion de buffer
	mov EDX, len 		;longitud de buffer
	int 0x80 		;llamar al sistema

	;cerrar archivo
	mov EAX, sys_close
	int 0x80

	mov EAX, buffer
	call sprintLF

salida:
	jmp quit
