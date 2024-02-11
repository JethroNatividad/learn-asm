nasm -f elf64 -o out.o in.asm
ld -o out out.o
./out

nasm -f elf64 -o main.o main.asm && ld -o main main.o && ./main