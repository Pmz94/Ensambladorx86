Trabajos escritos en lenguaje Ensamblador de arquitectura i386.

Estos codigos se corren en la consola de algun sistema operativo como Ubuntu y un compilador NASM.

Para correr los programas abra la consola, localice la carpeta donde estan los archivos y corra los sig. comandos:

"$ nasm -f elf -F stabs [nombre del archivo .asm con todo y formato]"

"$ ld -m elf_i386 -s -o [solo el nombre del archivo] [nombre del archivo .o con todo y formato]"

"$ ./ [solo el nombre del archivo]"
