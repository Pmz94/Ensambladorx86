;menuarchivo
;25/04/2017
;Pedro Muñoz
%include 'funciones.asm'

section .DATA
	menu DB "MENU", 0xa, "1- Leer archivo", 0xa, "2- Mostrar archivo", 0xa, "3- Salir", 0x0

	leido DB "Archivo Leido ", 0x0
	pregunta_archivo DB "Nombre del archivo ",0x0


segment .bss
	buffer_nombre RESB 2048
	len_nombre RESB $-buffer_nombre

	opcion RESB 4

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start:
	mov EAX, menu
	call sprintLF

	mov ECX, opcion
	mov EDX, 4
	call leertexto
	mov EAX, ECX
	call atoi
	cmp EAX, 1
	je pregarch
	cmp EAX, 2
	je cerrararchivo
	cmp EAX, 3
	je salir

abrirarchivo:
	;pop EBX 			;nombre del archivo

	mov EAX, sys_open 	;operacion de lectura
	mov ECX, o_rdonly 	;o_rdonly 0
	int 0x80 			;llamada al sistema
	cmp EAX, 0 			;comparar que EAX sea mayor que 0
	jle error 			;si es menor salta a error
	ret

leerarchivo:
	mov EBX, EAX 		;mover apuntador file handle a EBX
	mov EAX, sys_read 	;lectura
	mov ECX, buffer_nombre 	;direccion de buffer
	mov EDX, len_nombre		;longitud de buffer
	mov EAX, leido
	call sprintLF
	int 0x80 			;llamar al sistema
	jmp _start

cerrararchivo:
	mov EAX, sys_close
	int 0x80

	mov EAX, buffer_nombre
	call sprintLF
	jmp _start

salir:
	jmp quit

capturanombre:
	mov EAX, pregunta_archivo
	call sprint
	mov ECX, buffer_nombre
	mov EDX, len_nombre
	call leertexto
	jmp _start

pregarch:
	mov EAX, pregunta_archivo
	call sprint
	mov ECX, buffer_nombre
	mov EDX, len_nombre
	call leertexto
	mov EBX, buffer_nombre
	call abrirarchivo
	call leerarchivo
	call cerrararchivo
	jmp _start