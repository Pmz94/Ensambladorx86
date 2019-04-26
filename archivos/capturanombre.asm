;capturanombre.asm/
;18/04/2017
;Pedro Muñoz
%include 'funciones.asm'

section .DATA
	pregunta_nombre DB "Cual es tu nombre?", 0x0
	pregunta_edad DB "Cual es tu edad?", 0x0

segment .bss
	buffer_nombre RESB 20
	buffer_nombre_len EQU $-buffer_nombre
	
	buffer_edad RESB 3
	buffer_edad_len EQU $-buffer_edad

	nombre RESB 20
	edad RESB 4

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start:
	mov EAX, pregunta_nombre 	;preparamos para imprimir
	call sprintLF			;mandamos a imprimir
	mov ECX, buffer_nombre 		;direccion de buffer
	mov EDX, buffer_nombre_len 	;longitud del buffer
	call leertexto 			;llamamos a la funcion
	mov EAX, buffer_nombre 		;direccion de variab
	mov ESI, nombre 		;direccion de variab
	call stringcopy 		;copiamos 

	mov EAX, pregunta_edad 		;preparamos para pre
	call sprintLF				
	mov ECX, buffer_edad 		;direccion de buffer
	mov EDX, buffer_edad_len 	;longitud de buffer
	call leertexto 			;llamamos a la funcion
	mov EAX, buffer_edad 		;preparamos para convertir
	call atoi 			;convertimos
	mov [edad], EAX 		;guardamos numero en

	mov EAX, nombre 		;preparamos para imprimir el nombre
	call sprintLF 			;imprimimos el nombre
	mov EAX, [edad] 		;preparamos para imprimir la edad
	call iprintLF 			;imprimimos la edad

	call quit
