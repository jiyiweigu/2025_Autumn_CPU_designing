
./obj/test.elf:     file format elf32-loongarch
./obj/test.elf


Disassembly of section .text:

1c000000 <_start>:
_start():
1c000000:	28904013 	ld.w	$r19,$r0,1040(0x410)
1c000004:	00104c01 	add.w	$r1,$r0,$r19
1c000008:	00104c02 	add.w	$r2,$r0,$r19
1c00000c:	00104c03 	add.w	$r3,$r0,$r19
1c000010:	00104c04 	add.w	$r4,$r0,$r19
1c000014:	00104c05 	add.w	$r5,$r0,$r19
1c000018:	00100822 	add.w	$r2,$r1,$r2
1c00001c:	00100c43 	add.w	$r3,$r2,$r3
1c000020:	00101064 	add.w	$r4,$r3,$r4
1c000024:	00101485 	add.w	$r5,$r4,$r5
1c000028:	2890000e 	ld.w	$r14,$r0,1024(0x400)
1c00002c:	0280000f 	addi.w	$r15,$r0,0
1c000030:	02800410 	addi.w	$r16,$r0,1(0x1)
1c000034:	5c0011d0 	bne	$r14,$r16,16(0x10) # 1c000044 <check2>
1c000038:	0010040f 	add.w	$r15,$r0,$r1
1c00003c:	02800411 	addi.w	$r17,$r0,1(0x1)
1c000040:	5c004e20 	bne	$r17,$r0,76(0x4c) # 1c00008c <output>

1c000044 <check2>:
check2():
1c000044:	02800810 	addi.w	$r16,$r0,2(0x2)
1c000048:	5c0011d0 	bne	$r14,$r16,16(0x10) # 1c000058 <check3>
1c00004c:	0010080f 	add.w	$r15,$r0,$r2
1c000050:	02800411 	addi.w	$r17,$r0,1(0x1)
1c000054:	5c003a20 	bne	$r17,$r0,56(0x38) # 1c00008c <output>

1c000058 <check3>:
check3():
1c000058:	02800c10 	addi.w	$r16,$r0,3(0x3)
1c00005c:	5c0011d0 	bne	$r14,$r16,16(0x10) # 1c00006c <check4>
1c000060:	00100c0f 	add.w	$r15,$r0,$r3
1c000064:	02800411 	addi.w	$r17,$r0,1(0x1)
1c000068:	5c002620 	bne	$r17,$r0,36(0x24) # 1c00008c <output>

1c00006c <check4>:
check4():
1c00006c:	02801010 	addi.w	$r16,$r0,4(0x4)
1c000070:	5c0011d0 	bne	$r14,$r16,16(0x10) # 1c000080 <check5>
1c000074:	0010100f 	add.w	$r15,$r0,$r4
1c000078:	02800411 	addi.w	$r17,$r0,1(0x1)
1c00007c:	5c001220 	bne	$r17,$r0,16(0x10) # 1c00008c <output>

1c000080 <check5>:
check5():
1c000080:	02801410 	addi.w	$r16,$r0,5(0x5)
1c000084:	5c0009d0 	bne	$r14,$r16,8(0x8) # 1c00008c <output>
1c000088:	0010140f 	add.w	$r15,$r0,$r5

1c00008c <output>:
output():
1c00008c:	2990100f 	st.w	$r15,$r0,1028(0x404)

1c000090 <end>:
end():
1c000090:	5c000000 	bne	$r0,$r0,0 # 1c000090 <end>
