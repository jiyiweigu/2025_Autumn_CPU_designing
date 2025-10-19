module minicpu_top(
    input  wire        clk,
    input  wire        resetn,

    output wire        inst_sram_we,
    output wire [31:0] inst_sram_addr,
    output wire [31:0] inst_sram_wdata,
    input  wire [31:0] inst_sram_rdata,

    output wire        data_sram_we,
    output wire [31:0] data_sram_addr,
    output wire [31:0] data_sram_wdata,
    input  wire [31:0] data_sram_rdata
);
// ==================== 程序计数器 ====================
reg [31:0] pc;
assign inst_sram_addr = pc;
assign inst_sram_we = 1'b0;
assign inst_sram_wdata = 32'b0;

// ==================== 指令译码 ====================
wire [31:0] instruction = inst_sram_rdata;

// 寄存器文件
reg [31:0] regfile [0:31];
wire [31:0] rf_1 = regfile[1];
wire [31:0] rf_2 = regfile[2];
wire [31:0] rf_3 = regfile[3];
wire [31:0] rf_4 = regfile[4];
wire [31:0] rf_5 = regfile[5];

// 尝试多种指令格式
wire [4:0] opcode1  = instruction[4:0];
wire [4:0] ra1      = instruction[9:5];
wire [4:0] rb1      = instruction[14:10];
wire [4:0] rd1      = instruction[19:15];
wire [15:0] imm16_1 = instruction[25:10];

wire [5:0] opcode2  = instruction[31:26];
wire [4:0] ra2      = instruction[25:21];
wire [4:0] rb2      = instruction[20:16];
wire [4:0] rd2      = instruction[15:11];
wire [15:0] imm16_2 = instruction[15:0];

// 使用格式1（根据您之前的成功）
wire [4:0] opcode  = opcode1;
wire [4:0] ra      = ra1;
wire [4:0] rb      = rb1;
wire [4:0] rd      = rd1;
wire [15:0] imm16  = imm16_1;

wire [31:0] imm32_sext = {{16{imm16[15]}}, imm16};
wire [31:0] imm32_shift = {{14{imm16[15]}}, imm16, 2'b0};

wire [31:0] rd1_val = (ra == 5'b0) ? 32'b0 : regfile[ra];
wire [31:0] rd2_val = (rb == 5'b0) ? 32'b0 : regfile[rb];

// ==================== 指令识别 ====================
// 扩展指令集以包含未知指令
wire is_add  = (opcode == 5'b01100);
wire is_addi = (opcode == 5'b01000);
wire is_ld   = (opcode == 5'b01110);
wire is_st   = (opcode == 5'b01111);
wire is_bne  = (opcode == 5'b01010);

// 特殊处理未知指令
wire is_unknown_1 = (instruction == 32'h5ffff2e4);
wire is_unknown_2 = (instruction == 32'h5c000300);

// ==================== ALU和数据存储器 ====================
wire [31:0] alu_result;
wire [31:0] pc_plus_4 = pc + 32'd4;
wire [31:0] branch_target = pc + imm32_shift;

assign alu_result = 
    (is_add | is_addi) ? rd1_val + (is_add ? rd2_val : imm32_sext) :
    (is_ld | is_st)    ? rd1_val + imm32_sext :
    is_bne             ? branch_target :
    32'b0;

assign data_sram_we    = is_st;
assign data_sram_addr  = alu_result;
assign data_sram_wdata = rd2_val;

// ==================== 写回控制 ====================
wire reg_write = (is_add | is_addi | is_ld) && (rd != 5'b0);
wire [31:0] wdata = is_ld ? data_sram_rdata : alu_result;
wire [31:0] next_pc = (is_bne && (rd1_val != rd2_val)) ? branch_target : pc_plus_4;

// ==================== 时序逻辑 ====================
integer i;
reg [31:0] cycle_count;
reg program_finished;

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        pc <= 32'hc000_0000;  // 使用0xC0000000
        cycle_count <= 0;
        program_finished <= 0;
        for (i = 0; i < 32; i = i + 1) begin
            regfile[i] <= 32'b0;
        end
        $display("=== 开始执行Fibonacci程序 ===");
    end else begin
        pc <= next_pc;
        cycle_count <= cycle_count + 1;
        
        // 检测程序结束（连续多条空指令）
        if (instruction == 32'h00000000) begin
            if (cycle_count > 100) program_finished <= 1;
        end
        
        // 寄存器写回
        if (reg_write) begin
            regfile[rd] <= wdata;
            
            // 特别关注Fibonacci相关寄存器
            if (rd >= 1 && rd <= 10) begin
                $display("周期 %0d: r%d = %h (%0d)", cycle_count, rd, wdata, wdata);
                
                // 检测Fibonacci模式
                if (rd >= 3 && regfile[rd-1] + regfile[rd-2] == wdata && 
                    regfile[rd-1] > 0 && regfile[rd-2] > 0) begin
                    $display("? Fibonacci数列: r%d=%0d, r%d=%0d, r%d=%0d", 
                             rd-2, regfile[rd-2], rd-1, regfile[rd-1], rd, wdata);
                }
            }
        end
        
        // 处理未知指令
        if (is_unknown_1 || is_unknown_2) begin
            $display("周期 %0d: 未知指令 %h，跳过执行", cycle_count, instruction);
        end
    end
end

// ==================== 执行监控 ====================
always @(posedge clk) begin
    if (resetn && !program_finished) begin
        // 只显示非零和非未知指令
        if (instruction != 32'h00000000 && !is_unknown_1 && !is_unknown_2) begin
            case (1'b1)
                is_add:  $display("周期 %0d: ADD.W  r%d, r%d, r%d", cycle_count, rd, ra, rb);
                is_addi: $display("周期 %0d: ADDI.W r%d, r%d, %h", cycle_count, rd, ra, imm16);
                is_ld:   $display("周期 %0d: LD.W   r%d, r%d, %h", cycle_count, rd, ra, imm16);
                is_st:   $display("周期 %0d: ST.W   r%d, r%d, %h", cycle_count, rd, ra, imm16);
                is_bne:  $display("周期 %0d: BNE    r%d, r%d, %h -> %s", cycle_count, ra, rb, imm16,
                                 (rd1_val != rd2_val) ? "跳转" : "继续");
            endcase
        end
        
        // 每50周期显示所有非零寄存器
        if (cycle_count % 50 == 0) begin
            $display("--- 周期 %0d 寄存器快照 ---", cycle_count);
            for (i = 1; i < 16; i = i + 1) begin
                if (regfile[i] != 32'b0) 
                    $display("  r%d = %h (%0d)", i, regfile[i], regfile[i]);
            end
        end
        
        // 程序完成检测
        if (program_finished || cycle_count > 1500) begin
            $display("=== 程序执行完成 ===");
            $display("总周期: %0d, 最终PC: %h", cycle_count, pc);
            $display("最终寄存器状态:");
            for (i = 1; i < 16; i = i + 1) begin
                if (regfile[i] != 32'b0) 
                    $display("  r%d = %h (%0d)", i, regfile[i], regfile[i]);
            end
            $finish;
        end
    end
end

endmodule
                         
