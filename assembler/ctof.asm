;ctof.asm
;Pedro Muñoz
;04/04/17
%include 'funciones.asm'

section .DATA
	msg DB "EL promedio de los Celsius a Farenheit serian: ", 0x0

segment .bss
	num_arg RESB 4

section .text
	global _start 		;tiene que ser declarado para usar gcc

_start:
	pop ECX 	;capturar e num argumentos en ECX
	cmp ECX, 2 	;comparar si ECX tiene 2 o mas argumentos
	jl quit 	;si es asi, cierra el programa
	pop EAX 	;capturar el nombre del programa
	dec ECX 	;restar 1 al num de argumentos que tenga ECX
	mov EBX, 0  ;para inicializar la suma en cero 
	mov [num_arg], ECX ;

ciclo:
	pop EAX 			;obtenemos argumento
	call atoi 			;convierte el argum a numero
	;call iprintLF
	call ctof 			;hace la operacion
	call iprintLF
	add EBX, EAX 		;sumamos los argumentos

	dec ECX 			;restamos 1 al numero de argumentos
	cmp ECX, 0 			;checamos si es el ultimo argumento
	jnz ciclo 			;seguimos si no es el ultimo
						;si fue el ultimo argumento...
	;resultado a imprimir
	mov EAX, msg 		;mensaje a imprimir
	call sprint			;llamar funcion para imprimir cadena
	mov EDX, 0			;multiplicamos acumulado x
	mov EAX, EBX 		;movemos lo que haya en EBX a EAX
	mov EBX, [num_arg] 	;divisor
	div EBX
	call iprintLF 		;imprimimos el argumento

	jmp quit 			;salimos