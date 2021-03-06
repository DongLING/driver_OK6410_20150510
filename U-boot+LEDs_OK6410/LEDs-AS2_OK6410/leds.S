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
/*	ldr r1, =0x7F008820
	ldr r0, =0x1111
	str r0, [r1] */

/* 设置GPMDAT让GPM3输出0 */
/*	ldr r1, =0x7F008824
	mov r0, #0 */

leds_flicker:    
    ldr r2, =0x7F008820   @ GPMCON of OK6410  
    mov r3, #((1<<(1*2)) | (1<<(2*2)) | (1<<(3*2)))      @ GPM1_out|GPM2_out|GPM3_out
    str r3, [r2]   

    ldr r5, =0x7F008824   @ GPMDAT  
    mov r4, #0            @ 0x0

led_loop:
    ldr r0, =1000000
    bl  wait 
/*	bl delay */

    mvn r3, r4, lsl #4   @ r4 lsl #4 => r3. #4 for 3 LEDs; #5 for 4 LEDs.
    add r4, r4, #1       @ 0x1
    cmp r4, #8           @ 0x10. 3 LEDs 000~111 = #8
    subeq r4, r4, #8     @ 0x10
    str r3, [r5]
    b led_loop

wait:
    subs r0, r0, #1
    bne wait
    mov pc, lr

/*loop:	mov	r0,#0x0
	str	r0,[r1]
	bl	delay
	mov	r0,#0x0f
	str	r0,[r1]
	bl	delay
	b	loop */

/* delay:
	mov	r4,#0x400
del1:	mov	r5,#0x1000
del2:	sub	r5,r5,#1
	cmp	r5,#1
	bne	del2
	sub	r4,r4,#1
	cmp	r4,#1
	bne	del1
	mov	pc,lr */
	
halt:	b	halt
