;suma.asm
;suma 2 bytes
;Pedro MUñoz
;1/Mar/17

section .data
	a DB "5"	;primer operador
	b DB "4"	;segundo operador
	msg DB "La Suma Es: ", 0x0 ;mensaje de la
	len EQU $ - msg		;longitud
	vac DB " ", 0xA, 0x0 	;renglon vacio
	lv EQU $ - vac 			;longitud renglon vacio

segment .bss
	sum resb 1

section .text
	GLOBAL _start 	;tiene que ser declarado para usar
_start:
	mov EDX, [a]
	sub EAX, '0'

	mov EBX, [b]
	sub EAX, '0'
	
	add EBX, EBX
	add EAX, '0'
	mov [sum], EAX

	mov ECX, msg
	mov EDX, len
	mov EBX, 1 ;stdout
	mov EAX, 4 ;systwrite
	int 0x80 ;llamar al kernel

	mov ECX, sum ;despliega el resultado de la suma
	mov EDX, 1
	mov EBX, 1 ;file descriptor (stdout)
	mov EAX, 4 ;system call number (sys_write)
	int 0x80 ;llamar al kernel

	mov ECX, vac ;renglon vacio
	mov EDX, lv ;longitud de renglon vacio
	mov EBX, 1
	mov EAX, 4
	int 0x80

	mov EAX, 1
	int 0x80