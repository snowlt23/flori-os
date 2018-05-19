
GCCDIR=/gcc-cross/bin/bin

$GCCDIR/i686-elf-as boot.s -o boot.o
$GCCDIR/i686-elf-gcc -c floricache/flori_compiled.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
$GCCDIR/i686-elf-gcc -T linker.ld -o florios.bin -ffreestanding -O2 -nostdlib boot.o kernel.o
