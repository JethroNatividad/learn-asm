nasm -f elf64 -o out.o in.asm
ld -o out out.o
./out