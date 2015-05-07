LEDs-AS.bin: start.o
	arm-linux-ld -Ttext 0x50000000 -o LEDs-AS.elf start.o
	arm-linux-objcopy -O binary LEDs-AS.elf LEDs-AS.bin
	arm-linux-objdump -D LEDs-AS.elf > LEDs-AS.dis

start.o : start.S
	arm-linux-gcc -o start.o start.S -c

clean:
	rm *.o LEDs-AS.elf LEDs-AS.bin LEDs-AS.dis

