;escribearchivo.asm
;27/04/2017
;Pedro Muñoz
%include 'funciones.asm'

segment .bss
	buffer_alumno RESB 30
	len_alumno EQU $-buffer_alumno
	filename RESB 30
	len_filename EQU $-filename
	archivo RESB 30

section .data
	p_nombre DB "nombre del alumno> ", 0x0
	p_archivo DB "nombre del archivo> ", 0x0

section .text
	global _start

_start:
	mov EAX, p_nombre
	call sprint

	mov ECX, buffer_alumno
	mov EDX, len_alumno
	call leertexto
	
	mov EAX, p_archivo
	call sprint

	mov ECX, filename
	mov EDX, len_filename
	call leertexto

	mov ESI, archivo
	mov EAX, filename
	call copystring

	mov EAX, filename
	call sprint

;crear
	mov EAX, sys_creat
	mov EBX, archivo
	mov ECX, 511
	int 0x80

	cmp EAX, 0
	jle error

;openfilename
	mov EAX, sys_open
	mov EBX, archivo
	mov ECX, o_rdwr 		;o_rdwr EQU 1
	int 0x80
	cmp EAX, 0
	jle error

;write
	mov EBX, EAX
	mov EAX, sys_write
	mov ECX, buffer_alumno
	mov EDX, len_alumno
	int 0x80
	mov EAX, sys_sync
	int 0x80

;cerrar archivo
	mov EAX, sys_close
	int 0x80

salida:
	jmp quit