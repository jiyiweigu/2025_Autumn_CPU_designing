
./obj/main.elf:     file format elf32-loongarch
./obj/main.elf


Disassembly of section .text:

1c000000 <_start>:
_start():
1c000000:	0280000c 	addi.w	$r12,$r0,0
1c000004:	0280040d 	addi.w	$r13,$r0,1(0x1)
1c000008:	02800017 	addi.w	$r23,$r0,0
1c00000c:	02800418 	addi.w	$r24,$r0,1(0x1)
1c000010:	28900004 	ld.w	$r4,$r0,1024(0x400)

1c000014 <loop>:
loop():
1c000014:	0010358e 	add.w	$r14,$r12,$r13
1c000018:	028001ac 	addi.w	$r12,$r13,0
1c00001c:	028001cd 	addi.w	$r13,$r14,0
1c000020:	001062f7 	add.w	$r23,$r23,$r24
1c000024:	5ffff2e4 	bne	$r23,$r4,-16(0x3fff0) # 1c000014 <loop>
1c000028:	2990100e 	st.w	$r14,$r0,1028(0x404)

1c00002c <end>:
end():
1c00002c:	5c000300 	bne	$r24,$r0,0 # 1c00002c <end>
