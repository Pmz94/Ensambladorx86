;arreglo.asm
;Pedro Muñoz
;04/04/2017
%include 'funciones.asm'

segment .bss
	array RESB 20

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start:
	pop ECX 		;obtenemos el numero de arreglo
	cmp ECX, 2		;comparamos si es menor a 2
	jl salida 		;salimos si es menor a 2

	pop EAX 		;obtenemos el nombre de programa
	dec ECX 		;restamos 1 al numero de argumentos
	mov EDX, 0 		;ponemos en 0 a EDX
	mov ESI, array 	;la direccion de 'array' a ESI

ciclo:
	pop EBX 				;sacamos la direccion del argumento
	mov EAX, 0 				;limpiamos EAX
	mov AL, byte[EBX] 		;movemos un byte desde EBX
	mov byte[ESI+EDX],AL 	;movemos el byte a EDX
	inc EDX 				;incrementamos EDX en 1
	dec ECX 				;decrementamos ECX en 1
	cmp ECX, 0 				;preguntamos si ECX es 0
	jne ciclo 				;ciclar en caso de que no sea 0

impresion:
	mov EAX, array 			;apuntamos a donde est
	call sprintLF 			;mandamos a imprimir
salida:
	jmp quit