void delay()
{
	volatile int i = 500000;
	while (i--);
}

int main()
{
	int i = 0;
	volatile unsigned long *gpmcon = (volatile unsigned long *)0x7F008820;
	volatile unsigned long *gpmdat = (volatile unsigned long *)0x7F008824;
	
	// gpm4,5,6,7设为输出引脚 
	*gpmcon &= 0xffff;
	*gpmcon |= 0x11110000;
	
	while (1)
	{
		*gpmdat = ((*gpmdat & (~0xf<<4)) | ~i<<4);
		i++;
		if (i == 16)
		i = 0;
		delay();
	}

	return 0;
}

