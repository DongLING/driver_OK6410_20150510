.globl _start

_start:



/* 硬件相关的设置 */

    /* Peri port setup */

    ldr r0, =0x70000000

    orr r0, r0, #0x13

    mcr p15,0,r0,c15,c2,4       @ 256M(0x70000000-0x7fffffff)

    

/* 关看门狗 */

/* 往WTCON(0x7E004000)写0 */

	

	ldr r0, =0x7E004000

	mov r1, #0

	str r1, [r0]

/* 设置GPMCON让GPM0/1/2/3作为输出引脚 */

	ldr r1, =0x7F008820

	ldr r0, =0x1111

	str r0, [r1]



/* 设置GPMDAT让GPM3输出0 */

	ldr r1, =0x7F008824

	mov r0, #0



loop:	mov	r0,#0x0
	str	r0,[r1]
	bl	delay
	mov	r0,#0x06
/*	mov	r0,#0x0f */
	str	r0,[r1]
	bl	delay
	b	loop

delay:
	mov	r4,#0x400
del1:	mov	r5,#0x1000
del2:	sub	r5,r5,#1
	cmp	r5,#1
	bne	del2
	sub	r4,r4,#1
	cmp	r4,#1
	bne	del1
	mov	pc,lr
	
halt:	b	halt
