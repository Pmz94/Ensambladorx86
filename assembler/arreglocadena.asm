;arreglocadena.asm
;Pedro Muñoz
;05/05/2017
%include 'funciones.asm'

segment .bss
	array RESB 50

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start:
	pop ECX 		;obtenemos el numero de arreglo
	cmp ECX, 2		;comparamos si es menor a 2
	jl salida 		;salimos si es menor a 2
	pop EAX 		;obtenemos el nombre de programa
	dec ECX 		;restamos 1 al numero de argumentos
	mov EDX, ECX 		;ponemos en ECX a EDX
	mov ESI, array 	;la direccion de 'array' a ESI

ciclo:
	pop EAX 				;sacamos la direccion del argumento
	call stringcopy
	add ESI, 10
	dec ECX 				;decrementamos ECX en 1
	cmp ECX, 0 				;preguntamos si ECX es 0
	jne ciclo 				;ciclar en caso de que no sea 0
	mov ECX, EDX
	mov ESI, array

impresion:
	mov EAX, ESI 			;apuntamos a donde est
	call sprint 			;mandamos a imprimir
	add ESI, 10
	dec ECX
	cmp ECX, 0
	jne impresion

salida:
	jmp quit