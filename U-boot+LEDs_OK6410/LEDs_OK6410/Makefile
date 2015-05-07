LEDs.bin: start.o LEDs.o
	arm-none-linux-gnueabi-ld -Ttext 0x50000000 -o LEDs.elf start.o LEDs.o
#将两个文件连接生成 LEDs.elf文件，链接地址为0（通过-Ttext 0指定）
	arm-none-linux-gnueabi-objcopy -O binary LEDs.elf LEDs.bin
#用LEDs.elf文件生成二进制文件LEDs.bin(-O binary表示生成二进制文件）
	arm-none-linux-gnueabi-objdump -D LEDs.elf > LEDs.dis
#用LEDs.elf文件反汇编为LEDs.dis文件
start.o : start.S
	arm-none-linux-gnueabi-gcc -nostdlib -c -o start.o start.S
LEDs.o : LEDs.c
	arm-none-linux-gnueabi-gcc -nostdlib -c -o LEDs.o LEDs.c
#说明：首先将start.S只编译（-c）生成start.o,然后将LEDs.c只编译（-c）生成LEDs.o

clean:
	rm *.o LEDs.elf LEDs.bin LEDs.dis

