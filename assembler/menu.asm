;menu.asm
;20/04/2017
;Pedro Muñoz
%include 'funciones.asm'

section .DATA
	pregunta_nombre DB "Cual es tu nombre?", 0x0
	pregunta_edad DB "Cual es tu edad?", 0x0

	menu DB "MENU", 0x0
	uno DB "1- Capturar nombre", 0x0
	dos DB "2- Capturar Edad", 0x0
	tres DB "3- Imprimir", 0x0
	cuatro DB "4- Salir", 0x0

segment .bss
	buffer_nombre RESB 20
	buffer_nombre_len EQU $-buffer_nombre
	
	buffer_edad RESB 3
	buffer_edad_len EQU $-buffer_edad

	nombre RESB 20
	edad RESB 4

	opcion RESB 4

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start:
	call imprimirmenu
	mov ECX, opcion
	mov EDX, 4
	call leertexto
	mov EAX, ECX
	call atoi
	cmp EAX, 1
	je capturarnombre
	cmp EAX, 2
	je capturaredad
	cmp EAX, 3
	je imprimir
	cmp EAX, 4
	je salir

imprimirmenu:
	mov EAX, menu
	call sprintLF

	mov EAX, uno
	call sprintLF

	mov EAX, dos
	call sprintLF

	mov EAX, tres
	call sprintLF

	mov EAX, cuatro
	call sprintLF
	ret

capturarnombre:
	mov EAX, pregunta_nombre 	;preparamos para imprimir
	call sprintLF				;mandamos a imprimir
	mov ECX, buffer_nombre 		;direccion de buffer
	mov EDX, buffer_nombre_len 	;longitud del buffer
	call leertexto 				;llamamos a la funcion
	mov EAX, buffer_nombre 		;direccion de variab
	mov ESI, nombre 			;direccion de variab
	call stringcopy 			;copiamos 
	jmp _start

capturaredad:
	mov EAX, pregunta_edad 		;preparamos para pre
	call sprintLF				
	mov ECX, buffer_edad 		;direccion de buffer
	mov EDX, buffer_edad_len 	;longitud de buffer
	call leertexto 				;llamamos a la funcion
	mov EAX, buffer_edad 		;preparamos para convertir
	call atoi 					;convertimos
	mov [edad], EAX 			;guardamos numero en
	jmp _start

imprimir:
	mov EAX, nombre 			;preparamos para imprimir el nombre
	call sprintLF 				;imprimimos el nombre
	mov EAX, [edad] 			;preparamos para imprimir la edad
	call iprintLF 				;imprimimos la edad
	jmp _start

salir:
	call quit