# 1 "start.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/home/devcontainers/loongson-gnu-toolchain-8.3-x86_64-loongarch32r-linux-gnusf-v2.0/loongarch32r-linux-gnusf/sysroot/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "start.S"
.section .text
.global _start
_start:
       addi.w $t0,$zero,0x0
       addi.w $t1,$zero,0x1
       addi.w $s0,$zero,0x0
       addi.w $s1,$zero,0x1
       ld.w $a0,$zero,1024
 loop:
       add.w $t2,$t0,$t1
       addi.w $t0,$t1,0x0
       addi.w $t1,$t2,0x0
       add.w $s0,$s0,$s1
       bne $s0,$a0,loop
       st.w $t2,$zero,1028
 end:
       bne $s1, $zero, end
