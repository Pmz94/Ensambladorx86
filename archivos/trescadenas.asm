;trescadenas.asm
;Pedro Muñoz
;6/Marzo/17

section .data
	msj DB 'Hola Mundo!',0xA,0x0	;mensaje a imprimir
	msj2 DB 'Mi Nombre Es Pedro Muñoz', 0xA, 0x0
	msj3 DB 'Hoy Es Lunes', 0xA,0x0

section .text
	GLOBAL _start 	;punto de entrada
_start:
;Imprimir 1er mensaje
	mov EAX, msj 	;direccion mensaje msj
	call sprint 	;imprimir cadena
;Imprimir 2do mensaje
	mov EAX, msj2 	;direccion mensaje msj2
	call sprint 	;imprimir cadena
;Imprimir 3er mensaje
	mov EAX, msj3 	;direccion mensaje msj3
	call sprint 	;imprimir cadena

	jmp quit 	;salida

;1er mensaje
	;mov EAX, msj 		;cargar mensaje 1
	;call strlen 		;calcular longitud
	;mov EDX, EAX 		;guardo longitud en EDX
	;mov ECX, msj 		;cargo mensaje 1
	;mov EAX, 4 		;sys_write
	;mov EBX, 1 		;std_out
	;int 0x80 		;llamar al kernel
;2do mensaje
	;mov EAX, msj2		;cargar mensaje 2
	;call strlen 		;calcular longitud
	;mov EDX, EAX		;guardo longitud en EDX
	;mov ECX, msj2		;cargo mensaje 2
	;mov EAX, 4 		;sys_write
	;mov EBX, 1 		;std_out
	;int 0x80 		;llamar al kernel
;3er mensaje
	;mov EAX, msj3 		;cargar mensaje 3
	;call strlen 		;calcular longitud
	;mov EDX, EAX 		;guardo longitud en EDX
	;mov ECX, msj3		;cargo mensaje 3
	;mov EAX, 4 		;sys_write
	;mov EBX, 1 		;std_out
	;int 0x80 		;llamar al kernel
;Salida
	;mov EAX, 1 	;std_out
	;int 0x80 	;llamar al kernel

strlen:
	push EBX	;salvamos el valor de E
	mov EBX, EAX 	;copiamos la direccion

sigcar:
	cmp byte[EAX], 0	;comparamos el byte que
				;a la que apuntes EAX comn 0
	jz finalizar 		;JUMP if Zero, salta a
	inc EAX		 	;incrementamos en 1 el
	jmp sigcar 	 	;salto incondicional al

finalizar:
	sub EAX, EBX 	;restamos al valor inic
	pop EBX 	;establecer EBX
	ret 		;regresar al punto en que 

;Funcion String Print (sprint)
;Recibe direccion de cadena en EAX
sprint:
	push EDX 	;salvamos valor de EDX
	push ECX	;salvamos valor de ECX
	push EBX 	;salvamos valor de EBX
	push EAX 	;salvamos valor de EAX
	call strlen 	;llamamos a la funcion s

	mov EDX, EAX 	;movemos la longitud de
	pop EAX 	;traemos del stack la direccion
	mov ECX, EAX 	;la direccion del mensaje
	mov EBX, 1 	;descriptor de archivo()
	mov EAX, 4 	;sys_write
	int 80h 	;ejecuta

	pop EBX 	;reestablecemos EBX
	pop ECX 	;reestablecemos ECX
	pop EDX 	;reestablecemos EDX
	ret

;Salida
quit:
	mov EAX, 1 	;std_out
	int 0x80 	;llamar al kernel
