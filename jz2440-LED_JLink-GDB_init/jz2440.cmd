#connect to the J-Link gdb server
target remote localhost:2331
# Set JTAG speed to 30 kHz
monitor endian little
monitor speed 30
# Reset the target
monitor reset
monitor sleep 10
#
# CPU core initialization (to be done by user)
#
# Set the processor mode
monitor reg cpsr = 0xd3
#config MMU 配置MMU
#flush v3/v4 cache
monitor cp15 7, 7, 0, 0 = 0x0
#/* flush v4 TLB 协处理器*/
monitor cp15 8, 7, 0, 0 = 0x0
#disable MMU stuff and caches
monitor cp15 1, 0, 0, 0 =0x1002
#Peri port setup
monitor cp15 15, 2, 0, 4 = 0x70000013
#disable watchdog kangear 关闭看门狗
monitor MemU32 0x53000000 = 0x00000000
monitor sleep 10
#disable interrupt kangear 关闭中断
monitor MemU32 0x4A000008 = 0xffffffff
monitor MemU32 0x4A00001C = 0x7fff
#set clock
#initialize system clocks --- locktime register
monitor MemU32 0x4C000000 = 0xFF000000
#initialize system clocks --- clock-divn register
monitor MemU32 0x4C000014 = 0x5 #CLKDVIN_400_148
#initialize system clocks --- mpll register
monitor MemU32 0x4C000004 = 0x7f021 #default clock
#config sdram
monitor MemU32 0x53000000 0x00000000 
monitor MemU32 0x4A000008 0xFFFFFFFF 
monitor MemU32 0x4A00001C 0x000007FF 
monitor MemU32 0x53000000 0x00000000 
monitor MemU32 0x56000050 0x000055AA 
monitor MemU32 0x4C000014 0x00000007 
monitor MemU32 0x4C000000 0x00FFFFFF 
monitor MemU32 0x4C000004 0x00061012 
monitor MemU32 0x4C000008 0x00040042 
monitor MemU32 0x48000000 0x22111120 
monitor MemU32 0x48000004 0x00002F50 
monitor MemU32 0x48000008 0x00000700 
monitor MemU32 0x4800000C 0x00000700 
monitor MemU32 0x48000010 0x00000700 
monitor MemU32 0x48000014 0x00000700 
monitor MemU32 0x48000018 0x0007FFFC 
monitor MemU32 0x4800001C 0x00018005 
monitor MemU32 0x48000020 0x00018005 
monitor MemU32 0x48000024 0x008E0459 
monitor MemU32 0x48000028 0x00000032 
monitor MemU32 0x4800002C 0x00000030 
monitor MemU32 0x48000030 0x00000030
# Setup GDB for faster downloads
#set remote memory-write-packet-size 1024
monitor speed auto
break _start
load
