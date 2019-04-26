# Trabajos escritos en lenguaje Ensamblador de arquitectura i386.

Estos codigos se corren en la consola, necesitaras un compilador.

<!-- ### Para Windows -->

<!-- En este ejemplo usare el compilador [NASM](https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/win32/nasm-2.14.02-win32.zip). -->

<!-- Guarde los archivos dentro de la carpeta del compilador. -->

<!-- Para correr los programas abra la consola y vaya a la carpeta del compilador: -->

<!-- ```> cd C:/User/Documents/NASM``` -->

<!-- Luego corra los sig. comandos: -->

<!-- ```> nasm -f win32 archivo.asm -o archivo.o``` -->

<!-- ```> ld archivo.o -o archivo.exe``` -->

### Para Linux

En este ejemplo usare el compilador NASM.

Para instalarlo, escriba en la terminal:

```$ sudo apt update```

```$ sudo apt install nasm```

Ya que tenga lo anterior, vaya a la carpeta donde tenga los archivos:

```$ cd /home/user/ensamblador/```

Luego corra los sig. comandos:

```$ nasm -f elf -F stabs archivos/archivo.asm```

```$ ld -m elf_i386 -s -o ejecutables/archivo archivo.o```

```$ ./ejecutables/archivo```