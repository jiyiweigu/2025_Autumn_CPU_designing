.section .text
.global _start
_start:
    # 初始化寄存器链
    addi.w   $r1, $zero, 1      # r1 = 1
    addi.w   $r2, $r1,   2      # r2 = r1 + 2 = 3
    addi.w   $r3, $r2,   3      # r3 = r2 + 3 = 6
    addi.w   $r4, $r3,   4      # r4 = r3 + 4 = 10
    # 可选：将结果写入内存或特定端口，便于tb观测
    st.w     $r1, $zero, 1024   # 存1
    st.w     $r2, $zero, 1028   # 存3
    st.w     $r3, $zero, 1032   # 存6
    st.w     $r4, $zero, 1036   # 存10
end:
    bne      $zero, $zero, end  # 死循环