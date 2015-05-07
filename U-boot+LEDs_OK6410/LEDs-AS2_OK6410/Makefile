leds.bin : leds.S
	arm-linux-gcc -g -c -o leds.o leds.S
	arm-linux-ld -Ttext 0x5000000 -g leds.o -o leds.elf
	arm-linux-objcopy -O binary -S leds.elf leds.bin
clean:
	rm -f leds.bin leds.elf *.o
