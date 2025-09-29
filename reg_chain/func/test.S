.section .text
.global _start
_start:
    # --------- 配置参数 ---------
    # 通过内存1040地址读取init_num，和switch一致（32位）
    ld.w     $t7, $zero, 1040      # $t7 = init_num（tb.v仿真初始化写入）

    # --------- 写入init_num到r1~r4 ---------
    add.w    $r1, $zero, $t7
    add.w    $r2, $zero, $t7
    add.w    $r3, $zero, $t7
    add.w    $r4, $zero, $t7

    # --------- 前缀和计算 ---------
    add.w    $r2, $r1, $r2      # r2 = r1 + r2
    add.w    $r3, $r2, $r3      # r3 = r2 + r3
    add.w    $r4, $r3, $r4      # r4 = r3 + r4

    # --------- 前缀和计算完成后，读取switch，选择输出寄存器 ---------
    ld.w     $t2, $zero, 1024      # $t2 = switch（tb.v设置，选择要显示的寄存器号，32位）

    # 默认输出0
    addi.w   $t3, $zero, 0
    addi.w   $t4, $zero, 1
    bne      $t2, $t4, check2
    add.w    $t3, $zero, $r1
    addi.w   $t5, $zero, 1  # 设置标志，表示已找到匹配
    bne      $t5, $zero, output  # 模拟 b output
check2:
    addi.w   $t4, $zero, 2
    bne      $t2, $t4, check3
    add.w    $t3, $zero, $r2
    addi.w   $t5, $zero, 1
    bne      $t5, $zero, output
check3:
    addi.w   $t4, $zero, 3
    bne      $t2, $t4, check4
    add.w    $t3, $zero, $r3
    addi.w   $t5, $zero, 1
    bne      $t5, $zero, output
check4:
    addi.w   $t4, $zero, 4
    bne      $t2, $t4, output
    add.w    $t3, $zero, $r4
    addi.w   $t5, $zero, 1
    bne      $t5, $zero, output
output:
    st.w     $t3, $zero, 1028      # 输出到dataram，soc_mini_top会驱动led
    ld.w     $t6, $zero, 1028      # 读取dataram（led当前值）到t6

end:
    bne      $zero, $zero, end  # 死循环