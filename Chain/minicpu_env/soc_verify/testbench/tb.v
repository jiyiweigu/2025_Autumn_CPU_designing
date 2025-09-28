// 简单的testbench，观测寄存器链传递
`timescale 1ns/1ps
module tb_top;
    reg clk;
    reg resetn;
    reg  [7:0] switch;
    wire [15:0] led;

    initial begin
        clk = 1'b0;
        resetn = 1'b0;
        #2000;
        resetn = 1'b1;
    end
    always #5 clk = ~clk;


    // 可自定义测试输入
    reg [7:0] init_num;
    initial begin
        switch = 8'd5;      // 选择显示r5
        init_num = 8'd2;    // 设置init_num为2
    end

    soc_mini_top dut (
        .resetn (resetn),
        .clk    (clk),
        .led    (led),
        .switch (switch),
        .init_num (init_num)
    );

    initial begin
        $monitor($time, " led = %h", led);
        #5000;
        $finish;
    end
endmodule
