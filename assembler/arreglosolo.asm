;arreglosolo.asm
%include 'funciones.asm'

section .DATA
	A DB "3"
	nombre DB "Alan Turing",0x0

	B DW 1000
	C DD 80000

section .bss
	D RESB 1
	E RESB 4
	array RESB 20

section .text
	global _start

_start:
	pop ecx ;tomamos valor
	cmp ecx, 2
	jl quit

	pop eax
	dec ecx
	mov edx,0
	mov esi, array

ciclo:
	pop ebx
	mov eax,0
	mov al,byte[ebx]
	mov byte[esi+edx],al
	inc edx
	dec ecx
	cmp ecx,0
	jne ciclo

	mov eax, array ;direccion de array
	call sprintLF ;imprimimos la cadena
	jmp quit ;salir