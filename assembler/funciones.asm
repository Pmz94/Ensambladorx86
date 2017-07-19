;funciones.asm
;Pedro Muñoz
;8/Mar/17

sys_exit 	EQU 	1
sys_read 	EQU 	3
sys_write 	EQU 	4
sys_open 	EQU 	5
sys_close 	EQU 	6
sys_creat	EQU 	8
sys_sync 	EQU 	36
stdin 		EQU 	0
stdout 		EQU 	1
stderr 		EQU 	3
o_rdonly 	EQU 	0
o_rdwr		EQU 	1

strlen:
	push EBX 		;Salvamos el valor de EBX
	mov EBX, EAX 	;Copiamos la direccion

sigcar:
	cmp byte[EAX], 0	;comparamos el byte que
						;a la que apuntes EAX comn 0
	jz finalizar 		;JUMP if Zero, salta a
	inc EAX		 		;incrementamos en 1 el
	jmp sigcar 	 		;salto incondicional al

finalizar:
	sub EAX, EBX 	;restamos al valor inic
	pop EBX 	 	;establecer EBX
	ret 		 	;regresar al punto en que 

sprint:
	push EDX 		;salvamos valor de EDX
	push ECX		;salvamos valor de ECX
	push EBX 		;salvamos valor de EBX
	push EAX 		;salvamos valor de EAX
	call strlen 	;llamamos a la funcion s

	mov EDX, EAX 	;movemos la longitud de
	pop EAX 		;traemos del stack la direccion
	mov ECX, EAX 	;la direccion del mensaje
	mov EBX, stdout ;descriptor de archivo()
	mov EAX, sys_write ;sys_write
	int 80h 		;ejecuta

	pop EBX 		;reestablecemos EBX
	pop ECX 		;reestablecemos ECX
	pop EDX 		;reestablecemos EDX
	ret

sprintLF:
	call sprint 	;llama e imprime el mensaje
	push EAX 		;salvamos EAX, vamos a u
	mov EAX, 0xA 	;Hexadecimal para cara
	push EAX 		;salvamos el line feed en el stack
	mov EAX, ESP 	;copiamos el apuntador del stack
	call sprint 	;imprimimos el line feed
	pop EAX 		;removemos el line feed del stack
	pop EAX 		;reestablecemos el dato que traiamos
	ret 			;regresamos

iprint:
	push EAX 		;salvamos EAX en el stack (acumulador)
	push ECX 		;salvamos EXC en el stack (contador)
	push EDX 		;salvamos EDX en el stack (base)
	push ESI		;salvamos ESI en el stack (source, index)
	mov ECX, 0 		;vamos a contar cuantos bytes necesitamos imprimir

dividirloop:
	inc ECX 		;incrementamos en 1 ECX
	mov EDX, 0 		;limpiamos EDX
	mov ESI, 10 	;guardamos 10 en ESI, vamos a dividr entre 10
	idiv ESI 		;divide EAX entre ESI
	add EDX, 48 	;agrega el caracter 48 '0'
	push EDX 		;la representacion de ASCII de nuestro numero
	cmp EAX, 0 		;se puede dividir mas el numero entero?
	jnz dividirloop ;jump if not zero (salta si no es cero)

imprimirloop:
	dec ECX 		;vamos a contar hacia abajo cada byte en el stack
	mov EAX, ESP 	;apuntador del stack a EAX
	call sprint 	;llamamos a la funcion sprint
	pop EAX 		;removemos el ultimo caracter del stack
	cmp ECX, 0 		;ya imprimimos todos los bytes del stack?
	jnz imprimirloop;todavia hay numeros que imprimir?
	pop ESI 		;reestablecemos el valor de ESI
	pop EDX 		;reestablecemos el valor de EDX
	pop ECX 		;reestablecemos el valor de ECX
	pop EAX 		;reestablecemos el valor de EAX
	ret 			;regresamos

iprintLF: 			;integer print line feed (imprimir entero con nueva linea)
	call iprint 	;imprimimos el numero
	push EAX 		;salvamos el dato que traemos en el

	mov EAX, 0xA 	;copiamos el line feed a EAX
	push EAX 		;salvamos el line feed en el stack
	mov EAX, ESP 	;copiamos el apuntador del stack
	call sprint 	;imprimimos el line feed
	pop EAX 		;removemos el line feed del stack
	pop EAX 		;reestablecemos el dato que traiamos
	ret 			;regresamos

atoi: 				;
	push EBX 		;preservamos EBX
	push ECX 		;preservamos ECX
	push EDX 		;preservamos EDX
	push ESI 		;preservamos ESI
	mov ESI, EAX 	;nuestro numero a convertir va a
	mov EAX, 0 		;inicializamos a cero EAX
	mov ECX, 0		;inicializamos a cero ECX

ciclomult: 		;ciclo multiplicacion
	xor EBX, EBX 	;reseteamos a 0 EBX, tanto bh
	mov BL, [ESI+ECX] ;movemos un solo byte a a
	cmp BL, 48 		;comparamos con ascii '0'
	jl finalizado 	;si es menor, saltamos al finalizado
	cmp BL, 57 		;comparamos con ascii "9"
	jg finalizado 	;si es mayor, saltamos a finalizado
	cmp BL, 10 		;comparamos con linefeed
	je finalizado 	;si es igual, saltamos a finalizado
	cmp BL, 0 		;comparamos con caracter null
	jz finalizado 	;si es cero saltamos a finalizado
	sub BL, 48 		;convertimos el caracter en entero
	add EAX, EBX 	;agregamos el valor a EAX
	mov EBX, 10 	;movemos el decimal 10 a EBX
	mul EBX 		;multiplicamos EAX por EBC para obtener
	inc ECX 		;incrementamos EXC (conttador)
	jmp ciclomult 	;seguimos nuestro ciclo de multiplicacion

