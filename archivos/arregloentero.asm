;arregloentero.asm
;Pedro Muñoz
;06/05/2017
%include 'funciones.asm'

section .DATA
	msg DB "El promedio es: ", 0x0

segment .bss
	array RESB 100

section .text
	global _start 	;tiene que ser declarado para usar gcc

_start:
	pop ECX 		;obtenemos el numero de arreglo
	cmp ECX, 1		;comparamos si es menor a 2
	jle salida 		;salimos si es menor a 2
	pop EAX 		;obtenemos el nombre de programa
	dec ECX 		;restamos 1 al numero de argumentos
	mov EDX, 0 		;ponemos en ECX a EDX
	mov ESI, array 		;la direccion de 'array' a ESI

ciclo:
	pop EAX 		;sacamos la direccion del argumento
	call atoi 		;convertir el argum a numero
	mov [ESI+EDX*4], EAX 	;guardamos lo que hay en EAX adentro de ESI con corchetes
	inc EDX			;incrementar por uno
	dec ECX 		;decrementamos ECX en 1
	cmp ECX, 0 		;preguntamos si ECX es 0
	jne ciclo 		;ciclar en caso de que no sea 0
	mov EBX, 0

impresion:
	mov EAX, [ESI+ECX*4] 	;apuntamos a donde est
	add EBX, EAX
	call iprintLF 		;mandamos a imprimir
	inc ECX
	dec EDX
	cmp EDX, 0
	jne impresion
	mov EAX, EBX
	mov EDX, 0
	div ECX
	call iprintLF

salida:
	jmp quit
