# Connect to the J-Link GDBServer
target remote localhost:2331
# Set JTAG speed to 30 kHz
monitor endian little
monitor speed 30
# Reset the target
monitor reset
monitor sleep 10
#
# CPU core initialization 
#
# Set the processor to service mode
monitor reg cpsr = 0xd3
# Config MMU
# Flush v3/v4 cache
monitor cp15 7, 7, 0, 0 = 0x0
monitor cp15 8, 7, 0, 0 = 0x0
# Disable MMU stuff and caches
monitor cp15 1, 0, 0, 0 =0x1002
# Peri port setup
monitor cp15 15, 2, 0, 4 = 0x70000013
# Disable watchdog
monitor MemU32 0x7e004000  =  0x00000000
monitor sleep 10
# Disable interrupt
monitor MemU32 0x71200014  =  0xffffffff
monitor MemU32 0x71300014  =  0xffffffff
monitor MemU32 0x7120000C  =  0x00000000
monitor MemU32 0x7130000C  =  0x00000000
monitor MemU32 0x71200F00  =  0x00000000
monitor MemU32 0x71300F00  =  0x00000000
# Set clock 
monitor MemU32 0x7e00f900  =  0x000080de
monitor MemU32 0x7e00f000  =  0x0000ffff
monitor MemU32 0x7e00f004  =  0x0000ffff
monitor MemU32 0x7e00f008 = 0x0000ffff
monitor MemU32 0x7e00f028 = 0x00300000
monitor MemU32 0x7e00f020  =  0x01043310
monitor MemU32 0x7e00f00C  =  0x810a0301
monitor MemU32 0x7e00f010  =  0x810a0301
monitor MemU32 0x7e00f014 = 0x80200102
monitor MemU32 0x7e00f018 = 0x00000000
monitor MemU32 0x7e00f01c = 0x00000007
monitor sleep 1
# UART Init
monitor MemU32 0x7f008000 = 0x00220022
monitor memU32 0x7f008020 = 0x00002222
monitor memU32 0x7f005008 = 0x00000000
monitor memU32 0x7f00500c = 0x00000000
monitor memU32 0x7f005000 = 0x00000003
monitor memU32 0x7f005004 = 0x00000e45monitor memU32 0x7f005028 = 0x00000033
monitor memU32 0x7f00502c = 0x0000dfdd
monitor memU32 0x7f005020 = 0x4f4f4f4f
monitor memU32 0x7f005020 = 0x4b4b4b4b

# Config Mobile DDR SDRAM
monitor MemU32 0x7e00f120  =  0x0000000d
monitor MemU32 0x7e001004  =  0x00000004
monitor MemU32 0x7e001010  =  0x0000040f
monitor MemU32 0x7e001014  =  0x00000006
monitor MemU32 0x7e001018  =  0x00000001
monitor MemU32 0x7e00101c  =  0x00000002
monitor MemU32 0x7e001020  =  0x00000006
monitor MemU32 0x7e001024  =  0x0000000a
monitor MemU32 0x7e001028  =  0x0000000c
monitor MemU32 0x7e00102c  =  0x0000010b
monitor MemU32 0x7e001030  =  0x0000000c
monitor MemU32 0x7e001034  =  0x00000002
monitor MemU32 0x7e001038  =  0x00000002
monitor MemU32 0x7e00103c  =  0x00000002
monitor MemU32 0x7e001040  =  0x00000002
monitor MemU32 0x7e001044  =  0x00000010
monitor MemU32 0x7e001048  =  0x00000010
monitor MemU32 0x7e00100C  =  0x0001001a
monitor MemU32 0x7e00104C  =  0x00000b45
monitor MemU32 0x7e001200  =  0x000150f0
monitor MemU32 0x7e001304  =  0x00000000
monitor MemU32 0x7e001008  =  0x000c0000
monitor MemU32 0x7e001008  =  0x00000000
monitor MemU32 0x7e001008  =  0x00040000
monitor MemU32 0x7e001008  =  0x00040000
monitor MemU32 0x7e001008  =  0x000a0000
monitor MemU32 0x7e001008  =  0x00080032
monitor MemU32 0x7e001004  =  0x00000000
# Setup GDB for faster downloads
# set remote memory-write-packet-size 1024
set remote memory-write-packet-size 4096
set remote memory-write-packet-size fixed
monitor speed 12000
break start_armboot
load
continue