finalizado:
	mov EBX, 10 	;movemos el valor decimal 10 a EBX
	div EBX 		;dividimos EAX entre 10
	pop ESI 		;reestablecemos ESI
	pop EDX 		;reestablecemos EDX
	pop ECX 		;reestablecemos ECX
	pop EBX 		;reestablecemos EBX
	ret 			;regresamos

ftoc: 				;recibe grados farenheit en EAX, regresa grados celsius en EAX
	sub EAX, 32		;o 20h o 0x20   resta lo que haya en EAX menos 32
	imul EAX, 5 	;multiplica lo que haya en EAX por 5
	push EDX 		;salvamos EDX
	mov EDX, 0 		;
	push EBX 		;salvamos EBX
	mov EBX, 9 		;ponemos las variables a dividir
	div EBX 		;hacemos la division
	pop EBX
	pop EDX
	ret

ctof: 				;recibe grados celsius en EAX, regresa grados farenheit en EAX
	imul EAX, 9 	;multiplica lo que haya en EAX por 9
	push EDX 		;salvamos EDX
	mov EDX, 0 		;
	push EBX 		;salvamos EBX
	mov EBX, 5 		;ponemos las variables a dividir
	div EBX 		;hacemos la division
	add EAX, 32		;o 20h o 0x20   suma lo que haya en EAX mas 32
	pop EBX
	pop EDX
	ret

stringcopy:
	push ECX 	;salvamos ECX en el stack
	push EBX
	mov EBX, 0 	;EBX a 0
	mov ECX, 0 	;ECX a 0
	;mov EBX, EAX 		;copiamos la direccion

.sigcar:
	mov BL, byte[EAX]
	mov byte[ESI+ECX],BL 	;movemos un caracter
	cmp byte[EAX],0 		;comparamos el byte que es al que apunta EAX con 0

	jz .finalizar 			;JUMP if zero, salta a fin
	inc EAX 				;incrementamos en 1 el acumulador de EAX
	inc ECX 				;incrementamos en 1 el acumulador de EAX
	jmp .sigcar 			;salto incondicional al si

.finalizar:
	pop EBX
	pop ECX 				;reestablecer ECX
	ret 					;regresar al punto en que llamamos

leertexto:
	mov EBX, stdin
	mov EAX, sys_read
	int 80H
	ret

quit:
	mov EBX, 0
	mov EAX, sys_exit 		;std_out
	int 0x80 		;llamar al kernel

copystring:
	push ECX 	;salvamos ECX en el stack
	push EBX
	mov EBX, 0 	;EBX a 0
	mov ECX, 0 	;ECX a 0
	;mov EBX, EAX 		;copiamos la direccion

.sigcar:
	mov BL, byte[EAX]
	cmp BL, 0xA
	je .salto
	mov byte[ESI+ECX],BL 	;movemos un caracter
	cmp byte[EAX],0 		;comparamos el byte que es al que apunta EAX con 0

	jz .finalizar 			;JUMP if zero, salta a fin

.salto:
	inc EAX 				;incrementamos en 1 el acumulador de EAX
	inc ECX 				;incrementamos en 1 el acumulador de EAX
	jmp .sigcar 			;salto incondicional al si

.finalizar:
	pop EBX
	pop ECX 				;reestablecer ECX
	ret 					;regresar al punto en que llamamos

error:
	mov EBX, EAX
	mov EAX, sys_exit
	int 0x80

;; ------------------------------------
;; itoa recibe un entero
;; y lo convierte en cadena de texto
;; recibe entero en EAX
;; recibe direccion de cadena en ESI
;; ------------------------------------
itoa:
	push ebx ; preservamos ebx
	push ecx ; preservamos ecx
	push edx ; preservamos edx
	push esi ; preservamos esi
	mov ebx, 10 ;vamos a dividir por 10
	mov ecx, 0 ;nuestro contador en 0
	push ecx ;mandamos 0 al stack (fin de cadena)
	inc ecx

.dividir:
	inc ecx ;incrementamos nuestro contador
	mov edx, 0 ; limpiamos EDX para dividir
	idiv ebx ;dividimos EAX entre EBX
	add edx, 0x30 ;agregamos 48 (para obtener digitos de 0-9 en ASCII)
	push edx ;enviamos el residuo al stack
	cmp eax, 0 ;checamos si el residuo es 0
	je .fuera ;si es 0, salimos del ciclo
	jmp .dividir ;seguimos obteniendo digitos

.fuera:
	mov ebx,0 ;limpiamos ebx

.guardar:
	pop eax ;traemos un digito del stack
	mov byte[esi+ebx],al ;movemos el digito a memoria
	inc ebx ;incrementamos contador
	cmp ebx,ecx ;comparamos con la cuenta de digitos
	jne .guardar ;si no son iguales, obtenemos otro digito del stack
	
	pop esi ; restauramos esi
	pop edx ; restauramos edx
	pop ecx ; restauramos ecx
	pop ebx ; restauramos ebx
	ret ; y regresamos

isqrt32:
	mov ebx, edi
	xor eax, eax

.while:
	cmp eax, ebx
	jnb .endwhile
	add ebx, eax
	shr ebx, 1
	mov eax, edi
	xor edx, edx
	div ebx
	jmp .while

.endwhile:
	mov eax, ebx
	ret