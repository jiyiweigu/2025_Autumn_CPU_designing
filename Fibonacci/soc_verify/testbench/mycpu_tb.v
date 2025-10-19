/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Copyright (c) 2016, Loongson Technology Corporation Limited.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this 
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of Loongson Technology Corporation Limited nor the names of 
its contributors may be used to endorse or promote products derived from this 
software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL LOONGSON TECHNOLOGY CORPORATION LIMITED BE LIABLE
TO ANY PARTY FOR DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
`timescale 1ns / 1ps

module tb_top( );
    reg resetn;
    reg clk;

    // gpio
    wire [15:0] led;
    reg  [7:0] switch;

    initial
    begin
        $display("=== Testbench Started ===");
        clk = 1'b0;
        resetn = 1'b0;
        $display("Time %t: Reset asserted", $time);
        #20000;  // 20ns复位时间
        resetn = 1'b1;
        $display("Time %t: Reset released", $time);
    end
    
    always #5 clk = ~clk;

    initial 
    begin
        // 在这里可以自定义测试输入序列
        switch = ~(8'h5);  // 设置开关输入
        $display("Time %t: Switch initialized to %h", $time, switch);
    end

    // 监控CPU执行
    always @(posedge clk) begin
        if (resetn) begin
            $display("Time %t: PC = %h, Instruction = %h", 
                     $time, soc_mini.cpu_inst_addr, soc_mini.cpu_inst_rdata);
        end
    end

    // 仿真结束条件
    initial begin
        #1000000; // 仿真运行1ms
        $display("=== Simulation Finished ===");
        $display("Final LED output: %h", led);
        $finish;
    end

    soc_mini_top soc_mini
    (
        .resetn      (resetn     ), 
        .clk         (clk        ),
    
        //------gpio-------
        .led         (led        ),
        .switch      (switch     )
    );   

endmodule
